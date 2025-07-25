Return-Path: <linux-kernel+bounces-746105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BF7B1232F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 19:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2186C4E3A5C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 17:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574DC2EFDA9;
	Fri, 25 Jul 2025 17:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IICHEsNd"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615E124291C
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 17:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753465647; cv=none; b=Of63kNyM2OZG55J7ReAolKxkeTj/kuWBRXCLe8j/kTIBkMtkpcEdVmBX5C7f+S+0+wabpszuFwoHeyFhw5I96+9U6kq5Jjgf/PsTw3hcqSAhjbVdnH3fU6yj76e/eQTPbnQfe2KiqjhjYZL6UyvQ/KpwlPtB0vLCQLv449HLsoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753465647; c=relaxed/simple;
	bh=9/9IGptpLwsFSnxB182Zg/p4chccFKhXUqIIQR5aytk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rRvc8KnEbFSVy/OI4lVmcpl18NQTKfqeY/HpXi+MmT01XL/rAMWEln64Nfzc1gXKG63gaHwGCaWR0nLhenkIkGazZ1DkDaB8nxEw6KF8cTOXrE/i7QF67HN7zOB60Li5Q2i0CC/bAzNp7NPcglcwEsC/j0vImt/8TGJb2hfzXu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IICHEsNd; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-23dd9ae5aacso11935ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 10:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753465645; x=1754070445; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nb42As4a1Tt2TakmJwcUkP/IrOzz7ol8ZmDuilSE7QY=;
        b=IICHEsNdsuF+tsQCHp129l7z3NEfSJdgrzrsVXusp3893JyEzTsNWJjvhiQvL0ErvV
         QN0PedlPWS+FDkS2sY/AWdmZwR5ANL24/UWZp5TByoFVAXfZKtMyDpdLnyH8fRABOcxr
         2OkO0oF7/hxvr4ah6g9H/uexXY9WcPErlc00QGPXXyB/9jzRUO54Wu6UB+Z6KppW29eJ
         +1b6gBNPXWIZ04BM8QYB/yvcgKv++0hlrv74T8Hto0pyzMDNHRlGXK9T8bgGjYbsn+Of
         rSkhWPoizPMDtkZfWXA52K8XdYEQonYBfvnMYPMWxmKBUQyLaH+ITkupk4lAz9Xl9ShQ
         3zjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753465645; x=1754070445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nb42As4a1Tt2TakmJwcUkP/IrOzz7ol8ZmDuilSE7QY=;
        b=R01j8lXA5+tPCvruul5LRSkEwSDd9978qAS3egu5h/fr3LIY2PcVpQeY15AwtANH9m
         ZQxU00R58/qw1y3PpnIu/RxIe2KNndlQF2pLrbEnGhiowqjqYT1n/Y3n9cG43PzcRNcR
         Gl/J7pBADM58La0H53YzE7/KytdCl/cxpq26Fq7QAB6EI9DMJniXCQn+qJV1xinjSxwE
         EP6lyvITYzHv8dEO254NccmjpEsCzhbLOHV/r9GPmlsOc40WH6P4C/5HZRRWfQMP4qiw
         5hAja+LMw2+57E5YUyNxEJswJ2ihEgzoyq9rP2jgZPWW5s9nSLQpeCMGD/UCuV7JSNl0
         /ilQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkOg6HYYLsYNfkOz74gPr4u+g+H41py1F7gNP8qexzX+KoURDC11QJtGMmFyRkLYbF4Pd7XDPaGNnrhA4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2/ZjOnQ5Wzk2yjJgwREURLFwxxqEYlJhTmrGGD6lDkH98fFyU
	cNAuB/eQHGypucBVW2aUBAg1ARetJJMIe/4VCc928bVBgnEG3AacyyYXBTFcdVHXzw==
