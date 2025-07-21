Return-Path: <linux-kernel+bounces-739124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFF7B0C21D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 13:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68F90188F394
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 11:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302972900A3;
	Mon, 21 Jul 2025 11:03:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1CE21CC48
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 11:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753095818; cv=none; b=EkHZNezOQePAOKsWMSR7ry4P7O2ot3UukzW55F2RLIV811sCREPfNZ4+euahjKX4S/iEipr8yyeXZDzP6p22YbFJLb1eqdYkxbu9+2WsJ0NfY+xhSH1lEUuf9ykfR9Brmgf6IgHSm8uZc6LyY3kutLTOWpFEOlOZm3SvgDfTrZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753095818; c=relaxed/simple;
	bh=yl7j0wqQTWCP2DrkVhq+eHLllJaa/qZzbCSwjN/htGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I7hvaB21rYUkth7oz7lMzo/itYPx6cdiH8q4TbZUt3PgTExNztIAonnmq2iMihu0BtuEG9anOPY1xNyXOiudBhC69WFwwfvD8powZGV8xocrtdFU94EWdjcqjYmTxZDEESRBgbfiquYbvwkSiHPcK3KDOB5d9H4aA/1fwM82Xjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38986153B;
	Mon, 21 Jul 2025 04:03:29 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 34E1F3F6A8;
	Mon, 21 Jul 2025 04:03:33 -0700 (PDT)
Date: Mon, 21 Jul 2025 12:03:30 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, broonie@kernel.org,
	oliver.upton@linux.dev, ardb@kernel.org, frederic@kernel.org,
	james.morse@arm.com, joey.gouly@arm.com,
	scott@os.amperecomputing.com, maz@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/7] arm64/futex: add futex atomic operation with
 FEAT_LSUI
Message-ID: <aH4egvxnbQPu1XzE@J2N7QTR9R3>
References: <20250721083618.2743569-1-yeoreum.yun@arm.com>
 <20250721083618.2743569-6-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721083618.2743569-6-yeoreum.yun@arm.com>

On Mon, Jul 21, 2025 at 09:36:16AM +0100, Yeoreum Yun wrote:
> Current futex atomic operations are implemented with ll/sc instructions and
> clearing PSTATE.PAN.
> 
> Since Armv9.6, FEAT_LSUI supplies not only load/store instructions but
> also atomic operation for user memory access in kernel it doesn't need
> to clear PSTATE.PAN bit anymore.
> 
> With theses instructions some of futex atomic operations don't need to
> be implmented with ldxr/stlxr pair instead can be implmented with
> one atomic operation supplied by FEAT_LSUI.
> 
> However, some of futex atomic operations still need to use ll/sc way
> via ldtxr/stltxr supplied by FEAT_LSUI since there is no correspondant
> atomic instruction or doesn't support word size operation
> (i.e) eor, cas{mb}t But It's good to work without clearing PSTATE.PAN bit.

That's unfortunate; have we fed back to Arm's architecture folks that we
care about those cases?

> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> ---
>  arch/arm64/include/asm/futex_lsui.h | 132 ++++++++++++++++++++++++++++
>  1 file changed, 132 insertions(+)
>  create mode 100644 arch/arm64/include/asm/futex_lsui.h

This logic is introduced unused, and TBH I don't think this needs to be
in a separate header.

I reckon it's be better to keep all of this in <asm/futex.h> and rework
the series to:

(1) Factor out the existing LL/SC logic into separate LL/SC helpers in
    <asm/futex.h>, with an __llsc_ prefix, called by the existing
    functions.

(2) Add the new __lsui_ futex operations to <asm/futex.h>, along with
    code to select between the __llsc_ and __lsui_ versions.

We split the regular atomics different becuase there are *many* generic
atomic operations, but I don't think it's worthwhile to split the futex
logic over several headers.

Maybe it's worth having <asm/lsui.h>, but for now I reckon it's best to
also fold that into <asm/futex.h>, and we can split it out later if we
need it for something else.

Mark.

