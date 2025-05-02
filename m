Return-Path: <linux-kernel+bounces-629155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0E8AA6852
	for <lists+linux-kernel@lfdr.de>; Fri,  2 May 2025 03:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F27803BC8BE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 May 2025 01:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FDA13BC0C;
	Fri,  2 May 2025 01:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j+Xc9vHd"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D34B1A285
	for <linux-kernel@vger.kernel.org>; Fri,  2 May 2025 01:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746148656; cv=none; b=Inr7CgMTXrl7PVqExOAbLyD/pBOvcQRA+PYszyDU2WkrMnyJbJZU4PX5d7ZLw3lxitypGb3P/tqqBm6fzyrFLpqZW0JY/e3KWnB8vO3B7N1KZW8y18zIUDlYkWG5Cva/1H45wOczMdcaAN/7HcLnKNUBzSW8wPPQQunnu92rQgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746148656; c=relaxed/simple;
	bh=B1q2+ap++zLLjLUs9XEejRcMx0T6fUfUTcIS4OOKWk0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R57ldi+hfUOtsSw72GWbDZVk0a9wVbk5Zjgn8HMHAloDfpmzJIGp2GdQyabrObclNVtU2xFTbJmMf0ICYzaqYU7fHcMLxMh1PybfYArK2Zm558dA93rGwHzhLzgvTXbhghkpOZSw0uDdrZ4SFid7m3+tS6HZI4EX5ybUTXR+WpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j+Xc9vHd; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff78dd28ecso1653325a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 May 2025 18:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746148653; x=1746753453; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YzlnFCXfXy0GJ6wWugPL3V4XJdypnCJtArpXO+wkfcw=;
        b=j+Xc9vHdZWLIclD8rcikMtauMi5nbbJSOeQVyaaH4D2bxDun++Ri5r+dOtNLXs/5VQ
         tK+Jcje4vDx/Vl8Aj6bvlfHKgVvPUqPKmCHgRO8Z/hA73ZPUp4rd2K+cgYPeG0wbc/Qa
         KaBUnsZ9SnPHrnxN665O0lyWS+CEIeW5cPNLFBi78sZmIlth/VgM2YXcta5rws2mWPfz
         03zNFi3qEi2/uCAxVdWrydUGUhRYv7d/jhXswKD8eoRVYE97NyUJtROIgXW39E097Jjf
         95+7DaBkElQyGMPupCQsylR+tICSe+jEzIxg9E4yDCftk0GlDug8r2oyNPRpifRg/43n
         dPgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746148653; x=1746753453;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YzlnFCXfXy0GJ6wWugPL3V4XJdypnCJtArpXO+wkfcw=;
        b=Rbgozmo9iNbeiG9Vxa+dYzLgQsuDCRjKCFPWwrgIBpH10+ljbMSgA2Rki+iOn7Ofia
         fihQdLc0yIU19ctHAEWlqHMrgZtSA99uQ/4Qu7184l8QIRwZoKcRi6ivoX1ni0Lgzczy
         jJik2VULbd16arKCD6Qu0O+fKvBQZY7snW5VQsmA3KIJbg6I9U2K+alYEEeDBPREeCmb
         QdZMY98Nia7LskrzJm6YVnLOjyuqF0TSMoRVP2lLqcH9O/dUooxtQy9qG6T7Ul2F8cOB
         oQi1bQi7nDeygK8LnKZAgKMvktaPZ/+7rkEuiqMGJNrWFiV8AYGX+eao9SwayQVdEVjo
         n8HQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0vb99lsK12LhOFvdPDLkk4k+GA9Y2kepVL4B/QnYjVqJvVksPSErY1ZHMMHFd4MZNZ6Fu0Ui3ExC3PPE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzb569TPW1JRCxK4To4nm3OOxrK05ZBIRHGQZ/kd/EQSen/7k1
	kGWjjZP2i8S7NFmixUuXjzADJagEXksKtdk9CexeRj7pXsaQICnOyJ89zmh/Xjxz4EvWxKmGdqQ
	Mjw==
