Return-Path: <linux-kernel+bounces-744934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA23B112BB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 22:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0732F7A5ACF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 20:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7535827702F;
	Thu, 24 Jul 2025 20:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XWdD4XZr"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B19231840
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 20:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753390728; cv=none; b=Ar6KBPhMATlXEJ35/90Q5cds2CBcpVco84JxZldljtZnPwEQu3K2Pn9EkbcNzJwCIUnuHHTh0QGxgNu35hYWw8z0ZhDgnOOpV3d4Ujgein+rNfhrfsmde6fsRRazHyc1KmNKgE1H8nxcMdn8Xp6CjItMY3L08vmxIuPpWHeKktw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753390728; c=relaxed/simple;
	bh=cyO7L9yYcKPjjy+NefV6hDuPIR264Y/WcXCJuKdz9uM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Sx+iscw5Moi5l4flYdSo1NJ8qpaGEuMKACOHLq2U7IaWBbtHu5/ru7M+aso7BqrvqOqCjkcRX+B18QpFAR+3maxw5eqHDG3CHEcrvbIcUZxLkoVK3TYbWLCbWCDVQjepcFem6hN1+so/dJgH3ZN95/qhLr2wXhxj9tPEGKIqznU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XWdD4XZr; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-313fb0ec33bso1643800a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 13:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753390727; x=1753995527; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=njtRraa3yeDh+Mc2BX5WYec5QxIq/WkdRO/yIMvTr98=;
        b=XWdD4XZrSCFOQkgY1PPHqv2lfnsOh4Gxlj6YsvIUSclFOS27dp8wpqykgXd7A2+98+
         G0nbpct7hElztqurp3+AlXPdC0cWBqp5YuRgZzzb7jziWJ4iTL/D0u/tF6JWIWspjBzJ
         4NoUbixhn6nInYrTwnLlofXiTZGDmlqzP7zJfMreeBZqWRUGVX9RbX4H+mANE8yXZ0wd
         kkkgOjfERYEpim2Zh4nhIz40pyvoSgBPtIFoLqkFK7qyMmqaSFkLT+KmIvfWZDOtZH/0
         /5FswY+Hn98hld2Ultytc/ZfxJzBkXtGzJyEqEPxCHIBGOT39sYtOk0zvkYGDRDR13Qy
         w6hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753390727; x=1753995527;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=njtRraa3yeDh+Mc2BX5WYec5QxIq/WkdRO/yIMvTr98=;
        b=ss+x8UhLOi0U16bScGlkUM3n5mE/H/7/p933f6GVvengzb3KLR7ofn5BQB4evdZJA1
         zIIu1IhWpscFnda0vvkYmvf/JnyjmU7eT4CaQhlFJU96wbJv7LihzsplGQn3H2mQWmlo
         1Nt6V7SwwTf5tQPBD9q33yulXTos7fGtON/PpYFKckPtvmgwThqxQmalvLHSDFmPKRne
         MovnLws0RSF6dF0gVgSCvYm3qewFW5KBVRzckEqo5pAlOX+NdXivgV5OwKo19PzWFBo5
         UKgLzyJbvwvGVeNECOBr8FBU97qw+3F1JZMGBEnLFQDebEYt1L/1jPzZfLoJk87NSGzU
         1M+A==
X-Forwarded-Encrypted: i=1; AJvYcCUUI0XeTpbhfBjnXawMh42o2KLRhGRh9l/dyj8CpimbvrQS+9nFLe4SebpgE+g4gpPdmz9lu1TCqXMnUQw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yytzcld2TJTlzesWNz++IImdmawUpB45V9KWJjyv5E4ypfIYSzM
	d9zruiO/dzgcPa9n3PWavBQmCW2IZD6ngj9prj49weQr4qQWz3MFkgqMuD5p+Y4qBPkKptVi6Bg
	7s8nLYw==
X-Google-Smtp-Source: AGHT+IHonk8y2V0EPehspPsFSLsvcO05OzPpzTiZDecGiCSRMrTE72dXrjsNEv9iHbfHB3ZX17mg0IKKhH4=
X-Received: from pjv5.prod.google.com ([2002:a17:90b:5645:b0:309:f831:28e0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3844:b0:315:6f2b:ce53
 with SMTP id 98e67ed59e1d1-31e507dc1c7mr10900583a91.25.1753390726710; Thu, 24
 Jul 2025 13:58:46 -0700 (PDT)
Date: Thu, 24 Jul 2025 13:58:45 -0700
In-Reply-To: <27E487FE-EC8D-42AC-B259-F8A18776C802@alien8.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250721181155.3536023-1-yazen.ghannam@amd.com>
 <20250722165615.GCaH_CryG7kNrAS4O6@renoirsky.local> <20250723183426.GA1158000@yaz-khff2.amd.com>
 <27E487FE-EC8D-42AC-B259-F8A18776C802@alien8.de>
Message-ID: <aIKehTDgP-Nu36ol@google.com>
Subject: Re: [PATCH] x86/CPU/AMD: Ignore invalid reset reason value
From: Sean Christopherson <seanjc@google.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	Libing He <libhe@redhat.com>, David Arcari <darcari@redhat.com>, 
	Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Jul 23, 2025, Borislav Petkov wrote:
> On July 23, 2025 9:34:26 PM GMT+03:00, Yazen Ghannam <yazen.ghannam@amd.com> wrote:
> >On Tue, Jul 22, 2025 at 06:56:15PM +0200, Borislav Petkov wrote:
> >> On Mon, Jul 21, 2025 at 06:11:54PM +0000, Yazen Ghannam wrote:
> >> > The reset reason value may be "all bits set", e.g. 0xFFFFFFFF. This is a
> >> > commonly used error response from hardware. This may occur due to a real
> >> > hardware issue or when running in a VM.
> >> 
> >> Well, which is it Libing is reporting? VM or a real hw issue?
> >> 
> >
> >In this case, it was a VM.
> >
> >> If it is a VM, is that -1 the only thing a VMM returns when reading that
> >> MMIO address or can it be anything?
> >> 
> >> If latter, you need to check X86_FEATURE_HYPERVISOR.
> >> 
> >> Same for a real hw issue.
> >> 
> >> IOW, is -1 the *only* invalid data we can read here or are we playing
> >> whack-a-mole with it?
> >> 
> >
> >I see you're point, but I don't think we can know for sure all possible
> >cases. There are some reserved bits that shouldn't be set. But these
> >definitions could change in the future.
> >
> >And it'd be a pain to try and verify combinations of bits and configs.
> >Like can bit A and B be set together, or can bit C be set while running
> >in a VM, or can bit D ever be set on Model Z? 
> >
> >The -1 (all bits set) is the only "applies to all cases" invalid data,
> >since this is a common hardware error response. So we can at least check
> >for this.
> >
> >Thanks,
> >Yazen
> 
> I think you should check both: HV or -1.
> 
> HV covers the VM angle as they don't emulate this

You can't possibly know that.  If there exists a hardware spec of any kind, it's
fair game for emulation.

> and we simply should disable this functionality when running as a guest.
> 
> -1 covers the known-bad hw value.

And in a guest, -1, i.e. 0xffffffff is all but guaranteed to come from the VMM
providing PCI master abort semantics for reads to MMIO where no device exists.
That's about as "architectural" of behavior as you're going to get, so I don't
see any reason to assume no VMM will every emulate whatever this feature is.

