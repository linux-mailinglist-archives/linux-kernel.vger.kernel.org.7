Return-Path: <linux-kernel+bounces-660970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6283AC24B6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 16:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B0327B6DE4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 14:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CED2951D1;
	Fri, 23 May 2025 14:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SU0OglXn"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2042293750
	for <linux-kernel@vger.kernel.org>; Fri, 23 May 2025 14:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748009335; cv=none; b=L3cnmsu3HDX6rhyxg9ieEt9gcvgc+Ynor4zXRPx2UShhYZnzD3bZppQAGNbUdUKgoZzoU4hs7qhiGTIDNJn+8AHGstSyaSfw3o/I/1ppWOgBR1nama8EKT6NgsVYY6mkMmf1V6AnDnFoSc0TPBBMDuP2Bcsqjw0QOjFWxZ4LnZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748009335; c=relaxed/simple;
	bh=nGLPDMsCWixuZ6gz7stCBijHjh6Lpd4OoCmJhRU1ceo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u0wdRfcNkGavgAkBXG72SwPe8WQvlx7tLHmbcxl+zvT/wgNHKa8VBk2GBnwz/D04TTP/87td+NpdUs73/FaAB9nu8tKuygoEme1tDQkdC7OdUuaWiCdpo+Bic/hscFjDpFSc3RzwdZdM/XAyX+34EmDGqddySpdGOuzoqxaHnQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SU0OglXn; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 23 May 2025 10:08:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748009321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AlT8o3aeiD7EPPoEZehL5aOxHjk24xCHBMAZA2G9EwQ=;
	b=SU0OglXn00SDFfg645VfoOGWsgjOcsQkTLYc4TCdi1tVq064TXmBLrYVJCljo36B7IQ+Gu
	gSI/2ozlSR+IWfxigNNWVgBUDNyA212fyKdhXxNbloitBcfsjzNWwCzQ8kdrumKiJFFfvl
	nAvn8peFCsx9ZkYPH1ynfRb/6yQgu8M=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, 
	linux-bcache@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>
Subject: Re: riscv gcc-13 allyesconfig error the frame size of 2064 bytes is
 larger than 2048 bytes [-Werror=frame-larger-than=]
Message-ID: <7tsvzu2mubrpclr75yezqj7ncuzebpsgqskbehhjy6gll73rez@5cj7griclubx>
References: <CA+G9fYv08Rbg4f8ZyoZC9qseKdRygy8y86qFvts5D=BoJg888g@mail.gmail.com>
 <6tgxbull5sqlxbpiw3jafxtio2a3kc53yh27td4g2otb6kae5t@lr6wjawp6vfa>
 <CA+G9fYsjBXvm9NNKRbVo_7heX1537K8yOjH7OaSEQhGRmkLvgA@mail.gmail.com>
 <6247de76-d1f5-4357-83bd-4dd9268f44aa@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6247de76-d1f5-4357-83bd-4dd9268f44aa@app.fastmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, May 23, 2025 at 03:49:54PM +0200, Arnd Bergmann wrote:
> On Fri, May 23, 2025, at 15:19, Naresh Kamboju wrote:
> > On Thu, 22 May 2025 at 22:18, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> >>
> >> On Thu, May 22, 2025 at 06:59:53PM +0530, Naresh Kamboju wrote:
> >> > Regressions on riscv allyesconfig build failed with gcc-13 on the Linux next
> >> > tag next-20250516 and next-20250522.
> >> >
> >> > First seen on the next-20250516
> >> >  Good: next-20250515
> >> >  Bad:  next-20250516
> >> >
> >> > Regressions found on riscv:
> >> >  - build/gcc-13-allyesconfig
> >> >
> >> > Regression Analysis:
> >> >  - New regression? Yes
> >> >  - Reproducible? Yes
> >> >
> >> > Build regression: riscv gcc-13 allyesconfig error the frame size of
> >> > 2064 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]
> >>
> >> Is this a kmsan build? kmsan seems to inflate stack usage by quite a
> >> lot.
> 
> KMSAN is currently a clang-only feature.
> 
> > This is allyesconfig build which has KASAN builds.
> >
> > CONFIG_HAVE_ARCH_KASAN=y
> > CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
> > CONFIG_CC_HAS_KASAN_GENERIC=y
> > CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
> > CONFIG_KASAN=y
> > CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX=y
> > CONFIG_KASAN_GENERIC=y
> > # CONFIG_KASAN_OUTLINE is not set
> > CONFIG_KASAN_INLINE=y
> > CONFIG_KASAN_STACK=y
> 
> I reproduced the problem locally and found this to go down to
> 1440 bytes after I turn off KASAN_STACK. next-20250523 has
> some changes that take the number down further to 1136 with
> KASAN_STACK and or 1552 with KASAN_STACK.
> 
> I've turned bcachefs with kasan-stack on for my randconfig
> builds again to see if there are any remaining corner cases.

Thanks for the numbers - that does still seem high, I'll have to have a
look with pahole.

