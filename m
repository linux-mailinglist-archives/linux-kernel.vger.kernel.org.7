Return-Path: <linux-kernel+bounces-746825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68424B12BA8
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 19:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F73117D523
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 17:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933EE286D56;
	Sat, 26 Jul 2025 17:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hjB/WQNk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C0721C9E3;
	Sat, 26 Jul 2025 17:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753551594; cv=none; b=reHjXg+8UQYwOmYtDDE6DxopjgpdJmOUZkm1BAX1UoqUOU8TUl/mg2TmhB8cHTralHkrXhN+JwplC07biqBJWzDJR8mDV6hT/r0XF3T9SMJ5cg+WUdzymIv5sAmb2euImYlU/xp0OV+oHr9aRLToIg9OcyJYiQmc+8LLtWTjLI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753551594; c=relaxed/simple;
	bh=+VDc4EwjT56NL/Zol9kf1Q+HHzms9fp4Pp6RVQi7oDU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=VZTay0RxD7fu3NjJwGbnElpcbEwtnP4fx9gbm61ZMUdS0xesK1UfwAJ4Op9ypQRdaGCYDjsPDc3WtDKcPc6bBSdc29DqY2zTSJSASp61XyQLNZFGeNKEmNjqkiFHZlGyxRQ1KpaSqj8z55wEPr0DxAsqTkXYK/FRC5erw37Zc3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hjB/WQNk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB2C1C4CEED;
	Sat, 26 Jul 2025 17:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1753551593;
	bh=+VDc4EwjT56NL/Zol9kf1Q+HHzms9fp4Pp6RVQi7oDU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hjB/WQNk8i1P2njJC+lf+PTkFsnPl8eL7byz/R7MeXZ5hfwD4iL94Z9W2A7kbF3w5
	 xK9stE0hHsJviTYyeYTpMvEzwPKpYNCrG0yEE0FVS76Y4FMKjVJ8SdtnUJuuTt7uoa
	 pd7UYMQmsr2yWLhrQ3WBsHm32cvuT1vOiRSO7Vn4=
Date: Sat, 26 Jul 2025 10:39:52 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: kernel test robot <lkp@intel.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, llvm@lists.linux.dev,
 oe-kbuild-all@lists.linux.dev, Linux Memory Management List
 <linux-mm@kvack.org>, Christoph Hellwig <hch@infradead.org>, David
 Hildenbrand <david@redhat.com>, "Liam R . Howlett"
 <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
 <mhocko@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: remove io-mapping
Message-Id: <20250726103952.674ee38b16202dff3d54e8aa@linux-foundation.org>
In-Reply-To: <202507261811.4FJjX1bu-lkp@intel.com>
References: <20250724145313.65920-1-lorenzo.stoakes@oracle.com>
	<202507261811.4FJjX1bu-lkp@intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 26 Jul 2025 18:15:44 +0800 kernel test robot <lkp@intel.com> wrote:

> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on akpm-mm/mm-everything]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Lorenzo-Stoakes/mm-remove-io-mapping/20250724-225556
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> patch link:    https://lore.kernel.org/r/20250724145313.65920-1-lorenzo.stoakes%40oracle.com
> patch subject: [PATCH] mm: remove io-mapping
> config: x86_64-buildonly-randconfig-003-20250725 (https://download.01.org/0day-ci/archive/20250726/202507261811.4FJjX1bu-lkp@intel.com/config)
> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250726/202507261811.4FJjX1bu-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202507261811.4FJjX1bu-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
> >> drivers/net/ethernet/mellanox/mlx4/main.c:43:10: fatal error: 'linux/io-mapping.h' file not found
>       43 | #include <linux/io-mapping.h>
>          |          ^~~~~~~~~~~~~~~~~~~~

I'm all confused.  include/linux/io-mapping.h is present in every tree
I can find.  This report doesn't identify the HEAD commit which was
used?

