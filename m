Return-Path: <linux-kernel+bounces-848389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD78BCD9F4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 16:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5AA3E4E62AE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 14:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990642F7463;
	Fri, 10 Oct 2025 14:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VTnmIb1T"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD502F6573
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 14:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760108050; cv=none; b=G1IjDBQ/Dxhx3V7SDR87k3lsGP9ntiEPErUw0sEeh0tJEhJgAhDRuDpTW/zKeZL+89Im0Xin6/gmO2jBhXF6rIi7qU4CY5nG/bhs/mvTUBqWBm6CVwR4Zf/fWknsDxuv2nSNaLutSO8t01lb+qnMSfq3ntEh5cX0JxakvRDuKvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760108050; c=relaxed/simple;
	bh=DC7x9YWROCenDmlSc1FcZsUca68HCfG/mUx/W7rmzrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YJzneht6QmM64NyUyiaqrnrD7rvp7HLZ/xlaTbx2+MxGzfjPK7aFxRdrY568F4kWfhoMlyTdI8JAA1IvfOTHtEcA7pdH6hIWv7orRcnseYg2xNRcQfYICi8blnBIoJRtcaKIHGAobqeTsR+YsTuBFsjIC424L4sLxnHUaO8tAcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VTnmIb1T; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4e6ec0d1683so314461cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 07:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760108048; x=1760712848; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0DpdiimUJLGEL9YZv8OhwGPgsBnQcaD8Xj4apakBfn0=;
        b=VTnmIb1TlHElKTohVvdtRHx7HEmeqrB8hSvmF22DJB+mQqqZZk+wvsDuz4uln9V7FU
         dpsQgLT/r6jgDPFmApUUPclup6rNvOlQo0ZBmnDUNevAy0Zisy9ZysmhlASpSd4Rc+w1
         UlL5OoGSVmhMYUtrcg8PpuJ5/J5BCFolzz31lFG/HMjjS7/pk80KXDRttm9jhNG34XxI
         y42d9fImcgtux4nhQ7EP8Q2jXzWGqDHaxpe/P/Sck42KrtcdBO5PGk1kL/VeEL5tIWyF
         /sauTiZHoQFdaXa8Z681DWvHC8T3LFGFuTu+3Zdya2+6jVwPi1yIjMqIFriwTRqAu6Ku
         DWSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760108048; x=1760712848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0DpdiimUJLGEL9YZv8OhwGPgsBnQcaD8Xj4apakBfn0=;
        b=g1ARVWCT32dNldcyyKUQaaUgVrEohFsI9n6XCM7L7XxaOQ6cMGlLsThvsIIHXyuqkP
         XOLK+UWAD2fEd01Q9NuTKaNrq6p55gAAwrSRC83ssbbsjWuLRU3PwWLGDInqJuEGW/uv
         gjcW64k1HPkPwbMtukGeGuiEFqFOmnyh1uXIHADdzvW/Rz5f+EfMFG1zE+9EzPRGb+xN
         2mk1zkNx3v5RX6++t52iHYXTS/FYskZqzze5bUL53vWm9NKK7UZfTsv8XBCMNJZNZCAB
         ZU6MCZfJ8URt/o90qyn9pvMYNB9pX+Ddk+xNd6t0q/vMXhr+jaV+R8y3BdqEDWP31rvS
         5SQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUs+50sHLRbl9m4fsdAH51o//sQRlciB7F9HNqxnWLpomv+yP2J0eEfwUv5EZfPf1CTIU+xsZEMMcwmiz8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvVA8L/r6+n7ZgIHVWzrqp31X/XJ83JtpDxbqHxcqvSgRFE28P
	mBvjY5qpU0AHTBTio8La6ysWNfOcqTCFpVYTvk+QPYYm2gombAU49oXvjiBQYw4agFPMr5UMHPC
	oR1ANnCy8WWjoJeAtPk7bCBJKcupMAC39ua8CbY0U
X-Gm-Gg: ASbGncvLj6Xnf4aEY+uZTLF3dwNjQLLguewj0q5tqTVPtuxyYQbOkJgS2m/WyaHheqG
	PiHzCkl/dntuk5axOiizCiqeErbyKW3tTFq8zIHDr7awMgv56ViiI8wNzX9obLs6SbDoj44jVVu
	5EgwaYqksk+tb6Cv4r/dGDOwgV3v71KH3MYQVzafI845ZYbepUAs8TqdUDBwxFabqolOs3qe2Ov
	jHiCIhRmu7jOYqbunPg2b3gZYjwGedrlNyt1vYR37PEPuHX9OeI
