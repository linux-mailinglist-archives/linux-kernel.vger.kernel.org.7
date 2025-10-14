Return-Path: <linux-kernel+bounces-851645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBFDBD6F62
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 03:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B8EA1351A40
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 01:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86DFB25A33F;
	Tue, 14 Oct 2025 01:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Ig1/UQxf"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229DF24466C
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 01:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760404447; cv=none; b=m2nznOCUGrVcsa9KwObqFBu6QQcRfUHAVqAel3KwxmZsnEA8pe0icPdj61nbKInE5X4zIQNEfWitR1Wr2OTzjwNQ9G9v9dYxkx0NKo8HX6jMaiRqqkLhWW+MT8QdA9neo9xaZIzI2m4IpJNvtGkdyXdgcE3N4Bhm1KftAo5C2Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760404447; c=relaxed/simple;
	bh=VLDmeT4V4bMf/s8VcnNmz25fy91luPLGLGwIAeMLYJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ISzgM3pDV2Vv+RLPoiCLeWFymjnbUXxeMGwRO+Jp99CSAYl56daNWadcebzGz2Zo8ehHgiwJk37YMXA4WrWHrac7NUHi9i8bTiZJY6XVih6fzmpnMz+3T5QlLaf8Ha0O5bQhkZYaruEAqH/Czo5JM/qd398QVhYcVZqAkoUh2AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Ig1/UQxf; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46e34bd8eb2so48266435e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 18:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1760404443; x=1761009243; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BotW9r6xL/UMcoaCPy9Ldu6h3UcOKuy5CPivX5Mz6y0=;
        b=Ig1/UQxfiN5Fk/yO7ZJaSTtwT5JlC5gyQ3uBPDmOgXayMr5Z2naQM68l+Voq1LLoP3
         MyCrf80r59/7qzxlHPs0kpm/9eek0+fnEZQzKDw175M8QI02a6OlE0K2GbyepmtR7jeT
         BFeCNKPT+2wtlAo3Oo7V4svPlQLH3U0YyI1c5d5M9IVpV0EahD0HY/+Hwu9z1gkAR9Sp
         jFD1trNvSkT+tqNvc4IiMcCCJ3R38f5ZKk6zFE0OzRCn6NUu183DH+a2T9vf/z2++eCh
         HcyaFZcILGSnL99yrypSZPA85SvmNq9z4ghoCL1BffF+l+piB5XpCfEdxvHCPxHmm9CQ
         19GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760404443; x=1761009243;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BotW9r6xL/UMcoaCPy9Ldu6h3UcOKuy5CPivX5Mz6y0=;
        b=miz0I2o5De95mNI7hH/lD1fEAJgcztIpvQ7NzmuU86D8tkBpyNHgkGKg3b2anCHMbv
         a48kpj0khAkzJgpMWjY+SrU6Xxam5tfHBUX4H5HL+817V2X1r1zYHzLpqTA5OsgZVKSB
         J1K6eGu/8yPp5+U1viZFwFgCgXK3/iG5OyqDCXY+mvd8fL9t8PnpMZDFNKK9gn+YQi7I
         xcTo6lrmnBC1eziEXRGNNcSM3Mmmsl6u6rbAdpnjbGY7cCj+GXmi4o+ok3d+yGsuO/7o
         cSZTxs8U8REHQSLobDJLiYqdXrqGGamD+UVDu/0d6KajzkhPGn2SjxPlawZ+rzBs7PSg
         A7Ew==
X-Forwarded-Encrypted: i=1; AJvYcCWtz23WRXr7KdXiHFxfAcMwePNix9z/kdBJZsz6w006q1VIjaHFpiC5+W/L2U/Alo0oopcPlXj0sNGiGnI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJclWVQrPTTJXNxECC3PRXNbIt2UJzisoCi74vMibRr992uSCa
	lrGR+IrwoL31OADKCzcKoUOzpyFi8r7ebNBSeIRC5hVX/Biw1Q2/Tns=
X-Gm-Gg: ASbGncsZSxwkY6PHejCK7+nyAeMW+VT3r8xghH0vNkp4EEvMspzVcwGSRiYmSS7bIHj
	SljLBz0vst2I79tsYhiA34e2gnuTxv2wk5hoI5XrYxZlS8eEhV9E3R42IHEKPJ/adrNuiSV/Nz6
	iEQ6Vt31y6dBj2a9mE69BJdv7TafcMmbBuYccftOigMKsn4yMiB16KlUZpPO14leIkhshJVsgZ2
	KkxvRFi3gtaXNDUgsI3BQvPQ5oUvxOVYTj13vruNbg+hQFXME14f74GRkYgP1M75kkxd2hh+8Dq
	WQRpGdmYzv7XdupfCUWmxZReJtr38wHBNlIYdfF9FE/iWsBzsQoyAYgDnPQwIvAeRXJzCotL/CO
	2jgaTKjJbIU4ivsFb2Rz2WByinUxqbtnTwLQbPmpj3lkDvNOQP4+PDagmxduy//5aJfodq1Prrk
	zEju+cG5IGmnxiulZA0iQ=
X-Google-Smtp-Source: AGHT+IEn0zN7JJO7ozOpfwGf2FFNELh91wduawTwnU1AdEj1SfIBN2yVJEWWjvkaEB0nGVf1WaDqGQ==
X-Received: by 2002:a05:600c:4688:b0:45c:b540:763d with SMTP id 5b1f17b1804b1-46fa9b18258mr170118175e9.33.1760404443223;
        Mon, 13 Oct 2025 18:14:03 -0700 (PDT)
Received: from [192.168.1.3] (p5b2aca8d.dip0.t-ipconnect.de. [91.42.202.141])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb482ba41sm212307565e9.4.2025.10.13.18.14.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 18:14:02 -0700 (PDT)
Message-ID: <121e043b-f873-46cc-ab7a-22100c936dea@googlemail.com>
Date: Tue, 14 Oct 2025 03:14:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/262] 6.12.53-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251013144326.116493600@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20251013144326.116493600@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 13.10.2025 um 16:42 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.53 release.
> There are 262 patches in this series, all will be posted as a response
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

