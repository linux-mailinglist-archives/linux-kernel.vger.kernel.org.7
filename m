Return-Path: <linux-kernel+bounces-825906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A07D8B8D13A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 22:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83D4C1B27434
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 20:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618BF2E9EAA;
	Sat, 20 Sep 2025 20:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="FlEtobw5"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B412E7F30
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 20:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758400758; cv=none; b=jpYVnmgHk8X1ED5zGOskhv6gL6snNLRHxzApg7pYLt6VY7D5neVvXgx2agCka+IF9fXCbJ3lGhN+ZY1bEjQ37gVQi888okjdnKrrPGz0Q0eusI8t5mfTnklYdHE/7BGt5LPa+yPNEhVE8KcNj6AcQdgdxcCaOL7S6cMQ3G9XoGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758400758; c=relaxed/simple;
	bh=KZiCU1nVn9reB0m8aW3lnYMrYjnZ2w93aVpVoIvDif0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O1p08QJAWFAQtjlOIhJ0kQ3RbEXBLN8hRMCmRP2pgD5sJuZA5guZF5gNq8ykfhQOx4gR9iazx6P9o12+2zU0oQQB/qRvpNcnTWhp9JEsGpggeRuNemzi2vHI1IZxfKn1X4NknIGuDI9+ZRSRps1PxhXhhGroPjtp0l4J2HByMWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=FlEtobw5; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-4256f0fac67so5298565ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 13:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1758400756; x=1759005556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EDiaVjHF4kERpiNA+aqN0eX91N+wRKnw/AH6MzFfvy4=;
        b=FlEtobw5uZqVPmSoDwj3A90vj0pHNxTboIFWswXP+IyLOs5+UUzeo09UayL1Y8tbU1
         Hd6BAgA9FxT92rMgG5p3h7oUMEYqKpEtaA34d/jl9jgcsAXepRTvlzJrqyxEvkMSvUyB
         VMeR/1LDPpcwhBvqJLcRG+sxshh/BbPlJFNJx+C73b3kVXAMKwYYjZPceEj6xsQLHJtS
         h4NU3YGZVQpQAQsX6lzqbJS1Itokl0Hbwkih6eCXqOYtycqgQm5KCk23TeTYAZnC4fGy
         70uTg+VHuywcapCWoVdPUPa69RS4L8sIYlX5+484w0tlARilxwMu+qju8WfChcM+0tQu
         CZgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758400756; x=1759005556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EDiaVjHF4kERpiNA+aqN0eX91N+wRKnw/AH6MzFfvy4=;
        b=YwoeVYNnF8PRFvCM7ppZoz9yqKMD+cG/4VJahT/7H3HgxQ8NqcViz8eb3Pxj9SHdoy
         2/ENoknRLPYaTim41a2aaMZRMxXSMFiFYQrvS8z4M9g4SKdWgvInq15vfrjnN5cIy7Ub
         UhOD+IsAlQ07sB4cVf4g7bM1Bmmf5o2cmKWQGwdlQbPeg3mSWakyh+8kMCyRw+dcKIDB
         nnfKMIpuEDZkuH4oZMgHf3RTD1yfBwlCc2IAYRRoranyjNIKpYuyVBRvKSj77V9ygc2V
         U2GsgFGJOhCl6bJklCsPuKaDi8T8zK60SIdlO2uhDlJPtjeEhhXVnytKDdxfXWoGu9pZ
         5k+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUimHNtfVO5ulyIroRg1+5WAjr5SUOsrpaGK6eFx07CYU8OPTDKc3K/HGdjL++PMsMpRVCYCtLtVrBLh9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YznpeWXt6Fo6MYFVLGEc96QYnQLP7S9EOu4xtyZZ1mU+O3+1Z18
	8n6KeJ7xfELlfkbJVB2HNpna85DhMXOLQ+5SJMeaFoubouyGospM66RJY3KYlgYUb8o=
X-Gm-Gg: ASbGncuUf+E2s6uXTi8wFTVjkJG9A0iHoz1Iawhuaf6kxHidIJttxMoqQc9kyabXQY8
	/jHiZ/UiU69WE8aL7m+/s+QeNYVHDm8LEb08nAqM/ZzPiAPr2gezmKTNe2n30EM4K4mmy2wVu0N
	fj3L5gibfGNg8SyfTAaynWRiA+ojZ2UclkF5ppt9JG9vfI60ew+BHRWw4wpa/uNxabNf/se/Xt6
	I9zbFgMn/gci20tqGYCS3uzly/UnPXu8tsmFro2MyB6TykzlOL0/ejDYUNQVrL5kMhGMmKmN2cA
	TbXMbfYhP1S+SrRt3QL5Pc/tJnDGRHIzl3vtjPcnu3oKSeG0T5YDVGbX7p5UA/aapMk1HW7PWx2
	9bxwxuuGs1Lb7O7kO7Y45HjGg
X-Google-Smtp-Source: AGHT+IG8Raz8xeq0QgKszu3pyBicegyYf16hU26G0T5WrFouzicPpKiOvFexp2tE8Gc55HnrfGmbkg==
X-Received: by 2002:a05:6e02:1947:b0:424:80f2:299 with SMTP id e9e14a558f8ab-424819955bbmr133419975ab.27.1758400756210;
        Sat, 20 Sep 2025 13:39:16 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-424804ec921sm30642665ab.43.2025.09.20.13.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 13:39:15 -0700 (PDT)
From: Andrew Jones <ajones@ventanamicro.com>
To: iommu@lists.linux.dev,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: jgg@nvidia.com,
	zong.li@sifive.com,
	tjeznach@rivosinc.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	anup@brainfault.org,
	atish.patra@linux.dev,
	tglx@linutronix.de,
	alex.williamson@redhat.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	alex@ghiti.fr
Subject: [RFC PATCH v2 18/18] DO NOT UPSTREAM: RISC-V: KVM: Workaround kvm_riscv_gstage_ioremap() bug
Date: Sat, 20 Sep 2025 15:39:08 -0500
Message-ID: <20250920203851.2205115-38-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250920203851.2205115-20-ajones@ventanamicro.com>
References: <20250920203851.2205115-20-ajones@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Workaround a bug that breaks guest booting with device assignment that
was introduced with commit 9bca8be646e0 ("RISC-V: KVM: Fix pte settings
within kvm_riscv_gstage_ioremap()")
---
 arch/riscv/kvm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index 525fb5a330c0..994f18b92143 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -56,7 +56,7 @@ int kvm_riscv_mmu_ioremap(struct kvm *kvm, gpa_t gpa, phys_addr_t hpa,
 
 	end = (gpa + size + PAGE_SIZE - 1) & PAGE_MASK;
 	pfn = __phys_to_pfn(hpa);
-	prot = pgprot_noncached(PAGE_WRITE);
+	prot = pgprot_noncached(__pgprot(_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_READ | _PAGE_WRITE));
 
 	for (addr = gpa; addr < end; addr += PAGE_SIZE) {
 		map.addr = addr;
-- 
2.49.0


