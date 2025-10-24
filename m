Return-Path: <linux-kernel+bounces-868272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CD631C04BF3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4D3354E869A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 07:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B8E2E6CC3;
	Fri, 24 Oct 2025 07:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="pkQwZ1F+"
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4227E2E62DC
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 07:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761291381; cv=none; b=KNrdKngW/Kq6fVs6/M1f3cpslmGbtVm9vrqXS3OKdhFFrFFw8EpyWQICLj1gBGjQ27LTgb7UXQo4Bmjio3CQ7LUQvuMu8pEw+Lpp1SLuFdY9Lb6F3eQyZPvajy6dUP1A2fpTUzqibMyT7HuEeM1nw5f5XPSy4euVo0PEgrdwRFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761291381; c=relaxed/simple;
	bh=rLP68hBHDs+g38XppufkPkGcCa8JJ3oaI9MbKiPiD7M=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=PEKQueXJqIDrEwMgksyNrEeBT+Hxp53eL8VT4rooqe4GHJQKhkKcKyS0dCG8ZFwTpNOeriQI2DHFWaTnRZDOkCz52iNgCr4eVkmK1N5GYLnZ8D/tQ9LWxZoS4kpUEMqa+l+W+eshMxRjx/O1aKY/dFT6/YwLlXVeo69TAeXtqF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=pkQwZ1F+; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1761291368; bh=ADOIOMbXPgRYUiwWuCKOoBk0K2INBLNj7OFpUvxFPJk=;
	h=From:To:Cc:Subject:Date;
	b=pkQwZ1F+XdWFlXZAaoh/Ob3KexDWMF66WkM+eY631w/A1H2Yxuv71Eep2ePi6hT5G
	 WgtOVkcTDRQis/Yiy9B8wPCzjMhcA9dpDRmp6ly+AVTGAT6dn4gUlHN76LdVfAr3bF
	 fnj8gnoPsudw4o1DlAIgk2ROOdhBW13JGXOBnQQU=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id 77992C6A; Fri, 24 Oct 2025 15:29:57 +0800
X-QQ-mid: xmsmtpt1761290997te50iyx90
Message-ID: <tencent_2F3D865C2D4C1960CBBE360187953F0B6907@qq.com>
X-QQ-XMAILINFO: N/WmRbclY25GDTLo9mBrt7giouVYEdlQC294tLu56K28Z88M4+3osnpIvPp61s
	 OBm12cyVboC/KSP4R9F0W5mkj1jE9R+OOhYoaxwWu6kiMrlf49toVXK/gLNAdPQnC9+S2SDTZw4E
	 aqUjMLKHdzm5AKnx959O6A7rgxdWBI+ja9NRLIz7EzaoXS5uKUfOYU45nzigl3Q5Fu6/bBybfmdZ
	 iPd2VXFsUUiuFMqWBYkuS1VZ94N0EvbOP3X3AHh3987+NDmolb/MOoqnNb40RyUw9wrwtgThosFR
	 9WyHwogqJt7g6vdq9v+Vl2lFUzMo9EegVxFuTdwZkOF0ck/ZYUJkNAY1BmEbpIRcXGzkHqcMCh8/
	 7ZMCQ98A0be5Fz76vhWpmm+FwKAW1+CmShPtU6ncIXZriraq2Wo0Wtv9EZV+0AbFxL7Or/fEw/1b
	 zLvSsqrpLINhjMCZswpQF79E3ZtWY97nPsaw7AJTAudRbjQfVtQDUSS84ibz9GjD2wF4j1ow1GFY
	 j71OlZtN/JafhK2JehW2EOba6HvSiecZ+ij8PmDCgSKSZ5ERVCGllfY6PpR4Mi+uuDeAwpIUlUz+
	 kh5itUYi8kFi1m83WUr22/tksdpZg2HCiJ6kRW51JX/GTsXRC+uCjJ+X81yw9euG3sr98hPJh9N5
	 qSgl0a8YfQkiEXrkX0EkuGrd8nljYw3m0dmMo5u9gDuCNQGyuN4MuEhFSKsE2kVYnZZ+Z/mPLCqd
	 CpFZG+63C8nA1ahMNFpq7tKI67pY+1ZuKi0or+YGhHB13824c9MITyGnnEmVo3opYkDFBpKjD8xP
	 LKFw7i0l0+1rFjnuJhRm0pTAVUdGl6eixuQi++j1bfYHo28UMThrAFFm6VWxhuwCMdDwmTrz7uax
	 jSmaFCDS163PNAwIh7NjTbcEO3KnCoxid96GU5NYLbsNYXTDbHEI7TcrFLoaMd0xOuCptsSD+OMH
	 wB9osTKX0w/yLMANBThwPbiWQvM7ck/DuHVLmsxuVtUz526Wd2hvfTZOQPaPND0Qpm3do9FgZ2CF
	 fgj4UofsBGEApAAZK99x5qv+eVf8TSKjbJ1swRj35hOP3kwfeL
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: 724364708@qq.com
To: harry.wentland@amd.com,
	sunpeng.li@amd.com,
	siqueira@igalia.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Lu Yao <yaolu@kylinos.cn>
