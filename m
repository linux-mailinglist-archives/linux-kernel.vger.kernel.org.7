Return-Path: <linux-kernel+bounces-763568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D1CB216B3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 22:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E7AE1A245A4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 20:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A95527D771;
	Mon, 11 Aug 2025 20:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KMiKgSmr"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88504311C12
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 20:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754945149; cv=none; b=sXAPo25jvzNVpFLe5WYgu2ymWqD5AWd5jNVBquDRpmZtqx9Lirmg6OXEViOv+BJRBUsGphAQC6ELgYKdmuy6krNjP/KPY+FVNRk5a320PPwCA4AMgSNkSbB/kup/LKgI6ELYjIe0JFwLyPd1U40NuEZb8lVLA7Z37fZMYd6fT2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754945149; c=relaxed/simple;
	bh=x9w6V7pENJMTOyxSXxtDBfeZ6hHo/blTfXAWZ/CChgw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fZtTA5S9NBGdQ51NJE9t37ZZjakv7ztksvXbI3uRBdrTtw8PJhkI9LS8l7hSlevG9ZKJn/getfJUAjvqw+JsrBPBvZf4jqa90fakM78dm08s0HhVwZQs50uJBoRaAhu2y73W2rymob0VhkKzhAgZ5plOKQooeJHpa8cqUzWOU6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KMiKgSmr; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b2fa1a84566so4099312a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 13:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754945148; x=1755549948; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YCzvuaHTksePcyjhE6+vgQKI6eFemBt/7TJj5lqZjhU=;
        b=KMiKgSmrRCisEMKzu0SqZhJgIqx7Q15Z4FkhmFRe2drVN8kYEUzzgLsDdP012HxL7/
         ZhybWCUSruu2XSs+fv7MXBpJ3d51kWFCgTAg/PIvEUuaBoFqekC710JPs7idjnsLIvqb
         bjVg3rTlVFADWSUkZMbrG4GnMS3A0nCXLd/GFB6kAZgSminGnJyB1nZL2S/XO++M9alC
         1gaA08bk3aFnHekDuA88NU90pOgfcIBmQ932CKqFzVdx2ANxc6ZHrx0l19wyD8Ew2cmk
         iXygdosvjQEmxUq5e84Drk2pIsMTghK248HBmIKmmlvRrGt39rs7KWBqK2Yx79BN5F0N
         CkHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754945148; x=1755549948;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YCzvuaHTksePcyjhE6+vgQKI6eFemBt/7TJj5lqZjhU=;
        b=v9/W+yhEzS7T1nNeLdUdaW3Quc3y5/AiT1lElTnWT82sBltshGkpwvDoWWURyuonTC
         d4pzkH39u2dEgV1bru3dNkK3oimvmdqNoj2/9h4zse456r21XjayY2k6QIFSKJFs1EVp
         ewBbmgKD5NU4ElkFP69wy5pczs9Q2MzbQVWEhy0FxNJi88+ju6p+4jgB2WH4gbzZ7kae
         zJsfp5d4DrrNqG58Sh4VF0MEvcpAUCVwEBjpg9b6di/13b037foXog1cjh7Ctvb8/wA5
         YWuSHtgjY/9rFZEX0mfeiGqVLVMrlJcupxfIg+PAo574UYmXkHvly4aGtBNtmKeGm3bY
         4JVw==
X-Forwarded-Encrypted: i=1; AJvYcCXdLBNyFYeh9sT23nHaCtWYmw+/JDcJ/pwTLP+9FkJDyJHfUqFFGy13p8wqd5Cw0J82xbGl8oL37vyJims=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq21DWuItR06N9Jmn4sUU729JzyzYQJnI+XjqtESZjamwkHr6X
	6GrAIkRSULOSGupz2Tmiw0fPc5LsmQjadEtTmC/fkX8aVEkZOLXpPTZO3CAMBGKXyRLHioSqryF
	HFS8z0g==
X-Google-Smtp-Source: AGHT+IGbrPTnrEMcQaX9aICrlGhuN/HwbXf/jBn1buIix2r8TwtQnzufznJB8yzLjSRkDiDx2IIc3OUJTF4=
X-Received: from pjqf22.prod.google.com ([2002:a17:90a:a796:b0:31e:fac4:4723])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ebc2:b0:240:86b2:aeb6
 with SMTP id d9443c01a7336-242fc33d8bdmr13536485ad.26.1754945147830; Mon, 11
 Aug 2025 13:45:47 -0700 (PDT)
Date: Mon, 11 Aug 2025 13:45:46 -0700
In-Reply-To: <20250811203041.61622-3-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250811203041.61622-1-yury.norov@gmail.com> <20250811203041.61622-3-yury.norov@gmail.com>
Message-ID: <aJpWet3USvXLWYEZ@google.com>
Subject: Re: [PATCH 2/2] KVM: SVM: drop useless cpumask_test_cpu() in pre_sev_run()
From: Sean Christopherson <seanjc@google.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Zheyun Shen <szy0127@sjtu.edu.cn>
Content-Type: text/plain; charset="us-ascii"

On Mon, Aug 11, 2025, Yury Norov wrote:
> Testing cpumask for a CPU to be cleared just before setting the exact
> same CPU is useless because the end result is always the same: CPU is
> set.

No, it is not useless.  Blindly writing to the variable will unnecessarily bounce
the cacheline, and this is a hot path.

> While there, switch CPU setter to a non-atomic version. Atomicity is
> useless here 

No, atomicity isn't useless here either.  Dropping atomicity could result in
CPU's bit being lost.  I.e. the atomic accesses aren't for the benefit of
smp_call_function_many_cond(), the writes are atomic so that multiple vCPUs can
concurrently update the mask without needing additional protection.

> because sev_writeback_caches() ends up with a plain
> for_each_cpu() loop in smp_call_function_many_cond(), which is not
> atomic by nature.

That's fine.  As noted in sev_writeback_caches(), if vCPU could be running, then
the caller is responsible for ensuring that all vCPUs flush caches before the
memory being reclaimed is fully freed.  Those guarantees are provided by KVM's
MMU.

sev_writeback_caches() => smp_call_function_many_cond() could hit false positives,
i.e. trigger WBINVD on CPUs that couldn't possibly have accessed the memory being
reclaimed, but such false positives are functionally benign, and are "intended"
in the sense that we chose to prioritize simplicity over precision.

> Fixes: 6f38f8c57464 ("KVM: SVM: Flush cache only on CPUs running SEV guest")
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  arch/x86/kvm/svm/sev.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 49d7557de8bc..8170674d39c1 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -3498,8 +3498,7 @@ int pre_sev_run(struct vcpu_svm *svm, int cpu)
>  	 * have encrypted, dirty data in the cache, and flush caches only for
>  	 * CPUs that have entered the guest.
>  	 */
> -	if (!cpumask_test_cpu(cpu, to_kvm_sev_info(kvm)->have_run_cpus))
> -		cpumask_set_cpu(cpu, to_kvm_sev_info(kvm)->have_run_cpus);
> +	__cpumask_set_cpu(cpu, to_kvm_sev_info(kvm)->have_run_cpus);
>  
>  	/* Assign the asid allocated with this SEV guest */
>  	svm->asid = asid;
> -- 
> 2.43.0
> 

