Return-Path: <linux-kernel+bounces-887873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71644C3946D
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 07:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1081618C7AC8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 06:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4872D7395;
	Thu,  6 Nov 2025 06:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="VdeUEW51"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699FF23B616;
	Thu,  6 Nov 2025 06:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762410952; cv=none; b=Qnq57d2OZoHJ0vUjggcrG/s6166/6crvhxJ1K/3r8rQtQAQGPVq2TC7gUPTQ5+Nd1unXCgnnJEL3APXZRG+eA6rGOc3ckVou1+FQ6Ofs1NXm1QhO/KRXfowh406Ho4Lspf8m1ea4iK/aWXADhRedM0n1L+KPHlrAyops4YDNIjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762410952; c=relaxed/simple;
	bh=6dIncYsw2AUWCpJdPdju0yIAxmplRyqmcuOaj53NKtI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mrJWrA3U8lBmb9Jbd8MKWX7m54F3388dcJAyEhOO0R9pfCY1xNKpDjOL9WwuMNVgI8gQgKU25EnnhBE/tx156tNIC7JbaQDdxBgx0X+b7kySeXlUJYRm/XJNWtCTzQVUSadCgmPI/IJAJEWYSHCJLAX2EBwnpvObTZ8OLAjVXsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=VdeUEW51; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=vq
	V83Z6jyR2ex1aXweIWz+uIiWlYmXUgywvYFJHDbYY=; b=VdeUEW51e7keAucnhh
	8tyUcRfD/7x3qM/E8312DRnhCRjgf2I8D3c4K3e+2fVsrLYehKHMZMyPjVK8Vbl/
	C1FiAL6Sh/B25KWL5wcAbwX0pjqdbyYPJ+wsoHbTN+fhm1/aKYuJ/7Q+QH4kZeyn
	jlJkfKmosiRD5YeRcaexT0Yz0=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD339mdQQxppwQZCA--.7458S2;
	Thu, 06 Nov 2025 14:35:11 +0800 (CST)
From: wangdich9700@163.com
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	cezary.rojewski@intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	wangdicheng <wangdich9700@163.com>,
	wangdicheng <wangdicheng@kylinos.cn>
Subject: [PATCH] [PATCH v3] ALSA: hda/conexant: Fix pop noise on CX11880/SN6140 codecs
Date: Thu,  6 Nov 2025 14:34:59 +0800
Message-Id: <20251106063459.115006-1-wangdich9700@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD339mdQQxppwQZCA--.7458S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXF1fZw43Kr48uF4kCw1UGFg_yoWrCFW8pr
	15Ka43K393JF1Ivr4fJr48Z3WFgF95WFsrJ343t3W3JwsxKry7Wa1jgryxKF1rJryqgFW2
	vF42vryUKr45AF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pi-eOPUUUUU=
X-CM-SenderInfo: pzdqwv5lfkmliqq6il2tof0z/1tbibhj9T2kMMt8qKgADsP

From: wangdicheng <wangdich9700@163.com>

Pop noise mitigation: When headphones are unplugged during playback, mute
speaker DAC (0x17) immediately and restore after 20ms delay to avoid
audible popping. This fix is specifically for CX11880 (0x14f11f86) and
SN6140 (0x14f11f87) codecs based on testing verification.

Signed-off-by: wangdicheng <wangdicheng@kylinos.cn>
---
V2 -> V3:
- Fixed container_of usage by storing codec pointer in spec structure
- Added cancellation of delayed work when headphone is re-plugged
- Limited the fix to specific device IDs (0x14f11f86, 0x14f11f87) based on testing
- Added proper cleanup in remove function

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


