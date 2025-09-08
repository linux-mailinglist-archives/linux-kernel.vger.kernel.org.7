Return-Path: <linux-kernel+bounces-806159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC12AB4929A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 17:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47B6C3A4BE2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D0A3054FE;
	Mon,  8 Sep 2025 15:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DL2sZetd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4781F0E2E
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 15:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757344179; cv=none; b=CxrSbtjKGojhM8G0+Jpi2WQuo9W0eSXraFjiRlCLGUMYr0zHAGgqcilPDbMihmG2BJEckxlOgvdsKeegTwbAfZI/06K0pS/m76+4GjPOS3BXTA9iXXVVsWXlz55xdku79N/TOG2fnRftJuVMyCgqth9DOznX5oWljK6Oa9n03Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757344179; c=relaxed/simple;
	bh=IujjedwxqoC+IlQZCfHC7SQgOECGmWiYfazPxVnYZN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uw6nYEyy84EjtkZHHxq4hOKBjd96pkjNUn9aarzBBaUumbdhYkhVod60zWnsZmjDhHHkqO7Yl5oTQo+OSnAdU9a4xwax/9QQ7vuSroerBiQaXmis86Ed+CqUQ1ZbwxC8cAcNCihlJn0O0ll++ouK2whw6fxRf5iM3M2RBnnrhXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DL2sZetd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757344177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=heQQ3Ud2LMh6YOFJjpOWIBQv+t67vvA52HA8Ei7ieDs=;
	b=DL2sZetdOPz21Jfbpdb3ubXW5apvQzOPOnqyrnvs2QLLTTwO8dMdzEy6Umi5Q4TemT1Mrt
	2YYCr6sJ6WiRV0OdSc6DgSzrGKD3YbmQsd/oV0VtvKdRhzohuGDHnyZ+zsX62r6CnXDgLz
	uyV71ZROnM+CaFgJA2Gle7c4o0HeEjU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453-mbUoeq_OML650TvnQs5P0Q-1; Mon,
 08 Sep 2025 11:09:32 -0400
X-MC-Unique: mbUoeq_OML650TvnQs5P0Q-1
X-Mimecast-MFC-AGG-ID: mbUoeq_OML650TvnQs5P0Q_1757344170
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D324D19560AE;
	Mon,  8 Sep 2025 15:09:29 +0000 (UTC)
Received: from localhost (unknown [10.72.112.11])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E389D1800451;
	Mon,  8 Sep 2025 15:09:26 +0000 (UTC)
Date: Mon, 8 Sep 2025 23:09:22 +0800
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
Subject: Re: [PATCH v2 01/15] docs/mm: add document for swap table
Message-ID: <aL7xoiTacg0vCLjz@MiWiFi-R3L-srv>
References: <20250905191357.78298-1-ryncsn@gmail.com>
 <20250905191357.78298-2-ryncsn@gmail.com>
 <aL7NrhGw5ftOXUZs@MiWiFi-R3L-srv>
 <CACePvbXi3Avsic62fMdhLaDfiq4LS_t8-wbm9yQnEkScoxYO-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACePvbXi3Avsic62fMdhLaDfiq4LS_t8-wbm9yQnEkScoxYO-g@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 09/08/25 at 08:01am, Chris Li wrote:
> On Mon, Sep 8, 2025 at 5:36 AM Baoquan He <bhe@redhat.com> wrote:
> >
> > On 09/06/25 at 03:13am, Kairui Song wrote:
> > > From: Kairui Song <kasong@tencent.com>
> > >
> > > From: Chris Li <chrisl@kernel.org>
> >
> > 'From author <authorkernel.org>' can only be one person, and the co-author
> > should be specified by "Co-developed-by:" and "Signed-off-by:"?
> 
> That is the artifact of sending another person's patch in a series.
> The first "From" is from the email header sender. The second "from" is
> the real author of the patch. Just like an IP tunnel packet there is
> another inner IP packet wrapped in the outer IP packet.
> 
> I think that is all normal and did not violate the kernel rules. When
> I include Kairui's patch in my swap allocator series. The same thing
> happened there on Kairui's patch. In the end the git will know enough
> who is the real author, because those patches are  outputted by git
> anyway.

Hmm, maybe git doesn't work like that. I applied this patch via git am,
I got this on my local branch. The 2nd 'From' become part of commit log.

commit 337b3cd6c0ffad355df8851414e8aa5be052f4cb (HEAD -> kasan-v3)
Author: Kairui Song <kasong@tencent.com>
Date:   Sat Sep 6 03:13:43 2025 +0800

    docs/mm: add document for swap table
    
    From: Chris Li <chrisl@kernel.org>
    
    Swap table is the new swap cache.
    
    Signed-off-by: Chris Li <chrisl@kernel.org>
    Signed-off-by: Kairui Song <kasong@tencent.com>


