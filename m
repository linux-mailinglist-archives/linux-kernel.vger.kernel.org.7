Return-Path: <linux-kernel+bounces-792676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB2DB3C77B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 04:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3ED7A265E7
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 02:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3C125FA0A;
	Sat, 30 Aug 2025 02:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EwITjDox"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6D125DD1E
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 02:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756521522; cv=none; b=EhK3XqhaZHd6DBIFmbH/ciFZZHT3Xft4IRIdfh9pSYG3uxpQu6ChOsqjKkUXreb2QWiqy+niSQJ9N1XqyTvToJYW+RtdkY8XQ3/nwyJgE29gKZBoNTL5Km3r21uxxdc+n3e8F6IERdjlKps+GuBObegvXP5TyV3CuULvCjiyBq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756521522; c=relaxed/simple;
	bh=+p2n4tlZXGaHynIlVJt3ZHWklmLb2NN8iFLRK8WKrfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mlA8mp86UGtZQeZD4MxakZfJbHKpKxJfMv5fG0qsz440DJF0vTdfo1NrJ8t1FYki34H/xRf4F2TA7cs67woUM9c3YhPdqrwteGq41EUM8bbhGLH2KftKWR633/NhAOs1g46Yw6BP1aT6HQ7cXddZQwF3uBclm2I/kt3QuFRP+Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EwITjDox; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44F57C4CEFA
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 02:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756521522;
	bh=+p2n4tlZXGaHynIlVJt3ZHWklmLb2NN8iFLRK8WKrfE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EwITjDoxrM3rp7no35oPvdgmrP1ln2hZRFOawv6iBrhmW0++wNPgbxSuietZjXCrk
	 t9i/I3uWcJf0JdWaF0B9ATrRX4JHIEFC6RlQYS8frnmQaDGdlXS8MY4G+bT3e7nPwY
	 EodzG7n8aHnfhqTxsoYLjvXrN0DIxvJoTNe6rvwPXP+6n736JJa8o3uYZb2VV6+GGE
	 fmAZg49g9m4IUBJzqestbiM+A65GHmqDH/PIjsIkx2KWnQWS49GjScTKXHpcU8C1Qw
	 YPXx5Yt/SOwzG90CFsxk5EbmZ8oxLMuN+KSDUi85LXXlGgXzyL8iJSTmkcWlkykslv
	 Lj9mgBAmukF5w==
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-71d6059f490so25628817b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 19:38:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWB7pq92Yp7/TLrRKe1t6DZ9tjF3P3qhJEFjNJusjFpOzrG8xOdycSxy7obOn75w/kNZ5M4ml9mQazKN2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH6OhXr8PGszfJDgmKB5hg+p6qQqsJNtOxZV6oUUj8hQq7940o
	ibOdWKGnjGIp5p8VDaUJb96Ig9LIReV0db/khDQMgmJIDWwMcjNzoWoY4U84aNt90UxV8faZnmG
	wcmBudPxBbGaFnzqFejSO35f5XCtWMGeaquwvkdjbig==
X-Google-Smtp-Source: AGHT+IGuBuSwsjhHFtUTKA74QyYXEtkfLGe4VoSYAhkXUSo9fI0UtL8SW/S4muEUQSA+uavvttIEfu1Uod6PEcZakOM=
X-Received: by 2002:a05:690c:6812:b0:721:69f6:d403 with SMTP id
 00721157ae682-7227635732dmr9024847b3.11.1756521521562; Fri, 29 Aug 2025
 19:38:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822192023.13477-1-ryncsn@gmail.com> <20250822192023.13477-5-ryncsn@gmail.com>
 <aK5/1so7a0i80+dz@MiWiFi-R3L-srv> <CACePvbU8pnjWCiWcSXRr4UdpuD_wdtrouLMz_fNB_=KRrdHLmQ@mail.gmail.com>
 <aK+YzeWToVUX3WOY@MiWiFi-R3L-srv>
