Return-Path: <linux-kernel+bounces-809074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2C3B5082B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 23:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91AF616DA32
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 21:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B776F2594B9;
	Tue,  9 Sep 2025 21:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AOtaIwvl"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5845718859B
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 21:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757453380; cv=none; b=Sbr9GDSZeBQw4p14DgCcP1ZfywiEiyIJAPq05a/+acF91g9ooTY0noo5VpaYgq8udgAxfMh6FaGfpdZHrgyZyRxUQa62HF54mKtIbM55Hf6R6nfrX+6CCPoKPzgCETKdg8vYHWYu8YZTVKIqQpIXkY+cJTLDW7fhi6HRPjJbNx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757453380; c=relaxed/simple;
	bh=Y2nshdaZb1t6+WeMxrH4tlhw5qakdVFtNr+OXDy/QO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YkHrordJYY0NlqFqZIugUmHxUTZ9XjImObWEWsvjBWcenEi85EomJ1IB36L7G0yM5JdRAxD6AcopiBOnxZs+LjBupKoJAVi6wQHWHG86IGprSPrWlwYfGYS5NTEa5KiDgvRsJBqcHjyUAHGI8tjAGCw9+Sh47Fx9iSj8gDcvtcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AOtaIwvl; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-621c6ae39b5so5073a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 14:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757453376; x=1758058176; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OzshIuP25Lf/LgUwHvyQlavyLmps1lc6Uyl+gXnRofA=;
        b=AOtaIwvl7lilQ8epGnCW277MH2N2PIs0MdrvB/oOfsaiOeZFFAhYoBkN4BlpAcFwia
         K7MZDiPVksxCCFaYf4wMyMHJYty8yj+4tGNXasRuk4NjBfyshWz9q+PB7LmeEwVdSIK9
         CIEXvrOEUZXoltrpT+3axQWACNpVbRHacJhXN80K9o5I9WOhQ018zMHy+qd4UvBqefQR
         EWd5l+RCHg2mTmvHgr3IhhYGalo+qUB6zl3NV/tNpAvAha6MSEhjTy1PG8gZJ7c7lUGL
         oP1qhym4wjB5N9i4/5wJA9lzVk/GHM1iMRRslhrGpRWl/bo+xmESModOotAufAU347Vl
         eaRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757453376; x=1758058176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OzshIuP25Lf/LgUwHvyQlavyLmps1lc6Uyl+gXnRofA=;
        b=Hl0OhZBsgOEDyrQ7eZ/FPtRqcz4cR5NCr/AH1h2a6NAbf7BIni+veVi2BH64nDVqIN
         lwFJPkXUf9ZBhq2oioCkj8B6hOIXQjuPv+nWWEHTRskcCYsFWocWGEaFeM6yAWtnqvGL
         yCVjGHF/fJAcvapbXHzJ3WCOh9CEJepge630jnwxwwwyHW/d1x1CAL881tumVsyyzrof
         5KvGo1vj6LoV5OLDaOEm9N8yw+Cly4i0HEkeHWma5mVq/rNxTmqSQDqPEm4+xDsXlzeN
         JA5u2n/IbxT/tboz/1dupqvyf7R665Dc7kBk3j9Ku6OocMIQMBPoAleBhTKPiJYFCbPq
         74fw==
X-Forwarded-Encrypted: i=1; AJvYcCVsmnm4X9X+H6oGES51yz96fpo//2juPaWdvPcpPZPjHNe2r3Xlk1QzkTVS+/aVYJ/f2G17wcPvxNlRqaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDzhhVV3t+f+yn2PbCYBWcZ/sMF55swnPN3WdaKz5I5VFAtoLP
	7qUNLO0ZZPZJ25CHQY55CUi3EEnKEjQSHAOL0h/WQbX++GGp7caGuJHEzVi3t45BI2nYoUE0IWn
	dTAqFR+wSrWHFM8kJtnKQXnPYeLuZ11eWNC71VNnX
X-Gm-Gg: ASbGncvTOdfJKs34oHrJ1mBgio6BkYcqYKZRbE2gFQukxOYi4HfpGR9bDhSjJF7dXAM
	9aNy8rndXKoUdlBWhTWnrrY8RpeeG/LWpa81pmuH6/lqEd00/6qcOpNM1eSngoqeYOsm2wtOiAm
	An+Q0ruz9OU/AqPHnap0j+yoeJBByy+AyHVGcBttxiS3UjZuhSzS+bEBTNFiVhIC9N7P4DVjwrt
	FNrog4Xh+I7M05otybzojNYvzb1kjAKmn+4sLP73AvU
