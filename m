Return-Path: <linux-kernel+bounces-634253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04BFEAAB02B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 05:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 453597BD7DF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 03:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701D2308143;
	Mon,  5 May 2025 23:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s9ACHuAR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FB72F8DF3;
	Mon,  5 May 2025 23:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487270; cv=none; b=eXfKcxavkDcy+OZayrn9zZYe2S97H79R7ezMB4tzW8lninvJB8QyZQBmgomR5+4hmSRbrXes87SsIaHpNFixd8WQ95K+ql/S5G+jsfYsvvLRlsdxYlaZzWcB6liLFnu7eVv1TiMnPIShhDTfq2pjBGlJMsIG6LjMz5JSAGEquSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487270; c=relaxed/simple;
	bh=gcLvGmV1JRzL2rwyJll+qLObGQHNZdw+J27tMlj5Fkw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nEiQ8ccpHANdq3PANgC2HRLL0aCQoY9NMbDT7bkvMQPKHJl4OQBdiztjN1xmHcjQMu8yBrG80aZyun++xsAoFUZHYAFSzeDC/jvtlNdKOz7eUzv27VLI2PhHhOwBC337rojEBx0kiBVi1ezA31MhwwX/D7uJIlWC8rXc14CMUJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s9ACHuAR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CAF9C4CEF1;
	Mon,  5 May 2025 23:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487269;
	bh=gcLvGmV1JRzL2rwyJll+qLObGQHNZdw+J27tMlj5Fkw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s9ACHuARQ7ESWn/UshVy1JDlFqpIy0+7xobU//Wn9yqgnXbdoeZEVtI3apEASN/Za
	 9TO60BhE9xQxx4QOG2X4u0VKqDtzBUiGFa05CSa7bi0S5eavrLMsEk0ssJRqqtNzaQ
	 oMFNbWM7Yw7+BQXctWIT0beKlOUWUjUJ5OR0t+MismWILyFGxodlrw0pQj91MUHCiP
	 MzWDAia5/KlMoMV+Wb3EHDrxkZtU1HF6ymHqHr7gcIRtdFIfhX7yJWKQLjJ747zAxI
	 jt+J6aiJbHWgVu9gfZGEKAXJ/g91GIzA2tbFTPpfFIbJd04zh6dH5/FTdmPtljUMHQ
	 vXXe8iU2v/0oQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Damon Ding <damon.ding@rock-chips.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	kishon@kernel.org,
	linux-phy@lists.infradead.org
Subject: [PATCH AUTOSEL 5.10 091/114] phy: core: don't require set_mode() callback for phy_get_mode() to work
Date: Mon,  5 May 2025 19:17:54 -0400
Message-Id: <20250505231817.2697367-91-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231817.2697367-1-sashal@kernel.org>
References: <20250505231817.2697367-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.237
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
index 1bcdef37e8aa2..dac0f7f4f3d3d 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -360,13 +360,14 @@ EXPORT_SYMBOL_GPL(phy_power_off);
 
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


