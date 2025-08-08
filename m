Return-Path: <linux-kernel+bounces-760501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A596B1EBFD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 17:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BE30AA23D5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 15:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190AA283FF4;
	Fri,  8 Aug 2025 15:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vfYcsUMx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D+UQHaC2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E870828467B
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 15:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754667015; cv=none; b=p8Zk4UPT4SkbXN0im0MIpco6BSnG41lccA9LmfgeAZHGVLvZMHUElqmK5yIEvqZ+fkFUyG0/NlFbBpmQrLQ3rncZ4BZlRb7ml9E8z2dMoXhSY2rJVz+yetDFHHVTB6ilCQyQlhR+gobIqY53QoZAfAyFQoFt/iBpFgVS3cis/Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754667015; c=relaxed/simple;
	bh=gRPaYihZ0/f4wMLIvQdpsT3JMMaFk6hSHvqp1FDlbgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aTuWzqrKQwXUVHjbtEXuUyhvFF93xNjfjDu9MOy3i/VaPSUF8zgORF68M6+4jsttO7u69dOwjEn/6YHO8TIxUH3nOEaANdItSzvPs4YMzuxaCvTDjqBgqg6l7bXwF07zSYcsqT51reeMIiC2ssUIirPzj50Xm5CJnSkrsJQWWRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vfYcsUMx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D+UQHaC2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 8 Aug 2025 17:30:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754667011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cMXIxvxE5BQvdmzpDVy/7yXWORR6dKljoelXvDwT6tc=;
	b=vfYcsUMxmXaZFvOsAIuK13TynKNADLT+k9WS6UFIVj1riI0sxbXwA9UYHAVVkgvL+5ULq9
	3LBXv6GEsFex+rOpZGzTo5FaJO8Dxfnps8g5cqS9BXbXEL4mhe6AS9YNKNJSHc/1wZ4h/O
	5yJP271WnHZvH4L8shBYY0F5L/nMxTMW3C6PLLOa4tgKch0ebvZPV5+nnRnNa43KN58zv/
	VJhjMF+nnhspsmbCWA1njm/fL1vPj+uZHpPTaTAD2AEyKvJaMunrvsfrtEEYo7rtA7bYhq
	GGYez4gFAzd7cy8JJBxYZwwGWrFlVTFlldS2R0AW8MGKDUgfCwaxFNTjVHygbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754667011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cMXIxvxE5BQvdmzpDVy/7yXWORR6dKljoelXvDwT6tc=;
	b=D+UQHaC29ml9YHi2VtO86C2YQKZjsK8ZxHXCq5M+8Y8U3C7IrecN4LE6aRhnaBsKH0ygsM
	+ciYPPkj2C2U1wCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: kernel test robot <lkp@intel.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: ld.lld: error: undefined symbol: xt_recseq
Message-ID: <20250808153010.09myPtN7@linutronix.de>
References: <202508061149.iM5f5qtm-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202508061149.iM5f5qtm-lkp@intel.com>

On 2025-08-06 11:09:05 [+0200], kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   479058002c32b77acac43e883b92174e22c4be2d
> commit: 9fce66583f06c212e95e4b76dd61d8432ffa56b6 netfilter: Exclude LEGACY TABLES on PREEMPT_RT.
> date:   12 days ago
> config: i386-buildonly-randconfig-2001-20250806 (https://download.01.org/0day-ci/archive/20250806/202508061149.iM5f5qtm-lkp@intel.com/config)
> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250806/202508061149.iM5f5qtm-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202508061149.iM5f5qtm-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):

As far as I can tell, this is fixed by
	25a8b88f000c3 ("netfilter: add back NETFILTER_XTABLES dependencies")
	https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git/commit/?h=for-netdev-nf-25-08-07&id=25a8b88f000c33a1d580c317e93e40b953dc2fa5

Sebastian

