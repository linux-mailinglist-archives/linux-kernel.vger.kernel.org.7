Return-Path: <linux-kernel+bounces-888564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEC7C3B340
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 14:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29FB6421DCB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 13:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF0332937E;
	Thu,  6 Nov 2025 13:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Bb8XRUyc"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DE62E7F25
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 13:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762434732; cv=none; b=eg1+v1TSmfGohk/t/IQel6Bo+wTGLuqahclexLQLTRIShYe5SWCCmyITKncEG1/MtaHZMPRGOoNYgrfs1NUQsdOcV7xVDnZWspxQ6PhgdRNTqMPfVLO+TTKFNc8YikFJ9o6HZb/mK1asn5RWsijZwI+6F8yLLmqcnSgsMIAFmno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762434732; c=relaxed/simple;
	bh=5fTu+d04zbTJZlqMZWEMH+c1jZ5YJrgOff05i/wlilU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uC+gkK1TYUUQPR/Jbf6TDvrBYVx0OtmP8C1Y9GzxksUShjroxrO1EqJb4YNfrqxjGWsPYSmoK9384dtpxXULFQE5ltSRVXeXzmm+6m/YV2plxJlKOXeFfXO6Gsme57r2wDwseh+pjut1R2h7jreomM9HNFzzA/lZyfj207ZqLwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Bb8XRUyc; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4e89ac45e61so7986971cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 05:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1762434727; x=1763039527; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E29aoir2P/D00xWPCdBMTWQeHrb8OPeQgwrWgeqWvFc=;
        b=Bb8XRUyc6I+24kI0ViiS4Raw+iuqwEX9B/601LwkzioJve021e6dm8kEooeWby1Azi
         1Rx+yJmbc3f8DQ5SCKrO7N8UETHzyYX0SrQ6FA3gBDSn4EMLgXf5wd8plSA9Gdu32nbi
         zumEnQ62NgMjYNJQ7lzTvC2RShssT/qykkKMwGGsRSoMLIQ7jaM4hSDL+EPrZAC6d2vO
         qqSMHs/123WEf9h3bzR12WaDaDvEvPlj3LjvpszKjrd07nHy4ichg3KUI2gY3DNxdQy9
         /6e4osJK1VY3URm8wrTQ5Rge58WlODD6ba5r9lIFiRCLPWtfC+Npqah7D9KU25ypFMZc
         Z2Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762434727; x=1763039527;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E29aoir2P/D00xWPCdBMTWQeHrb8OPeQgwrWgeqWvFc=;
        b=BG88TcboHa740olWgNXcVd8eQzFTWngX3GlYIRrqVT2lVTLr19pQ7QCDgEfrYmeN+f
         LUsA9eq8D5o2FsyU9tRtNAYXa+wZ2eiJaXxvCYU5FaN8oTq7+Z0dWG94WM946CBqLY7X
         Y8cDf2r3Y6Y98CiPTkUHDZmaum+iI1Wfm/tGyPHcP2+3EHHk1yZR9W59TV3qcrVC6Wrw
         2Uj7ukXMVnbfkTyP6Cvrc7D/SokpHKX4x6yKseRFR6tLsYqqTlwHYD1rSxF7qtl1OnQP
         lYOO2/fO7zzCLtWsgHFNUSl+9DLq6b7LK0mK3pnMdsVL/TBvITgYhReTeDCSKK9dzSur
         LX6g==
X-Gm-Message-State: AOJu0Yx0fzFo1fMib835HLXkIHPwTHa4uyd3xvz2Z4r4uAIHadql91lw
	WGkzkPKsr0cpdMyguGm/eW3vfj37qbnQR2DvCYHFRbprAhrps7e2ObDMLP49IIevog4=
X-Gm-Gg: ASbGncuuI+Z9szxhlkQKs/p9XAFSMSdLwaovRlVfzVavEEYVur4G/BeMISRmqNx61zO
	T+jQR7KxzinaFEnVJ9svpOb6LnAd9XXhvAUP6w3eJd4fMR2M8b0Oyrqr7PtMpYG6OJPUTR1Vpgo
	mFxMFodek+spDVf8tNJ1H2iSdeiMlXambYRozaJJRA8UbZM1uArnLIvvBTcRQ0pgalB3oYTrkfr
	JEz2aeBy+SU2FnIzUy+ar8W1uIUy6MpDrpHvQIVOwgcSKLLBVAs4Pp7fcMT5OMtmtlWa+C7pmzc
	j9OSWL/j6//2EfDeb1+3RqzCZB8MwUvewBJbmD4GKf8MBwH4OckxzTrK2xWqocWn1Nl/mqokEdd
	XbtP4pm1ObVd1McSOsLHBPmK+uLw6sO6J85hBun2ELJSNdjqVhsjKeFoBtDpYSmYg4j6MXW28jA
	68TzcFShNM6ripTxUxYGJpGIWuYjdY0Yxsx5H+4TUwvGFRaw==
X-Google-Smtp-Source: AGHT+IHO2kfw1vydAWg7lJYdgVN60+8RpDLa3bu5iIb6/gokLYdATyBmAutBTljfCiGVr0ImJH3xUg==
X-Received: by 2002:ac8:5903:0:b0:4e8:a269:ceab with SMTP id d75a77b69052e-4ed72354895mr97954141cf.5.1762434727357;
        Thu, 06 Nov 2025 05:12:07 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-880829f7a3asm18683196d6.40.2025.11.06.05.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 05:12:06 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vGzmY-00000007LUY-0oBI;
	Thu, 06 Nov 2025 09:12:06 -0400
Date: Thu, 6 Nov 2025 09:12:06 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux IOMMU <iommu@lists.linux.dev>,
	Jonathan Corbet <corbet@lwn.net>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>
Subject: Re: [PATCH 0/2] genpt documentation fixes
Message-ID: <20251106131206.GT1204670@ziepe.ca>
References: <20251106073845.36445-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106073845.36445-1-bagasdotme@gmail.com>

On Thu, Nov 06, 2025 at 02:38:43PM +0700, Bagas Sanjaya wrote:
> Hi,
> 
> Here are fixes for two htmldocs warnings in generic radix page table
> documentation. The first one is reported in linux-next [1], and the
> second one is also found when making htmldocs locally to reproduce the
> former.
> 
> Enjoy!
> 
> [1]: https://lore.kernel.org/linux-next/20251106143925.578e411b@canb.auug.org.au/
> 
> Bagas Sanjaya (2):
>   Documentation: genpt: Don't use code block marker before iommu_amdv1.c
>     include listing
>   iommupt: Describe @bitnr parameter
> 
>  Documentation/driver-api/generic_pt.rst | 2 +-
>  drivers/iommu/generic_pt/pt_common.h    | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Thanks,
Jason

