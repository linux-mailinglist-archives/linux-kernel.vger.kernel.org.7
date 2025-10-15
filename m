Return-Path: <linux-kernel+bounces-854876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 87564BDFA7F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 18:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0B7D64E5BA8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C999C3376B9;
	Wed, 15 Oct 2025 16:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZSqGT/dY"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EA9337694
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 16:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760545771; cv=none; b=kshWWNC+rnkaOt38py+V1SvfyyaFdasLjLTWSabUKwFJLqcvJydeySsqUNyg6DGfbGQAJrq0ouUMOlh9ViqrSWFw9HmzL+fLZu6jTuMJqVfSvfPkingvwt9zKVbqzwsrNv95uYaU4llFHDPPJFPM1oaxoJGRVxqX/Q3XGc6OL2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760545771; c=relaxed/simple;
	bh=mAOp6YBWXF2xqdYUgKEIqdcG3pRmH5CtDKMy9bQANYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HkqGdhbFoDKWcU8F300+goH/7vhvElKwoIy1Gq1VKh5Lo7bTF7YBsAT6LSJgoO5NonzR2WI5ffI8D/Om0xqWuuKOyn18bJlxBr9VRvN9VuduzXy/vijO9gGgG+qb4tsnsdnoAd4oMNgEy3r/y9HEYYPO/3N8NrEwvXLemXsegd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZSqGT/dY; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-42d7d0c58f9so398255ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 09:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760545768; x=1761150568; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EPABWHgz0aje1cFhOw6wZjzCfYUS7SupNu8eCmm6K50=;
        b=ZSqGT/dYXgjtlSDnpW01Pqyr9CQKgE0jPKhinG2LKZqsUdde16WvY2P0lENZUMJupI
         S47yptvsbFTLsiYHDKuxWwOvooISst3T4Kfn+kfqwLA+tMlavFkX1PxAGJYSX238wMV2
         AAYdBu867srsI9ZvA22UtrK7Ou7Z5D8fnurWrH6hdlfzPMPFhSvXyjl9laQbz4Loup/E
         EcSgQcOVD1gwA7eXo6m5NA9UcdtE3K/f8JGg4A1jkIpjXLNXqqQG/8jJh330uDCSF1Nu
         xd9atXMFNkinCxAXDRi03HE9f4Z1D6Y8DDv9DaQhBGVC1cC7hlGNPOoZawumuc+ZlqUg
         hW8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760545768; x=1761150568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EPABWHgz0aje1cFhOw6wZjzCfYUS7SupNu8eCmm6K50=;
        b=MdYKzaLsYiPDJImS1ZoSKvo1kH/hdG7FaVz4cis04oBoxRQgl8bp66m+GhmMJL4ErJ
         HXz5riBtFMUcHq/o/INLyYM1MLOIUFZue7HphY5ORo67t+dirUJOp2ThyxvB64gFFq1L
         JZXstcrogIPYUg71bx43lj553mn2yfMrMgSW0r50nW9nCVkv1062JJuMw6rvt2lXBNnS
         8VYEKLpLN9e+qFpc0hv8mOK6EKwLRqB/MQ/mnt5A3uCl8oamgGsUWVe/XKzS6sNEfPl3
         OTEeaIKSlh2ShJtn6Af0x+nGFhQQaurvNhNCxttKrxfIWaZ6ehDZhDAfLopiU/RUnxsA
         97Pw==
X-Forwarded-Encrypted: i=1; AJvYcCVA7dxMH/HUmrdKxFpW7ZZ3f+v2x6e+pMlL0KbnIKVDDIn2LytnOAPrOhTEX4hzwEkAHUMpPsHyJxxOGnM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx21gP/XcYg2ZdCd1jijQ+5xleIrWEJgpeTPKPj86gQdXCNRNjd
	2dg3L8eJAV3Jlwr7M4IJQTG3nZHKPho656WEmMs0JUpZK8txzV/e5W41L0IbNvBuoxTBOKmklPf
	uA9RKlvROjsyiUJrAmyLK1YxJ2gngxSa3dXhlZvrt
X-Gm-Gg: ASbGncvIrjupNhRgsBSYpt/aQEtKjWjrsfyGSmWKHWj1WJw51x9zu+YDbpZpir0KkwM
	IGCZHGzT+v6KFeBA0GSC2VGzkoEHrRX1VjRPbIhTLRB5DoYKeRt7qEwATasETgV15e67XBVZ6jr
	sZjChnTJy12XOxivkm3eeXlG8KpsHhDNrN1xa6XYbIvpWl0rMn8oJfQsNAX0t1KgSQo43UT4at+
	DTW6FVBOl3YcWGWeP8tU/NWaZZpliRhxk5l3S29Dkvq2MQEp/nz/GNpNqpsXd85icd0yeQBAw==
