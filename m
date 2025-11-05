Return-Path: <linux-kernel+bounces-885704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 594E4C33B8F
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 03:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC12818917E0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 02:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB59F21E097;
	Wed,  5 Nov 2025 02:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="RG6996gE"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9341E9B22
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 01:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762308004; cv=none; b=I4rLStbSYP8wi9f74PccuICrYVqfkMhGn0UiGOzbivCmeKWdJzp/+pQ3isLpgA7gGwU8WSbza1xZnFppSEHrkbRFcbmWgSoPUUS+ZEGZL6k1L4kGGsWnlukSiFfpmDUjr6CLxYmYujSwOdCyjuCGasmRpKLj5LH/VxPhUyBYK5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762308004; c=relaxed/simple;
	bh=ltchXPMv96JdPyCrTc0ftaYXloAglH6tv2WFEm/8NWY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nmIw2gHse5AWxZblu51kd3V6HtSkYF3rLikf0wWWM+PuSNhskGqfvwMUE8nrG8BApx9V1u6rRCUw9gAC0dClqZV4T6o8zbVuZDoE7cPWHmyCQvtvR22X6h9yZXpzmL6zxdvKlyvI+O+qhH4jAw+2JpWLYVOzsXrr0JrvIBIF7d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=RG6996gE; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Fy
	fi61jM2svcV8LogP79yM0QO8FIFwLxqSWXYdFojMQ=; b=RG6996gE6cIYRcld1j
	Oc5N692OgZ+R+H88ndUGCw78Cc9u2FPYq35WJ4lZ+UPNq5p5vijJxcWH80PV+JLW
	8s0kk8Sq/EZauahf76L7iq3XZ3P3hhUNwsAwpRi6ZRga6i3V8yjhnmZzDBYS3FLh
	RETk8mkdwanxzFCoPV+axH8dg=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDn7w9xrwppK5sjCw--.36001S2;
	Wed, 05 Nov 2025 09:59:14 +0800 (CST)
From: wangdich9700@163.com
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	linux-arm-kernel@lists.infradead.org,
	wangdicheng <wangdich9700@163.com>,
	wangdicheng <wangdicheng@kylinos.cn>
Subject: [PATCH] ALSA: hda/conexant: Fix pop noise on conexant codec
Date: Wed,  5 Nov 2025 09:59:11 +0800
Message-Id: <20251105015911.26309-1-wangdich9700@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgDn7w9xrwppK5sjCw--.36001S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGw4fXFWxZryxKw15Wr1xXwb_yoW5tryDpr
	15Ga43GrZ3JF1I9r4fJr4fA3WrKFykWFsxJw1Sy3W3Jw43Kry7Wa1jqFyI9F1xJrW7Kry2
	vF42vFWUKrW5JFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pi0D7xUUUUU=
X-CM-SenderInfo: pzdqwv5lfkmliqq6il2tof0z/xtbCvxPkNGkKr3MNewAA31

From: wangdicheng <wangdich9700@163.com>

Pop noise mitigation: When headphones are unplugged during playback,mute
speaker DAC(0x17)immediately and restore after 20ms delay to avoid
audible popping.

Signed-off-by: wangdicheng <wangdicheng@kylinos.cn>
---
 sound/hda/codecs/conexant.c | 64 +++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/sound/hda/codecs/conexant.c b/sound/hda/codecs/conexant.c
index 5fcbc1312c69..641cb738901d 100644
--- a/sound/hda/codecs/conexant.c
+++ b/sound/hda/codecs/conexant.c
@@ -43,6 +43,8 @@ struct conexant_spec {
 	unsigned int gpio_mute_led_mask;
 	unsigned int gpio_mic_led_mask;
 	bool is_cx11880_sn6140;
+
+	struct delayed_work change_pinctl_work;
 };
 
 
@@ -216,6 +218,63 @@ static void cx_remove(struct hda_codec *codec)
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
+		codec_dbg(codec, "mute_speaker, set 0x%x  PinCtrl to 0.\n", nid);
+	} else {
+		snd_hda_codec_write(codec, nid, 0, 0x707, 0x40);
+		codec_dbg(codec, "unmute_speaker, set 0x%x  PinCtrl to 0x40.\n", nid);
+	}
+}
+
+static void change_pinctl_worker(struct work_struct *work)
+{
+	struct hda_codec *codec;
+	struct conexant_spec *spec;
+
+	spec = container_of(work, struct conexant_spec, change_pinctl_work.work);
+	codec = spec->conexant_codec;
+
+	return mute_unmute_speaker(codec, 0x17, false);
+}
+
+static void cx_auto_mute_unmute_speaker(struct hda_codec *codec, struct hda_jack_callback *event)
+{
+	struct conexant_spec *spec = codec->spec;
+	int phone_present;
+
+	phone_present = snd_hda_codec_read(codec, 0x16, 0, 0xf09, 0x0);
+	if (!(phone_present & 0x80000000)) {
+		mute_unmute_speaker(codec, 0x17, true);
+		schedule_delayed_work(&spec->change_pinctl_work, 20);
+	}
+}
+
 static void cx_process_headset_plugin(struct hda_codec *codec)
 {
 	unsigned int val;
@@ -1178,6 +1237,10 @@ static int cx_probe(struct hda_codec *codec, const struct hda_device_id *id)
 	spec = kzalloc(sizeof(*spec), GFP_KERNEL);
 	if (!spec)
 		return -ENOMEM;
+
+	INIT_DELAYED_WORK(&spec->change_pinctl_work, change_pinctl_worker);
+	spec->conexant_codec = codec;
+
 	snd_hda_gen_spec_init(&spec->gen);
 	codec->spec = spec;
 
@@ -1187,6 +1250,7 @@ static int cx_probe(struct hda_codec *codec, const struct hda_device_id *id)
 	case 0x14f11f87:
 		spec->is_cx11880_sn6140 = true;
 		snd_hda_jack_detect_enable_callback(codec, 0x19, cx_update_headset_mic_vref);
+		snd_hda_jack_detect_enable_callback(codec, 0x16, cx_auto_mute_unmute_speaker);
 		break;
 	}
 
-- 
2.25.1


