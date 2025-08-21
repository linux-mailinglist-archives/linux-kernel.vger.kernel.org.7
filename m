Return-Path: <linux-kernel+bounces-780696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E43B30827
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 23:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DE6B1897296
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 21:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AADF230269;
	Thu, 21 Aug 2025 21:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZTKWrar"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38B01AF0AF
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 21:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755810785; cv=none; b=ReGNLR/sJWdlHmeqNH0gjVO0NzgnnvJkQmSYab1nnmx74ECdHQoEiOjIPEvrwJirN6ShJ/IczOgW6wHWGrTG3wmvZp2XTweAVnKTvfeSEIjmAEu3dFyHyJh8uxT9aBI6llHwFtstahVVFiTBQDhq0QMFA+le5x+8F9fUCBvJ6h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755810785; c=relaxed/simple;
	bh=d4LvZt2aqV3dFzac86Byv4m6KNuAQDtZesHFxEyue/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i9UqMYK2Y90rqbEAWtN/BZUckSHOQ8o+/6k0KKVx7qRoQiKa0cQfJRkNUq1vZeIN0ltZqc+PVkos2Ggs5lB6hYPVp5ClF4xcF5tj1zUdja/y6KP8FMkK03JtxdJ/b/w7HkwnM8SxrJcZgExaqYuX2qTxUo416wc6eJB86xgiIjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZTKWrar; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB28C19422
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 21:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755810784;
	bh=d4LvZt2aqV3dFzac86Byv4m6KNuAQDtZesHFxEyue/g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BZTKWrarz+FjcikzzA1VRYISyCwmmVs7q36u6GQ5nLj9rMp/6XDxRrX2yEcN6Qi60
	 vE2iwGEapgUoT6jo9NBGg/sFy8TlAqwRqYkNq/lYbmXGpXNqOfGqIX4b+OfhlupjPt
	 Pq9rWFXiKZcofJV+a9khr5a/F6D/t8D06iKjyM9LHeuwDn3MnUTir2JVyXftsnFF5b
	 /C+xOBsWw5Zoi3RslBsV4LEtTjToptKyG2jRG/xVafKlJyVnPPvmhJOBRsPRHmcMH9
	 hc82BmzhACWboRl8bGmN/p24RUprdE8U5N58RrIUkTgAzFkfut3RKkt6cuwVAX2TR/
	 bubme2TfdJeVw==
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-459fc779bc3so7765e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 14:13:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVUqeExZZRWkLY73tmGzVdQlBJaH3nrFTfIYtGiqWLd9uknwG3fjpsoYMo8pVgW11n/WHA/FId2u2zZx6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVXOMhZO8hlaICsKepq81ywovPiyN4/QSswCqMvSmOMd4yfmiI
	mCTMQO8Ww8U3u4rjnNYqtPkjarhbew7KaDhhqHbcqZOpYhFK4P+OR7G+PWLx+foUpn82kReYvH6
	U4/I3ZyAgJlpwsdN2/U9McMWlzjyaE8+nKM/1PuvH
X-Google-Smtp-Source: AGHT+IHwAslQYh3tct59quajnnFXnOJIh7Dx/F1xRgBrh+DxXFUL4O7TIP/4OJCF7vgKU/9zH2fA6BUTYK6TqvAM2Ck=
X-Received: by 2002:a05:600c:2d47:b0:45b:4acd:836d with SMTP id
 5b1f17b1804b1-45b52128850mr39305e9.5.1755810783115; Thu, 21 Aug 2025 14:13:03
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815191031.3769540-1-Liam.Howlett@oracle.com> <20250815191031.3769540-2-Liam.Howlett@oracle.com>
In-Reply-To: <20250815191031.3769540-2-Liam.Howlett@oracle.com>
From: Chris Li <chrisl@kernel.org>
Date: Thu, 21 Aug 2025 14:12:51 -0700
X-Gmail-Original-Message-ID: <CAF8kJuPs4FBQ3x8Z_ME3vjwJHaAtHeE8jmn9pBqz8cau72e_+w@mail.gmail.com>
X-Gm-Features: Ac12FXyAKFIrA1ANsgy3Dp9wOcjESjPU68j7zxxmQrp3w0J6Atw6ZDtuSNed-Ek
Message-ID: <CAF8kJuPs4FBQ3x8Z_ME3vjwJHaAtHeE8jmn9pBqz8cau72e_+w@mail.gmail.com>
Subject: Re: [RFC PATCH 1/6] mm/mmap: Move exit_mmap() trace point
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: David Hildenbrand <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	maple-tree@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, Charan Teja Kalla <quic_charante@quicinc.com>, shikemeng@huaweicloud.com, 
	kasong@tencent.com, nphamcs@gmail.com, bhe@redhat.com, baohua@kernel.org, 
	Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Acked-by: Chris Li <chrisl@kernel.org>

Chris


Chris

On Fri, Aug 15, 2025 at 12:11=E2=80=AFPM Liam R. Howlett
<Liam.Howlett@oracle.com> wrote:
>
> Move the trace point later in the function so that it is not skipped in
> the event of a failed fork.
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>  mm/mmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 7306253cc3b57..c4c315b480af7 100644
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
>

