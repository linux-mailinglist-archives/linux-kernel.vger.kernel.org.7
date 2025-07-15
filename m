Return-Path: <linux-kernel+bounces-732025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1647CB06109
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 16:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D26A3AF48F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 14:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0301925BC;
	Tue, 15 Jul 2025 14:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="JJxczNTX"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A981922C0
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 14:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752588809; cv=none; b=bdrkjHJ3skoerOoblmvYNUN2uTraAo4IzwGs2iWG5VW2I8mgM59yWSrs5zzuu8RxZSssx8ZanqXq1AH7joxZ7h+K+BXTG2NMgZChkBvIdvGItEgGcujrpUePb3pOYEJneDWOSvUIHL6NPAY5c8an8bCi969wubZ9gewz9O7i+TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752588809; c=relaxed/simple;
	bh=eL0AhDlee/MEyBRhhKvb8McO2I7FRVBhy3aB9A/Fb9E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bzwUOtHcGMKe8Xoe2RvLtCRviv5YiPIcY1KunuK6JHVIMag6gyjG81fjbXspWb4iA1h0oY0IgsPUacjVK3ln4e4vaxCdVbH4XbpPppA5I10k3ezizvcUQS/egS1N8MLYMiFxn3CISv/x7NAWdRgiaft8bUBdj3cU6Wff9QdHvlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=JJxczNTX; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3b5e6bfb427so2872962f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 07:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1752588806; x=1753193606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EyhYMDLqwXgcBfbbxVXjHy0ZVk3xruqBs+IQYUNqyDE=;
        b=JJxczNTX2JTDVOMDjvji80FzEwoTp4jg7MOgb2oJAznp1BKjvKLm1/4QY8q0mhCTM6
         GEppo6DqOMDtvb3WUjBXeiE0Xwss2OQikHg4awvAV2D72q6v1TsK3hHrf5xLSCKyZb0H
         cwzDDF1o8CwzAeMGj5cgHx4tjKrIu39iBKqeg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752588806; x=1753193606;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EyhYMDLqwXgcBfbbxVXjHy0ZVk3xruqBs+IQYUNqyDE=;
        b=KYbpsh7cCcHHm1CFSmsGtE0TPrJu0YuiejFXdXiEMl/rsl9E3A+Ex52vNjxCn4bOJb
         jvuzL6H3cy0ldP1lnayIgXsJC24Ol7Hmlt/3DJpt3yDO735udDHwJLgGXtkHtJJbaMvD
         h8kXvtBMLbdzAckLD5sFWghRHNOG4rRRtiAXnBeB5kS/Ms/1vC0xRmxwJ2Izu6SiN4HE
         NETI02tPLHqUuUfcOrA6r92MpsvyfRK9hTv3d1nHRLlCdTTbThXSdLa5y7RC3qb6Nuqr
         EUS4/TNzit85jptonc5RSUdZVNeHwz6jfNn47bkKpBT2YNx7MDPwzCKGkkf2EyD52PYH
         mFEA==
X-Gm-Message-State: AOJu0YyMlYRjq3N9N8dozCZj79a0geylKY7NQkqCo8+QK341TEgf6g3k
	d6tSO727Pn4GRPhS+aMNDSuBFb1hIaf7kKtuWbIcaXW092cWakEwvfgrH68AASQFgUG7KP1EMOy
	O7icV
X-Gm-Gg: ASbGncvFEfZXYdcjJ2cqVLmY/g8RCtQ6wogDPUQ+MTeTb2G5LhYnLrlImyhrLAdp6BW
	XQa58bw7gym1HidWwrROjjxiykfGGX4OH2IsyP1isd5pbIie/Ff60fRhKpKsJGVYX2baAjhBQ3y
	ly6Ka2x8DPgikCR7aj1JFbvsSJLy8EkvTstlPIX9GctsLXiDc9/fx4TsqSvU5dmudgp5nZjHHhv
	UszH+/gmOgHr9ULFPi9xHqdks/mXEErKQAmhaOa0FLb0B+IyR+2KbLuHxlKKm/ZcAFVyAwhyG9n
	4n7yf2GcnokuiFKCerfxElgYncT5dYyUfJZdamg5KjM3/Y/bQUY0FysALzPMK90dl+OZ+u5E1Pr
	bxHpJil2VfmzoV+sux2qLdMnBkby3xOzFp2dJ+XuI2C+gHcPnzRkW8phjO++n3MDFnZgYxNYhLZ
	XRxKjrYh6bLsO6
X-Google-Smtp-Source: AGHT+IFxM20bqobvrOmTpeuI6kCK6N804fuZxfrBaPXGOvFhMW/WLgasuyeSoviyvYEo3idTS5/aaw==
X-Received: by 2002:a05:6000:24c6:b0:3a3:6991:dcbb with SMTP id ffacd0b85a97d-3b5f187a48cmr12925840f8f.12.1752588805687;
        Tue, 15 Jul 2025 07:13:25 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com ([2.196.40.133])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e26daasm15579557f8f.91.2025.07.15.07.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 07:13:25 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: Peng Fan <peng.fan@nxp.com>,
	linux-amarula@amarulasolutions.com,
	Wolfgang Birkner <wolfgang.birkner@bshg.com>,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] ARM: dts: imx6ulz-bsh-smm-m2: fix resume via console
Date: Tue, 15 Jul 2025 16:13:10 +0200
Message-ID: <20250715141322.1305512-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wolfgang Birkner <wolfgang.birkner@bshg.com>

Despite the current configuration being compliant with the technical
reference manual (TRM), testing on the system showed that resuming from
suspend via UART4 (used as the console) fails unless any other UART
is also enabled.

In our use case, UART2 is enabled to ensure reliable resume when UART4
is used as the console.

Signed-off-by: Wolfgang Birkner <wolfgang.birkner@bshg.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v2:
- Improve commit message
- Drop patches:
  - 1/3 ARM: dts: imx6ulz-bsh-smm-m2: Enable hardware rng
  - 3/3 ARM: dts: imx6ulz-bsh-smm-m2: Update wifi/bluetooth pinctrl

 arch/arm/boot/dts/nxp/imx/imx6ulz-bsh-smm-m2.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6ulz-bsh-smm-m2.dts b/arch/arm/boot/dts/nxp/imx/imx6ulz-bsh-smm-m2.dts
index 6159ed70d966..2d9f495660c9 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ulz-bsh-smm-m2.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6ulz-bsh-smm-m2.dts
@@ -33,6 +33,10 @@ &snvs_poweroff {
 	status = "okay";
 };
 
+&uart2 {
+	status = "okay";
+};
+
 &uart3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart3>;
-- 
2.43.0


