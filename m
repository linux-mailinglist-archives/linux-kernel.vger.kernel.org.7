Return-Path: <linux-kernel+bounces-837933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A441BAE191
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 18:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B332E4C0F7F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 16:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80AA42566F7;
	Tue, 30 Sep 2025 16:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C4CvMKfn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE0D24E4BD
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 16:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759251177; cv=none; b=iYAI+zCJMzSlTb5O1M3UizDfHaoELFr25AsIiRe3bxOyVvmjqM0DEn4jMRVjgiM7np9Q89GMkGnVP2f4G0YjmEF48nCVHz+y80LuzMkslajvC6byO0rmgGU9NCIIT8MMIkXItSrFsyS7nOqBR1ZaqYWlkruJBybbxsXslBP0MOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759251177; c=relaxed/simple;
	bh=XRHExvG/tHB5daSSKAmQDIMiwtytKVKqlEgrmiHYtGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qSyw7WXaPIFEJcOqCnIsV+OHTlcADybNFjcYdl4VpC6jk6+TQwedQx3xSjCPmYXHY0dTqy2zsY4DUA51HmLu/uRQlBhtU0lGFuXwTzfb7emp6MOPywg1uZI8W0eZbpE482nDLAPZqzcQ0TS8TW3sDnPCzU0scyVh04wbt5egAWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C4CvMKfn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759251175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JryoONnZtvrch8iWe5kQa/bp3US7CnLH1VFoC2oPQRw=;
	b=C4CvMKfnfsBwv/UV11NrYVILm3XQU5yOggbiFAlOCcDCemcY97Cn4bwXobrQuRvlzMI4Oz
	mrawaozBGewhSKsyc1yfWzDQp+PgIzf+CkCF80PggI25T6UCLny6qW6Av7sLEG7ZZin66O
	2hIxka+TFnVE75hvoNWCWnFId5SBkEY=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-UfHzugVzOemVirXY2iVQgg-1; Tue, 30 Sep 2025 12:52:51 -0400
X-MC-Unique: UfHzugVzOemVirXY2iVQgg-1
X-Mimecast-MFC-AGG-ID: UfHzugVzOemVirXY2iVQgg_1759251171
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7a05c527bf6so1190605a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 09:52:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759251171; x=1759855971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JryoONnZtvrch8iWe5kQa/bp3US7CnLH1VFoC2oPQRw=;
        b=vW692TFhOLZlshJ9/2NIHdcCoE+LrV8CMcE8jCAq2SKTTJSWMx3Ooq3UAyvB9qJ3QE
         SLXTvkPrAxfMtydcwWeymO+vbxDiT/P1npvxNQGj7BcgKKwKp9zg+iP/aFp54JDIRaiI
         n/NnFT0dB9dLMARY4tVAFygd0GS+mxVEI6An2Yyb+eu55gtcqNDAiw4qg+n2T/lyFduT
         VyS+NQPmwdFuwITmqdczTjWIkRKbzb4Ms7D/UjfM4+pleU+j7XFx9sH+V6VteSnouZuz
         vNXK5YeW2OPP7Lb9nbYGPVWVFOLIGZ8GKwcCbu9lazvc4RDROzqL2vXTT3H3dcPJPZXZ
         3H1w==
X-Forwarded-Encrypted: i=1; AJvYcCWQBQZpruDv4dVDVDN3cQOOoBgGGbG51DMenORxE0fg4Ic2IIrIALGA7axP0uued1Xi9gnpcY0PflzlUms=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpO3efAfUVxv415SrWocfoFlZlK08y6zi8rrjnLfbBiFraDCn+
	qWqKNjZ2MUwDhG/DIW63qXCp6QRMLWRZ6Yb7TdUYUG+uhD14CeaeC6YXxiRzy/pqpCimUccHx9C
	6UYWIJw90IH8okZn5N92c0wZI1mTuDZ9KKpRiSLE+nukFyCamTExPMQ37FCA84eeeTw==
