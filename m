Return-Path: <linux-kernel+bounces-887875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 60876C39473
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 07:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0D0614E5331
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 06:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E982D877B;
	Thu,  6 Nov 2025 06:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="irJ0f6mC"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C69D23B616;
	Thu,  6 Nov 2025 06:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762411026; cv=none; b=NgwHulgt/nzlikP+03pWA1BaZPvWV6i21XJtuQRiM50avQKhgkB2p3d3o65BUHo1KYTbik9CupJCzAMWS5dZHOKVXYmOjoPZRf/9z6uQmFuJEenSACi6Z6q4vZLssmwaTYsuR3B1oOqKkRBGWEO0CWiW8X5h1lAe0G2evoJgX1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762411026; c=relaxed/simple;
	bh=TQv944OsNJBy399bRPOXpN9cFgowfIvc7mJdW7mtYBc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t/jgXbwoWX4krx1dXo2Y45uTXRwCZBD3+lK7SCvDMa/wknYzxIM8EYV6wqilWJSg3XEzUdN/xhI2cwVPta2Odw/cwAO+rULe1GFv4Yv4k9Vk5WOkX2g+vHS2VFQ2oK445tzO1BeS3hJ5yQaAx1N2h+xez0oVwjzXxi7FLz9gd8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=irJ0f6mC; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=C/
	qSfn8XWm+oaCfY2V1Q0d+VxMXeZuMkTYlNsiNF8Y4=; b=irJ0f6mCzGGHqQUWxw
	QusFlN3nZOAlsiLI+QxGYlOOVI9I/UlQ71MIJQPeitkxGu5qsBaB7T91cIM0wGWf
	FEiMl5ESLTelPqsFfaA5FszVutgIoA3bIwcFjnRMyu2uN5CklkULWGTM5sHDunFN
	+/97h97/sR6yonYdf3BcmBuJI=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgAnnZfrQQxpfqNrCw--.22232S2;
	Thu, 06 Nov 2025 14:36:28 +0800 (CST)
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
Subject: [PATCH] ALSA: hda/senary: Replace magic numbers with defined constants
Date: Thu,  6 Nov 2025 14:36:26 +0800
Message-Id: <20251106063626.115358-1-wangdich9700@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgAnnZfrQQxpfqNrCw--.22232S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ur47tryktFy5KFWfAF43ZFb_yoW8GF18pF
	n0kFyrKrZ3Jr10yF18GayfZFyrGas8WF43K342g3WYvan2krykX3Wjqryaq3W3JF9rK3Wa
	vryxZ34UCryqyaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pi-tx3UUUUU=
X-CM-SenderInfo: pzdqwv5lfkmliqq6il2tof0z/xtbCwAzoOGkMQexNygAA3T

From: wangdicheng <wangdich9700@163.com>

Replace hardcoded GPIO node value with a defined constant for better
code readability and maintainability.

Signed-off-by: wangdicheng <wangdicheng@kylinos.cn>
---
 sound/hda/codecs/senarytech.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/hda/codecs/senarytech.c b/sound/hda/codecs/senarytech.c
index 99af8d5e51db..d61d57538bc9 100644
--- a/sound/hda/codecs/senarytech.c
+++ b/sound/hda/codecs/senarytech.c
@@ -19,6 +19,9 @@
 #include "hda_jack.h"
 #include "generic.h"
 
+/* GPIO node ID */
+#define SENARY_GPIO_NODE		0x01
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


