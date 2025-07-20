Return-Path: <linux-kernel+bounces-738288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BC1B0B6CA
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 17:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 941023A4399
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 15:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B86F20F098;
	Sun, 20 Jul 2025 15:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2irRZXi"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A8935973;
	Sun, 20 Jul 2025 15:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753026687; cv=none; b=NOVM7lTxXnbbV+OtoLEJdnV8gsYwsKdj0w+1kafuh+3hoYHef4xluRMRXIflI7FOhQSHeAA3R3KbXd41JKyRuDBO0hw+w02xE1HHl+iyhFiWBt945EqO49CCyMLnaVoZvigSvhhqhFuq7quwK3OTFB9yrivrNLZPOoKdFW8tCTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753026687; c=relaxed/simple;
	bh=nE5xxbedLd/LuxKiwHI+0glshnqFf2+IZaNg3zPZlHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JGWQvjrFY3xq3expSnGKNQBdJVENSLePjbRFtwch4dQsvNOkU5oL+FoYprk0MsaAg5vkDBpBkY530y2X/oiDtV35Q2wlDqyT7XMhnzAewIwSmA8z7Kpuwj9ssOFxedbLxw3C3TNmXRsr8IqF6wHBlBNfHmEnGfJiJykqu+dTKkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M2irRZXi; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a6d77b43c9so2776712f8f.3;
        Sun, 20 Jul 2025 08:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753026684; x=1753631484; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZhSlIzB6MVuqbW9qSicrU8zQ+g68g+LUEKaipuQGk8g=;
        b=M2irRZXiNjrY5Mq7/iI4MzwxSjKoc+At0vPGlQ/lOOYaHh52rnWn3BiED71toqvTbu
         2/snMNKUxzp70fz2Ti76Q0fhFWI/6gNhb/fI5ft53Fex58LwTAyR7eebhGkD1VOGc8Me
         FaR1K0z4vqSDd3P2Bd+vPga38pVxjCOG5ZCUk1HTdMJBl2fGS9LVYZIgfNnwg8wST5QL
         NIQjbxazE2RfwXXwfBYpy2bG0zeaVpbZ9QXi5RoHMKuffr7pq6EswbRXNuTLTb1/TroS
         iTz1NhceuU57x69neteRTziXC9eC83IT4FT7neZlDyN1HpJm9ZK0eTfK9CEGpe67fY3h
         pUXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753026684; x=1753631484;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZhSlIzB6MVuqbW9qSicrU8zQ+g68g+LUEKaipuQGk8g=;
        b=o1gMB7baJD732Wc1A6EOxANnspEowtxjp298Gtu+wGsgZhd8Tb53iNBCnvRICQSRRF
         Y3b/34S46pdB0n9H/Quww9igXFt8a8h2OCYaipvBkChXgfT38H7MO2GUgidPi2qCS9Dj
         vR63jBRhPsOZCyA6/5kNKyauTl6ZBHJtc+cC9Gt5IhxcQtrWwbMYc0aImPDu/GLBO6xM
         nSYasuMEpJZPedByEwloNNU+n59iGplaitiTcGw13qaXg7iFr3f+NNFQTuBCK0Ym1ZBG
         fnE6vV6uwFX0YMb+aRagmi9l39tbVIEbpVntFngVXkJ36NOrajxJ+vjHSjeMHN+1KoAW
         DRBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdxms9Z8xN9LScDKD7ZPoh8pIC7wfnp1jbGg95BI/oGgB+N08dYwgmYrJ4cIIOKR/6Z6nv4x8TyeWlICk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJMUX98nT2eM1Yly6Ihl52WhcbDwTEyq0QJIUXAk6eERLmsgbw
	UV+46wG+Z/xGyzZKVJmkUtdR7wjXV1swNFugdiaUJg9kLL3A+orZSXi3TT7K
