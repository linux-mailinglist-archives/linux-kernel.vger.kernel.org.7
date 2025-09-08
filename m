Return-Path: <linux-kernel+bounces-805132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CEEBB4845F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 08:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6C4316B263
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 06:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3CE2D7386;
	Mon,  8 Sep 2025 06:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csie.ntu.edu.tw header.i=@csie.ntu.edu.tw header.b="KXaInt8h"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC172D5C89
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 06:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757313976; cv=none; b=XXmZvkXqx6Fg09AFk8coByzEOC/SoWnhBFwxcwCJx15NNQiO+/sJPsGZcIwP2dXk0RL0mItZQEUBGkiRHklWiBWT7nU08v6FYmyRmDw1o8jBHNLwPNfWQ/RfUxFb/moUjvFITvvBuD7sMDpiRpVsbufNYmBBjHjGUDcHDqZA7KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757313976; c=relaxed/simple;
	bh=J+uwgCSb716MwM+IdWxrDTwyLDESBtarqBq1Dado3nw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t2ybOWANHB0/PG0Z0ZTzlkHBubKZ6zkTpr5i+cGKWnDgOGJ99v8OaL25vLDPxc9SF4OVhxDTvmow4CZK7SbfKmha1OcJsjHpK+uNdJFL5kbVRv0mE0I1H38PZW/HoTYwffVOCupnrpcBmr/vQk9e/36+hRvYI1vhfp8lpc9uNIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.ntu.edu.tw; spf=pass smtp.mailfrom=csie.ntu.edu.tw; dkim=pass (2048-bit key) header.d=csie.ntu.edu.tw header.i=@csie.ntu.edu.tw header.b=KXaInt8h; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.ntu.edu.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csie.ntu.edu.tw
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-251fc032d1fso16188255ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 23:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=csie.ntu.edu.tw; s=google; t=1757313972; x=1757918772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X/6C0dAUyoLQyauQofbYRj/vzpgwi+DjfoZxlhTk298=;
        b=KXaInt8h6phmfF4vuwBoMjFWr/3Qt/OGsL1vvzTRjQB8TWglpfvHrvL5jrAg438D/Z
         Fr0NoBlsqcYYzBqIdVr37McFg2630Hlxcr2STN6s19XNf+m49DX77i6cdoZIpgIYVoWV
         zuY0VnGalGEP2dRuUlPKdtWYP5CKimtVz+7HUYfX61QGPDfsM9wqMQTkoJYr7Gl8g0WK
         d5obKtZ5fh2lBTdFM3eGueQnWmLrGjskSr6ApgsOOuVS5b0OJYjKZauCwoBq0QXOfvKl
         muEummzJG+REZb8JZ/Tf3TbNVD733hiS5vPETLvQNc9/BgrROJTzIAIsFgLE5sEQibyl
         0M1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757313972; x=1757918772;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X/6C0dAUyoLQyauQofbYRj/vzpgwi+DjfoZxlhTk298=;
        b=t2I3nKlPVNJoQdXhWqwBWrXPPfGu4qk8PJLgC0mxNV5BzDUjpfjlnFnt1Uwp3M5jLO
         O/TOcSlbE8lZBVyCkhA8pyvCvm3BiWE2IPrwMLnL7rp7JD4WGhDqwmSJn4GFVUsvLiIE
         +WVyH19fvTc0U3njkB5qwo70GfdzH5mNU5Sn9sfm286Y25HdkiumaW80wtr54iculgDK
         o9B4KEeZnLUCVdyldXJQDViCLUqvovem2X35GIiBQ+UoaugNoidhd+trat2F8521KE72
         k4AJAtyjVGSvlE7F48xMJKlrQ7XMHeGSJLl8TPgGZxNJkfCkGD70JIDaH5OYM+MPe6z/
         DliQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+TuSD702TmHin5WjQSt0Wl6BoEFzmqZJMd1BzS1/FjZnMUHijnAqUZ0GYa/zWjR555TR3s0jyq5Fz464=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRVuN8hxerTWbIYcDMe28LWK430rMc8ePwbv+4jY1kYigm53uR
	sm/tngd7JVPlv/az30YOJ+zb0wyLN+Wb2xIHXKsd6h6PeBu3r5jNSH+pi9sMNvJ9/iZCP/+iUvJ
	LeSdqTN6SCyI9KaivzyBw2AXQzt9fJRDdp6cdkQoKGYjRjI4Yo98iEcnCGr4=
