Return-Path: <linux-kernel+bounces-868891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A81C066BA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 15:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 787E94ED522
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 13:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51EA131B81D;
	Fri, 24 Oct 2025 13:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="qb+/eio9"
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A158316915;
	Fri, 24 Oct 2025 13:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761311576; cv=none; b=DnkulhbHf3pahGxC7YZTuKtp18vCPMCKGeL2UeSj/S1LBCg9nUYRfM6JaSeTFryOkWD2COnPDsoXVB5DDMZI9tq1Ubo4MUnblyp4+R54mHywdKwmQx/ZYRB6h7/KUYx/rSErWJuKotmyq1/R3CpfQdlpDrg/wBa3oAPTZ/u1BQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761311576; c=relaxed/simple;
	bh=2aewrvQsu5cZfDk5up019SNDTifSNkr8oCASbDhfrB0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=C9kgRamhNb9mEY/5Cz083s3UXvEocLYqggo1s7sqt8tueCECABSsSSiQ3rgUM8Vg6o3eQIfh80l7qHymfc1VJ+zkCqjYl0cZb2xF4rYXHte0OihVfMXzwOhZFIMPODVnHpmb/vG62Ln8lopj0SCZDk0GUZzp1kPvlF5csaWSpZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=qb+/eio9; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1761311468;
	bh=9JV18j4VlfTipOLVghQOb8o4MFvZkdIXPEwg/4zYbWw=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=qb+/eio9LibALNgbrzIaDIItBJgDEYDxO3MRxe9Pxiojak0XWgPpwKmiJYmauEaWK
	 2W8oS9lwABsYT5whvhj1WQ7KmogMZW+w+C444sRlBuObLG7Yq8+gbJ8YLIlwCBxAam
	 Z/kWeTMLfEO5d4tt49Gvmpec2HfCHek6f6Lj9RzQ=
X-QQ-mid: zesmtpip4t1761311465te44400d9
X-QQ-Originating-IP: QoGeJjgVTLr+B6Q6EcmsTcYvLVeLIBLRdDiYkS5sJBQ=
Received: from = ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 24 Oct 2025 21:11:04 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17065809346992104462
EX-QQ-RecipientCnt: 11
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Date: Fri, 24 Oct 2025 21:11:01 +0800
Subject: [PATCH] ASoC: spacemit: add failure check for
 spacemit_i2s_init_dai()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-fix-k1-i2s-dai-mem-v1-1-15f5f1ec294a@linux.spacemit.com>
X-B4-Tracking: v=1; b=H4sIAOR6+2gC/x2MQQqAIBAAvxJ7bsGVyugr0UF0qyW0UIgg/HvSc
 WBmXsichDNMzQuJb8lyxgrUNuB2GzdG8ZVBK92T0h2u8uBBKDqjt4KBAxpLI3Xs3WA81PBKXK1
 /Oi+lfGY0fcBkAAAA
