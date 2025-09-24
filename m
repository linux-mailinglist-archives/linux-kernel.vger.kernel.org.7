Return-Path: <linux-kernel+bounces-830234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02672B99212
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 11:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9B3E188E159
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 09:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85AA12D8364;
	Wed, 24 Sep 2025 09:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AR9/Vmic"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3212D6E68;
	Wed, 24 Sep 2025 09:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758706102; cv=none; b=qynN3eBM7Pzsa0vRqsXLB/cBAvEWp4uS1fAJcxhj42dujYAc7bi9+ULDcwRE/2NpdqFxJu7Bfae6/y1aeOuwCyx+1l5r2i4aS4nUeFr6yaQ3B7wV103nPkH3nx41sjRNgLISRCopAsoMCikPEr+Tjs5IzjNrPnyX0g1CWZWVH3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758706102; c=relaxed/simple;
	bh=M/22n/6VII/Xvb7W0QVWWWhFM7cAUQ/uL17SmklK980=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EVhnzprhovRbdQZ35GynUoPi7sP/zEvPk7ftC/3By4AKT9nQAQm6r/TRFeXOjkK1oTOpFF7WNOiebpbVJ0n0p1PC3IKTHShIaAqTXYaVX5DuqIeRZfhU1NgexPEEZiarqRgaMTY+N65FrHwqz43+0zofmOQXWqjIvIpzKFvnbfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AR9/Vmic; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9067C2BCB5;
	Wed, 24 Sep 2025 09:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758706101;
	bh=M/22n/6VII/Xvb7W0QVWWWhFM7cAUQ/uL17SmklK980=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AR9/Vmicgn8Avcc/XvVw2pvj+J8QkwvFPBqcC+Le3e64dx5bcmKSwOwteglA+Alhl
	 LEdRD+/u/7VfwlqHTuJxLSs8hLm8f9RWm/Td+K5dPdK0ECFcI9okQTJ/sgINL+ONRy
	 JAFeuHxgcmcEWh93cMS0T3wRm4MGzZatRh3Ve0UZCwEZ6lJCHgQHeX4qpnxg4DuU0l
	 jKT4DmChWUSREksPJL/nJQbYRPGj80VU3BdAKpJhGrTzyeBmLP65K0yHkmUhntKGeE
	 WVZZHboRSr62mUhK3gnm+SyDkt5C8R3t+9P0m2TEgkGbElop6I+05nq+KwzIHmFy5K
	 u59afh1IZhurQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v1LnL-000000006pC-26OE;
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
Subject: [PATCH 3/4] drm/imx/tve: drop unused module alias
Date: Wed, 24 Sep 2025 11:26:42 +0200
Message-ID: <20250924092643.26113-4-johan@kernel.org>
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

The driver has never supported anything but OF probe so drop the
unused platform module alias incorrectly added by commit 52db752c3de5
("imx-drm: imx-tve: Add MODULE_ALIAS()").

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/gpu/drm/imx/ipuv3/imx-tve.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/imx/ipuv3/imx-tve.c b/drivers/gpu/drm/imx/ipuv3/imx-tve.c
index 895413d26113..31d93f59abe0 100644
--- a/drivers/gpu/drm/imx/ipuv3/imx-tve.c
+++ b/drivers/gpu/drm/imx/ipuv3/imx-tve.c
@@ -686,4 +686,3 @@ module_platform_driver(imx_tve_driver);
 MODULE_DESCRIPTION("i.MX Television Encoder driver");
 MODULE_AUTHOR("Philipp Zabel, Pengutronix");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:imx-tve");
-- 
2.49.1


