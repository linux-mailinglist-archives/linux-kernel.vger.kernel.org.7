Return-Path: <linux-kernel+bounces-753654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B77DBB185FB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 18:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE2ED3A212B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 16:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BFF1D5CC6;
	Fri,  1 Aug 2025 16:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="MTNFV2F3"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADE913B58D
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 16:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754066801; cv=none; b=Q/WJ/cYOOokSbOFThqDrfjHfxj4kYmLtkzaRKPv/lBhVo5HjDK2gnWAi5yMpLYsphjWrYknYR9+/QZG7bnJf0w78fEWhO8ZfnGH9Pk/qIDykujjdT+SxWN7IcNvDNgZupn/2r+PXMTM9sYAzdygkJpf4ABW5ygCN3AejRTB76W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754066801; c=relaxed/simple;
	bh=m1M89TETP+J1IQAu9w4QTKb4VwkHxMScxMjR/5Na2xY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TujTBZEDvDOBfOK1jreYOo1KvEeZ+Obl+pElDfz/bIaKLtVbpUTRJMfS1WYDtPybUVRNSNoReBZeuNFejDVyRGfCsRyID8g0O1F17KtqntqeZiKmAg7XW0l0MzRxsD33nGo1lFSjk9KPEVK6qzuD1RGIWt/znvmvF/49+xTu7Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=MTNFV2F3; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-70744318bb3so9428416d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 09:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1754066799; x=1754671599; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5oUm5wK6G92WfMPCbUZUcR35sqkaEU8gvzPmgYYYTFg=;
        b=MTNFV2F3EhdyihpR819XT0u/Gb0o7pwppssHNRDq1xx27TSlX87qDWSASBIOEvbefH
         mV/78yKei1zjqp9Ius5/bD7NrIcz9LjqDXmQaqvCPFkQGtpf7eyLuV7XY93a8f97qGbU
         WIqFVDEWgI1KknfxNsxzGn8VoeiQQNdV+wBL7l3t/bMCjmbIHHhSrAbJFBQDpXokXheS
         +JTaICY942MQviGCYyQI7DJdfQnkTOIu7/fbbjNptlIw5buo/2l5lkEnv6bcgimYWjA3
         dFVVq3k6VVYxzM8u/iFI99n/WH3LBDc/FSwMZE2NR78KMxfAdxFo2QfeheTy2zDRhiLH
         YtAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754066799; x=1754671599;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5oUm5wK6G92WfMPCbUZUcR35sqkaEU8gvzPmgYYYTFg=;
        b=JTPxLfLSXqj8F7zpRKOPwsj4tZDfgLO10Hfmnk2kqzmLNdvZRhP3RDFkRmNCXlJAY0
         2nsfarGK7GYJb9AQ08sN/2pBPR9sjlfmGFWITb6p0Flh36HBBgYjfM7LHybN0mXYtWqT
         vfAFhd5536Uc/MtLddp1qJmZ/e3MyV+7mTQDZ0/13OIVMZZHWsKJ1FgwJweriRtQ3wVv
         Waz/qGCzDgynZx7touHFqDsoI8hTNtfi+5PcdKYuYOk8vMyDkgTgPfrAPHgC5M4idEg4
         hPbsgJyCc/W/m9yVpBr7Bab4Dd6TtcPe2onwKP4MFw6c61IIibaMnb2GP7sjqVcoVVhg
         MCtw==
X-Forwarded-Encrypted: i=1; AJvYcCWVOUuvMlNQoNJKikmuBEyhtd/ev4/cnuIJXKQQ2jEP0u+uj5lSaO1JD7JIfR0XcTEYN+D+MJFZTuEG8Mo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsYYYdxy+0YT+jJtrgLDh7ugg/i79kJYMxsja2SwYCiLVoCSUA
	iecVznIimnmSWM3iTv3z5vMlKpKALXAUu4KzoM5hsRESQCBYXZZFN9R2kl+2cjKDhS0=
