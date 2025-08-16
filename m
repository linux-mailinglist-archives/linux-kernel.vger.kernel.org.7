Return-Path: <linux-kernel+bounces-772160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C13FDB28F66
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 18:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC79DAE32D1
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 16:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86EDE2E4277;
	Sat, 16 Aug 2025 16:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Ym15RQhy"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C18D23AE9A;
	Sat, 16 Aug 2025 16:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755361173; cv=none; b=QU/0DMma6U0CVPdSrJ/vcKzbZkpYmGMVLSCZhldosmgMCT+Ydo4OvTDfhoKEPmlpl5godxLqKfy5CQ+t4CU63U5X00UjMG8Tuzvm9iiCmWvD3ZhnzMefGAwDUEqNJpqnENdfuodIsAgYz05OoO5IxOjt49Nqczv6j2wdIA/oHaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755361173; c=relaxed/simple;
	bh=Ni2SRH/sEDhvrFuOT45BGG3k0SQyoGEYTroBGvv4mYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ftXNGtrwEg5+TLPDHyuvehdFzDCJ6fRMCx9mZ3NnQnGho/r5mmGzAbcYMLHTuv5bri56/5HVzQwM0kOV6CXNtUI12sqrN2SD5c7EQFjAPPBIgQAQFlJCmK/b51+Hg43496Ht4wxsvze4uwV/Hr5xL4URLzpSKH4Y2T10uG2FwiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Ym15RQhy; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=f5QcBb6a20Y9E3CIcIoL/CJ0bYUe2BW+pmQoB69q1kY=; b=Ym15RQhycP0LhykE7wVg8EhWcE
	lBMX41EIHNNOQV41ziQD+32Ylj9ebcsWijBpTCUp0vvroiP5ue7HHrYcgaUghfiPzs3SeTg9exd9l
	QxeQbBPUPA4d5hHgAfZYmUdS5K6SsXV6AzG6fjxtVf+f4d8wzVqfGqvWtlO6BqFYNoCwBHPvInWuX
	k0SFtvCxuK/S/hqD4uSA2rTdb4VCtMWnTpcR4RQ1troXLGGQG/lKXWe88JOrOGcIH1wdB3dZhvFpt
	0hKxsWeEfXFiB5R9Vi3o8RO1utNqaJ9dpG9dQ8UfLJnBM/SN5LMH9f1cEr0BmG2Q7NqzrmAlYFg6E
	KDZQLeLQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1unJcu-0000000GO1B-3coH;
	Sat, 16 Aug 2025 16:19:28 +0000
Date: Sat, 16 Aug 2025 17:19:28 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: kernel test robot <lkp@intel.com>
Cc: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: Re: mm/maccess.c:41:17: sparse: sparse: incorrect type in argument 2
 (different address spaces)
Message-ID: <20250816161928.GU222315@ZenIV>
References: <202508161713.RWu30Lv1-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202508161713.RWu30Lv1-lkp@intel.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Aug 16, 2025 at 05:28:29PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   dfd4b508c8c6106083698a0dd5e35aecc7c48725
> commit: ca1a66cdd685030738cf077e3955fdedfe39fbb9 riscv: uaccess: do not do misaligned accesses in get/put_user()
> date:   2 months ago
> config: riscv-randconfig-r122-20250816 (https://download.01.org/0day-ci/archive/20250816/202508161713.RWu30Lv1-lkp@intel.com/config)
> compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 93d24b6b7b148c47a2fa228a4ef31524fa1d9f3f)
> reproduce: (https://download.01.org/0day-ci/archive/20250816/202508161713.RWu30Lv1-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202508161713.RWu30Lv1-lkp@intel.com/
> 
> sparse warnings: (new ones prefixed by >>)
>    WARNING: invalid argument to '-march': '_zacas_zabha'
> >> mm/maccess.c:41:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got unsigned long long [usertype] * @@
>    mm/maccess.c:41:17: sparse:     expected void const [noderef] __user *from
>    mm/maccess.c:41:17: sparse:     got unsigned long long [usertype] *
> >> mm/maccess.c:43:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got unsigned int [usertype] * @@
>    mm/maccess.c:43:17: sparse:     expected void const [noderef] __user *from
>    mm/maccess.c:43:17: sparse:     got unsigned int [usertype] *
> >> mm/maccess.c:45:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got unsigned short [usertype] * @@
>    mm/maccess.c:45:17: sparse:     expected void const [noderef] __user *from
>    mm/maccess.c:45:17: sparse:     got unsigned short [usertype] *
> >> mm/maccess.c:46:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got unsigned char [usertype] * @@
>    mm/maccess.c:46:9: sparse:     expected void const [noderef] __user *from
>    mm/maccess.c:46:9: sparse:     got unsigned char [usertype] *
> >> mm/maccess.c:73:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got unsigned long long [usertype] * @@
>    mm/maccess.c:73:17: sparse:     expected void [noderef] __user *to
>    mm/maccess.c:73:17: sparse:     got unsigned long long [usertype] *
> >> mm/maccess.c:75:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got unsigned int [usertype] * @@
>    mm/maccess.c:75:17: sparse:     expected void [noderef] __user *to
>    mm/maccess.c:75:17: sparse:     got unsigned int [usertype] *
> >> mm/maccess.c:77:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got unsigned short [usertype] * @@
>    mm/maccess.c:77:17: sparse:     expected void [noderef] __user *to
>    mm/maccess.c:77:17: sparse:     got unsigned short [usertype] *
> >> mm/maccess.c:78:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got unsigned char [usertype] * @@
>    mm/maccess.c:78:9: sparse:     expected void [noderef] __user *to
>    mm/maccess.c:78:9: sparse:     got unsigned char [usertype] *
>    mm/maccess.c:98:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got unsigned char [usertype] * @@
>    mm/maccess.c:98:17: sparse:     expected void const [noderef] __user *from
>    mm/maccess.c:98:17: sparse:     got unsigned char [usertype] *

... and that clearly has fuck-all to do with mm/maccess.c.
The problem is in
#define __get_kernel_nofault(dst, src, type, err_label)                 \
        __get_user_nocheck(*((type *)(dst)), (type *)(src), err_label)

Make that
        __get_user_nocheck(*((type *)(dst)), (__force __user type *)(src), err_label)
and similar in
#define __put_kernel_nofault(dst, src, type, err_label)                 \
        __put_user_nocheck(*((type *)(src)), (type *)(dst), err_label)
(cast also on the second argument) and see how much noise will go away.

