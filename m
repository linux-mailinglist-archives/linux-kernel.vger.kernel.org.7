Return-Path: <linux-kernel+bounces-769294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2C4B26C84
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 18:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D47CF1C22F59
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 16:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166C52566E7;
	Thu, 14 Aug 2025 16:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l+PfsvwS"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E113225761
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 16:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755188819; cv=none; b=Pr+f6vBRpMEgWtu9F/Jfn3xtZ2pvxF/vI22D+MkmgChsT9O0I+ccp3XRYCW5MOQ4KDA4fzygvsVs88dFyH+nWkvY+dH5ffaATeOiM9IVQbR/DrjKg3l1+N8qx96thYKjUNJ86ptO8P3Myw/IsSff4D4YopQlrUqxvBrkBj07ng4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755188819; c=relaxed/simple;
	bh=9D8jNE+Xpo3zWiNPyvO4nZbQmriyK7SuBVCu8u21lTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XOqcBeV+29yFoWQiZVfnB5Xuy1n3UfPdEOI/MJn42K4eEnCiGeMJS1prbonCbXWm2GvlCYih3NwoqqigNBWTrxrMRL/2GjBjCitOMg7SDM8scRuSpzxA3KpXowEcsIjfkn+/vKVZwZt7jI5NC7+g5y9gBpkQMAxFMLU3CwHbz20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l+PfsvwS; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-242d3be5bdfso158855ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755188817; x=1755793617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h2K7kLOi1msFu8PrhhDfHKdkFOSC2kCXyrMtF2tQZYY=;
        b=l+PfsvwS2iOX2ik/3QFcK+byPnFAgqK2x5wpj0JjkQw3cjoPmNuX+rjG4CIihL8ZK1
         Kzrv+ynayaQU4+KZxjqxg1Zs8/eo/SPab0tXLfDwPM0OQC8EcHQXb1iNXp97xjFovQLl
         XXA42OUZPwPuWQSJtOnvbiyTdQDyYbeO1iJNNK37vlqXLwC9IdMW0F/HjmSczkZzCcw9
         r+oyolZh+PupCAFzvKuF0qDchgjg2/DR2A4JtyQfmcoR1GE9eIu3J3iG8yiH5goDsVPj
         nd2eyMn1R8wyGTBH8pf0YC1/ewWAn/zEQ4nCd2IOZIOVuR1LVlUq66bCGQrtyakdCW9m
         vNWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755188817; x=1755793617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h2K7kLOi1msFu8PrhhDfHKdkFOSC2kCXyrMtF2tQZYY=;
        b=Pk7hl3FKp5p5MBL6Eu7l+MJmBHJG61OcyEmjGuPiKRQ6sr70NbGU0OyJ43n4q1uaVN
         D99PF0W3JX1Q2evLGr6Ifa5S8CmG79fFTHyVlDnKgfJ1ogkAIchHR5IWERnSOwkMSgzb
         AuebUDR+LqFA3kgsI28rC1kAbTRfxyBFNskvHoP8WdmMZVncxhMnVdHfvglodj9+hLWR
         rFaDh7gD1QRj8EYjTXNgK6eshNiWnAe0hcM8ajl0qUMnfiycNT3a71kcbkqIa+1V+KkM
         QI6CC3bmAUnlcK5DBpmfjVbEXnonhCL1t0kPn0/+Mxn0IBE8G/TXnmYwPIfniB8QL8/K
         Fq5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWxr59h5BYmA2k9fuTQ3DQfb6gEU6zz/as6yd3tY/ZUqbodCfzt9l7bob9fQQRuYOfhe+btGathyKWJaXg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd3VPnoFj7KnxNadxqpP7kDbjlVN2/d+NhFqNQu+uXQF0wrLT2
	FXwwglD4buIoTUfZcpNXd0Xpf3DMqdUguP1Z012D7LhIfsIYZMViskHUmTZBSlv3gTHOBoxuDfc
	VvaEGbJslb+ep4BJ+kO/igakb9l0nOXpXxgabt/fZ
