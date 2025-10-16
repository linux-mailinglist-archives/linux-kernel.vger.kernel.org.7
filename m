Return-Path: <linux-kernel+bounces-856822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAE0BE52CB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 21:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DCD924E8AA3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 19:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E845823E358;
	Thu, 16 Oct 2025 19:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OX9fJawU"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E023D23E34C
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 19:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760641629; cv=none; b=OVN2fie+Z7Pmdk8DZjkppEiTYY3WyxHtH3KV/tx86gnAH1cE2ihZsamTvaweQRWaHBNZt7vFMnp7rgz2NO2Cz2s2PI3m2DqfW/nJU/tZogoTKmGc5FQEkX7M/DyA3WgQ0etyvA0FPwzT4LxKwn416HAlP5AvT4U3G4rWhxd2Kwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760641629; c=relaxed/simple;
	bh=xQK2os/eeIZl048ps4wSDRHIjD3SlzL6wi1dORI4+4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YHaUrp4TbHGUyyccDseVjD1MgsXh4Zrp4g/7vouBupzUK+eS3iEuw98e4MrYhh5Nf9ziI9Cy/sa5pZs0X37zTT9wWuFo/HHQp0Bk/7Ni1KjW3w5C17FCCVZJD1ulDLV8QBdF6N1SmFkJDZ7fZZCqMvMjH9pwlOXvAxLFcDQH0lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OX9fJawU; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kEqZzwVbVDtLlhNssXWczLoREFuVa/SbradjrL9usdQ=; b=OX9fJawUMKwZFQUcNxlDns226m
	UZNOWK2//fIDXuP06+oicxJ8yNP78lTO6MiGjIx0cCOIofvTTSRU8RWqT0nDA2yYjlTi8mPUVtEvY
	VvJgfISZkpPf7d1ci13PdlbiBH9H+mx7pAbiUd4ccSSy+biYVy8udF9yPPRB9XQQXcrr32GAuWKr0
	0mKeVKZ3XFepu7q4vyWd21TWqJToA2CcfihAcgx01aOu/0HM+nn6LtX+zBmpUcodHfWc+tzmkfJWv
	yShQzUD7fsGWXb6By9BHfu+1o5vXcUxJeAhLiOmQsUW3pHWm75r3MltK6t1o3kYSCUSehYDd5wIHx
	q6tE7BPQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9TJK-00000006yCM-13A9;
	Thu, 16 Oct 2025 19:06:51 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CB1B6300220; Thu, 16 Oct 2025 21:06:49 +0200 (CEST)
Date: Thu, 16 Oct 2025 21:06:49 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Cruz Zhao <CruzZhao@linux.alibaba.com>, mingo@redhat.com,
	will@kernel.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [BUG RESEND] Kernel panic in update_cfs_rq_h_load() on aarch64
Message-ID: <20251016190649.GI3289052@noisy.programming.kicks-ass.net>
References: <20251013071820.1531295-1-CruzZhao@linux.alibaba.com>
 <aPEoLc1mDB22f2Ff@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPEoLc1mDB22f2Ff@arm.com>

On Thu, Oct 16, 2025 at 06:15:25PM +0100, Catalin Marinas wrote:
> On Mon, Oct 13, 2025 at 03:17:58PM +0800, Cruz Zhao wrote:
> > Hi, all. We are encountering a kernel panic in our production environment
> > running Linux kernel version 5.10.134, on aarch64 architecture (aarch64
> > architecture only).
> > 
> > Summary:
> > - Kernel Version: 5.10.134
> 
> That's a pretty old kernel though still maintained LTS. Can you
> reproduce this with the latest 5.10.x?

FWIW, there is this thread:

  https://lkml.kernel.org/r/bc08fcd528bad11311cd25de37962eb1ce0e7879.1760530739.git.peng_wang@linux.alibaba.com

