Return-Path: <linux-kernel+bounces-865755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3FFBFDEC0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 20:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5E7E24E3B88
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 18:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8977334D4E2;
	Wed, 22 Oct 2025 18:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q7BXlNau"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8DE2ECD33
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 18:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761158777; cv=none; b=hooKowVNGyAO4SEkMvozWiq/OcTYCS4xBLZckgq/x87JKtTNDHO8eZLZ2mtIPpRSoHNmGVmdvAcBl74Cok8HXU3KL1mMHKWceJf9+AAui64w6TrISGDui2MUBeqQaETfzzNpxgvzN1fKvZzsSBmcpL0JHRcdHnS5ByYPwUMgppY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761158777; c=relaxed/simple;
	bh=5EpN3tBp41Rek+sTZqlNQydypqmiRlkRRwpgl3gWh1M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G49smPsIr5otmmcud+J+xTroIzs3YKvrZ27ORhaJ0YrO/JmHfuSLJah8zx2K0IbBc+OPZTVbTwA62lYokmEPUXU50NF/Cjjm4xqJAz+j0eJN+0ZbqIVwizrdffYB/4pWkWP0qGxrvT7KZlVH7FyA/8b8N2jomVUVTz2UNkL0dhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q7BXlNau; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b6cf1b799dcso194320a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 11:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761158776; x=1761763576; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y5LU3IumH/ybekjL605GOzLVsbqQp3MsudwytfNYQFY=;
        b=q7BXlNauDNA1IANRrj9R9SWi1tV9yrFXaDWtP/iRVVUBfn0Hy9bMMI4SETNYXQpKO5
         hkw2GhJpERFAzoJxrnXhZ7bhdaknaWwuHdxs8RMk2WB6daYEFhWqNx7IHzv+/2zSnN2S
         OUJ0Z+hem0wB1UjUfmXaID5CV5d93HsrdL0Oh+WhMjLTLHkqr6koccDoHGMEEoEBcmR1
         46/4sSjn3cspEXTZArWdXurLqvi5P5WDAnL/Gj5ator7GBuwY/6xVgRhwjTjGdp5giCm
         UFazpns9cqVzHVK65z5zigNWzK5RDyY0bhLOIvJGvJtKzlgp4N1MMptbqbEADc5kqrYW
         o/Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761158776; x=1761763576;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y5LU3IumH/ybekjL605GOzLVsbqQp3MsudwytfNYQFY=;
        b=l+i6/iAQna7yhUw+sxF8VnijpLEgT7WewQfuxA5+sP33RS7rxfnV9YduMJRIsiT7kG
         Jc9jPkpDsFO+T15FlCJZveHjwtWrkP9uqJuBjxX5m+fNRaMmXs3VacI7y0GdM7FTFuxU
         PdASbbLAm850eF0c6FGQIx1b8Q+OHbLoudyaKm1VvPrHctsCIkzfhdvDCu7eNtH1tYJ0
         50HtzPT5ZznlxqoXDLwrzTqq1NoX27ngTgu1+7NLMbT7fp5eLbfsmH7Pe5HnrKMk8viO
         4tYmX3bGPyKHJE5Fe58txyDfPL0qsPXkYiAkmyHkoVbedhBq56XtYlQneaFH0+Xh7gP6
         iK7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWoqBVuWtY2RT0F5+oKQv2MYJbHcBIsZg5WO3qGyntADk4mGIQVVogjn/E2uShuDJLLuPkSAiOWcXM9xzU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5mQtdv5+/A1BvgWdK3ww4A0PXvE/00I/3RnbLPbKEYIXUyyvI
	SsvwkN+LOKGdjqlBgWGp3HcyEXmBR5SFYEAu+s4GTOGiXIB63qsTaZ0F0ICzYijTVM4gELxfqV5
	n2eVbjw==
