Return-Path: <linux-kernel+bounces-803497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AC8B46095
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 19:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01A0F176520
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768922FB08E;
	Fri,  5 Sep 2025 17:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hGJe7bqG"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F3C3191DB
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 17:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757094403; cv=none; b=irz/QpFsyrpviWR+nuqLQ9Kr+YILX4E/cZVEp6W10bIbsCdPx2jiNGZ40UndcOJWrDv+TWnXIVuw11KQPz35DIk9L0y1wpmUtJ5MLMT0sViYOq1zZ15CJ3t89PYm/D3JrmcaI4mixK+p0IbUaBrMx8C2PtNnxKSE9L+m9XLzLlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757094403; c=relaxed/simple;
	bh=ImBcWa5EQacMGTiHmRHcGOuj7vGlSUaHQ6EbozwBxh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QI+VZuSkIAgACEvDRc4WJmS/QOts0Xn4cOql6XfjrK5fJRDWyNMDVjH0rPWj3AeUtaLbeVqlt3HGwdqH3wOcCjXJfYIWWrrn43hGEG51LBCZdSTB0Fsx9mzSEt5t8jRZLQVOa3hJlzvImQ8pwxdQHw89BQy4teSj13iVZI9c+wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hGJe7bqG; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3ecbe06f849so16137085ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 10:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757094401; x=1757699201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bpSR1HTJo6nPim1htqd1MlTdSRYvLLWGux9NsjKArVA=;
        b=hGJe7bqGU3o/0yzAr7aV61u8I+cgyzdCmVY6XUB+bxhVT3mhSBVRaEosRVFUf+SWy3
         K0E+F4e6z02seb0yvgvg/Sv2McgFCkaOXICldEDxw5jNwICtMduRnxGgxGSiXqCgyzIl
         S4tXy8PA6LfufZeq9LGCH+vLEGUy5Whes6WK2/RyBD66VMbhDZryWOigzJQlUVuUnndt
         QF1ACofL+/M2bb9ZW8KZmL9ED1c6z0l35rwDzq2jHNk34JfXoEFl0yMaw0pE1JkUxgVf
         01N0eUORFT0pA6KEUOZ51ToYtf7cjulJL6PtafnmV3O+cJ5uaJa31efaECt8CekLe/Kk
         pnGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757094401; x=1757699201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bpSR1HTJo6nPim1htqd1MlTdSRYvLLWGux9NsjKArVA=;
        b=eh4UnpxV84VJGfP7jAumSUHAGIzHDoC/9a5g5HvcHI0i8WisM9xa9RNIZYinZk/GQF
         zZMs2xt7mGmvvmBnp4s7+LhDaOyEn8hEeFH69gir8qMr8Xk6Fk3VIFuzrqQlRKEdsIul
         4HNCYCQL45akBUQNj//gXYOjXaB/FdRI222fZzaE2X9Dn1r4fThqr4OgSXZfvVxe5TjH
         03KcNvHfLhnfGZZ/ao4nkqiV62/dBLRebYO45Z7Eas7yvLUnQDqiMruPtrfkZQohc890
         r4gE1wXVE9yfnX5QELbeiZwj5mkPIDOeFssGrLN09uJOQPORQRDynpcl8Cm+sO/RrCnK
         8l+w==
X-Forwarded-Encrypted: i=1; AJvYcCVviQTidPgeGsnH7dg1jurZ+9cOwnIDuLs6JtHopOv2oJkIGAlFR42jFmQLbyPYC2bHeULxdlEkzOilIpI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1Rpg0a2gbajFJafr18BBk8eRo0ZG03fm4x5VX92dxUdFK7Kbm
	6Lr9HdVipOEUy6Uh7peLauwuWfyr2oJB5WeXkWNmVWZrB8ISFPe6uk6G3gtIRCUXPg2RNzVrkQU
	3NUjS9qCXxvJwBGusH12EEXEGgo+Hgx8=
X-Gm-Gg: ASbGncsJkh+rXv6HQSDYOPu2KAdVmrr2HLnJ26+hFqhQf/YrG/tzDgqMK4sf3RpnRkL
	0T8IBbdiod2qj9hrCcoSXsw4cyNb2m8Nx9shYHIj3033IvQHNxhmRBrcSIEhj58ZxhTC7nfLFAG
	gJSpo455+l5kd/F1l7WQjcVn7lAhQ0SPN/MW3ctHKADPENn4ASozSrpPV0BaB/o+8JN4i1+vg5t
	n8/
