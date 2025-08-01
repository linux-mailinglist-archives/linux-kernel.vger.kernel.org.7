Return-Path: <linux-kernel+bounces-752798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF6CB17B06
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 03:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D384A5671F6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 01:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F98A151991;
	Fri,  1 Aug 2025 01:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a0ceuMaI"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072D33398A
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 01:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754013413; cv=none; b=Sn/oFAhnJcpwSCHpmIeTq7xE5Raf3h8y5WcgCNTnaKDemglKHcaZ34JGdjGUGcaCWh5ZCNSa0aWtzGS/yMvKbVHlacIs6GXGGZ7j8aLArfJTO+qe8cMuxPx4vKRcwNkg6Q0b56ZuwEbwViL6r6xukDjSE6Q9+XrGjQ8JtsHDY5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754013413; c=relaxed/simple;
	bh=1Iwn17Dg8kD3l6fB8LK+OZD/CwFCIbknU2KW6H2btN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=keMSPv638Stc4JePEENay40CFQmPXsUsoHb1PQOciqSLhhh+3jYLf+sP+XTkgG86HMXSCe4yYQzhYGJ/DORtBtyEwju/cMOhvCHpyySrrYzSt3X0S/rF7IUSyvUag1DXu5kuiIQYMct6j4rAkY72+9tlFX16OrEe4Ztdin53tOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a0ceuMaI; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-240708ba498so21045ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 18:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754013411; x=1754618211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=73dgZbebrLU8zYg1FAZPFQA33fxb43EZn3LSBSzNaM8=;
        b=a0ceuMaItdqBARIQmz7q/3FE3NnZkgPIISmPWk9+P2xXfxX4ZesFQmayeBqThOLB57
         ToOUsS/tAjARlsOSow7Ea2fJ3lm5Y0AuRK3rbOEiDg03mt1tAK+8TqjcOqPB/xa84YT2
         f9kzJHvfAMGHmiTgp2zE2Md/loJLzukOuqvyKNFSCzgj5i3RJC02NtletSWSvxCMVGTJ
         +LkXHjxW1938QyUs6EJZASi2SiJs3/AmBoR0ZgHIAnLstPWtD7Dh+tn0VBI0i81161uf
         LANTaTGFaPdmMK+iC58/juru6R38VqxeTsQqaCB1IVi20BW0fQ1PgqiHFGK62eCGT4PT
         r2aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754013411; x=1754618211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=73dgZbebrLU8zYg1FAZPFQA33fxb43EZn3LSBSzNaM8=;
        b=sjEntV/rLCe+7CpIjHTCPBQg3pTbs0mnIjC2bOXItBUR+a+E28Ekn/QJR+CSxqxRMG
         n9kAHBe1RzTxV4o6IN7XE4s31XVDd7RRO8Ofp7weIr0uG3Adb66DJjoVQ+YU6AyHnPjW
         kZbJnUnKa+ZgmwiA7xGsRT96LPkP8OZNg+CSQMDtx7zUm+HUDy/x1L6FD2ZjTok2m70r
         /SEAxOh4fg7Jx6hNvfD+VJoqtH22oWllDyp7MKJL4FMdiHxq6YHfeKljDXUqvdEkaG53
         yxxc1fwYgtMupqQu5VIIy/g8X8u9LzIEPpOZEYG4K1Ow1BqrGkMz/huoP1LwEEs3154Z
         foUg==
X-Forwarded-Encrypted: i=1; AJvYcCU3gCoDc5U38euUUCldGF26ObeKmHjnt9wza4TXj6DDx0L48u42XK9E45SsjId0vFi7xnMNlKwPpwIqPLI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6MTh5/sn1K1xEr8AmnZgNby3Pm6EZm/Er+H6JT6tpEBOlG6ZZ
	2QFKRoMhfG3GylkEDE6ACIL/hn7HnZbwBdbD4yILQ+1YtGtXAzdU2ElgsjIfzm0VCmDVqf1j4+p
	jxYhQLw6deATp/TiZnl521XUbtWlURvguYZ6bpQ83
