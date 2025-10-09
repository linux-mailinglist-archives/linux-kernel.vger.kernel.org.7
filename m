Return-Path: <linux-kernel+bounces-846160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F7EBC72BF
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 04:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C0DE401B5E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 02:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A2A1A9F8E;
	Thu,  9 Oct 2025 02:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OxACerLf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05FE1A0BFA
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 02:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759975318; cv=none; b=Kj9f3fPJYJKK3kK2zimcvNSdHYuxuAidA2on5lQihmRTJQ7oxWRQMt5LSx3YJ0BzbHvGsKLqxQ67iPyRekLqSU2+Ya+/j57KDkIiPrSIwtLUEGaTH+PyrUTFtF6MXBp2XeQwvgqPWGZuqXIINxuhAH+wdYM/PONv1yy7jjiDNZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759975318; c=relaxed/simple;
	bh=cmwJ00nux7/r0iE9bq3u7flM+mf5JWKL9Ygfu+DRbZU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=RKiE4+VNXfCegG5TJAl77uRN5BAKRT4Xkw//jJ8HK3Tz0g/si5kW07zdDmg1l2hd+PMGmWcKWBX9JN3IMiJV2OcQEgeLU7wcTrCcQGPL/rpFOZvWWt5p6C5uKv9rq+qXTM+g7Z9w/PlzEPK981nM0Fvw8N4YQVWSd+sHedLjWOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OxACerLf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2621C4CEE7;
	Thu,  9 Oct 2025 02:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759975318;
	bh=cmwJ00nux7/r0iE9bq3u7flM+mf5JWKL9Ygfu+DRbZU=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=OxACerLfqf7L0d+AYAIEeeGyy5zqxC2ius15pBQc8ETUlL2stiRM2z2SXmX7FqoCe
	 xM16zufcxWF/cjPtXKogBPhPdBmb9eAiLgUNAmUnIztHLtvYqsco8o478BXmuCv1iD
	 hu0Ztn9gD/JRWTVkfk7NCiNdoM01TsTys1SQbx9aRf1wjBGo32ww7hHF0O/jf6Q1bl
	 Sc6d7JhjzZThIKdp0yMNlPe3V8JLEDsQr2pEC9gRX+NQ6+vMVdnsH1XVqVW7xe5+eR
	 3NsTdQgM/EKGMVj9MsZgktijPEJD5SjV3rq1WMdXrp7ZWls0TpJCOjKV+I2rDdvuRi
	 VPAljXaAERqfQ==
Date: Wed, 8 Oct 2025 20:01:54 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: duchangbin <changbin.du@huawei.com>, Alexandre Ghiti <alex@ghiti.fr>, 
    andybnac@gmail.com
cc: Paul Walmsley <paul.walmsley@sifive.com>, 
    Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
    "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, 
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] riscv: Prevent early kernel panic in instrumented
 apply_early_boot_alternatives
In-Reply-To: <d41d9c7a103f4600a4fc5beea77e0f4e@huawei.com>
Message-ID: <2396743a-480e-2ab3-f7fe-569d8f2adfcf@kernel.org>
References: <20250624113042.2123140-1-changbin.du@huawei.com> <a89f5970-5ea9-4d92-8952-6c26a22ac153@ghiti.fr> <d41d9c7a103f4600a4fc5beea77e0f4e@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Hi Alex, duchangbin, Andy,

On Wed, 25 Jun 2025, duchangbin wrote:

> On Tue, Jun 24, 2025 at 02:54:32PM +0200, Alexandre Ghiti wrote:
> > Hi Changbin,
> > 
> > On 6/24/25 13:30, Changbin Du wrote:
> > > Under FTRACE=y, DYNAMIC_FTRACE=n, and RISCV_ALTERNATIVE_EARLY=n, the kernel
> > 
> > 
> > Your above config works fine for me, I guess you meant FUNCTION_TRACER &&
> > !DYNAMIC_FTRACE (which fails).
> >
> Yes, it's FUNCTION_TRACER.
> 
> > We were just talking with Andy about this configuration (FUNCTION_TRACER &&
> > !DYNAMIC_FTRACE): do we really want to support static ftrace? Andy should
> > send a patch soon to remove this possibility as IMO we don't want to support
> > it. Let's wait for this patch and the discussion that will follow before
> > merging your fix. I'll keep it in my list for 6.16 just in case someone
> > comes up with a good argument to keep it.
> > 
> No problem. I'm unable to enable DYNAMIC_FTRACE because GCC_SUPPORTS_DYNAMIC_FTRACE=n
> and CC_HAS_MIN_FUNCTION_ALIGNMENT=n are set. It seems that my GCC version (13.3.0)
> does not support the option -fmin-function-alignment=8.
> 
> By the way, this change also eliminates an empty function call.

Working on cleaning out Patchwork.  Was there any further conclusion 
reached on this patch, or more broadly, static ftrace ?


- Paul

