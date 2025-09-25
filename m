Return-Path: <linux-kernel+bounces-832831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55691BA0845
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 18:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AE777B405A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421643043B0;
	Thu, 25 Sep 2025 15:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="fafCsRUw"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B682EBBB8
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 15:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758815995; cv=none; b=ojrNaBbAuawBOEjN4os2XXK1s52/BMwvuQD3s9NbHr5BvTNLIgIFsecPajrnUOuEqsUaxd3yeB3+GuogF0vcK8wU3wZoTefEpEPthFOqkBxAFxdCqTQLEKFiQQ/Xq5VU7I3qRx6UeCDTyKXXQXLm0bF6noQCslVtqmRSxDDWEd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758815995; c=relaxed/simple;
	bh=WAe304FWHEAyw7CqK4KrU6asr7XLuQd7BTQEDpcK5nI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B0ebUDvEYyjyMiN8lu7EYNffV3m77XVXIKSPXJFltNttfv5KkCYei3uJZHU393gZtDixibHzFAX3aj7qDjFvPFy7t84xom9faEfM2vv9lvK6DLqPx2ydxBdveEN6t426i55OQsZ9+jY42ZWSe0wkVrULOE2mCbFU+6ePQeDzrRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=fafCsRUw; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-77f198bd8eeso920817b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 08:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758815993; x=1759420793; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I5XBEq8QoZNrsUfm/LIlDnw2hOYxn9vY9Sj8fl398cE=;
        b=fafCsRUwq7m4AV115+nrwrhdLT2d/KMe9L1emObNRLmtv9xPQwV2DSXb3ZzaJ2OiEs
         u07T9RRgGFYGE0VJnS09j6ulM5F/lao2hC6agJR2fq7c17kq9hvIvpr4D15uuOyqhp0t
         ivsjHtiMY9ttaa87Br+td+QMyOjcdW3/AWod2t2t5Z91ByqOz4kdK8kMCBesUjgQwrxZ
         Y5v7NqChtQIwhIlLmZbZDOX0I6IHyVrxYW5QpUHC1hV4OjHOOPDxK8IQiw7GN+FYutsY
         WtN7iJ8lObiCnCQv5oj8Ard4jOyzFzT3GaaeA78LcC5GTmgBEPjOwqZUG8Ha2jkr0hOg
         SSsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758815993; x=1759420793;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I5XBEq8QoZNrsUfm/LIlDnw2hOYxn9vY9Sj8fl398cE=;
        b=eFVyPZ/ySeCicFTWnPgkb8gFiALNYzaZOn1ZWexPnOzgrRHJXgkTQzS8aJ3Vt6dmGT
         /24QrliJA+bSAmoSMmnd+8i1WreQGUZPYYJhc/5NVHUoyZbCcji6UBWGxPP/Al7tdYcR
         JmGsZ+qLnd2Ti11bOxbkxqqv4a/QMZbES2vI0UxW8N+HsJpSm9dhRkDG1NiJZWTP2rhS
         eMU6ySQM0MyXAT9/zAdFu60qeIl+vtvSaUHgLs8p0RTqhH1Gug380YFJKL/dz5Etu7bz
         l/cFRz71LBjs6UId7TuyLp0sqDJVKhp3djXpwk5c9Jv+ILvg9qBhX2abIyM7BFfUbrut
         LsPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbR/yluNAqJN09YBiMhijmJt3LPbFTyKpzl+Xu0ZlFN6ANMFR/MZC/trnWbqF5aGe4l9RyYV/Qi6vEd/U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0qXMPWfmjq0YekAnDD1XFtJfom9kQ7iMXXiZbuKzEfQtdB1Hk
	W5NMAmVV04T92FRYFdB3z6hWJDxJXNYxy0/rb86jR5wPd+K0+b5IgPCxSm5Yu/BEkME=
X-Gm-Gg: ASbGncsaBlB9tI+AIcCUdMYMZqxw+1pT8SMCzIjq9HzDQ44C8xU4bkSWWiFDy8P7Nnf
	ySVNS0gxfDBrqc8aS8RAy513C0/Qg438H+12d3eqUgUJBag64p4YFOFAaQOXu5mSS0a4djpi3Vg
	xesmV3wcg/ncb05rjvCiSyQ1j5Jw/TKtj/n8ki0eZz1a6EoImqM6arkxOWJizdN/AguRJzVXPeL
	6B05HwFd6wJsufaammYtD0NYnUO8Wu0vyCRdSpHP8BOPbcKfvGYOpEdy8eAloRI9OPX03nwhXQ7
	EeIQZ51WiSdGmwu4ldvfaGdiNx3BLE5xaR5sFH/s6A/QWp7N58Zo2Xk6lxkWcsPOguVmTXSa4iW
	5yD/FhvnjPUf+BU8f+Pk5inDK2E95
