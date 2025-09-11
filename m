Return-Path: <linux-kernel+bounces-812379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CDFB53767
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 17:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDDB51CC3FF3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 15:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215A2353376;
	Thu, 11 Sep 2025 15:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0qPEVuR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740F935FC08
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 15:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757603714; cv=none; b=HpH4458N2lvT9r5bHtK3s3Btw/2u2l2PyffDrvq77F+0z22VU2BEGqAqz2xIzPn7MypwK3ADtFjN051QrSYUByo63zaENGdAlt/7s5GjG6K+dUZdayFs3yjwPr7cGb1PMdO3iy3KqwS8Vlq8/Huyj64KKqoWNp3W+arnr+0lPIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757603714; c=relaxed/simple;
	bh=Y6vOOZKZQhyAZDLplhCSidBIh4kmrTfA+Ez7lqRJQ+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XTKDBpSvc8BeGwEPKqBHzRv8ZqD2zRKuB1CsQuZvIkjZ0YRg+KBFaymjOMeERLfYMCB9ZapBDu/H1b03YqQblraPpuFhFRdL4m6HQh8BOQEmgfC3+wT9kphcfaf3A7Fz5Ns/BpIr0VZUK762iUPPBUiUkUkY4BRwpS9Y0SMxkFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h0qPEVuR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13CB0C4CEF5;
	Thu, 11 Sep 2025 15:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757603714;
	bh=Y6vOOZKZQhyAZDLplhCSidBIh4kmrTfA+Ez7lqRJQ+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h0qPEVuR6/8EzOo0b66LStAlJNXfRdbhMq/7HNWqHqjp8mb4dFj/ztyiRC2f9BHBE
	 wdfzi4AZ3QqM5tUL2jNAvchiVTx1NIG1hraT5r0wygyVKcV1wimdOe7WwpJyOuTDLS
	 M7jjh+d0H6rYZ3hq1UDxYCwxY0/N1LRtZyFzI8qDUu7cM4brEzYJtn4J2ccbM7xD3n
	 2W6bM5218ABxgpUsBitN78KHT9169mzFPHI2JR3NJwoEFdrNFaeNE5EzhRfEv7PYOX
	 9z8O7xq2kT0BALEao1z7PdMVn5rnOsnTscKYcPW41Kyra68Mx6kU5DAnKAnWG7A4Kf
	 McYVBEraCif7w==
Date: Thu, 11 Sep 2025 16:15:10 +0100
From: Lee Jones <lee@kernel.org>
To: Michael Walle <mwalle@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Job Sava <jsava@criticallink.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: tps6594: Explicitly include bitfield.h
Message-ID: <20250911151510.GS9224@google.com>
References: <20250904-mfd-tps6594-core-fix-bitfield-h-v1-1-5d0f00cfe58f@kernel.org>
 <DCKNRRN0Q2I7.WFT5U4QKA9XS@kernel.org>
 <20250911151100.GQ9224@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250911151100.GQ9224@google.com>

On Thu, 11 Sep 2025, Lee Jones wrote:

> On Fri, 05 Sep 2025, Michael Walle wrote:
> 
> > Hi Nathan,
> > 
> > On Fri Sep 5, 2025 at 3:26 AM CEST, Nathan Chancellor wrote:
> > > After a recent change that started using FIELD_GET() in tps6594-core.c,
> > > there is an error when bitfield.h is not implicitly included, such as
> > > when building allmodconfig for ARCH=hexagon:
> > 
> > Thanks! I was already in a discussion with Lee about how to handle
> > that.
> > 
> > >   drivers/mfd/tps6594-core.c:767:7: error: call to undeclared function 'FIELD_GET'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
> > >     767 |                 if (FIELD_GET(TPS65224_MASK_EN_PB_VSENSE_CONFIG, pwr_on) == TPS65224_EN_SEL_PB ||
> > >         |                     ^
> > >
> > > Explicitly include bitfield.h to resolve the errors.
> > >
> > > Fixes: d766ca01c208 ("mfd: tps6594: Add power button functionality")
> > > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > 
> > In any case:
> > Reviewed-by: Michael Walle <mwalle@kernel.org>
> > 
> > Also,
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202509032356.LGa5hygM-lkp@intel.com/
> > 
> > > ---
> > > It looks like this should go into ib-mfd-input-6.18.
> > 
> > Yeah probably. Lee, is that possible?
> 
> Hold my beer!

https://lore.kernel.org/all/20250911151400.GR9224@google.com/

-- 
Lee Jones [李琼斯]