X-Google-Smtp-Source: AGHT+IGKGHbbfLh5CSf6ynM1o7L33zcz+2l5Q3BiEGunq0zKCeC+9lQM0pT75u+/Tc0YS0EeuHM7RhK/llM28VOk93o=
X-Received: by 2002:a05:622a:1f15:b0:4e4:6a1b:1148 with SMTP id
 d75a77b69052e-4e882ec9fd1mr7214141cf.6.1760545767796; Wed, 15 Oct 2025
 09:29:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015141642.700170-1-hao.ge@linux.dev>
In-Reply-To: <20251015141642.700170-1-hao.ge@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 15 Oct 2025 09:29:16 -0700
X-Gm-Features: AS18NWCtUmLEWW8-7DUbvX8A5tHpZs2tgG7P4DUVEuwVfYnJMCjKydySlEmkCcM
Message-ID: <CAJuCfpEpO_HaJuV3ukDtTdw_5zCq9R0MnMexC5PoEwOcKWjuYg@mail.gmail.com>
Subject: Re: [PATCH v5] slab: reset obj_ext when it is not actually valid
 during freeing
To: Hao Ge <hao.ge@linux.dev>
Cc: Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	Alexei Starovoitov <ast@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Hao Ge <gehao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 7:17=E2=80=AFAM Hao Ge <hao.ge@linux.dev> wrote:
>
> From: Hao Ge <gehao@kylinos.cn>
>
> If obj_exts allocation failed, slab->obj_exts is set to OBJEXTS_ALLOC_FAI=
L,
> But we did not clear it when freeing the slab. Since OBJEXTS_ALLOC_FAIL a=
nd
> MEMCG_DATA_OBJEXTS currently share the same bit position, during the
> release of the associated folio, a VM_BUG_ON_FOLIO() check in
> folio_memcg_kmem() is triggered because it was mistakenly assumed that
> a valid folio->memcg_data was not cleared before freeing the folio.
>
> When freeing a slab, we clear slab->obj_exts and reset it to 0
> if the obj_ext array has been successfully allocated.
> So let's reset slab->obj_exts to 0 when freeing a slab if
> the obj_ext array allocated fail to allow them to be returned
> to the buddy system more smoothly.
>
> Signed-off-by: Hao Ge <gehao@kylinos.cn>
> ---
> v5: Adopt the simpler solution proposed by Vlastimil;
>     Many thanks to him
> ---
>  mm/slub.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index b1f15598fbfd..2e4340c75be2 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2170,8 +2170,16 @@ static inline void free_slab_obj_exts(struct slab =
*slab)
>         struct slabobj_ext *obj_exts;
>
>         obj_exts =3D slab_obj_exts(slab);
> -       if (!obj_exts)
> +       if (!obj_exts) {
> +               /*
> +                * If obj_exts allocation failed, slab->obj_exts is set t=
o OBJEXTS_ALLOC_FAIL,
> +                * In this case, we will end up here.
> +                * Therefore, we should clear the OBJEXTS_ALLOC_FAIL flag=
 first when freeing a slab.
> +                * Then let's set it to 0 as below.
> +                */
> +               slab->obj_exts =3D 0;
>                 return;
> +       }

How about this instead:

static inline void free_slab_obj_exts(struct slab *slab)
{
        struct slabobj_ext *obj_exts;

        obj_exts =3D slab_obj_exts(slab);
+        /*
+         * Reset obj_exts to ensure all bits including OBJEXTS_ALLOC_FAIL
+         * are always cleared.
+         */
+        slab->obj_exts =3D 0;
        if (!obj_exts)
                return;

        /*
         * obj_exts was created with __GFP_NO_OBJ_EXT flag, therefore its
         * corresponding extension will be NULL. alloc_tag_sub() will throw=
 a
         * warning if slab has extensions but the extension of an object is
         * NULL, therefore replace NULL with CODETAG_EMPTY to indicate that
         * the extension for obj_exts is expected to be NULL.
         */
        mark_objexts_empty(obj_exts);
        kfree(obj_exts);
-        slab->obj_exts =3D 0;
}

>
>         /*
>          * obj_exts was created with __GFP_NO_OBJ_EXT flag, therefore its
> --
> 2.25.1
>

