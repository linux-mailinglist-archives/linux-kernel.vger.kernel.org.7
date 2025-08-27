Return-Path: <linux-kernel+bounces-788992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E44BB38F61
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 01:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B56A67C1013
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 23:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF41F30F94E;
	Wed, 27 Aug 2025 23:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pGFpoCR2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448F9287272;
	Wed, 27 Aug 2025 23:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756338620; cv=none; b=LzS1pZWp0Z8IElSQe9rAmTcx7HqzWNAk4FasFjmfKcfzf1VP4tzQ1k32lIiF9ScuqrMjTDf4PCHg5FPRVuvHgfakB25n5qYDHUGkVjrvn1nPT+vlqGQ+W//bGpTx6g5ZL/otSNS92rCzrL9wmZlLctrRTI1LrC8+QIlOdCmf6xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756338620; c=relaxed/simple;
	bh=Sjy4XKwPxjMH22cgtLTe94cAf6zqfoRAYkJo6V+R/v0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XCwKG5+QSshX1/YT7NuWo6Xn8GZcPH27wKqCjQJscsHtTgHUYl4X58Ms+DLyUEUjXsljymQpyt4+EAeoR+um5tnsK+POtcshyw3y5tl5NvOxV7hur2cVgQyREibr55CkmDCB+XMxRn5S53y6wG2FnR8qnXCnNJGIpxXM4ziaxA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pGFpoCR2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8285C4CEF5;
	Wed, 27 Aug 2025 23:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756338619;
	bh=Sjy4XKwPxjMH22cgtLTe94cAf6zqfoRAYkJo6V+R/v0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pGFpoCR2FfNWOEu7J+r96XKcBGhRGar1p+VF5wTN3S1ZPm0UJlygCJTLus76aX5JC
	 zrx/hHfddtxbGdH7c+R+PGl7UMTdvSpPHKgpBAwTezJZRc3XLMU830fd/8ZGFT/RG1
	 HjeDid3FpMjKSPqVFYlJpmGvrMJCtE5t4GH2zELfgYBlDTanMt6OWTQ+b/meoRLvTY
	 k8FCMoi23sCrCcgsmfxi7cnHfYQrDN6ntH5rrbB4W5hfK7kaHigsXsBH+NrLcxTS4q
	 O1vcYHJWNmYsvcqQGgBEWZIKIFZwlRVjhLDL3ztXerIxAGAkMqao6o6hHFR6ntYYM5
	 HIyQUsatn4Ipw==
Date: Wed, 27 Aug 2025 16:50:17 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the vhost tree
Message-ID: <aK-Zubfr92yrl3tE@google.com>
References: <20250827124654.78881028@canb.auug.org.au>
 <20250827062218-mutt-send-email-mst@kernel.org>
 <aK8_uOoLxLOniEbR@google.com>
 <20250827152222-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250827152222-mutt-send-email-mst@kernel.org>

On Wed, Aug 27, 2025 at 06:04:20PM -0400, Michael S. Tsirkin wrote:
> On Wed, Aug 27, 2025 at 10:26:16AM -0700, Namhyung Kim wrote:
> > Hello,
> > 
> > On Wed, Aug 27, 2025 at 06:23:52AM -0400, Michael S. Tsirkin wrote:
> > > On Wed, Aug 27, 2025 at 12:46:54PM +1000, Stephen Rothwell wrote:
> > > > Hi all,
> > > > 
> > > > The following commit is also in the perf-current tree as a different
> > > > commit (but the same patch):
> > > > 
> > > >   c67e16d30dca ("tools headers: Sync uapi/linux/vhost.h with the kernel source"
> > > > )
> > > > 
> > > > This is commit
> > > > 
> > > >   f79a62f4b3c7 ("tools headers: Sync uapi/linux/vhost.h with the kernel source")
> > > > 
> > > > in the perf-current tree.
> > > 
> > > 
> > > Hmm.  I could drop mine I guess, but it only really makes sense after:
> > > 
> > >     vhost: Fix ioctl # for VHOST_[GS]ET_FORK_FROM_OWNER
> > >     
> > > 
> > > which is not in the perf tree.
> > 
> > Yep, so I was waiting for you to send PR with the fix.
> > It seems you already removed the commit in your tree.
> > I'll send a PR for perf tools with this change.
> > 
> > Thanks,
> > Namhyung
> 
> It's in my tree but I did not want to send it before we agreed what to
> do. I can drop it, sure.

Just sent out the PR, thanks for your co-operation!

Namhyung


