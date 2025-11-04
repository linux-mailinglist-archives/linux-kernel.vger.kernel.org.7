Return-Path: <linux-kernel+bounces-884719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C71FEC30E38
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 13:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB078461E1D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 12:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECCA2F692E;
	Tue,  4 Nov 2025 12:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9VbWWH+"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784CE2F5468
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 12:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762257858; cv=none; b=A4KVjxfJF5NR5L11PAfXswSlQiCTRX39tUJLG0eK0qeeNUMEqCp5UK+fkENmMUh7yYIDC3El/1Q0yWpMzRsstY8OZzlM9izsJxgFvXA9gBSpp09Z3w4n+enbyKgQUs+GUnAsFjJjdnyab2vljUjnQIf/1iLz5/RaxPY5okoeR/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762257858; c=relaxed/simple;
	bh=v9PIaHoOGqn87lRlESH/AuFgCy5K1+8Bo9hGHBVSeHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K/wBwT2mV87pCLsNzlh78orQbkLrcTkMX39GKm07zuVIJ9MnMlgR/+iJEAiYvQXSXWqK/+61+QMF+ZRXm3VwXeknEXcOIyMjivnFwMnTKXB8XJUqKMoVnHXMuYeHRQbt1IJt6vFehWUi0NFMDcuIJ0fV+LuAH9YzJfmGQziPuOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l9VbWWH+; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b5b823b4f3dso876459666b.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 04:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762257854; x=1762862654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xHtOrvUe+VoHbx7eNPs1dlQDZqVpXM8AHRrOkF3QMQM=;
        b=l9VbWWH+WWl/zAn/ZQ2nCs+THHbJlBUkZ+oz8GiM0AkTgtNMk1Qi7bprLFhnpkN2fi
         9g5ByrfbwmACZi2dciDAIbHYdyrQCjqeperr6Pvzphfns2Q3E3kcWucR1pcaWrkS8SkA
         H3gSM1JOShq4rmKmOKnfq0EOe+yH81r5gSHt25O/wd/5EQnFKza3bTNLOXMdby1+5CJO
         Nwc8gH/FunX0a2fryHbqddbHaNLiEqom9JMKOwq/NCClJbRz8ln4DzsxhHf/Ff6P6olN
         4JQ1X8ZsSIXqRRQnS7/LwL7aE9MFtV6j6S1of+I/MiyQACX/nV52sFmHSFRT+7sNshCQ
         1hIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762257854; x=1762862654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xHtOrvUe+VoHbx7eNPs1dlQDZqVpXM8AHRrOkF3QMQM=;
        b=Wn6Fl4OPZ62gL09Np4gtkUgJ1FNHvYuEByY7rbkUI6bxU4CjeEz/2ssjtqCvolRPsp
         IecLE5m9WPRl+UYMKflBZRJCil7rduQMD/t2T0dvhlKMyGGuruIg7tbBKwUdMe8m4nS1
         r195eGWV7f0FXDLgEAb5Rpd4tn294ACn/ddQXQbGp1emawY4aTuwPQQNjlkhBaCC2pBU
         fjWYPJs+wnW/3pKmgGb/u+Iy28ocxmslPL5mQ+8rCz1lhSRVFzjCd6NSbNs034pS59J6
         DUJIo/a/orO60p0ws1ceuY+mylyixvGw5nFMtAK335TFHEfgQMS2iBDbB7Qddv4NpMoJ
         AMpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBO986HgeNuTNMA+Oi9GHNXXKxkLc9SLXXjiQhK3SFdw0WvZpXvtAZLBasi80AJMSKqPMcVN7LLJmTKPg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuK2D1aTR79a76UjMrIJ+XCJ6asxImlJYM5oWzh3xFrb9Ulnf1
	X9wiSP7jFO0cR71WV5p5ui4ZywhaYUwWPznAvc6SeQ+jKorgIR5hiGmI
X-Gm-Gg: ASbGncv5E3S4FtdXStd9fw4tLTHPeWOtUhltp9rdt6Ra6MCK9paC9efhKLeddzhW6WN
	jIF4jsmVOMvudtO6ji/MfqKao+BhhjSwf9GRHSEqXr5PsnGh1NPXJsOWzVCYOubR+RDiKTYoBl2
	jaaBM4V1rRsFSioQmi3Y3OzdiqEwwq1bwNSlLU2z+V1Bv+WUfVHT1Zpux+Yw7BwBhUHE/h5V9bt
	RXrsRda0t5OuPCpDI3RULxEu9cdUENS2tmfMH7WvNBLoh7YcfCnEieBatHoefOaeO9GxcN73z2U
	4K9HJUQNWXrO6IYuYALz/poynCZ/gDnVYP44QAMp0fHdV0sTuyt1to+xJ80i7pDZXhGBcZiKFwh
	W4ywGdbxmNfoLD4oRb9aORpGh4HLO9IxLZNGyPLDxVoigZEuj3vkJ3in6CyHHEA8z7NZjF/2KTu
	J8yFYINKdY3NO7+WVG/6O9xpk7KA==
X-Google-Smtp-Source: AGHT+IGGkO48Aav2aGVAeolzrPvhX0A2pS6by5Y49cTXFSpgxjQYcLbUpUeQ6msVNN8zrd86kzhCLg==
X-Received: by 2002:a17:906:a24f:b0:b6d:6c8f:6af6 with SMTP id a640c23a62f3a-b7070139726mr1396558966b.16.1762257853806;
        Tue, 04 Nov 2025 04:04:13 -0800 (PST)
Received: from SMW024614.wbi.nxp.com ([128.77.115.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723fa038e0sm200894166b.54.2025.11.04.04.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 04:04:12 -0800 (PST)
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
Subject: [PATCH v4 8/8] arm64: dts: imx8ulp: add sim lpav node
Date: Tue,  4 Nov 2025 04:03:01 -0800
Message-ID: <20251104120301.913-9-laurentiumihalcea111@gmail.com>
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

Add DT node for the SIM LPAV module.

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
index 13b01f3aa2a4..9b5d98766512 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
@@ -776,6 +776,23 @@ edma2: dma-controller@2d800000 {
 						"ch28", "ch29", "ch30", "ch31";
 			};
 
+			sim_lpav: clock-controller@2da50000 {
+				compatible = "fsl,imx8ulp-sim-lpav";
+				reg = <0x2da50000 0x10000>;
+				clocks = <&cgc2 IMX8ULP_CLK_LPAV_BUS_DIV>,
+					 <&cgc2 IMX8ULP_CLK_HIFI_DIVCORE>,
+					 <&cgc2 IMX8ULP_CLK_HIFI_DIVPLAT>;
+				clock-names = "bus", "core", "plat";
+				#clock-cells = <1>;
+				#reset-cells = <1>;
+
+				sim_lpav_mux: mux-controller {
+					compatible = "reg-mux";
+					#mux-control-cells = <1>;
+					mux-reg-masks = <0x8 0x00000200>;
+				};
+			};
+
 			cgc2: clock-controller@2da60000 {
 				compatible = "fsl,imx8ulp-cgc2";
 				reg = <0x2da60000 0x10000>;
-- 
2.43.0


