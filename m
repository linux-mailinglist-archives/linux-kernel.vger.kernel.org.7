Return-Path: <linux-kernel+bounces-740985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D24B0DE58
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 16:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4A1D3BA2C5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 14:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B432E1724;
	Tue, 22 Jul 2025 14:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PDQV1Dwf"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079921D6193
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 14:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753193628; cv=none; b=izi/Xpqbf1pNmH21lc7LdZe8aZCwrpodWInoKI90jdtMVmHWyLZDUrIjZT6EeSUG7r9zcyKAbGJUJIrNeljGRJzFGI8GLZeLFFpiOWG5WrpMl40fwCXu0DYPWkfVzHLg4TGuZ3xaG2dglJEabr2lTAS790ipYvRLFizJdKBc+Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753193628; c=relaxed/simple;
	bh=SIVeV/5x+C+aiI03S1yS9XTn1eCXwkQ8UaH2ikV0LOM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JGpeV8R8uZHXzuPUKzG4EhiWx+MPOxucdb9sOJt0X4NNqu5CFDnVxy9Pq5CEuJLwynTKg4z893D0xCHmqiaeqN9QLa48SnNn6UkXAKsOZw0gvjg3954icWz0a88VADhQz1hv2OsQXzmrJ/sagBCPg+xoKeHDe9gtciqY9ZFNoJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PDQV1Dwf; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b38ec062983so3811760a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 07:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753193626; x=1753798426; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=20QLCvcSY004GezKtjT3+306FnS1qCy6LGwEuBD+8PQ=;
        b=PDQV1DwfZmU8I+tEYB/6rFr8+Qw6rWmy+NVOPOo0aZB+O44qLApABV/adtGv75mAq7
         VaxGD/GhCXpP4AtG+Uqn/SI1qpeDDfdhdY8j9hi7TSRJa2lsrBC+Ig3AxSnTrPJlM7z3
         l7VRiodD2P1IELY9NSw0Z3VNAF5DJhgW9PznBeEriaYQWrS5NR3wFNTBVEdGWAjcLrR2
         zmoQY4satICRkCvknv1cVomSxFSA/kNyY57al7XsGsEsl2NbCEeEpkiGqLs/Gx6yNkJH
         9yCtmJcauJn2Qe5mAPy1vX4P/U8c+PLU43mcm8NAGX+1Kt/+TjPFRwByh94I02dqscOf
         kl4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753193626; x=1753798426;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=20QLCvcSY004GezKtjT3+306FnS1qCy6LGwEuBD+8PQ=;
        b=D0fSEpdPER7yorIlpCv/8HUkuoZtotNqLeR2pBt1/EJYmyliwb8Cse2SPt8M0oM28X
         xnzlrJKDrE2zuYo8Wu6ax9jHkqWohGtHP6Jvu4ZaF2WSg36UJQcx0kCAwQSxqnrYAUdG
         Wx6IHOd7Sq+eY+ui409gnyqshkExAMA8ZQoTnEnnc01h/4W+KWkvIEzlF/UFZxYBfO2P
         zlGFdwDHODGI2Qw2urXJ9EFJgOLd2GNOVfsKlnQZwfk2awBq2TQE9I0hwG1IPPYEmMEX
         jOXQC96HW/x5kY0NrQ5f6/3JFoVWgHCxSMzrqla057gBDrNBFP2jAbXFbumI0wvW4fxZ
         oESQ==
X-Forwarded-Encrypted: i=1; AJvYcCWH3h3ylUexoy7rriqafUXlYNB9acLO2uNMkll3yTwWBRvjG1p0xxIVgmZ2UaECZOtw0lgniW3cgBw1HkA=@vger.kernel.org
X-Gm-Message-State: AOJu0YydMSd75SXeFu2twqUEi1k3RaGTz2D2axNU7vuGkyzImYRPQhUb
	h6JcegZWwKm926lqhDCVCdnwjRDUbAqD/iwd3/+YM6M8svzcjFZZZQGGgYiRbmEE0c1QMC2ZXLm
	+00vm1A==
X-Google-Smtp-Source: AGHT+IHfoyKyRi4QOiUDSxvjqgLFDO1L/1RhSMjfXAzLTeEHcAyBHXnbeLhZO6F6DXRrf5fW+BcFtbQoa1I=
X-Received: from pjh16.prod.google.com ([2002:a17:90b:3f90:b0:312:eaf7:aa0d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1c04:b0:312:e9bd:5d37
 with SMTP id 98e67ed59e1d1-31cc2515a29mr24112775a91.6.1753193626228; Tue, 22
 Jul 2025 07:13:46 -0700 (PDT)
Date: Tue, 22 Jul 2025 07:13:44 -0700
In-Reply-To: <96a0a8b2-3ebd-466c-9c6e-8ba63cd4e2e3@grsecurity.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250704085027.182163-1-chao.gao@intel.com> <20250704085027.182163-20-chao.gao@intel.com>
 <4114d399-8649-41de-97bf-3b63f29ec7e8@grsecurity.net> <aH58w_wHx3Crklp4@google.com>
 <96a0a8b2-3ebd-466c-9c6e-8ba63cd4e2e3@grsecurity.net>
Message-ID: <aH-cmDRPPp2X7OxN@google.com>
Subject: Re: [PATCH v11 19/23] KVM: x86: Enable CET virtualization for VMX and
 advertise to userspace
From: Sean Christopherson <seanjc@google.com>
To: Mathias Krause <minipli@grsecurity.net>
Cc: Chao Gao <chao.gao@intel.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	x86@kernel.org, pbonzini@redhat.com, dave.hansen@intel.com, 
	rick.p.edgecombe@intel.com, mlevitsk@redhat.com, john.allen@amd.com, 
	weijiang.yang@intel.com, xin@zytor.com, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Jul 22, 2025, Mathias Krause wrote:
> On 21.07.25 19:45, Sean Christopherson wrote:
> > On Mon, Jul 21, 2025, Mathias Krause wrote:
> >> Can we please make CR4.CET a guest-owned bit as well (sending a patch in
> >> a second)? It's a logical continuation to making CR0.WP a guest-owned
> >> bit just that it's even easier this time, as no MMU role bits are
> >> involved and it still makes a big difference, at least for grsecurity
> >> guest kernels.
> > 
> > Out of curiosity, what's the use case for toggling CR4.CET at runtime?
> 
> Plain and simple: architectural requirements to be able to toggle CR0.WP.

Ugh, right.  That was less fun than I as expecting :-)

> > E.g. at one point CR4.LA57 was a guest-owned bit, and the code was buggy.  Fixing
> > things took far more effort than it should have there was no justification for
> > the logic (IIRC, it was done purely on the whims of the original developer).
> > 
> > KVM has had many such cases, where some weird behavior was never documented/justified,
> > and I really, really want to avoid committing the same sins that have caused me
> > so much pain :-)
> 
> I totally understand your reasoning, "just because" shouldn't be the
> justification. In this case, however, not making it a guest-owned bit
> has a big performance impact for grsecurity, we would like to address.

Oh, I'm not objecting to the change, at all.  I just want to make sure we capture
the justification in the changelog.

