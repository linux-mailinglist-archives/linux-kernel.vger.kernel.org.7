Return-Path: <linux-kernel+bounces-579010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7953A73EB1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Mar 2025 20:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8150817B5BC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Mar 2025 19:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34509221567;
	Thu, 27 Mar 2025 19:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="c4IpcaFB"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F86621C194
	for <linux-kernel@vger.kernel.org>; Thu, 27 Mar 2025 19:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743104182; cv=none; b=L9cV+2T45xWSZxgDNVfeTYR9P0nBfVSIRFBJd/oj82f5suxY8u3i6QlF3ctTGB1JoaXXGiNNjBQ1hULSGaG6ORv4l0/ykEOY5SlA+OW7ro5gq+vi2MWEbvdlQoyChV/kqWsvEMqBI88TRQYwhLbxS0dUOrn+qutSPT7LYXzZa3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743104182; c=relaxed/simple;
	bh=w+WG3/hTVbYWnKFaU0I9UFeLZ3mNLhg68etVPwj0GZk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nqpnkKgvQULVnwYYy8MHkOz55ZwZT9NWhP2EkP3McuLFz6xBsAVcFFVmJ+G6NHbEouoSbGP1GE3fjLFAqDYmEIFcYLKrlhK+zLK/BOTB6l6fVn5tJF3y0zIMxt1vbVZLaDlp424SFhuk139oIK8FZ+3lUZ4/f9nIjXAaavhM5GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=c4IpcaFB; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-223fb0f619dso31071765ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Mar 2025 12:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1743104180; x=1743708980; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zw3zbGTAqHMsJs8YvOYpRy60tVdSbXNH77zwDO4GVCI=;
        b=c4IpcaFBL76BLHBVNgKS1L1650FF/45ql8tkIYu9zfIr2Anf7xsj3B3Yn/j7cL6Toe
         5Wu7KgxfJF3PNDYSckTjGAATSdtcHhL9auMyXxR4l8ZsWivDGEpEPtk8/44vk+fCSiTz
         OTtDgMwhfMwcV29vbP/Q1d4bpPM3M4npr5tux8CbB5l3w1Qp20Y8TuJprVQKipsPHIHH
         Ev84V0PwtoU2OYn44JoiRpohwtLW4aEZ8c4OyH7/eBYemKePQyxkmhQDC+mhwx55cw4D
         UB7VQitGDrGkNetkqCV2yWblMmNGpnyDb0xud7f9x6w8Vaeu75bPAQs7/ns90nMhSw/G
         Vw8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743104180; x=1743708980;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zw3zbGTAqHMsJs8YvOYpRy60tVdSbXNH77zwDO4GVCI=;
        b=CqNZtD9cFVyJRekIXqY79n5C57yy3g6taAnziq3O+gVbT/zEUt86ZSm2gx7bY4QySD
         YCsKMD/X2yyPRrmEnV33qR9zmRMBWEl3WKh2jH7hKLxILTCkIKv3khXvjl0qR3TP4/S/
         KNyxBb3X9F10UOWRSXtf7+o+pmsAPLptiFrVBdbhngzn+q2ZjdzExmNNW8cxWsG4xiwz
         iAObM27m5FyQ4oU08NS1/VGWKGOmrv1e4TlUN2WaNc6VxodYD9C8sRc0s+xC/jOVFzdw
         HCfFBccizTMA/qv/am5iEzSi2X39t8N57N68MRg2QWScUonGY1VqecPrie/wBi/F+z/u
         Gk+A==
X-Forwarded-Encrypted: i=1; AJvYcCVW31arfwQGCxRBUK/GhZGZCiynBjsT8ExbTBKReTZVVC3AwJSZsbGXvwaRSkFbmgpkjL1f65MKLQ/t+zU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwURsXsgfhgAozs9GVGCcLV/Epc7M+7181tSm41ik/uF0gl6uj2
	2iJyRJB/T2DMHos1bsEBhjbgAT9n++xXjEq1hX9OodwZPjcAOZPzRFeUW7wU3Lo=
