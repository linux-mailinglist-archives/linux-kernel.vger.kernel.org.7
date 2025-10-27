Return-Path: <linux-kernel+bounces-872072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5C9C0F41F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 17:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2DEE428081
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE72F3115AF;
	Mon, 27 Oct 2025 16:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="VbZDnglb"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979CD30CD9D
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 16:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761581454; cv=none; b=U6KoeJ2I4QmW4d6xS4vMopzefJnOhoYOxDiKB0xBMZl92ictiVqWW6Ppq+Bm25YoHXCjPqDC6tnkItSnRh649tsJpCu/1O87SL3PKPb5NFek8uFLjKPEuiv+20epSFHgBHpgrnY+SZBPcvieZxsY/FBrWXRil6adD/fZLZ9Mi6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761581454; c=relaxed/simple;
	bh=cT+JbXkJCjUndBEl4/KvRhHpw6r6Ue8YLOgh13Ob7jo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uHmscjEH3mCZOGu7MUfAUCHqY57agy9sPxH9+FZQ7J1jq1R13BqEPVz/tiL71sRFJFNrychr6KjRA2Z6Extlq6PoJLqqrfhOXOy5WB/7pVxDbn1wijjGzuGgn3ze/BrfsonZqvpDgOJ0TpCysti1yNJhVp4hW1kf6Cb4zRtKtIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=VbZDnglb; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b6d4e44c54aso856418566b.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 09:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1761581450; x=1762186250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kT3v2aN8EQq8AgHMNf1v3TkZG4Dh+2CDgf66x9dYHZg=;
        b=VbZDnglbj8QgAvXUTOxUh4wYb6ZiInjWzB23yHH2/TGAjkX5AKR9yqXhthS4y/YbnZ
         CXbhSomL8XO8A/uezZR7me1NlC6EReZjnmtry8G2APAe1u3bo48KzMLtzjFYPUkmWocK
         JJ6apsQ5MfWRXKlcEQMpaERrx6w/0vDSkOmhI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761581450; x=1762186250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kT3v2aN8EQq8AgHMNf1v3TkZG4Dh+2CDgf66x9dYHZg=;
        b=EmDA6cjjDHdGd56+hi0d9m8Nr6ZUQ3oHX9aOcZnkfLVZIR0p05BLZwUJpp2F+/Z266
         gOJhSgeYBhf7lRIdos4BRSVZf9CSduL5+h2wx+cZ3xkndqW9/LUAjRvVy/bF3i/iP43T
         Y2mBQFZVai0AZqmXRMDT9DAoId2EAAqNwNO4I4jlB0e+bsQhex4+G2z9WwjKN+qdlN0d
         QiwvLaZYvyJ63WBhamcGUQ5OU4JLLM6RiRSCNlT/vob2KgLvtvSdCtC2eV14xaM1Ns7s
         Nh8WCcwsdxKU8rdnTwpHdOwuzP1+hrOhcdZaqrGPJiVFwJtGgSZBgMgjGxzPCtzjSZph
         /CWQ==
X-Gm-Message-State: AOJu0Yxfhfb+PuknQ32MRhm3qzCllquB0hth/22jiPBZ75gJOqFirIHH
	5nh3Wjc/fdftZEPb9V3ea6rs0jgdBnxI/IJtr2k1WEb2TShaCppv6ch/nMFIdIdIssQpT1V29I+
	6ZH//
X-Gm-Gg: ASbGncsctPYb2POPFu+t2Ad8jwtfuGYUtfZwC2KFGn1q/gQbbaNm+wgQdoa5fvBP8RR
	8lQKt4CrfmrsGDT1knNAkAIuSXT4kLEakp0+oENgTUIiYDgw8i+v92LDQbxa7KFoJMwutFodiwf
	/G8VZ7hi/ITGT4qzLxyUXLy9AiCd2vDsj9DKQTH5Fujc4EZ+icByoK81cuIN/Pusf+FCY4V+jge
	zyFcmUKILp66yXma/Yj8I2oUosG0lhR0tNp2Al6jlXr/R1gGh1C7EfYN4TDtrXAmvOdb76i53xc
	azDkynlkB73a0mJBV07k9jEftQsUEndvzdXZQ8fDznPwsVTG3ua9DM3pMlTmot9NvvhGWvtcbD2
	uUhOP+grXhbMfB3tbNjU37kJJ7jyMXOJER36Kv1W6lSX7mmIzvz3obwN9qGJcojLBoimUct0XBU
	mGNPMJ12tl/3dBYlSn0SrWBwO9GlRJ6tlTjaNgJtUiG6ylfywVML94wneO7q/vHwrVrx2+d75Q+
	9sG5nT5cFv78B0JraKWYG3C42CXNdpIwRYQSjArbC+v7lzYcZ21gT4=
X-Google-Smtp-Source: AGHT+IGpgYAzuEZ5slMssED+lqV263t1SAtoTQLAQnIGqZGLNwmT1wHA5r73stv598+NcofTsL2dCA==
X-Received: by 2002:a17:906:4787:b0:afe:cbee:7660 with SMTP id a640c23a62f3a-b6dba487ad0mr49506766b.21.1761581450341;
        Mon, 27 Oct 2025 09:10:50 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it (host-82-50-34-170.retail.telecomitalia.it. [82.50.34.170])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d8ceeaffasm742437466b.45.2025.10.27.09.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 09:10:49 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: Shawn Guo <shawnguo@kernel.org>,
	linux-amarula@amarulasolutions.com,
	Mark Brown <broonie@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Eric Biggers <ebiggers@google.com>,
	Fabio Estevam <festevam@gmail.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Russell King <linux@armlinux.org.uk>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/2] ARM: mxs_defconfig: enable sound drivers for imx28-amarula-rmm
Date: Mon, 27 Oct 2025 17:10:24 +0100
Message-ID: <20251027161040.2020623-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251027161040.2020623-1-dario.binacchi@amarulasolutions.com>
References: <20251027161040.2020623-1-dario.binacchi@amarulasolutions.com>
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

Changes in v2:
- Drop 1/3 patch "ASoC: mxs-saif: support usage with simple-audio-card"
  because merged in linux-next.

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

base-commit: dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa
branch: imx28-amarula-rmm-audio

