Return-Path: <linux-kernel+bounces-842156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9A9BB91AE
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 22:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 598754E3987
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 20:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60FF28643A;
	Sat,  4 Oct 2025 20:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="WGOZDzOs"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6975E285CB9
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 20:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759608673; cv=none; b=f4dFfHRFZY2rRjl/5pG8E6jpuryrN7ZaLsYqBEEBTkoFS9td5vXjciV4y44w5y1UXQI54coZuqRvr4voiFbiz0vOg+MBXV5ZQWWoEkcOyg2A+wQLSgtZKRPAi/wch8FBD7EW0DjLA3C4laF153tV1cRtMf6+Bxo3NPm+jS4T0/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759608673; c=relaxed/simple;
	bh=TsiZxhP+vFGkyQbZ5Zbz/SpNDQ7m1/puPmZFEmdcmw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r8W7LagJTg1ZqPFKxbZ7tzHZIt9Ap3wXi2xcE/wYDQPo1aDeXRHR89WStUnz9SfkMXqYDnD4rssRJseOzgA4JFOMX7I2N3pCk7KyHaZ+BJPteX+hB+zFGsL7fIqwCBeuYPVZjIJ/6odsPq2dKsToY4R3+raD5pCwreb8aqpPw6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=WGOZDzOs; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46e3cdc1a6aso25486125e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 Oct 2025 13:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1759608670; x=1760213470; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7dnXcFXMk+0a5S/+KzBaKdbrz4oMHtiB2nPe7M0WGHI=;
        b=WGOZDzOsVu8798vI7xbY+aM4VnUWQYMp7l4tDCrppe7lMAJzyFmbHFvtCArsXF9z7e
         du0ghmPenYDJiTcaCCOOqi7lIt88nKtj8fmvo3GnBnvhf8tialK5sZQFvgVEaEz+vK4r
         a3U1aa5/ze8RUn2d6Q+u8RgYoTqp/Aw1tPkAZs6XKYtNwMcvC9mS54OPP/qAvOV+yWYK
         o3oDLUTBunm3Q5YmPiLDhb5mJXM006lNCoqTe1ksJvdXvwFAP9IuCeuzl+myOAI5to+t
         ooLosIGlqvaqDzYr3vP5WjLCpaheIcvj6t6Ub3TeAro6ILhGvpjjGLqW66/CPfgSesuk
         Ac9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759608670; x=1760213470;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7dnXcFXMk+0a5S/+KzBaKdbrz4oMHtiB2nPe7M0WGHI=;
        b=U4eGdfmD1D6qr+6rIsf7quwnJxaSpNCfvp/x3k9QUOO53kdWUcF6TI69beaajYLBUr
         gBy75yRMRut9GA+NTpTEMkE+299Qg4D0s5chuHu65hT+tfw2OcET0hz9woA/BDrG7+QP
         Y43OrmPHAI9+mFyE129sQZ7GLZlA8gtu12qeYok8PiUOK+OkavPlrp9iEZsbVfD2n0mY
         9Up9kOoK6Hs7zdCluT+ZmOFHS2DqWFJbTbAOB2bPYIYX7JrturyJ0jgU34WeWdwfRGN+
         QxdgsHy75ia2oXaRe38g/VN7V8sya1SmFPa1uufpNaNVgC4kMAMSJo4fRXQjpV+lOGoF
         tztw==
X-Forwarded-Encrypted: i=1; AJvYcCUX1mFzplWS0jxrS7zAuQq3lVlVeV+G6NbTERHSkWQpkry+H/rWDSb/LsE1ZudVhbtAAXyuSnOqLa/Ds1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YylYwWBvCQd1r07xmRohqoULqklPcrP0V+u+cnK91o0o+6/GefW
	chMbQZbi/zkRE3bDIdj+1zvn7uuigysB7JO1MuXFeteUbQYiysT6BFY=
X-Gm-Gg: ASbGncuhl5gA+fdaHd5Vl+T5DqiNtJutCiJ3xGQDeIa3Y+LyxUHc0HjjkyjeUysLkLX
	8ycTdFc14zIfLWWi294vGVTJc8TYKWEXL0OkZs3kuQaQ2vgtNk6F5WXPaGaHhACx8G3SUWsS+7m
	43MtggJpasT60V6TcY2RCUOd9DoHieH80FoAkXl5TedH9pPBsh99XmzvmSRUyM+T/feHshy0hVb
	6D7pUx717gSk2mv7fXMF6Y3gSLsvHDcBrAyOQYqINgz3xH1a+2GYxIKixS6eSZrbMCiQKPZcVaM
	n+pVznxL2L1gyVtBIv+P1p2u7f0+G/JDYLp+nGw/WMpjWtJpojCT/zPY0cro5bYJP4DAzo0IGOG
	09oItpymM4VdMqbGEd8EkVeBfwvdZwsuyTqfqph9Y+xoHqnAonAQEShw0wYTxoj0/NrXYbWDAla
	+XEy/xSTwLvfu5XVaeDwIFgvU=
X-Google-Smtp-Source: AGHT+IEV/ddfbMzH+eYcV9jWeg4lthVxgeAg+yeGuby/PPk7hXfNTMdQi2AVMg60OxNAsVRCYgvu7A==
X-Received: by 2002:a05:600c:1f90:b0:45d:dc10:a5ee with SMTP id 5b1f17b1804b1-46e70cab483mr53674085e9.15.1759608669468;
        Sat, 04 Oct 2025 13:11:09 -0700 (PDT)
Received: from [192.168.1.3] (p5b2acd24.dip0.t-ipconnect.de. [91.42.205.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e61a022d8sm174613185e9.12.2025.10.04.13.11.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Oct 2025 13:11:09 -0700 (PDT)
Message-ID: <ebf0c3e6-1864-43c3-bb1e-219adff5c7db@googlemail.com>
Date: Sat, 4 Oct 2025 22:11:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 0/7] 6.6.110-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251003160331.487313415@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20251003160331.487313415@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 03.10.2025 um 18:06 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.110 release.
> There are 7 patches in this series, all will be posted as a response
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

