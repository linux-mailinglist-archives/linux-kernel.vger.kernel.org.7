Return-Path: <linux-kernel+bounces-753758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C20B4B18773
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 20:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B2CB1C81C05
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 18:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A0F28D83E;
	Fri,  1 Aug 2025 18:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1rUUtcq0"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E3D6F53E
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 18:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754073994; cv=none; b=PSc2HO/Tru7vtBdtHI1dzK6Sp+WwBgFnvyMQtg5ULuobLGeSY6ey5sKlQLKyL9QX8Y7mGKQtYoF//2QrRvmnwB0vAz8hNVvU3ZJwYH00yRC53jctIctspEPCIamOoXg5cwx9k8wzOg0KUvXOJy0YWP9lpa626SewbVvqinu6bnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754073994; c=relaxed/simple;
	bh=iuTKwx1riuuxhY/5J2mFsDhn7XxA9QAIr/JvJhOy0OY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g2wpkV3XLOyspH3bak/5TLNHmUZ9WLykTPVEGBNLMu98HZKNWyeZDY2YKyFSme5XMeRbH6arsq3qzE9HBzgsljyWKKM+Qg8nJiEwXxrhQzVDjt/XI4JKCXtYBbXZ4V+kAwf580aBWavoEll3FNlv1sTAMYxbqNNPzKTdgQvQ33I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1rUUtcq0; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-71b691a40a8so13195257b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 11:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754073992; x=1754678792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w2c7bQ162dhyffr+C2PMoaAl+4J9FXAI9hIAhBblIgs=;
        b=1rUUtcq0/jAohKC9WR77PEEg71ubNE7baLWFQA7l+IZJRitNLpOYHJeDaKq4178Tlg
         g8cKYCOL7bwP6S7UyKhC+API+vmHb09NTd5wCC3ZlyO3nAZbMEm9AHtc9T4xbCAGQRbE
         caL9xJ5glxWH5ynyPgVuFDVtgF3zfGW2qXmyW0w8+Ny52I09HyMAr8D0It94L/68sBSw
         Ib9q97yjjdjn+DHE/LTgnpcDcFzjwzGc+nD6KNfT9SpfVpOhoUkNT9IOZsEKpfyrDiqK
         NQ5rgBbHikQ4pdfQ7AKcK+6cQYZmyJyENNy+bOYr8c/Vqf2Yfq2RQNJM+Rfyk6FMf/6n
         iwbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754073992; x=1754678792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w2c7bQ162dhyffr+C2PMoaAl+4J9FXAI9hIAhBblIgs=;
        b=lMxulbtHxbStFen+5qUppmj3iUUn5FmOXoUQOI1RBU3G1HkajqoJiIDZjPFq7pTtoD
         y8tfGwKTW82RFYWDtzBIET25Z6Wg28FsxBKRNtAvmSy0yOTlL86ipVbQCicXITQgkERL
         Ls9YILnCS6j/x2beTo4wJXaMFUHaWGSoOZeV2AO260Z1p+YhbvBNLkLzrUoispCpkss4
         1tFR2GQwRSEcoGJwHnjMNySKysVFmIIeSSukksh1uddEEHEUxwVFFvufDfnPDw7FGvWt
         xwL99GltiXshxVjr8mZeNgeoScnSQoH6MrUF5/yFSjsfjwCDX4oMGi+kJr9SNmTKZuQc
         Z3eQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhk/Ohp+78VA3PXjMUDMNCJAd99GwYueDMXUe8U+voAf2HpJJVrWOl7NEyMGFNt86cGDY6NoMXaZLqAe4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ0v/aannMXCH4niNCOWXebzAqWUkYUxzcrxuKLV6YesNDrbCL
	C1hAhGZLD9igTHHSk3cG9wbpqDBu+LE9qw6iuE+aSX+cKDC6KsEaLbKjViO60p+zkuuJ5JMlWc7
	RVeImmD4PBnrSojtQ5PdPzNEV7+kOYAWj4Fh76uqy
X-Gm-Gg: ASbGncuITm8wwtAfqaNueYkZ0ApGijrDlwW9e9gKV71gdEbw49UqnWZIrxlCdM+g1yC
	yJWizPqqRFtZM2hh9FIXMdycHkkErEaHUSLzbIKdrIr97M/fJcH+1eNrn0Rv1CT2NfxjQToRH3h
	ydSDfzfvMIK21sRKalvg1y2O4LXwpqBH6yFyAaUNf9XT/rUy2AW60PD0hQjq6eot9BB2VecDtB5
	kal7TfCz+KA1yrbt3iWNJxFg4tAUVcCziA2pQ==
