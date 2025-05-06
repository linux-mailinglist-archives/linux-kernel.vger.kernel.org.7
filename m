Return-Path: <linux-kernel+bounces-634793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78634AAB746
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 08:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4E1A4E6751
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 06:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9151C342C59;
	Tue,  6 May 2025 00:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7iG8brE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63052F0BAB;
	Mon,  5 May 2025 23:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486701; cv=none; b=aWV0xcrh0oileFwAkZyUzuLZcf6lY4AlXQlIzvS6ZtK7yocC6YR3dM1TG5S7c4j1LprkQvydIK1E+/HIOOgI8AoGqjq6EWbJZw/+F1uWc3NyQXEXQp92eQeYMFKmR9HK41hPDCqDUxxSdtBr9i51bEWnwOrfoRFVtnvNQvCjc0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486701; c=relaxed/simple;
	bh=YYkf7N+9se8fSBnNL5wvD1zpQJHCh0JM8wOX7SVt/no=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ccNBBWUaqFbbiMR3SmIoIDwu9XvCVmRummdA0m3RPh8sza6WswNVN4SoDVFoA8hq30AJRqZ/Cped84iyYiIa6qDh3G+YySTf7wHpikEOSCI9JarUdv5eFTvJbsrWtCyDBBr9ZBC+1jLtRAEFBCoVwrbzIc8npfE30biuGLPgCf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T7iG8brE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98136C4CEE4;
	Mon,  5 May 2025 23:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486700;
	bh=YYkf7N+9se8fSBnNL5wvD1zpQJHCh0JM8wOX7SVt/no=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T7iG8brEwtHH27RXIP4286cHrajxO0pKz8J1osAQFgzztoko6laOrdogmmaqsr42f
	 VuuANOEBJybz6Q/xCySmjx6dsnR0FKv9LLXhU3PHR1T44vJyEGYTnH5fxEbJhkJ2i1
	 RkgpSu+AmlDP1XGJ18YPYTm5VhtelHA/xGvbPyFgNaQ26BqjruWuf/BRmCvm9BWAuB
	 LsVaOJ7hHOnoHsz5Otkw92iHKuuCL1JM5f/VEjU5FXoIk7PTZkuDX+1CBs4+Io07Z5
	 kdJDiiQmVd3Uowm2qecNiWecmrwyj/UKkBoB1q5C5aCQof5CNp/XIN7WoeQzZ/GvjM
	 +GCRtGul2Up5A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 159/212] ASoC: soc-dai: check return value at snd_soc_dai_set_tdm_slot()
Date: Mon,  5 May 2025 19:05:31 -0400
Message-Id: <20250505230624.2692522-159-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
Content-Transfer-Encoding: 8bit

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

[ Upstream commit 7f1186a8d738661b941b298fd6d1d5725ed71428 ]

snd_soc_dai_set_tdm_slot() calls .xlate_tdm_slot_mask() or
snd_soc_xlate_tdm_slot_mask(), but didn't check its return value.
Let's check it.

This patch might break existing driver. In such case, let's makes
each func to void instead of int.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://patch.msgid.link/87o6z7yk61.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-dai.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-dai.c b/sound/soc/soc-dai.c
index 49752af0e205d..ba38b6e6b2649 100644
--- a/sound/soc/soc-dai.c
+++ b/sound/soc/soc-dai.c
@@ -270,10 +270,11 @@ int snd_soc_dai_set_tdm_slot(struct snd_soc_dai *dai,
 
 	if (dai->driver->ops &&
 	    dai->driver->ops->xlate_tdm_slot_mask)
-		dai->driver->ops->xlate_tdm_slot_mask(slots,
-						      &tx_mask, &rx_mask);
+		ret = dai->driver->ops->xlate_tdm_slot_mask(slots, &tx_mask, &rx_mask);
 	else
-		snd_soc_xlate_tdm_slot_mask(slots, &tx_mask, &rx_mask);
+		ret = snd_soc_xlate_tdm_slot_mask(slots, &tx_mask, &rx_mask);
+	if (ret)
+		goto err;
 
 	dai->tx_mask = tx_mask;
 	dai->rx_mask = rx_mask;
@@ -282,6 +283,7 @@ int snd_soc_dai_set_tdm_slot(struct snd_soc_dai *dai,
 	    dai->driver->ops->set_tdm_slot)
 		ret = dai->driver->ops->set_tdm_slot(dai, tx_mask, rx_mask,
 						      slots, slot_width);
+err:
 	return soc_dai_ret(dai, ret);
 }
 EXPORT_SYMBOL_GPL(snd_soc_dai_set_tdm_slot);
-- 
2.39.5


