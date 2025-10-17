Return-Path: <linux-kernel+bounces-858662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA8EBEB5E0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 21:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29CD519A3545
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 19:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E482FFDC8;
	Fri, 17 Oct 2025 19:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPsNtg+u"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C045E2EB85D
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 19:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760728295; cv=none; b=OCQUt9BhLfZThMxyeEsW4FhQpNPyLw2CmgWMX8PvHyQvzOQqnHQzh8L7lovDQrHZi9RFl7H5s+W1rcaYvDDFt2uEGygH8/juNjFw8MP5VqeTsHkrZddXLJlUUPemr3DEBs/wK2plCyO6AWG80IE+pEXAO6ZNflyGJ3FdUGnQg5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760728295; c=relaxed/simple;
	bh=rZlVo0hqETHHWosbDDO1yCZXsWvpf7FQP7auewrGHgg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rgcOAxueSkYhyDhbCCAUBVcZxXo1+chp2J2GMXxEQbzjLFjxUlHoROhifTCsHZcAZqh+Hjz7fLHY2mOPSmUnVq+5J5wROrvKIi+lilIkJ6P6cey77Vz7yLHcnF9Upk/6lPBlb0Nmnr3dmRgB7K8NieQ1WLKHqMt7fTo/76TCPFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZPsNtg+u; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b3dbf11fa9eso439995266b.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 12:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760728291; x=1761333091; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hhR7N/1fveVtt6wxaFP4nn/bZMr+K94/sut3rmsfdTg=;
        b=ZPsNtg+uEziD3Lq0OoqRsQwYiROSHbXhXNbmwPYq6A+WQ3BTG2glApmFPScJQg28fK
         x4P4bRtnVsnmQC+jcVEIY4FfONyUoAnSQHWKqOw4s8MMftkySjdRsaoCYNtoX3aNKutZ
         MkqCvr/ShEXbxWd5pE9GcdDxhCs4g+EWOOCuVvxZj0Kp1a17WacGXDFgUfUesqjIyuXm
         UkysWd7Mn669Wq9kwKKKFR/JW+rrzm+T3Za7qPqJAwmd8JSEtzKoI1jil9v5rt96GkAV
         OKOlcemI798oPT9QBkMFFUlMSOhUtyEsz0V6JYLjP3+ReU+vTGP9VmqFKhShdbvJe6L1
         aiFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760728291; x=1761333091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hhR7N/1fveVtt6wxaFP4nn/bZMr+K94/sut3rmsfdTg=;
        b=qSYWhVIAqiSj+B81kmRn9hNRIfU/vDVo4lwSBsXGtIKbn06AjqasQff2uiSGWO4a+0
         6GHZSlbvb2kzIJ7mypv/LTH9jirnrCF9d7ITQbizMOz3TCv+AkLPVOmAuUFJbk/G+9Ac
         ECQCmUVaedgjfW+v1drlNjh3lacxpzMxZtxV2IX/MSYpC3EkD0MwBMkYcNBjZWEC3q/s
         Unaq8b0kMjt3mJBQwg6XvKp+0nyjYTl+p2yegFq+TI0N+K75HkE/uvjKl81cQoIf19lR
         O/Zj+p8wT8Nr9jfpvM5klgUZyGTKq+gv5r/m7pzGXsAa0Waqcns2vm0b/80j2vQPxZLi
         hIiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPrGl6XtOfpE2uqon8MM/VqMZC9PvHBycPZSwC1lGTsxnvrleMGqf3N9LXyjMf2f1DdmxAbtXvT88jrFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSQpzDBk5JIlTOObglMDRVWriuZCvVsVCThaj+VPMSI+Vq9FDR
	mrnmTD0ArRaQc3NZ7fu6EhKPMNiQB25wYH81CyhMjmd7pLhh/CG3sC+rdfF8qfRHZP3Kvsko9g4
	0pbqJwFaOprNJaeXLHrWChLpiSdbiGQ4=
X-Gm-Gg: ASbGncur+01SOSiVHw7523fqNrjxuDcyYAqayod5H05k0Oo8Qx0FrVuwTOQlmdDGif7
	yl5IvpI4Do3s68fQkELdgCBwo9asQ+XYb5FOzEjUnpWdsBPzG6Tmqram46h8jc4pZCxLWZfC9i6
	f5eIT7gNnR5Uo2hADzywXa9SS4BX8EIlwqsJvvxtKGLvusv3YaAMwNMsbBV8jhozMpk//cjTCMj
	arb5wsmJwVmz5LQ6Ule9eX4EsZ2OKc1NS59alpZRmUgCb4SvBVvZRhxtVAZaSTOwkev43GNcHM7
	h//sUg==