X-Google-Smtp-Source: AGHT+IFk5Xz55Lrwaeg30ggic9C4Fnk5btiTmEEBZkVEbj3Gn6+4gdw2Oshvs2RpuY9fAkh+7wPvJ0+It5jjM+pHCSo=
X-Received: by 2002:a05:6e02:1d98:b0:3f6:6ad8:6fbe with SMTP id
 e9e14a558f8ab-3f66ad871c0mr88436955ab.27.1757094401258; Fri, 05 Sep 2025
 10:46:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902-show_mem_zspages-v2-1-545daaa8b410@igalia.com> <paef7bzotb4runl4sjlcfesano36cc2bflb7uqe5mil3chnpgn@axng3yfe33w6>
In-Reply-To: <paef7bzotb4runl4sjlcfesano36cc2bflb7uqe5mil3chnpgn@axng3yfe33w6>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 5 Sep 2025 10:46:29 -0700
X-Gm-Features: Ac12FXzSy6TF-VgA3w4rWead4D6W38SYTeqqM6XV4n8p8HfQa0Ka1hCs1_kico8
Message-ID: <CAKEwX=NE3ngvFnyHQTAofX3M08JkeZZcfaKi_mkOUuiB4zh6Dg@mail.gmail.com>
Subject: Re: [PATCH v2] mm: show_mem: show number of zspages in show_free_areas
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Minchan Kim <minchan@kernel.org>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Chengming Zhou <chengming.zhou@linux.dev>, SeongJae Park <sj@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 11:44=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (25/09/02 09:49), Thadeu Lima de Souza Cascardo wrote:
> > When OOM is triggered, it will show where the pages might be for each z=
one.
> > When using zram or zswap, it might look like lots of pages are missing.
> > After this patch, zspages are shown as below.
> >
> > [   48.792859] Node 0 DMA free:2812kB boost:0kB min:60kB low:72kB high:=
84kB reserved_highatomic:0KB free_highatomic:0KB active_anon:0kB inactive_a=
non:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB =
zspages:11160kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free=
_pcp:0kB local_pcp:0kB free_cma:0kB
> > [   48.792962] lowmem_reserve[]: 0 956 956 956 956
> > [   48.792988] Node 0 DMA32 free:3512kB boost:0kB min:3912kB low:4888kB=
 high:5864kB reserved_highatomic:0KB free_highatomic:0KB active_anon:0kB in=
active_anon:28kB active_file:8kB inactive_file:16kB unevictable:0kB writepe=
nding:0kB zspages:916780kB present:1032064kB managed:978944kB mlocked:0kB b=
ounce:0kB free_pcp:500kB local_pcp:248kB free_cma:0kB
> > [   48.793118] lowmem_reserve[]: 0 0 0 0 0
> >
> > Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> > ---
> > v2:
> > - fix build when CONFIG_ZSMALLOC is not enabled
> > ---
> >  mm/show_mem.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/mm/show_mem.c b/mm/show_mem.c
> > index 41999e94a56d623726ea92f3f38785e8b218afe5..c563d9adfa87765a8736e91=
c1f68d824b03eaea8 100644
> > --- a/mm/show_mem.c
> > +++ b/mm/show_mem.c
> > @@ -310,6 +310,7 @@ static void show_free_areas(unsigned int filter, no=
demask_t *nodemask, int max_z
> >                       " inactive_file:%lukB"
> >                       " unevictable:%lukB"
> >                       " writepending:%lukB"
> > +                     " zspages:%lukB"
> >                       " present:%lukB"
> >                       " managed:%lukB"
> >                       " mlocked:%lukB"
>
> A little "preliminary optimization" idea: do we want to specifically
> refer to it as "zspages" or do we want a more generic term, just in
> case if zsmalloc goes away, or if there is (are) another allocator(s)
> for compressed swaps?

Hmmm, zpage? z is a common prefix for "compressed".

I'm honestly fine with zspage though. We can just have any new
allocator call it zspage too ;)

