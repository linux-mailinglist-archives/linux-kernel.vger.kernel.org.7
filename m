Return-Path: <linux-kernel+bounces-722420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACADEAFDA2D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 23:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66F0F1C25E26
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 21:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C1021CA02;
	Tue,  8 Jul 2025 21:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kerneltoast.com header.i=@kerneltoast.com header.b="ZxTUz/U3"
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C6F9461
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 21:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752011228; cv=none; b=p8hC3q6eAAYj37ykQw7MN1nziRm42AS5r4M4KN4FtDnb5Gyfm9Oyt5v9JEz4xxIkQ5O+Scr0TmdTZC695brR1sEbS91/04Zp2LXBi+neG7dx1cylktvtnG8Y9O183Ixmtug0RI4gtoNeZrAheanXEc/9HhXwRAUpyjE5aVAotwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752011228; c=relaxed/simple;
	bh=r3PcIzpuI0cmJuqvXBnwHIoVHbphOXbd9ZzNuqavrsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nRbve48IKa/pJeMNjIRgcsraPk2dwEHrNPgWuUumsH4vl/A3KcJiDPNd526wiF5rEJM2Sevu+NeFcN2ICSmtaf8ZLv1mIf41HGPLqL1HmCHOJJFi+sxagJVxLbtJCDc6NHFwMg0oDs15AxlmKJA4iHOHMB2VpQePAyu+7hP7I2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerneltoast.com; spf=pass smtp.mailfrom=kerneltoast.com; dkim=pass (2048-bit key) header.d=kerneltoast.com header.i=@kerneltoast.com header.b=ZxTUz/U3; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerneltoast.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kerneltoast.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-74b54af901bso3073669b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 14:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kerneltoast.com; s=google; t=1752011226; x=1752616026; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=13tR6fzkt2bQ08ugXjACDh19YKyW3sNzP8lou+ZxAAk=;
        b=ZxTUz/U3fsvtQPNuYmJyq8nZfo0OW8bk7zi25LFBXTh9ExQ+tj6HanRxQcgF3a+ZcP
         Mg/4RHTY5R+qiKiNKgIp+7ssPWD5+pRCGJi7q3xDU+JlcUK0LdrQ46IPFT5P89+ADVeD
         qRMqmDkVaddvrD5nDLcUqDGE4FCjnG6Mky+WcyNUXr888q5xQs6g6ypj0VJ/EBr5BFXs
         aJxjvXT0vi7DAyzR5OIvjtnVTYjXxmN3WiFnqTkEJiRNhRhLanrz93sgviOVDZLMXMn3
         NN7Xv1vaTfC2DcJQwMSnf3gzaMmc2yP/PoOw3tJtLmumB7vUT+GLCF+XbOGvJyZFJZD9
         SE6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752011226; x=1752616026;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=13tR6fzkt2bQ08ugXjACDh19YKyW3sNzP8lou+ZxAAk=;
        b=wHWGYuzjn5DF8A2kXGq5Ac+FUkYE+mXnRbPC4X8XJojhwg/JfX3V8XT8R3y2RAMmxd
         pbcJnba/lN1+Sw/KKNClX296V6v8dN7ouCtoX21s81xpmAapkMdmrQeCIoWhZkun97wL
         0XVnDXs0J6tUTiI4CJElq1/ysTEyoXbvJZIwdt07ScRdWz4niIfgXoit6SGDNYEsRAUq
         bdjcQy10v7l96OUuIlaoBdGxMlDgI3G0wsFzGYKC5IxV33hM6wyXjZToSdFv01Th2ZbG
         o22gGm4j/G+dYDQDqzta/yOP9/gis9ZC+XYJVCoF+FCf3VkaVo0RY7A9FTZmghPmiIod
         F3YA==
X-Forwarded-Encrypted: i=1; AJvYcCULvjPw7X6qbRcJz7WqM2mFVbhavbyLMNjksCS9BoVCsjBGc1f882jiUSpxC5UGulyoII/L2J4GtubTtic=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpgeSFTL4lkVcVmYZ48lw9Bv0XtsEvO02pdOux8a7+9hIXlRqh
	SBfLmgusXy4ElKgEVgKaige0bJrYdyIUuo0Kbmg4jkb4zVpgtGOUna/+/VKfgJecLUjF
