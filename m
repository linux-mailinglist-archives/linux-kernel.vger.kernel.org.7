Return-Path: <linux-kernel+bounces-758429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C61FB1CF05
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 00:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EE4A566A63
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 22:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B21C22DF99;
	Wed,  6 Aug 2025 22:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KHLLHCvB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A515927470;
	Wed,  6 Aug 2025 22:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754518780; cv=none; b=ANphS2D9sLgyrD7W+y/DHDwEAPoGtnyyiOPpAxm4l5txTXhG0kXuYLi+MT+UuKeF2Km4J5ugNcp2CW3FjwRQLA4dweEXse7yPkPV88rO5qey02k1J1vdIwXg8Y/kZVUEvRGVXuejvB8MLy2RgVVnLPSZg2mCj5mPsojKdpoFR9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754518780; c=relaxed/simple;
	bh=yEqWEe7fKZL9wI174QfVtk/Gwqa6G81uHG2fSIPPD/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p11uMfj8e0lL2ZJV6ywKfZklRAW9YMG8TsWwA/GKfeSMEcnUFpXiieIYpBxkcQqWalVimmzwJUBidDAn/fXjYT8LwC5ZTTWEgFLyp9SKKd5j/XvmiHTHI/MtbHX5zY/vC9Y70Y942nUiYd9UsYfg6eGrbO57j3xUFU3acqXvFHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KHLLHCvB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A78FBC4CEE7;
	Wed,  6 Aug 2025 22:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754518780;
	bh=yEqWEe7fKZL9wI174QfVtk/Gwqa6G81uHG2fSIPPD/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KHLLHCvBe3OZo40BHCtVxsxT6dMCdX9rQWVIa/9UupLGzqjW4cLDrJYw5khQHSSGH
	 Wpwfi2JGvb95/9dooHH4zcCWdySLAMEM4LNAz5UOY7ozKmkq7dsm5XNHbtBtG8bYYn
	 frMm5q39mo6fjQ+iahDkrH9N8L4QCJpJEUGvus39+5AHA0P79KVK+BWOPxv2U8XoeY
	 2W8fS34SmgC5bWT4WKfaUa96L90bt7V4jpnSC15J1A32eXIA5ch8nYzwLkXcw2+55M
	 EoJz9oKFDa3WjepsWjrZuBhdMbMcgc5Y3R4LL6TGALIcRbQcXKnZmY7zI1ZUOWAmJa
	 rXqXwlQN7Ca0w==
Date: Wed, 6 Aug 2025 15:19:35 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Samuel Holland <samuel.holland@sifive.com>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Jesse Taube <mr.bossman075@gmail.com>
Subject: Re: ld.lld: error: Function Import: link error: linking module flags
 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at
 861458), and 'i32 1' from vmlinux.a(net-traces.o at 1004198)
Message-ID: <20250806221935.GA1397381@ax162>
References: <202508061842.68gt097v-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202508061842.68gt097v-lkp@intel.com>

On Wed, Aug 06, 2025 at 07:06:34PM +0800, kernel test robot wrote:
...
> config: riscv-randconfig-002-20250806 (https://download.01.org/0day-ci/archive/20250806/202508061842.68gt097v-lkp@intel.com/config)
...
>    ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 861458), and 'i32 1' from vmlinux.a(trace.o at 871118)
>    ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 861458), and 'i32 1' from vmlinux.a(memcontrol.o at 876278)
>    ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 861458), and 'i32 1' from vmlinux.a(mballoc.o at 886958)
> >> ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 861458), and 'i32 1' from vmlinux.a(net-traces.o at 1004198)

As this configuration has CONFIG_CMODEL_MEDLOW, I expect
https://lore.kernel.org/20250710-riscv-restrict-lto-to-medany-v1-1-b1dac9871ecf@kernel.org/
to avoid this.

Cheers,
Nathan

