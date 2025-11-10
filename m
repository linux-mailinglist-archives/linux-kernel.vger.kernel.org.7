Return-Path: <linux-kernel+bounces-893458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B348EC477AA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EC2194F30D3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA47B32936E;
	Mon, 10 Nov 2025 15:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lskziJm4"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EEC316907
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 15:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762787394; cv=none; b=lh6SKW/wQRzS9LtoqbdKa384tzhbdHaslLigPqP2PnRRYGSTVYUacLvrkmbYa/SCOf/BKvsAPB1u1mmFLNKDgP7frmdPC34LuCsVdvqGKO0RCCTPUqDLhmJB43C3UdVa1RJ6ULmrQ754F/QUP89XXh3xyRMASsfcBEY+kbhF9GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762787394; c=relaxed/simple;
	bh=+JH0U6qbOEUnfDwDCRyU4gFFN4nN8oHEOuAlz98T2R4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qVlaw46qgg6Z1azu8gMW4XloRbo1hbDxmUrppMwZQnN5ZakNrXTxiSNI9/WLB4qrSlp+dKvKFGELroHH+oHTwM0LjVC2KEgiXWw4mu4xxeoHE/beI7I3+L06bageucEIFSp1GPopW5ZG6NnYO/zIF09Mqc4Gn5D4tSC+y702wMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lskziJm4; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 823DA4E41601;
	Mon, 10 Nov 2025 15:09:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 579BC606F5;
	Mon, 10 Nov 2025 15:09:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A8E9E103718D6;
	Mon, 10 Nov 2025 16:09:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762787388; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=ITk2tlVBaQjDuhVGmfM1Ssxn9cijCmVpO1LtokiUxJs=;
	b=lskziJm4fsclu4FaTekH9dxP/2NHPq+nAMrvdOXguQraaRFoAwSqtgwmOubO74gBVU5OHj
	Qe0zqm9bh4y2vxPGkvIGH0lLofxzvCPwQMqY6LtqUdY2LNSGJ98oMHdxK6fnZ50IMbswwb
	MFzyhoUVbWVr89lmYUJy9FPARXJlTkpOB5eYV3ZPhqXyQyYNnPfXrMLbcvOZbHZxZkN5ah
	jN+RiAB8sKmWMSdXDPWG3Cs4gDMVHbtdkK/kdbqE1FGDLAEcKWTbzvdFEgAm7hW4bWHOPZ
	sDXHrkEtgF4gNgugvaUp9AWJQv96RwXwLv4vhKcqh2DC0KMGwmq28MP7rUnKbQ==
Message-ID: <7cf0f824-2ebc-4e67-9f26-5a1f0ad4c8ac@bootlin.com>
Date: Mon, 10 Nov 2025 16:09:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/2] firmware: ti_sci: add BOARDCFG_MANAGED mode
 support
To: Nishanth Menon <nm@ti.com>
Cc: Tero Kristo <kristo@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>,
 Gregory CLEMENT <gregory.clement@bootlin.com>, richard.genoud@bootlin.com,
 Udit Kumar <u-kumar1@ti.com>, Prasanth Mantena <p-mantena@ti.com>,
 Abhash Kumar <a-kumar2@ti.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251017-ti-sci-jacinto-s2r-restore-irq-v1-0-34d4339d247a@bootlin.com>
 <20251017-ti-sci-jacinto-s2r-restore-irq-v1-1-34d4339d247a@bootlin.com>
 <20251107114116.f2laylu5yziueyia@budget>
Content-Language: en-US
From: Thomas Richard <thomas.richard@bootlin.com>
In-Reply-To: <20251107114116.f2laylu5yziueyia@budget>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hello Nishanth,

Thanks for the review.

On 11/7/25 12:41 PM, Nishanth Menon wrote:
> On 16:44-20251017, Thomas Richard (TI.com) wrote:
>> In BOARDCFG_MANAGED mode, the low power mode configuration is done
>> statically for the DM via the boardcfg. Constraints are not supported, and
>> prepare_sleep() is not needed.
> 
> Will be good to get pointed to some documentation around this..

I agree, but for now there is no public documentation. Once it is
available, I'll update the commit message.

Best Regards,
Thomas


