Return-Path: <linux-kernel+bounces-776861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05900B2D244
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 05:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B49A4621929
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 03:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA55F23643E;
	Wed, 20 Aug 2025 03:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="PO/0gJEu"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2C91C3BFC;
	Wed, 20 Aug 2025 03:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755659217; cv=none; b=jAeLCF3x9lVGmbXWA6JAEP3QDjMjOLYZ1sqQonKI74Lwx3jkQszEgYFkdGyscJ44hoPzeSc/R4lzMR7DjrIeMRm5zKKWBbLBOBThSkyh0IRKMi83DCwpBd+GsSsss7AVdGtFzUEL/6w8bAts2YbeW5LL1RrpuhzUKaLTknn9MXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755659217; c=relaxed/simple;
	bh=DPt7Pi+L7phcHIMxqL+fgF1oO1Wovx0g/uTdqllSL6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fUxPpgubuN9R/+Hbm6VOCgG9p6aWsvzy51GgGF364j+Ub1ch7NhleU0Ic0sgYDmleey4XCXqk3DNfF8+0O+XeOY1J3cvnIVnCU75BvShNEv3Jo87vekv88TpUV0muMimKC2UUs6P+6zSZsyj4pVjOYaUmUsjUf3WyxysOYiMVbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=PO/0gJEu; arc=none smtp.client-ip=1.95.21.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=2RofOJEfn1P9mwF+4wr1q1ngNmkqmQURn9mwJjYoVRs=;
	b=PO/0gJEuI/g09HqkDHc1OzLiqd/rrnJawcn/rOV2MiA/sZyBeblvSORzIOo8D5
	VgAZPcKtlkgBTaDTE+Ip/bs06N0QDUbe5e0d385HyKmJDogo5U1lXOlLH4rQH2iQ
	6deyueT9LN2/p8m33dLryWar/O0t4qWTmjHIED9SygDxo=
Received: from dragon (unknown [])
	by gzsmtp3 (Coremail) with SMTP id M88vCgDnBYuVO6Vodyb4Ag--.56412S3;
	Wed, 20 Aug 2025 11:05:59 +0800 (CST)
Date: Wed, 20 Aug 2025 11:05:57 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: =?iso-8859-1?B?Q3Pza+Fz?= Bence <csokas.bence@prolan.hu>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@karo-electronics.de>
Subject: Re: [PATCH v2] ARM: dts: imx6-karo: Replace license text comment
 with SPDX identifier
Message-ID: <aKU7leerEAZHf4Qr@dragon>
References: <20250703-karo-dts-lic-v2-1-329f4c55913e@prolan.hu>
 <0fdab5ac-604b-46fd-bd25-cfa7afd06f98@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0fdab5ac-604b-46fd-bd25-cfa7afd06f98@prolan.hu>
X-CM-TRANSID:M88vCgDnBYuVO6Vodyb4Ag--.56412S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrKr15Kr1xCrWfGry5WrW5GFg_yoWDKrgE9F
	4xuwsxCw15KF4I9F4fGryavasrKFy8XF47XwsYvF9xZ3ZrGryDXFs5WwnYvrn8W3yfZ3Zr
	CFy5X34DCwnFgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU86wZ3UUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiNxh43WilO5j6owAA39

On Thu, Aug 07, 2025 at 04:46:26PM +0200, CsÛk·s Bence wrote:
> Hi,
> 
> On 2025. 07. 03. 11:09, Bence CsÛk·s wrote:
> > Replace verbatim license text with a `SPDX-License-Identifier`
> > 
> > The comment header mis-attributes this license to be "X11", but the
> > license text does not include the last line "Except as contained in this
> > notice, the name of the X Consortium shall not be used in advertising or
> > otherwise to promote the sale, use or other dealings in this Software
> > without prior written authorization from the X Consortium.". Therefore,
> > this license is actually equivalent to the SPDX "MIT" license (confirmed
> > by text diffing).
> > 
> > Cc: Lothar Waﬂmann <LW@KARO-electronics.de>
> > Acked-By: Lothar Waﬂmann <LW@KARO-electronics.de>
> > Signed-off-by: Bence CsÛk·s <csokas.bence@prolan.hu>
> > ---
> > Changes in v2:
> > - fix message tags and typos
> > - collect Lothar's Ack
> 
> So, what do you think, is this patch acceptable now this way?

Hmm, I applied it [1], didn't I?

Shawn

https://lore.kernel.org/all/aGuOO36kkTWtM2yy@dragon/


