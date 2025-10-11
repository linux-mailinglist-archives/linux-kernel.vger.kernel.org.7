Return-Path: <linux-kernel+bounces-849316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 487C8BCFCF1
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 23:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 135791898EF4
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 21:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E3724466C;
	Sat, 11 Oct 2025 21:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Skt3jRJv"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3E72405ED
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 21:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760219952; cv=none; b=KIw1tcEGmWueJWC38YVVFT6AskjDK7vkPyt09HFWppGU4WrKa12xBpIonn2NiiSAh9O15km1yJokyuAgD6JNnvyIaAw8OWr8KJugHjRGz4eO/z58ptZY6zgZFMlVE16vIvQEV/fviyvGMdDffGSUSghMOck4ZaKY7sABMKha28Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760219952; c=relaxed/simple;
	bh=2huGcfbPwSh50phjR6U4KnFgcmdQ/b5O6KDcOTP5300=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q7sZGaX3CCB/E3gLl7Ldq6kfiR+eQzPckAZIITFvJC9CRt181spQWI5KSLC7DB11FxmZQYhGUQY4Wp89JIBKPAojCk0qMmAGqNUirp5HIogvOOi6FnolGhr3drb6KIMq7aVfI5mpuaHA/u3Xth9h7iM+TEwm4RMSv7MbKgOAvR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Skt3jRJv; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46e2826d5c6so18920285e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 14:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1760219947; x=1760824747; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MHThunLmw18bkcxxk1/kwdh40gHKEqGwgzIfI1FE8xY=;
        b=Skt3jRJvuIyUKzW9KxhIfEjoB2i+X5XOGcgx1rCruiyeEQILRADAHfKweUtJK7LZ5Q
         o/RWjr32fCZrRZeUKuFfqgHia3+mDxIvx5QW6A51OCVYg6eNg+XzKHHiLK19S35vAVTi
         usWlKG7+j88hpi0cw/QlKR6XZxc9XSECOD1p6IYU4ol5/KB8uOBvvdJ2MBvUPa/DQ0zq
         Wwx9vcvsEdjvepivbY3dKquTI2qALMgjbHHLBx+QUkYsX4NmKW5Z0GQO1OZM88LDyopD
         DMlVWsVgN6cRWMrxNx8+sR8ZH9GbetnZYJ/tjyDzxt4U9KeezD4NXE1m4xrqz8iGpCaj
         5APw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760219947; x=1760824747;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MHThunLmw18bkcxxk1/kwdh40gHKEqGwgzIfI1FE8xY=;
        b=WboEN9lHO4Mt2wY6tZS6To9fv65JzwDI1F6D8keXI9xVQlc9ghQbOpv0cdwML2l238
         3oD3Jlj2+hArREoYVVVx1eLM546pllJE4RMpieiAC+7CN6A5sYdepl93sqA1gRGTR7Mr
         bxUO7fx7PcM0VZyvfKqfSgn+s9Y1jCJEcTeiUhnrvU34957ULmwrD5hKwyIJR2WlcYvR
         POppRtfGndYsT8x17KZvDzxCtNcBA4u8h+Ad4/+QE3D9u8u1TDufCMfqkl7DhncNPwJi
         YmIS1RvVO/zWYfP4fu8WRpVpZsZjbN9s6MAs+6cQKiXb9dV24cn2XVjB7vjvNatJOjIv
         9PNA==
X-Forwarded-Encrypted: i=1; AJvYcCVqiHgdq/z/FkConF4D9e2nYrHQrUD9VvG8hQwc/QQqTGeqNSvMYV0Gl/mnZJAV6gU3w2ITjadOiWJgvD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFZiP21r5qZa+rczGv1+S1B0Gy+IvkP1N6QjR84JLM35q+EdyW
	xK/0c1/DPuUPQsFets0bEYZu0b5YJQsMEqdLAPcIpObbp1D4AnAhRVg=
X-Gm-Gg: ASbGncv3XTzkgoIM5hJSgVmD9z0jauIPmF5weh5syZLooja3BZs11BY3/qQVt/o0/Ir
	t5Yma3z8Y/SdgDGBT1Fwx4uamHlrefhQzwxkoKbHizU1agj+AU4q3TyBgrDc3TRbAKlzye4RHn/
	M/1hINzcRu6xL9eBQZlPCuapQJ+IP912ZQ7srV3hAA2l6QWnJEFYVKJZJguK1AzJYTaIZHltAi2
	MGbI2LVCSjYrgxbcBjlr5urrbYCSBNb76DcPUpxe4Vlqi2HGvBCZiYiWM5pqEEGTSEHPGAEXTY/
	yVINeWf2BhFeCwIeQuDtxij5ohfjKwgeGENJxYiRcWPp2EmBKa555/XtPo9gUYaIMSZ/5gUjtO6
	BTWjo6GoBHF3rTC2Ws1fijdnDHWcO790hbJEDUIlhfZ08NMeeScK7LFOB1ydx+39mhzDPWLOrKd
	C+IdFfwdCdXvD3l59vxwJNuui/1V2zurrYBk/tMMQ=
X-Google-Smtp-Source: AGHT+IFY8BvUEE5h0xt52mM8sCae3x2299mFEpXNCOJQAjgaAdK8tGVw0x5V3Un4+D2uFHAuzg4xjw==
X-Received: by 2002:a05:600c:4688:b0:46e:5df4:6f16 with SMTP id 5b1f17b1804b1-46fa9b1788amr111462435e9.35.1760219947277;
        Sat, 11 Oct 2025 14:59:07 -0700 (PDT)
Received: from [192.168.1.3] (p5b057b9b.dip0.t-ipconnect.de. [91.5.123.155])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb49bd977sm108385825e9.11.2025.10.11.14.59.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Oct 2025 14:59:07 -0700 (PDT)
Message-ID: <3992ab53-474d-4031-a601-259ba3966bec@googlemail.com>
Date: Sat, 11 Oct 2025 23:59:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.17 00/26] 6.17.2-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251010131331.204964167@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20251010131331.204964167@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 10.10.2025 um 15:15 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.17.2 release.
> There are 26 patches in this series, all will be posted as a response
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