X-Gm-Gg: ASbGncuplrTD6eYq/c7rp/yTpN/+IG50aZm/gC8J5ItqgHGc0Ek9FWQrpj+tL+ku3+J
	FSbw60bxB69/RRuwr+lDak5XG/eqfLCgz3lINuksxPuA54LMPEohovzw2DhxbRqTmbpK+cus9Xv
	mdcCw/oJNgSc6TjEkeC112gEUhzWELzRQgCEj8hQtOdNaIZzzhxu1P4tZdDCDpRkbjkzrm6Q5ca
	WmUg8nTNVpnasNaVnslqC7rS5YnXSlTAcWRgKIUF9AJfyyt9AatfhgvktZ74FWxd8KfvqdmOmZp
	LuiHA/5MFScoCTam/5NGS9GNyIr+IML/BrUkSyyVdEypaNxQ
X-Received: by 2002:a05:6808:f86:b0:438:33fd:317c with SMTP id 5614622812f47-43fa41bd61fmr82468b6e.3.1759251171049;
        Tue, 30 Sep 2025 09:52:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwZ3/lKZz7Fdu2TvHNlTbKRk5qveSl6rvSejYaxAMAP02EZ6HQb/uugFp+9XcOcN4obhcZxg==
X-Received: by 2002:a05:6808:f86:b0:438:33fd:317c with SMTP id 5614622812f47-43fa41bd61fmr82463b6e.3.1759251170626;
        Tue, 30 Sep 2025 09:52:50 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43f51238c63sm2746753b6e.22.2025.09.30.09.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 09:52:49 -0700 (PDT)
Date: Tue, 30 Sep 2025 10:52:47 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Shameer Kolothum <skolothumtho@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Jens Axboe <axboe@kernel.dk>, Joerg Roedel
 <joro@8bytes.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, Logan Gunthorpe <logang@deltatee.com>, Marek
 Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, Vivek Kasireddy
 <vivek.kasireddy@intel.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v4 10/10] vfio/pci: Add dma-buf export support for MMIO
 regions
Message-ID: <20250930105247.1935b553.alex.williamson@redhat.com>
In-Reply-To: <20250930143408.GI2942991@nvidia.com>
References: <cover.1759070796.git.leon@kernel.org>
	<53f3ea1947919a5e657b4f83e74ca53aa45814d4.1759070796.git.leon@kernel.org>
	<20250929151749.2007b192.alex.williamson@redhat.com>
	<20250930090048.GG324804@unreal>
	<CH3PR12MB754801DC65227CC39A3CB1F3AB1AA@CH3PR12MB7548.namprd12.prod.outlook.com>
	<20250930143408.GI2942991@nvidia.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Sep 2025 11:34:08 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, Sep 30, 2025 at 12:50:47PM +0000, Shameer Kolothum wrote:
> 
> > This is where hisi_acc reports a different BAR size as it tries to hide
> > the migration control region from Guest access.  
> 
> I think for now we should disable DMABUF for any PCI driver that
> implements a VFIO_DEVICE_GET_REGION_INFO
> 
> For a while I've wanted to further reduce the use of the ioctl
> multiplexer, so maybe this series:
> 
> https://github.com/jgunthorpe/linux/commits/vfio_get_region_info_op/
> 
> And then the dmabuf code can check if the ops are set to the generic
> or not and disable itself automatically.
> 
> Otherwise perhaps route the dmabuf through an op and deliberately omit
> it (with a comment!) from hisi, virtio, nvgrace.
> 
> We need to route it through an op anyhow as those three drivers will
> probably eventually want to implement their own version.

Can't we basically achieve the same by testing the ioctl is
vfio_pci_core_ioctl?  Your proposal would have better granularity, but
we'd probably want an ops callback that we can use without a userspace
buffer to get the advertised region size if we ever want to support a
device that both modifies the size of the region relative to the BAR
and supports p2p.  Thanks,

Alex


