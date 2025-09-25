Return-Path: <linux-kernel+bounces-832854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D23BA093A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 18:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 533351C21326
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 16:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984E13054D8;
	Thu, 25 Sep 2025 16:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OW3lhJWX"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEA13054CE
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 16:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758817400; cv=none; b=Jk5YxxnHTFedKgGVpbGU55jypPyJmnafc4ZVh80UPvrw/OGzeGEDmlaHHPNU2zstO0MuYm8RLt6o60VjMExEakJHEynUDSWdfWsTriz/9fozYyHAB2LbAW6pLKWfwHouNdER0q8Dr8Xk3TouHsoQU9W42kBKlTBgDtFhf94kIzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758817400; c=relaxed/simple;
	bh=ogDMvxEB0l/8LolmHlflKoM4VzHXpO3FbRQWfgyFd/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tjBBO7gDDjZMWtDspVtcuRIVnL+cEjh8QWcFQ8y9mnAJ8mj6QLnV0BTb4qnMJJBNUdJYNmIkxbWMw1CpCCrJzOBVWVzyiKihR8EBJ7ilVlahkN+OvXzcT6YwQ9IlO6QL0jXr7z7SIdrtEK3PVtSk37mA/45b9ZIr9O/ksmdo6E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OW3lhJWX; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-62fc89cd68bso2444314a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758817397; x=1759422197; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sVLfD6QI3aBalttz5ofGckCWcaUeaFqR+l9M9pjcrz8=;
        b=OW3lhJWXo6voXJt8MRV8n9F7KFslPnd9Pq71YVAjr+GJ8kk2K3WJgzbYP3aKy1KTMO
         mIqWLDO0NDturIQuMZVTi4PhPs1CYoSXtllXIzov1ku8g+FFYPQTYNFK5s5cGs2bFMwo
         Cd2T7qO9XvluLeg/Tf7SFb/1tN3DN+88Ba1xgD6eq4IlQUpyubQKYf/S0YrBE5BTozNp
         D/eqNP6FOH4aocib2Blw2yaAdg5NVDzzVywdcEOWvRO5JE65Epe0P+7Ojb0NTHVw2EEy
         RRuxEwQB0CljvzZCZdZFdVYwu+UJYVG8TwyzCNyRXcUOT2sm2mj0jf38eBBgfWGK8xyY
         qRkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758817397; x=1759422197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sVLfD6QI3aBalttz5ofGckCWcaUeaFqR+l9M9pjcrz8=;
        b=hjvEcvk7BX37WK0Upco9fbpffDOt0tKWzbv17V8XMSyvoDflW0rjN6c+5hl3lA3f9R
         kU15Yg2g19hbsFvUVbhLt3ew8+j2MqcHy4J66gXdg5vlMSeJlcDb53NJSW7Xeq/SCK1U
         MhsuOjjQf3cRnbxgMJh0KjVTjs5ZDKM0a8vutoylaTcGh+OoncOMNzMYUMzej34Zy2wC
         Jke8/2w9hFFNJPbRttRUPLoJFJpKQ5I5kkdscZHZjVJXADO2QC97Erawe1Vd/du0V6Gf
         0aeMos9e+WomZyNyjRq1JxVTFH/dUlDQWeDPVvx6LqJAzjrD0klDy0G9KZGzweth9qDf
         chTg==
X-Forwarded-Encrypted: i=1; AJvYcCUPStE/J9kJLDWFMvHw0T8Hek3323yf+H2ySQB7K/eWaYmLVHOXEYBkktpOkbjV/6iGtrrQ2sDbok474ww=@vger.kernel.org
X-Gm-Message-State: AOJu0YzotQVTBs4FmDEWanyIZesKy8sKIWTj9tiy0ttagjHS3Ddu2/8U
	/lGmLJgy4Gf9IVEk23DwmYxdr2zC+5UWzflVIb2KzuNyZRYW2JuJbdknZbNCQlKKXbatiuxdRjz
	ZTgaOok6T97RIamjBY8Xzn50T3KCeStE=
X-Gm-Gg: ASbGnctKojzsoMDTIDaPyvSOpPVeMn4sPAnrJT6vg/xjbWEx3l+llz7HeY/06fV/cp6
	j9UYT7mfM/Ul1NA6+zxUV2BMxaK2mpu41uByY6UXWduHCopagRyFcKq2ZeH7MglwUt3Pjc9GsVa
	aOBgAWBPUjDgoXE0QclGth5xHKgB8U69vqixPCI9qdn8LRnk6yPYvRH9rj1aTZWYPNr9Mswp+Do
	7XQIq+ZVwK1cA==