In-Reply-To: <aK+YzeWToVUX3WOY@MiWiFi-R3L-srv>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 29 Aug 2025 19:38:30 -0700
X-Gmail-Original-Message-ID: <CACePvbWX+snaDv9rJKfVe69QDo11ZwHQwuzd8Y8dJ8bS3ZJVEA@mail.gmail.com>
X-Gm-Features: Ac12FXzygJ_nskFfLZf5V2ThWdnbwEO8i2QJvMzIYPH7zqT-9-D6M15Imx23neQ
Message-ID: <CACePvbWX+snaDv9rJKfVe69QDo11ZwHQwuzd8Y8dJ8bS3ZJVEA@mail.gmail.com>
Subject: Re: [PATCH 4/9] mm, swap: tidy up swap device and cluster info helpers
To: Baoquan He <bhe@redhat.com>
Cc: Kairui Song <kasong@tencent.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	Hugh Dickins <hughd@google.com>, Barry Song <baohua@kernel.org>, Nhat Pham <nphamcs@gmail.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 4:46=E2=80=AFPM Baoquan He <bhe@redhat.com> wrote:
>
> On 08/27/25 at 10:44am, Chris Li wrote:
> > On Tue, Aug 26, 2025 at 8:47=E2=80=AFPM Baoquan He <bhe@redhat.com> wro=
te:
> > >
> > > On 08/23/25 at 03:20am, Kairui Song wrote:
> > > ......
> > > > diff --git a/mm/swap.h b/mm/swap.h
> > > > index 223b40f2d37e..7b3efaa51624 100644
> > > > --- a/mm/swap.h
> > > > +++ b/mm/swap.h
> > > > @@ -15,6 +15,8 @@ extern int page_cluster;
> > > >  #define swap_entry_order(order)      0
> > > >  #endif
> > > >
> > > > +extern struct swap_info_struct *swap_info[];
> > > > +
> > > >  /*
> > > >   * We use this to track usage of a cluster. A cluster is a block o=
f swap disk
> > > >   * space with SWAPFILE_CLUSTER pages long and naturally aligns in =
disk. All
> > > > @@ -53,9 +55,28 @@ enum swap_cluster_flags {
> > > >  #include <linux/swapops.h> /* for swp_offset */
> > > >  #include <linux/blk_types.h> /* for bio_end_io_t */
> > > >
> > > > +/*
> > > > + * Callers of all swp_* helpers here must ensure the entry is vali=
d, and
> > > > + * pin the swap device by reference or in other ways.
> > > > + */
> > > > +static inline struct swap_info_struct *swp_type_info(int type)
> > > > +{
> > > > +     struct swap_info_struct *si;
> > > > +
> > > > +     si =3D READ_ONCE(swap_info[type]); /* rcu_dereference() */
> > > > +     VM_WARN_ON_ONCE(percpu_ref_is_zero(&si->users)); /* race with=
 swapoff */
> > > > +     return si;
> > > > +}
> > > > +
> > > > +static inline struct swap_info_struct *swp_info(swp_entry_t entry)
> > > > +{
> > > > +     return swp_type_info(swp_type(entry));
> > > > +}
> > >
> > > swp_type_info() is only used by swp_info() in the whole series, can w=
e
> > > open code it in swp_info()?
> >
> > BTW, off topic here. I really don't like the "_info" suffix. Anything
> > you can put into a C struct by definition is some kind of information.
> > Same to the _struct. Anything defined by a struct is a struct. Don't
> > need to say that.
> > The "struct swap_info_struct" gets two of the unnecessary words. It
> > should be something like  "struct swap_file" or "struct swap_device".
> > Renaming it is too invasive to the code base and it will mess up the
> > git annotation history.
>
> I agree. I searched for _info_struct in the current code, only found
> swap_info_struct, ax25_info_struct, vm86plus_info_struct. The latter two
> are seen in very few LOC. Maybe we can rename it later when things are al=
l
> done. And 'struct swap_cluster_info' too.

Agree but might impact Kairui's later part of the patch series. Let's
wait until things stabilize a bit.

Again, no functional change patches are easier to review.

Acked-by: Chris Li <chrisl@kernel.org>

Chris

