Return-Path: <linux-kernel+bounces-806152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA574B4927C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 17:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 769907A4BBA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4253730DEB7;
	Mon,  8 Sep 2025 15:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eAsFCECm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946841F0E2E
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 15:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757343996; cv=none; b=Sbhg+NHiuzuwP7jOv0vp4cYxplbghKbmFNDoskS03HbcDs/DwIZTLa0xTvuXH4OUYiU1AVLLeN9V9v+WvnrSrw76w7Kin5VboVgZb7JfUEm06ntoPp/G5iv1yUv71uYKP/RjtErB612M23YSxZ7rFQbsIdOYtXKPkYLlrUQVb+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757343996; c=relaxed/simple;
	bh=Cygn0MzfQ4/mz/3chKiGWsztlEEYq4yMNLW6hLBekQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=utRnZ9EDGdM5KPK1CPcTyPPyCHU9zZuh/Qq+2jZMeNn0RzNpMFDSA0+XOTEjmaRFUJDyYUW1WX+jZR+vaEGnMUJ1ZLQ1OBqXq+4zClnNrbMsFB79dfK4uK38gIWZLzZbWBWg9Be7mNVeDROj5Jj1sNycwlvMTCSRoGiLZHxC8ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eAsFCECm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757343993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=45n0EoG+NugLPzExOpw0q6NkAjxX0oJ2+U+kNdZODK8=;
	b=eAsFCECmdI5Kwk4sQCD+HS84wxC73tQnUt71al/3ufDUqWFRU8LKPPpK0oU9cTeNJGzcdt
	FRfY+nBrRYQD3qsjw2XRp53HJN4aU6hIt6b1VxItwoIiLmhCy7S12shflWiWbefXckVg7l
	qeGr8p7nhM8E4DhXzahRs7DMW4qssHE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-331-Xf-DtVLQPnimMlKeA0rGIw-1; Mon,
 08 Sep 2025 11:06:31 -0400
X-MC-Unique: Xf-DtVLQPnimMlKeA0rGIw-1
X-Mimecast-MFC-AGG-ID: Xf-DtVLQPnimMlKeA0rGIw_1757343982
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F1E37195608B;
	Mon,  8 Sep 2025 15:06:21 +0000 (UTC)
Received: from localhost (unknown [10.72.112.11])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 046491800446;
	Mon,  8 Sep 2025 15:06:19 +0000 (UTC)
Date: Mon, 8 Sep 2025 23:06:15 +0800
From: Baoquan He <bhe@redhat.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>,
	Barry Song <baohua@kernel.org>, Nhat Pham <nphamcs@gmail.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	David Hildenbrand <david@redhat.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Zi Yan <ziy@nvidia.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/15] docs/mm: add document for swap table
Message-ID: <aL7w57kF3CCDGd9e@MiWiFi-R3L-srv>
References: <20250905191357.78298-1-ryncsn@gmail.com>
 <20250905191357.78298-2-ryncsn@gmail.com>
 <aL7NrhGw5ftOXUZs@MiWiFi-R3L-srv>
 <CAMgjq7Bp-buJfH8TPCxBiV80rn=zrvucwHgSCMFuS2BkUWkrJA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMgjq7Bp-buJfH8TPCxBiV80rn=zrvucwHgSCMFuS2BkUWkrJA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 09/08/25 at 10:27pm, Kairui Song wrote:
> On Mon, Sep 8, 2025 at 8:54 PM Baoquan He <bhe@redhat.com> wrote:
> >
> > On 09/06/25 at 03:13am, Kairui Song wrote:
> > > From: Kairui Song <kasong@tencent.com>
> > >
> > > From: Chris Li <chrisl@kernel.org>
> >
> > 'From author <authorkernel.org>' can only be one person, and the co-author
> > should be specified by "Co-developed-by:" and "Signed-off-by:"?
> >
> 
> Hmm, that's interesting, I'm using git send mail with below setup:
> 
> [sendemail]
> from = Kairui Song <ryncsn@gmail.com>
> confirm = auto
> smtpServer = smtp.gmail.com
> smtpServerPort = 587
> smtpEncryption = tls
> smtpUser = ryncsn@gmail.com
> 
> So it will add a "From:" automatically when I'm using gmail's SMTP but
> the patch author doesn't match the sender. It seems git somehow got
> confused by this commit, maybe I used some sending parameters wrongly.

Then you may need to remove the 'from' field of your git [sendemail]
section. If I git am your patch, then the your first 'from' will be the
patch author.

> 
> The author of the doc really should be Chris.
> 


