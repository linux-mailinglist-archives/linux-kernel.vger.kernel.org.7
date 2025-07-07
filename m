Return-Path: <linux-kernel+bounces-720134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C51BDAFB777
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 17:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11BEA1AA2C58
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 15:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8931D5CF2;
	Mon,  7 Jul 2025 15:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A+RayFWF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6D442049
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 15:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751902484; cv=none; b=fkMmwMWwB6dO1hIsOhGe11F0NII1pIQqOi9w2u8J6XybJi7AX+8CfGkgargGVKEDO9E8tHW4wgXt9QwnvtvhORbodw9bSfXnXtC5QY/nv+S6lDIVKxx61Mln2ZPvx445Ap/w4aWZ2rJ2bZhEJ6aEgUAHihEYq3jYyGRzRlvmNOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751902484; c=relaxed/simple;
	bh=Gm2HviMnOw2RYyeKG0yGzeIo3cXAifm0whf6Vye+kSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z+zxQ98xP0GoNuc2P980ivJ8P9lRBLJcXdvEYUpocjq76cZgrFSlLAvMss3Tlg+Ae0Z0hJQOzrwNrTQqCkRF3kkhz2fve26hj3VArWr9ZTf8hR/q5P9lIpjw3CDyyDJkS81OA1Qqa58CplYbfwGC8PHDmSout+5nkwM5OMfLg74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A+RayFWF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751902481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0v2CaHY1VAi0HOiCc4Zf7ehSdSOjQyZPIEDJJM+6zG0=;
	b=A+RayFWFnsiFnny7RMPusMO/lB+c4iqFpfMKV3OprIe7fo3WAKNagKGYImR32/oySqhAmP
	OV58jr7lVO/nl95b3mWOYb+y9Nec+o5+kAMAJAjxRZVcPjVibsopjraQhr8w+7Bm3W3SfE
	H7reraSS2DWVafUjRZ6ktM2uLzB3m6s=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-9PJhDxnNPXOG1DSumY-iVQ-1; Mon, 07 Jul 2025 11:34:39 -0400
X-MC-Unique: 9PJhDxnNPXOG1DSumY-iVQ-1
X-Mimecast-MFC-AGG-ID: 9PJhDxnNPXOG1DSumY-iVQ_1751902478
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-32b71af3b28so7830731fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 08:34:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751902478; x=1752507278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0v2CaHY1VAi0HOiCc4Zf7ehSdSOjQyZPIEDJJM+6zG0=;
        b=fDI7fzjBLpXaXUL3gzZcatAZQyAT6IlGU16FKAvEjnlfjXhEpE09gHqBXyHmJeOETn
         ObJlpo/0MXgKDzaQVDc7329M5kpm8pa2pF8Sfq4ppyZdWGh+EFDLL5FUc6UKZLFdF8dk
         pwO3KHwYEwsa9cthElWyaWjLbv7T4dIMBLSsp13UQxpuV7o5BdpWYfSuqTsRZtjY9LmR
         GL90Q60bLT3m8du906L2pXKRxs4OFnGOfljPPf+/WPcxdOoYkKQcPj82nfULlEMdmRgX
         t2sZDQxAB0ONqVx9+SF+CGbk71BxLGCrq1YoDl3oFSwv+UJk0jkadtVAinR93uUFBCCP
         ViQA==
X-Forwarded-Encrypted: i=1; AJvYcCU6eyxE1eW2Q1c3YH10utwGuTC8mGq0pI+UQ35witEgr8c4CA5WVaW9kPuBMgYiuXlPJmZk6fsEBR1weTI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6+b9pfneEQA6pyxNeWq1+CmJ1YFHt2lPKHIGb3w5VKRZqL14B
	pFPRFi4eHYCooqf1FCETIA/Rq5AWhIqw+8ey8tJ3exlPzYfTaqXegtFb4pmOemstSrl72pyt3Ff
	qoHSDYyKJaA2vnOqDLO534bHZXT+CXpg1k2KLD+IQb4DV6FWIPfTCB6n/JBjdKHthiR8nVzI1w8
	XPVGP4qn5t3tzOOUs7Xk0BerW5JJPCyckU6VzB2AYQ
X-Gm-Gg: ASbGnctmuVytOqT0NGNbuQwP3aGiQj+pZpw7nb4OOAPsLEM0jsX9i0dZ2USOtPumnF5
	Xts5cc+jYxiyPXtRqsJNaVVgznmAtfnzTONRsoH1LAPNhI0iJFQetsjtM/ENnanMBcF846ig9AN
	DoXA==
X-Received: by 2002:a05:651c:511:b0:32a:7270:5c29 with SMTP id 38308e7fff4ca-32f00c8798cmr38754521fa.2.1751902478101;
        Mon, 07 Jul 2025 08:34:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKIHiywACdGBCTH/X8Ige8Yin2oQ8Gj/tg8va7lfqvYjW2jr4+erCyQPrXLSYqAtP0qHUjYrx+aoXHh15am7o=