X-Gm-Gg: ASbGncvLkfBtQzU1RZQgbDuhJEcHQkr1GkgvkxbY4kDI/r8l2nn1jUTyHySvMJItbFg
	kHIh+0I9J0z6qBD24yglerXsNIb0aD77V9Wf6q41pEbyiRBQOXYpvIX4DAcmH84m5USyGM9imtR
	LTrp33howChZMt9wooa3/zMmS0QUqvDNt4U/CunvP55NrA0/TMx5IifvIno1zHKjT6BexxWaGU9
	lMKK8Ht7VPUJS2lCuy2Qu9uRK3+XT1Osy9628vrrrMFEg1eC/z+jZQXyFZCN2cvJSCRJ+1evOTq
	hQhQ8caSauRfBLvuEFQhdUasri5Et0ZqB8ptKi1YqT6IlBWkT/iC23d20w==
X-Google-Smtp-Source: AGHT+IHpWwO+ALT63AnEQfROc0MsU9HJIU94/2wnOwykaqK6qJLji7kuLw7H0FVEp+QuB62Asb9xXA==
X-Received: by 2002:a17:90b:5827:b0:2fe:a336:fe65 with SMTP id 98e67ed59e1d1-303a7d64066mr7195102a91.10.1743104179797;
        Thu, 27 Mar 2025 12:36:19 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3039f6b638csm2624220a91.44.2025.03.27.12.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 12:36:19 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Date: Thu, 27 Mar 2025 12:35:46 -0700
Subject: [PATCH v5 05/21] RISC-V: Define indirect CSR access helpers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250327-counter_delegation-v5-5-1ee538468d1b@rivosinc.com>
References: <20250327-counter_delegation-v5-0-1ee538468d1b@rivosinc.com>
In-Reply-To: <20250327-counter_delegation-v5-0-1ee538468d1b@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Anup Patel <anup@brainfault.org>, 
 Atish Patra <atishp@atishpatra.org>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, weilin.wang@intel.com
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Conor Dooley <conor@kernel.org>, devicetree@vger.kernel.org, 
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 Atish Patra <atishp@rivosinc.com>
X-Mailer: b4 0.15-dev-42535

The indriect CSR requires multiple instructions to read/write CSR.
Add a few helper functions for ease of usage.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/csr_ind.h | 42 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/riscv/include/asm/csr_ind.h b/arch/riscv/include/asm/csr_ind.h
new file mode 100644
index 000000000000..d36e1e06ed2b
--- /dev/null
+++ b/arch/riscv/include/asm/csr_ind.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2024 Rivos Inc.
+ */
+
+#ifndef _ASM_RISCV_CSR_IND_H
+#define _ASM_RISCV_CSR_IND_H
+
+#include <asm/csr.h>
+
+#define csr_ind_read(iregcsr, iselbase, iseloff) ({	\
+	unsigned long value = 0;			\
+	unsigned long flags;				\
+	local_irq_save(flags);				\
+	csr_write(CSR_ISELECT, iselbase + iseloff);	\
+	value = csr_read(iregcsr);			\
+	local_irq_restore(flags);			\
+	value;						\
+})
+
+#define csr_ind_write(iregcsr, iselbase, iseloff, value) ({	\
+	unsigned long flags;					\
+	local_irq_save(flags);					\
+	csr_write(CSR_ISELECT, iselbase + iseloff);		\
+	csr_write(iregcsr, value);				\
+	local_irq_restore(flags);				\
+})
+
+#define csr_ind_warl(iregcsr, iselbase, iseloff, warl_val) ({	\
+	unsigned long old_val = 0, value = 0;			\
+	unsigned long flags;					\
+	local_irq_save(flags);					\
+	csr_write(CSR_ISELECT, iselbase + iseloff);		\
+	old_val = csr_read(iregcsr);				\
+	csr_write(iregcsr, warl_val);				\
+	value = csr_read(iregcsr);				\
+	csr_write(iregcsr, old_val);				\
+	local_irq_restore(flags);				\
+	value;							\
+})
+
+#endif

-- 
2.43.0


