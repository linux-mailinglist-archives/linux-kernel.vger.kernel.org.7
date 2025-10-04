Return-Path: <linux-kernel+bounces-841936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F8FBB8902
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 05:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 95B154E4EC6
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 03:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608A91DE4C9;
	Sat,  4 Oct 2025 03:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BY6S9U9I"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F272F1494C2
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 03:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759550009; cv=none; b=dday0UDGesRrmEieFFXTV1R5GVyzv2oIPREdy10S6iJ+JvNdyOqJQJJvuPjz/9aLVsVzrjqkIBQYMJe7kJQnKrLULQNuJP2lyGwWPWV/EC/oEPgeOck68pvx7jn3VZ0XLejOZVClzkKiVFz8i6iua6nD6Fk8g0IKh736I8Vop5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759550009; c=relaxed/simple;
	bh=7tOOxBvzmfxrhJdFTP7IMW/lLHp6cWnh5lgvo0EbpJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oin8j7W50/nHCp91uBkDx96GtAE0bgRrMBGNFNk9liEFApy2/NRsgXrXIOBnN26NhTCe/dNmqKDtNQS0lxDgY2BRVBH0BmQzqJpfm3TSir3e6hJVGM63hVtIxDXq8I537kIuA4PeSxF4B4IhVTo5SUls3MV+e+jP0B14TWFEZac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BY6S9U9I; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759550006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RkIIvUaLniZLbjXm3aa4rhHDrqBDy6A0FmYdyH6k/vQ=;
	b=BY6S9U9IDqn0JCSDT1/o5AnQCGycVCXTkbvrPNEJzAokWYvGNepdQEiPP36XWTQx/Z3lZE
	chE5Kjen2C7LprWAu2sKVSLCqnLlroKct7ugWWbIAVb9GGfkTdy9513NVjegAEMG+N3RuF
	QxZvx2wHkpugHcZfkx5OfJGrOsWXQ+o=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-681-QF8grObeOseX5QEeRE4MtA-1; Fri,
 03 Oct 2025 23:53:23 -0400
X-MC-Unique: QF8grObeOseX5QEeRE4MtA-1
X-Mimecast-MFC-AGG-ID: QF8grObeOseX5QEeRE4MtA_1759550002
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1FBAC1800451;
	Sat,  4 Oct 2025 03:53:22 +0000 (UTC)
Received: from localhost (unknown [10.72.112.27])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8772819560B1;
	Sat,  4 Oct 2025 03:53:20 +0000 (UTC)
Date: Sat, 4 Oct 2025 11:53:16 +0800
From: Baoquan He <bhe@redhat.com>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v3 08/10] mm: Skip might_alloc() warnings when
 PF_MEMALLOC is set
Message-ID: <aOCaLNKZcC37w7ok@MiWiFi-R3L-srv>
References: <20251001192647.195204-1-urezki@gmail.com>
 <20251001192647.195204-9-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001192647.195204-9-urezki@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 10/01/25 at 09:26pm, Uladzislau Rezki (Sony) wrote:
> might_alloc() catches invalid blocking allocations in contexts
> where sleeping is not allowed.
> 
> However when PF_MEMALLOC is set, the page allocator already skips
> reclaim and other blocking paths. In such cases, a blocking gfp_mask
> does not actually lead to blocking, so triggering might_alloc() splats
> is misleading.
> 
> Adjust might_alloc() to skip warnings when the current task has
> PF_MEMALLOC set, matching the allocator's actual blocking behaviour.
> 
> Acked-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  include/linux/sched/mm.h | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Baoquan He <bhe@redhat.com>

> 
> diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
> index 0232d983b715..a74582aed747 100644
> --- a/include/linux/sched/mm.h
> +++ b/include/linux/sched/mm.h
> @@ -318,6 +318,9 @@ static inline void might_alloc(gfp_t gfp_mask)
>  	fs_reclaim_acquire(gfp_mask);
>  	fs_reclaim_release(gfp_mask);
>  
> +	if (current->flags & PF_MEMALLOC)
> +		return;
> +
>  	might_sleep_if(gfpflags_allow_blocking(gfp_mask));
>  }
>  
> -- 
> 2.47.3
> 