X-Google-Smtp-Source: AGHT+IE3MC+4196hdWgsoD1Z2JwahZdWiuJ/E8gO1X15jtnyZAibsQAfl1r6vLcaWOJ2ok+XUXafKg==
X-Received: by 2002:a05:6a20:7f97:b0:2cb:5f15:ebfa with SMTP id adf61e73a8af0-2e7dab12a8dmr3887775637.60.1758815992627;
        Thu, 25 Sep 2025 08:59:52 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([2601:640:8202:6fb0::bed8])
        by smtp.googlemail.com with UTF8SMTPSA id d2e1a72fcca58-78102b250bfsm2310854b3a.61.2025.09.25.08.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 08:59:52 -0700 (PDT)
Date: Thu, 25 Sep 2025 08:59:50 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Amit Chaudhary <achaudhary@purestorage.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, randyj@purestorage.com,
	jmeneghi@redhat.com, emilne@redhat.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] nvme-multipath: Skip nr_active increments in RETRY
 disposition
Message-ID: <20250925155950.GA4013-mkhalfella@purestorage.com>
References: <20250924224319.4557-1-achaudhary@purestorage.com>
 <aNR4m9wrO5cgFZIe@kbusch-mbp>
 <20250925011427.GC3269-mkhalfella@purestorage.com>
 <aNVVIP3WE7POT498@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNVVIP3WE7POT498@kbusch-mbp>

On 2025-09-25 08:43:44 -0600, Keith Busch wrote:
> On Wed, Sep 24, 2025 at 06:14:27PM -0700, Mohamed Khalfella wrote:
> > On 2025-09-24 17:02:51 -0600, Keith Busch wrote:
> > > On Wed, Sep 24, 2025 at 03:43:18PM -0700, Amit Chaudhary wrote:
> > > >  static inline void nvme_start_request(struct request *rq)
> > > >  {
> > > > -	if (rq->cmd_flags & REQ_NVME_MPATH)
> > > > +	if ((rq->cmd_flags & REQ_NVME_MPATH) && (!nvme_req(rq)->retries))
> > > >  		nvme_mpath_start_request(rq);
> > > >  	blk_mq_start_request(rq);
> > > >  }
> > > 
> > > Using "retries" is bit indirect as a proxy for multipath active counts.
> > > Could this be moved to the mpath start instead, directly using the flag
> > > that accounts for the path? This also helps to keep track if the command
> > > gets retried across a user toggling the policy to "qd".
> > > 
> > > ---
> > > diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> > > index 3da980dc60d91..1c630967ddd40 100644
> > > --- a/drivers/nvme/host/multipath.c
> > > +++ b/drivers/nvme/host/multipath.c
> > > @@ -182,7 +182,8 @@ void nvme_mpath_start_request(struct request *rq)
> > >         struct nvme_ns *ns = rq->q->queuedata;
> > >         struct gendisk *disk = ns->head->disk;
> > > 
> > > -       if (READ_ONCE(ns->head->subsys->iopolicy) == NVME_IOPOLICY_QD) {
> > > +       if (READ_ONCE(ns->head->subsys->iopolicy) == NVME_IOPOLICY_QD &&
> > > +           !(nvme_req(rq)->flags & NVME_MPATH_CNT_ACTIVE)) {
> > >                 atomic_inc(&ns->ctrl->nr_active);
> > >                 nvme_req(rq)->flags |= NVME_MPATH_CNT_ACTIVE;
> > >         }
> > > --
> > 
> > 193         nvme_req(rq)->flags |= NVME_MPATH_IO_STATS;
> > 194         nvme_req(rq)->start_time = bdev_start_io_acct(disk->part0, req_op(rq),
> > 195                                                       jiffies);
> > 
> > Doing it this way might messup with stats accounting because the two
> > lines above will be executed on request retry. I do not think we need
> > that, right?
> 
> Yeah, but we can use the other flag to know if it's already been
> accounted:
> 
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -182,12 +182,14 @@ void nvme_mpath_start_request(struct request *rq)
>         struct nvme_ns *ns = rq->q->queuedata;
>         struct gendisk *disk = ns->head->disk;
> 
> -       if (READ_ONCE(ns->head->subsys->iopolicy) == NVME_IOPOLICY_QD) {
> +       if (READ_ONCE(ns->head->subsys->iopolicy) == NVME_IOPOLICY_QD &&
> +           !(nvme_req(rq)->flags & NVME_MPATH_CNT_ACTIVE)) {
>                 atomic_inc(&ns->ctrl->nr_active);
>                 nvme_req(rq)->flags |= NVME_MPATH_CNT_ACTIVE;
>         }
> 
> -       if (!blk_queue_io_stat(disk->queue) || blk_rq_is_passthrough(rq))
> +       if (!blk_queue_io_stat(disk->queue) || blk_rq_is_passthrough(rq) ||
> +           nvme_req(rq)->flags & NVME_MPATH_IO_STATS)
>                 return;
> 
>         nvme_req(rq)->flags |= NVME_MPATH_IO_STATS;

This works. However, I find Amit's change more straight forward to
understand. nvme_mpath_start_request()/nvme_mpath_end_request() are
called when request started/ended respectively. For a request that has
been retried on the same path nvme_mpath_start_request() need not be
called again. Such retry should be transparent to multipath layer.

