Return-Path: <linux-kernel+bounces-825295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5FCB8B81A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 00:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7F52188292F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 22:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E702F90DE;
	Fri, 19 Sep 2025 22:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4QTlCx8A"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A97D2F7466
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 22:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758321229; cv=none; b=OAsDx+Pq7eqRfbFgnWTGsDaz9tPbzt3gH6ewXDaEAdI7A3MpZC3OHkV02nIsBTQBnhRqBA+9F0teZ/YpRudlxt96FbMcI/1Clx7xWY5kJyErGP9tVV/qxPee7Xqr6Gv2KMPoQGg2oEEptqJo4YtEFcC478OQe9Lkil0E5BiUYGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758321229; c=relaxed/simple;
	bh=YXWxcN5ooFHzqnHIABGYf8Ki0nUZbdPJHRUwd/y69Sg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZJ2uriONA7zmPl/OZDxJVzF3SBb1rSzUawdj+LoBXuqBCFt+VFQhu/0/bNZw5rYxK5L5vYB8d2DtcvTzgyji+ZU/coH9iF2m1OHcBY4Sobu7V+s9y0TQHsJJPt+uuZZuaNM5/N2R6RMMWz7AIhBskeJVgIoOqT4SG3sR9XrxPaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4QTlCx8A; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-77f18d99ebaso190987b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 15:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758321228; x=1758926028; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=oawoE6LRs/Nu1QjyiEx29qtiXpbR7RT6KFUgBZxZwV4=;
        b=4QTlCx8A31fyzt+7lNI+vatJqLddodmJHpWdBbhpqZMbX6N5BVUiRaDBkZkErDM8JV
         h/Yg4vqRNiaU4c3Gjhsrf93lF6LVM+2vvW6wanS3QHAKWG5Ewat9wDlaEHUK//bQtAcb
         QsOh/+KPbEpSeAZrCatAG0NiLr9tSfj4kZQw38bzPh/5YBjqpxxJrgZ35h97IdVmAwvQ
         fgbY5HOzM6k2CmdSL1f4TgPwH/g2qjSS0S95w0Sr3jj92Sck15OoOWny8rtXHbG5iSlP
         gsvhZDMuqMTQelAcCP8sbwASpPPo5i1x84fH5lR+pwD5TCQHLC9+fxr0S5MRd7uE1c0I
         k6dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758321228; x=1758926028;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oawoE6LRs/Nu1QjyiEx29qtiXpbR7RT6KFUgBZxZwV4=;
        b=T8MUS/uShzCWbxnY69TKVxfhByO9MwX/VAVhuODYwb5Je87SiCrHum1qOaXamasEI1
         6ufoi3M7m/LUppG9QdoS5hxYhMBrJ0inyRK3REnLpjslJwaTz1tuGSqKaEvnRfCF1Y/U
         Cr6pRzrFF8Bh/jzO8cf7WZpoeLv5c4LZe7IG4Qh7BTcuuKDGLQ9ZsDbEs6L2t99XCXTR
         /ZCcUlWAU7sxAT82p9gC1FppDuZD9/8Dop64kY8dI7vCZwEZlFKSVI5XTemVJtEGZUz+
         1FPe57PoJdr5+1SGlJ3dwp+xQg8GbUuSBO5FXqfTpDW8E2TFSfBMxiAIJ0lOFAYkexZU
         8kyg==
X-Forwarded-Encrypted: i=1; AJvYcCWloRruzzEVUhi5HALE1aVYD9XrGwhuu4+bxKd39ab1OAXZMlUTZL5hVTY1LKh2w0UUM0GvgeXnuSoSlz0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf1BMBPsIIIOEQkTCtosNVAPWYYETmJcKMg9a/MmPSNnPp1exC
	Z6goET2CwE0ROIuWNLAi8fvj0G/8ZRKwnEzuCSaVeipJGA/kkz7SopeHPOGc2lkmQNNGxrxmAaN
	+StzRGA==
X-Google-Smtp-Source: AGHT+IFK38KbNfStRa0r2xJb1UUQc4eKGeyf9ZN8JeCGEzXGI61Mb/D8u/wHGdl8K0ljHHIEwrJT9LOA6Js=
X-Received: from pjes22.prod.google.com ([2002:a17:90a:756:b0:330:acc9:302e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7d9d:b0:246:3a6:3e41
 with SMTP id adf61e73a8af0-2925a79eb77mr7834170637.6.1758321227737; Fri, 19
 Sep 2025 15:33:47 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 19 Sep 2025 15:32:31 -0700
In-Reply-To: <20250919223258.1604852-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250919223258.1604852-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250919223258.1604852-25-seanjc@google.com>
Subject: [PATCH v16 24/51] KVM: nVMX: Always forward XSAVES/XRSTORS exits from
 L2 to L1
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Mathias Krause <minipli@grsecurity.net>, 
	John Allen <john.allen@amd.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Chao Gao <chao.gao@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Zhang Yi Z <yi.z.zhang@linux.intel.com>, Xin Li <xin@zytor.com>
Content-Type: text/plain; charset="UTF-8"

Unconditionally forward XSAVES/XRSTORS VM-Exits from L2 to L1, as KVM
doesn't utilize the XSS-bitmap (KVM relies on controlling the XSS value
in hardware to prevent unauthorized access to XSAVES state).  KVM always
loads vmcs02 with vmcs12's bitmap, and so any exit _must_ be due to
vmcs12's XSS-bitmap.

Drop the comment about XSS never being non-zero in anticipation of
enabling CET_KERNEL and CET_USER support.

Opportunistically WARN if XSAVES is not enabled for L2, as the CPU is
supposed to generate #UD before checking the XSS-bitmap.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 2156c9a854f4..846c07380eac 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -6570,14 +6570,17 @@ static bool nested_vmx_l1_wants_exit(struct kvm_vcpu *vcpu,
 		return nested_cpu_has2(vmcs12, SECONDARY_EXEC_WBINVD_EXITING);
 	case EXIT_REASON_XSETBV:
 		return true;
-	case EXIT_REASON_XSAVES: case EXIT_REASON_XRSTORS:
+	case EXIT_REASON_XSAVES:
+	case EXIT_REASON_XRSTORS:
 		/*
-		 * This should never happen, since it is not possible to
-		 * set XSS to a non-zero value---neither in L1 nor in L2.
-		 * If if it were, XSS would have to be checked against
-		 * the XSS exit bitmap in vmcs12.
+		 * Always forward XSAVES/XRSTORS to L1 as KVM doesn't utilize
+		 * XSS-bitmap, and always loads vmcs02 with vmcs12's XSS-bitmap
+		 * verbatim, i.e. any exit is due to L1's bitmap.  WARN if
+		 * XSAVES isn't enabled, as the CPU is supposed to inject #UD
+		 * in that case, before consulting the XSS-bitmap.
 		 */
-		return nested_cpu_has2(vmcs12, SECONDARY_EXEC_ENABLE_XSAVES);
+		WARN_ON_ONCE(!nested_cpu_has2(vmcs12, SECONDARY_EXEC_ENABLE_XSAVES));
+		return true;
 	case EXIT_REASON_UMWAIT:
 	case EXIT_REASON_TPAUSE:
 		return nested_cpu_has2(vmcs12,
-- 
2.51.0.470.ga7dc726c21-goog


