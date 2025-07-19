Return-Path: <linux-kernel+bounces-737725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63191B0AFD1
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 14:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E37531AA744B
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 12:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCE1286425;
	Sat, 19 Jul 2025 12:20:40 +0000 (UTC)
Received: from srv01.abscue.de (abscue.de [89.58.28.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AA2285C99;
	Sat, 19 Jul 2025 12:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.28.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752927640; cv=none; b=Xst0Z+bzlBxYxxcqrGqs7EmT8OV0R78TUhOd391zrz/s/iscneUkFzp13+7bzm4awssGff6HT+jxBeYG2Na7hM1h9gHXN9Vc9E93sCjiF92Y3z76QRq++QlBWcq7Lox/LCFQTDEu2TmXjlPEy7ZTODrpnIeTVf/j0kVbhJse+Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752927640; c=relaxed/simple;
	bh=7zQVZxclqEAxO9auvvhhb/M0VjFV62I5c4EKcIGwF90=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RHgd9UGgUZTttvL8DVCNUBw+MuYbn2xiwJQtzbXWEEmz8uCcTF8DE+ENRXOQ5X0BnpUBuyyVkjDXk9yEdG4LBs3/s2gx0LmPgqo0icZlx+hKZKDEn/e97I5BCXtTm5NSLoXzzMMFZDYHjFhY54xAXuOtCF9/ZgqW2UE56pppEmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de; spf=pass smtp.mailfrom=abscue.de; arc=none smtp.client-ip=89.58.28.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=abscue.de
Received: from srv01.abscue.de (localhost [127.0.0.1])
	by spamfilter.srv.local (Postfix) with ESMTP id 8FB2C1C067F;
	Sat, 19 Jul 2025 14:11:30 +0200 (CEST)
X-Spam-Level: 
Received: from fluffy-mammal.metal.fwg-cag.de (unknown [IPv6:2001:9e8:cdf7:4000:ceae:3606:9020:cd4f])
	by srv01.abscue.de (Postfix) with ESMTPSA id F10F21C0680;
	Sat, 19 Jul 2025 14:11:29 +0200 (CEST)
From: =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Date: Sat, 19 Jul 2025 14:09:40 +0200
Subject: [PATCH 04/12] drm: sprd: remove plane and crtc destroy callbacks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250719-ums9230-drm-v1-4-e4344a05eb3d@abscue.de>
References: <20250719-ums9230-drm-v1-0-e4344a05eb3d@abscue.de>
In-Reply-To: <20250719-ums9230-drm-v1-0-e4344a05eb3d@abscue.de>
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, Kevin Tang <kevin.tang@unisoc.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
X-Mailer: b4 0.14.2

These callbacks are now required to be NULL and trigger a runtime
warning if they are present.

Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
---
 drivers/gpu/drm/sprd/sprd_dpu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/sprd/sprd_dpu.c b/drivers/gpu/drm/sprd/sprd_dpu.c
index a3447622a33cd612e34be038e833222567bdcd2c..0d9eb778794d92418b39f8535d94abde3566de43 100644
--- a/drivers/gpu/drm/sprd/sprd_dpu.c
+++ b/drivers/gpu/drm/sprd/sprd_dpu.c
@@ -577,7 +577,6 @@ static const struct drm_plane_helper_funcs sprd_plane_helper_funcs = {
 static const struct drm_plane_funcs sprd_plane_funcs = {
 	.update_plane = drm_atomic_helper_update_plane,
 	.disable_plane	= drm_atomic_helper_disable_plane,
-	.destroy = drm_plane_cleanup,
 	.reset = drm_atomic_helper_plane_reset,
 	.atomic_duplicate_state = drm_atomic_helper_plane_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_plane_destroy_state,
@@ -704,7 +703,6 @@ static const struct drm_crtc_helper_funcs sprd_crtc_helper_funcs = {
 };
 
 static const struct drm_crtc_funcs sprd_crtc_funcs = {
-	.destroy	= drm_crtc_cleanup,
 	.set_config	= drm_atomic_helper_set_config,
 	.page_flip	= drm_atomic_helper_page_flip,
 	.reset		= drm_atomic_helper_crtc_reset,

-- 
2.50.0

