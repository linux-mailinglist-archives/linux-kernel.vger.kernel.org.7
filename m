Return-Path: <linux-kernel+bounces-883312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFD7C2D091
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 17:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AC4EB34A373
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 16:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55E9286889;
	Mon,  3 Nov 2025 16:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YAvg0woH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC299313E13
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 16:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762186541; cv=none; b=apjM/S7yAZAL4gaOtL+moApenJQiRtDXuQocqkZ/Zc819Kyh2CfAm3+kE6ZQNdk6La5XUJaWInJUhQL67hCriMCW1BC3+xx1iOrWyr7rF+QDfzIEAPP6/HVgU+SSasV+tlzzBxNjqvzGu/XLmnOubfPCb6Dl33KEIrts5VcaxTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762186541; c=relaxed/simple;
	bh=ZR/sDYjpQKF1CKDhKCs09dp9eEQwFbA38q7Jicq8e4A=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gb44R4oKuFxwbsDa7PZHai8JEjmeZmn5ToI+ko4Fi/8SE7Anw/iKoCmDInP4FaTJIqiu0uKE8CE81PsbnGvPT6HxsznfQYKFjyUw1tiZB3U2zkP1DhGa050n7fADVIaoEYzkwIFwGruhDq3vM1yRPqBPZn1I+Rxs45/YGGN98f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YAvg0woH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762186538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ajIoHf0YZl85cHlPMn5BAk8HERcqnQT0DKHhQNq20Ew=;
	b=YAvg0woHbyXe/N4W6eJLb8iTenBrLjmGxKBddZNrTGnbSIrTxTGJbnMhmBn9QAIg5srTqy
	j4FnLypF3yIRuj0xM4UrgYaD8jghvyW3TczGqw5LpWQj4u2np91c5XGBjXUDl5KJ5OdnrB
	QXgM8GIzxQt9KWRYchBlgYyO9OvmidM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-253-J4O6Lz9jNx6t4iBepiByAw-1; Mon,
 03 Nov 2025 11:15:35 -0500
X-MC-Unique: J4O6Lz9jNx6t4iBepiByAw-1
X-Mimecast-MFC-AGG-ID: J4O6Lz9jNx6t4iBepiByAw_1762186534
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 55FBC18094C1;
	Mon,  3 Nov 2025 16:15:34 +0000 (UTC)
Received: from [10.45.225.163] (unknown [10.45.225.163])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6866619560A2;
	Mon,  3 Nov 2025 16:15:32 +0000 (UTC)
Date: Mon, 3 Nov 2025 17:15:29 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Jon Hunter <jonathanh@nvidia.com>
cc: Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
    Tushar Sugandhi <tusharsu@linux.microsoft.com>, dm-devel@lists.linux.dev, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dm: Don't warn if IMA_DISABLE_HTABLE is not enabled
In-Reply-To: <20251031153455.1057431-1-jonathanh@nvidia.com>
Message-ID: <60f0e17e-0d2a-e6b7-289d-84f7dac65a34@redhat.com>
References: <20251031153455.1057431-1-jonathanh@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Accepted, thanks.

Mikulas


On Fri, 31 Oct 2025, Jon Hunter wrote:

> Commit f1cd6cb24b6b ("dm ima: add a warning in dm_init if duplicate ima
> events are not measured") added a warning message if CONFIG_IMA is
> enabled but CONFIG_IMA_DISABLE_HTABLE is not to inform users. When
> enabling CONFIG_IMA, CONFIG_IMA_DISABLE_HTABLE is disabled by default
> and so warning is seen. Therefore, it seems more appropriate to make
> this an INFO level message than warning. If this truly is a warning,
> then maybe CONFIG_IMA_DISABLE_HTABLE should default to y if CONFIG_IMA
> is enabled.
> 
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
> We have some tests that check for kernel warnings and whenever we
> stumbled across a new warning we see if there is a way to fix it.
> For this one it seems a bit odd to always warn for something that
> defaults to disabled. If necessary we can ignore it, but I wanted
> to see if this would be acceptable first.
> 
>  drivers/md/dm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index bff3ab4a3bd8..557f3f52edf4 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -272,7 +272,7 @@ static int __init dm_init(void)
>  	int r, i;
>  
>  #if (IS_ENABLED(CONFIG_IMA) && !IS_ENABLED(CONFIG_IMA_DISABLE_HTABLE))
> -	DMWARN("CONFIG_IMA_DISABLE_HTABLE is disabled."
> +	DMINFO("CONFIG_IMA_DISABLE_HTABLE is disabled."
>  	       " Duplicate IMA measurements will not be recorded in the IMA log.");
>  #endif
>  
> -- 
> 2.43.0
> 


