Return-Path: <linux-kernel+bounces-881733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C4DC28D39
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 11:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B50473AC376
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 10:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4312226E17A;
	Sun,  2 Nov 2025 10:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sfLNha0j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6451B87C0
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 10:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762078906; cv=none; b=roZdsN++yLXUMFdQirDUQKd1QZ3kjNJ/akDxMMMNgKXRrhqIMs89wvwMbRRV9m7FDOo2i/QVr94c8XWpbWCrG/Oevbn0o0gXLky8S8ARtnIPLmREdVRaZobDDt3ia9nTezN55y/54b07Vp4VWCJhMHhpgHF29IIEUe6PppWQNYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762078906; c=relaxed/simple;
	bh=GSX+ZS26UIq0ltiwHsRY+WphdQyJt3balrP+un0Fz6g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GCB5WljiMJPokOHE8HdrS720M8LMat/eCZ+x9Mf+guSaOI8QvDMEb8l03U+kbVN8j1P21rd27gi7UwRI1bBmIcDdBw3iuCLIo2o/jAyiRE7a7+E35iK5oR/KykHfTHNv++fViHt82anJ9EaSdsj1poAx7oJzzbRn2gg2ETzrpv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sfLNha0j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D9FC4CEF7;
	Sun,  2 Nov 2025 10:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762078906;
	bh=GSX+ZS26UIq0ltiwHsRY+WphdQyJt3balrP+un0Fz6g=;
	h=From:To:Cc:Subject:Date:From;
	b=sfLNha0j6AEjpFjX0Q4/IsrWZp+dqATeB/dxOAmr0s735wPr/jAVF9E6PlXua3/07
	 Ac4bIhTAkSwS3x6nQPX2w4nOpNL6CxkA6Lc9u7u4I2hfKtWWQXv73iei7UQItoitIY
	 zkSM1ji8y/ED6kTFzRi6p3otjmdgjxd2pf3OldOnPIC+H2X7puHt9SvLrpIAkgF5XX
	 hYOCpWhxl2sMCXrxwi3x7WBh05+F+g8nGqo9seli2v+MdL7RFhL96W0omx2vDraUqr
	 RLJmTGpByI3Zv6gKtAohOikL1L1c7hFf0VTIssjpFK3ginb3rEwA+GHZYZV7weCwsc
	 uN+gSsCQTrwRA==
From: Jisheng Zhang <jszhang@kernel.org>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] mux: mmio: add suspend and resume support
Date: Sun,  2 Nov 2025 18:04:02 +0800
Message-ID: <20251102100402.9477-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During suspend, nothing to do; During resume, since the mux mmio reg
may be reset, so we have to reset mux->cached_state as
MUX_CACHE_UNKNOWN which is actual MUX_IDLE_AS_IS. See the comments of
MUX_CACHE_UNKNOWN in core.c ".. indication that the cached state of
the multiplexer is unknown."

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/mux/mmio.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/mux/mmio.c b/drivers/mux/mmio.c
index 9993ce38a818..86f7e7d31983 100644
--- a/drivers/mux/mmio.c
+++ b/drivers/mux/mmio.c
@@ -141,13 +141,31 @@ static int mux_mmio_probe(struct platform_device *pdev)
 
 	mux_chip->ops = &mux_mmio_ops;
 
+	platform_set_drvdata(pdev, mux_chip);
+
 	return devm_mux_chip_register(dev, mux_chip);
 }
 
+static int mux_mmio_resume(struct device *dev)
+{
+	int i;
+	struct mux_chip *mux_chip = dev_get_drvdata(dev);
+
+	for (i = 0; i < mux_chip->controllers; ++i) {
+		struct mux_control *mux = &mux_chip->mux[i];
+		mux->cached_state = MUX_IDLE_AS_IS;
+	}
+
+	return 0;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(mux_mmio_pm_ops, NULL, mux_mmio_resume);
+
 static struct platform_driver mux_mmio_driver = {
 	.driver = {
 		.name = "mmio-mux",
 		.of_match_table	= mux_mmio_dt_ids,
+		.pm = pm_sleep_ptr(&mux_mmio_pm_ops),
 	},
 	.probe = mux_mmio_probe,
 };
-- 
2.51.0


