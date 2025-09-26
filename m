Return-Path: <linux-kernel+bounces-833804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E9ABA31DC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 11:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 126674A6BD8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 09:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449D0271475;
	Fri, 26 Sep 2025 09:21:23 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E09F1DDDD;
	Fri, 26 Sep 2025 09:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758878482; cv=none; b=cdOayR0p/18i2rX7D+TLNkWMhojiky7o1B/jc6+SRz60ZTX9C54TD4hniAZkz3V/ibaVVpb/t83H2p8yhq6QlPkJ+fKx9XdcsdeUTA0NYgtr7ZuQ9twNcsumJCogNGvhE3rvNurXSnkl4B+uaR7IhYEBZAdV7aLd3RzSAfbTOhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758878482; c=relaxed/simple;
	bh=dPDlLFm6xmd3S3SXV4mz7VPGXEBWtUxgDgWRHPdMV2g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DmRjgJcG8p+yKPV30sPgauhELJtAHdMMxLYdxOYaXIBjUzDKzBFylmaXfK0UWc2NQY5EnBDzVEgaXt/pDtc+lIJS2MblznTWhYr6rijiUn1s2SRN0JYdGbcHCV+vTrKpLNlWoZ6Hj41o7Ji+/dyzzXmFq+/4CXFQWPVaqOcAzz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-03 (Coremail) with SMTP id rQCowAB3wHr9WtZoVlaJBg--.8995S2;
	Fri, 26 Sep 2025 17:21:01 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: sre@kernel.org,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	bryan.odonoghue@linaro.org
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH v2] platform: arm64: thinkpad-t14s-ec: Convert comma to semicolon
Date: Fri, 26 Sep 2025 17:13:02 +0800
Message-Id: <20250926091302.817919-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAB3wHr9WtZoVlaJBg--.8995S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KF17ur4DKrWUZrW5tr43ZFb_yoW8Aw4rpF
	1kuwsrtF48Gwsay3Zxtw4xZwn7X3yDXa4jka43C3y09a4Yqr9FqrW0qFWrCF40qFZ7Wa1q
	qr15AFWjgF4YvwUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvm14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	Jw0_GFylc2xSY4AK67AK6r4fMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
	4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
	67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
	x0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
	UI43ZEXa7VUb7GYJUUUUU==
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Replace comma between expressions with semicolons.

Using a ',' in place of a ';' can have unintended side effects.
Although that is not the case here, it is seems best to use ';'
unless ',' is intended.

Found by inspection.
No functional change intended.
Compile tested only.

Fixes: 27221f91b83f ("platform: arm64: thinkpad-t14s-ec: new driver")
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
Changelog:

v1 -> v2:

1. Add Fixes tag.
---
 drivers/platform/arm64/lenovo-thinkpad-t14s.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/arm64/lenovo-thinkpad-t14s.c b/drivers/platform/arm64/lenovo-thinkpad-t14s.c
index f721763e13cc..1d5d11adaf32 100644
--- a/drivers/platform/arm64/lenovo-thinkpad-t14s.c
+++ b/drivers/platform/arm64/lenovo-thinkpad-t14s.c
@@ -401,14 +401,14 @@ static int t14s_kbd_audio_led_probe(struct t14s_ec *ec)
 	int ret;
 
 	ec->led_mic_mute.name = "platform::micmute";
-	ec->led_mic_mute.max_brightness = 1,
-	ec->led_mic_mute.default_trigger = "audio-micmute",
+	ec->led_mic_mute.max_brightness = 1;
+	ec->led_mic_mute.default_trigger = "audio-micmute";
 	ec->led_mic_mute.brightness_set_blocking = t14s_mic_mute_led_set;
 	ec->led_mic_mute.brightness_get = t14s_mic_mute_led_get;
 
 	ec->led_spk_mute.name = "platform::mute";
-	ec->led_spk_mute.max_brightness = 1,
-	ec->led_spk_mute.default_trigger = "audio-mute",
+	ec->led_spk_mute.max_brightness = 1;
+	ec->led_spk_mute.default_trigger = "audio-mute";
 	ec->led_spk_mute.brightness_set_blocking = t14s_spk_mute_led_set;
 	ec->led_spk_mute.brightness_get = t14s_spk_mute_led_get;
 
-- 
2.25.1


