Return-Path: <linux-kernel+bounces-781196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F545B30EEA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 08:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF2F1601482
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 06:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CF62E541C;
	Fri, 22 Aug 2025 06:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="laqojCAz"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDF22E5405
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 06:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755844074; cv=none; b=KE0QF5kepWV3UTJ9eo2tei6vBSFFxT+xdTRcDsqV0pzHuAER6y+3uzQzdbcYyLUQUyFIiNX+pX7wiZ21UPhXqSv4Si4QG+rNi2fcjwRHrPfTP7+dGiV87IOCbQwssBhRGpSq2/lZBpZZa5ztAOxjUObLMIMCzGFAqbW0dxBezPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755844074; c=relaxed/simple;
	bh=9ATXq32utM4kfVagp8Kf92pg+poNWX+xRDXTF9eH0no=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qVBIuF1jV9E169pWlCJqIDovkvgectFhO3iBXWJu+vcnsWtZVOyAiZLwbNmD7sg45kanscG0sQaPQA2NJxhy00KUeyX0qjfgd6DlTpDKiITUxCU83t+QN+ggwCexmuVqrvncm38egPscM2cwYkrpEdcFEXr0BiRdfxy3VeCiFg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=laqojCAz; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2445806e03cso21753085ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 23:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755844072; x=1756448872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a74RVsak1TLYR6bws4zrQXpjsmVG5raUd4MS/ii7fb8=;
        b=laqojCAzLZa9/WRZm+IstdDYaLUAFmgD17Zw3GwUJIPkXuFXCkHz2IMrxXKVSGZUpw
         iTS1o+4yGjzvm/0hi6JpbKv2LwdeCYT+Cs98B9x9JJvrH6K25PB31kiJRLP64Vy4suLy
         4DigazfWlTPD1HizQ9XnWm/3PSQSBdBRLemI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755844072; x=1756448872;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a74RVsak1TLYR6bws4zrQXpjsmVG5raUd4MS/ii7fb8=;
        b=ETMpbiOTD6+zKpZ0SYx2XIoQ41QqKgHZ2EvJJtdhO5m1m5DnX8Vv6AMSikmdgzF4Y3
         x1TwC27luvn+M9z/OR+g/x+dAYbhLexd/ObyeuoWxyT+kD8qY8h6keLNjgWgU1bwavZ+
         7p5I9wKyxuNpCU4u68SSvCcxSfnFs+IUlDBvRuumtQn6q4L54dHBWqzGiCANb2jwHEGN
         ylkNLjj4UMC0JybmWcHqrgUmL88oK1XddFg9Zup4+iRRTbuQGYVMElwW978nS2rrtmXx
         QT4dOSG4YeN5RnkBI63D9EWXAhoE3r8nH7l51LREUGfBi8NlAY+zttFm50Q5FbODd4T/
         ZCfA==
X-Forwarded-Encrypted: i=1; AJvYcCXzBmhuEYqGrXjt30EbSibrYyFUwAF73djdkwxAhoV6la8e2aX4lbFJjNKKB+O08jet0TKtqFu++hJz/hg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv8jmOdcSySF4CQXkub138m+sdmu7SwBccT71Wil9CUAe9t0CK
	lXmhiiO3j5W0mlOTlc8/O0NAngd/wzvpC2adZSPikDcEauuxt9r3sJzR/iqy92Wqzw==
X-Gm-Gg: ASbGncvwqaTQDPqGPHqd6A4iRopjoXCOAG0SEYswHEzSDp9gt4UNypNy/+ngndw3opG
	BFgv5G+knMHPW7HtbysqsAOYYMOJ43mvSORek4H6toy90FykGBJrY/ud5thePFXkpspCmm3Ty/C
	e1KWGCbZ63QnsK34q/L3A8AgJqNgFKl4371zN8u+PZxQvGfE35hF0Ra7BLnSAqVIi+V4QZV/lzf
	VyFe1Hm7l8TDZmAZRPJJpdzn2jFbhZXBGhrnRbCMzxXauOaDNUqDap2LVpN0EWLNeuuiAc5HjKR
	ZbUZz1P/tOS7VXDuHT0hKzjjw7PGkQoy2u5/+Wabs3h/xejaCz2OaYqG/FVUT+MbtSDDu+YnqME
	3CHnKUsr4X/1NPDBLNPJs6lR14swXa/TPsY6rROJqbo2TLEcqShk=
X-Google-Smtp-Source: AGHT+IF4m2GD74ARWQ90O62WKvsqVkiAGFVrRDGXDAa8grwxDZefBXzvdvCU1/9OIzJpcFb0Leq+aw==
X-Received: by 2002:a17:902:c402:b0:246:464d:118a with SMTP id d9443c01a7336-246464d12bbmr7066525ad.46.1755844071478;
        Thu, 21 Aug 2025 23:27:51 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:8278:5411:367e:2f11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2463606470asm11813375ad.14.2025.08.21.23.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 23:27:51 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: mediatek: common: Switch to for_each_available_child_of_node_scoped()
Date: Fri, 22 Aug 2025 14:27:37 +0800
Message-ID: <20250822062738.2632746-1-wenst@chromium.org>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using for_each_available_child_of_node_scoped() allows us to get rid of
of_node_put() calls from early returns or breaks in the loop. It also
fixes issues with missing of_node_put() calls.

Switch to for_each_available_child_of_node_scoped() in parse_dai_link_info().
Also drop the braces around if blocks now that the inner block is just
one statement.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 .../soc/mediatek/common/mtk-soundcard-driver.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/sound/soc/mediatek/common/mtk-soundcard-driver.c b/sound/soc/mediatek/common/mtk-soundcard-driver.c
index 95a083939f3e..1e3b43fbb16f 100644
--- a/sound/soc/mediatek/common/mtk-soundcard-driver.c
+++ b/sound/soc/mediatek/common/mtk-soundcard-driver.c
@@ -95,34 +95,26 @@ int parse_dai_link_info(struct snd_soc_card *card)
 	int ret, i;
 
 	/* Loop over all the dai link sub nodes */
-	for_each_available_child_of_node(dev->of_node, sub_node) {
+	for_each_available_child_of_node_scoped(dev->of_node, sub_node) {
 		if (of_property_read_string(sub_node, "link-name",
-					    &dai_link_name)) {
-			of_node_put(sub_node);
+					    &dai_link_name))
 			return -EINVAL;
-		}
 
 		for_each_card_prelinks(card, i, dai_link) {
 			if (!strcmp(dai_link_name, dai_link->name))
 				break;
 		}
 
-		if (i >= card->num_links) {
-			of_node_put(sub_node);
+		if (i >= card->num_links)
 			return -EINVAL;
-		}
 
 		ret = set_card_codec_info(card, sub_node, dai_link);
-		if (ret < 0) {
-			of_node_put(sub_node);
+		if (ret < 0)
 			return ret;
-		}
 
 		ret = set_dailink_daifmt(card, sub_node, dai_link);
-		if (ret < 0) {
-			of_node_put(sub_node);
+		if (ret < 0)
 			return ret;
-		}
 	}
 
 	return 0;
-- 
2.51.0.261.g7ce5a0a67e-goog