X-Gm-Gg: ASbGncv110VMWbU0jsu1ly8EpoPc8lkuSsQvc0YnQYzS6Qtit7+/rf9fKX9TD27FMwh
	fnlxJjUk5lValy2DzjGKettbDSUP5+dSmp+/mUvRHzK9JksFMd4jH+cFuCP6u33FWrA+g0YOpF1
	2APf/IXvyw357YNX8lqVGK6QFHERBtjJUc9KoOmPNL+wPrVENT0+cB/PykGNJGZ2fitmJ2UBl7c
	Rd6pY/hLTV7WCgI0UYpF2Qc+bXbvg7kWbuEIFUK+5g+/JA=
X-Google-Smtp-Source: AGHT+IE1Xi8qyYhndEVvODlo5R4bNQvMviK2kuxs/l6Wlpkk77oP0VdMn3+ugh6zOobZUqKHcqQ2GO1F6nzXrcqgJ8E=
X-Received: by 2002:a17:902:f691:b0:234:b2bf:e67f with SMTP id
 d9443c01a7336-2445a7927d9mr3506845ad.9.1755188816277; Thu, 14 Aug 2025
 09:26:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611104844.245235-1-steven.price@arm.com> <20250611104844.245235-20-steven.price@arm.com>
 <CAGtprH-on3JdsHx-DyjN_z_5Z6HJoSQjJpA5o5_V6=rygMSbtQ@mail.gmail.com> <80c46a5c-7559-4763-bbf2-6c755a4b067c@arm.com>
In-Reply-To: <80c46a5c-7559-4763-bbf2-6c755a4b067c@arm.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Thu, 14 Aug 2025 09:26:43 -0700
X-Gm-Features: Ac12FXwAKtZ6w1m0fqmJfRbeB6BA7Boirvfy5XvFb88cYjZ1Wb1fbiPX78gZerA
Message-ID: <CAGtprH_6DYk8POPy+sLc3RL0-5gcrTdPNcDWFTssOK5_U4B3Nw@mail.gmail.com>
Subject: Re: [PATCH v9 19/43] arm64: RME: Allow populating initial contents
To: Steven Price <steven.price@arm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>, 
	James Morse <james.morse@arm.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Joey Gouly <joey.gouly@arm.com>, Alexandru Elisei <alexandru.elisei@arm.com>, 
	Christoffer Dall <christoffer.dall@arm.com>, Fuad Tabba <tabba@google.com>, linux-coco@lists.linux.dev, 
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>, Gavin Shan <gshan@redhat.com>, 
	Shanker Donthineni <sdonthineni@nvidia.com>, Alper Gun <alpergun@google.com>, 
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>, Emi Kisanuki <fj0570is@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 2:30=E2=80=AFAM Steven Price <steven.price@arm.com>=
 wrote:
