Return-Path: <linux-kernel+bounces-844885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A28BC2FDA
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 01:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5A9954E857F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 23:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A1523E35B;
	Tue,  7 Oct 2025 23:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZIKWJ7+"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDCF182B4
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 23:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759881010; cv=none; b=MD0/edvhq7A8vHnWckt8AA2p9bjeqWfyA4U1C2d4UZ3ZhTbik++VgOIDqCjqtW4OM3jk/K6IeRTbnaMI+Vt8aq7nOcwDNSBSGQw1kaiHcZsEp9hX1eZKTnzSSeSVBR46kdOs6Ykemw567M1g43O1t57N+Yw6HF2n+MjWBqMvPvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759881010; c=relaxed/simple;
	bh=efHG1fdVvZNfpqTsBlMXo/kuFbVLbko4VMSXYSZYRWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DIdCChFrHAymFIe9OzLO2iL58e+iR3A+t9de22cJ232CN4WPSgONPS7DLtOXlQv5sTOB8k9t+irq26orWMjeh945X9SdWwUFxWLg5UfqpkkMkeEhARyQCmPEmuA6sZcS0oKihI7AIcpQ6ujCPNPPUdA0YU4dua7tD6susTp2pEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IZIKWJ7+; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-42d7ef9a402so1917035ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 16:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759881006; x=1760485806; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D7MaOWeH2bJtJufFc8wbY+ts/mqyyc77aroG+z0p8Ow=;
        b=IZIKWJ7+a1nJRqUqin0Hxm2MW7yzH0YqfpebiRKXAbQ4YdAVq3paCgq8EPaoMbI5mi
         n9Bows5iYBBsn+Fh1h1/cvKggBM9EsdTTEKntb+Doxb8xTnUCgwayLJGr9EC5D52wevf
         eLoIuU8IwjTPsvc4PbFDZCGRt9z0emi/6WTMBpeaG5nU3C8C4nohpqUWaXzoZlg1XE6O
         IQAmwys2CfHI5UebgupeSg3i69LqI7gz/zdJ82YsozlwQLQ7vsZdO/G0tkKSdrAcJoKN
         mmMYicu6owvdg4nbgLRRIdNZIvzVDpJ9hGl+PtPBDnoeyNzPxj6l0t16oEjU14+Zu7xi
         h7ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759881006; x=1760485806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D7MaOWeH2bJtJufFc8wbY+ts/mqyyc77aroG+z0p8Ow=;
        b=g+j5dR6a1GlGOfgFDZLrFVcdrO29W8eHkB+hC/fuzT4BOD3L1askVqW960hEXAVqkK
         Kg5lUZ3XcKvfl7c5k8ktXKMZ7YObLGDwbB8eDYtNDk0pqIK3ZwAm1vVKoV4C7N2enQtK
         0IcDcM/tDDyx7t6gHpXGxPn0Zr9mlsKeIFAtKh19wQef6c20TvWpW+Mb0ZsFU5odoGNI
         H+2JCozACLGNHlj8xyzvItzDITmD4g3S21P6TPDA+l2T37imxFfDGpAgRP0s6bwKpqMR
         6tLgPnx7hB+k2E4Je7WWGTkQWPsK3+GWwJHMm5LVa8eIugFQzwSAaV/5kfj0PV82leWS
         Hg8w==
X-Forwarded-Encrypted: i=1; AJvYcCUDkhOFpRhaBhCPCJzVGfpO3u2ky7GVYgvANi+m375EGcsPIn7YkdJXrrRPhL2o7c1Nlhptqrn65ayODGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaLWspB620kP9TJ0A+qxaDn2rqnA0V3E/1zCtmQH8JLVg6t80K
	mPfOJcDJ/I0g3WFNTN5Zh9XQvJRLTAcOZNwtGDns0SNuRfpPuwtXXQSoOFqN7s3Cm02yhmyP+FR
	2iuEi+wv3XDCHEyzGXPrQq6ZOS26jJMw=
X-Gm-Gg: ASbGnct+hDxByXJCS/FAe9FPobkHCKVSSNdIsCNR0tPmj3BycYC0SiHy/GW6eVxE9SA
	F213UW9LlQ9pyzafGZkI2tRPHI1v6KLQOzEqWW9wFNSzPcQ2+YPUErktN8T+2b9kvF60+lsB4nZ
	s00DKMo+eJOCVH1WFX5Rs6MupVk2khJ9K62o+D0olt+L55MHTPDxbY6jI+msQD/yhisBQXF6sHy
	pe8L9Vm3QhvQJGwkkynfDsuwTitDfCpP6SdvGtUEPA6UX5ruw61UVrBlA==
