Return-Path: <linux-kernel+bounces-660016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E934DAC17FE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 01:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7244CA4580A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 May 2025 23:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FB3271A93;
	Thu, 22 May 2025 23:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="s/MFnMql"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBA82D4B49
	for <linux-kernel@vger.kernel.org>; Thu, 22 May 2025 23:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747956387; cv=none; b=guL8V2WcUk/7gEJX+bsOH/9B2BjMotkSoF1V1UJMcnHJrcEURjC+X+O75f0AoZIVEcZbXNXmrDdL0ZJ5x/4EgHvM1xHij+JLAPVC30Pndna86o5kpcUvwkeGBcxXGokofZTghy+764phq0Djx55s1BFgJomQOcM4NBTV9z2WwoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747956387; c=relaxed/simple;
	bh=4/41jFZ7X8VawKTZS2OnRtVeXztOo2HbkndVhYtr+SA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IPfCBtddx7TYqhEov2flHbXgAw9OXqgwG4dqkUmeII3UBBDfYhlbCU11WOS/bea1DWB4psO8yAXi/vwfFGxK8oKSS0UzmGsZCV2xDLBcA6bL2EwXTyjbD6UEiLQkUmqhpIhQ2efZe+LrCEWlN6WeKwVfuxXn7BJI1UNpg9vGkew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=s/MFnMql; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43edecbfb46so69649235e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 May 2025 16:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1747956383; x=1748561183; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2TGQ9Um79TGA1rdJIfqkWtDlxZ0F5uqHcIUUMheXtuM=;
        b=s/MFnMqlagQ232hEYp5xSURoyTSiNQeD28sHlznTLBjUXSavqGww8VRVFUHsNVBgti
         8EhFUeekXRuZ3O6wdcuYr205bFHbGqzmTOUQrCH0iY5YMK3LLojF1qbQqNtZ3bZtVVLN
         oJ4hEK79oqKiO+IUujmFt2MiUtS9ryyCOlGNCx/xqJi4JyLw25Ltim9RDYCa2q48LbaI
         Po7Dhr/IIhcxnLq/hbNLqFiKS20UJtnPiLG2Arz/rtrGHcENyDDLVA31wiG1a6Xrwy01
         UUwHIaSEv9VummezSTKG9SnBd7AZa9SrsHpBR4evHg2MW1vHpq9FKu0TwAUdG77quFtg
         QQgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747956383; x=1748561183;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2TGQ9Um79TGA1rdJIfqkWtDlxZ0F5uqHcIUUMheXtuM=;
        b=WWxL4EiS7nUfBdWm5AVlMuQbQ4AAePBO1k+q9xquqF+e03T53/DsbUitHnZoq9HNJY
         Dl1dHspbaD6bpgi2crlNHMfPYMA/AO6IKH04IkTkDJPNHoOudVuW48rO1abkH8yidLpQ
         bwUs9NFwBNmakrg/pjYSCTu9ZrYA1uxHp8T+nfFcq1Wqxrh9bzw9Y/RTYKJn37XJaBqV
         v3JPr4tQ5N9XhoDvDIgyWb6N2IPJ/HA48molG6Af8jQ8q4Th4nSVZI2fvFhSY+Tl15CQ
         geEw5lE2RxAHZHD0gaJCWH0hsf49jhMWUjGY/LDLJXkXf0P+LP5HuP0aPqvxn/pd/Uma
         a7Cw==
X-Forwarded-Encrypted: i=1; AJvYcCXYbQwatXPXFRGqur6ZeF2lQSImcVR6AEtUtSAyGTgekb02vK7RXmEVEvlT37ZsZI2ksUu/5diLGqByS0A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/E1BlX8HK4DsuBzIOl6imII6UoBuxl+alsuDIvOEVo3o0AsDP
	xEgmtX9qhNVqKvPl5kWtpWNC/Dh8HC7wkEOxgdRlxoOb/rI4SSQxaYnznZG6n7FqRcs=
X-Gm-Gg: ASbGncvdlIXuScoIJHzMH+WhXUSTH0QAHMP4kQkpNSdp3500PETAqslVnaVaSdrv+Ht
	fauC3pyLLwqKKt8cB4OUCfYKa+PQT+eE2OG/+oX9G0ZXAiaWM7ZFmxefODorq6jjPGOQvOC5oU0
	cWjRnbPgeKkru1opHW+ZcGKgkG6i4A4LomqQRMNTzxS0qE3YaXlBpC8eaS4TSUFRP4PAr5YpSIj
	tIJakrReGhEs5ZZMTcUyZbJfWPwTk/42X4FNiBDxivs4NUUH4xaPXqbvGYAuLa9A4bWCeIxqhYe
	IML29P39lCeIQn9NbJ/WppBuoj4esnpsMWNQ0ZaSP9NVZQbmIKId4w==
