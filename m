Return-Path: <linux-kernel+bounces-887690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B9AD9C38E1D
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 03:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 390A234D890
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 02:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F9521C9FD;
	Thu,  6 Nov 2025 02:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="flx61ELH"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92371A9F84
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 02:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762396753; cv=none; b=b7yICVsRySXnTBbN1uIR87OFcz6Dty2nG4uvvDkMXYj+uG7ttqMnt8VEZ6hzl8pkCf/WPnOPTmShleyDi7fqwg2Nr+A5X7YGP/XsBtF6EEocIuMFe51RXDnEH+O92anlE4/9+O1rTPrOzYIkgSNcyWiw6YhuDhEoDUBrcNKrM5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762396753; c=relaxed/simple;
	bh=BA5DN392L5pMC/hE704tkepVLlbE3jtRvAkCi+fzRaA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Gw+WBc3WJQExvIJHhv70KU2hzKpCJYALGxXX6BbFBq8DBxU+reZA1RmXjVBmKBaFfegjb08yMRWwpzZCGlBGEi/TVabC0ZyMFMu8KA7cVyvDmght96duI18uwVkDQkp30IsOzaeeGEnFYR/t5hIrz/GqH8py0yESvIkn4p12FgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=flx61ELH; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=0b
	4R35jSS/yUbZ/j8tv6hexOvyBCIsa6naKN2CvBI5A=; b=flx61ELHtHf/djU+6x
	qzS+D/GFkbb1BCYVzBwK/9kA2yPjxHR8NfnNGcu+JZFrotnLBzs3pJR/J7viZdo8
	LUOb+8XCZXjpsM9mMoFwfybCROk4GILxlBdipeAbj3Y8NLtbia76l3/BGFQ58WJs
	pb42bhUVuQUqzK5x8/JlsixIU=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3B_kSCgxpGD7kBw--.791S2;
	Thu, 06 Nov 2025 10:38:11 +0800 (CST)
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
Subject: [PATCH] [PATCH v3] ALSA: hda/conexant: Fix pop noise on CX11880/SN6140 codecs
Date: Thu,  6 Nov 2025 10:38:09 +0800
Message-Id: <20251106023809.70002-1-wangdich9700@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3B_kSCgxpGD7kBw--.791S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXF1kAr47GrW3XrWkJr4kCrg_yoWrWF17pr
	15Ka43K393JF1Ivr4fJr48A3WFgF95WFsrJw13t3W3JwsxKryxWa1jgryxKF1rJryqgry2
	vF429FWUKr45AF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piOBMAUUUUU=
X-CM-SenderInfo: pzdqwv5lfkmliqq6il2tof0z/xtbCwBPjM2kMChNt-gAA3s

From: wangdicheng <wangdich9700@163.com>

Pop noise mitigation: When headphones are unplugged during playback, mute
speaker DAC (0x17) immediately and restore after 20ms delay to avoid
audible popping. This fix is specifically for CX11880 (0x14f11f86) and
SN6140 (0x14f11f87) codecs based on testing verification.

Signed-off-by: wangdicheng <wangdicheng@kylinos.cn>
---
 sound/hda/codecs/conexant.c | 73 +++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/sound/hda/codecs/conexant.c b/sound/hda/codecs/conexant.c
index 5fcbc1312c69..f2f447ab749e 100644
--- a/sound/hda/codecs/conexant.c
+++ b/sound/hda/codecs/conexant.c
@@ -43,6 +43,10 @@ struct conexant_spec {
 	unsigned int gpio_mute_led_mask;
 	unsigned int gpio_mic_led_mask;
 	bool is_cx11880_sn6140;
+
+	/* Pop noise mitigation */
+	struct hda_codec *codec;
+	struct delayed_work pop_mitigation_work;
 };
 
 
@@ -212,10 +216,74 @@ static void cx_auto_shutdown(struct hda_codec *codec)
 
 static void cx_remove(struct hda_codec *codec)
 {
+	struct conexant_spec *spec = codec->spec;
+
+	cancel_delayed_work_sync(&spec->pop_mitigation_work);
 	cx_auto_shutdown(codec);
 	snd_hda_gen_remove(codec);
 }
 
