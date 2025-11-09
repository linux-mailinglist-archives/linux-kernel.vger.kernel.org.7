Return-Path: <linux-kernel+bounces-891928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFF8C43D53
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 13:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5857B4E5BC9
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 12:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1CF2EBDF4;
	Sun,  9 Nov 2025 12:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="blOqM+x9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFBF2EBBB9
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 12:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762690807; cv=none; b=GMGQaWEtqMgxx11egGIhnTWIdDwdJPPOWR8UNTWSMV4cYdMn3OAOPqnIgiRDKCqM7o8asqgll9qjnMydE5T2+wQcet9gDwswnWDxES1+oumbjl/Cmq0X6/ieZbVNyNJRPnevlFS3Fmz7WOp0I+02aT+ZqSfqGa4jrgGMApbFlrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762690807; c=relaxed/simple;
	bh=BtwNUYyMtkKVBobof0xuLKkDSYk5rO6NJeNX4AhfYyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BJ0GeCrdDf4QcUJJN0D0T7K+RJ08U6Yg3X4tccMx7l0gDfyKRtzJRczGQIEgLXkHRJrGxzN7C5AjI0bWNfQH3+1yqzORxZUmKpEq2shOnGqU+DhaRIgPymLHjJUUwT3PzT84gdMwdOpFbeMX2WAaab5rNmcfRHxZf6lCPQTuonQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=blOqM+x9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762690804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l0ZU+iBTTUw5olZrRzf+qb/pbO+mX7P5xruykc73XyI=;
	b=blOqM+x94pkc3XFroyyvRE0C0s4g7gGte8oH8oCsvmHTIJTK4ruR4wks5m443u8xSRRISI
	rDdhRR7zRv55bRzI90nYhhs95surcHlAZ8skCv/jodJWgcg3FFyzUdG+SDrmNKEZimnLiU
	OQdpa+r/IqCeEANOkpLHCvxPBogvoBE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-516-XC4XW8GHM_mpPycP9NT0kA-1; Sun,
 09 Nov 2025 07:19:59 -0500
X-MC-Unique: XC4XW8GHM_mpPycP9NT0kA-1
X-Mimecast-MFC-AGG-ID: XC4XW8GHM_mpPycP9NT0kA_1762690798
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DCE7D1956088;
	Sun,  9 Nov 2025 12:19:57 +0000 (UTC)
Received: from fedora (unknown [10.72.116.19])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B18B530001B9;
	Sun,  9 Nov 2025 12:19:50 +0000 (UTC)
Date: Sun, 9 Nov 2025 20:19:40 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] loop: use blk_rq_nr_phys_segments() instead of
 iterating bvecs
Message-ID: <aRCG3OUThPCys92r@fedora>
References: <20251108230101.4187106-1-csander@purestorage.com>
 <20251108230101.4187106-2-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251108230101.4187106-2-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Sat, Nov 08, 2025 at 04:01:00PM -0700, Caleb Sander Mateos wrote:
> The number of bvecs can be obtained directly from struct request's
> nr_phys_segments field via blk_rq_nr_phys_segments(), so use that
> instead of iterating over the bvecs an extra time.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> ---
>  drivers/block/loop.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 13ce229d450c..8096478fad45 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -346,16 +346,13 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
>  	struct request *rq = blk_mq_rq_from_pdu(cmd);
>  	struct bio *bio = rq->bio;
>  	struct file *file = lo->lo_backing_file;
>  	struct bio_vec tmp;
>  	unsigned int offset;
> -	int nr_bvec = 0;
> +	unsigned short nr_bvec = blk_rq_nr_phys_segments(rq);
>  	int ret;
>  
> -	rq_for_each_bvec(tmp, rq, rq_iter)
> -		nr_bvec++;
> -

The two may not be same, since one bvec can be splitted into multiple segments.

Thanks,
Ming


