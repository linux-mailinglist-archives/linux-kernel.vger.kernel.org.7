Return-Path: <linux-kernel+bounces-856562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FE9BE47C9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B79571885D5D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DAB332D0E5;
	Thu, 16 Oct 2025 16:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="jaxC8P5Z"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D44132D0FE
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 16:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760631153; cv=none; b=P8D1dubDcPzw2m5qBTfBqvr5622FPSTe+mRJseaXJqovwo4O0NoKps590pHBPRdNV4ZqbtIv9FS+vBXo7xr/rnhjI3vABLk4b1RXPLCIPCxzKbdZrzdFx0VE1Psr2UyTya7tMcm0D06z1mgrl1ubPWoRmBrZtDZseAuiSkeOh5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760631153; c=relaxed/simple;
	bh=tK4nBP5ZW/n2FdmfrGNvfW9qpVfWyHpShwt5hD7hYq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rkOxy0SbrEhN9CPVVE8fQUx/o8LVtXNe+lFXtbt+2fjt9Ih+8muZbY4/iodCSDhcARVJoqlDV/Oe+Q/Am9t6gLVJqBcPW5bwrbapBY7VG7rWZ6nJEsqIAxm8HQPrYQ9Y9maqsoVvOZbNY5S1b3PbYmGPyHhhenOnR3cUu728Ht0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=jaxC8P5Z; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7a8e7ece907so672448a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 09:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1760631151; x=1761235951; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NRpFtwXiNMgpIA5IWo+QdMTjYy97Q0e03I3R5kmEU0I=;
        b=jaxC8P5ZdX+2dcRx5TCxX1uZc0Q6oaUpLMDlFSQc0zyb8/gHWFrDUvmzP1Xa53abks
         u69hbRpPmWCogqpxguvHvhiVpnV8q99Igp+71nemYzF0lxI4rnw1Zui1UqCU7rfR6CPL
         hAumvxLYWmKPQ9QMup6KetKnjVC+fYO34GPQnI8LCjEpBqjFE1CSM0BOZR0vgLEKNxeL
         euvZQWmQwR/VBCLLF7UKsAeBVYX+4iRgOvdopXlVGC38Oj12hKcwQt9zoS/zxo8aQi4M
         sH438KffssiXWLEuE1WDPo49O3C3ocWREAHx9UEtWS36sVyHtg1VNk4UvxXLSh2ean+I
         aKUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760631151; x=1761235951;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NRpFtwXiNMgpIA5IWo+QdMTjYy97Q0e03I3R5kmEU0I=;
        b=ABSDgP3DIK4VE8KjOsU6fXYWSxSqiKNF+8FeFrpdyBAq1p7/NpFXFsyj0DpMerNWWI
         LzbjaCKJHlaVQwG30fP0M8iCy8LwKHbTB/VEtV0ZKTKFALEL2Fk2E5OeusCf5PZgegsY
         wkiIBLhkxYgRCNV95qtHwpHi5DSIF8O5WDTlmZBTpYvhnjrXOv2EcY9KLuMXVALuz7XJ
         K3/VuSLweRFYRmWNjXgF98fzIAAopdzBxW9AgSRwW8TuR5ug4KnACstHVCog71CqxszV
         +O5oMTJOUvBtZL4mFmpKPGIZArvjz8TS43uZhGYrsr1QOSsuWN2qL5iYMRkJxBUYpbJf
         YpYA==
X-Forwarded-Encrypted: i=1; AJvYcCU2mU1MUCSp5hr4V+n2/cNdHKqidEeeNudrciJlf7ElnOyPf8dDkmTR4ju30U+8E7YR790WipJCGZpih1c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7kfWJXAjLF5mfNMosyoyuazbIS6otg5QZ/5Vy61/fMBJrX42i
	6TyRFxtJIzeQvJUzjvw6WXseA24/fP1nnaCzY3/BkromMzdaKQ0n1hNshEhMizPrngc=
X-Gm-Gg: ASbGnctuK7mlePINfA3bEu0Ty4Za0+Cnmpn//9PrbjWitLuWniE/XOWGvUIVUnWHCeW
	cQAuLft8gfu67PzFqeHXqOfeL+Y3wojBa65R4J7W6M9wH5FlpKLi/8VuKPDuZWWHjuDc4yRrvgu
	KA0qTotZ7ZkyEe4BP8ZaYJ2/XGfa44wWNjn3MyCZKB4gc9cpWoYrywgAMGOr90YSFvVzZIkdyXF
	HTNDClCbNPR66pWLtN1wQZe1DjeoqKF1cs5zyZUWA4uajls7QP+uLqiS8mtZ+EzTcYYJ7zEs7AE
	O8R51/1rYPedE0xbZu71Mx7VODW4lg1lk939wlwlIDJ/DpdJYRIBbZh4mftM6s8CAD9zr4ASyuF
	NZ6QqLV/E5jesB3fiMbtuRlOlRhtaacNAxZL0rgw/qCWo+QKeyFIkXE4ZJAOB
