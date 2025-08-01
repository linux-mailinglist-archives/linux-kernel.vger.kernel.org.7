Return-Path: <linux-kernel+bounces-753463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C51D6B18365
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 16:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25D001892BFE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 14:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE2326B2D3;
	Fri,  1 Aug 2025 14:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D+A22zrJ"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EEB267B02
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 14:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754057481; cv=none; b=Z7un72Xhe92GLdCW6QxIrd04dlTFohYDYsxP0TEmSyTabHFgW43Qd8kJQMDf1mEm/gLP7J3zTUkRO/SsieqyXoBecstwauSWPakJtmPPx/29IFsTt7TZCOyxZoesLMumkjjxg1g38xu65kRDEgV9et7TZi0eqC3MNW0X1yiSF2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754057481; c=relaxed/simple;
	bh=UtO5loiZvcJTq21yCIMV34bPkutVZd8A4MkqOMhGpzQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZhfPmbVP/+QOt500zsQXYnip26OShnp9oqKr5XMUEvts/9nLS4TMQLSA9kewr0siC6PSxE4XA5O4vSoVmLiTQzdx6ywLEDvGIGIntL1E/MbJnWP72EHL6pcgeDkhANpUefCr6cUrYhOsPnG2mNj5SHcj5+ePT2QMtGnzup7b22o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D+A22zrJ; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3138e65efe2so1990937a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 07:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754057479; x=1754662279; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jg0WGsPYkwgejTtuXNguQQAsciGyvH569oRaPP4mcY0=;
        b=D+A22zrJqf5+jGYF/rs7cIRHJyk7aIfWVbaigRyOcrPGOccLB3zHBXRzmFUMl0m9gU
         N6W9DsLzuIwq5aQDvNYJBG/GmDmDpGboUr7qsWj8x+O+9zgavdmVsKAa6oMYJJuGW+dG
         7asc9w69LXIPZ+0o5u4fjoYWJPusNymH8EDT+GD+MkbAHywIOTJyu8xHsOtco/jyHhzi
         rHuVS7ZcJjEP71gQeGYhZRpwgQQ5NrMRP1DoJwyvMkyN3siLnyGVyYYZ0tCh3QR8IoC7
         PO5mLr3cddMYO0Ak3GvFKYq8flelz2Gl0Xt7sWvJOidV7hTIJMYw+0LR3Ez+x1WsoGth
         0RHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754057479; x=1754662279;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Jg0WGsPYkwgejTtuXNguQQAsciGyvH569oRaPP4mcY0=;
        b=wiucT5gBctj4AKist512qtnMDHUBgGflVzsCGCEhDPjIJKuhoZAr3N75oZafVqpd0t
         CGG9roKCdWZxY66nRU7I6uAVpwIkl6qCLx8QNiVvDNfH+EwX4oG+1oYYDNjWEg16lbHE
         9re05QzhG2Rm+9goIrtJn12s2KOcPR2mZqFZ8e72RcPB9QBD9BsEuq3l5jHZlipEYwGu
         UkSiyUeQg6aumQhPJ+MKzSHV/PPsdp0ZGJe8Iz2hR15q/YKJP+mLuzcmhOiNwxnZR207
         ZsunPnwhJO93T5YtSmx9nSg8VnFc2i/HxRwf5CjuRnLmJcy24Ajb9JgPlkz7ixZUlB83
         5/GA==
X-Forwarded-Encrypted: i=1; AJvYcCVxrEcSCmphR8cHYDSbp+7m/js93twgEntOW5HktRKQuQW0Yb52ms6npKOD2oOEd5NAKKtgJnTg6cXuCRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOpnY56RJV6VEZZc5SWPp3fK/Z4T0qEGb7M91nQJKBcny5wa4l
	PwuVjss+0OHaOdxJrkkyPTZ3Pb87oi1hedoehRC8UAI0/yBnUVfbsUKr1K39ekKHI1Ei2IX5Qmk
	Ac8J7cg==
X-Google-Smtp-Source: AGHT+IGR5hwEN23kldB9nnxSgAaLLxN3YwoJiYheB6+obK/49reqSW4a1/x1J8h4NADMadntT1ELOoAtP3E=
X-Received: from pjbpv17.prod.google.com ([2002:a17:90b:3c91:b0:31f:6a10:6ea6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3ecb:b0:311:df4b:4b93
 with SMTP id 98e67ed59e1d1-31f5dd6b545mr15104043a91.7.1754057479038; Fri, 01
 Aug 2025 07:11:19 -0700 (PDT)
Date: Fri, 1 Aug 2025 07:11:17 -0700
In-Reply-To: <CADrL8HVJrHrb3AJV5wYtL9x0XHx+-bNFreO4-OyztFOrupE5eg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250707224720.4016504-1-jthoughton@google.com>
 <20250707224720.4016504-8-jthoughton@google.com> <aIFOV4ydqsyDH72G@google.com>
 <CADrL8HVJrHrb3AJV5wYtL9x0XHx+-bNFreO4-OyztFOrupE5eg@mail.gmail.com>
Message-ID: <aIzLBWqImtgtztOH@google.com>
Subject: Re: [PATCH v5 7/7] KVM: selftests: Add an NX huge pages jitter test
From: Sean Christopherson <seanjc@google.com>
To: James Houghton <jthoughton@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vipin Sharma <vipinsh@google.com>, 
	David Matlack <dmatlack@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025, James Houghton wrote:
> On Wed, Jul 23, 2025 at 2:04=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> > On Mon, Jul 07, 2025, James Houghton wrote:
> > Right, but we also don't want to wait for the initial fault-in either, =
no?  I.e.
> > plumbing in MAP_POPULATE only fixes the worst of the delay, and maybe o=
nly with
> > the TDP MMU enabled.
> >
> > In other words, it seems like we need a helper (option?) to excplitly "=
prefault",
> > all memory from within the guest, not the ability to specify MAP_POPULA=
TE.
>=20
> I don't want the EPT to be populated.
>=20
> In the event of a hugepage being executed, consider another memory
> access. The access can either (1) be in the executed-from hugepage or
> (2) be somewhere else.
>=20
> For (1), the optimization in this series doesn't help; we will often
> be stuck behind the hugepage either being destroyed or reconstructed.
>=20
> For (2), the optimization in this series is an improvement, and that's
> what this test is trying to demonstrate. But this is only true if the
> EPT does not have a valid mapping for the GPA we tried to use. If it
> does, the access will just proceed like normal.
>=20
> This test only times these "case 2" accesses. Now if we didn't have
> MAP_POPULATE, then (non-fast) GUP time appears in these results, which
> (IIRC) adds so much noise that the improvement is difficult to
> ascertain. But with MAP_POPULATE, the difference is very clear.

Oh, right, the whole point is to measure fault-in performance.

In that case, rather than MAP_POPULATE, can we do the slightly more standar=
d (for
VMMs) thing of writing (or reading) memory from host userspace?  I don't th=
ink it's
worth plumbing in extra_mmap_flags just for MAP_POPULATE, in no small part =
because
MAP_POPULATE is effectively best effort, and doesn't work for VM_PFNMAP (or=
 VM_IO).

Those quirks shouldn't matter for this case, and _probably_ won't ever matt=
er for
any KVM selftest, but it's enough to make me think MAP_POPULATE is a patter=
n we
don't want to encourage.

> This test is 100% contrived to consistently reproduce the memory
> access timing anomalies that Vipin demonstrated with his initial
> posting of this series[1].

Eh, contrived, targeted, same thing :-D

> [1]: https://lore.kernel.org/kvm/20240906204515.3276696-3-vipinsh@google.=
com/

