Return-Path: <linux-kernel+bounces-819106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2F2B59B8E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 17:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 150C63B1DF9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3351735E4F5;
	Tue, 16 Sep 2025 15:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFN2pbFq"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C35135084C
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758034990; cv=none; b=Q/4fzH1A5C0mdef7v0+nPFedvjUIoKOa3L4cF8euMWxdJB4HqGG7ewjo0AkaSuvgD4DUs1WLTvyH394nNorlkOkmQfVraMw7W9OKnCb1q6boVSYSG7CkNBlWZQK0sBQp2VdgmasE+DPoIXmLwtV7a+OpHgF/L6e78qiKBVKYm2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758034990; c=relaxed/simple;
	bh=p0XHYjWm6PVj5hcDpoyJfwFzpCOsy0hYx3RRzsnxsME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HRQcyeSe0LSL0Jhjt0VyFoxdOC/0ikGQMwutwKIXY3XT7nOTwhqi14uTcQY3DJDi2YUQySK/17A/GQko5BqdRaC2mQP1UT8+D6yNzuQ2Sm6PEXjN1Qk/Ft7ZDZsLIxZAKh1vPxB8LskHo17RvOzNCJf6x/tTx98JxHv92ziEDY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DFN2pbFq; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45b9814efbcso41966105e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 08:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758034985; x=1758639785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a3K9HF74mxQXiOLLFFTSuE0GixIWTnEsWf8ibJCzoHw=;
        b=DFN2pbFqK62YNH1CqRJaqNGr0TT7JX/c9QwFnT/xpjsWBnvTnjxrVY1AhXOgYQuGzI
         SyF54X2cJ3czf/27KGdFPRNb28X3roR6tJzCCIFaeh8HJn1uAXxr/ZBM66eBRcsR44yE
         ewsLXzZy8Xy9dIbfCMoVTxCelG9+vkeoSMyIIdsG8oaY1ZwMb5nTr2dBmD2dvRKra65a
         OS49FU+ryZaVCfjc19kmeZNdaH2t9kG7ipDG/7XgGsnopqGCdUYUvrdmHa5GBHCjoHBA
         NbFPbBuvved8ltWvIYEfUUYrRQpA75G8wgj753DWt14bj0t5kiNbq+NONphdKhoAjE97
         yP9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758034985; x=1758639785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a3K9HF74mxQXiOLLFFTSuE0GixIWTnEsWf8ibJCzoHw=;
        b=aEgL2V+1XLmKTPA9vCOBG8V1jlUYvS76MPaWnJBvf7qt3EWaAx1oXxdU52NUpcgetF
         O3xA6rhXOdnN828+vWbzkmv+U67xnnyzQOt/GyLLlIhlXPsyRaNgyqsmfRq+NkFtQ3sJ
         K+wskpb3lo29jC/IadCd6Tl8ivB6t8ZgN3eM6WLsY4SjWE2auXAAunJGFcgCUbMMGCPl
         QaSUK5jsCOX+vatob7uvKlBLRAM2BG9+c0V/mDqLU4lbALB3odUd/2P0E3hFDQGYUJCM
         AXogu9obOt2KgxxmrR1slsiB6oNbiQDbAe2Y0lcxmwz/adsSgy9ioMom3RJb2x2tSotV
         2YoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzmpa+4+dTgCiD3BjixzZ5I9K998PS+338dLuvCnBePF/7D03Ne8cVOClt9bZqTzpDsia93w8nb0lI7IY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt2DMycEWRlDPNoECnws7v5M5jtYdQMwC2pPi/EYsKCvISExoz
	HN8xrrnHN4x0QHI0osongIsLbnq8uzeZFAZiVIvQE3QSSS50Yeoc+9Fm
X-Gm-Gg: ASbGncvw04v2x2rgbKdblWQvJidBk+Nl13CE3rIynhevgeTVM5TvU1IhPLYkpWDdBrM
	cmm2eCaG5nL2e4kZguKfnsLg3vN4v5lFUW7LQas+3v+yE0O/UihLyzYRCJmzJxGctrkHuGJExXj
	CeLtf00kBYwCy7L3WyUQIXZtAGWM8mnPA6EMALws3qZ0iVWHH9VfxpYqutzzcDQ/TSkZ8CzSVye
	KntiQgFyenvVrqV3jvIzvkpvm+8ve5WDf8SIJ5yy/NAH/0oA3aM8IdHE/tNo5QakenNpHpMkHBM
	KhwT2tDl1PFCdMzssCu7BxTumqUbNTVsoi+9P5pWxS+jy0mtk34r0MxqAuZ8YXm6qvM+2j4z807
	W7lCyDep3frfX8bQAYE7Lvdcd3rLa2C3cEgbAYZWzLJmk35zCIS1Im5C0jS3ygF7/l44tU3ZPvk
	qRKQ==
X-Google-Smtp-Source: AGHT+IGjLufNti220Cb2/jo69dHoi79tKr9fu2kHOT12ewBTg4Sxo+8fUT0WB40XsjZIq8dDSZz06g==
X-Received: by 2002:a05:600c:5487:b0:45b:47e1:ef7b with SMTP id 5b1f17b1804b1-45f32d49432mr30917625e9.17.1758034984912;
        Tue, 16 Sep 2025 08:03:04 -0700 (PDT)
Received: from biju.lan (host86-139-30-37.range86-139.btcentralplus.com. [86.139.30.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ecdc2deb20sm932154f8f.47.2025.09.16.08.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 08:03:04 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Nishanth Menon <nm@ti.com>,
	Eric Biggers <ebiggers@kernel.org>,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	Taniya Das <quic_tdas@quicinc.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v3 9/9] arm64: defconfig: Enable RZ/G3E USB3 PHY driver
Date: Tue, 16 Sep 2025 16:02:45 +0100
Message-ID: <20250916150255.4231-10-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916150255.4231-1-biju.das.jz@bp.renesas.com>
References: <20250916150255.4231-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Enable the RZ/G3E USB3 PHY driver on the Renesas RZ/G3E SMARC EVK board.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2->v3:
 * No change.
v1->v2:
 * No change.
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 69bdb56a3d9e..14356d40f42f 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1650,6 +1650,7 @@ CONFIG_PHY_R8A779F0_ETHERNET_SERDES=y
 CONFIG_PHY_RCAR_GEN3_PCIE=y
 CONFIG_PHY_RCAR_GEN3_USB2=y
 CONFIG_PHY_RCAR_GEN3_USB3=m
+CONFIG_PHY_RZ_G3E_USB3=m
 CONFIG_PHY_ROCKCHIP_EMMC=y
 CONFIG_PHY_ROCKCHIP_INNO_HDMI=m
 CONFIG_PHY_ROCKCHIP_INNO_USB2=y
-- 
2.43.0


