Return-Path: <linux-kernel+bounces-872464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 302D4C113D5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 20:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA20D18993A0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 19:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DCAD31B80E;
	Mon, 27 Oct 2025 19:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LjIWPXx6"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD892D7D47
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 19:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761594298; cv=none; b=Au1OewUKuIaZxh2UPTjs12CFLgAKX0yQJcT+CDfyApJGoA/QKV/vkI1p0ZZxy+hYNouMJNBIclSIsl179nTkkvQzpOuNLYG8pA6TInbkkKaO9gqRuWpory09/gSkcBDvUcrbvKEmCOQj9xM9xKKcCLr9KDzmyvI7xHH80TOrKYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761594298; c=relaxed/simple;
	bh=2+B45/rPs1MVjTtFKAmg7Mxr3EYanBlo2Mo3UvbIz5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uFcVKPWjXs/NOZQ/zaQYD/EFLXZZVpkEDEaZAl/MIRzH7fZ/Iqjg96Q00Mn68mvpWndqb5s7fHWhYPJa5ci0XPZMvorkpB+xXDcSkIvsrJWllVnh9g9auPTIFfUa7Ug7iMFRoA9eh9oqIx7Y/p1os9dDqGVUgUT+fOcBxKufn+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LjIWPXx6; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4ea12242d2eso12551cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 12:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761594295; x=1762199095; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JptCkBXsHjZlBBzRnLae/mJJEFh3aB9VIqvSzCz+zbA=;
        b=LjIWPXx6jIZTrKELLV+28UuoInLQN8U33wINOfUenzAV4XuK+X4G+CBVYzJNuQBpc+
         hzjiJUoriBgCmd6zVPnDHiXlCsJ7ZhiTWDsstf/rhKQ/oePwHBN16dpvIAEqJFy8qan+
         Shd8B3NUygWiy6cOhhM2rof5L3BbVz5xwU4KYvEuwnAcvPD5fkhg1y5bmj9WVyUQQ+g9
         5CcCRsj6IQVP+sQOpL7jHXfNkXrTU7DqJtxVKEiDRABkm8ImWV9yUA9XEtMEN6UjP0Ed
         /6qT4+2cbZglcloRqn6/biWjxzF/mGCHxov2bA+/JRmjQQriUWz3NKmDtWpAsWJvhvY4
         EdGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761594295; x=1762199095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JptCkBXsHjZlBBzRnLae/mJJEFh3aB9VIqvSzCz+zbA=;
        b=ScCfPdQJVVXMpMOduKmTasCe45d2DqFvzDi1FKdTnY+qvN4izxCm3ELDzNQkhGmckc
         NeoXggRkeyEyYs2wK6lY/mFzZGR4cHpiP612x0+iKI6R+uPp9xOZhJ1Ype06sAABQK54
         Ik+i8u0pDCJz/Il+bK1gYnsXmAYMr5VEjKfjF2VU61NSc6hXD+Mdzn4jIMT0LVybvWA3
         GILQb+lxQ6MPNCjHtIP0pWQqjKbqp+vNIZY97EpWJnrHrgkRhQUjcsoYfjmnN8d8Hivy
         q7tqgIRUg1d4WzNCm/HhIuE9kBJ1pJF1lKfT5P7a/qsxmi0rLsto32f9Q2Y4oV+8QP3W
         JLAw==
X-Forwarded-Encrypted: i=1; AJvYcCUozcsoz0A3rsezL7AFQh9hAPGwFZeyyXpMa6dLwov9LZIvOSaLK+JbX5ooWkd7KB+mqaabs71HIoI3ahA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlQCC+/M2/6ZehjRu60fJIZVWA8AkIL2OOm8LxgTtwWgzOkZ59
	v3vUwVxUQPC8CClAlp8ejbeHf0+2/k1wM6n06hCHulQtirQRDRegWrGysMDlgwGS4DCtKXxqMKt
	n/ee7Jmk+LMQbLyAjV5KZrnJ5ux8+Bpm0H7nCIvxA