X-Received: by 2002:a05:651c:511:b0:32a:7270:5c29 with SMTP id
 38308e7fff4ca-32f00c8798cmr38754371fa.2.1751902477586; Mon, 07 Jul 2025
 08:34:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625201853.84062-1-stuart.w.hayes@gmail.com>
 <20250703114656.GE17686@lst.de> <aGaklKejxefXTQB4@jeremy-HP-Z840-Workstation>
 <CA+-xHTFC6KTs6D8EdvmVe=buqw9oN5P7GJ-WWvam6M3SzeZF4g@mail.gmail.com> <aGgAuje4tpIOveFc@sultan-box>
In-Reply-To: <aGgAuje4tpIOveFc@sultan-box>
From: David Jeffery <djeffery@redhat.com>
Date: Mon, 7 Jul 2025 11:34:25 -0400
X-Gm-Features: Ac12FXy7hQPGBK3xlwuh3LCyK0QkERATPwkzNINwGBKvhalA6yUfuGbVbXEvMNc
Message-ID: <CA+-xHTFNRwbxH=zNMM4kasB=kUAne0b6cxPM+sq5FyM32k8peg@mail.gmail.com>
Subject: Re: [PATCH v10 0/5] shut down devices asynchronously
To: Sultan Alsawaf <sultan@kerneltoast.com>
Cc: Jeremy Allison <jra@samba.org>, Christoph Hellwig <hch@lst.de>, Stuart Hayes <stuart.w.hayes@gmail.com>, 
	linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Martin Belanger <Martin.Belanger@dell.com>, 
	"Oliver O'Halloran" <oohall@gmail.com>, Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>, 
	Lukas Wunner <lukas@wunner.de>, Jeremy Allison <jallison@ciq.com>, Jens Axboe <axboe@fb.com>, 
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org, 
	Nathan Chancellor <nathan@kernel.org>, Jan Kiszka <jan.kiszka@seimens.com>, 
	Bert Karwatzki <spasswolf@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 4, 2025 at 12:26=E2=80=AFPM Sultan Alsawaf <sultan@kerneltoast.=
com> wrote:
>
> On Fri, Jul 04, 2025 at 09:45:44AM -0400, David Jeffery wrote:
> > On Thu, Jul 3, 2025 at 12:13=E2=80=AFPM Jeremy Allison <jra@samba.org> =
wrote:
> > >
> > > On Thu, Jul 03, 2025 at 01:46:56PM +0200, Christoph Hellwig wrote:
> > > >On Wed, Jun 25, 2025 at 03:18:48PM -0500, Stuart Hayes wrote:
> > > >> Address resource and timing issues when spawning a unique async th=
read
> > > >> for every device during shutdown:
> > > >>   * Make the asynchronous threads able to shut down multiple devic=
es,
> > > >>     instead of spawning a unique thread for every device.
> > > >>   * Modify core kernel async code with a custom wake function so i=
t
> > > >>     doesn't wake up threads waiting to synchronize every time the =
cookie
> > > >>     changes
> > > >
> > > >Given all these thread spawning issues, why can't we just go back
> > > >to the approach that kicks off shutdown asynchronously and then wait=
s
> > > >for it without spawning all these threads?
> > >
> > > It isn't just an nvme issue. Red Hat found the same issue
> > > with SCSI devices.
> > >
> > > My colleague Sultan Alsawaf posted a simpler fix for the
> > > earlier patch here:
> > >
> > > https://lists.infradead.org/pipermail/linux-nvme/2025-January/053666.=
html
> > >
> > > Maybe this could be explored.
> > >
> >
> > Unfortunately, this approach looks flawed. If I am reading it right,
> > it assumes async shutdown devices do not have dependencies on sync
> > shutdown devices.
>
> It does not make any such assumption. Dependency on a sync device is hand=
led
> through a combination of queue_device_async_shutdown() setting an async d=
evice's
> shutdown_after and the synchronous shutdown loop dispatching an "async" s=
hutdown
> for a sync device when it encounters a sync device that has a downstream =
async
> dependency.
>

Yes, but not what I think fails. This handles a sync parent having an
async child. It does not handle the reverse, a sync child having an
async parent.

For example, take a system with 1 pci nvme device. The nvme device
which is flagged for async shutdown can have sync shutdown children as
well as a sync shutdown parent. The patch linked pulls the async
device off the shutdown list into a separate async list, then starts
this lone async device with queue_device_async_shutdown from being on
the async list. The device then is passed to the async subsystem
running shutdown_one_device_async where it will immediately do
shutdown due to a zero value shutdown_after. The patch sets
shutdown_after for its parent, but there is nothing connecting and
ordering the async device to its sync children which will be shutdown
later from the original device_shutdown task.

> > Maintaining all the dependencies is the core problem and source of the
> > complexity of the async shutdown patches.
>
> I am acutely aware. Please take a closer look at my patch.
>

I have, and it still looks incomplete to me.

David Jeffery


