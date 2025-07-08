Return-Path: <linux-kernel+bounces-721888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BCBAFCF1B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 17:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E1C9189110A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82E92E0B7A;
	Tue,  8 Jul 2025 15:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VWgjcXuR"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E93217722
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 15:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751988346; cv=none; b=baMGIMTWUC/wmBynpP04MZZEXxtU46Qr5mpuFfSbOj2izWWq02ec5hu2fSgACwsorBPG3kNx+Xt4YVP7hwOCHzzu0g3ffMNqVQQ24Cg7X5htlCpsidNxRHBclML5Xvo9pueLntNE3+3UzyZZsZwX19MeS0NW5ZEFEDFnP+wiatc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751988346; c=relaxed/simple;
	bh=nXTQFnvKUQItPlB5dvvKLQqhlM53CgN31QOEKsG8ze4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jfR35DusG5jgkFlC4MTnmtBjgG4WecCFXBvY319CBQSk9gz4O8YRp5H9kfrECzxuLJEJA+JP1PAtoWkkMvXxG4Eiqo76b7s49PgRKXD0hFzUbta0oL+aC1xMbn8rOBOGxZhVhdBlhPa6UgoPV0pBONpy32UBQli3Dvvr+4AKRE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VWgjcXuR; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8248D443F7;
	Tue,  8 Jul 2025 15:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1751988337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bl2mZLAmfC38rN0LPamsmSOKGf0UkHN/P7hgt6AZZ44=;
	b=VWgjcXuR1zJPygqIoVLzx57coaQ92mwk10H7tZzTBL+39Kcba0tsAWA3MNAbuCRK3YfYWo
	73uRwFXpZEr7CyhIBhsAPWlkBoGg9mxz4bOcGe0zlwOraDLJ7Z/mFvTgfs0p1o+Z0bcEdr
	ffbrx56bFhW3C+Sb4bqHBsRAqIuEBt05j6DJ0dbf5immeG4u9EgY/rVXBXuKMNwCz3C1LK
	/N1fa0+YUmpsHb/noNdryaohjCoS/0nP4L4QHHzN/icsxvxP3zwc0krypMs73i6XnDG1+S
	IvRyAgTYb5icDwlKIvSdbihRhYsghBqcacgxsgstCEOAUQ7eAv5CY/HWKyibSw==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH 0/2] drm: fix missing conversions of bridge drivers to
 devm_drm_bridge_alloc()
Date: Tue, 08 Jul 2025 17:24:41 +0200
Message-Id: <20250708-drm-bridge-convert-to-alloc-api-leftovers-v1-0-6285de8c3759@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADk4bWgC/x2N0QrCMAxFf2Xk2UCtzk1/ZfjQtZkGajPSMoSxf
 zf4eO6Be3aopEwVHt0OShtXlmJwPnUQ36G8CDkZg3e+d4MbMekHZ+VkJkrZSBs2wZCzRAwrY6a
 lic0Vb3EkP1yuc093sL9VaeHvvzU9j+MH6OFzm3sAAAA=
X-Change-ID: 20250708-drm-bridge-convert-to-alloc-api-leftovers-6c8e2734b5e9
To: Alain Volmat <alain.volmat@foss.st.com>, 
 Raphael Gallais-Pou <rgallaispou@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, 
 Hui Pu <Hui.Pu@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefhedtfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpefnuhgtrgcuvegvrhgvshholhhiuceolhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfeiteekkefgtdduveeuffeuffevkeehieduhfefvdfhueekuefhhfdttddvkeefnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepkeejrdduvddtrddvudekrddvtdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepkeejrdduvddtrddvudekrddvtdejpdhhvghloheplgduledvrdduieekrddurddufegnpdhmrghilhhfrhhomheplhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudefpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepughrihdquggvvhgvlheslhhishhtshdrfhhrvggvuggvshhkthhophdrohhrghdprhgtphhtthhopefjuhhirdfruhesghgvhhgvrghlthhhtggrrhgvrdgtohhmpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiii
 ihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtoheprghirhhlihgvugesghhmrghilhdrtghomhdprhgtphhtthhopehrghgrlhhlrghishhpohhusehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhdrshiihihprhhofihskhhisehsrghmshhunhhgrdgtohhmpdhrtghpthhtoheplhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomh
X-GND-Sasl: luca.ceresoli@bootlin.com

Most DRM bridge drivers have been converted to devm_drm_bridge_alloc() by
[0], but a few drivers were missed. One got converted by [1], this series
converts all the (known) remaining ones.

Thanks Marek for having found and reported them!

[0] https://lore.kernel.org/all/20250528-drm-bridge-convert-to-alloc-api-v4-1-f04e698c9a77@bootlin.com/
[1] https://lore.kernel.org/all/20250627165652.580798-1-m.szyprowski@samsung.com/

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
Luca Ceresoli (2):
      drm/sti: hdmi: convert to devm_drm_bridge_alloc() API
      drm/sti: hda: convert to devm_drm_bridge_alloc() API

 drivers/gpu/drm/sti/sti_hda.c  | 27 +++++++++++++--------------
 drivers/gpu/drm/sti/sti_hdmi.c | 26 ++++++++++++--------------
 drivers/gpu/drm/sti/sti_hdmi.h |  2 ++
 3 files changed, 27 insertions(+), 28 deletions(-)
---
base-commit: 482c7e296edc0f594e8869a789a40be53c49bd6a
change-id: 20250708-drm-bridge-convert-to-alloc-api-leftovers-6c8e2734b5e9

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


