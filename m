Return-Path: <linux-kernel+bounces-810223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A0FB5176A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B8A75E059D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6044E31CA66;
	Wed, 10 Sep 2025 12:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Olf4fOkj"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB7D31DDAC
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 12:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757509020; cv=none; b=L1bFeEkAN3oQLNFllV1RETIhoS3QKnqWB4v2Uq93FyA3VXOVL09LxtoibMspJfpA1gDWny0ryZxjS+EFLaT+n9CjWWCTq6+QoJE6gG03jLUgA2YU9TuWF4+SkIfA4M8pm4qz6Nehd/4N3lzYStyluc5F2YDLYr30hsPIm0rUWCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757509020; c=relaxed/simple;
	bh=ggmBScy3Dq2wfaxRKxoM0Fquk3b6bViu168f83JKzOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bpjRoKJDkPiXbMxAdq7iCWsDYWeGqtMSB/R+snyy/ZlAdTIGaK8d42s+7NpGj3xc+En/BEZQ8BNvxSoJxQYBE6H5EWEH4KiUzHPRnKxHqCvpkW+jLVm56EwaJIGQc6XVsodItnromiCpgFb/V8HXyLb5xbcLURGdLC3+NPwsGAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Olf4fOkj; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-625e1dfc43dso7301544a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 05:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757509017; x=1758113817; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MMKyDunwSGtBRbm9G/rqnpc3sRFNucd0BdvyVxUFvLg=;
        b=Olf4fOkjPeSlqq67BciUKKsU+xz9VC322LJ4pGidHhqFFfr6a6IuuA5ju6nDVeBjrp
         g+3yT+LhFZdDNnHvFPzBlOSJ+WKYquWJrrS6nesp8LtJiAT/9dJgpGmrmZ4/5xQ6v73z
         yEAb85/9LuhP34tZS/c9OzTjIf0BkApxRKFwjt3PEk8v8DUyxm0u6IIHYvoy9Udi0xJE
         HF4DnSNnliArkJRi9gkEzZo8MlzAvNJFAGKbO47ssFPEkkh2H/rRvL48dBgO6381eodN
         enXCmwy5G2+SLlww+zlfcIH4uS+9Oa4q7xK4mi8i4E75//ejfMiDTY+jO9W1ox0XpVvx
         2kiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757509017; x=1758113817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MMKyDunwSGtBRbm9G/rqnpc3sRFNucd0BdvyVxUFvLg=;
        b=CfmoxSPBomf+6NrEns/kAbw0jIEaIEHMEz1KxNPJnucrAxomk3X+v7fLNhw9kveRJ9
         sIarmVU0TtYnenngzRk6ySav17kQm6H1ggAZbXwhM0y650XWBTG3LdL1RspEZ7sRBMuj
         JeFv1DnuVNM/tfhT/1pdpxXUXA6/hM18hSAL1lt+lrDQiq1V5Wz8fs4QaIVE7Hm0rRNf
         iVr2k0hQzX9S7EARVEwMcjQ4FLf+HKFBECniMcUdtQICJXt/udxiqPOL1fHT1Owh+kqP
         vq0LFHvJixbWXRbbQzZ9HCV2EPjwQzX0u9225MvHatebplpKGixqJzt/k/yxCs0YpIup
         aiBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNiFnS19SSTU0GrOe+83xqHvRqC5OKc9GnA84SKIaeEYHi5eE79vvjeWxOm5wM9f/AEeheoBYcQINxnLw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0u5uU28gEoD1VJtkizDQjkefUaykpWwilyClF8/WCCTNmycIR
	xQVq6AlNrZMD8KJEPdAVvM+SmqXVdxDKNlDKqjlR4bZgMKEvBJzeUhVa9/4rhXa1C6agUQtaVjE
	jshB6FLM9KeS1y4FkvlpGlTDkmHApezw=
X-Gm-Gg: ASbGncsvxR+5oHDwGNiKDdiOmruBaM76q0El+dw5sdNUQfOWoKvzoyBYi5c+ACU53+Z
	FWFltlf2uPYdpV9LG6LzyebiloMqutL+FBm/r33h93U4MEShbDUCaOocMTHrUsj6EVvaVwLX0zI
	HXRXueC+Dmy9MiuBVC+5Ta9q4KG7tTE9RelnVPAmNH1tiVGYZ4jPeeJVRSUzHWR4LBm4TpeoPZp
	YFG9guu25MeFxx6Nmy5uw==
X-Google-Smtp-Source: AGHT+IEv9eLVpjjBvqrFpdRX6L3iK/v3rJwHC4f9FyOGjkK+DZCBoaCqi9xQ3rFk6LzHDIS4tktgKLhkDhbSow62Vc8=
X-Received: by 2002:a05:6402:4305:b0:629:7973:e8b1 with SMTP id
 4fb4d7f45d1cf-6297973ec5fmr7558603a12.7.1757509017250; Wed, 10 Sep 2025
 05:56:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905191357.78298-1-ryncsn@gmail.com> <20250905191357.78298-6-ryncsn@gmail.com>
 <0bbda135-068a-45bd-afd6-3f5cdf4e570d@redhat.com> <CAMgjq7CsKYWzAD0Ev7q0cocQO8kOYLmhgLD0wk6AX-HUzWFJZQ@mail.gmail.com>
 <283fc6d5-caca-4a67-916e-55246a5a4cbb@redhat.com>
In-Reply-To: <283fc6d5-caca-4a67-916e-55246a5a4cbb@redhat.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 10 Sep 2025 20:56:20 +0800
X-Gm-Features: AS18NWCq6G6AFq-R6ytPum-lAXwcxsOSJmLax7Xy0V_qYAvPUPQFSkeoLQETCvU
Message-ID: <CAMgjq7Axhj-OGe6p1_KHAcR=j92=3MjMMz1YafsPxHWqsmemiA@mail.gmail.com>
Subject: Re: [PATCH v2 05/15] mm, swap: always lock and check the swap cache
 folio before use
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>, 
	Barry Song <baohua@kernel.org>, Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Yosry Ahmed <yosryahmed@google.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Zi Yan <ziy@nvidia.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 11:19=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 09.09.25 16:58, Kairui Song wrote:
> > On Mon, Sep 8, 2025 at 10:08=E2=80=AFPM David Hildenbrand <david@redhat=
.com> wrote:
> >>
> >>
> >>>
> >>>                folio_lock(folio);
> >>> +             if (!folio_matches_swap_entry(folio, entry)) {
> >>> +                     folio_unlock(folio);
> >>> +                     folio_put(folio);
> >>> +                     continue;
> >>> +             }
> >>> +
> >>
> >> I wonder if we should put that into unuse_pte() instead. It checks for
> >> other types of races (like the page table entry getting modified) alre=
ady.
> >
> > Doing this earlier here might help to avoid the folio_wait_writeback
> > below?
>
> Why would we care about optimizing that out in that corner case?
>
> And checking the folio right after locking seems to follow the
> > convention more strictly.
>
> I'd just slap it into unuse_pte() where you can return immediately and
> we don't need another duplicated
>
>         folio_unlock(folio);
>         folio_put(folio);
>         continue;

Yeah, removing the duplication is a very good point.

>
> --
> Cheers
>
> David / dhildenb
>

