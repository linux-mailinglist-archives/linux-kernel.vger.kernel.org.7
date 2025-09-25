Return-Path: <linux-kernel+bounces-832213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 703D8B9EA7F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D9103AB322
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A09C2ED84A;
	Thu, 25 Sep 2025 10:28:45 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7B12EC0A1;
	Thu, 25 Sep 2025 10:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758796125; cv=none; b=jJUNBHy+UB0CybuK7pcirZg6BMxBhUt8tghqLAlpgVhe+/JhDhMFZ9bZWuRUWpTPd5oFiYpcIg10j3HHyjtF8i9EqI/N+3rny6d951E58BpmwDw8RK0+fbsO+JFx/aZlhpxm2VOPdaxoG7a759XakZaTJHPHv5lMH8k9MufJcD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758796125; c=relaxed/simple;
	bh=GTEdlIQJ4X0zEOKmiDRTbe+z2Vlkhkonjn7D1kh3VeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ANgjHKkz4DWRBtuH4XayokgPqICs6J113qzDRAWmmwRvEPpMlms0T4A3UDAUrYKoTFAThkag42AUSHBe4glRkMtS4YU5TDPY59ELo6S05xt7jxIdjzphRH+44ZUPmNfa6r7GLLMvm0p3gQF3PLDmgPwTkot1s6wQocU13uoKZQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB2B8C4CEF0;
	Thu, 25 Sep 2025 10:28:43 +0000 (UTC)
Date: Thu, 25 Sep 2025 11:28:41 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: kernel test robot <lkp@intel.com>
Cc: Robin Murphy <robin.murphy@arm.com>, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: arch/arm64/kernel/signal.c:1300: undefined reference to
 `preserve_gcs_context'
Message-ID: <aNUZWQdNsyDPGEWc@arm.com>
References: <202509241856.XvV8zSHD-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202509241856.XvV8zSHD-lkp@intel.com>

On Wed, Sep 24, 2025 at 06:30:53PM +0800, kernel test robot wrote:
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   cec1e6e5d1ab33403b809f79cd20d6aff124ccfe
> commit: f00b53f1614f7be554fd28b9594ef4e63e2686c5 arm64: cpufeature: Add GCS to cpucap_is_possible()
> date:   10 months ago
> config: arm64-randconfig-r132-20250924 (https://download.01.org/0day-ci/archive/20250924/202509241856.XvV8zSHD-lkp@intel.com/config)
> compiler: aarch64-linux-gcc (GCC) 10.5.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250924/202509241856.XvV8zSHD-lkp@intel.com/reproduce)

Robin's commit was supposed to fix this.

> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202509241856.XvV8zSHD-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    aarch64-linux-ld: Unexpected GOT/PLT entries detected!
>    aarch64-linux-ld: Unexpected run-time procedure linkages detected!
>    aarch64-linux-ld: arch/arm64/kernel/signal.o: in function `setup_sigframe':
> >> arch/arm64/kernel/signal.c:1300: undefined reference to `preserve_gcs_context'
>    aarch64-linux-ld: arch/arm64/kernel/signal.o: in function `restore_sigframe':
> >> arch/arm64/kernel/signal.c:1042: undefined reference to `restore_gcs_context'
> 
> 
> vim +1300 arch/arm64/kernel/signal.c
> 
> bb4891a6c3551f Dave Martin      2017-06-15  1258  
> 20987de3c2c45c Dave Martin      2017-06-15  1259  static int setup_sigframe(struct rt_sigframe_user_layout *user,
> 2e8a1acea8597f Kevin Brodsky    2024-10-29  1260  			  struct pt_regs *regs, sigset_t *set,
> 2e8a1acea8597f Kevin Brodsky    2024-10-29  1261  			  const struct user_access_state *ua_state)
> 2c020ed8d148f7 Catalin Marinas  2012-03-05  1262  {
[...]
> 16f47bb9ac8afe Mark Brown       2024-10-01  1297  	if (system_supports_gcs() && err == 0 && user->gcs_offset) {
> 16f47bb9ac8afe Mark Brown       2024-10-01  1298  		struct gcs_context __user *gcs_ctx =
> 16f47bb9ac8afe Mark Brown       2024-10-01  1299  			apply_user_offset(user, user->gcs_offset);
> 16f47bb9ac8afe Mark Brown       2024-10-01 @1300  		err |= preserve_gcs_context(gcs_ctx);
> 16f47bb9ac8afe Mark Brown       2024-10-01  1301  	}

It looks like the compiler was not able to remove these calls. Is this
compiler-specific?

-- 
Catalin

