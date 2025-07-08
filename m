Return-Path: <linux-kernel+bounces-722412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC22AFD9FD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 23:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E967F189FDC8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 21:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544FA2459C6;
	Tue,  8 Jul 2025 21:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kerneltoast.com header.i=@kerneltoast.com header.b="kTdU4zwG"
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AB11799F
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 21:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752010306; cv=none; b=OGswLuqKazuKjS7YGWCVYXZ7tvT2fbhD32cWSj3y8MDonpgoavzUsGgh0SCHIZh0jWR2ZFhYtmkNOEQ2Q2g2WCE3ltEhKfl2GlVMVuqaFg6MknZ4zQNMRbkpFvfwAkLa6MZTkbGXcjFt0wdQndVqQbpT5NKHWsNJdbVAudXnh2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752010306; c=relaxed/simple;
	bh=ZksjAlsbcqZB3ppbT/Azu63yrO78s4/0al9fr5MODWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F6oDb9vO1Bv22trUowWDhssWR2wiAqLj0Zz/YdUxzoT6HKZt8THrRYIyWFV/G5KT7DI9/Hd1Al7pwAsf2aSR3JbiLqdlsJN1MT90qytCMRb6oRPIjpaqLNeDBTpHVbTAjFfamocqP/wXbQYcYvb8LpDfyevxMrdoK0H/Zw8PWbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerneltoast.com; spf=pass smtp.mailfrom=kerneltoast.com; dkim=pass (2048-bit key) header.d=kerneltoast.com header.i=@kerneltoast.com header.b=kTdU4zwG; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerneltoast.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kerneltoast.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-748feca4a61so2644893b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 14:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kerneltoast.com; s=google; t=1752010304; x=1752615104; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vv8bVQli0FxG/x60urjN+lD1A8MWHKf0hpuLGEAS4zo=;
        b=kTdU4zwGiF0ubl+3mOBopxb2k9hIYW7x7tKaTN+tr36pMd3ml6nElxjPFdUfVqy+nb
         JDdl4VCBtxpshJB6Y3x7r6mfQ/zF4dnhym29G4ydO8ZZ650fi2Y83LOP1kb/0cG/l/Ad
         vS4XalEt+8Jdk+7e25bAbsxaSyeYozPadXmpLZxTMA1MNvHFUnZHhcA0G5v0OCdK5RdI
         ix7cE12O1dKlG5oGTQOz3ZmTMm/QMyAFGRfFEoxJGf7Lx4bW12nf7+tpvNE56Ll/1KQo
         4W8ALjd0tJPPWQ4gX1IlBLl4GCCSanrdVFw7rO07b7DeygL4vpXhS5od1FAwqmq36rfo
         ST3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752010304; x=1752615104;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vv8bVQli0FxG/x60urjN+lD1A8MWHKf0hpuLGEAS4zo=;
        b=qi9JOdKXekPDyPDFQGenBf1Vq7yi1Ce4nRDIdrnS9QCffvLdJ9KMvxcqaNXYtYTB3t
         4AaH/TVtRmExTZaUXacaeLAHQNH+2dxkLlGHvn/CDWmfLJq2tgnO9MsZ3X5gs5P6mHJP
         /zsjMwhZQbZ9vwTIQL86XLurQi88wyU+PMkxAuL8J4qIi1IfWHlsA/k9jwfKaOwrPNT4
         SU8WSPk2VVfLRZaWCOH4/8nQLlxK86MSl8QiqAmDLAvbYR/DFYvA4u9gDahjB3SQAh6n
         0lnMQzi2mYMrpFEihZwUnl5Beh+ndsRg0/SVMCAblA9SoHucSSKPGbxJfa774BBNZL5H
         rmRA==
X-Forwarded-Encrypted: i=1; AJvYcCXRzy6PRA9PXBkDG6jSIINkEYrIkCACwm06MHFFyf7ogQAHCf2Gy8lutCMf9PP4K+EzT2MTMfkTn0T16ng=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9+Zgtfd0je+fekLguda1wTNJaFyT862RhAoheE3GHCAejR+JS
	qXg1QG8eR/tNpvrIh3RhjwrCMCc7pBzt3jXAJmRjgO6FJWtLpZM2sg2eKqawu8hvMoku
X-Gm-Gg: ASbGncuw6SeDAiJi1rsKQTswX3nbiV13HBvO+iWF+yUg6Bwzc4FXDqvUsUQ1CGrsmQ3
	OWxBIULCibM6TEa4gMglAPwC5i3sdzhPjqA8Y4r39dCk8e9XxZEcuZE5VQ3P47qkQ7t8QwV1VUx
	mc7ASbtayjd3j0Le6/seZOWeha85YAz3w5Nh96/8HS7ybLfOXnSMUSPr2Hvqkb8AEfqVHG3E5LW
	kAx7X8cIdQbR4jI7g8uW1xRKIPwAH4740w2JM7deeP/53bMuxb8j6lQ0kRPRo0o6wpGzpcdW/cZ
	9vJOQg66P0/USXaFbypieQdjhomsmFnZhYn6ITeJG1VET/wsXFjXlzS2YnKNvHjr
X-Google-Smtp-Source: AGHT+IGQtf7HMV5vqQ74P9l7ev3A5Dl/XSsOjm90Q34YEw8Cu0ZhOjMuNUH318xDdiC/AsjYN0mxWQ==
X-Received: by 2002:a05:6a00:a95:b0:748:2d1d:f7b3 with SMTP id d2e1a72fcca58-74ea66b0bf5mr161000b3a.22.1752010303895;
        Tue, 08 Jul 2025 14:31:43 -0700 (PDT)
Received: from sultan-box ([142.147.89.207])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce42cefccsm12475681b3a.156.2025.07.08.14.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 14:31:43 -0700 (PDT)
Date: Tue, 8 Jul 2025 14:31:39 -0700
From: Sultan Alsawaf <sultan@kerneltoast.com>
To: stuart hayes <stuart.w.hayes@gmail.com>
Cc: David Jeffery <djeffery@redhat.com>, Jeremy Allison <jra@samba.org>,
	Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
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
Message-ID: <aG2OO3-KerXN8t3o@sultan-box>
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

FWIW, I did consider this scenario when I wrote my patch and this hang cannot
occur with the way I implemented async shutdown. The reason is because my patch
assumes that async devices never need to wait on synchronous devices to shut
down, as David pointed out. My patch only assumes that synchronous devices need
to wait for async devices, so any allocation failures in async_schedule_domain()
won't cause the hang you described.

Sultan

