Return-Path: <linux-kernel+bounces-808943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13774B506BE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 22:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 905753A38F9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 20:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B9E303A3D;
	Tue,  9 Sep 2025 20:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0dw+oMjY"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE18307AC4
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 20:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757448604; cv=none; b=Xl/m9QBOQGMHd8selk8VTjyU8GvEcFAIcm3PjfSP5u+URa1pHzdJAhDcCEOYrL76cwVWEOAE2AOLidzvONSEJX6ODA96Pt+vSQBLkrCNHZm9tlNQrBkZSCGq4OzlFtbDnvqVbf7jvcrmeNAL71vD/t7u2VWZf1QDNxl8emTmoC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757448604; c=relaxed/simple;
	bh=BpsPJqjLESTM3CtUHLateIMpLo4HDJYjsC9h6DFdufQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vGjSpGbc4hIEQaRRtZ6jNfnfpPbDl7plMEQsThHlKJY/9ag6f1194SQdKiz4Xx68pzyqVcE4NlaI60viH8h4847oZIN8e3fnDV9RntvUolIkwh0rbhjKua9VkgU9LJ4A9FFv73qiH85fEpdB2UhKRRjtK/TIeE6bw+1qE37/S7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0dw+oMjY; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4b48fc1d998so14291cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 13:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757448602; x=1758053402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t6moEsQrMOvaJDyHg83dzxwUYK12SAvE5EtoliwNDps=;
        b=0dw+oMjYY0L+mliCPJRWSAMzAefxeJWECF6HIlOWbzLj2jBb7+HoLf6jaw1IBKtldu
         87eYDmvr6NM3QGjWht/mOpphQO//+sAu5JO/waPTYtcbL9C7TqvN9qbHChgPSgdr8aKF
         siJVI/mxznN6ng5yIdXcm9qVT4D6gwmILP1TSW5eCOAqSuLu5TOahGJ+tgBfBAhJKJki
         5W+tjt4DMGcR5eGRiTGr9CFYAJ2DrHylG5CGaf/HZ9am+/s/YTdD/12k2yV5PArIw4cs
         InXefhR+VuCPyRddeH9vFkeWvD0YU6Csl7ehjuYeCIL3BMXE4ckW0Nfi3iFVyiOAAVDA
         NZlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757448602; x=1758053402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t6moEsQrMOvaJDyHg83dzxwUYK12SAvE5EtoliwNDps=;
        b=QDKSDAx5RJFTDHp3Boem/wJpiVXj7p5s0gfie9x47O4RSzWofUj3FG4/yeC+ZIrqCV
         saw3fUu1JhkuxDyPZt6A5QyQ79VGfglmVhi8RyoTX3j0uvplITDkpILwf6PsoNxfhrj7
         vIqI/iNPBwqaGTB+F5bHcrbSoGIzm7CSSRPluAlceV64bfAf+Iwo5wzWt+p+6vQavX7u
         oDwtugcRZUJZ3KlI9NdAb46VhfzBiZsxokS5RGjfgj/mgK760/ESYC+2Q4Q10M95RH21
         TMGu1ftqehJBOVsf1n4b3lvzzozqDQOrvdvQkKrH127gRXsv1e7SO2oH+IBzXyPiXt5r
         B0kw==
X-Forwarded-Encrypted: i=1; AJvYcCXuGOn2BURMLo+n8kvsckLjWGmyBG7U4IYzWEqvYQjZnziFMifsAcYIh0T6OkoWpDPAs44egld5hRxHiFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrMoEg057py7sMxCG1BCsSrpmMjnWLI5Zki77SFy47PwyT/JPx
	wnEM8QrVd4zOlw0iyCczZixNAP3tiIk4t92SXQHgi2oCr/rJzuZLKNhqfHLwSocNUA8At0Ghfwj
	8aN4p0utqkm5wklqUWfGHASj/rXC0dYZHMkpFAl1g
