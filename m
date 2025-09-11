Return-Path: <linux-kernel+bounces-812365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 711A9B53703
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 17:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE1C3AA10D3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 15:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877F434A31E;
	Thu, 11 Sep 2025 15:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qhnBHnN5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E1A3D76
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 15:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757603464; cv=none; b=Rfa4TDGLPRfsP5cQOnBKiTjYpEwmnU97HNquHhqzTh/3LSYGwYjOQOIl4SuMQzoVeSkkaOf33pRADlVeTrtARhqXsrFtGmOSMeXL2l/RdRJO7ovkMmw3jV/nwyiSZCGTTqL7zS6utXhrGgoolgdRlcIxDRw27azEvfcHHzXqi24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757603464; c=relaxed/simple;
	bh=Q1ync32Kzeq/3kxPfeUqX38nMSedR6eNQsrwlr0JYaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MhmUnNOse9TycIuvjlhJ/FdOC1Pi9jJhkxj/4VBaleg+Wrgmjnq0QWMurGAKgHrGa6ORxDcOnIft8y6dKM00sXyF2ZXWmdOyGRAD65UQ/nfoq2qIGhkxnWyX3BksGETiEOttF6gt5gHFHdEg+h4rd/g5UOMmxB6jspdbTMaXya8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qhnBHnN5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2219C4CEF0;
	Thu, 11 Sep 2025 15:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757603463;
	bh=Q1ync32Kzeq/3kxPfeUqX38nMSedR6eNQsrwlr0JYaE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qhnBHnN5ikMCMdlhheYYf0lJ/7rcyJGx9xzxMJoW4Taz5Ii/a7LaNMygmxZJ7+J7+
	 lvgjyj4TPko0nCjJgDyG/ShWWMhuBHA4FUJMwPDzSpOO8CJLoDkl2huYIIkZX8NnLJ
	 qQzV8v/dwAmhTMJ+PtOiVGkpGcrNEaqaYZyJQAsc+X+8EB9Ku4j8qSAGmvdt3akxOJ
	 hSer9IBk7TVkwX6bEf2xhGnocVn0LNgZNy5t+0pP4Uyev/9zvk08hZQp60g+4ZoBtS
	 ntNPmiNOhD59jAleeIqicyw75BlnQBm7+YbwJHwh3hsuyTqx5iDa9eiPLTn4wRvqU5
	 sPIBHRO03K6hg==
Date: Thu, 11 Sep 2025 16:11:00 +0100
From: Lee Jones <lee@kernel.org>
To: Michael Walle <mwalle@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Job Sava <jsava@criticallink.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: tps6594: Explicitly include bitfield.h
Message-ID: <20250911151100.GQ9224@google.com>
References: <20250904-mfd-tps6594-core-fix-bitfield-h-v1-1-5d0f00cfe58f@kernel.org>
 <DCKNRRN0Q2I7.WFT5U4QKA9XS@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DCKNRRN0Q2I7.WFT5U4QKA9XS@kernel.org>

On Fri, 05 Sep 2025, Michael Walle wrote:

> Hi Nathan,
> 
> On Fri Sep 5, 2025 at 3:26 AM CEST, Nathan Chancellor wrote:
> > After a recent change that started using FIELD_GET() in tps6594-core.c,
> > there is an error when bitfield.h is not implicitly included, such as
> > when building allmodconfig for ARCH=hexagon:
> 
> Thanks! I was already in a discussion with Lee about how to handle
> that.
> 
> >   drivers/mfd/tps6594-core.c:767:7: error: call to undeclared function 'FIELD_GET'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
> >     767 |                 if (FIELD_GET(TPS65224_MASK_EN_PB_VSENSE_CONFIG, pwr_on) == TPS65224_EN_SEL_PB ||
> >         |                     ^
> >
> > Explicitly include bitfield.h to resolve the errors.
> >
> > Fixes: d766ca01c208 ("mfd: tps6594: Add power button functionality")
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> 
> In any case:
> Reviewed-by: Michael Walle <mwalle@kernel.org>
> 
> Also,
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202509032356.LGa5hygM-lkp@intel.com/
> 
> > ---
> > It looks like this should go into ib-mfd-input-6.18.
> 
> Yeah probably. Lee, is that possible?

Hold my beer!

-- 
Lee Jones [李琼斯]

