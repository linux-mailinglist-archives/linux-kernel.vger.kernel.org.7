Return-Path: <linux-kernel+bounces-732631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8524B069CD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 01:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA2413B949F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 23:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53262D3A98;
	Tue, 15 Jul 2025 23:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z/CEHg5F"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034AC1FF7DC;
	Tue, 15 Jul 2025 23:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752621597; cv=none; b=C2rVnxsiJY6Um2f5GsHb5K8AuE0l+4zh2x2iDnJmX5Dbh7JRqCkx16cIpe2o8BPgAPo4gu/38WRSou2LFR8kM7m7pwEvBJiXR0Yq9dOIw5PlhespJyxIWJcsiVC1n0N9OcFDUkL0W3nr4q9/uL+9m6zy0IMpOicHrJwqDr8png0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752621597; c=relaxed/simple;
	bh=itnCC0VYx4q+7BX3ewA5kXh7ZnbQx/OqXw4zUuElz3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FGvSvWhDa+716s/+377bTmIpnEJAP7JvRX/lm1a3qfO5yVhX8z314pf/UkdpyXH7QBHyuSDTUGPaKL3hnUqBJ/9Zh2khaG66t9V0LU6LtqU6AANLgqSk9hQ4WAil7LFN3KITn7ZI9Pq7maODeUQTUvFtAlDzOfLf7pIE6rv5dUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z/CEHg5F; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752621595; x=1784157595;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=itnCC0VYx4q+7BX3ewA5kXh7ZnbQx/OqXw4zUuElz3g=;
  b=Z/CEHg5FJljA7j2K6Ly+X5Z7mAlUamfZSy2mq+S0u235DT1zg4zchRYv
   tpKPb78JCYHYmiBNp7K8Q/JwskemVGDizK+hoa1GFdWR6G+V3bALPPLew
   /ajxNLrttTnt+k50nnEhiH+mAHd/x9Dn+LIMBxFtpaZcmBtA1CFFdLEI0
   /oknIXD7nf0Y8cUgCiqv2CLgs9neQMQFIQM74jnmeqsx4sQpL65d01jh7
   fl+1Zi3Q3A0muspkCK1Juxy8tyQyWkg3Hu6nQDFhYTEe6VOkKj9hu82Ww
   Zs20Yip5xlxLk94pglad4RJ2YLcKl+GG1yWXi78xA4iUdYVfi22eh5gqy
   w==;
X-CSE-ConnectionGUID: dByCVXMISRGi/418Kmv9kg==
X-CSE-MsgGUID: cCpDRak5RJOGTpXpIqAScg==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="55006928"
X-IronPort-AV: E=Sophos;i="6.16,314,1744095600"; 
   d="scan'208";a="55006928"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 16:19:54 -0700
X-CSE-ConnectionGUID: VujzdIHpTnu31G/E73VB1A==
X-CSE-MsgGUID: pemlAhaUQjqCEiML7WxdCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,314,1744095600"; 
   d="scan'208";a="158070374"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 15 Jul 2025 16:19:49 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ubow7-000Bet-1H;
	Tue, 15 Jul 2025 23:19:47 +0000
Date: Wed, 16 Jul 2025 07:19:21 +0800
From: kernel test robot <lkp@intel.com>
To: Hui Zhu <hui.zhu@linux.dev>, Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	bjorn3_gh@protonmail.com, Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Geliang Tang <geliang@kernel.org>, Hui Zhu <zhuhui@kylinos.cn>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH 1/3] vmalloc: Add vrealloc_align to support allocation of
 aligned vmap pages
Message-ID: <202507160708.jArplInK-lkp@intel.com>
References: <81647cce3b8e7139af47f20dbeba184b7a89b0cc.1752573305.git.zhuhui@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81647cce3b8e7139af47f20dbeba184b7a89b0cc.1752573305.git.zhuhui@kylinos.cn>

