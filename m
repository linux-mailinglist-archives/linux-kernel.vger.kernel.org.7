Return-Path: <linux-kernel+bounces-806527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F292EB4981F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 20:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A01FE207057
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 18:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4966530DD2D;
	Mon,  8 Sep 2025 18:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="SIh8nBrQ"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132FD1A4E70
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 18:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757355553; cv=none; b=I6Q/MR1LsPJ5M0pWQI0+jplUnsE9nUWg6BOLhLUpFPw0+srAzpzVkROF5ae2vvjtCnHVd5cTSzpZZ2VZzDjGwzV8dGMtsuUFlopchPXK6q8UrW3xZd4oWJNlrlcH3nyPF3MIP/4ltnMCOhX8BtfGdKPy9o0DdHBHEDMqTVX6HaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757355553; c=relaxed/simple;
	bh=4ngI4xpv5niSM5jXq4BIP6OuSAam1un1E/BjzFHjMhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZlTW9X9pyGJPyeoKvArfal1zOSdaLdXyF946K5Oi6fu5eu3o4SgORRHsbU1/1Vgo1i3QtlFYqyJ0K0nue9bKJP+SS87LVmq8cBba8H1vdr3Gh2B6ZZ1TcDOb9p3GMfwTIX4LztnJ5F7Z4qAIvHY1pSTN+fEetRVLPT9UGBhaH1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=SIh8nBrQ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-24c8ef94e5dso38618015ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 11:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1757355551; x=1757960351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OljeesxWIp9jDHv6jz9r0EeqTIgS1JKVuBa2eUtHLpE=;
        b=SIh8nBrQy5gYmHY6Q+29U4gr243O0j00oLIEQsB9WOUdJOZ/MgpQnw2MevlgWGgizu
         MdC5p91mIXsc2Ua2TeWaBWIDvu8UygqP9yU9zBDyFTaF5n6f/E+lh6sRVD8LnQy3dcUo
         Qwksy3BAh4TktoNVfICK7cjkBXP2RIz8JsMN7ozkUVrGDTPXhciudMlWcpRl6+UYLspQ
         8sJdmV4AuXOWUCZ4fsgQ05BgFzfFMqL8/vGjWQrUGCybUD1Ue/IbpCBFf18CjpC/O4jc
         i64sgvtSB2XWtJJT3/UXW4F+SU2T1VVsypGKsweYleJ/MzRHG3Z1XrgqjiZoCUx+SqcL
         ck6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757355551; x=1757960351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OljeesxWIp9jDHv6jz9r0EeqTIgS1JKVuBa2eUtHLpE=;
        b=n2hI8Qz4pfuw7eXb+YTcWpwOUduSEpJB/vevt+relPfZ1+6GIbF1TzsnrLZ+NAuRJl
         LnGBv0Lk9jRBGCHuJyJ60++DAmCAc4t1vaWkv5HD8T1ck1kxRVTyowKI4aXxpBxnifbw
         IRKmhma75qnQk9dOb+568hJ5bDaqdlLfMQbTCmhMBExBmEB9AW47EciHRsaNcYPvjw95
         6l+oECiWKGmjix4Q/h3pStycjr37Z75Q8hkdFn6sKPK1PuDOT8yyCUnLhbWu1ZVolmw6
         ZCYZJcQPHJeeQQuaZzK2NKuP7fdmsAfFZkizczyi5GnYqE9V2eubKgbYphNOFTVeTeId
         f4ig==
X-Forwarded-Encrypted: i=1; AJvYcCXNRQvkAWb56f+NJlF+Aj3QGeqevof1QA+7iaAKDLk9sFqKWfkhz36PxOSeOhO9+F3J+SY1+L5xmllFv/4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd1qbHtmVFsYsHtlN6IJdbi1m7zMwdRPoxLXmXv8OPqo49GX85
	0RB5AvLm1B/T3Ti+dv+Eh2GZpc0uQu1pjbh6E2PRJp0nKgSRhRK5S8aNW/2kR4DaC7A=
X-Gm-Gg: ASbGncviBWqHEowDzr0mODh+HQQXhaJIdgyXZ6SgRZnmB1F3UXwsB9dYaMGnOsOOxVu
	xPTRc5yjthtwntEELFhZ+/ZVUcoxbmi8T9we/feumWYm/7luA7pFYvURiafxsiXjRp2+v/iN2hN
	3QJeo7ZsZGJW3peqGKuQrZrSqEVuPoActOK0iWxVao8zE2tPaJLUD4IZTDNC9sJxL6SmMY1cSxi
	W5YfIG0XdsVqepfNGdLscZSy9mmK+j5U0FD05S4TNoYRiKY+MpA6uD4FZU3RTUdO74VMJwKDIjM
	nErS8Lqkrvw6TJdcUVzjF/3+NMdJ9sm5cMHMsEJiJ7IRV2Xs1pBweGbYUnfawdHW2SBt6jBc7aC
	mw5A2za48xvKKa+9tDabWaJBE
X-Google-Smtp-Source: AGHT+IHobZOnXIMkvuSbjqGZcdW0FzEx8+rn30MylSnC+vt7QbpZ58d6DFDptlwzGDiTrysTelEV2w==
X-Received: by 2002:a17:902:e811:b0:244:5bbe:acdd with SMTP id d9443c01a7336-25179f34dc0mr105646145ad.27.1757355551317;
        Mon, 08 Sep 2025 11:19:11 -0700 (PDT)
Received: from cleger.eu.int ([2001:41d0:420:f300::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24ccd763948sm117012755ad.118.2025.09.08.11.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 11:19:10 -0700 (PDT)
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
Subject: [PATCH v7 1/5] riscv: add SBI SSE extension definitions
Date: Mon,  8 Sep 2025 18:17:03 +0000
Message-ID: <20250908181717.1997461-2-cleger@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250908181717.1997461-1-cleger@rivosinc.com>
References: <20250908181717.1997461-1-cleger@rivosinc.com>
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
index 341e74238aa0..874cc1d7603a 100644
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
+	SBI_SSE_EVENT_INJECT,
+	SBI_SSE_HART_UNMASK,
+	SBI_SSE_HART_MASK,
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


