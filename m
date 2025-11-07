Return-Path: <linux-kernel+bounces-889697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F57C3E451
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 03:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B827A3AA3BE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 02:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C7F2F12C6;
	Fri,  7 Nov 2025 02:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="acgNVMao"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EECA2DECC2;
	Fri,  7 Nov 2025 02:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762483299; cv=none; b=Sxn4319lKuhrN6RUs2OOtYk1LoAzEIgb8nIPFiXKZdpxVYHRpXJOaFzsPNz/z2CbDW/PxeIw+frDBwXHaOP9Okp1Riv0ght81qZQnfLZgwgop3h4D6lEC3LJtgn6CmrBLfbMVufvhPVK6hjjNCPs6gG2fPG2BJQIGKzEflUw1K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762483299; c=relaxed/simple;
	bh=r4/s9HOshdULd/EqA6S39QwmIjspJoWX+6sPhfSMMuM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oe/v8NcvnhWFGu3SwieA3siLlj8psyOYW1w3+t9xrJlpvksnZHjiwfoGjfJ3ToyZw8MIwGAgAzA5j9bHHZQqQTbK1Jk9jJZ0/Fv4hFHaUrW/hEFrROMBbK/Fm9hy/HDNbkfOuCLlPCzByMRHm0Xo1y8Swsr8mqNHo8XmKHwPlbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=acgNVMao; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=KZ
	jeK6wWfSrWBcTcOZj4lHgWUS2TJviSTPcQPa8owWw=; b=acgNVMaomnRfJVPbln
	bceAy3lm3DGwYsY7qZsCWEsg8DlbYdrAs9WinPLXvRDlHbzGtMKi7nYf0jNEe8GL
	Y94/MihWCuqBv1F47xttjsswnXeeh3oVKAVlRiIwQcu0ocsawznS1LzTVR06AxaZ
	EgI96+LUTW1TWtDrAIb712hxA=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3N1MfXA1p6qbzCA--.918S2;
	Fri, 07 Nov 2025 10:40:33 +0800 (CST)
From: wangdich9700@163.com
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	cezary.rojewski@intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	wangdicheng <wangdicheng@kylinos.cn>
Subject: [PATCH v2] ALSA: hda/senary: Replace magic numbers with defined constants
Date: Fri,  7 Nov 2025 10:40:30 +0800
Message-Id: <20251107024030.36712-1-wangdich9700@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3N1MfXA1p6qbzCA--.918S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ur1UuF4xGw45WF4UCw18uFg_yoW8Gw1kpr
	n8CFyrKrZ3Jr10yr18Gay5ZFyrGa98XF43t3y7K3W5Zan2kFykX3WUXryaq3W3JF9rK3Wa
	vryxZ34UC34qyaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jnmiiUUUUU=
X-CM-SenderInfo: pzdqwv5lfkmliqq6il2tof0z/1tbibgT9T2kMbWHmRwABsR

From: wangdicheng <wangdicheng@kylinos.cn>

Replace hardcoded GPIO node value with a defined constant for better
code readability and maintainability.

Signed-off-by: wangdicheng <wangdicheng@kylinos.cn>
---

v1->v2:
-Align both From and Signed-off-by addresses

 sound/hda/codecs/senarytech.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/hda/codecs/senarytech.c b/sound/hda/codecs/senarytech.c
index 99af8d5e51db..31ec4e53f6ff 100644
--- a/sound/hda/codecs/senarytech.c
+++ b/sound/hda/codecs/senarytech.c
@@ -19,6 +19,9 @@
 #include "hda_jack.h"
 #include "generic.h"
 
+/* GPIO node ID */
+#define SENARY_GPIO_NODE	0x01
+
 struct senary_spec {
 	struct hda_gen_spec gen;
 
@@ -131,11 +134,11 @@ static void senary_init_gpio_led(struct hda_codec *codec)
 	unsigned int mask = spec->gpio_mute_led_mask | spec->gpio_mic_led_mask;
 
 	if (mask) {
-		snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_GPIO_MASK,
+		snd_hda_codec_write(codec, SENARY_GPIO_NODE, 0, AC_VERB_SET_GPIO_MASK,
 				    mask);
-		snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_GPIO_DIRECTION,
+		snd_hda_codec_write(codec, SENARY_GPIO_NODE, 0, AC_VERB_SET_GPIO_DIRECTION,
 				    mask);
-		snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_GPIO_DATA,
+		snd_hda_codec_write(codec, SENARY_GPIO_NODE, 0, AC_VERB_SET_GPIO_DATA,
 				    spec->gpio_led);
 	}
 }
-- 
2.25.1


