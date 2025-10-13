Return-Path: <linux-kernel+bounces-851566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E837BD6C71
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 01:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85AAF4207E3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 23:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7F32D738A;
	Mon, 13 Oct 2025 23:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="m4IjIrzQ"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4580A1E5B9A
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 23:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760399362; cv=none; b=JBIEq7zI+0CXORLElcuGZGdoNorixISgFztc32d+0m/l5Z0StbMW2HKtY12z3Qu86SrjoubdF83gBF5C/LAzztOnExyrBtw9MgzwLnJjJH8A3oEgzBcuBJ6Hl3+5QWhh7fgFGCwriRJYYka5G1kr3mMLzN46+bPJM/Vvsb2QOsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760399362; c=relaxed/simple;
	bh=DPqPKVJKoM3S17XqAq8bmlRdURRM8F4tonrV/c7MP2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CepHPW3G/TrXk8Z39oJnbMtLwe04e9SstUC/oxFwqcnimFgNU9VCechqcb9ku3zgicLklek7lOIMuqWe1DS7EttGW9IvCl7m8y7wy5H/5zdb7vQ++wUpi1Xfuu+HR0TH8lXW2Hw20DGgFqWU4TVzdrflkYOQK6Fcr9ZcOI/7bHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=m4IjIrzQ; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3ee12807d97so3192012f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 16:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1760399359; x=1761004159; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q5IQjhjUeRhdsqvIEklKbDkjqGDRUGHZz22zuYo2k2I=;
        b=m4IjIrzQRHYo5PAAZmU3UKKfoj22IOCzcVvvzjxQe4KIT6/BxRZOEgIdT7dID+4tmi
         8ys94dQ9wpGhi1mFO2Lh+keM5wC28DYycXoWH6NNWw2uasrPOHpTwD+/FOMQD2BLaIHZ
         e4ymkzDm7/jT3JziT4BRYFFTyCv5C5TJt7PjyKxbYG0eitm8bZxwXZRKIQ7FniaTYvBg
         OAlY+phh5tqZGEuD5TpkzmFjtfMPfozKxpxkdBq0JV5Lrl5gGafBA0WHn+o7lOfwkbEm
         2tM9iztn4JrB0G25xO6DUkjqhI8e/2EiGTTDVG3l5WlaHRfE2kraW81CxpGhOMFQekod
         GTPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760399359; x=1761004159;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5IQjhjUeRhdsqvIEklKbDkjqGDRUGHZz22zuYo2k2I=;
        b=KbWXQYYuomNKHFuUJUBkx8YD66LnKKVJfVJUJ/6jECNE/qlHFLtUsmGy2tHWOSrzUI
         XhbDJSbwrj+yrS9I6YEZ02Z0WTBLaoyfsin6CO2P6j9RCEBEeX3jTxekcoKXnlksfk2g
         cfo+EmOkgIeqIQRJlDEPJjE/XnVDOqEoKjtvL8GsVR7+SoK2Hy6lFoT4/pTXR+ClLtZi
         lH4GlWaDKbkhcvMwkjO5TC4kPE/lhkoKXAH20amVjH0ZkzA1dDmrVDsEpRy6iAWXs7Vl
         YfgVA0GS58oIICPUqh52SAulFTX+bzHKs+mTibNuF0ZgcPhuEax0RnTcq7w9+wKeA1DL
         HudQ==
X-Forwarded-Encrypted: i=1; AJvYcCXesnSMeQdj0ZAyxPFJO9Ju8fulksa+4QCxUVRR8bOivdykRQrLSryeQOSjh19Ku4kdMMqnD63+it8Kne4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZijEEr1E8QC3fdRrIQ5dqCcE5Rjw4XI3aZS/+X+nAWnrb2tXR
	7lazmzU/MefElLJ3/yFfTyH0sWkl0U1VaUWot6xlZceFCh4f05kkNf0=
X-Gm-Gg: ASbGncsKRI8AcHiqWXMi39mlzAy4Afeg1rQXUMDhCzR68uslrdfcKEPWt2SwOU3NvtE
	tLDjLJ2dxNW+gwFTnNzFw/O/Nhrop1P6cmttJOb/k/sSK1aAClbergGToxtn7n+TwDC+lyaDjrH
	wB3Qi81kyx8gl9mUYPKAji8xWG6Ju29P3Mgn7Bjq8nJsYkjdh/pzQWiWfasah1Zwgi50POTbidY
	Ihc2o/1ye4MpxVfNr8lZDF1q7z8dnCJLsinMwU1MbZ1PXBFkr8e+LigzRi/1ULbC4uQRPZDBJBB
	A5QeKTZhAUlNUVwa5ubyiAOnt2q8RLsIj2+gifPJVwfaw5AEC92keTkJdWOPPGf0g70lqXY3KkY
	I6kLwEqHTv+dmmXTjxigaaRQsE6lIlqPCg4CkGwCVmLvT23AqCirQnm/FWUXtPDl9xiZoMb+tAP
	tHlCqgE13AArijJS0KkzE=
X-Google-Smtp-Source: AGHT+IEcseHOVdvzwVXHr2ecTf0F6oIMAJeswTeWEHpm7pkR4PH0JeeBnX2ghP7A6wl1XDa7xCODQA==
X-Received: by 2002:a5d:5d08:0:b0:3f8:8aa7:464d with SMTP id ffacd0b85a97d-4267260e155mr15648973f8f.42.1760399359433;
        Mon, 13 Oct 2025 16:49:19 -0700 (PDT)
Received: from [192.168.1.3] (p5b2aca8d.dip0.t-ipconnect.de. [91.42.202.141])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e1284sm20457300f8f.45.2025.10.13.16.49.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 16:49:19 -0700 (PDT)
Message-ID: <831459fa-ab4c-4b64-b8c0-eb47a919d7f8@googlemail.com>
Date: Tue, 14 Oct 2025 01:49:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 000/196] 6.6.112-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251013144315.184275491@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20251013144315.184275491@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 13.10.2025 um 16:43 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.112 release.
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

