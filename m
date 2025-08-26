Return-Path: <linux-kernel+bounces-785737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB05B35043
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 02:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAEB72420A5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 00:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4B023A9B3;
	Tue, 26 Aug 2025 00:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kA2Zg+k0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6CB393DC5;
	Tue, 26 Aug 2025 00:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756168313; cv=none; b=HXWgBE56md5xLcqqCNE7xNlvgEKmwv+yGyRnZSn6qgMCHqeGjtpN93+fmjpBk/eIBKtpkdj5W+ENyEDuQa4y5Zc79XHsQRaUtsT/Ro49RpO1mciBThFas918UF2U7qpozCHoTRoDO744QBhaRiZwUXs2cwQy5mo7cuIsRyFcmcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756168313; c=relaxed/simple;
	bh=CPnEBZBjXV/lzxeV1sHV1BY++uFlByZX7Cld6l17i/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jJ8FViHaIpx8eKmX2WfX0NSjiIDg+ESEEwbvBKt8C2r1OrWiohVoDT66cvh3Tjl7I38+I4HGtb0T3qK6lcn5HCA70dzz1mhi8a/p/zNmUVOJfr7he3JhJ78JcKkkTHhOMJTCDoMNLbRaQ61oFo9Xll1BOJ7SJutXUaTsai8OKWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kA2Zg+k0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EE7AC4CEED;
	Tue, 26 Aug 2025 00:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756168312;
	bh=CPnEBZBjXV/lzxeV1sHV1BY++uFlByZX7Cld6l17i/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kA2Zg+k0pFEQcnjhuXBjqyRvKdActGu0y02/REUiju6RRF33HK1L49cHZ2OcXyvfs
	 xPNOq4d0Yil6Opx4YruYw6aot2yRWsuEkJIqCpxg7M8fa+RoHaAA7OhzNdJJbCvira
	 mQhZV/++2JQ9eNWw21C80dhDSDzP7GJP+oifHkrDmvnM9vfRiZ524th8fPCaUXM7p3
	 rKGTRw13OGvqaKfety2/ASYQFTUHLMOqvYPI+VpDjxEaacChxEzNMY+pscjKooUZ1+
	 QaMI/tGVtIBfkbpP1ch1LSrG6WORLmDKuPwlGhkrBbiJA3vSAY7ZhesV8VoOfKUkXN
	 n7ZBU3+quSuIg==
Date: Mon, 25 Aug 2025 17:31:51 -0700
From: Kees Cook <kees@kernel.org>
To: kernel test robot <lkp@intel.com>,
	Nathan Chancellor <nathan@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: include/linux/ucopysize.h:45:4: error: call to '__bad_copy_from'
 declared with 'error' attribute: copy source size is too small
Message-ID: <202508251728.D5CA199F35@keescook>
References: <202508060351.OMeX2wGa-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202508060351.OMeX2wGa-lkp@intel.com>

On Wed, Aug 06, 2025 at 03:49:28AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   6bcdbd62bd56e6d7383f9e06d9d148935b3c9b73
> commit: 808aac63e2bdf9bae08485e072bf3d317a18acbf uaccess: Introduce ucopysize.h
> date:   5 months ago
> config: um-randconfig-001-20250806 (https://download.01.org/0day-ci/archive/20250806/202508060351.OMeX2wGa-lkp@intel.com/config)

The option inducing the miscompile (the "len" argument gets turned into
a compiler-constant value +1 from where it actually should be across the
inlinings of copy_to_user) is, *drum roll*  -fsanitize=alignment

So, I think we need to ban CONFIG_UBSAN_ALIGNMENT on at least on x86...

-Kees

> compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250806/202508060351.OMeX2wGa-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202508060351.OMeX2wGa-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from net/sctp/socket.c:45:
>    In file included from include/linux/sched/signal.h:9:
>    In file included from include/linux/sched/task.h:13:
>    In file included from include/linux/uaccess.h:10:
> >> include/linux/ucopysize.h:45:4: error: call to '__bad_copy_from' declared with 'error' attribute: copy source size is too small
>                            __bad_copy_from();
>                            ^
>    1 error generated.
> 
> 
> vim +45 include/linux/ucopysize.h
> 
>     36	
>     37	static __always_inline __must_check bool
>     38	check_copy_size(const void *addr, size_t bytes, bool is_source)
>     39	{
>     40		int sz = __builtin_object_size(addr, 0);
>     41		if (unlikely(sz >= 0 && sz < bytes)) {
>     42			if (!__builtin_constant_p(bytes))
>     43				copy_overflow(sz, bytes);
>     44			else if (is_source)
>   > 45				__bad_copy_from();
>     46			else
>     47				__bad_copy_to();
>     48			return false;
>     49		}
>     50		if (WARN_ON_ONCE(bytes > INT_MAX))
>     51			return false;
>     52		check_object_size(addr, bytes, is_source);
>     53		return true;
>     54	}
>     55	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

-- 
Kees Cook

