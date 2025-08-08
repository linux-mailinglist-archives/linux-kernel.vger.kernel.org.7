Return-Path: <linux-kernel+bounces-760508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E948B1EC42
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 17:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D235718857C7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 15:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08CA3284693;
	Fri,  8 Aug 2025 15:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="U2zsCLT4"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9263628467C
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 15:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754667568; cv=none; b=Wk+flIEm/k7JF7fPtcLF5qabcP3NTH6NhuPmD7D7EpoXBhx+wX7zttJQWnzsTBsuQ2iU1lDJ5eOe4mVizI4vONS6ST7sjy0gAmNfP1kBaZXU/3FxNTqU7KcsAgPq1SdArrBtj6PmT6TB316gCjUrQd/cKyfqxf8CQfMteXa1Usg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754667568; c=relaxed/simple;
	bh=uol5TGL7aLYqIn5MMJKdM+aNQrg7vaqw7kUoGEb0IDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XGqLfKytHZeuPjJD3UPrsEh2CME+GoBuj24aQYgIFlJ+mpHaBp1Yu9wsPqgbHjLKC3DWX75FHiflxv3xBPdd55lRK01X/3Yuwz7Huk06ZoIZjH9ZvvD0RZd5aErqIKmImbIVDB6hHuHTwF4TMWUPcD8u+/EEazgRc+6prHcOw7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=U2zsCLT4; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-32128c5fc44so1997516a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 08:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1754667566; x=1755272366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lRwyOgWeUUf4xzQUl6yQwVpNHXqT8Es+y3tNlmZTS9I=;
        b=U2zsCLT4JBhNB2yXKydMzgAIXSje+ekdmLS24cWdkVgndafV0qigi0g8uQcnubByyy
         0MnVItt0fVGZFa4bjM/hpCIAAwMuVUDz8JGNaAY7ZJs8ai/aO0oeTfTqwPGxU+INBVUv
         DAZSQzV+rZFH3vBWXuldGP9Zpq+JD7qkaxhtaDSIQLKS/Zzj/9R47toyn88YCnGghBxo
         LAx5Fsy06Tv//X1Rh/Li9K6yWreld4F2bwPmpxdL/HZ1k1iOgW20DnMkS2CKU0ncJSUd
         o6qIm3eroHFxDZFi9sybF1MmjFRlcGajkrVYNBsXrIxusOR9I1DjePCnbIRuxfRrdhCl
         GRbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754667566; x=1755272366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lRwyOgWeUUf4xzQUl6yQwVpNHXqT8Es+y3tNlmZTS9I=;
        b=cflDaa6yxUd2EUh1u3absQbU0HdojMV2uhhVgX0SNsvXOCDVhlbCtsgnyQSXyu64QX
         21jVRQXFf6Qz6+Gnfnhlh9r1NysVedYfg1WOuoEqLlizMdnzczlqVH19/bNM7xnR9Vrk
         6gqz8pWvlafBGlXeWKXXUK76PQ7UETZsLXWr33EtyN7kQmeazUzodNMhM5adjKDzQT9R
         x1ejlwxx6ASbz+/zzX+8GF14Lfej6SoEBnabsRraQxeioEmZWN+Z/qpk3qE7w6Ws0X7q
         uPtwGb3TdDpjmuDy15XWk6ueWd7pfxcQbHq9xl+IVf9NOKRUeoQmu/SSqluIAYWSEdQ+
         usdw==
X-Forwarded-Encrypted: i=1; AJvYcCXnCJIu/dyuyYrhvf32/8EIQrdUrlq0mZGBS/Cy8hLghRUL1FIh2Arhs4FF8ho/z9SwlZtRXyffs2r47PM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLJXo7gKz+H8jwBo9cHeIim9OfWbYYK1elYFb27AkTSlzKGGQe
	9bWlXjYOmpHiWmjVadGKOvJo+oxKJ5alWM8pWmTTXHNbM0VNxp2A78XiP4C9D4g5wSo=
X-Gm-Gg: ASbGnct5wI0oxJNJvnPY61u7A75OVWfejaG2NuKqlasCulU2Mrp7STfJCGhwVNUnnLI
	+JJzfINlUom4mU5OdE+P3eDKjZMZK9dwhYj5ivVsfzXik356rFbSZ5PWDWzcCn7HBmAlwNF9m3d
	02VbUImYuimQJt4qvBqONOUCiAd3+JdbZ8F+wtAgiAXQtmhkxmBVCUD6GoqWBrWEr0tJIP+KhwU
	FCvk8/PnjenBIC0noO7KgMGOnhOeENulyoGT39WBkicD1HSgC3gP/jUt06KFutZIcPYWLtWmTsA
	jfgumLFKSS5lkOep5L7Ltc71CWbZDBhN68KFUstDF5+JkiV9WlEoJISI0nY5KwIJNBTicIELaga
	NI6g=
X-Google-Smtp-Source: AGHT+IEMeucseF/gpbdWW57tdD6DURYLC5rMNYgTyXb7nxmDdDLc/tCzgk2uslWhC5YtHa2cc8w4rg==
X-Received: by 2002:a17:90a:dfc7:b0:313:aefa:b08 with SMTP id 98e67ed59e1d1-3218465337dmr4414853a91.16.1754667565153;
        Fri, 08 Aug 2025 08:39:25 -0700 (PDT)
