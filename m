Return-Path: <linux-kernel+bounces-809722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B45B51129
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B84487AA577
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 08:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD85630DD0D;
	Wed, 10 Sep 2025 08:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iVsFuY7B"
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE82230BBA6
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 08:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757492770; cv=none; b=kTXonNagNX0Io05ITKxm3Q3yg/7arPwYunaTQIfU87O0qwkbeUo1eD3dgyFwQZYnuBL0agR6vGrhMPMylOX2RghnxNvubxOG4x+Dgzto12wc6GfzWm/lTzHxBb0wqRNo6UpoTaV5GMRSUZ+lE1FxofP+4wRMitqg1e7qbckKSiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757492770; c=relaxed/simple;
	bh=LGDx5UXVQvNOddW1bShX1KCkaUIEpgFgG6LEtTXv7kU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MqIcK6QKRp+e2pgcyJvzSGEeaeXpok0OFY8svAW9VB/alBniZxUOQ5g1Hn1X/Jyx4Ol7dJJYdKVFwRMq9gaPYcgvvPb/mn76ubAc9/k1mx8VS6n0IpzyQDzRQoc1vzVOWA+xAVtuPPoUTpgTD+RxHFOqVBRIk3sBHWa3vj7OVKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iVsFuY7B; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-32314296757so3201455fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 01:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757492765; x=1758097565; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nQH7snnNQnRZRbg0xLLdaSxYnYx9rFgR1u9eFyrWIv8=;
        b=iVsFuY7BsYTNYGFv2qtJNSI5I3Kj1rvjngN3lOdOqvQYZNj5jWl8TGX0a76wh5Ls+x
         OXktHxwGlcrHxoqIVCwI8dgYaJ/05lcQqG0CWAkm3+1kFSjFPKZM0DkqWhtWbqe3uh4U
         f03T5BPutuT4+AyIP8oDvkF73b+5+H34wPYV1sm1VNYYXuZqzZGaGTdTmFBUcGU95Da2
         uBLfNbv+N1gWiRq2Do941zW9NJKxnWM0QPgzsWVDf/y+RKgFzVc7QdccVO+oRFYW2ALs
         o/J7s+8jd9liYRoUEl1xub0vfsnECwQTOjtZGa3yg5/DPX3LWnyiklD5x45dJj8Qwpl7
         BFyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757492765; x=1758097565;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nQH7snnNQnRZRbg0xLLdaSxYnYx9rFgR1u9eFyrWIv8=;
        b=REu9pC/iZjeQxZNLHlEhL8PuSEnGVh8Q+VyDUsZPI3Jrz0oatIa9/vwaR3nWOSRcVL
         cQJULV3/7fTqr1ABSfjxqf0Ng31Skcyk0wxEOshitSfhPNnEv+E5O70e9znZ4vWWEMvj
         hsQrF4rEhG4hJ2CbBjDMvdM5qTsSIiyYOd6RwUw4/PoDhn6sk4JHzcmF1ReegQ4Ev333
         MqfdtPi58lmR0xmnFmVVu4vgpDaTgz1hySgVjHJhuPaFUw0rrov92iWXC1chdRQ8ziLe
         xQv3L7SqXwtYuJcHZmG4RKXoAo8DS0jg+sN6Mvl5mbrAHkPtcW/g/77ZYrVBXdgv4n0Y
         4Aog==
X-Forwarded-Encrypted: i=1; AJvYcCVaQ7pw464Br05w7glgBaRqaQj2EewtdQeDonbrQthWPx3HafwQvUybzyTSRpn6wwe0lp1u42jqecoNAkM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPmPf9TK0wMNSHv5Aq3kNWgob2G0IGjsUh1+Xb4972Vw8xFhoO
	BAb6Tv3kDXXyl4OUb4loPg7cAUBl7g6xPKGWq387eLiYBpOFpoamXCNDQEqNZpOyUU/BaQT9fjd
	/haczBZfv6qSVxkYlBVpaj7aIsAL2DNw=
X-Gm-Gg: ASbGncvlglkmfTW7d3fYWA/V04NOwFTs4opWIZ1EBZP7TvqL6bIz6wDTHRAhsaUtV7d
	ETvmDgjZXbLIBfHFD0TbPp+fflr6QSuaNSu/YbCWwVcB9vZ7pNk0RY/xOoD/cckGh9Ek6FPnK/z
	JaF/viF2OlHC+irg7FrO6q3UUmPtBR/D5cA6K/TKuow2ow8UvlFP8uI8XK63Jw7VEtXJEIBrwX9
	HkDjw==
