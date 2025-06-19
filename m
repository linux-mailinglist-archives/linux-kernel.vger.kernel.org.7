Return-Path: <linux-kernel+bounces-692988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F7BADF9A7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jun 2025 01:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1EBB1789D8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 23:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95E527FB14;
	Wed, 18 Jun 2025 23:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="CVpuZUbS"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B714B1C2324
	for <linux-kernel@vger.kernel.org>; Wed, 18 Jun 2025 23:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750288086; cv=none; b=t9h7MrXM7bu36fiBegy9U0X6FoHA/TzbXCnk64IiunIKboAiqHB/+mnvlavu6VgOGz/oEZIpV1yU7JOegykBeBru6THERyRWg3n/hiHVM25G9/zXk/K3PgSR8J0DDl9kJXjamTVUc1KmF8YIVha5fDkv5jPu/AkCfMZBcn1jspA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750288086; c=relaxed/simple;
	bh=N6vkA6XyZvytlKbYFVtn5MMNpiaj7TIFAGlgh/pbydM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eE+pfm1dxXtIDiZKR6hG7fFGbeV1L4HT0tL9V5wmUq+lhO79h3tLl7/FW81b2X7cU0+N6f6+dIKyNNaecD95KzJtw39aaF8gD4SSN8AOk/1Kx89WYvZAgizHhmuqMMmJUsKc9sUA/BCJwMtN3i+mNBofOlSihIhQr3w/EBBYSxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=CVpuZUbS; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from DESKTOP-0403QTC. (unknown [40.65.108.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id 11B6F2119373;
	Wed, 18 Jun 2025 16:08:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 11B6F2119373
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1750288083;
	bh=fXneXgh6kwJBiXWbwt1qYNjG2yxkkWpVOm1C4PjW2lY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Reply-To:From;
	b=CVpuZUbS+XKxNffVoN5T6pyOADeRhaynfFbesjSb3O0f3k0ED9p5s1o3SRwk2O0SP
	 VQomVESe7xOZXkOG9KmwcbxSwfwTZog6lpUVE3fAU90lulAurvtXL8AfB9dsniCs7m
	 gY5ZjV7/dhWF1YjFi3aYktDEShDpszwL58G8lE3k=
Date: Wed, 18 Jun 2025 16:08:01 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, linux-kernel@vger.kernel.org,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>, "Liu, Yi L"
 <yi.l.liu@intel.com>, Zhang Yu <zhangyu1@microsoft.com>, Easwar Hariharan
 <eahariha@linux.microsoft.com>, Saurabh Sengar
 <ssengar@linux.microsoft.com>, jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v2 1/2] vfio: Prevent open_count decrement to negative
Message-ID: <20250618160801.6ccec26e@DESKTOP-0403QTC.>
In-Reply-To: <20250616084001.20ed53aa.alex.williamson@redhat.com>
References: <20250603152343.1104-1-jacob.pan@linux.microsoft.com>
	<20250613163100.7efa6528.alex.williamson@redhat.com>
	<20250614000926.GQ1174925@nvidia.com>
	<20250616084001.20ed53aa.alex.williamson@redhat.com>
Reply-To: jacob.pan@linux.microsoft.com
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Alex,

On Mon, 16 Jun 2025 08:40:01 -0600
Alex Williamson <alex.williamson@redhat.com> wrote:

> On Fri, 13 Jun 2025 21:09:26 -0300
> Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > On Fri, Jun 13, 2025 at 04:31:00PM -0600, Alex Williamson wrote:  
> > > Hi Jacob,
> > > 
> > > On Tue,  3 Jun 2025 08:23:42 -0700
> > > Jacob Pan <jacob.pan@linux.microsoft.com> wrote:
> > >     
> > > > When vfio_df_close() is called with open_count=0, it triggers a
> > > > warning in vfio_assert_device_open() but still decrements
> > > > open_count to -1. This allows a subsequent open to incorrectly
> > > > pass the open_count == 0 check, leading to unintended behavior,
> > > > such as setting df->access_granted = true.
> > > > 
> > > > For example, running an IOMMUFD compat no-IOMMU device with
> > > > VFIO tests
> > > > (https://github.com/awilliam/tests/blob/master/vfio-noiommu-pci-device-open.c)
> > > > results in a warning and a failed VFIO_GROUP_GET_DEVICE_FD
> > > > ioctl on the first run, but the second run succeeds incorrectly.
> > > > 
> > > > Add checks to avoid decrementing open_count below zero.    
> > > 
> > > The example above suggests to me that this is a means by which we
> > > could see this, but in reality it seems it is the only means by
> > > which we can create this scenario, right?    
> > 
> > I understood this as an assertion hit because of the bug fixed in
> > patch 2 and thus the missed assertion error handling flow was
> > noticed.
> > 
> > Obviously the assertion should never happen, but if it does we
> > should try to recover better than we currently do.  
> 
> Certainly.  My statement is trying to determine the scope of the issue
> from a stable perspective.  Maybe I'm interpreting "[f]or example" too
> broadly, but I think this is unreachable outside of the specific
> described scenario, ie. using iommufd in compatibility mode with
> no-iommu.  Further, it only became reachable with 6086efe73498.
> 
> In any case, it fixes something and we should attribute that
> something, whether it's 6086efe73498 or we want to reach back to when
> the assert was introduced and claim it should have had a return even
> if it was unreachable.
> 
> It seems these patches should also be re-ordered if not rolled into
> one.  Fixing the issue in 2/ makes this once again unreachable, so I
> don't mind it coming along as a "also handle this error case better."
> This alone doesn't really do much.  Thanks,
> 
IMHO, this is an independent exception handling fix, perhaps I just add
the missing tag below?

Fixes: 05f37e1c03b6 ("vfio: Pass struct vfio_device_file * to
vfio_device_open/close()")

Thanks,

Jacob