X-Google-Smtp-Source: AGHT+IHrLfqKU+fL92X7D5u431cMJZPJyrtVkhiVpqdBaM41xpe5f3nevQqNwe3zgdGq42HMPJgytQhdodbZUNRWfwg=
X-Received: by 2002:a17:907:961f:b0:b04:c7c5:499d with SMTP id
 a640c23a62f3a-b34be7cef09mr433129366b.47.1758817396702; Thu, 25 Sep 2025
 09:23:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <68d2c943.a70a0220.1b52b.02b3.GAE@google.com> <ce93b55c-75a7-4b4d-a68b-9d80baf1578b@redhat.com>
 <DB0E39CD-36A9-4929-BCC6-33F27E387AEA@nvidia.com> <70522abd-c03a-43a9-a882-76f59f33404d@redhat.com>
 <B0781266-D168-4DCB-BFCE-3EA01F43F184@nvidia.com> <cad74ef8-3543-4fc5-a175-8fc23a88776a@redhat.com>
 <E82638DD-9E5D-4C69-AA0F-7DDC0E3D109B@nvidia.com> <fzfcprayhtwbyuauld5geudyzzrslcb3luaneejq4hyq2aqm3l@iwpn2n33gi3m>
 <80D4F8CE-FCFF-44F9-8846-6098FAC76082@nvidia.com>
In-Reply-To: <80D4F8CE-FCFF-44F9-8846-6098FAC76082@nvidia.com>
From: Yang Shi <shy828301@gmail.com>
Date: Thu, 25 Sep 2025 09:23:05 -0700
X-Gm-Features: AS18NWDY4BleLREPHkOm-WtFq5BXfe1lid1VqVLM4gXE_Ot-5sNbySege7rDVV0
Message-ID: <CAHbLzkrstjnEVUzz2==A2Z+CJToOgU6YU2MasdK49o-0-jW2yw@mail.gmail.com>
Subject: Re: [syzbot] [mm?] WARNING in memory_failure
To: Zi Yan <ziy@nvidia.com>
Cc: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, David Hildenbrand <david@redhat.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, 
	syzbot <syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, linmiaohe@huawei.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, nao.horiguchi@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 7:45=E2=80=AFAM Zi Yan <ziy@nvidia.com> wrote:
>
> On 25 Sep 2025, at 8:02, Pankaj Raghav (Samsung) wrote:
>
> >>>>
> >>>> We might just need (a), since there is no caller of (b) in kernel, e=
xcept
> >>>> split_folio_to_order() is used for testing. There might be future us=
es
> >>>> when kernel wants to convert from THP to mTHP, but it seems that we =
are
> >>>> not there yet.
> >>>>
> >>>
> >>> Even better, then maybe selected interfaces could just fail if the mi=
n-order contradicts with the request to split to a non-larger (order-0) fol=
io.
> >>
> >> Yep. Let=E2=80=99s hear what Luis and Pankaj will say about this.
> >>
> >>>
> >>>>
> >>>>
> >>>> +Luis and Pankaj for their opinions on how LBS is going to use split=
 folio
> >>>> to any order.
> >>>>
> >>>> Hi Luis and Pankaj,
> >>>>
> >>>> It seems that bumping split folio order from 0 to mapping_min_folio_=
order()
> >>>> instead of simply failing the split folio call gives surprises to so=
me
> >>>> callers and causes issues like the one reported by this email. I can=
not think
> >>>> of any situation where failing a folio split does not work. If LBS c=
ode
> >>>> wants to split, it should supply mapping_min_folio_order(), right? D=
oes
> >>>> such caller exist?
> >>>>
> >
> > I am not aware of any place in the LBS path where we supply the
> > min_order. truncate_inode_partial_folio() calls try_folio_split(), whic=
h
> > takes care of splitting in min_order chunks. So we embedded the
> > min_order in the MM functions that performs the split instead of the
> > caller passing the min_order. Probably, that is why this problem is
> > being exposed now where people are surprised by seeing a large folio
> > even though they asked to split folios to order-0.
> >
> > As you concluded, we will not be breaking anything wrt LBS as we
> > just refuse to split if it doesn't match the min_order. The only issue =
I
> > see is we might be exacerbating ENOMEM errors as we are not splitting a=
s
> > many folios with this change. But the solution for that is simple, add
> > more RAM to the system ;)
> >
> > Just for clarity, are we talking about changing the behaviour just the
> > try_to_split_thp_page() function or all the split functions in huge_mm.=
h?
>
> I want to change all the split functions in huge_mm.h and provide
> mapping_min_folio_order() to try_folio_split() in truncate_inode_partial_=
folio().
>
> Something like below:
>
> 1. no split function will change the given order;
> 2. __folio_split() will no longer give VM_WARN_ONCE when provided new_ord=
er
> is smaller than mapping_min_folio_order().
>
> In this way, for an LBS folio that cannot be split to order 0, split
> functions will return -EINVAL to tell caller that the folio cannot
> be split. The caller is supposed to handle the split failure.

