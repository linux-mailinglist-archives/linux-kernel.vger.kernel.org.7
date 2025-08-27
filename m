Return-Path: <linux-kernel+bounces-788990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C37F3B38F5A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 01:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C65D91C24083
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 23:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0EA623D7EC;
	Wed, 27 Aug 2025 23:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ferPd0sQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859227260A
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 23:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756338398; cv=none; b=h7FgTaeVvIDCVUFdAO2+la9CO3T4LA9NUQSLgZ/dZS7Glo7UTTZ8SL3d8YVT1zsRLRbnqTt4nes7T+A9G4BZ2otPHWZj5S5D2KLKpFLGOaQO6A+Q7eEcJfbqWkhjBTAl1xNQQwEetUfqNlPA1NDls4NUm9Xm7NBfkSG0TtniQls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756338398; c=relaxed/simple;
	bh=NSEz2Gsq2659Evjda+c7nmwkt2zUQgrHmtnu4V+HBW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H2Zc0LFqAC63Kg4WU8DHh6LjiB3V+IgN+3uyAH+B9WE2FYLPwTxUZfNEAfe/OYH0XlDxCCZmV6frlvCkkLenyjnkQAaOV5oHSUpYIHrYdFz8fLEpVj4FOnTvlVebxVZKO20SBMH/w9qVSdKvwYCWwSB7a25Pe5Kwpgor419KdoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ferPd0sQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756338395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P5F8gpBz7t5sMa3hnf8LHIFEhCjAdRv+NiEXkMZszlQ=;
	b=ferPd0sQAEpOpQXdDmjdKuAnHpTJDV4DEXGcjj3MZEKMiUuVt0Bg/xxrrgPedm3MD5WIm7
	wDgQDXf4dZqnxAxGtzsFeEinuDekZ3TDaSEpc6YGkxiJALixaFlIJcoGnXEydBOgT2zoyf
	URHaAK20t+w59PaA+oSZNcXN5/C3kK8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-KQYxMOZTN466KSj7S-_7Ag-1; Wed,
 27 Aug 2025 19:46:32 -0400
X-MC-Unique: KQYxMOZTN466KSj7S-_7Ag-1
X-Mimecast-MFC-AGG-ID: KQYxMOZTN466KSj7S-_7Ag_1756338390
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 01E541800366;
	Wed, 27 Aug 2025 23:46:29 +0000 (UTC)
Received: from localhost (unknown [10.72.112.154])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 29DA91800446;
	Wed, 27 Aug 2025 23:46:25 +0000 (UTC)
Date: Thu, 28 Aug 2025 07:46:21 +0800
From: Baoquan He <bhe@redhat.com>
To: Chris Li <chrisl@kernel.org>
Cc: Kairui Song <kasong@tencent.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Hugh Dickins <hughd@google.com>, Barry Song <baohua@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	David Hildenbrand <david@redhat.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Zi Yan <ziy@nvidia.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/9] mm, swap: tidy up swap device and cluster info
 helpers
Message-ID: <aK+YzeWToVUX3WOY@MiWiFi-R3L-srv>
References: <20250822192023.13477-1-ryncsn@gmail.com>
 <20250822192023.13477-5-ryncsn@gmail.com>
 <aK5/1so7a0i80+dz@MiWiFi-R3L-srv>
 <CACePvbU8pnjWCiWcSXRr4UdpuD_wdtrouLMz_fNB_=KRrdHLmQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACePvbU8pnjWCiWcSXRr4UdpuD_wdtrouLMz_fNB_=KRrdHLmQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 08/27/25 at 10:44am, Chris Li wrote:
> On Tue, Aug 26, 2025 at 8:47 PM Baoquan He <bhe@redhat.com> wrote:
> >
> > On 08/23/25 at 03:20am, Kairui Song wrote:
> > ......
> > > diff --git a/mm/swap.h b/mm/swap.h
> > > index 223b40f2d37e..7b3efaa51624 100644
> > > --- a/mm/swap.h
> > > +++ b/mm/swap.h
> > > @@ -15,6 +15,8 @@ extern int page_cluster;
> > >  #define swap_entry_order(order)      0
> > >  #endif
> > >
> > > +extern struct swap_info_struct *swap_info[];
> > > +
> > >  /*
> > >   * We use this to track usage of a cluster. A cluster is a block of swap disk
> > >   * space with SWAPFILE_CLUSTER pages long and naturally aligns in disk. All
> > > @@ -53,9 +55,28 @@ enum swap_cluster_flags {
> > >  #include <linux/swapops.h> /* for swp_offset */
> > >  #include <linux/blk_types.h> /* for bio_end_io_t */
> > >
> > > +/*
> > > + * Callers of all swp_* helpers here must ensure the entry is valid, and
> > > + * pin the swap device by reference or in other ways.
> > > + */
> > > +static inline struct swap_info_struct *swp_type_info(int type)
> > > +{
> > > +     struct swap_info_struct *si;
> > > +
> > > +     si = READ_ONCE(swap_info[type]); /* rcu_dereference() */
> > > +     VM_WARN_ON_ONCE(percpu_ref_is_zero(&si->users)); /* race with swapoff */
> > > +     return si;
> > > +}
> > > +
> > > +static inline struct swap_info_struct *swp_info(swp_entry_t entry)
> > > +{
> > > +     return swp_type_info(swp_type(entry));
> > > +}
> >
> > swp_type_info() is only used by swp_info() in the whole series, can we
> > open code it in swp_info()?
> 
> BTW, off topic here. I really don't like the "_info" suffix. Anything
> you can put into a C struct by definition is some kind of information.
> Same to the _struct. Anything defined by a struct is a struct. Don't
> need to say that.
> The "struct swap_info_struct" gets two of the unnecessary words. It
> should be something like  "struct swap_file" or "struct swap_device".
> Renaming it is too invasive to the code base and it will mess up the
> git annotation history.

I agree. I searched for _info_struct in the current code, only found
swap_info_struct, ax25_info_struct, vm86plus_info_struct. The latter two
are seen in very few LOC. Maybe we can rename it later when things are all
done. And 'struct swap_cluster_info' too.


