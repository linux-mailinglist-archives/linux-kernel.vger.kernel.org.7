Return-Path: <linux-kernel+bounces-817201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67837B57F36
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 16:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F8822076A2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120C032A822;
	Mon, 15 Sep 2025 14:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZN2e6kb8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6199F32143D;
	Mon, 15 Sep 2025 14:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757947015; cv=none; b=iCF1kgrIqDrWidJhmMVgl7lny4liKd9TwXbyiLfpN605VhjgYc72QNp3U5JhKJUW7/NYwXd/cE4Pxz+bl4l/GfLYTR3q8oTh6xGOJsLDuPYAGZtDYrImRJkhZoxB+FQdWrXDvcYYA7yODc4BzkxSZ+0tyeONP6xc59V7Oq1CPAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757947015; c=relaxed/simple;
	bh=DC9uy+dVdl3WE0T3/WYt5Rj+8+1fLNzMGLUJt/1fWFE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K5fOyW7fuUaUKDTeTqE/y6YcZlvm1ravAmWseZkFT8EqyFIeu09pcS1TiSnb+nrIR5w+91uo9w+lB+LdABrGL7MPQJzRyD9KSkVAPwsk3ZD5BknIwI7X3scPwUUhgL6EeVd1d4qTM9FZ9epRXsqQRvyZAOP4tMqQSRIgclx0P4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZN2e6kb8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9839CC4CEFB;
	Mon, 15 Sep 2025 14:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757947014;
	bh=DC9uy+dVdl3WE0T3/WYt5Rj+8+1fLNzMGLUJt/1fWFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZN2e6kb83a8RLhtHiGG11XNIk+RikQBnovHZSe/LBKI7GxxMjokxx21qsamISZjbz
	 y8KiZoJmLPujUBrfyvZENQgd9Wj7anvwB7KTU79GAZt59bhzhSD3nS8Ql6CplWFvdK
	 DO4uWDOtkLejOkBARy+WPRrgdmENTnwAjjZegilKjzUVqtLD7sdgYVldzADSUNkP0R
	 V+LRQl6+jlRXCPInsMkUGfM07/0DPEYSbfbcgUcnwsEYT3lOz7QEX/yV3gaSE2OQfw
	 1EnFieg0pvTk8tmphZh6B4qiAjEAF3RgCKcfNuEX5iv6M0Vas8KYYewZcS1mrCqE02
	 3cig+ofLrp55w==
From: Michael Walle <mwalle@kernel.org>
To: Frank Binns <frank.binns@imgtec.com>,
	Matt Coster <matt.coster@imgtec.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Andrew Davis <afd@ti.com>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH 2/3] clk: keystone: don't cache clock rate
Date: Mon, 15 Sep 2025 16:34:39 +0200
Message-Id: <20250915143440.2362812-3-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250915143440.2362812-1-mwalle@kernel.org>
References: <20250915143440.2362812-1-mwalle@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TISCI firmware will return 0 if the clock or consumer is not
enabled although there is a stored value in the firmware. IOW a call to
set rate will work but at get rate will always return 0 if the clock is
disabled.
The clk framework will try to cache the clock rate when it's requested
by a consumer. If the clock or consumer is not enabled at that point,
the cached value is 0, which is wrong. Thus, disable the cache
altogether.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
I guess to make it work correctly with the caching of the linux
subsystem a new flag to query the real clock rate is needed. That
way, one could also query the default value without having to turn
the clock and consumer on first. That can be retrofitted later and
the driver could query the firmware capabilities.

Regarding a Fixes: tag. I didn't include one because it might have a
slight performance impact because the firmware has to be queried
every time now and it doesn't have been a problem for now. OTOH I've
enabled tracing during boot and there were just a handful
clock_{get/set}_rate() calls.
---
 drivers/clk/keystone/sci-clk.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/clk/keystone/sci-clk.c b/drivers/clk/keystone/sci-clk.c
index c5894fc9395e..d73858b5ca7a 100644
--- a/drivers/clk/keystone/sci-clk.c
+++ b/drivers/clk/keystone/sci-clk.c
@@ -333,6 +333,14 @@ static int _sci_clk_build(struct sci_clk_provider *provider,
 
 	init.ops = &sci_clk_ops;
 	init.num_parents = sci_clk->num_parents;
+
+	/*
+	 * A clock rate query to the SCI firmware will return 0 if either the
+	 * clock itself is disabled or the attached device/consumer is disabled.
+	 * This makes it inherently unsuitable for the caching of the clk
+	 * framework.
+	 */
+	init.flags = CLK_GET_RATE_NOCACHE;
 	sci_clk->hw.init = &init;
 
 	ret = devm_clk_hw_register(provider->dev, &sci_clk->hw);
-- 
2.39.5


