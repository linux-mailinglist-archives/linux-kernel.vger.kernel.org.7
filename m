Return-Path: <linux-kernel+bounces-862600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9262DBF5B84
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95C65189DA61
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2FD32B998;
	Tue, 21 Oct 2025 10:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGBXTSBo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2732E88B7;
	Tue, 21 Oct 2025 10:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761041567; cv=none; b=hflgbPrI9PY/91/nYu98xomIzWpMVB3GTaCeZ4XiX5YYcMA0B9FRumGoSYn8NlQhG8bKQR/jpKiN2FKI4AzpeQGnzq0y81kbIz+uOPBT8AppoXXx1SWs+E0QIFGxtPLlWI4SiupdOfK8PEJVpBzMtGX9fPvizEVIKJMR1dI8s3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761041567; c=relaxed/simple;
	bh=lXJHHFptBMpEYGRhwmXvUj9/TcSk3rk7mp2Kop2wt9E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=poMBYn6/+GSgG1gy512Jz5aR2vDFS9SCXXL5gWTlC/Kro1wI4iBFxkbThvxWzlaIUiInhK0eUpNSiGj7k4ov8ct28xSwS1qTsFalOkhzpPihy4KFO8Rzqy6kLpN9gfPI3+OvYIHaVRgUVf+9AeKwyZhOxQS/hfnsU2Np2KPGHzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGBXTSBo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2CC1FC4CEFF;
	Tue, 21 Oct 2025 10:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761041567;
	bh=lXJHHFptBMpEYGRhwmXvUj9/TcSk3rk7mp2Kop2wt9E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=UGBXTSBoU4r/S+NZXqhliuLYbstQY8dOy0nH6RUhm91QvPFnmEnoOlM9S8fgReF+4
	 9PwJVabUwkI6b2BRAK1usBU2EygbxdsF6nNQ5ZT2Z8om9RE5dVRJpc6qq6Cwo6W385
	 DHAQKIyfDR+mt1QKYPo/DSY1dzkWyp1ot4htAGydAWa4UrDJJqOV/U6ZOl2eA4NDAL
	 UxwHQKRjezLLf7vJwA3iiWkbEFQzrgzHaXVgDcx2xD17TRyzcv2Q+ZbWmC4eNq2qiI
	 Bw4MT4Mb95zsScm0tpo4WmLz25R65LFJdTJ490ogM71qtr6S2RFZwJMMjb7bjb+hS1
	 ojAKYDrsTW27w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EBB5CCD184;
	Tue, 21 Oct 2025 10:12:47 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Date: Tue, 21 Oct 2025 18:12:31 +0800
Subject: [PATCH 2/2] clk: divider: improve the execution efficiency of
 determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-improve_efficiency_of_clk_divider-v1-2-e2bf7f625af6@amlogic.com>
References: <20251021-improve_efficiency_of_clk_divider-v1-0-e2bf7f625af6@amlogic.com>
In-Reply-To: <20251021-improve_efficiency_of_clk_divider-v1-0-e2bf7f625af6@amlogic.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Chuan Liu <chuan.liu@amlogic.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761041565; l=652;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=4yJ8TlYve5AF/Eq9UZTnZIGY2BOewY1lDoBVTOtUsrQ=;
 b=VxzxRsKA+iZOgpD1UJltY5o1FNELeaOzfb/BDwqRVvD76/IppmfZ9jTzZLKPqGAMOhcmHJAjj
 rl/nsdMNhmcCEN7UCfH8OZkpW8gduzzcOFoM8CGg2yw+nVCORYeyBAO
X-Developer-Key: i=chuan.liu@amlogic.com; a=ed25519;
 pk=fnKDB+81SoWGKW2GJNFkKy/ULvsDmJZRGBE7pR5Xcpo=
X-Endpoint-Received: by B4 Relay for chuan.liu@amlogic.com/20240902 with
 auth_id=203
X-Original-From: Chuan Liu <chuan.liu@amlogic.com>
Reply-To: chuan.liu@amlogic.com

From: Chuan Liu <chuan.liu@amlogic.com>

There is no need to evaluate further divider values once _is_best_div()
finds one that matches the target rate.

Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
---
 drivers/clk/clk-divider.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index 2601b6155afb..b92c4f800fa9 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -339,6 +339,9 @@ static int clk_divider_bestdiv(struct clk_hw *hw, struct clk_hw *parent,
 			best = now;
 			*best_parent_rate = parent_rate;
 		}
+
+		if (best == rate)
+			break;
 	}
 
 	if (!bestdiv) {

-- 
2.42.0



