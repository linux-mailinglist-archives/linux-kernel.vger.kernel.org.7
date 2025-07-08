Return-Path: <linux-kernel+bounces-720661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E27AFBED9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 02:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 262221AA53B9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 00:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FAC96A33B;
	Tue,  8 Jul 2025 00:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kerneltoast.com header.i=@kerneltoast.com header.b="na9FgYWu"
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA3B6FB9
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 00:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751932841; cv=none; b=Rb3+NHMYs/VGggCYU5c6+OJTsmxw2B8T9w4VszsM86wvqvwEE4M9mEI7T2pjcpgR+fRgxIBHQxmhbt9dTbSO3Wot4a2Nug984N0+dnsdNgQCjbhnkZ+fLQB1Wj+E7c0yIIaou5kFU39necysLxVxZgT1C89yqZ1fhiohS5bUruU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751932841; c=relaxed/simple;
	bh=EAufAOeV1a7B9cn2a7SyeHm60rhTJfJEc7iaCOl6QaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h9pIo+WvAORP0ipCM/UL5NjSzOcXZJjGv+ir1FqqV/jm3YdjPo7myowizcvEWgA9ttW2JKxZOAWZj2wkOAiyUPEHTnm+ZYHSc/BA92Bkk3RnWM8H4uBaAuLnVkbB7nLVTqitJthqemsf2MLKS5Ba7MTsPLzLQwUX73k02Y8lfXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerneltoast.com; spf=pass smtp.mailfrom=kerneltoast.com; dkim=pass (2048-bit key) header.d=kerneltoast.com header.i=@kerneltoast.com header.b=na9FgYWu; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerneltoast.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kerneltoast.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-74264d1832eso4504991b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 17:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kerneltoast.com; s=google; t=1751932839; x=1752537639; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Mw0H4znRNvFOsCeoBJhqxSDJMZoZ+H5yrQMWI0sghlk=;
        b=na9FgYWuCyUZEPZNHM2PK8mx+1QPKJoefL9vyOrNXs+odkI9UyapmC9x36JpQ6KNvd
         coFvtnYH21SdQJc35Kvy8R/4QF/KCDp4y5OukoGQZvPc5zk0BYKU5d1vZKnD0XDQMNMx
         RuHmt09NcEpl+Q0V8hxajHDHIjLasbNSULnfQ4qtfc90NviQ6e6z0IhIeUECdrmQfqFt
         xNT4Hn/91Fn/+Kzp47dlyQVsMIRuq+/rjmpB5GjmvFHFaxrybeXCuPTmdtTGTH2v4M2w
         3nvjcGUIJbdS+gPi+mN1E9mklshGxt73UsfaT/bUf4etViIqKceNaOnV6ibFE+MXkXd8
         QFIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751932839; x=1752537639;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mw0H4znRNvFOsCeoBJhqxSDJMZoZ+H5yrQMWI0sghlk=;
        b=Yi9nLfITvbjuO75mPRCYRjD3H/XpAeNaZjx9bXqfXZpyM2yGerPIgsZ1lX8HCk1+Sl
         CI2EM7695Ho32bwh5JBwPxxQl4AQH5NAOJV4LJ2QdDdfE5Gjv1sYTqILDfBA3+nbIWnB
         lm3koeNTALoqlMv6rzEHaXO1mp2mCq+bN4wF5DnU9vXuHm1e/41T/dKiTf+XZJNdZ2xB
         FERQ749B94DzlG2Q+ZO6QaW1bhnkuGIt9q4dYDImON2ZrpoB5dd89s61bRtWdGpf+1Th
         H5jTzCF3M1oZK/tBMQLZKTUi2udOaUhKiVzuVYmzuFo7OqerqWCaK0cncq9zKDDXuvp5
         9yhA==
X-Forwarded-Encrypted: i=1; AJvYcCXmMeojgKq/XrtIBM4h6+nRZYud1ketxDajuTnz7U4LCsQGcX4KzI/CdKyMm/uNdib0cMUScMuQHrcs3h0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQAmeTj0Q/R4VcrVI08TvdfPaDGffoQZu6gjySh48ptd4EDXGd
	d4opIKWU0PS2CRNJjgam1NXpfwA5ia0UeCy6uPoDXkYHtZhaS26ZQLdsmVozfkA5a2uO
