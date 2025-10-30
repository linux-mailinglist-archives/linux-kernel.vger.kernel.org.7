Return-Path: <linux-kernel+bounces-878375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 41711C206E8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 981D94ED76E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20B124A047;
	Thu, 30 Oct 2025 13:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="QFP0nzRi"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FEE242D78
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 13:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761832629; cv=none; b=h4Il8E+ZeW84ILTAlYfs3eOLTWCJNANE/qCPKtidLdw5p2zxpeeRoGGlRd7Bm8/TBz7JFNeqOQOcEuVwwsqGwiiXRW/IgAqOUUGhCTWkE+oo3ICbZmYyz25ZFSqqM/TYxvO6PUzCaood1/idZ5KUpckmGdiEuKpiF0AomJWoWGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761832629; c=relaxed/simple;
	bh=s5iozbZgWNVtTbraAacnZCEwXQ1F+RRaD5pBFzrjkIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LV/Dlz+ut4tvgnjAc9pI4y5saZGpu1dXBSxMlhpPMCeC8WbpG2P1ddVLORGBq4ecr5DC5wHvh29ywDmvXeBm6ZDJqBVBWsIwYxC3DxEUElWipiWeuM8LyDGKt2bqnyDlMIonl9OB5SSxN4+lvk3zUrR4vtX6tx3X8KyN33O9WAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=QFP0nzRi; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-27c369f8986so10225695ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 06:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1761832627; x=1762437427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c8VyXh52m2HmF6WkbMPxGheT256pmfI79AWNunisbZ0=;
        b=QFP0nzRiwmJbw11lW6uJCrT99+qUXIQw9kg3z6zjZOoAuQk6Px6T3Gx/l70aRmxADx
         hYeXBqZIe1sOtV192vI9mXxnpNTuWXUXenHP7f2TeTKhGNoZ6Maz9iOasAVekH2AZ1wY
         MBsA4CbQUnEU7nJobfjGeXC1/MuSDW4OiHyUxaGEpWrYbE9AReveyTXB9s9ibAQ1UbF/
         HEx7Hd4hNDmeIQPEeI/fO1E+2mBkrYJVuJtDUvDsN+X+UzuByzkV0A+1afwi2FNogY1r
         IOl2oIhINeOUnSdgls1W/NPwh0BYFUH5atw0+P4GavoDC6xmtFQsPZJAk+PyWBee+E87
         68ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761832627; x=1762437427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c8VyXh52m2HmF6WkbMPxGheT256pmfI79AWNunisbZ0=;
        b=Rv+52st7BvmmnFqrVSbznbeEJlAI4Q0KqnM9aqAPDjxjCnMlEqy3tBxK6apiJEPFdX
         h4P6RchrcPqVBby0flB5ppbawPVfRpjSQ1gnX66qOUr+B5rPWr6raFHSTIWSQy3FuQvz
         ZMHd4fOC95iV6rOkYPctiy7PXqOxc8mjLK1burufkdE6NZFTVP0ux9XglykraBBUaq7O
         Cf/QyuLiPjACVT6MkUS6u8FyjexI+YTyyR1SjBmB1XK2n0wyzdp8DkhRC/qxzzyAon7H
         0TjJSCB2Bvrxjj+xaheHeL3GMeDndc++FWcZswrTWGtVgid//CwGJX040PFO0dC/txt1
         jpsw==
X-Forwarded-Encrypted: i=1; AJvYcCXhtvrhdivxVThLierxakDmn00QIGbC1PV+WPpNwVmKdtz9ZWxioqdhbJHJ9kZTSKmRc7hYOsw8jMchEjs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP2T9ghxUXlwcpUre5dAatF/+rFGzaEz4cFvmPU1w8lhyFKGmL
	vKcNKG3NAWiISr5+pT31JfAcr9YFhFnc9aQE7bB6iw9ahIdq7u+2v2Uo2mtbAWHxtqI=
