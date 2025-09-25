Return-Path: <linux-kernel+bounces-832951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5F6BA0D4F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 19:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57D501BC5837
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 17:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F2630CDBA;
	Thu, 25 Sep 2025 17:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iA9Tt66G"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD7C30CD92
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 17:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758821214; cv=none; b=rtGhH01ZBNib1Qx5N1vGFCoG8nhlTbGXJaPvTNFCohlYyv3SwY6+JvHmAf49QHLYZmG8gz+wWhI44/L0Fj8dNx9nTGXoVScKsHDwMoZVBL5tPN4KrbpIDxBlplAb3CIg32WCukzxeZoaoXxWmU+4/Ma3mCfq5ckCWcDemSCn38c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758821214; c=relaxed/simple;
	bh=Hxzv2cBWff/v6c1vesRxyiI+Yy9Izb2fQv+kxW/dGpA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KG3e1ZbBcFyc9isbsNUprxequ5Mjg3S/UZJkEU5p7uy3HoWbINpd0vpihnBdgD2GiN3ywUwuLq7ov8CFXZ89v98S70miqCpuzsG2AEMYfVhAV6d6lHegK5zAVykNpVtJ5QJQyLo1+3vnL8ZrZ1YAfwQ9PY7zp7YYPtwRCwGtIuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iA9Tt66G; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-63491fc16c3so2049917a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758821211; x=1759426011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hxzv2cBWff/v6c1vesRxyiI+Yy9Izb2fQv+kxW/dGpA=;
        b=iA9Tt66G8WsdE42LEW5btnS1UMh9t8i3RKclwq8MlseFDslWHMC1jTJEvmLZPu79Ns
         Rb4szSeDrgSvQl4iaqMOxkWhXM9DIauwqQTB/IqrZzuJLp3UWZz/z3unxGxY2EoELRp8
         4s2NtDET9lZ8Epg1Wtth8XC69YU+08r2zcFWAdDAu0VQbvTpv2KDAVXSC9S+t+P1pQRY
         rpHRByatYs94Wwg2w751GWrLBh08g08/PWk3sRro9BS8z2ARL0uOpAPFwiPhZioXKWGx
         slht6+wyyrP9dCMyIteoZoIKkPokF4CQOQsOM35rflnKdFWoqWBFKgAcYuWnnyV2AYMH
         rhzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758821211; x=1759426011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hxzv2cBWff/v6c1vesRxyiI+Yy9Izb2fQv+kxW/dGpA=;
        b=N2YXQnHo4G5It7252UZ7YQoX6/daYgTSq3bQ8waa0KIwen7FyESDmCNrmp4JU91ETG
         a/35qv1h6sFLpXcToB6YJYGU7uxPGbwkCcXnYiIE/ECy+JGwqmuhbdFQRUasF/K/cI+x
         jXbCnPw/1RIFnBAfxoKMxKV+EIdnJWx2w7AVMhBOT/eQNjzRAcDq5zpomuqdujutB11E
         SaZLsI4HhVZ3FozQKG8RLowXnYX1ql2WDxt0kH+Bd9NSIZZOVr5fstYLmnjuHJiS4gP9
         ovgIjpgPmzwm/UC668hX6RLBVIN67Vz7pMywHBFjz0P5Ju/GsA9kP9IHwamaFP2t8Ko/
         n1EA==
X-Forwarded-Encrypted: i=1; AJvYcCXE9n7G2FD1hdip36KQqtu+V0Z3HueXfZpNOLGBIFCD3yTzfIvT/uvktOHSUxDCcQ7d+IwiUdIZPcmpsZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIwM6UATAR8TeWFwDrwz3At5uSlrvdkVlKlugEffE61gXol1wq
	rC+QikKMzAasxB9tmAxXgLzihlfeSqUXUKr4agxeBSd6Dd1WTnocS/+bOx3NP/qr4UjFhVhhzlp
	oQiqVYIuuyp0MKcvMn9zq3r4tcM0S3VqkeGmr
X-Gm-Gg: ASbGncs8fZI+JlPLp+81p/KyELYg9DsHuZvxPxmAm7nb8FtGFxxVePpXoyJIu+8r5R0
	A4fRNO9L0DlvMw3iAGpz2lMxZjuWGnCEzGJm7TTCV0X7s8nIMZz6tTZJQeZsL941HLiJ2E04HqB
	rO8x8rOwm4SUfpotXH5K4GYRF8NBCVftOmy8K9GZpMHqsSpaKhRx4prGsKD/oOsQ5LpUA38+rAK
	Ts=
X-Google-Smtp-Source: AGHT+IEjzLFBbzflK4F+frlRfcbPaspWQC9oQPfqbZdjRXB0LrK0sUdF9qQBxVp9KRq1FroodJ/I2IDpzawl6coBJMs=
X-Received: by 2002:a17:907:2da7:b0:b30:daf3:a5a0 with SMTP id
 a640c23a62f3a-b34bad2253cmr480436066b.42.1758821210852; Thu, 25 Sep 2025
 10:26:50 -0700 (PDT)
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
 <80D4F8CE-FCFF-44F9-8846-6098FAC76082@nvidia.com> <CAHbLzkrstjnEVUzz2==A2Z+CJToOgU6YU2MasdK49o-0-jW2yw@mail.gmail.com>
 <ec108aa2-88ae-42bb-a64d-ef12867526c4@redhat.com>
