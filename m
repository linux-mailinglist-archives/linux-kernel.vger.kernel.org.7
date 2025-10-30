Return-Path: <linux-kernel+bounces-878980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D350C21E5D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 20:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65E23460A2C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 19:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A191F303C93;
	Thu, 30 Oct 2025 19:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZEpsSSHZ"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F5A2F7AD8
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 19:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761851743; cv=none; b=r19pPqjOECyY3U8TtfwTYVHfim90O/gCfhaNJGf1lIS6SFw48yC1SyowjDTQjOsvpiGeZbZZdfiJSrN6hi/28517bSZ8rqOhAZO0IRlBJtC8LhWJlcCPuC+vsM+mzeBkL8SerLfW/nBS7FAAtgJJ/EeSayarvGmAeIz9ZssoBcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761851743; c=relaxed/simple;
	bh=5kpuGHjjpW7eTD6TcJHKfUqA4500T6O1STI83TOW8fs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SyXikdUVI9GPfad+BBulHUwbfvmdzeSuyaXvs8DbajmAKphlRiVhOV4AE79Zo0o4WR/WrrJIs3d06U+ca09/JuwxtsUyt++sKnxT6IE1RGhz/9JmP4yHMpTOszBAQBDSd+LGXif2pXxa2IiSV8kryGO/udgH73qX8I+zwT9qDBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZEpsSSHZ; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b62f9247dd1so1144220a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 12:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761851741; x=1762456541; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=W/2e8g1L0c2/fPIAdJgPfrLPj4zwW85TJ2q4DSKPNps=;
        b=ZEpsSSHZBtu0juLkwieUGwZtNeGeCyMjSEXFCX2/G85+IzUpJIMh9Wc0bLqkGLBmCO
         yDeyxLipzL0K6L2d8MtYUsmlFvJ2LfLIsmAjGqAipRUJ0s08WdPvmF8CB0KqGZzWg4eh
         09c5AgmLCopk1zd+1ydIBzmZJdFpQmDTkZfZZU+OORi01kWcazruCBIOJg7RvBnhmTAz
         josrWYJ21DWrftAtiO7pLHh2UCMoQlLBGThEBdhdgRJFqCaPxewb1jQ2krMAAJY46VfD
         I6512lw9p7rPhTsqVjmQHptJsg2bDwwLdS3DNvrVoa22wVVAOju4Fdsyk3WntAeRZdgM
         12hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761851741; x=1762456541;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W/2e8g1L0c2/fPIAdJgPfrLPj4zwW85TJ2q4DSKPNps=;
        b=UaFq6x5W2ZjVCW34niUmcqJmaoDlvqpyXBWTTJugIIhcqV4QnY3pMZw5bEJ8ejJOVQ
         Xr7IV38ZKGfBypye4LqtWC0rp26nOyB2C1qy5XT7w5uZhT1d97JmYj+wF4n7cnfbkYaW
         BEcAPfo50nrHvhBoUWgYT9LlrXBOxFXnegQJVYbG0CUTdnO0pqADVE3Gh6oppbu7Geb8
         NFqbav2bJ+lOzQyZj9TdA5ZtMM8bDjk5RyrKRy5AfIoYpNbcqLZM+PvXAy+d98/8nJs3
         MYWdcjkv13E+lGGh7mQWxcTY88NCkwHyClLQqLrWqqygBCncfKXkppbZtTS1nqSYSNTi
         wppw==
X-Forwarded-Encrypted: i=1; AJvYcCW7cndtiHmTcdRMoemEpDOCxkolGcMHkd6ezZBZsqAGGEaTYntip8LcXnW9Flvkrh4CMcmE7saa3OsqIdY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9EjoF7xKW1X/p4XLWpsIWy8cL4Ojvwf9VSCkp5qhvuzcAryjJ
	qR/bFshyorX/lqtbiED/AQPlhwCUJviD1BM1O1MEZIHGU0u9DL/idpdUJWlzeXgV5BJ579hxbUI
	uwJoEFQ==
X-Google-Smtp-Source: AGHT+IHBG+E9whSy2GErOVQq7nq3zTa9mi3obzAxIEd5dUmGB6oa0sd3yHkkpbWzPAltL195JDv7MbsuY58=
X-Received: from pllk11.prod.google.com ([2002:a17:902:760b:b0:290:b136:4f08])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a67:b0:295:ed6:4641
 with SMTP id d9443c01a7336-2951a3bfafamr11598625ad.25.1761851740789; Thu, 30
 Oct 2025 12:15:40 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 30 Oct 2025 12:15:28 -0700
In-Reply-To: <20251030191528.3380553-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251030191528.3380553-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
Message-ID: <20251030191528.3380553-5-seanjc@google.com>
Subject: [PATCH v5 4/4] KVM: x86: Don't disable IRQs when unregistering
 user-return notifier
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	"Kirill A. Shutemov" <kas@kernel.org>
Cc: kvm@vger.kernel.org, x86@kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Yan Zhao <yan.y.zhao@intel.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>
Content-Type: text/plain; charset="UTF-8"

From: Hou Wenlong <houwenlong.hwl@antgroup.com>

Remove the code to disable IRQs when unregistering KVM's user-return
notifier now that KVM doesn't invoke kvm_on_user_return() when disabling
virtualization via IPI function call, i.e. now that there's no need to
guard against re-entrancy via IPI callback.

Note, disabling IRQs has largely been unnecessary since commit
a377ac1cd9d7b ("x86/entry: Move user return notifier out of loop") moved
fire_user_return_notifiers() into the section with IRQs disabled.  In doing
so, the commit somewhat inadvertently fixed the underlying issue that
was papered over by commit 1650b4ebc99d ("KVM: Disable irq while
unregistering user notifier").  I.e. in practice, the code and comment
has been stale since commit a377ac1cd9d7b.

Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
[sean: rewrite changelog after rebasing, drop lockdep assert]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c927326344b1..719a5fa45eb1 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -602,18 +602,10 @@ static void kvm_on_user_return(struct user_return_notifier *urn)
 	struct kvm_user_return_msrs *msrs
 		= container_of(urn, struct kvm_user_return_msrs, urn);
 	struct kvm_user_return_msr_values *values;
-	unsigned long flags;
 
-	/*
-	 * Disabling irqs at this point since the following code could be
-	 * interrupted and executed through kvm_arch_disable_virtualization_cpu()
-	 */
-	local_irq_save(flags);
-	if (msrs->registered) {
-		msrs->registered = false;
-		user_return_notifier_unregister(urn);
-	}
-	local_irq_restore(flags);
+	msrs->registered = false;
+	user_return_notifier_unregister(urn);
+
 	for (slot = 0; slot < kvm_nr_uret_msrs; ++slot) {
 		values = &msrs->values[slot];
 		if (values->host != values->curr) {
-- 
2.51.1.930.gacf6e81ea2-goog


