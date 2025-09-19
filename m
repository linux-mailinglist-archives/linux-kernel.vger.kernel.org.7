Return-Path: <linux-kernel+bounces-825247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A40B8B6B0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 23:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AB601CC2483
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 21:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058772D47E7;
	Fri, 19 Sep 2025 21:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uj+xYlRt"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EA41DEFE8
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 21:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758319012; cv=none; b=FjXkPX4v4nxtX3wIQTY3ol79MKNi+olK3Vlr5OS9TKHSDgvYj+91hTH2Y/uL1Lf2XZtRGnQjTsuBBMneN7A/9vH5/R9vLrwqpp/PUJLtdflxniZpp2RmzeOl1SxASjhVpmeh6ptQN2gQa8Wc4iv77BsWOZW6drpZ0dLjbMhfQ+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758319012; c=relaxed/simple;
	bh=igHxpSnoF5Kb8JVdQPsx+6NFF2n5cn2LdylQutZ5QYw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ubP8I3NgcvehtktVNF1xdv3zb9BABoMZCbP9znEYJ3DkW/7T5xj6H7yfa0nnv7WuwMsF8v6nNDVRRhBDrvHeOM40/eWEoh7ka0lLKaTOchPcszc1jMW6tnWpX2dNy8UuWq3VyBkj0TxjbjjDuVGGlHlqKUMeVVttALh63267/zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uj+xYlRt; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b5508cb189cso2584816a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758319010; x=1758923810; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FSeaN0drXXPg1f9FuSTW4yBvIIFvX43DlnUrM8CS0NU=;
        b=uj+xYlRtLKZMdfdzdaTAKr/c18PRi98Xw1Im9aiHQ5kH0OpRKPa7ZG9MqzxMNMQQQy
         L9wKmD4vKTsS4CkzUT1MlTQLS69MLzM/pmyOxOWCVGkK9lUG9iwI7iqhVQLuS02Iv8C5
         vsvBjtL3/o08B+uNuy1ZKuAD5hN73L8iol8z7dh+NVYyhH1BHPJ0piWu/nSmQ53paXlj
         oDpB39Uw4fpkayaMoTMJn4x1jm0ABC46Wt9MC8LJhaSSylkvpCa1z+P/9bqA1UBqF8Zx
         FiGJeLoRHnY9FNuAwT21p6yNG66TlT53iDIKAOlhTJC+72lepj/jyr/WU3eLVHCQG3Ti
         gD5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758319010; x=1758923810;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FSeaN0drXXPg1f9FuSTW4yBvIIFvX43DlnUrM8CS0NU=;
        b=TnAbeWYo2D172aeZ7NyQUg8Vl/SUQFPxxpT02hNE5Pqni83Sc3on1TFjK1U95tClWR
         Yfsm0KWjvuTn7HfyZPGVtnVL0QiIMP4Ur56+habsWDKLavd8gV2XMTJg63zHgzo11u9j
         qAkXMnyXSqJdRINzAy/EA3+BWNAw7q2YwTyJHfiktPZ9pUKeKHeRiXONgdIY/qLqZXiB
         QUcthKRtL11wECsL+60EWYB8rC+oQDbO4Hmo0tVEAHzWH9yIzcM815x0TyRa2YIJ5Y/B
         v6HspN7hZkR/f990C78XcrV+WF9WYMMxrEa4iwVgs7DmMXBFFNAHmFjScuX6Wxgk+a2u
         e80w==
X-Forwarded-Encrypted: i=1; AJvYcCViJ1lTg1Oog79d+wquWpPsZcLH/BUei9KrjeqJ/O7aisBXXEoIabVkQ9SZ6IPRaTut5dV/kFkmFiZDV/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlPMXcDEkGiv99cZF6eA0dom1AIo87FjWujEWPNCfQ5YZQnBnl
	hDyiCg6a7STQ/d/Ka98NRDHWAlNNYPRANaBejf/K+AnpFj/aVj+lupKpeLloGa4sju/iUWoo4Y2
	SR0ZJjg==
X-Google-Smtp-Source: AGHT+IFHHJ+E5msUuNFmJGIGLmjlzaUahnz2PVA54G+cCjdH3Esd/tItndD375RRvkO7+PRjUFj9laNQtKA=
X-Received: from pjl13.prod.google.com ([2002:a17:90b:2f8d:b0:32d:def7:e60f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:288f:b0:329:ed5b:ecd5
 with SMTP id 98e67ed59e1d1-33098246259mr6191568a91.19.1758319010480; Fri, 19
 Sep 2025 14:56:50 -0700 (PDT)
Date: Fri, 19 Sep 2025 14:56:49 -0700
In-Reply-To: <4vqqbmsqcaeabbslmrmxbtrq4wubt2avhimijk3xqgerkifune@ahyotfj55gds>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250919002136.1349663-1-seanjc@google.com> <20250919002136.1349663-7-seanjc@google.com>
 <4vqqbmsqcaeabbslmrmxbtrq4wubt2avhimijk3xqgerkifune@ahyotfj55gds>
Message-ID: <aM3RoW3MzUfp-yto@google.com>
Subject: Re: [PATCH v3 6/6] KVM: SVM: Enable AVIC by default for Zen4+ if
 x2AVIC is support
From: Sean Christopherson <seanjc@google.com>
To: Naveen N Rao <naveen@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Sep 19, 2025, Naveen N Rao wrote:
> On Thu, Sep 18, 2025 at 05:21:36PM -0700, Sean Christopherson wrote:
> > @@ -1151,6 +1170,18 @@ void avic_vcpu_unblocking(struct kvm_vcpu *vcpu)
> >  
> >  static bool __init avic_want_avic_enable(void)
> >  {
> > +	/*
> > +	 * In "auto" mode, enable AVIC by default for Zen4+ if x2AVIC is
> > +	 * supported (to avoid enabling partial support by default, and because
> > +	 * x2AVIC should be supported by all Zen4+ CPUs).  Explicitly check for
> > +	 * family 0x19 and later (Zen5+), as the kernel's synthetic ZenX flags
> > +	 * aren't inclusive of previous generations, i.e. the kernel will set
> > +	 * at most one ZenX feature flag.
> > +	 */
> > +	if (avic == AVIC_AUTO_MODE)
> > +		avic = boot_cpu_has(X86_FEATURE_X2AVIC) &&
> 
> This can use cpu_feature_enabled() as well, I think.

It could, but I'm going to leave it as boot_cpu_has() for now, purely because
the existing code uses boot_cpu_has() for X2AVIC and mixing the two adds
"complexity" where none exists.

I'm definitely not opposed to using cpu_feature_enabled() in general, just not
in this case (of course, we could just swap them all, but meh, it's init code).