Received: from cleger.eu.int ([2001:41d0:420:f300::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3218c3c2d58sm1135971a91.16.2025.08.08.08.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 08:39:24 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Himanshu Chauhan <hchauhan@ventanamicro.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Xu Lu <luxu.kernel@bytedance.com>,
	Atish Patra <atishp@atishpatra.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Yunhui Cui <cuiyunhui@bytedance.com>
Subject: [PATCH v6 1/5] riscv: add SBI SSE extension definitions
Date: Fri,  8 Aug 2025 15:38:52 +0000
Message-ID: <20250808153901.2477005-2-cleger@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250808153901.2477005-1-cleger@rivosinc.com>
References: <20250808153901.2477005-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add needed definitions for SBI Supervisor Software Events extension [1].
This extension enables the SBI to inject events into supervisor software
much like ARM SDEI.

[1] https://lists.riscv.org/g/tech-prs/message/515

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/include/asm/sbi.h | 61 ++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 341e74238aa0..e4993fb664d2 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -36,6 +36,7 @@ enum sbi_ext_id {
 	SBI_EXT_STA = 0x535441,
 	SBI_EXT_NACL = 0x4E41434C,
 	SBI_EXT_FWFT = 0x46574654,
+	SBI_EXT_SSE = 0x535345,
 
 	/* Experimentals extensions must lie within this range */
 	SBI_EXT_EXPERIMENTAL_START = 0x08000000,
@@ -430,6 +431,66 @@ enum sbi_fwft_feature_t {
 
 #define SBI_FWFT_SET_FLAG_LOCK			BIT(0)
 
+enum sbi_ext_sse_fid {
+	SBI_SSE_EVENT_ATTR_READ = 0,
+	SBI_SSE_EVENT_ATTR_WRITE,
+	SBI_SSE_EVENT_REGISTER,
+	SBI_SSE_EVENT_UNREGISTER,
+	SBI_SSE_EVENT_ENABLE,
+	SBI_SSE_EVENT_DISABLE,
+	SBI_SSE_EVENT_COMPLETE,
+	SBI_SSE_EVENT_SIGNAL,
+	SBI_SSE_EVENT_HART_UNMASK,
+	SBI_SSE_EVENT_HART_MASK,
+};
+
+enum sbi_sse_state {
+	SBI_SSE_STATE_UNUSED     = 0,
+	SBI_SSE_STATE_REGISTERED = 1,
+	SBI_SSE_STATE_ENABLED    = 2,
+	SBI_SSE_STATE_RUNNING    = 3,
+};
+
+/* SBI SSE Event Attributes. */
+enum sbi_sse_attr_id {
+	SBI_SSE_ATTR_STATUS		= 0x00000000,
+	SBI_SSE_ATTR_PRIO		= 0x00000001,
+	SBI_SSE_ATTR_CONFIG		= 0x00000002,
+	SBI_SSE_ATTR_PREFERRED_HART	= 0x00000003,
+	SBI_SSE_ATTR_ENTRY_PC		= 0x00000004,
+	SBI_SSE_ATTR_ENTRY_ARG		= 0x00000005,
+	SBI_SSE_ATTR_INTERRUPTED_SEPC	= 0x00000006,
+	SBI_SSE_ATTR_INTERRUPTED_FLAGS	= 0x00000007,
+	SBI_SSE_ATTR_INTERRUPTED_A6	= 0x00000008,
+	SBI_SSE_ATTR_INTERRUPTED_A7	= 0x00000009,
+
+	SBI_SSE_ATTR_MAX		= 0x0000000A
+};
+
+#define SBI_SSE_ATTR_STATUS_STATE_OFFSET	0
+#define SBI_SSE_ATTR_STATUS_STATE_MASK		0x3
+#define SBI_SSE_ATTR_STATUS_PENDING_OFFSET	2
+#define SBI_SSE_ATTR_STATUS_INJECT_OFFSET	3
+
+#define SBI_SSE_ATTR_CONFIG_ONESHOT	BIT(0)
+
+#define SBI_SSE_ATTR_INTERRUPTED_FLAGS_SSTATUS_SPP	BIT(0)
+#define SBI_SSE_ATTR_INTERRUPTED_FLAGS_SSTATUS_SPIE	BIT(1)
+#define SBI_SSE_ATTR_INTERRUPTED_FLAGS_HSTATUS_SPV	BIT(2)
+#define SBI_SSE_ATTR_INTERRUPTED_FLAGS_HSTATUS_SPVP	BIT(3)
+
+#define SBI_SSE_EVENT_LOCAL_HIGH_PRIO_RAS	0x00000000
+#define SBI_SSE_EVENT_LOCAL_DOUBLE_TRAP		0x00000001
+#define SBI_SSE_EVENT_GLOBAL_HIGH_PRIO_RAS	0x00008000
+#define SBI_SSE_EVENT_LOCAL_PMU_OVERFLOW	0x00010000
+#define SBI_SSE_EVENT_LOCAL_LOW_PRIO_RAS	0x00100000
+#define SBI_SSE_EVENT_GLOBAL_LOW_PRIO_RAS	0x00108000
+#define SBI_SSE_EVENT_LOCAL_SOFTWARE_INJECTED	0xffff0000
+#define SBI_SSE_EVENT_GLOBAL_SOFTWARE_INJECTED	0xffff8000
+
+#define SBI_SSE_EVENT_PLATFORM		BIT(14)
+#define SBI_SSE_EVENT_GLOBAL		BIT(15)
+
 /* SBI spec version fields */
 #define SBI_SPEC_VERSION_DEFAULT	0x1
 #define SBI_SPEC_VERSION_MAJOR_SHIFT	24
-- 
2.43.0


