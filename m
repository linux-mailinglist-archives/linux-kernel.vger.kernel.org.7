Return-Path: <linux-kernel+bounces-739359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB95B0C54D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 15:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 958443B1410
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 13:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74732C324C;
	Mon, 21 Jul 2025 13:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E3Mr4B3b"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A7F28F53F
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 13:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753104943; cv=none; b=tZtFMDUX2dVm/USU1u3xca9GpaV8yxBM8eJDuMwlTt7dvaJaPCeSpcnjG6qUlptQZW+BvEd/4eVtW3ygdwar7Jmx8rEGtBUsaqJLji+VfJmYNYyflTOr83/ZPAL7DF93cXpLFbB9k/T392/90NrRk3PNXrvby1CCsLwgDgDJ+JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753104943; c=relaxed/simple;
	bh=vdV4AbIHHCh/p4KE/2PhpkRCcEnpbWOLyAFLgGzS0TQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AJZDLWbIr0zt+Y0n6d4ZEaJYNFXWVmWqgramC3gjzT8o7G4YEMjkj8kQ/0gxqb0GgWI1g697ZE2/WQkR+1NEfV94CWBTxZQxCTl6cQoqqzDmFIC/j1vnO/FTb16rNixvBF9dBE6SjRlHuD6Xm8KvYoiCs+wau5ZHEL8gAYOiBug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E3Mr4B3b; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753104940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l/ZhE5NxJbIsjqgp/6zjKREAkCffQHdsRvJCLM+SUFs=;
	b=E3Mr4B3bvCNx6ryrv/wE7RU/xi3loKGp/I2VJy3WRvoV3I4plii28mmmFNCiGcvvFAKQ/s
	vL5dhjxUkXi+UEEAyQ55YNSR47jEOZaTnD4uCqwdcf34+TG9ixYnWnEkSVL9Nrys3sTo6j
	9YEGq6fbF+/5f4RyinTDFVG23neEN6k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-34M-hUgQP0SuSImUvjcCTw-1; Mon, 21 Jul 2025 09:35:39 -0400
X-MC-Unique: 34M-hUgQP0SuSImUvjcCTw-1
X-Mimecast-MFC-AGG-ID: 34M-hUgQP0SuSImUvjcCTw_1753104938
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45611579300so33427645e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 06:35:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753104938; x=1753709738;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l/ZhE5NxJbIsjqgp/6zjKREAkCffQHdsRvJCLM+SUFs=;
        b=aU7sMyUEWDeVj3+Tkxgp8nghh13JBTo3oCcph9fsEe0afMctjMiJ8ZaqP1NIIZzydb
         YDpuPYS4uT2kJWhXlCm1FHirCquUSsj2bdhgmTmUwhqyy9XCLNKROiCua2VBOFX1fg/Z
         GdMY82vS8y4fKYFzLBtj6N2OhGu5AYabDnuimhJg9augIRqyRdVEw5SjzmUwTUOSKZsK
         UPbccjtpBE+EOYtFXUzxGEl2+NRGqBKnCXt7GzOVu6vEZEu9uj2FFNgFqZGLwryW2Bku
         cTw9yeGC8V2CnzvzuFarExyiYhyT53Zx/Uw3AwNpvnD7ovsPfkaWqmW2SRpC45nkoxiJ
         rbkg==
X-Forwarded-Encrypted: i=1; AJvYcCU3TumQkPeT8Zadl+DPxt+yyOqt4sBELVDALWcBwENQs7poczEHwOHwCx/3T/vqR8CiG/xKU5+ktdwdINs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1neiI1K5sSER5g7vD5l8rvYIAYFxjJ7HYPbmAd2C90KRtx1hB
	GSBX9sVC+ZvG92SSFRq9A/8c9V59nx6jNbRNKYVStby2yByy+cbhbUhQH1nZzoEDWgY3930NiW/
	6MT3SXHRTuFdtGIcifsAk7Z11S1+5Q++SfsQvHmXB7hpYGw9CL5ZGRuOmCu8kp5RtLA==
