Return-Path: <linux-kernel+bounces-827617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF58B92399
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 18:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AE943A4478
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 16:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1CF311C3C;
	Mon, 22 Sep 2025 16:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W4Ol7vBy"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55704311592
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 16:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758558587; cv=none; b=nthjo2gPgTK7meOTYfSzMR8dhVH2psLw4Z3NI+MyuMWiZNOThVw4m7G31Ss65RB5mWx6bBFsNNGCbchgxdulVQslbCP15G5rkbgczNeLF0Gn4dDNkdHUKjj+jSCVRLSK8YmVeXtGInnc3eDQBAffa3LrNb57qvVL6cg90nLJ3fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758558587; c=relaxed/simple;
	bh=t52RI7t5Qv+jWIhNWUYoVvPH+4WLTE0aurBZ0jd9Z2M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=E9/kb6ruEY+u96rRBwL4HgWYJh1VbIRmrPjVfuvwMF+xNr+lHZdJT4NiEvNvoYJWm3HTXgvJZ7pCyoaxHBMqOq/jlWhYDvTKDp5A8Z3cnCCC2tU2iXqdYULbuIahp0aax2KZ6KlRhRoQKI1mMBFp8YvRd3haJggXn14sLvDqOtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W4Ol7vBy; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-330a4d5c4efso2677006a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 09:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758558586; x=1759163386; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bkgY9ceXPdaZB5q5v1VS3P+DK7qjSWQRkaXpesHzhwg=;
        b=W4Ol7vBy3M8JqtUALETuX8xwiq0dEKJbXI+b9bUk3FN40UO+/JhtC8apyZ99Nzl2gR
         rJkBWSIFDaiverLfVUjCCGKRkNaH9+ut2flta2HtVcigpy+LmUFiNY4SvdCshEMIiqNY
         5ixA/RKptooZoIM7zzPVSczVoL4VOhO+lNKkpJREXHzMTBigwzAp9b7pockMwqLKzpO5
         ewpb/cRPshcpN4gRkouv5lXwimJl1kfnTECUJr3/wvqXNjw3lS90FtmFw//vgZeMtvKY
         p0JELSW4f4k2oIG1lQ5a5tRcOe17BzlUZYcu2d6QvVn8BwHNRUU+CiBcMQBoMAjjaalM
         79+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758558586; x=1759163386;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bkgY9ceXPdaZB5q5v1VS3P+DK7qjSWQRkaXpesHzhwg=;
        b=dH6+QLCkirjgJRhYVyn3zirTq7vFjF0hPuukO6mYcN3fbv94sT4sg0vOsqz7Z4zb+i
         zYx4ozjkDTv/R7vkCRKGYQJTF/kOjQyCy8xIWlq7pxb7dqQqzCDbAD9sTXzz8eY+96cT
         QJWWBM1DJBu/L3PoL0J2KudNg7fpvKmE0rdcygTMLeHQ5/ERhAqQ9EnZPnw5jfBhguyU
         ug3ke++sxqSdKvSnApxM+z40bwezIMzOWn29VaMjRxZYDKAxgJmqIUf2fFmFZdrtTXEx
         jUky7BA4pgfeD0LTOVgzO8cvZ3ggxXPuvC3PXqlfoLe/oN/Q5kvpan3r9nD1fR8nlYht
         b86A==
X-Forwarded-Encrypted: i=1; AJvYcCU+ypk4cBd0g1HHxX3Lho6K0eYO9XuWOtkFUzchJmAHhf13uXJL1joQdqCecLU4Xp0IFgg9/cSlNEOlRMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYdW7p/4Gxas0HJU/W5AwPNlM6CaUsXpNOxmid6nwnCjsxO/J1
	X8YQczHVnYO3N7MQWxhgErCK/F+2Y19K3TFDt1M6XxWrqnvuTM30qrE+jTFG049L897W1ysR4iY
	T/+GwQPU9vUcfig==
X-Google-Smtp-Source: AGHT+IEGcw3tckWJnWAt+KDw3v1zpwJKOzPT7MsJPUPXmlWdpknfr9XxZgn+Y/Rd7ABuKyWODb8wqHIlO+Ea0Q==
X-Received: from pjbhl4.prod.google.com ([2002:a17:90b:1344:b0:330:7dd8:2dc2])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:57ce:b0:327:83e1:5bf with SMTP id 98e67ed59e1d1-3309836301bmr14749855a91.28.1758558585645;
 Mon, 22 Sep 2025 09:29:45 -0700 (PDT)
Date: Mon, 22 Sep 2025 09:29:22 -0700
In-Reply-To: <20250922162935.621409-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250922162935.621409-1-jmattson@google.com>
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250922162935.621409-2-jmattson@google.com>
Subject: [PATCH 1/2] KVM: SVM: Mark VMCB_PERM_MAP as dirty on nested VMRUN
From: Jim Mattson <jmattson@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jim Mattson <jmattson@google.com>, Matteo Rizzo <matteorizzo@google.com>
Content-Type: text/plain; charset="UTF-8"

Mark the VMCB_PERM_MAP bit as dirty in nested_vmcb02_prepare_control()
on every nested VMRUN.

If L1 changes MSR interception (INTERCEPT_MSR_PROT) between two VMRUN
instructions on the same L1 vCPU, the msrpm_base_pa in the associated
vmcb02 will change, and the VMCB_PERM_MAP clean bit should be cleared.

Fixes: 4bb170a5430b ("KVM: nSVM: do not mark all VMCB02 fields dirty on nested vmexit")
Reported-by: Matteo Rizzo <matteorizzo@google.com>
Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/svm/nested.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index b7fd2e869998..177a9764fb64 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -744,6 +744,7 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm,
 	vmcb02->control.nested_ctl = vmcb01->control.nested_ctl;
 	vmcb02->control.iopm_base_pa = vmcb01->control.iopm_base_pa;
 	vmcb02->control.msrpm_base_pa = vmcb01->control.msrpm_base_pa;
+	vmcb_mark_dirty(vmcb02, VMCB_PERM_MAP);
 
 	/*
 	 * Stash vmcb02's counter if the guest hasn't moved past the guilty
-- 
2.51.0.470.ga7dc726c21-goog


