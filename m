Return-Path: <linux-kernel+bounces-758418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7A2B1CEB3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 23:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 167863AB03B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 21:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D77D22FF35;
	Wed,  6 Aug 2025 21:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PJILIwn/"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9413A22D9F7
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 21:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754517294; cv=none; b=mcm7P2ihUk8PyCcurt/Du0Ha/aoBBEHINLMSjJMZh+xkZH9KVBEPdSQpN68h3r8L62hC6D7CGZ/5NwtYh9sAvp0F8IPxrjICPCeADqNyUx8P6ZtnhNQEKIX1aOOjufoRSUGBZ5XCS4owqtDDix7GwoxnP5d5RYZ25CPGeLzCtFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754517294; c=relaxed/simple;
	bh=wzwCwuhZLT/+kj+O3V6lcQiJXb33vcCbaKrtnnQwVGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UNERElsp2S50fIvZ3oWZt6+NyAlCp9LFg0QszIPvqxK5kUi2tUSKDEOuibL5PYp1e4kxG6qbV7iLlFqrZcNQgktsEKmNi0Mcp5JOjCO5WwjrMRcpqZQ4A9lrgQsvlOvxNnxSd7ZgjYU7L/PRNcfWg++T0H41siZDu4/z+HHJGSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PJILIwn/; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-24070ef9e2eso63585ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 14:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754517292; x=1755122092; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wzwCwuhZLT/+kj+O3V6lcQiJXb33vcCbaKrtnnQwVGI=;
        b=PJILIwn/lpUicBLvQ1IquVedDUL2P6Pw9hq+ZXrt//noXg66Y5UBisbyNQ5xeuGzMg
         CRVv0HpsmbX7TQOa+osPxmzm3H/x1EC8QfuvTh/Tf/3UKiMS+B+EZhBX8OwpzWHeb9uU
         lIWPPk1mSl2bXqkcdBHFiTcUGO5yjnb/M8Etj7rZAZWI/glArApW93xuoqB1MbBwAd6f
         2CbCQ57OR7MB0J44vp3C/RPNztWue6vPWfXfSFanUXza36yLDvGBjL5TzRtDJpOXLqYy
         ENDlTgaiSpkh2ijR5QutdaLejMXfpeMfEy1IHYhwOY4E5Kov1l6BF78x5bT/fpkyljxB
         cN/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754517292; x=1755122092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wzwCwuhZLT/+kj+O3V6lcQiJXb33vcCbaKrtnnQwVGI=;
        b=jmnbwXM929XZxzdbpi7VsTUnyhB1wtEn34yDpPyVSX6EzBxOpXgUB7XgQInP7A3PFD
         F4W8l6LUf/mU8esdJZd7rBBpRrZAMqq9RS6ZBSSRW+rUGPeBnZy3pAV7dm0qBlfPgDAj
         9J0PVEot3wkdotqO1f7PbxSA8XESKdG5JQo5VwcCtdB+00yW0G2VZulF/LiJbPdntvNh
         eyGcjYLknD7o965YYOSSPti6AA5f69GddAQlbjDIoU6DxWLdCQ6hBO8uDo/kkj9vEZzb
         5b1faNkDgrH46fAMGYAN8up+XlGFqRPV9lALct924nIi6pgPbumnvuzBKjOFqSpJgU9O
         ycdg==
X-Forwarded-Encrypted: i=1; AJvYcCV81v/4QBzLVQsZaKsyxSUGPvRigRuZhOS2rNlqYSDVCfrPfg+hVOPT+CivdvPe1GaWkl2c9/0yF68dfkA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ7dKMoPiolbgSsDamt2PXCJe3/hIIc4WuLhSjbj/P3B5j9O8E
	eryHm7sgZLcifwRyXmEQRNdL4Z4BQbr6GZFjG0QCDtxqNy+QLJiG3OotJl9QtU6bFRn79H7Z8a+
	q7BJl/S7L7GL6o6ALM6ndWz/kWaceQoOZ7elNz/Bl
X-Gm-Gg: ASbGncvWJcMGjeU9vKaFvgEIStfJKmg3rQGXDbf7DVbJhNsk3HeUNh1//Bh2LqPDQKj
	Lgx9vdtfv79n7l27dNX4Thogjnhs3M2MxudqnJAn3Uqmf217oOCdNjsweEmKlny8P6Zw2iTv1+v
	R5ivP2nRvULaPVU7b1LZigGyw62oUgZ+AJf0pgS8J9dD/Yiv0hIgR9g013OGWuRKXX6zuh+k1FX
	mGYe4UN5EaTc2tsBgoOw3JQDuRWIeqG1VyfqUHSdgknPlCw