X-Gm-Gg: ASbGncv0LD1+BQOyGpGdrF+ai5ehIknVQV6FnPTkOsIwy4LLiE9L+e5EvnWrgvNHxqn
	oERWlxizdvDOODZPq1gmgXyJsXSjIDIwN2MY5aSLEF08vmavaGuXgiC7+3HxuN52EV65+/k1mHH
	NACs0uOydPpgol4L41YKGxpH0E049y6A9BtIn3RCgXVZRzZSIuaAjEL78rTDpcDX+ZJ0BOZUBAb
	F0epayF+B6ZWNf7bTVCBhQmqh5JKXoYm+0lD7fab7exbVE1Pm4Qul1hJ4VtqCv6cG+Cp/WWCvej
	HeoXgLaJGp5zSrq0d7oO9H9QdxAbuLquwu7+GUPMV6G8eCg2KMeZprTTiQOqnYje
X-Google-Smtp-Source: AGHT+IGwh8MkxUmtG3ny5yTUcyZnjRvVq1ckz8zzVP3GrObaG6Q3EN4p91gwmyWqH3fRaVfkvH14hg==
X-Received: by 2002:a05:6a00:3991:b0:730:95a6:3761 with SMTP id d2e1a72fcca58-74ce8833fbamr23918640b3a.3.1751932838774;
        Mon, 07 Jul 2025 17:00:38 -0700 (PDT)
Received: from sultan-box ([142.147.89.207])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce359ead0sm10280841b3a.8.2025.07.07.17.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 17:00:38 -0700 (PDT)
Date: Mon, 7 Jul 2025 17:00:34 -0700
From: Sultan Alsawaf <sultan@kerneltoast.com>
To: stuart hayes <stuart.w.hayes@gmail.com>,
	David Jeffery <djeffery@redhat.com>
Cc: Jeremy Allison <jra@samba.org>, Christoph Hellwig <hch@lst.de>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Martin Belanger <Martin.Belanger@dell.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, Jeremy Allison <jallison@ciq.com>,
	Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Nathan Chancellor <nathan@kernel.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Bert Karwatzki <spasswolf@web.de>
Subject: Re: [PATCH v10 0/5] shut down devices asynchronously
Message-ID: <aGxfoqccqot9t9SB@sultan-box>
References: <20250625201853.84062-1-stuart.w.hayes@gmail.com>
 <20250703114656.GE17686@lst.de>
 <aGaklKejxefXTQB4@jeremy-HP-Z840-Workstation>
 <CA+-xHTFC6KTs6D8EdvmVe=buqw9oN5P7GJ-WWvam6M3SzeZF4g@mail.gmail.com>
 <aGgAuje4tpIOveFc@sultan-box>
 <CA+-xHTFNRwbxH=zNMM4kasB=kUAne0b6cxPM+sq5FyM32k8peg@mail.gmail.com>
 <fd941519-6f71-4286-9517-2dc861ee99a5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fd941519-6f71-4286-9517-2dc861ee99a5@gmail.com>

