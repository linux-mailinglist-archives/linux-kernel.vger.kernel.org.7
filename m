Return-Path: <linux-kernel+bounces-748486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A85B141BD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 20:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C0AC1636B5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 18:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9445A273D65;
	Mon, 28 Jul 2025 18:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="03bCLprC"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F6F26D4F9
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 18:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753726096; cv=none; b=JzUSZOeSdGB1EOpFUcxw3dwR66URtkdxCccqXfjHoOurX9x24h7EJ2D49e0pGJsoSiJmaNgwhAsw7xY+JJtnBXO0p3dmMP3dXxv+sVftWTVff6psxPBgNT8nwVfqA0uLTpFSW7c93Ui8RDnQbN7R/cZD42XjbikkCAEb1F8S0Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753726096; c=relaxed/simple;
	bh=EVc0iEknCF3Ka4SHyQNJqg8MLMtEG5JaIjGM3psiOjg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cs1Bp9s/mgA1HE7u+0t5ui/B8A+rf+4VxJWGbGa2CjT5QQbdsgsKsoZo17ZdNhlX3XWCuhj1f32cpGOq2cikljmp2ws7jNvX7AA2rOxpJaLKGnZDqNvAnyrZHK/MYQyLEQ4xS7VzsFisN1TABHTgj0fMv7Bv4oGw8vGdB4gpcx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=03bCLprC; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e8e20883cd3so223473276.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 11:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753726094; x=1754330894; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2gmrGvfylvw3ZgqzNbgUCIxZfOpxfy+MGSCTqwUJs5I=;
        b=03bCLprC2Ls4UHUjZucCW8ZWhm8QnJTnU9jR/2u2U7HYhFN70q5vhsQ2Lgmbm/MTNy
         NcItjzDtdg1JwVb/5CSXUgpsSAQQPOGpIhb1euuyIpxLa5VKPrN7FcbjZ+E5rUd5Xrrg
         m8oUi2qYCbFWecQBjkK9X/TVSb+k0hcCvfzjxAmQhAViu5Asq/WIHT/7+HBC/RRuwFaE
         dTvlhIh/69CI8ejhvrYHVu2DIamtNiylE5DpgT0cHoCnXD6JGsXE9YEe9iXN11ADFdos
         JumYHY5SyDvebXK4nkrDGrz9CoakRyMOxuVekd8w7Ru+UFwlc2fDwPAAv5A8WlMAm4pO
         0uag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753726094; x=1754330894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2gmrGvfylvw3ZgqzNbgUCIxZfOpxfy+MGSCTqwUJs5I=;
        b=kaLg6OgKNugOZGMC8GnZggbRYiGeAyv3geJG+z14nibCxKZvmqt9BlsuiX3a5bPJQb
         YyPWcJ67fogzYkGJb1pbVpWFdCHaKJO4OwCqAJMWGRCvBbR2zsJTKgJl4jcoXohWZ+ok
         movPsGik/IVgNMnp7uOduSBbTNl0xHYCoxxIeJ7uFnEx/oHXEQ87rN6ivXtHednZM8KK
         AUwMivHY3lCH8mH3IICgU3scck3fC5/eol44Ar+30941F8qeUBe5WBmb6gwA1Wqe/XO3
         iwXRU/ZXajq653QW5bbymnvEfeHrfTiPVc63kE6aaYlBidjFfSuSqDUsfKq20qcNmMLN
         bsWg==
X-Forwarded-Encrypted: i=1; AJvYcCXvLL1mygEg3zRbHBYkZCMe+2EwvrHSXAzMOIML3Xeb3PaGLHv0piN78FPKX9ss75iDSvzYUAI/sSTpd3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxediWRe7XnfIih6Sa3REAfnNNFkpK7+zSHuNZz/TlwoFx5trTo
	dCNsL7siVJacD2YQ/eeOf6JMY18Ax7jmMXOaNaaAKDEqztmgsR9JkvL0gWJxpz1Rpy5IFwJhLnR
	dNyCrFanbasN8MU3TP+hq3QHWa4bAAh9R2ogXSfan
X-Gm-Gg: ASbGnctjT5pyXUeCyqyc4i0ZjwgT3RXAqM5yc1XSLLDMe7izbek8ortO/ziwcc8p0rb
	YLPVWn44LH0MUHch+2dL8K9tAgmvuda8w1Ge13kOIrwnELAZvBkfRBCwFcMw2/o7nURSmWH76ZP
	z+arYjvg/6YK/HtmK/RgGM8/vnIvmxs9HoRa/7hRki+4YP/WnKCSYt0DwYqMaYyrCNuRcFxr00A
	q2HSefTLSHc9AOFgiojBsXizQb6LzZh3Bdl9sB83n3F7wM=
