Return-Path: <linux-kernel+bounces-823713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFD8B874B9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 00:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 164117ADFD7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 22:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDB82FF654;
	Thu, 18 Sep 2025 22:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="pRTqd0c4"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849CA2FC892
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 22:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758236263; cv=none; b=OkbIlimPZIu2twBUC4Pa634yQmn+vd3ummB9pEbV6cmc40K+jHDwJ9UNpHx+ofMUvxkC7Ba60KIFyJZ2qrdY8QKAkIEUa2+PA3kuSPReXL0MkTRYAah6JItW2YF7aje8KLHuA8sdmST3AFyZTgOZqJus3Roni3FzqbrQlYf91ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758236263; c=relaxed/simple;
	bh=EnAugjJKGS9kNcH0KPK8H8jgbanYL7rHbRk1ja9LOTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lwqY5AWIK1QHTtJwlvLwUtlr9PZMX+sF+Jg4ARL/yVZVHPYdfWkWTl+3kvEitxGXOhAFEu5X5GAZhzV/6u8/ybsCcOtF5/nNZDQFUSfYkXjXHP4D11cCF/rdm2HbNJFs7YjBiSAVQWxiP1hhKvmEbFiOQTw7e7aCRjveaTUQDYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=pRTqd0c4; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2698e4795ebso12265915ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 15:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1758236261; x=1758841061; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v83WXTTHBivSkvwG/ZEkQECpEw+P202t/WrSkYtNyqY=;
        b=pRTqd0c4iXi61oDuWExZAh4UuVd1qvHnh9Igvr/jFe9maxCyrvdrhdczdXXRJcRtKR
         J4vHWf0Wkfiugip0dxE4cUJE1cCoUnN7noY7nm/p8ywMm6Oh8ekyjWFRPLG2twCX1Upu
         riAAUkeE511h6drDCganhJa/SyWQXBZ2PJaiMTXAkzT3MkXWG1+6YZe2U1zWVBBLy5Lw
         gaMX+f7bgmJpTYTouoFb+01tg1eGSzllfpqFz0ChXbM+uGo7EBGOki8pfa4AiUZXi4G1
         IdOCKFjBu2rGxyTAo1YrMhQCP80ffuFfxpZECMG/4TpzrXdsqUxel2pPHuzhXU3wvY+5
         tz5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758236261; x=1758841061;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v83WXTTHBivSkvwG/ZEkQECpEw+P202t/WrSkYtNyqY=;
        b=C+yCulcdkADe/AounN7rn98MHm/iRC6ligdSZalkQPyGxuHY/fX7wsMSrk7+9MofWh
         pCQX4AklmOrLr94ZQFJX8ZVEfaINlGnz3c5BJ0Xji8zu1CNBs7l6WsD8EZSCOaQNrLwS
         DDg9EBQhlbLUMlThwqj3Xiadk+VgDt6heR2ttdmYSax1W2FAw0ErOvpSdnKoRpRvXifZ
         FsV9Zg/vjL+8BB+kA3kwMTbRCRoW3PVbT4mm+pPTECPs0YqG5wDCgVANc4Nnl1XdI8eO
         0ZoG7lFvm4ekbT3SyR5gVvqOWpsV4t70R5pZM2oIpNbEe1Jp9TAJPl63OpiHWXUnk3z0
         Js1w==
X-Forwarded-Encrypted: i=1; AJvYcCX43bjFqTkgv8FYh8XtHbP/Yp4zVyMOWJAlZ6rukwi1NCc8IimKdUm0+XkAUHcmcw+MdxG0159mCIK+mLY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTASXqnDHusTJw9i2oPEHqw5ASX96W9JjIHjcUKvWUWvBFhRgN
	reZE/xYq03sVL2/zSffr74rvHCT+N2aHqnYPw9AFV1a2qlJXQuxuiFKQND6SQtmHM6E=
X-Gm-Gg: ASbGncsHvWQoZVr1/zS43whCV14LxlwNOPt0T1nRoPaZd8ts+02PFy79uKOaqfyMlbO
	Mm57wTMDxFhrPKhUYBdzZiv2vxiaqyDUyjgey7oiuqyL0FlaArJ7jl2yEwmTZNTcaucRv/8Oflm
	2WeCkTLeHcSyLB32bjDMAnzaEOaS67A3dAlhUObVcbv6fSiuIZLWcodKJbJlnNrbaLClpuNIaTx
	CaHV5DMIMayvne6SZH+tth77DC51P/ozDOBpyGKncT4His9NvC8RZfeIq1CV4bzWwtX7MwWPPks
	K3bRz7dM5IZkr7uZM1Oa3XSNhlsY5/seqClQqtBB3p7wXOPGP11Z9b5VTHg7mG4QpJ3BizdbYUS
	rNPL1IDwFpxq4Ers=
