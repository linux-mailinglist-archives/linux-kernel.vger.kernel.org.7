Return-Path: <linux-kernel+bounces-738551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FBD1B0B9EC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 04:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16D8B1898C1E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 02:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3BF1DB34C;
	Mon, 21 Jul 2025 02:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="W9yrvj3r"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E592212B93;
	Mon, 21 Jul 2025 02:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753063972; cv=none; b=ACuuFOEn3y37LsO4KUJRaeRQ8Kn7B7MMHQlvgOSQvL3UucUBBMQy1CtFkNKkqYffoTbuX3U+mOuoCyKtWR18Oc//roj9psjcDdmDMYIgrUPSq8FtqC3c82Hdv89O+5L7Fqxr5yNRNK9MjHA14ARjt67rU4pHi/+wICKZ3bfrEso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753063972; c=relaxed/simple;
	bh=MlcqU25xyivLsMXTZtxlSWvGq9oUlxagH9zmK9DR4tY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BIFQVUA8nDuuznab1REm15r68ChOmoy7TRLPNmwmFYO23mOu6uM2y23q/6vRmTbLeOYXJgHuZ0s53vBdKouBrngA6bzhOAUzMeSdvKM365tBcEXlMbZYZtOZBPzjs3Zj3MgxMFznu0gc7JtNVmPrb73Rjk8go90ds7hjgmFJskE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=W9yrvj3r; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1753063967;
	bh=FkhA3zlKJ7B2nNbB5q6wEMsFaY29unq8WxRmb9v+A+Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=W9yrvj3r975nfRIB2Azd+aPqn8wG7OJiffxAhFNOUEbpLuLY8iqYshtb/HN45Gwd0
	 PeyzZ2wco4eqZibpbfCk9oA7zZ87jLcjHsiOO4IhvBIWYKRfySqqaG7mX454E0i3So
	 6owCi7NrpqqF+X2FwFSe7Csj/AYMNZuRByqjgGweYiQ/bleoaS87fDIPX/bji5KPI3
	 E83OOpH5vRfyydo0dK3VA5Tu7Ir1QCc9IHQUD5nsw1hE7HIDxRl7mhE2oLupvrNXS7
	 /gHzt7q1vqPpxXR0huEOvlFikQmQyN1z7fXOTabUk6uFAoSi/i/UZvprkWnXA46hHS
	 OMU5GvbOVP58g==
Received: from [127.0.1.1] (unknown [180.150.112.70])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 13F6B640A2;
	Mon, 21 Jul 2025 10:12:45 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
 conor+dt@kernel.org, avifishman70@gmail.com, tali.perry1@gmail.com, 
 joel@jms.id.au, venture@google.com, yuenn@google.com, 
 benjaminfair@google.com, Tomer Maimon <tmaimon77@gmail.com>
Cc: openbmc@lists.ozlabs.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250706153551.2180052-1-tmaimon77@gmail.com>
References: <20250706153551.2180052-1-tmaimon77@gmail.com>
Subject: Re: [PATCH v1] arm64: dts: nuvoton: npcm845: Add pinctrl groups
Message-Id: <175306396590.1248080.10609062611312790046.b4-ty@codeconstruct.com.au>
Date: Mon, 21 Jul 2025 11:42:45 +0930
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Sun, 06 Jul 2025 18:35:51 +0300, Tomer Maimon wrote:
> Add 64 missing pinctrl groups to the NPCM845 device tree source file to
> support additional pinmux configurations defined in the npcm845-pinctrl
> driver.
> 
> This enhances the pinmux configuration for the NPCM845 SoC, enabling
> further hardware pin functionalities.
> 
> [...]

Thanks, I've applied this to be picked up through the BMC tree.

-- 
Andrew Jeffery <andrew@codeconstruct.com.au>


