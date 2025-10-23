Return-Path: <linux-kernel+bounces-867432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDEDC02A2E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 19:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5E421889828
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 17:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277FE340279;
	Thu, 23 Oct 2025 16:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aPZIU8bO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BD533F8DF
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 16:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761238331; cv=none; b=BlZo/ENw84q2S/TF1ZJOlBY7NEMhx6Q2WJeRAIBTnTtGJmETgUaA+x18lXev/m3eBxLUorqLAEtv7tW4HHsgeT1uXogFEYrRaT8NHaK7nORsatmdp/6p2AVSqhITHaJH5BDl/UKjAV6ScDCVTLZ4agS8FtIROwjop7nfSdXLYDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761238331; c=relaxed/simple;
	bh=+xRBkG3Yznei7bfa+btKlosF8EF6f3qzPwRiGCSSb3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fDu+KU9LCQltwIdV4E6EIHxjyXkDX4OchQoSazF9wOTXJY6CKbNgWM/b05Mn+AOR4iuz2U2K9JITkTjFce3BE2F5FDfOlKGd+2/IY/0zIBQNQDAmwKF4LqDiU/9Njh/NdH0Deh9eRmX3FuXapl/qngBfDVHZ3ldDMFSjIJgLID4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aPZIU8bO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2891BC4CEFF;
	Thu, 23 Oct 2025 16:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761238330;
	bh=+xRBkG3Yznei7bfa+btKlosF8EF6f3qzPwRiGCSSb3Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aPZIU8bOdrBTvimBJyVcMU+/In0iMQ5P6Wj1bUu6miPgDBd9Wxsh6puE7gYTDffOw
	 nxEnXqPhPjTuqFKE1gy+JqJ39OaiR6S29lmQg6ObvZjqylBQqwflQr1W7aVsBPpKbC
	 zmOI3B7yYIULLT+yKh5u3c4KHY39ii3TK0XBkKniaqNocgyofHO6F7l4BNp0341j3Y
	 Bv6LxLxdS/hwvz0cTRy5kgLblQVjuC+VdOhoCKNSfOkkzFkdumst3nIbPTjtNACNjV
	 N2MmGRVQEZwecoUIsmnYHVf4NHHjHg4U4ySR3cNE72dhB6tPuie/V5Og4uNTxEpD8T
	 5bTLIfjc9ZSvA==
Date: Thu, 23 Oct 2025 18:52:05 +0200
From: Nathan Chancellor <nathan@kernel.org>
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	Anshuman Gupta <anshuman.gupta@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	intel-xe@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mei: late_bind: Fix
 -Wincompatible-function-pointer-types-strict
Message-ID: <20251023165205.GD2090923@ax162>
References: <20250920-drm-xe-fix-wifpts-v1-1-c89b5357c7ba@kernel.org>
 <qxvmx7nawbqjj5luzzken3psdei7pvgliieiv4vdxgumb2wpkx@p4ckdsds66ak>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qxvmx7nawbqjj5luzzken3psdei7pvgliieiv4vdxgumb2wpkx@p4ckdsds66ak>

On Thu, Oct 23, 2025 at 09:27:03AM -0500, Lucas De Marchi wrote:
> On Sat, Sep 20, 2025 at 04:17:50PM -0700, Nathan Chancellor wrote:
> > When building with -Wincompatible-function-pointer-types-strict, a
> > warning designed to catch kernel control flow integrity (kCFI) issues at
> > build time, there is an instance in the new mei late binding code
> > originating from the type parameter of mei_lb_push_payload():
> > 
> >  drivers/misc/mei/mei_lb.c:211:18: error: incompatible function pointer types initializing 'int (*)(struct device *, u32, u32, const void *, size_t)' (aka 'int (*)(struct device *, unsigned int, unsigned int, const void *, unsigned long)') with an expression of type 'int (struct device *, enum intel_lb_type, u32, const void *, size_t)' (aka 'int (struct device *, enum intel_lb_type, unsigned int, const void *, unsigned long)') [-Werror,-Wincompatible-function-pointer-types-strict]
> >    211 |         .push_payload = mei_lb_push_payload,
> >        |                         ^~~~~~~~~~~~~~~~~~~
> > 
> > While 'unsigned int' and 'enum intel_lb_type' are ABI compatible, hence
> > no regular warning from -Wincompatible-function-pointer-types, the
> > mismatch will trigger a kCFI violation when mei_lb_push_payload() is
> > called indirectly.
> > 
> > Update the type parameter of mei_lb_push_payload() to be 'u32' to match
> > the prototype in 'struct intel_lb_component_ops', clearing up the
> > warning and kCFI violation.
> > 
> > Fixes: 741eeabb7c78 ("mei: late_bind: add late binding component driver")
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> 
> Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>
> 
> Sasha, is this fix something you are taking through char-misc since the
> commits that added it already propagated through the 6.18-rc?

It looks like Greg already took this via char-misc-linus:

https://git.kernel.org/gregkh/char-misc/c/98718e80af0bb1cd80f4bfe565dd60c57debad51

Cheers,
Nathan