>
> On 01/08/2025 02:56, Vishal Annapurve wrote:
> > On Wed, Jun 11, 2025 at 3:59=E2=80=AFAM Steven Price <steven.price@arm.=
com> wrote:
> >>
> >> +static int realm_create_protected_data_page(struct realm *realm,
> >> +                                           unsigned long ipa,
> >> +                                           kvm_pfn_t dst_pfn,
> >> +                                           kvm_pfn_t src_pfn,
> >> +                                           unsigned long flags)
> >> +{
> >> +       unsigned long rd =3D virt_to_phys(realm->rd);
> >> +       phys_addr_t dst_phys, src_phys;
> >> +       bool undelegate_failed =3D false;
> >> +       int ret, offset;
> >> +
> >> +       dst_phys =3D __pfn_to_phys(dst_pfn);
> >> +       src_phys =3D __pfn_to_phys(src_pfn);
> >> +
> >> +       for (offset =3D 0; offset < PAGE_SIZE; offset +=3D RMM_PAGE_SI=
ZE) {
> >> +               ret =3D realm_create_protected_data_granule(realm,
> >> +                                                         ipa,
> >> +                                                         dst_phys,
> >> +                                                         src_phys,
> >> +                                                         flags);
> >> +               if (ret)
> >> +                       goto err;
> >> +
> >> +               ipa +=3D RMM_PAGE_SIZE;
> >> +               dst_phys +=3D RMM_PAGE_SIZE;
> >> +               src_phys +=3D RMM_PAGE_SIZE;
> >> +       }
> >> +
> >> +       return 0;
> >> +
> >> +err:
> >> +       if (ret =3D=3D -EIO) {
> >> +               /* current offset needs undelegating */
> >> +               if (WARN_ON(rmi_granule_undelegate(dst_phys)))
> >> +                       undelegate_failed =3D true;
> >> +       }
> >> +       while (offset > 0) {
> >> +               ipa -=3D RMM_PAGE_SIZE;
> >> +               offset -=3D RMM_PAGE_SIZE;
> >> +               dst_phys -=3D RMM_PAGE_SIZE;
> >> +
> >> +               rmi_data_destroy(rd, ipa, NULL, NULL);
> >> +
> >> +               if (WARN_ON(rmi_granule_undelegate(dst_phys)))
> >> +                       undelegate_failed =3D true;
> >> +       }
> >> +
> >> +       if (undelegate_failed) {
> >> +               /*
> >> +                * A granule could not be undelegated,
> >> +                * so the page has to be leaked
> >> +                */
> >> +               get_page(pfn_to_page(dst_pfn));
> >
> > I would like to point out that the support for in-place conversion
> > with guest_memfd using hugetlb pages [1] is under discussion.
> >
> > As part of the in-place conversion, the policy we are routing for is
> > to avoid any "refcounts" from KVM on folios supplied by guest_memfd as
> > in-place conversion works by splitting and merging folios during
> > memory conversion as per discussion at LPC [2].
>
> CCA doesn't really support "in-place" conversions (see more detail
> below). But here the issue is that something has gone wrong and the RMM
> is refusing to give us a page back.

I think I overloaded the term "in-place" conversion in this context. I
was talking about supporting "in-place" conversion without data
preservation. i.e. Host will use the same GPA->HPA range mapping even
after conversions, ensuring single backing for guest memory. This is
achieved by guest_memfd keeping track of private/shared ranges based
on userspace IOCTLs to change the tracking metadata.

>
> >
> > The best way to avoid further use of this page with huge page support
> > around would be either:
> > 1) Explicitly Inform guest_memfd of a particular pfn being in use by
> > KVM without relying on page refcounts or
>
> This might work, but note that the page is unavailable even after user
> space has freed the guest_memfd. So at some point the page needs to be
> marked so that it cannot be reallocated by the kernel. Holding a
> refcount isn't ideal but I haven't come up with a better idea.
>
> Note that this is a "should never happen" situation - the code will have
> WARN()ed already - so this is just a best effort to allow the system to
> limp on.
>
> > 2) Set the page as hwpoisoned. (Needs further discussion)
>
> This certainly sounds like a closer fit - but I'm not very familiar with
> hwpoison so I don't know how easy it would be to integrate with this.
>

We had similar discussions with Intel specific SEPT management and the
conclusion there was to just not hold refcounts and give a warning on
such failures [1].

[1] https://lore.kernel.org/kvm/20250807094241.4523-1-yan.y.zhao@intel.com/

