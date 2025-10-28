Return-Path: <linux-kernel+bounces-874300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 062EAC16002
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B8A9401394
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFEB634AAE7;
	Tue, 28 Oct 2025 16:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hA3f8ekH"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2CF34AAE6
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 16:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761670334; cv=none; b=QhDVJ7gPffBPZ8adS0EZ4pza5iM8hXg3OZ2foxYGVIremt2AiFC7uccCsBfNnHG2V/fI3wNx736sNvwsk/hn1xiLE7FGEUbBjexYZ4uWPOIJSqHRDmvR4r+lrR/skuMoxlJ4IsDslt6GhJs4h4bbiSB8NbDQ/tAhIcuD42Eije4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761670334; c=relaxed/simple;
	bh=gzhh/UeAH1T9kvsMnrnAYMspbqlc2xJ5quWu/5dmr9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hFJBy+hvEOfF0MKUPMu5n4kmJvFk1+uWx7TcNCVaddt9cHslcNihJbQhLB8H2PMhRRFxloPuzSYzu1P8RWgrVLJgZ7K6z/ymf2ESXXBMX9VcYviX9DLAMlNHhFK8PfxBXyxdZgBT+2+bXTG7IHxyuQAi9TWRBgc7mgFFr1KYe54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hA3f8ekH; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b553412a19bso4065294a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761670331; x=1762275131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ojXgjHdopbMba8HLrtZWP804VXrMf9315iM7O/XSMpM=;
        b=hA3f8ekHYdCKEGNxdx4zGuze9R/vqrgSmjopBVbM4lAb42Co4L22zOifVlU9K0TbXC
         NNDiy5p6pFDEdTuHlT5Zm/CgW54YA3/KMIj0SOJtZlDe99UxSaDojov2g+1nfp5ejHBV
         c6qLzeK6CmmTFmj+VJwyKitDVhOgiuBQDQ8l5b1izzcEunpZCtvondu/nTFNlumXDceb
         57cbuoTMxxV4wFTjted+QH1SBuLy63lkMitgqSijn1sxg/w/STOwlTtDKOBUqBxr+FLU
         cFam/qKyibFbW2aPaLd8UZf/BuvIPzY7GKwi3gOdzbuaQyPzpLPIi6xBxtFlimLnkLuy
         9o8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761670331; x=1762275131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ojXgjHdopbMba8HLrtZWP804VXrMf9315iM7O/XSMpM=;
        b=r05OBc+exIzEDJu5Ros/VgZrqtdT/vKJZ8q+qLERnjL8F8ilaK6VXXZbxPvnKHmCey
         EH+F2cCLT0GemCws4xQIQVEJSMkHzUvHQfs7Y8id9xLgFzTXFtv5/YLnUMYYE3m8w0Lm
         IZ2kIOMjdUNeIbzDz0VvxHq53NZC/hMypC0Jot3AJR7Nm0MGUZS+8MSgKGf1nSXc/j7Y
         muq1FszBIwugjGsW2j+YfS89fc0iydjqM+5x/A7LflLjqC4BodQSQrIZHKzareAux3Po
         0TKV2TWYoUgvWQtodpEUNWbjQ3cazs10NmmvqVMwsS7XZV/7cB+A66fPRKjlLAgb127p
         ofOA==
X-Forwarded-Encrypted: i=1; AJvYcCXoF8oP7jCO8EwPOy2JzoE6td4p8ywtnqOQIlQbKKlAR3JS9nr+Q7TmSDvYbMH/Gc04/hizZ26KlogPWZE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa3kw5yAYuJd2S/0ZcbFvOGypXP+0Dmwlw3Z6o6AoApnAUUd9X
	J7rt/kGw3aTDljz9S6iW4EFyBat3XxEgkyxxwnBh3J4yV/rHYxjZiTom
