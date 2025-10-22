Return-Path: <linux-kernel+bounces-865783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F34BFE01A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 21:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 16574352132
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 19:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79DF0333448;
	Wed, 22 Oct 2025 19:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UDDYpwke"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189D72F4A19
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 19:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761160860; cv=none; b=I/HcSu4OMCd2X4hq7jhrDgaBjhSyrq9mHi7LMJI1Kz9jBI9Tr9hieEKnArNKXmBr2Q/6K/yocwGaWv61Efyngv+GpJAd6v0Le7vd4qV2BCz8p97HUR5C9LEGgHorkaOoL9FnILa+hZrUn1QlRI/5nx1ckaNOnsKFjxLoNACZJLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761160860; c=relaxed/simple;
	bh=k+qh3CE/VzNaTrqql/qoqDM5HA3CBNNxquHRgL6QD7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TN8J984lOvtfkoQeQGxJVbhzFGq0q4LG63Zrp5k9sq+im8AnjZivef+w77SX8qhGapbH+YkkBnlo9CK/PxbF7iLU2h7PRRnCcMC38gIzVaG3LZffhlHFcj72iGYwpnRro2+pOc70kfA5pVDX8cFPH59ZQs+Qo9c1pnpkNhTss3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UDDYpwke; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-471075c0a18so76507035e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761160856; x=1761765656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+qh3CE/VzNaTrqql/qoqDM5HA3CBNNxquHRgL6QD7s=;
        b=UDDYpwkeWP3BE17VYvaswRGOwB5/NMzMbiTcn9LLHdc2Gk2sFM1iaVEYaiAH+111WB
         kVPUtB7QY7fkq6dZzgP71kORCghbVJk1nLnOW5H2rUmxjaezY8AkM3nKFkqASXOWzrVe
         SZi3ecyghUh19mAqg7za6Tr8/GB5AGIN+b99INEu7gbi9JRfct9tPrbb98ZPfrNQNzcI
         8obyC2DPcFcLWldPxnmIMiy6WHDxcptrWz5ivjxDNQH6f5hdAljHsiL6tBxC+Bv+Us89
         neKK47ZsIKBccusabR9LYoJL4Vv1uvBddzY9nAJqJicIEDKW/DLGHnMyU1smGydOLJf+
         Hhsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761160856; x=1761765656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k+qh3CE/VzNaTrqql/qoqDM5HA3CBNNxquHRgL6QD7s=;
        b=jKeatf4oOcn7menrtpit5X0pf+JRs5OmVHy07dPJtz7+SSjznPDlfXNPzQRvyCdzoQ
         OvHWC5RLMI1BHcj0kLi4tRwWpo594laA8B4bv4wiYUZwY9maYNqDfGVBqXpjPLjlRc6f
         1l34wupbLj0Lk/8+JnekAHzO1tnY/qUiAXjq6339HL0jPLYb4rnfdNvIYhPPKZ6I4CQ3
         uj1R12Rz9dwwhEzj3yirsiI8NM39yE8LPgTS1c7TbnqExQ3GfV0yKxiK507WSYtJMgfu
         lRUDnudXtPy23967dqGH20aexfGz4SzglOsQ7evQdm9IvP8N3kUDswxWRL2jwZge3OAG
         hXKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjlfHeWvtASCqVzVS2eh1b7a0jGXQ1+8JSJ5lm0v56+fkF2JaB4ZxFfOHtBeJexFK2FghbbVpgkjYSOi0=@vger.kernel.org
X-Gm-Message-State: AOJu0YytlCXmxuc9D1YUYy8sat+twG38BpIyIXwX5FdfllCPHlF1YCWS
	41EV0Sux63+olImMu7BrTfXQzYP+sGf+JtZ9cyqXvS4dz9zsRRJ71R2jLKn9pZP+mGGiTac276r
	q4MiQC27dJ9oxEgLUqYQZeFTR/DDqkao=