X-Google-Smtp-Source: AGHT+IHiQxgcwgBaqEXKgthWbvh8SOb1o3D2BTYBYuxwdC+Nqxt8hZmjd1LtLB9rP0PHnhyFcz4d60Uxj9g=
X-Received: from pjbsi3.prod.google.com ([2002:a17:90b:5283:b0:2ee:4a90:3d06])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:7788:b0:30a:4f0d:a6e7
 with SMTP id 98e67ed59e1d1-30a4f0dad3cmr1182831a91.14.1746148652869; Thu, 01
 May 2025 18:17:32 -0700 (PDT)
Date: Thu, 1 May 2025 18:17:31 -0700
In-Reply-To: <20250325041350.1728373-3-suleiman@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250325041350.1728373-1-suleiman@google.com> <20250325041350.1728373-3-suleiman@google.com>
Message-ID: <aBQdKyCI0fC5T8U-@google.com>
Subject: Re: [PATCH v5 2/2] KVM: x86: Include host suspended time in steal time
From: Sean Christopherson <seanjc@google.com>
To: Suleiman Souhlal <suleiman@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Chao Gao <chao.gao@intel.com>, 
	David Woodhouse <dwmw2@infradead.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ssouhlal@freebsd.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Mar 25, 2025, Suleiman Souhlal wrote:
> When the host resumes from a suspend, the guest thinks any task
> that was running during the suspend ran for a long time, even though
> the effective run time was much shorter, which can end up having
> negative effects with scheduling.
> 
> To mitigate this issue, the time that the host was suspended is included
> in steal time, which lets the guest subtract the duration from the
> tasks' runtime.
> 
> In order to implement this behavior, once the suspend notifier fires,
> vCPUs trying to run will block until the resume notifier finishes. This is
> because the freezing of userspace tasks happens between these two points.
> It means that vCPUs could otherwise run and get their suspend steal
> time misaccounted, particularly if a vCPU would run after resume before
> the resume notifier fires.
> Incidentally, doing this also addresses a potential race with the
> suspend notifier setting PVCLOCK_GUEST_STOPPED, which could then get
> cleared before the suspend actually happened.
> 
> One potential caveat is that in the case of a suspend happening during
> a VM migration, the suspend time might not be accounted for.
> A workaround would be for the VMM to ensure that the guest is entered
> with KVM_RUN after resuming from suspend.

Please rewrite this to state what changes are being made in impreative mood, as
commands.  Describing the _effects_ of a change makes it extremely difficult to
understand whether the behavior is pre-patch or post-patch.

E.g. for this

  vCPUs trying to run will block until the resume notifier finishes

I had to look at the code to understand what this was saying, which largely
defeats the purpose of the changelog.

> Signed-off-by: Suleiman Souhlal <suleiman@google.com>
> ---
>  Documentation/virt/kvm/x86/msr.rst | 10 ++++--
>  arch/x86/include/asm/kvm_host.h    |  6 ++++
>  arch/x86/kvm/x86.c                 | 51 ++++++++++++++++++++++++++++++
>  3 files changed, 65 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/virt/kvm/x86/msr.rst b/Documentation/virt/kvm/x86/msr.rst
> index 3aecf2a70e7b43..48f2a8ca519548 100644
> --- a/Documentation/virt/kvm/x86/msr.rst
> +++ b/Documentation/virt/kvm/x86/msr.rst
> @@ -294,8 +294,14 @@ data:
>  
>  	steal:
>  		the amount of time in which this vCPU did not run, in
> -		nanoseconds. Time during which the vcpu is idle, will not be
> -		reported as steal time.
> +		nanoseconds. This includes the time during which the host is
> +		suspended. Time during which the vcpu is idle, might not be
> +		reported as steal time. The case where the host suspends
> +		during a VM migration might not be accounted if VCPUs aren't
> +		entered post-resume, because KVM does not currently support
> +		suspend/resuming the associated metadata. A workaround would
> +		be for the VMM to ensure that the guest is entered with
> +		KVM_RUN after resuming from suspend.

Coming back to this with fresh eyes, I kinda feel like this needs an opt-in
somewhere.  E.g. a KVM capability, or maybe a guest-side steal-time feature?  Or
maybe we can squeak by with a module param based on your use case?

IIRC, there is a guest-side fix that is needed to not go completely off the rails
for large steal-time values.  I.e. enabling this blindly could negatively effect
existings guests.

The forced wait behavior introduced in v4 also gives me pause, but that should
really just be about getting the code right, i.e. shouldn't go sideways as long
as the host kernel is bug free.

