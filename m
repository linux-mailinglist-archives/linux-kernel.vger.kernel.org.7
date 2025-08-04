Return-Path: <linux-kernel+bounces-755389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92457B1A5D0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 17:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D184188B830
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59C9220F2D;
	Mon,  4 Aug 2025 15:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tts1qsLu"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4784D21882F
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 15:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754321037; cv=none; b=QwciWpxeOZR68nCP1coAWQGIVKeaLlKydZJT0mowRvMto8Ewd5UzbUWuVOuDexvjdvq/TTQFSM5sfCIE8CcPfPmp3SVYwZRXRrYSmif/l0g42XVHjCFYgUmuEb9tqaYO5syukEivMkulNhonQacR57vYphci0tSm/YF+D9ifckg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754321037; c=relaxed/simple;
	bh=jK9R1dnUwKGI3zGLQm75/1AN+GpBkqgb//hlItvir0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B5BV3LySvjpzioMtIz+hi268FcJ2GxCmiYJjbgdHK8VZos5VjBVyO1odsDm2ODm97F3u+7rturH0DG9ZXk+0Q6pgKdQCy0Uc7obR1qmNvnA+RqyvdD4YsqEh1nXAOsSg+a8lFtaZFXXv8E3Xq2uBKSaoDTLLF3r1ll+0GvwRrl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tts1qsLu; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a6cd1a6fecso3957598f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 08:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754321033; x=1754925833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Bx6PIe+EYTqF7HuIJczhS/0SNZn3oEqyjSCB05qzyk=;
        b=tts1qsLuQWyPwfeD+NmPQNgd/A8FYtDXNu6chWZSgzZY08KgWCpYszacIKJS1XM4+e
         XYEpUaritSjZvPGkGwTfYoTCq6EEjMhUytTwgdwyRSzCmnFLcqOdwsZmLaHwe6TASZ1g
         /0jJ3kZvZURdPw2ckd6J5VzjXC4JFNyzAhfEbxGNTp87C2v/ArdS3ESV+/Dq6FuIlcK1
         wk5ZuN/nRiA73ypCIxaKhDNyzmMzIZPBLznEc4ek1ue+zl78+Uh5ovnmFJsgxI76o/te
         HxYRq1a+GNsKKzSdJVk7uFUaNG/JE4Z1Oae6b8RNaCqMd3O/q/wLUfHNCbTj30yq6oju
         0k8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754321033; x=1754925833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Bx6PIe+EYTqF7HuIJczhS/0SNZn3oEqyjSCB05qzyk=;
        b=sS1UnXqwj+9z3UIKoNveQZvmsKSeVfqYfViysRmWggWuCAeqgRRuGJ8h+62jGaH8iM
         o0ie3pikS/rglVl9OicO2l4tGKGFzbtfntcTo/AL+TjoE9LFEAqJYnhiLYUekbYC0FmC
         2nT9d1Qh8lWJMKMzcKh1xAlMtGNc6R1iilVZ7AIlkj/8pJwap9uJI8h7B/l9w3tNZJ2X
         2+uzX1gwRr+KVK9YCdlSIOKjJzKZ+qBnXl68hO2QTbTrfOE661oeDwUzomOB8cxHb3sD
         qOAl+zkHioRBNM8U+UddVUzh0Qie3mkpAUzbA5w1X5HkjQGDHlX4yIbZ4cKt2QTbcR+p
         Q3xw==
X-Forwarded-Encrypted: i=1; AJvYcCXlaibXZDS7TlaSjOs2Gghgr0CuQxnTu6BHOIwU//ajxgJZkCdSWxmQ80+q8mfmLKF+h4NilXyggyAsbWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoGMwhSQMpMj8T/Apf9mBoYR07TkzrQUDROOtVfLJ10EO1q8za
	KrenqTN+N4EuNcfXsCqbliHG48uN/g+ExCu3FGgWCfzvM9P4ggpuPiUYYCTDI3UfPyY=
X-Gm-Gg: ASbGncu2ssd1P6tiR1ocJNTZVB04o9ZDlvqvl90jlP1jLp/+EsYSNblI7K5yvzdrXpG
	WMLunwMKrcgGSgqqlFMGxPEVh/OQr0t48+6HALo37SZ1K+bd55a0rKKeMhQJo9q2O7PNocyQaZt
	ZBcJYOr1gi3ipJzlEcd1Fv3R7qoxjdNMiETG7lTgpna5vapLxngUS2DjI7oHcZL+JjZ/+fYque4
	Poo7iarNtj5ayIq++wP3XmFo3sCwg//TGPG5XBEOcTniWrWhLxC/mUnPTA2qQH+DIYCwCfmt3Au
	EHzCV7MUyr48B9YqAKvl3QrsmckBXI4KkRbavNXbstnSAUub8fzItXwyKjl26BonMod8gn6OqX+
	50MuV5FtleXQqsubeqMOq5ukPeaY8jDBeBaU8rxLYZQlTavMgrOdBuASIPRU=
X-Google-Smtp-Source: AGHT+IEKV7p4h75mL1zWMoNWH8MyfVf/nrpUD4AlS1EgbjOqj8AzMO37fhNuEgrorQQTWP/OUjrfRg==
X-Received: by 2002:a5d:584c:0:b0:3b7:8a49:eed0 with SMTP id ffacd0b85a97d-3b8d9472882mr7926118f8f.22.1754321033503;
        Mon, 04 Aug 2025 08:23:53 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4530b3sm16335579f8f.34.2025.08.04.08.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 08:23:52 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	tglx@linutronix.de
Cc: S32@nxp.com,
	linux-kernel@vger.kernel.org,
	ghennadi.procopciuc@oss.nxp.com
Subject: [PATCH v3 02/20] clocksource/drivers/vf-pit: Add COMPILE_TEST option
Date: Mon,  4 Aug 2025 17:23:20 +0200
Message-ID: <20250804152344.1109310-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250804152344.1109310-1-daniel.lezcano@linaro.org>
References: <20250804152344.1109310-1-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The VF PIT driver is a silent koption. In order to allow a better
compilation test coverage, let's add the COMPILE_TEST option so it can
be selected on other platforms than the Vybrid Family.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 645f517a1ac2..6f7d371904df 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -475,7 +475,7 @@ config FSL_FTM_TIMER
 	  Support for Freescale FlexTimer Module (FTM) timer.
 
 config VF_PIT_TIMER
-	bool
+	bool "Vybrid Family Programmable timer" if COMPILE_TEST
 	select CLKSRC_MMIO
 	help
 	  Support for Periodic Interrupt Timer on Freescale Vybrid Family SoCs.
-- 
2.43.0


