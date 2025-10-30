Return-Path: <linux-kernel+bounces-878869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D6AC21A95
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 19:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B40A54F470B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A777F374AC5;
	Thu, 30 Oct 2025 17:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUggTbiB"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4FB375757
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761847104; cv=none; b=qNrFK++J8fpe4X8DKJdNPV0UbxpT15jV9f18BomTmBu9Uof3coLQSXsrtFTJgQy0gDQm74GtRltBs3jPoy+H6JfTWGUnkm3qAeqarSevzNqZkr51zqVYM8fVWQHNv0b62Ec1tD89mYZADMigFvgEYF73WF7xuOHCagj30s+Dqu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761847104; c=relaxed/simple;
	bh=HUpnC1htM18fOjkA4XpHL5QRou+4yn4bYa0B4lXoOyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l2eGFPjhwL3GW9YpnTtXluDDR/urPwrwF0CbC5qzoxz9y7k3fU9+d6DF7w1k82CdYlFMUdo5ZNE72i2v3b5rWhSYLPDLelICpHKyWE21OTSEZkK70ARDFM5qEcTLQ5OZso+nIrHXaNAjwB5JJaCYb6B7/qM48SgRvuFtF2b3+sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EUggTbiB; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47710acf715so7587995e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761847099; x=1762451899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aEUFPuIhsavAXgb0AC7F4BVlpWod4yVZ6DEuITlOuu0=;
        b=EUggTbiBhseDw5AelPETgH/Zu5KInJAirZUTl+wFeQi4mXedPnPlZqgFWeX4IKhF/i
         cPcMaoU5Z5L+8zDJ9rXAhxgiWzASxOmyN2BQ1c/zhBQH8lLr8aucVnFuFP7mt6YANHaT
         0PyIwCH7t1R0/xt8Rfj3twrM6UQUUhCLCwxm1w+qKaQRaMnMPmMpv8NGRkyKekveOYts
         67/pSkxTCJGIXNcDZKMQ4xOeB/NPVNVhbtHheN5YcsX6EAp18lygQiyLbKPyqk+RKb3o
         IsYfMKb/Yfy/g+HAKD7b9H2w5vdfIPmkin0Rw1S2WZ4bZgrkjEdMZe0G7c33h9Tx0H76
         SiiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761847099; x=1762451899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aEUFPuIhsavAXgb0AC7F4BVlpWod4yVZ6DEuITlOuu0=;
        b=hKncUW4nsyUS5vGxJxhQv5jNtOEYNfiZB0gH8vpMSDyipBkq7qdP/J2SO8/wKYWA6x
         CgL4VHrOwgex75lVfG4LAVxuzvWPI970Pwy9kwHD8Zw+KIb2hAe2KTRyoEGikFsaapj8
         mrj9TxiS6Us+8ppvvHEaqrCrKF3qz0YH3sj5El9cjPt9gsJ2aTGtfpW1v5Nf+7Z7lmph
         l6va7XI67r3II1TsGwiawJsVlSemuhg2iAi1Jo6VLj4BreAGS2T0m5RyGmHtivt86loN
         DYnwzlTJ5LjWRA+Jfp3ITyH1BjeCqr7ZYvJgH5nLEQobLSLXhx077zcL8MH1IxHpodW0
         hUQA==
X-Forwarded-Encrypted: i=1; AJvYcCW3KqIqLTC6ib3UPUeH9rnoOMhl0pP1M+0YLOGU2fM+wjrLwfdGc6rLRsTWtp0TuQALkh0ZXTbCmwBN9DU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh/JK2I3T7zK8skFVSyEIGcAykWaJfvEHg1e+XEVzY/LJWMnXC
	ZtLhnwfCwgCbzPJOe1TVwjjeeCtcnjg9eZPS8+BmQEa2YBSJTkRvh5AK
X-Gm-Gg: ASbGnctnY6TJvpB9GmW2McenVsTr1uKw6byBC3dRnijqELjgoLE8GcZt9PrVkZM/FQB
	GOIhvMB8CtiKdLRme5hrvLU57maISIwsw8O0231kbtY5TdodgasVaoLm7OV6ZgSfWCowS4AxqP3
	D+uOLHMukPn0LW/j2GikPGOmRvQ1gsImWyVKZhsw4sshCqg3TmkOgf8IYPMcox9v/+FGtj/Mynn
	l9KubNaaLA1xixnZYkQV9ElLoQP8GdxeAP/SxpS35rBmNXwkCAXktiAnYGpbYWTeQJmR8W0yYTN
	5P7roTc6AsOaMfwn+CXtZ7GDXThRxtDvop4RnDVbEISkkKH0ITsDS3rUkj53mimhGIG4hjpbcpz
	G/uDX8c8TZmx3fAJxY5j+EnyTrJIVv/O0HwfsNhl3l4I7ZS/s3NjdsBO5VbJiAw/1kB4omr7gMd
	hJhGCPcnmp7JnLvVLJt69rwvhY6YuteOQ4dTTYsz9BhbUnVLj3vhcSbKEWMUzyTzlyb7YRgUk=
