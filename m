Return-Path: <linux-kernel+bounces-856289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 42288BE3C1A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 15:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E1C7A4EAD19
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 13:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91597339B52;
	Thu, 16 Oct 2025 13:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BYg/+XKs"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56ECE32A3CC
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 13:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760622068; cv=none; b=nRQL2lCpvnSmueNdu8SERstBCOZ/UcABFrj0SLYf9UXvveO1vT11SjbtXiZnBPVJvhna1XWr++F/JLguWY6FGpiX/7ZP9EaEJ3wnCukl+f80+3MNDUW+Bs0wCWEVd4KgrlKcS+79zIaqwFkhTrOrE8vaP2eIW2Y4sFWw/5pWrf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760622068; c=relaxed/simple;
	bh=aVEhqc/c60MDyAfUgQvI6KEHXzGImS1PZJ4Zx3bPwW8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bDFJuQL/BJX/VxEmDr3SvKPAvkSL4ovzKUsYlVaSifTAOwNa02p5/e7h3wG0rr7ZIHm1ihDanji7P+TYzAEXMJIpd3ZoAiRl0VybBUbGlQOlT3pJ7QosJy44auKjHWFzST/1lCkh6k7ulYtJIpEMdVMF5pgDR+9iMolQYhPlZec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BYg/+XKs; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-33bb3b235ebso1011798a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 06:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760622066; x=1761226866; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DnajJrtq/zicbKOANLTRdaDsT6uMH68/4M/MyZaKoJ8=;
        b=BYg/+XKsJcMDtkTygrrexdSXoGy8Wf0Tqs4WdAm2gpgQJtixDqhjEgCmfaPow4OZZk
         ZxLDUeWCvK5qk9dCk01Aa62m6+L5dU6qifK/IkYu3KvjSAn6sTeU0xeNQ1X7/47pOIbo
         AH00768Byj1S1PGe2rvDCaWUrL6pPqKLkF9VNlUD5zL28iwZIgkcV1mF/I1TlidFo91D
         iGdnr9aA+yV1sE9zt/Upa/+YpboS0RsAgaN4xqlZoagc7j8GMXLJAvao0IFfHXYchC5M
         LLYV8LkgIivm8+CvMssFtFVWg6QOp1lagDdOVbf0qFgKRf5jqBTfnZfr8cBhTAtT3W07
         cMUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760622066; x=1761226866;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DnajJrtq/zicbKOANLTRdaDsT6uMH68/4M/MyZaKoJ8=;
        b=PhFj1D+RBEUzUpsbMp/aGiijVADJWQxKsdP1u8B+XL6Tr9MP+C2zqg0zzqmi0fNB5o
         QLuVb28InM6UpTDdhmAC/+jZVM9jk5cTGcUMRsL/afClbmavfbk0l+wvkzPtcKrSyzR1
         5ZiSN5RdFUiYGOtCmRY77mKtrQkzh52rC/pDSK0SZvSz+PEuknbT6t4yam/AK9xpbUg4
         QQ4ylnYNc9msx520eEnWp7OSMAOi0kIO+hcVS1EzemNbteiJAghbkYWBaX0tp7GnOXqz
         EybB47oqotxMiPgrKruvbkRzTEsYUa2ko/zpeMaDyEVKXJEMRSMs0hoZCsRTtJbAarCh
         WAvg==
X-Forwarded-Encrypted: i=1; AJvYcCV5wARRM2RnfqkPYG6z670oJH26YdH6zpmekUu7N/Zp2hnlMPqhonkvpqF/L2EVbF3oOYhQ+6GWCHqb3dE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsWkAQEO0laV1j9fnfp8Ct8KpqP3SFxqdzex/BsvkRH+s4sB0n
	RKa1i6V7ajpQ8B36WZs3VRZN4G/04eG305KfQbWnN/MEzMzd6R2pme9TV/xPaT1Ww5fJkP9+Wv7
	WqJup8Q==
