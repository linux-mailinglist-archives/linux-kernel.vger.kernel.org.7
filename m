Return-Path: <linux-kernel+bounces-831550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB354B9CFD4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 03:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18E221BC211B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBAFC2DEA73;
	Thu, 25 Sep 2025 01:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Imr1cMDk"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613202DE719
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 01:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758762872; cv=none; b=lNAxPLHigGjj/iB25TYNEy1uUEsroYoH4G7tBvjN+VGRZc/RWT//WBKIU2clT3WbAcnzQIcOn2JljvdL9eTO9N5d+SPX6CD2t4rJMzEfmhNsab6ql1Kwmaabsj8wRKeEEfHyGoiPtp0hguUrHJ0HKvbHC3PCwCgOTO6SHi8KbzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758762872; c=relaxed/simple;
	bh=r5v69HYaD2Ruqrjim4BqbYx3ZoP5J4GuM3iCZ54pbRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CUR/UFXNvSy565yYRq5yUhF06ec80/mt76guPhpH+jpOJ7DsJgVBFLRKQBxf0HkIf93XQ+jgR8vlTvKkBcjqqBUIBVxoxvqPIqU5aX77/8NZ/Gh3fmABd4xkuuk4n3QPKWEnqqbozuauHx3yhW2HA6I8FYFqm/UBFUGGeHpYtQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Imr1cMDk; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-77f41086c11so490690b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 18:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758762869; x=1759367669; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EpH3vDieEOf5P6kACxecFbAgag5Z9fa9GewUJ4RQEl0=;
        b=Imr1cMDk5wMOzJvUI7n7SEQTned/STtdSdtCxuEkanbVx+xcIPbMFk48xakUP1CE7U
         yld6vzTroEas27TVoSAre+MasIilRmpqOlkZmewue+Y4wJpHzlYXffzTuSQJYLd50sR6
         NldfnXIflvrHguBcRnd/wL6JCv9qqQbU/C5HxhxFk6nffWM7Hf+x5rGAWVG5icDZ1l4g
         2+BHunM5wlUfLo665JwRNlswDN/XjEA8l2tcgVTAMCLC+iLb+9OxYS62YKoykhSZQFsP
         3GUqUyFr0YmBUg2sHg6XJf10OxZPOf16fI3iK6gluDAcufSbgycOsGnS3QXTAgei9x/u
         DnJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758762869; x=1759367669;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EpH3vDieEOf5P6kACxecFbAgag5Z9fa9GewUJ4RQEl0=;
        b=RwKYxfXdjgPi5g9kMg47Undk26NaZxpBVBDLUCGkbI+ELvrS5MUd2mRSt/9v1Thsoa
         AmhJGmZ/1M4Xt7Mh73CQhownoc4c4pOT65mwI5jY2EwlJNRv0YD71j2gV1rRl88pXSt8
         AQaR083qLSTNr5n6k16Rgd+9LKuMRD+GqJhqepse7KtaHH/UVH/icT9e7lr41+9zaZYc
         LV6ay5u7cpuPYvwPH9f1yiGOZ9ktH4TIrxwDJ8qEJrDzL1Iy8qPPZCI+JEzCM2ajK4wn
         cHsa+clGGFt/fFVOcEfDQ5PiYdkjH+GX0IgdIh99etKS5bi67Tq2SM989fKB8rwIpi56
         lr1w==
X-Forwarded-Encrypted: i=1; AJvYcCWzsy4GUTDBBoAo2GaQigC5XG54r4P3qKd+DUpko+m4gVLaPslAYusfCkeiuPyoka+JrJsQanXuGHeVmI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGzu0xZX7SfsQ20lagKfcNKvb8R8DLTjMF5KTNkKjbH8gKs/ds
	YYdOx46Trjoiw9l0aGX0edPnvCw6nG57ioQeGrM2UxotZA3o3FiIOM7YUFhiI73jyEw=
