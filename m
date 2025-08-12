Return-Path: <linux-kernel+bounces-764413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6648EB222C2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBDF91A22434
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 09:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5902E7F1D;
	Tue, 12 Aug 2025 09:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QTjSGt5r"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E552E1C53
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 09:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754990195; cv=none; b=mzNtM/SnDp+afb1ULKHm62Bh1vWqbT9gJkRnyL57TQryqy7W0O1IS1wpEiYxhiDUgcx/wGjw7bfFmw1p3N6mY8o2lvS4uAOxEtH1qvwqr2xVbnw3sFWKJ5K3Wg5HpoSDRk1r8RU82SIgKHtMv33KL6sEs83ethn3C/BTUljXJE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754990195; c=relaxed/simple;
	bh=y8z/VznqSYDTiS702Oe43jqdo48jHiNSRwg/JgsiCBQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L1sd+RDRsHaOGhALB0vauV+iIWQ8Xs/i7200A5p7IeYQhP0SJpuCJtaRIzJxT8KTUgIl9WXNl42lu1qkFUENmvSKN+H6uMBcKB2FtZV9i5Dj1xb8S4f87iuA84U6xndj3Mbm25+JIWnEihRYxIcndL90d1e5BXAYrKkoTGLs1ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=QTjSGt5r; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-60bfcada295so8631976a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 02:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1754990191; x=1755594991; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XpyRTrxPweNj7vM7NPNQrMhG4svc0bcCinaeeoiCyfo=;
        b=QTjSGt5rpDO04ehsWa9PpB8NuMA58asOQF06OoQw6oPsqYmPYYjhLuiwYkum/D/BUs
         ElUe9EpwUVpZtAKkG1PTN4GVyd+ds/TGredRbPDWZRm7kfHDXjL2CIegDJvcrLtSZ1Sf
         gek0jZ47//wmblAKfGET2LUYS1NBwb8T+WWmHqgNp3yMmPDiMEwK5YjM+WJRer/tONLB
         LLqmsusTmdq2cDSFRz4sLnOiIr73IWES6JBC93AW2noJNuLbihYpIY9mGRmnYbXmPDGm
         xNKBjE6jHPznJqV0oBeM55yejygU5GN23TkBl8+AYqdpYATu0WYIhWliNuHZBk4r+JrJ
         Zdkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754990191; x=1755594991;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XpyRTrxPweNj7vM7NPNQrMhG4svc0bcCinaeeoiCyfo=;
        b=xEFOzOZzoFjZXVX03DkTxUPGb02JCMRTXJVQjZiR9fEp2Nxh+vkZ96rWyj3b4aCV/l
         wk/syOkB/8QBmbXmVs+pOp0x+1GvWYnww5KbZehTAcatBzKrNVWlVUCY7FnpfRl9rjLw
         21p0rfIQ4WVx5m6Y7we6szCmDV5S6zBKNzFyl+YcSpwdXkDFiQEBRIb/VviEoVbyZkQi
         x+3oLxTFai8zmDx9i1G/1PMA6053Qm2pi6z1cbkl7bLqpLhSkJDq1aQUukoPugcQ+L1E
         o6/z13Yw5Qt+U861Ulhg7fWqgUBhA+vB16snLo6B8fy/jCn9q49txR5jNhPB5hpn9puy
         XiZg==
X-Forwarded-Encrypted: i=1; AJvYcCUIojbPYk7z0EX4lnqOpfkIF4mWdPrHb6h/rE/2+LlmhLxcFu3hQ8LQ62fvaFO2dFBglvTvVj3QN1tyOzY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQHvBNRn6k5qarU86EIfLywN/ejyQcdTxxPeJBsM2NE8iGQ7KA
	DBext6G5lT4qrHf/ic3LaAOXQ/lfpCgHiKK3aN17uNyMBJUHgckTjOgy8LPR3DFLyjU=