X-Change-ID: 20251024-fix-k1-i2s-dai-mem-7a1814edc67d
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Yixun Lan <dlan@gentoo.org>
Cc: linux-sound@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761311464; l=1205;
 i=troy.mitchell@linux.spacemit.com; s=20250712; h=from:subject:message-id;
 bh=2aewrvQsu5cZfDk5up019SNDTifSNkr8oCASbDhfrB0=;
 b=oFTTIP2sJJhiz+ZVGA4xIkkKuXYvu9i5W2/Y+Af/20Lbi35uQ525bl6kreU3ivgjK6kElXDks
 4cD9xOpPJoyAJrTQ0NNyPAnusC5raEvjznDEOILs6x+VYSoTv0f1lRI
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=zhRP1xE0bftrurqSWI+SzcSdJGIZ0BTTY9Id0ESzqlI=
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MQSJ42kM78w4IN4m8F7ewha38AwA6ruOftcyyZZbtGqDqrwtvgTCRFpg
	tAJfcQb8NsFadiqye4C3XL+9Npsb74TQzUGJDrweXtCbvWLtnMhIgODEwfya2iRsS/1jlyd
	IaYNr5CfcJ1cXuWz0hJbmzgH7NO3vVADX97cSQYkb4ALB+XVppFQkfuiJbhP8wRZZaof7Ez
	vhEDcQ5p3aGWMaWxbLgfX9hjA+aWxfa0RU142sSaqKqwC6ZeyH1OnJfQmJ4TusxN5KqJfsi
	bI848K8PyzkEG6y8JqtB6O+e9ejd9FJy2fGDVpaNJfn16Ow5kRuR0wwCBaIM/rnP8kkDuG3
	dxnkANevDmf6RosOomNjkw1P5SDyVJXTeh6zDj0p3LSMA9olhWy5h9qQlkaqfA559Xb4G5H
	PChO6Rs1QRrlnO3bXKAFUV6T+obpjHZgRS/gTtvJ7gGSxymxR7SgBTS7ORjw6UfJGmfef2m
	kf/7W9/TCpk/eFe8mAtxb3pJOlaxuAnvW1Usu+WLqrMJwJqPP85qw7Q9Co841iyUimPsEvh
	hfj4AQNRkX84BhR21MfL3f/CT13BdC2JNr6lUX5dFa1vl/jH9y/FItmU12gR1yX42kdTjAB
	fQ7vps379Uq+fsOXMJDfQnM0nkmHwg8ywZiGn0MwChzuB762fM7EZqHVKAaUmEwAe0dF/w2
	ykQES+AdtSPYpif2+rP7vsQk4meiNHwDGyGfGp55fn7Ampiux4YkZyNZwrOQFGfS18RpzDW
	qOo7bGO7dqDWoikLt2WbUPMCfPSfz9yfPNkoKcntnQsC2hKoAolsi+LoUa1gFCwKSZoa4/J
	1a1UFlVqB1P/2Tx+CqcZ0wBby9JbjhlDJVJ9nukJYkdM6rxLcLgJkUH8VPaT9jRw/JBCTrd
	B2MMsuomNq3Mp1n1AkIHt4pSTfwVCE9k8AKsipVdBvxQTyPEUHUf5FZbIATsTQira7mZvKp
	w2T/xkRBHltMDsDk0fmlgjseGvq/wtHEedtbDAq2dKeRo81riDlKpvFYMLh4KxPyjczFxyb
	A0sHpvY7UvdDHdaXREKkkGFGNsHXsK2VDOXCk9ijA6C3Y2ayFK3/ITRcQPmTaM24UMroASF
	/G/+OtKJuElYKJVr3dth9KXQ6xvEA4Mz3pxUH8k1RX9jm3tQdyRuYLQNlPRpCvbrADigq/4
	4/s2CTfNMnuLIvQ=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

Add error handling when memory allocation for dai fails in
spacemit_i2s_init_dai() call.

Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
---
Dan reported here [1].

Link: https://lore.kernel.org/all/aPtiNCZ_KBezL2Dr@stanley.mountain/#t [1]
---
 sound/soc/spacemit/k1_i2s.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/spacemit/k1_i2s.c b/sound/soc/spacemit/k1_i2s.c
index abc439b53e3d4358570df2e69e636bf54820d9ce..8af05e1604f518b63cbbbaa66b73cfee8262d87f 100644
--- a/sound/soc/spacemit/k1_i2s.c
+++ b/sound/soc/spacemit/k1_i2s.c
@@ -428,7 +428,9 @@ static int spacemit_i2s_probe(struct platform_device *pdev)
 
 	dev_set_drvdata(i2s->dev, i2s);
 
-	spacemit_i2s_init_dai(i2s, &dai, res->start + SSDATR);
+	ret = spacemit_i2s_init_dai(i2s, &dai, res->start + SSDATR);
+	if (ret)
+		return ret;
 
 	ret = devm_snd_soc_register_component(i2s->dev,
 					      &spacemit_i2s_component,

---
base-commit: 72fb0170ef1f45addf726319c52a0562b6913707
change-id: 20251024-fix-k1-i2s-dai-mem-7a1814edc67d

Best regards,
-- 
Troy Mitchell <troy.mitchell@linux.spacemit.com>


