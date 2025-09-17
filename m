Return-Path: <linux-kernel+bounces-820200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D505B7F4CC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0755E521C73
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 08:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7536230748C;
	Wed, 17 Sep 2025 08:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="opUAs/zl"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D04306487
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 08:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758096342; cv=none; b=Rcte4chancnFII+Bz2XNvGeGr53YT5UGf/6zJRLFQGxyG+4aihimLHFxxlcrHUyTJJUCdjEo2g+fRv8PFGGWFzSocKdD0jRLSFV6G62QtRL583rcDbY3QS0C/rVf3MCBC6dqcHFc0dLHqJvIAaVcERJwEpYi3CGtBrGxFZwQfIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758096342; c=relaxed/simple;
	bh=BRys3ZutdevswohgMnBrm5EhSN86iKLozXVmHM3NKNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GO/NlWbSbSbw8txaveeqIqGCF1FkDGrbKl3RV+WLe7JdaEaq9lbnnyrQaftH7VHOr1iUE3ZpBQbbPS4QTxXy+96MAYA/SYZJIX/OU6F1fNn4oTEC0Td40tjC3Ta5g7GJkQft9yxiTsBdi0m5knb0Spi+Ih0EhP5t2wtv/pmdop0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=opUAs/zl; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b149efbed4eso323441066b.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 01:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1758096339; x=1758701139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JAYdvSVQgA1h0haeD8J+mH93pNUjVxDxBFzkQXHtMmU=;
        b=opUAs/zlheXQLMA06+/wUOVs6Hv3UZXvpHVIfU9KBu2O7bI6NfZtTOujYtcY3S725X
         A1ohczR1UY4i/2qHEWUkJxvscGZ0zW8SnsVquFxdRAhtwgRtGpiTyLf5f95J8y/1lxP0
         0vv5QN0BrUDnRufwdzqc7BP8eC4p/iSerr6y0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758096339; x=1758701139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JAYdvSVQgA1h0haeD8J+mH93pNUjVxDxBFzkQXHtMmU=;
        b=h2zVgrE6peEIT1FZWEguGfGiEpFVSuwJLwkgK8ow+8vTAEO+hZSv1R4wJbG+POSRZS
         ZSyN+w/WoqnZkDnwUnyI/0MkRrsbLdaGG0ccQ2SZRln3rhvjQu/rhqksNnZjBg/SyLgm
         cvqzIIeSqcdW52DrDHj2xNslccLV2/I7DI0Sk5/Ey9teOsLseGdYQLD6eRO29GXiqZHO
         /SKeilOMEKGd4f3mLb/BEq2pDORbYDHkBlCo1rCEuofpUge/9QwHLVjQBbvaxS2Iom3r
         VRqWjRJv9l1hNXzHHvBmU30nnwy8E1twShz9KlHT5YyVmufNfi5x1Ems3OhHeHx+NaG+
         XUJQ==
X-Gm-Message-State: AOJu0Yyvmu/U5+SDVbhMp7IydyAHY05ZRD/rYf1jF7qQVqmUMSSpkSFK
	/vltHRrJR6CfqAhOyG12qW+0noAQkiy7YdqpDbFH6rRdT7Iypa0tf4JWkUpNH+jm/gTOZz+JBEk
	xZ9Ca
X-Gm-Gg: ASbGncsfigeCeykP9VFCIRzfPw4IhPVXaMMYbab4DHK2b96RNG/OBUAkL2YgpCZZMYK
	DYautLOvVO72dXDg0LaAlA+hwvZcJ3XH2cG28h38xT2OyZ2z9gdM8JRZnvCltkw7L6J7rf9nHTJ
	chbKmILdqShuyd4qAGmBvWraYy0C/aor2xwdvxjXcIx09uJRfSJRyz1kTlzxbziSyECy1hZ4iUC
	oBfTCuM55oJTuZuFKHta16d3OU8+YLzmAOvAULiOL0y9+vgl25llqSuoJ0Y8F7NQZ+tK2rf2vNr
	OOMOySesGLGbId2zJX3l3H9PASLAbJonNaLu78MEtNl2rFbckhL2uCdhOzoNHrIP2JXisAvyTOR
	QfwRY3h66rMQijA5lCUcZZWeuv3rukedAxzVVNJFVZlxZIkFm+iQtcbtDUsA=
X-Google-Smtp-Source: AGHT+IHQZ9rc3jl/nR/PWKeSWOjOjcRVyHb+GabJ2P0Cvoe8YSOsLplNCUEtCcN7qWi0RlLMh58DoQ==
X-Received: by 2002:a17:907:97ce:b0:b0a:aa7e:a193 with SMTP id a640c23a62f3a-b1bb559965emr139686566b.21.1758096339059;
        Wed, 17 Sep 2025 01:05:39 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6474:ebbf:1215:4a13:8ee5:da2a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07e1aed5ffsm924936766b.81.2025.09.17.01.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 01:05:38 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Frank Li <Frank.Li@nxp.com>,
	Michael Trimarchi <michael@amarulasolutions.com>,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-input@vger.kernel.org
Subject: [PATCH v4 1/6] Input: imx6ul_tsc - fix typo in register name
Date: Wed, 17 Sep 2025 10:05:06 +0200
Message-ID: <20250917080534.1772202-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250917080534.1772202-1-dario.binacchi@amarulasolutions.com>
References: <20250917080534.1772202-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Trimarchi <michael@amarulasolutions.com>

Replace 'SETING' with 'SETTING'.

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>

---

(no changes since v2)

Changes in v2:
- Add Reviewed-by tag of Frank Li.

 drivers/input/touchscreen/imx6ul_tsc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/imx6ul_tsc.c b/drivers/input/touchscreen/imx6ul_tsc.c
index 6ac8fa84ed9f..c2c6e50efc54 100644
--- a/drivers/input/touchscreen/imx6ul_tsc.c
+++ b/drivers/input/touchscreen/imx6ul_tsc.c
@@ -55,7 +55,7 @@
 #define ADC_TIMEOUT		msecs_to_jiffies(100)
 
 /* TSC registers */
-#define REG_TSC_BASIC_SETING	0x00
+#define REG_TSC_BASIC_SETTING	0x00
 #define REG_TSC_PRE_CHARGE_TIME	0x10
 #define REG_TSC_FLOW_CONTROL	0x20
 #define REG_TSC_MEASURE_VALUE	0x30
@@ -192,7 +192,7 @@ static void imx6ul_tsc_set(struct imx6ul_tsc *tsc)
 
 	basic_setting |= tsc->measure_delay_time << 8;
 	basic_setting |= DETECT_4_WIRE_MODE | AUTO_MEASURE;
-	writel(basic_setting, tsc->tsc_regs + REG_TSC_BASIC_SETING);
+	writel(basic_setting, tsc->tsc_regs + REG_TSC_BASIC_SETTING);
 
 	writel(DE_GLITCH_2, tsc->tsc_regs + REG_TSC_DEBUG_MODE2);
 
-- 
2.43.0


