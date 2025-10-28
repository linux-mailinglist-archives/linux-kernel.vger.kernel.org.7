Return-Path: <linux-kernel+bounces-872901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC5EC12907
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 02:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45AEA4236F5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 01:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A61242D67;
	Tue, 28 Oct 2025 01:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="WHzyoKco"
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E8D23DEB6;
	Tue, 28 Oct 2025 01:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761615283; cv=none; b=fFzLsIwjEDOcm7NLUgFqyJiuwbRF7Bat6FqCq2/C/wluDKAVn3AB9thQL0MchbhAd0yQm5caPUOlSFp53ROe2f5mr4Fkk06+qM/73lU8KxZvA0BHq27Wwp+6zRBRs7lCzpSGxm97Qp5JvatlmSXdp9Vqe0iNxU3oYQBTKmNZ+6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761615283; c=relaxed/simple;
	bh=+67PEqmzb/LxXS8vH/GQ0qhgTnbL8aAKvZ6J79lPqxw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EeRqO+PuzudSYT05Uh8HlcCqiI+Wa4FARdw/Vv8EFEnDykQ/i3dfvtN0ut33wBfxNZGSef64OhrL8q7hEnvrkLmxAkal5he0uSvjJMXGJ2ctYybRbw4URMPF1LoXdChbAct3q9Tg4KuacldSU8IXhsu1xNolKSLodsSWknb4h80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=WHzyoKco; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1761615157;
	bh=wSCQMvjLrBLNf5FX7IDdcyBql0gKoQDnL87jngKGghM=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=WHzyoKcoOAdw2sUwGqw9ugfAe5PyEMcMmz8/mBza/b/g5j88TI9bH3tlXHz8MFZ3H
	 w8tCPCunRiHD0aCw+NlNXN/OXRt8IXjQZGKt6AbHAhEjp4WCdS2sGOBnBlkR0eTcGR
	 K5YZCmDPCEB1eGm5nId2HSUss4/P7Sd4rbQhD4Ho=
X-QQ-mid: zesmtpgz5t1761615155te7b3f33f
X-QQ-Originating-IP: zYhKlthU7CIU0Jej9Zs4hktewHtXVQCI+5u9h2T/gg0=
Received: from = ( [183.48.246.218])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 28 Oct 2025 09:32:33 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16365730684758387002
EX-QQ-RecipientCnt: 12
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Date: Tue, 28 Oct 2025 09:32:10 +0800
Subject: [PATCH v2 2/2] ASoC: spacemit: use `depends on` instead of
 `select`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-fix-k1-i2s-v2-2-a547c15ed5c3@linux.spacemit.com>
