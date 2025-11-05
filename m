Return-Path: <linux-kernel+bounces-886371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AD6C355E2
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 12:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 461C1347925
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 11:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D906A2D7DE8;
	Wed,  5 Nov 2025 11:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPaot0Kp"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1642DC334
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 11:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762342321; cv=none; b=L/i/DKf/uGVyjknLHx7oMfUKMh8MOcO9o0FfFILmrEICpsiIti5L84bPg5YXN+anX3LU0VGd74oMKyGaQ+uNRXC9KRNBzV9yRlAOlwYSz3nFIc6JljImJ+mQUJDtDpmSF83nGMV/2mYPvc5Oak8BcPfurLzS0KbpPMlt6hgqNKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762342321; c=relaxed/simple;
	bh=eBD1IiAAvxb4uJZP0t0b7YhcrJKLL2oHN59HrlJW2bI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BsGi3VAUKUvlMc9Bv52S26tevjRiyKx0dK3C0J8eAnbiXI8RKgXRgoI6XrPhRN8pXqiRiFbIIerGf6tTN5rk9ZUauyJ7/3hQLrQNTdXC2etY3AdoAd8wcUcb5BlDE3zR9hHHV0kgXTdWqpoPs/NI8qfAU9cso1aPybfRxmyk/Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bPaot0Kp; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b726997b121so84695766b.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 03:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762342318; x=1762947118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JbOOFWIto5LwOi6FTFeE9TGPze2sDwwy8SsoL+/k4rU=;
        b=bPaot0KpA6WCPVsUUqPb+TaGlrq+1UoB+/KilUXBCvEw6UMRrq4rUWPnyH0z9ZSoTc
         pFIktycEBtOKYZ0Huev9RxGfiQYiVRXuEdbgXSZitnbkLIFKd+AaO/6MfDTVlm6qrxGI
         y1Gst4DgPRh+lL2bm72ZYEZWPEKyt/CMjxIxskgMMkJ2xW8/kA8/iPZyfxdAwOk8t2ZD
         DblQDCk7qOBeSTjXIaTSVIr7tDUebMR5D8+FtqwcSHBuJfYICZKk1wTcdWWf1OxbsvsF
         z5R9CUVYYmVDAtu+GG0yU57h5LbxZuF5C9kH9kRNb/8eHFTxYT7udrImpJdDRf3eoIIS
         96MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762342318; x=1762947118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JbOOFWIto5LwOi6FTFeE9TGPze2sDwwy8SsoL+/k4rU=;
        b=hd0lxQ0w7sOGlX3IW5QWQhVvl7m4s6y/Yi+icWth86WiggQ9D9SMCW/6YHs0NDce7y
         t7D6M6OU5FbcPr6ER+Bi5/K+/JrK9/nxzABpYp/bw+rRD/UvqmJHppgcbf3pNAzM+pco
         NglZu8YuViYVf0WEMiht3OpbeiB2kglAF1HM51GUFebYwUXVP9ib3zKk7XeAI/DCj4BS
         +CENItDj0cuyLA6GoMrmTnqEHNQXhgldG3CUYb3qQSQ7YkJ3awzO7nlRUKUFJwTD8SsK
         4lnOZ+RxuknrbubodXIpaYR+HJZhuK0WVAAhO2N+jQwrdYeDJDAJI1U5kzhhjg1+YcMN
         HIJA==
X-Forwarded-Encrypted: i=1; AJvYcCUa59P3li5OrNwxqG0VKkQRgs1kfmF0t+xKM69SFS0mffph9ZVR2fu9ju4xcWXmn8x+I5FO1T7JJt8on5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBg2R/rGX+9s+H6Pofv+xCR2c/WNsSBSBC+xHa+yru71mpb4Nx
	u4Dfh9pxTz7OvR2sFF0sfebWHwKlfEVnhur9Js4ZIwLY80FYc0LGZo9AjtyXiJgv6Cql/rWcq6k
	8WeFJkGkj2s6VHF5V7HfK4kbCnyqGrug=
X-Gm-Gg: ASbGncvd/5mtwl99zf6TXuUYL7r86oFVMA3aCaul+C2FVZ58A5bUywDEX+WxcdL9hJ/
	rqx6B9eOHl8ki5ayidWVMRqGcg8hBlMgoFuKI062gPzswR0BdGlpzXYZVi4t5m3uURsXbiDEKGe
	nwAoteHKbh6CEmWYL56JV4CaXYf1l8jpZAdadHGKj6MKmyrc8KfUHwlEYcBNROu9xgY2mpSwdh5
	jBHYJGr0pTk8KrYag/WsPsAEx6VlnKxUIejVbOnz22Wv6cJxy4P1Y2JcyHip9jRw7wGumOi
