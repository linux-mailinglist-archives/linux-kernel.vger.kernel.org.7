Return-Path: <linux-kernel+bounces-832980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECCBBA0E30
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 19:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79A5E6C1B02
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 17:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DB7320CCE;
	Thu, 25 Sep 2025 17:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xYlFAF1e"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B7031FEFA
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 17:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758821369; cv=none; b=LXJQ6S5Z1HlYfJyR/i7zusoImVBwAEslcgev/NryGv4XYgaO4u7Xt4QbLNof/tJm93pB1feIuiubzH0H7sSNjTiLi3iigPZLgrZJ+J7ZgymP0TlxI5dgrTJ/GQPE2d9+FTK5g5QwAJy9WZO2bBmEIUuOjBlyC+QtNSNpgOwyi4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758821369; c=relaxed/simple;
	bh=dYFvkv/kP46uEh3pmF+KAf5FeYo5k2Exf5A9E/UqiwU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PX6A6/G/XBGIOEnBqZDkMDOGNZavDMW8SUCc3Q9IPrqg+WIHlXcXxml2g8VfrFWpx9hP29omI38+vYmQgbqa+7mveMLrPxoyqWSb2Z+QaVCRRM/XMdRokC00W4NW5hDfypXzjuI7z+QP0ps0eqVq/BYXfhKDRWln1yGj4vuO0tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xYlFAF1e; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b522037281bso852688a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758821367; x=1759426167; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oGebHjn44dF8SnIsKkF6tQFy+O1wwz15ARCChz5z1aE=;
        b=xYlFAF1eKYNDHnHf7vyZkzEzvlJzL4NjoveILHWrOthxFmg747NFr1BwYKpnB6UVk6
         wOhPfa1Y7TDbTcwInCOWCse4AX26K46qmI1HcCVU/c9R5Bkx12XQW5erjTH+8yvxVXo/
         BLvA51wGBx1vQLRAd4rS4dYSlAXThDEejJMKT2M+keeKYI1lxiWS0NHZqDbFWXjyX74p
         AZXEAgA/Qg/1EMhpiItZ4dOSxL9A4vrP6YpapY3VzPE9iY+26E87SbgDp8FAScL2n1AO
         T11CV50ze40JXl5PWMrqB1EF/8F5g6hiKhrqlGF8QXIv+uE/6QKB9mxCHxErp58XITta
         FsBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758821367; x=1759426167;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oGebHjn44dF8SnIsKkF6tQFy+O1wwz15ARCChz5z1aE=;
        b=vsSF+iki1Oxg6Wpcpylv3UMnL2fOIEh9zRlh5tsnFyBY76yybeCMnR2pCvpzjhuACC
         ZeMvtOM9z+lvEhCl9kxE/Zb2B6oasz+u+QJvCZVKktjli0Kq5fAokU2Pvv3s6lU2aDuM
         /efCMt+Q7hkYgMJJfy3srM54/XBUWdVl6lX1TRXoKeEUEHVXRvZX6h12VM4m4B9GI2+b
         Fj9TxQgnmStT4idVysrxZi2ZGZFMffD5DJdynfcM19b/efhrqaG7Hw/B4/AqMH9MUUCY
         sA5PqGu+w9haBQzPdr2vNCgjKPj3VzI9qksNj7XX7+KFlQZzPjEdUe2L0ci0NSxg/zE3
         eISg==
X-Gm-Message-State: AOJu0Ywl2Y6nHbMlFj+eJQkXiBgpkS6qesccuNePSQkkgPgVDBJEscvw
	fIDDFsU6hxssACD1XHlvaZQ2aXmUJZULKEzZaEehzaQaStM5+EH2mxSuP4HposaNeXyKIpywB34
	Q4A==
X-Google-Smtp-Source: AGHT+IFQmB0Qc6Pt6BHOi6WxFN9Xk84xHXHc9lPe2+pu/qXW/7V7Q0SpznZQK+4Toe8YWlsRbTCyi3+w/w==
X-Received: from pjbgg20.prod.google.com ([2002:a17:90b:a14:b0:32e:8ff7:495])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3901:b0:327:b2a1:2964
 with SMTP id 98e67ed59e1d1-3342a26119amr5380780a91.15.1758821366694; Thu, 25
 Sep 2025 10:29:26 -0700 (PDT)
Date: Thu, 25 Sep 2025 10:28:45 -0700
In-Reply-To: <20250925172851.606193-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250925172851.606193-1-sagis@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250925172851.606193-18-sagis@google.com>
Subject: [PATCH v11 17/21] KVM: selftests: Set entry point for TDX guest code
From: Sagi Shahar <sagis@google.com>
To: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sagi Shahar <sagis@google.com>, Roger Wang <runanwang@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Since the rip register is inaccessible for TDX VMs, we need a different
way to set the guest entry point for TDX VMs. This is done by writing
the guest code address to a predefined location in the guest memory and
loading it into rip as part of the TDX boot code.

Signed-off-by: Sagi Shahar <sagis@google.com>
---
 tools/testing/selftests/kvm/lib/x86/processor.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index f7ddea3b2044..92a9cac18c56 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -656,9 +656,13 @@ void vcpu_arch_set_entry_point(struct kvm_vcpu *vcpu, void *guest_code)
 {
 	struct kvm_regs regs;
 
-	vcpu_regs_get(vcpu, &regs);
-	regs.rip = (unsigned long) guest_code;
-	vcpu_regs_set(vcpu, &regs);
+	if (is_tdx_vm(vcpu->vm))
+		vm_tdx_set_vcpu_entry_point(vcpu, guest_code);
+	else {
+		vcpu_regs_get(vcpu, &regs);
+		regs.rip = (unsigned long) guest_code;
+		vcpu_regs_set(vcpu, &regs);
+	}
 }
 
 vm_vaddr_t kvm_allocate_vcpu_stack(struct kvm_vm *vm)
-- 
2.51.0.536.g15c5d4f767-goog


