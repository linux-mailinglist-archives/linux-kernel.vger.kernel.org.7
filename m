Return-Path: <linux-kernel+bounces-739275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 891A5B0C43B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 14:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB12B162DF7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 12:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0612D3EED;
	Mon, 21 Jul 2025 12:41:17 +0000 (UTC)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF742D0C8C;
	Mon, 21 Jul 2025 12:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753101676; cv=none; b=OOcvB9Ldd8ABDtaFRpfKGx8mECFr4URJP3qsZ6LbKRYzRqUB8fB90WDcTCVT7mrJqlGvT2idrYgCZjNNFhXnSRM4FkqQ0B6bAffgyAbxTweRBkZZBM9HBEtHnIayPKqZsjQv0jy8O4i2iEMe/RlVmWtM+08WjeHFB3nhTdLak68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753101676; c=relaxed/simple;
	bh=HKypV4u1z7AQtKEV8qXfKdvAJq3j2oYfgAV7NWh5XKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=muKcMFs4kYRRWSmMeB6etviw0q3e+yDIIe5jvHIseUa+aHePUnGf9VgdPXwel6HhhLwoJ0MMEfDyo4t5Ot3OGgj6CiFfFL8iKQIG0qt4NPEixniJML7Zbnx6PNWwXlzWbYHjOVM5xKwL8FTsFXzdDiBIIJYOMkdXgkqtUN3KQGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foursemi.com; spf=pass smtp.mailfrom=foursemi.com; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foursemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foursemi.com
X-QQ-mid: zesmtpsz2t1753101613t8c8f9366
X-QQ-Originating-IP: MoVW0Qm5NMBWEz3uPCzh4xqGQRVxpVf/CTDZ4DOFxxU=
Received: from localhost ( [113.89.235.49])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 21 Jul 2025 20:40:12 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5610268674547387337
EX-QQ-RecipientCnt: 14
Date: Mon, 21 Jul 2025 20:40:02 +0800
From: Nick Li <nick.li@foursemi.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: lgirdwood@gmail.com, broonie@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, perex@perex.cz,
	tiwai@suse.com, xiaoming.yang@foursemi.com,
	danyang.zheng@foursemi.com, like.xy@foxmail.com,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] ASoC: dt-bindings: Add FS2104/5S audio amplifiers
Message-ID: <0D06FAB8CF1A9D4C+aH41IrERxjlsEAPr@foursemi.com>
References: <20250721103805.531758-1-nick.li@foursemi.com>
 <20250721103805.531758-3-nick.li@foursemi.com>
 <83f7c489-7001-49cd-97a5-4280eba95fe0@kernel.org>
 <F04DD98A69286426+aH4sT_P0GvttoCOq@foursemi.com>
 <ea2f30ff-b2cf-4b88-9fe8-78950a03d882@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ea2f30ff-b2cf-4b88-9fe8-78950a03d882@kernel.org>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:foursemi.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: N0fHFfxtkpsjEWs3A0xBuJ3MCCGLm1f5F5Y/t4u4jUD0ofASZGMC5o4P
	oJmZo2RQQTTTZUMaEJub+Y/fDMxP9XQuQ5sxiL8MCSjjDoUd+ci60S2Rb58BmbYWmQw1ILz
	EUUBXzkTLWHzd79MPqg7PJ9ykQ1j2QT+p/3WQCK6Q0YOmzkj9APbCwQekZ/Dyl2oCKfuOED
	x0sq70ybB9JJtqI+NqwMdoo6yaMzPXDLuvawAYmcaW3XThfXx+DATJyY1s56gHfiS1yxXK1
	X++kyhMERdDHSIY8wWN6+0QyjqJAqungWaRlIsArJJrX6UDEiCjnz3t+sYj1hf54MzrzTTp
	tWTCpYuGuXQFSA0QWfLPtXuStoFZb5N7I/GmTxZFuwnzy+0flPsxfJ/1N9YCSXuzM0MZGDq
	fH9Qb2DYJ/mBgZvQR3A9KAuuD48TcFSkFLUShKnL3ZcugPIh53soSkTs86EAcg2vFXPlH8i
	j6du9YaJRv8Ip6gHXt+3ED2XsrULDRXYL7Escw/OmwkEbOOi4qvPRfSJSt9+juLjT5RtecA
	jACJPeUL7tKszRHEZP26aGtRQN2o0BRlfWCQG8k8PVBx6+khxkZS/U67lOtU8C0A9NR8Ymq
	JQbdaG+TvAByKeD2Jmt8m7gqoUgfvTNWhDm2hmExfM9/eWtG3potHx0Dg7OSumb0yuWHTS2
	BvhUQCjxLrihq19+cpZQVRY6ishZRn0hWwfXXwxY5ZB+jveLg1UrG+jWcCUT7U30UlLQvOt
	93k1Ef27buYU2J3mjaz0HMOBCNXzpQptgXMYWVDQHYTS1fEE0iv0IdGR3umXSzliyrgHy2T
	RKM+AGFFA2PexWe+uQdjThf3ysW+ok3kGDxwKHgnpI96wVg6w9EtaZE2uh9QB7D90XnJBXl
	+kydeWZovTPP1Hr2tVqGkx3N5lYQZiJ3bn54OodH+luUXqz3DELWarmNNRaJ4g1SO3ZOF1j
	5kLxhobshWGyOXBlA3vSzrU5P6obBmrYDisKc0OZJjZoueQH2DURy7YNVOY//X8zka93unx
	DPegShYFk0IO6QEeVwkPK4Gt35oiAmMqRTDd+f+d0waUK3a/Vs
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

On Mon, Jul 21, 2025 at 02:15:38PM +0200, Krzysztof Kozlowski wrote:
> On 21/07/2025 14:02, Nick Li wrote:
> > On Mon, Jul 21, 2025 at 12:48:24PM +0200, Krzysztof Kozlowski wrote:
> >> On 21/07/2025 12:38, Nick wrote:
> >>> +  firmware-name:
> >>> +    maxItems: 1
> >>> +    description: |
> >>> +      The firmware(*.bin) contains:
> >>> +      a. Register initialization settings
> >>> +      b. DSP effect parameters
> >>> +      c. Multi-scene sound effect configurations(optional)
> >>> +      It's gernerated by FourSemi's tuning tool.
> >>> +
> >>> +required:
> >>> +  - compatible
> >>> +  - reg
> >>> +  - '#sound-dai-cells'
> >>> +  - reset-gpios
> >>> +  - firmware-name
> >>
> >>
> >> I do not see how you resolved my comment from v1 or v2. Nothing in the
> >> changelog explains that either.
> > 
> > Change logs are in the cover letter:
> 
> 
> And as I said I do not see resolution of my comment.
> 
> If you reject reviewers comment, usually it should be mentioned in the
> changelog.
> 
> Otherwise you get now the same review as v1 or v2. Devices cannot work
> without power.

I explained it in the previous email:
The power may be connected to the baterry/adapter directly,
it may not be under the control of the software,
in this case, the supplies are use as dummy regulators?

And we tested the driver without the supplies in DTS,
so I didn't mark the supplies as the required items.

Best regards,
Nick

> 
> Best regards,
> Krzysztof
> 

