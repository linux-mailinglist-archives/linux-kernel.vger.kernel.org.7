Return-Path: <linux-kernel+bounces-831352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A42B9C6E8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 625961BC15F0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B227927FD6E;
	Wed, 24 Sep 2025 23:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eDCUt4IS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9A835957
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758754974; cv=none; b=QfxoFupBgaTjrbs8dDd3SUNEpaniHrluzqZCCf6Su9knZzClhj1ERfVMoH7OnukrBU490HJHmi7YKFfcFz5+/4Jyn0KOZrjUn+71bs0/fzc4gRWORPFcItsPIN783lrGoDkvkH/bBMApN7yqhfx/A05pVeAsV15XC11nOI+4VEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758754974; c=relaxed/simple;
	bh=WL1YIeZxrOhfyEJEdvA3ieauQEgRVeScvPkQdXGhVWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lXorShNLuvDnBDjeER5fAR7YM30HPPjjBkYTTEV3NEyo7KnR5x0ADn8wtJju/zu/Te/Nep4NtMD2AQT5ifKYr60y0mG1EPU3Ip85qkQO66oL82eVpw3F2MwnRldHOsBm0hpG7twlqGD5L2qDA6e70tAwfvN58vCW9ev7dEAOSFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eDCUt4IS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36C51C4CEE7;
	Wed, 24 Sep 2025 23:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758754973;
	bh=WL1YIeZxrOhfyEJEdvA3ieauQEgRVeScvPkQdXGhVWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eDCUt4ISdcKLqRhChVQuATgGVDG9Iu7chqvIJwl0FQIScgIdT/C/E/IdW5S1pC+qo
	 H6Lm8CUHGJTIsIeaDLf1aRrL7uzkeQd2vky5g2cT6AmytuMrrgb1142qIyooRD+Hza
	 6vtL/nFqevylvyn6ofsLMb9/US5bbLEMzIQneveP4I/XKlS6ERpgSZ1saHQRRpvlDb
	 Bu9myQlpp45lLNUQjhCruSXnYU1eGlVldBY9f02/VF4j9iv9XARlMcfZ/KQV2Er4Oy
	 XmEhH3y3ndzO4CNMFSpSZD5qbLq8E0ldO5P5sBiiJxAHRqVoUymORQQa10GC2gECa+
	 d715yui9TN66w==
Date: Wed, 24 Sep 2025 17:02:51 -0600
From: Keith Busch <kbusch@kernel.org>
To: Amit Chaudhary <achaudhary@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, mkhalfella@purestorage.com,
	randyj@purestorage.com, jmeneghi@redhat.com, emilne@redhat.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] nvme-multipath: Skip nr_active increments in RETRY
 disposition
Message-ID: <aNR4m9wrO5cgFZIe@kbusch-mbp>
References: <20250924224319.4557-1-achaudhary@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924224319.4557-1-achaudhary@purestorage.com>

On Wed, Sep 24, 2025 at 03:43:18PM -0700, Amit Chaudhary wrote:
>  static inline void nvme_start_request(struct request *rq)
>  {
> -	if (rq->cmd_flags & REQ_NVME_MPATH)
> +	if ((rq->cmd_flags & REQ_NVME_MPATH) && (!nvme_req(rq)->retries))
>  		nvme_mpath_start_request(rq);
>  	blk_mq_start_request(rq);
>  }

Using "retries" is bit indirect as a proxy for multipath active counts.
Could this be moved to the mpath start instead, directly using the flag
that accounts for the path? This also helps to keep track if the command
gets retried across a user toggling the policy to "qd".

---
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 3da980dc60d91..1c630967ddd40 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -182,7 +182,8 @@ void nvme_mpath_start_request(struct request *rq)
        struct nvme_ns *ns = rq->q->queuedata;
        struct gendisk *disk = ns->head->disk;

-       if (READ_ONCE(ns->head->subsys->iopolicy) == NVME_IOPOLICY_QD) {
+       if (READ_ONCE(ns->head->subsys->iopolicy) == NVME_IOPOLICY_QD &&
+           !(nvme_req(rq)->flags & NVME_MPATH_CNT_ACTIVE)) {
                atomic_inc(&ns->ctrl->nr_active);
                nvme_req(rq)->flags |= NVME_MPATH_CNT_ACTIVE;
        }
--