References: <20251028-fix-k1-i2s-v2-0-a547c15ed5c3@linux.spacemit.com>
In-Reply-To: <20251028-fix-k1-i2s-v2-0-a547c15ed5c3@linux.spacemit.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Yixun Lan <dlan@gentoo.org>, Jinmei Wei <weijinmei@linux.spacemit.com>
Cc: linux-sound@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>, 
 Stephen Rothwell <sfr@canb.auug.org.au>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761615145; l=1132;
 i=troy.mitchell@linux.spacemit.com; s=20250710; h=from:subject:message-id;
 bh=+67PEqmzb/LxXS8vH/GQ0qhgTnbL8aAKvZ6J79lPqxw=;
 b=VOWimUOVSwFKWgSLTrUiIufRFt0iUVPmpDwW51/t5wGbzbSxDMEhrsR3Uq7MBL9TRUUXOOcca
 Isi0Vcpdw0lD96nhYSnuNG6Jh6DoHxU7YdQ9AeJ4OZgIlYY1Vjc0Ycz
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=lQa7BzLrq8DfZnChqmwJ5qQk8fP2USmY/4xZ2/MSsXc=
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: OKX6byuwCvg7cP3ud8MQUPeHZXSvWhUS1PFKuyXueDozw9veylqBV9rZ
	7wHdaJ7xkpe5dcdD+ODDTr/wwk7HtWLp6RTPWI6z0EFPAhLapqlRJkBmV/E71t2ttSDM/Hh
	2RyJ4ZiFFFczJQIRrV5dfn/7SvtnZ6tgVJTRYrtdpUB/36XrTu0+Um5s4WK4yfPTsGeq5YO
	FCiD96s5HD883w0T/BlnX5spptZQd8W7V33AE3MDceRoWKMoH5UvDlAxJgDIJBrZj13Zd+G
	dOZjjteK2qkmdplNBz6Lc1KD1VtVGwEFtZzUA54KhxYCp6LqNob1vJAv/QsTWIV25s1F7h2
	Jj7uhJg3Foj/m1mqnz6MQV8J0krFkJQepO/xXX0NstQXDvpA8uIiO5lAiO6/foVs2DphCM/
	c/oWueqb8n7vGJizL97xZUW+ZrbdcP9owUewfivmI5UeWTkr7UNHfjqwKEpz5HZqjbBXsPN
	K63jMAarZg8Ibu50V1cl1QukT65NSlmWlZFobp2PiI8c1Iu3lcQZiFf1qtZfOJH9J4UKXmD
	Ai2W44gWrJ+M933o9kc862epRJUEtli/XEDc3ZI2Z/de+CQUZn9wYPCqlv85fh6H+pLI+N+
	d8o24Sgd7hsQNnvq9Pe9UCJfFWPtKb8m+wFPTQmIwdrk8Bzc7aC45oEbj8cZcW2IiY6WT4v
	AQ+xj5nPcAzsz1CTPWnyBGWYEWipgEt9AniJfQrxphUcRx7GkCXvRm6MW4S5EBIBpzw2M69
	SXNPIjecQzFMz8EVDc1q7+TyMOzJnWfQlTXCxtD5eHQsqJEY1gI8UbQ8x37I/H9Qj7bUlbr
	OkPVbDetqIVHIH8GjAx1iAsBIIIqwbhmqv3y0CNCH/OOm8z7M/bx9O+SXP40Bszsk7eUkO3
	S/K0ZLJ0U1G3qbfAs/M2hBUPZQcIn4jwTKIPmQhtsefahgregrqKc8LXG0VtgTjjinnNiQC
	xfLSU/pPgruiYOBNyhaEhH8+dWTNEHdSTbvm1wDz9bDCdmquNjQwVQAr11DhV0LE/kBc3SO
	X+VCPyhX90lJk0VpsbRWfAKP2qnt0PS3RTPDVATXA7y6wEFfRpp0cO7PUC621VYTurjVnXn
	vLjeUrvRCp8hCM+vk3pmfmzv8SbhLQn4qnu/gucFk2GAI9QgrlWIUJi+4Zty3vcmUccPEN6
	NXwj
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

Selecting DMA_CMA directly bypasses its dependency chain.
This can cause build warnings or errors if the required
dependencies are not enabled.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/all/20251022141705.714b19b5@canb.auug.org.au/
Fixes: fce217449075 ("ASoC: spacemit: add i2s support for K1 SoC")
Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
---
Changelog in v2:
- this patch is introduced in v2
---
 sound/soc/spacemit/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/spacemit/Kconfig b/sound/soc/spacemit/Kconfig
index 2179f94f3f179c54cd06e6ced5523ed3f5225cf4..e11f600a327f58681ce46df6e0e7a70f5f1d1234 100644
--- a/sound/soc/spacemit/Kconfig
+++ b/sound/soc/spacemit/Kconfig
@@ -6,8 +6,7 @@ menu "SpacemiT"
 config SND_SOC_K1_I2S
 	tristate "K1 I2S Device Driver"
 	select SND_SOC_GENERIC_DMAENGINE_PCM
-	select CMA
-	select DMA_CMA
+	depends on DMA_CMA
 	help
 	  Say Y or M if you want to add support for I2S driver for
 	  K1 I2S controller. The device supports up to maximum of

-- 
2.51.1


