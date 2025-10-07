Return-Path: <linux-kernel+bounces-844363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B338BBC1B0B
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 16:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E1D419A423F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 14:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0974D2D94A0;
	Tue,  7 Oct 2025 14:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HYz0w0oc"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E821F0994
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 14:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759846811; cv=none; b=QdbB12R7c9n2UbraiVNH5musEqrWpIHJTjW161+J3Tib01CC/+23Ip12AShgOeJI40slm+ak35/ikal0ARQriaT/zON2zE0hPcEK/qBxbo38l/abTwgURJIwkeg8C/K3ReU5ns0m1Yrx+NH3engJUl6gJDSkGxpU+9Ockv7Tm0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759846811; c=relaxed/simple;
	bh=Qw/zGLAlS0WneNM+ATx3EXtlXvXA8Fs6JSI5NyYfX0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zvj36GgdbMtxGv7hizhEFTxMvjsnZPh62QabPgla0AC3AxJR3d/t5w4Ba1yzAoBa/I8YUxJ25l5WZhs8R/QbrTfPApRmijngnT4nBev3hO5WpoFFTh0n95tlMPxPWs7Va9p21v7MOTTr+6J2+plcZzU7GF9IM1cuEXaZ0QO+5rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HYz0w0oc; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4888cefa-e8be-4f0d-9d4a-c82f9ff6cda0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759846806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ngYQpH36569K++7CCAQsgIJKCzPaP0ImpmBI/4BGpek=;
	b=HYz0w0ocj3aTEHZBOXPy4bsjjc6WbH9bd6NEk2nD/pGsK3BaVcHhRV7ggaCHI0sXHAp3gm
	bIY2bUbzY8r4VuoZrfWcOpOsn2lEujFF7DoeqEOrbmbjMI3W8a7IltVhjgR/K3Hu+j3yp/
	EKKvz/jrdSgaLy2uUnQgZ+j6QHlEn9Q=
Date: Tue, 7 Oct 2025 10:20:01 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mtd: spi-nor: Enable locking for n25q00a
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
 Michael Walle <mwalle@kernel.org>, linux-mtd@lists.infradead.org,
 Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Vignesh Raghavendra <vigneshr@ti.com>
References: <20251006223409.3475001-1-sean.anderson@linux.dev>
 <mafs0ecreontu.fsf@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <mafs0ecreontu.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/7/25 09:15, Pratyush Yadav wrote:
> On Mon, Oct 06 2025, Sean Anderson wrote:
> 
>> The datasheet for n25q00a shows that the status register has the same
>> layout as for n25q00, so use the same flags to enable locking support.
>> These flags should have been added back in commit 150ccc181588 ("mtd:
>> spi-nor: Enable locking for n25q128a11"), but they were removed by the
>> maintainer...
> 
> This makes it sound like the maintainer did something wrong, which is
> not true. Tudor had a good reason for removing them.

I disagree. The maintainer used his position of authority to make the
submitter second-guess their correct patch.

These flashes have capacity of greater than the 8 MiB that can be
protected using 3 BP bits. Micron (and ST before them?) addressed this
by adding a fourth BP bit. This is consistent across every flash in this
series, and is clearly documented in every datasheet. Defaulting to 3
bits is buggy behavior: we should assume flashes behave per their
datasheets until proven otherwise, especially for less-popular features
that the original submitter may not have tested.

The original patch was entirely correct, and the maintainer's
justification for removing the second hunk is flawed.

> Jungseung did not
> have the flash at hand and Tudor didn't want to apply patches that
> weren't tested. Both were in agreement for removing the n25q00a changes.
> 
> If you are going to mention that commit, then mention the full context,
> and then also mention what has changed since that makes it possible to
> add those changes back in. Having tested them on the real hardware for
> example.
> 
>>
>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>> ---
>> Tested with a mt25qu01gbbb, which shares the same flash ID.
> 
> Ughh, is this another case of flash ID reuse? Do mt25qu and n25q00a
> flashes behave exactly the same and only have two names? If not, then
> how do you know if n25q00a will also work with these changes?

I examined the datasheet for the n25q00a and determined that it has the
same status register layout.

In fact, every n25q and mt25q flash has the same status register layout,
which (as noted above) is necessary to support capacities greater than 8
MiB (and all flashes in this series have such capacity).

--Sea

>>
>>  drivers/mtd/spi-nor/micron-st.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
>> index 187239ccd549..17c7d6322508 100644
>> --- a/drivers/mtd/spi-nor/micron-st.c
>> +++ b/drivers/mtd/spi-nor/micron-st.c
>> @@ -486,6 +486,8 @@ static const struct flash_info st_nor_parts[] = {
>>  		.id = SNOR_ID(0x20, 0xbb, 0x21),
>>  		.name = "n25q00a",
>>  		.size = SZ_128M,
>> +		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_4BIT_BP |
>> +			 SPI_NOR_BP3_SR_BIT6,
>>  		.no_sfdp_flags = SECT_4K | SPI_NOR_QUAD_READ,
>>  		.mfr_flags = USE_FSR,
>>  		.fixups = &n25q00_fixups,
> 

