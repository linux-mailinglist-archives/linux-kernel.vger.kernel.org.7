Return-Path: <linux-kernel+bounces-827172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 388F5B910B8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 14:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37BA81886292
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 12:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307B9305E2F;
	Mon, 22 Sep 2025 12:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="lVjG4Pdu"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975B318EFD1
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 12:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758542740; cv=none; b=EsY6EPSKS8tvvtlU8WqPgDGeVK7IU1G6Bxfm6N5ayclL49JW6NcGxxdOfvdr371OsSNPUJ5A96fKQdSQom/IWfEX7FINzSYvD/LELpXhDif0ApReKPHSsE6M3x4w9+jojL5NoMKkBthK4SwlNXwjbcBSCrIR0YI+1Dc1J9W7nAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758542740; c=relaxed/simple;
	bh=i8YXMN5Q3402PUiiai3EDlmaoxAVqUXPZ1ERWyiYf34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gRcZ5voyj+9C4olG2t1TmMmdiSuX2McYmZwmD0kR1S6qdhY5RxJZarrcwRf9Gl6LIQWv7292CDOvisVmkeECvS+9RH/2mAsMB4CHh6e6yWffCVmZSTmR+e6LAaHs73mf+2x5zNMoJkQ9/vyhRgQ8WsVyFj9zZAxpXZoAjw/PT2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=lVjG4Pdu; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1758542736;
	bh=i8YXMN5Q3402PUiiai3EDlmaoxAVqUXPZ1ERWyiYf34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lVjG4PduqoJK0Mm+tEwYy6qhcdW6bigG28rqwCwF7lHSJaxLVTuJBEXIC8Uj7YyyR
	 /egWXjlVBMasFDwjm2POqOMn3rrbCy6Wj0cyCu9yS9ibl0xN0tUfLhV5yr61FKkDC2
	 QA6QLnqTwQmihuUCG3A1Wn9PMLOUOqWJJOTpsets=
Date: Mon, 22 Sep 2025 14:05:34 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Tiwei Bie <tiwei.bie@linux.dev>
Cc: richard@nod.at, anton.ivanov@cambridgegreys.com, 
	johannes@sipsolutions.net, benjamin@sipsolutions.net, arnd@arndb.de, 
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, tiwei.btw@antgroup.com
Subject: Re: [PATCH v2 03/10] um: vdso: Implement __vdso_getcpu() via syscall
Message-ID: <495a5594-8ac6-4b7d-be6b-7c176b741c21@t-8ch.de>
References: <1568f254-7963-4015-91ed-7630d5d87881@t-8ch.de>
 <20250922045020.48158-1-tiwei.bie@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250922045020.48158-1-tiwei.bie@linux.dev>

On 2025-09-22 12:50:20+0800, Tiwei Bie wrote:
> On Sun, 21 Sep 2025 22:00:41 +0200, Thomas Weißschuh wrote:
> > On 2025-09-10 13:59:02+0200, Johannes Berg wrote:
> > > On Sun, 2025-08-10 at 13:51 +0800, Tiwei Bie wrote:
> > > > From: Tiwei Bie <tiwei.btw@antgroup.com>
> > > > 
> > > > We are going to support SMP in UML, so we can not hard code
> > > > the CPU and NUMA node in __vdso_getcpu() anymore.
> > > 
> > > Correct. But does that mean we actually have to implement it via syscall
> > > in the VDSO? That seems a bit odd? ARM doesn't seem to have getcpu in
> > > the VDSO at all, for example, so could we do the same and just remove
> > > it?
> > 
> > It is my understanding that the UM VDSO exists to cope with old versions
> > of glibc which would fall back to the old vsyscall mechanism if no VDSO
> > was present. That could fall through to the host kernels vsyscalls.
> > See commit f1c2bb8b9964 ("um: implement a x86_64 vDSO").
> > 
> > If this is not necessary anymore, the whole VDSO on UM can probably go
> > away.
> 
> The vsyscall usage was removed from glibc a decade ago:
> 
> https://sourceware.org/git/?p=glibc.git;a=commit;h=7cbeabac0fb28e24c99aaa5085e613ea543a2346
> 
> "This patch removes the vsyscall usage for x86_64 port.  As indicated
>  by kernel code comments [1], vsyscalls are a legacy ABI and its concept
>  is problematic:
> 
>  - It interferes with ASLR.
>  - It's awkward to write code that lives in kernel addresses but is
>    callable by userspace at fixed addresses.
>  - The whole concept is impossible for 32-bit compat userspace.
>  - UML cannot easily virtualize a vsyscall.
> 
>  ......"

Also modern kernels dont even implement the vsyscall page anymore.
At most it is implemented as a stub which will trigger the real syscall
which then gets handled properly.

> The original issue could now be considered resolved. So in v3, we no
> longer turn __vdso_getcpu into a syscall wrapper; we simply removed it.
> Perhaps we could remove the whole VDSO before we implement the "real"
> VDSO. However, its implementation is clean, so keeping it wouldn't hurt
> and it could serve as a useful starting point for the "real" VDSO.

A "real" vDSO would require quite some more infrastructure. And it is
not even clear if such a vDSO will make a difference on UML. In my
opinion if __vdso_getcpu() gets removed, the whole vDSO should go with
it. The code can still be easily restored from git.

Also the functionality to map the host vDSO and vsyscall page into UML
userspace looks very weird and error-prone. Maybe it can also go away.


Thomas

