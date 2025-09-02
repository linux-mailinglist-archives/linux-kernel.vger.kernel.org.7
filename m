Return-Path: <linux-kernel+bounces-795513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E0BB3F3B2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 06:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 698DE7A7672
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 04:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DAB2D5943;
	Tue,  2 Sep 2025 04:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="PpikUUgg"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481942DF137
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 04:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756787101; cv=none; b=fbwFGhfEZwumonmRVE4I5elL7wcBaPM1TFrb9bNs7ts8d7b5TBGoDf3x/OenQ2Ibu1SixAFX484uQ+SedA0pEEkx56ZauHly+1Up6hIF+uJRDDnaliSTSww17jEvOnxBA/gQfoLM6JYSRWxle4hrmSkwBfnywnCGJG/7ZCLyd+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756787101; c=relaxed/simple;
	bh=HFpqts/W53QUbSMz1faFreS+L9DMcn6zulFxd1eY3xM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JwHN7tVMkc/hXki5RiHFg+RUZpkU+lvwDjNz2J+tavrmFoP9HSFiU207sDByuOefr8geIIWW3/XNbFSKLQ2GG9UbPaJUMr4pgcydXZkPJ8Wn8l9JXBooWeQR4yLiZlgi85+jspnLjVAxi+dlMMb6BesiOlvB5i3lI4qD4wF5FC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=PpikUUgg; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-328015abe0bso3019123a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 21:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756787099; x=1757391899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+193yncmANzEfIfweyuJi14B+CiP/3dMuVzUWsZjMz4=;
        b=PpikUUggLtMtWaQZp2ZiyJ+2S9/2u1rHSw891/Xx1W6nXSf5ybZdrezKsRlDxAZqhc
         jNN+OTdouvX9GzjdXe9sZkqz+HtQtQydAsJo+CFWULHhY1moTz8baDLIJC4Q6J/Hqi5p
         im/NIsypx+Op+ATBRodsFiorFo80dTse7Z7cmOlsAc1p2mIHgRueL65ff4i2Q8d9FelA
         puMW4/r6DtD6ffs1Bpk0cL3SojH0chl86G9W+Ngr1WpWJBVC7KzuH5G7Jla3YIBmcegI
         7V86Pku4zWldfub/2JJThX0LWX+BpsF5QASj064EJBcrDNtNfR+U6U0R5m0FevnOTOdc
         koWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756787099; x=1757391899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+193yncmANzEfIfweyuJi14B+CiP/3dMuVzUWsZjMz4=;
        b=ZERSPfMFflxjijhUWjkzJvWRFGnBDar/10Jvqvidr21v2IuKDgbcgPvU6opPdrKQQm
         iW0kIsIteHI65/ed1E9pO+Op89FdlIhX5CwcpZUOUxAa8Ineul1DvurzcxqTYRYr/c6S
         X1ZN247XoKtBC8X7PltbJ6uRxylsRcH7Ju1kvlTfNh3zmXCgC+Y40GPEcRjG3rpNoWdx
         N/uaoW494Y50Bi9E+/OMHiYmgepAjdPTe71I938+BU8SrWjSOs+teLtYMdFSs3/kIXPl
         ZuLtYuynoUg9RmfQK3D7SuMP216+IbTizjcskNNAhrMtf6ImgYwNrxgSJGq2sWc+lr/1
         pKwA==
X-Forwarded-Encrypted: i=1; AJvYcCXW0wt0e0d3kXl63ynrXMLQ+3t5VzjHbfXj4MfehHtY3G1j7IgT3OfpXn+yN1WHx7EHlQqXkvIJJQ+eYoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmE4aozT/+4uzkN3pnCg3UQnpBz+1/2Hw/Z5sUlvWnUMsFg1wU
	hL9hm+LQGlbHYwqKHZeflf5PXlpW1T8yeEJKy9SVl4v7DL06ZBTcwwv6/b/CkZWOTys=
X-Gm-Gg: ASbGncu8kmbll7YrL0BqWJDIlo4Z7+1Pwi5lA/gjsukoQYMB9WaTwOH+eVcA7bOoiMi
	GbSsfRXaKMtFW9BOnjEQgrKaU/MVBIiGTMLUZL3uG0cvBYGtLz8hSejiqtRPw/jta6jXS/5UC5x
	bYpLhYNVRPvIDMA4ldesyyPubkESMceb4Y//cVnfrHc85N7bMht5xK/IEx7BKv53Z/j1Ft6mjhP
	xQhOc+xkfNeXf1t1H2V5TyE8yyRtJo7h/y3lqiMsDsO1bNHlJ/WGTI7MdwRyVNj5shMkUFCJSLC
	fLCWS0icDI6+X1ms04CoQn/xGOKFeyNYP6YaZgms9yA3KyjTytaYbLm6jbat6Q01tVBOqP8Wz6U
	j6AuMGcJz/Vo83CqM3x5k4Q0/TvsDz8E8SssINLfwGitzwVuaG0FkDHEriZQC7wDEVKqAOsgUZB
	ZieALcQRYkOqiDe8uQny/jSEIWbFKH7e4Pcbe7D71XKyg=
X-Google-Smtp-Source: AGHT+IFv/BZz+oSuV4r85o4JJ2VFlCeRdRpWZ7vxfc7IdiLIgnvMDvIfeMquYk/s/EZmpJpPE1uOBQ==
X-Received: by 2002:a17:90b:2692:b0:327:2589:7d4d with SMTP id 98e67ed59e1d1-3280d364babmr13673655a91.15.1756787099420;
        Mon, 01 Sep 2025 21:24:59 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-327e21d14a8sm12216706a91.2.2025.09.01.21.24.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 01 Sep 2025 21:24:59 -0700 (PDT)
