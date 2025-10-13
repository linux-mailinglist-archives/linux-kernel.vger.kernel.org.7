Return-Path: <linux-kernel+bounces-851535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 233CEBD6AF3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 01:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1169C4EA22D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 23:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3822D9EE8;
	Mon, 13 Oct 2025 23:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="FCJ0ph6z"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9617220F38
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 23:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760396570; cv=none; b=QFeJTVL2rZLqFOsTDBx5rGDab927P5tt8csDQF2WaLAIqHV9Lds8jtzbrOJkpMqnBX7XhnnhH21dB9nZm5lcrjafKFP2T4hZJ+Gmc75GOae8ZnsY/hJjHjus8UXk6rrlA/l/DBUBVe81fIgB+vig+pfStQg51xN1vsP4ccPSOus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760396570; c=relaxed/simple;
	bh=NN5Uhc/H7ql22G1CZ8MYhKGMzprQGvu13nPfy/soR6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B9QvXke3d9sMrDQ41AuLHy+FwMceOIw02yidBHWpQnue8OmfmSvuXPYnXRKc16uz1ollUk6YDT2fw7HhQvTjjWcFpnxH9O47CwJaAAkXXom77Hrf6kG2qpueOwabn6HlTo0+wfRkXRqbqVK4XiQOMOEIat5KPfszrKO+GLL2zQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=FCJ0ph6z; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46e42fa08e4so40563555e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 16:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1760396566; x=1761001366; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I/couXEdkLhLPr9L+MDSsns4M5kv4pWx10gdCua1dck=;
        b=FCJ0ph6zFKw2tMgxMGEk59T9vozg9Buy6fz0vnm1QGS70l3brt6jGR+76LLT5/upGd
         m3OIF5d3GM6xjhsRJ5VVIjMerT0QX5YJNNV9mem25vc36Pz5m1kxqFmQtnYXqA5TMNxp
         xzTwBHWyblPHujZzbCw3+oR+WB/Wm3UcQKRDF6D+6FCZPZ4QPKDtQDLU2ccWudzuh4su
         I4oc3f3fxgIKi3tJD5fwwLkbpNRl5BpEGnEZXx5PCKiYEZ7TXHB3wQIJIDnj2MXEK4M5
         9xA7zle05Wxrp2GLKHs86rcFI9VoxAsTVo3gTmkjpN4I9cSKxPSaYhwcV0xrw7umoSfm
         gl1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760396566; x=1761001366;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I/couXEdkLhLPr9L+MDSsns4M5kv4pWx10gdCua1dck=;
        b=O2lM/tnTidIPLjzwDNqmDrJBIlZGRnrQlA1ys7QEl47boXjeF0VDESySZ1cdDXxEQd
         9I1rs7Wxh1gmWcpc7Vl5TfrRVO0Di+K77vkLyd8qzwZ+CXsa+dnnNA0M0aQosSZGZ6/5
         pIR6+l1SdDTa5UO+sEEHwoFMCPdPvFdFw/vWqBIsHW1fpBdMMIHPBzcHn7udg1lAnVYf
         c98nKbKLHZ+BgQdZY7w8kG4tfZ+ZUURERR4QFhB2LT7pXepNi807YcD1Tbsms/U0ZH1k
         uUeBPreG4zAi7OpTQsSncuZZnDyNj66x6TlpzNhAL8tSXPgHsJE1subO4C/f5d9fKJdd
         TIhw==
X-Forwarded-Encrypted: i=1; AJvYcCXhWbv8XtDlU0ugC7qk7iAJL199zGklee1pViDG0nsFdIykLTPyt407gpI9DD7ZuovJArmXpUUj+jKRomY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCwRpwfQkvTJ5yhouo30VmogL+MyzYM+7e1buEx7Mltm2Bcjpv
	U0mWC2qKFjGvnojiuFKtz71UumGmLreVtVlS4HZbW0wUCQk9U4qXSUE=
X-Gm-Gg: ASbGncsZnFhYDemdQfKfevgtb7tijLBBw3Uv4TYWgU0yAZioqSS4P5TSLoimaEiFEPy
	lHueA95HLU7ehaLw2B6VRJZuz4KdSE7DJdGTVwRhbANoD6q4l367N9LpuwEoYMLgQGmEreuYS90
	aSstmnlU4591w2OM5fo8yzDgVUSU3JeIOmM71ru10dLlxrS3+aTUq3lF0fJvvy7Ku+6HGd7h4bt
	yVwdow+Tc/XPCMSDAZMyooTDEiw0PrYk2WPyzUww1nPNIUNrz5H5V2WbPdvC6Q07rktZ1bMjM2a
	owHbXkl24UzuwfvnJ6asX56QYja+E3/haP5Yyxtel/2Jrdjz/9lqa6bBmTEyzPETV50w6/C2Ggn
	rIjgEajX6n3L6hMN4FIFkNNP3aNCHnNk4sgpi4ISXFB4Yvgojj+Z5QdmONShLVCxwJJ8hSM5eUq
	9VTCs4QjV+T7L+bCunf90=
X-Google-Smtp-Source: AGHT+IEvSuL2pcLs02ff6tDICDiVy1cIZRV5hog1G8bH+8Au/ePi0Nv8ATYYDvBtFD/LFI+EZGN9Og==
X-Received: by 2002:a05:600c:3f08:b0:46e:4b42:1dbe with SMTP id 5b1f17b1804b1-46fa9b075f3mr172090445e9.32.1760396565972;
        Mon, 13 Oct 2025 16:02:45 -0700 (PDT)
Received: from [192.168.1.3] (p5b2aca8d.dip0.t-ipconnect.de. [91.42.202.141])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb49d0307sm205739165e9.18.2025.10.13.16.02.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 16:02:45 -0700 (PDT)
Message-ID: <13ca47ef-e5f9-4339-a94d-0eef595d3fb0@googlemail.com>
Date: Tue, 14 Oct 2025 01:02:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 000/196] 6.1.156-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251013144314.549284796@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20251013144314.549284796@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 13.10.2025 um 16:42 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.156 release.
> There are 196 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg oddities or regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


Beste Grüße,
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com

