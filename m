Return-Path: <linux-kernel+bounces-858360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8014DBEA8F5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 18:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4CB025697F0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA9F336ED3;
	Fri, 17 Oct 2025 15:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Of2NuEBY"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715E8336EDC
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 15:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760716792; cv=none; b=Du173Pv7k3jud5UdMVs8hni7vF4rPn2E9XvUb6QiBu/xFL54jAxltobVW9wCo4+ACfv5Ufc5rs0TAqgZ1V1kU7v9SsTUwHJiPILjKLCXA8pgFVhsPcoXFv5uzaXdRgaRNMwKoKkYnJn6rehHx3BbdW+le9p/ITD7QPSDF+JwUOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760716792; c=relaxed/simple;
	bh=TZPcRasNMeLsIZK1JLiv9Hygp+bbQA2e5mO/bhGFgio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cOxhwthwwTJGbyhIO6w37b87W4IFS9ypgVZVS1dxCRQVn02nP/gLVXrP/W67Lpy2lFhPrIREf5J/TkLsjgjUYnLTGaWCd5cuU6CGTmC0ui3jC8AWdRVYdyd1rVssOrQyOIa8QUZTmG6hFFn+tFNo02rDHGHCjrOeziWtQjJvgqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Of2NuEBY; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b62e7221351so1716352a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1760716790; x=1761321590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XGrq7dE9mGPhrWe1XWbI1ElRSHZxTOfH8a4rxkkGojA=;
        b=Of2NuEBYUj2qVwwb/HbRPJwXN3sAUM3RD4HMAWD1O3c5ZT9JMlo6TYbnF/rbwiWzkS
         6EKMOq76nbbRTMdYbH7WOWc9gJncUB6zyUyT02ltzSnSKYDvKTjyQaeEPqAQRxObTQJY
         IZhZBKcyehIXUtOTKqWbdjnwrPHwhxLRxXiIfOT5VmVSj58S3M4oGufbHQa291QVZQsU
         Q36bXNc48kPe6Fm/IEbg/571WAAH6xzueNgDdH5qOZ1PFHEiX8/EEd14yduKZX3M8wRB
         VJ+hTmVmkazZH3w+bxakpF4tNWr/3GiUIcaYoC7noBGOZFPj+EXcrVQdc/7TGWoprYfm
         VUkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760716790; x=1761321590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XGrq7dE9mGPhrWe1XWbI1ElRSHZxTOfH8a4rxkkGojA=;
        b=kQsnB4bLn6kdiOeFk/2IZn7Mgb+coWmRMWssDeKGh+lwlqbD3OJIkirYLaKxSzDEcX
         /eROAa+Y0C5KAdqIPgzSKqdTV8JF10Fj9njCOqei8ow1ymkazQOIpAv9qneUjfkO6o/z
         v0aoj2qimvaAs5d2Kx3j/8GKNkvllHhscluW96k97hDCPkyhUDC2JyyYTuOkS91K1QAE
         /HxTzEyGq2ip3KBTJOJViKob4nxro58kYs5iYIt5QykErDApg5mS1BHhMEyJ35jeBBEq
         g8EqaKgW1Bz7FKsmqjYxOTYc8x2ADx0mt1Wj8yMQ8SSVGdKvzPR1l1eamMN5dxm0OIVm
         Obpw==
X-Forwarded-Encrypted: i=1; AJvYcCW0s+z4oczYk6i8KiVKiHwVTTQ2aC4HNbFUM4aL0Qibb8QqYV38suxcgcLcU/fn43st2ag5YVMbnKWDuyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjId8koMxUZeUTaY1C+nj/7f2bvtIojOnNtxugCkiXW42Q4PUW
	gQ5QyD6CseIkYH58w3kX/kJMzeSmp+F2XoDXcy7TwKRZA5SAvACc0n7x/DYdMwKi6nY=
X-Gm-Gg: ASbGncsjVeh+weUpam4mbwDLSOThX7TC2VflqshP1bP9VIGucmeV7G0G5Oe85vISFaO
	YEkWVre0sdxdfvZqKW6vSkOBlIV0p2zHsFVN/JVtD5K84HBKB9JEqE79vybbRFNTZXybLnLxgt9
	OpgXTRc/ZSxHRalfjEO3ydQUbD+u3cemndBGUI3ovmZNRcwKhoZklI7/rkjzCuPcKNb7/L6VRp5
	u7i4ZUpC2mtssnSlqCLoK7wDJtAQRgOqJpc4yO+KWiCVBXwmdjWx4lCHGgvUY26lNtbHVjcdqpw
	aeN/VAzmw+jCXtBiqeVLIT+h1vFSS59zF3Mz76FrHWAGhYmzM6nz24zkbSxb17JQbzQiu17zRS3
	nroA1ESXTozxKJK/cPQXJWPJPgomcaS4D0xA6YGFofJjcNBS8eyx3LKuHRUXiRMeZvQt8DdT8HS
	OAo9b6eFA1b11HX/nQW4K52jV+JoE+0InHtMaVqRjiHV4=
