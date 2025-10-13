Return-Path: <linux-kernel+bounces-850086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F749BD1CEE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 09:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A5E634EC5EE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 07:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047702E8B83;
	Mon, 13 Oct 2025 07:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cvylvrtd"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657FE1E7C2E
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 07:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760340630; cv=none; b=VwahyQt8nHVvtjQcb87617nXNgCh2/j/i/t5XGVejNG3NupuxN2zTOmeBc3DahA9a2XRYHR0MK9IPwJ9Yfgzrm/jOPlBTYEfyEMwZ9PXzi4YuIP5LFNUFFFOZIWhr/ZmDBjX53y65F4bftXpUgEzdQLpkKZllq4UD/jhFxrA84o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760340630; c=relaxed/simple;
	bh=i2YvHo5Ac6vi6Cw+OzLFVrwPMPFb59UoXYBTXSuUtkU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V0fYl65A94nPSTIWCKBqi4yTMOcaVp8Yuyqa5/2rcERQo04jfkf8ztWPdbmP6Q20VRpgOPYu9XqNinsnFHTP9szC1hwjW3nuYeSCqtm0XCxfXLmpWQJLkrpKFEUyaFkX9Lgcso8aWM8EM5U4uNsZ9Msm/BngJcF6TqdbtHAE54Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Cvylvrtd; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-46e2e363118so32295775e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 00:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760340626; x=1760945426; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O7tThfX+A9pJzDxQgmG7Tj5N8YTWpyW9vcBCkeCqf1Y=;
        b=CvylvrtdDtAiROXOkWZyl5xyapS5F3Icjj//xqTgDnDIWjj/xu3MBVDKnVy1eUHzZ4
         cgHeC4q5XTb8g/HPtjEgvAVrOUNsqrF6mU8QXlC681p1YpXWT8QxRoZG7XAJYoqCxVWH
         CcBVVKje35Sxdi2kkOZGaFPTAxYnnLGSEuTGtSy/Ov2HWpKZYxb0gDNXOH/ceS7PObRj
         yjtdxKqMXljzv78VLE7Av8Dx5cJ7g22Wyezj7NhOiCiPUkuU4iWmw5zsBd6GNTM6aICm
         TMcggXKfJpBERwCS1vcuV1DNfrWu5eZlsvobHzzrjk8LlZfUBc7W3Bj/wljquSOZzEdV
         SaKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760340626; x=1760945426;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O7tThfX+A9pJzDxQgmG7Tj5N8YTWpyW9vcBCkeCqf1Y=;
        b=WlG/eNnaM3b/KQww2tJGmQjYX1gFQc2/A7hB41pVKkt+HnpWqEEMT7DdNk8ZFPjLfh
         Z36+5JPDTv3+Kc6FBhx2UdRFoH9IneRGRW14w5MXTGknwWnh+LulsRAUmj2tbcgWAuVX
         JtVJlFvPNNkFUru/1iep9iRcWGjSAJjwiINkaxCeMQeGuOz9XESof6az6D0BnhxdTlgx
         ME1yKeuckFBJlissusXVnstZpnV15VZDOfDKJovMEg5z3BevgszQkxsMm+I1CyQvTtue
         UqY7vdmMkbfpl8BLTxVdnX4dAdeuSezcblG+tu5IUvlyUoPybIqfJ83W+aWXzqU9VcP4
         bHbw==
X-Forwarded-Encrypted: i=1; AJvYcCUfUoAMWinCeAjAwsq7fxreoZ6PrISBEXqxAhQyJU+3i/PeWxLx3RdNHMSSOrRH4CPDGs6isITczXVp2+s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz6Yg3F0AEURA0QJ6A5rkxYt9GkqPvihF5KLTRkNzqC3+6Gg//
	0guO5AEIBvCiLcxWl7XGpqv9NSJFD62926JKtFyaLGBZF0bgaNpMFcUCtnalSFvnjJ8=
X-Gm-Gg: ASbGncvGI8vsBkSz7y2YEmRB8MVV4XMJnrFgWGGch7JILtCRaD+fc2i3b/XaGroGBk6
	bSrhJA76eYg+EuVaUeYypAI/3Z+k4lRKeUHBignfO9FMtSp3zC7rviLg6zgRiQWttmAZFtWGqi5
	CiXm4OCuVyaKkCu+ejkVOOyQVRubjylNovLhMFpVeSYeghNmfavLZloqs/9t1J1rer38C6Cn7aY
	IifX5gH80ql3jJM7Zb4oQSFRhoscuMZfGQaXjW4gniBRdMPDIn8LVxfhwow3tNX4fh4VOwFrikt
	Y6XEPcHoU3+VwkE0lXXUtdtoRw8lkFslfoZ1Pg+NK90zousbQV0embsYMNvHYQpxg64wShhm1of
	7RJgjoyDwHKmdeGuy37nTmwY3xSdLFDHLbhpAnO8ItAlKezZhG4SN/w==
X-Google-Smtp-Source: AGHT+IF0oyexkmT+hYLMRBg1CZ0D2tPubfKPEN4EIxAjwblVTb0yV519e8lVjoOsf0C8pdo29qcdmQ==
X-Received: by 2002:a05:6000:1ac8:b0:3f7:b7ac:f3d4 with SMTP id ffacd0b85a97d-42666abbbc1mr15035393f8f.5.1760340626525;
        Mon, 13 Oct 2025 00:30:26 -0700 (PDT)
Received: from [10.11.12.107] ([79.115.63.145])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5d015esm17200215f8f.33.2025.10.13.00.30.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 00:30:26 -0700 (PDT)
Message-ID: <33cbbac1-c247-4644-b555-998eea6e8305@linaro.org>
Date: Mon, 13 Oct 2025 08:30:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor: Enable locking for n25q00a
To: Sean Anderson <sean.anderson@linux.dev>,
 Pratyush Yadav <pratyush@kernel.org>
Cc: Michael Walle <mwalle@kernel.org>, linux-mtd@lists.infradead.org,
 Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Vignesh Raghavendra <vigneshr@ti.com>
References: <20251006223409.3475001-1-sean.anderson@linux.dev>
 <mafs0ecreontu.fsf@kernel.org>
 <4888cefa-e8be-4f0d-9d4a-c82f9ff6cda0@linux.dev>
 <mafs05xcpo9sz.fsf@kernel.org>
 <26a795ac-e6ff-4363-a8b9-38793a9be794@linux.dev>
 <mafs0ikgnn07u.fsf@kernel.org>
 <d00d42ce-4262-4736-8c73-5d2544e86d33@linux.dev>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <d00d42ce-4262-4736-8c73-5d2544e86d33@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Sean,

On 10/10/25 4:45 PM, Sean Anderson wrote:

>> ... or, you know, read the data sheet, write the driver, and _test_ if
>> it actually works?
> 
> Which I did.

cut

> - Locking is not in your suggested test procedure for new flashes
>   (although it probably should be if you're so gung ho about mistrusting
>   datasheets). 

cut

> There is no evidence that the status register has three bits (except
> when the flash has 64 eraseblocks or fewer), and there overwhelming
> evidence to the contrary.

Nobody challenged that your flash has 4 BP bits. I/we just want the proof
that you did the tests, i.e. show the output of the mtd-utils locking tests.

I also need you to dump the sysfs/debugs entries.

It's true that the locking tests are not yet described in
https://docs.kernel.org/driver-api/mtd/spi-nor.html, that's why I encouraged
you to show us how you did the testing and maybe to contribute and extend
the documentation.

Cheers,
ta