X-Google-Smtp-Source: AGHT+IHCpSqOqfu494ZwihjiS2Nn5X3JignxUlxwge9/0fS8hKe4ONpHcMnssp5tHSKwqdBpSnpYNN1XKd0=
X-Received: from pjbsv12.prod.google.com ([2002:a17:90b:538c:b0:33b:9921:8e9a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1ae4:b0:27d:69de:edd3
 with SMTP id d9443c01a7336-29027374b2cmr398857755ad.20.1760622065740; Thu, 16
 Oct 2025 06:41:05 -0700 (PDT)
Date: Thu, 16 Oct 2025 06:41:03 -0700
In-Reply-To: <20251016132738.GB95606@k08j02272.eu95sqa>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250919214259.1584273-1-seanjc@google.com> <aNvLkRZCZ1ckPhFa@yzhao56-desk.sh.intel.com>
 <aNvT8s01Q5Cr3wAq@yzhao56-desk.sh.intel.com> <aNwFTLM3yt6AGAzd@google.com>
 <aNwGjIoNRGZL3_Qr@google.com> <aO7w+GwftVK5yLfy@yzhao56-desk.sh.intel.com>
 <aO_JdH3WhfWr2BKr@google.com> <aPCzqQO7LE/cNiMA@yzhao56-desk.sh.intel.com> <20251016132738.GB95606@k08j02272.eu95sqa>
Message-ID: <aPD173WPjul0qC0P@google.com>
Subject: Re: [PATCH] KVM: x86: Drop "cache" from user return MSR setter that
 skips WRMSR
From: Sean Christopherson <seanjc@google.com>
To: Hou Wenlong <houwenlong.hwl@antgroup.com>
Cc: Yan Zhao <yan.y.zhao@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Oct 16, 2025, Hou Wenlong wrote:
> On Thu, Oct 16, 2025 at 04:58:17PM +0800, Yan Zhao wrote:
> > On Wed, Oct 15, 2025 at 09:19:00AM -0700, Sean Christopherson wrote:
> > > +	/*
> > > +	 * Leave the user-return notifiers as-is when disabling virtualization
> > > +	 * for reboot, i.e. when disabling via IPI function call, and instead
> > > +	 * pin kvm.ko (if it's a module) to defend against use-after-free (in
> > > +	 * the *very* unlikely scenario module unload is racing with reboot).
> > > +	 * On a forced reboot, tasks aren't frozen before shutdown, and so KVM
> > > +	 * could be actively modifying user-return MSR state when the IPI to
> > > +	 * disable virtualization arrives.  Handle the extreme edge case here
> > > +	 * instead of trying to account for it in the normal flows.
> > > +	 */
> > > +	if (in_task() || WARN_ON_ONCE(!kvm_rebooting))
> > kvm_offline_cpu() may be invoked when irq is enabled.
> > So does it depend on [1]?
> > 
> > [1] https://lore.kernel.org/kvm/aMirvo9Xly5fVmbY@google.com/
> >
> 
> Actually, kvm_offline_cpu() can't be interrupted by kvm_shutdown().
> syscore_shutdown() is always called after
> migrate_to_reboot_cpu(), which internally waits for currently running
> CPU hotplug to complete, as described in [*].
> 
> [*] https://lore.kernel.org/kvm/dd4b8286774df98d58b5048e380b10d4de5836af.camel@intel.com
> 
> 
> > > +		drop_user_return_notifiers();
> > > +	else
> > > +		__module_get(THIS_MODULE);
> > Since vm_vm_fops holds ref of module kvm_intel, and drop_user_return_notifiers()
> > is called in kvm_destroy_vm() or kvm_exit():
> > 
> > kvm_destroy_vm/kvm_exit
> >   kvm_disable_virtualization
> >     kvm_offline_cpu
> >       kvm_disable_virtualization_cpu
> >         drop_user_return_notifiers
> > 
> > also since fire_user_return_notifiers() executes with irq disabled, is it
> > necessary to pin kvm.ko?

Pinning kvm.ko is necessary because kvm_disable_virtualization_cpu() will bail
early due to virtualization_enabled being false (it will have been cleared by
the IPI call from kvm_shutdown()).  We could try figuring out a way around that,
but I don't see an easy solution, and in practice I can't think of any meaningful
downside to pinning kvm.ko.

I don't want to leave virtualization_enabled set because that's completely wrong
for everything except x86's user-return MSRs, which aren't even strictly related
to enabling virtualization.

I considered calling drop_user_return_notifiers() directly from kvm_exit(), but
that would require more special-case code, and it would mean blasting an IPI to
all CPUs, which seems like a bad idea when we know the system is trying to reboot.

