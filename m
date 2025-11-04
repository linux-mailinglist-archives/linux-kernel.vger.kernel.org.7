Return-Path: <linux-kernel+bounces-884712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 094DCC30DED
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 13:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8702834B79B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 12:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879BB2ECD1D;
	Tue,  4 Nov 2025 12:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RLVBLjuT"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09C22ECE84
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 12:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762257841; cv=none; b=cDLVzKDLJ+a5nwY93vKFvcnSHpGLkYRsEyPkeHA2InIafVgYfcP+Ax49QtQrzRlohiULup9j1sx28emwlBL8buEhv4TZQVtfhDB1LuFS5WIRVVxAHAZ3YWYd9wcxDqw82k81E0ZB/H4Ok/f+e+M0YAaCFMS7u/mAfT6I8svw1fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762257841; c=relaxed/simple;
	bh=j0EXgrYnvVA59AWsBuPviuInGMrdX8MUdYFnXuN3nj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YOek2eMyf3RxkAwqKXHfprTRi2ahnsGmhtjCssiPh8AhGLzZNm0oyln9gg86DrTUr17kPH1gae+9jTAxb2q9eEOaAllufuquC4/nB6dkW0PhAUw2Cr89Zg22RadeSaQvP+y2kVS1UxyTrxLOEwm/7egMcGgZVaS1s0W4FRFJZK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RLVBLjuT; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b3b27b50090so841958966b.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 04:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762257837; x=1762862637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hQ5uBVedfr9KMSyQo0sT0JGcllMUFdDYdUnW2PHKUXc=;
        b=RLVBLjuTdkrv3mYRUgR7W8IF9vBK9wu+UToFWAx6wOYG4zZrlHU2/SmFnjrP5SOgMH
         g+lGWXMR0+nSQb9m75KuVNt0cWxKue4/493Zt/mzWwzIrIsYF53qlCNQQaQg6HljN28c
         VDA0cwsJbTiK5Iu+7aeF57yAV60CIWd/pQv0dAXVQiXasysKDyO1ihJ5aDvZIF58MFuy
         w1YoNTFXrdu8PhLi4Ge9nWhMlgQM+LgiDHFmsSgCvSc+qS5RRSJaMeY3sXbmNbs3iSJD
         m7miRS2QrUFlnXFa8gi2QkLlJfE27QUNShjLXzzlChBRslBTogSM5d6NZT7Lav95eMOi
         jjow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762257837; x=1762862637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hQ5uBVedfr9KMSyQo0sT0JGcllMUFdDYdUnW2PHKUXc=;
        b=sWdPgjVsqZXl5D8530EpoLjYMlgmG/sJ/08HzQPy7BpFMNZBYQ2SHltQgPJQycB/xE
         93Tzihqb7IzotoLT1CzjXTh4grkoZPCnbbQq44kNnvV1vCuUzgNKOouNLVmUEfi4CHrV
         CowxeATymsfv1yVYSvAmcQ5G9bWE98mloRqIK6QqQA4shPGF3hkEPboe72fucYZrN38C
         sUaG9dpR3qUXTdFjWU4RJi4flpx8JZbil2i/YV5ULQPCKPwJnOaveRaKkvL+8lzqOuhx
         1k4lUDndFsDNWKvB4jbgU5B1Hgww9MCAAYlBGkZNHpC9hRiJAODFMQglbny8Xw6ICisp
         0sxg==
X-Forwarded-Encrypted: i=1; AJvYcCXYaPfgVFrtEpcLxMND2CbCMcjB8gSkMrh7A07k+WgzSs3MYAmd2ZFWFYi1M9iimswDGbetFxUt3F985Bg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz07a3dp8RPMtUWGyOJe1ifKSfisah1HQVD7BlpfKWPkPvO1Cbr
	6nC3Nx40VxjoA60G8u9UqyL8aqecwrabEwwXN5GwZJwgfVD2m6VFtc3e