> > This page refcounting strategy will have to be revisited depending on
> > which series lands first. That being said, it would be great if ARM
> > could review/verify if the series [1] works for backing CCA VMs with
> > huge pages.
> >
> > [1] https://lore.kernel.org/kvm/cover.1747264138.git.ackerleytng@google=
.com/
> > [2] https://lpc.events/event/18/contributions/1764/
> >
> >> +       }
> >> +
> >> +       return -ENXIO;
> >> +}
> >> +
> >> +static int populate_region(struct kvm *kvm,
> >> +                          phys_addr_t ipa_base,
> >> +                          phys_addr_t ipa_end,
> >> +                          unsigned long data_flags)
> >> +{
> >> +       struct realm *realm =3D &kvm->arch.realm;
> >> +       struct kvm_memory_slot *memslot;
> >> +       gfn_t base_gfn, end_gfn;
> >> +       int idx;
> >> +       phys_addr_t ipa =3D ipa_base;
> >> +       int ret =3D 0;
> >> +
> >> +       base_gfn =3D gpa_to_gfn(ipa_base);
> >> +       end_gfn =3D gpa_to_gfn(ipa_end);
> >> +
> >> +       idx =3D srcu_read_lock(&kvm->srcu);
> >> +       memslot =3D gfn_to_memslot(kvm, base_gfn);
> >> +       if (!memslot) {
> >> +               ret =3D -EFAULT;
> >> +               goto out;
> >> +       }
> >> +
> >> +       /* We require the region to be contained within a single memsl=
ot */
> >> +       if (memslot->base_gfn + memslot->npages < end_gfn) {
> >> +               ret =3D -EINVAL;
> >> +               goto out;
> >> +       }
> >> +
> >> +       if (!kvm_slot_can_be_private(memslot)) {
> >> +               ret =3D -EPERM;
> >> +               goto out;
> >> +       }
> >> +
> >> +       while (ipa < ipa_end) {
> >> +               struct vm_area_struct *vma;
> >> +               unsigned long hva;
> >> +               struct page *page;
> >> +               bool writeable;
> >> +               kvm_pfn_t pfn;
> >> +               kvm_pfn_t priv_pfn;
> >> +               struct page *gmem_page;
> >> +
> >> +               hva =3D gfn_to_hva_memslot(memslot, gpa_to_gfn(ipa));
> >> +               vma =3D vma_lookup(current->mm, hva);
> >> +               if (!vma) {
> >> +                       ret =3D -EFAULT;
> >> +                       break;
> >> +               }
> >> +
> >> +               pfn =3D __kvm_faultin_pfn(memslot, gpa_to_gfn(ipa), FO=
LL_WRITE,
> >> +                                       &writeable, &page);
> >
> > Is this assuming double backing of guest memory ranges? Is this logic
> > trying to simulate a shared fault?
>
> Yes and yes...
>
> > Does memory population work with CCA if priv_pfn and pfn are the same?
> > I am curious how the memory population will work with in-place
> > conversion support available for guest_memfd files.
>
> The RMM interface doesn't support an in-place conversion. The
> RMI_DATA_CREATE operation takes the PA of the already delegated
> granule[1] along with the PA of a non-delegated granule with the data.

Ok, I think this will need a source buffer from userspace that is
outside guest_memfd once guest_memfd will support a single backing for
guest memory. You might want to simulate private access fault for
destination GPAs backed by guest_memfd ranges for this initial data
population -> similar to how memory population works today with TDX
VMs.

Note that with single backing around, at least for x86, KVM
shared/private stage2 faults will always be served using guest_memfd
as the source of truth (i.e. not via userspace pagetables for shared
faults).

>
> So to mimic an in-place conversion requires copying the data from the
> page, delegating the (original) page and then using RMI_DATA_CREATE
> which copies the data back. Fundamentally because there may be memory
> encryption involved there is going to be a requirement for this double
> memcpy() approach. Note that this is only relevant during the initial
> setup phase - CCA doesn't (at least currently) permit populated pages to
> be provided to the guest when it is running.
>
> The approach this series takes pre-dates the guest_memfd discussions and
> so is assuming that the shared memory is not (directly) provided by the
> guest_memfd but is using the user space pointer provided in the memslot.
> It would be possible (with the patches proposed) for the VMM to mmap()
> the guest_memfd when the memory is being shared so as to reuse the
> physical pages.
>
> I do also plan to look at supporting the use of the guest_memfd for the
> shared memory directly. But I've been waiting for the discussions to
> conclude before attempting to implement that.
>
> [1] A 'granule' is the RMM's idea of a page size (RMM_PAGE_SIZE), which
> is currently (RMM v1.0) always 4k. So may be different when Linux is
> running with a larger page size.
>
> Thanks,
> Steve
>

