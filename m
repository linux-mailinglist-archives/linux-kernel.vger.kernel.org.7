Return-Path: <linux-kernel+bounces-893141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B9AC469EB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F2D494EA3AE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCFE30E831;
	Mon, 10 Nov 2025 12:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/2BybgX"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320382F690D
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 12:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762778052; cv=none; b=G5YPttDpGP3XMQs1fOJNbRXzLKs8C5gbzwtYS9kMYDrR/tHa0IqoeZys7wepZp+IxfdxT2VVLVt68gFvLbL26P/vHpvyhhIoUcOWfCU+wwryJoH/TNj3PeVBqRL44KPhycIn20tVD7pJKel/HWZxQam1hc7OTJ2QZVHDJYEXN/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762778052; c=relaxed/simple;
	bh=AMVbyD8nNSVZt+FCVLLq05ihtlDP/Tor4+bfXvY17so=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dFfxGRVkjyul97zp8kwjBscbw77F94+YBk5OEFj8RakfKM7UU/yQIqNYbv8TmVwTEkgn+jc6zcJSzsUrzHwKHjfjCJ4m5VRFtSWHTTSmm3rlK6vWS3wLGwIdgTyK1uPuwhVkgn2IwLfRNyteSIO0BQdGXtyo9klLrCl8P9iRYS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/2BybgX; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3418ac74bffso2066354a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 04:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762778050; x=1763382850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sy5DjoSQimDCENwTSGtt2eMZiZGbRj1r/HV/Tgc/t8U=;
        b=W/2BybgXGkPDMgwtj8AxEXt4CtgYTa0cl0094yUHseYRcLYre2lo15f6RE0CmowP/2
         /Am/hWB995bk6EHtZmAxTfylES6zm36xHOMvl9d8y2L170bQVjXmCcmYjTK9n48Z4NqC
         6r2DAblGCFM4MPzn/wpsvN3iwZHsp+UDQ5wrJpzaEIgSWg/4L39elLbwcJMdjYP1Mkr2
         Z2P5PiUptJPLgwXDGE9xMQ0c6/Yaa0TfLjoFlnXXNBmmTkLK8BwrJqBndXh6x8YbqOVG
         GJ1j7RaEtTxrwwZuTKWxbZYMWK3yZL7BpcFlWZqDtj+FdRYtwtG0hE0vQ/KnXdomrALh
         5zHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762778050; x=1763382850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sy5DjoSQimDCENwTSGtt2eMZiZGbRj1r/HV/Tgc/t8U=;
        b=Mm//YwrQOVQ6cC0+mYSTGR1M5WyVShTr0ci21y/SAWj6b6YfcRFRLDcf1nJWvpRldf
         Cf0f6BL/GNjmaivuAuqxbnHpQDAoeBAB2Eogl/pkMzACJLl49Rd1ChBQS2LmWriFrVx9
         24YfGlu7KbnFAnSKNqjBbZcJABj69TrbOpqPbA+PfHBaBCtTnEaxr7jYBRVUQiox/2PQ
         e69SyAs1uy8hWzLUWyX8PDqpzb2E1HQWtAerugxxXUcPUGp4srQ2qjKnDSLVBpWHbSNE
         /6pqsNjFOO4L3tWVos4c4Lk63a+DBpcuvpvpHLZTKY4Fsdo3ZE8tW6lHGju3oP+9La89
         walA==
X-Forwarded-Encrypted: i=1; AJvYcCXPN3VHUAmh1W24GmQXf4+7zYrVmOdXiAmrr6P8bRgA0Uxr+wYzOkVdmt/DTJAT9+/fwDG9aO1YiknaIgM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH8Dhldlkwi73CSmtZgcSUB3sFyB7L4t6EooqYW9hrFR/jud5p
	dbiecrZ52ZFksR+MlQsf5O8PiLZVn7LalVM8eZZqkVDCTzVWCInNpLUtF5S4jGwEqMKaQivjcIQ
	QJeIWQWNqYw+PqjYzqiorAF5aw67GdCA=
X-Gm-Gg: ASbGncvQ7ifl9qzeYxGl1bzNtTruMx58/bW45kM6Z6U/ijmhYXWjXydr+0j76iBiC/Q
	waCfgyiJhrUltO8+QzZQVEQndtGmMvCMyEMV8CBQRDHdWzA3Hnxh+FQmft3DrAIn9FfpNuxUNHH
	ULHy3rraDKn7lK5ADW1vHYModObHXPHsTXKgnZQsmx085e0ZXy+e+czFl+lAlDbyeC1CwP0I847
	5faz8ApsxtBsB69A1G+eWfZnJMKsSc8b7aw59hiYyFJaSz2XP2GsI6tNl7UHaGIV2vHGY+XUc7y
	o93ARIOwNmUiw6s8Fwb0PQ6vaAQ=
X-Google-Smtp-Source: AGHT+IGyg9aZV4dgyvFuRtdSsElpeyZ+CpTXqovvGuPUeZo+pqdjOClLE9fxRv8gppzbemj2+mN2w/AMZs0pWBdc88E=
X-Received: by 2002:a17:90b:3b43:b0:340:dd2c:a3da with SMTP id
 98e67ed59e1d1-3436cb7aa3emr8354432a91.8.1762778050319; Mon, 10 Nov 2025
 04:34:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110-revert-78524b05f1a3-v1-1-88313f2b9b20@tencent.com>
 <875xbiodl2.fsf@DESKTOP-5N7EMDA> <CAMgjq7CTdtjMUUk2YvanL_PMZxS_7+pQhHDP-DjkhDaUhDRjDw@mail.gmail.com>
 <877bvymaau.fsf@DESKTOP-5N7EMDA> <CAMgjq7BsnGFDCVGRQoa+evBdOposnAKM3yKpf5gGykefUvq-mg@mail.gmail.com>
In-Reply-To: <CAMgjq7BsnGFDCVGRQoa+evBdOposnAKM3yKpf5gGykefUvq-mg@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Mon, 10 Nov 2025 20:33:31 +0800
X-Gm-Features: AWmQ_bnm3NOQhTmQKSG361K0h_1KBf9RdCY2Qg8AObjYfkOGH4tdJ9Y2X52coCY
Message-ID: <CAMgjq7C5H0rV4tkosUEtwvHTd5bO+jxyQkW4xjP+8-qnjh=oiA@mail.gmail.com>
Subject: Re: [PATCH] Revert "mm, swap: avoid redundant swap device pinning"
To: "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Chris Li <chrisl@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Youngjun Park <youngjun.park@lge.com>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 7:37=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrot=
e:
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 3f85a1c4cfd9..4cca4865627f 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -747,6 +747,7 @@ static struct folio
> *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
>
>         blk_start_plug(&plug);
>         for (addr =3D start; addr < end; ilx++, addr +=3D PAGE_SIZE) {
> +               struct swap_info_struct *si =3D NULL;
>                 leaf_entry_t entry;
>
>                 if (!pte++) {
> @@ -761,8 +762,12 @@ static struct folio
> *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
>                         continue;
>                 pte_unmap(pte);
>                 pte =3D NULL;
> +               if (swp_type(entry) !=3D swp_type(targ_entry))
> +                       si =3D get_swap_device(entry);

Oops I missed a NULL check here.


>                 folio =3D __read_swap_cache_async(entry, gfp_mask, mpol, =
ilx,
>                                                 &page_allocated, false);
> +               if (si)
> +                       put_swap_device(si);
>                 if (!folio)
>                         continue;
>                 if (page_allocated) {
>
> I'll post a patch if it looks ok.