X-Gm-Gg: ASbGncs5d7Ryf29UKav8tAaWR7ftcYWgKg9c5cTQ/velClEHkdlf99GJxdPeQng84QF
	RSfkiNnmcWJZjbsRzMg0kZrfaZgUXquBJyK7q150PM/p9FcWMsvM1U7DfZTgXz+CozLJRKYzb+S
	ehOeVqiM1UA+r4mDVmAX+2dNniNWF8CfZE0rcW72YrZe2hIHx3cyTeG48wlhRGnAWkCcI+LYisM
	UztUNpAM52VdF5tBvGFpGPqUm4pOOWsCpuTIPRIrvQD7HdoGz0t8I5NhBS444k1IZ8P3LRPkmbg
	1ht6hNN5DUBE0JKHEhBdtsRdHnsli93yE5Xp7AmlrlY1gwvZZGRt3I6GPkwf4xoza9wl1WsxGrN
	QiHPzNvUU4qyV0fNbHo341cTF3PsXPqGjQ4VsMPEgodwAR5XZM+E4/RROZ+C9n7TQra+WcHaL17
	h7ceaIVQz8g0fVDfy8nX1W3HR4Eg==
X-Google-Smtp-Source: AGHT+IHt2fE/H6FCE9dPp9U8nFD+BbuQEZr0YcTeeDYKJn0Q0W8ZsDGbQTHbvxjqtH0OMOcDf7SSqw==
X-Received: by 2002:a17:907:9484:b0:b40:da21:bf38 with SMTP id a640c23a62f3a-b70704b654cmr1611290866b.36.1762257837013;
        Tue, 04 Nov 2025 04:03:57 -0800 (PST)
Received: from SMW024614.wbi.nxp.com ([128.77.115.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723fa038e0sm200894166b.54.2025.11.04.04.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 04:03:56 -0800 (PST)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Abel Vesa <abelvesa@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Frank Li <Frank.Li@nxp.com>
Cc: linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH v4 1/8] reset: imx8mp-audiomix: Fix bad mask values
Date: Tue,  4 Nov 2025 04:02:54 -0800
Message-ID: <20251104120301.913-2-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251104120301.913-1-laurentiumihalcea111@gmail.com>
References: <20251104120301.913-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

As per the i.MX8MP TRM, section 14.2 "AUDIO_BLK_CTRL", table 14.2.3.1.1
"memory map", the definition of the EARC control register shows that the
EARC controller software reset is controlled via bit 0, while the EARC PHY
software reset is controlled via bit 1.

This means that the current definitions of IMX8MP_AUDIOMIX_EARC_RESET_MASK
and IMX8MP_AUDIOMIX_EARC_PHY_RESET_MASK are wrong since their values would
imply that the EARC controller software reset is controlled via bit 1 and
the EARC PHY software reset is controlled via bit 2. Fix them.

Fixes: a83bc87cd30a ("reset: imx8mp-audiomix: Prepare the code for more reset bits")
Cc: stable@vger.kernel.org
Reviewed-by: Shengjiu Wang <shengjiu.wang@gmail.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
---
 drivers/reset/reset-imx8mp-audiomix.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/reset/reset-imx8mp-audiomix.c b/drivers/reset/reset-imx8mp-audiomix.c
index 6b357adfe646..eceb37ff5dc5 100644
--- a/drivers/reset/reset-imx8mp-audiomix.c
+++ b/drivers/reset/reset-imx8mp-audiomix.c
@@ -14,8 +14,8 @@
 #include <linux/reset-controller.h>
 
 #define IMX8MP_AUDIOMIX_EARC_RESET_OFFSET	0x200
-#define IMX8MP_AUDIOMIX_EARC_RESET_MASK		BIT(1)
-#define IMX8MP_AUDIOMIX_EARC_PHY_RESET_MASK	BIT(2)
+#define IMX8MP_AUDIOMIX_EARC_RESET_MASK		BIT(0)
+#define IMX8MP_AUDIOMIX_EARC_PHY_RESET_MASK	BIT(1)
 
 #define IMX8MP_AUDIOMIX_DSP_RUNSTALL_OFFSET	0x108
 #define IMX8MP_AUDIOMIX_DSP_RUNSTALL_MASK	BIT(5)
-- 
2.43.0


