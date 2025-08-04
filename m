Return-Path: <linux-kernel+bounces-754647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6272BB19A60
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 05:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 918BD176B3F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 03:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B1B2206BB;
	Mon,  4 Aug 2025 03:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="V7JUQ43v"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D17622129B
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 03:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754276796; cv=none; b=qn/IzGv1mKHbEmlhrUdEdSNZgFOjJSTde9ktFZMRcHapeU+ccNKarBDILveAfsW41qUEFgDUKWASPu8I9ZGWfYoEeQvkqRKqh57TgDJjds4Fei5ryGPu9qrGenkDyc5niOdpyfNjFtFxLN/xZvlwTqOOBbJNUPOUf1TL6/JmeEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754276796; c=relaxed/simple;
	bh=XKr5AQLTpe/9o2Ut4mAq8cRpm/bxnnJLpr/to5+kjwI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NIlttaW7+b2iSRltAMhu0T5v/d1thqyvQZGpGKD4CSoTECXFnyoBWMpRODiq/ZA1WwC8ESUHw92ImHy0ZJRRibPco6AbgTs42OHo9hXamhMxcvQa2N2FayzWE0DOumBUn9DWnBB87qB+D5xoVTX3eAHFzSZhijiEhuTsuEPJR+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=V7JUQ43v; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Ys
	qQmWamYIYco22fUSPqUsEq0HJ6AU5htrVCYU+nqmE=; b=V7JUQ43v2It6MWY9oK
	7cPQOitHNMn/Bmbm0xRNn4pPkgBgAR6rxWPWE0HaaOPt4jJZjCKFcKKV2WEmd0XS
	Tl2Talb1JlOkjlM+0Mer0VDVSWCrVV1xEEs5gsMgVFRU4SlZE7GDRuFT8HdljgSh
	Xst/KdJA+5ZnV0dJJ2vYmHjLs=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wBHOs5_I5BoPnvzJQ--.25158S2;
	Mon, 04 Aug 2025 11:05:39 +0800 (CST)
From: wangdich9700@163.com
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	linux-arm-kernel@lists.infradead.org,
	wangdicheng <wangdicheng@kylinos.cn>
Subject: [PATCH 1/2] ALSA: hda/realtek: Accelerate the front MIC charging and discharging of the 897 codec
Date: Mon,  4 Aug 2025 11:05:17 +0800
Message-Id: <20250804030518.424229-1-wangdich9700@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBHOs5_I5BoPnvzJQ--.25158S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZF13Xry8XFW8uw1DWry8Xwb_yoW8JFWfpr
	WrCFy3XFs3Xr4jyw48tr4fua4kGa45ZrW3C3yYk3W7XrsxuryktFyrG342v3W7KFWYkr1j
	qr1Fy34kJ3y5Kr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UZ6pQUUUUU=
X-CM-SenderInfo: pzdqwv5lfkmliqq6il2tof0z/1tbibgSfT2iQGr-xBwAAsR

From: wangdicheng <wangdicheng@kylinos.cn>

The front MIC capacitance of the Inspur board is too large, resulting in a longer charging and discharging time required,
which in turn prevents recording for 5 seconds before startup.
Therefore, software is used to increase the delay by 2 seconds to avoid this issue.

Signed-off-by: wangdicheng <wangdicheng@kylinos.cn>
---
 sound/pci/hda/patch_realtek.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 877137cb09ac..88675eae9447 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -1001,6 +1001,14 @@ static int alc_resume(struct hda_codec *codec)
 	if (!spec->no_depop_delay)
 		msleep(150); /* to avoid pop noise */
 	codec->patch_ops.init(codec);
+
+	if (codec->core.subsystem_id == 0x10ec1304) {
+		snd_hda_codec_write(codec, 0x19, 0, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x04);
+		msleep(50);
+		snd_hda_codec_write(codec, 0x19, 0, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x44);
+		msleep(2000);
+		snd_hda_codec_write(codec, 0x19, 0, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF80);
+	}
 	snd_hda_regmap_sync(codec);
 	hda_call_check_power_status(codec, 0x01);
 	return 0;
-- 
2.25.1


