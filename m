Return-Path: <linux-kernel+bounces-794426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B78A4B3E196
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 13:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 87C3E4E27C5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 11:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741AF3148A8;
	Mon,  1 Sep 2025 11:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="f/uYsMij"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9B428E3F
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 11:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756726241; cv=none; b=Vqbpp/Z3wiwiMK4uL05+aR5GuqXYroZ8GKvMvqDcxyf9IvUCOLU6LA53pECG0Osv2mRzGzhDEDKBeMr2VwqXQ7LXv9cHQcyUmHR1VWKxk/fu/zar5umo5i/6p6wZxCXeFARCYSkU8JSj8gMpilJ2/fF19BjuwtJ0rCoOmZA18aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756726241; c=relaxed/simple;
	bh=AHBUSWC6NQwt5gipootBG6lu9YU2EyCEcBy5+RZx010=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jo/G1xteVIc6lf8RQXgs1CsQGOIr/Q4pZxwiOHc4WmQqKc4ExNIpH2Y6p/qsH1tJYjZUP4mR8W8DUUNJieAbaFFOr6ToKHRUOsx3kRLOzYzkHGcPkeNZ9hqmEDhq0Ft6lDkloqF3eLzZm/6FOg0N63OzOLln67XOyOoxIKfPBVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=f/uYsMij; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-77269d19280so57743b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 04:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756726240; x=1757331040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L4l4TBk/LGXRpjovIOSrhrLfanQNTxjIirl6+Uo+sE8=;
        b=f/uYsMij5EpVDv86AJlQ9v6LN1dgUIOAr/DPuoORrlSBlqGePbtYAdG8nS4bufEbl6
         Bq6Bba5AtmwNLGu3VXgqqPFyujrZBgNdiQZVSVVUt6XjYYdwFhWBr1AzMFHZT6+77Vyq
         OI8r7jBUflu/GioYab5l+o3PRDaRpCC5vNTwWjb99Hw22oT95zS6ab6kyhgt1srKmRE+
         PR8EPg8RTginceWV5SCqHWsH8ywiCC7b9w8IZ/vpkKRB9CbsvNegMj4xgTIUNMm7eLO5
         kL4i3u5FYQkpJnL3gacLQ39BHHnCCm8QAar/yylMFtFawJSP+u3ox28Ho0pNuji9tp7f
         w1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756726240; x=1757331040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L4l4TBk/LGXRpjovIOSrhrLfanQNTxjIirl6+Uo+sE8=;
        b=w2xrt6A/0DvfHLEa4BlVZubLx375wgyJWGQcPFJBIZ9ON3zKCr/EDeaLjOGQL74Dsm
         AtfjcqNi11e2nBqyrWj6fCfmIuA4pTcCNXZoftKue9gjKElfJTGnwZsrFufpwm3RCcL+
         RNp/HxwSh9JZqNCXRpwqLnw/mN1ascMryFyo4JNjdIBlBiaNVeniOUM6ozAGqNlbOfIX
         +Wnt+v9/WfwVPJR5cSGi+etPrJpbAm0NYERXqJZl4icf9DHAVMjzV3+5ByO8RYg173bP
         jczmIUifxXTlCk9htihWp8iCL27L+ws9gG7hhpdXAnLZs59YcyjSJ5shdlqe4EqqDiHA
         Nnag==
X-Forwarded-Encrypted: i=1; AJvYcCXQhhKHsk1Cg/R9mjqpkYkRcpsNE0UM2jjRZRTRdAx9M/MknNxS8Zs5lMY5HV5/ro5AFv3AFIDk2w5frSU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6tjNPZH+3553ij8+wLntdmtqrcYBxQSP8EjSESkx8aIYkclhP
	yqz1ILsUfL+rKOUws7xgbGEeJENRAqOejDDp7YTOP/zKaYzPjbp22ivgGHmscXZAaUQ=
X-Gm-Gg: ASbGncsKCQpAzSMR4/TNb9GdGY5OTbgIK9HVuYtnq8tg8GDniwlJTH8n2oUPLYprSmr
	yJWbNMdCZwj/WJTLgSSqkfFiMbFwj8J7bNf0NJyb1SQPGnl64mK4+5XuzFJHWvqNv3mtsyV9YmN
	lzwKL0x5FeRF29pQ40EtWjDdoWKQwgGt4YMaU0FJqD69XhMtsjCvPSLvfniCcgecSbUytI3njaS
	iqPx79ejfdsMRWd2IXD2ZHAxg+BiTGO4cxklnN/hVfE/GL+xZWsZ+vwOVJl0PA8gr6AFpiC++yq
	aPqLz8Tgqpw2OvCQFtY9f5ZPD2RjqI/xgaZqLliqvRcUDvTipCcCm9D/gUSSvWy++KO+Xt0r1g4
	DdPMeOfNJ91cr/uEtHlxwSa9/cUgUKAJNfBZLZQlduQPr0PHvet5FHUlfZfh/6KafEWGNHoLaoW
	w4ZNTUByJ05ck8swgC6eqMcgGu/jIAlgTcc4GMOfnK3Y/2uwbjsb9sLw==
X-Google-Smtp-Source: AGHT+IGxbGNHyf7cdKlPSirFuPWtekxBxUWcXRyssxTcMUJqB8qIwHPWBXuB4taHEDMzJ7h/+f/ZSA==
X-Received: by 2002:a05:6a20:9148:b0:243:a290:3293 with SMTP id adf61e73a8af0-243d6f37dabmr10788824637.42.1756726239715;
        Mon, 01 Sep 2025 04:30:39 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.55])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7725ad1e9afsm2911441b3a.11.2025.09.01.04.30.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 01 Sep 2025 04:30:39 -0700 (PDT)
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
Subject: [PATCH 1/4] riscv: add ISA extension parsing for Zalasr
Date: Mon,  1 Sep 2025 19:30:19 +0800
Message-Id: <20250901113022.3812-2-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250901113022.3812-1-luxu.kernel@bytedance.com>
References: <20250901113022.3812-1-luxu.kernel@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add parsing for Zalasr ISA extension.

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 arch/riscv/include/asm/hwcap.h | 1 +
 arch/riscv/kernel/cpufeature.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index affd63e11b0a3..ae3852c4f2ca2 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -106,6 +106,7 @@
 #define RISCV_ISA_EXT_ZAAMO		97
 #define RISCV_ISA_EXT_ZALRSC		98
 #define RISCV_ISA_EXT_ZICBOP		99
+#define RISCV_ISA_EXT_ZALASR		100
 
 #define RISCV_ISA_EXT_XLINUXENVCFG	127
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 743d53415572e..bf9d3d92bf372 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -472,6 +472,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(zaamo, RISCV_ISA_EXT_ZAAMO),
 	__RISCV_ISA_EXT_DATA(zabha, RISCV_ISA_EXT_ZABHA),
 	__RISCV_ISA_EXT_DATA(zacas, RISCV_ISA_EXT_ZACAS),
+	__RISCV_ISA_EXT_DATA(zalasr, RISCV_ISA_EXT_ZALASR),
 	__RISCV_ISA_EXT_DATA(zalrsc, RISCV_ISA_EXT_ZALRSC),
 	__RISCV_ISA_EXT_DATA(zawrs, RISCV_ISA_EXT_ZAWRS),
 	__RISCV_ISA_EXT_DATA(zfa, RISCV_ISA_EXT_ZFA),
-- 
2.20.1


