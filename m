Return-Path: <linux-kernel+bounces-744905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D00B11255
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 22:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 721AE5634E4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 20:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84577274FE8;
	Thu, 24 Jul 2025 20:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hTFd/QVp"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204212EE5E1
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 20:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753388972; cv=none; b=r65LNmfYbRG0PYzSZ8bhAv7xGZdnpLS8s1nn5Y7OsXcb4wwxwoFr1WABTOgUOJ6zOwMb9nRh5GF+BqgKN2DsJYddh7e95YHcyGb0aI6Bn3HtYp/fhdoxCOw1g0lR9pFwLxq4v3InY3hR1UvFoojqzlbSUdxljpjx5PnNeW+nIOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753388972; c=relaxed/simple;
	bh=DzXVhulZGvTKq7BsPcMgg1dzeOqUZTXVxR/3MGaFMqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=alv2qRheMFDynr4tgw5hYgJC+R0lfAFq36L57K8qozNGxOA2HIpWSFV4kEgFPeu9sZ4fZ7aUG4UsD9lx+f12pC6O4GadMELTdPGzZSW/2b9hFOxnTTqm9zD4zGFHoFqCaSTBbKQxTMVme0MayZfaULgjQqAaZnBd2O9TjNZB7nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hTFd/QVp; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3df210930f7so6809795ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 13:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1753388970; x=1753993770; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+b9HQMUZxMpzyZdyEB0HK8P1uTOBEw1dpmm2/mfBx+Y=;
        b=hTFd/QVps/fK5UniKInwOayEt8b4D/HXqMHR5Uv2Ha7fGNmNGBvoA0SFuM91uefqNk
         5BypDdsiFmmUjhB1n+vgpktxeGUjrt4Il368xVFbRt4lg/fyqsXmlB33fg6PYlW9qX2j
         mW10noLCXEYHg/nMUNHV3FWfVx51+HFq7XRrA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753388970; x=1753993770;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+b9HQMUZxMpzyZdyEB0HK8P1uTOBEw1dpmm2/mfBx+Y=;
        b=sMXvMGoys63Un/TsgH7+Uzi90299NPUH6zuTntEvR+hYQoV+yZvNVboV9H4MKny1/l
         ZZV6TDIudRV+WcjFTxQRapBIk1YfAJIrjC2o29D1RyLeUK5aEfhvXdBA0Bcmyor15qwj
         4+wLlUMLEMys1uwSyKgk0wM0Q6Ejy4YcwkVB7J5EEsfvmPUcVeHcGfc2O5P4/nvfMBuo
         d4T0uQqCrAqTwrS2BZmvcDeqUNzpIXbyEHGTQyfpOQz8MQTsNIVTvthrd+2QJ5eCGnjN
         vULZ3uNaCgayonwuKCQA2Wbs0WTT9ogsVepSuV0JH4iIGOOD4cE5mmP7/yJCsebi0yKE
         88gg==
X-Forwarded-Encrypted: i=1; AJvYcCWNMXo/fxoNOXDgvrX6dWa/1UkI+9D5IlWjKkcftm8UnMrhHY1DjMtaXFTgad45i/2haf84KBgcW/ZV4Cg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEoPfvKnbBJbGrH/nQFhEpkffTms+Oj2Mgg9scaetyOP3lKHI4
	Z3plXXDnqwdKm5Ps620v1Ztw3a0pPRZi9U5YF+zTpRBYBCqVhzJmIaFee7MS+0p8YIk=
X-Gm-Gg: ASbGncsqyx5gDR8fdTNFOtM6sSX6bjlRCX9X86ny5yqLg71MuCUsljz69gUWUoPP+YP
	S94XR7Ds3Kxu8YhENV0yR5DZD47j4DZBJ4Q0IC5DdLnzM46+DWc7YPQrJFFicTq444sNuaU1fUj
	B70kfK75zeTMGj1AdcJ9gChZgYqZYEnSQULzgV0yk6NspKcsgqVg8QJpLKWpzNhwec0YkvdPYNK
	vz8vVNEWi6peYA5WlNqbJa1HkEqG4nG7EDKsfomsVpydsY+iX7UUtp5OBIpafGBdBsN/VeFbJpC
	4O+GLG+X2ibUL31H1u+UBp4PetS8AUT8joh+cOfGbtLSg5fSJMkxLckvcUF+kMsVy8C7fSSE51J
	d4PF18lbcbtGagfJEXAeyp7QDQddBEaZqPg==
X-Google-Smtp-Source: AGHT+IFt92nHqkhxzj87qLRfizBmZ9YET/pL7elzT+vQNPvr7LxI858Hx4FdfyjRDKhqcEADcbyxpw==
X-Received: by 2002:a05:6e02:168f:b0:3e2:84aa:f473 with SMTP id e9e14a558f8ab-3e3b979c998mr51075605ab.1.1753388970222;
        Thu, 24 Jul 2025 13:29:30 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e3b723e927sm8214485ab.55.2025.07.24.13.29.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 13:29:29 -0700 (PDT)
Message-ID: <c4da142b-07c5-43a8-a12f-6e403d994a4e@linuxfoundation.org>
Date: Thu, 24 Jul 2025 14:29:29 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests: firmware: Add details in error logging
To: Harshal Wadhwa <embedkari167@gmail.com>
Cc: shuah@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250714212650.17935-1-embedkari167@gmail.com>
 <934dae5f-88af-41a3-9a0e-3aa5311b8f11@linuxfoundation.org>
 <aH0zxwC8eJ2GhcXu@harshPC>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <aH0zxwC8eJ2GhcXu@harshPC>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/20/25 12:21, Harshal Wadhwa wrote:
> On Mon, Jul 14, 2025 at 03:39:47PM -0600, Shuah Khan wrote:
>> On 7/14/25 15:26, Harshal wrote:
>>> Specify details in logs of failed cases
>>
>> How about changing the above to:
>>
>> Improve error messages adding details on failuires
> Will change this in next patch
> 
>>>    	fd = open(sys_path, O_WRONLY);
>>>    	if (fd < 0)
>>> -		die("open failed: %s\n",
>>> +		die("open of sys_path failed: %s\n",
>>
>> Why not just use sys_path as a input parameter to die()?
> Sure, that's great. Is there a way to test these changes ?

The same way you tested your v2 patch? How did you test this
patch?

thanks,
-- Shuah