X-Gm-Gg: ASbGnctObaPPcOZqhJpTq3ds/0aeTszGHqNGALBNVp6eU4Xg9ipLo5FoDZGWEtxjoao
	jW+1D1u8BQjjRXwkrXhi5Kifz1tleub1+J7hH7osZwxkphmkGMZu2wAANSIpQ7V7mOzaBgmbTej
	bMpfTFLInWIAHmgeIlAoF0vbRlVVtKx0DHDr379YTemtWqPoOgznWwVsFnBVs94/tQaHvU626ZG
	PW5PXEtPbcYw/TUrNdac1RBqaSeTo8G9fE8fCsjMwneInMzd2OLdDMQTxPU7sAqH4weSP+4pjNr
	Q0sDR1Ar3fJfveOtdvOTJmIlqHy/QRXtGMs5B1QF1/VAVe/ZOWgUbiDDc/B3SAXg
X-Google-Smtp-Source: AGHT+IHwOCg52U3b95dIpK9iZs0O6N3hZ4b0tVdV9D3VixsumfIvhEFDrERlIPnFDdaIS9MRhpJJJg==
X-Received: by 2002:a05:6a00:1795:b0:742:3fb4:f992 with SMTP id d2e1a72fcca58-74ea64572dcmr257168b3a.10.1752011226208;
        Tue, 08 Jul 2025 14:47:06 -0700 (PDT)
Received: from sultan-box ([142.147.89.207])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce359df4bsm13146245b3a.21.2025.07.08.14.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 14:47:05 -0700 (PDT)
Date: Tue, 8 Jul 2025 14:47:02 -0700
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
Message-ID: <aG2R1lyniZxhYiSJ@sultan-box>
References: <20250625201853.84062-1-stuart.w.hayes@gmail.com>
 <20250703114656.GE17686@lst.de>
 <aGaklKejxefXTQB4@jeremy-HP-Z840-Workstation>
 <CA+-xHTFC6KTs6D8EdvmVe=buqw9oN5P7GJ-WWvam6M3SzeZF4g@mail.gmail.com>
 <aGgAuje4tpIOveFc@sultan-box>
 <CA+-xHTFNRwbxH=zNMM4kasB=kUAne0b6cxPM+sq5FyM32k8peg@mail.gmail.com>
 <fd941519-6f71-4286-9517-2dc861ee99a5@gmail.com>
 <aGxfoqccqot9t9SB@sultan-box>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aGxfoqccqot9t9SB@sultan-box>

