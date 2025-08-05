Return-Path: <linux-kernel+bounces-755803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E20BB1ABFD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 03:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4221E172954
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 01:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B69192580;
	Tue,  5 Aug 2025 01:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B/vd8tX6"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB03189905
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 01:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754357106; cv=none; b=b9hw8kJuFYoPlWY9zJ8wk/m5ILiy79AZamdoIwboIECx/ILU0vVNBLHBlQH1SthTEvwBX1RrijfylpZUxzWdOzNp68qExO4MwF+yxpC/Swuu1Ifcf1W+8lHNB+NsLpiSvMFp224MRptYvN2Z8l5L+dJWS0JzLNqoJ8wY2lTs4pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754357106; c=relaxed/simple;
	bh=WOxJd4NbFHO3LlR4MpOBylEfyAcyuSwlZhpBODqzhsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mgrede/0sLxd/9mOQ1JETE+lL6DZ+WT3UcZlJ19I0kCvwl29kHppFHu/e2NKk+CLhDlJjfuX+MvERrd/n+i+NzFZIEdTxL1HDp+szT56DdXJ6sPOBqgmBsZGd6CIlTMAieqA9OPB8L+E6tG0cabdCHIBtAlHbxd3MEZMLYHLXkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B/vd8tX6; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-24070dd87e4so77075ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 18:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754357104; x=1754961904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WOxJd4NbFHO3LlR4MpOBylEfyAcyuSwlZhpBODqzhsU=;
        b=B/vd8tX6Wj8AKoFU/BpAPCbHEp3TOhBfNQeUWapKbfG2IW1J1X0vtpJiAnrJYJ0o9d
         LtLCq+W5Kbir+/+D2yGP9hdzUI3XxJltBAINHQx/OOqccW/QUPKseA5kFjtRcHVPQsdj
         T9cu7VnaHw/64YhKkAP4iXi1ag3stvdLAsjIyxCgduk0fvc2Kgk7dz/9Utd0wyJP/0nk
         2txleSi54OGgf3ex/s/uA1ba3jx/odOdFimk3k+ouD6dFXt8HxoWx3aP/W4+LgCX1/8s
         Gx16FFfTPtPaZdjDRuSxQS1HV+bpjuFdRfAb48+dt2WOEQQj9yvOlXqnTJ7QoGQy75+9
         i4tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754357104; x=1754961904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WOxJd4NbFHO3LlR4MpOBylEfyAcyuSwlZhpBODqzhsU=;
        b=RvQXc6CKZHPMWPgBkEdwj1gzTwWFW2U3PUbJZ2ux3rXQHPSeof7sriG7lphJgOkeaH
         Qz+p5h4Hbprbx0/LQjqQG2WX1lHWn0Ym/kt37h59Nfwyo5+txp5NbLInTDQdmgSUYpSP
         i0fe1zedrfw+aO+y80FiYcQCJ2Hg9Pni/NbMwpKx0eMF5tTYfuoz587/vx0F3i7CpWe/
         1eSYTEGIkMf8lihvPG0/2xqSAe0xxpvzMrcb39oXYB8LxGij/5O0cWmeQRDWoGs9fcDP
         hXXgvVF/CYTly9kBgj6LuqjIArG/UEJu+kmhUElNNQMZnZ6nfLALuAMqRW9gy87201Oz
         en1A==
X-Forwarded-Encrypted: i=1; AJvYcCUKuSg4iMjLswoLFI92DGjHxZ+se0ZTesGSBzdRz5CrvLB3ZKRN4Am7kvzqSPePgseAtB5wXuRc7lhWF14=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBJzJXhIQ7ji3SVsw1hKsi7NQXwHO21ra//PSXsVRVpMwipWTJ
	h6fzNCLtQW9VfvxSp9FuL3V5WMG6L7rzvbwizZ5PFr4kgkeetXwDQzvNZs2L89AiVwcB2RPRCDw
	pQodD4FQw6GNhhYFqoo7D9e36pGqsrCb7FKCXcEP2
X-Gm-Gg: ASbGncvzpKtLtYmyR64XMWZqEE82a4+NuAsqLqjl8vTCpol9/pUFPCePla/9S587/01
	y3b1P5NHxB3BGh50lU39TSeoanWfbGjB1jAwITlIDPnW8nkDtM5MLsxf4cjWNhsQ7GQCcMvwEMN
	Azai/LzBm0Xd32kg7aaWBgoKjhZrd8XNiOONvQRaU+pZzqKwzqsqOTGZ9iy25t4zdPxCYvG/KbM
	S7oX4KWU89WVHLMirKV/yhMgApmg74PFju9J+7j
