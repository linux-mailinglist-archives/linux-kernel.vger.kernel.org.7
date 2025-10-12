Return-Path: <linux-kernel+bounces-849770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 179FBBD0D66
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 01:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51E9B18935F0
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 23:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E0D2EBB86;
	Sun, 12 Oct 2025 23:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b="tBxvfyM5"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1592E212568
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 23:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760310537; cv=none; b=PUcdl3nSu2eBWfbZK5krH4mUTQDnyKB7fUy6dVaRwiVOyb0V43IZct5Z4Zk71TNkyWmUFMaVKDjHLKazNBEzGgP/f+F26Fx6F3raod59ipg7LLA/xxM1hb8LV6a1K5W+5dCoXr+sLrqLbjHWFz4z1dyb3P1PYzMViDvF81WdbIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760310537; c=relaxed/simple;
	bh=FrgeO9jAQ13cWTQoQ8ZjMCCa9xelIk+ejwmInmLMfpY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oHNURiK/WburFDAJLw8wJ2JQErmWCdoTR3iHHMS4aJdA/u5gX6dSpl7vKoGNykJ4cphMIadMe3/4O5rV/hotRlHPBJARtIL7yfCeOxcO1i9UpoKYAspIBIs7YwOu1ZpJDDwjVseWj9sJPxtNSfK9mgWbjbfb0X9dTQ1YVqe3x4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool; spf=pass smtp.mailfrom=packett.cool; dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b=tBxvfyM5; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=packett.cool;
	s=key1; t=1760310533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qfhZrhYFtMSLWRRAHazHk/R5uWWKEYTL6cwb+TfTWeI=;
	b=tBxvfyM5iX0sxh8othw28Ip5LCQ81nppXf8uXsHR4bUpDvVo10RzQeLk5zZtQ6pwiE6Hfp
	vXFuixsc4Qylvon+Nuehb5QefLnTP/7meW2FgC2aE+4O+QtT3b30MUaX64gnPA2mDiSE26
	e55DPcnNGjXHSSFjlXJv+mT3bam6mJxhtKjhRTEwM0HBzWYLRIpBaqgxgBHcuePvsdorYy
	v9sRUkJ19sQGjJ04foe8fuCJHOZ143xsBiepgROMyula/yv/Mfq/B3qkG+kTskxHIy9XcJ
	qQ4VvlyoXEcqZlTixoDJ66KFLLKKGlsz2H0X71JEQZDgzGGRqaSewpl8emWR5Q==
From: Val Packett <val@packett.cool>
To: Bjorn Andersson <andersson@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Val Packett <val@packett.cool>,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] clk: qcom: gcc-x1e80100: Enable runtime PM
Date: Sun, 12 Oct 2025 20:06:59 -0300
Message-ID: <20251012230822.16825-1-val@packett.cool>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Enable the main clock controller driver to participate in runtime
power management.

Signed-off-by: Val Packett <val@packett.cool>
---
Seems like this would be one of the prerequisites for actually reaching
deeper power states.. I've been running with this patch on a Dell
Latitude 7455 for quite a while, did not see any harm for sure.
---
 drivers/clk/qcom/gcc-x1e80100.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/qcom/gcc-x1e80100.c b/drivers/clk/qcom/gcc-x1e80100.c
index 301fc9fc32d8..96bb604c6378 100644
--- a/drivers/clk/qcom/gcc-x1e80100.c
+++ b/drivers/clk/qcom/gcc-x1e80100.c
@@ -6721,6 +6721,7 @@ static const struct qcom_cc_desc gcc_x1e80100_desc = {
 	.num_resets = ARRAY_SIZE(gcc_x1e80100_resets),
 	.gdscs = gcc_x1e80100_gdscs,
 	.num_gdscs = ARRAY_SIZE(gcc_x1e80100_gdscs),
+	.use_rpm = true,
 };
 
 static const struct of_device_id gcc_x1e80100_match_table[] = {
-- 
2.51.0