On Mon, Jul 07, 2025 at 05:00:34PM -0700, Sultan Alsawaf wrote:
> On Mon, Jul 07, 2025 at 03:49:44PM -0500, stuart hayes wrote:
> > On 7/7/2025 10:34 AM, David Jeffery wrote:
> > > On Fri, Jul 4, 2025 at 12:26 PM Sultan Alsawaf <sultan@kerneltoast.com> wrote:
> > > > 
> > > > On Fri, Jul 04, 2025 at 09:45:44AM -0400, David Jeffery wrote:
> > > > > On Thu, Jul 3, 2025 at 12:13 PM Jeremy Allison <jra@samba.org> wrote:
> > > > > > 
> > > > > > On Thu, Jul 03, 2025 at 01:46:56PM +0200, Christoph Hellwig wrote:
> > > > > > > On Wed, Jun 25, 2025 at 03:18:48PM -0500, Stuart Hayes wrote:
> > > > > > > > Address resource and timing issues when spawning a unique async thread
> > > > > > > > for every device during shutdown:
> > > > > > > >    * Make the asynchronous threads able to shut down multiple devices,
> > > > > > > >      instead of spawning a unique thread for every device.
> > > > > > > >    * Modify core kernel async code with a custom wake function so it
> > > > > > > >      doesn't wake up threads waiting to synchronize every time the cookie
> > > > > > > >      changes
> > > > > > > 
> > > > > > > Given all these thread spawning issues, why can't we just go back
> > > > > > > to the approach that kicks off shutdown asynchronously and then waits
> > > > > > > for it without spawning all these threads?
> > > > > > 
> > > > > > It isn't just an nvme issue. Red Hat found the same issue
> > > > > > with SCSI devices.
> > > > > > 
> > > > > > My colleague Sultan Alsawaf posted a simpler fix for the
> > > > > > earlier patch here:
> > > > > > 
> > > > > > https://lists.infradead.org/pipermail/linux-nvme/2025-January/053666.html
> > > > > > 
> > > > > > Maybe this could be explored.
> > > > > > 
> > > > > 
> > > > > Unfortunately, this approach looks flawed. If I am reading it right,
> > > > > it assumes async shutdown devices do not have dependencies on sync
> > > > > shutdown devices.
> > > > 
> > > > It does not make any such assumption. Dependency on a sync device is handled
> > > > through a combination of queue_device_async_shutdown() setting an async device's
> > > > shutdown_after and the synchronous shutdown loop dispatching an "async" shutdown
> > > > for a sync device when it encounters a sync device that has a downstream async
> > > > dependency.
> > > > 
> > > 
> > > Yes, but not what I think fails. This handles a sync parent having an
> > > async child. It does not handle the reverse, a sync child having an
> > > async parent.
> > > 
> > > For example, take a system with 1 pci nvme device. The nvme device
> > > which is flagged for async shutdown can have sync shutdown children as
> > > well as a sync shutdown parent. The patch linked pulls the async
> > > device off the shutdown list into a separate async list, then starts
> > > this lone async device with queue_device_async_shutdown from being on
> > > the async list. The device then is passed to the async subsystem
> > > running shutdown_one_device_async where it will immediately do
> > > shutdown due to a zero value shutdown_after. The patch sets
> > > shutdown_after for its parent, but there is nothing connecting and
> > > ordering the async device to its sync children which will be shutdown
> > > later from the original device_shutdown task.
> > > 
> > > > > Maintaining all the dependencies is the core problem and source of the
> > > > > complexity of the async shutdown patches.
> > > > 
> > > > I am acutely aware. Please take a closer look at my patch.
> > > > 
> > > 
> > > I have, and it still looks incomplete to me.
> > > 
> > > David Jeffery
> > > 
> > 
> > Also, the way it is implemented, it could hang if there isn't enough memory
> > to queue up all of the async device shutdowns before starting the
> > synchronous shutdowns.
> > 
> > When you call async_schedule_domain() and there's not enough memory to
> > allocate an async_entry, the async function will be run immediately. If that
> > happens when queuing up the async shutdowns, it could easily hang if there
> > if there are any dependencies requiring an async device shutdown to have to
> > wait for a synchronous device to shutdown, since none of the synchronous
> > shutdown devices have been scheduled yet.
> 
> Understood. Thank you both for the clarifications.
> 
> Regarding an async device with a sync child: this case strikes me as odd. What
> exactly makes the child device require "synchronous" shutdown? Synchronous
> relative to what, specifically?
> 
> This also makes me question what, exactly, the criteria are for determining that
> a device is safe to shut down "async". I think that all children of an async
> shutdown device should be enrolled into async shutdown to isolate the entire
> async dependency chain. That way, the async shutdown devices don't need to wait
> for synchronous shutdown of unrelated devices. I'm happy to do this in a v3.
> 
> Regarding async_schedule_domain() running synchronously when async_entry
> allocation fails: this is a bothersome constraint of the async helpers. Although
> there is a lot of overlap between the async helpers and the requirements for
> async device shutdown, there are other annoying constraints that make the async
> helpers unfit as-is for async device shutdown (like the arbitrary MAX_WORK
> limit).
> 
> The async helpers also don't do exclusive wakes, which leads to the behavior you
> observed in "[PATCH v10 1/5] kernel/async: streamline cookie synchronization".
> We could use exclusive wakes by isolating async shutdown device dependency
> chains and creating a different async_domain for each chain, which is faster
> than calling TTWU on all async waiters and filtering out the wakeups ad hoc.

Correcting myself here: the custom wake function filters out wakeups _before_
TTWU, so what I said in this paragraph is incorrect and therefore exclusive
wakes aren't necessary or helpful. My apologies.

Sultan

