Return-Path: <linux-kernel+bounces-746554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 311D2B12830
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 02:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 990297B66E8
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 00:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39ACD13790B;
	Sat, 26 Jul 2025 00:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qIAwoYcf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909691D555;
	Sat, 26 Jul 2025 00:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753490410; cv=none; b=JZkarSpvpZqa/qNNYHQgQcSqQNssKdrcpGEDAjIvQHwsnIkzFxT62yigVuGZ5yGAJly1k9kLuEndv6N9FMoRqlC/JRv0eNG85gicEhjxA/bXm/8xTbpxASIHLVEPI/oa+0wQaCGrjkGIn7DPDjkWBZ+eZdoZpWX4mqTwFWFhKJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753490410; c=relaxed/simple;
	bh=0ljOxLf3asG8EXlvRRWHYhLY5dkENjRCIl0TEBmEpuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DdYddDyV2q/UMuHS3AgPpHSNE9dunDSY1dnukxIQVMRcM8dAlygthSW/OXRESLuC+inuddY43Z32SWL9D3kjWH//9rV1V3MYfIBrqr7ILgG8YNSyaAL5ycWAVKmDbRfMeDOglyNiBLUKmhOkwDxgzSb7Nqko5n/BhWHtdhYPB4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qIAwoYcf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D8FDC4CEE7;
	Sat, 26 Jul 2025 00:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753490410;
	bh=0ljOxLf3asG8EXlvRRWHYhLY5dkENjRCIl0TEBmEpuQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qIAwoYcfsZX1JS5swQvuHh4YAx0Dnjek7XHbdZP95vmn5NhVaWu8fz5mXlu5BBIAC
	 x6YOX8sgCFIcwnCJiFrMCZLDejXSr5vsm7Qe4GKcJlMH7O0ky8j3xOIizTdbLij8FA
	 fqeMmkJgU9YDKqv2atpEgKynTwztATUXn+GiIk8Q2Ah/WppIH2agLqoMsvbdPbZwxG
	 CsG0gH/hqJVWGMxmA+DwhKy/2mMFW4VSAwH8mxoJSjrMcDtc6gx50fEcIJbdxST+Hr
	 /xYR7l1GHiIwy1yT/iT1EOHzrYB3/50GYc3b0mqdEu5mIY/9GWugfC635HDgQOBeXc
	 arPS14ZlZY6Cw==
Date: Fri, 25 Jul 2025 17:40:09 -0700
From: Kees Cook <kees@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	Arnd Bergmann <arnd@arndb.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Ben Copeland <benjamin.copeland@linaro.org>
Subject: Re: next-20250723 arm atags_to_fdt.c undefined reference to
 `__sanitizer_cov_stack_depth'
Message-ID: <202507251739.E62B1C95@keescook>
References: <CA+G9fYtBk8qnpWvoaFwymCx5s5i-5KXtPGpmf=_+UKJddCOnLA@mail.gmail.com>
 <aINJTDD3je4XJ6VO@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aINJTDD3je4XJ6VO@shell.armlinux.org.uk>

On Fri, Jul 25, 2025 at 10:07:24AM +0100, Russell King (Oracle) wrote:
> On Fri, Jul 25, 2025 at 01:59:02PM +0530, Naresh Kamboju wrote:
> > Regressions noticed while building arm builds with gcc-13 and gcc-8
> > toolchains on the Linux next-20250723 to next-20250725 tags.
> > 
> > First seen on the Linux next-20250723
> > Good: next-20250722
> > Bad:  next-20250723 and next-20250725
> > 
> > Regression Analysis:
> > - New regression? Yes
> > - Reproducibility? Yes
> > 
> > ## Build regressions
> > * arm, build
> >   - gcc-13-lkftconfig-hardening
> >   - gcc-8-lkftconfig-hardening
> > 
> > Build regression: next-20250723 arm atags_to_fdt.c undefined reference
> > to `__sanitizer_cov_stack_depth'
> 
> "cov" suggests "coverty", and that the symbol is not available in the
> kernel suggests that coverty isn't supported.

This is the coverage sanitizer and related to my changes. Sorry! This
didn't show up in my build testing, I'll reproduce it and get it fixed.

-- 
Kees Cook