In-Reply-To: <ec108aa2-88ae-42bb-a64d-ef12867526c4@redhat.com>
From: Yang Shi <shy828301@gmail.com>
Date: Thu, 25 Sep 2025 10:26:39 -0700
X-Gm-Features: AS18NWA7mmHpaW4unFP9jmKD9f1afbd8FCzR488IcF67iAHmHq3JAN9lKlZCtYo
Message-ID: <CAHbLzkryOopTOJ1gXmQiveZtuDfqSyYTO5WsfvrFcNjiHJV3cw@mail.gmail.com>
Subject: Re: [syzbot] [mm?] WARNING in memory_failure
To: David Hildenbrand <david@redhat.com>
Cc: Zi Yan <ziy@nvidia.com>, "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, 
	syzbot <syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, linmiaohe@huawei.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, nao.horiguchi@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 9:48=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 25.09.25 18:23, Yang Shi wrote:
> > On Thu, Sep 25, 2025 at 7:45=E2=80=AFAM Zi Yan <ziy@nvidia.com> wrote:
> >>
> >> On 25 Sep 2025, at 8:02, Pankaj Raghav (Samsung) wrote:
> >>
> >>>>>>
> >>>>>> We might just need (a), since there is no caller of (b) in kernel,=
 except
> >>>>>> split_folio_to_order() is used for testing. There might be future =
uses
> >>>>>> when kernel wants to convert from THP to mTHP, but it seems that w=
e are
> >>>>>> not there yet.
> >>>>>>
> >>>>>
> >>>>> Even better, then maybe selected interfaces could just fail if the =
min-order contradicts with the request to split to a non-larger (order-0) f=
olio.
> >>>>
> >>>> Yep. Let=E2=80=99s hear what Luis and Pankaj will say about this.
> >>>>
> >>>>>
> >>>>>>
> >>>>>>
> >>>>>> +Luis and Pankaj for their opinions on how LBS is going to use spl=
it folio
> >>>>>> to any order.
> >>>>>>
> >>>>>> Hi Luis and Pankaj,
> >>>>>>
> >>>>>> It seems that bumping split folio order from 0 to mapping_min_foli=
o_order()
> >>>>>> instead of simply failing the split folio call gives surprises to =
some
> >>>>>> callers and causes issues like the one reported by this email. I c=
annot think
> >>>>>> of any situation where failing a folio split does not work. If LBS=
 code
> >>>>>> wants to split, it should supply mapping_min_folio_order(), right?=
 Does
> >>>>>> such caller exist?
> >>>>>>
> >>>
> >>> I am not aware of any place in the LBS path where we supply the
> >>> min_order. truncate_inode_partial_folio() calls try_folio_split(), wh=
ich
> >>> takes care of splitting in min_order chunks. So we embedded the
> >>> min_order in the MM functions that performs the split instead of the
> >>> caller passing the min_order. Probably, that is why this problem is
> >>> being exposed now where people are surprised by seeing a large folio
> >>> even though they asked to split folios to order-0.
> >>>
> >>> As you concluded, we will not be breaking anything wrt LBS as we
> >>> just refuse to split if it doesn't match the min_order. The only issu=
e I
> >>> see is we might be exacerbating ENOMEM errors as we are not splitting=
 as
> >>> many folios with this change. But the solution for that is simple, ad=
d
> >>> more RAM to the system ;)
> >>>
> >>> Just for clarity, are we talking about changing the behaviour just th=
e
> >>> try_to_split_thp_page() function or all the split functions in huge_m=
m.h?
> >>
> >> I want to change all the split functions in huge_mm.h and provide
> >> mapping_min_folio_order() to try_folio_split() in truncate_inode_parti=
al_folio().
> >>
> >> Something like below:
> >>
> >> 1. no split function will change the given order;
> >> 2. __folio_split() will no longer give VM_WARN_ONCE when provided new_=
order
> >> is smaller than mapping_min_folio_order().
> >>
> >> In this way, for an LBS folio that cannot be split to order 0, split
> >> functions will return -EINVAL to tell caller that the folio cannot
> >> be split. The caller is supposed to handle the split failure.
> >
> > Other than making folio split more reliable, it seems like to me this
> > bug report shows memory failure doesn't handle LBS folio properly. For
> > example, if the block size <=3D order-0 page size (this should be alway=
s
> > true before LBS), memory failure should expect the large folio is
> > split to order-0, then the poisoned order-0 page should be discarded
> > if it is not dirty. The later access to the block will trigger a major
> > fault.
>
> Agreed that larger-folio support would be nice in memory-failure code,
> but I recall some other areas we recently touched that are rather hairy.
> (something around unmap_poisoned_folio()).

I had been busy on some arm64 stuff, I didn't follow up the recent
development too closely, you meant this one?
https://lore.kernel.org/linux-mm/20250627125747.3094074-3-tujinjiang@huawei=
.com/

It seems like we need more work to support large folio for memory failure.

Thanks,
Yang

>
> The BUG at hand is that we changed splitting semantics without taking
> care of the actual users.
>
> --
> Cheers
>
> David / dhildenb
>

