Return-Path: <linux-kernel+bounces-587576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7AEBA7AE33
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 22:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D386C16F42A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 20:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338441FE47D;
	Thu,  3 Apr 2025 19:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u3dI9BFL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790D21FDA7A;
	Thu,  3 Apr 2025 19:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707778; cv=none; b=nLxlp1VE8WxgDCJ2dm5P4Vnsskjw+J5hDYfp5ByCzitBYFUl+kGDJnFbX8QsBXeE2/MB49AfnflmHb1AnkkuV7LlFXhk+RkC/D6QC6SFRdSMAw67j2eSEQrsGD94EhDKhdAIdiACcCD3RJ7pq0Ocopa/uncspVg76P/AhD5V4sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707778; c=relaxed/simple;
	bh=i6DETD1Avhc2RRSPj7UiOVAKtd4jihLU5CxouD+O6y8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ia+dezNMCRKd3grx0Ol5DsmLQKYKYmgQyqq3czZWRlcI0LGPeTe6F89hOc6fIdn8fL895vFm3J0t+IgKmwvETP83tqZd55ot7se5iVMiLsu6bkUwwDpid6yRfcl8qvI2N0+JOORFc0Lil3342+sIiMWhoTIDrRXrPwgmYaqCmK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u3dI9BFL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB1C3C4CEE3;
	Thu,  3 Apr 2025 19:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707776;
	bh=i6DETD1Avhc2RRSPj7UiOVAKtd4jihLU5CxouD+O6y8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u3dI9BFLZFFT84Yq63pJpLyLKw3tp6oaiGfF+dkQWvdQWt8zpD/1EhVc9AQzbKWeV
	 yrq31bOrNCP7LBs+5PzhJzqmCXDE6PjEyV8/6hqZAHio1oheR+Q9Ley3Zy11pv6PVk
	 3YspXGYNy1WSPbxDKs3rK58vWNiAzWQuVSYEd0Y+E4FNpHHeCD2mdC67UxHMA0nzF2
	 TCJQ92yrGIEDl+053JByc7Re0C+UnRA6+4M7KxM3IdVv83GSOSxZId+F5Yq7/Jb0qT
	 AVlfQ6M53Xf4N5ORkS+fh/ObmM6Vo7KAlTsiiBigcnGGD/QE6MQAipOA+9ySWLJWCG
	 KV9mUiIo67RAg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Philip Yang <Philip.Yang@amd.com>,
	Felix Kuehling <felix.kuehling@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Felix.Kuehling@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.13 20/37] drm/amdkfd: Fix pqm_destroy_queue race with GPU reset
Date: Thu,  3 Apr 2025 15:14:56 -0400
Message-Id: <20250403191513.2680235-20-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191513.2680235-1-sashal@kernel.org>
References: <20250403191513.2680235-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.9
Content-Transfer-Encoding: 8bit

From: Philip Yang <Philip.Yang@amd.com>

[ Upstream commit 7919b4cad5545ed93778f11881ceee72e4dbed66 ]

If GPU in reset, destroy_queue return -EIO, pqm_destroy_queue should
delete the queue from process_queue_list and free the resource.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 1d538e874140c..6ca0efa2c3c97 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -529,7 +529,7 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
 			pr_err("Pasid 0x%x destroy queue %d failed, ret %d\n",
 				pqm->process->pasid,
 				pqn->q->properties.queue_id, retval);
-			if (retval != -ETIME)
+			if (retval != -ETIME && retval != -EIO)
 				goto err_destroy_queue;
 		}
 		kfd_procfs_del_queue(pqn->q);
-- 
2.39.5


