Return-Path: <linux-kernel+bounces-881028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4C0C273E3
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 01:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1767A4E7B2D
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 00:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365341B808;
	Sat,  1 Nov 2025 00:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G2qFSOC7"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1AA8460
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 00:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761955384; cv=none; b=hMoJFtZ7RwEl2zapKxgw76e5tC0g1+HFHVvJ4gFNEW4QA8XDd5LLgyouR3oMIpbEFsadL19i9NlY3vP26aqBpyjFFhe4ISx4Kgs3AoiFM67b6ltQ8Upu+L3SMjGW3eHSWW8K5BN8RkdwUA/6ax+UvS6lNdcV7DNkFr3FvhZGDYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761955384; c=relaxed/simple;
	bh=6B5ADNO6b+I1304veLGc80oNx2ETfK4pQRdC0pLmZ+Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KTPnayCOqfw6pO4/BlyXj+E6NTYa5fMh5j9kuR3HTerWr1/agmr1A4SmBw+Y2R1pu9lDokkB/4g7fVT16OTYIDGQfTwyLoPncfz61EPwQ+qa+Mda0U19+3o3xdR4pVxNua8GZwtqEBQrR4g0NrbSOw7ovnaN8gZbBVt7tobD0IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G2qFSOC7; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3307af9b55eso2141657a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 17:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761955382; x=1762560182; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Vsa9BLl4UP9MQX24fXJz57VqPDYmKwpeFV0rHWUJWjE=;
        b=G2qFSOC7hnOC1uAv0lpJoJnu0mlkc4I/eKEYXYjYFyve9AuaTVoaSTlNKt0VcrK1hv
         bdc4CdBA+XWwUSu7IiKvg7641mlED1XN/TeYppKQ0Ja9OZ0f+Pf6COqXlazeUdQl+moE
         sUo1mOH3thn9/GFswS0rLC3F6CBjAS/NWTMTKwki1pkl8jIXZi7xhJI82vhhhBIRLZvw
         uyYhntO+e4bwX43TvW1ICMUHNclRiAln7mVnRkCMGM4TIaMlhee+j1CyS8lqKvUuByj8
         kXzmyyyax1pRT9FXWhcUO+BW5elGygErDqBcGpXjpNwZ2akEuoXv+R1BGVbtSZziSJ7O
         jDlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761955382; x=1762560182;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vsa9BLl4UP9MQX24fXJz57VqPDYmKwpeFV0rHWUJWjE=;
        b=bHK0fw+zKpYibCgRgl36pW7ors1W+2dOA8c1ZvsW7LOkN6SusDGZKJBoQ6w+qsBUZE
         uHlVFwN3h4AofH4RzbgV9GQPLnzMW0oufP4+XKNrUtPZTyOWpCPKoIFKUzvj/Uf+MjMu
         slJyTrgpBJS6DvMazIH0HICYhiOl5RcIsT0+hbCPWC8CbcciH1MTULUFQUrxwTap5zq/
         p325lkiOV7zvDw27mIhFnaETTbAVG7Ooc+2vhRF2P5fDbbWpXcVCnku3wRFRYU0Umnjt
         uvbMX9RJmKfgFqzH8cSNlwgiqbQumhJN2Sqp4iWkz8h+Lrqy29jP/NRbkUvegc+NbMxv
         55zA==
X-Forwarded-Encrypted: i=1; AJvYcCXyUo+zXxJPwgVLkj8Z5f+OT/zjuGxY118LlmqfB+Ko7894nVVuYIOKUUf+CmiylCE/skOxshdw9D+Qj/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLMiqso7FPxVzste5R+0UGkIh6PCY6RWcbpO2ip1dIJcHbUY8v
	Tqja40CyPRxUCPQVg6qvGnaWnP8SEAyU1w9zQwRJofv5GYmSlG42WJZIEBrbvDo804bBCigELmV
	/FVvNgPe1WxkPgg==
X-Google-Smtp-Source: AGHT+IFGS4KHFxDjDA6q9T2d8R7JKao2hxEA3pruFKNUwFkxPAWOw+0Hgh7uYwWFyeqdISipHxL9HRKSd6Yrag==
X-Received: from plbmi11.prod.google.com ([2002:a17:902:fccb:b0:295:445a:2a75])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:22c2:b0:295:fc0:5a32 with SMTP id d9443c01a7336-2951a36c311mr67301915ad.3.1761955382518;
 Fri, 31 Oct 2025 17:03:02 -0700 (PDT)
Date: Fri, 31 Oct 2025 17:02:29 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.2.1006.ga50a493c49-goog
Message-ID: <20251101000241.3764458-1-jmattson@google.com>
Subject: [PATCH] KVM: x86: SVM: Mark VMCB_LBR dirty when L1 sets DebugCtl[LBR]
From: Jim Mattson <jmattson@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Jim Mattson <jmattson@google.com>, Matteo Rizzo <matteorizzo@google.com>, evn@google.com
Content-Type: text/plain; charset="UTF-8"

With the VMCB's LBR_VIRTUALIZATION_ENABLE bit set, the CPU will load
the DebugCtl MSR from the VMCB's DBGCTL field at VMRUN. To ensure that
it does not load a stale cached value, clear the VMCB's LBR clean bit
when L1 is running and bit 0 (LBR) of the DBGCTL field is changed from
0 to 1. (Note that this is already handled correctly when L2 is
running.)

There is no need to clear the clean bit in the other direction,
because when the VMCB's DBGCTL.LBR is 0, the VMCB's
LBR_VIRTUALIZATION_ENABLE bit will be clear, and the CPU will not
consult the VMCB's DBGCTL field at VMRUN.

Fixes: 1d5a1b5860ed ("KVM: x86: nSVM: correctly virtualize LBR msrs when L2 is running")
Reported-by: Matteo Rizzo <matteorizzo@google.com>
Reported-by: evn@google.com
Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/svm/svm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 153c12dbf3eb..b4e5a0684f57 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -816,6 +816,8 @@ void svm_enable_lbrv(struct kvm_vcpu *vcpu)
 	/* Move the LBR msrs to the vmcb02 so that the guest can see them. */
 	if (is_guest_mode(vcpu))
 		svm_copy_lbrs(svm->vmcb, svm->vmcb01.ptr);
+	else
+		vmcb_mark_dirty(svm->vmcb, VMCB_LBR);
 }
 
 static void svm_disable_lbrv(struct kvm_vcpu *vcpu)
-- 
2.51.2.1006.ga50a493c49-goog


