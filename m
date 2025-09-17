Return-Path: <linux-kernel+bounces-820778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5E3B7F50E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92F2C4A4584
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E05E33C756;
	Wed, 17 Sep 2025 13:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X+p04iBr"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E7233C747
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758114889; cv=none; b=V2VIrjPo1u0BbVWj4VRM1AEYD5zf0QscjGWK3Z37sw+irEVhpQDn3NKO9UDLMt86CtGkDZzR6DOfWxdqtxe7Tg0pqkLCmZHRvVE8G8ZHyGHnXJAskpYbiQa4RKOE+fI30AqcmlucpdXzkZa6bjIRc7WB6QaRfPpBU2XYPn+BY7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758114889; c=relaxed/simple;
	bh=WbMt08VUPJcs6SUg2Se74Sn0+CZFx6WJ/eZRXR7L1+M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jkTlQTW6SDolfvN2y6XqL+vMRKyDa2kol0mbbXwIfcpUVNKclWmT7KU98Xmn/ydencx18SKEPyiDGgZenkAWkHbbd5RbHzTYpfAnYZNcYCRmtSt7xaExraIAoA8TWmY8tifrF5a1R8fa76nPF/fnNbwnphihXo9JFagVS+UFZs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X+p04iBr; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32eae48beaaso1531674a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 06:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758114888; x=1758719688; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+dStKelxvhfQdf95uSaYkcCy0EFr9PxQZO0L0kZj6MM=;
        b=X+p04iBrQBKNcITEGKbAPjFJJ+tF7y37wQHmmxoEMZxmKe6gaASMB/hrUVYHq6RvRB
         Fwgha99+3PlP0AkDE6xwWKcnwJf9qzeOgYX29HQ1jYxF+387dvVDYV4zNWTzoy5btfeS
         bHmTJM6SrAasxwva/zsaNenVF0NWQRDF9rEYPawXDEpZw8OkSn4H967kv01uhmIpsf97
         aSF6dquka08k+3pIiTINeD7Be3lp8n2OSHgKjE/aij7S9STjY+UmNqCCP1ulLJWPJ7hj
         kfSJfjL8vIaDLsDBX42/d+QVspKW+DCSIuqG2W/T2pKTXmm3tJ6kWPN3FyU2/dnaaE5R
         RtHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758114888; x=1758719688;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+dStKelxvhfQdf95uSaYkcCy0EFr9PxQZO0L0kZj6MM=;
        b=JyIEmezUf/jpC2IlGaCxHeRguD58jzP4AaOGkoVFRUgXhLtD5TJ9Ts4V/jYnUSRZ1z
         mOKPjrIhokDMXUNRrsU1PmDGBFU7qo7ClqZ9x67Hvx22xdy/TvUQaKMwyYGrOHKqEJkI
         R1QmeXwYUohkgIE/DIuvc3PTrMbV+EBmFoRhiyGF7atK4eLQd3yUzFy4z1cnzlcwjC+0
         azaqeHNLvUXJ+gauhck+eMxiQ3JOeGwvhJlE8gleba4Umiv1dSuF78DFZwGDMu0FxUV3
         OZqXLgE2gw0AouQ/JfRyMUxpHRQOEg9ct+2GXiC7VO4CVJrLnvZKpzcts/xQPEJqaN97
         Jx0g==
X-Forwarded-Encrypted: i=1; AJvYcCWNJFOhRfnQbiS4NYw0q4z9w6zEMnkHnwRC52hD3EagGcP6L4Z0S1RwPi+hzjgqCNA+mEakQxBgywTrp/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEWGYq8ccYIcHQML+Hyl558KpcOTyN7rdbAite4TjAXVKw9vO6
	h6RBuh9OGNXk2kSdeWCkOzpslI1FK5guJskDBsHskxl6Y+Prq3yVCM/mUpJVs82j+QB9uUjRq2g
	6fZXuhw==
X-Google-Smtp-Source: AGHT+IFM7f2Z2olWNtKq3AasdeRyFgxmIxXSINLJwEK3VfS5x2oQhprQuWkvpKlJfPJnsnCvz3TmY6cyB0o=
X-Received: from pjbta13.prod.google.com ([2002:a17:90b:4ecd:b0:32e:879e:cac1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a05:b0:32e:d599:1f66
 with SMTP id 98e67ed59e1d1-32ee3f53853mr2804657a91.30.1758114887330; Wed, 17
 Sep 2025 06:14:47 -0700 (PDT)
Date: Wed, 17 Sep 2025 06:14:40 -0700
In-Reply-To: <b3fae3e0-1337-430c-beeb-290dc185b8bf@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250912232319.429659-1-seanjc@google.com> <20250912232319.429659-5-seanjc@google.com>
 <b3fae3e0-1337-430c-beeb-290dc185b8bf@linux.intel.com>
Message-ID: <aMq0QOX36DOWEXHK@google.com>
Subject: Re: [PATCH v15 04/41] KVM: x86: Introduce KVM_{G,S}ET_ONE_REG uAPIs support
From: Sean Christopherson <seanjc@google.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Mathias Krause <minipli@grsecurity.net>, 
	John Allen <john.allen@amd.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Chao Gao <chao.gao@intel.com>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Zhang Yi Z <yi.z.zhang@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Sep 16, 2025, Binbin Wu wrote:
> On 9/13/2025 7:22 AM, Sean Christopherson wrote:
> > ---
> >   Documentation/virt/kvm/api.rst  |   6 +-
> >   arch/x86/include/uapi/asm/kvm.h |  26 +++++++++
> >   arch/x86/kvm/x86.c              | 100 ++++++++++++++++++++++++++++++++
> >   3 files changed, 131 insertions(+), 1 deletion(-)
> [...]
> > +
> > +#define KVM_X86_REG_ENCODE(type, index)				\
> Nit:
> Is it better to use KVM_X86_REG_ID so that when searching with the string
> non-case sensitively, the encoding and its structure can be related to each
> other?

I'm leaning _very_ slightly toward ENOCDE, but I am a-ok with ID too.  Anyone
else have a preference?  If not, I'll go with Binbinb's suggestion of ID.