X-Google-Smtp-Source: AGHT+IEl9yX593jURawHLWbkAVgQAYSYsMpaUOTywvKTzCY1mB223Rq26/uhMv+My9oQ9rjrYGf4rC+/HsCsxlqvW3Y=
X-Received: by 2002:a05:690c:488a:b0:70c:c013:f26 with SMTP id
 00721157ae682-71b7ef7b402mr11188117b3.33.1754073991958; Fri, 01 Aug 2025
 11:46:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250707224720.4016504-1-jthoughton@google.com>
 <20250707224720.4016504-8-jthoughton@google.com> <aIFOV4ydqsyDH72G@google.com>
 <CADrL8HVJrHrb3AJV5wYtL9x0XHx+-bNFreO4-OyztFOrupE5eg@mail.gmail.com> <aIzLBWqImtgtztOH@google.com>
In-Reply-To: <aIzLBWqImtgtztOH@google.com>
From: James Houghton <jthoughton@google.com>
Date: Fri, 1 Aug 2025 11:45:56 -0700
X-Gm-Features: Ac12FXxAU2RUoTM8vbbi5zAcMiC3jCiOxjwk0GR-osMUp_HPSvA3qzKWlQIC99M
Message-ID: <CADrL8HX11ee3R9HXexk3PbhFRKoOPfW6_=c+OOcaWE=0WJ7K4g@mail.gmail.com>
Subject: Re: [PATCH v5 7/7] KVM: selftests: Add an NX huge pages jitter test
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vipin Sharma <vipinsh@google.com>, 
	David Matlack <dmatlack@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 1, 2025 at 7:11=E2=80=AFAM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> On Mon, Jul 28, 2025, James Houghton wrote:
> > On Wed, Jul 23, 2025 at 2:04=E2=80=AFPM Sean Christopherson <seanjc@goo=
gle.com> wrote:
> > > On Mon, Jul 07, 2025, James Houghton wrote:
> > > Right, but we also don't want to wait for the initial fault-in either=
, no?  I.e.
> > > plumbing in MAP_POPULATE only fixes the worst of the delay, and maybe=
 only with
> > > the TDP MMU enabled.
> > >
> > > In other words, it seems like we need a helper (option?) to excplitly=
 "prefault",
> > > all memory from within the guest, not the ability to specify MAP_POPU=
LATE.
> >
> > I don't want the EPT to be populated.
> >
> > In the event of a hugepage being executed, consider another memory
> > access. The access can either (1) be in the executed-from hugepage or
> > (2) be somewhere else.
> >
> > For (1), the optimization in this series doesn't help; we will often
> > be stuck behind the hugepage either being destroyed or reconstructed.
> >
> > For (2), the optimization in this series is an improvement, and that's
> > what this test is trying to demonstrate. But this is only true if the
> > EPT does not have a valid mapping for the GPA we tried to use. If it
> > does, the access will just proceed like normal.
> >
> > This test only times these "case 2" accesses. Now if we didn't have
> > MAP_POPULATE, then (non-fast) GUP time appears in these results, which
> > (IIRC) adds so much noise that the improvement is difficult to
> > ascertain. But with MAP_POPULATE, the difference is very clear.
>
> Oh, right, the whole point is to measure fault-in performance.
>
> In that case, rather than MAP_POPULATE, can we do the slightly more stand=
ard (for
> VMMs) thing of writing (or reading) memory from host userspace?  I don't =
think it's
> worth plumbing in extra_mmap_flags just for MAP_POPULATE, in no small par=
t because
> MAP_POPULATE is effectively best effort, and doesn't work for VM_PFNMAP (=
or VM_IO).
>
> Those quirks shouldn't matter for this case, and _probably_ won't ever ma=
tter for
> any KVM selftest, but it's enough to make me think MAP_POPULATE is a patt=
ern we
> don't want to encourage.

What if vm_mem_add() just returned the VA of the added region, and
then the test could call mlock() on it? That's actually closer to what
I want; I want to avoid slow GUP as much as I can (though mlock()
isn't perfect, it's pretty much as good as we can do). So we can
write:

  char *mem =3D vm_mem_add(...);
  mlock(mem, size);

instead of

  char *mem =3D vm_mem_add(...);
  for (tmp =3D mem; tmp < mem + size; tmp +=3D backing_src_pagesz)
       *(volatile char *)tmp =3D 0;

