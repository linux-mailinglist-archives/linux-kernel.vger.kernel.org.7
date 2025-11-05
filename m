Return-Path: <linux-kernel+bounces-885996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E13C34787
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 09:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 48AC64F318C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 08:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1BB2D739F;
	Wed,  5 Nov 2025 08:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="ShVK0YTS"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBB82D640A
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 08:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762331336; cv=none; b=Rfv1tTJl/jUsIclp3AFm0JxbNS+JFTf9dbYPwDkKPrAI4WMALJp2x+gw09XYPXlD2oE6LaUbRLdh4CG5jeLj0WdniB8ZSIpfWR+gOTpeqE34z7AwIX3BZGR68XT6t8j/21kmCyJ9tdVba1QxUc2eCjapLmutX4kCC/DioH8VSk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762331336; c=relaxed/simple;
	bh=YD1DGc1PTTzmFAGHhSNrHRTvJkRtZfZ1qpUIc0VusL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lbWxUHuZu4HZUaYDqxei833oBc2auebowBX+126VtMBd1mE6KKA7u2O9AEwbae0L6oNby7qifn8HlYdwTxRBddxjBFRFduJFzRtMgxXxVSri9LP/2FUxn6X2TOAcGZdpnpLdlrxggSuEgGFa+MDWpOO8agYPp4cnc0GBhCIyhcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=ShVK0YTS; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-294fd2ca6acso5161575ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 00:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1762331333; x=1762936133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mxVWTJdT+SCjk5O8ZmtBkLAMOboy+sCiTeWzaOD3L7c=;
        b=ShVK0YTSvDfTVYKyfdoqQOagSaBTDIUuwymTHoPAAPadL9xsq8UgKEfQn4eN4+lecM
         79WBWv87nhl//oFNcEab6WzxvoCtSjZYaW6ZkhWTzk4oFAdUyu+qIiU14wcbN6Zoa+ed
         +7uWaw2oIV8oO3id9x8tzFjMwIDQKryyXhp0NPIePHU4/ASMhp6voIvd1web3imWZS3h
         +2RR6wUQY00ktmPZsRYUAQx0fWx1ehBmKEDz16ojzVLX3IULUUN8YeQHb2VsL3JDYpjl
         RfazJoSH1d/v7b9gm/X9SA9DfIox/zXDnEU9fX6NQRswd4rFcrtpPqI3FrC+OJCrjRGo
         Xh6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762331334; x=1762936134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mxVWTJdT+SCjk5O8ZmtBkLAMOboy+sCiTeWzaOD3L7c=;
        b=K5KmlfwC5qWgfLH16DelJ/JBwKiVMFWTwucfRg4gDVC2Fgb9JMS1HeoZ3yCoQl17sc
         BE6lfquTAnOxF0D363OMpjowOWgtsfw6GNOp4XjZ+QxQU70AZwm1qV1HT8BTmUzHaYPT
         DtXTT+3hxGw2vvwoUFOmWPG7u3AvxbSmvR0ANWOabd2lhDnqBVaVP+qYYDpHA5u8C02j
         gr5fMwnh4LrY1FvRpGUY6o4lw8hIUDYblVUCtpfeKVwQHJSCi/TXFMn0hx5poUcxjX1P
         M/7/hHTtJSpMJSC2XOvY44nEXymi7+Vzzdklzm+OfKYbrUF6sN1KKfevOrpLhjzzWRql
         1T1Q==
X-Forwarded-Encrypted: i=1; AJvYcCW/xDzEsk22dixfA+tgcYas9vzzWF9DsdgiFGJUfhJyjJd9aI7tqZdJ9kBlFllXjCxSqv9qVuZ+vN2HS6M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2Gn36KbLca8xp/5sGywVU14ey2VNRyIcYGMaQz8gltWK/0PUX
	AUMKxlAZnzUeFNrOutBt2MCxLvlGtXTGXAWOMr/93GGDYXNJQ0GTkhK2IGOVJpOafsw=
X-Gm-Gg: ASbGncsTax7Bqc8EMRupcxgukdH6guYZH/O9UVb7CEnX1g3vdbE0K9A/jyK6HSQVXsm
	9kPrA03BvigbUWIlLrPw9mS64AEj522QmELgmvyxZRhfL0fus4MO+DM95e91GfPq0qR1eMmKNe/
	fyfjr0lh2LHMCTsHBO1FDySbUCsOmY7CXhI+/vE802/0dqF7DeIiyhO9sNJN/HSlnteg6HswlHd
	pEoYaND+eum9I0dMEDQF92k4/86CZzOGShcRE77ouoHYe9s/Gvrk4fYT03dpdWHriMGZ2CPZbee
	2k2phQDX1432zxFg2c4yXny//mduTYFCTxqeuqxR/xvDbUWZjlOOat2m6JtpX3h0szYR7GvYWxr
	T28HBRpCuUKEyADS71jum4dKu6CPcD0nJtD4csznMnPZP2BWFldt84yFy
X-Google-Smtp-Source: AGHT+IGoN1GXGikcvAvUXnBnSY8dbKotW+FyvTG4CG4Bx86TVuBznGgWug72QAB0JjPEWtQzHPyqhw==
X-Received: by 2002:a17:903:2346:b0:269:aba9:ffd7 with SMTP id d9443c01a7336-295f9483fb3mr69028445ad.25.1762331333570;
        Wed, 05 Nov 2025 00:28:53 -0800 (PST)
Received: from cleger.eu.int ([2001:41d0:420:f300::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601a741e3sm51870875ad.98.2025.11.05.00.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 00:28:53 -0800 (PST)
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
Subject: [PATCH v8 1/5] riscv: add SBI SSE extension definitions
Date: Wed,  5 Nov 2025 08:26:33 +0000
Message-ID: <20251105082639.342973-2-cleger@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251105082639.342973-1-cleger@rivosinc.com>
References: <20251105082639.342973-1-cleger@rivosinc.com>
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
index ccc77a89b1e2..0f47e6f03b7e 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -37,6 +37,7 @@ enum sbi_ext_id {
 	SBI_EXT_NACL = 0x4E41434C,
 	SBI_EXT_FWFT = 0x46574654,
 	SBI_EXT_MPXY = 0x4D505859,
+	SBI_EXT_SSE = 0x535345,
 
 	/* Experimentals extensions must lie within this range */
 	SBI_EXT_EXPERIMENTAL_START = 0x08000000,
@@ -505,6 +506,66 @@ enum sbi_mpxy_rpmi_attribute_id {
 #define SBI_MPXY_CHAN_CAP_SEND_WITHOUT_RESP	BIT(4)
 #define SBI_MPXY_CHAN_CAP_GET_NOTIFICATIONS	BIT(5)
 
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


