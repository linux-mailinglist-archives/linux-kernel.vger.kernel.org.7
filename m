Return-Path: <linux-kernel+bounces-745261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A0CB1175B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 06:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E345F1CC4379
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 04:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDD020297B;
	Fri, 25 Jul 2025 04:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GBjt/Jpr"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F964C83;
	Fri, 25 Jul 2025 04:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753416960; cv=none; b=DO8FyvXf7hmymQ9vSmlmPVjbhFwfbYsa0nr+7dj7YU7JQSsHwbnxyt8oe/HhmRdkaGb/U6lgmDY5k43jtjEjf7eMYq8C8xXlwuswCA2YLNCsrqu4Go99fY9mEehaqjD3S0Z4binjiqrgSWKA9mLh4SKUGKJ04IjuNj46/Qa/PVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753416960; c=relaxed/simple;
	bh=Q0e9u94rW3Jfkx+y5FFMQvmmN6VUWHZdVKOCpcPPiHo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CZ3m1HkdTILj880WzV6KoqhZ0j/fwJla1R5UrnJ37K9pNeSpQUu0wJlh127Aiir7XIwWycsolCBOPx6Z6VuwR1HmIrHjy08eFXGBHWXcfa5ZJGQBXbxx/qDSQIcVFra7vSu1wf2BPiaD225xigVc1Kb9OVfpeWLhQE7hdh6WiYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GBjt/Jpr; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-234c5b57557so14950945ad.3;
        Thu, 24 Jul 2025 21:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753416958; x=1754021758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d1haI0gCwRRPokBFr8QJa7NTwbmxoWWpXWwux6OgkUk=;
        b=GBjt/JprP68nQLUZAVfV9yf8QhrtYx2htwnAMKA7eVqEEh4FI80KrpVM5R7UTBueMd
         jiWB4JgjcYSdeXn6Mq4LHShNQcVY+9JjTWkokC8Brj3C4xIbOmgnoE52tBmR3gy8jbK6
         E0AHJP4bkJyYJWBxhnLPgtBj57e2CwU/KloV4Xllw5+627ZDc7QyHmuB2bIi21VeN07j
         ydMa9wzlh6Ip8JBb61FarLGGeJN/cy/rOdH2XBLqdvSWiMJeQF9LjcGWzKiKzfTiHwNb
         JxEJehtx1rQZ24LFkyLYciKjCvGvoO1xOXK2RQqx6yUaPsjTf0c5vtPZc1K1/AVcMPho
         AoOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753416958; x=1754021758;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d1haI0gCwRRPokBFr8QJa7NTwbmxoWWpXWwux6OgkUk=;
        b=LwSIB8t//orb63gtaWCzUYfivdIwLZUMl2TtN/fHKO//rPJSKQUMv3hy8JXd/Tg+t2
         FDPBmy+Psc/HfbcruGfX4mtSC1Rmq59szj1cHsz3377uxFZRiWfrVrGyP93Ls0KaD8aC
         57rYOQ9kXe6BjSew6xcBspQvLZcxaVh50YywCpRrqSOC5olzOULjICSgQCGI8hIjCJrE
         o26FrUUwe97+7LM5zV1+nkpEm57yxE4MxKbVb5WvlvERbSJlZRB7vjeI50ZYZyEcBTi9
         WkKjq8qTdlim6tk2o4w6Eia+FdzYLxtN/+t5LPIrANQISjun+d9vix4jBxXHVR1o1ycO
         E5QA==
X-Forwarded-Encrypted: i=1; AJvYcCWHt/blCdH44x+OF3rrKBZbOV3VfCCvbKi1DxXKWNWJcdx4eHjfUtd+qfcgGyax6pkVxgbWb6ybnGDk8ck=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhl5TFEHZSjw1KqNHJxLKLCmzaMRyIPR+J7QhDgApNiAqvydhf
	qAccQ7LF3+iRTSmqIm76LET41mafQ3aqHW2jUmeHAoqnZc3ux9Rpa2Ns
X-Gm-Gg: ASbGncv5X7tPcBEd9boNYuwhwnV2TcOoJO9pk0W8t2V+iFeZ5FCEnBqxXhbN4q/WB+H
	b0UxBfwc4pJEyl+TUuFVfBK7PigzZt5wEte7jnZPc5lca7/1VMiPIdnOt/08B5Y4pvoJ+WOmiaq
	Wn33QchHL6vyMlrjuUbMQk/RKjw3m+sUUfzHFlECHhaX9IYBqER/TAMiiHswiiWLQUvU0RPjH3N
	CLN3FpfrjM4DpJTQjj/ZdUKKOSNeXhvrbF7KbrzOJai825dTNDHs36a2oejJWXbl18ADqCeQzgL
	eWFCV6XAhRbsHxWwWjseLS2SJ8rqKjqf+c0yDesLEfhIu2GCUE6H31v+vLSyi07IZVZlxrv2uRB
	bBOWTMvNWHV7aMIvwBHe+v71baqhSqpBfraImiCAaWqvxELi9StQaVibS
X-Google-Smtp-Source: AGHT+IFqlFY7wlaX1miKuyzePzjRyOSo7j1l36a0gkueAGzH8txV2BceRcppLgQERmkg6ylFcR2cJQ==
X-Received: by 2002:a17:903:2f8a:b0:23c:7b9e:163e with SMTP id d9443c01a7336-23fb2ff890dmr6125885ad.11.1753416958290;
        Thu, 24 Jul 2025 21:15:58 -0700 (PDT)
Received: from fedora (181-162-135-125.baf.movistar.cl. [181.162.135.125])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa4914681sm26744725ad.200.2025.07.24.21.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 21:15:57 -0700 (PDT)
From: =?UTF-8?q?Ignacio=20Pe=C3=B1a?= <ignacio.pena87@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ignacio Pena <ignacio.pena87@gmail.com>
Subject: [PATCH] drivers/clk/clk-hsdk-pll.c: Fix typo 'succesful' -> 'successful'
Date: Fri, 25 Jul 2025 00:15:59 -0400
Message-ID: <20250725041559.73699-1-ignacio.pena87@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix spelling mistake.

No functional change.

Signed-off-by: Ignacio Pena <ignacio.pena87@gmail.com>
---
 drivers/clk/clk-hsdk-pll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-hsdk-pll.c b/drivers/clk/clk-hsdk-pll.c
index 5d2a90add..1e95fabd9 100644
--- a/drivers/clk/clk-hsdk-pll.c
+++ b/drivers/clk/clk-hsdk-pll.c
@@ -265,7 +265,7 @@ static int hsdk_pll_core_update_rate(struct hsdk_pll_clk *clk,
 		return -EINVAL;
 
 	/*
-	 * Program divider to div-by-1 if we succesfuly set core clock below
+	 * Program divider to div-by-1 if we successfuly set core clock below
 	 * 500MHz threshold.
 	 */
 	if (rate <= CORE_IF_CLK_THRESHOLD_HZ)
-- 
2.50.1