X-Google-Smtp-Source: AGHT+IFYqrtp7JG0RfEaCFBlvsdX3gPrSrR0w79mzMBohMX0IZtkG8ES6BAULUyIYgI5eIGYjgMK4NZ+91j3WRygSds=
X-Received: by 2002:a17:902:f685:b0:231:d0ef:e8ff with SMTP id
 d9443c01a7336-242b19cdb6emr1226665ad.8.1754517291353; Wed, 06 Aug 2025
 14:54:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJDx_rgzkZognxWzOXJ-ZxdTtUaM3FT6bmpkwxMz03XiX3fKAQ@mail.gmail.com>
 <d395b14a-9a84-4f25-b4f0-45e8500fc5fe@redhat.com> <CAJDx_rgrp1TpOt-iDcsSGRTL=qZZsK_dpKL1bSkyunPGcGXt5g@mail.gmail.com>
 <4566222d-6b91-4789-bdd6-61e3769f5dbf@suse.cz> <CAJDx_rjvYdjPYHbBDKvkaWV=-OPJG=oRdSAugaOyJAXaOVu-9w@mail.gmail.com>
 <ee7ba479-4917-4d83-8130-8c247c08d2d0@suse.cz>
In-Reply-To: <ee7ba479-4917-4d83-8130-8c247c08d2d0@suse.cz>
From: Juan Yescas <jyescas@google.com>
Date: Wed, 6 Aug 2025 14:54:38 -0700
X-Gm-Features: Ac12FXzxJB1KJhmM9UUQIP_g3mb-qTY9IZidyxnzraRCfXRqR8AlpzShlLDxEgA
Message-ID: <CAJDx_rgL4bWnftmEfqnt87KuTYrvn-7J+ZOu5fd26q+fi0RVgQ@mail.gmail.com>
Subject: Re: [RFC PATCH] mm/page_alloc: Add PCP list for THP CMA
To: Vlastimil Babka <vbabka@suse.cz>
Cc: David Hildenbrand <david@redhat.com>, akash.tyagi@mediatek.com, 
	Andrew Morton <akpm@linux-foundation.org>, angelogioacchino.delregno@collabora.com, 
	hannes@cmpxchg.org, Brendan Jackman <jackmanb@google.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, 
	Linux Memory Management List <linux-mm@kvack.org>, matthias.bgg@gmail.com, Michal Hocko <mhocko@suse.com>, 
	Suren Baghdasaryan <surenb@google.com>, wsd_upstream@mediatek.com, Zi Yan <ziy@nvidia.com>, 
	Kalesh Singh <kaleshsingh@google.com>, "T.J. Mercier" <tjmercier@google.com>, 
	Isaac Manjarres <isaacmanjarres@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 2:09=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wro=
te:
>
> On 8/5/25 19:12, Juan Yescas wrote:
> > On Tue, Aug 5, 2025 at 2:52=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz>=
 wrote:
> >>
> >> >
> >> > Thanks David for the quick overview.
> >> >
> >> >> I still have no clue what this patch here tried to solve: it doesn'=
t
> >> >> make any sense.
> >> >>
> >> >
> >> > The story started with this out of tree patch that is part of Androi=
d.
> >> >
> >> > https://lore.kernel.org/lkml/cover.1604282969.git.cgoldswo@codeauror=
a.org/T/#u
> >> >
> >> > This patch introduced the __GFP_CMA flag that allocates pages from
> >> > MIGRATE_MOVABLE
> >> > or MIGRATE_CMA.
> >>
> >> What kinds of allocations would then use __GFP_CMA?
> >
> > The __GFP_CMA allocations are used to allocate userspace anonymous memo=
ry. This
> > was done initially in the alloc_zeroed_user_highpage_movable()
> > function, now it is done
> > in vma_alloc_zeroed_movable_folio().
>
> So that means you perceive the risk of anonymous memory being temporarily
> pinned and thwarting a alloc_contig_pages() device CMA allocation lower t=
han
> for file pages? The pinning can be a gup(), or a compaction migrating the
> page, etc...
>

I think that was the assumption when the patches were sent :(


>

