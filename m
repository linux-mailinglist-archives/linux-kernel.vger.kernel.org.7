Return-Path: <linux-kernel+bounces-754646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6EFB19A5F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 05:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A5BB3BA56F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 03:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4168220F24;
	Mon,  4 Aug 2025 03:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DL2H5VV+"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5070A1C5489
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 03:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754276788; cv=none; b=aLk4mjtdLZVkc4RLJAVda/FOtoyZFB1VAgHzIFCw2Qi2RYWd9VYFUVMFHp8qdNIyKdRFraq5kmZdbVAiLPJORRv59eMIPTjy3aJbn7qlU2vYkNenDqSmYp+uRGLZJ5wZHfNHm+tg49tMsyEMOet8OgXSTzcIoy0aU2WA4T0IdUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754276788; c=relaxed/simple;
	bh=aRhhJa9/9ViCdgD8GDjba5LOR9SNDQwa3S5lWHQCQEU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hWn8juBHUuNnikK5rMePIdcTh+bX2fjmzzQZdWxmkTxT9PKBDcfkcR78Fi56q3KfbJ9KV6c2EAOsNzBF+Aqfww3bcu1EnsNVbiVj6NBoUrMi8pOoLg4/xnlz0M9BW7F95TQFl+pjuhaGUXNl4ASE3Jpqmv6300reptu8uQzef6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=DL2H5VV+; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=5u
	ajuGA4O8ZmH1OAMXAjwo6x5Mp+YdmlXiyesPEcWhs=; b=DL2H5VV+94vSCReGJz
	AJEnHd0lalLN2Dn7kWqFuFOYXCUJSL8FY8k0u8uAVJLeefhgmvjJMXlhCUQcfCje
	rbmex0irmeYWK25KNYORDtXQh33+PAQVpEEq1oFsvWOZTF9j4X80Tv60BcPcQ8j4
	tiWZKlTCPLUVtHJ4ymWCVEjV0=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wBHOs5_I5BoPnvzJQ--.25158S3;
	Mon, 04 Aug 2025 11:05:44 +0800 (CST)
From: wangdich9700@163.com
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	linux-arm-kernel@lists.infradead.org,
	wangdicheng <wangdicheng@kylinos.cn>
Subject: [PATCH 2/2] ALSA: hda/realtek: Fix ALC662 codec pop noise on recording
Date: Mon,  4 Aug 2025 11:05:18 +0800
Message-Id: <20250804030518.424229-2-wangdich9700@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250804030518.424229-1-wangdich9700@163.com>
References: <20250804030518.424229-1-wangdich9700@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBHOs5_I5BoPnvzJQ--.25158S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7tryfJr1kWry5AF15CFyfZwb_yoW8XrWrpr
	WfCFyfWF47Jryjyw18tw47u3W8Ga48ZrW3C3yYkw1xJrsY93s3KF1fA3srZFW2kFZ0gFWj
	vr1rta4kXrWYkF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jfeOJUUUUU=
X-CM-SenderInfo: pzdqwv5lfkmliqq6il2tof0z/1tbibgSfT2iQGr-xBwABsQ

From: wangdicheng <wangdicheng@kylinos.cn>

Pop noise originates from unstable mic_vref during power_save transitions.
Remediation: Disable VREF at resume, delay 1000ms before re-enabling to guarantee circuit stabilization pre-capture.

Signed-off-by: wangdicheng <wangdicheng@kylinos.cn>
---
 sound/pci/hda/patch_realtek.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 88675eae9447..665e291dea75 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -997,16 +997,21 @@ static int alc_suspend(struct hda_codec *codec)
 static int alc_resume(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
+	int vref_delay = 0;
 
 	if (!spec->no_depop_delay)
 		msleep(150); /* to avoid pop noise */
 	codec->patch_ops.init(codec);
 
-	if (codec->core.subsystem_id == 0x10ec1304) {
+	if (codec->core.subsystem_id == 0x10ec1304)
+		vref_delay = 2000;
+	else if (codec->core.subsystem_id == 0x1b505809)
+		vref_delay = 1000;
+	if (vref_delay > 0) {
 		snd_hda_codec_write(codec, 0x19, 0, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x04);
 		msleep(50);
 		snd_hda_codec_write(codec, 0x19, 0, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x44);
-		msleep(2000);
+		msleep(vref_delay);
 		snd_hda_codec_write(codec, 0x19, 0, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF80);
 	}
 	snd_hda_regmap_sync(codec);
-- 
2.25.1


