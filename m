Return-Path: <linux-kernel+bounces-811275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5750B526E6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 05:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 818037B7683
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 03:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C208C236453;
	Thu, 11 Sep 2025 03:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b="mFG5U2Z0"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B7022578A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 03:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757560139; cv=none; b=f4xzBbmQgqxP6TbvyncNQZlS0q9kqYeflqNzINQq1CUCZ1ERc2hQ4Qf5WyfMPIhgbwriy4rNNLSrHnktiYWA7v6YAALmVwlvksfzJwpN8T7ETzR8DXreZiwovyF+81fCabXYgUhLdNYw48ggnQ1GdsnFkV2D3oqjiutBgDnmmD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757560139; c=relaxed/simple;
	bh=+RcLhsoO/K9y6z8m+RK4oedOFC1Mb+ZaaErRQoKGEhs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jJxmKXgDV2dOP/raIPvdprzgn6He7FaoWKNxVu/3YozUVHSzGONCyEXjBv7USS/Im58ImGxUK5MxD0HvVyKn/eRbwLq6GKLsQu8idnoFb2BZjj01r1rHSb0YaZcUnrZ4H/y3lbEsL51u+u0mnSwSQv4LdjVOM689fAkNf0SP44k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org; spf=pass smtp.mailfrom=postmarketos.org; dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b=mFG5U2Z0; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=postmarketos.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1757560125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uTRi5Fe4/Iqo8ogK1qtB7HVlQSF3x2QH7rPlF7FRJ9w=;
	b=mFG5U2Z0PZrz/5l08C4xhiUfw50J5yrRXt6ZipICmPt1vKv/JDzIhbkzgG0lmqCJ/u+/rg
	iSQ22cfi/c7y9nm1FkqGxA3BN70KB9nkWEgcBjVeWrs0GVmNHZYpB3C9+P22a/I0H564zx
	dTilknziMzmQCncfTkJnIVtVLPvqhasROmf21u8bqmfouLhInn2jOuEOZJd10dZqpUNEyi
	Cr4xaITbcpGme4L3fBkCMXZR4lo/jDF8bhg4hFgZPPlMyvNMYEyHvZPNA077KDjktQXUcK
	fSsYtuFkEcqhzoHE0GJNwlFKNhlgS5Vk/a3trY3XNoaRNEbN0bWA9pXdecsx8A==
From: Paul Sajna <sajattack@postmarketos.org>
Subject: [PATCH 0/3] Add LG SW49410 Panel Driver
Date: Wed, 10 Sep 2025 20:08:19 -0700
Message-Id: <20250910-judyln-panel-v1-0-825c74403bbb@postmarketos.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACM9wmgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDS0MD3azSlMqcPN2CxLzUHF1LE4s0Q3PzZFMgVAJqKShKTcusABsXHVt
 bCwCn++QRXgAAAA==
X-Change-ID: 20250910-judyln-panel-948f177c5c5c
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, David Heidelberg <david@ixit.cz>, 
 Amir Dahan <system64fumo@protonmail.com>, 
 Paul Sajna <sajattack@postmarketos.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757560120; l=1433;
 i=sajattack@postmarketos.org; s=20250422; h=from:subject:message-id;
 bh=+RcLhsoO/K9y6z8m+RK4oedOFC1Mb+ZaaErRQoKGEhs=;
 b=kcob6K3fKDqG2x/qWf3XSwpVVmG/evfJ40nEFOT08DoBi4ggz4X36C0XNE5MR26llySYZGF1r
 iaYhWglp4DcDOSLXSKBJZf5SYsnF5SHItlk0hHkG7dDRdo/TxYpSRZG
X-Developer-Key: i=sajattack@postmarketos.org; a=ed25519;
 pk=TwacvEOiRJ2P2oAdEqIDrtQTL18QS4FfcHfP/zNsxkQ=
X-Migadu-Flow: FLOW_OUT

This patch series adds a drm panel driver for the LG SW49410 panel found
in the LG G7 ThinQ (codename judyln).

The basic driver skeleton was generated by https://github.com/msm8916-mainline/linux-mdss-dsi-panel-driver-generator
from the vendor device-tree.

Comments were added explaining magic numbers, and devicetree
documentation was also added

Once this patch has been accepted, I'll follow up with
a devicetree update for sdm845-lg-judyln
that includes this driver, along with several other improvements

Co-authored-by: Amir Dahan <system64fumo@protonmail.com>
Signed-off-by: Amir Dahan <system64fumo@protonmail.com>
Signed-off-by: Paul Sajna <sajattack@postmarketos.org>
---
Amir Dahan (1):
      drm/panel: Add LG SW49410 Panel

Paul Sajna (2):
      dt-bindings: display: panel: Add devicetree documentation for lg,sw49410
      Update MAINTAINERS for lg,sw49410

 .../bindings/display/panel/lg,sw49410.yaml         |  66 +++
 MAINTAINERS                                        |   6 +
 drivers/gpu/drm/panel/Kconfig                      |  14 +
 drivers/gpu/drm/panel/Makefile                     |   1 +
 drivers/gpu/drm/panel/panel-lg-sw49410.c           | 513 +++++++++++++++++++++
 5 files changed, 600 insertions(+)
---
base-commit: e04c78d86a9699d136910cfc0bdcf01087e3267e
change-id: 20250910-judyln-panel-948f177c5c5c

Best regards,
-- 
Paul Sajna <sajattack@postmarketos.org>


