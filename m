Return-Path: <linux-kernel+bounces-844838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7ADBC2E39
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 00:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E0CE3C4D2C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 22:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB5E259C83;
	Tue,  7 Oct 2025 22:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4NQNsDEZ"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED192494D8
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 22:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759877069; cv=none; b=dfLeemqA0t6BL5zIUvMCdYeHUWLBtSoefhPAV029aJJzDGPBUlZyeHvSDGd1+/Nxy03C4SHJElh1fs1ztftYM0C2vVzkBSx93KfATZVYc45UGEZeT+ik/KBZcuhQhC85T0EclOEjYtbU6nZwb/dfthy3A8wYSMrrLFuntLe5eic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759877069; c=relaxed/simple;
	bh=78cJopXpOQG9OAsUEwX6lCCobqh+oH6OfHl5pPo7Ztk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SDypkPdhVe/IZWvCMhhkDw3kzoyqPlswo/sxfmKDi5l3oBv5tSl4aOuHyhMzRvYvzrFeR+4QIKHKrwr+pBpzjSrGEPU1uB78pQgYcbmJ0u028bMcFWkMwsdyR1k45RKo7xcgXO/EL9NqweYxP3qQQfnEeBogweYV+ha8dSc1tP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4NQNsDEZ; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-28e538b5f23so74182315ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 15:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759877068; x=1760481868; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/Rkpq/p6vlS1ftX3Hk8IgbTMJisDfUj8W7AvidCFsY0=;
        b=4NQNsDEZNgslDedNuS9YaH/UJZei4lcYI38XojhVitXe653Xij8s8dph+tu+CCo0Gn
         obBcLwKkuN3LFFl3QQnZ3vppbCngv8xZhNybtqilV/Zq499T0zFZEIqFxxrqRRN2IvXf
         WODbis9u1BPnBpM3j2wD7PRoVBmnOnv7G7CHwssdWxJiEAaic3jXfc0VK0M1SvYC6vJt
         hsRmDHK2MEGFwHlmO53sWyFiLkLY7oHF/GSCywHj128dVG3C4D7eWEGKNmLafmHvZyy0
         xnDJddbc4dOAtqioYUSJSz9o9zebLS25UgKNAeVHFyw7/fbk4qO7dR5BgwEab3He6nNo
         5oBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759877068; x=1760481868;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Rkpq/p6vlS1ftX3Hk8IgbTMJisDfUj8W7AvidCFsY0=;
        b=Wd3rKO3DEZvgyKq+hilKLKLzo2vimpITIOHyLbEtwGznToxrtAPYQv8wDn2xOR6xkI
         SsobbLdCq3Gm0LQOxrMyLvbhe0sIDBNOWDVMjsAKA+sQeGq5qVlQWuNDXFiiO4CBoZoW
         sgS+BU1oqaei8OxrGLRgJ2XuSKpFb8tJBD4OAJKfaoQ4ar3V8EIhGgfsDzL2J9Ll7XDH
         CDAN6L1gWBIGE8r6a2PRG8C2SsStCg7vjuvrOGGsWjiFgs/b8F/E6Ldz3C6Gm5qF1Zjl
         rtXuv3Gu7KZvUFI/H+0hIJDP0jb/jTBuqh61NflfMGy7olKrJMNQAfNzFsCkkDGKXn7j
         u9Eg==
X-Forwarded-Encrypted: i=1; AJvYcCWnmMyir0aBWdXWrLPhUjmGzJS6eH/Gw7jWM7p8F5AM6m72f17eXCQzpc+K8u6NI08pULZ42a9kdr9XkSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdZWEQvFeyWA63AnQrxDay8UFxpYflEl2afDjOsaiVvONGLYLX
	ePTzXfG/vD1W0AwgIU3sO9Apmbf4nKcn3pSFGiPbnmoxQ7srJxWwyGVTY2vLf+zrAnkFtTXBFW6
	vmsO6IvyThDcGnw==
X-Google-Smtp-Source: AGHT+IH/DPeqBgyKHXxOCo4/E3KmZEcspJS7td8Arw5LBmg4kppGX/eQxm4ue9E3qb2QwOhVlQeaDs/189kaJw==
X-Received: from pjnh3.prod.google.com ([2002:a17:90a:8303:b0:32e:c154:c2f6])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ef10:b0:27e:eabd:4b41 with SMTP id d9443c01a7336-29027216505mr14903695ad.7.1759877067692;
 Tue, 07 Oct 2025 15:44:27 -0700 (PDT)
Date: Tue,  7 Oct 2025 15:44:00 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.710.ga91ca5db03-goog
Message-ID: <20251007224405.1914008-1-jmattson@google.com>
Subject: [PATCH] KVM: SVM: Don't set GIF when clearing EFER.SVME
From: Jim Mattson <jmattson@google.com>
To: Yosry Ahmed <yosry.ahmed@linux.dev>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Clearing EFER.SVME is not architected to set GIF. Don't set GIF when
emulating a change to EFER that clears EFER.SVME.

This is covered in the discussion at
https://lore.kernel.org/all/5b8787b8-16e9-13dc-7fca-0dc441d673f9@citrix.com/.

Fixes: c513f484c558 ("KVM: nSVM: leave guest mode when clearing EFER.SVME")
Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/svm/svm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 3a9fe0a8b78c..5387851a96da 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -223,7 +223,6 @@ int svm_set_efer(struct kvm_vcpu *vcpu, u64 efer)
 	if ((old_efer & EFER_SVME) != (efer & EFER_SVME)) {
 		if (!(efer & EFER_SVME)) {
 			svm_leave_nested(vcpu);
-			svm_set_gif(svm, true);
 			/* #GP intercept is still needed for vmware backdoor */
 			if (!enable_vmware_backdoor)
 				clr_exception_intercept(svm, GP_VECTOR);
-- 
2.51.0.710.ga91ca5db03-goog


