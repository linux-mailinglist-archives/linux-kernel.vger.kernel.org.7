Return-Path: <linux-kernel+bounces-715818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01230AF7E29
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jul 2025 18:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EB015856F5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jul 2025 16:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E413A248F5F;
	Thu,  3 Jul 2025 16:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rIWixzvj"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7181833DF
	for <linux-kernel@vger.kernel.org>; Thu,  3 Jul 2025 16:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751561239; cv=none; b=gkm51SdcBOUnJob7969k2eRCs3OqOOAgso+u8nyzshv8vAldxdfWiI5xRsWjte+72Xu16PfiIOd7wCYtVMJIItBN5q9AX69oe862ILxdSEFowxVEGeab9vyLKCRXc6wX/DaoAfOhCuENX3dVmHB85NHsaGDpIbDRAkDrmFZaRq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751561239; c=relaxed/simple;
	bh=bPdmBJpr+0n4/dZVYvzLyG0nYYbdUEbX7joHkZqlf3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L/1ix4i5pxeyRAosK9OAqn4nlndD6MUbZCsfPJyRjLBX646wEhqs8BBSPlqHbLTQbr9JYRZduCbnM3pnWyKAnKRar/o3zq25vF0vD9pW4WDzfuRLJiEbRMOEEvXmjGMvvmfzGkRumSS7Gvsqbxis72gHeB6ooIUdR7aPeja8OYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rIWixzvj; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hA4hmvyAkI8aCMOwywVt/416zIzVxDyFKXBb3uab40o=; b=rIWixzvjY0exX9wBaZNHL8r81H
	za0U5lS3nqfTmGz6UE8xGAr8UXGKLV5TIVU0go16efDrV+HmoPegC5LHeovuQdXYFMmDLFpmX02hu
	T0IgvHzF0ZOjVQAjUQYGkGTtPMCyQHkzUzV/m9FPWl2b28anpBBhvcCrf4iggNy3Rk/4NNbtzepIG
	dRSUhQhDEb3Zpe/5ZamFjd/2uqzG53K9A6uYm3PKzrTSm1h8CXnBZqFU2e9xweRPpnIv6drNi4ASh
	qIT7l4LwcZG+5fs0zV6hp1B8GLH5FPbcpO/BoiSYQj2DYPscd/zWfL8aEZAs/kWUb+Fq+XzC/9PMT
	y49w7c3A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXN5Z-0000000DjjU-27ja;
	Thu, 03 Jul 2025 16:47:09 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 26A5A30017D; Thu, 03 Jul 2025 18:47:08 +0200 (CEST)
Date: Thu, 3 Jul 2025 18:47:08 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Phil Auld <pauld@redhat.com>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, clm@meta.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 12/12] sched: Add ttwu_queue support for delayed tasks
Message-ID: <20250703164708.GZ1613200@noisy.programming.kicks-ass.net>
References: <20250702114924.091581796@infradead.org>
 <20250702121159.652969404@infradead.org>
 <20250703160027.GC245663@pauld.westford.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703160027.GC245663@pauld.westford.csb>

On Thu, Jul 03, 2025 at 12:00:27PM -0400, Phil Auld wrote:

> > +	if (ttwu_do_migrate(rq, p, cpu))
> > +
> 
> This doesn't compile because ttwu_do_migrate() doesn't take a *rq.
> 
> It's easy enough to fix up and I'll try to have our perf team try these
> out. 

I'm confused, isn't that what patch 7 does?

Also, I updated the git tree today, fixing a silly mistake. But I don't
remember build failures here.