Other than making folio split more reliable, it seems like to me this
bug report shows memory failure doesn't handle LBS folio properly. For
example, if the block size <=3D order-0 page size (this should be always
true before LBS), memory failure should expect the large folio is
split to order-0, then the poisoned order-0 page should be discarded
if it is not dirty. The later access to the block will trigger a major
fault.
But with LBS, the block size may be greater than order-0 page size, so
the large folio is actually backed by one single block, so memory
failure should discard the whole large folio instead of one order-0
page in the large folio. IOW, memory failure should expect to see
large folio.

Thanks,
Yang

>
> WDYT?
>
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index f327d62fc985..e15c3ca07e33 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -387,34 +387,16 @@ int folio_split(struct folio *folio, unsigned int n=
ew_order, struct page *page,
>   * Return: 0: split is successful, otherwise split failed.
>   */
>  static inline int try_folio_split(struct folio *folio, struct page *page=
,
> -               struct list_head *list)
> +               struct list_head *list, unsigned int order)
>  {
> -       int ret =3D min_order_for_split(folio);
> -
> -       if (ret < 0)
> -               return ret;
> -
> -       if (!non_uniform_split_supported(folio, 0, false))
> +       if (!non_uniform_split_supported(folio, order, false))
>                 return split_huge_page_to_list_to_order(&folio->page, lis=
t,
> -                               ret);
> -       return folio_split(folio, ret, page, list);
> +                               order);
> +       return folio_split(folio, order, page, list);
>  }
>  static inline int split_huge_page(struct page *page)
>  {
> -       struct folio *folio =3D page_folio(page);
> -       int ret =3D min_order_for_split(folio);
> -
> -       if (ret < 0)
> -               return ret;
> -
> -       /*
> -        * split_huge_page() locks the page before splitting and
> -        * expects the same page that has been split to be locked when
> -        * returned. split_folio(page_folio(page)) cannot be used here
> -        * because it converts the page to folio and passes the head
> -        * page to be split.
> -        */
> -       return split_huge_page_to_list_to_order(page, NULL, ret);
> +       return split_huge_page_to_list_to_order(page, NULL, 0);
>  }
>  void deferred_split_folio(struct folio *folio, bool partially_mapped);
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 5acca24bbabb..faf5da459a4c 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3653,8 +3653,6 @@ static int __folio_split(struct folio *folio, unsig=
ned int new_order,
>
>                 min_order =3D mapping_min_folio_order(folio->mapping);
>                 if (new_order < min_order) {
> -                       VM_WARN_ONCE(1, "Cannot split mapped folio below =
min-order: %u",
> -                                    min_order);
>                         ret =3D -EINVAL;
>                         goto out;
>                 }
> @@ -3986,11 +3984,6 @@ int min_order_for_split(struct folio *folio)
>
>  int split_folio_to_list(struct folio *folio, struct list_head *list)
>  {
> -       int ret =3D min_order_for_split(folio);
> -
> -       if (ret < 0)
> -               return ret;
> -
>         return split_huge_page_to_list_to_order(&folio->page, list, ret);
>  }
>
> diff --git a/mm/truncate.c b/mm/truncate.c
> index 91eb92a5ce4f..1c15149ae8e9 100644
> --- a/mm/truncate.c
> +++ b/mm/truncate.c
> @@ -194,6 +194,7 @@ bool truncate_inode_partial_folio(struct folio *folio=
, loff_t start, loff_t end)
>         size_t size =3D folio_size(folio);
>         unsigned int offset, length;
>         struct page *split_at, *split_at2;
> +       unsigned int min_order;
>
>         if (pos < start)
>                 offset =3D start - pos;
> @@ -223,8 +224,9 @@ bool truncate_inode_partial_folio(struct folio *folio=
, loff_t start, loff_t end)
>         if (!folio_test_large(folio))
>                 return true;
>
> +       min_order =3D mapping_min_folio_order(folio->mapping);
>         split_at =3D folio_page(folio, PAGE_ALIGN_DOWN(offset) / PAGE_SIZ=
E);
> -       if (!try_folio_split(folio, split_at, NULL)) {
> +       if (!try_folio_split(folio, split_at, NULL, min_order)) {
>                 /*
>                  * try to split at offset + length to make sure folios wi=
thin
>                  * the range can be dropped, especially to avoid memory w=
aste
> @@ -254,7 +256,7 @@ bool truncate_inode_partial_folio(struct folio *folio=
, loff_t start, loff_t end)
>                  */
>                 if (folio_test_large(folio2) &&
>                     folio2->mapping =3D=3D folio->mapping)
> -                       try_folio_split(folio2, split_at2, NULL);
> +                       try_folio_split(folio2, split_at2, NULL, min_orde=
r);
>
>                 folio_unlock(folio2);
>  out:
>
>
> Best Regards,
> Yan, Zi
>

