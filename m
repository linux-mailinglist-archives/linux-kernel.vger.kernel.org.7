Return-Path: <linux-kernel+bounces-849273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0A1BCFB5D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 21:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79215189A067
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 19:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B07A222560;
	Sat, 11 Oct 2025 19:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="SVysR6bu"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1100521770C
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 19:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760210682; cv=none; b=NnUeNAybsSWDv7d2kGX8QGWl3/bYknGx9pA+dy0ORJu63p2aHZU0QTOTie8xmlN2X7KGyK/LFGJyNQF2Pe1jex+EuzyhXBSwgZxlZA/a/y0bqz/FSCfomlqx9Uq5fvG7CBH7QgC7RDwJoo/Bpj+nZbjQlbRy6L48XUNDoVb+ly8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760210682; c=relaxed/simple;
	bh=HWo0rnjmqiObnqt8aaSDDNvEmppp34tQnFy/FsL8dlg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=okkQ+MBVyyNmP6h9fdqEJSmdGGtP4vR23iZwAekqvouQ5iog7UyA0fK0LYeYDxweG+3+pmNEo/1u2naV5cfvkCZ3OkkFTT1tDDD+F35Hww+9vakMOjWLlSBq84koTQ2BYD3Jc7TpqOAbbq06jmnzdQdfXvoYvqOG23Yzxz3G934=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=SVysR6bu; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-46e542196c7so21385555e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 12:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1760210679; x=1760815479; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6eByIpXYuNkGA4vMeyFPW1nCJy+/bsqVrEyTS/rcOmE=;
        b=SVysR6bueXuYoAVuyjQv9U33ESUCh2pio55RcOkj1wSp2YYD+6CKbstv7nAxUcvyaZ
         eBCITFR/6i8DbEWiX8XfiIlt3zGfOjZPqR0TvV+um3JZrPhSo44ghhfk9ayjy99Bbyc2
         JlQKXTsdTW1ffu6w9bYSUVXcr7ZtSiFS6VQApjsHQCvzf1Bm/kHdrUB5JvzlnTWtdRRC
         p3rNvAdrsVKPZyLOxCrD4dDXwnnghuVn8IPWK01bsV5FtfQSpEVh7ABsRWizj/wXSQeQ
         lGg4gc8oi6reGct/+5kWStTFbUJanV5d5lhm61JUWVYS5M2mDcSQDAXL0JXNZmUc+Mwj
         iskw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760210679; x=1760815479;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6eByIpXYuNkGA4vMeyFPW1nCJy+/bsqVrEyTS/rcOmE=;
        b=piJQQiBI6r5L88TEbMG6gbDaVh/JcjjIVu3/QMXm0m0jhzQbGwRbJ4E4dQ54WzCpZL
         H4dZTe4FcWvyFbxG63RKRvDip2QO4zvoffJRdcFKjR+8vs9zZTdaJNucctVOFN18bFNt
         GPSED3zS+ObWYY4Ly0FRXC7uwPTokjXONoMygBn2Qswy9Zi0rX5IJtd5kJLmjl8/jNzO
         D2VCo112JJgt6zoYD2r1eoB0EREE4P5pwwbpgoy+f2FQYAH1XXoVBSqaZ2KzxrksLvMM
         Z8MyexyJRLdklIetnktCj+AHR41Qlvy8FKnhbXf5NvL08ie0/6sis9Y1aUgy/QixmOOT
         FEKw==
X-Forwarded-Encrypted: i=1; AJvYcCXlQH51iSpUemQlX1zAYRywnVptvB+Jf67vk9ye2BtP3nZJTU3qq1xBLsmI/D1IAvudpXJtUYjUAJmbSvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxelACcyVU/j2k5lWgeGr3w/JifqipcM7n1m6a8Pt1OWq31GNrm
	o71GKe4YDHR0NvbSi1/Y6g8cdxO7bEV9va7oDpuFvgtd180/5k/vTcA=
X-Gm-Gg: ASbGncvOHe8oVFDnJ3lEVc/JZtOk+LAwgLzalYGg9xB6NDaDUqrTrlp+26WZs9ksfD/
	9a8Ec0vlCD6h+Lv0XRuAQZLExIXxL5P3eBXIt8vzhOGYPnam81NeDa8C5vEHC2gf19CmKJqnaUb
	oX5jWp3C9SSQEUcUCGdZeAnwQfDh5zv1kbYJjBJNbBzHczw3W5+hZgaLSPZONK2PuRWEIKM5Gdl
	+cjGwkPjSX8A/0jVi0YzMbl09f/WRgODtxjPyKqIEaKRlB/e5wiaJyuvUxBhjU4Djns+8HIMpbO
	Eg7+qjzZd7U69iWHmw0yMR9IaIFv7r1vB43PvNG8zOzgbZynQmhedntgZ9bvjNPQjX+NHyORFlb
	lXxKcb1yLxCLm4hKqmKzpDARMPJvgs4jY9GGCU54vGX3g4ADgT0bNxSiQDDLxco3VeRwd24p8TS
	VMVsc3ltMkAU4oF4yPfMu0FCMGTbYTR0sTc8fngvg=
X-Google-Smtp-Source: AGHT+IF9Ep4er0sxE++lYcipoxpJCMsv+akfvA7XXiL+g3pOZ2ul1BTLiah3UVqQK13BxZKbTh7cpw==
X-Received: by 2002:a05:600c:b96:b0:46e:59bd:f7e2 with SMTP id 5b1f17b1804b1-46fa9ebe245mr116787055e9.11.1760210679150;
        Sat, 11 Oct 2025 12:24:39 -0700 (PDT)
Received: from [192.168.1.3] (p5b057b9b.dip0.t-ipconnect.de. [91.5.123.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e10e8sm10016181f8f.39.2025.10.11.12.24.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Oct 2025 12:24:38 -0700 (PDT)
Message-ID: <e753c8a2-4af8-4e95-bc86-18baf7d2670d@googlemail.com>
Date: Sat, 11 Oct 2025 21:24:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 00/28] 6.6.111-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251010131330.355311487@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20251010131330.355311487@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 10.10.2025 um 15:16 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.111 release.
> There are 28 patches in this series, all will be posted as a response
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

