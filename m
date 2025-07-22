Return-Path: <linux-kernel+bounces-740115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF66FB0D026
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 05:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A85D73AC4DF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 03:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5534728EBF1;
	Tue, 22 Jul 2025 03:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="w68NOB56"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DEC28C2D3
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 03:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753154133; cv=none; b=DmCMzdB4Y40Fd9vL8Skr9VRJh+w6D15vOu1MsccKA8ynLwK8tBk+cCBnELZVaFtpOxFjg1HbWLpBTdcLBPoKAk51lkwkb4FepsqpSvkhO0RuMqF67Bx2ncJTGqdXQb3eceN7/bVzkv2IWYDV8g9fGTfhcFMd5u6IVbtPC7mFohM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753154133; c=relaxed/simple;
	bh=MqHwXxa9SSyAxr2Hw1r4Mv5fnDVYLJpVS2ULkJu1mRU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qFmkVeZv44jSTr+IbT9gAGkv8pQymqkgCp9AJjwOQl/q1Xv6LLydDK4G9pHxJ6wd24Hs40yh9TE6xeDKrHpf56CwCkHEyB+qwif2vNsP4mw2Tm7k8AcRpAr3cqxx5h60wqMV1Kp5Qco3tyYE7VKInbRLnRV15OrQgYDXExoUaFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=w68NOB56; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-74264d1832eso6388345b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 20:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1753154131; x=1753758931; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SzDB3T8h1PmSiiQR5aHwi6QPgnFacs+893qWZ0jSQcw=;
        b=w68NOB566VukxOWmJF0Pvk2Jk4tg53iQuicIbSOlTmnnA9g9vsHMT5mtOVGHYgARWV
         n/PVjc8FCHCHiXOe+Ia/HyZR0CrrZuJ22yB7CfRDasHQrcdpvyMr8h3/3ODHATCR1Vh/
         KhH+ymfgvsArx39lh5py7NyoU6LBP4TbCW6xU7+nvw3eokG6VGH4HXVamFbsGlhWRvY4
         bRFx/o5HZX5xOb6bEovDb4B/iISdOu1khf4oefHeVu7CBOgqVpAVD+VnAmIAjmaImXiS
         jg4+krkupDVfNYmaaq2f6lrxmfPO+RRAyIINoAyPxa2+aoRXEbufOS+LD3bUwEV/uPDB
         rJdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753154131; x=1753758931;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SzDB3T8h1PmSiiQR5aHwi6QPgnFacs+893qWZ0jSQcw=;
        b=MSJRG+rh85FJ98+AfjykWAOcUHTqwwSMjFRoedQ7n7gdUyQxb5yzT2f0oM0pO4CTjs
         egjZqfAUyVt+s76We8GKRvjdxcqbYaY7p9qaI2ZjzdWvda5tHqps8mAxgmpOU3yEMSni
         avy2JU26t1sLBKr+aG185a+r+2glHxbWGZSrX2nPsb1jFmzv4iFGgVQA+rpYu/la4xbo
         Tvf7Zt3rzr0HIv2+Hx16V/DtybR2xYrCpMXtujrMlIZqx03CmVg6OUg7TEfuIsNsVIBr
         nWzvhUypmvVTcTyuHVfU5psXFXvUCuBmlJW5C9VC2uG0efRfjpTzDFzzxeEgHOO/7LCa
         jijQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJssFXrf+KYlTuyUUvC2aYN8X9FR96g43nxtjmIMKLQ8K1WgrE5qhu57Sx1DsSR5zJl9N5ulVcLCRvSUI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4cMTlM+VXk8i63Wu3/cebVlHvMf7RVZ2jneYaanp1LNvBaVQu
	Zpps84PSkJcrvVsWK9oGWxvHFm0hM/MVV5MvFJd2o8TrG+QHx7bNllKOdfEnvvztQus=
