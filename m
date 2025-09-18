Return-Path: <linux-kernel+bounces-763594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E866B2173A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 23:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7702B460BE5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 21:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730512E2EE4;
	Mon, 11 Aug 2025 21:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d/g7trIN"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5489A1F4C8C
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 21:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754947307; cv=none; b=PLYyd1TXi3Jiqq0eeY/NemHtAFtyh3IRK4Osf4mBEocFe4zBqBNdJVtAyyhZj1zY26LSWFGPD1+j+Nmm6AbxdsMDQ5vRkFUDHKRFWnAYcwYbE0/zuPBCdcOT7LwlaJv7F4STdtK2Q20ZZKixqNckeShL28c3CY76imHdDjjp8zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754947307; c=relaxed/simple;
	bh=brKf34GlMteC6e97iXsE70oZ4GKg8aiG8bnhTlQwsfM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HDwEUWonPpOIwVCoaiqjYVat2LudqDTpCTnJ3X4jekZ8l0iFTQEyWUSrpdRnuV0NGT0408ZIzImOLIVMh+tj7+VPCNYWrHEMLwwVq1hFOFnSGkSodLIv7sVinoZ3soTvOs0Vd+4GzKYbBq2faiNKSXyRttlg8UV+gkAxEwTHoYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d/g7trIN; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32187814ef6so2877182a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 14:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754947306; x=1755552106; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VkuNbvX9tBpKROGoOIkFK7C05qc/TsQCHwS4wmeWMeY=;
        b=d/g7trINxtHYeoqFBbUq2GSp0sqdoFxpief5h1F7jkzGYApLoU6OUtIpwsrtc8xDew
         Xk2bs038wPisjiy3MhXKYIxyCfjurGUnea+lXPLHIbG+jNrpm6dSwv5BjwbIfc7b5oXP
         Zw/xFz48ojLjOkmJwgf5PUMer2no5IxPUs90wQMWIJw4w4DXnpw7cFL6Mn47OSAtiV/t
         LzqDmpG2+WFD7tIhAw+Wx4NddP9IvStW1CWR/Cgkrgceo/I4tGjl+uVxGxjyHn9K9VF/
         Ej1QFy+J/K9vcpOwPe40QVxKMOqVtrUSmNfbKPM/kYWiE701I6+lOy/KKucjAA4piMj8
         ESLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754947306; x=1755552106;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VkuNbvX9tBpKROGoOIkFK7C05qc/TsQCHwS4wmeWMeY=;
        b=k6hpbO3oVbbeDMJhF2qqE97fIWQXr91gEaE+JduuwcsR1gY3obvLVCGToRMSnJDlbi
         dCs18OOIeliobEA+QsIIyFwR3u+BdMkECxvScLEQXBSqIX4y7sgwvA+LzePhEKRtCeWm
         edLmE4S6d9wByv/LiHQjeqbVPhe5FBcchdW2XJp6LBij5d/jqeHkacW4SL/LcE+gYacy
         jWbO5/bsZ3EvfopkEIi4pULQEvQvBjWhVqnDKuxZCn5HJ5EXqGAKKEOnVP61lfrpCZHQ
         IT/30XjzvEw1iLXFPvraMzPBUjYmIxg0ZPMFM+YrhDy7RnIw4+ZSaoIbh4RmCXzq3JoM
         yqow==
X-Forwarded-Encrypted: i=1; AJvYcCV0zbxfH1dG3f6hw2jnEVmQ8vXv549p/UwIliYbit/tbwWNIifyl/5TaXH7mmXEsu3XnpT5+q4Jw6CgMCk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3aBgWIxe+lffKsrGHN1vQOh+VGtmLZUaQCXNlODhvjYAJY2K6
	IIkTePRdzxX9M3wLWbC2I1fg1+frf685VhaVy65znIRLyojDVmmAvkOSCh/VU9RacmYd4Kf9bDy
	mQcjqbg==