X-Gm-Gg: ASbGnctLeUYR8a69fQmWi2MeQP/TApGHpfrP/ewrhv2zqs0GLPt1uOnTbXGxbs/vf30
	LFz/sktdS5ylCZ8H09+7MlIYC9Ql+SAGhmlJkJoNqggV7/Rzox8vdJwRLRjmWy7buw8gkvMAHE6
	vhpA0GgNMmovkhLQoJ59mSTmv3gfK2WQbvrkI3Y9l22mTrgTjrj6uB9RBBjaGvIljVEGYoKhaHT
	0vEqNgBWwbrrZHOhJcvG874508B4Jp4+uvKrmfT2wN6om1Wu2iQNWcE0iDG+gcwAZd2aW8PHeGi
	FcwdqnhJl7Ka5PINzyrew9rJ+FF6lqNdsxoQMC0hFToneFwHqKiR1Ymykh9Vw4g9YDujqFdDO/T
	eF4E+Cnz/U+oy45I6mG001oH4WQi9sOGMOnO5tgw52Pflu04QLxbdlHw4Yu0Bhtf5+zbuzwZnb8
	TFBRawD3nFOwY57OT4PEDOTg==
X-Google-Smtp-Source: AGHT+IEvbcR/Suumy9Jm69zfLX73WbjC1gaV/SLo7s80s4EswBuoqKMd9xQyKmFR209kVMWXKteMEA==
X-Received: by 2002:a17:902:f682:b0:27e:eb98:9a13 with SMTP id d9443c01a7336-294cb3d7202mr46784325ad.22.1761670330905;
        Tue, 28 Oct 2025 09:52:10 -0700 (PDT)
Received: from iku.. ([2401:4900:1c06:77f0:168f:479e:bf92:ce93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498f0be0esm122123665ad.96.2025.10.28.09.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 09:52:10 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 4/5] dt-bindings: clock: renesas,r9a09g077/87: Add XSPI0/1 IDs
Date: Tue, 28 Oct 2025 16:51:26 +0000
Message-ID: <20251028165127.991351-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251028165127.991351-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251028165127.991351-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Add clock definitions for XSPI0/1 to both R9A09G077 and R9A09G087 SoCs.
These definitions are required for describing XSPI devices in DT

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v1-v2:
- Added Acked-by and Reviewed-by tags
---
 include/dt-bindings/clock/renesas,r9a09g077-cpg-mssr.h | 2 ++
 include/dt-bindings/clock/renesas,r9a09g087-cpg-mssr.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/include/dt-bindings/clock/renesas,r9a09g077-cpg-mssr.h b/include/dt-bindings/clock/renesas,r9a09g077-cpg-mssr.h
index 2a805e06487b..9eaedca6a616 100644
--- a/include/dt-bindings/clock/renesas,r9a09g077-cpg-mssr.h
+++ b/include/dt-bindings/clock/renesas,r9a09g077-cpg-mssr.h
@@ -31,5 +31,7 @@
 #define R9A09G077_ETCLKC		19
 #define R9A09G077_ETCLKD		20
 #define R9A09G077_ETCLKE		21
+#define R9A09G077_XSPI_CLK0		22
+#define R9A09G077_XSPI_CLK1		23
 
 #endif /* __DT_BINDINGS_CLOCK_RENESAS_R9A09G077_CPG_H__ */
diff --git a/include/dt-bindings/clock/renesas,r9a09g087-cpg-mssr.h b/include/dt-bindings/clock/renesas,r9a09g087-cpg-mssr.h
index 09da0ad33be6..606468ac49a4 100644
--- a/include/dt-bindings/clock/renesas,r9a09g087-cpg-mssr.h
+++ b/include/dt-bindings/clock/renesas,r9a09g087-cpg-mssr.h
@@ -31,5 +31,7 @@
 #define R9A09G087_ETCLKC		19
 #define R9A09G087_ETCLKD		20
 #define R9A09G087_ETCLKE		21
+#define R9A09G087_XSPI_CLK0		22
+#define R9A09G087_XSPI_CLK1		23
 
 #endif /* __DT_BINDINGS_CLOCK_RENESAS_R9A09G087_CPG_H__ */
-- 
2.43.0