X-Gm-Gg: ASbGncvNRpi9wK3KcZY+W1aARXERy8cEtNIxKAKO1LQku8edpZmAAtqTahoIFZ58MYm
	+OXF2he7zP7UZug36XAYAlgE4ImHp6jM6RylHTL0Gy574/P8cu+5/WPTcP42WqJAx257oR7Aiwb
	F1qfHYcS6IW5jDrhmqoZe18AltoIWqahNWbSu1htRKTwboDIV4fJOC+gInHfhgwj5FaS0JrX5Qh
	UUHcwzAIpKlJjY7uX1g2yQduZF0GFmx3B6pp+UOaU95XU8nbsdTsVCjhy8Ik0pq1Xmt3fwij3q4
	6i0wNJpEc1JA0wkcfL4VaYgH8EJwPViP6i364iAdAurdF529snSZfioXBbTdLyKWa69AUn0anyI
	7LZ1Oomv7w4yjyVhLDftxgSwVY5o3p40d+go=
X-Google-Smtp-Source: AGHT+IFIrVKrPK9UdCTELOyVWNX8T+lBXipMNBQiQT8fVWHbL9rvRg5zysIp/cvj2jz89NoBA/hgbQ==
X-Received: by 2002:a05:6a21:2d4a:b0:215:efe1:a680 with SMTP id adf61e73a8af0-2381143ed4emr32571364637.16.1753154131380;
        Mon, 21 Jul 2025 20:15:31 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f2feac065sm6027612a12.33.2025.07.21.20.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 20:15:31 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Date: Mon, 21 Jul 2025 20:15:22 -0700
Subject: [PATCH v4 6/9] KVM: Add a helper function to validate vcpu gpa
 range
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-pmu_event_info-v4-6-ac76758a4269@rivosinc.com>
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

The arch specific code may need to validate a gpa range if it is a shared
memory between the host and the guest. Currently, there are few places
where it is used in RISC-V implementation. Given the nature of the function
it may be used for other architectures. Hence, a common helper function
is added.

Reviewed-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 include/linux/kvm_host.h |  2 ++
 virt/kvm/kvm_main.c      | 21 +++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 3bde4fb5c6aa..9532da14b451 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1387,6 +1387,8 @@ static inline int kvm_vcpu_map_readonly(struct kvm_vcpu *vcpu, gpa_t gpa,
 
 unsigned long kvm_vcpu_gfn_to_hva(struct kvm_vcpu *vcpu, gfn_t gfn);
 unsigned long kvm_vcpu_gfn_to_hva_prot(struct kvm_vcpu *vcpu, gfn_t gfn, bool *writable);
+int kvm_vcpu_validate_gpa_range(struct kvm_vcpu *vcpu, gpa_t gpa, unsigned long len,
+				bool write_access);
 int kvm_vcpu_read_guest_page(struct kvm_vcpu *vcpu, gfn_t gfn, void *data, int offset,
 			     int len);
 int kvm_vcpu_read_guest_atomic(struct kvm_vcpu *vcpu, gpa_t gpa, void *data,
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 222f0e894a0c..11bb5c24ed0d 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3361,6 +3361,27 @@ int kvm_vcpu_write_guest(struct kvm_vcpu *vcpu, gpa_t gpa, const void *data,
 }
 EXPORT_SYMBOL_GPL(kvm_vcpu_write_guest);
 
+int kvm_vcpu_validate_gpa_range(struct kvm_vcpu *vcpu, gpa_t gpa, unsigned long len,
+				bool write_access)
+{
+	unsigned long hva;
+	int offset = offset_in_page(gpa);
+	gfn_t gfn = gpa >> PAGE_SHIFT;
+	int seg;
+	bool writable = false;
+
+	while ((seg = next_segment(len, offset)) != 0) {
+		hva = kvm_vcpu_gfn_to_hva_prot(vcpu, gfn, &writable);
+		if (kvm_is_error_hva(hva) || (writable ^ write_access))
+			return -EPERM;
+		offset = 0;
+		len -= seg;
+		++gfn;
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(kvm_vcpu_validate_gpa_range);
+
 static int __kvm_gfn_to_hva_cache_init(struct kvm_memslots *slots,
 				       struct gfn_to_hva_cache *ghc,
 				       gpa_t gpa, unsigned long len)

-- 
2.43.0