X-Google-Smtp-Source: AGHT+IEK4VLGMXiSIwY83HgovnmV+uwHaU0wvPKcWqvTTRG1gQzEHs2lYqa4NbosMDpjGWRBbH/Oh/H322U=
X-Received: from pjoa22.prod.google.com ([2002:a17:90a:8c16:b0:31e:d9dc:605f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2787:b0:31f:12f:ffaa
 with SMTP id 98e67ed59e1d1-321839d5ddcmr19785107a91.6.1754947305631; Mon, 11
 Aug 2025 14:21:45 -0700 (PDT)
Date: Mon, 11 Aug 2025 14:21:44 -0700
In-Reply-To: <aJpbLX_0WP5jXn7o@yury>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250811203041.61622-1-yury.norov@gmail.com> <20250811203041.61622-2-yury.norov@gmail.com>
 <aJpXh3dQNZpmUlHL@google.com> <aJpbLX_0WP5jXn7o@yury>
Message-ID: <aJpe6GM_3edwJXuX@google.com>
Subject: Re: [PATCH 1/2] KVM: SVM: don't check have_run_cpus in sev_writeback_caches()
From: Sean Christopherson <seanjc@google.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Zheyun Shen <szy0127@sjtu.edu.cn>
Content-Type: text/plain; charset="us-ascii"

On Mon, Aug 11, 2025, Yury Norov wrote:
> On Mon, Aug 11, 2025 at 01:50:15PM -0700, Sean Christopherson wrote:
> > On Mon, Aug 11, 2025, Yury Norov wrote:
> > > From: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> > > 
> > > Before calling wbnoinvd_on_cpus_mask(), the function checks the cpumask
> > > for emptiness. It's useless, as the following wbnoinvd_on_cpus_mask()
> > > ends up with smp_call_function_many_cond(), which handles empty cpumask
> > > correctly.
> > 
> > I don't agree that it's useless.  The early check avoids disabling/enabling
> > preemption (which is cheap, but still), and IMO it makes the KVM code more obviously
> > correct.  E.g. it takes quite a bit of digging to understand that invoking
> > wbnoinvd_on_cpus_mask() with an empty mask is ok/fine.
> > 
> > I'm not completely opposed to this change, but I also don't see the point.
> 
> So, there's a tradeoff between useless preemption cycling, which is
> O(1) and cpumask_empty(), which is O(N).

Oh, that argument I buy.  I had it in my head that the check is going to be O(1)
in practice, because never running vCPU0 would be all kinds of bizarre.  But the
mask tracks physical CPUs, not virtual CPUs.  E.g. a 2-vCPU VM that's pinned to
the last 2 pCPUs in the system could indeed trigger several superfluous loads and
checks.

> I have no measurements that can support one vs another. But the
> original patch doesn't discuss it anyhow, as well. So, with the
> lack of any information on performance impact, I'd stick with the 
> version that brings less code.
> 
> Agree?

Not sure I agree that less code is always better, but I do agree that dropping
the check makes sense.  :-)

How about this?  No need for a v2 (unless you disagree on the tweaks), I'll happily
fixup when applying.

--
From: Yury Norov <yury.norov@gmail.com>
Date: Mon, 11 Aug 2025 16:30:39 -0400
Subject: [PATCH] KVM: SEV: don't check have_run_cpus in sev_writeback_caches()

Drop KVM's check on an empty cpumask when flushing caches when memory is
being reclaimed from an SEV VM, as smp_call_function_many_cond() naturally
(and correctly) handles and empty cpumask.  This avoids an extra O(n)
lookup in the common case where at least one pCPU has enterred the guest,
which could be noticeable in some setups, e.g. if a small VM is pinned to
the last few pCPUs in the system.

Fixes: 6f38f8c57464 ("KVM: SVM: Flush cache only on CPUs running SEV guest")
Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
[sean: rewrite changelog to capture performance angle]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 2fbdebf79fbb..0635bd71c10e 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -718,13 +718,6 @@ static void sev_clflush_pages(struct page *pages[], unsigned long npages)
 
 static void sev_writeback_caches(struct kvm *kvm)
 {
-	/*
-	 * Note, the caller is responsible for ensuring correctness if the mask
-	 * can be modified, e.g. if a CPU could be doing VMRUN.
-	 */
-	if (cpumask_empty(to_kvm_sev_info(kvm)->have_run_cpus))
-		return;
-
 	/*
 	 * Ensure that all dirty guest tagged cache entries are written back
 	 * before releasing the pages back to the system for use.  CLFLUSH will
@@ -739,6 +732,9 @@ static void sev_writeback_caches(struct kvm *kvm)
 	 * serializing multiple calls and having responding CPUs (to the IPI)
 	 * mark themselves as still running if they are running (or about to
 	 * run) a vCPU for the VM.
+	 *
+	 * Note, the caller is responsible for ensuring correctness if the mask
+	 * can be modified, e.g. if a CPU could be doing VMRUN.
 	 */
 	wbnoinvd_on_cpus_mask(to_kvm_sev_info(kvm)->have_run_cpus);
 }

base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
--