X-Gm-Gg: ASbGncskhy+Yp3tMqUTz78qugJJOCfWHSOZcyE7/DrEqTOqTg6fU4DLkfHaZX7h+9nu
	eOxZjgXUfgayMgnkFaPeDmx+ab36/evLIs83eC4XDYyfhIMiRF75oJZEmneo/IZNV3jLbuwoCip
	ciGwhzeg6CTMqNh7YTAHP0dozSXPOqAqydYkRpdbAj25+eZLUvIc+LXF2m8yUWPQ9Y6ww7LXZt7
	NnR5H0ZJ5ARE/if0rQL8HBjvqEV/fRhxKyZASeYERgjKzPdz5pIrWBdzEsibFo1vMu9AAm6T6Qh
	LcCvayQhF4YEX4DPpP6GKxLdINC3euoz+BtvtsqtMGybIcfnihSoi2ebrpWQlP9WD7FsRQ/jJjS
	sunSdAcs9BWQlo9LZxbOCrcwuvQ/SvFTfpvCSe3wizv/c335m+qzvz2DYMB4NG8BnTYkg
X-Google-Smtp-Source: AGHT+IG+5w27E9q1sMLm5Y1WlTy33FG/bBzJqXE6w27xvGt5x1K2hO4i0gkfmLaVrTrtj/ZKRMJ/bA==
X-Received: by 2002:adf:e195:0:b0:3a4:ed62:c7e1 with SMTP id ffacd0b85a97d-3b60e4bf986mr13518949f8f.12.1753026684061;
        Sun, 20 Jul 2025 08:51:24 -0700 (PDT)
Received: from ?IPV6:2a02:810b:f13:8500:8b91:8a7e:bd07:2736? ([2a02:810b:f13:8500:8b91:8a7e:bd07:2736])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e7f2e8csm135189035e9.5.2025.07.20.08.51.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Jul 2025 08:51:23 -0700 (PDT)
Message-ID: <3c83e8cc-9ef0-4560-b6d7-127abab50541@gmail.com>
Date: Sun, 20 Jul 2025 17:51:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] arm64: dts: rockchip: Add ROCK 2A/2F, Sige1 and
 NanoPi Zero2
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: devicetree@vger.kernel.org, heiko@sntech.de, jonas@kwiboo.se,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, ziyao@disroot.org
References: <86814bf6-5d1b-47f3-ad1d-962cae4a543f@gmail.com>
 <20250720134005.215346-1-amadeus@jmu.edu.cn>
Content-Language: en-US
From: Alex Bee <knaerzche@gmail.com>
In-Reply-To: <20250720134005.215346-1-amadeus@jmu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Hi,
> Hi,
>
>> Just for the record: There actually is a non-A version of the
>> RK3528, which I actually own (but forgot about - perhaps my subconscious
>> made me reply to this thread). It's on the Mango Pi M28K board [0][1][2] -
>> which, to my knowledge, is one of the first RK3528-based SBCs.
> Thanks for sharing this. M28S is an engineering test board, and the official
> version was later renamed M28K. The MangoPi M28K board uses the RK3528A SoC.

I'm not sure where you are getting your information from, but as I told
before I actually *own* this board in the non-development version and it
has an RK3528 SoC/silkscreen - I just was too lazy to photograph it my own -
but I did now [0]

[0] https://imgur.com/a/6jwx4dC

> As for the M28S board, the silkscreen of SoC is indeed RK3528. [1]
> But then the interesting thing comes, uboot reports it is RK3528A:
>
> U-Boot 2025.07-rc1-OpenWrt-r30114-9b777547be (Jun 18 2025 - 18:35:23 +0000)
>
> Model: Generic RK3528
> SoC:   RK3528A
> DRAM:  2 GiB
> Core:  130 devices, 20 uclasses, devicetree: separate
> MMC:   mmc@ffbf0000: 0, mmc@ffc30000: 1
> Loading Environment from nowhere... OK
> In:    serial@ff9f0000
> Out:   serial@ff9f0000
> Err:   serial@ff9f0000
> Hit any key to stop autoboot:  0
>
> [1] https://imgur.com/a/ddLsnmt
>
> Thanks,
> Chukun
>
> --
> 2.25.1
>

