Return-Path: <linux-kernel+bounces-776692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A030EB2D08B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 02:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E577F1BC6F06
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 00:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6116042A83;
	Wed, 20 Aug 2025 00:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rfu5sxaP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AB44C9F
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 00:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755648094; cv=none; b=M+KhFbhCbJZGn2419hPBmKQYsHrb0Gm9P7wGU2MeBV+63K9HBfKvIfmNCcpdZ146e2ttlS3GMdxKqkxAn4SvRnhwXsjwhjDvUNvKxlPyiMWNqAj6eQy83CcrQ7wgGf7Y7joGcxP0ycFxhTuRrOJCdOtfX5yn1aiahkhiJBHhpVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755648094; c=relaxed/simple;
	bh=BF2nongohxL86yTybLMjEVN3XQRN/BOzcVk35AHcCzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pZDD0X4HZTEelPwhnsxgWjWIeEC+jmzZKQ7L7XTSoLOKVqT3MdfMDasTSQpregPGwmUmJfhJUOfGZv77CD4B3t4u44gr2BukdrsFtbTofg4N9Ly+B/ynDjoHKyRo6v3vMBi9KfLg5YdQ+/9jS6YASweTEosj2XS8u4EqebE0rBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rfu5sxaP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17486C4CEF1;
	Wed, 20 Aug 2025 00:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755648094;
	bh=BF2nongohxL86yTybLMjEVN3XQRN/BOzcVk35AHcCzE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rfu5sxaPNLk41Bejx8ROFIRMBhuR9rSeRYbQ0taHMw97hCpiCTUd2ayfoqhct1qpm
	 b6ZrfvWbYX5wFgOfJwyBNflzknImgLXRNovwThoTgNfTLtvYnBC4ROi/83Ps6eqVgG
	 ehiaHsbmxGNHAFY06tsO4DlEQCcpHb0FU8THJD3O5t0OloZrioGupdeZLbXg7FXzdW
	 hGsdCC7GUQzQunhWBLSOeeYELF1xuul2CBEGy95Egppr1hhNbm4a//LuXYQoU79icc
	 LUR/FwGaWM1UGJGWvz23W3ccLG89fi/yqIfxUBQoyFC/RqA8DnQmJK/pGG+eUqfN9+
	 8Er9YtcEQPiBA==
Date: Tue, 19 Aug 2025 17:01:32 -0700
From: Drew Fustini <fustini@kernel.org>
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Samuel Holland <samuel.holland@sifive.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Andy Chiu <andybnac@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Darius Rad <darius@bluespec.com>,
	Vivian Wang <wangruikang@iscas.ac.cn>,
	Florian Weimer <fweimer@redhat.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Drew Fustini <dfustini@tenstorrent.com>
Subject: Re: [PATCH v3] riscv: Add sysctl to control discard of vstate on
 syscall entry
Message-ID: <aKUQXDh4u9xJx+jS@x1>
References: <20250819-riscv_v_vstate_discard-v3-1-0af577dafdc2@kernel.org>
 <20250819-bb1be8c05ebdf7ea751323aa@orel>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819-bb1be8c05ebdf7ea751323aa@orel>

On Tue, Aug 19, 2025 at 12:16:02PM -0500, Andrew Jones wrote:
> On Tue, Aug 19, 2025 at 02:40:21AM -0700, Drew Fustini wrote:
> > From: Drew Fustini <dfustini@tenstorrent.com>
> > 
> > Vector registers are always clobbered in the syscall entry path to
> > enforce the documented ABI that vector state is not preserved across
> > syscalls. However, this operation can be slow on some RISC-V cores.
> > To mitigate this performance impact, add a sysctl knob to control
> > whether vector state is discarded in the syscall entry path:
> > 
> > /proc/sys/abi/riscv_v_vstate_discard
> > 
> > Valid values are:
> > 
> > 0: Vector state is not intentionally clobbered when entering a syscall
> > 1: Vector state is always clobbered when entering a syscall
> > 
> > The initial state is controlled by CONFIG_RISCV_ISA_V_VSTATE_DISCARD.
> 
> I'm in favor of the clobbering being off by default and creating a knob
> to enable it for debug purposes, but I'm not sure we need the config. I
> think it's reasonable for systems that need the discard behavior to add
> a sysctl toggle to their early init. The config may complicate the
> documentation needed for user recommendations and potentially generate
> confusion when moving from one system to another since defaults could
> be flipped.

If I dropped CONFIG_RISCV_ISA_V_VSTATE_DISCARD, then are you thinking
that riscv_v_vstate_discard_ctl would be initialized to 0 instead?

I would be okay with that as it defaults to the clobbering being off.
Hopefully, Palmer will chime in on whether setting the sysctl in an
init script would be acceptable. He told me that he does want to retain
the strict clobbering behavior on his tester machine.

Thanks,
Drew

