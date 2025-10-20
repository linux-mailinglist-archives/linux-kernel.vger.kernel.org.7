Return-Path: <linux-kernel+bounces-861914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BB0BF3FD8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 01:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F0BA4287FF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 23:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B682F619A;
	Mon, 20 Oct 2025 23:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SNQ/HC59"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92DA2F49E9
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 23:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761001822; cv=none; b=LZs85emfkx9gDyUTFR1UpAzXXLGedFMNVJ51P7xytDCJaOmUGI8tMA/+RP61ZHJzUUvIAGaQzkITy+WwXGQCR83FwVEX5pZXBg6v2xv0r6ILugfZrVnjsY7qfZfRm8Un0CF6ClPbt4oc5FsFMVaHU2dkp1etJm8+aX5zRWo3ecI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761001822; c=relaxed/simple;
	bh=VgKxrbgpt5i/OpZBw16+vdT9CmvFFNCQc0iogYg3VqI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q65jwusbuvBl6yaKRdgL3t24z71yDSfhLlKuzodAkswxQAYk9lC/es2TDOLVcrzJK0IRhQ4n4LOP6k4ll1sAhTGOghLLyE1F908AY5asE3EE/JjVk5yhpvwaSCpODZgZ1bDKyWPfna5Ty4gZy7SVMKh4hX1JL+PmeINnC9E249A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SNQ/HC59; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761001816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZHy4AWrt+NUl0LwBuvIQCbQtTogfHk8+6iKBV+Xh/Jc=;
	b=SNQ/HC59cdHjeOY7bhCMoDl7xwI/1gtMU1vJB1bW88WN5ct+86WS8fLCcwWBeiGE6qBNuJ
	fhjlwTMQBlkiYKol7XIumnP0awdX9YUM/vmZuuiUN3ep9h8YN08JlAKC06BIrx6Dt0Ztzp
	zo+d4XsxOfUjNfYeE3bV7/BCBKBmW/s=
From: Matthew Schwartz <matthew.schwartz@linux.dev>
To: amd-gfx@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org,
	mario.limonciello@amd.com,
	alexander.deucher@amd.com,
	alex.hung@amd.com,
	daniel.wheeler@amd.com,
	roman.li@amd.com,
	misyl@froggi.es,
	Matthew Schwartz <matthew.schwartz@linux.dev>
Subject: [PATCH] drm/amd/display: Don't program BLNDGAM_MEM_PWR_FORCE when CM low-power is disabled on DCN30
Date: Mon, 20 Oct 2025 16:09:34 -0700
Message-ID: <20251020230934.387745-1-matthew.schwartz@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Before commit 33056a97ae5e ("drm/amd/display: Remove double checks for
`debug.enable_mem_low_power.bits.cm`"), dpp3_program_blnd_lut(NULL)
checked the low-power debug flag before calling
dpp3_power_on_blnd_lut(false).

After commit 33056a97ae5e ("drm/amd/display: Remove double checks for
`debug.enable_mem_low_power.bits.cm`"), dpp3_program_blnd_lut(NULL)
unconditionally calls dpp3_power_on_blnd_lut(false). The BLNDGAM power
helper writes BLNDGAM_MEM_PWR_FORCE when CM low-power is disabled, causing
immediate SRAM power toggles instead of deferring at vupdate. This can
disrupt atomic color/LUT sequencing during transitions between
direct scanout and composition within gamescope's DRM backend on
Steam Deck OLED.

To fix this, leave the BLNDGAM power state unchanged when low-power is
disabled, matching dpp3_power_on_hdr3dlut and dpp3_power_on_shaper.

Fixes: 33056a97ae5e ("drm/amd/display: Remove double checks for `debug.enable_mem_low_power.bits.cm`")
Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
---
 drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
index 09be2a90cc79d..4f569cd8a5d61 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
@@ -578,9 +578,6 @@ static void dpp3_power_on_blnd_lut(
 			dpp_base->ctx->dc->optimized_required = true;
 			dpp_base->deferred_reg_writes.bits.disable_blnd_lut = true;
 		}
-	} else {
-		REG_SET(CM_MEM_PWR_CTRL, 0,
-				BLNDGAM_MEM_PWR_FORCE, power_on == true ? 0 : 1);
 	}
 }
 
-- 
2.51.1.dirty