X-Google-Smtp-Source: AGHT+IHjjBEZToln1GUKdNiNA5i+48eLmqUyHE2lIco0fXmKeAo87dihQyms53696HZtftCNENAtjjy50jxrFh37csY=
X-Received: by 2002:a05:6902:2192:b0:e8e:16d9:8f09 with SMTP id
 3f1490d57ef6-e8e2512a762mr683908276.17.1753726093352; Mon, 28 Jul 2025
 11:08:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250707224720.4016504-1-jthoughton@google.com>
 <20250707224720.4016504-4-jthoughton@google.com> <aIFHc83PtfB9fkKB@google.com>
In-Reply-To: <aIFHc83PtfB9fkKB@google.com>
From: James Houghton <jthoughton@google.com>
Date: Mon, 28 Jul 2025 11:07:37 -0700
X-Gm-Features: Ac12FXw88v-b_BueYv4w7UAtEPsyh5QQFnvb9K48s-JDnycsPo2ucd7UoV2kjdI
Message-ID: <CADrL8HW46uQQKYUngYwomzfKWB0Vf4nG1WRjZu84hiXxtHN14Q@mail.gmail.com>
Subject: Re: [PATCH v5 3/7] KVM: x86/mmu: Recover TDP MMU NX huge pages using
 MMU read lock
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vipin Sharma <vipinsh@google.com>, 
	David Matlack <dmatlack@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2025 at 1:35=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Mon, Jul 07, 2025, James Houghton wrote:
> > From: Vipin Sharma <vipinsh@google.com>
> >
> > Use MMU read lock to recover TDP MMU NX huge pages. Iterate
>
> Wrap at ~75 chars.

Oh, I did indeed wrap the text pretty aggressively for this patch. Not
sure why that happened.

>
> > over the huge pages list under tdp_mmu_pages_lock protection and
> > unaccount the page before dropping the lock.
> >
> > We must not zap an SPTE if:
>
> No pronouns!

Right.

>
> > - The SPTE is a root page.
> > - The SPTE does not point at the SP's page table.
> >
> > If the SPTE does not point at the SP's page table, then something else
> > has change the SPTE, so we cannot safely zap it.
> >
> > Warn if zapping SPTE fails and current SPTE is still pointing to same
> > page table. This should never happen.
> >
> > There is always a race between dirty logging, vCPU faults, and NX huge
> > page recovery for backing a gfn by an NX huge page or an executable
> > small page. Unaccounting sooner during the list traversal is increasing
> > the window of that race. Functionally, it is okay, because accounting
> > doesn't protect against iTLB multi-hit bug, it is there purely to
> > prevent KVM from bouncing a gfn between two page sizes. The only
> > downside is that a vCPU will end up doing more work in tearing down all
> > the child SPTEs. This should be a very rare race.
> >
> > Zapping under MMU read lock unblocks vCPUs which are waiting for MMU
> > read lock. This optimizaion is done to solve a guest jitter issue on
> > Windows VM which was observing an increase in network latency.
>
> With slight tweaking:
>
> Use MMU read lock to recover TDP MMU NX huge pages.  To prevent
> concurrent modification of the list of potential huge pages, iterate over
> the list under tdp_mmu_pages_lock protection and unaccount the page
> before dropping the lock.
>
> Zapping under MMU read lock unblocks vCPUs which are waiting for MMU
> read lock, which solves a guest jitter issue on Windows VMs which were
> observing an increase in network latency.
>
> Do not zap an SPTE if:
> - The SPTE is a root page.
> - The SPTE does not point at the SP's page table.
>
> If the SPTE does not point at the SP's page table, then something else
> has change the SPTE, so KVM cannot safely zap it.

"has changed" (my mistake)

>
> Warn if zapping SPTE fails and current SPTE is still pointing to same
> page table, as it should be impossible for the CMPXCHG to fail due to all
> other write scenarios being mutually exclusive.
>
> There is always a race between dirty logging, vCPU faults, and NX huge
> page recovery for backing a gfn by an NX huge page or an executable
> small page.  Unaccounting sooner during the list traversal increases the
> window of that race, but functionally, it is okay.  Accounting doesn't
> protect against iTLB multi-hit bug, it is there purely to prevent KVM
> from bouncing a gfn between two page sizes. The only  downside is that a
> vCPU will end up doing more work in tearing down all  the child SPTEs.
> This should be a very rare race.

Thanks, this is much better.

