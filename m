Return-Path: <linux-kernel+bounces-825898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE0FB8D10A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 22:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04601169255
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 20:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7702E0B59;
	Sat, 20 Sep 2025 20:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Se3l/gSg"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0A82DC781
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 20:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758400748; cv=none; b=tXWTwwJ2oigR6BstM74tspEjTIAmdp1MoM06omtcMMNYO0UARYTwoB2PW3ZdIHIxBZgvqrIJi0X6wiIvFs9+XgYjOi1H8q+hSmM+pEIsr/VkQ5qx7PP6LSkBG/0RJ5g//a9k+ai4Ngjp7czQfnR6vUQzbBxK7z1EdE4Jsfi+qKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758400748; c=relaxed/simple;
	bh=tTMgpRJRAH5vDgnhSX3ZRgd44nfq1rpFBPS4f/QxglI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cYfXcFQ1hkGveW5ziFC2KDocpbC0coZnc+XQfJGhiXCktAuYMdtThIMishcHKdISRAk3ozoU8q8f0dSokoP6CrWrZ5v7ZPzOpDjneXfxLp2TKAZlQQmZk08FwMh9/YbZ03WyPX6TuCTjS++6NBR37WlnT0VAWEJhn4G8ANDOg1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Se3l/gSg; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-42571046185so1667745ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 13:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1758400745; x=1759005545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WfEiik7U1UfCLLRy1SfBX6A4ZldZkp0tuNOLkoczFfo=;
        b=Se3l/gSglcRTnjswM51KDYs2LchjfnohP1LsfbGyVgnl1+ZN9ThEfHCDobmES1cEs8
         8pyLiJmhKRbxRolXIZuEd8oUnZB/G81ipSIpr4jddGiwAJHT+uBXSC5WGSoJlB+eM0Je
         Yh6mG9UbhpkZeSwk6XDRfCaHHUWE/iIJkU9kRVb25rZkwY8wr4Nzw6tyL9kmRWB3hMZ1
         OxRcRC3GEJViZP1PTm89MMaXziG6KKApbrITMvqpGVbXT56QUhPtF1DbTOZd2LcGcSZ8
         jeuubM5YfE8BfQW79Gg0mgelD6a44009n0O5p+O6DNK7fpGIwQxAMKXX8opKBzofU4O2
         4CMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758400745; x=1759005545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WfEiik7U1UfCLLRy1SfBX6A4ZldZkp0tuNOLkoczFfo=;
        b=qkoeD25IHFr3B3IB8sIx9z3Wcl8A/6hfTlyAYUajXnzF5jjpgUrOQnQfPSI2Zaodyp
         SDucgLB3EunXOrErtcv/MiwXcdhxPZL9B2WxXNKMNgumRXKmPSII3at6SNYlx27DekLi
         YeCIj1qCJbGL6LwvCJBR6j0+JQXgkzSC650liReZ9rO2K5OOnxuW4hrKjuRlxzkvtgtj
         0/JUuSGXQgfpWuk1gIPs57ta8ZIGMkoI7BvzFAjvW1qFMvPpgQfZ5bCOSVbqRpOdQ5ka
         ncmoJHdgjDGC+XaieFFpjAu9gqHTxghEACa1PC0daGz5x7CsAIVW637wR2leMixRAFSP
         CuUA==
X-Forwarded-Encrypted: i=1; AJvYcCXUCnVXB7c2XZpq1R58mczSVnz52kokeTcLCuu+3D0h8EmV3+JOhJbBzk8HzXgfCJGL6+5wpRLrVBWs1MM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyybRMv9K0qNNesmG9OjPAkLTPaX/qa7BJ6sZcd26LDWsh0Dks9
	NfgfM71A/x23XU944D0uOCONolJSOvyYrVa5cM4TigHa16N+qlqbYMJcfH9L/Xb/bKY=
X-Gm-Gg: ASbGncsEYOa2XW59YbpqyLbTzG03PFpCzaK2gpPjh8EAba0EF5qoCqW24bU66h15qsN
	xvM0Qd64cUGthLdwc3kgIFaOScUYLChAayBPbd/JEdjoP4RBR4ytQsCt2j9eXSi7Xas6f5IBS8b
	E+xgQxQF4ASsi1o6zxiYelK1aMWarsWC3UlLvJib3pxHCeEhQZj48dEVMnci/2ub1+wTMUEMQzZ
	+Vm54bqU9HTx4qP+S3utPlufvOeHddvoHiNcLqCETp1LMmSd+Wo8DXhhWrDt+7DejrlsB4TY12Z
	0ciFN5ejnfrr00+/V+3njhliF8pVtlDNmOQF9/vWnupj6q3EvIAYxwuMjoUZwNWqlM3tLMClvGd
	o9Ztne9VnNRgXrv/tAytAO2o7
X-Google-Smtp-Source: AGHT+IE581P0AkyphXbszugWZqZNJhwWmOr5TRI9ATozw6M+qkg0V/7BRnonU41e1GD3hHsR2JSR+w==
X-Received: by 2002:a05:6e02:1b09:b0:424:69b:e8bb with SMTP id e9e14a558f8ab-42481936b23mr116504325ab.9.1758400745560;
        Sat, 20 Sep 2025 13:39:05 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-53d3a590fcfsm3682210173.11.2025.09.20.13.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 13:39:05 -0700 (PDT)
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
Subject: [RFC PATCH v2 10/18] RISC-V: Define irqbypass vcpu_info
Date: Sat, 20 Sep 2025 15:39:00 -0500
Message-ID: <20250920203851.2205115-30-ajones@ventanamicro.com>
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

The vcpu_info parameter to irq_set_vcpu_affinity() effectively
defines an arch specific IOMMU <=> hypervisor protocol. Provide
a definition for the RISCV IOMMU.

Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/include/asm/irq.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/riscv/include/asm/irq.h b/arch/riscv/include/asm/irq.h
index 59c975f750c9..27ff169d1b77 100644
--- a/arch/riscv/include/asm/irq.h
+++ b/arch/riscv/include/asm/irq.h
@@ -25,6 +25,15 @@ struct fwnode_handle *riscv_get_intc_hwnode(void);
 int riscv_get_hart_index(struct fwnode_handle *fwnode, u32 logical_index,
 			 u32 *hart_index);
 
+struct riscv_iommu_ir_vcpu_info {
+	u64 gpa;
+	u64 hpa;
+	u64 msi_addr_mask;
+	u64 msi_addr_pattern;
+	u32 group_index_bits;
+	u32 group_index_shift;
+};
+
 #ifdef CONFIG_ACPI
 
 enum riscv_irqchip_type {
-- 
2.49.0