X-Google-Smtp-Source: AGHT+IHCnSAFWePFf3QW3AZNoiI/h3gcT0ofd78nlVqllQKhXKQhlnqG5HXZO9bGFC2m/6UHt0HCZA==
X-Received: by 2002:a05:600c:4ed0:b0:471:1415:b545 with SMTP id 5b1f17b1804b1-477307b8f57mr6623855e9.7.1761847098870;
        Thu, 30 Oct 2025 10:58:18 -0700 (PDT)
Received: from biju.lan (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772f53aad6sm15098055e9.13.2025.10.30.10.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 10:58:18 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2 09/13] serial: sh-sci: Add support for RZ/G3E RSCI clks
Date: Thu, 30 Oct 2025 17:57:57 +0000
Message-ID: <20251030175811.607137-10-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251030175811.607137-1-biju.das.jz@bp.renesas.com>
References: <20251030175811.607137-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

RZ/G3E RSCI has 6 clocks (5 module clocks + 1 external clock). Add
support for the module clocks.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * Updated commit description.
---
 drivers/tty/serial/sh-sci-common.h |  3 +++
 drivers/tty/serial/sh-sci.c        | 12 ++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/tty/serial/sh-sci-common.h b/drivers/tty/serial/sh-sci-common.h
index ef1d94ae8b5c..f730ff9add60 100644
--- a/drivers/tty/serial/sh-sci-common.h
+++ b/drivers/tty/serial/sh-sci-common.h
@@ -17,6 +17,9 @@ enum SCI_CLKS {
 	SCI_SCK,		/* Optional External Clock */
 	SCI_BRG_INT,		/* Optional BRG Internal Clock Source */
 	SCI_SCIF_CLK,		/* Optional BRG External Clock Source */
+	SCI_FCK_DIV64,		/* Optional Functional Clock frequency-divided by 64 */
+	SCI_FCK_DIV16,		/* Optional Functional Clock frequency-divided by 16 */
+	SCI_FCK_DIV4,		/* Optional Functional Clock frequency-divided by 4 */
 	SCI_NUM_CLKS
 };
 
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 7cc2b622e270..67eba7feea9f 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2994,6 +2994,9 @@ static int sci_init_clocks(struct sci_port *sci_port, struct device *dev)
 		[SCI_SCK] = "sck",
 		[SCI_BRG_INT] = "brg_int",
 		[SCI_SCIF_CLK] = "scif_clk",
+		[SCI_FCK_DIV64] = "tclk_div64",
+		[SCI_FCK_DIV16] = "tclk_div16",
+		[SCI_FCK_DIV4] = "tclk_div4",
 	};
 	struct clk *clk;
 	unsigned int i;
@@ -3003,6 +3006,9 @@ static int sci_init_clocks(struct sci_port *sci_port, struct device *dev)
 	} else if (sci_port->type == SCI_PORT_RSCI) {
 		clk_names[SCI_FCK] = "operation";
 		clk_names[SCI_BRG_INT] = "bus";
+	} else if (sci_port->type == RSCI_PORT_SCI || sci_port->type == RSCI_PORT_SCIF) {
+		clk_names[SCI_FCK] = "tclk";
+		clk_names[SCI_BRG_INT] = "bus";
 	}
 
 	for (i = 0; i < SCI_NUM_CLKS; i++) {
@@ -3016,6 +3022,12 @@ static int sci_init_clocks(struct sci_port *sci_port, struct device *dev)
 		    (i == SCI_FCK || i == SCI_BRG_INT))
 			return dev_err_probe(dev, -ENODEV, "failed to get %s\n", name);
 
+		if (!clk && (sci_port->type == RSCI_PORT_SCI ||
+			     sci_port->type == RSCI_PORT_SCIF) &&
+		    (i == SCI_FCK || i == SCI_BRG_INT || i == SCI_FCK_DIV64 ||
+		     i == SCI_FCK_DIV16 || i == SCI_FCK_DIV4))
+			return dev_err_probe(dev, -ENODEV, "failed to get %s\n", name);
+
 		if (!clk && i == SCI_FCK) {
 			/*
 			 * Not all SH platforms declare a clock lookup entry
-- 
2.43.0


