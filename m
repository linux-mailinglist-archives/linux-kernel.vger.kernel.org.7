Return-Path: <linux-kernel+bounces-820176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D78DB7E030
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76C0F1BC0C1E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 07:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD392DEA76;
	Wed, 17 Sep 2025 07:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GCZp/18o"
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BF529AB13
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 07:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758095401; cv=none; b=HxMK4sRHct1zqThrggRLu/fuIpzQdZNlZ/1GfOsw5pAKOTak8h0cyGgQmq+Lfw+OeEwSj3y3H7KHMzuha7Cj6LosdcG7WCmi6vObRiMwDWquxVxcC3tn46gdWjAg+DjJomQwjHwCzVtKO72WcFmcfip9o3KSGxVy8EgN4AcugpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758095401; c=relaxed/simple;
	bh=8JVr+n6KIqKH/J1udIYS8p7uZws7D/9iWn6BpS9G2gg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Q3Rv7mo1rV8Vkg3WA2MhTR1JDtAunvB7J4At1Ubpo0BE3lCJ3fPcpAVo2rwtUHBhT1U0qCq+mdnSwce6p6uomh7cUrWLaMbfdcj4iRVqV5fOJntOkz2R9iucjMFiymrzi5vf2qxFF3t7ZMJ6BcBvdjE1Ym/6WuBt9trgjftIDAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GCZp/18o; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-62a35c99b9fso1609779d50.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 00:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758095398; x=1758700198; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6NQRoRgD8S2ikkOEtTruAMEMt6AIscFE/yU3xumvdBE=;
        b=GCZp/18oH4Ig3ixMzMRwpFbJs2Wdkz3K+K5hb4KowLNxOeaqgePoq+M2Td7xomyn1t
         Ia3jty48SHFr7gG4pcZLec5UATfsqRp1Y48hYRnLvscTBsgXmlgV6SRshAf1loLvD8U6
         JtKIDma38/HnC1RVXeJu43lF31agjWfTSaU3r5Y1oq1oapWRMR3fStsiVOZ8wGazcgLo
         00O8hBtBtRCWIufRz15M7PulncZjAxzT+mvO3I5VJnGTLje26MAn1/Lex4HrLdyTGcjm
         /Gcit9fGGwwz5grXv3ZAZKtVziecfFXD4Doixe+G/1/sGMl+b9/f0zV4FqJnY8pD+Las
         nmNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758095398; x=1758700198;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6NQRoRgD8S2ikkOEtTruAMEMt6AIscFE/yU3xumvdBE=;
        b=FS21NxTt31nfOb3tQ2csGAHVdzkVqzUcgbguZCTJ4ks1zwl0beY6IlaCsBmwMEUDIz
         25LANgUt+08pNQ3HaRhvl/Ey5EzM31noK0HBkTY0qK37Qx66HTWcknCkGFh4QxA7ZSUK
         0koow9Ng7ATed6yMosmPJCU+J/hIa3YqVltCgbso2W8VOI/8U52K3sHNnf2yzrZLChto
         6eIq58Rul5SrvijJ+koP850l6+kh59p9baNiJ+6jAP63BwEmT+KrTk0OPHq0iTpwBehW
         fYJN+/TJvtDXrW167tgA1J0MkKIPyf4l6Op3qC476RaYL1AF3PsSqyOVfORp/Zl122ne
         +fNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuHQbEHq0bECbQBWFndSqzBAHRDzT7dK/dPk3+qicCWpMZ8dUPmdTUMdpCay2lTLdhwz4kkXOQ0LgOgsk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEDEu+dQorQ6Y6CcUfygojNWYdV3Xuh91kIkMVUt85Z+QjzaRR
	B6sfHlfOptk8DpsCcPA6Rlx/qyvrp73Eg9VIOoqk1GZDPgzG1CQ9J2pgqrFjhRnPNQ==
X-Gm-Gg: ASbGncu7FCIWRzUpNFP0FG0I6b8ezaGpaqAjUYwPEPFMwTbWS9Uo67gYyKieQPC5Gi6
	FSfSIbAN1d3L+Zhj1t4L2XgDz1ihpJ356lU88b7+BOGEkKQ9e81ONTYCyJoWMWa8RQ+ATZlcL49
	27iDUHihad2Pj29sndJzifV3Exyn+wPSlJNHYcZ7FMGpuY9KDucbSWJY7rk85O3eEQr4gxikE29
	qzuay+mPNEKKbnIHBLchavi68rOUEAq/zH00Zza5PTucwfu2vud4l0quirPY6ZAmYZivhC5QBcS
	t0ku4yjSjjwRDE0o6gghRJL26FWtjMrXsmqmFEqXdQYQZXqlaW0KhYERLH1G1DoH8/kG3WVRqZx
	QKAwA5O3gahTkeLqViJFmsU1qnTrQcAKh8whl7rF1rh/fjok02+3SMEYIQRw5qrTGRD0S0Xt8eU
	sA0VIRUnH5Gb5qJw==
X-Google-Smtp-Source: AGHT+IEycN/Pi0TNMq7JJ5LbiFtMN/1DZOlF9cpk9pz+GeMZUQNxhoiqxbeuUkwh8PzyvhsApJdfTQ==
X-Received: by 2002:a05:690e:248d:b0:62c:f19f:794d with SMTP id 956f58d0204a3-633b06e8016mr715569d50.36.1758095398236;
        Wed, 17 Sep 2025 00:49:58 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-72f791a5d54sm45202767b3.37.2025.09.17.00.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 00:49:57 -0700 (PDT)
