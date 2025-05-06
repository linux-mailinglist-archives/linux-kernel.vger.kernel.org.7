Return-Path: <linux-kernel+bounces-634100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3934BAAAF73
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 05:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86CAE16828B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 03:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0F12FC0FE;
	Mon,  5 May 2025 23:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ulz3lqEd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E318F2F1527;
	Mon,  5 May 2025 23:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486720; cv=none; b=SnRQFjLk8gKL8L7MUW1QqHFvf8Okof+IYs6Roqqg5LXGe6M8A4aRTVtEuEPRDvXvVAumb/DNzH155swin81jvJEYaFNXXQv7Zltlmyh1lqVdL97/+hkbB/CMmkZ7WglEFnjuP+oSAiKoZv/k/QXFV08L8/j8HhfuLcIVKO2OBBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486720; c=relaxed/simple;
	bh=TbJ6vTwCvQR/FzOhw+PeOhkfU5Pj1/ek0z5v8QzODss=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f+4MUXox4qIuP8uv8uoDu9uNsFmcLyXXcirleFh1qtUnBm5T6mgs3uJt6eQWKjmDxYbrBoTsCq3k+4Pdsdd3H3x2+aT83C03wj254Imi1y0BhnO0uWWHTN7LkVTCKMaf+YHXDIMtl54EDCCH9ILqoaQI7EkB0FD435QQYfF313Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ulz3lqEd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E9E6C4CEED;
	Mon,  5 May 2025 23:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486719;
	bh=TbJ6vTwCvQR/FzOhw+PeOhkfU5Pj1/ek0z5v8QzODss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ulz3lqEdrEhB2NSyb/5i2Fnt0dSe7jEvtv/zI0fYX8DJjnflbZTnLwTeyYEuclIW7
	 BQnccJ2LySKcU9d883FM6ubiYIj6O9OD5vZHkfVsrGFBKk4eVs/UNf0f92Ot68KC+L
	 WL1cQ2HwsZFZtwn2QktgrKqgRa/pM0hUYHQk3KyVQ1A5+GudZ9Tq1qMSdyrl0TgIKA
	 6kvAog2rG94tHef22nvKUBJfi1aaXJfby4kI/enn6u519C2hFsCksS7OwlssXj2xGF
	 P5z9pYFIWeiAhmEIxhwB8Z4WQY/ebYK/CwHgYMPhooBnqHqK05/gUkFIemGapU97lC
	 SKfhLEv2IWpSg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jiang Liu <gerry@linux.alibaba.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	Hawking.Zhang@amd.com,
	sunil.khatri@amd.com,
	le.ma@amd.com,
	candice.li@amd.com,
	YiPeng.Chai@amd.com,
	Feifei.Xu@amd.com,
	kevinyang.wang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 170/212] drm/amdgpu: reset psp->cmd to NULL after releasing the buffer
Date: Mon,  5 May 2025 19:05:42 -0400
Message-Id: <20250505230624.2692522-170-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
Content-Transfer-Encoding: 8bit

From: Jiang Liu <gerry@linux.alibaba.com>

[ Upstream commit e92f3f94cad24154fd3baae30c6dfb918492278d ]

Reset psp->cmd to NULL after releasing the buffer in function psp_sw_fini().

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index f8740ad08af41..a176b1da03bd3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -484,7 +484,6 @@ static int psp_sw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	struct psp_context *psp = &adev->psp;
-	struct psp_gfx_cmd_resp *cmd = psp->cmd;
 
 	psp_memory_training_fini(psp);
 	if (psp->sos_fw) {
@@ -511,8 +510,8 @@ static int psp_sw_fini(void *handle)
 	    adev->ip_versions[MP0_HWIP][0] == IP_VERSION(11, 0, 7))
 		psp_sysfs_fini(adev);
 
-	kfree(cmd);
-	cmd = NULL;
+	kfree(psp->cmd);
+	psp->cmd = NULL;
 
 	psp_free_shared_bufs(psp);
 
-- 
2.39.5