X-Gm-Gg: ASbGncuVrwAMOxe987WTq8IGTuZkCxMEVZZzKtyiwcNbkWcPycG9JBDZf0q/OxLuS4p
	aSLpp1hlIlEz6wvRa/XHMjUsxDa1Y96S168Rfvvateyd559V5KdJVGilMwqFdr2sZCo4pS8qpak
	JiTOBAXSCmuZaXKXpqgAvyy/A3u/cJQBKurSa0eZ+8klsRr8vGQbq3BZPSTEajj65f3hN9Wl+AK
	3lY6kUM5+j/aNVrNRFQD11vfLSeMvcVvVspgw==
X-Google-Smtp-Source: AGHT+IGvZgypmLXLSq3N1f77JjImJFtH643iQZJ6JC8/AqrHkOHoDRMIuJnZGr/f0hMyS1/ZxzAo17cEHgxEVEja0es=
X-Received: by 2002:a17:902:d490:b0:240:48f4:40fd with SMTP id
 d9443c01a7336-2422a435a05mr1308475ad.19.1754013410954; Thu, 31 Jul 2025
 18:56:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611104844.245235-1-steven.price@arm.com> <20250611104844.245235-20-steven.price@arm.com>
In-Reply-To: <20250611104844.245235-20-steven.price@arm.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Thu, 31 Jul 2025 18:56:38 -0700
X-Gm-Features: Ac12FXzyEE-6rAkSbBh6dTxzQhEIIz_vo5j0_DPiuqgwWpPvKvjM24zs36qca7o
Message-ID: <CAGtprH-on3JdsHx-DyjN_z_5Z6HJoSQjJpA5o5_V6=rygMSbtQ@mail.gmail.com>
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

On Wed, Jun 11, 2025 at 3:59=E2=80=AFAM Steven Price <steven.price@arm.com>=
 wrote:
>
> +static int realm_create_protected_data_page(struct realm *realm,
> +                                           unsigned long ipa,
> +                                           kvm_pfn_t dst_pfn,
> +                                           kvm_pfn_t src_pfn,
> +                                           unsigned long flags)
> +{
> +       unsigned long rd =3D virt_to_phys(realm->rd);
> +       phys_addr_t dst_phys, src_phys;
> +       bool undelegate_failed =3D false;
> +       int ret, offset;
> +
> +       dst_phys =3D __pfn_to_phys(dst_pfn);
> +       src_phys =3D __pfn_to_phys(src_pfn);
> +
> +       for (offset =3D 0; offset < PAGE_SIZE; offset +=3D RMM_PAGE_SIZE)=
 {
> +               ret =3D realm_create_protected_data_granule(realm,
> +                                                         ipa,
> +                                                         dst_phys,
> +                                                         src_phys,
> +                                                         flags);
> +               if (ret)
> +                       goto err;
> +
> +               ipa +=3D RMM_PAGE_SIZE;
> +               dst_phys +=3D RMM_PAGE_SIZE;
> +               src_phys +=3D RMM_PAGE_SIZE;
> +       }
> +
> +       return 0;
> +
> +err:
> +       if (ret =3D=3D -EIO) {
> +               /* current offset needs undelegating */
> +               if (WARN_ON(rmi_granule_undelegate(dst_phys)))
> +                       undelegate_failed =3D true;
> +       }
> +       while (offset > 0) {
> +               ipa -=3D RMM_PAGE_SIZE;
> +               offset -=3D RMM_PAGE_SIZE;
> +               dst_phys -=3D RMM_PAGE_SIZE;
> +
> +               rmi_data_destroy(rd, ipa, NULL, NULL);
> +
> +               if (WARN_ON(rmi_granule_undelegate(dst_phys)))
> +                       undelegate_failed =3D true;
> +       }
> +
> +       if (undelegate_failed) {
> +               /*
> +                * A granule could not be undelegated,
> +                * so the page has to be leaked
> +                */
> +               get_page(pfn_to_page(dst_pfn));

I would like to point out that the support for in-place conversion
with guest_memfd using hugetlb pages [1] is under discussion.

As part of the in-place conversion, the policy we are routing for is
to avoid any "refcounts" from KVM on folios supplied by guest_memfd as
in-place conversion works by splitting and merging folios during
memory conversion as per discussion at LPC [2].

The best way to avoid further use of this page with huge page support
around would be either:
1) Explicitly Inform guest_memfd of a particular pfn being in use by
KVM without relying on page refcounts or
2) Set the page as hwpoisoned. (Needs further discussion)

