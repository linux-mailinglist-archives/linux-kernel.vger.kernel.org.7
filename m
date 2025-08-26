Return-Path: <linux-kernel+bounces-786618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A28BBB35F23
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 14:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DCEA3A7955
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 12:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410E41DDC1D;
	Tue, 26 Aug 2025 12:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="cxFNAOcH"
Received: from pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.35.192.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA19D2AD2C
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 12:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.35.192.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756211539; cv=none; b=RAqXteeKciXgO1H35XKJOXaEYxhJSErPW6+CaeRQZRBWNAsU3PkqowTEJDVDsgVbMchtanAykSmMz8sOVFhzfPnsCG6PXJvHYJoiu6Uwco5XoGKDSFSeENunRjfwjnMY7ibX6nd7BLNDW6AMRaqEX5HM2/Qw9dML82rdwkPBFz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756211539; c=relaxed/simple;
	bh=Bn1mgvNuOiHqjq3XKP6HGDR38GZYHK41WVavCEF78S8=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HBYTpkV0kFsYl0y4meZu4QX+fkCKkYQkIdF+gf3SHt9bjEK8irZzPl2R/lyIzY5psEXsE4aotZMj0CY5+r/bqGuyqZ0eS0WvmFr9aqeOZRIt0FvX83KNelEfINBjMwIN7hb3iem+or3n2P3ZMy9K0+Gi1bZ5yguVrjJErdj6FXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=cxFNAOcH; arc=none smtp.client-ip=52.35.192.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1756211537; x=1787747537;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=rGyARBczImSI4wNMqnE8j3mqUIz2tAvrLtU3ceQ/xjw=;
  b=cxFNAOcHhD/2oxj/LajPe31CFvi6/yrr74amnVNW06mpU6HORcvPOLs8
   6JzrQYmKLXFKLTKzaY4blS3QKS3BxjZDxOdF9Z576vBhqHXH4GN7ospdN
   MP3pRoPbDf8Q6z9YZ0dZgjoipxqEaJIdktExzAar1yoBNh53CVRrbjrl0
   /FpfqcQbUw1+3vJn9SXFTuRg1zvOEIgMUCMUM83EPxnYE6aoMe0F8z3+r
   w8hd3/bXZQWoFNFXD/QLUPvb4+ocVcGAbwEA2siKAAk4MYpEeRHMWyJtf
   Qi38zl31pS2R2+Ia0DUkpZnLSRFbt0DUkV0PNkWtgmEF96M+52NNOG4pz
   A==;
X-CSE-ConnectionGUID: FIcGtJriTUOh+txoijCjjg==
X-CSE-MsgGUID: GaIdYBMPT8qlxm+H2NA9Pw==
X-IronPort-AV: E=Sophos;i="6.18,214,1751241600"; 
   d="scan'208";a="1701264"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 12:32:12 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:34798]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.52.56:2525] with esmtp (Farcaster)
 id b514d795-1824-4752-ad9c-2fc3301fae56; Tue, 26 Aug 2025 12:32:12 +0000 (UTC)
X-Farcaster-Flow-ID: b514d795-1824-4752-ad9c-2fc3301fae56
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Tue, 26 Aug 2025 12:32:11 +0000
Received: from dev-dsk-simonlie-1b-d602a7e1.eu-west-1.amazon.com
 (10.13.232.104) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17; Tue, 26 Aug 2025
 12:32:08 +0000
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
In-Reply-To: <c69341d2-bf01-48df-9eeb-e346f72c9409@intel.com> (Dave Hansen's
	message of "Mon, 25 Aug 2025 07:02:37 -0700")
References: <20250825104847.36669-1-simonlie@amazon.de>
	<c69341d2-bf01-48df-9eeb-e346f72c9409@intel.com>
Date: Tue, 26 Aug 2025 12:32:07 +0000
Message-ID: <h6liptt1umfg8.fsf@dev-dsk-simonlie-1b-d602a7e1.eu-west-1.amazon.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA002.ant.amazon.com (10.13.139.39) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Dave Hansen <dave.hansen@intel.com> writes:

> On 8/25/25 03:48, Simon Liebold wrote:
>> Commit 03475167fda5 ("x86: Increase brk randomness entropy for 64-bit
>> systems") increased the brk randomness from 32 MiB to 1 GiB. MAP_32BIT
>> looks between 1 GiB and 2 GiB for an unmapped area. Depending on the
>> randomization, a heap starting high enough and being big enough can use
>> up all the area that MAP_32BIT looks at, leading to allocation failures.
>
> Isn't that still a really unreasonably gigantic heap?
>
> Would you mind posting some actual /proc/$pid/maps output from one of
> the failure cases?

Hello Dave,

we are seeing heaps this large on real workloads. This is a Lua
application using LuaJit v2.0.

This is an excerpt from the output of one of the failure cases:

    00400000-00566000 r-xp 00000000 103:01 4476567               [...]/bin/httpd.orig
    00765000-0076b000 r--p 00165000 103:01 4476567               [...]/bin/httpd.orig
    0076b000-00772000 rw-p 0016b000 103:01 4476567               [...]/bin/httpd.orig
    00772000-00778000 rw-p 00000000 00:00 0
    34a21000-35021000 rw-p 00000000 00:00 0                      [heap]
    35021000-82ea7000 rw-p 00000000 00:00 0                      [heap]
    7fee7c0ba000-7fee7c11f000 r-xp 00000000 103:01 3836609       [...]/lib/libluajit-5.1.so
    7fee7c11f000-7fee7c31f000 ---p 00065000 103:01 3836609       [...]/lib/libluajit-5.1.so
    7fee7c31f000-7fee7c321000 r--p 00065000 103:01 3836609       [...]/lib/libluajit-5.1.so
    7fee7c321000-7fee7c322000 rw-p 00067000 103:01 3836609       [...]/lib/libluajit-5.1.so
    [Other maps at high addresses...]

Regards,

Simon Liebold



Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


