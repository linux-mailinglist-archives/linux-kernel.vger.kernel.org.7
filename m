Return-Path: <linux-kernel+bounces-822616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7A6B84533
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 13:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62E2A3A510D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 11:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A8E301032;
	Thu, 18 Sep 2025 11:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OV2lcIeG"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D03613C8FF
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 11:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758194499; cv=none; b=jn+8DhXnQgRtYFTzsE5lo7Q1OJJLUTK3gOxDQy2trUA82PIWSTo58IQ998t+BmSFUWqgPHzSK6W/ihVVaNRtEWcb+H9yVCmMkDFUYTsxaDwI0hiks1OXbEST068USY74wFu91YXo2kc1BVlD10x/L50NfyQS6run9UCqY25k9iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758194499; c=relaxed/simple;
	bh=WEa6is6m16w0o1GnlTpu4Z4MOHk4RhV2VSpcw14U1VQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r8iFzR8TtrpscwP1VqgMs2lqIIi4ytftzrdS6IrkLX0jif8mHiSlXFbYUVUHvO+Q49Y0DlYXZYcL2nmR8CdQ/ucnJr+lZInNwa5SQFCG6xvldUD9pxI8mdVLNE03hpp/CS6W1ywpbtEI0zTESWguFuiUk2n8pTuiW2K5iofkVq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OV2lcIeG; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758194484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=33NI10JupNvzF5LVk088MZ+tWcPvXkOtTzuIPkgIQlE=;
	b=OV2lcIeGO4gg71RHX8vqR+xJ1Kdl1nvhZ+LCImJeLBcA8n7apT6HhRPvU2oZ/VtqZ22kC1
	hFfrqTVvTvdAlWllI+eBNmJhyZJ01qXoiwWkO5QvEwQrziAHrOnNXp5H3lwniaXxMVGkIR
	juG1QjQX/mspF/P43V12sAub1fCG9LY=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-arm-kernel@lists.infradead.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: pxa: Return -EOPNOTSUPP instead of -EINVAL
Date: Thu, 18 Sep 2025 13:21:02 +0200
Message-ID: <20250918112102.64314-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Return -EOPNOTSUPP from mmp_sspa_set_dai_sysclk() instead of -EINVAL for
unsupported clock ids, and remove the obsolete comment.

Replace other -ENOTSUPP returns with -EOPNOTSUPP to comply with SUSv4
error code guidelines and silence multiple checkpatch warnings:

  ENOTSUPP is not a SUSV4 error code, prefer EOPNOTSUPP

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 sound/soc/pxa/mmp-sspa.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/pxa/mmp-sspa.c b/sound/soc/pxa/mmp-sspa.c
index 73f36c9dd35c..38815ca8f152 100644
--- a/sound/soc/pxa/mmp-sspa.c
+++ b/sound/soc/pxa/mmp-sspa.c
@@ -111,7 +111,7 @@ static int mmp_sspa_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 	int ret = 0;
 
 	if (dev->of_node)
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	switch (clk_id) {
 	case MMP_SSPA_CLK_AUDIO:
@@ -121,8 +121,7 @@ static int mmp_sspa_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 		break;
 	case MMP_SSPA_CLK_PLL:
 	case MMP_SSPA_CLK_VCXO:
-		/* not support yet */
-		return -EINVAL;
+		return -EOPNOTSUPP;
 	default:
 		return -EINVAL;
 	}
@@ -139,7 +138,7 @@ static int mmp_sspa_set_dai_pll(struct snd_soc_dai *cpu_dai, int pll_id,
 	int ret = 0;
 
 	if (dev->of_node)
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	switch (pll_id) {
 	case MMP_SYSCLK:
-- 
2.51.0