Ugh, actually, yeah, that part needs a guard.  At the very least, it needs to be
conditional on steal-time being enabled.  KVM most definitely should not block
vCPUs that aren't using steal-time, as that's a complete waste and will only make
the effects of suspend worse for the guest.  At that point, having the guest
opt-in to the behavior is a pretty minor change, and it gives users a way to
opt-out if this is causing pain.

>  	preempted:
>  		indicate the vCPU who owns this struct is running or
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index f5ce2c2782142b..10634bbf2f5d21 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -124,6 +124,7 @@
>  #define KVM_REQ_HV_TLB_FLUSH \
>  	KVM_ARCH_REQ_FLAGS(32, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
>  #define KVM_REQ_UPDATE_PROTECTED_GUEST_STATE	KVM_ARCH_REQ(34)
> +#define KVM_REQ_WAIT_FOR_RESUME		KVM_ARCH_REQ(35)
>  
>  #define CR0_RESERVED_BITS                                               \
>  	(~(unsigned long)(X86_CR0_PE | X86_CR0_MP | X86_CR0_EM | X86_CR0_TS \
> @@ -917,8 +918,13 @@ struct kvm_vcpu_arch {
>  
>  	struct {
>  		u8 preempted;
> +		bool host_suspended;
>  		u64 msr_val;
>  		u64 last_steal;
> +		u64 last_suspend;
> +		u64 suspend_ns;
> +		u64 last_suspend_ns;
> +		wait_queue_head_t resume_waitq;
>  		struct gfn_to_hva_cache cache;
>  	} st;
>  
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 6b4ea3be66e814..327d1831dc0746 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -3717,6 +3717,8 @@ static void record_steal_time(struct kvm_vcpu *vcpu)
>  	steal += current->sched_info.run_delay -
>  		vcpu->arch.st.last_steal;
>  	vcpu->arch.st.last_steal = current->sched_info.run_delay;
> +	steal += vcpu->arch.st.suspend_ns - vcpu->arch.st.last_suspend_ns;
> +	vcpu->arch.st.last_suspend_ns = vcpu->arch.st.suspend_ns;

Isn't this just:

	steal += vcpu->arch.st.suspend_ns;
	vcpu->arch.st.suspend_ns = 0;

or am I missing something?  I suspect you implemented the code this way to avoid
writing vcpu->arch.st.suspend_ns in this context, because you discovered that
record_steal_time() can run concurrently with kvm_arch_suspend_notifier(), i.e.
because vcpu->arch.st.suspend_ns was getting corrupted.

The above doesn't fully solve the problem, it just makes the badness less bad
and/or much less likely to be hit.  E.g. if vcpu->arch.st.suspend_ns is advanced
between the first and second loads, KVM would fail to account the delta between
the two loads.

Unless I'm missing something, the obvious/easy thing is to make arch.st.suspend_ns
and atomic64_t, e.g.

	if (unlikely(atomic64_read(&vcpu->arch.st.suspend_ns)))
		steal += atomic64_xchg(&vcpu->arch.st.suspend_ns, 0);

and then on the resume side:

	atomic64_add(suspend_ns, &vcpu->arch.st.suspend_ns);
	kvm_make_request(KVM_REQ_STEAL_UPDATE, vcpu);


>  	unsafe_put_user(steal, &st->steal, out);
>  
>  	version += 1;
> @@ -6930,6 +6932,19 @@ long kvm_arch_vm_compat_ioctl(struct file *filp, unsigned int ioctl,
>  }
>  #endif
>  
> +static void wait_for_resume(struct kvm_vcpu *vcpu)
> +{
> +	wait_event_interruptible(vcpu->arch.st.resume_waitq,
> +	    vcpu->arch.st.host_suspended == 0);
> +
> +	/*
> +	 * This might happen if we blocked here before the freezing of tasks
> +	 * and we get woken up by the freezer.
> +	 */
> +	if (vcpu->arch.st.host_suspended)
> +		kvm_make_request(KVM_REQ_WAIT_FOR_RESUME, vcpu);

I most definitely don't want to add custom waiting behavior for this.  As this
code shows, ensuring a wakeup doesn't race with blocking isn't the easiest thing
in the world.

Off the top of my head, I can't think of any reason why we can't simply send the
vCPU into kvm_vcpu_block(), by treating the vCPU as completely non-runnable while
it is suspended.

>  #ifdef CONFIG_HAVE_KVM_PM_NOTIFIER
>  static int kvm_arch_suspend_notifier(struct kvm *kvm)
>  {
> @@ -6939,6 +6954,19 @@ static int kvm_arch_suspend_notifier(struct kvm *kvm)
>  
>  	mutex_lock(&kvm->lock);
>  	kvm_for_each_vcpu(i, vcpu, kvm) {
> +		vcpu->arch.st.last_suspend = ktime_get_boottime_ns();
> +		/*
> +		 * Tasks get thawed before the resume notifier has been called
> +		 * so we need to block vCPUs until the resume notifier has run.
> +		 * Otherwise, suspend steal time might get applied too late,
> +		 * and get accounted to the wrong guest task.
> +		 * This also ensures that the guest paused bit set below
> +		 * doesn't get checked and cleared before the host actually
> +		 * suspends.
> +		 */
> +		vcpu->arch.st.host_suspended = 1;

We can definitely avoid this flag, e.g. by zeroing last_suspend in the resume
notified, and using that to detect "host suspended".

> +		kvm_make_request(KVM_REQ_WAIT_FOR_RESUME, vcpu);
> +
>  		if (!vcpu->arch.pv_time.active)
>  			continue;
>  
> @@ -6954,12 +6982,32 @@ static int kvm_arch_suspend_notifier(struct kvm *kvm)
>  	return ret ? NOTIFY_BAD : NOTIFY_DONE;
>  }
>  
> +static int kvm_arch_resume_notifier(struct kvm *kvm)
> +{
> +	struct kvm_vcpu *vcpu;
> +	unsigned long i;
> +
> +	mutex_lock(&kvm->lock);

No need for this, it provides zero protection and can (very, very theoretically)
trigger deadlock.  The lock has already been dropped from the suspend notifier.

> +	kvm_for_each_vcpu(i, vcpu, kvm) {
> +		vcpu->arch.st.host_suspended = 0;
> +		vcpu->arch.st.suspend_ns += ktime_get_boottime_ns() -
> +		    vcpu->arch.st.last_suspend;
> +		wake_up_interruptible(&vcpu->arch.st.resume_waitq);

This needs a

	kvm_make_request(KVM_REQ_STEAL_UPDATE, vcpu);

to ensure the suspend_ns time is accounted.  kvm_arch_vcpu_load() probably
guarantees KVM_REQ_STEAL_UPDATE is set, but KVM shouldn't rely on that.

Completely untested, and I didn't add any new ABI, but something like this?

---
 Documentation/virt/kvm/x86/msr.rst | 10 ++++--
 arch/x86/include/asm/kvm_host.h    |  2 ++
 arch/x86/kvm/x86.c                 | 56 +++++++++++++++++++++++++++++-
 3 files changed, 65 insertions(+), 3 deletions(-)

diff --git a/Documentation/virt/kvm/x86/msr.rst b/Documentation/virt/kvm/x86/msr.rst
index 3aecf2a70e7b..48f2a8ca5195 100644
--- a/Documentation/virt/kvm/x86/msr.rst
+++ b/Documentation/virt/kvm/x86/msr.rst
@@ -294,8 +294,14 @@ data:
 
 	steal:
 		the amount of time in which this vCPU did not run, in
-		nanoseconds. Time during which the vcpu is idle, will not be
-		reported as steal time.
+		nanoseconds. This includes the time during which the host is
+		suspended. Time during which the vcpu is idle, might not be
+		reported as steal time. The case where the host suspends
+		during a VM migration might not be accounted if VCPUs aren't
+		entered post-resume, because KVM does not currently support
+		suspend/resuming the associated metadata. A workaround would
+		be for the VMM to ensure that the guest is entered with
+		KVM_RUN after resuming from suspend.
 
 	preempted:
 		indicate the vCPU who owns this struct is running or
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 8becf50d9ade..8a5ff888037a 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -931,6 +931,8 @@ struct kvm_vcpu_arch {
 		u8 preempted;
 		u64 msr_val;
 		u64 last_steal;
+		atomic64_t suspend_ns;
+		u64 suspend_ts;
 		struct gfn_to_hva_cache cache;
 	} st;
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 73f4a85c72aa..b6120ebbb8fa 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3751,6 +3751,10 @@ static void record_steal_time(struct kvm_vcpu *vcpu)
 	steal += current->sched_info.run_delay -
 		vcpu->arch.st.last_steal;
 	vcpu->arch.st.last_steal = current->sched_info.run_delay;
+
+	if (unlikely(atomic64_read(&vcpu->arch.st.suspend_ns)))
+		steal += atomic64_xchg(&vcpu->arch.st.suspend_ns, 0);
+
 	unsafe_put_user(steal, &st->steal, out);
 
 	version += 1;
@@ -6992,6 +6996,7 @@ long kvm_arch_vm_compat_ioctl(struct file *filp, unsigned int ioctl,
 #ifdef CONFIG_HAVE_KVM_PM_NOTIFIER
 static int kvm_arch_suspend_notifier(struct kvm *kvm)
 {
+	bool kick_vcpus = false;
 	struct kvm_vcpu *vcpu;
 	unsigned long i;
 
@@ -6999,9 +7004,45 @@ static int kvm_arch_suspend_notifier(struct kvm *kvm)
 	 * Ignore the return, marking the guest paused only "fails" if the vCPU
 	 * isn't using kvmclock; continuing on is correct and desirable.
 	 */
-	kvm_for_each_vcpu(i, vcpu, kvm)
+	kvm_for_each_vcpu(i, vcpu, kvm) {
 		(void)kvm_set_guest_paused(vcpu);
 
+		if (vcpu->arch.st.msr_val & KVM_MSR_ENABLED) {
+			kick_vcpus = true;
+			WRITE_ONCE(vcpu->arch.st.suspend_ts,
+				   ktime_get_boottime_ns());
+		}
+	}
+
+	if (kick_vcpus)
+		kvm_make_all_cpus_request(kvm, KVM_REQ_OUTSIDE_GUEST_MODE);
+
+	return NOTIFY_DONE;
+}
+
+static int kvm_arch_resume_notifier(struct kvm *kvm)
+{
+	struct kvm_vcpu *vcpu;
+	unsigned long i;
+
+	kvm_for_each_vcpu(i, vcpu, kvm) {
+		u64 suspend_ns  = ktime_get_boottime_ns() -
+				  vcpu->arch.st.suspend_ts;
+
+		WRITE_ONCE(vcpu->arch.st.suspend_ts, 0);
+
+		/*
+		 * Only accumulate the suspend time if steal-time is enabled,
+		 * but always clear suspend_ts and kick the vCPU as the vCPU
+		 * could have disabled steal-time after the suspend notifier
+		 * grabbed suspend_ts.
+		 */
+		if (vcpu->arch.st.msr_val & KVM_MSR_ENABLED)
+			atomic64_add(suspend_ns, &vcpu->arch.st.suspend_ns);
+
+		kvm_make_request(KVM_REQ_STEAL_UPDATE, vcpu);
+	}
+
 	return NOTIFY_DONE;
 }
 
@@ -7011,6 +7052,9 @@ int kvm_arch_pm_notifier(struct kvm *kvm, unsigned long state)
 	case PM_HIBERNATION_PREPARE:
 	case PM_SUSPEND_PREPARE:
 		return kvm_arch_suspend_notifier(kvm);
+	case PM_POST_HIBERNATION:
+	case PM_POST_SUSPEND:
+		return kvm_arch_resume_notifier(kvm);
 	}
 
 	return NOTIFY_DONE;
@@ -11251,6 +11295,16 @@ EXPORT_SYMBOL_GPL(kvm_vcpu_has_events);
 
 int kvm_arch_vcpu_runnable(struct kvm_vcpu *vcpu)
 {
+	/*
+	 * During host SUSPEND/RESUME tasks get frozen after SUSPEND notifiers
+	 * run, and thawed before RESUME notifiers, i.e. vCPUs can be actively
+	 * running when KVM sees the system as suspended.  Block the vCPU if
+	 * KVM sees the vCPU as suspended to ensure the suspend steal time is
+	 * accounted before the guest can run, and to the correct guest task.
+	 */
+	if (READ_ONCE(vcpu->arch.st.suspend_ts))
+		return false;
+
 	return kvm_vcpu_running(vcpu) || vcpu->arch.pv.pv_unhalted ||
 	       kvm_vcpu_has_events(vcpu);
 }

base-commit: 17cfb61855eafd72fd6a22d713a39be0d74660e1
-- 