X-Google-Smtp-Source: AGHT+IHyI3J6k4eVmUR3urNDzX7uOe4AwYGVJpNt69xG/KOAwgukPr8ufI5DMeIiUV+tYwd8ZhYffQ==
X-Received: by 2002:a17:903:b48:b0:24b:e55:334 with SMTP id d9443c01a7336-269ba3ec96cmr14255435ad.8.1758236260768;
        Thu, 18 Sep 2025 15:57:40 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269803163a1sm35312695ad.117.2025.09.18.15.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 15:57:40 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uzNZL-0000000926U-19Ay;
	Thu, 18 Sep 2025 19:57:39 -0300
Date: Thu, 18 Sep 2025 19:57:39 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alex Mastro <amastro@fb.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, David Reiss <dreiss@meta.com>,
	Joerg Roedel <joro@8bytes.org>, Keith Busch <kbusch@kernel.org>,
	Leon Romanovsky <leon@kernel.org>, Li Zhe <lizhe.67@bytedance.com>,
	Mahmoud Adam <mngyadam@amazon.de>,
	Philipp Stanner <pstanner@redhat.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Will Deacon <will@kernel.org>, Yunxiang Li <Yunxiang.Li@amd.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	kvm@vger.kernel.org
Subject: Re: [TECH TOPIC] vfio, iommufd: Enabling user space drivers to vend
 more granular access to client processes
Message-ID: <20250918225739.GS1326709@ziepe.ca>
References: <20250918214425.2677057-1-amastro@fb.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918214425.2677057-1-amastro@fb.com>

On Thu, Sep 18, 2025 at 02:44:07PM -0700, Alex Mastro wrote:

> We anticipate a growing need to provide more granular access to device resources
> beyond what the kernel currently affords to user space drivers similar to our
> model.

I'm having a somewhat hard time wrapping my head around the security
model that says your trust your related processes not use DMA in a way
that is hostile their peers, but you don't trust them not to issue
hostile ioctls..

> To achieve (a), the USD sends the VFIO device fd to the client over Unix domain
> sockets using SCM_RIGHTS, along with descriptions of which device regions are
> for what. While this allows the client to mmap BARs into its address space,
> it comes at the cost of exposing more access to device BAR regions than is
> necessary or appropriate. 

IIRC VFIO should allow partial BAR mappings, so the client process can
robustly have a subset mapped if you trust it to perform the unix
SCM_RIGHTS/mapping ioctl/close() sequence.

> Instead of vending the VFIO device fd to the client process, the USD could bind
> the necessary BAR regions to a dma-buf fd and share that with the client. If
> VFIO supported dma_buf_ops.mmap, the client could mmap those into its address
> space.

I wouldn't object to this, I think it is not too complicated at all.

And the idea to add some 'use writecombining' to the create dmabuf ioctl is
certainly a novel and simple way to solve that problem.

> We are interested in the following incremental capabilities:
> - We want the USD to be able to create and vend fds which provide restricted
>   mapping access to the device's IOAS to the client, while preserving
>   the ability of the USD to revoke device access to client memory via
>   VFIO_IOMMU_UNMAP_DMA (or IOMMUFD_CMD_IOAS_UNMAP for IOMMUFD). Alternatively,
>   to forcefully invalidate the entire restricted IOMMU fd, including mappings.

I've had similarish requests for fwctl.. 

What I've been thinking is if the vending process could "dup" the FD
and permanently attach a BPF program to the new FD that sits right
after ioctl. The BPF program would inspect each ioctl when it is
issued and enforce whatever policy the vending process wants.

Sort of like seccomp.

iommufd and fwctl have a similar ioctl design, so I would have no
issue with something that could be easily reused for both.

What would give me alot of pause is your proposal where we effectively
have the kernel enforce some arbitary policy, and I know from
experience there will be endless asks for more and more policy
options.

> - It would be nice if mappings created with the restricted IOMMU fd were
>   automatically freed when the underlying kernel object was freed (if the client
>   process were to exit ungracefully without explicitly performing unmap cleanup
>   after itself).

Maybe the BPF could trigger an eventfd or something when the FD closes?

> Some of those things sound very similar to the direction of vIOMMU, but it is
> difficult to tell if that could meet our needs exactly. The kinds of features
> I think we want should be achievable purely in software without any dedicated
> hardware support.

I don't think viommu is really related to this, viommu is more about
multiple physical devices.

Jason

