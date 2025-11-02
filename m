Return-Path: <linux-kernel+bounces-881730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02591C28D2A
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 11:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC1CB3B310E
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 10:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF32D1E5718;
	Sun,  2 Nov 2025 10:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lL3/YZrY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D1717B418
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 10:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762078822; cv=none; b=R+YIBvf59a9euf5p/3p8C6o9tg64TW8XF53Vh13XR+ocpxPrZ9c3B7cSB1cqUzD3ncE+Re9DmKJ/53kFZVgQWHcDi+xHnAFl6oQcmIrorraUwFOOVJeQSb1MbCJme2XBNhcSB4L4eW99PKtvLZjzgJpXD3qa8aLU7fzGYHkwWps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762078822; c=relaxed/simple;
	bh=uMx1a1jzdRa9DPHduAtpXTqZk23q5LRqreUcRszHpT4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IKsm8zLr0vxi+ERKJMSqQ8zrSGFl84S3Nm3RiZ1GqXxrcAniOdCWRkiEPqjyJ1XfL7qXvuFBeWgQplS1RVpiF2c9r9zlQU2QGRy0c+eKqpPdZG2WyGQVvMdgn/ZHrgRjJ/wwOXtAm3P0APctqyh23J1zsWO1CCM8L+HodcrcmlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lL3/YZrY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91418C4CEF7;
	Sun,  2 Nov 2025 10:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762078821;
	bh=uMx1a1jzdRa9DPHduAtpXTqZk23q5LRqreUcRszHpT4=;
	h=From:To:Cc:Subject:Date:From;
	b=lL3/YZrYCN9s1ZsczQRekScth3/rnBPBjLr6fle2j8tAtaH3d9AHtQgGj1xBfl9Zf
	 9mDg8w1ZXFk4mLZv9WdYsqlTXfxNOYG/LsB7JhqYQOqJuoBRp6m0YQc62mpcNX2FT0
	 JGTXwFMBnw9JMxem1KQEoaYyQJDZaL6GT8dBMZjnQ+CamQy6pYdH4tZ1cUvMKKqE/p
	 l9dJFPp57E2sgky5U2QaKhmte/pharKwqN4rjGTuW0uGVLXpHmqVi9ry/W4bosTI6j
	 1du1Ei//Xtrccj73q7H1Vs2Qc+gWnqohyZq3sw+wiyaUgbVoVtSfL8ePc+S/hb6fgO
	 rLDnjEN7Of7OA==
From: Jisheng Zhang <jszhang@kernel.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Frank Li <Frank.Li@nxp.com>
Cc: linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] i3c: dw: Add apb reset support
Date: Sun,  2 Nov 2025 18:02:37 +0800
Message-ID: <20251102100237.9451-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support of apb reset which is to reset the APB interface.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/i3c/master/dw-i3c-master.c | 9 +++++++++
 drivers/i3c/master/dw-i3c-master.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index 9ceedf09c3b6..ca2863d2b2b7 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -1558,7 +1558,13 @@ int dw_i3c_common_probe(struct dw_i3c_master *master,
 	if (IS_ERR(master->core_rst))
 		return PTR_ERR(master->core_rst);
 
+	master->apb_rst = devm_reset_control_get_optional_exclusive(&pdev->dev,
+								    "apb_rst");
+	if (IS_ERR(master->apb_rst))
+		return PTR_ERR(master->apb_rst);
+
 	reset_control_deassert(master->core_rst);
+	reset_control_deassert(master->apb_rst);
 
 	spin_lock_init(&master->xferqueue.lock);
 	INIT_LIST_HEAD(&master->xferqueue.list);
@@ -1607,6 +1613,7 @@ int dw_i3c_common_probe(struct dw_i3c_master *master,
 
 err_assert_rst:
 	reset_control_assert(master->core_rst);
+	reset_control_assert(master->apb_rst);
 
 	return ret;
 }
@@ -1711,6 +1718,7 @@ static int __maybe_unused dw_i3c_master_runtime_suspend(struct device *dev)
 	dw_i3c_master_disable(master);
 
 	reset_control_assert(master->core_rst);
+	reset_control_assert(master->apb_rst);
 	dw_i3c_master_disable_clks(master);
 	pinctrl_pm_select_sleep_state(dev);
 	return 0;
@@ -1723,6 +1731,7 @@ static int __maybe_unused dw_i3c_master_runtime_resume(struct device *dev)
 	pinctrl_pm_select_default_state(dev);
 	dw_i3c_master_enable_clks(master);
 	reset_control_deassert(master->core_rst);
+	reset_control_deassert(master->apb_rst);
 
 	dw_i3c_master_set_intr_regs(master);
 	dw_i3c_master_restore_timing_regs(master);
diff --git a/drivers/i3c/master/dw-i3c-master.h b/drivers/i3c/master/dw-i3c-master.h
index c5cb695c16ab..a4ba60043288 100644
--- a/drivers/i3c/master/dw-i3c-master.h
+++ b/drivers/i3c/master/dw-i3c-master.h
@@ -37,6 +37,7 @@ struct dw_i3c_master {
 	struct dw_i3c_master_caps caps;
 	void __iomem *regs;
 	struct reset_control *core_rst;
+	struct reset_control *apb_rst;
 	struct clk *core_clk;
 	struct clk *pclk;
 	char version[5];
-- 
2.51.0


