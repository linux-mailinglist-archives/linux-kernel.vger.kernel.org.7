Return-Path: <linux-kernel+bounces-877417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F1BC1E11F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 02:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A5061890E05
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 01:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0355B2E8B66;
	Thu, 30 Oct 2025 01:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vH3X3ULr"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5857D2E1747
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 01:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761789415; cv=none; b=hA2t/cvWn6jWGGqpPdZOGEjhUjB4egbAHsv+pgtQ2IOdnp0oS5FRs92iRvsIBEXZFOy7EPzgSkE0QyrFixoInCWbBY3+m8QOtxQKmdKQpXxlBUSUrUGcf1fG+18w+1sEscw6qdaWD24ObX2gBp4oVodltHcbib4LEmkN07f5ZBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761789415; c=relaxed/simple;
	bh=D25QYheVTAF9RSKjWz43UBGslUArK/Xg0fm0TLY8ahs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TsBLBQrSIBe8VLZVidMUHDXpsWafvxMAczdKVJZ0GbzQy0hlQ7Wo/NmoYbEI9rslJ6JUhiazQQGrZLu8HTObMP1hytaGsZ5247K/F5OQVKuDd+Po/44p/UqMhRLPzRmh3NOuefRl5JmGeJlZz8rdB7+UAXXIkd/yObGwnVXK6Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=vH3X3ULr; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761789403; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=CTkSbhbsTSP6Nc12cy82Rk/0qORhZ5wAeJo00QNbzbg=;
	b=vH3X3ULrEV+Cz8dmhbMDx9tUZMvc2MLpKYjInq+EV50SwI/FxKK0b3JAOLCRHx2JvRM+tkD2wsFQNqmKkV8UEHVqQr6941HEpoS1frh7pRT1kUsNiBJbQVQaBowaT/cyH72uEg2LqgZvGXiPxp1ExP/64XkuuxoXzzeoPSdkPP4=
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0WrI6Z-._1761789399 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 30 Oct 2025 09:56:42 +0800
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
Subject: [PATCH -next 2/3] drm/amd/display: remove unneeded semicolon
Date: Thu, 30 Oct 2025 09:56:30 +0800
Message-ID: <20251030015631.3106732-2-jiapeng.chong@linux.alibaba.com>
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

./drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c:1850:3-4: Unneeded semicolon.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=26821
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index 81e64e17d0cb..df0b664c0cd2 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -1847,7 +1847,7 @@ enum dc_status dcn32_validate_bandwidth(struct dc *dc,
 				dc_state_set_stream_cursor_subvp_limit(stream, context, true);
 				status = DC_FAIL_HW_CURSOR_SUPPORT;
 			}
-		};
+		}
 	}
 
 	if (validate_mode == DC_VALIDATE_MODE_AND_PROGRAMMING && status == DC_FAIL_HW_CURSOR_SUPPORT) {
-- 
2.43.5


