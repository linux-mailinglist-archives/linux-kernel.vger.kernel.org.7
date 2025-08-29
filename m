Return-Path: <linux-kernel+bounces-791940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE40B3BE39
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 16:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19DAE17CE38
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 14:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D5E3203BA;
	Fri, 29 Aug 2025 14:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="A/LETT7K"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90D73203A4
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 14:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756478494; cv=none; b=Ozb7UsQjlo3pvDbBM4qQ3LjCQ7zQekRbofn3T7/wKELVKJOYVmXnpkxugdxUNpao5ZgKmAc16VEgnj1A/ecSoe/XyoTYyJt1kTQtuzqUFdv+bb/hXF/3Wp0DAThJXkNQUxO/FTHDy/GtFYehEECGGyy8lBOGalWJrHP9zDvvCnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756478494; c=relaxed/simple;
	bh=XThoAUpZFHs1s+pwrFwO14HP8Izu5U/x/smPnCa25bQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kGFySBS3xrwhkpaEJMVgoUA2yskbWPuL3ikjKzumMIPRgKFsOjmJjVPosU53Odqa+SKXkeCDQUOkzniD4wPC5Rs8TzlxFhxrgyklCKYyHN9FitrGZFUDIDqtfCLzY0Z2+bavJt03vDkUgxTtkSxIs4ZsB76FIfQFAo2NT+U+8K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=A/LETT7K; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-770593ba164so1760731b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 07:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1756478491; x=1757083291; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WRvT6lW8SE24T6disqBtYa/lDa3Uh1O4/DOC6STqtSc=;
        b=A/LETT7K2IPW4rW/n60t4X4rzlm1pCbfDLvvlUXpqSC/qogDARyEuDjb71VPOzUL4s
         sMxC6OdJNbqHN1E/wSJE6bbWanvHJHZW7ix+3FPgCWz2NREAlQ07eq7llEXZ95yV79UJ
         K2Y+PlneEt8QVj0H2OQsEtVbiirHhizFVHvLNqdnletBiflcUmZd01V0/7RHkKQGVves
         Js0NPUNCHIFLwPU5+D1c0lYDHinBqOgT/Z7idEbnEMb4D1GWupXq0DA/hUPlhKdtqIv7
         7eLmCmgrBOeF4Ghvjxo9asodnjPk3IjryecZxzkBHaO7ndDnwM6ywBRg+dEQX0tObjU9
         B2XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756478491; x=1757083291;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WRvT6lW8SE24T6disqBtYa/lDa3Uh1O4/DOC6STqtSc=;
        b=lnJEVJVAduRWcNDGfSzkq6zOfpvc04zXPQR6uII2d4IQJI5RposDow8W1wzYMno7UM
         dZ9qFq+F8CxVb6p1sMFLPh29f8xPX3NM2h2Jfm9yYSgXMSRUz6lioJK/2U/9hycQeav4
         jTYBjXpe0ohSut1pAbYxxY3YBZ1soZR8TXUrpMS1mDbFMn1iEcttKnedLzn/JtSpjC3H
         1fmH+H02bmsvdHNLos/esURMtjFq2mOpfSefRU5WCpCe0SqeShgS3BgozKq452d2aj7b
         vuEfGp3utx3i73TYTLNmzXNGThgmm1h6L3CPpnezE3x9Bjm6W6tDX/g+AHQl1ImWmB7N
         Gzqg==
X-Forwarded-Encrypted: i=1; AJvYcCUHRDu+US8mybgp0kB9UCuOuwFurp2DUW8yO9U4fIpiXs77YlrOFqRsmXq1nyiNa9ygj6tqBUt65CU32R4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCqxvOzLZ60iObW0DSi7CrBIQxNba7Tqq90Sze6Ft4fNJF4XMQ
	cAkYMwlZIv14gM1KdClfN5Ea0lsUJiD+j3xuDb4F0H/ElOf/RXXjclzPu2XQV1DycC0=
X-Gm-Gg: ASbGnct3JXHLzMu/K3Dr1VRDFQFL/aLiVuDgRaWJqOr53EeaV+b6a+yEETfi4PMEx/Y
	wZ7pNpjBVYchfTbm4Kw34vks2cl7iaR5m7nKAosXdUFLa7DpNRpgrreHZISu7m9IQBUkiNi1fGW
	GNC3LhR/0U/9QAS/qeXc0QzRotno4vIE2dcW075kUwqNIutAnWO2X18BX+y+QLIwXbaq3DnuM32
	cluWPnaLjVePazxTVIM3Ajt654nlPWDhwJhztkhD4pFtYsZe0NC6dXCIiqkgBUTuyxKqtfBNHuf
	TGUvFmjlcSq2TBTmAkc1K1TSS1QmoEJVOhB2bjLngDRCsUHCf9jxNx2aeC81g7DXFdzq2ltmHQX
	Mz6FTLTcwH0X1e6xPZrN4BEXKsLpZk1kk2HZPuva8CmM5lw==
X-Google-Smtp-Source: AGHT+IFDBhv3MLTcxgH+II4bHiTtnlUQ3Qi3MwL3+YWiPJW3Bh7QRSHoNEvUKcz9tZC69e4QqkawWQ==
X-Received: by 2002:a05:6a00:9a5:b0:770:374c:6c55 with SMTP id d2e1a72fcca58-770374c6e1amr32573308b3a.31.1756478490940;
        Fri, 29 Aug 2025 07:41:30 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4e1f86sm2560999b3a.72.2025.08.29.07.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 07:41:23 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Date: Fri, 29 Aug 2025 07:41:10 -0700
Subject: [PATCH v5 9/9] RISC-V: KVM: Upgrade the supported SBI version to
 3.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250829-pmu_event_info-v5-9-9dca26139a33@rivosinc.com>
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

Upgrade the SBI version to v3.0 so that corresponding features
can be enabled in the guest.

Reviewed-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/kvm_vcpu_sbi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/kvm_vcpu_sbi.h b/arch/riscv/include/asm/kvm_vcpu_sbi.h
index d678fd7e5973..f9c350ab84d9 100644
--- a/arch/riscv/include/asm/kvm_vcpu_sbi.h
+++ b/arch/riscv/include/asm/kvm_vcpu_sbi.h
@@ -11,7 +11,7 @@
 
 #define KVM_SBI_IMPID 3
 
-#define KVM_SBI_VERSION_MAJOR 2
+#define KVM_SBI_VERSION_MAJOR 3
 #define KVM_SBI_VERSION_MINOR 0
 
 enum kvm_riscv_sbi_ext_status {

-- 
2.43.0


