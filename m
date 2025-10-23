Return-Path: <linux-kernel+bounces-866735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 819BBC0086D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 949241A04E0F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A4F30AD1E;
	Thu, 23 Oct 2025 10:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uRI5o5CE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAF82DE6ED;
	Thu, 23 Oct 2025 10:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761215667; cv=none; b=bMFLbm9+4AiH7yOG0LrRt9HbZRCIp8ytZa9vMXvKQnVSPynhse+S2e4J0pVpiQluQrq/CBaWfT2CF6ScRbg9YN7lJveo3hlG9YR/OwkkeJ1VihGGx5Qby2q8TFjQgq2P7qvGYZgijBXB6Bzl2C9yKN5zWQDik8yrxBmAzk8bifk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761215667; c=relaxed/simple;
	bh=EvgrZI+rymOOfZUCPqItc1VU/vONGS0OSWFKI/tUzDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=owAedEmziGoZfPx0MBhy6pW9FOFa5pAnc3ltALGs85Qr/sp2WzRwY2AvyhFYPCjBaQU2qvEEteYYvKD/eF1xRwzAKRwoWB3EYivD7C3qXUwSRU5YdveOCAxU5uV8hKrUTBuADpXCLWw3r9ygBG5bA+OzQrmrTT61V7ENbaUvFOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uRI5o5CE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D2D2C4CEE7;
	Thu, 23 Oct 2025 10:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761215667;
	bh=EvgrZI+rymOOfZUCPqItc1VU/vONGS0OSWFKI/tUzDs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uRI5o5CEuyLF8Dsw/NHSiQH641JTHFRjyjRHMeLd6Ltw3N/WUcoXgM9nnD5zSct3L
	 +m1/CsyFgl0kAZeWmYT4WZVkOCsUe4OHX8G+c+f0GK+vmdra6BvwuoRmsTqaO4zK/7
	 l5jZ/+Lj1gu4cxqy6wfpwkhByYY2ax6WflUUzg4ihhcJgiHmJ8rtTVCR8247axtNrI
	 MC/AQ9p31JRcxevANJ5y0lskvzJW3DtGUdHntQ+tUhok2yvKWaHsv4RwfUnpUAbpFD
	 4G76lppLtXr4SBngcinr0W1lMWdAfBk0WndUTVk26yzEAFMuAUeShMgJKsoOsA+w4S
	 dW3FN/qYIMDtA==
Date: Thu, 23 Oct 2025 12:34:23 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Yixun Lan <dlan@gentoo.org>, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, spacemit@lists.linux.dev
Subject: Re: [PATCH v4] i2c: spacemit: configure ILCR for accurate SCL
 frequency
Message-ID: <lr77avehdf3skwd5o2yur4hvbxhyx2spzve3wpo733l74ppjcx@mn34escjt542>
References: <20251017-k1-i2c-ilcr-v4-1-eed4903ecdb9@linux.spacemit.com>
 <t26pyjnmzj62oczwuje2bbscowj22pdge2ef3tcktwmhzpsq47@7odo2ccvc52a>
 <sdhkjmi5l2m4ua4zqkwkecbihul5bc2dbmitudwfd57y66mdht@6ipjfyz7dtmx>
 <748544ABF6A72D31+aPg31PBvHDkBALoa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <748544ABF6A72D31+aPg31PBvHDkBALoa@kernel.org>

Hi Troy,

On Wed, Oct 22, 2025 at 09:48:04AM +0800, Troy Mitchell wrote:
> On Tue, Oct 21, 2025 at 06:03:34PM +0200, Andi Shyti wrote:
> > On Mon, Oct 20, 2025 at 11:28:45AM +0200, Andi Shyti wrote:
> > > On Fri, Oct 17, 2025 at 03:27:39PM +0800, Troy Mitchell wrote:
> > > > The SpacemiT I2C controller's SCL (Serial Clock Line) frequency for
> > > > master mode operations is determined by the ILCR (I2C Load Count Register).
> > > > Previously, the driver relied on the hardware's reset default
> > > > values for this register.
> > > > 
> > > > The hardware's default ILCR values (SLV=0x156, FLV=0x5d) yield SCL
> > > > frequencies lower than intended. For example, with the default
> > > > 31.5 MHz input clock, these default settings result in an SCL
> > > > frequency of approximately 93 kHz (standard mode) when targeting 100 kHz,
> > > > and approximately 338 kHz (fast mode) when targeting 400 kHz.
> > > > These frequencies are below the 100 kHz/400 kHz nominal speeds.
> > > > 
> > > > This patch integrates the SCL frequency management into
> > > > the Common Clock Framework (CCF). Specifically, the ILCR register,
> > > > which acts as a frequency divider for the SCL clock, is now registered
> > > > as a managed clock (scl_clk) within the CCF.
> > > > 
> > > > This patch also cleans up unnecessary whitespace
> > > > in the included header files.
> > > > 
> > > > Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> > > 
> > > merged to i2c/i2c-host.
> > 
> > I'm sorry, because of the report from LKP(*) I reverted your
> > patch. I2C_K1 is selected by MFD_SPACEMIT_P1, so that we get the
> > following warning:
> > 
> >   WARNING: unmet direct dependencies detected for I2C_K1
> > 
> > and compile I2C_K1 without COMMON_CLK. Please, fix it and
> > resubmit the patch.
> Yes, I noticed that too. The issue is introduced by PMIC driver(P1)
> instead of I2C.
> Should I resubmit this patch right after sending the fix,
> or wait until the fix gets merged first?

I have reverted the patch. Please send them both in the same
series, where the first patch is the "fix" (or preparation to
this patch) and then this patch.

Thanks,
Andi

