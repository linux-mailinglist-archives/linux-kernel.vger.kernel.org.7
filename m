Return-Path: <linux-kernel+bounces-739846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B67B0CBE5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 22:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B13416E178
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 20:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EBB23A98E;
	Mon, 21 Jul 2025 20:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="pbggo5s3";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="XNSoo6wr"
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC42622F164
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 20:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753130076; cv=none; b=HvMEEMoo5FsL+auRLL8LgqwVi5GDERELHt3pW9KzKxezPDAacF/HdxeS//9QWNKIKshEJBakLFn7TVL6PXK48smLAdlSUZ6kGTVs3P+egdfrOCcei83JwU1NT2uNtX4wTfg+HkegQkIKabh64/kTLRB3trdVuLmeIusprqBhino=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753130076; c=relaxed/simple;
	bh=L8UNGGOIK0V9bTLJkf7/n3mqGkhzvKUB53owv5FItu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g/SPTfXRdyNvXzkVOHfCrvOIe9eC83t1jTG8tJgsdppMLckuZtK5OqPs1HEfmyPP4oHYvoJYyw0rRc+41i2VlR0TF+ECjJltEnzzLHtNyuJNXAWtovKB99XKtCBZDpdvqPiUvBsusXc3gWBYJWQe0koK+oZHTAQ1ZlGq0AcmDTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=pbggo5s3; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=XNSoo6wr; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4bmBvr5vCnz9sxb;
	Mon, 21 Jul 2025 22:34:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1753130072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XjMHqHnrbR9uOHiktuTKqoY5zCg3GeGQDLjsSoyvOm0=;
	b=pbggo5s3icq1EDv03NvOkzqtmk0anN/EGdZDMSq1RJuo59MEXMCMyQfuAUL8yivjDAUuiq
	a1SwP0YBhyOa5iQEF3tKApjhI05iOSF1IJJNHefUYc1ZQ+ydNp6UrhjRoZ77kFSfQKiEKK
	YQrF5DpCqhlSq0HuZciIHc1hO84Ug5Nd1R9RGeQkjqGca6cVUfV9N0BDq0Ed8NZMpwMRLV
	NQ/I2oq3/UpGMLjgLdTUV6A9Y/gvF2JwU9VNqcuJ4DgA8hTPzuYS58vIEszBrZ9Fsw25eR
	vQuxHdtbIaI8NYcGOeA2I7DV02lpUNhGQ1Ve/NFVrSxpf5e/N/Vy107K+W3zzA==
Message-ID: <ada14a84-0b98-485b-bd84-26666f7a9b3b@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1753130070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XjMHqHnrbR9uOHiktuTKqoY5zCg3GeGQDLjsSoyvOm0=;
	b=XNSoo6wrVkYR7ROKG/Zx3v6+n5I3sVoXsdB5kVwc6jq3b5r9AIuC9X6q6MEY91GrTIoVVB
	clBGyP9rZYOoCj0HN03Q+G2d/8dVAsrHONqGwvXnI8r+yLa8shfzzcFgK3kQ0XU1/X9L20
	EqRqFOVSsPwyrLZ4XZHpcniarqodSwV+59GS0NH1DOUvHLYr70hhIpsLy1xPDW43/hzlQx
	ia4OP2kY2ytTdoTyXt79+YVnwk4PdYUzREMwHCBADrlH0sbeco5+0vk8/GW3p9aY/tC52D
	Aw96RJb7/+G5rD+5qj3/CHIcJ19aKGL4+QRM8MPHhf/GvymzcTjaqWg/7w3o6A==
Date: Mon, 21 Jul 2025 22:34:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mtd: spi-nor: winbond: Add support for W77Q51NW
To: Tudor Ambarus <tudor.ambarus@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, linux-mtd@lists.infradead.org
Cc: Michael Walle <mwalle@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Pratyush Yadav <pratyush@kernel.org>, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org
References: <20250720195625.413715-1-marek.vasut+renesas@mailbox.org>
 <11349679-f1c4-4648-83ec-2292f1c2ae3f@linaro.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <11349679-f1c4-4648-83ec-2292f1c2ae3f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 5e68372c44b02ec9c00
X-MBO-RS-META: 53q8xj3dgsennxtkko5bfhn3beg8i7ir

On 7/21/25 11:28 AM, Tudor Ambarus wrote:

Hi,

>> diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
>> index 63a93c9eb917..dcb6c9ec862a 100644
>> --- a/drivers/mtd/spi-nor/winbond.c
>> +++ b/drivers/mtd/spi-nor/winbond.c
>> @@ -343,6 +343,10 @@ static const struct flash_info winbond_nor_parts[] = {
>>   		.id = SNOR_ID(0xef, 0x80, 0x20),
>>   		.name = "w25q512nwm",
>>   		.otp = SNOR_OTP(256, 3, 0x1000, 0x1000),
>> +	}, {
>> +		.id = SNOR_ID(0xef, 0x8a, 0x1a),
>> +		.name = "w77q51nw",
> 
> we concluded that the name is not relevant, as there can be flashes
> that update their name or worse, entirely different flashes that use
> the same flash ID. So please add the name as a comment, above the flash
> definition. See recent flash additions.
> 
> Also, we introduced some minimum testing requirements, so that we make
> sure that the flash was tested at the time of submission and also to
> save the dtb database in case other flashes reuse the flash ID, or
> different flavors appear, etc. Please do the tests described at:
> https://docs.kernel.org/driver-api/mtd/spi-nor.html#minimum-testing-requirements
Should all be part of V2 I just posted, thanks .

