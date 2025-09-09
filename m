Return-Path: <linux-kernel+bounces-808937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D34B506B7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 22:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 259B64E12B9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 20:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF56304BBA;
	Tue,  9 Sep 2025 20:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ikhi9GL6"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06AF1D799D
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 20:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757448491; cv=none; b=i5Xw+BigziZshNQX2srnrpOavKQseDkMKd7QtKRErIGqTPYIsvaL6x8dDCteY0s2TKvnAfNjyp40CuyKELdv3fDb8uXDXR8ZPfqEqsn3LYmzLRiEv8JDObxT29putUOtUlqHE+Nl+codsV3btJBuZweNGEv3H/QXBZF78Ht39gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757448491; c=relaxed/simple;
	bh=pwDhYi2YfQDUsu2v0Kg18caghX0cdhc9z5LjDm0do6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EV5CQtZjgo4DhUDt/GzObrKhr2wa7RNYJu0OmR45peisutnGV5976pGxbh1rGn7dd5g3zN6EYkpzQp8D1WD8jz2L22ECpUAqpgG0keFeDtHaBvLu8e5gfynVTLC5yXoCYUvZz2+66ZtHtOVxYBB0DD9EhEjGAv45KabhgR3VrYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ikhi9GL6; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4b350971a2eso9641cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 13:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757448488; x=1758053288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ktxPXY3FXbFBz5mAoTAioVgA7sscE5zPCw8jojY97cY=;
        b=ikhi9GL6MvEd5UfON3LA/8xjtKUw3+ejBWhQsIlDL4ygZOUDDQ90CdGzpB4eL6+kD4
         KyZCwEB4xOsGNn5Wuvz7FxroZYvKP7oFIMOm4kfvGLTJTclj1LPx54Po4nWBf2Rdf/Qg
         48wOAtsuu7Yu/umbjkwRATON/MGHgpHYglkTPfN3/f4KnUkpx1XzuHl3+TpnSCkb1NOH
         ms5BBPvtYno2Ck87opHlSlv2ZEMHJBIifWM7Po9oczZWiJUQwsEEDBulw8tq4lDLEGUd
         wnZ4UMEmtYEC00DJyn/HxlGGbYLeWqSbb8CmReDFrjJ+jTknSO7MhAkBk/X9FyU5+wB2
         hQGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757448488; x=1758053288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ktxPXY3FXbFBz5mAoTAioVgA7sscE5zPCw8jojY97cY=;
        b=F9A2cpUAz5Oo69ILyAyoarfhKPCA7RB7diaXochvMZo/AHHEFiCvXWKPMfrVqEWv9J
         w24lBrAyipQHYmAlXrw+HL2o3Bxi4HmYjLTdi2ReSpJDKZcuinJLPmO/QplBRMNkK2DG
         Pn3oBsYFALKeljMg7kXTq0DkUOZdDcgKULVARvZRGGKzH9GPfC2I4vJ/F/04QcJGFNZr
         d9A1+KwMjr5fpTKy48M003N+tZrCJcVrDVji7YWeU0KAXtsY1Fv7jR8TNBjo2Tyn6kNn
         ey09Bc0hqGS4Oz4Y/M6xMMCXHFMatFAfuj7nx1gr12Zm6sjLQf7aCPWZEiArUOPCHGDA
         oLuw==
X-Forwarded-Encrypted: i=1; AJvYcCUUi0ipJCkTgt19JrCKY+Ta8Dz5yoV4HhoIqP09ArUGurXJ78uatu+w7KrbDwbRDN5IlGFrFaJl1ZeoKQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU8tnuBM+U16CEWEWmrUihMPjICDCTNuju+a1fbeM9nfDEwIiX
	mjO7egy7ZLREqp2c1RX/FTJM3ruVlofM+7rRjmojZVKHXGiAddCvNbOErcIRWiiZaxt5wspyrlY
	RIAyybi24FpSo7HylKW9WUICy3d2zB41I59IUdOH7
X-Gm-Gg: ASbGnctSl5g5Ck0+4IkeznOT/weXEw9ylk0mZQhSh55B7e9Fmbr9KLjhpFcg+r84JnG
	oKqbBC7SjLRqTelrrJT3TTAqNeWSKmhv1Og3/vuTCuZwnWa9pkMg+a1IaKGAYSfXY4hRbK41jr4
	a4JzlrmCPch5xiawrBhGyaFxygZ/VmNRrgCiLpqR2ywvfMZ3h+Hy/6c7yevKt2T1A2+uYs31of/
	ETea44fLzAjBa4IZe/dtqd2ZI1z+4TPYpacJlFm4UiL
X-Google-Smtp-Source: AGHT+IEiIDXhAKZ5zA3wuc6dlxMlvsypLMSrwiOmc3D0J6T34wMRv0GdxjHA98Txfmfmy63m+RjNtLqEv7OYeYbVsYA=
X-Received: by 2002:a05:622a:828b:b0:4b3:4b14:b420 with SMTP id
 d75a77b69052e-4b625643a28mr813671cf.7.1757448488179; Tue, 09 Sep 2025
 13:08:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909190945.1030905-1-Liam.Howlett@oracle.com> <20250909190945.1030905-2-Liam.Howlett@oracle.com>
In-Reply-To: <20250909190945.1030905-2-Liam.Howlett@oracle.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 9 Sep 2025 13:07:57 -0700
X-Gm-Features: AS18NWDRFWvZMJ8e1fk4lCTGGRgGWp1CT7Hd0CxGRModRraXwvLx01LRLebKNO0
Message-ID: <CAJuCfpGsGvYfCQmx1ix86zUM-u8n2EbSATS5bcHMs9=_yEtRzg@mail.gmail.com>
Subject: Re: [PATCH v1 1/9] mm/mmap: Move exit_mmap() trace point
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

On Tue, Sep 9, 2025 at 12:09=E2=80=AFPM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> Move the trace point later in the function so that it is not skipped in
> the event of a failed fork.
>
> Acked-by: Chris Li <chrisl@kernel.org>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  mm/mmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 5fd3b80fda1d5..b07b3ec5e28f5 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1310,9 +1310,9 @@ void exit_mmap(struct mm_struct *mm)
>
>         BUG_ON(count !=3D mm->map_count);
>
> -       trace_exit_mmap(mm);
>  destroy:
>         __mt_destroy(&mm->mm_mt);
> +       trace_exit_mmap(mm);
>         mmap_write_unlock(mm);
>         vm_unacct_memory(nr_accounted);
>  }
> --
> 2.47.2
>

