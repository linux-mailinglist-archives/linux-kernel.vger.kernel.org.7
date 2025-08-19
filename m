Return-Path: <linux-kernel+bounces-776500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 662A5B2CE30
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 22:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 117181B676E3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 20:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C535342CA2;
	Tue, 19 Aug 2025 20:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b="h2fwKtog"
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEB2341AC5
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 20:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755636153; cv=none; b=sRMj14vID35o1LWrpWjufdSsXil0j/ucm/HtzS8F+0tXj7WoSB5i0FsWEtqX9+HnAYiayifnWABAbsO4+mChJp6HYpWNfDWfiPntjUkdBpfHQ4q0zHw6W8Al+mADYFsuoonPinGcIBN1UzR0b4PruN3t3RcOkA8DQM3JOsvmDqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755636153; c=relaxed/simple;
	bh=8ZBILanD8GUfHeGu8xOCQHmUBP8lbkPUGutl0kkUM6k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eeg4ZDp4b3U94UisiYnUAwQ3xHfFSN8hC3EuOVFXZ1IJrRN+aO8hT3hrPfWZ+IQmY0EzWyKVOS94AWTsMx8JzYbB1/+rNNzNYZujZ2/cchdSNEkqS7JopLY7fELZD5Hf4OVVrUQf358M+r8HXQbBxt68+s3isD6DjejpsSrbAwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz; spf=pass smtp.mailfrom=listout.xyz; dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b=h2fwKtog; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=listout.xyz
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4c61jT4Q03z9t3B;
	Tue, 19 Aug 2025 22:42:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=listout.xyz; s=MBO0001;
	t=1755636141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=f39+AAkAozC+X5tq/z57cuX92rwCgBeX91Rk3Y1dpJM=;
	b=h2fwKtogxfQac8+Jr/0dADySlaqMyPSf3kbo8NT1uaEeFhq/Mzg6++OqrzlCRS9RMUFzSk
	v/oES9S2P1xN9/BCGU9OI7K6+ZNraM5aSQ4glMNECeSbv8JBKcZl9RYMSo1v6QYZZ8yvJF
	ZjO6EP2Rxc3XX4NUPLpiEdA4UA6TDi+k5NE/4bwzPrZn2Ut3VQzdiPwGGr71fWhEG9TLiq
	Gy5zQ3wnJ6TXerrFqs9FfwieAbvDRAIpIbY461u6Gb9XcOPnp8vchelat0xCn2Ly7qtTdg
	3wte85NQ3Z1QcWJVpw0xlpB6BC4e/itwl2EEKAcvKSzTJuySZwx9mh7/k7/wdg==
From: Brahmajit Das <listout@listout.xyz>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexdeucher@gmail.com>,
	Jun Lei <jun.lei@amd.com>,
	Qingqing Zhuo <Qingqing.Zhuo@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Cc: linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org,
	listout@listout.xyz
Subject: [PATCH] drm/amd/display: clean-up dead code in dml2_mall_phantom
Date: Wed, 20 Aug 2025 02:12:07 +0530
Message-ID: <20250819204207.14407-1-listout@listout.xyz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

pipe_idx in function dml2_svp_validate_static_schedulabilit, although
set is never actually used. While building with GCC 16 this gives a
warning:

drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/dml2_mall_phantom.c: In function ‘set_phantom_stream_timing’:
drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/dml2_mall_phantom.c:657:25: warning: variable ‘pipe_idx’ set but not used [-Wunused-but-set-variable=]
  657 |         unsigned int i, pipe_idx;
      |                         ^~~~~~~~

Signed-off-by: Brahmajit Das <listout@listout.xyz>
---
 drivers/gpu/drm/amd/display/dc/dml2/dml2_mall_phantom.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_mall_phantom.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_mall_phantom.c
index a56e75cdf712..1d0af0f8ffa1 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_mall_phantom.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_mall_phantom.c
@@ -654,14 +654,13 @@ static void set_phantom_stream_timing(struct dml2_context *ctx, struct dc_state
 				     unsigned int svp_height,
 				     unsigned int svp_vstartup)
 {
-	unsigned int i, pipe_idx;
 	double line_time, fp_and_sync_width_time;
 	struct pipe_ctx *pipe;
 	uint32_t phantom_vactive, phantom_bp, pstate_width_fw_delay_lines;
 	static const double cvt_rb_vblank_max = ((double) 460 / (1000 * 1000));
 
 	// Find DML pipe index (pipe_idx) using dc_pipe_idx
-	for (i = 0, pipe_idx = 0; i < ctx->config.dcn_pipe_count; i++) {
+	for (unsigned int i = 0; i < ctx->config.dcn_pipe_count; i++) {
 		pipe = &state->res_ctx.pipe_ctx[i];
 
 		if (!pipe->stream)
@@ -669,8 +668,6 @@ static void set_phantom_stream_timing(struct dml2_context *ctx, struct dc_state
 
 		if (i == dc_pipe_idx)
 			break;
-
-		pipe_idx++;
 	}
 
 	// Calculate lines required for pstate allow width and FW processing delays
-- 
2.51.0


