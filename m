Return-Path: <linux-kernel+bounces-720279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B837AFB987
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 19:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59C32424466
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 17:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C31E2E8E00;
	Mon,  7 Jul 2025 17:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Xfptt2Oz"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6932E7F20
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 17:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751907910; cv=none; b=nLUVlHbYXQ66JpUlY6Lw24CCdoQ8Iqy3hW7MdUzVxkvDXOPi2NJYWV9apIwMHG08rGq3zyRNW1TaEiBnQOgM8shheI7+EqkrWfGI8qR3sq0vtrmGUxC4yn0OjPQ/HKxAIQG0oVUT3MSrOSEAvKtaxiizC2m7JEXdVQyh30DUGmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751907910; c=relaxed/simple;
	bh=9A/8qRN3N5EQ/idueTkzfofxl+ak2m/9E8a9eLvVQf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S1ohwckNqh+lORr3/RGiDpucxABSgskXFsp0NGVXO+MWniJgpLsbOXNV7AtnqBAyA5HrsdalP64dujIl+VMyterBwpigu87wYUv6LI97m08RDdClsf2HLYVS2ZSwVbaL+oP9Td+cMMb2lOBJLOt0yu9f88H+lZkjFAC+IpPMnRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Xfptt2Oz; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1751907906;
	bh=9A/8qRN3N5EQ/idueTkzfofxl+ak2m/9E8a9eLvVQf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xfptt2Ozmxd3hEOz3iPMnAdT2OgLJ67BhOzhLVH1DaZHv4cY93DBHb9MuYx719idr
	 bTNOpCFUG6QcvKMkxIS3TFCYdFkL3GpiSn168zCoXHnHhft96WEDHo9qo+UaNVWco7
	 7bc3ZzwfoDOxBBwyMtu8HqRJNtV3OrSUm/cSbtTsGNBU0p1+cxJ/NlhnaXJIfdavBH
	 WVgkw2pf9OXaFEvvpAF7mHMmrJHz6NmnS8SOct2sRzCBzj/xVCNdCMNae6Kzt1F0r5
	 9doJGxlJaEPVGG01YzvvNaCnQiy3v2r7gqHzvzk4xwDICDS5Ia/zeWj6mtkc0rZx7h
	 fz0DbgSM2wTtA==