X-Google-Smtp-Source: AGHT+IG0HVZfxPkDrgRBzX/n9U+fCYU/2NmebcopFt0qzjddaa3YzlMk+xglrbWVYBpiQJdIybINd2bI2nOsdiS8yBg=
X-Received: by 2002:a17:907:9445:b0:b07:e258:4629 with SMTP id
 a640c23a62f3a-b7216f64be1mr825151766b.16.1762342317513; Wed, 05 Nov 2025
 03:31:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104134033.344807-1-dolinux.peng@gmail.com>
 <20251104134033.344807-3-dolinux.peng@gmail.com> <f16e34ac93438c9ccb9b174d45060c3b06b45e9d.camel@gmail.com>
In-Reply-To: <f16e34ac93438c9ccb9b174d45060c3b06b45e9d.camel@gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Wed, 5 Nov 2025 19:31:45 +0800
X-Gm-Features: AWmQ_bm7gm7cH1M0ZJVpTqcVirZEDME7a_DlsdnpsyeKAFrsL7ZC_t5R3uWwVXI
Message-ID: <CAErzpmv+wmfh_hjSiR5WhSyXVmX-iFAw3cYo5qeMphsWayyZWw@mail.gmail.com>
Subject: Re: [RFC PATCH v4 2/7] libbpf: Add BTF permutation support for type reordering
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: ast@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, 
	Song Liu <song@kernel.org>, pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 7:45=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Tue, 2025-11-04 at 21:40 +0800, Donglin Peng wrote:
> > From: pengdonglin <pengdonglin@xiaomi.com>
> >
> > Introduce btf__permute() API to allow in-place rearrangement of BTF typ=
es.
> > This function reorganizes BTF type order according to a provided array =
of
> > type IDs, updating all type references to maintain consistency.
> >
> > The permutation process involves:
> > 1. Shuffling types into new order based on the provided ID mapping
> > 2. Remapping all type ID references to point to new locations
> > 3. Handling BTF extension data if provided via options
> >
> > This is particularly useful for optimizing type locality after BTF
> > deduplication or for meeting specific layout requirements in specialize=
d
> > use cases.
> >
> > Cc: Eduard Zingerman <eddyz87@gmail.com>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > Cc: Alan Maguire <alan.maguire@oracle.com>
> > Cc: Song Liu <song@kernel.org>
> > Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> > Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> [...]
>
> > --- a/tools/lib/bpf/btf.h
> > +++ b/tools/lib/bpf/btf.h
> > @@ -273,6 +273,40 @@ LIBBPF_API int btf__dedup(struct btf *btf, const s=
truct btf_dedup_opts *opts);
> >   */
> >  LIBBPF_API int btf__relocate(struct btf *btf, const struct btf *base_b=
tf);
> >
> > +struct btf_permute_opts {
> > +     size_t sz;
> > +     /* optional .BTF.ext info along the main BTF info */
> > +     struct btf_ext *btf_ext;
> > +     size_t :0;
> > +};
> > +#define btf_permute_opts__last_field btf_ext
> > +
> > +/**
> > + * @brief **btf__permute()** rearranges BTF types in-place according t=
o specified mapping
> > + * @param btf BTF object to permute
> > + * @param ids Array defining new type order. Must contain exactly btf-=
>nr_types elements,
> > + *        each being a valid type ID in range [btf->start_id, btf->sta=
rt_id + btf->nr_types - 1]
> > + * @param opts Optional parameters, including BTF extension data for r=
eference updates
> > + * @return 0 on success, negative error code on failure
> > + *
> > + * **btf__permute()** performs an in-place permutation of BTF types, r=
earranging them
> > + * according to the order specified in @p ids array. After reordering,=
 all type references
> > + * within the BTF data and optional BTF extension are updated to maint=
ain consistency.
> > + *
> > + * The permutation process consists of two phases:
> > + * 1. Type shuffling: Physical reordering of type data in memory
> > + * 2. Reference remapping: Updating all type ID references to new loca=
tions
>
> Nit: Please drop this paragraph: it is an implementation detail, not
>      user-facing behavior, and it is obvious from the function code.

Thanks, I will fix it in the next version.

>
> > + *
> > + * This is particularly useful for optimizing type locality after BTF =
deduplication
> > + * or for meeting specific layout requirements in specialized use case=
s.
>
> Nit: Please drop this paragraph as well.

Thanks, I will fix it in the next version.

>
> > + *
> > + * On error, negative error code is returned and errno is set appropri=
ately.
> > + * Common error codes include:
> > + *   - -EINVAL: Invalid parameters or invalid ID mapping (e.g., duplic=
ate IDs, out-of-range IDs)
> > + *   - -ENOMEM: Memory allocation failure during permutation process
> > + */
> > +LIBBPF_API int btf__permute(struct btf *btf, __u32 *ids, const struct =
btf_permute_opts *opts);
> > +
> >  struct btf_dump;
> >
> >  struct btf_dump_opts {
>
> [...]

