Return-Path: <linux-kernel+bounces-887874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C3DC39470
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 07:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F4253B60E7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 06:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE992D8781;
	Thu,  6 Nov 2025 06:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="hGlgaP/q"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B489728000A;
	Thu,  6 Nov 2025 06:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762410995; cv=none; b=N7SR7SkcnuT+wkr1o83D6HBZv34LWQNYlg+gffFpwjcXVblGWwB0LzzmA2g2bysOlDo3u+khGYmpMDDvZSQGhiBIjj1TyyxQJ//DL+JbJrF8Y2sI5jJG7KBx/iuWijQgB8aKWRVRxSVuJTF92pBJWTT4bOQjnewCYKvG0hQBjnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762410995; c=relaxed/simple;
	bh=ccI7w72smvenBTyrW2Fi5iyGpbN34hShK/Sq9W07v4c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pWguW5FbSgtcaVTco8295ox8ur3USOCJqqQdZJwrnQuq4c/YvqQkUsQLZu+9j/e0KTOw36z8iafJCU3ko32gBmBGzWJrdMCrR0OyhVM4Ae6pHE9Woi6UlEoq7dtNu1ghmmyaMlblGhG0XISjRLAyUXQzY5Fvh4LMkU4HvJUrA6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=hGlgaP/q; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=0e
	ZVXCKfTD48oWYcUMSXO8jVUm+ueuSjn9uH27gyeaY=; b=hGlgaP/qeA0CQHhcNY
	PrU17XnS3DM/cP3CDHuQor9GP0CS+2JuCghku+RtL4j5GX+S3EMLvnNpPhEEtZbi
	iw7sSdxxW5yiY0cMrDlIACU3zROPOf6Zlkjmq1CxtByTmm9PJ8bmDr4kZxev0QvQ
	fgohQFdbLTSp6FdyZ+7Q9Or8o=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wBncUrNQQxpei_XBw--.6726S2;
	Thu, 06 Nov 2025 14:35:58 +0800 (CST)
From: wangdich9700@163.com
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	wangdicheng <wangdich9700@163.com>,
	wangdicheng <wangdicheng@kylinos.cn>
Subject: [PATCH] ALSA: hda/senary: Fix potential resource leak in set_beep_amp
Date: Thu,  6 Nov 2025 14:35:46 +0800
Message-Id: <20251106063546.115197-1-wangdich9700@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBncUrNQQxpei_XBw--.6726S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7urW8WFWfCr45tF13XF4kXrb_yoW8Jw1DpF
	1fG34rtFsxJa92yr4rGa1UW3Z3Wa4kWF15JayUKw1fZF4Yyr48tw1rtw12ga1rKrWI9a13
	ZFy2vF1UKa98AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pi-zstUUUUU=
X-CM-SenderInfo: pzdqwv5lfkmliqq6il2tof0z/xtbCvw7gMGkMQc6UkwAA3M

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


