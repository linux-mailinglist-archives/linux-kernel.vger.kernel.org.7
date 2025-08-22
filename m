Return-Path: <linux-kernel+bounces-781781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3622B316B0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40D53B65CC0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC462E8E19;
	Fri, 22 Aug 2025 11:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cVuv5bzX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790F7393DC4
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 11:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755863349; cv=none; b=PsYt7r0wKviV8YdX2SZreR73wXlC+s/LaQn2cC3uEO7zkkO7XCzOktgCCL5cltK4G5pthZ7C44JC0aHO+CWGF71amOd+CmHlz5q685GMDVsXtaCPoVxWcGOTLWLRUmHE/YcidhJdBQ64WMWCXZGFdFxasU4DECGeDuugDKa/t+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755863349; c=relaxed/simple;
	bh=RhtZ9QF3jNeWlu1NyFf57VDqqZgeDOt1OLEdNPilCV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LpzpfWTxbz7CCewdfdGOtUQzTpIv/dkfvCZnumDG24q0IIdqdt5/vmG0lb+e6KHprhpuBVXD6eIlbBc1B/r2FSeLmCHbM8P+OFzb4m02w64h0RQBErK3MGvVQ7ZyxB8iHJZOObTKL1ELWB3yCx6shVcAAXocXwV2HLSvmswnEyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cVuv5bzX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5679DC4CEED;
	Fri, 22 Aug 2025 11:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755863349;
	bh=RhtZ9QF3jNeWlu1NyFf57VDqqZgeDOt1OLEdNPilCV8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cVuv5bzX+5SDkVZko/FxaR8PIehk2hm9GwG194YkD4PdxbojWmDB49ZiIS7c6KjyE
	 bcu10fZIrslTqSRXdey/bq7fmYqIA/cjZFHXS9qaxW6LwErOndsgftLu4ogMRugi//
	 WCXofIN0tn2lV00/6UmtssqwL6v1V3LsIJYC2bs8=
Date: Fri, 22 Aug 2025 13:49:05 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Mahesh Rao <mahesh.rao@altera.com>
Cc: Dinh Nguyen <dinguyen@kernel.org>, linux-kernel@vger.kernel.org,
	Matthew Gerlach <matthew.gerlach@altera.com>
Subject: Re: [PATCH 1/5] firmware: stratix10-svc: Add mutex lock and unlock
 in stratix10 memory allocation/free
Message-ID: <2025082234-scarcity-relive-9362@gregkh>
References: <20250722163045.168186-1-dinguyen@kernel.org>
 <2025081920-greyhound-discuss-79b2@gregkh>
 <0bee0edb-5a3b-4648-8ca5-ad334220f092@altera.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bee0edb-5a3b-4648-8ca5-ad334220f092@altera.com>

On Fri, Aug 22, 2025 at 03:17:54PM +0530, Mahesh Rao wrote:
> Hi Greg,
> 	thanks for reviewing the code.
> 
> On 19-08-2025 04:36 pm, Greg KH wrote:
> > On Tue, Jul 22, 2025 at 11:30:41AM -0500, Dinh Nguyen wrote:
> > > From: Mahesh Rao <mahesh.rao@altera.com>
> > > 
> > > This commit adds a mutex lock to protect the
> > > stratix10_svc_allocate_memory and
> > > stratix10_svc_free_memory functions to ensure
> > > thread safety when allocating and freeing memory.
> > > This prevents potential race conditions and ensures
> > > synchronization.
> > 
> > You have 72 columns to write a changelog in, please use it :)
> > 
> > And is this fixing a bug?  If so, shouldn't this be tagged for stable
> > and add a Fixes: tag?
> > 
> > If this isn't a bug, then why is it needed?  How can these race?
> 
> In the current implementation, all operations were performed serially,
> eliminating the need for protection mechanisms. However, with this patch
> set, we are introducing parallel access and communication with the SDM
> across multiple client drivers. This change may lead to race conditions
> involving the svc_data_mem list.

Then that needs to be said here :)

Also, what is causing these operations to be performed serially if there
is no locking?

> 
> > 
> > > 
> > > Signed-off-by: Mahesh Rao <mahesh.rao@altera.com>
> > > Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>
> > > Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> > > ---
> > >   drivers/firmware/stratix10-svc.c | 31 ++++++++++++++++++++++++-------
> > >   1 file changed, 24 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
> > > index e3f990d888d7..73c77b8e9f2b 100644
> > > --- a/drivers/firmware/stratix10-svc.c
> > > +++ b/drivers/firmware/stratix10-svc.c
> > > @@ -1,6 +1,7 @@
> > >   // SPDX-License-Identifier: GPL-2.0
> > >   /*
> > >    * Copyright (C) 2017-2018, Intel Corporation
> > > + * Copyright (C) 2025, Altera Corporation
> > >    */
> > >   #include <linux/completion.h>
> > > @@ -171,6 +172,10 @@ struct stratix10_svc_chan {
> > >   static LIST_HEAD(svc_ctrl);
> > >   static LIST_HEAD(svc_data_mem);
> > > +/* svc_mem_lock protects access to the svc_data_mem list for
> > > + * concurrent multi-client operations
> > > + */
> > 
> > Odd coding style, this isn't the network subsystem :(
> 
> Ok sure, will change
> 
> > 
> > And what about a lock for svc_ctrl?
> 
> There is only one instance of svc_ctrl and there is no parallel access to
> it.so a lock is not required as of now.

But don't you have multiple places that list can be accessed now at the
same time?

In other words, what is changing to require one list to require it but
not the other?  Is there some other lock for that?

thanks,

greg k-h

