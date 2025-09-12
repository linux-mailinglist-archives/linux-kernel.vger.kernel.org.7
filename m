Return-Path: <linux-kernel+bounces-813003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D7FB53F82
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 02:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0E791713FA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 00:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66E717555;
	Fri, 12 Sep 2025 00:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hpNzexgm"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD8F1114
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 00:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757637088; cv=none; b=mcJgcrGONwZIG+FWzjXHLEq+ohparZlsLdCbXac/e3DUpc+LqV2drxiFSZ/NESfS8E8YyAcl8SorbVMmBueYboO0OPkKBYonGF0ZnTWfuTakF/YBlLwLG5kUeHEavTu/dDtiqXr3Gg5CJ61+lSvN4vzDxOVMUQxtCIXjFemOfKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757637088; c=relaxed/simple;
	bh=V9v+l2yWhLRNr/5hshvuc6mxKVdciHSRpWmqgued1Og=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y9/9Q4FrjUyyQGVDCJ/xcsVWacnUbMnj+0pX6yBHUqMUbUOMj1SEPgTuTUJ09rBJA5yJsyLB8KOKq1TY+BPSZ0Du8I9VwBXDdQAmSWc/Iw6ZcDcXbkoemWeUi5c+SOHt9DRSt4iNyJbTf8jldjL6JtcOU9vXjkp8wTjlS303qiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hpNzexgm; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757637074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EZxU73zTx/9g+dWjgY/xVOQON0jaT8APRpXiMYNVZyc=;
	b=hpNzexgmJhu8VyBysEyHt3YLiXdHNjA6/43xJrjFF8XDfRdNDiA2za4rG6vaCf9mrodWZ1
	Rsb69FTkg9bMCXFpWE0BoJ1zXFLXrGYoKGHtF9zqYP7wp1wsNW9pLMG5AFpDIRfS95o7Cd
	HxvnJBa910jt61gODQpFumI47JnXbsI=
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
Date: Fri, 12 Sep 2025 08:30:54 +0800
Message-Id: <20250912003054.2564842-1-tiwei.bie@linux.dev>
In-Reply-To: <75ba2109fcdfb8a1629fdf5f6b4e58694b975c9f.camel@sipsolutions.net>
References: <75ba2109fcdfb8a1629fdf5f6b4e58694b975c9f.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi,

On Thu, 11 Sep 2025 10:06:53 +0200, Benjamin Berg wrote:
> On Thu, 2025-09-11 at 09:37 +0200, Benjamin Berg wrote:
> > On Thu, 2025-09-11 at 12:34 +0800, Tiwei Bie wrote:
> > > On Wed, 10 Sep 2025 14:15:28 +0200, Johannes Berg wrote:
> > > > On Sun, 2025-08-10 at 13:51 +0800, Tiwei Bie wrote:
> > > > > From: Tiwei Bie <tiwei.btw@antgroup.com>
> > > > > 
> > > > > Turn signals_enabled, signals_pending and signals_active into
> > > > > thread-local variables. This enables us to control and track
> > > > > signals independently on each CPU thread. This is a preparation
> > > > > for adding SMP support.
> > > > 
> > > > [...]
> > > > 
> > > > > +static __thread int signals_enabled;
> > > > 
> > > > How much glibc infrastructure does __thread rely on? More
> > > > specifically:
> > > > Some time ago we had a discussion about building UML as a nolibc
> > > > binary,
> > > > what would that mean for the __thread usage here?
> > > 
> > > We would need to parse TLS data (PT_TLS) from the ELF file
> > > ourselves
> > > and properly set up TLS when creating threads using clone().
> > 
> > I guess right now we cannot use PER_CPU variables in these files.
> > However, my expectation that this is possible when using nolibc, and
> > then it should be simple enough to replace the __thread.

Good idea!

> 
> That said, I do believe that the allocations from the libc itself are
> problematic. A lot of the mappings from UML are there already (i.e. the
> physical memory is mapped). However, I believe the vmalloc area for
> example is not guarded.
> 
> So when pthread allocates the thread specific memory (stack, TLS, ...),
> we really do not know where this will be mapped into the address space.
> If it happens to be in an area that UML wants to use later, then UML
> could map e.g. vmalloc data over it.
> 
> Now, it could be that (currently) the addresses picked by pthread (or
> the host kernel) do not actually clash with anything. However, I do not
> think there is any guarantee for that.

Indeed. The mmap from libc (pthread, shared libs, ...) can potentially
conflict with UML. The reason it has been working on x86_64 so far might
be that we did this in linux_main():

	task_size = task_size & PGDIR_MASK;

The current layout is:

shared libs and pthreads are located at 7ffxxxxxxxxx
TASK_SIZE                             = 7f8000000000
VMALLOC_END                           = 7f7fffffe000 (which is TASK_SIZE-2*PAGE_SIZE)

However, on i386, the risk of conflicts looks much higher:

TASK_SIZE   = ffc00000
VMALLOC_END = ffbfe000

......
f7c00000-f7c20000 r--p 00000000 08:01 9114                               /usr/lib32/libc.so.6
f7c20000-f7d9e000 r-xp 00020000 08:01 9114                               /usr/lib32/libc.so.6
f7d9e000-f7e23000 r--p 0019e000 08:01 9114                               /usr/lib32/libc.so.6
f7e23000-f7e24000 ---p 00223000 08:01 9114                               /usr/lib32/libc.so.6
f7e24000-f7e26000 r--p 00223000 08:01 9114                               /usr/lib32/libc.so.6
f7e26000-f7e27000 rw-p 00225000 08:01 9114                               /usr/lib32/libc.so.6
f7e27000-f7e31000 rw-p 00000000 00:00 0 
f7fbe000-f7fc0000 rw-p 00000000 00:00 0 
f7fc0000-f7fc4000 r--p 00000000 00:00 0                                  [vvar]
f7fc4000-f7fc6000 r-xp 00000000 00:00 0                                  [vdso]
f7fc6000-f7fc7000 r--p 00000000 08:01 9107                               /usr/lib32/ld-linux.so.2
f7fc7000-f7fec000 r-xp 00001000 08:01 9107                               /usr/lib32/ld-linux.so.2
f7fec000-f7ffb000 r--p 00026000 08:01 9107                               /usr/lib32/ld-linux.so.2
f7ffb000-f7ffd000 r--p 00034000 08:01 9107                               /usr/lib32/ld-linux.so.2
f7ffd000-f7ffe000 rw-p 00036000 08:01 9107                               /usr/lib32/ld-linux.so.2
fffdd000-ffffe000 rw-p 00000000 00:00 0                                  [stack]

Ideally, we could completely eliminate the dependency on libc. Before that,
perhaps we could reserve a region of address space for UML with mmap(PROT_NONE).

Regards,
Tiwei

