Return-Path: <linux-kernel+bounces-753015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D011B17DC9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 09:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63CC017E22E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 07:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF771FA272;
	Fri,  1 Aug 2025 07:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aj1tCNoZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2972AE72
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 07:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754034367; cv=none; b=hSyYUohMvAy7eBEIqAYGHA325gedNDML0DTo+P7G3cvSfSdN0ycpky9eR+xRidYk7RmfAG+Jq42jZtMiiJ7uAJDcMElqOGUdgODIVYUoYaZEpk6TIwdG5SyJQMjCg/sjzBCLWVI2AYF+DgH3KFu8irOQOnVLgzniLFg9w32cWyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754034367; c=relaxed/simple;
	bh=J6nfFiOOqDG78zHsPEpxmyy2x4qceu5t+JJbMCFLeH0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P2AuxAPK6MnKChkbgbdYkheX7+ZjgA/U4cLxfHsTKg7jgpv2R+xEuqDMsOHyi76tMm3P5+Gc+XfxSLSP3VS5+1QV/yooxS4nXdUa81NbnPB4NQ7Tm+vab/oFWn+QKQFu+JbJWN2s898OMcrS8MClrBLscHWZhG0hjpJsc+KL7go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aj1tCNoZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95863C4CEE7;
	Fri,  1 Aug 2025 07:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754034367;
	bh=J6nfFiOOqDG78zHsPEpxmyy2x4qceu5t+JJbMCFLeH0=;
	h=From:To:Cc:Subject:Date:From;
	b=aj1tCNoZGZlj+x3WnOt7ruc6OG0j1vd+xYlGRHCDQEouPbGQ3S94YR8nMy80M9FBH
	 vhNIN3Ia/hnHnIa2YIWj1ER96iOVeUPQ6jsOpT59ekPjmJ3iQUkJ43Jms5eWrmllBu
	 V1JPANToOA9/e+oO804DPh/I1LUrfeccHDubE8d8WiABrkUdngQ1YXO4PtjKBw4WgX
	 OJ9vpeeMqMg7TnFVfk1XzTS7I297oJxIe+GiSPMUJ9G+3v97AH4sHxEu5prR9dbZni
	 1I2wManj9DRlpFld5eS/9TZyTzLQdvGl2z/G20Xj8F0jueE/Xv9Ep+K7T/CHpfrorF
	 c7KucmY0ThYlA==
From: Philipp Stanner <phasta@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Philipp Stanner <phasta@kernel.org>
Subject: [PATCH] drm/nouveau: Remove surplus struct member
Date: Fri,  1 Aug 2025 09:45:32 +0200
Message-ID: <20250801074531.79237-2-phasta@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct nouveau_channel contains the member 'accel_done' and a forgotten
TODO which hints at that mechanism being removed in the "near future".
Since that variable is read nowhere anymore, this "near future" is now.

Remove the variable and the TODO.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/gpu/drm/nouveau/nouveau_chan.h | 2 --
 drivers/gpu/drm/nouveau/nouveau_dma.h  | 1 -
 2 files changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_chan.h b/drivers/gpu/drm/nouveau/nouveau_chan.h
index 561877725aac..bb34b0a6082d 100644
--- a/drivers/gpu/drm/nouveau/nouveau_chan.h
+++ b/drivers/gpu/drm/nouveau/nouveau_chan.h
@@ -31,8 +31,6 @@ struct nouveau_channel {
 		u64 addr;
 	} push;
 
-	/* TODO: this will be reworked in the near future */
-	bool accel_done;
 	void *fence;
 	struct {
 		int max;
diff --git a/drivers/gpu/drm/nouveau/nouveau_dma.h b/drivers/gpu/drm/nouveau/nouveau_dma.h
index 0e27b76d1e1c..c25ef9a54b9f 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dma.h
+++ b/drivers/gpu/drm/nouveau/nouveau_dma.h
@@ -90,7 +90,6 @@ FIRE_RING(struct nouveau_channel *chan)
 {
 	if (chan->dma.cur == chan->dma.put)
 		return;
-	chan->accel_done = true;
 
 	WRITE_PUT(chan->dma.cur);
 
-- 
2.49.0


