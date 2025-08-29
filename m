Return-Path: <linux-kernel+bounces-791930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED745B3BE17
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 16:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53151169166
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 14:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91998320CA7;
	Fri, 29 Aug 2025 14:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="J2lZAwMe"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344D42EB85D
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 14:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756478471; cv=none; b=Fg/A5I3N5jTmFg+8tbXbDCS7Fe6Thlb0yTMU/TbJz6QzBy4C9QJ73Vz43lHvEfsnagEk23Rfvi53aHs5PW0bnWtd1Uki4JIlhdSuIKwkp5B2GnmLLSiW0QcT04cbq/PRToWP+9D6ruWjH1P+ke7xStEBDkwFJg6II6J0NoNDLC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756478471; c=relaxed/simple;
	bh=m2E8W7DiSx6Ltrasj+rnR9WEkMr09MKsEoyxo0F+Klg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tkzt3GGDPRK/xNjlzysHqc/frzuK40HJfUlsjVtp8wPAEF7jWGwJtXYY281d3sjzPIWTWaEVAgkbQ0aV/q1GDKb4h4sAbdbPkOK2AmwYyZ+R0+7CVTtemDaoWiKKzxfqKIQDiJzR954n1jwi+nd8t/iCLlaI7/zo7A1DWGDsacM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=J2lZAwMe; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7718408baf7so2109323b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 07:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1756478469; x=1757083269; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QppemwXg72umVaHol/lc8lTgDOnrssZANvnDyByXBzA=;
        b=J2lZAwMeDRUl811hv53I23QJWBwz6961FQgBLeHdvbDBDomJSn6qLvLAr9tjlsJHL5
         QTFsj8vcPQN54Xo77LNRt2OX8/JDqvGA58ObrM4yKhxGWx5fkkj6RlwrtL0UOcbGPMQ1
         gUqv5/gGVqoTdOIZ4pGIwHfRo6aDYtvJLfrfNngIcRAGpAzpFiKajHYjZkkO5Umm29qb
         hTiT9Bpga7IfE2H48Jzw7BSWbDc6dzDFOyWd0BEZdzRTP2Gx3DMiEKPAMZQG8AF1BXll
         ypbVG2Kq/lQ35pxybndDazJ+SmDPbdH4fER1INxceVoHTEf7ltYuHZtuBss7s8FoTS3Y
         0upg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756478469; x=1757083269;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QppemwXg72umVaHol/lc8lTgDOnrssZANvnDyByXBzA=;
        b=Hrjlj3Dd3OXMrnftYKV//PMP5VlE7mNfpOIB918x9gCov/7wIzLzeum0JukAcMglV5
         iSYXBJ+ZQV1qD8S4lHwuZd5y+gLa07mj69ThyBut+pbM8H1vZIXa3mRDd08wG+4Lt8RT
         isQXn0Dv9JydijwFS8aS84zybaC5L8TQlXPTMeQDGEZ7Ixoprrf/X/75PpDjmUa8Nawo
         mdk3fyhEVPi9RYglR7mIE/oQ2Q4Q3ZMYc9RJmw6iwuAf+fvU9/JmYOkMP+B+UH+2dQlp
         1PfJ+v2TrQZtZtC+niu9HxZ7hbDvgHE2szztwKuoNIrA+rD2U5w9Y0ZxEYBnUXATe7VN
         v+bA==
X-Forwarded-Encrypted: i=1; AJvYcCXCZNddMB89fXdi7iz34UY0XmX6C0cjQqmAF7tIA253yHx6MPxhGkzOlgQoKQbxE4Y0+Zjzzc9HDRh7MxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWdu44WXbqulahHh77wx3z1XEmByqILZrJuXzgjNtnuxoT0vdl
	1aymbQVfDr9TR9LjbsDXluCBbOSfm/skHp3voFlqlDRw1XWui56nucfqEo6rl7j1hfo=
X-Gm-Gg: ASbGnct3wQfMNlK3hfP5Wwy92VsRpRcXkQBbKiblJ4xscNIMKTUf7i56iMLnWflRtVZ
	PlAD7HUESwAUJh+BHQbGRaQnmoDVdSKcueUlsVCn6zVeUWWDBNuUQBWD4j3UVVqPhMH8GTVnILl
	YzAeE8x8QjiPIHQKDlYzmDJIug6UHXPWJUVCMH5RsyaCER0OB+gYzn1UXvzIR+82eWtXdCo17vP
	IvWMwQJB41Q8PdlZaRpKqLT5LsfivjkxYPyOddh9KdurY7J10QaKiVAtwJCaAy9RSmzqycufT97
	4JwikD/DvACQvwg6kUy96uf9p6DBQBcHYgJYCZc337TwasZQGMmCYor5qaUdICr2IWr4LZnsFJa
	Ahh/0zPRhL9DQUx1QzKs6jMYe5Hv4K83sWws=
X-Google-Smtp-Source: AGHT+IEyDQaVO7hw6M+jmWcVL/199fQHjMH7i3C/32jO0Trqcu+fqIoi/CB4Tct+03RcyOTn/ZKedg==
X-Received: by 2002:a05:6a00:2306:b0:76b:e868:eedd with SMTP id d2e1a72fcca58-7702fc059c7mr38073588b3a.24.1756478469428;
        Fri, 29 Aug 2025 07:41:09 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4e1f86sm2560999b3a.72.2025.08.29.07.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 07:41:09 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Date: Fri, 29 Aug 2025 07:41:02 -0700
Subject: [PATCH v5 1/9] drivers/perf: riscv: Add SBI v3.0 flag
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250829-pmu_event_info-v5-1-9dca26139a33@rivosinc.com>
References: <20250829-pmu_event_info-v5-0-9dca26139a33@rivosinc.com>
In-Reply-To: <20250829-pmu_event_info-v5-0-9dca26139a33@rivosinc.com>
To: Anup Patel <anup@brainfault.org>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 kvm-riscv@lists.infradead.org, Atish Patra <atishp@rivosinc.com>
X-Mailer: b4 0.15-dev-50721

There are new PMU related features introduced in SBI v3.0.
1. Raw Event v2 which allows mhpmeventX value to be 56 bit wide.
2. Get Event info function to do a bulk query at one shot.

Reviewed-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 drivers/perf/riscv_pmu_sbi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 698de8ddf895..cfd6946fca42 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -63,6 +63,7 @@ PMU_FORMAT_ATTR(event, "config:0-47");
 PMU_FORMAT_ATTR(firmware, "config:62-63");
 
 static bool sbi_v2_available;
+static bool sbi_v3_available;
 static DEFINE_STATIC_KEY_FALSE(sbi_pmu_snapshot_available);
 #define sbi_pmu_snapshot_available() \
 	static_branch_unlikely(&sbi_pmu_snapshot_available)
@@ -1452,6 +1453,9 @@ static int __init pmu_sbi_devinit(void)
 	if (sbi_spec_version >= sbi_mk_version(2, 0))
 		sbi_v2_available = true;
 
+	if (sbi_spec_version >= sbi_mk_version(3, 0))
+		sbi_v3_available = true;
+
 	ret = cpuhp_setup_state_multi(CPUHP_AP_PERF_RISCV_STARTING,
 				      "perf/riscv/pmu:starting",
 				      pmu_sbi_starting_cpu, pmu_sbi_dying_cpu);

-- 
2.43.0


