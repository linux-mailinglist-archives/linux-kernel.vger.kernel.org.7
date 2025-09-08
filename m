Return-Path: <linux-kernel+bounces-805804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DD1B48DA5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CD6D7A62A8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 12:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8085E2FE079;
	Mon,  8 Sep 2025 12:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wd5F5txa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD50221F26
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 12:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757334974; cv=none; b=lrXm6i7xQMg+xtCZjhKbk18vwbEHjEzv8bSiERJDdLIA2vqGqYpNnTJH6K51Xn/xXBoUie5FnFQzz5QJ6RgXheruiD55mMQEqu9gqjSP/DP1HQxVp3aqRN+hNkdricqCM0N0x0+APSSTS0MOomjNJcKcrd4VxrNrTCNTrXb3nkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757334974; c=relaxed/simple;
	bh=pLIko1F8AdP5K1bUSv4JLW9AWnUwO4YwD5dni8f5yWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OmQJU3w0qo2Cu98zMcBGF4hY0ciUqQuRd5DMKMpy5e35rqDRuqxv6o3KcL3A2DsYFuUnD8kWcUoNkzoK5fPy7ETHhhj4tz86AngBSEm/LfhE9nY74HHso49plESwhfp2kMtEGXZRIu1ELicifCsbFZdPZledxHnK9o94LF/8nU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wd5F5txa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757334972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5AXKbYRLtxYcNR1yut317zhnZdWEsk0ARZGAWBOW04Y=;
	b=Wd5F5txac/D3AjWdk1pqB6rYLNa+S65gbg7XTyFXZkZF2a3gmWEJlnRRs0GKQxtf99Zetz
	LqMZz6Qi9PKJUlvUGEtmyC0wuBre25zCl3JAP4Y3rybnj2K2WeQh5jfVO6ocVekeVwI0mO
	JRHO/FPC2W0u2gGXDJ7BZJEcEwVCLKc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-KKEbFsUPNfS8HxQ-yvFc0Q-1; Mon,
 08 Sep 2025 08:36:08 -0400
X-MC-Unique: KKEbFsUPNfS8HxQ-yvFc0Q-1
X-Mimecast-MFC-AGG-ID: KKEbFsUPNfS8HxQ-yvFc0Q_1757334966
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7C2CD19560AD;
	Mon,  8 Sep 2025 12:36:05 +0000 (UTC)
Received: from localhost (unknown [10.72.112.11])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CF1C518003FC;
	Mon,  8 Sep 2025 12:36:02 +0000 (UTC)
Date: Mon, 8 Sep 2025 20:35:58 +0800
From: Baoquan He <bhe@redhat.com>
To: Kairui Song <kasong@tencent.com>
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
Message-ID: <aL7NrhGw5ftOXUZs@MiWiFi-R3L-srv>
References: <20250905191357.78298-1-ryncsn@gmail.com>
 <20250905191357.78298-2-ryncsn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905191357.78298-2-ryncsn@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 09/06/25 at 03:13am, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> From: Chris Li <chrisl@kernel.org>

'From author <authorkernel.org>' can only be one person, and the co-author
should be specified by "Co-developed-by:" and "Signed-off-by:"?

> 
> Swap table is the new swap cache.
> 
> Signed-off-by: Chris Li <chrisl@kernel.org>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  Documentation/mm/swap-table.rst | 72 +++++++++++++++++++++++++++++++++
>  MAINTAINERS                     |  1 +
>  2 files changed, 73 insertions(+)
>  create mode 100644 Documentation/mm/swap-table.rst
> 
> diff --git a/Documentation/mm/swap-table.rst b/Documentation/mm/swap-table.rst
> new file mode 100644
> index 000000000000..929cd91aa984
> --- /dev/null
> +++ b/Documentation/mm/swap-table.rst
> @@ -0,0 +1,72 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +:Author: Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>
> +
> +==========
> +Swap Table
> +==========
> +
> +Swap table implements swap cache as a per-cluster swap cache value array.
> +
> +Swap Entry
> +----------
> +
> +A swap entry contains the information required to serve the anonymous page
> +fault.
> +
> +Swap entry is encoded as two parts: swap type and swap offset.
> +
> +The swap type indicates which swap device to use.
> +The swap offset is the offset of the swap file to read the page data from.
> +
> +Swap Cache
> +----------
> +
> +Swap cache is a map to look up folios using swap entry as the key. The result
> +value can have three possible types depending on which stage of this swap entry
> +was in.
> +
> +1. NULL: This swap entry is not used.
> +
> +2. folio: A folio has been allocated and bound to this swap entry. This is
> +   the transient state of swap out or swap in. The folio data can be in
> +   the folio or swap file, or both.
> +
> +3. shadow: The shadow contains the working set information of the swap
> +   outed folio. This is the normal state for a swap outed page.
> +
> +Swap Table
> +----------
> +
> +The previous swap cache is implemented by XAray. The XArray is a tree
> +structure. Each lookup will go through multiple nodes. Can we do better?
> +
> +Notice that most of the time when we look up the swap cache, we are either
> +in a swap in or swap out path. We should already have the swap cluster,
> +which contains the swap entry.
> +
> +If we have a per-cluster array to store swap cache value in the cluster.
> +Swap cache lookup within the cluster can be a very simple array lookup.
> +
> +We give such a per-cluster swap cache value array a name: the swap table.
> +
> +Each swap cluster contains 512 entries, so a swap table stores one cluster
> +worth of swap cache values, which is exactly one page. This is not
> +coincidental because the cluster size is determined by the huge page size.
> +The swap table is holding an array of pointers. The pointer has the same
> +size as the PTE. The size of the swap table should match to the second
> +last level of the page table page, exactly one page.
> +
> +With swap table, swap cache lookup can achieve great locality, simpler,
> +and faster.
> +
> +Locking
> +-------
> +
> +Swap table modification requires taking the cluster lock. If a folio
> +is being added to or removed from the swap table, the folio must be
> +locked prior to the cluster lock. After adding or removing is done, the
> +folio shall be unlocked.
> +
> +Swap table lookup is protected by RCU and atomic read. If the lookup
> +returns a folio, the user must lock the folio before use.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ec19be6c9917..1c8292c0318d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16219,6 +16219,7 @@ R:	Barry Song <baohua@kernel.org>
>  R:	Chris Li <chrisl@kernel.org>
>  L:	linux-mm@kvack.org
>  S:	Maintained
> +F:	Documentation/mm/swap-table.rst
>  F:	include/linux/swap.h
>  F:	include/linux/swapfile.h
>  F:	include/linux/swapops.h
> -- 
> 2.51.0
> 


