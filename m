Return-Path: <linux-kernel+bounces-596425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B799BA82BCD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Apr 2025 18:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 264FC4A2502
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Apr 2025 15:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E47E2690F0;
	Wed,  9 Apr 2025 15:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="aRkaHkll"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF73F267B9F
	for <linux-kernel@vger.kernel.org>; Wed,  9 Apr 2025 15:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744214230; cv=none; b=LjLh8HV7SxMiACDGAfJZGKC4RsstyGvlU4ugz3okAntFXE9mVRz+YvxkTyxJYIKi4dEQwKWMnt9EQwkLv6cyrnJcj+mMXWFtNBqSKkMw7XN/jor6nLRlWJXQFyEM8G1xrKMUbrjSNRIPiWPdCOV9TSh341HQN3H//2HzYHQhFZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744214230; c=relaxed/simple;
	bh=o5Ss/7SRTUHdQRRvriDzXrgvhGE29l/1IqKebEKZmZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X4I6/Oz1fXupa62iCwge8J6546qvH1ow+O/lebHuNJl8nFz2Tu/h1ub4Y5vpjxS4wq5JVXMglYLFiY2YtBxDRw1vX4qLEdwj1GAtAOrRN9SGr13/SrpCVnrT9+o6HYL4yPbDUw0bo/y/ZJ7Ic0FsWmGn2MILklE6aORH16UUzB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=aRkaHkll; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=pq+avEanNTE2ylz89cC98GhRgY4JbA8jvhBnU/hKhDg=; b=aRkaHkll0OvdZRwkWzxq6DOO0T
	XH/MzIcIcYv+GXrVOrvwq2FuyAVdtVPInUe5JNqDqpGTGjycY6NaEhixHFV0pwX0wbhjVKicJr3ks
	ogEN8MKFhxFNxhFxD/y9jkzztkej8cN+g6ceDJsSwUi0KmWoK8qLg/Q8/fvuumVQwVQuiYs7mgL+c
	MDUAEy0vyYUK3CSQyFxV5OJybrQMKlcW8/hX8G4JwndjicUUik+ZR7XEkwuTB+fy7APE9XAV6bw8v
	Bmo0BdBdOJkSX01Mm0VCsjVDVJK2FqayhXkkU2aZA4C0yiKlTZByGhgWLrC7Ks0vJfaedmVgVIZKi
	Tk8U6hnA==;
Received: from [77.26.4.178] (helo=edoras.jupiter)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1u2XnP-00ECwp-4e; Wed, 09 Apr 2025 17:56:59 +0200
From: Jose Maria Casanova Crespo <jmcasanova@igalia.com>
To: Melissa Wen <mwen@igalia.com>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: Jose Maria Casanova Crespo <jmcasanova@igalia.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm/v3d: client ranges from axi_ids are different with V3D 7.1
Date: Wed,  9 Apr 2025 17:55:04 +0200
Message-ID: <20250409155504.1093400-3-jmcasanova@igalia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250409155504.1093400-2-jmcasanova@igalia.com>
References: <20250409155504.1093400-2-jmcasanova@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The client mask has been reduced from 8 bits on V3D 4.1 to 7 bits
on V3d 7.1, so the ranges for each client are not compatible.

A new CSD client can now report MMU errors on 7.1

Signed-off-by: Jose Maria Casanova Crespo <jmcasanova@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_irq.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/v3d/v3d_irq.c b/drivers/gpu/drm/v3d/v3d_irq.c
index 1810743ea7b8..0cc1c7e5b412 100644
--- a/drivers/gpu/drm/v3d/v3d_irq.c
+++ b/drivers/gpu/drm/v3d/v3d_irq.c
@@ -199,12 +199,31 @@ v3d_hub_irq(int irq, void *arg)
 			{0xA0, 0xA1, "TFU"},
 			{0xC0, 0xE0, "MMU"},
 			{0xE0, 0xE1, "GMP"},
+		}, v3d71_axi_ids[] = {
+			{0x00, 0x30, "L2T"},
+			{0x30, 0x38, "CLE"},
+			{0x38, 0x39, "PTB"},
+			{0x39, 0x3A, "PSE"},
+			{0x3A, 0x3B, "CSD"},
+			{0x40, 0x60, "TLB"},
+			{0x60, 0x70, "MMU"},
+			{0x7C, 0x7E, "TFU"},
+			{0x7F, 0x80, "GMP"},
 		};
 		const char *client = "?";
 
 		V3D_WRITE(V3D_MMU_CTL, V3D_READ(V3D_MMU_CTL));
 
-		if (v3d->ver >= V3D_GEN_41) {
+		if (v3d->ver >= V3D_GEN_71) {
+			axi_id = axi_id & 0x7F;
+			for (size_t i = 0; i < ARRAY_SIZE(v3d71_axi_ids); i++) {
+				if (axi_id >= v3d71_axi_ids[i].begin &&
+				    axi_id < v3d71_axi_ids[i].end) {
+					client = v3d71_axi_ids[i].client;
+					break;
+				}
+			}
+		} else if (v3d->ver >= V3D_GEN_41) {
 			axi_id = axi_id & 0xFF;
 			for (size_t i = 0; i < ARRAY_SIZE(v3d41_axi_ids); i++) {
 				if (axi_id >= v3d41_axi_ids[i].begin &&
-- 
2.49.0