X-Gm-Gg: ASbGncv7Ji06wNmUDHnZQaPNHG7VL72O65V4bWHOETBpSvFrcps6ViTnhiKINDueuTX
	zXgyakSJNheC82K58ksl0SinhIiNTw44oBwnt9sKldNpMMlU+tVVAefIT0MOUMr6hFYvaJUjBG+
	DF2yu7l8U5Ug6aG/V29OHPxAQFO3TiDRESNDQlHjU4pott2uo/sUpWTrCc4Eh40KwFo53fGkJU1
	NuQxD4l8OSfDtvwmo0fBdk8pzA3SBpHQExZQxOfwk5sk4s2YlFCjPZxDgTbMi60ImOfn0g3U9iX
	fEQQgmyiZABr8CXJflH44+MDm3AR9loeqSfYihG5I+lq6p4CSKFpjqBRCRsUlzqRKveub0fA/40
	rHdrXB46a12OifogHKkLUb0nMiOwXoIoOyCN2N4lP954=
X-Google-Smtp-Source: AGHT+IFbdkdawYQ5DW+wMtEwe5sjA9aOuzPxMZ0/627qe7vqGZqDMaJiDojubyykTXfFK/7YWQNpJA==
X-Received: by 2002:a05:6a20:1588:b0:2d5:e559:d24b with SMTP id adf61e73a8af0-2e7cdda1022mr1961101637.32.1758762869339;
        Wed, 24 Sep 2025 18:14:29 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with UTF8SMTPSA id d2e1a72fcca58-7810238ca29sm337965b3a.6.2025.09.24.18.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 18:14:28 -0700 (PDT)
Date: Wed, 24 Sep 2025 18:14:27 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Amit Chaudhary <achaudhary@purestorage.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, randyj@purestorage.com,
	jmeneghi@redhat.com, emilne@redhat.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] nvme-multipath: Skip nr_active increments in RETRY
 disposition
Message-ID: <20250925011427.GC3269-mkhalfella@purestorage.com>
References: <20250924224319.4557-1-achaudhary@purestorage.com>
 <aNR4m9wrO5cgFZIe@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNR4m9wrO5cgFZIe@kbusch-mbp>

On 2025-09-24 17:02:51 -0600, Keith Busch wrote:
> On Wed, Sep 24, 2025 at 03:43:18PM -0700, Amit Chaudhary wrote:
> >  static inline void nvme_start_request(struct request *rq)
> >  {
> > -	if (rq->cmd_flags & REQ_NVME_MPATH)
> > +	if ((rq->cmd_flags & REQ_NVME_MPATH) && (!nvme_req(rq)->retries))
> >  		nvme_mpath_start_request(rq);
> >  	blk_mq_start_request(rq);
> >  }
> 
> Using "retries" is bit indirect as a proxy for multipath active counts.
> Could this be moved to the mpath start instead, directly using the flag
> that accounts for the path? This also helps to keep track if the command
> gets retried across a user toggling the policy to "qd".
> 
> ---
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 3da980dc60d91..1c630967ddd40 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -182,7 +182,8 @@ void nvme_mpath_start_request(struct request *rq)
>         struct nvme_ns *ns = rq->q->queuedata;
>         struct gendisk *disk = ns->head->disk;
> 
> -       if (READ_ONCE(ns->head->subsys->iopolicy) == NVME_IOPOLICY_QD) {
> +       if (READ_ONCE(ns->head->subsys->iopolicy) == NVME_IOPOLICY_QD &&
> +           !(nvme_req(rq)->flags & NVME_MPATH_CNT_ACTIVE)) {
>                 atomic_inc(&ns->ctrl->nr_active);
>                 nvme_req(rq)->flags |= NVME_MPATH_CNT_ACTIVE;
>         }
> --

193         nvme_req(rq)->flags |= NVME_MPATH_IO_STATS;
194         nvme_req(rq)->start_time = bdev_start_io_acct(disk->part0, req_op(rq),
195                                                       jiffies);

Doing it this way might messup with stats accounting because the two
lines above will be executed on request retry. I do not think we need
that, right?