X-Google-Smtp-Source: AGHT+IFlsd4BFifhkmjK0hoI9D1z1RM0tIuhzOXEXydeMOREIODbN5VKBxSZiUJ/7vXGUgtPglp42A==
X-Received: by 2002:a05:6830:719e:b0:7a4:a993:da38 with SMTP id 46e09a7af769-7c27cbd6276mr186364a34.34.1760631151017;
        Thu, 16 Oct 2025 09:12:31 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c27a206ac7sm278507a34.17.2025.10.16.09.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 09:12:30 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v9Qab-00000000V4E-2PEx;
	Thu, 16 Oct 2025 13:12:29 -0300
Date: Thu, 16 Oct 2025 13:12:29 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Haakon Bugge <haakon.bugge@oracle.com>
Cc: Sean Hefty <shefty@nvidia.com>, Jacob Moroni <jmoroni@google.com>,
	Leon Romanovsky <leon@kernel.org>,
	Vlad Dumitrescu <vdumitrescu@nvidia.com>,
	Or Har-Toov <ohartoov@nvidia.com>,
	Manjunath Patil <manjunath.b.patil@oracle.com>,
	OFED mailing list <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH for-next] RDMA/cm: Rate limit destroy CM ID timeout error
 message
Message-ID: <20251016161229.GM3938986@ziepe.ca>
References: <20250912100525.531102-1-haakon.bugge@oracle.com>
 <20250916141812.GP882933@ziepe.ca>
 <CAHYDg1Rd=meRaF=AJAXJ+5_hDaJckaZs7DJUtXAY_D2z_a6wsw@mail.gmail.com>
 <D2E28412-CC9F-497E-BF81-2DB4A8BC1C5E@oracle.com>
 <ABD64250-0CA0-4F4F-94D3-9AA4497E3518@oracle.com>
 <07DE3BC6-827E-4311-B68B-695074000CA3@oracle.com>
 <20251015164928.GJ3938986@ziepe.ca>
 <CH8PR12MB97419E98111F553FCC117E36BDE8A@CH8PR12MB9741.namprd12.prod.outlook.com>
 <20251015184516.GK3938986@ziepe.ca>
 <49A8CE60-DC8E-43F7-9620-D4D5F8EB2A08@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49A8CE60-DC8E-43F7-9620-D4D5F8EB2A08@oracle.com>

On Thu, Oct 16, 2025 at 03:25:15PM +0000, Haakon Bugge wrote:
> 
> 
> > On 15 Oct 2025, at 20:45, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > 
> > On Wed, Oct 15, 2025 at 06:34:33PM +0000, Sean Hefty wrote:
> >>>> With this hack, running cmtime with 10.000 connections in loopback,
> >>>> the "cm_destroy_id_wait_timeout: cm_id=000000007ce44ace timed out.
> >>>> state 6 -> 0, refcnt=1" messages are indeed produced. Had to kill
> >>>> cmtime because it was hanging, and then it got defunct with the
> >>>> following stack:
> >>> 
> >>> Seems like a bug, it should not hang forever if a MAD is lost..
> >> 
> >> The hack skipped calling ib_post_send.  But the result of that is a
> >> completion is never written to the CQ.
> 
> 
> Which is exactly the behaviour I see when the VF gets "whacked". This is from a system without the reproducer hack. Looking at the netdev detected TX timeout:
>
> mlx5_core 0000:af:00.2 ens4f2: TX timeout detected
> mlx5_core 0000:af:00.2 ens4f2: TX timeout on queue: 0, SQ: 0xe31ee, CQ: 0x484, SQ Cons: 0x0 SQ Prod: 0x7, usecs since last trans: 18439000
> mlx5_core 0000:af:00.2 ens4f2: EQ 0x7: Cons = 0x3ded47a, irqn = 0x197
> 
> (I get tons of the like)
> 
> There are two points here. All of them has "SQ Cons: 0x0", which to me implies that no TX CQE has ever been polled for any of them.
 
> The other point is that we do _not_ see "Recovered %d eqes on EQ
> 0x%x" (which is because mlx5_eq_poll_irq_disabled() always returns
> zero), which means that either a) no CQE has been generated by the
> HCA or b) a CQE has been generated but no corresponding EQE has been
> written to the EQ.

Lost interrupts/cqe are an obnoxiously common bug in virtualization
environments. Be sure you are running latest NIC firmware. Be sure you
have all the qemu/kvm fixes.

But yes, if you hit these bugs then the QP gets effectively stuck
forever.

We don't have a stuck QP watchdog for the GMP QP, IIRC. Perhaps we
should, but I'd also argue if you are loosing interrupts for GMP QPs
then your VM platform is so broken it won't succeed to run normal RDMA
applications :\

At the end of the day you must not have these "TX timeout" type
errors, they are very very serious. Whatever bugs cause them must be
squashed.

> >>  The state machine or
> >> reference counting is likely waiting for the completion, so it knows
> >> that HW is done trying to access the buffer.
> > 
> > That does make sense, it has to immediately trigger the completion to
> > be accurate. A better test would be to truncate the mad or something
> > so it can't be rx'd
> 
> As argued above, I think my reproducer hack is sound and to the point.

Not quite, you are just loosing CQEs. We should never loose a CQE.

Yes perhaps your QP can become permanently stuck, and that's bad. But
the fix is to detect the stuck QP, push it through to error and drain
it generating all the err CQs without any loss.

To better model what you are seeing you want to do something like
randomly drop the GMP QP doorbell ring, that will cause the QP to get
stuck similar to a lost interrupt/etc.

Jason

