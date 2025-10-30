Return-Path: <linux-kernel+bounces-877416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE3EC1E10D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 02:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D4F564E2EC1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 01:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DA42E1C5C;
	Thu, 30 Oct 2025 01:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="wtVpC0hz"
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E202DF3F9
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 01:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761789412; cv=none; b=WcTFIO0tfd4GlIgpoT1jnhswq2Dqy/K6Ly7ipYU2UFBuAav97xQQ914/EvxNZUC1Ao2uxZ/6DQZmWD/Piv+PfgIy8/JNfkNQHfETNndgyUmwtrxDUs7yCuxq0n94oa6hZXSWEmMnU4Fg4l30q2H6hFcZS4U0jWTKZZDX8+9Lhc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761789412; c=relaxed/simple;
	bh=Vt/UWldsRRepQ2CAgzw0gtyIPVhGQOuX9LxRVeYbSqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n6laITkpJY3nDg2dbDe5YEXYmS71q7pjIayRSl4hMiwt1AKCsxmSPxTHzoD48AaLc5M4tNhWWafPU4D/WR5vSu/4nJa2I8Tzx2rACi7A6rnX+LBa/BjBtUOm8Cq6+6o2H7Ci//TMhR8H3dRcfiP9Ssbbbz/GUjCNKwoMlmoNvps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=wtVpC0hz; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761789405; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=1y/8gMi7tm6PsOc59fPI8ACo1arCYOtEuKQye8c5Ehg=;
	b=wtVpC0hzWQVUJ/7xc+fYL5y0v7wsjjjgwgOTN6cTIGP4+9X+Pc4tsKc7PKobxGqxYSmHo6usoVbSR+xTpHBCYXQzhOEiHd8LHY/8h5BNADTUCc/9Deaxg0gfeTSfSIImLsP/U4Ok4qrMu+rtBEY+K1dqZlGAPPwLms7iZssw/gw=
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0WrI6Z-z_1761789403 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 30 Oct 2025 09:56:45 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: harry.wentland@amd.com
Cc: sunpeng.li@amd.com,
	siqueira@igalia.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next 1/3] drm/amd/display: remove unneeded semicolon
Date: Thu, 30 Oct 2025 09:56:31 +0800
Message-ID: <20251030015631.3106732-3-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251030015631.3106732-1-jiapeng.chong@linux.alibaba.com>
References: <20251030015631.3106732-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional modification involved.

./drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c:1674:3-4: Unneeded semicolon.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=26821
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 .../gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c    | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
index 130058d7a70c..875ae97489d3 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
@@ -1671,7 +1671,7 @@ enum dc_status dcn401_validate_bandwidth(struct dc *dc,
 				dc_state_set_stream_cursor_subvp_limit(stream, context, true);
 				status = DC_FAIL_HW_CURSOR_SUPPORT;
 			}
-		};
+		}
 	}
 
 	if (validate_mode == DC_VALIDATE_MODE_AND_PROGRAMMING && status == DC_FAIL_HW_CURSOR_SUPPORT) {
-- 
2.43.5


