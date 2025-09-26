Return-Path: <linux-kernel+bounces-833498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B3DBA2288
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 03:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA3FC1C23439
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 01:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C587E1B87C9;
	Fri, 26 Sep 2025 01:46:28 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482351A08CA;
	Fri, 26 Sep 2025 01:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758851188; cv=none; b=F0M2ZleJYY2ug4xalihtlkeIjgfRXvAYMhObbpMsPRzxigQuyIM734Qfmyc8r8IBMwG+x8er6iCkOn2SqXuTROPiaj8zdDt58uQ57B6h7psWwICx0V4x+vKznDBo5nXReNJYVv/cTLFPTh+fFIA1zfT36dLwLUW60aNtPH0maWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758851188; c=relaxed/simple;
	bh=tpjmJCLTops9cU9mUxoNkqsEStycO91Hn0t97rHZaPc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QmutMqrFT0m7y9sZu2AML9O4I/803F2Fb33AV0vUvFsszmaBJmid7Y9lxk5ya+7Ks4dH+ajMLRME3EwPlpOV1dh7QnbLQuXMm+oIO7JsD7Q6vEcs50iVHx4P8OfrOhKE5dXwQuhBoljOWTyKoLltDeFJYwyacYQGieqxM1exuLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-01 (Coremail) with SMTP id qwCowAA3kaNk8NVozmhSBg--.28246S2;
	Fri, 26 Sep 2025 09:46:12 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: sre@kernel.org,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	bryan.odonoghue@linaro.org
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] platform: arm64: thinkpad-t14s-ec: Convert comma to semicolon
Date: Fri, 26 Sep 2025 09:43:45 +0800
Message-Id: <20250926014345.651176-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAA3kaNk8NVozmhSBg--.28246S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KF17ur4DKrWUZF4ktF1xGrg_yoW8WF18pF
	1v9397tF48Wwnay3Zxtr4xZwn7X3yDZa4jka43C3y0kas0qr9FqrW0vFy3CF40qFWkWa1D
	Xr15AFWYgF4YvwUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7
	v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS
	14v26r126r1DMxkIecxEwVAFwVWkMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
	cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa
	73UjIFyTuYvjfUOl1vDUUUU
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Replace comma between expressions with semicolons.

Using a ',' in place of a ';' can have unintended side effects.
Although that is not the case here, it is seems best to use ';'
unless ',' is intended.

Found by inspection.
No functional change intended.
Compile tested only.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
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


