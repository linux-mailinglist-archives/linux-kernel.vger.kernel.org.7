Return-Path: <linux-kernel+bounces-671170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A28DDACBDB6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jun 2025 01:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E0573A34BF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jun 2025 23:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D77C1EDA3A;
	Mon,  2 Jun 2025 23:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j9RyeHCN"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F808A920
	for <linux-kernel@vger.kernel.org>; Mon,  2 Jun 2025 23:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748907698; cv=none; b=kcpuVJoW9Nibntyghsys8xnQUa7LB5dfaPTLT0N5lnAWvOeFBYgfQc7FC7bYpFXR00TdidIUUlp9CkUWJl1pT3cnWQDkhTidWzPcM5l5rKk+SwIfZgk/Hl+FAdEit6RUuT8KOpjXykFbOsm4xm3mmWduo84g5C22rasRK+4UgY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748907698; c=relaxed/simple;
	bh=fMKS8WACMDtPAXmZ9MQI+ToMVGwyvZqRwVy5JyvSz3M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J7dPS+8b7SGgikvcWkJSQoqG1UToU0SwsKgMYpCv8xvbaOyLyuahl7eR4G+F6xoJWeqPOQcpQhCdevX/KpxyjmcPtmm8aZqzuqDcW4DIqrbkXMI/HH51UcgHJ8A75myXFj1vwjOc5+Lm2JdvRXQ7Ci39cuUDCssdyinBlO35aos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j9RyeHCN; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b1ffc678adfso3085481a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jun 2025 16:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748907696; x=1749512496; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5aK/ClnEO1BHlKYU0vEB7Daj0M2CFLLL/QgF7WVTiw=;
        b=j9RyeHCNQxtwGuOZDNSQZX9/ggqXgsf+DUc9CNMCJD3gGvtcPUnb/i79frDWu1vwIH
         8XEHAnuRavj3FqlgjMfsCqtArv4heQLDHHELwrlJGlBizL4KsgSsasr9q9sWWLjE9yKc
         4gSq9V+HFea55/YWEngXj5CtLEt1LljzxZKvyVrHDhoJXJ2bq432O/vF+Jb4853BEmRA
         x+Uz/Jx2UNpjESjdsfMKJyyUZEQ7jOT8zvKP5Q9jyn7PVKZ7IebdK8cM/08uVj76yDOH
         PHHEQ7VsYfOW/+weUiTMnsGthSn5CbeMtE5uZjNoKg/V3QsvYYp7LerdOe5VAYSHcRKF
         yv3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748907696; x=1749512496;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5aK/ClnEO1BHlKYU0vEB7Daj0M2CFLLL/QgF7WVTiw=;
        b=HrVqq2lkhVx187N6e5a37ZviMewxEvusOc780yxaUBMFJ2Xc/xgexzZOBUaWZ61Heu
         Xz2WZarK/h5Aml9ETe+Al8SGgcx3JOiPAI/gAqscnOfcThHCiLNWZ2jTgq66+l+lnL4I
         NIbV6sYjWL9DSgPvJLIPMNFX/o8ke/AwqgPtxBjNtmXGybsjsteruJRgNdR5JarzPrQW
         XVMUIHSMFLHFi+nPflTND6MJlDmY3cCkrtPlpcBcrpWyWh37o4DvtyML4ybC117pSHlm
         N878Ap2JHSEo6xlNY1KD0fOqPToBOQcOnooflApSvkxmhHAB8asv86si2lQuKxoFAqzA
         RMRA==
X-Forwarded-Encrypted: i=1; AJvYcCUXMLV5BAHamGoYTwWiPfspaX6MuEUaiQ1HfE0yI0e3EvAjThp0yZbIOWKmv5213S6RLPWb5Bxx69Ckl1E=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf7Xtg8HHF5asbnskrep0Z5G3EdAP1CJH3G2A4vqRpG6P2FlMw
	OT3eSrm7QTWuAVGZR+NeOD7dsTqftfKG66xOh2tKNSBrq6UuZRlw8fV8WVqPmMdA3edO1Lst/pp
	aU5suqA==
X-Google-Smtp-Source: AGHT+IG5ru2XR9cFkpu7bGl5YyCVbeXqLm5BUr9HX9PzTeqwFZg21QzASeGhlFnT2eYIHHgeQPt8CEsJnxQ=
X-Received: from pji6.prod.google.com ([2002:a17:90b:3fc6:b0:312:1900:72e2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1810:b0:312:39c1:c9cf
 with SMTP id 98e67ed59e1d1-31241101002mr24531531a91.7.1748907696630; Mon, 02
 Jun 2025 16:41:36 -0700 (PDT)
Date: Mon, 2 Jun 2025 16:41:35 -0700
In-Reply-To: <20250529033546.dhf3ittxsc3qcysc@desk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250523011756.3243624-1-seanjc@google.com> <20250529033546.dhf3ittxsc3qcysc@desk>
Message-ID: <aD42rwMoJ0gh5VBy@google.com>
Subject: Re: [PATCH 0/5] KVM: VMX: Fix MMIO Stale Data Mitigation
From: Sean Christopherson <seanjc@google.com>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Borislav Petkov <bp@alien8.de>, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, May 28, 2025, Pawan Gupta wrote:
> On Thu, May 22, 2025 at 06:17:51PM -0700, Sean Christopherson wrote:
> > Fix KVM's mitigation of the MMIO Stale Data bug, as the current approach
> > doesn't actually detect whether or not a guest has access to MMIO.  E.g.
> > KVM_DEV_VFIO_FILE_ADD is entirely optional, and obviously only covers VFIO
> 
> I believe this needs userspace co-operation?

Yes, more or less.  If the userspace VMM knows it doesn't need to trigger the
side effects of KVM_DEV_VFIO_FILE_ADD (e.g. isn't dealing with non-coherent DMA),
and doesn't need the VFIO<=>KVM binding (e.g. for KVM-GT), then AFAIK it's safe
to skip KVM_DEV_VFIO_FILE_ADD, modulo this mitigation.

> > devices, and so is a terrible heuristic for "can this vCPU access MMIO?"
> > 
> > To fix the flaw (hopefully), track whether or not a vCPU has access to MMIO
> > based on the MMU it will run with.  KVM already detects host MMIO when
> > installing PTEs in order to force host MMIO to UC (EPT bypasses MTRRs), so
> > feeding that information into the MMU is rather straightforward.
> > 
> > Note, I haven't actually verified this mitigates the MMIO Stale Data bug, but
> > I think it's safe to say no has verified the existing code works either.
> 
> Mitigation was verifed for VFIO devices, but ofcourse not for the cases you
> mentioned above. Typically, it is the PCI config registers on some faulty
> devices (that don't respect byte-enable) are subject to MMIO Stale Data.
>
> But, it is impossible to test and confirm with absolute certainity that all

Yeah, no argument there.  

> other cases are not affected. Your patches should rule out those cases as
> well.
> 
> Regarding validating this, if VERW is executed at VMenter, mitigation was
> found to be effective. This is similar to other bugs like MDS. I am not a
> virtualization expert, but I will try to validate whatever I can.

If you can re-verify the mitigation works for VFIO devices, that's more than
good enough for me.  The bar at this point is to not regress the existing mitigation,
anything beyond that is gravy.

I've verified the KVM mechanics of tracing MMIO mappings fairly well (famous last
words), the only thing I haven't sanity checked is that the existing coverage for
VFIO devices is maintained.

