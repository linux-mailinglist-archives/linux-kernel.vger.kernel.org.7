Return-Path: <linux-kernel+bounces-741007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB20B0DEC3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 16:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEF2FAC0425
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 14:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2F92E8E16;
	Tue, 22 Jul 2025 14:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="eZtIqqwp";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="QWzlBzep"
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD473195
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 14:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753194507; cv=none; b=idRZIVA/Uxo6wY0Gief3hguC52g5yCMIIJnX1EqKBmEQjhKvIz52fN784RmPIrZYSUz+/NKLLCNhOZObeqh+tfaMnqFtC4OQmEepj4P+Alatcgg74DObV7wORBHLTdaYk0A68pYOUhUYAswXXJ/WL3a4DlSAzVzd1vVkjpvIyPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753194507; c=relaxed/simple;
	bh=JXdRMsGOqPckUaxt3XKUqYvo7xGP2i9WBfQTeTjMbHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iNSXPubRf4gd2ijIvMAsl0OyrotWuEhtzcobnKhQF769jc7M1GltTxYmpPh9YDhi8Fgdmqb1bk+xk4jRSxbsRzNwEyZXV7Uwh7J9PKFG8/gFzznp1PmNimmx0VlWHG+cwLcg4i4W3fEOq6zBskvFx6ip+9/KoPqq5csVJXOrN6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=eZtIqqwp; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=QWzlBzep; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bmfkt5gPlz9sqs;
	Tue, 22 Jul 2025 16:28:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1753194502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QoZeSq3Ft9zf022HB19vAIpK1dHjyTYwqBtZvyRFCXI=;
	b=eZtIqqwp/7w6FnBDYMq9ulsCseyYSJI6D81LFNCvmmCN+Eh4peo1IvAV1sDxLtyVYQXsra
	lKfqeZ92TJqSGet9uB1onzjqbe5WzYx6VAf/SM8crVDKIpItL/SbSb7GaDK2UghkLyj9YQ
	HI2JWfx0nV6zIoF6bZe3ndqBZcTTPQ2dJvuqJYHJh6O1bg+z5Icqr8aDwGT9EC3FO7Z3gb
	q8rxT9XdTsQ0TZc2SJR0dPKgE7tkvBmEzl2WsVKovlFmYye9KboGwLOPHSWjqUN8s2FoFl
	xKFUuNGRNu2+cKK8r/YgG6t68xb77pnA36R6LTtLSbXhP/TEj1wr92WDk5IHDg==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=QWzlBzep;
	spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <62383ff7-0a14-4f15-818b-f5e5c56332c5@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1753194500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QoZeSq3Ft9zf022HB19vAIpK1dHjyTYwqBtZvyRFCXI=;
	b=QWzlBzepyhq2y1E5mc3THppQod1M4AOspjRIxVn/hXKoPsFj0opxOLv2xncbqHqdDKgiZ1
	rEF1juluq6IUvCPSfESIWmA+xZm87wPSdIPEpx1Cuo47u+yn8hoCT0Avwx/VxZoWqHIDiU
	HrnJKGuJjA8S6KG5xpL1oRXDiKzVuB/LFqxbRA+w4xsZAWGYukQlWVZZMwCfECjHXcjoHi
	TnaU/e6BHnkazTUm4PVmkqGG4vctDbqPbmTs4j8PJIge6RJ1dAHCN1LT7J53EkIwsPqACP
	p6kgupxN4nPLayYLh8kySqki7J1CuOfyu07NWNB1BWImY1elWE7KWDnz9fhLIQ==
Date: Tue, 22 Jul 2025 16:28:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] mtd: spi-nor: winbond: Add support for W77Q51NW
To: Michael Walle <mwalle@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-mtd@lists.infradead.org, Miquel Raynal <miquel.raynal@bootlin.com>,
 Pratyush Yadav <pratyush@kernel.org>, Richard Weinberger <richard@nod.at>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org
References: <20250721202257.83936-1-marek.vasut+renesas@mailbox.org>
 <9eabfe619554cbdd493086dcffef8f44@kernel.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <9eabfe619554cbdd493086dcffef8f44@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 9hjry69xq8ezz76u599fti8f57agswgn
X-MBO-RS-ID: 39ef04fce8a48af26b9
X-Rspamd-Queue-Id: 4bmfkt5gPlz9sqs

On 7/22/25 10:43 AM, Michael Walle wrote:
> Hi Marek,

Hi,

>> --- a/drivers/mtd/spi-nor/winbond.c
>> +++ b/drivers/mtd/spi-nor/winbond.c
>> @@ -343,6 +343,10 @@ static const struct flash_info 
>> winbond_nor_parts[] = {
>>          .id = SNOR_ID(0xef, 0x80, 0x20),
>>          .name = "w25q512nwm",
>>          .otp = SNOR_OTP(256, 3, 0x1000, 0x1000),
>> +    }, {
>> +        /* W77Q51NW */
>> +        .id = SNOR_ID(0xef, 0x8a, 0x1a),
>> +        .otp = SNOR_OTP(256, 3, 0x1000, 0x1000),
> 
> Did you also test the OTP read and write? I'd guess so, because otherwise
> you wouldn't need that entry at all, right? Or is it because of the
> winbond_nor_late_init() which will be called as a manufacturer fixup?
> In that case we could do the same as in commit afe1ea1344bb ("mtd: spi-nor:
> add support for Macronix Octal flash").

I have limited supply of these devices, so OTP is untested. The flash 
does have OTP registers, that's why the .otp entry is there. Why should 
I remove it if the OTP registers are in the chip ?

-- 
Best regards,
Marek Vasut