X-Google-Smtp-Source: AGHT+IF6ivtK0jlTOWplkDrHgDgHgJQdZAf+be8xON8uguEYmscbWhUXECsK2nYD7OUkDLNgE9SoYA==
X-Received: by 2002:a05:600c:8207:b0:44a:b9e4:4e6f with SMTP id 5b1f17b1804b1-44ab9e44edcmr45387425e9.16.1747956383213;
        Thu, 22 May 2025 16:26:23 -0700 (PDT)
Received: from [127.0.1.1] ([2a02:c7c:75ac:6300:c05a:35d:17ae:e731])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f6f04334sm117825395e9.10.2025.05.22.16.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 16:26:23 -0700 (PDT)
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
Date: Fri, 23 May 2025 00:25:13 +0100
Subject: [PATCH v3 7/7] dt-bindings: riscv: add Sxctr ISA extension
 description
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250523-b4-ctr_upstream_v3-v3-7-ad355304ba1c@rivosinc.com>
References: <20250523-b4-ctr_upstream_v3-v3-0-ad355304ba1c@rivosinc.com>
In-Reply-To: <20250523-b4-ctr_upstream_v3-v3-0-ad355304ba1c@rivosinc.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Atish Kumar Patra <atishp@rivosinc.com>, 
 Anup Patel <anup@brainfault.org>, Will Deacon <will@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Beeman Strong <beeman@rivosinc.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 Palmer Dabbelt <palmer@sifive.com>, Conor Dooley <conor@kernel.org>, 
 devicetree@vger.kernel.org, Rajnesh Kanwal <rkanwal@rivosinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747956375; l=2497;
 i=rkanwal@rivosinc.com; s=20250522; h=from:subject:message-id;
 bh=4/41jFZ7X8VawKTZS2OnRtVeXztOo2HbkndVhYtr+SA=;
 b=jbzPeS5MNGd7AFFPThGCJziNnql/9Fc4HHGH91C3BLqfIJnqOWhSXa3ocJBdIz4rrC/pVNW7X
 eE6pHLfkSXrBFviRejtBWb+GcQKMp69KtkiO2MuH6iYL+oRko9WVfgD
X-Developer-Key: i=rkanwal@rivosinc.com; a=ed25519;
 pk=aw8nvncslGKHEmTBTJqvkP/4tj6pijL8fwRRym/GuS8=

Add the S[m|s]ctr ISA extension description.

Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
---
 .../devicetree/bindings/riscv/extensions.yaml      | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index f34bc66940c06bf9b3c18fcd7cce7bfd0593cd28..193751400933ca3fe69e0b2bc03e9c635e2db244 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -149,6 +149,13 @@ properties:
             to enable privilege mode filtering for cycle and instret counters as
             ratified in the 20240326 version of the privileged ISA specification.
 
+        - const: smctr
+          description: |
+            The standard Smctr supervisor-level extension for the machine mode
+            to enable recording limited branch history in a register-accessible
+            internal core storage as ratified at commit 9c87013 ("Merge pull
+            request #44 from riscv/issue-42-fix") of riscv-control-transfer-records.
+
         - const: smmpm
           description: |
             The standard Smmpm extension for M-mode pointer masking as
@@ -196,6 +203,13 @@ properties:
             and mode-based filtering as ratified at commit 01d1df0 ("Add ability
             to manually trigger workflow. (#2)") of riscv-count-overflow.
 
+        - const: ssctr
+          description: |
+            The standard Ssctr supervisor-level extension for recording limited
+            branch history in a register-accessible internal core storage as
+            ratified at commit 9c87013 ("Merge pull request #44 from
+            riscv/issue-42-fix") of riscv-control-transfer-records.
+
         - const: ssnpm
           description: |
             The standard Ssnpm extension for next-mode pointer masking as
@@ -740,6 +754,20 @@ properties:
                 const: zihpm
             - contains:
                 const: zicntr
+      # Smctr depends on Sscsrind
+      - if:
+          contains:
+            const: smctr
+        then:
+          contains:
+            const: sscsrind
+      # Ssctr depends on Sscsrind
+      - if:
+          contains:
+            const: ssctr
+        then:
+          contains:
+            const: sscsrind
 
 allOf:
   # Zcf extension does not exist on rv64

-- 
2.43.0


