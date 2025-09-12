Return-Path: <linux-kernel+bounces-814120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B84C6B54F87
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6509C5A5181
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDE630DEBB;
	Fri, 12 Sep 2025 13:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cmWWpW59"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF10249E5
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 13:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757683712; cv=none; b=pUVv8Ar6ZSVtEPeA24/bqYYEXjI8Qg8s0nAVIiPouBVx9IUoeNoIiusdahVSlbt/9yKjzMGW1fvA3DCNjJzeEuHEdfUMbXY4Q0CGLoL0IlIo5xca7saYvTy+cN9ShLbguIqxnUO6jdVk6nyF/O6xa3F+UJit3qLjzSoTokUP7Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757683712; c=relaxed/simple;
	bh=n9vADEGKeUYWQU7FkqiWQu2aTA8jVFqJtfuYBbSbGTY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dAbcWbXNW6gJhxVC6mKl5Qiki5qL7CeKfpasTCJQasY2M40DYg7WEAG4XnXR7HNncRgm3Q/hFwLngTYak8HlQ7wH3SC5l5ubY1iVm92y6jeFrWKpZKjOdvREw1URVhCWLl7xXqTi+sD+n2NaHaQjJjl6d+EtJABl1Wtge0/vJrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cmWWpW59; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757683707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+ns7H8CB30PHzOE+CLH8DzyRO1n3rgJ84XgwC8jafww=;
	b=cmWWpW59hiaPFvHb/tGmBvinl/fxs1nqNO9wiy6G69d+tDQBnuBciv/B3Dr9Mpj7+ZI2Ss
	O3oYzUtE9RXp9zt/xTaG2IMtocMombghGby2kJxyQOECQwdkXsvil/kc1KWbbNyVo/n06D
	gnkn0OmpK90PoogBSiBmEnOVscCQHII=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: benjamin@sipsolutions.net
Cc: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	arnd@arndb.de,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev
Subject: Re: [PATCH v2 04/10] um: Turn signals_* into thread-local variables
Date: Fri, 12 Sep 2025 21:27:53 +0800
Message-Id: <20250912132753.2651038-1-tiwei.bie@linux.dev>
In-Reply-To: <250234d1acd54553bf5f55972d9b05cfccb2cfab.camel@sipsolutions.net>
References: <250234d1acd54553bf5f55972d9b05cfccb2cfab.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Fri, 12 Sep 2025 09:58:49 +0200, Benjamin Berg wrote:
> On Fri, 2025-09-12 at 08:30 +0800, Tiwei Bie wrote:
> > On Thu, 11 Sep 2025 10:06:53 +0200, Benjamin Berg wrote:
> > 
> > > [SNIP]
> > > That said, I do believe that the allocations from the libc itself are
> > > problematic. A lot of the mappings from UML are there already (i.e. the
> > > physical memory is mapped). However, I believe the vmalloc area for
> > > example is not guarded.
> > > 
> > > So when pthread allocates the thread specific memory (stack, TLS, ...),
> > > we really do not know where this will be mapped into the address space.
> > > If it happens to be in an area that UML wants to use later, then UML
> > > could map e.g. vmalloc data over it.
> > > 
> > > Now, it could be that (currently) the addresses picked by pthread (or
> > > the host kernel) do not actually clash with anything. However, I do not
> > > think there is any guarantee for that.
> > 
> > Indeed. The mmap from libc (pthread, shared libs, ...) can potentially
> > conflict with UML. The reason it has been working on x86_64 so far might
> > be that we did this in linux_main():
> > 
> > 	task_size = task_size & PGDIR_MASK;
> > 
> > The current layout is:
> > 
> > shared libs and pthreads are located at 7ffxxxxxxxxx
> > TASK_SIZE                             = 7f8000000000
> > VMALLOC_END                           = 7f7fffffe000 (which is TASK_SIZE-2*PAGE_SIZE)
> 
> Uh, right, yes. Because of the masking we are capping ourselves to
> 0x7f8000000000. And then all of the interesting bits (vdso, ...) happen
> to be mapped above that address and are effectively protected. And,
> there is also plenty of space for other allocations technically.
> 
> That is kind of horrible, as it only works because all of this happens
> to be mapped into the top of the address space.

+1.

> But, maybe something to
> just wilfully ignore and only fix as part of a nolibc port?

Sure. Thanks!

Regards,
Tiwei