From: Xu Lu <luxu.kernel@bytedance.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	ajones@ventanamicro.com,
	brs@rivosinc.com
Cc: devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	apw@canonical.com,
	joe@perches.com,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [PATCH v2 3/4] riscv: Instroduce Zalasr instructions
Date: Tue,  2 Sep 2025 12:24:31 +0800
Message-Id: <20250902042432.78960-4-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250902042432.78960-1-luxu.kernel@bytedance.com>
References: <20250902042432.78960-1-luxu.kernel@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce l{b|h|w|d}.{aq|aqrl} and s{b|h|w|d}.{rl|aqrl} instruction
encodings.

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 arch/riscv/include/asm/insn-def.h | 79 +++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/arch/riscv/include/asm/insn-def.h b/arch/riscv/include/asm/insn-def.h
index d5adbaec1d010..3fec7e66ce50f 100644
--- a/arch/riscv/include/asm/insn-def.h
+++ b/arch/riscv/include/asm/insn-def.h
@@ -179,6 +179,7 @@
 #define RV___RS1(v)		__RV_REG(v)
 #define RV___RS2(v)		__RV_REG(v)
 
+#define RV_OPCODE_AMO		RV_OPCODE(47)
 #define RV_OPCODE_MISC_MEM	RV_OPCODE(15)
 #define RV_OPCODE_OP_IMM	RV_OPCODE(19)
 #define RV_OPCODE_SYSTEM	RV_OPCODE(115)
@@ -208,6 +209,84 @@
 	__ASM_STR(.error "hlv.d requires 64-bit support")
 #endif
 
+#define LB_AQ(dest, addr)					\
+	INSN_R(OPCODE_AMO, FUNC3(0), FUNC7(26),			\
+	       RD(dest), RS1(addr), __RS2(0))
+
+#define LB_AQRL(dest, addr)					\
+	INSN_R(OPCODE_AMO, FUNC3(0), FUNC7(27),			\
+	       RD(dest), RS1(addr), __RS2(0))
+
+#define LH_AQ(dest, addr)					\
+	INSN_R(OPCODE_AMO, FUNC3(1), FUNC7(26),			\
+	       RD(dest), RS1(addr), __RS2(0))
+
+#define LH_AQRL(dest, addr)					\
+	INSN_R(OPCODE_AMO, FUNC3(1), FUNC7(27),			\
+	       RD(dest), RS1(addr), __RS2(0))
+
+#define LW_AQ(dest, addr)					\
+	INSN_R(OPCODE_AMO, FUNC3(2), FUNC7(26),			\
+	       RD(dest), RS1(addr), __RS2(0))
+
+#define LW_AQRL(dest, addr)					\
+	INSN_R(OPCODE_AMO, FUNC3(2), FUNC7(27),			\
+	       RD(dest), RS1(addr), __RS2(0))
+
+#define SB_RL(src, addr)					\
+	INSN_R(OPCODE_AMO, FUNC3(0), FUNC7(29),			\
+	       __RD(0), RS1(addr), RS2(src))
+
+#define SB_AQRL(src, addr)					\
+	INSN_R(OPCODE_AMO, FUNC3(0), FUNC7(31),			\
+	       __RD(0), RS1(addr), RS2(src))
+
+#define SH_RL(src, addr)					\
+	INSN_R(OPCODE_AMO, FUNC3(1), FUNC7(29),			\
+	       __RD(0), RS1(addr), RS2(src))
+
+#define SH_AQRL(src, addr)					\
+	INSN_R(OPCODE_AMO, FUNC3(1), FUNC7(31),			\
+	       __RD(0), RS1(addr), RS2(src))
+
+#define SW_RL(src, addr)					\
+	INSN_R(OPCODE_AMO, FUNC3(2), FUNC7(29),			\
+	       __RD(0), RS1(addr), RS2(src))
+
+#define SW_AQRL(src, addr)					\
+	INSN_R(OPCODE_AMO, FUNC3(2), FUNC7(31),			\
+	       __RD(0), RS1(addr), RS2(src))
+
+#ifdef CONFIG_64BIT
+#define LD_AQ(dest, addr)					\
+	INSN_R(OPCODE_AMO, FUNC3(3), FUNC7(26),			\
+	       RD(dest), RS1(addr), __RS2(0))
+
+#define LD_AQRL(dest, addr)					\
+	INSN_R(OPCODE_AMO, FUNC3(3), FUNC7(27),			\
+	       RD(dest), RS1(addr), __RS2(0))
+
+#define SD_RL(src, addr)					\
+	INSN_R(OPCODE_AMO, FUNC3(3), FUNC7(29),			\
+	       __RD(0), RS1(addr), RS2(src))
+
+#define SD_AQRL(src, addr)					\
+	INSN_R(OPCODE_AMO, FUNC3(3), FUNC7(31),			\
+	       __RD(0), RS1(addr), RS2(src))
+#else
+#define LD_AQ(dest, addr)					\
+	__ASM_STR(.error "ld.aq requires 64-bit support")
+
+#define LD_AQRL(dest, addr)					\
+	__ASM_STR(.error "ld.aqrl requires 64-bit support")
+
+#define SD_RL(dest, addr)					\
+	__ASM_STR(.error "sd.rl requires 64-bit support")
+
+#define SD_AQRL(dest, addr)					\
+	__ASM_STR(.error "sd.aqrl requires 64-bit support")
+#endif
+
 #define SINVAL_VMA(vaddr, asid)					\
 	INSN_R(OPCODE_SYSTEM, FUNC3(0), FUNC7(11),		\
 	       __RD(0), RS1(vaddr), RS2(asid))
-- 
2.20.1


