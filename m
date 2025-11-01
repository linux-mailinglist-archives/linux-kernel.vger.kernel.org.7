Return-Path: <linux-kernel+bounces-881116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89425C277EE
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 06:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADB703AFED4
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 05:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C171FC0ED;
	Sat,  1 Nov 2025 05:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8t8Vvgw"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED5123E33D
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 05:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761973251; cv=none; b=EFSQXaPz/uUNtUbxtief0s5gNABUNJnYJ3yYNA+p0uGnszukOEB9JGUckli54AJ/iPvTzCb+TG5H5Loq5c73ahsS6w77XxbuEn8/977rgJqyLDaqRB8MVoHnTVN8l9Xvt525S+Fw0pmpsNP0QU3pp7YfZA9hX8bLVINShVXM2vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761973251; c=relaxed/simple;
	bh=gNkcBk5b3Jhb+g3nkspOg/6VmVpI3bAfh7XCxvUGOGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O2cYOfXB+iVIM7Ji5w2YU2pq73ate2CXgyI9QlmX0UlahJTx0ewHDy2uo3wiqci5zHsVmLe6TAH2ffEL3vMKp0F/H2+G0p5DuQGu37+Zm456HkeXUFZgze/X2u5Hu9N1hLbq48TX/6THDZ/wTbZ5vdbLWLu46lr/DyO0RAOs1Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j8t8Vvgw; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-33292adb180so3214295a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 22:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761973249; x=1762578049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tLxEbqXFOSys1fkuyDgS6YVeyPEnVIaluiwVwN9wD4w=;
        b=j8t8Vvgw6IaSVm1vJjERIY544aasnMdvOLDj+tcO6IYArWXrWRY/ygSyuyUyMY6wma
         ciODLO2e+/spbqgo4EMKmnZMO9/f3J2Z4R9oh6qRgMOaN4FxLUThNf+2liBFSxjMMWm1
         w1nlJIsw4d41EKk/7BhDfOj0MZEdyvCVSKORqPnSmSIPWQKi9BV4OoJIjP81Y1RF/Ct+
         cYGkuh4e3wevxMUgXk1xNWj3Xm7B1voKPCjF0coUtbomOUhOR5BbOi22phGH1Wf0gHRl
         oTglC5GsDvo9xgvu9vWtPAEaW9ArMRoTwbHFLEaVpR3gJ0cmMGysQLFt2MLbMBppBtxl
         khGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761973249; x=1762578049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tLxEbqXFOSys1fkuyDgS6YVeyPEnVIaluiwVwN9wD4w=;
        b=jTtULFxN0vulTeKQuELrkgArGlkasi3SpD24e9JbFf0XrQoC/lzUGOiOZWOgqGhUYm
         MucBIJfiC2DhfJdhwJ09UxxbWlKyn+H7YRufXbTX0kSv8AokMOM5tx8PaVazZ45Ho8Ss
         SuBHHj7E5h5q7fzeL0bG8qHkj5q23dy88dWCE5G0A9ZCLHsFdN7jqtuogCGJKHFQH+WG
         yqWCU2tv+GpmDfWNR2BuJwAhKskf60y3pNeHkrEGb1X1ywQ1gTZkW2sDf6oPk4xDkAVn
         YquX35r1fR+9i+xmbnr8SO31/T52BP+6XTddCvd3pC4UvUOraPBKxKivsGAoIt6V9045
         r5QA==
X-Forwarded-Encrypted: i=1; AJvYcCUZm4vLj4lyH0NX72UpkQqeKaXDMQpE7gDa8aSbVEQmUfcbweWuOhZx6do/7ldW3OuCrpbXPWSnNrEhoFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW+PKeD7NFdWVWur1OSxhr4psR+OS+SELP+YqjnV+bW0AjyS5X
	Du1XL+K6OY3hIHb6/JFtreKYl6pu7AwEwP+9FWHDK3q1uW8MZsqwZ1T4
X-Gm-Gg: ASbGncv/EkH6DzMOMb9Stt+Twg30fTMpt08LPgy4KzYQmy/BoIfgOVQVZLRU77jbxDJ
	mn0+wM20OIKEvIyTX3n9PVNHREpI5rpw2aBkfmkuXPFPeiN8R4Xe0pYi6OL7fPnp4stxCahgSwB
	mNen9xquEwZymMslkY7DqjDsnVNGIeIpm0ZtL1JDaKxb15RBjoI89Vs9pdTl0byvNTPN5d+6L9D
	B6D+uDWMlEO6aK3R2emmc4t4FISiIJfnWCdg+k1rWg7+YcQ8FhgglubFhBTE5KsUNv+NyUhUe5l
	OlrnOJvPUPJD/y44wadsXewFb40EFEUCP6I8dze66UlNF+/+UUO4W8zkNJVf6EHkDFOSA7ao4QU
	GJ6aGoisSmheLW9/Vr+w6XPjcqyaziC0Pom4xqaj47ffsZvXZoyfQ9FyfrTEU1Acbxwq6LVJTdj
	Le6dMldYnxXfQhBXCIKbxUGZDIlRQJ9ew=
X-Google-Smtp-Source: AGHT+IFdN5hHVmgurX//nCd5fuS9Rr9NaSNkMhWsVrS8eB/7eP8n7yZw8P4C3wajjw9mV4bnV50BEw==
X-Received: by 2002:a17:90b:4d05:b0:33f:ee05:56e1 with SMTP id 98e67ed59e1d1-34082fc42d9mr7584949a91.2.1761973249547;
        Fri, 31 Oct 2025 22:00:49 -0700 (PDT)
Received: from iku.. ([2401:4900:1c06:600d:690:cbc4:d4d9:22c2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b93b8aa3ff1sm3761095a12.14.2025.10.31.22.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 22:00:48 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Cc: linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 1/4] dt-bindings: clock: renesas,r9a09g057-cpg: Add USB3.0 core clocks
Date: Sat,  1 Nov 2025 05:00:31 +0000
Message-ID: <20251101050034.738807-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251101050034.738807-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251101050034.738807-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Add definitions for USB3.0 core clocks in the R9A09G057 CPG DT bindings
header file.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 include/dt-bindings/clock/renesas,r9a09g057-cpg.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/dt-bindings/clock/renesas,r9a09g057-cpg.h b/include/dt-bindings/clock/renesas,r9a09g057-cpg.h
index 5346a898ab60..f91d7f72922a 100644
--- a/include/dt-bindings/clock/renesas,r9a09g057-cpg.h
+++ b/include/dt-bindings/clock/renesas,r9a09g057-cpg.h
@@ -22,5 +22,9 @@
 #define R9A09G057_GBETH_0_CLK_PTP_REF_I		11
 #define R9A09G057_GBETH_1_CLK_PTP_REF_I		12
 #define R9A09G057_SPI_CLK_SPI			13
+#define R9A09G057_USB3_0_REF_ALT_CLK_P		14
+#define R9A09G057_USB3_0_CLKCORE		15
+#define R9A09G057_USB3_1_REF_ALT_CLK_P		16
+#define R9A09G057_USB3_1_CLKCORE		17
 
 #endif /* __DT_BINDINGS_CLOCK_RENESAS_R9A09G057_CPG_H__ */
-- 
2.43.0


