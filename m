Return-Path: <linux-kernel+bounces-851875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2873EBD7803
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 07:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59A6B40289E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 05:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1D83043D8;
	Tue, 14 Oct 2025 05:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZgR5WYcd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95CB3054D0
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 05:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760421304; cv=none; b=mBUIbD0qXY6/n9cDuySZX/tya+GyyBT2IFoz/gFPuox8PnVZEbIqVWo8hryZ13l7gWSt40oB7KyvRdCyHsHduGhrRm56Z/WE6kdysWNmkgwyGNDWTiStPnETBfeildaCQ9OaIp6Ti8weew6MBGCNdZpYEFFyUNUP5C35BGAP+l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760421304; c=relaxed/simple;
	bh=yXwEx39SW/o4ktzJekxrqUuu5wbUKI25mXm4Y616TVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N5tS7FI1q4g2bmRyOxoKFHFpDHG1JRESDuA+o1naNANbQHEyLlO9Mw8T/6XVg0kgbsLkTaxWRlYq43kfST04+8JASdGzK7gUKkC8UWD2WYx4ln0yvtQfuxuKxH+od8zKT6kCKiWsFWr8TRoRKxymBzLje/SFQsmFNVbJ3mo7dF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZgR5WYcd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 986C8C4CEF1;
	Tue, 14 Oct 2025 05:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760421303;
	bh=yXwEx39SW/o4ktzJekxrqUuu5wbUKI25mXm4Y616TVU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZgR5WYcdfSu4Du7E7jXQmhA1nOopUroh/P6YKhIJHde/wL7WEEs6yWrzsqiJWfXMj
	 YywfVbx8RePX7FI1MFct3JLvpiM8jXrdNGVjeW7Bdf3Ya6NXk12l81Gd3GOPtqDUsI
	 6N1uLQxpwOR7aT4i6hjaUEjwos/MJssCXirzUKpDy/RIGaUf4/yZW1dfgt6YzvOnc+
	 xUXYS5BK9RYfvt8G7U8ojRK0MgjD78KEFHaypQgW+7t/3aJw5EnlpkxN+b+dng3yCP
	 wHaLEyOEhETMfIsYAZ/BNJfYcRttZKyxMO8Z0sGy9sQ2MqDZct7p5bHsMKSOmCSWeH
	 NEZmRwmmWZPQg==
Date: Mon, 13 Oct 2025 22:54:58 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Feng Chen <feng.chen@amlogic.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: Re: Linux 6.18-rc1
Message-ID: <20251014055458.GA2373807@ax162>
References: <CAHk-=whPJTtX5u1m47fPUD2g2Dc=Did_6OqCVj6OQPKFgfKn9g@mail.gmail.com>
 <f594c621-f9e1-49f2-af31-23fbcb176058@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f594c621-f9e1-49f2-af31-23fbcb176058@roeck-us.net>

