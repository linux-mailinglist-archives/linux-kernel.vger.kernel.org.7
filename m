Return-Path: <linux-kernel+bounces-838176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76862BAE99C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 23:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DA443213EA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 21:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5421628DEE9;
	Tue, 30 Sep 2025 21:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="SlycOliT"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167D62F2E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 21:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759266640; cv=none; b=IcfSU/vSmUNV62XTTEo2c1C1Gq4Okm+g1Rn6HoaV8tEsvrPg3lw/vAhN5PlzYbD1fPV7vr5HBKndaaE4LdqZXTiXX5jtwmOE8nr2IgQDm2byZSUl7rI+RAfqxGaeO6lmbIvdrAXe+mjBOccgR3JH1yTGLcdCQk5Aq3BMA2hnccg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759266640; c=relaxed/simple;
	bh=IY/T5MW0cQ6hRm9986aMUWP4hxXi0edg7BRspaUZmxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WHoIHG9DUbjZwO+4Bb1wqIUgj7LRMtZbiDmc+3HXyTmuFglc56qjLvGdwuQBMDSCA8tNPYtZo/3eTcvl3lBs3CRzLM9rLII/JqkRfAeYKo7aw+IsXVtgtqEHPyVzdf0cQ8aanX75cPaPQ35YvKa3GfPaK4F+NGNIn8HdS9nGeTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=SlycOliT; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3ee64bc6b90so4051337f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 14:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1759266637; x=1759871437; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bHb1TeK0SDtTGD/hGQdOAwIIPezVefzkx8O/f8zdLfw=;
        b=SlycOliTrZ/v2davzRiKMEIc2I0gdO4U3p9lnmfSrGlduz5FX/LGu5BJcG1yuSRzi2
         vN/nje4LvAn5DuZ9PLhlSb1aHQSRo8GAWuvTB4xabCxYprROxbIjPvCJpfJihIKESNgT
         EHxW7Ox0Wpas9Ukqu4H+vGN/Y4F9NBGiYe/tzG3ixlNj1QG5KWjbl3tDwhPlnHpk66hW
         A64LzwoPTeSYsxGD0f7yUOvXJmImdRLpLBB6XFwmgi6qIFQkFKOSLhTKs3aYBTqJnROJ
         ZQxGhUyoK3EY3wWHcfjYyEPs7Ov7CNrm74KKkB5PFGd6RX4HPgB1EncA8qqklsjRceYp
         gBvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759266637; x=1759871437;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bHb1TeK0SDtTGD/hGQdOAwIIPezVefzkx8O/f8zdLfw=;
        b=HIWRg5J+XOE4vtq4Jz68o88ohkcEWGDPDhZHHR1+vt55Co/s1c1koOkp9UFbM3f74D
         eknu7ycB4QOEvbHd4MdxmFBirNuNnpLOTqnS7aT7pOe0GxuLIpY6T7ds9AP9v1GZZ7rs
         TuwfLxCSM8ouxHR/bYAyJRHSG+7ULi40jsBt1rUJjeTEu5Udcsmn+aiZpYEHVBlh3Hb1
         fwdwjtT/lvcxbCJOzyu8aw5xP9n9Vcc446VKPGzj2aTlJuVbk0DJy2jxwCH7ujq2J5OR
         54ImQOEpAdh53ee6tWmt/vEb+yu85VVS20mF26ln/JFJFvyD/JgqJYnXbVCsrhuykc1X
         u1cA==
X-Forwarded-Encrypted: i=1; AJvYcCWBymhhABcGQBiQPRZnyt+I/ETJh6kXj03AsklnuZ6Zf5rqoo81Zis3gqOwy70d6ZmkNTP7ZzWqOyXxMGo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi8ZNcCTd3TK8fx61xohuhTZyQI5vCZ7QtSZ0U7jYNCZiET8ac
	68ZaP4tIuPpT07yV8PWttZjgm9SnYwf0Cx8SRCv3lxTMWGCUpBwSY04=
X-Gm-Gg: ASbGncsTJnLFHyE20EpgTRPTDTcGqkVm/MUG0BROOde7sC4kcmSshjeq1Fda5gN8pM7
	RmvVMfn5vxcz4aCpSs9AQw2GAqtOWVa4PTmRXDSNYWs+FloaaCc6SKKRe2RtAHkqP2WnCb7yy+v
	9lxHEAeUxPQ52XfRwH3JroyH3D/5MtPbRzGoPOliEKl5HRG3Tk9CzXSFgjMyKUCF3I/fMurXPNY
	4EaAXvESHA1u9JcFisXpy0OxhqueGnk6fvEzvlMy9W7wb/8/z1SPj+U5SAyWTRcLluVHBgZnC8U
	xL4GJQwOE7k2AlhAg8wSESh75eL/H85GPW4LRqxgdwWB5Sw3gzKXpnltj2aY7FlezauL5T+Tr1P
	kG9xOHRAylzjARGJRV2DM/LqC1FnieFMi0/BwM1E7rEmmIgJv5k0ppH+W4Hl5DyXDUzCsKivYAH
	Mwb8jm8Xj1y8GTbNUfyOoxm1M=
X-Google-Smtp-Source: AGHT+IEtRCdZtfm6bV+C3kHsNpx319GbRTyLtQCVbRdZ4EJBOZT09wV8Fky23E8en9rieAf9Q7cbwg==
X-Received: by 2002:a5d:584a:0:b0:402:4142:c7a7 with SMTP id ffacd0b85a97d-425577f325amr883446f8f.16.1759266637039;
        Tue, 30 Sep 2025 14:10:37 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b4965.dip0.t-ipconnect.de. [91.43.73.101])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e5c3eca22sm21222835e9.4.2025.09.30.14.10.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 14:10:36 -0700 (PDT)
Message-ID: <4e557716-474d-4aa9-96f3-9bf154781582@googlemail.com>
Date: Tue, 30 Sep 2025 23:10:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.16 000/143] 6.16.10-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20250930143831.236060637@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250930143831.236060637@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 30.09.2025 um 16:45 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.16.10 release.
> There are 143 patches in this series, all will be posted as a response
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

