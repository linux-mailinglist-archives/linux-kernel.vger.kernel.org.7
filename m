Return-Path: <linux-kernel+bounces-733669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D16F1B0779E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 16:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCEDBA41370
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7CB21C19E;
	Wed, 16 Jul 2025 14:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JH8YeOwD"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D847721C19A
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 14:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752674874; cv=none; b=VhcGmOYYSgp6EKtT/FGb+xVbAKFLrnfseowGfcnZnZScsdIfrz/Iu2ZGZTspoEeYZsdjo51Pc0VpoAHwAaw3ZYXWm8KF7X+CMvz5CYOL7+NQpOVqReF/IsIDt3wztZ4JY0Q9CloqppfKlMl+A1309SSuvO9XRa0+rxk5WRz8SLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752674874; c=relaxed/simple;
	bh=xnppXDW+/D4BUUfT+nmUqzxni9FLNf119+Kee7lDjQY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VRZGtic6pXkMAvb/OgDLWoJyXJwo9iJeUe/91uzYg2i1eD1yovmncwXR0RmJ2l/bdN+Jzf1ydnhj07ZWs0cyRnE8Fn1GXX59IsuO5HaDfWPKfh0QCVaOwuDOjoPVCFr3Zs9v8HzFnGDtYL+P/hPUDBcFudIeB4Gq82wdK/WhvuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JH8YeOwD; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3138e64b3f1so9869652a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 07:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752674872; x=1753279672; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zTkHFe90gJMMisypW9Kk07LFR5ck7ZI/4vCfu7qJlUI=;
        b=JH8YeOwD7Kbd6Q63SXat3adOBXFJdhJzWXDh0aQkobSuxhPCUNne8EdKXbzImZMBnR
         UiMfqSe/yeuA0bE4An6JoNAriXnowF0dGHEgMInUNEms3Oj+QRPbin6/r+4Bag6utQPH
         khCjzIf3J36LDv0UksybZ6JhqhBMUYBBq6rodbjCLfnavJhi+lFlL4jeGiasAQ4wOjui
         w0UNnWudubYtcutktOIqCdrIY/fkdOC1ZffxuR6l1BOmvxXG6Sx2mMfgj2aup8E1Cs+A
         VAlD6i4cavK1sEiqkzrKIAey99T52lEAY6/KoL5he8lAoEk+wy6smESZnR24PNFXHbLG
         +e8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752674872; x=1753279672;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zTkHFe90gJMMisypW9Kk07LFR5ck7ZI/4vCfu7qJlUI=;
        b=CkMrqGLi5x/m/0wrR0JD02k9CrFakZ7Pi9JiQMxjrPaFg/IK6yOzcaZiKiQmKasVyw
         Ufn3/6CP+TNeUozZj1aRtDZrBRllMbR9nr6+WCwbFO4glMLjvsbcom2Qj5qHbNyKZ1xM
         HhjPHMo14dYm3XEeQxVQobXByETDZJpMnyKioK8QDpSs9aLdt8l3D4qDVejQx+MFXywK
         pxksRAGYqjYeZZveeAdc0Yvz3SmlB78jkh3Y96S1z7L5Vtf9aot5paK0FBMcmVvcslNY
         RezlUO+CQop7lsfds3m5EbJI1yaEHn9bxtjYgg2jgmfRRQRBgt9LgzxbclMHIj1W4K0u
         hPGA==
X-Forwarded-Encrypted: i=1; AJvYcCWquAhVbMo+zA43ebKdq5eEU5+5Nllj//EDsfCbiNT7H1xpefhpz8NwYsLJZz7GUODgehnL8rH6ve5oEIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfqUxvYxaa+fObRq94xpdoi8AGXmhOxV+2E+zTgWJJeIPlzA2t
	cI4pV8244ipe4Lw7cr7ykkRT1OTAuyUYC5Q6E5cZcLbrDMtCUvF8GyC9ZEqTei9MSvMMtsCtJpx
	hnfO+Sg==
X-Google-Smtp-Source: AGHT+IGH7SKkiv+dEeqsqPQ36yI4iZJKO0Glbz2Nfmg5FFOwhR41KHC8GZ7fd7PWHjk6NrfWpS+ivmnev7w=
X-Received: from pjbqo11.prod.google.com ([2002:a17:90b:3dcb:b0:311:7d77:229f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5604:b0:31c:38f8:7efb
 with SMTP id 98e67ed59e1d1-31c9f424137mr4936137a91.18.1752674872198; Wed, 16
 Jul 2025 07:07:52 -0700 (PDT)
Date: Wed, 16 Jul 2025 07:07:50 -0700
In-Reply-To: <229325e8-a461-6e5c-0d32-1c36086b62f7@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250716055315.2229037-1-nikunj@amd.com> <229325e8-a461-6e5c-0d32-1c36086b62f7@amd.com>
Message-ID: <aHeyNvzvbgrWAob5@google.com>
Subject: Re: [PATCH v2] x86/sev: Improve handling of writes to intercepted TSC MSRs
From: Sean Christopherson <seanjc@google.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Nikunj A Dadhania <nikunj@amd.com>, linux-kernel@vger.kernel.org, bp@alien8.de, 
	x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, santosh.shukla@amd.com
Content-Type: text/plain; charset="us-ascii"

On Wed, Jul 16, 2025, Tom Lendacky wrote:
> On 7/16/25 00:53, Nikunj A Dadhania wrote:
> > From: Sean Christopherson <seanjc@google.com>
> > 
> > Currently, when a Secure TSC enabled SNP guest attempts to write to the
> > intercepted GUEST_TSC_FREQ MSR (a read-only MSR), the guest kernel response
> > incorrectly implies a VMM configuration error, when in fact it is the usual
> > VMM configuration to intercept writes to read-only MSRs, unless explicitly
> > documented.
> > 
> > Modify the intercepted TSC MSR #VC handling:
> > * Write to GUEST_TSC_FREQ will generate a #GP instead of terminating the
> >   guest
> > * Write to MSR_IA32_TSC will generate a #GP instead of silently ignoring it
> > 
> > Add a WARN_ONCE to log the incident, as well-behaved SNP guest kernels
> > should never attempt to write to these MSRs.
> > 
> > However, continue to terminate the guest when reading from intercepted
> > GUEST_TSC_FREQ MSR with Secure TSC enabled, as intercepted reads indicate
> > an improper VMM configuration for Secure TSC enabled SNP guests.
> > 
> > Signed-off-by: Sean Christopherson <seanjc@google.com>

Feel free to drop me as author and just give me a Reported-by or Suggested-by.
At this point, I ain't doing a whole lot of anything for this patch :-)

> > +	if (WARN_ON_ONCE(write)) {
> 
> Do we want to capture individual WARNs for each MSR? I guess I'm ok with
> a single WARN for either MSR, but just asking the question.

Or don't WARN at all.  If the caller is doing a bare wrmsrq(), then the kernel
will WARN in ex_handler_msr().  If the caller is doing wrmsrq_safe(), do we care
that they're being deliberately weird?