X-Gm-Gg: ASbGnctWxYkheTQZFAqZN4VqmGyAPbPX2Rc9iiKaOAWW8zIB2bs/Iix4Ea0RZZ8arNN
	xALZBJ88NU2tu6SvSmLkhHqsquaWTXoypMpSKS/Fx4t+JyWD7cmfm/+L2RpLTxzn0FNB4WuxJb5
	0hoo+F1X1ZauRccuyxZFcQ1wf4SFO0+I/sNsGy36qqaXNgOj7B7WgpcFYYHusJmsC2cbnw2p8Zh
	A3G6eZ/EFfUjgBlw8EG6Rd+uIrIbA059DyAHUNmmF3zDArTuGoXWPGkQl+wS64UzFDN22mLQbV8
	2RTkvt09900Hq1cg63n9RmLROnS0atkY/sz5ZwdeKz2uCSP93BKolFAd4532jb7Rn01pEElsmHj
	cdM74//XYQLBg453ryQ==
X-Google-Smtp-Source: AGHT+IFUdPtxDW0i1essizBgmFTXB8SnaSppFE9xYLgAQXzcYuMdaQchhqUon0sWY56fd1fLtjkqIA==
X-Received: by 2002:a05:6402:5186:b0:615:cb9c:d5a2 with SMTP id 4fb4d7f45d1cf-617e2e56225mr13393239a12.18.1754990191490;
        Tue, 12 Aug 2025 02:16:31 -0700 (PDT)
Received: from localhost ([2001:4090:a244:8691:4b7a:7bbd:bac:c56e])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-6183b154241sm2417273a12.27.2025.08.12.02.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 02:16:30 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Tue, 12 Aug 2025 11:15:20 +0200
Subject: [PATCH v2 1/7] arm64: dts: ti: k3-pinctrl: Add WKUP_EN flag
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-topic-am62-dt-partialio-v6-15-v2-1-25352364a0ac@baylibre.com>
References: <20250812-topic-am62-dt-partialio-v6-15-v2-0-25352364a0ac@baylibre.com>
In-Reply-To: <20250812-topic-am62-dt-partialio-v6-15-v2-0-25352364a0ac@baylibre.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Vishal Mahaveer <vishalm@ti.com>, 
 Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>, 
 Sebin Francis <sebin.francis@ti.com>, Kendall Willis <k-willis@ti.com>, 
 Akashdeep Kaur <a-kaur@ti.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1111; i=msp@baylibre.com;
 h=from:subject:message-id; bh=y8z/VznqSYDTiS702Oe43jqdo48jHiNSRwg/JgsiCBQ=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhozZbLaFaldzZCZe9VdfahElrGB23bfR+UDI+q1MGpdXR
 bPe3Xmoo5SFQYyLQVZMkaUzMTTtv/zOY8mLlm2GmcPKBDKEgYtTACYy7wTDX5HC5w+dz5w1KziX
 Pvnl++OGeZwVrvGeJxw/Wf23P64rv5CRYTYz58mMzAmns57uf+q1Utjt9VnJTb/yVpo7dCgsylG
 YzAoA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

WKUP_EN is a flag to enable pin wakeup. Any activity will wakeup the SoC
in that case.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 arch/arm64/boot/dts/ti/k3-pinctrl.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-pinctrl.h b/arch/arm64/boot/dts/ti/k3-pinctrl.h
index c0f09be8d3f94a70812b66c3f91626aac35f4026..d3b0ecdf1a4a4de25ee6121ec9e62d1c7df26eb9 100644
--- a/arch/arm64/boot/dts/ti/k3-pinctrl.h
+++ b/arch/arm64/boot/dts/ti/k3-pinctrl.h
@@ -19,6 +19,7 @@
 #define DS_OUT_VAL_SHIFT	(26)
 #define DS_PULLUD_EN_SHIFT	(27)
 #define DS_PULLTYPE_SEL_SHIFT	(28)
+#define WKUP_EN_SHIFT		(29)
 
 /* Schmitt trigger configuration */
 #define ST_DISABLE		(0 << ST_EN_SHIFT)
@@ -65,6 +66,7 @@
 #define PIN_DS_PULLUD_DISABLE		(1 << DS_PULLUD_EN_SHIFT)
 #define PIN_DS_PULL_DOWN		(0 << DS_PULLTYPE_SEL_SHIFT)
 #define PIN_DS_PULL_UP			(1 << DS_PULLTYPE_SEL_SHIFT)
+#define WKUP_EN				(1 << WKUP_EN_SHIFT)
 
 /* Default mux configuration for gpio-ranges to use with pinctrl */
 #define PIN_GPIO_RANGE_IOPAD	(PIN_INPUT | 7)

-- 
2.50.1


