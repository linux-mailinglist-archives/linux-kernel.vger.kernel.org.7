Return-Path: <linux-kernel+bounces-741313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B19B0E2AF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 19:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E97E7A73B2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 17:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8E1281341;
	Tue, 22 Jul 2025 17:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="SP3nOb1G"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFA3280330
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 17:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753205920; cv=none; b=RUzyzdooeWkOdhb6SrlKKMc/nEhEu9M/dNslQk4s7DNeDxLmldsMJlkY/G5UKVeLJ0cEV8MBUkBczT9SR5PdrLaQwljFJy9/izXzeZ+InhXCIoJ3kb6tIZ6VNcRdlxHL9ZHnJp61eMm2FZDAiSPrqFTfOVCut55m52G/WC8Tnmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753205920; c=relaxed/simple;
	bh=Yqrau/0pHwWcYxpJTRYRGqV2PXfF/+2IqvWOBxUtYqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rw4EbRdgH1Fl7yXQvUFne9EFEvaqA+VtekG0LXruPt/2y9cOY0H0kxwix1afL4W/Z3BrtDlN5KAH0JrEc4H/vsS/MZqhiRiclUwmXFdC4LRcHYrm7YhXtO/+e3RZci8IAVv3XyE/WNAnpWVfrtKJFfubQtfvKUuZ2s2c5u/YkEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=SP3nOb1G; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6fafb6899c2so1666806d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 10:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1753205915; x=1753810715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G0zO9q5RHjrpTuBAsZGCPwDy4LSegspYm+5gaPuuIvs=;
        b=SP3nOb1Gb6ORDxOWg7ob7KjXi689yjJzx2UKk5sEH2huJKBDubueqX8x5+FGEAV9Gx
         S+K00tjmZfZCA/EX9dhSKlJ6eeC8P1Wr2xTfiEj6bQw80n4GZpL322rmO1Ae/VrrT7ZK
         azcFG6EhJCZjw9bzR0iPLimBDMmyAYxtLFOU4Cn7IObfE8MCEnfvPHADY/BbxqKKPxAJ
         StTCRhNEbsBXhFLdvYN1Lz0JqDKHak7Q6tFnbNX3X64u5ItJ+AXVhz7WjM/R6OzBkyHE
         JScmZ2E+0fiaLaRfWm7lKnK4BJSW0BcLVT5Ysy2rFxBMBOatpq++vvO8GGpl8ZNgHxsR
         lQgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753205915; x=1753810715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G0zO9q5RHjrpTuBAsZGCPwDy4LSegspYm+5gaPuuIvs=;
        b=ukHcpw16/vWjaChPNtbrXkINWYXUOJjuH6poPp6z8bVV4e7XwEIJvf6N5rOI7L4SyQ
         NWMDWbcW+s3w8oo4089f06+SLxY9jD3KuVOoF5TX9QkzuZARD4yUnghKxKsalRWh/2uH
         4NxzG50znN2VQFtX+H3u810MQpE3ooxQ395T05CuVTYslooxGzj2UIFi/V7cpPJz6Iqy
         RrQWbdZll8rF2j5BjY2gg8VuA6NGZLacFQ5oMXYA2klyjPs2eJ553Nad4GFX7B7IYaMO
         BD5KeaG1+gqZkqGXdshzpG2Z8xaUnUzxVn3RTNljVQF3CsN4VF8bH/EQdtcBs4sbbFpl
         9gMg==
X-Forwarded-Encrypted: i=1; AJvYcCWB2B3Gq5rHz+hS3jLhupgQXoVawSwKyBeBPYkJEHC+NkKCJ3lZCk904mi/n6d6xjwmRarDejM7U2NMQmc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6H4neFEEwSO0f9d2qe8GFF0BN1AsVzI7UY4oBD77dzVrGXmWR
	7xLudypU0PUDtoz1DmZqcp0yR0i6DKfycemty8FivJpMOsSMSALBm7Vuv8N95NKgMrA=
