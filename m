Return-Path: <linux-kernel+bounces-852949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1315CBDA46B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 17:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1901E1882BB3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362363002CA;
	Tue, 14 Oct 2025 15:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m35svozl"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFCC3002C6
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 15:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760454827; cv=none; b=RdqNrval6Z0jukI7Ne2/M4ja+5MMY0WTfNTQYUEjtzjQImPSJPvyQmOESGCzesnaE++N1vw1WwMXsLD0QAVSgQaR+SF3WQ7BnxAIgRobvo8poOFrIDzGO8Q8N1Ni72Lk5swmbLsiNfpMzf7cyW333D2XGREOZjCXCBy+P0PiDYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760454827; c=relaxed/simple;
	bh=4l1PEhZk1G2/8p3MtkkZqUn68Cuzz+W5KwWiBPIO5NQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=edkXt3GxoRK4yoVUD0N4ygx56tFqw6CeVn0FTJrEW2BQd/sLbPkUmH0pHyIWm4lJ44pCDanhbPSdhGyg6H6LBqRA1vRe1l3teg02sXFow5k5VJVdfMqcCxbkMNSz/DMUTfbALA75zK3sJpHZV3QRI0yBKnjwMg3X3l5tAiYTb+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m35svozl; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2897522a1dfso50926515ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760454825; x=1761059625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XFqfxSZngP7oXH9+DvZVe6YfUWRdnzIGpWugECUd8pY=;
        b=m35svozlJJ7aCbhvK2VHL+JO3qmDQNruk/nU4fgqaffEY+qC3C8ZHSjjMspMf6Kndp
         ZK9x0D7F7J4bcCA9Q7sGRfOUkNCCMvrLPfyJZvxbLdO5G6z7sb/cVe/2LaKkKkyqno3c
         ZL/hz0qVTy50qCnagLaTGDwfN9BJtC74qei7R0L658eQy2Y9LxNcSpWbQ3s2IME7/Ykn
         mI4nqeePCG0jH9Yg/EQWe3y2vjm0mu62dOqpt3bIk0sMnTFm1HnPAM0w3U2SUvTpW87h
         bI64wBZfnLuQjQiIfHXO9rvhhldKbuukOGG2AovqmSHvXvkigW30DToHM3paH2zxiNb2
         /KyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760454825; x=1761059625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XFqfxSZngP7oXH9+DvZVe6YfUWRdnzIGpWugECUd8pY=;
        b=TiSZJvbaA5Xoxs27rCTYYDL2H3hsn+2j8a/6nsgUKugNax4qbbZyN6MhMDvqhBKpJr
         WIDjwn5xbqI3UOxbn5tvbm6NWUD4LJCkMx+X/meDQlQR+InCYizeBVverUHLZjXAbvuS
         CdjtaN4R3G8LbZ4WiDtnxVYSr92HVk1SP+MMYeamCGZPZ/VlTjxnagcZT+dteChDhYYw
         urTJEBg7fvontXIv45nvCKGWySgSpp68hfyanmyVlCHmPdmmU++nulx6JCQYjSIQhGbq
         f6asgtDelCnXKcMVESr7st4YFuIgqdgdap0NH+b0rMmy/e3mhx42teEC9CzLvE2Kpdoj
         wzVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxCYvuzo0UXtmbwHPMvXLFR3DUQTprZreA8h+kF5o8ejeoE10QRDnJpYrSm09F+WmnVf30bzI2QFgEORQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwWU9pORro6pzqnjk7EQTq3WOcoYOuAXzV4L8AD/FxxKddl6NZ
	P4aItNC/dWQxKrSI4t8onY+KmgT2EHiTWE6rznlG7MadG/C4JxshvcnD
X-Gm-Gg: ASbGncsHWbt/Yw7bYZqzIbRPgiu6mR1cUZW/tv9xvsRn78AD8907qeMzmwA5hxqvMqP
	SQNNvDU09M2oZJGdB3syzMvZVW/VXJVL4n9VjeBPn5sF2tOed3AAnbZobD6oKIPLs4suT1p2JHu
	t8PULXlxzkgHjbCvpkQOS3whAaA8V3g9e/2HH3nmuXCMVZumL9FmxgGmVFSZOq5fQqcEjdHkAlD
	tVXJ15ZrcFjGPy+YixuNBA47HwQRaAJCsSWc7/pND4w4S7Cg1gwdsmONvAOLxnApaP41C9+RAC1
	/QMKjxEWOFoHoJaJbDtHZIieuAGFgGI9mhUmCSd4RFSk5ultaoAKo0qvUIoYAYKJadskvjXHtp8
	XxxQPGDz0SyazPbdOEzAhVu4V0g6P99uvRkDxFzCklgugENmBAj3vYpQt0yURzc6j1u3UraK8OI
	QcZ/gunaVu
X-Google-Smtp-Source: AGHT+IFYYizKEfdSx/Exyb9Umb5pCxnPbfheHglhxt1KBGSv/n6E0xPdNIQNKiH244PGB9Y2zVCvAg==
X-Received: by 2002:a17:902:e788:b0:286:456f:8c8a with SMTP id d9443c01a7336-290272dfad8mr294196425ad.50.1760454825310;
        Tue, 14 Oct 2025 08:13:45 -0700 (PDT)
Received: from iku.. ([2401:4900:1c07:6d70:c338:e681:47e3:e797])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f8f9bbsm167171125ad.121.2025.10.14.08.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 08:13:44 -0700 (PDT)
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
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 1/2] dt-bindings: clock: renesas,r9a09g077/87: Add XSPI0/1 IDs
Date: Tue, 14 Oct 2025 16:13:24 +0100
Message-ID: <20251014151325.160062-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251014151325.160062-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251014151325.160062-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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


