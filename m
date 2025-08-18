Return-Path: <linux-kernel+bounces-773863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C09B2AB54
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 16:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 740F9720222
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8223203BE;
	Mon, 18 Aug 2025 14:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="M98z+0jz"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0763203B6
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 14:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755527813; cv=none; b=Gp4G3Xxtm7I4kEGuJiI1SvNAdUuBf30otzN7w7l2ziwAAfimd4kiY3/XInYF4DSRVbwd2qqV4QYyvnTXguWV8Qg1Lur/8LU4R1tHeMis3Ij5bKgOBTGhnR/o3O973sn38goLwR788p1l4dlhCnOL/mHCfj8FTxsFRZG6dhn3n8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755527813; c=relaxed/simple;
	bh=xtTVVvYKRT3zqG7WMPSmZmZl0Wr4uI0gO0PQOWeY0ME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q7ahL3voUmzrUQB3dcG74ICbZRBMBx8qEeyiTj/sLj0iSHd87v5aBt6EbdqZR86MBSkmTA7oYb7vQ5lq/Z4BUNqcm3h/J8W7yWhlZzt5eHe9ObZa7Jh2KIw+/O4fQ1nyF937dEC6OwwhrwiD/ywWGzZACe5EXqsK6hXZs8HYgaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=M98z+0jz; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b471aaa085aso2406368a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 07:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755527811; x=1756132611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQbiLTQGi4sOYDMKTFgGpWiNF5qAYuHZ+4Lz0Qn0zrE=;
        b=M98z+0jzirfGUx93AjVBZtuaNzNUw5uUTzT7ZgWsn5etFkybhBnxL3wHxl2pA5gBpj
         xythucqhrSXItir9pLBzIQ2Yfx99NQ3uOc7jjVqG7tqoe2MFrStmokxE8D9Q8wiEexid
         XgQBtlq/T67DPxJJ2rq0yeTXVx7hELjGapfcYMaXNlgGG4VEPuHrAd+SSXtXXGA7/X7s
         RE/+ptRBZe0AVVLt9cBAyTntE1bZ2EfHjQmvzl3xgrV1jznuB2T+BGgNc5F7b2YqYQjz
         XKDA8toU3z67J1jIsG0kqHYHwGHAl/XVmeP/E+tqSQhqta8WOpLzqdGCoJgyUfOxu2/g
         +BUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755527811; x=1756132611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UQbiLTQGi4sOYDMKTFgGpWiNF5qAYuHZ+4Lz0Qn0zrE=;
        b=kSf10sSy997aOogBNfD2iXKIU5Ar9a1SGl0vSlp0pUlIlIU2lYmLeIKgQINDXWoDac
         vWP61jcBxzT99IVgCxIRLktJYLiwyW5pKTrAN9n568mCv/74hf/j12PNJO0pLjIgI+ZT
         1uMPGljDli987euR5Aj8Apx+DnOiVN7fxNe7KA8oKh1k1treWmMLlSSb+A6C4o6wKb4P
         7bAI7NgPAGcYzU9UTyRe1WYV7Gi92+pW3u4o6kHjGFJWV+GD8R5/CLOPWt91UVgzWxpd
         q9YqtPWYkLfKMJF8j6mz5c25ToE3o1R2cmx/haXUZRZmQoLQIF75iUMQdPszMxchsIkF
         bYfg==
X-Forwarded-Encrypted: i=1; AJvYcCW/RFpGXzlu99mIlzxqGQrUg4D9Vj9ZVoMng4Zbx1Z1FxvS4we1Sycb3RPwXrPFaKvhqlbBHFz2ZE25lLw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtb2sut6Rl3+Pg+zzVNvkDxAa4POAgEnl1ojAcoWxc05y6//oq
	kVCcrg+Tx5H1S7qcnUgSSa/jxGrZL8wrTSP6cnu1pjSmD1HaOoUX9bgysgo1/Nkim2o=
X-Gm-Gg: ASbGncsEXigt1JjNKWHmydKTLbtCbxioR7wkgvIsJi4KYj2ofs3he0KDeznQt8n4cnk
	fS7lyQostPg8wNUrk+GGbhOEpcgfc0rH/d3BXR2/OG+Iphy5N+s1Sybjk0meCz048lHuET2gRHH
	JQmgQ/t6UIjaIzK56REQuk34RUxIpWg8iRxzCHODwayiy69pW5AqeM/17zos+IhmzdBSEUrHyhD
	y2I5RD7iQEp8X9x14y7b3WumOUZTQkY+sOBa7bZsjzz+bJxNSZFIb1i0vUF1q1xpFtxO1rY4GJV
	Jl+LZgprzho3ZJyxE4P7FP+t1UBn87FDa2yF9Y3iAWIHh2Q0aueEpw6EDas7Ze+TTjwlYNm/0Y9
	kiH9ZVAY4j6xnjd4AL1zwYq+VszSdS3Ktq2Bl2txEt2dmxNY+7ubuBX4=
X-Google-Smtp-Source: AGHT+IFPjTGWX0YkyeszTwSPraUCxDH1MMY6bmni9f8pZnvxHNb7k5FK6QV/gsCMcRTABLOy2Tdaqg==
X-Received: by 2002:a17:903:b07:b0:234:8a4a:ad89 with SMTP id d9443c01a7336-2446bce41cbmr181639185ad.1.1755527810969;
        Mon, 18 Aug 2025 07:36:50 -0700 (PDT)
Received: from localhost.localdomain ([122.171.22.169])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d50f664sm81704945ad.75.2025.08.18.07.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 07:36:50 -0700 (PDT)
From: Anup Patel <apatel@ventanamicro.com>
To: Sunil V L <sunilvl@ventanamicro.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Len Brown <lenb@kernel.org>,
	Atish Patra <atish.patra@linux.dev>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-acpi@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>,
	Troy Mitchell <troy.mitchell@linux.dev>
Subject: [PATCH v2 1/2] ACPI: RISC-V: Fix FFH_CPPC_CSR error handling
Date: Mon, 18 Aug 2025 20:05:59 +0530
Message-ID: <20250818143600.894385-2-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250818143600.894385-1-apatel@ventanamicro.com>
References: <20250818143600.894385-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cppc_ffh_csr_read() and cppc_ffh_csr_write() returns Linux error
code in "data->ret.error" so cpc_read_ffh() and cpc_write_ffh() must
not use sbi_err_map_linux_errno() for FFH_CPPC_CSR.

Fixes: 30f3ffbee86b ("ACPI: RISC-V: Add CPPC driver")
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Troy Mitchell <troy.mitchell@linux.dev>
---
 drivers/acpi/riscv/cppc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/riscv/cppc.c b/drivers/acpi/riscv/cppc.c
index 440cf9fb91aa..42c1a9052470 100644
--- a/drivers/acpi/riscv/cppc.c
+++ b/drivers/acpi/riscv/cppc.c
@@ -119,7 +119,7 @@ int cpc_read_ffh(int cpu, struct cpc_reg *reg, u64 *val)
 
 		*val = data.ret.value;
 
-		return (data.ret.error) ? sbi_err_map_linux_errno(data.ret.error) : 0;
+		return data.ret.error;
 	}
 
 	return -EINVAL;
@@ -148,7 +148,7 @@ int cpc_write_ffh(int cpu, struct cpc_reg *reg, u64 val)
 
 		smp_call_function_single(cpu, cppc_ffh_csr_write, &data, 1);
 
-		return (data.ret.error) ? sbi_err_map_linux_errno(data.ret.error) : 0;
+		return data.ret.error;
 	}
 
 	return -EINVAL;
-- 
2.43.0


