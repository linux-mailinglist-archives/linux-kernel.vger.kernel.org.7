Return-Path: <linux-kernel+bounces-830235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFF3B9920D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 11:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6EDB170271
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 09:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857D42D0C6F;
	Wed, 24 Sep 2025 09:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TMpUya35"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD39F2D6E69;
	Wed, 24 Sep 2025 09:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758706102; cv=none; b=UtLh6o84H0A8KQwKSgOKpdWezYzJFiW9r7rJj2/J/CgAT2A8HPKIf3D3BbGK7SnwQQHbyTtV7tPe5OnbwKvjbu0V02qVn3gudUzv4emkYRys9vaELKTF9OVrJWnvk8q/IvrKTHRWTec8STw0vFh3vjEUl9g51crJGrzWopQqCCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758706102; c=relaxed/simple;
	bh=LjEZsu/eRN6Oc2WFJua8KrGaq3Ac5hB3lBQxT0YFGr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jNZOm0AxhEPCLW6FGDF5Pb0BgOi3/w+Phmunux4Sbp2LaCEZS1cO4XPXAArzhU7gVfh7n23GmW5fnXgYI2HU8MS8DtxNEi7sxDfCc+YelkQ7yVi+ipQn0jEUFRUFxlvcsmc1mbHNtZHNTVv5oUlGuezWuv3QmarjtkGs6fpd57Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TMpUya35; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B90A8C2BCB8;
	Wed, 24 Sep 2025 09:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758706101;
	bh=LjEZsu/eRN6Oc2WFJua8KrGaq3Ac5hB3lBQxT0YFGr0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TMpUya35NhDTWF7mbMjNWQQqW3N0pzPrB2gSmhinHpi2ocrNXnjX2f3YaYFqsoiXc
	 ahF2Wlvp0am8TI70w7hDTsPuECDiwVvXjhn+Fa12NApwVuoJqoyrcFcU6h33MrwKSy
	 WWt3ysvpl8vqxz9wXSao37d2q/nxsCs7Aj3tBId2jm+FYpGL1/r9ywgnxp2Ld4la/a
	 9bPZd8GxiWDzKvPraMKPgSLkwrM9MVSKC+Nl5D23lXwUbVE8/eqzczPqgpVIrq2StP
	 dgq8/S0WFmzQkWiVRPiheQNKCac6OgNEQFaSHXJOPKEroMK0rGgrjtFFLQiN7TCIcD
	 x4SNSNFCkd52Q==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v1LnL-000000006pE-2Qg0;
	Wed, 24 Sep 2025 11:28:15 +0200
From: Johan Hovold <johan@kernel.org>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	dri-devel@lists.freedesktop.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 4/4] drm/imx/parallel-display: drop unused module alias
Date: Wed, 24 Sep 2025 11:26:43 +0200
Message-ID: <20250924092643.26113-5-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20250924092643.26113-1-johan@kernel.org>
References: <20250924092643.26113-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver has never supported anything but OF probe so drop the unused
platform module alias incorrectly added by commit b2da05ff4797
("imx-drm: parallel-display: Add MODULE_ALIAS()")

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/gpu/drm/imx/ipuv3/parallel-display.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/imx/ipuv3/parallel-display.c b/drivers/gpu/drm/imx/ipuv3/parallel-display.c
index 6d8325c76697..f2f36f425664 100644
--- a/drivers/gpu/drm/imx/ipuv3/parallel-display.c
+++ b/drivers/gpu/drm/imx/ipuv3/parallel-display.c
@@ -286,4 +286,3 @@ module_platform_driver(imx_pd_driver);
 MODULE_DESCRIPTION("i.MX parallel display driver");
 MODULE_AUTHOR("Sascha Hauer, Pengutronix");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:imx-parallel-display");
-- 
2.49.1


