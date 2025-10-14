Return-Path: <linux-kernel+bounces-851750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2EABD72CE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 05:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22C3E189078F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 03:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07691EF36C;
	Tue, 14 Oct 2025 03:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Qj5gE/XY"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EDC634EC
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 03:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760411936; cv=none; b=SlQcInsGbdw1a/U99+hRoDN66zh3Ht6DR+FB+927XDBu9EdUmRV/Hfr4Ikt9XZly49/MulXUm7IQd5VjOnk5JTY2GOfPo95pzruQrbKKaHqlV+NTKxiSDD9Zsm5nED2MjTBJT9dUqM2/rVKWbCGEXsYoH3JsDXlS6U045ieh92Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760411936; c=relaxed/simple;
	bh=6lR/TQju9ey0aOHm4Um+2HHuV8O2PyLs66AmGS3EoSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t980RnDbiiSa8aPiMzPzE0yVtTE3mK/rQhhwq2F/1HqWA3WG9qqoqkGPAQbNlMuzni3qJleaQqTFk3mkPZxuPFNnnz1Qwwl9srj8rhWUjBsuBrs+aPOGud6haUYzNSLs1EPO0ga2sM1KRSVM6ViagjPcBQYpT5SkjXSXDncMSGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Qj5gE/XY; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-46e42fa08e4so41265075e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 20:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1760411933; x=1761016733; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RZkQk8i8I+bz9BlzrbCcwSCImHhYisNiBNVjldByEI8=;
        b=Qj5gE/XYOWWRJ3ZU+ltFDTOPZFRXdFBwj4Nas8mmt2/5ZgLAt8onTEkutcDvmXNDzt
         6WcVdVfc7zDgHNu9zgwcDkNEiEgGmP2ugnZOiNzggmEPCqHnLo6uX9xQ5oS9WqmB0wUT
         ngksUCIuOBEAW3LNTzReQsAGWNhrwC74eGkUHeuliLbTSizG6E5ezAF3PMTMaqTwOwDM
         SjTPIVZXX5PplBo68uUfIuTBLP4AmBMuzpFyTCw4M+BNHrhPqc9HjZm+88L+p13pRAFH
         83nmTv4JFKB1/iA+evyWcJ2dFz8odM7L+FEA6NKY8t2X/eyUGKdzgIZYPpA9UXUMHyTo
         CcQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760411933; x=1761016733;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RZkQk8i8I+bz9BlzrbCcwSCImHhYisNiBNVjldByEI8=;
        b=cxiQSBl5vX5u8mRboR4ycHnljBPc33ngi4yDkIA7mISFVMqj/W9eI+u6SNxnWNIBg2
         8LyTJuWM6FSoUWIE4SL56c7JVyzrypf8KnoJHTBB1tiMPxLXvETLd75/DpAh1itIFtTV
         j1FsNo6n7iKFO+slKxa4ucpxwfQ2ZbT7gXwaAqCYGsiT/9eUDGsprlLiYoHw1frhiNYk
         OtB3f08/fVpWFsV1lLEV7MxByu5avtFBGUgxmpddP4TNA0UjZWqkRiN1iUKcMdMK35gH
         IvpMDHAhzZhLvOKK7Jxry8oRlWiqUkovwNcdoqcyDDm7VcnUmO2qogyc6ZlUd3+kS4Ge
         fppg==
X-Forwarded-Encrypted: i=1; AJvYcCUMhTIc9njtz1M420OBunT++ak09h24mLqgixILlhx55nDwm1Tgvex7zHIbKCK5V06fckaEnXBvr1vF9Gc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmZ8uPkxTifmVcfATkhdiIdfn0Zxq02YNsYm9/xNqDsKjI5G7H
	jc2krjHBneH/hPo95cH3nV9QyovTufwAy9Cwf1a5K/IDa8/htN6PVto=
X-Gm-Gg: ASbGncs1l/pidMMyiujFNgoDR182O/YCmQBZzE97kQJs1NFBVOG795UpVd7DVmUossO
	gA95WKYk0SEB9lGwA17ZL/Ct+c32F8Iwg9ZBFIupdI8sm1/W0P0uYKrzwmCgnyufQ8mBsonYqcw
	LhXu2TQr05uuT5cb+kvRPuP2mdHmZVbkd1PNzODw2gReTkbbhlc3mq1oSZpleWDidZAzVCHmt5d
	1M/XY0sD++yQY3CQ+YGCJjXs2pGpVXQESP572DyH3Fiht7dqz/wVfnbRyfmge/lMU4nINREmG8y
	cJBS+uDYGBNIQ6n94SXRH0lUY0PeIJE+IfqL2pFOXgIb+7VK2cAMZS1/GiOmYfBzZugFYkApTai
	F1vsj2a4Xs0OMgRye5SM7FVttQmqOizYS8Bcoq9El/tuZO/cgo2VS5hSm3YtKaWzDoIUVHMa3+f
	Li0MKloasDe4sePtKDWhYdLcDFrKk=
X-Google-Smtp-Source: AGHT+IFREi6+xE8As6AfUHzhnF2zI2x/unVzciiXYX3NqYh0HkV9t5cMcjOgt5siISL+FR37Jj9fVg==
X-Received: by 2002:a05:600c:37cd:b0:46e:59dd:1b55 with SMTP id 5b1f17b1804b1-46fa9a8b3e3mr168711425e9.2.1760411932553;
        Mon, 13 Oct 2025 20:18:52 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b4413.dip0.t-ipconnect.de. [91.43.68.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e13b6sm21160015f8f.44.2025.10.13.20.18.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 20:18:52 -0700 (PDT)
Message-ID: <8e7c9b48-0809-4678-8747-313f2bcb5699@googlemail.com>
Date: Tue, 14 Oct 2025 05:18:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.17 000/563] 6.17.3-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251013144411.274874080@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20251013144411.274874080@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 13.10.2025 um 16:37 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.17.3 release.
> There are 563 patches in this series, all will be posted as a response
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

