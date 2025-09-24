Return-Path: <linux-kernel+bounces-830233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC4EB9920C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 11:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39DD27B0A55
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 09:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5603A2D7DD2;
	Wed, 24 Sep 2025 09:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AsoYN5EK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87E52882A7;
	Wed, 24 Sep 2025 09:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758706101; cv=none; b=u61tHdTn0Q1aH8zO3/a4TJicm6nSvZtk/re/j3nX9gYFuUBq6bppyviQ6HejA2U1UCMX2IuGnc9j7CZPeee1eH4YQtrgvr57NUQ1lw1UegRuT5T+RMm6X8pmzpAbkKlYnIz/Sulc42o5BwC5hhhd0pjbzCfdjBnDtpep7wZmMfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758706101; c=relaxed/simple;
	bh=aucfxwIehpz3q4PmJQg0bLLpC3j4Jr0IJwNGf6IB8sA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WX1SG/R9sebM+WiHYIreybkrC8+Q531lwDnKYJoRNbsduBINZu7tj8rIscRyXJFKaT7AaFWiNWXpAitnLqn3YMD57O0t7ZC42JS3SwK2b/8IPogJ90Ht+sDxjutSMtCSHYOp76Tdf0n7QIXgEM3NcsMRhISWe3pOxR5jH097m9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AsoYN5EK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D4C9C4AF11;
	Wed, 24 Sep 2025 09:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758706101;
	bh=aucfxwIehpz3q4PmJQg0bLLpC3j4Jr0IJwNGf6IB8sA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AsoYN5EKLNNjjqGHGVI0LET75KTXf7vK2x4ZiDwghs/Q0TvRPaqNOcFzYfdz4JGnq
	 eFKQhJuem8zDXU+gffIIS2Y3FcQPNxvOfGp/1r5uvIuZqr6rC9H/PpNSFqhUg8sJJZ
	 +i4F5SNaf8xbXcetzipLAUXOqvOe6P2/UlM3AigK6ZfD0T2cXWjbaM/7Emw9ViNejd
	 ZVqrtVhQhhTTNojrsPfjxuX7e6OBLjRzRiayWiqsOIYtC+UOFiVfZArVa1vIezxsRv
	 UgUTLg06CDWKbH5cShaq9MINsrzdkLQlGv7k8M+LYk3t+PcTH3EPyNcxY1qmkYSFc+
	 NqIqE/BnBSskg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v1LnL-000000006pA-1m2t;
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
Subject: [PATCH 2/4] drm/imx/ldb: drop unused module alias
Date: Wed, 24 Sep 2025 11:26:41 +0200
Message-ID: <20250924092643.26113-3-johan@kernel.org>
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
platform module alias incorrectly added by commit bc627387a951
("imx-drm: imx-ldb: Add MODULE_ALIAS()").

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/gpu/drm/imx/ipuv3/imx-ldb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/imx/ipuv3/imx-ldb.c b/drivers/gpu/drm/imx/ipuv3/imx-ldb.c
index 6be7a57ad03d..626d410d9150 100644
--- a/drivers/gpu/drm/imx/ipuv3/imx-ldb.c
+++ b/drivers/gpu/drm/imx/ipuv3/imx-ldb.c
@@ -644,4 +644,3 @@ module_platform_driver(imx_ldb_driver);
 MODULE_DESCRIPTION("i.MX LVDS driver");
 MODULE_AUTHOR("Sascha Hauer, Pengutronix");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:" DRIVER_NAME);
-- 
2.49.1