+static void mute_unmute_speaker(struct hda_codec *codec, hda_nid_t nid, bool mute)
+{
+	unsigned int conn_sel, dac, conn_list, gain_left, gain_right;
+
+	conn_sel = snd_hda_codec_read(codec, nid, 0, 0xf01, 0x0);
+	conn_list = snd_hda_codec_read(codec, nid, 0, 0xf02, 0x0);
+
+	dac = ((conn_list >> (conn_sel * 8)) & 0xff);
+	if (dac == 0)
+		return;
+
+	gain_left = snd_hda_codec_read(codec, dac, 0, 0xba0, 0x0);
+	gain_right = snd_hda_codec_read(codec, dac, 0, 0xb80, 0x0);
+
+	if (mute) {
+		gain_left |= 0x80;
+		gain_right |= 0x80;
+	} else {
+		gain_left &= (~(0x80));
+		gain_right &= (~(0x80));
+	}
+
+	snd_hda_codec_write(codec, dac, 0, 0x3a0, gain_left);
+	snd_hda_codec_write(codec, dac, 0, 0x390, gain_right);
+
+	if (mute) {
+		snd_hda_codec_write(codec, nid, 0, 0x707, 0);
+		codec_dbg(codec, "mute_speaker, set 0x%x PinCtrl to 0.\n", nid);
+	} else {
+		snd_hda_codec_write(codec, nid, 0, 0x707, 0x40);
+		codec_dbg(codec, "unmute_speaker, set 0x%x PinCtrl to 0x40.\n", nid);
+	}
+}
+
+static void pop_mitigation_worker(struct work_struct *work)
+{
+	struct conexant_spec *spec = container_of(work, struct conexant_spec,
+			pop_mitigation_work.work);
+	struct hda_codec *codec = spec->codec;
+
+	mute_unmute_speaker(codec, 0x17, false);
+}
+
+static void cx_auto_pop_mitigation(struct hda_codec *codec,
+		struct hda_jack_callback *event)
+{
+	struct conexant_spec *spec = codec->spec;
+	int phone_present;
+
+	phone_present = snd_hda_codec_read(codec, 0x16, 0, 0xf09, 0x0);
+	if (!(phone_present & 0x80000000)) {
+		/* Headphone unplugged, mute speaker immediately */
+		mute_unmute_speaker(codec, 0x17, true);
+		/* Schedule unmute after 20ms delay */
+		schedule_delayed_work(&spec->pop_mitigation_work, msecs_to_jiffies(20));
+	} else {
+		/* Headphone plugged in, cancel any pending unmute */
+		cancel_delayed_work_sync(&spec->pop_mitigation_work);
+	}
+}
+
 static void cx_process_headset_plugin(struct hda_codec *codec)
 {
 	unsigned int val;
@@ -1178,6 +1246,9 @@ static int cx_probe(struct hda_codec *codec, const struct hda_device_id *id)
 	spec = kzalloc(sizeof(*spec), GFP_KERNEL);
 	if (!spec)
 		return -ENOMEM;
+
+	spec->codec = codec;
+	INIT_DELAYED_WORK(&spec->pop_mitigation_work, pop_mitigation_worker);
 	snd_hda_gen_spec_init(&spec->gen);
 	codec->spec = spec;
 
@@ -1187,6 +1258,8 @@ static int cx_probe(struct hda_codec *codec, const struct hda_device_id *id)
 	case 0x14f11f87:
 		spec->is_cx11880_sn6140 = true;
 		snd_hda_jack_detect_enable_callback(codec, 0x19, cx_update_headset_mic_vref);
+		/* Enable pop noise mitigation for both codecs */
+		snd_hda_jack_detect_enable_callback(codec, 0x16, cx_auto_pop_mitigation);
 		break;
 	}
 
-- 
2.25.1


