Return-Path: <linux-kernel+bounces-832668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C2CBA00E4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 16:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FC2116401B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 14:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF4B2DEA86;
	Thu, 25 Sep 2025 14:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PNO7y+yd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E46A23D7D8
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 14:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758811427; cv=none; b=sN4D1hapnCrEW/P8RiXZCuIaTh2HCfPPRw8hIsN5luo9YANcfWUNfkfeMGPCY/U/VxVJcEngwsXCcQurGhBzs67StdF5QGFDKwopyx1N3JckSUkBZwW/acqYVWBKpudxuJuUSpjapfKccYCWio8h28Kk42rX5VOiklyCMOoDr58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758811427; c=relaxed/simple;
	bh=N5JrG4ArvWG565dEhJ88rgU/kFQ1aVlRQbuV/+x6VtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FoEqURuiNm/YkiYkrOyw3L8OfiNkvVDC2mBA43pUhakZPSuZ2heykeGeEWVWSTYBD7ypL3EBK1xL/97/b8rZu9O7eCvMKy0gSHVtyyge1PjAykVpgXCI0Q3hAVu13f9+kNVU3qdlbAuXSHqawq6AYT0yqwZWGdoCdIBXEVP0uwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PNO7y+yd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88D11C4CEF0;
	Thu, 25 Sep 2025 14:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758811427;
	bh=N5JrG4ArvWG565dEhJ88rgU/kFQ1aVlRQbuV/+x6VtY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PNO7y+ydl7+LI3KzCsV8aPacVEZhWIePBPCoKdY1N1Lt5BIlBlxum2fIIFJY0Bi0Z
	 20OuFhCEGojQ2pjWwU6icXsBe77CzHL2hSm+8KbpBNsZrf4wtjKlydNvENlcAo7ZSx
	 bc6WyN57Av0RA0Wpg4XsxIDmggfnh86sjP6tLkKQFz938Rw/qBKb32GeII/i0xXsIz
	 2+uXkMLXtQ2hHyXYbcBrV3YpmSjwU9YXPnDsyPwghWfcYy6ZXsrqN6Cmi4TaFd8wKy
	 Azfb1gu2SYi7cTkYquVFer8dEmglYjUatbNzOGDj9xg+5VCCVNIG8f1B2lf8OXfaMv
	 sma10paLnqtRA==
Date: Thu, 25 Sep 2025 08:43:44 -0600
From: Keith Busch <kbusch@kernel.org>
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Amit Chaudhary <achaudhary@purestorage.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, randyj@purestorage.com,
	jmeneghi@redhat.com, emilne@redhat.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] nvme-multipath: Skip nr_active increments in RETRY
 disposition
Message-ID: <aNVVIP3WE7POT498@kbusch-mbp>
References: <20250924224319.4557-1-achaudhary@purestorage.com>
 <aNR4m9wrO5cgFZIe@kbusch-mbp>
 <20250925011427.GC3269-mkhalfella@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925011427.GC3269-mkhalfella@purestorage.com>

On Wed, Sep 24, 2025 at 06:14:27PM -0700, Mohamed Khalfella wrote:
> On 2025-09-24 17:02:51 -0600, Keith Busch wrote:
> > On Wed, Sep 24, 2025 at 03:43:18PM -0700, Amit Chaudhary wrote:
> > >  static inline void nvme_start_request(struct request *rq)
> > >  {
> > > -	if (rq->cmd_flags & REQ_NVME_MPATH)
> > > +	if ((rq->cmd_flags & REQ_NVME_MPATH) && (!nvme_req(rq)->retries))
> > >  		nvme_mpath_start_request(rq);
> > >  	blk_mq_start_request(rq);
> > >  }
> > 
> > Using "retries" is bit indirect as a proxy for multipath active counts.
> > Could this be moved to the mpath start instead, directly using the flag
> > that accounts for the path? This also helps to keep track if the command
> > gets retried across a user toggling the policy to "qd".
> > 
> > ---
> > diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> > index 3da980dc60d91..1c630967ddd40 100644
> > --- a/drivers/nvme/host/multipath.c
> > +++ b/drivers/nvme/host/multipath.c
> > @@ -182,7 +182,8 @@ void nvme_mpath_start_request(struct request *rq)
> >         struct nvme_ns *ns = rq->q->queuedata;
> >         struct gendisk *disk = ns->head->disk;
> > 
> > -       if (READ_ONCE(ns->head->subsys->iopolicy) == NVME_IOPOLICY_QD) {
> > +       if (READ_ONCE(ns->head->subsys->iopolicy) == NVME_IOPOLICY_QD &&
> > +           !(nvme_req(rq)->flags & NVME_MPATH_CNT_ACTIVE)) {
> >                 atomic_inc(&ns->ctrl->nr_active);
> >                 nvme_req(rq)->flags |= NVME_MPATH_CNT_ACTIVE;
> >         }
> > --
> 
> 193         nvme_req(rq)->flags |= NVME_MPATH_IO_STATS;
> 194         nvme_req(rq)->start_time = bdev_start_io_acct(disk->part0, req_op(rq),
> 195                                                       jiffies);
> 
> Doing it this way might messup with stats accounting because the two
> lines above will be executed on request retry. I do not think we need
> that, right?

Yeah, but we can use the other flag to know if it's already been
accounted:

--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -182,12 +182,14 @@ void nvme_mpath_start_request(struct request *rq)
        struct nvme_ns *ns = rq->q->queuedata;
        struct gendisk *disk = ns->head->disk;

-       if (READ_ONCE(ns->head->subsys->iopolicy) == NVME_IOPOLICY_QD) {
+       if (READ_ONCE(ns->head->subsys->iopolicy) == NVME_IOPOLICY_QD &&
+           !(nvme_req(rq)->flags & NVME_MPATH_CNT_ACTIVE)) {
                atomic_inc(&ns->ctrl->nr_active);
                nvme_req(rq)->flags |= NVME_MPATH_CNT_ACTIVE;
        }

-       if (!blk_queue_io_stat(disk->queue) || blk_rq_is_passthrough(rq))
+       if (!blk_queue_io_stat(disk->queue) || blk_rq_is_passthrough(rq) ||
+           nvme_req(rq)->flags & NVME_MPATH_IO_STATS)
                return;

        nvme_req(rq)->flags |= NVME_MPATH_IO_STATS;

