Return-Path: <linux-kernel+bounces-885822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A95DC33FC5
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 06:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEB2E462C73
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 05:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FFC261B9F;
	Wed,  5 Nov 2025 05:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQpfZrf7"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A161F23770A
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 05:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762320239; cv=none; b=aFt+eKs9l1NqZs2czo3z3HLHCEjnjTRD5CU4lhJDx1ocFbOAr8JcuFOQP7664ZV3o+bsVuNfYgf/cFR9vTZrRGA/Jlmq767H+3hVANqMajtsbc87ZqlFSYO4n6C0aaLokD8L2UjYrqMzOfJ8DmJAHFm9efrn74iaeifLTvI7gzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762320239; c=relaxed/simple;
	bh=vMnA4b62LyVOX+kITGE+k8NsudOnI+PdEK2A45KcDPE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n6uigC3NukXCKNnYASf5u2EOq4qkJpFUd/Y0LttcAYkzdgirN//PctpimoBoYmHNYnMd/pISNHwx4XknKUZn+x1iVm48YL+r7/4+MF6ymysHAYucB5HJ1+KaUv6gXL83cIxxpFF/WLkkzz6M61bG7ZD3keE9aBX9BUTGkAssgrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQpfZrf7; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3ece1102998so4254069f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 21:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762320236; x=1762925036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AryDtBRCtbnQiPG+FgwX1TudBAH/Sf1WgDB+03Apd6M=;
        b=BQpfZrf74FNiAt10Oy0ZO8Dz+McOCfilUqGjms8tsd45BKueYG1CRtF2cI7Fp1Jm3I
         dOeev0D3wHB9DUlW3oNFNVugkV+JDzIo/xnaVpMTk0d99YSHIKqpgoaS30fIUfes+5/D
         qKehJNcDV+ZvqGSQPKtT/a/cKyn2z/WGimE7k0aeyfvRRWvHu9ZDnFwe8K43jDAc7Uqt
         LoBmBxUyHboFx9M1JpoI+zipwNFi1ZtcgYR+0bgTuxT7auOLRqurtyXSpWt3FymmJ2Nu
         yR4bTm/8kt+uCvapslWJSa1EXoQ+WfQC+toR5jz3AW8+kTgmkvMI7N10B4J1C42s6ed0
         j7BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762320236; x=1762925036;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AryDtBRCtbnQiPG+FgwX1TudBAH/Sf1WgDB+03Apd6M=;
        b=ucSc62WitEBAmqpF7UHuEpJa4l5BmciosXBSgBs2h2QmT0wfP4S+hVxlJCJFKgOz6u
         ZbztKSSA+Azfe+go7LURWmNq9FdqCeQ27U+G+IzrF0zDbmCNpD76a/2Jl4Hvf1wW9ucb
         NN78LTMciwsbGBWN7cnBdpvifFnr+kGHMf7CsaXwkp43y7YXGnJ11x+H339/432me+eP
         5s5LDxk0FXMBXtQQ686j6/FuEfFRaKlJ9PERgU1ARs6dNiGvRV3wW6xIWBe5sJrV3OhL
         QWaczR/XwMYM6wTURwWc7+e6rgsEpcZXzA1oBDQv5HJvubiK1O0LskobNr2GYHAtQiY1
         EpIA==
X-Forwarded-Encrypted: i=1; AJvYcCVsBly9yJOt/IRqQeLaiQd/FE1tHc05Bl4ETZj2/vVRAQyeQ9TffPJnp3LQeB5lJkwrFxD/P6wQAksWPc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXK55eu8unRQoY3uCJSbbUM9kqQu7ac+j1/BkI+i+eqJ/zZX63
	B6r8ySIfcFaGVUAdsH5x5YldRZMORM6aKuNo32OZRbl8QbUluPMjneLi
X-Gm-Gg: ASbGnctJAqI3+k8QAKOIjuzIK6P85Jref4R+faO4YxOiIsavySUoi/4ng8kn4M2R/He
	prDOgi2TR6Hu+4i1F1Ow5STXnpucS6eOa2deosRFlvgvfc880Mnz7v9QCk25ngkTSk0kZ4xv3Jo
	HHh1GEmDbJQ2nSU0vlYeqZkAY0sVzxvKm9KXmU0NXFWZBUo0TNaipim2VcHi9106xtE42ER1tvB
	fy5+bOIwf/cVEvTZdGcmukHopYPNuZnpkSCyf4eMTMk4G1Ln8+aV0/8HP3tGiCuxohhVm1Dtmqe
	eXOpqJKL2YKnW1pcDsF97x4lcNI1vrxtPM1gr4VMRaQeo4g+pjD+E7FjctJ5YfYVuFJLOr4qNmW
	smdFPudeBni/8O23hfhTChjF6iAlhvRaejLfGDFzfFrpSvUcYzq3dg0DW5hcFdinInGtIAcQ7ru
	zZ/DfOMq2Xh26uQw==
X-Google-Smtp-Source: AGHT+IFXnns6DvO6Tz+dYOGSr8t9XwwvqFN7DRgi2I/5OsUu5Kbr1vlFlSJ/pAsSBpj5U1U7TK8YqQ==
X-Received: by 2002:a5d:5f42:0:b0:429:def1:777d with SMTP id ffacd0b85a97d-429e32e35d1mr1483263f8f.14.1762320235701;
        Tue, 04 Nov 2025 21:23:55 -0800 (PST)
Received: from gmail.com ([147.161.143.107])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1fbeadsm8190909f8f.37.2025.11.04.21.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 21:23:55 -0800 (PST)
From: hariconscious@gmail.com
To: shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	festevam@gmail.com,
	nicoleotsuka@gmail.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: khalid@kernel.org,
	shuah@kernel.org,
	david.hunter.linux@gmail.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	HariKrishna Sagala <hariconscious@gmail.com>
Subject: [PATCH] ASoC: fsl: fsl_ssi: Replace deprecated strcpy() with strscpy()
Date: Wed,  5 Nov 2025 10:51:15 +0530
Message-ID: <20251105052113.39999-3-hariconscious@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: HariKrishna Sagala <hariconscious@gmail.com>

strcpy() is deprecated,use strscpy() instead.
No functional changes intended.
Link: https://github.com/KSPP/linux/issues/88

Signed-off-by: HariKrishna Sagala <hariconscious@gmail.com>
---
This patch replaces strcpy() call with the strscpy() API.
strscpy() is preferred over strcpy()/strncpy() as per the
kernel documentation.

Thank you.

 sound/soc/fsl/fsl_ssi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 320108bebf30..b2e1da1781ae 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -1447,7 +1447,7 @@ static int fsl_ssi_probe_from_dt(struct fsl_ssi *ssi)
 			dev_err(dev, "failed to get SSI index property\n");
 			return -EINVAL;
 		}
-		strcpy(ssi->card_name, "ac97-codec");
+		strscpy(ssi->card_name, "ac97-codec");
 	} else if (!of_property_read_bool(np, "fsl,ssi-asynchronous")) {
 		/*
 		 * In synchronous mode, STCK and STFS ports are used by RX

base-commit: 284922f4c563aa3a8558a00f2a05722133237fe8
-- 
2.43.0


