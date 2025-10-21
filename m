Return-Path: <linux-kernel+bounces-862601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E73BF5B7E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD3B3466168
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E12E2EE5FD;
	Tue, 21 Oct 2025 10:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pKAGZs+G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3832F6933;
	Tue, 21 Oct 2025 10:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761041567; cv=none; b=aISBHngf30yMjdj09tom9lXc/VnuIn9NLpcW+E3fEgbmjTxx5Pr1+cBcA5BzVoiC7KUvx3HXCG/wJufNmKFeEfu5msyP0OlNrFzqSpw2FBXoNInWn4FDW9LWxxE7sCCQNSwN5gcGbepTgDDJxIdF9x2AboPpM2/CDoaF/MwWGIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761041567; c=relaxed/simple;
	bh=UzedL+S3HAdK0eeXkw7a+NEY01+Id+ZhbprHN+fI+gQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QjLQn7VluoWZ66DU3p3tB1A5FOWYnd61UTbM1RZ9ONei3AoSI/hYIxIhwqyXVxDXW4rZlEA3BotmZSJmcbNwtU7mPep0nVlJUjpy+s2XOL6/g/JdE7BSl8fVcyGEkv4CjnaE586QiMcCxHI33RJroUAWHXOsmIvCguZdvqDTKMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pKAGZs+G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 208D6C4CEF5;
	Tue, 21 Oct 2025 10:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761041567;
	bh=UzedL+S3HAdK0eeXkw7a+NEY01+Id+ZhbprHN+fI+gQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=pKAGZs+GSLnnH43WowczAwllaSVexNCTjMBoGQtRHfdr5Ah7LD6TVFrlcgFE1vNMJ
	 SxcZU5xO1hzO/TK2qXYJKj1kgEWB4DmOba7Vu20UP2j1OiQHXNYF+sc+DMI9RtA8n/
	 gzKTze/wxO3nw8riB+s71ARTvEnP45JKtf+arJS0aT/oHaURWgjbFlE9/Q75tptSp4
	 TlWExjGx+/4fDRgcbvng5dYCL2BmZfEDa+6vKJq8UbZlzkdBb8XFkGy81t3q55PcBE
	 3aDnuNnnhxNNFGIFQ4dYoPG+lTIt1ZQvZdh0OlSNd08IocUFjmgaemaNHxi+5LO+Wl
	 ynnrb1sMhiqIw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10EE4CCD1A5;
	Tue, 21 Oct 2025 10:12:47 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Date: Tue, 21 Oct 2025 18:12:30 +0800
Subject: [PATCH 1/2] clk: mux: improve the execution efficiency of
 determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-improve_efficiency_of_clk_divider-v1-1-e2bf7f625af6@amlogic.com>
References: <20251021-improve_efficiency_of_clk_divider-v1-0-e2bf7f625af6@amlogic.com>
In-Reply-To: <20251021-improve_efficiency_of_clk_divider-v1-0-e2bf7f625af6@amlogic.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Chuan Liu <chuan.liu@amlogic.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761041565; l=769;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=kpI7sJGuBtaGiKOaRn1dUBDRcck1TQit3fBKO0ju8fc=;
 b=au5lQ/hQp014GAb+uq9d8JpGOxZ1QHU8sRX0kgqHJ87EH7/z089DXLBqHOs+j6CwD3RoB+IMw
 7xFQgHArwbaCq/uYirA8Ci/LC8HuFVN07WZfJ7raLs0czwoi20uxO1m
X-Developer-Key: i=chuan.liu@amlogic.com; a=ed25519;
 pk=fnKDB+81SoWGKW2GJNFkKy/ULvsDmJZRGBE7pR5Xcpo=
X-Endpoint-Received: by B4 Relay for chuan.liu@amlogic.com/20240902 with
 auth_id=203
X-Original-From: Chuan Liu <chuan.liu@amlogic.com>
Reply-To: chuan.liu@amlogic.com

From: Chuan Liu <chuan.liu@amlogic.com>

According to the current logic of mux_is_better_rate(), even if a
parent clock matching req->rate is found again in the current loop,
it will not be selected.

Exit the loop once the best-matching parent clock is found to avoid
unnecessary function calls and reduce execution time.

Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
---
 drivers/clk/clk.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 85d2f2481acf..925e4768e3ad 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -758,6 +758,9 @@ int clk_mux_determine_rate_flags(struct clk_hw *hw,
 			best_parent = parent;
 			best = parent_rate;
 		}
+
+		if (best == req->rate)
+			break;
 	}
 
 	if (!best_parent)

-- 
2.42.0



