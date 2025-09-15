Return-Path: <linux-kernel+bounces-817591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B2FB58435
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 20:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E6F116DF29
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 18:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02101275B1B;
	Mon, 15 Sep 2025 18:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6gQHAwN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FA321CC71
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 18:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757959393; cv=none; b=hDT9B7Nh20Vg29CRflbI4zPVVCyFN6mTukTKsrWY5yQPnZl34D1k9bjWiRoyIkzVSeJj7BjxZfMr2nHsCfkFl/tx119P4gmjiDWH9THPzJTqZ7j50lLNehbs9xb1Mds3Mfic2KDfDurjXjjMGiinakUmRH3ooII31eQbGTcHz74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757959393; c=relaxed/simple;
	bh=95ccvwynTPPBJ3VSneLqZ1zP/VaVb+UaV3d2KQZYJkQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gQ4X3I0yVVb4PcxsnPg8jrTN5HXjjlvN05Wrv6HwcmriujvyvA3MVYjkHfE5ZtPOJz9K6D4HB/0Wke9zY6xMxBJcHieQRFH2grPRV51hg2VX70Clp31SdnPH9NRz3jj796+USwEaPOOhv1LmQvoLD2SSj8hEIhvIG2yg20ZaOXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b6gQHAwN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD936C113D0
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 18:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757959392;
	bh=95ccvwynTPPBJ3VSneLqZ1zP/VaVb+UaV3d2KQZYJkQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=b6gQHAwNSHIM0m1optIKYBL3uLR1WmN984EcPGAyGqBs2pGtAsY++vKO03EZkFIwV
	 +tRMRu5ftNCsop4lkHoIxHLopYpvorUXj/i0l1Q0NLY8RVi0PxAvrmS6Ubc1tYJbQ5
	 dGRJysVxxfW8HtC2AgEEkXlEPB7dhWgScZezzJWvV1M+62hGmJ5PW1oT6877zcFZ4M
	 8VipDL+Z3vuvQOsA0EPPdWRsBW8M6ME4wekPiGZ+8upRDpollWrgHgJyNwKyDS6rF2
	 9X++AR7AI9cFawDF4VpooBVn/NrPr3dWNXN0g0mAFEtWBfcxPsCkxdEtyZhL9psuAJ
	 FXRPzbT8IjBMw==
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-60f476eab6cso2410828d50.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:03:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUk8wQQr8Svod466mxSfvKlLHWhJQkN8otQyNMB7071wv3KLHhtduIWI/SLTul57vhrkro55Ysyfjj74fM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yztn2mDgffiEmH1tUhrLbH3z9MGuQGEsjusz7hN3f5B/4hzCsKl
	oeMe5t28kXD7q9u1yWz15PLHLHSwod301ndCE9dxnYbfE45A6FyQYIz9Pv7Xst6NT/E4lc7RW0w
	jKF6TYnT8+cHSqD5x65s478FBsQzH7kCSEFgWfXijuA==
X-Google-Smtp-Source: AGHT+IGznbxlru4z1wgEjBBcYPzKTJKderdVTriUrpm7drfmb1ZVpveUFgHxH+0dDwR+fAkdCmzAq4G/cfPwxyeMIDE=
X-Received: by 2002:a05:690c:3388:b0:729:46de:38bf with SMTP id
 00721157ae682-73064febdc6mr119361847b3.29.1757959392031; Mon, 15 Sep 2025
 11:03:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910160833.3464-15-ryncsn@gmail.com> <20250915150719.3446727-1-clm@meta.com>
 <CAMgjq7A1hqQ+yboCtT+JF=5Tfijph2s4ooSqNwnexQ9kwJOCtA@mail.gmail.com>
 <6466a351-4c3a-4a02-b76f-8785daf36c0b@meta.com> <CACePvbUWGNq=TW2aP2zvcp9=Xt86hBPi3Ga1SLqjeZcyaKApoQ@mail.gmail.com>