X-Google-Smtp-Source: AGHT+IFDOlJ6XYwDeGzUOeuUv7tu/n9jNAnoTgbcA/YtbUqQ9ooDi0ZvO1Y7Lz1HWF/EaVHKgjB6T0ljyIDFi13wLII=
X-Received: by 2002:a17:907:940f:b0:b40:e687:c2c with SMTP id
 a640c23a62f3a-b647394ce7fmr469325666b.37.1760728290384; Fri, 17 Oct 2025
 12:11:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016033452.125479-1-ziy@nvidia.com> <20251016033452.125479-3-ziy@nvidia.com>
In-Reply-To: <20251016033452.125479-3-ziy@nvidia.com>
From: Yang Shi <shy828301@gmail.com>
Date: Fri, 17 Oct 2025 12:11:17 -0700
X-Gm-Features: AS18NWBFTKLOBvlIpa6FLOiYX2FyPcTBMCd4lweftBhZd_zGhKkHrG1wKzTNxSo
Message-ID: <CAHbLzkoOZm0PXxE9qwtF4gKR=cpRXrSrJ9V9Pm2DJexs985q4g@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] mm/memory-failure: improve large block size folio handling.
To: Zi Yan <ziy@nvidia.com>
Cc: linmiaohe@huawei.com, david@redhat.com, jane.chu@oracle.com, 
	kernel@pankajraghav.com, 
	syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com, akpm@linux-foundation.org, mcgrof@kernel.org, 
	nao.horiguchi@gmail.com, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Wei Yang <richard.weiyang@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 8:38=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
>
> Large block size (LBS) folios cannot be split to order-0 folios but
> min_order_for_folio(). Current split fails directly, but that is not
> optimal. Split the folio to min_order_for_folio(), so that, after split,
> only the folio containing the poisoned page becomes unusable instead.
>
> For soft offline, do not split the large folio if it cannot be split to
> order-0. Since the folio is still accessible from userspace and premature
> split might lead to potential performance loss.
>
> Suggested-by: Jane Chu <jane.chu@oracle.com>
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  mm/memory-failure.c | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
>
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index f698df156bf8..443df9581c24 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1656,12 +1656,13 @@ static int identify_page_state(unsigned long pfn,=
 struct page *p,
>   * there is still more to do, hence the page refcount we took earlier
>   * is still needed.
>   */
> -static int try_to_split_thp_page(struct page *page, bool release)
> +static int try_to_split_thp_page(struct page *page, unsigned int new_ord=
er,
> +               bool release)
>  {
>         int ret;
>
>         lock_page(page);
> -       ret =3D split_huge_page(page);
> +       ret =3D split_huge_page_to_list_to_order(page, NULL, new_order);
>         unlock_page(page);
>
>         if (ret && release)
> @@ -2280,6 +2281,7 @@ int memory_failure(unsigned long pfn, int flags)
>         folio_unlock(folio);
>
>         if (folio_test_large(folio)) {
> +               int new_order =3D min_order_for_split(folio);
>                 /*
>                  * The flag must be set after the refcount is bumped
>                  * otherwise it may race with THP split.
> @@ -2294,7 +2296,14 @@ int memory_failure(unsigned long pfn, int flags)
>                  * page is a valid handlable page.
>                  */
>                 folio_set_has_hwpoisoned(folio);
> -               if (try_to_split_thp_page(p, false) < 0) {
> +               /*
> +                * If the folio cannot be split to order-0, kill the proc=
ess,
> +                * but split the folio anyway to minimize the amount of u=
nusable
> +                * pages.
> +                */
> +               if (try_to_split_thp_page(p, new_order, false) || new_ord=
er) {

folio split will clear PG_has_hwpoisoned flag. It is ok for splitting
to order-0 folios because the PG_hwpoisoned flag is set on the
poisoned page. But if you split the folio to some smaller order large
folios, it seems you need to keep PG_has_hwpoisoned flag on the
poisoned folio.

Yang


> +                       /* get folio again in case the original one is sp=
lit */
> +                       folio =3D page_folio(p);
>                         res =3D -EHWPOISON;
>                         kill_procs_now(p, pfn, flags, folio);
>                         put_page(p);
> @@ -2621,7 +2630,15 @@ static int soft_offline_in_use_page(struct page *p=
age)
>         };
>
>         if (!huge && folio_test_large(folio)) {
> -               if (try_to_split_thp_page(page, true)) {
> +               int new_order =3D min_order_for_split(folio);
> +
> +               /*
> +                * If the folio cannot be split to order-0, do not split =
it at
> +                * all to retain the still accessible large folio.
> +                * NOTE: if getting free memory is perferred, split it li=
ke it
> +                * is done in memory_failure().
> +                */
> +               if (new_order || try_to_split_thp_page(page, new_order, t=
rue)) {
>                         pr_info("%#lx: thp split failed\n", pfn);
>                         return -EBUSY;
>                 }
> --
> 2.51.0
>
>

