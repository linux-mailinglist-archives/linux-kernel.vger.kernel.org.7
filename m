Return-Path: <linux-kernel+bounces-882321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FA1C2A2F2
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 07:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67F89188AEB5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 06:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2CE296BA8;
	Mon,  3 Nov 2025 06:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxG98CUt"
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AEB21578D
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 06:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762151320; cv=none; b=W7GFyjM+sAZWf7dQXfWBsNv/OgI94NucdTON7FAnxD2pq8eW+6vBmA1emi8DoJimo703j0pljQsS8tEqbiFs77IAiCHBuZOv7DzVAOgz6U0fNekbSceY607qE/fVFOcVHnyzVkl7g0p8s64uTNjmG3MZBMEapXvEvv6rD+x4lNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762151320; c=relaxed/simple;
	bh=PfSsBRoB3TgmqwbvgrIlvWOlJprDh92dXfLoV/tLGlg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=kUrxcSN6oxspSbMuLiSUXsIKsJD/AGozr0cyxHOI9KZ8MBKUgnxfAT9+RWuJkXJSdHL0kzNS496DMzrqm6/+hU713xq015vDBPD38VVpZVEOKgVBxs2yyUFYc9mF2Owu9vxD2eO3Nne302mcP55W7IxCqPOlhPIIu+wDZYGAacg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxG98CUt; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2956d816c10so13651695ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 22:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762151318; x=1762756118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HzWLA6lM7306PSkRpZwBsCJQbgLVcWr7Jb7jPn8ULYQ=;
        b=cxG98CUt30ivJIKJgt7/dzhqgSS6q6ovGTF3Sv3LpIC8CmtExCW3+I754+K4rornrB
         /t5mI+I/DVzJr5OGhUPNH4nuaaBffa9atjTPEn7Sml47rqZcUPm7yFrce0V++RYGP+kH
         F+BSveDBbzU1Ivd0R/zYc/y5OtBcqidSmrulMhWhGPkDi6xNBeEJgvjmgIAQXep6y3P5
         JYCbplnuw5tWDVNMq+J4UCNzm3OVTsRXbBfyYTJR0vyZa23b2r+2V5Q6/eHVfJc+43GV
         wK8Nx9UsAkagZrrAD0pb4jvB80wfLRPK0wg94HMl+b95JgJgO3IbCwe4YzkUocOOYR02
         Tqhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762151318; x=1762756118;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HzWLA6lM7306PSkRpZwBsCJQbgLVcWr7Jb7jPn8ULYQ=;
        b=pC3UIzcpFhcjKm3dZz5cxO9eAbVfOsNT9bm5mp50t20pEK8/Of1+AMxMN3VRJcZtLy
         7cw/Qj3bh511zWayrGZMgHmYOjc6B0zuzXlmTMR5gixCfnHHPJKLGB5xjk3LHFSCNoZy
         zx8cD/sYV2CjmTDp52By3Dv0R16Vm5KjaNgXRrtMDOuL80Fu+27cxF9xGJfmbgd8m7QA
         wNSBtKSw3sB7rh1bFgDLf9/hhI/GFe0m1noL/0cEEcrXSCGybEHVO2uYORdwzRP+Uo+9
         QOGCAJiKCWWkM2qXsIOPhaGueqG+0qKoy93Ge+384+Z4JsHpbDuss+S0OPdEnHuOn+d9
         y3gQ==
X-Gm-Message-State: AOJu0YzoR/fQSrkV0jjU5Tck0EB2fNcPkyVd6oCo7WP8uHqyBFlHUXkp
	rygvF8iXe4RGOhEu83VG5ct5shYw0nQCPZtYO3GNzjTXiBNd2bH/jCDnLAScPYP9M31SNYLJ
X-Gm-Gg: ASbGncvtacuH/gKQbsPNo6DG9Uai+CYuGJGvy+7YWEM9aD1NU50tlrW6NBoyrvokzs2
	oljAHxO8FNZi2mBWrwsic1t0Zm2wMg8cMhBG58SMaBF3+MqN6BZxZwFr2cFSt6qpwm+mUXj/IO0
	djTObErdP8t1DL12aeDdg5rkpIFOQ/snD7pNJ1Lt4vm6i/LA68f0R9Yt2uX3pOzm6oRrJi9raZS
	H+1RDzuF+SBMhzphVwsmTgaQ3l9+xslaIOyVboDv0eKvg4ua//D2XJq8rhdN0Awn3BGwdn2DRI/
	T+FrYFbdGUXfr3aUNQtJ0jDA8YV4+KleBMOUextkXelvT1IIB95zVFw+0iTjoGLzILefMOJ9G3Q
	luoFvMaGcbKyZ1kRfSbAu/xRJ94tl9ZZJe3YdIq/jALXmySnIhCTu+XKUZGf5FNBfcLpbnTjw5e
	mrV40ZvwfZ5kY/pU/SjF0U
