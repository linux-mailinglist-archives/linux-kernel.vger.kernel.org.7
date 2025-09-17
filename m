Return-Path: <linux-kernel+bounces-821713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E94B820CC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 23:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EAA51C225C5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 21:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D0B30C60A;
	Wed, 17 Sep 2025 21:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cLILqsL6"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150C93043AC
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 21:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758146189; cv=none; b=dphGa34qBWwaLSw3rXBkk8O/ddXJt3uYpdAJ2h4JI5jn+Ev2i5UzyJanyAW9Z0JpsDvteEHcpFBBaZLxjr7J/5RifSN/yxS6k6l/T3QcgRooH8MgMeYBZ9JbrdII4R8ph7ahWQYt4uny75oDvKjGTJwy1s3aaZian2kvWQEbo+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758146189; c=relaxed/simple;
	bh=ISMK7DM43Nk4mIV0A/GH5D71wvjF9kfvLj8iGbNKtas=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UkkT/4S684yt/KgZjezU82c5fBJTLNPWcQDZ0/X01JCdAJ6pq0BJ8SGha3fbXqS7cCrO1CL0MoXk5F72kbepgQBQmi1lggJaDwn9DA0lGd1mm3qr9mMzIp1ZXZmfxakH4FQriAsIagWYWvgCazrLXg7IM7BYLipYCvKPIMMa8Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cLILqsL6; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3234811cab3so220241a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 14:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758146187; x=1758750987; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nEBSWYKD+SqnMEh1+pQSHNZcrfb8li51aiqDJLMcodY=;
        b=cLILqsL6p1LsctF5I8ga5NcvgrJs4o0v3v2cyNFUtLb75StqKG/cJ8NsiEOfsASRLW
         uzTHzFReXaT2ImvmpIkPpOPuJPh2Sr9yAW947OQ6ccSYmTNAPbmIs9MjgcXeOp0EPRf0
         8YgX4Zgxjirv77Exe41hXPF7cyif9d7EsGsF9VwLXl0FbPRlaFt03sCZiF6BwP8BodEH
         nieYtdB4B6As2pKMpCWz9xXo84nWW0dB6Hy81hoIp/RhsBk5CZC/y9/sSZSebW0vN6n7
         oC0DaFWxHQG0XqNuObxEBNGEKhlraXYlZpVPVPLG4zW8X6SbVBKLlVV3pTaSfkcmkakJ
         5Pww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758146187; x=1758750987;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nEBSWYKD+SqnMEh1+pQSHNZcrfb8li51aiqDJLMcodY=;
        b=W3ixmJQFslh/QZezT4xC7GZxF9uJnYkA8rH6qMCWrnHyP60q2rQLRyghDQoQLcz1Rk
         Dho/szuiNdwUgGJPbWQ5ILScaLsOIOMaKC6IsxRMHyEzRrVlPIGkRtzyelPLuLb1ivTJ
         YdpA1tz+lHhqRTPskcBrzJNHSmzMYaAU42E4kftOmjMYw3gDnSnOin5HbI1sIve4hWgd
         HAFqXtlpEKddqpb4RkEvR3L6ZON45TeEDwtEg3BfKjN0gw8EEGmWAHpnT1Vq4QE/jIqq
         Z6u+TAn2pYVNKxo1q6TfU529Z6R5zQWcbRFZHRD3waToZGieMcX4qbCXNiZi8O5wngPD
         TN6A==
X-Forwarded-Encrypted: i=1; AJvYcCVdwrrpGEI4dKBvxY4J8bE7Qj9NeZ2X6/yETIfFFDDaeLOIFUDu98e3Q7wf3CcRnrlJLgHQD75KIQmByq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrPIIDovNQVJQhZhIDTvOUJKs0RoF+1eGjaKv/c17LCzspR5/X
	dcnm223D0E8n6IIc5p1XzM20kYZp9x8bU6EBhEM1+G3O0C5G9Z/mm9UbjBLRtorUxNwx2nwukCd
	UMX0ncg==
X-Google-Smtp-Source: AGHT+IHOXqIQmTAugf15BrDiV6HcY4fQ6ZvPzwSIXYUDhSteM2Wo5XdQ+I1dxHg6x0puKwyQc7KGqYKDSZo=
X-Received: from pjbnb15.prod.google.com ([2002:a17:90b:35cf:b0:328:116e:273])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:390a:b0:329:f670:2624
 with SMTP id 98e67ed59e1d1-32ee3f2488dmr4339532a91.30.1758146187259; Wed, 17
 Sep 2025 14:56:27 -0700 (PDT)
Date: Wed, 17 Sep 2025 14:56:25 -0700
In-Reply-To: <aMqt46hxeKxCxkmq@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250912232319.429659-1-seanjc@google.com> <20250912232319.429659-10-seanjc@google.com>
 <c4b9d87b-fddc-420b-ac86-7da48a42610f@linux.intel.com> <aMqt46hxeKxCxkmq@google.com>
Message-ID: <aMsuiTIUlulepJly@google.com>
Subject: Re: [PATCH v15 09/41] KVM: x86: Load guest FPU state when access
 XSAVE-managed MSRs
From: Sean Christopherson <seanjc@google.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Mathias Krause <minipli@grsecurity.net>, 
	John Allen <john.allen@amd.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Chao Gao <chao.gao@intel.com>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Zhang Yi Z <yi.z.zhang@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Sep 17, 2025, Sean Christopherson wrote:
> On Tue, Sep 16, 2025, Binbin Wu wrote:
> > > +/*
> > > + * Lock and/or reload guest FPU and access xstate MSRs. For accesses initiated
> > 
> > 
> > Lock is unconditional and reload is conditional.
> > "and/or" seems not accurate?
> 
> Agreed.  This?
> 
> /*
>  * Lock andr (re)load guest FPU and access xstate MSRs. For accesses initiated
>  * by host, guest FPU is loaded in __msr_io(). For accesses initiated by guest,
>  * guest FPU should have been loaded already.
>  */

That's not very good either.

/*
 * Lock (and if necessary, re-load) the guest FPU, i.e. XSTATE, and access an
 * MSR that is managed via XSTATE.  Note, the caller is responsible for doing
 * the initial FPU load, this helper only ensures that guest state is resident
 * in hardware (the kernel can load its FPU state in IRQ context).
 */

