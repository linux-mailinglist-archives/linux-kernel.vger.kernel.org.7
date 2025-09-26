Return-Path: <linux-kernel+bounces-834354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76061BA4843
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 17:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE5F11C06550
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 15:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4A32253A0;
	Fri, 26 Sep 2025 15:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KQGErAcX"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E8B1D6195
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 15:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758902258; cv=none; b=qAs8EKRqvXIENfUubmdMJvp9SA+iYGutLZaNrpfTMAihdjqdMZNrPb2pWdGu7x2z3Lt4H9CNfOHuA9vyJS6wDWXokrINqJJRHcS9S31updhfCGxCR4sCsoWcAgU3AI7YraJSAnkwjSAmgi3Bj8GSFtqgyCTZklSNC2zTg6t0Xdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758902258; c=relaxed/simple;
	bh=ECLlIpH3f0tmfwTuHKFged4MrFHa2zBFDx3QZkLLNT4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iKylVSjRAaE3blhunVfw/3d12T9f9ITC2HRRw6+CUaG+CGcy73V/kzy4UxaNTitTl4C4IGua2C5ki1S1sHkIob+2QN3Yhyi0831KykJ1Cz/LGykAzokMQxgor7rzTi4DhnI6lDGTf1Q0sJvBu5prw6llfbwZgOZmUOc1PIeiBIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KQGErAcX; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b33d2f0f5f4so370975066b.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 08:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758902255; x=1759507055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MnCYIxbhfqhLOYxe+K+CHs0locV4mStAOU9WPUq7DAo=;
        b=KQGErAcXS2uX0iiEVaA7r+M1Y94gM4PtQXQtfSe9ouxX0bZXoMoDcSdXfjBY1R61ms
         5LCrxGWHreJAclq7yoCe7kZwIEaI2pl3hM9r75+vdB0uv3uTnZjW8nOhJcjykDWaJjvP
         A5BtRHtR0JKeDdxKWqBrfchYAu4Y5oVuQeL0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758902255; x=1759507055;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MnCYIxbhfqhLOYxe+K+CHs0locV4mStAOU9WPUq7DAo=;
        b=e9WrB1ykZzBf0Pwtw3cvxoW8PQnmVd7tjT0SX7ngzpKTOLbWkliQC7wNOUAs8MdRfi
         amJiXUPUTT+pS/rxERVTXPJt6uI5+lfX7JW5b7/DV58u9dGEp6zLXTzJ8WFGBg9muRBo
         Mg5dpJ0K9JAf4J2EDmCScb/ZhIK5sQLh0MYiLa8K9heUnXXDHApwTTaFXcxI2nG2vLgh
         nuIU86hlAC5lqtwd+FaKoXHj09r+vKzhnCILc5SRJjQBC8Je3BdMaT2uHqABnD+riwSk
         xNTcOMVRz/FUo7Q7vl+h414skIurTHD6EaA2YwG838Xa6mrVG7YXJopCcXjkxHQKK03K
         zfrw==
X-Forwarded-Encrypted: i=1; AJvYcCU5SD7CNIJU5fPDgUg1BniOthz2j3Mt3tdhJcKRlTawYJKw4zLruws375pOrcJR5dX1ibAsDGmuoa/UXh8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRCT5CMCcq8BVx2yCwvJD/Eqi/VvIdqpc4ikLfKsPltd6Oql1E
	hLTyjg3kPY1EPv9aczRfxi+rsOpSwliJYFZjB4wx5ru0X62NjiS9+5T+2gkpdRgzmQ==
X-Gm-Gg: ASbGncsfVcACmHBzudr5y11lj1Ck6npuj2ot9TPA6J28lDlC4bZ6XoQBCvC6o2tsUj7
	8Zt/s+RcsRLgWx1VbNuFwflgl2bGkmyZsdzW4KxOAzJwC+vL0FVDvu3WWo3Es913n4CiGNQ1UZo
	TNf4JJDCBawQYAVk57mWUOHqBIYdZj3syqukC5GWz4bbJABdShv2KeNLEE36di2lvnZimPZQ9Ep
	pYVyYCu6EhJrEl89xVq/7wZQllNrQH4aRLDNOkxR70MZeIoa7nTd4iMOasWX1XEMo+Gw/RFuA/B
	EHIvgHhySYtISLM+FrhWzfQ1oq4qdEX20HFsBhcV/cErixBPqFvlwWYfMJd/S5TIA4MOYuu7+zJ
	64O86nTGTvTRQXszN70pdyQ==
X-Google-Smtp-Source: AGHT+IFy3tXeQaesLpF4f5dI7bz/wmKc1Ad6cifwbzws9wXsRPXgAJsfxHkxNMMO+uC8NB7mfu1IgA==
X-Received: by 2002:a17:907:6ea3:b0:b07:d904:4b9c with SMTP id a640c23a62f3a-b34ba147a47mr931736566b.12.1758902254736;
        Fri, 26 Sep 2025 08:57:34 -0700 (PDT)
Received: from dmaluka1.corp.google.com ([2a00:79e0:a:200:f83f:a8ff:c4f3:beb])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b353f395349sm384242966b.34.2025.09.26.08.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 08:57:34 -0700 (PDT)
From: Dmytro Maluka <dmaluka@chromium.org>
To: kvm@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org,
	Dmytro Maluka <dmaluka@chromium.org>
Subject: [PATCH] KVM: VMX: Remove stale vmx_set_dr6() declaration
Date: Fri, 26 Sep 2025 17:57:24 +0200
Message-ID: <20250926155724.1619716-1-dmaluka@chromium.org>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove leftover after commit 80c64c7afea1 ("KVM: x86: Drop
kvm_x86_ops.set_dr6() in favor of a new KVM_RUN flag") which removed
vmx_set_dr6().

Signed-off-by: Dmytro Maluka <dmaluka@chromium.org>
---
 arch/x86/kvm/vmx/x86_ops.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/x86_ops.h b/arch/x86/kvm/vmx/x86_ops.h
index 2b3424f638db..48a888fa71b3 100644
--- a/arch/x86/kvm/vmx/x86_ops.h
+++ b/arch/x86/kvm/vmx/x86_ops.h
@@ -73,7 +73,6 @@ void vmx_get_idt(struct kvm_vcpu *vcpu, struct desc_ptr *dt);
 void vmx_set_idt(struct kvm_vcpu *vcpu, struct desc_ptr *dt);
 void vmx_get_gdt(struct kvm_vcpu *vcpu, struct desc_ptr *dt);
 void vmx_set_gdt(struct kvm_vcpu *vcpu, struct desc_ptr *dt);
-void vmx_set_dr6(struct kvm_vcpu *vcpu, unsigned long val);
 void vmx_set_dr7(struct kvm_vcpu *vcpu, unsigned long val);
 void vmx_sync_dirty_debug_regs(struct kvm_vcpu *vcpu);
 void vmx_cache_reg(struct kvm_vcpu *vcpu, enum kvm_reg reg);
-- 
2.51.0.536.g15c5d4f767-goog


