Return-Path: <linux-kernel+bounces-846572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AE871BC861E
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 11:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 745BD4E55B3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 09:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2ACA2D7D2F;
	Thu,  9 Oct 2025 09:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HKvB9jSE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3725028642B
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 09:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760003776; cv=none; b=R4C7keKRSew4IM7pR75y3bkanx+szh+AJ9zxY06aD68jTleGk+uZ4Xro9Ynnkc6B32VIuT4pm4fo0o7jU5UIvBU6NeLmxD6SFfySDvWI6vrij41AcGt4D/sg5+YsFWG5USDy3Bj1uFWLJ7S+e8LOe3uSQi79mCK9Xs4efFl4hto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760003776; c=relaxed/simple;
	bh=3UhF6vr6K17EMDJPD+D0NWeUPswfeJDH1wNl5B4vyAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S1oEjrBPESTm/CaLVv0RdlFDvkbgnCO68vHMzDPx01CxpZc6P36JMz4Ukm8rWFU4cPvZzivJkjqdbVmW2eSDCw863R9xjmvSKeGovTfOF8eH+MxKZ6npviVSavuxIBVWzMTyR5gFVVmyIJ4OIPHTdgxdF6K60D5duajUoAuv36I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HKvB9jSE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7430BC4CEE7;
	Thu,  9 Oct 2025 09:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760003775;
	bh=3UhF6vr6K17EMDJPD+D0NWeUPswfeJDH1wNl5B4vyAA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HKvB9jSEUpV/JjSfjXtNBMQzGWFkyCU0YzrpH/2Gfiwiyw2fMhEd/KStVQtLQUoYJ
	 nRwyitk7mgtsSqSyrJWzoKLZEeaMFjZ+WulZ10u1GT5uVhc93IqPUdfxW3SD4wj3OJ
	 MzER1dOmOJhElKaN+lfkipnJIWNLiSQLDxtPwE3LBbGqbq2IlWYrZ8LVf/MJoxJK42
	 WI1wJNmJMape7Ji5qqE6Z8IDwn5Xpp13wFL0yhb3HnhSqPlDxHaQHettgA3Z0HgZxb
	 aK7SvV/7z4Gu0FyYRkcOQWsGhvSUufHxD8j9bb0ns8WBrPYEfGSfR3mk07A0nlLC6m
	 BTF48tDurnOFg==
Date: Thu, 9 Oct 2025 10:56:11 +0100
From: Lee Jones <lee@kernel.org>
To: Corey Minyard <corey@minyard.net>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Chong Qiao <qiaochong@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] mfd: ls2kbmc: Fix a couple Smatch warnings
Message-ID: <20251009095611.GC8757@google.com>
References: <cover.1759478975.git.dan.carpenter@linaro.org>
 <aN_uCPqymUbVN34c@mail.minyard.net>
 <20251008140301.GY8757@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251008140301.GY8757@google.com>

On Wed, 08 Oct 2025, Lee Jones wrote:

> On Fri, 03 Oct 2025, Corey Minyard wrote:
> 
> > On Fri, Oct 03, 2025 at 12:28:58PM +0300, Dan Carpenter wrote:
> > > These are two issues which were detected by Smatch.  They're not really
> > > going to happen in real life.  Small kmalloc()s can't fail.
> > > The devm_mfd_add_devices() function isn't going to fail either...
> > > 
> > > But still, they're worth fixing just for correctness sake.
> > > 
> > > Dan Carpenter (2):
> > >   mfd: ls2kbmc: Fix an IS_ERR() vs NULL check in probe()
> > >   mfd: ls2kbmc: check for devm_mfd_add_devices() failure
> > 
> > Got them, thank you.  I'll get this in for 6.18.
> 
> Do what, now?

Corey, can you remove these from your IPMI tree please.

They are in the incorrect format and are not yours to collect.

-- 
Lee Jones [李琼斯]