X-Gm-Gg: ASbGnctBG1hYbw60t8ZsBxRWC4W4z+1kiCt9PUJODTXlTznUWIwgpF10bum34IAkkuN
	RQjIGz6lry1Lytw2nGGZF2f+mGnXz3jqtW4N4q/h4nZWTbWqOwW8ztY94PFKIllN3G9rOGJ2fMf
	D27+lz+jS3XsKSJ3hFnWzx11eJXFfuijSVToBEEjB+NWYsQupyDgmRlkdyn7SjE47Oyr9J+2nO8
	O/WbHzc2Ty8fPWQbo/UZxUVqc3y4yKIt0+IF8X2rEF0m833M6/C4DsO17NBp2JHeML2Y9t4HPeL
	fcqYjZG2bX0BEvZxkvCFHb9eU8Zn
X-Google-Smtp-Source: AGHT+IF4876amNxsWT6lCxn1MJaV47IHSNaa9AOOQytVEr4VTHmcwE9o3W3K49dS4kNqMKk7vJ3S878Sqao6E3aUkEQ=
X-Received: by 2002:adf:e19b:0:b0:427:53e:ab3e with SMTP id
 ffacd0b85a97d-427053ead3bmr14361051f8f.56.1761160856038; Wed, 22 Oct 2025
 12:20:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022-fix-slab-accounting-v1-1-27870ec363ce@suse.cz> <53f0cc42-e19a-4b84-8631-390cc5b178f5@suse.cz>
In-Reply-To: <53f0cc42-e19a-4b84-8631-390cc5b178f5@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 22 Oct 2025 12:20:44 -0700
X-Gm-Features: AS18NWAFaUq4KxlFKcEHWSegwYcFzQGgXDB1ANKnMEoNkJowl2AheOduUky5rT8
Message-ID: <CAADnVQJXDPFaY6HyB+RTnGAVk9xwv_TZkVxu9MO7EPRktRLndw@mail.gmail.com>
Subject: Re: [PATCH] slab: perform inc_slabs_node() as part of new_slab()
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, Alexei Starovoitov <ast@kernel.org>, linux-mm <linux-mm@kvack.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 11:00=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> w=
rote:
>
> On 10/22/25 19:23, Vlastimil Babka wrote:
> > Since commit af92793e52c3 ("slab: Introduce kmalloc_nolock() and
> > kfree_nolock().") there's a possibility in alloc_single_from_new_slab()
> > that we discard the newly allocated slab if we can't spin and we fail t=
o
> > trylock. As a result we don't perform inc_slabs_node() later in the
> > function. Instead we perform a deferred deactivate_slab() which can
> > either put the unacounted slab on partial list, or discard it
> > immediately while performing dec_slabs_node(). Either way will cause an
> > accounting imbalance.
> >
> > Fix this and also make the code more robust by performing
> > inc_slabs_node() in new_slab() itself, and removing it from its callers=
.
> > As a side effect, in the theoretical case where the new slab is
> > immediately leaked due to debugging consistency check failure, it will
> > be accounted (as full) in /proc/slabinfo anyway, which is not wrong.
> >
> > The exceptional caller is early_kmem_cache_node_alloc() where the node
> > for stats is not yet initialized. We can handle it by using
> > allocate_slab() there as the gfp flags are known and fixed and we don't
> > need need new_slab()'s fixups.
> >
> > Fixes: af92793e52c3 ("slab: Introduce kmalloc_nolock() and kfree_nolock=
().")
> > Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>
> Pushed to slab/for-next-fixes for testing.
>
> Note I haven't seen the imbalance happening. During the ongoing developme=
nt
> work I caused a very deterministic underflow elsewhere, decided to make t=
he
> code more robust by creating this patch, and when going through new_slab(=
)
> callers I realized it fixes an existing issue.

lgtm
Acked-by: Alexei Starovoitov <ast@kernel.org>

