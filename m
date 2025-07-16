Return-Path: <linux-kernel+bounces-732990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD62B06E81
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 09:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFAA37A8216
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 07:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E8E289E16;
	Wed, 16 Jul 2025 07:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DbQm/y+R"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD3110A1E
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 07:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752649803; cv=none; b=uL8qXNTPA0EgR6vToCNf1gEQiFtTCN8og+AIHGX7DpoJHwwDgr8L8lcrbFKjDHznTlpxWC4F6NzIZx16JbWGqVBLRFyJk2IR7aJ9EjAglwBlLxKSV/fsQiRIV+pHc2bRLz0FVHuAp3aZErxXq7ehR9UiRvO2IQwR7sAo6UzhvNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752649803; c=relaxed/simple;
	bh=pbzwr583kv2Kv3frGIlUuk0d2ZEJA9N61Pp8J8V7T/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+PS8wMy27rUIhQDlUQ+ihOUlXxKKxIuVvzkbO9nmcw6YAOYO6hQfTkMLOqvI1QXhUWN34fAfPa/Ny7IgCHxEX1y0dxOLYwbfp0wuHbPpVdE6iqDGd8KBph5vFlopZlD6mG2HluPlp1gY28ZY5xvjdckhLcI1ieSKMSOH9tTyWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DbQm/y+R; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752649800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QkrGeaLtfkyhuYs4DJLfNNM1RGd1ZIds2xpUAYiTE04=;
	b=DbQm/y+RSgoq7b9dxf7cFn8Cx7kigyoznxxUEnK5BfCJ+q1LVthfRXZqEPwlLg76ZKewB0
	QiYljLJ/Qlz1nAid6bIjRs1wIy9Y1/3kRRWHwlRvd8veUu+wAeQACIJz7rK7u4+r2BaLQ8
	VZ+uHudiRKYk3a3Fye35o51kWTlX5IY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-122-90ItctHzNwyXJ70pwng09A-1; Wed,
 16 Jul 2025 03:09:57 -0400
X-MC-Unique: 90ItctHzNwyXJ70pwng09A-1
X-Mimecast-MFC-AGG-ID: 90ItctHzNwyXJ70pwng09A_1752649795
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AAC131800C31;
	Wed, 16 Jul 2025 07:09:53 +0000 (UTC)
Received: from localhost (unknown [10.72.112.156])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C04D118002AF;
	Wed, 16 Jul 2025 07:09:51 +0000 (UTC)
Date: Wed, 16 Jul 2025 15:09:47 +0800
From: Baoquan He <bhe@redhat.com>
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Matthew Wilcox <willy@infradead.org>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Chris Li <chrisl@kernel.org>, Nhat Pham <nphamcs@gmail.com>,
	Barry Song <baohua@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/8] mm/shmem, swap: tidy up swap entry splitting
Message-ID: <aHdQO/SN9MUL5/Bk@MiWiFi-R3L-srv>
References: <20250710033706.71042-1-ryncsn@gmail.com>
 <20250710033706.71042-5-ryncsn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710033706.71042-5-ryncsn@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 07/10/25 at 11:37am, Kairui Song wrote:
......snip...
> @@ -2321,46 +2323,35 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
>  		}
>  
>  		/*
> -		 * Now swap device can only swap in order 0 folio, then we
> -		 * should split the large swap entry stored in the pagecache
> -		 * if necessary.
> -		 */
> -		split_order = shmem_split_large_entry(inode, index, swap, gfp);
> -		if (split_order < 0) {
> -			error = split_order;
> -			goto failed;
> -		}
> -
> -		/*
> -		 * If the large swap entry has already been split, it is
> +		 * Now swap device can only swap in order 0 folio, it is
>  		 * necessary to recalculate the new swap entry based on
> -		 * the old order alignment.
> +		 * the offset, as the swapin index might be unalgined.
>  		 */
> -		if (split_order > 0) {
> -			pgoff_t offset = index - round_down(index, 1 << split_order);
> -
> +		if (order) {
> +			offset = index - round_down(index, 1 << order);
>  			swap = swp_entry(swp_type(swap), swp_offset(swap) + offset);
>  		}
>  
> -		/* Here we actually start the io */
>  		folio = shmem_swapin_cluster(swap, gfp, info, index);
>  		if (!folio) {
>  			error = -ENOMEM;
>  			goto failed;
>  		}
> -	} else if (order > folio_order(folio)) {
> +	}
> +alloced:

Here, only synchronous device handling will jump to label 'alloced', while
its folio is allocated with order. Maybe we should move the label down 
below these if else conditional checking and handling?

Anyway, this is an intermediary patch and code will be changed, not strong
opinion.

> +	if (order > folio_order(folio)) {
>  		/*
> -		 * Swap readahead may swap in order 0 folios into swapcache
> +		 * Swapin may get smaller folios due to various reasons:
> +		 * It may fallback to order 0 due to memory pressure or race,
> +		 * swap readahead may swap in order 0 folios into swapcache
>  		 * asynchronously, while the shmem mapping can still stores
>  		 * large swap entries. In such cases, we should split the
>  		 * large swap entry to prevent possible data corruption.
>  		 */
> -		split_order = shmem_split_large_entry(inode, index, swap, gfp);
> +		split_order = shmem_split_large_entry(inode, index, index_entry, gfp);
>  		if (split_order < 0) {
> -			folio_put(folio);
> -			folio = NULL;
>  			error = split_order;
> -			goto failed;
> +			goto failed_nolock;
>  		}
>  
>  		/*
...snip...