This page refcounting strategy will have to be revisited depending on
which series lands first. That being said, it would be great if ARM
could review/verify if the series [1] works for backing CCA VMs with
huge pages.

[1] https://lore.kernel.org/kvm/cover.1747264138.git.ackerleytng@google.com=
/
[2] https://lpc.events/event/18/contributions/1764/

> +       }
> +
> +       return -ENXIO;
> +}
> +
> +static int populate_region(struct kvm *kvm,
> +                          phys_addr_t ipa_base,
> +                          phys_addr_t ipa_end,
> +                          unsigned long data_flags)
> +{
> +       struct realm *realm =3D &kvm->arch.realm;
> +       struct kvm_memory_slot *memslot;
> +       gfn_t base_gfn, end_gfn;
> +       int idx;
> +       phys_addr_t ipa =3D ipa_base;
> +       int ret =3D 0;
> +
> +       base_gfn =3D gpa_to_gfn(ipa_base);
> +       end_gfn =3D gpa_to_gfn(ipa_end);
> +
> +       idx =3D srcu_read_lock(&kvm->srcu);
> +       memslot =3D gfn_to_memslot(kvm, base_gfn);
> +       if (!memslot) {
> +               ret =3D -EFAULT;
> +               goto out;
> +       }
> +
> +       /* We require the region to be contained within a single memslot =
*/
> +       if (memslot->base_gfn + memslot->npages < end_gfn) {
> +               ret =3D -EINVAL;
> +               goto out;
> +       }
> +
> +       if (!kvm_slot_can_be_private(memslot)) {
> +               ret =3D -EPERM;
> +               goto out;
> +       }
> +
> +       while (ipa < ipa_end) {
> +               struct vm_area_struct *vma;
> +               unsigned long hva;
> +               struct page *page;
> +               bool writeable;
> +               kvm_pfn_t pfn;
> +               kvm_pfn_t priv_pfn;
> +               struct page *gmem_page;
> +
> +               hva =3D gfn_to_hva_memslot(memslot, gpa_to_gfn(ipa));
> +               vma =3D vma_lookup(current->mm, hva);
> +               if (!vma) {
> +                       ret =3D -EFAULT;
> +                       break;
> +               }
> +
> +               pfn =3D __kvm_faultin_pfn(memslot, gpa_to_gfn(ipa), FOLL_=
WRITE,
> +                                       &writeable, &page);

Is this assuming double backing of guest memory ranges? Is this logic
trying to simulate a shared fault?

Does memory population work with CCA if priv_pfn and pfn are the same?
I am curious how the memory population will work with in-place
conversion support available for guest_memfd files.

> +
> +               if (is_error_pfn(pfn)) {
> +                       ret =3D -EFAULT;
> +                       break;
> +               }
> +
> +               ret =3D kvm_gmem_get_pfn(kvm, memslot,
> +                                      ipa >> PAGE_SHIFT,
> +                                      &priv_pfn, &gmem_page, NULL);
> +               if (ret)
> +                       break;
> +
> +               ret =3D realm_create_protected_data_page(realm, ipa,
> +                                                      priv_pfn,
> +                                                      pfn,
> +                                                      data_flags);
> +
> +               kvm_release_page_clean(page);
> +
> +               if (ret)
> +                       break;
> +
> +               ipa +=3D PAGE_SIZE;
> +       }
> +
> +out:
> +       srcu_read_unlock(&kvm->srcu, idx);
> +       return ret;
> +}
> +

