Return-Path: <linux-kernel+bounces-814166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C64FAB55020
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D825D1D629A6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6548D30DD0B;
	Fri, 12 Sep 2025 13:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="hOWG2se+"
Received: from pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.1.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019672D3735
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 13:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.1.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757685464; cv=none; b=UjjsOoa6GB9ykRof+bwAi+PlS1DYB/y7DJaHy+oSEyR2YY1Hn84HWca8b7C/e2w2tWOOu6CgXWKsWbupX7YNnkV1/a6NPzDZf7I19dQe3/wpzCMNfkqTZUoW+imlVVjhmlUIINxamVp2wFV+labFKDr2b//HHYmn8iALxqlrDoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757685464; c=relaxed/simple;
	bh=XAWPmIuOEW6iZp33se4JJnRqfK031chAx6Ogi+CN5l4=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eGLJmheU6M49qRRwdzOcX1wwiFhdzmSHhFIZSn4MTCRnuJp7N0rdBxHrJNqHdtpMiPsHwZyLutxHj1qZCyZM0OHU66Cozgs/5EE67uKLq2nzig+uabYppIG0OweuHbHF4D9L0wZ/4SLDGn6lXZOgvG5K+takjyZb0Y1wQUIxgPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=hOWG2se+; arc=none smtp.client-ip=44.246.1.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1757685462; x=1789221462;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=t9gjpfv7LPDr+NqTEFkCSBIddQxUZOYqqn70K+XWxBA=;
  b=hOWG2se+eA+kwohiTavPPlDVKWcY7ryQ+7OreLj2SOF4lnz30xSew9IB
   VWGdJgkOrVax2Wjh9OtaAEGKejEzj5xGn2qRLKF3iOY7rTn9VzdrOErdi
   +dvYbS5y3PniV+Zjhmk9ykidWDOopn5d29aqhPz+2v8u/VhgPGVUgzFK1
   5WpLrhSp/3+VM/ZI/ESrGPNqoLmkMHWqUevh1VCG2HJWmkfXsro/gd0ta
   q1iPFmaj1MaIdD4lsw6nnZI5WUqIvEbW1O1qgmFgWXtmp8baORB4bl+iP
   GT2yd+W0UsHeiYX0ADdiqXcuP3hYvI25OfF+qr6ox5A39T6sPyi4FuC+h
   g==;
X-CSE-ConnectionGUID: JfBou5DESlKtqTDwEIR+KQ==
X-CSE-MsgGUID: NjWZWAFPQDapr2+ZObHHwA==
X-IronPort-AV: E=Sophos;i="6.18,259,1751241600"; 
   d="scan'208";a="2901672"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 13:57:40 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:17846]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.90:2525] with esmtp (Farcaster)
 id d41e25a8-8cee-4786-a64b-7405f7e75f4f; Fri, 12 Sep 2025 13:57:40 +0000 (UTC)
X-Farcaster-Flow-ID: d41e25a8-8cee-4786-a64b-7405f7e75f4f
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Fri, 12 Sep 2025 13:57:40 +0000
Received: from dev-dsk-simonlie-1b-d602a7e1.eu-west-1.amazon.com
 (10.13.232.104) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Fri, 12 Sep 2025
 13:57:38 +0000
From: Simon Liebold <simonlie@amazon.de>
To: Dave Hansen <dave.hansen@intel.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton
	<akpm@linux-foundation.org>, Mark Brown <broonie@kernel.org>, Lorenzo Stoakes
	<lorenzo.stoakes@oracle.com>, Helge Deller <deller@gmx.de>, "Liam R. Howlett"
	<Liam.Howlett@Oracle.com>, Simon Liebold <lieboldsimonpaul@gmail.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/mm: lower MAP_32BIT begin to reduce heap collisions
In-Reply-To: <h6liptt1umfg8.fsf@dev-dsk-simonlie-1b-d602a7e1.eu-west-1.amazon.com>
	(Simon Liebold's message of "Tue, 26 Aug 2025 12:32:07 +0000")
References: <20250825104847.36669-1-simonlie@amazon.de>
	<c69341d2-bf01-48df-9eeb-e346f72c9409@intel.com>
	<h6liptt1umfg8.fsf@dev-dsk-simonlie-1b-d602a7e1.eu-west-1.amazon.com>
Date: Fri, 12 Sep 2025 13:57:36 +0000
Message-ID: <h6lip8qijg4dr.fsf@dev-dsk-simonlie-1b-d602a7e1.eu-west-1.amazon.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWA001.ant.amazon.com (10.13.139.124) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Simon Liebold <simonlie@amazon.de> writes:

> Dave Hansen <dave.hansen@intel.com> writes:
>
>> On 8/25/25 03:48, Simon Liebold wrote:
>>> Commit 03475167fda5 ("x86: Increase brk randomness entropy for 64-bit
>>> systems") increased the brk randomness from 32 MiB to 1 GiB. MAP_32BIT
>>> looks between 1 GiB and 2 GiB for an unmapped area. Depending on the
>>> randomization, a heap starting high enough and being big enough can use
>>> up all the area that MAP_32BIT looks at, leading to allocation failures.
>>
>> Isn't that still a really unreasonably gigantic heap?
>>
>> Would you mind posting some actual /proc/$pid/maps output from one of
>> the failure cases?
>
> Hello Dave,
>
> we are seeing heaps this large on real workloads. This is a Lua
> application using LuaJit v2.0.
>
> This is an excerpt from the output of one of the failure cases:
>
>     00400000-00566000 r-xp 00000000 103:01 4476567               [...]/bin/httpd.orig
>     00765000-0076b000 r--p 00165000 103:01 4476567               [...]/bin/httpd.orig
>     0076b000-00772000 rw-p 0016b000 103:01 4476567               [...]/bin/httpd.orig
>     00772000-00778000 rw-p 00000000 00:00 0
>     34a21000-35021000 rw-p 00000000 00:00 0                      [heap]
>     35021000-82ea7000 rw-p 00000000 00:00 0                      [heap]
>     7fee7c0ba000-7fee7c11f000 r-xp 00000000 103:01 3836609       [...]/lib/libluajit-5.1.so
>     7fee7c11f000-7fee7c31f000 ---p 00065000 103:01 3836609       [...]/lib/libluajit-5.1.so
>     7fee7c31f000-7fee7c321000 r--p 00065000 103:01 3836609       [...]/lib/libluajit-5.1.so
>     7fee7c321000-7fee7c322000 rw-p 00067000 103:01 3836609       [...]/lib/libluajit-5.1.so
>     [Other maps at high addresses...]
>
> Regards,
>
> Simon Liebold

Hi Dave,

I wanted to follow up on our previous discussion about the brk
randomization and MAP_32BIT allocation failures.

The heap overflow we're seeing is standard LuaJIT v2.0 behavior under
certain workloads, not just custom programs with unusual memory
patterns. Given LuaJIT's widespread production use, these MAP_32BIT
allocation failures could impact many users.

While I understand this might be considered an edge case, it does make
MAP_32BIT allocations less reliable in practice.

Do you have any thoughts on this?

Regards,

Simon Liebold



Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


