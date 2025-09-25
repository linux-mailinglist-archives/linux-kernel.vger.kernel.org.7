Return-Path: <linux-kernel+bounces-833050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA7DBA1189
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 20:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 811EB6C1A9E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 18:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A63331B13B;
	Thu, 25 Sep 2025 18:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S1//ztRg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A8A31AF31
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 18:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758826598; cv=none; b=gv7wgft1p1XQ0t7xabrEdspj+rCzPOBFba+rjOAZ1L0C1PZTDpu85JZdPPlGvxPoKKyH/CMbD1kwTYF0D+WOB3yPucMADHkA3jCsvyPXhgxqS5y/CAm9+FvbuaKfOzll5m1OcNhwMlfBD913Yuhyle6onHtjITBX4iUUjJVtaDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758826598; c=relaxed/simple;
	bh=5awjZi6LAQKGTPl9pWzSg2NbxiVJDN/C6wLGHG2Zvhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JCS1lzEyrg40c6frr1ndMylDzG7dmblKEk9AumI5dncad8oplj0m6X7UMYYderr3WWSBtJ1z/U5MZN6j0f45oQZSMHW5znbyt48ZnZ+c3gDgyOjc0X0qnfr/+HPdRT92qpAqlwwFGa95kPNy2TTH2srutrS0MGQ8+IIO0XIs8xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S1//ztRg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758826596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F/Yt2WnuBhEjL/U2P+Vd5YgyHfunjh4/CMHN3cS8jjI=;
	b=S1//ztRgF03b779Qc+ZS+Zm1sh0nqB7oDtNuBDi7SazAzqhX3AgH4qXNnTXPqA7vF4AKBt
	LxN1zm77tpOJMmGiEVR3I3kZi+EgBsN3TR8i4+zDQbKJmJXIJls2DRpp9rY8ruW6mfsYXo
	N38UDU3HJnlS3Ji5tGFFmHKrpiic4rw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-388-9Tq7xlPfNPuX-ZHG7_ohcQ-1; Thu,
 25 Sep 2025 14:56:30 -0400
X-MC-Unique: 9Tq7xlPfNPuX-ZHG7_ohcQ-1
X-Mimecast-MFC-AGG-ID: 9Tq7xlPfNPuX-ZHG7_ohcQ_1758826588
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 04F9A1800378;
	Thu, 25 Sep 2025 18:56:28 +0000 (UTC)
Received: from bfoster (unknown [10.22.64.134])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CBD9B30002D1;
	Thu, 25 Sep 2025 18:56:25 +0000 (UTC)
Date: Thu, 25 Sep 2025 15:00:35 -0400
From: Brian Foster <bfoster@redhat.com>
To: alexjlzheng@gmail.com
Cc: brauner@kernel.org, djwong@kernel.org, hch@infradead.org,
	kernel@pankajraghav.com, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com, Jinliang Zheng <alexjlzheng@tencent.com>
Subject: Re: [PATCH v5 3/4] iomap: make iomap_write_end() return the number
 of written length again
Message-ID: <aNWRUyZhdhX7lzig@bfoster>
References: <20250923042158.1196568-1-alexjlzheng@tencent.com>
 <20250923042158.1196568-4-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923042158.1196568-4-alexjlzheng@tencent.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Sep 23, 2025 at 12:21:57PM +0800, alexjlzheng@gmail.com wrote:
> From: Jinliang Zheng <alexjlzheng@tencent.com>
> 
> In the next patch, we allow iomap_write_end() to conditionally accept
> partial writes, so this patch makes iomap_write_end() return the number
> of accepted write bytes in preparation for the next patch.
> 
> Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
> ---
>  fs/iomap/buffered-io.c | 27 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index e130db3b761e..6e516c7d9f04 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
...
> @@ -915,10 +915,10 @@ static void iomap_write_end_inline(const struct iomap_iter *iter,
>  }
>  
>  /*
> - * Returns true if all copied bytes have been written to the pagecache,
> - * otherwise return false.
> + * Returns number of copied bytes have been written to the pagecache,
> + * zero if block is partial update.
>   */
> -static bool iomap_write_end(struct iomap_iter *iter, size_t len, size_t copied,
> +static int iomap_write_end(struct iomap_iter *iter, size_t len, size_t copied,
>  		struct folio *folio)
>  {
>  	const struct iomap *srcmap = iomap_iter_srcmap(iter);
> @@ -926,7 +926,7 @@ static bool iomap_write_end(struct iomap_iter *iter, size_t len, size_t copied,
>  
>  	if (srcmap->type == IOMAP_INLINE) {
>  		iomap_write_end_inline(iter, folio, pos, copied);
> -		return true;
> +		return copied;
>  	}
>  
>  	if (srcmap->flags & IOMAP_F_BUFFER_HEAD) {
> @@ -934,7 +934,7 @@ static bool iomap_write_end(struct iomap_iter *iter, size_t len, size_t copied,
>  
>  		bh_written = block_write_end(pos, len, copied, folio);
>  		WARN_ON_ONCE(bh_written != copied && bh_written != 0);
> -		return bh_written == copied;
> +		return bh_written;

I notice block_write_end() actually returns an int. Not sure it's an
issue really, but perhaps we should just change the type of bh_written
here as well. Otherwise seems reasonable.

Brian

>  	}
>  
>  	return __iomap_write_end(iter->inode, pos, len, copied, folio);
> @@ -1000,8 +1000,7 @@ static int iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i,
>  			flush_dcache_folio(folio);
>  
>  		copied = copy_folio_from_iter_atomic(folio, offset, bytes, i);
> -		written = iomap_write_end(iter, bytes, copied, folio) ?
> -			  copied : 0;
> +		written = iomap_write_end(iter, bytes, copied, folio);
>  
>  		/*
>  		 * Update the in-memory inode size after copying the data into
> @@ -1315,7 +1314,7 @@ static int iomap_unshare_iter(struct iomap_iter *iter,
>  	do {
>  		struct folio *folio;
>  		size_t offset;
> -		bool ret;
> +		int ret;
>  
>  		bytes = min_t(u64, SIZE_MAX, bytes);
>  		status = iomap_write_begin(iter, write_ops, &folio, &offset,
> @@ -1327,7 +1326,7 @@ static int iomap_unshare_iter(struct iomap_iter *iter,
>  
>  		ret = iomap_write_end(iter, bytes, bytes, folio);
>  		__iomap_put_folio(iter, write_ops, bytes, folio);
> -		if (WARN_ON_ONCE(!ret))
> +		if (WARN_ON_ONCE(ret != bytes))
>  			return -EIO;
>  
>  		cond_resched();
> @@ -1388,7 +1387,7 @@ static int iomap_zero_iter(struct iomap_iter *iter, bool *did_zero,
>  	do {
>  		struct folio *folio;
>  		size_t offset;
> -		bool ret;
> +		int ret;
>  
>  		bytes = min_t(u64, SIZE_MAX, bytes);
>  		status = iomap_write_begin(iter, write_ops, &folio, &offset,
> @@ -1406,7 +1405,7 @@ static int iomap_zero_iter(struct iomap_iter *iter, bool *did_zero,
>  
>  		ret = iomap_write_end(iter, bytes, bytes, folio);
>  		__iomap_put_folio(iter, write_ops, bytes, folio);
> -		if (WARN_ON_ONCE(!ret))
> +		if (WARN_ON_ONCE(ret != bytes))
>  			return -EIO;
>  
>  		status = iomap_iter_advance(iter, &bytes);
> -- 
> 2.49.0
> 
> 


