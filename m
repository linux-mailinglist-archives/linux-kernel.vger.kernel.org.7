Return-Path: <linux-kernel+bounces-634003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD76AAAB81
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 03:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 662D83A5D21
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 01:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5581C2F73DD;
	Mon,  5 May 2025 23:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qnGnSEOM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56EE2E338E;
	Mon,  5 May 2025 23:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486233; cv=none; b=WXLwgr2pykPeSUNr3EUXBAXmVH5eCKGfSpr7MJvSA/7lCa/9smyy679OghREeuIhDejzrA+RLoVYRItftq1KjRqXtizIYJEmquE9g3VY+X/5u++1GR3X1e0gyBtvm/3qRu9o3YgiEi9Jr0b4CPVqvYYs+hJ14zBMmLevEf1qVmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486233; c=relaxed/simple;
	bh=Nm5dAaQuP1tFUt1Z3tmizws4xDWNqGjg64KYQwYXWXA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OJqBRQMoQun4us7hZIyzexUDXAVkQrwDfKPqVR+PHoXZC0wy0eFKmEe57DU+eWKGY1kFVR13G0KizPKPc3jqMU6or1+vQZlJRdaETFDB0YMfdbaUruZsExRIltpXZnWNdKHjGlJX/CN465b1BMnnBVZgCxqUi8/7Kg0YXDwQDbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qnGnSEOM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0ADBC4CEED;
	Mon,  5 May 2025 23:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486232;
	bh=Nm5dAaQuP1tFUt1Z3tmizws4xDWNqGjg64KYQwYXWXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qnGnSEOMt6zeIq0jri54y0sWJGZ6FeyYHGr7+0A1km8rtiN3IVAfCK4dakcvEqVHf
	 80fFqHStVOmCpBt+aGpRUK2CiAylc0YJcssWq/s98HIhySggeQ6TWhNasZClcFXWOk
	 ekbtiW1yKMWFBwGoQq5p5hUgy930X/rGiNk15ubjX4a9GUeuqjNhs2rXEJ7imZgv9Y
	 K64+VIagIpjZMqusJIyTRcsunlTb0ltIdKDm2qEjgkVB1wKp84J/inawNt/R7ytgym
	 fBLKkEuzDrtmxR7ZwC+SpSMptLY+iznFUY6i3q5LeshO68JdQ+LxlqjtN2ZwqdIMcX
	 w0i6qCvlF4u8A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Damon Ding <damon.ding@rock-chips.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	kishon@kernel.org,
	linux-phy@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 220/294] phy: core: don't require set_mode() callback for phy_get_mode() to work
Date: Mon,  5 May 2025 18:55:20 -0400
Message-Id: <20250505225634.2688578-220-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
Content-Transfer-Encoding: 8bit

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit d58c04e305afbaa9dda7969151f06c4efe2c98b0 ]

As reported by Damon Ding, the phy_get_mode() call doesn't work as
expected unless the PHY driver has a .set_mode() call. This prompts PHY
drivers to have empty stubs for .set_mode() for the sake of being able
to get the mode.

Make .set_mode() callback truly optional and update PHY's mode even if
it there is none.

Cc: Damon Ding <damon.ding@rock-chips.com>
Link: https://lore.kernel.org/r/96f8310f-93f1-4bcb-8637-137e1159ff83@rock-chips.com
Tested-by: Damon Ding <damon.ding@rock-chips.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20250209-phy-fix-set-moe-v2-1-76e248503856@linaro.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/phy-core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index a892e1d7e2d02..9417372a01554 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -400,13 +400,14 @@ EXPORT_SYMBOL_GPL(phy_power_off);
 
 int phy_set_mode_ext(struct phy *phy, enum phy_mode mode, int submode)
 {
-	int ret;
+	int ret = 0;
 
-	if (!phy || !phy->ops->set_mode)
+	if (!phy)
 		return 0;
 
 	mutex_lock(&phy->mutex);
-	ret = phy->ops->set_mode(phy, mode, submode);
+	if (phy->ops->set_mode)
+		ret = phy->ops->set_mode(phy, mode, submode);
 	if (!ret)
 		phy->attrs.mode = mode;
 	mutex_unlock(&phy->mutex);
-- 
2.39.5