X-Gm-Gg: ASbGncvVLnI3KpGWU387DN+GPxFLR1iWUWa41vh0hM2gmpBPgLNDUI5olb5uOluk59X
	RtCM2cWs4ljaVRByyatRcWzgr8ME+kbUl58xV4BTpV9EB3vFWGxjul+3MJ5pqU6swbM0Vp9fqE/
	zwxQuVO6S1fsBBOiM/v64pGLDiRksC6UI4XDUGYzDQ+wvpgugeewigq/iPZ3/lksoE9XPzwwUB1
	5ykK7Q+MRXObVG9IB59hTY3O6JYsb1W8rzDyJaHcAJ1srP7fi7TkhWFQN4QoaS0NH5sGgCY6sRV
	dKIVj5qsD3UAkvy7QNXNKZrcCOPuw8/k43dQezgh3Fb/cTYDHOVTpJeLBpYFU7bDH51jbnu8+0H
	s12xMm8WAoHWyrN5MXkNGX+k5oThi3gkO27u/Auo/HSUl2+xFggmu6jhKDr41o/+OT30pgus=
X-Google-Smtp-Source: AGHT+IEQZar8WBAOm85u+suoluGDr+DTtstTbqs6dfovDku4FTi9XGSytpEOzcrDiccqig50y3evvA==
X-Received: by 2002:a17:902:f64e:b0:24c:be1f:c1f7 with SMTP id d9443c01a7336-25170e4187fmr86761255ad.39.1757313972470;
        Sun, 07 Sep 2025 23:46:12 -0700 (PDT)
Received: from zenbook (118-163-61-247.hinet-ip.hinet.net. [118.163.61.247])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b5236338fcasm1574671a12.35.2025.09.07.23.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 23:46:12 -0700 (PDT)
From: Wei-Lin Chang <r09922117@csie.ntu.edu.tw>
To: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Wei-Lin Chang <r09922117@csie.ntu.edu.tw>,
	Will Deacon <will@kernel.org>
Subject: [PATCH v2] KVM: arm64: Remove stage 2 read fault check
Date: Mon,  8 Sep 2025 14:48:06 +0800
Message-ID: <20250908064806.4093081-1-r09922117@csie.ntu.edu.tw>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Gm-Spam: 0
X-Gm-Phishy: 0

In the non-NV case, read permission is always granted when mapping
stage-2, so checking for it doesn't bring much. On the other hand,
shadow stage-2 for NV guests could potentially have non-readable
mappings when we align the permissions with those that L1 set for L2, we
shouldn't be checking for read faults in this case either.

So just remove this check.

Suggested-by: Oliver Upton <oliver.upton@linux.dev>
Suggested-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Wei-Lin Chang <r09922117@csie.ntu.edu.tw>
---

Changes in v2, thanks to those listed in the Suggested-by tags:
  - remove the read fault check instead of skipping it for NV
  - Link to v1: https://lore.kernel.org/kvmarm/20250822031853.2007437-1-r09922117@csie.ntu.edu.tw/

---
 arch/arm64/kvm/mmu.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 1c78864767c5c..fb239cd9f7a67 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1508,11 +1508,6 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	exec_fault = kvm_vcpu_trap_is_exec_fault(vcpu);
 	VM_BUG_ON(write_fault && exec_fault);
 
-	if (fault_is_perm && !write_fault && !exec_fault) {
-		kvm_err("Unexpected L2 read permission error\n");
-		return -EFAULT;
-	}
-
 	if (!is_protected_kvm_enabled())
 		memcache = &vcpu->arch.mmu_page_cache;
 	else
-- 
2.50.1


