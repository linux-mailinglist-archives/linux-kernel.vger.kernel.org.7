Return-Path: <linux-kernel+bounces-864486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3468DBFAE32
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9065B353C62
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBC0309F02;
	Wed, 22 Oct 2025 08:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="GLezp4tR"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810FF3081DC
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761121691; cv=none; b=seargUpIOb57WRk15rI16R8V5Smm32rjs7bEGppj8d++f2H4M0u4Ij/1EErFOzvBPG0ysZauH+QTZDBpCGhZ2lpmVzmm12FirDi7BKoNbhFQKjk0DS5HSIfmN2EPoNEhXdNUQfWcmgc34yjNmhYKQ3DD0BR/O4c86U7P4BKH3rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761121691; c=relaxed/simple;
	bh=+qDTriJL1I8TlNCkThOTTjYJGjDQws6OfKtI9VmLqYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zn4DK/SRY4a1p3fSzKY4og79TluCMA6vrRgc/HLRbG2NXlLwjhrhI68YS94w8dXML0I9l8hoJRyEwsyCU3AQbaeuOrFX4+biA2gyvGos0JsM5mGb50vKX9nCPzMeMQDYJW/2cJ+NBE+HHgsq/L4n0ocI+rYbmRQUs8LxJW4EX5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=GLezp4tR; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761121686;
	bh=+qDTriJL1I8TlNCkThOTTjYJGjDQws6OfKtI9VmLqYU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GLezp4tR0VrbO4ufLefY9gSD9aFklgbAX1ncNafEdBljwnmLzVoZ/n2P6arETT3yx
	 BhDYxIDpnFVx0OuZ4Mxenaamq9C93PodBccJx9kPbcbs1V8jdmH0gqROMaU4VCMCjR
	 y2TXGUxy8dzqtvY+WuuJrFW0L+TS1ayxAghS1NF8GVPnZn2xA9Nc+haDd+RSGiwDuM
	 LZnycgx5dmSetFT4S7nnM1Ej8gVvXyoIvRWgFP66pzUQpRKN/JumjSzNayA8tQBl4r
	 MQ/R99lq4mQaQ2a2JC+feu3/QSC+AVCkC6LCBRyTA//kwxaRPMb1uVCtAod8qf2zA0
	 zYZIzAL/bm0Ag==
Received: from [IPV6:2a01:e0a:5e3:6100:7aed:fe0e:8590:cbaa] (unknown [IPv6:2a01:e0a:5e3:6100:7aed:fe0e:8590:cbaa])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: loicmolinari)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A862E17E00B0;
	Wed, 22 Oct 2025 10:28:05 +0200 (CEST)
Message-ID: <64040015-2840-4210-8019-a39e605d87a0@collabora.com>
Date: Wed, 22 Oct 2025 10:28:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/12] drm/i915: Use huge tmpfs mountpoint helpers
To: Boris Brezillon <boris.brezillon@collabora.com>,
 kernel test robot <lkp@intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, Boris Brezillon <bbrezillon@kernel.org>,
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>, Melissa Wen <mwen@igalia.com>,
 =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Hugh Dickins <hughd@google.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Andrew Morton <akpm@linux-foundation.org>,
 Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Nitin Gote <nitin.r.gote@intel.com>, Andi Shyti
 <andi.shyti@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Christopher Healy <healych@amazon.com>, Matthew Wilcox
 <willy@infradead.org>, Bagas Sanjaya <bagasdotme@gmail.com>,
 oe-kbuild-all@lists.linux.dev,
 Linux Memory Management List <linux-mm@kvack.org>,
 linux-kernel@vger.kernel.org
References: <20251021113049.17242-7-loic.molinari@collabora.com>
 <202510221301.wU3TSqMg-lkp@intel.com> <20251022100548.4dee241e@fedora>
Content-Language: fr
From: =?UTF-8?Q?Lo=C3=AFc_Molinari?= <loic.molinari@collabora.com>
Organization: Collabora Ltd
In-Reply-To: <20251022100548.4dee241e@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Boris,