>
> > Suggested-by: Sean Christopherson <seanjc@google.com>
> > Signed-off-by: Vipin Sharma <vipinsh@google.com>
> > Co-developed-by: James Houghton <jthoughton@google.com>
> > Signed-off-by: James Houghton <jthoughton@google.com>
> > ---
> >  arch/x86/kvm/mmu/mmu.c     | 107 ++++++++++++++++++++++++-------------
> >  arch/x86/kvm/mmu/tdp_mmu.c |  42 ++++++++++++---
> >  2 files changed, 105 insertions(+), 44 deletions(-)
> >
> > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > index b074f7bb5cc58..7df1b4ead705b 100644
> > --- a/arch/x86/kvm/mmu/mmu.c
> > +++ b/arch/x86/kvm/mmu/mmu.c
> > @@ -7535,12 +7535,40 @@ static unsigned long nx_huge_pages_to_zap(struc=
t kvm *kvm,
> >       return ratio ? DIV_ROUND_UP(pages, ratio) : 0;
> >  }
> >
> > +static bool kvm_mmu_sp_dirty_logging_enabled(struct kvm *kvm,
> > +                                          struct kvm_mmu_page *sp)
> > +{
> > +     struct kvm_memory_slot *slot =3D NULL;
> > +
> > +     /*
> > +      * Since gfn_to_memslot() is relatively expensive, it helps to sk=
ip it if
> > +      * it the test cannot possibly return true.  On the other hand, i=
f any
> > +      * memslot has logging enabled, chances are good that all of them=
 do, in
> > +      * which case unaccount_nx_huge_page() is much cheaper than zappi=
ng the
> > +      * page.
>
> And largely irrelevant, because KVM should unaccount the NX no matter wha=
t.  I
> kinda get what you're saying, but honestly it adds a lot of confusion, es=
pecially
> since unaccount_nx_huge_page() is in the caller.
>
> > +      *
> > +      * If a memslot update is in progress, reading an incorrect value=
 of
> > +      * kvm->nr_memslots_dirty_logging is not a problem: if it is beco=
ming
> > +      * zero, gfn_to_memslot() will be done unnecessarily; if it is be=
coming
> > +      * nonzero, the page will be zapped unnecessarily.  Either way, t=
his only
> > +      * affects efficiency in racy situations, and not correctness.
> > +      */
> > +     if (atomic_read(&kvm->nr_memslots_dirty_logging)) {
>
> Short-circuit the function to decrease indentation, and so that "slot" do=
esn't
> need to be NULL-initialized.
>
> > +             struct kvm_memslots *slots;
> > +
> > +             slots =3D kvm_memslots_for_spte_role(kvm, sp->role);
> > +             slot =3D __gfn_to_memslot(slots, sp->gfn);
>
> Then this can be:
>
>         slot =3D __gfn_to_memslot(kvm_memslots_for_spte_role(kvm, sp->rol=
e), sp->gfn);
>
> without creating a stupid-long line.
>
> > +             WARN_ON_ONCE(!slot);
>
> And then:
>
>         if (WARN_ON_ONCE(!slot))
>                 return false;
>
>         return kvm_slot_dirty_track_enabled(slot);
>
> With a comment cleanup:
>
>         struct kvm_memory_slot *slot;
>
>         /*
>          * Skip the memslot lookup if dirty tracking can't possibly be en=
abled,
>          * as memslot lookups are relatively expensive.
>          *
>          * If a memslot update is in progress, reading an incorrect value=
 of
>          * kvm->nr_memslots_dirty_logging is not a problem: if it is beco=
ming
>          * zero, KVM will  do an unnecessary memslot lookup;  if it is be=
coming
>          * nonzero, the page will be zapped unnecessarily.  Either way, t=
his
>          * only affects efficiency in racy situations, and not correctnes=
s.
>          */
>         if (!atomic_read(&kvm->nr_memslots_dirty_logging))
>                 return false;
>
>         slot =3D __gfn_to_memslot(kvm_memslots_for_spte_role(kvm, sp->rol=
e), sp->gfn);
>         if (WARN_ON_ONCE(!slot))
>                 return false;
>
>         return kvm_slot_dirty_track_enabled(slot);

LGTM, thanks!

> > @@ -7559,8 +7590,17 @@ static void kvm_recover_nx_huge_pages(struct kvm=
 *kvm,
> >       rcu_read_lock();
> >
> >       for ( ; to_zap; --to_zap) {
> > -             if (list_empty(nx_huge_pages))
> > +#ifdef CONFIG_X86_64
>
> These #ifdefs still make me sad, but I also still think they're the least=
 awful
> solution.  And hopefully we will jettison 32-bit sooner than later :-)

Yeah I couldn't come up with anything better. :(