X-Google-Smtp-Source: AGHT+IG8+X4z7lWHsoiDJ8ey4B9KiZeLoM8QTORaK4x4ttFg5WhTeM8qOcmzY4k1bJV831pksGGd1X5634WxyYNLQpo=
X-Received: by 2002:a05:6871:4b10:b0:31d:6b5b:6b57 with SMTP id
 586e51a60fabf-32264c16755mr7048854fac.30.1757492764639; Wed, 10 Sep 2025
 01:26:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909095611.803898-1-zhangchunyan@iscas.ac.cn>
 <20250909095611.803898-2-zhangchunyan@iscas.ac.cn> <6b2f12aa-8ed9-476d-a69d-f05ea526f16a@redhat.com>
In-Reply-To: <6b2f12aa-8ed9-476d-a69d-f05ea526f16a@redhat.com>
From: Chunyan Zhang <zhang.lyra@gmail.com>
Date: Wed, 10 Sep 2025 16:25:28 +0800
X-Gm-Features: Ac12FXx-v6pjQQB1q-gdPDWGiaVNDNxmW_UZ1a0xUB3t-SaqR__1RTrhpm4oqiU
Message-ID: <CAAfSe-vbvGQy9JozQY3vsqrrPrTaWYMcNw+NaDf3nReWz8ynZg@mail.gmail.com>
Subject: Re: [PATCH V10 1/5] mm: softdirty: Add pte_soft_dirty_available()
To: David Hildenbrand <david@redhat.com>
Cc: Chunyan Zhang <zhangchunyan@iscas.ac.cn>, linux-riscv@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Deepak Gupta <debug@rivosinc.com>, Ved Shanbhogue <ved@rivosinc.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>, 
	Arnd Bergmann <arnd@arndb.de>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi David,