On 22/10/2025 10:05, Boris Brezillon wrote:
> On Wed, 22 Oct 2025 11:25:10 +0800
> kernel test robot <lkp@intel.com> wrote:
> 
>> Hi Loïc,
>>
>> kernel test robot noticed the following build errors:
>>
>> [auto build test ERROR on next-20251021]
>> [also build test ERROR on v6.18-rc2]
>> [cannot apply to akpm-mm/mm-everything drm-misc/drm-misc-next linus/master v6.18-rc2 v6.18-rc1 v6.17]
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use '--base' as documented in
>> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>>
>> url:    https://github.com/intel-lab-lkp/linux/commits/Lo-c-Molinari/drm-shmem-helper-Simplify-page-offset-calculation-in-fault-handler/20251021-193355
>> base:   next-20251021
>> patch link:    https://lore.kernel.org/r/20251021113049.17242-7-loic.molinari%40collabora.com
>> patch subject: [PATCH v5 06/12] drm/i915: Use huge tmpfs mountpoint helpers
>> config: x86_64-randconfig-003-20251022 (https://download.01.org/0day-ci/archive/20251022/202510221301.wU3TSqMg-lkp@intel.com/config)
>> compiler: gcc-13 (Debian 13.3.0-16) 13.3.0
>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251022/202510221301.wU3TSqMg-lkp@intel.com/reproduce)
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://lore.kernel.org/oe-kbuild-all/202510221301.wU3TSqMg-lkp@intel.com/
>>
>> All errors (new ones prefixed by >>):
>>
>>     drivers/gpu/drm/i915/gem/i915_gem_shmem.c: In function '__create_shmem':
>>>> drivers/gpu/drm/i915/gem/i915_gem_shmem.c:511:59: error: 'struct drm_device' has no member named 'huge_mnt'
>>       511 |                 filp = shmem_file_setup_with_mnt(i915->drm.huge_mnt, "i915",
>>           |                                                           ^
>>
>>
>> vim +511 drivers/gpu/drm/i915/gem/i915_gem_shmem.c
>>
>>     486	
>>     487	static int __create_shmem(struct drm_i915_private *i915,
>>     488				  struct drm_gem_object *obj,
>>     489				  resource_size_t size)
>>     490	{
>>     491		unsigned long flags = VM_NORESERVE;
>>     492		struct file *filp;
>>     493	
>>     494		drm_gem_private_object_init(&i915->drm, obj, size);
>>     495	
>>     496		/* XXX: The __shmem_file_setup() function returns -EINVAL if size is
>>     497		 * greater than MAX_LFS_FILESIZE.
>>     498		 * To handle the same error as other code that returns -E2BIG when
>>     499		 * the size is too large, we add a code that returns -E2BIG when the
>>     500		 * size is larger than the size that can be handled.
>>     501		 * If BITS_PER_LONG is 32, size > MAX_LFS_FILESIZE is always false,
>>     502		 * so we only needs to check when BITS_PER_LONG is 64.
>>     503		 * If BITS_PER_LONG is 32, E2BIG checks are processed when
>>     504		 * i915_gem_object_size_2big() is called before init_object() callback
>>     505		 * is called.
>>     506		 */
>>     507		if (BITS_PER_LONG == 64 && size > MAX_LFS_FILESIZE)
>>     508			return -E2BIG;
>>     509	
>>     510		if (drm_gem_has_huge_mnt(&i915->drm))
>>   > 511			filp = shmem_file_setup_with_mnt(i915->drm.huge_mnt, "i915",
>>     512							 size, flags);
> 
> Maybe instead of this drm_gem_has_huge_mnt() (or in addition to), we
> should have a drm_gem_get_huge_mnt() helper, so we don't have drivers
> dereferencing drm_device::huge_mnt directly and we can get rid of it on
> non THP configs.

Yes, drm_gem_get_huge_mnt() should be enough. This would prevent build 
errors like that for builds with CONFIG_TRANSPARENT_PAGE=n without 
having to insert ifdefs and would also just compile to a single 
shmem_file_setup() here. The few places which actually need a boolean 
value can simply do !!drm_gem_get_huge_mnt(dev).

> 
>>     513		else
>>     514			filp = shmem_file_setup("i915", size, flags);
>>     515		if (IS_ERR(filp))
>>     516			return PTR_ERR(filp);
>>     517	
>>     518		/*
>>     519		 * Prevent -EFBIG by allowing large writes beyond MAX_NON_LFS on shmem
>>     520		 * objects by setting O_LARGEFILE.
>>     521		 */
>>     522		if (force_o_largefile())
>>     523			filp->f_flags |= O_LARGEFILE;
>>     524	
>>     525		obj->filp = filp;
>>     526		return 0;
>>     527	}
>>     528	
>>
> 

Regards,
Loïc

