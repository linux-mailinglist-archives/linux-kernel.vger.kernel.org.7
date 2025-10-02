Return-Path: <linux-kernel+bounces-839865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D6FBB2998
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 08:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D79374204A2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 06:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455D72DA773;
	Thu,  2 Oct 2025 06:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="hcikybLL"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C23B2882BD
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 06:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759385379; cv=none; b=XP+OWBsjP7+HC8rJry4TBdcsczyp74HT16XiNvPJpp64sh1NfCbqJxhxRoub3hR7sJAsz9M5vBEBdbJvVQ6h4q0g8c9+8DR3HuMvbosq38tJHVwzYalz8PHcwYoOftUHkZVOhYiLXLlulfsQcyprB6CQn/rIzn5MqhulBe1LRTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759385379; c=relaxed/simple;
	bh=j2jjXbUEye2nfKb3sw3aIgKPRAfLAp+24kdzx86f4sc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f6b7TiDgVDIncGxi8f7OHKIrrVaVGMVrc2U6pLngORcm+t2+kGOALCjKW25M8/6gJkcyrtpCkrrl6gN+sSAVTz0ptCR5aoAO+hdmys0o5c64uu8mEk8XZuq/vf0BbJ+Xm3z0M+3JZDDcm1kb+DPdHZqKJD8OUTlfjKOOeAEd4Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=hcikybLL; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3327f8ed081so877676a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 23:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1759385377; x=1759990177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MF1UBNl0YQdxkCR2Wq/BcrNYDGhukTT3j7EdaD4pBPY=;
        b=hcikybLLA/XrC7oQzbMplex6fDdyU1a4XXZ7jQJRx1uxX3hFXxTtUzlZ7xVDhR3sgo
         AWvUKGbpjW8mNUwQPaY9vzDfJKxKdTl4UrYBV1KIEZ3oB6n7SXxJttxWonhTdwIFGOhv
         G+4AZftItpiBRGUheuWhY5Yo6DSw02eDAY3D4uVma+0+tgzVvmrH6+4NC5QZPdzVmgCC
         fXbvrQAKly2YUrjmH61PeU5YzCsmswRzPsEpPHE7VLuP7Ae0ow4siB5DB2EsgRaVy2u8
         lZhTVhMGNDPFMT7IAjUAD3j1g2XcgSGcnyBPlqHxJ0b5pL7IVO05jZT+7iAEzxsw5XC1
         f0zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759385377; x=1759990177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MF1UBNl0YQdxkCR2Wq/BcrNYDGhukTT3j7EdaD4pBPY=;
        b=eQ22HVo7ZRk8ZCKmlWQZO1VVAe14tNLBfRjwfTz/O3Y5fEH5I/l9mjnE9/i/afZMen
         mfR7AcWpoVxtWa4YbZ/mJ9T/SZ+4lPKIHFgOSOvUlv/DdBEPA4pS94b4EbFvt0EXbv9j
         JoqKUxiX4fy3qlq+oCQITyuVLEuhez/KNXz7Yix8PUuUkDJ3cWGPvWics8XQF4GxTvAq
         3qLV53J/fPhU1CpYH2//i+vwZw/5pA9iaoXvZ6H0y2c2WzWr0ZOMh/VN99N9taDHnnTp
         YeBpiWORLRVdkR/Q1eMddu2rzKykZ2ONvTQBXgQMpIDCdqsYmefM8e03CvQII2YjcBrb
         VcbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBZ625BYji7ur/O168TF3a8WxITuN+r3rq3CGRD1ZjK1Zsu+frpsU0TFbkiWW28+vEAhdA4oRFuyiZkRs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+J6bFGmlbbjW1XEdPcD4cFx8QTN+pX/+/UIy5bbRtvP/e3t2B
	+inZBXAk4hpQsLc1LJXGEghZ5h7xRx5KWdOp1Wec6/ryWuNNGv6SLPz0/oB5VQAPWSI=
X-Gm-Gg: ASbGncshWGbYrhheucSg82NYZUSiSWdwUcJu334r7Tp1ci4cj+Cn2JsIxuiR30DJ7wu
	TP9KClWzVQltpikPt5HvucwzbbskDjtiKN10F5LfRwVEup6EvNA7Y9/fkQwX71xS/thNMA+8Ten
	JL3a4UibSnOPsfH2a/Ey/EAtwKbfXVkeTPQPOO4eh44ydPaEOIlqpqNijvxyViZnwT7sT/MKEKh
	AJ2RcSdfuk0nhiZLxaRDGos8equ6R6G0R1KW8jFIolWfC/cFsI2Dd+8nrOZPFhVjacawNtewsM4
	kIt89s8YCabQwbWC2Ijd9syMaOd7WsKxy6YEvD/tgHBIxHrjVBDaidzIISdHCiHmICgLJ9jUquk
	amqK8s8ClxInbVDi6S0aJ+YqQ6EqSO2ruB1eePER5PtRhz8R4xp6oET5gHKT6XPnkGWgm7hI6fD
	cBR/Q=
X-Google-Smtp-Source: AGHT+IHhhHbJ8hJGnY+jVzo5XBMGx1xaIAa5m44vk4uxyjS42YcaIHBNHmkiTntGZfiB3yhY5MXCRg==
X-Received: by 2002:a17:90b:1e08:b0:32e:70f5:6988 with SMTP id 98e67ed59e1d1-339a6f84cd2mr5872201a91.32.1759385377284;
        Wed, 01 Oct 2025 23:09:37 -0700 (PDT)
Received: from localhost.localdomain ([122.171.19.158])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099f594afsm1205029a12.37.2025.10.01.23.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 23:09:36 -0700 (PDT)
From: Anup Patel <apatel@ventanamicro.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Liang Kan <kan.liang@linux.intel.com>,
	Mayuresh Chitale <mchitale@gmail.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Andrew Jones <ajones@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 11/11] MAINTAINERS: Add entry for RISC-V trace framework and drivers
Date: Thu,  2 Oct 2025 11:37:32 +0530
Message-ID: <20251002060732.100213-12-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251002060732.100213-1-apatel@ventanamicro.com>
References: <20251002060732.100213-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Mayuresh and myself as maintainers for RISC-V trace framework and drivers.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 969df0192fc1..898b51d3dd8a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21800,6 +21800,17 @@ F:	include/dt-bindings/power/thead,th1520-power.h
 F:	include/dt-bindings/reset/thead,th1520-reset.h
 F:	include/linux/firmware/thead/thead,th1520-aon.h
 
+RISC-V TRACE FRAMEWORK AND DRIVERS
+M:	Mayuresh Chitale <mchitale@gmail.com>
+M:	Anup Patel <anup@brainfault.org>
+L:	linux-riscv@lists.infradead.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/riscv/riscv,trace-component.yaml
+F:	drivers/hwtracing/rvtrace/*
+F:	include/linux/rvtrace*
+F:	tools/perf/arch/riscv/util/auxtrace.c
+F:	tools/perf/util/rvtrace*
+
 RNBD BLOCK DRIVERS
 M:	Md. Haris Iqbal <haris.iqbal@ionos.com>
 M:	Jack Wang <jinpu.wang@ionos.com>
-- 
2.43.0


