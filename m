Return-Path: <linux-kernel+bounces-784326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 263B4B339FA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 10:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AED487A160D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 08:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA1229E11D;
	Mon, 25 Aug 2025 08:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="Ova68O9t"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D340628D8CE
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 08:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756112046; cv=none; b=L8wlft3gCK5BJtoHwiLjAOh/h/HsbhiI7IJK7D16wOcxn0kCcY8lkERm/afAVgWOYaPomJV/9Vj5+bQBbcj9dt7LAp0YweY10UfAl7674uwmVsdo1ijoi1OlFQfP3RPvGzCbwLwspWnjGPKc0GKh5aG7sKtKa4qdHT/2Bc8DTZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756112046; c=relaxed/simple;
	bh=m84ECcN0WxtVYyG32AbKesu0Gs/eWeOojmVOVeScXxs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yd4K2G1yB88vx1xnvAX+gTLYUVoH6rY/K/WcLgRwgzryAywU3wRqHEe45ulDMa/481kIPLSdOxzuTh5t9H6in0+COj5AmxuZ/IJaq/E+ZZqMvJzp5y3Py2xE/1FAGWGkuBE2bHPyG0lI19GFT2Xn9M9ncJqip7UoRy7cmTTSyTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=Ova68O9t; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1756112035;
	bh=sOPq0KUHy/zQLje3GwBSgWl+bHBkFOh2egvfb2ycGo8=;
	h=From:To:Cc:Subject:Date:From;
	b=Ova68O9tx5wsT1T5lnawE/wIbds2ux/wGsvhdCqJx0V+doE3+h7RoJ7ZLMIPyDWcQ
	 F79keAPA2U1sQGlUz8pvfjVP0Tf1qQ5cfagVJfBbNcKiIBHJk66655E2aT4dqplmdV
	 5BH93m72ceDJZRKXzw0TwczJxa7rC9+QiCjvpbuo=
Received: from stargazer (unknown [IPv6:2409:874d:200:3037::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 5925D66B28;
	Mon, 25 Aug 2025 04:53:50 -0400 (EDT)
From: Xi Ruoyao <xry111@xry111.site>
To: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Mingcong Bai <jeffbai@aosc.io>,
	dri-devel@lists.freedesktop.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Xi Ruoyao <xry111@xry111.site>,
	Asiacn <710187964@qq.com>
Subject: [PATCH] drm/amd/display/dml2: Guard dml21_map_dc_state_into_dml_display_cfg with DC_FP_START
Date: Mon, 25 Aug 2025 16:52:11 +0800
Message-ID: <20250825085211.34396-1-xry111@xry111.site>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dml21_map_dc_state_into_dml_display_cfg calls (the call is usually
inlined by the compiler) populate_dml21_surface_config_from_plane_state
and populate_dml21_plane_config_from_plane_state which may use FPU.  In
a x86-64 build:

    $ objdump --disassemble=dml21_map_dc_state_into_dml_display_cfg \
    > drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.o |
    > grep %xmm -c
    63

Thus it needs to be guarded with DC_FP_START.  But we must note that the
current code quality of the in-kernel FPU use in AMD dml2 is very much
problematic: we are actually calling DC_FP_START in dml21_wrapper.c
here, and this translation unit is built with CC_FLAGS_FPU.  Strictly
speaking this does not make any sense: with CC_FLAGS_FPU the compiler is
allowed to generate FPU uses anywhere in the translated code, perhaps
out of the DC_FP_START guard.  This problematic pattern also occurs in
at least dml2_wrapper.c, dcn35_fpu.c, and dcn351_fpu.c.  Thus we really
need a careful audit and refactor for the in-kernel FPU uses, and this
patch is simply whacking a mole.  However per the reporter, whacking
this mole is enough to make a 9060XT "just work."

Reported-by: Asiacn <710187964@qq.com>
Link: https://github.com/loongson-community/discussions/issues/102
Tested-by: Asiacn <710187964@qq.com>
Signed-off-by: Xi Ruoyao <xry111@xry111.site>
---
 drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
index 03de3cf06ae5..059ede6ff256 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
@@ -224,7 +224,9 @@ static bool dml21_mode_check_and_programming(const struct dc *in_dc, struct dc_s
 	dml_ctx->config.svp_pstate.callbacks.release_phantom_streams_and_planes(in_dc, context);
 
 	/* Populate stream, plane mappings and other fields in display config. */
+	DC_FP_START();
 	result = dml21_map_dc_state_into_dml_display_cfg(in_dc, context, dml_ctx);
+	DC_FP_END();
 	if (!result)
 		return false;
 
@@ -279,7 +281,9 @@ static bool dml21_check_mode_support(const struct dc *in_dc, struct dc_state *co
 	dml_ctx->config.svp_pstate.callbacks.release_phantom_streams_and_planes(in_dc, context);
 
 	mode_support->dml2_instance = dml_init->dml2_instance;
+	DC_FP_START();
 	dml21_map_dc_state_into_dml_display_cfg(in_dc, context, dml_ctx);
+	DC_FP_END();
 	dml_ctx->v21.mode_programming.dml2_instance->scratch.build_mode_programming_locals.mode_programming_params.programming = dml_ctx->v21.mode_programming.programming;
 	DC_FP_START();
 	is_supported = dml2_check_mode_supported(mode_support);
-- 
2.51.0


