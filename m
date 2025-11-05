Return-Path: <linux-kernel+bounces-885718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C77AC33C36
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 03:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49DF6463C5D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 02:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745C621D3EA;
	Wed,  5 Nov 2025 02:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DgtSb4RO"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE79231C91
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 02:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762309580; cv=none; b=H4+T+hkbZexTvBt3zoWvtXsdlD1Q/Q7TT+5RvRc8n8lw1dqu7kZ7CdAVOpgJ8miY8L4L/3THvtaTUqG2dRdpgzmW5jiqi8yq2GAPBKFfhCSPBeYCyBc6wrgWBb46s78Asw18NbQUk3VfcEz1KxWLLrgf+2NY5ysdyVwR/ruA6L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762309580; c=relaxed/simple;
	bh=YEhGzlYvaxknDODKk9pV+4jV9odIZpMcPlhU5BRJVSg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tBahkn60nPwMRJcgpzKm+FvZw8Kb9c3+9q34EcFb3VfCEez8HyJ2m6c/qJOvD1rAoXSbUUGBj/1p99/4TCwow1H8ecqvbR6EAZNgo6KoWMnBe8NkLzf3r36LzTWmWncGJp2zkd54hEdmgUV5LLtwXFnV2UbH4pYyG6hfwPy1AKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=DgtSb4RO; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=/p
	2mNp4gNAgGCW3IMGenGM2K7t6SvD8ichbCMBxhLHs=; b=DgtSb4ROT+7ZTf/2Kw
	jBA/cNT0xndd6kmGtsY/9Y6GoESOOBLBIVJev0UhoQs26x93eJg7bIpJzu2PC/4L
	YaxB9paFN3809Q93RC9j4ucM85eVXagvt9rvLfrysoHBjoKhqlvvRsb10u4Bt0SW
	nTLyDpVrNcK/neROxwzkH2UIw=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDH3_GYtQppMrN8BQ--.117S2;
	Wed, 05 Nov 2025 10:25:31 +0800 (CST)
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
Subject: [PATCH v2] ALSA: hda/conexant: Fix pop noise on conexant codec
Date: Wed,  5 Nov 2025 10:25:26 +0800
Message-Id: <20251105022527.69770-1-wangdich9700@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDH3_GYtQppMrN8BQ--.117S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZr18KF45Gr1xAF4kGFykXwb_yoW5tFyUpr
	15Ga43GrZ3JF1I9r4fJr4fA3WYkFykWFsxJ34ft3W3Jw43Kry7Wa1jqFyI9F1fJrW7Kry2
	vF42vrWUKrW5JFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pi0JPtUUUUU=
X-CM-SenderInfo: pzdqwv5lfkmliqq6il2tof0z/xtbCwBtwv2kKtZvLrgAA38

From: wangdicheng <wangdich9700@163.com>

Pop noise mitigation: When headphones are unplugged during playback,mute
speaker DAC(0x17)immediately and restore after 20ms delay to avoid
audible popping.

Signed-off-by: wangdicheng <wangdicheng@kylinos.cn>
---
 sound/hda/codecs/conexant.c | 65 +++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/sound/hda/codecs/conexant.c b/sound/hda/codecs/conexant.c
index 5fcbc1312c69..2c16d1930a75 100644
--- a/sound/hda/codecs/conexant.c
+++ b/sound/hda/codecs/conexant.c
@@ -43,6 +43,9 @@ struct conexant_spec {
 	unsigned int gpio_mute_led_mask;
 	unsigned int gpio_mic_led_mask;
 	bool is_cx11880_sn6140;
+
+	struct hda_codec *conexant_codec;
+	struct delayed_work change_pinctl_work;
 };
 
 
@@ -216,6 +219,63 @@ static void cx_remove(struct hda_codec *codec)
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
@@ -1178,6 +1238,10 @@ static int cx_probe(struct hda_codec *codec, const struct hda_device_id *id)
 	spec = kzalloc(sizeof(*spec), GFP_KERNEL);
 	if (!spec)
 		return -ENOMEM;
+
+	INIT_DELAYED_WORK(&spec->change_pinctl_work, change_pinctl_worker);
+	spec->conexant_codec = codec;
+
 	snd_hda_gen_spec_init(&spec->gen);
 	codec->spec = spec;
 
@@ -1187,6 +1251,7 @@ static int cx_probe(struct hda_codec *codec, const struct hda_device_id *id)
 	case 0x14f11f87:
 		spec->is_cx11880_sn6140 = true;
 		snd_hda_jack_detect_enable_callback(codec, 0x19, cx_update_headset_mic_vref);
+		snd_hda_jack_detect_enable_callback(codec, 0x16, cx_auto_mute_unmute_speaker);
 		break;
 	}
 
-- 
2.25.1


