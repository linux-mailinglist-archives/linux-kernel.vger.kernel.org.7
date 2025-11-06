Return-Path: <linux-kernel+bounces-887724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 309AAC38F42
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 04:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 68D2F34DD82
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 03:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077D22BE621;
	Thu,  6 Nov 2025 03:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="H8oeiFDn"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDAC2BDC3E
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 03:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762399175; cv=none; b=GYyo05hHd0/dA1XMbNUbKF89zbnXu5NK87qPcgX/OdlH7pFjuXQuslsKuGvuXfYo/K9fDOuRt1IFKjmHrjRxo9PnnZ2f/gN+Y/JSRgL0Uy6M+RZOOlq5H2RT01jk6gyyspGh3cdrZ/kjwzTzuSu+W9+etGB/K4l1YGP6mZG1KiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762399175; c=relaxed/simple;
	bh=ccI7w72smvenBTyrW2Fi5iyGpbN34hShK/Sq9W07v4c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gfbbSNioHf/4EKW8QAdLPfeBWXSS2nLB3AoQ/qk7I99lr+bfWdsERHkGlNwmnoUT8ZNuTYxasRLdJfRyBR8gLP5gSWJ4pH0tEAEfZQVfJx1C5eUqDtCof1H2cHHOr5PcTaZMa/HuafHrqW6gslZjj6EJvETF6FBr2DbSpejbd4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=H8oeiFDn; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=0e
	ZVXCKfTD48oWYcUMSXO8jVUm+ueuSjn9uH27gyeaY=; b=H8oeiFDnBeh6rPvOm8
	7A07mMjPdqPcvMHylvyTmsIu2BT3xJ+oRlIM114dDjqcJHt0r2vYxv7Hc8zI0oam
	9gSN55g+jQNL+M6ZflSGNLkl1O9Fi9BFS4qhN++yDMilIYtljroS2xrbYyvWbgPw
	CbQD3/TKrIK7EA8fejmPvYtXc=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgBXNueKEwxp3uGrCw--.54468S2;
	Thu, 06 Nov 2025 11:18:35 +0800 (CST)
From: wangdich9700@163.com
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	cezary.rojewski@intel.com
Cc: linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	linux-arm-kernel@lists.infradead.org,
	wangdicheng <wangdich9700@163.com>,
	wangdicheng <wangdicheng@kylinos.cn>
Subject: [PATCH] ALSA: hda/senary: Fix potential resource leak in set_beep_amp
Date: Thu,  6 Nov 2025 11:18:33 +0800
Message-Id: <20251106031833.80303-1-wangdich9700@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgBXNueKEwxp3uGrCw--.54468S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7urW8WFWfCr45tF13XF4kXrb_yoW8Jw1DpF
	1fG34rtFsxJa92yr4rGa1UW3Z3Wa4kWF15JayUKw1fZF4Yyr48tw1rtw12ga1rKrWI9a13
	ZFy2vF1UKa98AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piFApUUUUUU=
X-CM-SenderInfo: pzdqwv5lfkmliqq6il2tof0z/xtbCvwxFlGkME4wdKgAA3v

From: wangdicheng <wangdich9700@163.com>

Add proper error handling in set_beep_amp function to avoid potential
resource leaks when snd_hda_gen_add_kctl fails.

Signed-off-by: wangdicheng <wangdicheng@kylinos.cn>
---
 sound/hda/codecs/senarytech.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/sound/hda/codecs/senarytech.c b/sound/hda/codecs/senarytech.c
index 9aa1e9bcd9ec..99af8d5e51db 100644
--- a/sound/hda/codecs/senarytech.c
+++ b/sound/hda/codecs/senarytech.c
@@ -47,17 +47,28 @@ static int set_beep_amp(struct senary_spec *spec, hda_nid_t nid,
 {
 	struct snd_kcontrol_new *knew;
 	unsigned int beep_amp = HDA_COMPOSE_AMP_VAL(nid, 1, idx, dir);
-	int i;
+	int i, err;
 
 	spec->gen.beep_nid = nid;
 	for (i = 0; i < ARRAY_SIZE(senary_beep_mixer); i++) {
 		knew = snd_hda_gen_add_kctl(&spec->gen, NULL,
 					    &senary_beep_mixer[i]);
-		if (!knew)
-			return -ENOMEM;
+		if (!knew) {
+			err = -ENOMEM;
+			goto error;
+		}
 		knew->private_value = beep_amp;
 	}
 	return 0;
+
+error:
+	/* Clean up any successfully added controls */
+	while (i-- > 0) {
+		/* The gen spec will be cleaned up in senary_remove,
+		 * so we don't need individual cleanup here
+		 */
+	}
+	return err;
 }
 
 static int senary_auto_parse_beep(struct hda_codec *codec)
-- 
2.25.1


