Return-Path: <linux-kernel+bounces-740112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7CAB0D01F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 05:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEF091AA21CE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 03:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A7228C02F;
	Tue, 22 Jul 2025 03:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="s5YeUef6"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E51228C2AA
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 03:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753154130; cv=none; b=jiVo0ozpqcash0n+WlfvLoB9TBirUlWeman3FLcKdOEPqy/ra7tsdKVND37063YfVF4iY+BE3vcb0JTOT3v4RKe5HzjL22cVs6kjGcPRMqUatDKZItBimSr/vVIuVz3SPP4tZMQRTsiwW54AZ1OITJ0AJOHv829WP1rU5+3WUA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753154130; c=relaxed/simple;
	bh=e7KhWyihGNeHQtmANrYGamMrWZjvNUfv+srLihtniBI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KxsN5lT0mG4nvJZ9tzBZdOcZKxotzG5XyPPMFLrliirL8UDFK29ZGu5FkxazbGkT56byh/oDn5nYBXBW/nDE34RqKSga6BvpplwLyT3RiBr6ID16LP/9cB21o94uqxL5KXGoVM4NQTIGiqVLa6LAeosw6NMnC1FFPLX99G6BRiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=s5YeUef6; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-74ad4533ac5so3241363b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 20:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1753154128; x=1753758928; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=goqLKtDob+ZNX+w3rmmnq6+zF8DlfuvYjDiKv2ieDbU=;
        b=s5YeUef6RTO6GfWIMiC1SiGduaDJSwIs1PcaM2diW9VDyubdNMNxwdhu9BO/1p4Fhx
         BWY8qJlBnPphX1opyliabfp2IxHk/PGGZZyImCMH4P/xTzPQtFqNH4r2ONmMh8nz4oqJ
         f/K54DY7ACvjc1a/NqZl1UqFaKDntienWU6mAUD+DlEY9h89kFx/8c9rxg3aYJ7HgMqR
         tzvR72wtEurfepWaZdH6YrW8dJY93iv8A3ixcqJvdqnBArXSODGveH8sIKvkTCg4xIuG
         t6uC0DUghYrFCPH48gM32fX1cNIqWyX30vRrrnyxd7aJdbpDULtFTaJR6qei6lfhwrGq
         D8JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753154128; x=1753758928;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=goqLKtDob+ZNX+w3rmmnq6+zF8DlfuvYjDiKv2ieDbU=;
        b=EBe58gPlylFZs8cvPGhK41en/XfcYpNEkIQE1lY/7TN6RLM1HkO9FE3iur7uJlOqpU
         zBVtqIVs5N86J5bntJ975BhlmRCtQSUfEgY1v4iPXGhJ6jquTmtOm9Q8kbmEyckugb/w
         7Xnx+ukPcL+xZYsWuqQRdeuZfizsNDDQ/IpEReXNfyv1/jyCMZeogPm4yw9SlTeM2i3j
         4L7dytkKoO9RSGzrSwCmyx4IhJlMZtAd0OozMRtZY9CQdGaG4Nb1yfl104NzGEp16+Py
         UpfkJUiVO5PbbnS5rRqGZn2sLAFnTTldmGfLnsx7ER8adgnnMsdL/bpthfyWEZD+hVJ/
         RK4w==
X-Forwarded-Encrypted: i=1; AJvYcCXP65n5HR0+hlGtfYBvg+wK1dlrEZWTZi12vqRZ+z6uOEDogUF4lhKMGq1/U3QWE0ISOa4Gno2kTdpwcHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwteuLVL4N9aJPdIdwuwUz+nXuJMajcFab6faGRfyRNpYgPPDuA
	79xIiN+BI+dxWRNZc/Gp0EwJ4d4vhCXIvm67GUMj/xHsiB576ghsw+5TwwZH19EV37U=
X-Gm-Gg: ASbGncs+nLvD4qNzI78kpB7KpmUNIz964sIl8NdM7V1hUPmS7WMinks30PbGUYm6c8v
	XudHt4RxJjZlC9Tx9o5O6iEc+DPDpOZDC40nqzgdRcotFLLKqajmy0FYOZgNVB5yjVayA4EoXjr
	tV8w4BY2FqTR/EsZw/AOjgb0CBoPWLcons804k/QOuc+nxAWCDiRCLBMLiYiV051yMP1BMa9MkS
	PleiPIUZW4eCOgI/kRrvr99fWQq5L2cSYkVUF7dG1mEGLMhTzGtvcMixiK5sSKySeiKYdWL6DdZ
	5BWVrQYjRO4OentFbzuguimVXHdRvyw5H1BCHN5efGw9ACDg8/0u2sTwqza+1Mj9EkbScU733tD
	I7APQgOtlpWXN04UB72c1UtHN7PhkYD7JpY4=
X-Google-Smtp-Source: AGHT+IHQyL4rtGfOdMFXQZYZwkkphmY+Xgv9oIObvrdf8R89tWOPveRkw6OvWr9uZxH2fTwJdfujLw==
X-Received: by 2002:a05:6a20:9186:b0:235:7452:5867 with SMTP id adf61e73a8af0-23d37d7e90dmr2717183637.20.1753154128287;
        Mon, 21 Jul 2025 20:15:28 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f2feac065sm6027612a12.33.2025.07.21.20.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 20:15:28 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Date: Mon, 21 Jul 2025 20:15:19 -0700
Subject: [PATCH v4 3/9] RISC-V: KVM: Add support for Raw event v2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-pmu_event_info-v4-3-ac76758a4269@rivosinc.com>
References: <20250721-pmu_event_info-v4-0-ac76758a4269@rivosinc.com>
In-Reply-To: <20250721-pmu_event_info-v4-0-ac76758a4269@rivosinc.com>
To: Anup Patel <anup@brainfault.org>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 kvm-riscv@lists.infradead.org, Atish Patra <atishp@rivosinc.com>
X-Mailer: b4 0.15-dev-42535

SBI v3.0 introduced a new raw event type v2 for wider mhpmeventX
programming. Add the support in kvm for that.

Reviewed-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/kvm/vcpu_pmu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
index 78ac3216a54d..15d71a7b75ba 100644
--- a/arch/riscv/kvm/vcpu_pmu.c
+++ b/arch/riscv/kvm/vcpu_pmu.c
@@ -60,6 +60,7 @@ static u32 kvm_pmu_get_perf_event_type(unsigned long eidx)
 		type = PERF_TYPE_HW_CACHE;
 		break;
 	case SBI_PMU_EVENT_TYPE_RAW:
+	case SBI_PMU_EVENT_TYPE_RAW_V2:
 	case SBI_PMU_EVENT_TYPE_FW:
 		type = PERF_TYPE_RAW;
 		break;
@@ -128,6 +129,9 @@ static u64 kvm_pmu_get_perf_event_config(unsigned long eidx, uint64_t evt_data)
 	case SBI_PMU_EVENT_TYPE_RAW:
 		config = evt_data & RISCV_PMU_RAW_EVENT_MASK;
 		break;
+	case SBI_PMU_EVENT_TYPE_RAW_V2:
+		config = evt_data & RISCV_PMU_RAW_EVENT_V2_MASK;
+		break;
 	case SBI_PMU_EVENT_TYPE_FW:
 		if (ecode < SBI_PMU_FW_MAX)
 			config = (1ULL << 63) | ecode;

-- 
2.43.0


