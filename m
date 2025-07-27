Return-Path: <linux-kernel+bounces-747275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA86B131B8
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 22:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E51C63B6DE5
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 20:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1257A22F383;
	Sun, 27 Jul 2025 20:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="mbkFk88c";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="uxwoLRAM"
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35F31E1A3D
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 20:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753647978; cv=none; b=lW5mmePM8rltfZaA0bFVn2cqX7P9ASSu45YLESbFnPIKC7T2Ob3oO5cStVJPnNOpmu6t542ZprFYn4GiMUD7MTnx523z9OugGXYwkfqBXhHRfbDSw5U3S2kg0AuRbRw/qyK68fbQOo3XAW3Ug6zpfaBim9vT7gqI3nWALzKv7PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753647978; c=relaxed/simple;
	bh=g+hkzzAeyh/Hyrlpjukdpv9zieVKZW1ZP0s851iugFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KZGOEx0dkepBFvRUSrJ4Hp9ngdabBU6QCSfRHE6VFMdqL2c2pMuXQPPHofFXduEFpPum1eqFcf6h3lKpS+bZlBO+RPZnpWglq/9UWQrsvkq883e5dMT8ZTDxkVFrNvaCpHvD8KgJ9iYruCvX0m3oifLQYaeSBEMnuaXjwTlHWLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=mbkFk88c; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=uxwoLRAM; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4bqtRN5Gk2z9scL;
	Sun, 27 Jul 2025 22:26:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1753647968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pVqjetrkruUe9JYviGggH7WtL8pQ7Lddsrbp4Xeri80=;
	b=mbkFk88cUhr8yUpYFnvFyHoRMZwVzFl7ZmlDyWPraJYGpRvaDwc310f/sX/24Gyp2/2T1K
	Z3J8qZ0YgL91XVVsLcec0GWBFln/NwksWx1K9rhAM85867/E/6uyCl2imuu1pKuDNcxvT0
	gy9kGsjY1KF6WFjZ4dRk8y0cmft6S8B1ez6i0w48Ru2HGpj0ABLi3YXij8CV6dyq3W1uIb
	OZ4nR2+uYcRYjSrvY9FGvcSgEIsYt17zEnwZp4XGFQQWrKT1LOFJgq1N2yvVl6GoRPfKiL
	sEBPDLqkIiMoBXcnkyM/Y+zAKTZibEsliGIi0jepWUYS08tvDN8MxQeRIh7YZw==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=uxwoLRAM;
	spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <0d0cd3cb-61e5-4ec6-958b-ec48b82429bf@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1753647966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pVqjetrkruUe9JYviGggH7WtL8pQ7Lddsrbp4Xeri80=;
	b=uxwoLRAMja5/+qIvB5BOrKRros6quYAHEzVx7j14Flhg+xyTOnSP4gDMGAJqhuRUNsczy4
	8n4DfZ+CC2S0RAvKhwZ8GGlqpbFwqkAZurzSp5mI5af95pjWXps1BpQr6NXSdQT1Oxjb4y
	F6cUgzixSf993iszkCTPn9wtqcJswE4WZuFm0SJauDBSX4OvK7AyExdq20PiWMyKZpBPOI
	RY13MtNgTgIoLqCX+AOJzPbHygdV6tM2B5/e8Vz/Nx89iKLQd02+u4jrEuOleMm7+uLYl+
	wW+vQi7h/IrfX8eoDe80EQMm4QiOuoisfQeDBWqZcqsU+PTklWMZugnYfwVqaQ==
Date: Sun, 27 Jul 2025 22:26:04 +0200
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
 <62383ff7-0a14-4f15-818b-f5e5c56332c5@mailbox.org>
 <DBJ86H8MDFNX.2Y6T55E0NH63R@kernel.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <DBJ86H8MDFNX.2Y6T55E0NH63R@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: c7f887b48f46c31999d
X-MBO-RS-META: enizhpo9cnkw6gcodok8afkhzh1januq
X-Rspamd-Queue-Id: 4bqtRN5Gk2z9scL

On 7/23/25 8:36 AM, Michael Walle wrote:
> On Tue Jul 22, 2025 at 4:28 PM CEST, Marek Vasut wrote:
>> On 7/22/25 10:43 AM, Michael Walle wrote:
>>> Hi Marek,
>>
>> Hi,
>>
>>>> --- a/drivers/mtd/spi-nor/winbond.c
>>>> +++ b/drivers/mtd/spi-nor/winbond.c
>>>> @@ -343,6 +343,10 @@ static const struct flash_info
>>>> winbond_nor_parts[] = {
>>>>           .id = SNOR_ID(0xef, 0x80, 0x20),
>>>>           .name = "w25q512nwm",
>>>>           .otp = SNOR_OTP(256, 3, 0x1000, 0x1000),
>>>> +    }, {
>>>> +        /* W77Q51NW */
>>>> +        .id = SNOR_ID(0xef, 0x8a, 0x1a),
>>>> +        .otp = SNOR_OTP(256, 3, 0x1000, 0x1000),
>>>
>>> Did you also test the OTP read and write? I'd guess so, because otherwise
>>> you wouldn't need that entry at all, right? Or is it because of the
>>> winbond_nor_late_init() which will be called as a manufacturer fixup?
>>> In that case we could do the same as in commit afe1ea1344bb ("mtd: spi-nor:
>>> add support for Macronix Octal flash").
>>
>> I have limited supply of these devices, so OTP is untested. The flash
>> does have OTP registers, that's why the .otp entry is there. Why should
>> I remove it if the OTP registers are in the chip ?
> 
> We only add tested features. I'm just the messenger here :o. Anyway,
> OTP is not really one-time-programmable here, you can write and
> erase it again as long as you don't lock it, if that was your
> concern.

So how do I test the OTP without locking it ?

-- 
Best regards,
Marek Vasut

