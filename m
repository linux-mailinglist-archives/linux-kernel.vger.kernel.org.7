Return-Path: <linux-kernel+bounces-888764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B6568C3BDB7
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 15:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C3698503A1B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 14:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC7A227B95;
	Thu,  6 Nov 2025 14:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PAy1N3a7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ii6JmfXp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7339D30F538;
	Thu,  6 Nov 2025 14:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762440145; cv=none; b=SMqH3g//RkF0LePwkgUkyTbKXtuFpnpUEo88nqp5ZxtVFZZFSZ8/s3ufYgGzPBwInuiyMzn+Odjhfi9dxMKbPyj6h9y/buh4SZtQK/SW8YbZpfl9ZhmXVi3vfFRmrTR/mp9b7N7cubisZ3RYRR6IW1SjXyGNBFbuzo5XrA20Kuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762440145; c=relaxed/simple;
	bh=u3JHp/qpCUvTjf3bCgMmhxbdgh3vpao1Tq40kL7L4U4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=EGgEurhi65Yi9/97lw5XhQ5v9Do7FG66aoiIIhSVSahxt/g2wpmK2YhIvy0R+d94gnCdl9gapWlHC0gUEB1IVR+vlUJpSmSJxwWvxvpqbvmtV9+Sna/DJDYQJgR1smU+0IsRDiaG8EVMnp8RcjFDU+mnjSXvoT7L/9ZUCaJU4C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PAy1N3a7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ii6JmfXp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762440140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FOOLV+Wt6cHX8IB56gpRGewt+8/m8I9TnkK1yGUVBrw=;
	b=PAy1N3a7SmuG/It82kUVWs7XH1XoUuU2LBMSWsQe92MYeMc6fMk99Oh2ED4REz0DfKwJ7e
	snLOGoEi+h6rxH1AToYSm6dkyPydDkO9dEhJ0bOdYmPxSj+iypgGI75fBIGHPJdOZkuoCe
	J3ncdAZaHl51xGEEOuBW2HDMRjfxWhiDWeakQoYNgDOIo8S1zvb/OqDN/npoehXCUnH4qV
	xniuDaI04M6z6lU8oswSbqY6Y1ekuPeEk1+ENq4jwYiWlFalpdYVZ3dEiOgXqfBiPT62Ep
	/Ty/UZRoQ9t5mouKRmdM0FJr6c4Apvnuk0qFSYyrJLz7Q+xkW6Clx7W9w0lx9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762440140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FOOLV+Wt6cHX8IB56gpRGewt+8/m8I9TnkK1yGUVBrw=;
	b=ii6JmfXp0RoYt2PeZHZB0fv0OUb2E/wmb9jj0+DNATMOesrbqgHuWyzipDdk8KyujH9YzS
	JK0cxBo5oSub6nBw==
Date: Thu, 06 Nov 2025 15:41:57 +0100
Subject: [PATCH] ASoC: stm32: dfsdm: don't use %pK through printk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251106-restricted-pointers-stm-v1-1-7d03eb5020ba@linutronix.de>
X-B4-Tracking: v=1; b=H4sIALSzDGkC/x3MMQqAMAxA0atIZgNWrYhXEYfaRs1glaSIIN7d4
 viG/x9QEiaFoXhA6GLlI2aYsgC/ubgScsiGuqqtMVWHQpqEfaKA58ExkShq2tHOi2/70LjWW8j
 1KbTw/Z/H6X0/bulgGmkAAAA=
X-Change-ID: 20251106-restricted-pointers-stm-5bfc48d3a4c5
To: Olivier Moysan <olivier.moysan@foss.st.com>, 
 Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762440134; l=1480;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=u3JHp/qpCUvTjf3bCgMmhxbdgh3vpao1Tq40kL7L4U4=;
 b=JX2/pGtnxIWSvsmEmArg+q9ng4flIkflN4nEGjJUT8CwoyuR9/ggaXsSr1SLyL16fci8pTktn
 zlfGtfCQCGcB4MC6P//HH2Iz7Zt1s9RNoqJx57MVyEwkMl2KPH6djk0
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

In the past %pK was preferable to %p as it would not leak raw pointer
values into the kernel log.
Since commit ad67b74d2469 ("printk: hash addresses printed with %p")
the regular %p has been improved to avoid this issue.
Furthermore, restricted pointers ("%pK") were never meant to be used
through printk(). They can still unintentionally leak raw pointers or
acquire sleeping locks in atomic contexts.

Switch to the regular pointer formatting which is safer and
easier to reason about.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 sound/soc/stm/stm32_adfsdm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/stm/stm32_adfsdm.c b/sound/soc/stm/stm32_adfsdm.c
index c914d1c4685019ef1fd66ab92d73bd06cf8d14a1..1797a91fea7ae85671ba9991c2f8bfa8c9d1ce92 100644
--- a/sound/soc/stm/stm32_adfsdm.c
+++ b/sound/soc/stm/stm32_adfsdm.c
@@ -180,7 +180,7 @@ static int stm32_afsdm_pcm_cb(const void *data, size_t size, void *private)
 		src_size >>= 1;
 	cur_size = src_size;
 
-	dev_dbg(rtd->dev, "%s: buff_add :%pK, pos = %d, size = %zu\n",
+	dev_dbg(rtd->dev, "%s: buff_add :%p, pos = %d, size = %zu\n",
 		__func__, &pcm_buff[priv->pos], priv->pos, src_size);
 
 	if ((priv->pos + src_size) > buff_size) {

---
base-commit: 7ea30958b3054f5e488fa0b33c352723f7ab3a2a
change-id: 20251106-restricted-pointers-stm-5bfc48d3a4c5

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