X-Gm-Gg: ASbGncvfshK1XGO+n0yz2P+Ux3c7/y0vZGKz0iy2NyVNcJZwJJW/IWscVOc1jGkd+Qb
	sFtHAsTNPwquuoLk2EIfbkv2auD1BJpDMUGrxZ/2W2QI4HB+uQGbAOzISzJEGuUwuOmsIvaC7Tb
	ZgmvmjFZJTMCNVrz0bC66raeTnGU5yUGL9a0zCoPNXi5S3w2vOw7pATpWS/JzFKXV9JvAv6vmem
	ej6fPFNZQmwnsrmR/oefjPSpuQxGakqDh2VTn39Ct5In6BEBfgL1q0uqm27zIi8dzY2rzP3/pwI
	fv6W7XtWjEUWK+r4HJZYwBSl7HMmY7XRB+OsaVNNQUTXsSuvkD45JPAG6FLSoSFrdbUtI7QWC1p
	thQ+uko43HDe1tHPYu7nwU5EbkM5ti6lzkQx21MV7v5ApjA0BUG8BuiDEv96UD0BnxwIL9vNjtD
	VH7N4gkqjbD08=
X-Google-Smtp-Source: AGHT+IHCokx4YHdCLRfoDwTLrDfS3sucjtTIvZ9hf2c8wFkhh0tDPdS/VDHIEe87OwXUJyu9QNOD4A==
X-Received: by 2002:ad4:5d6f:0:b0:704:7dfa:3fd with SMTP id 6a1803df08f44-706eb692e9cmr53112496d6.4.1753205915406;
        Tue, 22 Jul 2025 10:38:35 -0700 (PDT)
Received: from jesse-lt.ba.rivosinc.com (pool-108-26-215-125.bstnma.fios.verizon.net. [108.26.215.125])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7051ba6b783sm54184536d6.73.2025.07.22.10.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 10:38:35 -0700 (PDT)
From: Jesse Taube <jesse@rivosinc.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Oleg Nesterov <oleg@redhat.com>,
	Jesse Taube <jesse@rivosinc.com>,
	Himanshu Chauhan <hchauhan@ventanamicro.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Deepak Gupta <debug@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Patra <atishp@rivosinc.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Mayuresh Chitale <mchitale@ventanamicro.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	WangYuli <wangyuli@uniontech.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Nam Cao <namcao@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	Joel Granados <joel.granados@kernel.org>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Celeste Liu <coelacanthushex@gmail.com>,
	Evan Green <evan@rivosinc.com>,
	Nylon Chen <nylon.chen@sifive.com>
Subject: [RFC PATCH 3/6] riscv: insn: __read_insn use copy_from_X_nofault
Date: Tue, 22 Jul 2025 10:38:26 -0700
Message-ID: <20250722173829.984082-4-jesse@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250722173829.984082-1-jesse@rivosinc.com>
References: <20250722173829.984082-1-jesse@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__read_insn was using get_user for user space reads and direct
dereferencing for kernel space reads.
Update to use copy_from_user_nofault, copy_from_kernel_nofault for this
as get_user is user context only and may sleep.

Signed-off-by: Jesse Taube <jesse@rivosinc.com>
---
Squash with previous commit as it's breaks bisectability.
Separated as i'm unsure if copy_from_user_nofault is an acceptable
replacement.
---
 arch/riscv/kernel/insn.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/insn.c b/arch/riscv/kernel/insn.c
index dd2a6ef9fd25..b8e5202ddced 100644
--- a/arch/riscv/kernel/insn.c
+++ b/arch/riscv/kernel/insn.c
@@ -2,6 +2,9 @@
 /*
  * Copyright 2025 Rivos, Inc
  */
+
+#include <linux/uaccess.h>
+
 #include <asm/insn.h>
 #include <asm/ptrace.h>
 #include <asm/uaccess.h>
@@ -11,10 +14,9 @@
 	int __ret;					\
 							\
 	if (user_mode(regs)) {				\
-		__ret = get_user(insn, (type __user *) insn_addr); \
+		__ret = copy_from_user_nofault(&insn, (const type __user *) insn_addr, sizeof(type)); \
 	} else {					\
-		insn = *(type *)insn_addr;		\
-		__ret = 0;				\
+		__ret = copy_from_kernel_nofault(&insn, (const type *) insn_addr, sizeof(type)); \
 	}						\
 							\
 	__ret;						\
-- 
2.43.0