X-Gm-Gg: ASbGncvf1XlFTaIaj/Croq9/9+qBvT3gA2qso2JAPMvk2Dy3rl2KRl/Fu9nR67MoVvh
	F0qSKconv5MttcLeBFod3V5eG6XveXSrfaoaAlUFEvuD008Ry6YwFtweOQDC8e3rMSLf2DXG24A
	DUhTYLzUrwYoKiClj2lzMkdROuT8Fvicc5cEw8BH84cQSZzcEXMqLpmkiVYpUcZXL2dVi00xV0z
	cAlly+QsX6IGLcpHhZhMKIzvNWA5ReyiTusw/bY9NhWwV/wR7b9KDWwDM576O0lCGzqp9oNkFXc
	1S4yAbyYyjZPjS8y5o/YBAGC6FhDnkGCa4ug8fO0fZrc6sW0a1MRgO0luRbk3m/jfkITe2j/jsw
	wozk0usP/4GCAYHxy3BtCKry8Wfd1so6RykNUilEtXtM8BsGcZ99VgKP5gUZVf8OXWUg8WsI3En
	d4jU0=
X-Google-Smtp-Source: AGHT+IGVVOWQB4/1iDofT+YAUuJwKo0n0CGvBCRj9fO4gfCwpoC+KN12czXAx1xbZXDfGO7Jsn2RQw==
X-Received: by 2002:ad4:5aaf:0:b0:707:43cb:d9ef with SMTP id 6a1803df08f44-70935fb0820mr5596516d6.21.1754066798378;
        Fri, 01 Aug 2025 09:46:38 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077c9d6db9sm23142096d6.14.2025.08.01.09.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 09:46:37 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uhstx-000000013A0-19T8;
	Fri, 01 Aug 2025 13:46:37 -0300
Date: Fri, 1 Aug 2025 13:46:37 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@infradead.org>
Cc: Yonatan Maman <ymaman@nvidia.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Leon Romanovsky <leon@kernel.org>, Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Alistair Popple <apopple@nvidia.com>,
	Ben Skeggs <bskeggs@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Or Har-Toov <ohartoov@nvidia.com>,
	Daisuke Matsuda <dskmtsd@gmail.com>, Shay Drory <shayd@nvidia.com>,
	linux-mm@kvack.org, linux-rdma@vger.kernel.org,
	dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, Gal Shalom <GalShalom@nvidia.com>
Subject: Re: [PATCH v2 4/5] RDMA/mlx5: Enable P2P DMA with fallback mechanism
Message-ID: <20250801164637.GE26511@ziepe.ca>
References: <20250718115112.3881129-1-ymaman@nvidia.com>
 <20250718115112.3881129-5-ymaman@nvidia.com>
 <aH3mTZP7w8KnMLx1@infradead.org>
 <aIBdKhzft4umCGZO@ziepe.ca>
 <aIHhGi3adOiLykJn@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIHhGi3adOiLykJn@infradead.org>

On Thu, Jul 24, 2025 at 12:30:34AM -0700, Christoph Hellwig wrote:
> On Wed, Jul 23, 2025 at 12:55:22AM -0300, Jason Gunthorpe wrote:
> > On Mon, Jul 21, 2025 at 12:03:41AM -0700, Christoph Hellwig wrote:
> > > On Fri, Jul 18, 2025 at 02:51:11PM +0300, Yonatan Maman wrote:
> > > > From: Yonatan Maman <Ymaman@Nvidia.com>
> > > > 
> > > > Add support for P2P for MLX5 NIC devices with automatic fallback to
> > > > standard DMA when P2P mapping fails.
> > > 
> > > That's now how the P2P API works.  You need to check the P2P availability
> > > higher up.
> > 
> > How do you mean?
> > 
> > This looks OKish to me, for ODP and HMM it has to check the P2P
> > availability on a page by page basis because every single page can be
> > a different origin device.
> > 
> > There isn't really a higher up here...
> 
> The DMA API expects the caller to already check for connectability,
> why can't HMM do that like everyone else?

It does, this doesn't change anything about how the DMA API works.

All this series does, and you stated it perfectly, is to allow HMM to
return the single PCI P2P alias of the device private page.

HMM already blindly returns normal P2P pages in a VMA, it should also
blindly return the P2P alias pages too.

Once the P2P is returned the xisting code in hmm_dma_map_pfn() calls
pci_p2pdma_state() to find out if it is compatible or not.

Lifting the pci_p2pdma_state() from hmm_dma_map_pfn() and into
hmm_range_fault() is perhaps possible and may be reasonable, but not
really related to this series.

Jason

