Return-Path: <linux-kernel+bounces-824724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C141B89FEF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 16:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03F9E166454
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C44315760;
	Fri, 19 Sep 2025 14:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ive1AxkN"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B27430F541
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758292279; cv=none; b=fHJmwm3i4ruJJt9yicaCxK5w+wGS8gHmsU+xpuT6h/4QX3HceZdNPqU6h1CYVPdeze59BjKCMcnab11UuXmqY7PD+Re2onmk2MQid5//1hIRr0Ar41+6vZIbcwRPSVgCaXvbNol1GVWoF9nahUYNFk1Hoxn0PloVod4+r+zCnHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758292279; c=relaxed/simple;
	bh=BSz5ZqZ0glHCz/O9VXnR0T9lJTXY6DFyO6jwFayHnX4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=PlQB/JbTXa2jM3h5st1lXFqEpinsm4bGrIJkegeeH1frucVSaV0JzEv/Dcvz3TI/QEKWXcQ1OuHy47lnlxb7Epm1kZQlbk0Jkq1X31gQC4bgl4f0DKKKIY2ASA4VtXs9kmOKxbNX2NdNUbwTtRDrvamfvCCnm0uIemPDHxSXfZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ive1AxkN; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32edda89a37so2199075a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 07:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758292277; x=1758897077; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TRKUeIPuLfgTD3Ji8hPzrm3593uacvCQqcFOb79bZss=;
        b=Ive1AxkNqzI0zESMVBaMXYeF244MOU+Qet+nVlVxYmQ/NMcFI/i6+f34nWxoJ38Swh
         3jH+ddid7uZC3ZbUrulEllhlHypHcEjR4pA4iRgtdg1a2zeB9xmjWr78FAjbwhQ+ukxG
         BpjK3YIYXrgeIhORDQmwhzM+NFEwXPlvS/YOm/Rv1+JBVfvjSBJV2lQk9Ma6BxNpMmOO
         U/JOJHE2odzRQjmi67WMIjqR9P1p0SVm0aqCgGMMYj2WnN+EpZRPqkBrWz1l6wLSYn76
         pvO6KgzDsy40qGoI/3nRYeZRhXwptjichbyMHT2vSoc0Ax/4m3SoeMq81R9N9KUm+K7i
         fI+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758292277; x=1758897077;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TRKUeIPuLfgTD3Ji8hPzrm3593uacvCQqcFOb79bZss=;
        b=tkkXJxoZNmfAjeewu05t0ds6B6+MH8X6SlQtFu/o0bhU7eHmGjumvnpffjWBEbv84B
         s0xPdqZs8pzahKuxzHqtbz6oJwdTMZDEe7fyQny3ick1VFh5KgLEQO65av1Hua37Gx40
         XZoySnCddkLQf8wNl1I4/5ACRJ8ZMl199KtUcJon2BzMmd4fspUgTvqIptcgUqHDrPpM
         8kYwdE0Fe/eTc47rhNUCqSutARud9wLxNWBqBPbfOcicVGRNRPtVmG/YxTxJMn+aDoZS
         r6BBZEFLfVfoBrfvtJuEA9ccNOoQPMuewu75QEr8rQGeGiT9/MvwuLgD4prHpk4P0ROL
         s8cg==
X-Forwarded-Encrypted: i=1; AJvYcCXZ+x3zn1yQQkKl8ukyN25vtuaz2thjQosz6X5FADUcs2cPpWzokm9n3ZnALeI3roo93jnbYf2nZMrgkxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsURgnlI0SjQdJqo6YjmYCwZ/05rT91/CDYWMy+HEWyk1T/XIk
	ZeWBNHH329mCZXvildlqmyLtM/J+pZaKC9KbBreg2teVILMEb8r5bDurxLFyWxm0+pijEE0g6Xz
	I/Ck+xg==
X-Google-Smtp-Source: AGHT+IFGhuQ8bD+WT2kJZruj5Cd3iaM/mscEBLG6W6rRQqv7ludOgUnm0Cofpfm9CKlpm+M1BY5Xq3lt1Lw=
X-Received: from pjqq8.prod.google.com ([2002:a17:90b:5848:b0:327:4fa6:eaa1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2688:b0:32b:bac7:5a41
 with SMTP id 98e67ed59e1d1-330983a13c6mr4788215a91.37.1758292277567; Fri, 19
 Sep 2025 07:31:17 -0700 (PDT)
Date: Fri, 19 Sep 2025 07:31:16 -0700
In-Reply-To: <20250808172358.1938974-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250808172358.1938974-1-seanjc@google.com>
Message-ID: <aM1pNN_ById_l6xR@google.com>
Subject: Re: [PATCH 0/3] x86/umip: Fix UMIP insn decoder false positives
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	Dan Snyder <dansnyder@google.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Aug 08, 2025, Sean Christopherson wrote:
> Fix two false positives scenarios where the UMIP #GP logic will incorrectly
> trigger emulation, e.g. due to a partially decoded instruction, or on
> instructions like VMLAUNCH that usurp the register form of '0f 01'.
> 
> Tested with the hack-a-test patch at the end, but I haven't done any testing
> using a real userspace (neither positive nor negative testing).
> 
> Sean Christopherson (3):
>   x86/umip: Check that the instruction opcode is at least two bytes
>   x86/umip: Fix decoding of register forms of 0F 01 (SGDT and SIDT
>     aliases)

Ping on these two, looks like they slipped through the cracks.  FWIW, I wouldn't
consider these urgent enough to squeeze into 6.17, but it'd be nice to get them
into 6.18.

