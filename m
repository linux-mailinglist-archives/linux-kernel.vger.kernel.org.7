Return-Path: <linux-kernel+bounces-823812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD45B877D3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 02:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 389037BBF05
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 00:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458F92566F7;
	Fri, 19 Sep 2025 00:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wual1gXE"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFC92505AF
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 00:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758242003; cv=none; b=ZSbVnsbNmQykD0SlSZYRTgDpHU0b9phuc2k9WALTmf1z6LPEdJ+NTVWRdXjSmkiOiL/vNBv9Ha+y+PlvFUISW09eCZcf+nszJt5SqpOwJVkjiuWLEZ40JwpOtxCDm2cS3gersgITaY9GHRvQbgcYWCSjcdzTaXGFe1ryRLeJVN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758242003; c=relaxed/simple;
	bh=beOA7yeMJ2oVmvwypx6LdP1/laar+mcAGIBojfsH2oY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YFfDFW0MPMcs8g2+td4a3x75UtlFvAHJNiy+m3r1dSsuxAwhMt18xZDBTNJnn18LGSEYSW3marjX4mQ411LeFsUD3reyPceiSWUvavHhvtbESNCPGK02Jx/i6KgUOXijpJcMbeL1kC8TRZwP0/KAnDXLY7A9cUAYnSnW+whZ0hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wual1gXE; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32ee4998c4aso1444436a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 17:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758242001; x=1758846801; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=RD/DK6kAG0c67mN/7HOpwDxU9lDZGk0fnKN4zAB6ORM=;
        b=wual1gXEO/qW/KcZbwpbjI0sfoehgcUGLD9x5H5IssZtwVGw1NDTs0m/FavAeb0uWd
         hJezfbf4ec0ve+CJ8ri6xoPdmbJhNd43fHRSqAky+UdLoM2+OMQVkRc3Cb3X3PJLbfI4
         8C3KMBbIY+54TStHLijE8z1Ov0x2jdnnoIP5hcyos0ofFhya0/ZIy+OoS+yimlrlM/Ge
         TbZ++UWriWCVW2aOhubu4sAgGGxWOsQfaWG1Vg8u3QszBVt5oshCh9zuBgASzj1kIanL
         /FgadlFwL0mzQsHkmJxMQcTn4i+/LucAJ5ylSCG1fu9waaPgXjZ5tKrYnrCNGG+4VYnV
         YdvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758242001; x=1758846801;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RD/DK6kAG0c67mN/7HOpwDxU9lDZGk0fnKN4zAB6ORM=;
        b=vgHBC1+MHA5Q/qsjb6e0PzaBVCaAq5h6bmoOQJKuS7y4x6f/Sh7ASNm0lvMUVL+OmL
         M41ZQqGDL72qnfxG61wi8LG6BGf21/dbm0mID1uQW5EkieMY9KArY8CwvHhAc/lgvvej
         KvJXH2Cy8YZmse+Iv1/DiP0VA6DjoF53eUINKwUoTk/XR7HtPLgIndZ7j8F5Dn6jcxpc
         OH7LamMlHHhXZW7Ck/0fsmP3vSVNPhHr8vY8W3okJimGoUtzzbdEQws18/2oY9rbWpFb
         /5l7bEXfuSKDxL0o0E+8mKTtGeQPw4FuKop76ctbOJjx41bf7QPcgk+gUCeC1r58tYRA
         wOSA==
X-Forwarded-Encrypted: i=1; AJvYcCW6NAgcJiuwmmncx48RQ/y3FMzt/j6uZmAWVYrnasmquCwK5+epVRKvi0kdgul+Thqag95LxnIbkm3fZDk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2yoaEqkcB/VcMEM6R7Pv9yHj0rcs0wFohPzuCKFnLvyxrgMxK
	yVWCpEPIHU9aG3OHUdNuAzp3FsV5HkD+x8AbDvDbJvPU6KmeYgbmDlb+nUDKwZ2sRmXMrdNMjA7
	QCEYCHA==
X-Google-Smtp-Source: AGHT+IEhgM6vmYfPOslFAinl0W4DEpXPFYuyJm2Gwrf0Sw+W4NYJijAe6YZgNnvs4sWIJBhjxXbmqFTMuoE=
X-Received: from pjbpw5.prod.google.com ([2002:a17:90b:2785:b0:330:7dd8:2dc2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3c88:b0:32e:b36b:3711
 with SMTP id 98e67ed59e1d1-3309836d7c3mr1410096a91.28.1758242001517; Thu, 18
 Sep 2025 17:33:21 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 18 Sep 2025 17:33:02 -0700
In-Reply-To: <20250919003303.1355064-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250919003303.1355064-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250919003303.1355064-5-seanjc@google.com>
Subject: [PATCH v2 4/5] KVM: x86: Drop pointless exports of kvm_arch_xxx() hooks
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Tony Krowiak <akrowiak@linux.ibm.com>, 
	Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>, 
	Harald Freudenberger <freude@linux.ibm.com>, Holger Dengler <dengler@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Drop the exporting of several kvm_arch_xxx() hooks that are only called
from arch-neutral code, i.e. that are only called from kvm.ko.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index e07936efacd4..ea0fffb24d4d 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -13542,14 +13542,12 @@ void kvm_arch_register_noncoherent_dma(struct kvm *kvm)
 	if (atomic_inc_return(&kvm->arch.noncoherent_dma_count) == 1)
 		kvm_noncoherent_dma_assignment_start_or_stop(kvm);
 }
-EXPORT_SYMBOL_GPL(kvm_arch_register_noncoherent_dma);
 
 void kvm_arch_unregister_noncoherent_dma(struct kvm *kvm)
 {
 	if (!atomic_dec_return(&kvm->arch.noncoherent_dma_count))
 		kvm_noncoherent_dma_assignment_start_or_stop(kvm);
 }
-EXPORT_SYMBOL_GPL(kvm_arch_unregister_noncoherent_dma);
 
 bool kvm_arch_has_noncoherent_dma(struct kvm *kvm)
 {
@@ -13561,7 +13559,6 @@ bool kvm_arch_no_poll(struct kvm_vcpu *vcpu)
 {
 	return (vcpu->arch.msr_kvm_poll_control & 1) == 0;
 }
-EXPORT_SYMBOL_GPL(kvm_arch_no_poll);
 
 #ifdef CONFIG_KVM_GUEST_MEMFD
 /*
-- 
2.51.0.470.ga7dc726c21-goog