X-Google-Smtp-Source: AGHT+IFBiRrszCSdm2e4UZUihptdfJo3Fri0WVzryFNC37wuwOz3s4UYIiQEXK8bC+A9qU2S65sV1Ia3TEa3U3VJiZ0=
X-Received: by 2002:a05:6e02:1a8b:b0:411:6759:bfad with SMTP id
 e9e14a558f8ab-42f7c38ea02mr67276615ab.10.1759881006089; Tue, 07 Oct 2025
 16:50:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007-swap-clean-after-swap-table-p1-v1-0-74860ef8ba74@tencent.com>
 <20251007-swap-clean-after-swap-table-p1-v1-3-74860ef8ba74@tencent.com> <CAMgjq7DGy_ZmPqcqUO6s5BN381Zuee_g3KWjVqM3amLhpwE=2g@mail.gmail.com>
In-Reply-To: <CAMgjq7DGy_ZmPqcqUO6s5BN381Zuee_g3KWjVqM3amLhpwE=2g@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 7 Oct 2025 16:49:55 -0700
X-Gm-Features: AS18NWASkxLWQ0qk4dUy_pmlvoui4cUusggLIc1AOPTDWupkf8jL8C9LXWOawGA
Message-ID: <CAKEwX=PLfQCWZV7i9YP9UvcTmnHZXr635t3BX9D2uLEVr-Fnqw@mail.gmail.com>
Subject: Re: [PATCH 3/4] mm, swap: cleanup swap entry allocation parameter
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baoquan He <bhe@redhat.com>, 
	Barry Song <baohua@kernel.org>, Chris Li <chrisl@kernel.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, David Hildenbrand <david@redhat.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Ying Huang <ying.huang@linux.alibaba.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 1:08=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrote=
:
>
> On Tue, Oct 7, 2025 at 4:03=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wro=
te:
> >
> > From: Kairui Song <kasong@tencent.com>
> >
> > We no longer need this GFP parameter after commit 8578e0c00dcf ("mm, sw=
ap:
> > use the swap table for the swap cache and switch API"). Before that
> > commit the GFP parameter is already almost identical for all callers, s=
o
> > nothing changed by that commit. Swap table just moved the GFP to lower
> > layer and make it more defined and changes depend on atomic or sleep
> > allocation.
> >
> > Now this parameter is no longer used, just remove it. No behavior
> > change.
> >
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > ---
> >  include/linux/swap.h | 4 ++--
> >  mm/shmem.c           | 2 +-
> >  mm/swapfile.c        | 2 +-
> >  mm/vmscan.c          | 4 ++--
> >  4 files changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/linux/swap.h b/include/linux/swap.h
> > index e818fbade1e2..a4b264817735 100644
> > --- a/include/linux/swap.h
> > +++ b/include/linux/swap.h
> > @@ -462,7 +462,7 @@ static inline long get_nr_swap_pages(void)
> >  }
> >
> >  extern void si_swapinfo(struct sysinfo *);
> > -int folio_alloc_swap(struct folio *folio, gfp_t gfp_mask);
> > +int folio_alloc_swap(struct folio *folio);
> >  bool folio_free_swap(struct folio *folio);
> >  void put_swap_folio(struct folio *folio, swp_entry_t entry);
> >  extern swp_entry_t get_swap_page_of_type(int);
> > @@ -560,7 +560,7 @@ static inline int swp_swapcount(swp_entry_t entry)
> >         return 0;
> >  }
> >
> > -static inline int folio_alloc_swap(struct folio *folio, gfp_t gfp_mask=
)
> > +static inline int folio_alloc_swap(struct folio *folio)
> >  {
> >         return -EINVAL;
> >  }
> > diff --git a/mm/shmem.c b/mm/shmem.c
> > index 45f51745ad88..63092cc0b141 100644
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -1617,7 +1617,7 @@ int shmem_writeout(struct folio *folio, struct sw=
ap_iocb **plug,
> >                 folio_mark_uptodate(folio);
> >         }
> >
> > -       if (!folio_alloc_swap(folio, __GFP_HIGH | __GFP_NOMEMALLOC | __=
GFP_NOWARN)) {
> > +       if (!folio_alloc_swap(folio)) {
> >                 bool first_swapped =3D shmem_recalc_inode(inode, 0, nr_=
pages);
> >                 int error;
> >
> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > index 732e07c70ce9..534b21aeef5a 100644
> > --- a/mm/swapfile.c
> > +++ b/mm/swapfile.c
> > @@ -1425,7 +1425,7 @@ static bool swap_sync_discard(void)
> >   * Context: Caller needs to hold the folio lock.
> >   * Return: Whether the folio was added to the swap cache.
> >   */
> > -int folio_alloc_swap(struct folio *folio, gfp_t gfp)
> > +int folio_alloc_swap(struct folio *folio)
> >  {
> >         unsigned int order =3D folio_order(folio);
> >         unsigned int size =3D 1 << order;
>
> One trivial issue for myself, I better update the kerneldoc too...
> sorry about this:
>

LGTM, with the kerneldoc update:

Acked-by: Nhat Pham <nphamcs@gmail.com>