X-Google-Smtp-Source: AGHT+IGlJmNfwi/BL4sdNg3IcRsYuofmOwv7pzZKDekvC/MlCzimr5ljrnxQNNuBlGzWZKaEvJBcyRJkdCx796VG3hA=
X-Received: by 2002:a17:903:3bc3:b0:240:22af:91c1 with SMTP id
 d9443c01a7336-2428eaf97ddmr262835ad.22.1754357103774; Mon, 04 Aug 2025
 18:25:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJDx_rgzkZognxWzOXJ-ZxdTtUaM3FT6bmpkwxMz03XiX3fKAQ@mail.gmail.com>
 <d395b14a-9a84-4f25-b4f0-45e8500fc5fe@redhat.com> <8A3D2D44-DCE9-48FC-A684-C43006B3912F@nvidia.com>
In-Reply-To: <8A3D2D44-DCE9-48FC-A684-C43006B3912F@nvidia.com>
From: Juan Yescas <jyescas@google.com>
Date: Mon, 4 Aug 2025 18:24:51 -0700
X-Gm-Features: Ac12FXywo_FBvKfn816eFQhOWDa_XVeaC7qAl3HAB468md2l2Uuye3UZxdQHZ5c
Message-ID: <CAJDx_ri28-_SqPoYgm2DHEwkA8Y8PU9+YjbRZqMdGpy_k0DKuA@mail.gmail.com>
Subject: Re: [RFC PATCH] mm/page_alloc: Add PCP list for THP CMA
To: Zi Yan <ziy@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>, akash.tyagi@mediatek.com, 
	Andrew Morton <akpm@linux-foundation.org>, angelogioacchino.delregno@collabora.com, 
	hannes@cmpxchg.org, Brendan Jackman <jackmanb@google.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, 
	Linux Memory Management List <linux-mm@kvack.org>, matthias.bgg@gmail.com, Michal Hocko <mhocko@suse.com>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, wsd_upstream@mediatek.com, 
	Kalesh Singh <kaleshsingh@google.com>, "T.J. Mercier" <tjmercier@google.com>, 
	Isaac Manjarres <isaacmanjarres@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 4, 2025 at 12:00=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
>
> On 4 Aug 2025, at 14:49, David Hildenbrand wrote:
>
> > On 04.08.25 20:20, Juan Yescas wrote:
> >> Hi David/Zi,
> >>
> >> Is there any reason why the MIGRATE_CMA pages are not in the PCP lists=
?
> >>
> >> There are many devices that need fast allocation of MIGRATE_CMA pages,
> >> and they have to get them from the buddy allocator, which is a bit
> >> slower in comparison to the PCP lists.
> >>
> >> We also have cases where the MIGRATE_CMA memory requirements are big.
> >> For example, GPUs need MIGRATE_CMA memory in the ranges of 30MiB to 50=
0MiBs.
> >> These cases would benefit if we have THPs for CMAs.
> >>
> >> Could we add the support for MIGRATE_CMA pages on the PCP and THP list=
s?
> >
> > Remember how CMA memory is used:
> >
> > The owner allocates it through cma_alloc() and friends, where the CMA a=
llocator will try allocating *specific physical memory regions* using alloc=
_contig_range(). It doesn't just go ahead and pick a random CMA page from t=
he buddy (or PCP) lists. Doesn't work (just imagine having different CMA ar=
eas etc).
>
> Yeah, unless some code is relying on gfp_to_alloc_flags_cma() to get ALLO=
C_CMA
> to try to get CMA pages from buddy.
>
> >
> > Anybody else is free to use CMA pages for MOVABLE allocations. So we tr=
eat them as being MOVABLE on the PCP.
> >
> > Having a separate CMA PCP list doesn't solve or speedup anything, reall=
y.
>
> It can be slower when small CMA pages are on PCP lists and large CMA page=
s
> cannot be allocated, one needs to drain PCP lists. This assumes the code =
is
> trying to get CMA pages from buddy, which is not how CMA memory is design=
ed
> to be used like David mentioned above.
>

Thanks Zi for confirming!

> >
> > I still have no clue what this patch here tried to solve: it doesn't ma=
ke any sense.
>
>
> Best Regards,
> Yan, Zi

