Return-Path: <linux-kernel+bounces-830231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D59B99200
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 11:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B0BC1716A3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 09:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BB72D7D2E;
	Wed, 24 Sep 2025 09:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZCIgqoL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86B428314A;
	Wed, 24 Sep 2025 09:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758706101; cv=none; b=XHJnuiLCbcHRFjx3jXNo65MO4nHuugEeV5bvsjMhx6tuSqJpAqVQ/16V5ahvsvxhZDbv4HmabcX3DOSj/zLNz2IQfOfnWvAkpk0CQT3CsByvwmQEMeXzlp8I7FV6YtHVWxCXtptaVsqOwOWM2phjtdoRn0zQvOgpQvilSvvXUVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758706101; c=relaxed/simple;
	bh=JeezoGPCvEL1Rw85QMPh7l/F/95kWKSx8wcoS1htAp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XqGJ9n2scIXV+01yQ/zfdQOYyCg6MWvkes4zLfaE4OGPI+/gdafwHZaJnDbul7hSS3ocBepACgy+9EiKyX8o98Gj68JvVO2fsQO9PNrwQx0iFJ9Opjfio/92ffuuBmvHX1NPnA/EXc6Otsf8XDx4VyLjb5r4lWRoWtReg24jgds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZCIgqoL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B625C2BCB3;
	Wed, 24 Sep 2025 09:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758706101;
	bh=JeezoGPCvEL1Rw85QMPh7l/F/95kWKSx8wcoS1htAp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NZCIgqoLG1XHzeMxN/G3cqWiZYOdv2EGfdQf2DmDdvBcpt2s+EXpWnG+Q2a6V0SM4
	 PyzfhC/LrR7DQemCzDd3qD/l5IGFu9eIpiqYj9H1bJsJlu7h1QDjfxTFf3D5CBuUEy
	 Qbx7/kHyiVFKpBi+m21BaCfpAbDrTLsto0Y0yUrrh0jcC55cUImiQuwKeOlzvpGbU+
	 cA+//VtNY0fZys9gaG8SzAwyjtuowFy+fqM+2cw6xgjJMEczQZSEn7XcEkcJNHzUI4
	 +rtOgPjC8bGPMVYNIJsKEB3tuBJN5oTkL8pLIQX4SAD1TTEhycOdD9V69azevVcK9u
	 vOb1a1TmgfTqg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v1LnL-000000006p8-1OmT;
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
Subject: [PATCH 1/4] drm/imx/dw-hdmi: drop unused module alias
Date: Wed, 24 Sep 2025 11:26:40 +0200
Message-ID: <20250924092643.26113-2-johan@kernel.org>
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
platform module alias which was incorrectly added by commit 3d1b35a3d9f3
("drm: imx: imx-hdmi: convert imx-hdmi to drm_bridge mode").

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/gpu/drm/imx/ipuv3/dw_hdmi-imx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/imx/ipuv3/dw_hdmi-imx.c b/drivers/gpu/drm/imx/ipuv3/dw_hdmi-imx.c
index 8333c4bf7369..07e5f96202d4 100644
--- a/drivers/gpu/drm/imx/ipuv3/dw_hdmi-imx.c
+++ b/drivers/gpu/drm/imx/ipuv3/dw_hdmi-imx.c
@@ -278,4 +278,3 @@ MODULE_AUTHOR("Andy Yan <andy.yan@rock-chips.com>");
 MODULE_AUTHOR("Yakir Yang <ykk@rock-chips.com>");
 MODULE_DESCRIPTION("IMX6 Specific DW-HDMI Driver Extension");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:dwhdmi-imx");
-- 
2.49.1