Date: Wed, 17 Sep 2025 00:49:43 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
cc: Hugh Dickins <hughd@google.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
    akpm@linux-foundation.org, hannes@cmpxchg.org, david@redhat.com, 
    mhocko@kernel.org, zhengqi.arch@bytedance.com, lorenzo.stoakes@oracle.com, 
    willy@infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: vmscan: remove folio_test_private() check in
 pageout()
In-Reply-To: <7eace9f6-e257-498d-ac10-ae86b5713e3a@linux.alibaba.com>
Message-ID: <1111883c-974f-e4da-a38f-bb3d337185ad@google.com>
References: <cover.1757648598.git.baolin.wang@linux.alibaba.com> <b8c0fe71982aa1cafafd59d8e71064efaac16007.1757648598.git.baolin.wang@linux.alibaba.com> <qe56xt2natnxnkht7wgknsb5nqjhinaaajomvvvgnfpwry2jih@hsj2w5zqj6wv> <02798d6c-1ad3-4109-be3a-e09feb5e4eda@linux.alibaba.com>
 <9b01a2cc-7cdb-e008-f5bc-ff9aa313621a@google.com> <6ebb5cd0-0897-4de7-9303-422d0caa18cb@linux.alibaba.com> <7eace9f6-e257-498d-ac10-ae86b5713e3a@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463770367-1928573329-1758095397=:29290"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463770367-1928573329-1758095397=:29290
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 17 Sep 2025, Baolin Wang wrote:
> On 2025/9/16 15:18, Baolin Wang wrote:
=2E..
> >=20
> > Additionally, I'm still struggling to understand this case where a foli=
o is
> > dirty but has a NULL mapping, but I might understand that ext3 journali=
ng
> > might do this from the comments in truncate_cleanup_folio().
> >=20
> > But I still doubt whether this case exists because the refcount check i=
n
> > is_page_cache_freeable() considers the pagecache. This means if this di=
rty
> > folio's mapping is NULL, the following check would return false. If it
> > returns true, it means that even if we release the private data here, t=
he
> > orphaned folio's refcount still doesn't meet the requirements for being
> > reclaimed. Please correct me if I missed anything.
> >=20
> > static inline int is_page_cache_freeable(struct folio *folio)
> > {
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * A freeable page cac=
he folio is referenced only by the caller
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * that isolated the f=
olio, the page cache and optional filesystem
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * private data at fol=
io->private.
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return folio_ref_count(foli=
o) - folio_test_private(folio) =3D=3D
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 1 + folio_nr_pages(folio);
> > }
> >=20

Good point, yes, it's surprising that that such a folio could pass
that check and reach the code you're proposing to delete.

(Though a racing scanner of physical memory could raise the refcount
momentarily, causing the folio to look like a page cache freeable.)

>=20
> I continued to dig into the historical commits, where the private check w=
as
> introduced in 2005 by commit ce91b575332b ("orphaned pagecache memleak fi=
x"),
> as the commit message mentioned, it was to address the issue where reiser=
fs
> pagecache may be truncated while still pinned:

Yes, I had been doing the same research, coming to that same 2.6.12 commit,
one of the last to go in before the birth of git.

>=20
> "
> Chris found that with data journaling a reiserfs pagecache may be truncat=
e
> while still pinned.  The truncation removes the page->mapping, but the pa=
ge is
> still listed in the VM queues because it still has buffers.  Then during =
the
> journaling process, a buffer is marked dirty and that sets the PG_dirty
> bitflag as well (in mark_buffer_dirty). After that the page is leaked bec=
ause
> it's both dirty and without a mapping.
>=20
> So we must allow pages without mapping and dirty to reach the PagePrivate
> check.  The page->mapping will be checked again right after the PagePriva=
te
> check.
> "
>=20
> In 2008, commit a2b345642f530 ("Fix dirty page accounting leak with ext3
> data=3Djournal") seems to be dealing with a similar issue, where the page
> becomes dirty after truncation, and provides a very useful call stack:
> truncate_complete_page()
>       cancel_dirty_page() // PG_dirty cleared, decr. dirty pages
>       do_invalidatepage()
>         ext3_invalidatepage()
>           journal_invalidatepage()
>             journal_unmap_buffer()
>               __dispose_buffer()
>                 __journal_unfile_buffer()
>                   __journal_temp_unlink_buffer()
>                     mark_buffer_dirty(); // PG_dirty set, incr. dirty pag=
es
>=20
> In this fix, we forcefully clear the page's dirty flag during truncation =
(in
> truncate_complete_page()).

But missed that one.

>=20
> However, I am still unsure how the reiserfs case is checked through
> is_page_cache_freeable() (if the pagecache is truncated, then the pagecac=
he
> refcount would be decreased). Fortunately, reiserfs was removed in 2024 b=
y
> commit fb6f20ecb121 ("reiserfs: The last commit").

I did find a single report of the "pageout: orphaned page" message
(where Andrew claims the message as his forgotten temporary debugging):

https://lore.kernel.org/all/20061002170353.GA26816@king.bitgnome.net/

From=202006 on 2.6.18: and indeed it was on reiserfs - maybe reiserfs
had some extra refcounting on these pages, which caused them to pass
the is_page_cache_freeable() check (but would they actually be freeable,
or leaked? TBH I haven't tried to work that out, nor care very much).

Where does this leave us?  I think it says that your deletion of that
block from pageout() is acceptable now, with reiserfs gone to history.

Though somehow I would prefer, like that ext3 fix, that we would just
clear dirty on such a folio (to avoid "Bad page state" later if it is
freeable), not go to pageout(), but proceed to the folio_needs_release()
block like for clean folios.

But whatever: you've persuaded me! I withdraw my objection to your patch.

Thanks,
Hugh
---1463770367-1928573329-1758095397=:29290--