X-Gm-Gg: ASbGncvWQfpIMJEtPI7prE0mIwsP2nysVI8yGk9YN0mw0da/EYEpJEbbsoI+pytLWJQ
	4vCJd5rx0dvEmrAJxiCC0F+tQ029qZdePjVfZL3MmQpt79ddVTb0+Tkzw0VBLOBq+qITd9qQLDY
	rKYjKDZ2s215SxU7oA7b02VLGS5qu7qBrdAvqsezn+OHdJgSNdgUNm6bvMjt+wNZQ6tkjo9pfug
	gaXELfHDsu2wH4TmjH4Pk+6eT1C1bjdvG42dVUu2w8gbeqCNAakfWlxg0CTKybLxP3IXeCA94lS
	iIbd8ldnKpA2eig6HaN2vtxAuOkT2Cdj7FM/xUkGFdjgXGrq16HBqmbho8XvJ6GOND9gug==
X-Received: by 2002:a05:6000:40cc:b0:3b5:f0aa:b1e5 with SMTP id ffacd0b85a97d-3b60e4c21aamr14987263f8f.19.1753104937940;
        Mon, 21 Jul 2025 06:35:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKLxevCXAp/ZaKcZG6IGYm2011Dp/msW7/oCb3X6AMF1wQkf7r2hLAjijhWGwIYKj/zf1bMQ==
X-Received: by 2002:a05:6000:40cc:b0:3b5:f0aa:b1e5 with SMTP id ffacd0b85a97d-3b60e4c21aamr14987236f8f.19.1753104937432;
        Mon, 21 Jul 2025 06:35:37 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.54.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e7f4289sm160704865e9.7.2025.07.21.06.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 06:35:36 -0700 (PDT)
Date: Mon, 21 Jul 2025 15:35:34 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Yuri Andriaccio <yurand2000@gmail.com>
Cc: bsegall@google.com, dietmar.eggemann@arm.com,
	linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
	mgorman@suse.de, mingo@redhat.com, peterz@infradead.org,
	rostedt@goodmis.org, vincent.guittot@linaro.org,
	vschneid@redhat.com, yuri.andriaccio@santannapisa.it
Subject: Re: [BUG] Bw accounting warning on fair-servers' parameters change
Message-ID: <aH5CJgkXuOxYSSmF@jlelli-thinkpadt14gen4.remote.csb>
References: <aHpf4LfMtB2V9uNb@jlelli-thinkpadt14gen4.remote.csb>
 <20250721093442.244074-1-yurand2000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721093442.244074-1-yurand2000@gmail.com>

On 21/07/25 11:34, Yuri Andriaccio wrote:
> Hi,
> 
> On 18/07/25 16:53, Juri Lelli wrote:
> > On 18/07/25 16:22, Juri Lelli wrote:
> > > Hi,
> > >
> > > Thanks for reporting.
> > >
> > > On 18/07/25 13:38, Yuri Andriaccio wrote:
> > > > Hi,
> > > >
> > > > I've been lately working on fair-servers and dl_servers for some patches and
> > > > I've come across a bandwidth accounting warning on the latest tip/master (as of
> > > > 2025-07-18, git sha ed0272f0675f). The warning is triggered by simply starting
> > > > the machine, mounting debugfs and then just zeroing any fair-server's runtime.
> > > >
> > > >
> > > > The warning:
> > > >
> > > > WARNING: kernel/sched/deadline.c:266 at dl_rq_change_utilization+0x208/0x230
> > > > static inline void __sub_rq_bw(u64 dl_bw, struct dl_rq *dl_rq) {
> > > >     ...
> > > > 	WARN_ON_ONCE(dl_rq->running_bw > dl_rq->this_bw);
> > > > }
> > > >
> > > > Steps to reproduce:
> > > >
> > > > mount -t debugfs none /sys/kernel/debug
> > > > echo 0 > /sys/kernel/debug/sched/fair_server/cpu0/runtime
> > > >
> > > >
> > > > It does not happen at every machine boot, but happens on most. Could it possibly
> > > > be related to some of the deadline timers?
> > >
> > > I took a quick first look and currently suspect cccb45d7c4295
> > > ("sched/deadline: Less agressive dl_server handling") could be playing a
> > > role in this as it delays actual server stop.
> > >
> > > Could you please try to repro after having reverted such commit?
> >
> > After that (w/o the revert), could you please try to see if the
> > following helps?
> 
> I've been performing some tests as you asked and indeed the culprit seems to be
> cccb45d7c4295 ("sched/deadline: Less agressive dl_server handling"), as
> reverting it on the current tip removes the issue.
> 
> I've also tested the fix you posted (w/o the reverted commit), and I can confirm
> that the warning does not seem to be triggered anymore.

Thanks!

Sent out a clean-up version

https://lore.kernel.org/lkml/20250721-upstream-fix-dlserver-lessaggressive-b4-v1-1-4ebc10c87e40@redhat.com/