X-Google-Smtp-Source: AGHT+IELG1HO5re9l71qV16AXiLCV5TxV3n/x4fv7b1UlE7oKp+shLXPJ4Ui15bl56g81Rjif4tTmM3A2oXDy0V1pv8=
X-Received: by 2002:a05:622a:50:b0:4d0:dff9:9518 with SMTP id
 d75a77b69052e-4e6eabcf616mr24839371cf.12.1760108047605; Fri, 10 Oct 2025
 07:54:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010011951.2136980-1-surenb@google.com> <20251010011951.2136980-2-surenb@google.com>
 <aOhx9Zj1a6feN8wC@casper.infradead.org>
In-Reply-To: <aOhx9Zj1a6feN8wC@casper.infradead.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 10 Oct 2025 07:53:56 -0700
X-Gm-Features: AS18NWBSQfAZ95bfn8zHE7YuLwgx02HxJfLsEBTBLUde_yaDHMul1ATmajxkrCY
Message-ID: <CAJuCfpH85Ns8_+JNG4HS6TnFMUN0si+mcLXxUxedhQh1c0CSEw@mail.gmail.com>
Subject: Re: [PATCH 1/8] mm: implement cleancache
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, alexandru.elisei@arm.com, 
	peterx@redhat.com, sj@kernel.org, rppt@kernel.org, mhocko@suse.com, 
	corbet@lwn.net, axboe@kernel.dk, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	hch@infradead.org, jack@suse.cz, m.szyprowski@samsung.com, 
	robin.murphy@arm.com, hannes@cmpxchg.org, zhengqi.arch@bytedance.com, 
	shakeel.butt@linux.dev, axelrasmussen@google.com, yuanchu@google.com, 
	weixugc@google.com, minchan@kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	iommu@lists.linux.dev, Minchan Kim <minchan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 7:39=E2=80=AFPM Matthew Wilcox <willy@infradead.org>=
 wrote:
>
> On Thu, Oct 09, 2025 at 06:19:44PM -0700, Suren Baghdasaryan wrote:
> > +     /*
> > +      * 99% of the time, we don't need to flush the cleancache on the =
bdev.
> > +      * But, for the strange corners, lets be cautious
> > +      */
> > +     cleancache_invalidate_inode(mapping, mapping->host);
>
> Why do we need to pass in both address_space and inode?

Ah, you mean why I don't use inode->i_mapping to get to its address
space? I think I can. I'll try, and unless something blows up, I'll
apply the change in the next version.

>
> > +/*
> > + * Backend API
> > + *
> > + * Cleancache does not touch page reference. Page refcount should be 1=
 when
> > + * page is placed or returned into cleancache and pages obtained from
> > + * cleancache will also have their refcount at 1.
>
> I don't like these references to page refcount.  Surely you mean folio
> refcount?

Yes, mea culpa :) Will fix.

>
> > +     help
> > +       Cleancache can be thought of as a page-granularity victim cache
> > +       for clean pages that the kernel's pageframe replacement algorit=
hm
> > +       (PFRA) would like to keep around, but can't since there isn't e=
nough
>
> PFRA seems to be an acronym you've just made up.  Why?

Inherited from the original cleancache documentation. Will remove.

>
> > +struct cleancache_inode {
> > +     struct inode *inode;
> > +     struct hlist_node hash;
> > +     refcount_t ref_count;
> > +     struct xarray folios; /* protected by folios.xa_lock */
>
> This is a pointless comment.  All xarrays are protected by their own
> xa_lock.

Ack.

>
> > +static DEFINE_IDR(fs_idr);
>
> No.  The IDR is deprecated.  Use an allocating XArray.

Ah, good to know. I'll change to xarray.

>
> > +/*
> > + * Folio attributes:
> > + *   folio->_mapcount - pool_id
> > + *   folio->mapping - ccinode reference or NULL if folio is unused
> > + *   folio->index - file offset
>
> No.  Don't reuse fields for something entirely different.  Put a
> properly named field in the union.

Ack.

>
> > +static void folio_attachment(struct folio *folio, struct cleancache_in=
ode **ccinode,
>
> Unnecessarily long line

Ack.

Thanks for the feedback, Matthew!

>

