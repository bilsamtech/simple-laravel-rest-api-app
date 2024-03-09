<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class WelcomeController extends Controller
{
    public function welcome(){
        $data["status"] = true;
        $data["message"] = 'Welcome to DevOps training';
        
        return response()->json($data, 200, [
            ['Content-Type' => "application/json"]
        ]);
    }
}
