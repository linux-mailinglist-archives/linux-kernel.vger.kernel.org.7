Return-Path: <linux-kernel+bounces-789156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B094B391C1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 04:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4869E7A5F39
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 02:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF5325BEF8;
	Thu, 28 Aug 2025 02:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="bTcnjlE8"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9681A9FB8
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 02:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756348531; cv=pass; b=qPAzsTXTRRi9PuZyfw9CEMlqaZZn2aG+CMBgyBKW0JwCdmP6sgIePHqc+PjD70IRlPucFmpVXfU++P6RaXvpM/EvUpIS+c5cfdf6FHUPoN8WVG2UdRZyNz6+ameRnUFE+0j8kmOkrwIGmrl7xTmAf++P09VlqPth8YTgi38vPjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756348531; c=relaxed/simple;
	bh=UvqG/wxG+NEmQwSW6r12yp/QSCvRu3NXYTi/7nGBl4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MeCeSNh15et/YDCLpBtr8TcTEMsLegNk/s+DlsTPfhBhUGsruJTdQPIbpoj69nOytrwFQtj2FFs35lmKIrR9Xcxhdb1Vgf3kzrbKhSY5rLEIfCKrk5wc0zdgvYIPOw8g8+dN7eInkViIDozc7Ij7VWnRpt1Y2dzEumBaGVQxp7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=bTcnjlE8; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1756348507; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=e0Lu09OCUP0WgVr3n31YDq1NfZNRaecwMWSEzhgLPihmfsWTeX685rU46DfyPnyxQxTz7TkS6PivZFzgStS319pfvceSmq/c/ezhJ0+p2F8JGduZGuQZa+F9OvlqFOnAXI7Q9gmjHMvDlw2RcdI1ZD3nx8PYSFLdJ3dP+kUFrkM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756348507; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=/XgZbXaaDAt51tRo1gxaJmYurANtM3wU1qrejFSnDxA=; 
	b=k4sjsNxwOHAjmkkum/3wBlb/jQX2KlI9B0KHOrI0Hk7pSbANUal/XLJXH3/EvJfFG4q03XyYUxNuMxY6BUHvYxDCvLqaqfht3YPYgwQEN+HTsKWO/7vV84BqYh3JwgToUJqqREEtpUCDYVPkVSRtamVftZG5v34WPAx79+pnv2Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756348507;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=/XgZbXaaDAt51tRo1gxaJmYurANtM3wU1qrejFSnDxA=;
	b=bTcnjlE8tUy6GWMO/O66nMnoLl+f2QPNUx9hZTlOiGlzUUMZ50i1pSalo2YgpfBl
	lKOFjuIT3TzEg9zkfTgcwWuymGQAWkmjVhuSVsfal/iPaVcU3ZqzWW4whqAvuUgEXFX
	fgKDNgqz2tmKmt7WUik8TChswjKkK3ccQvo3FEFg=
Received: by mx.zohomail.com with SMTPS id 1756348505762628.2176497594086;
	Wed, 27 Aug 2025 19:35:05 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
	Boris Brezillon <boris.brezillon@collabora.com>,
	kernel@collabora.com,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Subject: [PATCH 1/5] drm/panfrost: Add job slot register defs for affinity
Date: Thu, 28 Aug 2025 03:34:04 +0100
Message-ID: <20250828023422.2404784-2-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250828023422.2404784-1-adrian.larumbe@collabora.com>
References: <20250828023422.2404784-1-adrian.larumbe@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Boris Brezillon <boris.brezillon@collabora.com>

This will let us set the affinity (L2 caches and tiler units that can
process a job) in future commits.

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_regs.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_regs.h b/drivers/gpu/drm/panfrost/panfrost_regs.h
index 2b8f1617b836..a63cd65b344a 100644
--- a/drivers/gpu/drm/panfrost/panfrost_regs.h
+++ b/drivers/gpu/drm/panfrost/panfrost_regs.h
@@ -253,6 +253,7 @@
 #define JS_AFFINITY_NEXT_LO(n)		(JS_BASE + ((n) * JS_SLOT_STRIDE) + 0x50)
 #define JS_AFFINITY_NEXT_HI(n)		(JS_BASE + ((n) * JS_SLOT_STRIDE) + 0x54)
 #define JS_CONFIG_NEXT(n)		(JS_BASE + ((n) * JS_SLOT_STRIDE) + 0x58)
+#define JS_XAFFINITY_NEXT(n)		(JS_BASE + ((n) * JS_SLOT_STRIDE) + 0x5c)
 #define JS_COMMAND_NEXT(n)		(JS_BASE + ((n) * JS_SLOT_STRIDE) + 0x60)
 #define JS_FLUSH_ID_NEXT(n)		(JS_BASE + ((n) * JS_SLOT_STRIDE) + 0x70)
 
@@ -267,6 +268,11 @@
 #define JS_CONFIG_DISABLE_DESCRIPTOR_WR_BK	BIT(15)
 #define JS_CONFIG_THREAD_PRI(n)			((n) << 16)
 
+/* Possible values of JS_XAFFINITY and JS_XAFFINITY_NEXT registers */
+#define JS_XAFFINITY_ENABLE		BIT(0)
+#define JS_XAFFINITY_TILER_MASK(x)	(((u32)(x) & GENMASK(7, 0)) << 8)
+#define JS_XAFFINITY_L2_MASK(x)		(((u32)(x) & GENMASK(15, 0)) << 16)
+
 #define JS_COMMAND_NOP			0x00
 #define JS_COMMAND_START		0x01
 #define JS_COMMAND_SOFT_STOP		0x02	/* Gently stop processing a job chain */
-- 
2.50.0


