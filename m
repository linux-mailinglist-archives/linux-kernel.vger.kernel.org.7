Return-Path: <linux-kernel+bounces-827684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45407B9267E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 19:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 068163A7DBF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 17:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55BF313E1C;
	Mon, 22 Sep 2025 17:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uKMItRd/"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE3E311948
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 17:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758561837; cv=none; b=SeUr09KdLxPcrmVhzPiXNqVRD5D95aU0ZQyefQDFPv6UmQW01hCf3899E25nizncaflKcB40SSFK+2iEROeGQE+BO47WmVhdEaLAXTuuFH/YvX/y2dTCkceG9IbzhvH+XGhFaR1EKyqcRiJKBP2WaGGviEEGiSQGV7ArfEno7rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758561837; c=relaxed/simple;
	bh=Qr8opr5Va/cNTYJOoQfNrBHaJx/DGVxEWEk+0FtXquU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iB3iPkVWYPjcalvGis8lJBPzR11UmVmCzYFahWVLZKTPPFLIaVPKl7swCnhA6VaE9gznIgepYwU5BAIC9c1onmSOqCdIH/xHy8pqye2DJjeF4B1+0uIHP3ngRUWN212rzw59ZuISoFmq4/N4s8wxDvpL7pcOsyFSX0UgfO0YT5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uKMItRd/; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-77f2e48a829so2263530b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 10:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758561835; x=1759166635; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=M9vyYHmdIH5iKP3oSm5+z2eLymQyLbEwwwhYHv+QomA=;
        b=uKMItRd/8801mvvYlmzUpFWAzGZc4Eh6vWQWfeHZ2ePqdo0VDnpKJ4AsRNoGHx9Sfc
         I4Hyasghz/M+HvoOBQ4taaz+wbxe27XPZwyoQM14PG7fVacUIE8OOP0nobiKzlUubJcB
         XW+ejS/D1PRJs6HPqY6/Xb5XmtNmQSI0XnaMU4ZJNpOQlx7aoMxAH9DdI7Z9onWTBOMG
         rjkhqlrqxAMRM09o4xRVehgkJ/Es8tFvFZCgMNzYceXi2CrMYVZVPEnC0QOe0tkDALUv
         InNzMl2efovKp1GeZggJyI454x0LS4sljQTAojZdSWy8d0zaVOVmjooCh+c3PbuVV935
         44jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758561835; x=1759166635;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M9vyYHmdIH5iKP3oSm5+z2eLymQyLbEwwwhYHv+QomA=;
        b=ssc1EZdfzjci/Bx7jDnhFsbljfObX2i0T59XxsUeSowX9DRvwm9tDf4I2Myt5ow2Jd
         qyBEH/Rpl/JWvNQ/IfhrJaqP95/QXAyp/NmZ/Y1d7os4bEMTt966DCiBStKeOwbUOe6/
         IkdsVPBk+ZO4Up4HAEip3jRsG91ESn9lxxgj2nBPvz0DOjqoTpkGzXkRhQTNDheAiH45
         QJqLZN3XULJgfGCR9rq5E3/Ftf5bbXOT+6QKDAxoFbMU8dDwyPFsl4yvkZoPkGkqPvh0
         Ooa8A5ZVBGLRmZjXb7oNaXAGTPE8QlknHc9TNNdv+eoVLeBRP6lTvzSxXj0Z27csred1
         Qa0g==
X-Forwarded-Encrypted: i=1; AJvYcCVHdnVYO1ccwXzByKlGwFHQ+8GtK3Ik3V5J2NcOGjmlNNsG7D/HUlJnc3ZnW8NTk7kxNgNcPCKOhlEcBjI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7gNDPI6q0+KP6NKX5g/ZgcJw4gRlz1J/OEGjRvpkY9buMGgtI
	n2SylWkVNiuX+pEoR0bP9Xjoo3bZ+mstW2wMY5ErRKPO3rzqs/+bievJ9HLz29FTJ3YEhetLNJV
	psyPIfw==
X-Google-Smtp-Source: AGHT+IHzaNnenwkgcBdaNWYxcUbuxKLyQwhcnBxdwF8ALviEB1U545RXGfkdPcZrZCYnvFYVPR14Frq61bQ=
X-Received: from pgcs15.prod.google.com ([2002:a63:770f:0:b0:b4c:190c:3129])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:1584:b0:246:3a6:3e5e
 with SMTP id adf61e73a8af0-29274fb118dmr19821556637.54.1758561835342; Mon, 22
 Sep 2025 10:23:55 -0700 (PDT)
Date: Mon, 22 Sep 2025 10:23:54 -0700
In-Reply-To: <b89600a2-c3ae-4bb6-8c91-ea9a1dd507fb@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250919223258.1604852-1-seanjc@google.com> <20250919223258.1604852-20-seanjc@google.com>
 <b89600a2-c3ae-4bb6-8c91-ea9a1dd507fb@linux.intel.com>
Message-ID: <aNGGKm0Yzjvn3YVv@google.com>
Subject: Re: [PATCH v16 19/51] KVM: x86: Don't emulate task switches when IBT
 or SHSTK is enabled
From: Sean Christopherson <seanjc@google.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Mathias Krause <minipli@grsecurity.net>, 
	John Allen <john.allen@amd.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Chao Gao <chao.gao@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Zhang Yi Z <yi.z.zhang@linux.intel.com>, Xin Li <xin@zytor.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Sep 22, 2025, Binbin Wu wrote:
> 
> 
> On 9/20/2025 6:32 AM, Sean Christopherson wrote:
> > Exit to userspace with KVM_INTERNAL_ERROR_EMULATION if the guest triggers
> > task switch emulation with Indirect Branch Tracking or Shadow Stacks
> > enabled,
> 
> The code just does it when shadow stack is enabled.

Doh.  Fixed that and the EMULATION_FAILED typo Chao pointed out:

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 8b31dfcb1de9..06a88a2b08d7 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -12194,9 +12194,9 @@ int kvm_task_switch(struct kvm_vcpu *vcpu, u16 tss_selector, int idt_index,
                 */
                if (__kvm_emulate_msr_read(vcpu, MSR_IA32_U_CET, &u_cet) ||
                    __kvm_emulate_msr_read(vcpu, MSR_IA32_S_CET, &s_cet))
-                       return EMULATION_FAILED;
+                       goto unhandled_task_switch;
 
-               if ((u_cet | s_cet) & CET_SHSTK_EN)
+               if ((u_cet | s_cet) & (CET_ENDBR_EN | CET_SHSTK_EN))
                        goto unhandled_task_switch;
        }