X-Gm-Gg: ASbGncteu8i1pMYTRMbmaBvz4/RGyjbnLZHh7t06ZUjF5g+NRlMEySo1LdxmexKS0DS
	C3dFhtc+OWL3onslAnur9h/EGfEANRH4M+jFCs6fkbUpXTELfTQIc5HqpPi1QyrRhWXF+OIccUi
	C9YHNCGILYFmi3q1yYrGp1WWsKIXCEGi8wpi7XaDMysJrx3hbHVm/46iDC3Cmf7Aj/rf3PrQ4XF
	jqYCupF9haska9/N+xoE78CholiFBDC5rb8v87C9Ikwxkml9vBYvhs=
X-Google-Smtp-Source: AGHT+IHnHLlgpvqGEl14YzylQSH61T6ExMaMJwPOn7axIYhzTaqY2adH/yufFSZhoXIEb2CxQVDlO/GRoeTM7lDQUWE=
X-Received: by 2002:a05:622a:14c:b0:4b4:9863:5d76 with SMTP id
 d75a77b69052e-4b6252075bbmr949291cf.8.1757448601620; Tue, 09 Sep 2025
 13:10:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909190945.1030905-1-Liam.Howlett@oracle.com> <20250909190945.1030905-4-Liam.Howlett@oracle.com>
In-Reply-To: <20250909190945.1030905-4-Liam.Howlett@oracle.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 9 Sep 2025 13:09:50 -0700
X-Gm-Features: AS18NWCLA-Laybgj0BVgoTc0VsNcV6DuM6nWCtOdabz2PeHFWlEO9xtiR7vwsbA
Message-ID: <CAJuCfpGSX3VMnFH3u67mKZTe1pXOYXoFc92XiU+TVjPs==5mcA@mail.gmail.com>
Subject: Re: [PATCH v1 3/9] mm/vma: Add limits to unmap_region() for vmas
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
> Add a limit to the vma search instead of using the start and end of the
> one passed in.

Would be good to explain why this is needed. I'm sure I'll find the
answer in the later patches though.


>
> No functional changes intended.
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  mm/vma.c | 6 ++++--
>  mm/vma.h | 1 +
>  2 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/mm/vma.c b/mm/vma.c
> index abe0da33c8446..a648e0555c873 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -474,6 +474,7 @@ void remove_vma(struct vm_area_struct *vma)
>   * Called with the mm semaphore held.
>   */
>  void unmap_region(struct ma_state *mas, struct vm_area_struct *vma,
> +               unsigned long vma_min, unsigned long vma_max,
>                 struct vm_area_struct *prev, struct vm_area_struct *next)
>  {
>         struct mm_struct *mm =3D vma->vm_mm;
> @@ -481,7 +482,7 @@ void unmap_region(struct ma_state *mas, struct vm_are=
a_struct *vma,
>
>         tlb_gather_mmu(&tlb, mm);
>         update_hiwater_rss(mm);
> -       unmap_vmas(&tlb, mas, vma, vma->vm_start, vma->vm_end, vma->vm_en=
d,
> +       unmap_vmas(&tlb, mas, vma, vma_min, vma_max, vma_max,
>                    /* mm_wr_locked =3D */ true);
>         mas_set(mas, vma->vm_end);
>         free_pgtables(&tlb, mas, vma, prev ? prev->vm_end : FIRST_USER_AD=
DRESS,
> @@ -2417,7 +2418,8 @@ static int __mmap_new_file_vma(struct mmap_state *m=
ap,
>
>                 vma_iter_set(vmi, vma->vm_end);
>                 /* Undo any partial mapping done by a device driver. */
> -               unmap_region(&vmi->mas, vma, map->prev, map->next);
> +               unmap_region(&vmi->mas, vma, vma->vm_start, vma->vm_end,
> +                            map->prev, map->next);
>
>                 return error;
>         }
> diff --git a/mm/vma.h b/mm/vma.h
> index 9183fe5490090..a9d0cef684ddb 100644
> --- a/mm/vma.h
> +++ b/mm/vma.h
> @@ -261,6 +261,7 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct mm=
_struct *mm,
>  void remove_vma(struct vm_area_struct *vma);
>
>  void unmap_region(struct ma_state *mas, struct vm_area_struct *vma,
> +               unsigned long min, unsigned long max,
>                 struct vm_area_struct *prev, struct vm_area_struct *next)=
;
>
>  /* We are about to modify the VMA's flags. */
> --
> 2.47.2
>

