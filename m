Return-Path: <linux-kernel+bounces-740583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BE5B0D60C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 11:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94CBC1638D2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 09:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52F72DCC1A;
	Tue, 22 Jul 2025 09:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bW+h904W"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C0628D854
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 09:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753177064; cv=none; b=c2shO2CnxzYYGe5ZBjQqlDMZy5cS0vpz2S56B6Tei43U4Z2qXLS53yM45vXfgNXGRLZ336uByNIgXD2u5m+NUBelGZQ3I8I+ayERmxnM0HEcXPpRMRdVmHqjjjgbmLSbeQBv1jCwO3Rv7bAnBs8ObqEbuWJH7m3B7amGn2UhtGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753177064; c=relaxed/simple;
	bh=/ce7nSynynLTChbKzOP1rTjuHeXQcHu2EEJNRjlMLRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ccenTNej2cf1Y4yoDzG54Qls6bDvWvB/msGkI7hhXA6lrVbuF74EmK8zFLPCYaS8TRPnY9BUddTStpHtp4WQXnvZUvbp97NOpvjxmcyMWbCvnn9t4DAqZHxtGrzK+mPYbA5S21C6hwU5+2zz/D8/OVr/JeXVoQYZgnIu+gGNaWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bW+h904W; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-60768f080d8so10113076a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 02:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753177060; x=1753781860; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4pV0KmP7SnZDTkv34ZusWsOS5sGMMAlP7jVm4P/E25g=;
        b=bW+h904WUGBfBbVKQ/0f7eWs+6cgZKkCSNPBG9dTeVzyKiKQjE0I2KBChHhzRy1hSl
         4DDPtXtyVNZVsOXFIoYDnSRdwRCS3GKv3RpnDppL3xrPDUUknDK13OcniS3Gv2WF1VHZ
         8ZFIiSg3Uva7PAklEEXzxHAqFuy7/0+ux4L6tbIvMJ3Mzv4Z5mWlCovjSHcSgwCXD1Th
         OV5UAMzTvQl112PUoI3KM3jWkuNUDw2fKDJtQbrK7BCBjn2zY4hUfGHa0Sd/xxLeG2KD
         Qys1vuZlMHhHl/cS4kLm30iAyuKXJuv7pRGv87tbipE+pPvOlHbG2aTZPiOZpKkclqAy
         8zGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753177060; x=1753781860;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4pV0KmP7SnZDTkv34ZusWsOS5sGMMAlP7jVm4P/E25g=;
        b=cbfrfi0K2nspZFHBZztyJpkE8szRPZLpD3dKyexuKINhkkdxTmVIwDMH815AlWAPEP
         z7n2HbHgSrvSBB+OYY2fSMoc3m3bKtqUqNqpuSDclyjy4BvMVWK+CJqFblyevJ05QQ38
         DhGfcBb7xeQIWpuEXe+aPgQUbyI5dL2uljfBBZ8Qblzln5YD2AAd2rsrHViYIY9edCjb
         2D0iBrbZDDcXVMDuZcLqxBTWnpkuRzPg7H32WbVG7JkiguI+CMRXPnzkNULZ2+pZPF75
         rUb+6JUZ2e06MOUbCAGZ82OtuznKqlNE1liLNuAOTREZoa7WOHYgq7zPnKkuXyrtT+S3
         HHkQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0HLGR8n8fC8DoyGmhXhUinxLofpdnUa0nRmkmz6k53o7bNuSwfJ1NMLC0fhRCe8CZItjxUo4R1ZvFIGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVdp1DgwiyBL0tYOnGG1448EtFfoc5NBMQ96/YCy50SCahjtO/
	y3OIjjJLQZ16aYQYJ4rrHv0FE+VeMttjHocIQ2mrTDp66tu3j22wLUKrdakKZd/GV5g=
X-Gm-Gg: ASbGncuHf+MjQB8Hsj4bXXg/aB68XDOLYMHVeDk1Lopd1c1/iLTuDK46ibGhsP/2HWE
	LLhKbQo6/L0p9B+ohlxPNEpDle5jPqZesofjq7pyg5EEqOZni4h3B3GVpmGzJJMJijP9PAEw6xn
	5iALik+dlDAznGAdXRZ1e9S2c+WJO4dxzDrV6eQxcxCJ6jyX8Icc/Zel258sqlvSpeFmQ307j1c
	bvch/LojbvpK0+TY9OaunIGKBkUUsSQjNA20EBCVh/gc6FUWnhIa1btFjsaKvVJUON3+LH8Jvwy
	MkZlrWcsNS9If6JfW4LfBZIsu2OUSFh28IWKwGXyu7y3CT5E6ubsI+YF7ADrmPmzk78cTHlDh+Y
	gglDmmGsmQLp18y5I2CIeXt+ifZ4Dq9Y=
X-Google-Smtp-Source: AGHT+IF2mpYCyGVUcU1jI9o10RqcMKRUSsS4RESsp4aChq6sbBycz3536/vpVNzy6Tu9lWLcrVnzdg==
X-Received: by 2002:a17:907:96a2:b0:ae3:60e5:ece3 with SMTP id a640c23a62f3a-ae9cdd8436fmr2406915166b.6.1753177060157;
        Tue, 22 Jul 2025 02:37:40 -0700 (PDT)
Received: from [172.20.10.10] ([46.97.171.248])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6ca7bc8esm836474166b.106.2025.07.22.02.37.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 02:37:39 -0700 (PDT)
Message-ID: <c13f39b5-020d-4553-a79f-e22a0cbd1dfa@linaro.org>
Date: Tue, 22 Jul 2025 10:37:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mtd: spi-nor: winbond: Add support for W77Q51NW
To: Michael Walle <mwalle@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-mtd@lists.infradead.org, Miquel Raynal <miquel.raynal@bootlin.com>,
 Pratyush Yadav <pratyush@kernel.org>, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org
References: <20250721202257.83936-1-marek.vasut+renesas@mailbox.org>
 <9eabfe619554cbdd493086dcffef8f44@kernel.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <9eabfe619554cbdd493086dcffef8f44@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 7/22/25 9:43 AM, Michael Walle wrote:
> Hi Marek,
> 
>> --- a/drivers/mtd/spi-nor/winbond.c
>> +++ b/drivers/mtd/spi-nor/winbond.c
>> @@ -343,6 +343,10 @@ static const struct flash_info winbond_nor_parts[] = {
>>          .id = SNOR_ID(0xef, 0x80, 0x20),
>>          .name = "w25q512nwm",
>>          .otp = SNOR_OTP(256, 3, 0x1000, 0x1000),
>> +    }, {
>> +        /* W77Q51NW */
>> +        .id = SNOR_ID(0xef, 0x8a, 0x1a),
>> +        .otp = SNOR_OTP(256, 3, 0x1000, 0x1000),
> 
> Did you also test the OTP read and write? I'd guess so, because otherwise

Any of you interested in adding testing requirements and examples for otp?

> you wouldn't need that entry at all, right? Or is it because of the
> winbond_nor_late_init() which will be called as a manufacturer fixup?

M,

the overwrite of set_4byte_addr_mode in winbond_nor_late_init() seems a
little trashy, we assume that winbond will always use
spi_nor_set_4byte_addr_mode_en4b_ex4b(), apart of the extra ops that we're
doing there. Aren't we better without this generalization?

> In that case we could do the same as in commit afe1ea1344bb ("mtd: spi-nor:
> add support for Macronix Octal flash").
> 
> -michael


