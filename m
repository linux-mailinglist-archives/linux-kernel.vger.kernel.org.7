Return-Path: <linux-kernel+bounces-723190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C44EAFE434
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 11:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BDA61C428FB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 09:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3BA286405;
	Wed,  9 Jul 2025 09:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PRPHFLaW"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB444286436
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 09:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752053775; cv=none; b=dIniJ6boQz55xopyUvXLghAPISm7/TKMyWLC88y5yTvM463Fx/lCGBIxAEfIZX1CqPtPHrp4xSSn59RUDBcDCpQQc8UnVSLEVzYCymxRUNSGSCFH73+QKzfiOzaIChdbZip1Z4BdalKeB+g21ot+VrrXRGnX+T9cSg4ayvgGppI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752053775; c=relaxed/simple;
	bh=qoC8mBUPXJlvycmPEeH/hJsdO3AXdL8gTotWhRMQZ3o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tk0cQZaLYN/yN2vCihlgLZLw5kvvooRJwI4oHRnDr6el/f6k2OsP3sKbh2KdVc3wQvdhOS7zqM1foJOk7/i78UKQBLY/akDNWTUEUtyB+oQDSfYUHU9MpF08cZ94qlJjjHFYr3O58vDm/Uhtw3U1gVaUt3o2+zS3vbq4gXIDAec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PRPHFLaW; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A0A1843B03;
	Wed,  9 Jul 2025 09:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1752053766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u+cBjBYyyBi0/gtpArpSyfc0KxCmCFk4ds45njMdkn0=;
	b=PRPHFLaWVQnOdkOb0rgpHBn/DpTm1LOkTLIkZvigf/VPCC4PIci5y6vmhAlpbiIAc4cOIE
	RtZicIH36/IE+8F52qCtecU2NftEZdKEVY6jcQCZt32FeX90fXpOecLZtDN6NAqD6jheMo
	41eGElNo0AjpvuFhpZYPgSBuXeEtKO8E6JOqyk4B7Mp+mYROWtBFXLgHrd6cdlICvCG6K8
	IXq0Cq7RNM7Y9danVIFywOsCQOYUhm2qTwWQ0PcNcs934aWGEhdsJshCA6wPfxy9iD+p3Y
	ClnaQdT8VBRUP1S4kWZ6ZSXVaOiMk82qmroDLjOi1hfvcpwVIjacih75mpiMhw==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Alain Volmat <alain.volmat@foss.st.com>, 
 Raphael Gallais-Pou <rgallaispou@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, 
 Hui Pu <Hui.Pu@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250708-drm-bridge-convert-to-alloc-api-leftovers-v1-0-6285de8c3759@bootlin.com>
References: <20250708-drm-bridge-convert-to-alloc-api-leftovers-v1-0-6285de8c3759@bootlin.com>
Subject: Re: [PATCH 0/2] drm: fix missing conversions of bridge drivers to
 devm_drm_bridge_alloc()
Message-Id: <175205374260.60140.13824257782987722025.b4-ty@bootlin.com>
Date: Wed, 09 Jul 2025 11:35:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefjedvudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvegjfhfukfffgggtgffosehtjeertdertdejnecuhfhrohhmpefnuhgtrgcuvegvrhgvshholhhiuceolhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepheelkefglefhhfegudegtdfgueegffegleehheekvdduiefhfeeftdeihfektdetnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepkeejrdduvddtrddvudekrddvtdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepkeejrdduvddtrddvudekrddvtdejpdhhvghloheplgduledvrdduieekrddurddvtdelngdpmhgrihhlfhhrohhmpehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedufedprhgtphhtthhopegrihhrlhhivggusehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhdrshiihihprhhofihskhhisehsrghmshhunhhgrdgtohhmpdhrtghpthhtohepughrihdquggvvhgvlheslhhishhtshdrfhhrvggvuggvshhkthhophdrohhrghdprhgtphhtthhopehluhgtrgdrtggvrhgvshholhhisegsohhothhli
 hhnrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrrghrthgvnhdrlhgrnhhkhhhorhhstheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehrghgrlhhlrghishhpohhusehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhm
X-GND-Sasl: luca.ceresoli@bootlin.com


On Tue, 08 Jul 2025 17:24:41 +0200, Luca Ceresoli wrote:
> Most DRM bridge drivers have been converted to devm_drm_bridge_alloc() by
> [0], but a few drivers were missed. One got converted by [1], this series
> converts all the (known) remaining ones.
> 
> Thanks Marek for having found and reported them!
> 
> [0] https://lore.kernel.org/all/20250528-drm-bridge-convert-to-alloc-api-v4-1-f04e698c9a77@bootlin.com/
> [1] https://lore.kernel.org/all/20250627165652.580798-1-m.szyprowski@samsung.com/
> 
> [...]

Applied, thanks!

[1/2] drm/sti: hdmi: convert to devm_drm_bridge_alloc() API
      commit: ac4531424d907f3983e919a7bda2b90ea0cede4f
[2/2] drm/sti: hda: convert to devm_drm_bridge_alloc() API
      commit: 602d565d3c10dfb2dfd397f65078cb603a26a513

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