X-Gm-Gg: ASbGncsvc2MHwoCju++AYfzLS4XCoox7FAqSEWHaTupBgV0kWJjhZR7+chcq8FC7l6w
	UbxkRYwyxqyXlcVJ2T5xZVg67wm6HbqA/EZSGGapXerRcSMnuBFcXkSwZ5NvYegfwK52X3SKYmW
	71r7uXzUInWHAC+vqOFkU3X+euhv2qRUJvl2k0RWVIYWHLXDA2LvVwMKB2P+Dlgwk8X1Nek4LyC
	GrfQPrQzCqAvy2SvGusFIAXvKarFFGPHphULsbuB2yDDXkyTBps77Da5MA=
X-Google-Smtp-Source: AGHT+IEDRWjZQdkoQn4JOV8IDsTmIW0+zMctax/00G1Ot311AEaKU+dlsGs5ioPlepPWCTlzahP9mAEfzBcRuEnpQFk=
X-Received: by 2002:a05:622a:145:b0:4eb:75cb:a267 with SMTP id
 d75a77b69052e-4ed08f87205mr1488091cf.12.1761594295008; Mon, 27 Oct 2025
 12:44:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027085214.184672-1-hao.ge@linux.dev>
In-Reply-To: <20251027085214.184672-1-hao.ge@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 27 Oct 2025 12:44:44 -0700
X-Gm-Features: AWmQ_blDdOyc-tNIULuWANg5xz4Mu6a22Tyq-1C42xlGGDpEiRSKathUjbCucF4
Message-ID: <CAJuCfpF+0ok85A1ZhbptSzrB-X6CUj=TMj9ZvwzjV1tO5PqFbA@mail.gmail.com>
Subject: Re: [PATCH] codetag: debug: Handle existing CODETAG_EMPTY in
 mark_objexts_empty for slabobj_ext
To: Hao Ge <hao.ge@linux.dev>
Cc: Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Hao Ge <gehao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 1:53=E2=80=AFAM Hao Ge <hao.ge@linux.dev> wrote:
>
> From: Hao Ge <gehao@kylinos.cn>
>
> Even though obj_exts was created with the __GFP_NO_OBJ_EXT flag,
> objects in the same slab may have their extensions allocated via
> alloc_slab_obj_exts, and handle_failed_objexts_alloc may be called
> within alloc_slab_obj_exts to set their codetag to CODETAG_EMPTY.
>
> Therefore, both NULL and CODETAG_EMPTY are valid for the codetag of
> slabobj_ext, as we do not need to re-set it to CODETAG_EMPTY if it
> is already CODETAG_EMPTY. It also resolves the warning triggered when
> the codetag is CODETAG_EMPTY during slab freeing.

I'm not sure what scenario leads to handle_failed_objexts_alloc() and
mark_objexts_empty() being used against the same codetag reference.
Could you please explain the exact scenario you hit?

handle_failed_objexts_alloc() assigns CODETAG_EMPTY to the elements of
the obj_exts vector while mark_objexts_empty() assigns CODETAG_EMPTY
to the obj_ext of the obj_exts vector itself. In what case do these
two calls operate on the same reference?

>
> Fixes: 09c46563ff6d ("codetag: debug: introduce OBJEXTS_ALLOC_FAIL to mar=
k failed slab_ext allocations")
> Signed-off-by: Hao Ge <gehao@kylinos.cn>
> ---
>  mm/slub.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index d4367f25b20d..cda8f75b72e7 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2046,7 +2046,17 @@ static inline void mark_objexts_empty(struct slabo=
bj_ext *obj_exts)
>         if (slab_exts) {
>                 unsigned int offs =3D obj_to_index(obj_exts_slab->slab_ca=
che,
>                                                  obj_exts_slab, obj_exts)=
;
> -               /* codetag should be NULL */
> +
> +               /*
> +                * codetag should be either NULL or CODETAG_EMPTY.
> +                * When the same slab calls handle_failed_objexts_alloc,
> +                * it will set us to CODETAG_EMPTY.
> +                *
> +                * If codetag is already CODETAG_EMPTY, no action is need=
ed here.
> +                */
> +               if (unlikely(is_codetag_empty(&slab_exts[offs].ref)))
> +                       return;
> +
>                 WARN_ON(slab_exts[offs].ref.ct);
>                 set_codetag_empty(&slab_exts[offs].ref);
>         }
> --
> 2.25.1
>

