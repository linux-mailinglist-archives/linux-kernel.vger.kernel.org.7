Return-Path: <linux-kernel+bounces-757885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BDAB1C7E3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 16:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7821117CAD3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 14:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC281D63DF;
	Wed,  6 Aug 2025 14:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="Q1gJfF0Z"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E16E1D5146
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 14:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754491715; cv=none; b=J6mDzLu8pB7zjMLx3QFG885LSRmynL6tUr6hxp6wkq7OxWAFu2LBuegyqa26bs6ekl046t4dVgYDRbs3RgLYWWGeZvgC6dGB6V9SrjDiGkw3fytOlgK/OFfJk0rtAuPLBtSSnQe2Bdn5fd5HahIXhW9B2B8WTV6pDXQqU6I5/So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754491715; c=relaxed/simple;
	bh=/WaxHr/fcNNvwBMyYXeMTnOq8nei6iL8c2DAY83YZms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o8V/bJ/GY44PepkdzUX78nuU4/7gD6IBm660TRS0Cm5vhcsRphJj316MM98IC8Htbyulz17MBvnHdEJNnFF1dFRub+hciBmUasE244mo1Yh6Iqdn5pR6oy+VOmm+EMJQsXHAVJLnNgrVjvk4tapQz5Wx7vUVLQl0GPRrFoaJBGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=Q1gJfF0Z; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7e817450f7eso68415885a.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 07:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1754491712; x=1755096512; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d+IXGiQjY6etL1HijGeumViSvmoghZhD/MAbBHOTCY8=;
        b=Q1gJfF0ZJQ2wuJsuUHFtQcwByclcU9u8lhDUxFvwQg+8F+uHc42W/w5B3VtMbOr/pD
         2fEb1QzbNc1QQG7qMvUVy3piA86xu+ZD2wgGp6K9R9nHzIlybeKFVKN4nt3AL4QbLCX5
         HOhFLI7UZjQDVx/VzWWKPbCFsQwolGzePLe5s49++dxiXktVdjbSX65R2uxiQoPPvq1A
         Do+PU6xj7g0HHRscGN8G014BaDhyLj/o34Wedj5FYoVj9KVsT1E22UdSzTYKOgisM99p
         4MSsKBO5ssSN410aAoe0IR/MFAcF1QaP+ZZppVxOp8G+sc/lJ3ukNMG8BV9ySMT3t81j
         mhCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754491712; x=1755096512;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d+IXGiQjY6etL1HijGeumViSvmoghZhD/MAbBHOTCY8=;
        b=OMQYDtkU35CNmnaeZRCsXsWDHembY23BB3FnRRdO+bMDOWEiZpUk7JiVbi5Inafhic
         4bPqJifZa8r/n6VX6X56zMkZhbqdEsilKrvxP68ZLzq/r53arwDaAPubDrpN5XjVRqQq
         y6njtBEjBzCWKe3q0cmi4BH5xwNNlUulevi5ipjZpjgGlD3gRnqjED77eE6QKOrto5Ym
         YaqwkSDZne/ZDmnHDxZjvFofqAVn+OcUenQjBD+9W6NIVrwQb0ssh8F6ebBHdIxNNb0/
         Ylj3S07sH4282c8468yH39Z1dgwWSJgR4JG1cXrzJWnJ9UL4hl3bEi5EEYtLTOVSO+Sj
         YC5A==
X-Forwarded-Encrypted: i=1; AJvYcCUU/GZejvVwZB8M4HZvsI+b6D6l9++jzxyGRsQ/x1A9NSTUD38xcAPJ2JbUn61UZdNkDanvElNxCumxo7M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkl/UoFaaSBb9lPO86liWGrR3NwxQHqBAXuj5oOJV2jhKT6WkU
	Rd9QoLKOPbY7/bk05BG7xahDVxK0RpoOY00BEyK+riB54PlfvescthFc+vHQWizvJQ==
X-Gm-Gg: ASbGncu9HP+zAkuUcEnyUPk/1HfOVV7///4XRb6ArUHsqvBmB5nP+gw7fmgaW+b4POj
	xgN4qNuLVQ+56BWoVetnSkWqtl67P5AJ2uI2uGkalm5wynSm2kLKW8uz8FE/Oj8ZCSCSJT1hvG/
	6sVOvvqfj+NI8WLPg6Sbvs6q3rQmDFEWraiiKRYM8gLBaqTUIVQ+okr5G0/5MlI8I+wXYTTNMjp
	Iiy4lwK/26iwtpCMi0YWtDE8Kx45Ap0tzs9lClkhQMNW5l3wCz68FHjlpmMMBh1Vatw1gFfkBk/
	yaq2gLGSbiGmO4yyBs8v1xmzOXbP9cIPbSXtKIKDNqkkDX9utdfqJuur1MepmjfnxTb35hivZvH
	XTdTL14d+Q/+I9oNruayy9Jpme83DUZIbJjM7gTlr
X-Google-Smtp-Source: AGHT+IEoV2J1KPJpYzF/n7at19yY+noWoVgVnUNgi+OTjlcXhUx/F0riVfkSgi2p1CxUP3mVELiYww==
X-Received: by 2002:a05:620a:2914:b0:7e6:9c12:f0ce with SMTP id af79cd13be357-7e814ed1dadmr517512885a.66.1754491712397;
        Wed, 06 Aug 2025 07:48:32 -0700 (PDT)
Received: from rowland.harvard.edu ([140.247.181.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e7fa87e7d0sm445254285a.82.2025.08.06.07.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 07:48:31 -0700 (PDT)
Date: Wed, 6 Aug 2025 10:48:27 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: gregkh@linuxfoundation.org, mingo@kernel.org, tglx@linutronix.de,
	jun.li@nxp.com, viro@zeniv.linux.org.uk,
	thomas.weissschuh@linutronix.de, andriy.shevchenko@linux.intel.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH] usb: core: hcd: fix accessing unmapped memory in
 SINGLE_STEP_SET_FEATURE test
Message-ID: <2f0148fa-ba18-4711-81dd-89da3bdd1627@rowland.harvard.edu>
References: <20250806083955.3325299-1-xu.yang_2@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806083955.3325299-1-xu.yang_2@nxp.com>

On Wed, Aug 06, 2025 at 04:39:55PM +0800, Xu Yang wrote:
> The USB core will unmap urb->transfer_dma after SETUP stage completes.
> Then the USB controller will access unmapped memory when it received
> device descriptor. If iommu is equipped, the entire test can't be
> completed due to the memory accessing is blocked.
> 
> Fix it by calling map_urb_for_dma() again for IN stage. To reduce
> redundant map for urb->transfer_buffer, this will also set
> URB_NO_TRANSFER_DMA_MAP flag before first map_urb_for_dma() to skip
> dma map for urb->transfer_buffer and clear URB_NO_TRANSFER_DMA_MAP
> flag before second map_urb_for_dma().
> 
> Fixes: 216e0e563d81 ("usb: core: hcd: use map_urb_for_dma for single step set feature urb")
> Cc: stable@vger.kernel.org
> Reviewed-by: Jun Li <jun.li@nxp.com>
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> ---

Acked-by: Alan Stern <stern@rowland.harvard.edu>

I guess we both overlooked the fact that the URBs used in this debugging 
pathway get submitted in two partial steps.

Alan Stern

