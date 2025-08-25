Return-Path: <linux-kernel+bounces-785057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D756B34545
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 17:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8DD81728A6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 15:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803B82F360C;
	Mon, 25 Aug 2025 15:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KYLoyNCk"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE5B2F83BA
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 15:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756134684; cv=none; b=fzCELH+RSKHQlcD7MlzDnlTmAp2RSmVChAjjTrsdHwmtuPzKxRO4j0ycQhOF7Q91JwfIjtKODUOUWrRF4sXVwWiuFrigDNViuJu8r6nVotGm+n7ysLfkl7d2bpvc0PT7suAk4dICDvrDLTez5MIiw0KgELzzdV3pZVQVbhzMkUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756134684; c=relaxed/simple;
	bh=6aWYKlqmLmN65SZrSdpzfteiFn/NWrcOVSYzCVaVo8k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rz/BEA7RVHd14+BqUfcWjloO0Rzg5kolDdYDCjBOCTEUUI+NDOt64OFnhmgs6GZLgUYvjm0NeemzXAj4ByasXofQwPjj2ulqOF8yjzhNZO2+7sBpwktL42E0jLE2SkXIg1xyIEVfbO4nmm62M83NMXyqj+W/UAXXQuK1Tp04V+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KYLoyNCk; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so3998216b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 08:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1756134681; x=1756739481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UYv1SFw8KHRTBAs11RxrIjSXI0+Dq/l8nNXuXGxjK1Y=;
        b=KYLoyNCkbbNHWe05MTlksYWH/jJao9Nks6d8wYamyAvmlfXiZKeb1Og7Uasz0EbFdO
         rVq9q9K/MYiaRA+J31+sHtqEA8NaRlkc4UdSudsvJ3Hl+9BGLCZGoSBEbuQNEs+pc+iM
         MQl/x2ugqT98WbVX8DBqdiDRxyv2AGuQD87J4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756134681; x=1756739481;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UYv1SFw8KHRTBAs11RxrIjSXI0+Dq/l8nNXuXGxjK1Y=;
        b=fUV8XwJ3wnG28ECYm117TfGQMI5LNwGelcWPryzOUEshJblSlmtJqL+lDHglilW2UD
         7o4xv/0+G5ltnsnakjprCb/mMJazkngLbDm/QVVefZKP8ZPF5owIOPF893k6c2VCrOAT
         wiUHOUCcOZ4zo52U0hTeWJZ/Q9ouh8uiDquC6SGr7kCsnVjZF8EesXsypRVqCLA7o6zR
         mJAXF9JHDYf769MYl/OI9JBdvMwQH4h3L3RHbuLuyVFmSBfZC6wHvvoI9abY0W/o/RVD
         56+cGDGtNbjuws2f1cu88IfIUECswQY6z8+IUv9Hk5HChLgfpDF3NnoI5lg8R3bmeVmD
         bo6g==
X-Forwarded-Encrypted: i=1; AJvYcCU9o/RXjGrK3/D5UR8SBs8mGlK78LUFV6u7kVu3cy9gATKL1OvMUag4frFqDPrF8LMXV6cnYa6RnLkmj4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiSg5UYLLS+McZ9sAiINSXjUns3mHJNyHYHHkskHR7DwLPq/t8
	9+yTHzqN3pCMiO4GXeYY5mTQS9HqO7i88e08MffDD1FEeDxaW0FwynK1oe19KtxFmA==
X-Gm-Gg: ASbGncvPSeLeNgdJTbtvJxtZQCL+eBFlsji1u9QVUUd9PcdAKQEAvGW9jbs08g7iiHa
	fYPFkTdZNAzD72cACrFkI5dbiHdxBI0MEKEx+iLawWAPPKktnSQYjVRs8nmhgCEFb3T3lhCtOO+
	1vBFuNN1To1ZOYUJhuGF42VkEoqWlFBa7ai98XbxnIfAad8BYzUD6an/aDMB5inytP94i1sBlhD
	utz/5wtyS0U5Rb6AwGIGFirx0RFRCXWxrE0glDRvJ+DuW4lUMiO3gigXF2nDI/uzzYz3gdUjjQg
	fmhUiMzuBkbGptYkKfmlFdxxVxVOxIerUUPnYCZJFSHTD7MszhNZzcm7pqwM/lP/ofzjhCxBe3x
	aclY+csIMl55MvMXUI2GA1L0QbmLHwfYDoFyq1ho+
X-Google-Smtp-Source: AGHT+IEdQuMc4qvfjOIBTCp/6aJwd6EcXET57GS+m3OZRdtWe1hoQXNFWqvIycN2W/2OBfSyp1B9yg==
X-Received: by 2002:a05:6a20:7f85:b0:240:30c:273e with SMTP id adf61e73a8af0-24340c42b16mr19202183637.15.1756134680661;
        Mon, 25 Aug 2025 08:11:20 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:d5a9:711e:13f5:e60f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cb88fac4sm6956517a12.9.2025.08.25.08.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 08:11:20 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] ASoC: mediatek: common: Switch to for_each_available_child_of_node_scoped()
Date: Mon, 25 Aug 2025 23:11:09 +0800
Message-ID: <20250825151111.3696404-1-wenst@chromium.org>
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
Changes since v1:
- Dropped unused variable
---
 .../mediatek/common/mtk-soundcard-driver.c    | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/sound/soc/mediatek/common/mtk-soundcard-driver.c b/sound/soc/mediatek/common/mtk-soundcard-driver.c
index 95a083939f3e..a2a30a87a359 100644
--- a/sound/soc/mediatek/common/mtk-soundcard-driver.c
+++ b/sound/soc/mediatek/common/mtk-soundcard-driver.c
@@ -89,40 +89,31 @@ static int set_dailink_daifmt(struct snd_soc_card *card,
 int parse_dai_link_info(struct snd_soc_card *card)
 {
 	struct device *dev = card->dev;
-	struct device_node *sub_node;
 	struct snd_soc_dai_link *dai_link;
 	const char *dai_link_name;
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