X-Google-Smtp-Source: AGHT+IG3Bk5jtrADtC8DToS6oiX6FI8o3Fb6PEL11mpb8Jwou6oOmQTziCZTSqNNrEujN8hDJXcpLR1UXiFaeVgmlUA=
X-Received: by 2002:aa7:d7cb:0:b0:61e:c6ae:7a58 with SMTP id
 4fb4d7f45d1cf-62d22df05d0mr26258a12.0.1757453376378; Tue, 09 Sep 2025
 14:29:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909190945.1030905-1-Liam.Howlett@oracle.com> <20250909190945.1030905-6-Liam.Howlett@oracle.com>
In-Reply-To: <20250909190945.1030905-6-Liam.Howlett@oracle.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 9 Sep 2025 14:29:23 -0700
X-Gm-Features: AS18NWCtVVHoJovdoA_YZXVgLcM8he286fzD9VywAnIKmyeEKVWRIu_7WPtm7FA
Message-ID: <CAJuCfpG6US+wPA7V5-0Dkho+BRs6uNUCYCV1GyRrbvpzC1N=sg@mail.gmail.com>
Subject: Re: [PATCH v1 5/9] mm/vma: Add page table limit to unmap_region()
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, maple-tree@lists.infradead.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	David Hildenbrand <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, Charan Teja Kalla <quic_charante@quicinc.com>, shikemeng@huaweicloud.com, 
	kasong@tencent.com, nphamcs@gmail.com, bhe@redhat.com, baohua@kernel.org, 
	chrisl@kernel.org, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 12:10=E2=80=AFPM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> The unmap_region() calls need to pass through the page table limit for a
> future patch.
>
> No functional changes intended.
>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>  mm/vma.c | 5 +++--
>  mm/vma.h | 2 +-
>  2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/mm/vma.c b/mm/vma.c
> index 1bae142bbc0f1..4c850ffd83a4b 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -474,7 +474,7 @@ void remove_vma(struct vm_area_struct *vma)
>   * Called with the mm semaphore held.
>   */
>  void unmap_region(struct ma_state *mas, struct vm_area_struct *vma,
> -               unsigned long vma_min, unsigned long vma_max,
> +               unsigned long vma_min, unsigned long vma_max, unsigned lo=
ng pg_max,
>                 struct vm_area_struct *prev, struct vm_area_struct *next)
>  {
>         struct mm_struct *mm =3D vma->vm_mm;
> @@ -487,7 +487,7 @@ void unmap_region(struct ma_state *mas, struct vm_are=
a_struct *vma,
>         mas_set(mas, vma->vm_end);
>         free_pgtables(&tlb, mas, vma, prev ? prev->vm_end : FIRST_USER_AD=
DRESS,
>                       next ? next->vm_start : USER_PGTABLES_CEILING,
> -                     next ? next->vm_start : USER_PGTABLES_CEILING,
> +                     pg_max,

Hmm. The free_pgtables() parameters were advertised as:

@floor: The lowest page table address
@ceiling: The highest page table address
@tree_max: The highest tree search address

but here tree_max=3Dpg_max. I would expect pg_max to mean "The highest
page table address", IOW we should have ceiling=3Dpg_max. Either the
order of the parameters is wrong here or the names are misleading.
I also think in the previous patch we should have renamed
free_pgtables() parameters to vma_min, vma_max and pg_max like here
for consistency and to avoid confusion.

>                       /* mm_wr_locked =3D */ true);
>         tlb_finish_mmu(&tlb);
>  }
> @@ -2420,6 +2420,7 @@ static int __mmap_new_file_vma(struct mmap_state *m=
ap,
>                 vma_iter_set(vmi, vma->vm_end);
>                 /* Undo any partial mapping done by a device driver. */
>                 unmap_region(&vmi->mas, vma, vma->vm_start, vma->vm_end,
> +                            map->next ? map->next->vm_start : USER_PGTAB=
LES_CEILING,
>                              map->prev, map->next);
>
>                 return error;
> diff --git a/mm/vma.h b/mm/vma.h
> index a9d0cef684ddb..b0ebc81d5862e 100644
> --- a/mm/vma.h
> +++ b/mm/vma.h
> @@ -261,7 +261,7 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct mm=
_struct *mm,
>  void remove_vma(struct vm_area_struct *vma);
>
>  void unmap_region(struct ma_state *mas, struct vm_area_struct *vma,
> -               unsigned long min, unsigned long max,
> +               unsigned long min, unsigned long max, unsigned long pg_ma=
x,
>                 struct vm_area_struct *prev, struct vm_area_struct *next)=
;
>
>  /* We are about to modify the VMA's flags. */
> --
> 2.47.2
>

