Return-Path: <linux-kernel+bounces-874991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9ABC17F4E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 02:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 21B554F4458
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 01:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AE92E2846;
	Wed, 29 Oct 2025 01:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BNf2ex+X"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923EF184
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 01:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761703050; cv=none; b=B/xFIjOWVjeRRUu6ggq4Sju2P1mOUOoUKPU15y+huhJDx7QduRZzF0I6LzBP2QrB3ECI8hKXMib5KOVYZZDXgoJcnFbwHyBs6pRmmQ1z5gHbHOT+wGlUOUkgjAzbVCyLMuH1jGs+qtVinJn5zvbtPPZCiQ+x+QuavHIIT9tC+3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761703050; c=relaxed/simple;
	bh=VfiKIYQTZRAVa5Lcx9ON0mLIIWj0lQmBi0hbA7PuTzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MTejP4IUNADaDH4jJoTrPXCL8NhLpV6qsDbP6d3knpoI1rspSLdZ4E1VMv6JIcj8GgW7qQ3k8dHJDxdqRwyQn91mvZ2ZzSWDRl0kDFEd2rrzR4Vpx8Pxttt59AQywqmQ2AWeIBTU4mZzBnDeLRqjSEco/NzoGIm//KikgOkEYbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BNf2ex+X; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-63c3d7e2217so12534637a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 18:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761703047; x=1762307847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VfiKIYQTZRAVa5Lcx9ON0mLIIWj0lQmBi0hbA7PuTzk=;
        b=BNf2ex+XsKWmZc+kbsrmzwRvjgKD+uxkedkvdVXOCg++HQJwJ7lQClNlEPW6n/sc4L
         nevZ/ZZn/CQNNw5/+G2pr763DwX0vwVxX4OL3VB3m5Fx6sOIVmKx72Xcozk1Ppiz5y0z
         I8m2KJTNlU2QqRQJPQxNS1H9OOjQlVKlbPhjvvbC4g4AdoKga8GLmF5hGa6H90/wCoDD
         eUrql57gTq3yiGi2L2/LL1kc2Z8B08d9+GCI4epVh0gxCYJaFPrOIw2n7XcEv6ahHqyg
         b7GCQNPWSyPsCTC8pw73MdsjPl6FpqK2Kg+moAbFum0Raq5FvAtJWlIx8LC5m6w1jSyk
         8Zwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761703047; x=1762307847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VfiKIYQTZRAVa5Lcx9ON0mLIIWj0lQmBi0hbA7PuTzk=;
        b=kSkPv0879OjdTFvGhIYVdmC5v8IxZNZdyuPljyhbeFPEUttNhun6eKkXF8ojkRNKV+
         ReSkQrSbeivyqkfXzyS8nPxOEnG5vmBf8Hx+XmgcP3P2ebPdisQtyL71LtVPa7ILXWmS
         EWygK0NuI9UrF4Am6RexupnGRMgKiHup6TOs/MDQolbdhsB3TxrBJXshz9efBfbqaNnx
         +7ZkBDs1CgPothnIzNF92fmwHj+FxdGEToW020C+p2ABw0R3WQBBMAFdYHvTeA7TEu0w
         EiRs5XhQUyfcqiz++tWS6RC2+SZtnmsL9iHrnoidbb+1kFCjcCh8ACtlIn0Aqh8hPgMC
         HQKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCvbTxz9oWbpIkvCqptb5IuNTCFfRnFWon7rrHK3NKYhIks8qiJCsdvt0Cj0iX1+L35efxyoHPcnVSrJM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg/am0+Ho9ueTezOIW+chpK+pkaPfpronr2rEFCYopFCshVS9G
	bctt++io216q45toVbDSI+BtP0Grgulh5VF5IJVnR89m1ie3fYt1q63pqkprXaDwBwJ7K0ZTie6
	9O00RLNQlIGML1lXp3K/w8Flljvf/YVg=
X-Gm-Gg: ASbGncsaxsvnkGhrdt8z4EKM4vSMEkNkNYbenJAJ+Sh5zwFqInkwHmho7n2QtPRgRCQ
	57UDpFF8n/yw4CLaIDGSwjv3fVcRztHgsblAOyiLi7rF2fmlSzBX6Pan17KcENsh3Ebl3Q9K3os
	u35yX1zRrscxVOebMFQU943dPrizWl/oxRBODh2lHCjayLuDsn17BvGfcFMQ6ix6b9nEVAFbFf7
	am82jtj8MsSx9HhxFGGOol6+t10//S35466SCBV23o0zLLVA33XPg6+kEy6oA==
X-Google-Smtp-Source: AGHT+IEwoe1Sba9NxVNKGdCq+7mY9Dclx1D8G5UVLGqJ6Gyca5OcCW/AEE9fQQzByTje75xjuPI37H2veAC5n++kz2s=
X-Received: by 2002:a05:6402:d08:b0:63c:4f2:2131 with SMTP id
 4fb4d7f45d1cf-6404425e8d1mr852014a12.22.1761703046765; Tue, 28 Oct 2025
 18:57:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027135423.3098490-1-dolinux.peng@gmail.com>
 <20251027135423.3098490-4-dolinux.peng@gmail.com> <CAADnVQLdN1mU-jR70WkkrWcfHXU1OOKDfWLdHS5Ji3-Fe++-xA@mail.gmail.com>
In-Reply-To: <CAADnVQLdN1mU-jR70WkkrWcfHXU1OOKDfWLdHS5Ji3-Fe++-xA@mail.gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Wed, 29 Oct 2025 09:57:14 +0800
X-Gm-Features: AWmQ_bnXkHTeuA85fJzsTKmVMX9lqv4tc3jkUu65N9yE0EQhMy08jcaCivgickc
Message-ID: <CAErzpmtFEudhMtYvmhb8gs0-YeA+_iET4azNML6fd9-8M9r1iQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 3/3] btf: Reuse libbpf code for BTF type sorting
 verification and binary search
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, 
	Song Liu <song@kernel.org>, pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 3:56=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Oct 27, 2025 at 6:54=E2=80=AFAM Donglin Peng <dolinux.peng@gmail.=
com> wrote:
> >
> > +
> > +/*
> > + * btf_sort.c is included directly to avoid function call overhead
> > + * when accessing BTF private data, as this file is shared between
> > + * libbpf and kernel and may be called frequently (especially when
> > + * funcgraph-args or func-args tracing options are enabled).
> > + */
> > +#include "../../tools/lib/bpf/btf_sort.c"
>
> function call overhead? I don't believe it's measurable.

Thank you. Since the overhead is primarily due to the function graph tracer=
,
I have reverted to the v2 approach and added the notrace attribute to the
relevant functions.

>
> Don't do it on libbpf side either.

Yes.

>
> pw-bot: cr

