Return-Path: <linux-kernel+bounces-724161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F93AFEF52
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 19:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 497001BC7298
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 17:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBCB222585;
	Wed,  9 Jul 2025 17:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="tD5mAcSV"
Received: from smtp.smtpout.orange.fr (smtp-82.smtpout.orange.fr [80.12.242.82])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CE838F9C;
	Wed,  9 Jul 2025 17:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752080641; cv=none; b=lFeAdhTa1j0J75iR4PrJgPX6YG5aKe7o0DWRxl0tDeoiwGJixZAb5onUN4tZ8BtsETahjQugJf/BkiGkpJj37IK3XqGhcHEUXXsCfajF8Epu0w1JuM6HbG3L2QTnjjxOzfvtp1Pj42hn2Mg4mhBhEEqYUZ64+ruNkTCDelhmU1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752080641; c=relaxed/simple;
	bh=+QLS67LP3MAKEKzz3JJMVKPpv6Hxh0TQYFvpq7He7W4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BIhE/FIAcQ0ADeY4elqnxYNGEYQlKzj+YL8w9Z+0k2h/mB1jKGqgwTzOVXqvNhKV/RwHVuiO/wwR6iczXgVWrWOdya3hNI/956Y/tIgjJVjr3rnfwKUBMdup1RzM46MtG4JiNxUPOQ77YFYq4aEIgcko0P/YXbogCs8XBSzlFCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=tD5mAcSV; arc=none smtp.client-ip=80.12.242.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
 ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id ZYD2uiFK70i5kZYD2uV8Mx; Wed, 09 Jul 2025 19:03:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1752080636;
	bh=zun+I1R1xXyJz0HTUliO8x5fV8L46/pP1oYWwkaGDyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=tD5mAcSV17dDqivd0yuOdX396vyjLb9SPpJq1S1BRuBLPMHwTcBl8bCk3vF4KhkPw
	 OK8IxCL8cbyTr3bvgOXKL+toR4ggJbJEHKEcVvqFDa092/Rn/YxTHLc3DDBbOxECQD
	 WXYve3A5Mfdgmeb6914zViG/OBmyYgyTYrR+u51tqT/dBd7RsIDnFi54pjrIZRKfcs
	 gCpKVZ6RtQWxPVZrBZZxqqxiHS+4vdCYwoCcAMGN0bffMcXV9LglKdF9SkkN2pF/So
	 tcguz1UG4SuJober2Y+EUFsQKj/3ZQUjO9bpqr6em6c+uiov1WP6M+ieocdKqN2NOz
	 N2qYgHK9wOjIw==
X-ME-Helo: [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Wed, 09 Jul 2025 19:03:56 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
Message-ID: <14040edb-5c27-42d2-a78b-f679bbc90ed8@wanadoo.fr>
Date: Wed, 9 Jul 2025 19:03:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] squashfs: Fix incorrect argument to sizeof in
 kmalloc_array call
To: Andrew Morton <akpm@linux-foundation.org>,
 kernel test robot <lkp@intel.com>
Cc: Colin Ian King <colin.i.king@gmail.com>,
 Phillip Lougher <phillip@squashfs.org.uk>, Chanho Min <chanho.min@lge.com>,
 oe-kbuild-all@lists.linux.dev, kernel-janitors@vger.kernel.org,
 Linux Memory Management List <linux-mm@kvack.org>,
 linux-kernel@vger.kernel.org
References: <20250708142604.1891156-1-colin.i.king@gmail.com>
 <aG3AVf8fbqHzk+OD@rli9-mobl>
 <20250708195413.e990d63665144c28b0caa672@linux-foundation.org>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20250708195413.e990d63665144c28b0caa672@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 09/07/2025 à 04:54, Andrew Morton a écrit :
> On Wed, 9 Jul 2025 09:05:25 +0800 kernel test robot <lkp@intel.com> wrote:
> 
>> Hi Colin,
>>
>> kernel test robot noticed the following build errors:
>>
>> [auto build test ERROR on akpm-mm/mm-everything]
>> [also build test ERROR on next-20250708]
>> [cannot apply to linus/master v6.16-rc5]
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use '--base' as documented in
>> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>>
>> url:    https://github.com/intel-lab-lkp/linux/commits/Colin-Ian-King/squashfs-Fix-incorrect-argument-to-sizeof-in-kmalloc_array-call/20250708-223017
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
>> patch link:    https://lore.kernel.org/r/20250708142604.1891156-1-colin.i.king%40gmail.com
>> patch subject: [PATCH] squashfs: Fix incorrect argument to sizeof in kmalloc_array call
>> :::::: branch date: 10 hours ago
>> :::::: commit date: 10 hours ago
>> config: mips-randconfig-r071-20250709 (attached as .config)
>> compiler: mips64-linux-gcc (GCC) 8.5.0
>> reproduce (this is a W=1 build): (attached as reproduce)
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://lore.kernel.org/oe-kbuild-all/202507090822.QI1bMiUV-lkp@intel.com/
>>
>> All error/warnings (new ones prefixed by >>):
>>
>>     In file included from include/linux/percpu.h:5,
>>                      from include/linux/percpu_counter.h:14,
>>                      from include/linux/mm_types.h:21,
>>                      from include/linux/mmzone.h:22,
>>                      from include/linux/gfp.h:7,
>>                      from include/linux/xarray.h:16,
>>                      from include/linux/list_lru.h:14,
>>                      from include/linux/fs.h:14,
>>                      from include/linux/highmem.h:5,
>>                      from include/linux/bvec.h:10,
>>                      from include/linux/blk_types.h:10,
>>                      from include/linux/blkdev.h:9,
>>                      from fs/squashfs/block.c:16:
>>     fs/squashfs/block.c: In function 'squashfs_bio_read_cached':
>>>> fs/squashfs/block.c:92:12: error: 'folio' undeclared (first use in this function)
>>         sizeof(*folio), GFP_KERNEL | __GFP_ZERO);
>>                 ^~~~~
> 
> I made it
> 
> 	struct folio **cache_folios = kmalloc_array(page_count,
> 			sizeof(*cache_folios), GFP_KERNEL | __GFP_ZERO);
> 

WHy not kcalloc(), to be less verbose and remove the explicit __GFP_ZERO?

CJ

> 
> 