On Mon, Oct 13, 2025 at 10:08:22AM -0700, Guenter Roeck wrote:
> Building openrisc:allmodconfig ... failed
> --------------
> Error log:
> In file included from include/linux/cpumask.h:11,
>                  from include/linux/smp.h:13,
>                  from include/linux/lockdep.h:14,
>                  from include/linux/spinlock.h:63,
>                  from include/linux/mmzone.h:8,
>                  from include/linux/gfp.h:7,
>                  from include/linux/slab.h:16,
>                  from fs/nfsd/nfs4xdr.c:37:
> fs/nfsd/nfs4xdr.c: In function 'nfsd4_encode_components_esc':
> include/linux/kernel.h:334:46: error: called object 'strlen' is not a function or function pointer
> 
> bisect:
> 
> # bad: [3a8660878839faadb4f1a6dd72c3179c1df56787] Linux 6.18-rc1
> # good: [e5f0a698b34ed76002dc5cff3804a61c80233a7a] Linux 6.17
> git bisect start 'HEAD' 'v6.17'
> # good: [58809f614e0e3f4e12b489bddf680bfeb31c0a20] Merge tag 'drm-next-2025-10-01' of https://gitlab.freedesktop.org/drm/kernel
> git bisect good 58809f614e0e3f4e12b489bddf680bfeb31c0a20
> # bad: [bed0653fe2aacb0ca8196075cffc9e7062e74927] Merge tag 'iommu-updates-v6.18' of git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux
> git bisect bad bed0653fe2aacb0ca8196075cffc9e7062e74927
> # good: [be812ace0378a9db86344ad637c5ed2a5d11f216] Bluetooth: Avoid a couple dozen -Wflex-array-member-not-at-end warnings
> git bisect good be812ace0378a9db86344ad637c5ed2a5d11f216
> # good: [8804d970fab45726b3c7cd7f240b31122aa94219] Merge tag 'mm-stable-2025-10-01-19-00' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> git bisect good 8804d970fab45726b3c7cd7f240b31122aa94219
> # good: [b3fee71e6673393d04476fbe0f4f03f97765e32d] Merge tag 'v6.18rc1-part1-ksmbd-server-fixes' of git://git.samba.org/ksmbd
> git bisect good b3fee71e6673393d04476fbe0f4f03f97765e32d
> # good: [944df7a31452f75bbc15b1e7215e1aacee8cd1b4] docs: update the guidance for Link: tags
> git bisect good 944df7a31452f75bbc15b1e7215e1aacee8cd1b4
> # bad: [50647a1176b7abd1b4ae55b491eb2fbbeef89db9] Merge tag 'pull-f_path' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs
> git bisect bad 50647a1176b7abd1b4ae55b491eb2fbbeef89db9
> # bad: [c817248fc831f5494d076421672b70a6ec1a92dc] nfs/localio: add proper O_DIRECT support for READ and WRITE
> git bisect bad c817248fc831f5494d076421672b70a6ec1a92dc
> # bad: [4b7c3b4c673d40e4b98cdaf642495929f43787e6] NFS: Update the flexfilelayout driver to use xdr_set_scratch_folio()
> git bisect bad 4b7c3b4c673d40e4b98cdaf642495929f43787e6
> # bad: [bf75ad096820fee5da40e671ebb32de725a1c417] NFSv4.1: fix mount hang after CREATE_SESSION failure
> git bisect bad bf75ad096820fee5da40e671ebb32de725a1c417
> # good: [64dd8022245038109826c0e2a778f16618d88600] nfs: cleanup tracepoint declarations
> git bisect good 64dd8022245038109826c0e2a778f16618d88600
> # bad: [be390f95242785adbf37d7b8a5101dd2f2ba891b] NFSv4: handle ERR_GRACE on delegation recalls
> git bisect bad be390f95242785adbf37d7b8a5101dd2f2ba891b
> # bad: [ec7d8e68ef0ec5c635c8f9e93cd881673445a397] sunrpc: add a Kconfig option to redirect dfprintk() output to trace buffer
> git bisect bad ec7d8e68ef0ec5c635c8f9e93cd881673445a397
> # good: [9082aae154be2d9e208b56e249cb886612f7c6cf] sunrpc: remove dfprintk_cont() and dfprintk_rcu_cont()
> git bisect good 9082aae154be2d9e208b56e249cb886612f7c6cf
> # first bad commit: [ec7d8e68ef0ec5c635c8f9e93cd881673445a397] sunrpc: add a Kconfig option to redirect dfprintk() output to trace buffer
> 
> I did not try to understand why that patch triggers the build failure,
> but reverting it fixes the problem (not that it is a good idea to have
> a variable named 'strlen').
> 
> Author: Jeff Layton <jlayton@kernel.org>

I sent a patch for this:

https://lore.kernel.org/20250930-nfsd-fix-trace-printk-strlen-error-v3-1-536cc9822ee6@kernel.org/

which Chuck appears to have tenatively applied:

https://git.kernel.org/cel/c/c710de671789388b3af1046c7091685594ec44d9

Cheers,
Nathan

