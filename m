Return-Path: <linux-kernel+bounces-730228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E54BBB0418F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 16:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D82301A620D8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 14:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBCF2571B0;
	Mon, 14 Jul 2025 14:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xAmpuZYz"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE78253F2C
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 14:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752503094; cv=none; b=KfIwybBIhgB5EAhnMtXKUfZJAnZ0wRfrCfuRJfq3gUNmHtiD9gFTQbTEx8DpZ5fnR3p/3l0o/lurpp5fPwclqon9gpOjAg5CI1UUzs623qRXfcr1rKpNsHIksGV8LN3D7AS2Ldu1sMw6zp+TJJHIGrDsKuSQ12iDKHSepiu8bEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752503094; c=relaxed/simple;
	bh=AL0qcjismFyT4Br/slwPcT1SEZ/oQLYuSTq7ZqeHvxc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K97zay+jZQCBG5cLjwKkZSKA5Wrzz8/8vx4i/0PFrZNJgv8xFJfIbbH7khnEFDH71b8cGST5bB8PiOXP0IjjlPSQeFUdjBxBNq5YIasHctt0ERBmJp8ZIgGR3lbcAL2LtVDqElMKGlAD7PEgvDYjVMKA+3XSqka1eTi5Cm9JSKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xAmpuZYz; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-748fd21468cso3618716b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 07:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752503092; x=1753107892; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PjiIUolk8DPaMFwfYt8gpf4LXAA6kjVRpoDM1DpOaF4=;
        b=xAmpuZYz0YFLhkyIl2vAq4VZjWYmMUi3hVKqrs9IROz1izj+EhjuQOeC1cxM6mah2/
         IFh335a5Kl/tF9F8G28J7IEC6u5MqegRCp2Zsk7e7k1HJWP8EImoAYzOw1uKblWR1eyp
         3xh45fKGbZ/3JD3Ac7hPscmG8xSlZgPEqnJa74kXQjBmZf4NjwXB28UIpj8j8kVVAzgT
         ldR2jqeADuBOldMd7YmwCYMiyFXEDDT/78oMJoW4uvzEwg5zLXK+6hkdLRh8Lem+Uwdg
         7QovbmwepgN3grjw6LoKw7FNX5oVa45mDhMJMLTm5M03in2IUXmj1nR3bIweMDuyqt5p
         rctA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752503092; x=1753107892;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PjiIUolk8DPaMFwfYt8gpf4LXAA6kjVRpoDM1DpOaF4=;
        b=wOHPpvd/qHrUItzZzDZ6tHHazSN4ZmdErkblPo7/i/Auvvcp+yPPxt4E+5QaP/ZsT5
         jC0G0/OEk6I4BjKL7Iv2pO+e9mzR+0Esyw/IgSmhFxei74TUx+D7IlGTLZmFeKRfkCia
         4toASm5F8ckoPbpGNveiN8rSOaudmwy8zBXp7RlOLbbWXuvoqtQFdh3hr43g+kV3aqfY
         ncNg5NPx3ZR7Jx6RZL6k8j2wGeDnnPq4cptOz+oQPgV42wGykKnkMelclBWWsZ9walTy
         qtZpzpDkG1mdejkIDs2AXqUhiX7jAudwRjoui9kMBn6q69BKmuS0ECS6GhKvZH8gZull
         jH3w==
X-Forwarded-Encrypted: i=1; AJvYcCWELyvvtFzQq4IKNdVxeDwgmRLmgi2YQuTKNudob4gOTxqimSIyqVqjWj0FbODh3w6YnlLMcCTYHze+9Xs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUwGNHmmulx9gGoCAF5y9OgBqn3xJZyOx/WvtBsz2H5Blga0Y1
	ASbxTCR0VVgYeo9OYCjzemE/H833lJFkTQSMQXbaxSXUrw/g5BbXEszP/V7rWEb+HhuXFqw2BjM
	Y1ecQpw==
X-Google-Smtp-Source: AGHT+IEym4TQyl7FjcGITdRl9T7s7z7+/GywmdPKyKiwjQbO0AJBLH+3zv/9l9OzLRjdG7EkOo0Jge9aarE=
X-Received: from pfbhw1.prod.google.com ([2002:a05:6a00:8901:b0:746:683a:6104])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:230a:b0:740:b394:3ebd
 with SMTP id d2e1a72fcca58-74f1c5de456mr17586960b3a.7.1752503091994; Mon, 14
 Jul 2025 07:24:51 -0700 (PDT)
Date: Mon, 14 Jul 2025 07:24:50 -0700
In-Reply-To: <20250714104424.GGaHTfiFxI_pf-vhRn@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250711041200.87892-1-nikunj@amd.com> <20250714104424.GGaHTfiFxI_pf-vhRn@fat_crate.local>
Message-ID: <aHUTMiEJ-nd76lxM@google.com>
Subject: Re: [PATCH] x86/sev: Improve handling of writes to intercepted GUEST_TSC_FREQ
From: Sean Christopherson <seanjc@google.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Nikunj A Dadhania <nikunj@amd.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com, 
	thomas.lendacky@amd.com, santosh.shukla@amd.com
Content-Type: text/plain; charset="us-ascii"

On Mon, Jul 14, 2025, Borislav Petkov wrote:
> On Fri, Jul 11, 2025 at 09:42:00AM +0530, Nikunj A Dadhania wrote:
> > From: Sean Christopherson <seanjc@google.com>
> > 
> > For Secure TSC enabled guests, don't panic when a guest writes to
> > intercepted GUEST_TSC_FREQ MSR. Instead, ignore writes to GUEST_TSC_FREQ,
> > similar to MSR_IA32_TSC, and log a warning instead.
> 
> Why?
> 
> Nothing should poke at the TSC MSR and those who do, deserve what they get.
> 
> > Only terminate the guest when reading from intercepted GUEST_TSC_FREQ MSR
> > with Secure TSC enabled, as this indicates an unexpected hypervisor
> > configuration.
> 
> Huh, this sounds weird.
> 
> What are we "fixing" here?

Returning ES_VMM_ERROR is misleading/wrong, and panicking doesn't match how the
kernel handles every other "bad" WRMSR.  How's this for a changelog?

  For Secure TSC enabled guests, don't panic if the kernel hits a #VC due
  to attempting to write to GUEST_TSC_FREQ, and instead WARN and drop the
  write.  The kernel should never write GUEST_TSC_FREQ as it's read-only,
  but panicking with ES_VMM_ERROR is both misleading (it's entirely
  reasonable for a VMM to intercept writes to a read-only MSR), and
  unnecessary, e.g. the kernel eats #GPs with a WARN on every other "bad"
  WRMSR.