Subject: [PATCH] drm/amd/display: fix audio playing speed up on POLARIS12
Date: Fri, 24 Oct 2025 15:29:56 +0800
X-OQ-MSGID: <20251024072956.137133-1-724364708@qq.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lu Yao <yaolu@kylinos.cn>

Playing audio/video will speed up when color space is NV12.
For POLARIS12, audio request clock has to be same as
'stream->timing.pix_clk_100hz', so double clock now for it
has been halved in the 'get_pixel_clock_parameters' function.

Signed-off-by: Lu Yao <yaolu@kylinos.cn>
---
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c  | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)
---
Test environment:
  Card: RX550  device id: 0X699F
  Display mode: 4K@60 clock:59400

A similar issue was reported in the community a long time ago,
but it was not dealt with, link as follow:
https://gitlab.freedesktop.org/drm/amd/-/issues/556

Discovered through logs audio_output requested&calculated is half
of stream->timing.pix_clk_100hz before, so I double it.
I'm not sure if this patch modification has correctly solved the
root cause and whether all DCE_VERSION_11_2 have problem or POLARIS12
only, but it's working properly on my machine now.
---

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 24184b4eb352..a93313248db3 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1440,13 +1440,21 @@ void build_audio_output(
 
 /*for HDMI, audio ACR is with deep color ratio factor*/
 	if (dc_is_hdmi_tmds_signal(pipe_ctx->stream->signal) &&
-		audio_output->crtc_info.requested_pixel_clock_100Hz ==
-				(stream->timing.pix_clk_100hz)) {
-		if (pipe_ctx->stream_res.pix_clk_params.pixel_encoding == PIXEL_ENCODING_YCBCR420) {
+		pipe_ctx->stream_res.pix_clk_params.pixel_encoding == PIXEL_ENCODING_YCBCR420) {
+		struct hw_asic_id asic_id = stream->link->ctx->asic_id;
+
+		if (asic_id.chip_family == FAMILY_VI &&
+		    ASIC_REV_IS_POLARIS12_V(asic_id.hw_internal_rev)) {
+			audio_output->crtc_info.requested_pixel_clock_100Hz =
+				audio_output->crtc_info.requested_pixel_clock_100Hz*2;
+			audio_output->crtc_info.calculated_pixel_clock_100Hz =
+				pipe_ctx->stream_res.pix_clk_params.requested_pix_clk_100hz*2;
+		} else if (audio_output->crtc_info.requested_pixel_clock_100Hz ==
+			   (stream->timing.pix_clk_100hz)) {
 			audio_output->crtc_info.requested_pixel_clock_100Hz =
-					audio_output->crtc_info.requested_pixel_clock_100Hz/2;
+				audio_output->crtc_info.requested_pixel_clock_100Hz/2;
 			audio_output->crtc_info.calculated_pixel_clock_100Hz =
-					pipe_ctx->stream_res.pix_clk_params.requested_pix_clk_100hz/2;
+				pipe_ctx->stream_res.pix_clk_params.requested_pix_clk_100hz/2;
 
 		}
 	}
-- 
2.25.1


