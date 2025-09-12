Return-Path: <linux-kernel+bounces-814895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E269FB55A56
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 01:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11381BA1709
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 23:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C1F2DE6E8;
	Fri, 12 Sep 2025 23:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fEkd+vF1"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410112DAFBD
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 23:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757719449; cv=none; b=XYo1zzbVc29lZXDY/PyOo5tntqvLJCcfKjOXDkoHpQVMBeOh5vu7iNVAjDKa+ZveqxUVSk4lfPNgIxoB42GRfmJfjnEYdoXbzgfMEjM7FoBIuC0Xxp/I8y8io7LsoCdSctG7RKN/EML+EtSUCh7lyUYGIewWQ2LDRLkogEKVKWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757719449; c=relaxed/simple;
	bh=u6obytA8jhs+D5XP44Ibf3Fk/tIoJ+TGc9bGl3L5dOA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eYiHA+hL0hI6h9+EzXOUaYzgxJrXY4qBuWlZjwgk+uPI4FIYO3cKerCidlVKwnl6xzkTnNHo5GP24DsVkcFcAvxUB0WKjKHe4U/2UtgqioxyNTZJKg7wW93a7q2xTcw8Q74pCWh7WlJS+lPe/h8E6YdfSYgvaF+0DGnmXDNfUVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fEkd+vF1; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b54ad69f143so1604023a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 16:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757719448; x=1758324248; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=I6bEobPpCMUaQNNOaa/Shf0wUDSFQDd5DVDJT0PcEeY=;
        b=fEkd+vF1uXlXWQlL5n5rB7p6V/wmiFHeScwumb42Pi6ONvBrTX7K82Zz1i/dkG5dK9
         +BVtbHPtIW32PIv+JwN0t3n9aEeohMghhEE67eH5//5/nTQ0gcHBpxu+qLl1HmRjaqdL
         M6lKONCQO1vJYcjJd9bKMrxzD75LsJc8chluSjcqqYLT2hLdg7CIsYA4yFDi4zZxhZXO
         MTY/7MYHS63Nqcvypk6dwqODwOiIdHJMUoLvNA7cVVjwHJrZ9PLio46w1g7TWiiDrg4u
         DU2+eldi6IE6IQcOzeaMoO3jkEW0j/uyM1jSJ910xRnDC0rk4oRgb+aUsvCiLQd2pX9b
         KDGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757719448; x=1758324248;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I6bEobPpCMUaQNNOaa/Shf0wUDSFQDd5DVDJT0PcEeY=;
        b=cYf2njk0Z+nRdequbAON5VZm9Zka7CHLluTFDXF3LS2LuQbXGpKa3P2pSO/Q5WnJB0
         5kJUd1s1FXJhWKyxOqwf55ITPQOTJLQo1RYwQPah4LkydBfUaIHAt7ToBlY9kUb45dxU
         +G/T9B8rlqVpsVUJrWhNnawaPRZZE4cKJxlwb3/UnLqV6xufVhUGwOnojTARrfknYlRy
         73U3nO2DKWYJUNEpDp7uS7BnWyB6KF3z6GOBNCm5ntOforQd40xo83ZR5Ur3WPel5pRr
         CUwMPoxhKZBDFfe5BnsXdBtSE+zFw9kMGXfXmPm5MwD0empSV00UGTj54q/A8AMWRkoc
         509A==
X-Forwarded-Encrypted: i=1; AJvYcCXY6GIKmuaszPCFeEu6nLFRdE/Fw7Bj74B77K00dQ5y3grvBmkG6iT2oXaKJqkN5fQkhnLLYuc5oQwpIyY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9AJa6Q5B10oY64yGlD5qX/eE05psDc+dwxI0ZcX1M4ibMC4OZ
	Q8kXBG02lTAcScE6tulrn9z7JsmV/c0JvIvuypxsu8a+8PMsMJPjtVeR6X8d4b0xeIceof4EKFV
	zn4kD0g==
X-Google-Smtp-Source: AGHT+IHtj+tfTTkNWx+nJoIYfR+Z5Mexj4eaI1LLzMLxspdIKr6yZiJ5WzcH128cOWOdI+CaPgk3IhWMyJs=
X-Received: from pjwx7.prod.google.com ([2002:a17:90a:c2c7:b0:327:d54a:8c93])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:72a7:b0:24e:e270:2f4d
 with SMTP id adf61e73a8af0-2602cc1c69dmr6233860637.52.1757719447756; Fri, 12
 Sep 2025 16:24:07 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Sep 2025 16:23:02 -0700
In-Reply-To: <20250912232319.429659-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250912232319.429659-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250912232319.429659-25-seanjc@google.com>
Subject: [PATCH v15 24/41] KVM: nVMX: Advertise new VM-Entry/Exit control bits
 for CET state
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Mathias Krause <minipli@grsecurity.net>, 
	John Allen <john.allen@amd.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Chao Gao <chao.gao@intel.com>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Zhang Yi Z <yi.z.zhang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

From: Chao Gao <chao.gao@intel.com>

Advertise new VM-Entry/Exit control bits as all nested support for
CET virtualization, including consistency checks, is in place.

Signed-off-by: Chao Gao <chao.gao@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index edb3b877a0f6..d7e2fb30fc1a 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -7176,7 +7176,7 @@ static void nested_vmx_setup_exit_ctls(struct vmcs_config *vmcs_conf,
 		VM_EXIT_HOST_ADDR_SPACE_SIZE |
 #endif
 		VM_EXIT_LOAD_IA32_PAT | VM_EXIT_SAVE_IA32_PAT |
-		VM_EXIT_CLEAR_BNDCFGS;
+		VM_EXIT_CLEAR_BNDCFGS | VM_EXIT_LOAD_CET_STATE;
 	msrs->exit_ctls_high |=
 		VM_EXIT_ALWAYSON_WITHOUT_TRUE_MSR |
 		VM_EXIT_LOAD_IA32_EFER | VM_EXIT_SAVE_IA32_EFER |
@@ -7198,7 +7198,8 @@ static void nested_vmx_setup_entry_ctls(struct vmcs_config *vmcs_conf,
 #ifdef CONFIG_X86_64
 		VM_ENTRY_IA32E_MODE |
 #endif
-		VM_ENTRY_LOAD_IA32_PAT | VM_ENTRY_LOAD_BNDCFGS;
+		VM_ENTRY_LOAD_IA32_PAT | VM_ENTRY_LOAD_BNDCFGS |
+		VM_ENTRY_LOAD_CET_STATE;
 	msrs->entry_ctls_high |=
 		(VM_ENTRY_ALWAYSON_WITHOUT_TRUE_MSR | VM_ENTRY_LOAD_IA32_EFER |
 		 VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL);
-- 
2.51.0.384.g4c02a37b29-goog