On Tue, 9 Sept 2025 at 19:42, David Hildenbrand <david@redhat.com> wrote:
>
> On 09.09.25 11:56, Chunyan Zhang wrote:
> > Some platforms can customize the PTE soft dirty bit and make it unavailable
> > even if the architecture allows providing the PTE resource.
> >
> > Add an API which architectures can define their specific implementations
> > to detect if the PTE soft-dirty bit is available, on which the kernel
> > is running.
> >
> > Signed-off-by: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
> > ---
> >   fs/proc/task_mmu.c      | 17 ++++++++++++++++-
> >   include/linux/pgtable.h | 10 ++++++++++
> >   mm/debug_vm_pgtable.c   |  9 +++++----
> >   mm/huge_memory.c        | 10 ++++++----
> >   mm/internal.h           |  2 +-
> >   mm/mremap.c             | 10 ++++++----
> >   mm/userfaultfd.c        |  6 ++++--
> >   7 files changed, 48 insertions(+), 16 deletions(-)
> >
> > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > index 29cca0e6d0ff..20a609ec1ba6 100644
> > --- a/fs/proc/task_mmu.c
> > +++ b/fs/proc/task_mmu.c
> > @@ -1058,7 +1058,7 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
> >        * -Werror=unterminated-string-initialization warning
> >        *  with GCC 15
> >        */
> > -     static const char mnemonics[BITS_PER_LONG][3] = {
> > +     static char mnemonics[BITS_PER_LONG][3] = {
> >               /*
> >                * In case if we meet a flag we don't know about.
> >                */
> > @@ -1129,6 +1129,16 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
> >               [ilog2(VM_SEALED)] = "sl",
> >   #endif
> >       };
> > +/*
> > + * We should remove the VM_SOFTDIRTY flag if the PTE soft-dirty bit is
> > + * unavailable on which the kernel is running, even if the architecture
> > + * allows providing the PTE resource and soft-dirty is compiled in.
> > + */
> > +#ifdef CONFIG_MEM_SOFT_DIRTY
> > +     if (!pte_soft_dirty_available())
> > +             mnemonics[ilog2(VM_SOFTDIRTY)][0] = 0;
> > +#endif
> > +
> >       size_t i;
> >
> >       seq_puts(m, "VmFlags: ");
> > @@ -1531,6 +1541,8 @@ static inline bool pte_is_pinned(struct vm_area_struct *vma, unsigned long addr,
> >   static inline void clear_soft_dirty(struct vm_area_struct *vma,
> >               unsigned long addr, pte_t *pte)
> >   {
> > +     if (!pte_soft_dirty_available())
> > +             return;
> >       /*
> >        * The soft-dirty tracker uses #PF-s to catch writes
> >        * to pages, so write-protect the pte as well. See the
> > @@ -1566,6 +1578,9 @@ static inline void clear_soft_dirty_pmd(struct vm_area_struct *vma,
> >   {
> >       pmd_t old, pmd = *pmdp;
> >
> > +     if (!pte_soft_dirty_available())
> > +             return;
> > +
> >       if (pmd_present(pmd)) {
> >               /* See comment in change_huge_pmd() */
> >               old = pmdp_invalidate(vma, addr, pmdp);
> > diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> > index 4c035637eeb7..c0e2a6dc69f4 100644
> > --- a/include/linux/pgtable.h
> > +++ b/include/linux/pgtable.h
> > @@ -1538,6 +1538,15 @@ static inline pgprot_t pgprot_modify(pgprot_t oldprot, pgprot_t newprot)
> >   #endif
> >
> >   #ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
> > +
> > +/*
> > + * Some platforms can customize the PTE soft dirty bit and make it unavailable
> > + * even if the architecture allows providing the PTE resource.
> > + */
> > +#ifndef pte_soft_dirty_available
> > +#define pte_soft_dirty_available()   (true)
> > +#endif
> > +
> >   #ifndef CONFIG_ARCH_ENABLE_THP_MIGRATION
> >   static inline pmd_t pmd_swp_mksoft_dirty(pmd_t pmd)
> >   {
> > @@ -1555,6 +1564,7 @@ static inline pmd_t pmd_swp_clear_soft_dirty(pmd_t pmd)
> >   }
> >   #endif
> >   #else /* !CONFIG_HAVE_ARCH_SOFT_DIRTY */
> > +#define pte_soft_dirty_available()   (false)
> >   static inline int pte_soft_dirty(pte_t pte)
> >   {
> >       return 0;
> > diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
> > index 830107b6dd08..98ed7e22ccec 100644
> > --- a/mm/debug_vm_pgtable.c
> > +++ b/mm/debug_vm_pgtable.c
> > @@ -690,7 +690,7 @@ static void __init pte_soft_dirty_tests(struct pgtable_debug_args *args)
> >   {
> >       pte_t pte = pfn_pte(args->fixed_pte_pfn, args->page_prot);
> >
> > -     if (!IS_ENABLED(CONFIG_MEM_SOFT_DIRTY))
> > +     if (!IS_ENABLED(CONFIG_MEM_SOFT_DIRTY) || !pte_soft_dirty_available())
>
> I suggest that you instead make pte_soft_dirty_available() be false without CONFIG_MEM_SOFT_DIRTY.
>
> e.g., for the default implementation
>
> define pte_soft_dirty_available()       IS_ENABLED(CONFIG_MEM_SOFT_DIRTY)
>
> That way you can avoid some ifefs and cleanup these checks.

Do you mean something like this:

--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1538,6 +1538,16 @@ static inline pgprot_t pgprot_modify(pgprot_t
oldprot, pgprot_t newprot)
 #endif

 #ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
+#ifndef arch_soft_dirty_available
+#define arch_soft_dirty_available()     (true)
+#endif
+#define pgtable_soft_dirty_supported()
(IS_ENABLED(CONFIG_MEM_SOFT_DIRTY) && arch_soft_dirty_available())
+
 #ifndef CONFIG_ARCH_ENABLE_THP_MIGRATION
 static inline pmd_t pmd_swp_mksoft_dirty(pmd_t pmd)
 {
@@ -1555,6 +1565,7 @@ static inline pmd_t pmd_swp_clear_soft_dirty(pmd_t pmd)
 }
 #endif
 #else /* !CONFIG_HAVE_ARCH_SOFT_DIRTY */
+#define pgtable_soft_dirty_supported() (false)

>
>
> But as we do also have PMD soft-dirty support, I guess we would want to call this
> something more abstract "pgtable_soft_dirty_available" or "pgtable_soft_dirty_supported"
>
> --
> Cheers
>
> David / dhildenb
>

