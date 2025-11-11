Return-Path: <linux-kernel+bounces-894691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FA3C4B9C7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 07:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8E46D34E402
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 06:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F28A29ACD7;
	Tue, 11 Nov 2025 06:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M9JYBhEi"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B193242D90
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 06:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762841278; cv=none; b=TjgjbW3otgRPirJ7kRIBVLBdzn97o26JYfbm6UhTp6yjB88faAxir+Sm52gZxXCyEuISSyqcuAmqQM+d8X/lZrJudjkScUL/VNiart+RVTFldsrJZQGVTq+r4toNA34tMr7m+78vdUnSBUYi9+mk86d8P0DkxNagy6TAE2H09GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762841278; c=relaxed/simple;
	bh=hc29+4J/AIduvBPSRlmzkPZBdWhqXwOE/0a/Wi+b3P0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RKCE42Ou9LN2QnHYUQ67wIxe+GceJEOvRIq5fF8CyXDPglFNhyUx1wm62HLibxdeK84Yej1UUTZchcjUMy3nEuPZkHD2GWwMxKvjbDNSaQc6E+tbCA+rkcR+J4j0jmZw/A2hnSjSOiWJDIu5NW0HFaPXZVxdTl08byq3CrplZfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M9JYBhEi; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42b3ad51fecso1435336f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 22:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762841275; x=1763446075; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FE22nBMsNusJRq+HRsVjaUDZroO9N+NkbAMorS2bqUY=;
        b=M9JYBhEiulsjuKasxey48ukjPL2kVqfXDzL23s0ggvXmfAkb1BuuM5l3jJjGHwwgoY
         Qs9RuimtF2I/hcw0QHem5DidUecLTT4kHHCOizm1lRarfnO3008pQz/VK7DYFWXoT9js
         YgJh0c8TDP1jBjEIEXyIixWQ+siwnrMBHcOvjVZKR6qf+6ulEEceeHrDCDQ5mL8mq94M
         auGmxzLu5k0VB2HnHtJ/sztzb3HoW7PV6s5ODYOwa/Py3S1Z4LEY4juwNxzzmbe3Emj3
         sx6eJ8ju+vM3KFjcrGdqA5ODWM0P0CXlJgVVINXDOp8aCiZJ2yauWbgFU2fakIlEqhx3
         7diw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762841275; x=1763446075;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FE22nBMsNusJRq+HRsVjaUDZroO9N+NkbAMorS2bqUY=;
        b=lulQ3Z3R8fuaiyUT4RmfIttkfm92+KHZMu/G2iGSeFGp/6xl3nuF4itzHC+8LGAqc6
         flWMadonhuG58MFM0otuYdfsQ/O+aNAsC61iIvT8co67F0GTsnu07lO+SuKMHDwIwhp6
         UprCdIRFWJ6re/BTXpZ9/NDheIwlKGBTNrJX2Mtk/2REEnDE89QB2drtFcYbWnLTvifv
         zH1FxIHzVJs/rHdFwiXwEX7kJoBfbMpdOtwF33MS/OwMyjQiOE+Y8Fwqonid8sckiyEX
         vlZvS+AYm+SVMPWKWy1uVYMkYy37gg9I+uR5p6jC0zcMt9mTTCibIKOVd8tGHNHLjeqK
         cWWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXR7oXx8hn8wLJzQp3WM6J9oHikhUQPblQIAVCKrqJEqUdNNUgdQYkJ540XocUONXSsOr8xYPDvWHM2F/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFqvIIWhVYr4fsPvWteqjDh0Cbvm2ceHnnQVAlVgfxnvxkDR90
	5UMK3USLFPpuujaA88P/Tcugs/uCjs66y+LxFI0io8IkaJYTaHM9gRXf2P0rdG5fPU/vOgJ+PkV
	gL+h2
X-Gm-Gg: ASbGnctb3LvABY9chi1tLcYErNvIk6RkzoUjCpsfQKRKAJJE+ADuMV6cJcvh2GP0qgq
	Z6WsYRuLzBgSoSB1llwPkZPtQfTIQnGe0mPjdVwaGsEvmB8xTD+xTA4i5EB9MdItN6QnpS5IZKu
	N4JptegdGCTenTSIdlKE4ZNo9+YoxzqhKzvXJG348/qM7v8Dltr9JCQGGdDPmpXi18UX9Oqa/+P
	NEGnKvbTP1HuI6jJyfX9WYLD7dSsce5c4NLEYt+2oSQ3i4K+KN1R6BPLLCHfLKRqNaFUU9Ocuwu
	X/NAMMCBnIik2LhpbdLNYjVVQi4K8xSLmaxDz84yozXzE91eoSde0Bc2JAopatEUgnGiQEngMO1
	AN3T5s8mKRyXfXTYNwnieaqBhiiV9bSOgNtgVx8hP0eR8A69ZyJ8nigsicFrprEueBlNtsUP/I3
	V+4GimIwkAGWSY6b+e
X-Google-Smtp-Source: AGHT+IH/vx3IJ4gFgO3GQrB0wpRgXuIgnYj3bOs7Nv51ZH88KwqwBT+Kt/AB7na4V0rHovb2MNU/pQ==
X-Received: by 2002:a05:6000:2f81:b0:42b:43cc:9830 with SMTP id ffacd0b85a97d-42b43cc9b95mr1352999f8f.41.1762841274900;
        Mon, 10 Nov 2025 22:07:54 -0800 (PST)
Received: from [10.11.12.107] ([5.12.85.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac675ca86sm26204201f8f.31.2025.11.10.22.07.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 22:07:54 -0800 (PST)
Message-ID: <f13ae1c5-17f8-4722-b5fb-07b261d5e637@linaro.org>
Date: Tue, 11 Nov 2025 08:07:51 +0200
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
 <33cbbac1-c247-4644-b555-998eea6e8305@linaro.org>
 <92e99a96-5582-48a5-a4f9-e9b33fcff171@linux.dev>
 <31d01667-e80e-423c-bdab-8d05831d575d@linaro.org>
 <76896942-0f84-47d0-90ca-7bfc5d39318c@linux.dev>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <76896942-0f84-47d0-90ca-7bfc5d39318c@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/10/25 6:36 PM, Sean Anderson wrote:
> On 11/10/25 02:08, Tudor Ambarus wrote:
>>
>> The locking tests look fine to me:
>>
>> Acked-by: Tudor Ambarus <tudor.ambarus@linaro.org>
>>
>> Sean, if you care you can extend the documentation on how to test locking.
> 
> I'll take a look.
> 
>> Also, you may drop the non SFDP data from the flash's static definition as
>> a follow up patch.
> 
> I don't understand what you mean by "non SFDP data".
> 

Remove static definitions from the flash entry that can be discovered by SFDP.

For example in your case:

 		.id = SNOR_ID(0x20, 0xbb, 0x21),
 		.name = "n25q00a",
 		.size = SZ_128M,
		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_4BIT_BP |
			 SPI_NOR_BP3_SR_BIT6,
 		.no_sfdp_flags = SECT_4K | SPI_NOR_QUAD_READ,
 		.mfr_flags = USE_FSR,
 		.fixups = &n25q00_fixups,

you can drop size and no_sfdp_flags as this info is discovered when parsing SFDP.

Also, you can drop the name, and add is as a comment.
Cheers,
ta

