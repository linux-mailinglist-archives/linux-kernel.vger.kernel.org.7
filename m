Return-Path: <linux-kernel+bounces-762695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD6DB209F2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 15:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE6421662CE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4D72DC321;
	Mon, 11 Aug 2025 13:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YiCAYCpB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD349277CB8
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 13:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754918337; cv=none; b=p0Wpb1kPZETzlFkHXR+xHd9Du0eDXyBdiTW93Qu59jqsSw1+2LKnJtVh0qzA9GOxKKQLlG7srZqC5hcKoyApflOKt0byUVR5Dx6lfdlkJu0+3vE2bslPRPCvhMVzur6xdiiQaB2RwhENyU1wCxOYyrCJ3J6f7A2yCXoypDr3uMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754918337; c=relaxed/simple;
	bh=YurnktU6uLK/QMMiHdEUOXfRLMdcVqtaWTbxLFOUN3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=foHGptLLBgwEF8GbVvDBiAq3y0g9Xv5XWqH0fkwKcDwKBMdc1PSjls1uDfC0YeHUR5lpj/GvGuQ6uW8UMKXirzBk7fexiFWA9IMt6MFpx0wawvdHfQVhUVJ+k5L2NIsgu7Z8ng6mZyG1PyhKvBamnomU4K6MpXQ2mcbpNzz4nXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YiCAYCpB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754918334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eybU9c2mDvdB/SAMfEZIKdU5KhZDaZNeqdGbPmyFJI4=;
	b=YiCAYCpB5vo6Y/XzAwHHGdNDdZwLSy7o3iUmWU8IsAq+JcaAxESvd3cxIezh25MXcbUZOI
	+4TQhJ79fLC+bEnb25hUfXp+NuBPbpilbC6iH0KM6SrU/cr6TLedhW/Lk9FDedkWIO6Lvi
	YVHktsq2Kwc9q0ALhsC6z09LfVX4780=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-124-l5x060c7OpOwLNUxTQ9DaA-1; Mon,
 11 Aug 2025 09:18:49 -0400
X-MC-Unique: l5x060c7OpOwLNUxTQ9DaA-1
X-Mimecast-MFC-AGG-ID: l5x060c7OpOwLNUxTQ9DaA_1754918327
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ACC2E18002B1;
	Mon, 11 Aug 2025 13:18:46 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.224.64])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A47A419560AD;
	Mon, 11 Aug 2025 13:18:45 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 155C21800091; Mon, 11 Aug 2025 15:18:43 +0200 (CEST)
Date: Mon, 11 Aug 2025 15:18:43 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: dan.j.williams@intel.com
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	linux-coco@lists.linux.dev, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bhelgaas@google.com, aik@amd.com, lukas@wunner.de, Samuel Ortiz <sameo@rivosinc.com>, 
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: Re: [PATCH v4 05/10] samples/devsec: Introduce a PCI device-security
 bus + endpoint sample
Message-ID: <mckkt3aiggiqogigbms4kcysaaqw5toieot5vvfw55smti4acr@mbwb2oe6jp7g>
References: <20250717183358.1332417-1-dan.j.williams@intel.com>
 <20250717183358.1332417-6-dan.j.williams@intel.com>
 <20250729161643.000023e7@huawei.com>
 <6892c9fe760_55f09100d4@dwillia2-xfh.jf.intel.com.notmuch>
 <20250806121625.00001556@huawei.com>
 <68939feeef7d9_55f09100c7@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68939feeef7d9_55f09100c7@dwillia2-xfh.jf.intel.com.notmuch>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Wed, Aug 06, 2025 at 11:33:18AM -0700, dan.j.williams@intel.com wrote:
> Jonathan Cameron wrote:
> > 
> > +CC Gerd, of off chance we can use a Redhat PCI device ID for kernel
> > emulation similar to those they let Qemu use.
> > 
> [..]
> > > > Emulating something real?  If not maybe we should get an ID from another space
> > > > (or reserve this one ;)  
> > > 
> > > I am happy to switch to something else, but no, I do not have time to
> > > chase this through PCI SIG. I do not expect this id to cause conflicts,
> > > but no guarantees.
> > 
> > Nothing to do with the SIG - you definitely don't want to try talking them
> > into giving a Vendor ID for the kernel.  That's an Intel ID so you need to find
> > the owner of whatever tracker Intel uses for these.
> 
> About the same level of difficulty...
> 
> > Or maybe we can ask for one of the Redhat ones (maintained by Gerd).

Well, they are meant for virtual devices emulated by qemu (and the
registry is docs/specs/pci-ids.rst in the qemu repo).

We made exceptions to that rule before (linux/samples/vfio-mdev/mdpy.c
got one for example).  So feel free to try sending a patch with an
update to qemu-devel.  There should be a /good/ explanation why you want
go that route, and "I'm to lazy to get one from my employer" is not what
I'd consider "good".  Also it's qemu release freeze and vacation season
right now, so don't expect this process to be fast.

take care,
  Gerd


