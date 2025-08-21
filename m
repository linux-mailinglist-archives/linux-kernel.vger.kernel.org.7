Return-Path: <linux-kernel+bounces-779833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 917C0B2F9DB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 15:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D782C3BAAEF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 13:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5732C11C1;
	Thu, 21 Aug 2025 13:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b="s+jGAUic"
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CF036CDE1
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 13:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755781768; cv=none; b=bJJFh1w9ACuX6W/f7FBIcSSZ3lzfHTZNYawRJvdAW0kZxrjG1GrPnpjmjCThsc1Ebkgz3r+b/afJLVzpEPljbw8XG4/Sb22Z8Jaw4Jxj9wQx5B+irN8P4URdcLhRSmltfAXfSgVoBMjmpF5AeIQxWdiRZn0VX1K09Qbc9jUt6SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755781768; c=relaxed/simple;
	bh=MeQEZv8XM24OgU4ggYQjZ95ovNGDRXHKtmzcUdqWP5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oq2QiUmDwc/x9MRVHsKyOkb1OFIlmJUqVmcPJngq+v0wEB6EqlBcboz9oPiUq+APPlA2UfpIbBBFPU/l2GNZ/Y7MA6dCMjzgZdTtLDsAHRngHbgPhUvx3y8bVUeLX8/mFPGjWEqqE3btvbo6b2msCf646073kyxeWPjrwfyRjk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz; spf=pass smtp.mailfrom=listout.xyz; dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b=s+jGAUic; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=listout.xyz
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4c73Yv1V1cz9tJx;
	Thu, 21 Aug 2025 15:09:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=listout.xyz; s=MBO0001;
	t=1755781763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=52AW3vX2G/gONvQRliEmju8kdN4K7aQivHGiuzDOHmM=;
	b=s+jGAUic/ET4f3uS8kGl/sLr8obP/gvQlWLnXAU7A/5pRIpCSJuw48ObfQD4kqqOL2GWxy
	okDa/fq/dfTkmxuxZGxqfTW1YStwNU9pitzLoWRItb35yCYOeNZjMVn2U7C+KtwpKZgMAq
	SuG3NpGCf6zIegVozyX/xbCcj7kbngzhX3JZ1nmEgz8CTggPBDOYItayjbsGX6teJD2eKv
	NXl4JtrUYVAmDUkuKHWM28BE7A9uPGrsGUCpxXwCDGXkAuR79vu8/St1YARB8QhzRDcbPZ
	PTTLyADBSHraW+k936OhCXcYglKh8quexx+XSBhGvk4juDSYBxjSNqzk6W8jzg==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of listout@listout.xyz designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=listout@listout.xyz
From: Brahmajit Das <listout@listout.xyz>
To: alexander.deucher@amd.com
Cc: Christian.Koenig@amd.com,
	Jun.Lei@amd.com,
	Qingqing.Zhuo@amd.com,
	alexdeucher@gmail.com,
	amd-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	listout@listout.xyz
Subject: [PATCH v2] drm/amd/display: clean-up dead code in dml2_mall_phantom
Date: Thu, 21 Aug 2025 18:39:09 +0530
Message-ID: <20250821130909.25428-1-listout@listout.xyz>
In-Reply-To: <BL1PR12MB5144269A278EED9AC3CCEE7EF733A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <BL1PR12MB5144269A278EED9AC3CCEE7EF733A@BL1PR12MB5144.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4c73Yv1V1cz9tJx

pipe_idx in funtion dml2_svp_validate_static_schedulabilit, although set
is never actually used. While building with GCC 16 this gives a warning:

drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/dml2_mall_phantom.c: In function ‘set_phantom_stream_timing’:
drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/dml2_mall_phantom.c:657:25: warning: variable ‘pipe_idx’ set but not used [-Wunused-but-set-variable=]
  657 |         unsigned int i, pipe_idx;
      |                         ^~~~~~~~

Signed-off-by: Brahmajit Das <listout@listout.xyz>
---
v1 -> v2: leaving declaration above
---
 drivers/gpu/drm/amd/display/dc/dml2/dml2_mall_phantom.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_mall_phantom.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_mall_phantom.c
index a56e75cdf712..c59f825cfae9 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_mall_phantom.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_mall_phantom.c
@@ -654,14 +654,14 @@ static void set_phantom_stream_timing(struct dml2_context *ctx, struct dc_state
 				     unsigned int svp_height,
 				     unsigned int svp_vstartup)
 {
-	unsigned int i, pipe_idx;
+	unsigned int i;
 	double line_time, fp_and_sync_width_time;
 	struct pipe_ctx *pipe;
 	uint32_t phantom_vactive, phantom_bp, pstate_width_fw_delay_lines;
 	static const double cvt_rb_vblank_max = ((double) 460 / (1000 * 1000));
 
 	// Find DML pipe index (pipe_idx) using dc_pipe_idx
-	for (i = 0, pipe_idx = 0; i < ctx->config.dcn_pipe_count; i++) {
+	for (i = 0; i < ctx->config.dcn_pipe_count; i++) {
 		pipe = &state->res_ctx.pipe_ctx[i];
 
 		if (!pipe->stream)
@@ -669,8 +669,6 @@ static void set_phantom_stream_timing(struct dml2_context *ctx, struct dc_state
 
 		if (i == dc_pipe_idx)
 			break;
-
-		pipe_idx++;
 	}
 
 	// Calculate lines required for pstate allow width and FW processing delays
-- 
2.51.0