On Mon, Jul 07, 2025 at 03:49:44PM -0500, stuart hayes wrote:
> On 7/7/2025 10:34 AM, David Jeffery wrote:
> > On Fri, Jul 4, 2025 at 12:26 PM Sultan Alsawaf <sultan@kerneltoast.com> wrote:
> > > 
> > > On Fri, Jul 04, 2025 at 09:45:44AM -0400, David Jeffery wrote:
> > > > On Thu, Jul 3, 2025 at 12:13 PM Jeremy Allison <jra@samba.org> wrote:
> > > > > 
> > > > > On Thu, Jul 03, 2025 at 01:46:56PM +0200, Christoph Hellwig wrote:
> > > > > > On Wed, Jun 25, 2025 at 03:18:48PM -0500, Stuart Hayes wrote:
> > > > > > > Address resource and timing issues when spawning a unique async thread
> > > > > > > for every device during shutdown:
> > > > > > >    * Make the asynchronous threads able to shut down multiple devices,
> > > > > > >      instead of spawning a unique thread for every device.
> > > > > > >    * Modify core kernel async code with a custom wake function so it
> > > > > > >      doesn't wake up threads waiting to synchronize every time the cookie
> > > > > > >      changes
> > > > > > 
> > > > > > Given all these thread spawning issues, why can't we just go back
> > > > > > to the approach that kicks off shutdown asynchronously and then waits
> > > > > > for it without spawning all these threads?
> > > > > 
> > > > > It isn't just an nvme issue. Red Hat found the same issue
> > > > > with SCSI devices.
> > > > > 
> > > > > My colleague Sultan Alsawaf posted a simpler fix for the
> > > > > earlier patch here:
> > > > > 
> > > > > https://lists.infradead.org/pipermail/linux-nvme/2025-January/053666.html
> > > > > 
> > > > > Maybe this could be explored.
> > > > > 
> > > > 
> > > > Unfortunately, this approach looks flawed. If I am reading it right,
> > > > it assumes async shutdown devices do not have dependencies on sync
> > > > shutdown devices.
> > > 
> > > It does not make any such assumption. Dependency on a sync device is handled
> > > through a combination of queue_device_async_shutdown() setting an async device's
> > > shutdown_after and the synchronous shutdown loop dispatching an "async" shutdown
> > > for a sync device when it encounters a sync device that has a downstream async
> > > dependency.
> > > 
> > 
> > Yes, but not what I think fails. This handles a sync parent having an
> > async child. It does not handle the reverse, a sync child having an
> > async parent.
> > 
> > For example, take a system with 1 pci nvme device. The nvme device
> > which is flagged for async shutdown can have sync shutdown children as
> > well as a sync shutdown parent. The patch linked pulls the async
> > device off the shutdown list into a separate async list, then starts
> > this lone async device with queue_device_async_shutdown from being on
> > the async list. The device then is passed to the async subsystem
> > running shutdown_one_device_async where it will immediately do
> > shutdown due to a zero value shutdown_after. The patch sets
> > shutdown_after for its parent, but there is nothing connecting and
> > ordering the async device to its sync children which will be shutdown
> > later from the original device_shutdown task.
> > 
> > > > Maintaining all the dependencies is the core problem and source of the
> > > > complexity of the async shutdown patches.
> > > 
> > > I am acutely aware. Please take a closer look at my patch.
> > > 
> > 
> > I have, and it still looks incomplete to me.
> > 
> > David Jeffery
> > 
> 
> Also, the way it is implemented, it could hang if there isn't enough memory
> to queue up all of the async device shutdowns before starting the
> synchronous shutdowns.
> 
> When you call async_schedule_domain() and there's not enough memory to
> allocate an async_entry, the async function will be run immediately. If that
> happens when queuing up the async shutdowns, it could easily hang if there
> if there are any dependencies requiring an async device shutdown to have to
> wait for a synchronous device to shutdown, since none of the synchronous
> shutdown devices have been scheduled yet.

Understood. Thank you both for the clarifications.

Regarding an async device with a sync child: this case strikes me as odd. What
exactly makes the child device require "synchronous" shutdown? Synchronous
relative to what, specifically?

This also makes me question what, exactly, the criteria are for determining that
a device is safe to shut down "async". I think that all children of an async
shutdown device should be enrolled into async shutdown to isolate the entire
async dependency chain. That way, the async shutdown devices don't need to wait
for synchronous shutdown of unrelated devices. I'm happy to do this in a v3.

Regarding async_schedule_domain() running synchronously when async_entry
allocation fails: this is a bothersome constraint of the async helpers. Although
there is a lot of overlap between the async helpers and the requirements for
async device shutdown, there are other annoying constraints that make the async
helpers unfit as-is for async device shutdown (like the arbitrary MAX_WORK
limit).

The async helpers also don't do exclusive wakes, which leads to the behavior you
observed in "[PATCH v10 1/5] kernel/async: streamline cookie synchronization".
We could use exclusive wakes by isolating async shutdown device dependency
chains and creating a different async_domain for each chain, which is faster
than calling TTWU on all async waiters and filtering out the wakeups ad hoc.

These points make me think that either the async helpers should be made far more
generic or the driver core code should have its own async infrastructure.

> Before your patch, all device shutdowns are scheduled in order such that if
> the call to async_schedule_domain() runs the function immediately, it will
> still be able to complete, it just won't get the benefit of multiple threads
> shutting down devices concurrently. The V10 patch maintains that--it just
> lets one thread shut down multiple synchronous devices instead of creating
> one thread for each synchronous device shutdown.

This still dedicates threads to shutting down synchronous devices that don't
share a dependency chain with an async shutdown device. This shouldn't be
necessary.

(PS: fixed CC of Jan Kiszka <jan.kiszka@siemens.com>, who appears to have been
CC'd with a typo'd email address for at least the entire v9 patchset and this
v10 patchset. The CC list had siemens.com misspelled as seimens.com)

Sultan