X-Google-Smtp-Source: AGHT+IEjhb0cA2r/R2/eGguQc8wJ0VGA660zoYKsRyUrDokrj4BSrZrFe4SkzJzL8cy+UNwStJFbqg==
X-Received: by 2002:a05:6a20:958f:b0:334:8335:9d87 with SMTP id adf61e73a8af0-334a856e41amr6075209637.19.1760716789785;
        Fri, 17 Oct 2025 08:59:49 -0700 (PDT)
Received: from localhost.localdomain ([122.171.18.129])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a7669392csm151067a12.18.2025.10.17.08.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 08:59:49 -0700 (PDT)
From: Anup Patel <apatel@ventanamicro.com>
To: Atish Patra <atish.patra@linux.dev>,
	Andrew Jones <ajones@ventanamicro.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Anup Patel <anup@brainfault.org>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 3/4] RISC-V: KVM: Add SBI MPXY extension support for Guest
Date: Fri, 17 Oct 2025 21:29:24 +0530
Message-ID: <20251017155925.361560-4-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251017155925.361560-1-apatel@ventanamicro.com>
References: <20251017155925.361560-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SBI MPXY extension is a platform-level functionality so KVM only
needs to forward SBI MPXY calls to KVM user-space.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/include/asm/kvm_vcpu_sbi.h | 1 +
 arch/riscv/include/uapi/asm/kvm.h     | 1 +
 arch/riscv/kvm/vcpu_sbi.c             | 4 ++++
 arch/riscv/kvm/vcpu_sbi_forward.c     | 7 +++++++
 4 files changed, 13 insertions(+)

diff --git a/arch/riscv/include/asm/kvm_vcpu_sbi.h b/arch/riscv/include/asm/kvm_vcpu_sbi.h
index 446f4a8eb3cd..c1a7e3b40d9c 100644
--- a/arch/riscv/include/asm/kvm_vcpu_sbi.h
+++ b/arch/riscv/include/asm/kvm_vcpu_sbi.h
@@ -107,6 +107,7 @@ extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_dbcn;
 extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_susp;
 extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_sta;
 extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_fwft;
+extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_mpxy;
 extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_experimental;
 extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_vendor;
 
diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
index 759a4852c09a..37213d86c0d1 100644
--- a/arch/riscv/include/uapi/asm/kvm.h
+++ b/arch/riscv/include/uapi/asm/kvm.h
@@ -211,6 +211,7 @@ enum KVM_RISCV_SBI_EXT_ID {
 	KVM_RISCV_SBI_EXT_STA,
 	KVM_RISCV_SBI_EXT_SUSP,
 	KVM_RISCV_SBI_EXT_FWFT,
+	KVM_RISCV_SBI_EXT_MPXY,
 	KVM_RISCV_SBI_EXT_MAX,
 };
 
diff --git a/arch/riscv/kvm/vcpu_sbi.c b/arch/riscv/kvm/vcpu_sbi.c
index fd4106c276d8..46ab7b989432 100644
--- a/arch/riscv/kvm/vcpu_sbi.c
+++ b/arch/riscv/kvm/vcpu_sbi.c
@@ -82,6 +82,10 @@ static const struct kvm_riscv_sbi_extension_entry sbi_ext[] = {
 		.ext_idx = KVM_RISCV_SBI_EXT_FWFT,
 		.ext_ptr = &vcpu_sbi_ext_fwft,
 	},
+	{
+		.ext_idx = KVM_RISCV_SBI_EXT_MPXY,
+		.ext_ptr = &vcpu_sbi_ext_mpxy,
+	},
 	{
 		.ext_idx = KVM_RISCV_SBI_EXT_EXPERIMENTAL,
 		.ext_ptr = &vcpu_sbi_ext_experimental,
diff --git a/arch/riscv/kvm/vcpu_sbi_forward.c b/arch/riscv/kvm/vcpu_sbi_forward.c
index dbfa70c2c775..5a3c75eb23c5 100644
--- a/arch/riscv/kvm/vcpu_sbi_forward.c
+++ b/arch/riscv/kvm/vcpu_sbi_forward.c
@@ -25,3 +25,10 @@ const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_dbcn = {
 	.default_disabled = true,
 	.handler = kvm_riscv_vcpu_sbi_forward_handler,
 };
+
+const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_mpxy = {
+	.extid_start = SBI_EXT_MPXY,
+	.extid_end = SBI_EXT_MPXY,
+	.default_disabled = true,
+	.handler = kvm_riscv_vcpu_sbi_forward_handler,
+};
-- 
2.43.0