In-Reply-To: <CACePvbUWGNq=TW2aP2zvcp9=Xt86hBPi3Ga1SLqjeZcyaKApoQ@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Mon, 15 Sep 2025 11:03:01 -0700
X-Gmail-Original-Message-ID: <CACePvbWiGZEuR1xHorjS2mXE-=Z4ZfpR8U_1jSMGMBe8PFnU_g@mail.gmail.com>
X-Gm-Features: Ac12FXzKV5l_rqhgwUM_R0cj5e126WLF3vMosZkwhTpDsrGF8h_VyiI2EGR56GM
Message-ID: <CACePvbWiGZEuR1xHorjS2mXE-=Z4ZfpR8U_1jSMGMBe8PFnU_g@mail.gmail.com>
Subject: Re: [PATCH v3 14/15] mm, swap: implement dynamic allocation of swap table
To: Chris Mason <clm@meta.com>
Cc: Kairui Song <ryncsn@gmail.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	Hugh Dickins <hughd@google.com>, Barry Song <baohua@kernel.org>, Baoquan He <bhe@redhat.com>, 
	Nhat Pham <nphamcs@gmail.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, David Hildenbrand <david@redhat.com>, 
	Yosry Ahmed <yosryahmed@google.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Zi Yan <ziy@nvidia.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 10:14=E2=80=AFAM Chris Li <chrisl@kernel.org> wrote=
:
>
> On Mon, Sep 15, 2025 at 10:00=E2=80=AFAM Chris Mason <clm@meta.com> wrote=
:
> >
> >
> >
> > On 9/15/25 12:24 PM, Kairui Song wrote:
> > > On Mon, Sep 15, 2025 at 11:55=E2=80=AFPM Chris Mason <clm@meta.com> w=
rote:
> > >>
> > >> On Thu, 11 Sep 2025 00:08:32 +0800 Kairui Song <ryncsn@gmail.com> wr=
ote:
> >
> > [ ... ]
> >              spin_lock(&si->global_cluster_lock);
> > >>> +     /*
> > >>> +      * Back to atomic context. First, check if we migrated to a n=
ew
> > >>> +      * CPU with a usable percpu cluster. If so, try using that in=
stead.
> > >>> +      * No need to check it for the spinning device, as swap is
> > >>> +      * serialized by the global lock on them.
> > >>> +      *
> > >>> +      * The is_usable check is a bit rough, but ensures order 0 su=
ccess.
> > >>> +      */
> > >>> +     offset =3D this_cpu_read(percpu_swap_cluster.offset[order]);
> > >>> +     if ((si->flags & SWP_SOLIDSTATE) && offset) {
> > >>> +             pcp_ci =3D swap_cluster_lock(si, offset);
> > >>> +             if (cluster_is_usable(pcp_ci, order) &&
> > >>> +                 pcp_ci->count < SWAPFILE_CLUSTER) {
> > >>> +                     ci =3D pcp_ci;
> > >>                        ^^^^^^^^^^^^^
> > >> ci came from the caller, and in the case of isolate_lock_cluster() t=
hey
> > >> had just removed it from a list.  We overwrite ci and return somethi=
ng
> > >> different.
> > >
> > > Yes, that's expected. See the comment above. We have just dropped
> > > local lock so it's possible that we migrated to another CPU which has
> > > its own percpu cache ci (percpu_swap_cluster.offset).
> > >
> > > To avoid fragmentation, drop the isolated ci and use the percpu ci
> > > instead. But you are right that I need to add the ci back to the list=
,
> > > or it will be leaked. Thanks!
> >
> > Yeah, the comment helped a lot (thank you).  It was just the leak I was
> > worried about ;)
>
> As Kairui said, that is not a leak, it is the intended behavior. It
> rotates the listhead when fetching the ci from the list to avoid
> repeatedly trying some fragment cluster which has a very low success
> rate. Otherwise it can stall on the same fragmented list. It does look
> odd at the first glance. That is the best we can do so far without
> introducing a lot of repeating rotation logic to the caller. If you
> find other ways to improve the reading without performance penalty and
> make code simpler, feel free to make suggestions or even patches.

Sorry I take back what I just said. There might be a real leak as you
point out. My bad.

Chris

