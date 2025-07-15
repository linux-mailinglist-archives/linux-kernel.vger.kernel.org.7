Return-Path: <linux-kernel+bounces-732232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33AEAB063DA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 18:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2783D1AA7344
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 16:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE831FE455;
	Tue, 15 Jul 2025 16:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="fZ2uhIfA"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5247F2E3715
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 16:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752595402; cv=none; b=iheEhy0ZdvKNq3RkEyMc5t3s9vLWwCQaAcnXgOJUkz571l2QjlluVvxZJE0LuDgcwcKgaFick+lBuY5JnUQJUZOZLfX5x9OBJtYakSfuxCn+PcLfSZCRL7GrwSA5RPmRNrXxKs8/uze0UwG0ywDfxEdApIV7dOeNMpr5ufed09Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752595402; c=relaxed/simple;
	bh=uol5TGL7aLYqIn5MMJKdM+aNQrg7vaqw7kUoGEb0IDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k/uCIpzk6F0yC0HK5pMRjTIMOnSSgcCC/oPB5JKWWoqeD1BLKMvaM2/DYuBIfH+TNwmFltEh4KFktI/2g5palS/MuwTWLvabhzGxwLEGxVL9gCX3cAgCOv4khgd1YP2kaq9EwtSKipJCSvVXUeXNjFbsgXxqVIhbeRfYWNVMQbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=fZ2uhIfA; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7426c44e014so5511068b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 09:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1752595399; x=1753200199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lRwyOgWeUUf4xzQUl6yQwVpNHXqT8Es+y3tNlmZTS9I=;
        b=fZ2uhIfAU0RnaXb3o+5wB9RrBtn7pnUC7ScqbRSgkwq4P/EdlAzPveClV9KFZWcou9
         QiVPNhb438xQXnMQOJ60gPZIrknym6U6bLdBgTX19glYTQa+aF+Wd8HJgPZXYZxrmIfR
         fgocR9rqFadzYnA77hp2zwaLWYGBTOEc2EmN3lI8/kFj42b3dG5WhEZ9e0oAm1huxA5I
         pfBxzbUuwMTtzPpW0kRcRbS11bg24iMUisIi8VF6ZQrRk12q1ghTHoXL/qKdeIylplok
         WyslZEvlIlk30u7W2B8QXUB4X4AUpg+G3KtHQQc+Wxbs9Qp//ouvOWWiiNuxdNaeihj+
         Lz9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752595399; x=1753200199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lRwyOgWeUUf4xzQUl6yQwVpNHXqT8Es+y3tNlmZTS9I=;
        b=f6jg1GpuQK5FhGGZFE4pFi4m6WeX6leL/p6z5d4YKjf7XvmTPKAUyKNEX1RRdZOrr5
         5+rkA6vVATtYz5FfJkXhAK+UlxoFpfRKeqiIP5dB8bU0bsJig0WV4V9pV8DJMm+4074s
         YhUfK57y3td2h2kufzp0dcx1BpwcmEx71Cw6sjMBa/z6rlJDSLROxNQrUlfAhCHdFhwX
         s5xe8muOXciaWLxxDsGCN9ay3DXy7JPav2ptq3qeuF5o4vpGnHkDWwmM7Ru8HX0V2zWA
         M92hXkcDXQjC4NrQb8QiPXh2AjW49rFX5S862wJJDZuGFzIcJv5mDijP9TKpBs3BtQ5f
         Og0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVKijBfRXlUDXgo1wGvxvO1oYHY6Y3mnemTvGgbtBGUaitLi/UNjuEdw03lO8J8Np4vyten2dpmBRz0ddM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+XQHy/AlikbYMg0HfVkG5UKUOE9YctT46YOwMyBx4nMMkNZ+A
	ANXh0YSHO2CFCoxW1TkTRGTueZBwPOZZCHNJQRNJzVxShE7uphI7sz0SXLfdczzrUqk=
X-Gm-Gg: ASbGncvCoEz4oldjo+unJsWsjFtKmS9qWeTtmNOimWlm5gH6zuEdqWMvN+XruZpJYmL
	pEPP6vKZkHvDlcijFu3GNebSdAVMh6+gUZzQjWiNFeF3jZtH4X2T/t132codSDmdv38ml41E4Dc
	l4b2sJIgmuTwFd55CHUczZYMYyYP/VfuedFo4tKQz89TTYijCOodquSUi+SGm4ik7mhpHygllk0
	u1Z6y31BpqCCiurofutOqyw/DshysHNwcVr7YM/X/gfwLXAZP6kB6l3zDVJbP0u/hv7v/6py3n3
	klYpemgAfoKwMo554LDEZ3oLJa5UdlabvOwLu/KEdGIVabWXumvpGyFkLVEHMw1JJGdrQxI5j3e
	vIqg=
X-Google-Smtp-Source: AGHT+IGvzjaplpjHHcySeWxi/fySPbOh8CHoZuQqs8pJ8fFzORsjPFHbBuFq87mnlR1ZNPoONlGm1A==
X-Received: by 2002:a05:6a00:218a:b0:742:a82b:abeb with SMTP id d2e1a72fcca58-74f1beec959mr22574622b3a.2.1752595399392;
        Tue, 15 Jul 2025 09:03:19 -0700 (PDT)
Received: from cleger.eu.int ([2001:41d0:420:f300::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f856fdsm12546532b3a.144.2025.07.15.09.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 09:03:18 -0700 (PDT)
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
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>
Subject: [PATCH v5 1/5] riscv: add SBI SSE extension definitions
Date: Tue, 15 Jul 2025 16:02:29 +0000
Message-ID: <20250715160234.454848-2-cleger@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250715160234.454848-1-cleger@rivosinc.com>
References: <20250715160234.454848-1-cleger@rivosinc.com>
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


