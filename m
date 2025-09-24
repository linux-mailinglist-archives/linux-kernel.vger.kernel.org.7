Return-Path: <linux-kernel+bounces-830560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A657AB99FA9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 631F7172A75
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 13:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D39B302162;
	Wed, 24 Sep 2025 13:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ri6jia+k"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8758F302CB2
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 13:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758719279; cv=none; b=No5TlBKxQ234Gpr8yQrVTYb2eXveZHsHAmlMLyVMC0K8RpQtW5PnNlF3n158LvD3aAY3Cin+g1ztt3fK9pgu9jloxXqFwgSIz4U5T2c/uyZ+ZmMNufHLoLH1HJy5q9JcgR0QYvFNIRwNKhMymVnVcss8yK1/cbq3YLB1jhU6AuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758719279; c=relaxed/simple;
	bh=S9krJNAXbYfiBjHOowFzU/MHlCd/viA3rjI5GntmR2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GE8tTJZNC7DgORhpUIoMknn/Cj1cySzU0PdYVC1bEGxGzbBir6re09cC+Ny83ZLknuzjhv8j9g9YMQaRqQS4szqg2toMpckvKXbYO6O3P3uma9Cr36zu/y7ErI4xTjMLz2gWll4Gypfj6A9mLwVjQFd+9kGs/3uBYaT7h+o544k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=ri6jia+k; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b29ebf9478bso524422066b.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 06:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1758719275; x=1759324075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rr4AHNLZpak0/qwDXluW3tBh9480ZbWvsfmpnJ8cepg=;
        b=ri6jia+kH8MzxsCjDOfjBG5/rql5gUUYEJor0TBAwkcYjQdyoCALbQnxfxBYIq2Nae
         uIfWi1tXgg1EOC2hLTzDBLJrQz4buKIgM6gtE7mSQf1TlayQbPS5P/D+r+rkfxPnI2hl
         kXiwCDLovVxqPsi7dBvbbwYhfrzE1fpkhOJCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758719275; x=1759324075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rr4AHNLZpak0/qwDXluW3tBh9480ZbWvsfmpnJ8cepg=;
        b=HKSebEZ3MBI02TepnUHo7GbYtlS+pEC50xwq6T4y94H328ecYThxXIWuq8Tywbq+Fj
         GLFyBTKFrvdzQ1Gli0nR8XGwyhhKjUfSFPJvM7mD3tbVb+idFa1gVcNRtPBQQaEgjxBT
         gnGZeDPO7J2DoZvwKGsCMuvsr8VB3ZrpGvw6srSw0Xku7QYssttWlK/qWG8izA3uTuBx
         KG4hO6PoLHm3FOcdQvSr3tpg0u0I9bD2nC+raqB1+3t5A3e0+ZURAKysAr4brvB6MGwR
         4Tpdlz8voWtyyVKgm40Z+ONfFipdi0pCSUyDM+5FCWMxVXPL3fQLuHbop8KyaERH5XVn
         qbDw==
X-Gm-Message-State: AOJu0Yzons6iQxf9Q1VZ6Fc/Eii8uPPJU5lIVU+kBG36Y8wRkEKjBGZs
	X6yKLc3JfJ3TXOMpQo31axBHbvP/y7XhY8I26ldHZSuNgBa1WWWw+Bl0b8Sv5AGSkX8gHjWEnqt
	Iv3tsTEE=
X-Gm-Gg: ASbGncuWzqbsq0TbCIaUCws+K+lDCrE6APSisojo5Z9VsNyLO7tve8A6lfrc9JunQmO
	w2TbkRFH3Z2+JLokvi+1LIkvEGnXpV+BQGo9++9W40tuMu/ELA7IzNiPuW0Y8jS7QLc+SmJNf9Z
	YbaJO4rZi42dLIhDqYOw7L5zIH8qB3bHoJPyAaEz6FvuIcXAsJQsw+T3Y9rUNfdK6h5R9LjgsOa
	K2BsXKHh2S8rIc2A2bs6eYmpz/SU3iaH7VyMs45kCgDMG4C2eudTlt6CSEVFEmmpM9FS0pHH7O5
	iYm7g9SUn5x7nOWCJNRJ3V5Ft95JCTQ1QIpPxAYtOI0q34CZkwwc3+IIgxXIcgAQ6vY92NJWZea
	KoPAhA502OEi2LQn2Tfy8ZjmnTNCMNUG6XZhHksIqaqby0e816umRzX1yB3u/ZXXpw3xw0MLmxm
	w3aTk/gctpf1T7p5k/wbutH0D0ClGGuvLkypeGJ8EeKAirjhAGVKLSSaoTowU=
X-Google-Smtp-Source: AGHT+IFx9RJ+/2IFWtcGeD4AIDWcZcKVdKo7r0/4aN/+yno0pYXxsSMoGTi5NzRLLyVL5lFzEdLoFQ==
X-Received: by 2002:a17:906:6a03:b0:afe:dd76:7cd4 with SMTP id a640c23a62f3a-b302b21c432mr677014766b.57.1758719275523;
        Wed, 24 Sep 2025 06:07:55 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com (host-82-56-38-125.retail.telecomitalia.it. [82.56.38.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fc5f382b0sm1574379866b.2.2025.09.24.06.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 06:07:55 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Eric Biggers <ebiggers@google.com>,
	Fabio Estevam <festevam@gmail.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Russell King <linux@armlinux.org.uk>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [RESEND PATCH 3/3] ARM: mxs_defconfig: enable sound drivers for imx28-amarula-rmm
Date: Wed, 24 Sep 2025 15:07:46 +0200
Message-ID: <20250924130749.3012071-3-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250924130749.3012071-1-dario.binacchi@amarulasolutions.com>
References: <20250924130749.3012071-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable TLV320AIC3X I2C codec and simple-card support used on Amarula
rmm board.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

 arch/arm/configs/mxs_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
index 3b08c63b6de4..603fb003b223 100644
--- a/arch/arm/configs/mxs_defconfig
+++ b/arch/arm/configs/mxs_defconfig
@@ -100,6 +100,8 @@ CONFIG_SND=y
 CONFIG_SND_SOC=y
 CONFIG_SND_MXS_SOC=y
 CONFIG_SND_SOC_MXS_SGTL5000=y
+CONFIG_SND_SOC_TLV320AIC3X_I2C=y
+CONFIG_SND_SIMPLE_CARD=y
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_STORAGE=y
-- 
2.43.0

base-commit: cec1e6e5d1ab33403b809f79cd20d6aff124ccfe
branch: microgea-rmm-audio