X-Google-Smtp-Source: AGHT+IGZcCmPNTyYelUhOZ+RcEbayx11WFQSaVwU+Yrmb47JNxNNavWgCeScqZcEPGI7kg/CaUjf/Kp5mDE=
X-Received: from pjdq23.prod.google.com ([2002:a17:90a:2e17:b0:33d:9628:960e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:52d0:b0:332:1edf:a694
 with SMTP id 98e67ed59e1d1-33bcf8fbbd3mr23327257a91.31.1761158775693; Wed, 22
 Oct 2025 11:46:15 -0700 (PDT)
Date: Wed, 22 Oct 2025 11:46:14 -0700
In-Reply-To: <48d66446-40be-4a4e-a5af-c19e0b8d9182@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250910174210.1969750-1-sshegde@linux.ibm.com>
 <aPZIGCFk-Rnlc1yT@google.com> <48d66446-40be-4a4e-a5af-c19e0b8d9182@linux.ibm.com>
Message-ID: <aPkmdsnG1qsaW3Ro@google.com>
Subject: Re: [RFC PATCH v3 00/10] paravirt CPUs and push task for less vCPU preemption
From: Sean Christopherson <seanjc@google.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, tglx@linutronix.de, yury.norov@gmail.com, 
	maddy@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, gregkh@linuxfoundation.org, 
	vschneid@redhat.com, iii@linux.ibm.com, huschle@linux.ibm.com, 
	rostedt@goodmis.org, dietmar.eggemann@arm.com, vineeth@bitbyteword.org, 
	jgross@suse.com, pbonzini@redhat.com
Content-Type: text/plain; charset="us-ascii"

On Tue, Oct 21, 2025, Shrikanth Hegde wrote:
> 
> Hi Sean.
> Thanks for taking time and going through the series.
> 
> On 10/20/25 8:02 PM, Sean Christopherson wrote:
> > On Wed, Sep 10, 2025, Shrikanth Hegde wrote:
> > > tl;dr
> > > 
> > > This is follow up of [1] with few fixes and addressing review comments.
> > > Upgraded it to RFC PATCH from RFC.
> > > Please review.
> > > 
> > > [1]: v2 - https://lore.kernel.org/all/20250625191108.1646208-1-sshegde@linux.ibm.com/
> > > 
> > > v2 -> v3:
> > > - Renamed to paravirt CPUs
> > 
> > There are myriad uses of "paravirt" throughout Linux and related environments,
> > and none of them mean "oversubscribed" or "contended".  I assume Hillf's comments
> > triggered the rename from "avoid CPUs", but IMO "avoid" is at least somewhat
> > accurate; "paravirt" is wildly misleading.
> 
> Name has been tricky. We want to have a positive sounding name while
> conveying that these CPUs are not be used for now due to contention,
> they may be used again when the contention has gone.

I suspect part of the problem with naming is the all-or-nothing approach itself.
There's a _lot_ of policy baked into that seemingly simple decision, and thus
it's hard to describe with a human-friendly name.

> > > Open issues:
> > > 
> > > - Derivation of hint from steal time is still a challenge. Some work is
> > >    underway to address it.
> > > 
> > > - Consider kvm and other hypervsiors and how they could derive the hint.
> > >    Need inputs from community.
> > 
> > Bluntly, this series is never going to land, at least not in a form that's remotely
> > close to what is proposed here.  This is an incredibly simplistic way of handling
> > overcommit, and AFAICT there's no line of sight to supporting more complex scenarios.
> > 
> 
> Could you describe these complex scenarios?

Any setup where "don't use this CPU" isn't a viable option, e.g. because all cores
could be overcommitted at any given time, or is far, far too coarse-grained.  Very
few use cases can distill vCPU scheduling needs and policies into single flag.

E.g. if all CPUs in a system are being used to vCPU tasks, all vCPUs are actively
running, and the host has a non-vCPU task that _must_ run, then the host will need
to preempt a vCPU task.  Ideally, a paravirtualized scheduling system would allow
the host to make an informed decision when choosing which vCPU to preempt, e.g. to
minimize disruption to the guest(s).