Hi Hui,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rust/rust-next]
[also build test WARNING on akpm-mm/mm-everything rust/alloc-next linus/master v6.16-rc6 next-20250715]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Hui-Zhu/vmalloc-Add-vrealloc_align-to-support-allocation-of-aligned-vmap-pages/20250715-180136
base:   https://github.com/Rust-for-Linux/linux rust-next
patch link:    https://lore.kernel.org/r/81647cce3b8e7139af47f20dbeba184b7a89b0cc.1752573305.git.zhuhui%40kylinos.cn
patch subject: [PATCH 1/3] vmalloc: Add vrealloc_align to support allocation of aligned vmap pages
config: i386-buildonly-randconfig-002-20250716 (https://download.01.org/0day-ci/archive/20250716/202507160708.jArplInK-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250716/202507160708.jArplInK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507160708.jArplInK-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> mm/vmalloc.c:4124:9: warning: format specifies type 'long' but the argument has type 'size_t' (aka 'unsigned int') [-Wformat]
    4123 |                         WARN(1, "Trying to vrealloc_align() align is not power of 2 (%ld)\n",
         |                                                                                      ~~~
         |                                                                                      %zu
    4124 |                              align);
         |                              ^~~~~
   include/asm-generic/bug.h:134:29: note: expanded from macro 'WARN'
     134 |                 __WARN_printf(TAINT_WARN, format);                      \
         |                                           ^~~~~~
   include/asm-generic/bug.h:106:17: note: expanded from macro '__WARN_printf'
     106 |                 __warn_printk(arg);                                     \
         |                               ^~~
   mm/vmalloc.c:1987:20: warning: unused function 'setup_vmalloc_vm' [-Wunused-function]
    1987 | static inline void setup_vmalloc_vm(struct vm_struct *vm,
         |                    ^~~~~~~~~~~~~~~~
   2 warnings generated.


vim +4124 mm/vmalloc.c

  4082	
  4083	/**
  4084	 * vrealloc_align - reallocate virtually contiguous memory;
  4085	 *                  contents remain unchanged
  4086	 * @p: object to reallocate memory for
  4087	 * @size: the size to reallocate
  4088	 * @align: requested alignment
  4089	 * @flags: the flags for the page level allocator
  4090	 *
  4091	 * If @p is %NULL, vrealloc() behaves exactly like vmalloc(). If @size is 0 and
  4092	 * @p is not a %NULL pointer, the object pointed to is freed.
  4093	 *
  4094	 * If __GFP_ZERO logic is requested, callers must ensure that, starting with the
  4095	 * initial memory allocation, every subsequent call to this API for the same
  4096	 * memory allocation is flagged with __GFP_ZERO. Otherwise, it is possible that
  4097	 * __GFP_ZERO is not fully honored by this API.
  4098	 *
  4099	 * In any case, the contents of the object pointed to are preserved up to the
  4100	 * lesser of the new and old sizes.
  4101	 *
  4102	 * This function must not be called concurrently with itself or vfree() for the
  4103	 * same memory allocation.
  4104	 *
  4105	 * Return: pointer to the allocated memory; %NULL if @size is zero or in case of
  4106	 *         failure
  4107	 */
  4108	void *vrealloc_align_noprof(const void *p, size_t size, size_t align,
  4109				    gfp_t flags)
  4110	{
  4111		struct vm_struct *vm = NULL;
  4112		size_t alloced_size = 0;
  4113		size_t old_size = 0;
  4114		void *n;
  4115	
  4116		if (!size) {
  4117			vfree(p);
  4118			return NULL;
  4119		}
  4120	
  4121		if (p) {
  4122			if (!is_power_of_2(align)) {
  4123				WARN(1, "Trying to vrealloc_align() align is not power of 2 (%ld)\n",
> 4124				     align);
  4125				return NULL;
  4126			}
  4127	
  4128			vm = find_vm_area(p);
  4129			if (unlikely(!vm)) {
  4130				WARN(1, "Trying to vrealloc_align() nonexistent vm area (%p)\n", p);
  4131				return NULL;
  4132			}
  4133	
  4134			alloced_size = get_vm_area_size(vm);
  4135			old_size = vm->requested_size;
  4136			if (WARN(alloced_size < old_size,
  4137				 "vrealloc_align() has mismatched area vs requested sizes (%p)\n", p))
  4138				return NULL;
  4139		}
  4140	
  4141		if (IS_ALIGNED((unsigned long)p, align)) {
  4142			/*
  4143			 * TODO: Shrink the vm_area, i.e. unmap and free unused pages. What
  4144			 * would be a good heuristic for when to shrink the vm_area?
  4145			 */
  4146			if (size <= old_size) {
  4147				/* Zero out "freed" memory, potentially for future realloc. */
  4148				if (want_init_on_free() || want_init_on_alloc(flags))
  4149					memset((void *)p + size, 0, old_size - size);
  4150				vm->requested_size = size;
  4151				kasan_poison_vmalloc(p + size, old_size - size);
  4152				return (void *)p;
  4153			}
  4154	
  4155			/*
  4156			 * We already have the bytes available in the allocation; use them.
  4157			 */
  4158			if (size <= alloced_size) {
  4159				kasan_unpoison_vmalloc(p + old_size, size - old_size,
  4160						KASAN_VMALLOC_PROT_NORMAL);
  4161				/*
  4162				 * No need to zero memory here, as unused memory will have
  4163				 * already been zeroed at initial allocation time or during
  4164				 * realloc shrink time.
  4165				 */
  4166				vm->requested_size = size;
  4167				return (void *)p;
  4168			}
  4169		} else {
  4170			/*
  4171			 * p is not aligned with align.
  4172			 * Allocate a new address to handle it.
  4173			 */
  4174			if (size < old_size)
  4175				old_size = size;
  4176		}
  4177	
  4178		/* TODO: Grow the vm_area, i.e. allocate and map additional pages. */
  4179		n = __vmalloc_node_noprof(size, align, flags, NUMA_NO_NODE,
  4180					  __builtin_return_address(0));
  4181		if (!n)
  4182			return NULL;
  4183	
  4184		if (p) {
  4185			memcpy(n, p, old_size);
  4186			vfree(p);
  4187		}
  4188	
  4189		return n;
  4190	}
  4191	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

