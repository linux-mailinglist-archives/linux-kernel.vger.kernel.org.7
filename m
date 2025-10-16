Return-Path: <linux-kernel+bounces-857068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D40BE5D4B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 01:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 846504EB4A9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 23:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205E62E716A;
	Thu, 16 Oct 2025 23:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BZ15LKBe"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134EA2D7DCA
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 23:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760658943; cv=none; b=LhHJv2+MI6oAOog1NAssieqtomBgK9T18XzWRJSTjtdjlmbqAB7fKpD7tBnle/epn9WfiAMWUFRdiDQcr28qToG9f8Ii2NTLzrBaILPnahXoWh3XZYF50FbYr7NNMMxFfrq/GOMYc7UppswmeGsU46ltfCk56RJuOq3Mz6IrNE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760658943; c=relaxed/simple;
	bh=WwjO4GatRHKKUJDBAs3BruAaj4i1hqbmFn941g71wiI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=XEyVquyeJqXxOpRW5olwY3IPcez+HC+8DUVdAiQTAp1zn5viRCAwfCaqOJuIUGJk8VsuYlsrbTxFfbVSUHFrxRAIATJjYMReuH4jFbPyb/0XFg5jc6pTfl4Pkewa7r9Av30JZHiIEvStaejY0/lY3AorydrHVVpw9CKNFb4kkR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BZ15LKBe; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-33bba464b08so925372a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 16:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760658941; x=1761263741; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pPVrm5pE/FjJ1RaaLP4f68EkqgXZ2N60KkxrWhwGEQA=;
        b=BZ15LKBeEY92ify+Cxeb4qE/yuu6mWLN32WabLVpaBwKpD4rV5uZ9b4lejpAMefAno
         GxO6vlPBNqKkkv6ZumIPgWzpemURtOQomf7/CZ17qnF/rsaWlkpALJ6iX68/0xkP2Csc
         GsJOBlKiPcwqSoDhIumBwgqqQSMj3LzPJ8SGcZuQF4B74WNmjV0JBYtfgZKIfsDz8SAU
         Na2ddSIydDA8EBs6cWciCbFoCPfG16zBhYbA8GjrWPUy0eC4hJW9Hzsky1kQ3DMcBkuu
         lPi0ZV71X9q2Ugx+9AYuF4pqXOi9PrJVilgN+l9lr67QKivZRLJRSq/75QEbKgfUgQ6p
         UyJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760658941; x=1761263741;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pPVrm5pE/FjJ1RaaLP4f68EkqgXZ2N60KkxrWhwGEQA=;
        b=nbdctpotXZhjlUA9GQesnRvm25iXtlroZVclHUHruSN5ByFJyU4HPNofBVUkqPTW7V
         K+qZxmCyExPxZsub25Otaei46ZkHMJA7VXu9oYxz2L3UwNBuHSfPr4UhbghjhnT0Ns4B
         Q16IhpEJQMq33qojcV6iC8uLTY6coRi+P7lhTke4vqAUDciyMPtM29BCmYxVRyjAuN2B
         BHsUBN3tUml22CRnDZTIk61i7tGkD7o8tEehXAF8zObtOno91kE4cFwKQKorYXzCP8hv
         P7ixT/jzBlzatB7MbBnAdPyeqGrJag0g9BQtuKKfO5x7xjyQmpVLuagEP34ZNnLbS2EL
         Girw==
X-Forwarded-Encrypted: i=1; AJvYcCVCDr5+BmUi0WvuP855uC+wQJX80inAbfCpM4gIKgWsvfMlImyCtH99PzpUzMVqdTOQI59hD7qrTwr/bbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFVROAWHeOofpag9MJuXWbO4e4k2RJBSo8cVpDuvXVFhiWahX2
	HC80nD35G9F0jMkp29AMtZZCONWl65BRKCo+RCa6ew60qRfvcmjGq6WXmWtLhmQJD9k5ouDaOPc
	TINfg/g==
X-Google-Smtp-Source: AGHT+IEubE2lA1WOXoIBHExBmIq5CuR49JO3UOOOlGoyNxR7LBrKYLkgLhfLvK7PDhIOutFTQwQ9vWmAfjA=
X-Received: from pjbtd12.prod.google.com ([2002:a17:90b:544c:b0:330:b9e9:7acc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5290:b0:32e:a54a:be5d
 with SMTP id 98e67ed59e1d1-33bcf85abbfmr1652222a91.2.1760658941384; Thu, 16
 Oct 2025 16:55:41 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 16 Oct 2025 16:55:38 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <20251016235538.171962-1-seanjc@google.com>
Subject: [PATCH] Documentation: KVM: Formalizing taking vcpu->mutex *outside*
 of kvm->slots_lock
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Explicitly document the ordering of vcpu->mutex being taken *outside* of
kvm->slots_lock.  While extremely unintuitive, and arguably wrong, both
arm64 and x86 have gained flows that take kvm->slots_lock inside of
vcpu->mutex.  x86's kvm_inhibit_apic_access_page() is particularly
nasty, as slots_lock is taken quite deep within KVM_RUN, i.e. simply
swapping the ordering isn't an option.

Commit to the vcpu->mutex => kvm->slots_lock ordering even though taking a
VM-scoped lock inside a vCPU-scoped lock is odd, as vcpu->mutex really is
intended to be a "top-level" lock in most respects, whereas kvm->slots_lock
is "just" a helper lock.

Cc: Oliver Upton <oliver.upton@linux.dev>
Cc: Marc Zyngier <maz@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 Documentation/virt/kvm/locking.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/virt/kvm/locking.rst b/Documentation/virt/kvm/locking.rst
index ae8bce7fecbe..2b4c786038be 100644
--- a/Documentation/virt/kvm/locking.rst
+++ b/Documentation/virt/kvm/locking.rst
@@ -17,6 +17,8 @@ The acquisition orders for mutexes are as follows:
 
 - kvm->lock is taken outside kvm->slots_lock and kvm->irq_lock
 
+- vcpu->mutex is taken outside kvm->slots_lock
+
 - kvm->slots_lock is taken outside kvm->irq_lock, though acquiring
   them together is quite rare.
 

base-commit: 6b36119b94d0b2bb8cea9d512017efafd461d6ac
-- 
2.51.0.858.gf9c4a03a3a-goog