X-Gm-Gg: ASbGncvyj9Lifn3TQv6ao1ZQc+4dinrfSmjnmoyEyb/oRLNbV/vcdTOgboeqyklsfWz
	U0+CIpuLhsFzRXfG85VijMk6C/nvDVp/pxL5CrUYMHF00oYtJEUe4TlcdRrLecjPHNdLkXeo375
	ulaJ5rBrKjN/kVrB6k9aZArD2Kn91+hkmL401YxaPGKsDj/VFSbkHybWsF0Zn9PEr0K4P6vq0dO
	gJ6OP6FHHqzAoPeMS0VK3jonqBngSnQcOZYJ3YYU+iidBPaY13ieyxE1Quu2pB6JOuGjKbQX5nc
	WK9GFvxJvfdk+oc0/Bu2eKpX7sRO2FullBvpBkXoenFOZxwCa2VFIqAJ7YYRB8QaJWDV58ORGre
	7dezo5tHqlcVKB5j4+Wn890QEBsIxTBVilcdM5B988B8LqILuwQhQy36v
X-Google-Smtp-Source: AGHT+IH6CzP73NhGeAVCvr5tnhQ0xcNucVsA1Zx6VNhDEe6MGsxi7hQ/IPtgDO+K7Qiu3C7e0YT0ug==
X-Received: by 2002:a17:902:e889:b0:235:e1fa:1fbc with SMTP id d9443c01a7336-23fbf677572mr113455ad.0.1753465644867;
        Fri, 25 Jul 2025 10:47:24 -0700 (PDT)
Received: from google.com (232.98.126.34.bc.googleusercontent.com. [34.126.98.232])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe537f8asm1791005ad.167.2025.07.25.10.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 10:47:24 -0700 (PDT)
Date: Fri, 25 Jul 2025 17:47:19 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, will@kernel.org, joro@8bytes.org, robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iommu/arm-smmu-v3: Replace vsmmu_size/type with
 get_viommu_size
Message-ID: <aIPDJyuSVpqMV8sn@google.com>
References: <20250721200444.1740461-1-nicolinc@nvidia.com>
 <20250721200444.1740461-3-nicolinc@nvidia.com>
 <aIDlsUvF2Xbdelvx@google.com>
 <aIEkZoTOSlQ0nMKd@Asurada-Nvidia>
 <aIEwzM7mKUI8-h9U@google.com>
 <aIKd1owebUNQeN1-@google.com>
 <aIKqaGMMpsIuAVab@Asurada-Nvidia>
 <aIMR6xxR3Jdpy8kX@google.com>
 <aIOq2ysFPfZsNUix@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIOq2ysFPfZsNUix@Asurada-Nvidia>

On Fri, Jul 25, 2025 at 09:03:39AM -0700, Nicolin Chen wrote:
> On Fri, Jul 25, 2025 at 05:11:07AM +0000, Pranjal Shrivastava wrote:
> > On Thu, Jul 24, 2025 at 02:49:28PM -0700, Nicolin Chen wrote:
> > I'm agreeing with all of it, it's just that the comment says something 
> > was rejected in by the size op, which raises confusion as to why we're
> > in the init op. The init op rejecting something due to data corruption
> > is a different thing..
> > 
> > I totally get the point about data corruption, i.e.:
> > 
> > size op -> returned something valid
> > <data corruption>
> > init op -> rejecting corrupted type
> > 
> > Wheras I was just trying to understand a case where as per the comment:
> > "Unsupported type was rejected in tegra241_cmdqv_get_vintf_size()", 
> > i.e. ->size op returned 0, yet we ended up calling the init op
> 
> Is the updated one in v4 fine to you?
> 
> /*
>  * Unsupported type should be rejected by tegra241_cmdqv_get_vintf_size.
>  * Seeing one here indicates a kernel bug or some data corruption.
>  */

Yes, v4 looks fine.. but I was just trying to understand if the comment
was wrong, didn't necessarily need a re-spin just for that comment :)
Thanks for accommodating it though.

> 
> Nicolin