X-Gm-Gg: ASbGncvdjvviYcUPyMd0P6po83tLViUvqzrJmKwkZwxcGcWNhE8g/7tb/nEycIAm7VH
	ZOXHDvKSSwJHcg2L/XgKlyTTu8fmfV4b4fyZO7m8oJRnKslx7YOcHOizEmndjiSHa2ocZqREVnC
	h4lGHhinOYqOvHiztlKBfykfTt1TnHnlmUgk9PCCozqNCtXlrhF+YbumGlmkzhDiE8nxKk77GKK
	uP1/qQEmL3M4/RaAAr7ob3dkLAzOtWp+v0aCUVe+wN5lifphIWMju1BZsvQoPgF7qJs2G/22pvW
	OmWEdlSnh097VlZD681jhJngSDsKaIbM1JXt/GZxqOH7WOb5FgljBcW0eRrcFHOQfxKBNPN6sbm
	CJ8CqcpYpL6OPREQcNuc4JInkbcnVZUmO/qupdpbpAJPmmd9g5ZSmJZ9aolu5+OcmTE2EFS4zES
	jcgHENdXTGEyvMV17wNAhlE47hU53gpUMD/xOPQ594G0qEZggt9JSga0oTA17SmAY=
X-Google-Smtp-Source: AGHT+IGCoAuBzTrQiSWc/Ld2jXG5kw739zrV1CLzqkJDo2K/6TZfdSsStOQfI7qh++gzFJ3h/uvC5g==
X-Received: by 2002:a17:902:f550:b0:277:3488:787e with SMTP id d9443c01a7336-294dee0cebemr84296405ad.12.1761832626724;
        Thu, 30 Oct 2025 06:57:06 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e495e8sm187071905ad.110.2025.10.30.06.57.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 30 Oct 2025 06:57:06 -0700 (PDT)
From: Xu Lu <luxu.kernel@bytedance.com>
To: pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	apatel@ventanamicro.com,
	guoren@kernel.org
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [RFC PATCH v1 1/4] riscv: mm: Introduce percpu loaded_asid
Date: Thu, 30 Oct 2025 21:56:49 +0800
Message-ID: <20251030135652.63837-2-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251030135652.63837-1-luxu.kernel@bytedance.com>
References: <20251030135652.63837-1-luxu.kernel@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The percpu loaded_asid records the asid currently used by each CPU.

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 arch/riscv/include/asm/mmu_context.h | 1 +
 arch/riscv/mm/context.c              | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/arch/riscv/include/asm/mmu_context.h b/arch/riscv/include/asm/mmu_context.h
index 8c4bc49a3a0f5..fd532f8e8d057 100644
--- a/arch/riscv/include/asm/mmu_context.h
+++ b/arch/riscv/include/asm/mmu_context.h
@@ -39,6 +39,7 @@ static inline int init_new_context(struct task_struct *tsk,
 }
 
 DECLARE_STATIC_KEY_FALSE(use_asid_allocator);
+DECLARE_PER_CPU(unsigned long, loaded_asid);
 
 #ifdef CONFIG_RISCV_ISA_SUPM
 #define mm_untag_mask mm_untag_mask
diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
index 55c20ad1f7444..4d5792c3a8c19 100644
--- a/arch/riscv/mm/context.c
+++ b/arch/riscv/mm/context.c
@@ -32,6 +32,8 @@ static unsigned long *context_asid_map;
 static DEFINE_PER_CPU(atomic_long_t, active_context);
 static DEFINE_PER_CPU(unsigned long, reserved_context);
 
+DEFINE_PER_CPU(unsigned long, loaded_asid) = 0;
+
 static bool check_update_reserved_context(unsigned long cntx,
 					  unsigned long newcntx)
 {
@@ -193,6 +195,8 @@ static void set_mm_asid(struct mm_struct *mm, unsigned int cpu)
 		  (cntx2asid(cntx) << SATP_ASID_SHIFT) |
 		  satp_mode);
 
+	this_cpu_write(loaded_asid, cntx2asid(cntx));
+
 	if (need_flush_tlb)
 		local_flush_tlb_all();
 }
-- 
2.20.1