Received: from debian-rockchip-rock5b-rk3588.. (unknown [90.168.160.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nanokatze)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3C59C17E046D;
	Mon,  7 Jul 2025 19:05:05 +0200 (CEST)
From: Caterina Shablia <caterina.shablia@collabora.com>
To: "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
	"Maxime Ripard" <mripard@kernel.org>,
	"Thomas Zimmermann" <tzimmermann@suse.de>,
	"David Airlie" <airlied@gmail.com>,
	"Simona Vetter" <simona@ffwll.ch>,
	"Frank Binns" <frank.binns@imgtec.com>,
	"Matt Coster" <matt.coster@imgtec.com>,
	"Karol Herbst" <kherbst@redhat.com>,
	"Lyude Paul" <lyude@redhat.com>,
	"Danilo Krummrich" <dakr@kernel.org>,
	"Boris Brezillon" <boris.brezillon@collabora.com>,
	"Steven Price" <steven.price@arm.com>,
	"Liviu Dudau" <liviu.dudau@arm.com>,
	"Lucas De Marchi" <lucas.demarchi@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	"Rodrigo Vivi" <rodrigo.vivi@intel.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	nouveau@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	asahi@lists.linux.dev,
	Asahi Lina <lina@asahilina.net>,
	Caterina Shablia <caterina.shablia@collabora.com>
Subject: [PATCH v4 4/7] drm/gpuvm: Add a helper to check if two VA can be merged
Date: Mon,  7 Jul 2025 17:04:30 +0000
Message-ID: <20250707170442.1437009-5-caterina.shablia@collabora.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250707170442.1437009-1-caterina.shablia@collabora.com>
References: <20250707170442.1437009-1-caterina.shablia@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Boris Brezillon <boris.brezillon@collabora.com>

We are going to add flags/properties that will impact the VA merging
ability. Instead of sprinkling tests all over the place in
__drm_gpuvm_sm_map(), let's add a helper aggregating all these checks
can call it for every existing VA we walk through in the
__drm_gpuvm_sm_map() loop.

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Caterina Shablia <caterina.shablia@collabora.com>
---
 drivers/gpu/drm/drm_gpuvm.c | 47 +++++++++++++++++++++++++++++--------
 1 file changed, 37 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpuvm.c b/drivers/gpu/drm/drm_gpuvm.c
index 05978c5c38b1..dc3c2f906400 100644
--- a/drivers/gpu/drm/drm_gpuvm.c
+++ b/drivers/gpu/drm/drm_gpuvm.c
@@ -2098,12 +2098,48 @@ op_unmap_cb(const struct drm_gpuvm_ops *fn, void *priv,
 	return fn->sm_step_unmap(&op, priv);
 }
 
+static bool can_merge(struct drm_gpuvm *gpuvm, const struct drm_gpuva *a,
+		      const struct drm_gpuva *b)
+{
+	/* Only GEM-based mappings can be merged, and they must point to
+	 * the same GEM object.
+	 */
+	if (a->gem.obj != b->gem.obj || !a->gem.obj)
+		return false;
+
+	/* Let's keep things simple for now and force all flags to match. */
+	if (a->flags != b->flags)
+		return false;
+
+	/* Order VAs for the rest of the checks. */
+	if (a->va.addr > b->va.addr)
+		swap(a, b);
+
+	/* We assume the caller already checked that VAs overlap or are
+	 * contiguous.
+	 */
+	if (drm_WARN_ON(gpuvm->drm, b->va.addr > a->va.addr + a->va.range))
+		return false;
+
+	/* We intentionally ignore u64 underflows because all we care about
+	 * here is whether the VA diff matches the GEM offset diff.
+	 */
+	return b->va.addr - a->va.addr == b->gem.offset - a->gem.offset;
+}
+
 static int
 __drm_gpuvm_sm_map(struct drm_gpuvm *gpuvm,
 		   const struct drm_gpuvm_ops *ops, void *priv,
 		   const struct drm_gpuvm_map_req *req)
 {
 	struct drm_gpuva *va, *next;
+	struct drm_gpuva reqva = {
+		.va.addr = req->va.addr,
+		.va.range = req->va.range,
+		.gem.offset = req->gem.offset,
+		.gem.obj = req->gem.obj,
+		.flags = req->flags,
+	};
 	u64 req_end = req->va.addr + req->va.range;
 	int ret;
 
@@ -2116,12 +2152,9 @@ __drm_gpuvm_sm_map(struct drm_gpuvm *gpuvm,
 		u64 addr = va->va.addr;
 		u64 range = va->va.range;
 		u64 end = addr + range;
-		bool merge = !!va->gem.obj;
+		bool merge = can_merge(gpuvm, va, &reqva);
 
 		if (addr == req->va.addr) {
-			merge &= obj == req->gem.obj &&
-				 offset == req->gem.offset;
-
 			if (end == req_end) {
 				ret = op_unmap_cb(ops, priv, va, merge);
 				if (ret)
@@ -2163,8 +2196,6 @@ __drm_gpuvm_sm_map(struct drm_gpuvm *gpuvm,
 			};
 			struct drm_gpuva_op_unmap u = { .va = va };
 
-			merge &= obj == req->gem.obj &&
-				 offset + ls_range == req->gem.offset;
 			u.keep = merge;
 
 			if (end == req_end) {
@@ -2196,10 +2227,6 @@ __drm_gpuvm_sm_map(struct drm_gpuvm *gpuvm,
 				break;
 			}
 		} else if (addr > req->va.addr) {
-			merge &= obj == req->gem.obj &&
-				 offset == req->gem.offset +
-					   (addr - req->va.addr);
-
 			if (end == req_end) {
 				ret = op_unmap_cb(ops, priv, va, merge);
 				if (ret)
-- 
2.47.2


