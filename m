Return-Path: <linux-kernel+bounces-748871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B92B146FB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 05:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66D343A9C5F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 03:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5092248AC;
	Tue, 29 Jul 2025 03:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="rzGUbzf1"
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE06223DF1
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 03:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753761128; cv=none; b=YcH0+GdfS1nx2Dtl+I23WUaGopLLhb7gS2pT+A253b2eMQAMmJu9dS+2ZMjRqCervgCF7yl2l7uySwUImzqJ2j+a0V7pFSHSx+IZI7WMQPVdHt5ra7aPDyF202e9dDgvxlK51l7TpRiN6P0n2MJe2kixVf1BDq8bjb2sfCzki30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753761128; c=relaxed/simple;
	bh=KvG7kkbZ3iXse0Fzh4VrJ1ay91aHsCKq34iQ+8zkVuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bWqms8QNhApE5ZcuqhsvYtk0btyHtOmb1hERw/JLtTVBiagN4LBm9Hm0aS1tWJU/c2Vx4x/k3aN8HanrlemFB+lfK7JNeqNi5QcCJCeAbEnRZ4PuhlcCjv6N9V4YsTSLBq1ibhGcFYGfjg7f5nX6gSfMJg1bBAYD9AkfxrAZajw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=rzGUbzf1; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4brhHK40CNz9tYZ;
	Tue, 29 Jul 2025 05:51:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1753761117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/mrZr0k1CH1wBQQfdXAImWXil90dxRbLtJqXjKs7gYI=;
	b=rzGUbzf1QNkYSJ+O4AXWqnJoWe1NR7WsIsgvkSGDKBDjZdp5NNId59nAGx4LYudZxAGHvu
	VNvNUg+JH5jrGUFHDPaRLCVKCM3TLYMY3/FKkiAP6AZWlHWfsdZvKJRwLDakr1lI2vP+H9
	nZy3pI5XAWLrd2ITilDowrcsMkuR1v4ggSZQQkRWuRkTs7aeqcGsiX6c2gaDpuPj5QjWEi
	m+XD7FigCaIGUkhxH/CZ0jIKoJqGK5rCWFrjS6LQGN/H6bSOEnz5iy2qEKesb2J9PbOIYD
	Y1AubsLwLpK3p7mI1Gh0hvsDTpojC6DGziC6S4CgO0wzn2YC4I//vKtomMgQBA==
Message-ID: <d592e97a-fad2-4269-b854-d3e82d985035@mailbox.org>
Date: Tue, 29 Jul 2025 05:51:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] mtd: spi-nor: winbond: Add support for W77Q51NW
To: Michael Walle <mwalle@kernel.org>
Cc: linux-mtd@lists.infradead.org, Miquel Raynal <miquel.raynal@bootlin.com>,
 Pratyush Yadav <pratyush@kernel.org>, Richard Weinberger <richard@nod.at>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org
References: <20250721202257.83936-1-marek.vasut+renesas@mailbox.org>
 <9eabfe619554cbdd493086dcffef8f44@kernel.org>
 <62383ff7-0a14-4f15-818b-f5e5c56332c5@mailbox.org>
 <DBJ86H8MDFNX.2Y6T55E0NH63R@kernel.org>
 <0d0cd3cb-61e5-4ec6-958b-ec48b82429bf@mailbox.org>
 <DBNH88949QTH.3I3MSOA019UJL@kernel.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <DBNH88949QTH.3I3MSOA019UJL@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: k9gc1ikgent8pos756noof5a6xn5qegr
X-MBO-RS-ID: 9cb17900f721a6b5267

On 7/28/25 8:32 AM, Michael Walle wrote:
>>>> I have limited supply of these devices, so OTP is untested. The flash
>>>> does have OTP registers, that's why the .otp entry is there. Why should
>>>> I remove it if the OTP registers are in the chip ?
>>>
>>> We only add tested features. I'm just the messenger here :o. Anyway,
>>> OTP is not really one-time-programmable here, you can write and
>>> erase it again as long as you don't lock it, if that was your
>>> concern.
>>
>> So how do I test the OTP without locking it ?
> 
> flash_otp_{write,info,dump,erase}, just don't use flash_otp_lock.

Thanks. flash_otp_dump -u /dev/mtd0 returns zeroes, so I suspect the OTP 
is not working. The chip does work even without this entry and the 
content /sys/kernel/debug/spi-nor/spi0.0/capabilities and 
/sys/kernel/debug/spi-nor/spi0.0/params did not change, so I think the 
best way forward is to drop this patch, until I can figure out the OTP 
on this chip ?

-- 
Best regards,
Marek Vasut