X-Google-Smtp-Source: AGHT+IGieiNu6B5gkgyoDggtQ7uHFE1tUXXst+2hCFavgg4oBRkDQVMrd9IkdCDUo5boIWBJw2G0nw==
X-Received: by 2002:a17:902:c407:b0:295:57f6:76b with SMTP id d9443c01a7336-29557f60d3bmr68472355ad.7.1762151317697;
        Sun, 02 Nov 2025 22:28:37 -0800 (PST)
Received: from days-ASUSLaptop.lan ([110.191.181.52])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2952699c482sm108155595ad.80.2025.11.02.22.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 22:28:37 -0800 (PST)
From: dayss1224@gmail.com
To: anup@brainfault.org,
	ajones@ventanamicro.com,
	atishp@atishpatra.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com
Cc: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	Dong Yang <dayss1224@gmail.com>,
	Quan Zhou <zhouquan@iscas.ac.cn>
Subject: [PATCH] KVM: riscv: Support enabling dirty log gradually in small chunks
Date: Mon,  3 Nov 2025 14:28:25 +0800
Message-Id: <20251103062825.9084-1-dayss1224@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Dong Yang <dayss1224@gmail.com>

There is already support of enabling dirty log gradually in small chunks
for x86 in commit 3c9bd4006bfc ("KVM: x86: enable dirty log gradually in
small chunks") and c862626 ("KVM: arm64: Support enabling dirty log
gradually in small chunks"). This adds support for riscv.

x86 and arm64 writes protect both huge pages and normal pages now, so
riscv protect also protects both huge pages and normal pages.

On a nested virtualization setup (RISC-V KVM running inside a QEMU VM
on an [Intel® Core™ i5-12500H] host), I did some tests with a 2G Linux
VM using different backing page sizes. The time taken for
memory_global_dirty_log_start in the L2 QEMU is listed below:

Page Size      Before    After Optimization
  4K            4490.23ms         31.94ms
  2M             48.97ms          45.46ms
  1G             28.40ms          30.93ms

Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Dong Yang <dayss1224@gmail.com>
---
 Documentation/virt/kvm/api.rst    | 2 +-
 arch/riscv/include/asm/kvm_host.h | 3 +++
 arch/riscv/kvm/mmu.c              | 5 ++++-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 57061fa29e6a..3b621c3ae67c 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -8028,7 +8028,7 @@ will be initialized to 1 when created.  This also improves performance because
 dirty logging can be enabled gradually in small chunks on the first call
 to KVM_CLEAR_DIRTY_LOG.  KVM_DIRTY_LOG_INITIALLY_SET depends on
 KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE (it is also only available on
-x86 and arm64 for now).
+x86, arm64 and riscv for now).
 
 KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2 was previously available under the name
 KVM_CAP_MANUAL_DIRTY_LOG_PROTECT, but the implementation had bugs that make
diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
index 4d794573e3db..848b63f87001 100644
--- a/arch/riscv/include/asm/kvm_host.h
+++ b/arch/riscv/include/asm/kvm_host.h
@@ -59,6 +59,9 @@
 					 BIT(IRQ_VS_TIMER) | \
 					 BIT(IRQ_VS_EXT))
 
+#define KVM_DIRTY_LOG_MANUAL_CAPS   (KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE | \
+	KVM_DIRTY_LOG_INITIALLY_SET)
+
 struct kvm_vm_stat {
 	struct kvm_vm_stat_generic generic;
 };
diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index 525fb5a330c0..a194eee256d8 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -161,8 +161,11 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 	 * allocated dirty_bitmap[], dirty pages will be tracked while
 	 * the memory slot is write protected.
 	 */
-	if (change != KVM_MR_DELETE && new->flags & KVM_MEM_LOG_DIRTY_PAGES)
+	if (change != KVM_MR_DELETE && new->flags & KVM_MEM_LOG_DIRTY_PAGES) {
+		if (kvm_dirty_log_manual_protect_and_init_set(kvm))
+			return;
 		mmu_wp_memory_region(kvm, new->id);
+	}
 }
 
 int kvm_arch_prepare_memory_region(struct kvm *kvm,
-- 
2.34.1


