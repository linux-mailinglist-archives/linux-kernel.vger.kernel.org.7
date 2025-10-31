Return-Path: <linux-kernel+bounces-879344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4422FC22E35
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 02:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2F4B64E62C4
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 01:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7419F2512E6;
	Fri, 31 Oct 2025 01:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="TPtWy7U8"
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AD0248F77
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 01:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761874615; cv=none; b=bRNP6RdzXM4MPr9Lt1wxqBWOIB9IxmvvToMZstKF2BE4OR3mo/v+p51oGNeH092ZjgqAaHYbi7cHDEwwwlg7AC9oogpY1ocdG3nqFLBziKETuCu+JgAebqSGm9EluxNnp/TK2nOKfUVukKzztOmQArJ8pB7Btw/WXVumXOsbocI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761874615; c=relaxed/simple;
	bh=ra98l5vCAiUM9cl/H+7FvfxyjPMgS5+DTDOWdzFcLp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cd/chlcYA4PVe/Yj3ckRfoUyRKwMLRjxbs60eSlO5liOCgOLZXU77MaXGDuTQ+UnyfxwYVBlPQOJyORRDbywnd8oCt3JwWZcZ/pktUgcRfo7HbknwHUVJmp1Chs02TqmX6a9oFjUnQTPebHUthTSeNRvqAkIwSLaikbsJDyR9qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=TPtWy7U8; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1761874540;
	bh=6R5YTEFGe8zvvUBTqpI3LLKAzOQSDt5qh5MXI7g06MU=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=TPtWy7U85yY956n93JNjZnxwTouJEc5Kcx0XpcLJbOrGkY6dOM5FXJxF8+s3aI9bh
	 mpwlIMbWR4zFBsl5VQikKO0vcdvCh/f1Nn1J8VlwNE8yzX1c3FgTOGGwkF7Y9e5f5P
	 mAb2p47vGQno73RI3N21siZoIlvboAgy5kHJWqSI=
X-QQ-mid: zesmtpsz2t1761874536t3284b2d5
X-QQ-Originating-IP: UIrVPTkPFuqoK3aussdKWGuZnaeDIiMcqZr0RQVS6iM=
Received: from [10.10.74.117] ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 31 Oct 2025 09:35:35 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 17088829782577716598
Message-ID: <2E76E38A52ABE495+b9e1827e-5180-47a3-86fd-35a8bdcc65c1@uniontech.com>
Date: Fri, 31 Oct 2025 09:35:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kexec: print out debugging message if required for
 kexec_load
To: kernel test robot <lkp@intel.com>, akpm@linux-foundation.org,
 bhe@redhat.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251030073316.529106-1-maqianga@uniontech.com>
 <202510310332.6XrLe70K-lkp@intel.com>
Content-Language: en-US
From: Qiang Ma <maqianga@uniontech.com>
In-Reply-To: <202510310332.6XrLe70K-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: MQPu5pFEJFN4wrKCH2h0XbtN7bO0XcPgUjg3fLfFvuX/BN9y/aRyaOfa
	XkDTJEUFduweHcLzqm2hpEzyn0ZFR2DVS5TVFj5hGvXqly8LacDwyxPJgeFIvgEDGSqBf7U
	dPYFiD+BpQtpLXK6bHGVBI+2alH+fQRCmerIXHToQ7BHBlryBSKX+IrnmqEeF3guL6roLw3
	HmSG5G6rMK4YNE1okIV/DHr+o//Hwg/4VwQ/FyUQKzL9DgCA8c0S5aQrE3rZkUtW99+s2BW
	gux3NNzzI1UvVWJovl9nHSF9ZiomKUo3OK64WcsDft6qjU9vqqxlVASEkUwwlZxX7mcjb5y
	VK9o4gl4kMDJmt4EVlQl+PPfkQDdXZ0uO8ETmYwaaAJXEYecSXbuj2yuOQn75TNaMvZ4nF/
	iR6mHAZ+NY5YySIWLBwc3sFnDoL9G2q3zPo6kJjtzJPI2stTb0C3RRB4Az829Gd0IWGe2Ar
	OFOOD04O+BTivV7IawKGQlLERhwcYlNYi8+jZ/xYYfhaeiVCi9ZGMwcm2sk0q806VOUQJvb
	HuPwh3fwjlpIHXb/wsDzk6jaRVcNo+adQpkoQFVw3MElG0Jlujf3mXGnV/D/iKwl/MpmcOI
	61ES85Up1fXSUhGIDycNCv0dE5JWeJ/TOn3jlV9xqbbVhz4STAowZsfdtgyv/OZx9jzfMmx
	kiznbMnDhhC4jaMCWm3P6+gDzENQosQti+KveKIaK1fBZeci53m723mhzxTCwp9uIHBWg3j
	VZai3oOCxgEzfVRJHoNnNW7lTMqa5IIeKIyNRv0eNjRjdGkRo62FRxoeK3dm5jrsBNJAjV9
	dYxFGFPhxFUpvGfMQWOueqsJuc8QA9TfbnOcZw4Kkfprga/U3xTEU8uhuUcbnooYpJfyUwP
	3PXFfhLhRYX4ts0CKTRFvt6Qn6NG2TPlYMwtyTAIp0MGduhpkeoUT1xUgGQsR+D7Upuc3Rn
	shvyJrERXqHeAFqiNKIMrCbrIhVxqZSEBt3owIcRe8SkZCXbWrIU0Qpgf7o1Y4LeyPsM0fJ
	plZPPEZjGZOpjRWfTmilXNcamn4t0=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0


在 2025/10/31 03:20, kernel test robot 写道:
> Hi Qiang,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on akpm-mm/mm-everything]
> [also build test WARNING on linus/master v6.18-rc3 next-20251030]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Qiang-Ma/kexec-print-out-debugging-message-if-required-for-kexec_load/20251030-153807
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> patch link:    https://lore.kernel.org/r/20251030073316.529106-1-maqianga%40uniontech.com
> patch subject: [PATCH] kexec: print out debugging message if required for kexec_load
> config: x86_64-kexec (https://download.01.org/0day-ci/archive/20251031/202510310332.6XrLe70K-lkp@intel.com/config)
> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251031/202510310332.6XrLe70K-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202510310332.6XrLe70K-lkp@intel.com/
ok.
> All warnings (new ones prefixed by >>):
>
>>> kernel/kexec.c:160:10: warning: format specifies type 'int' but the argument has type 'unsigned long' [-Wformat]
>       159 |                 kexec_dprintk("segment[%d]: buf=0x%p bufsz=0x%zx mem=0x%lx memsz=0x%zx\n",
>           |                                        ~~
>           |                                        %lu
>       160 |                               i, ksegment->buf, ksegment->bufsz, ksegment->mem,
>           |                               ^
>     include/linux/kexec.h:531:55: note: expanded from macro 'kexec_dprintk'
>       531 |         do { if (kexec_file_dbg_print) pr_info(fmt, ##arg); } while (0)
>           |                                                ~~~    ^~~
>     include/linux/printk.h:585:34: note: expanded from macro 'pr_info'
>       585 |         printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
>           |                                 ~~~     ^~~~~~~~~~~
>     include/linux/printk.h:512:60: note: expanded from macro 'printk'
>       512 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
>           |                                                     ~~~    ^~~~~~~~~~~
>     include/linux/printk.h:484:19: note: expanded from macro 'printk_index_wrap'
>       484 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
>           |                         ~~~~    ^~~~~~~~~~~
>     1 warning generated.
Yes, this is an type mismatch, will fix and update in new post, thanks.
>
> vim +160 kernel/kexec.c
>
>     141	
>     142		ret = machine_kexec_prepare(image);
>     143		if (ret)
>     144			goto out;
>     145	
>     146		/*
>     147		 * Some architecture(like S390) may touch the crash memory before
>     148		 * machine_kexec_prepare(), we must copy vmcoreinfo data after it.
>     149		 */
>     150		ret = kimage_crash_copy_vmcoreinfo(image);
>     151		if (ret)
>     152			goto out;
>     153	
>     154		kexec_dprintk("nr_segments = %lu\n", image->nr_segments);
>     155		for (i = 0; i < nr_segments; i++) {
>     156			struct kexec_segment *ksegment;
>     157	
>     158			ksegment = &image->segment[i];
>     159			kexec_dprintk("segment[%d]: buf=0x%p bufsz=0x%zx mem=0x%lx memsz=0x%zx\n",
>   > 160				      i, ksegment->buf, ksegment->bufsz, ksegment->mem,
>     161				      ksegment->memsz);
>     162	
>     163			ret = kimage_load_segment(image, i);
>     164			if (ret)
>     165				goto out;
>     166		}
>     167	
>     168		kimage_terminate(image);
>     169	
>     170		ret = machine_kexec_post_load(image);
>     171		if (ret)
>     172			goto out;
>     173	
>     174		kexec_dprintk("kexec_file_load: type:%u, start:0x%lx head:0x%lx flags:0x%lx\n",
>     175			      image->type, image->start, image->head, flags);
>     176	
>     177		/* Install the new kernel and uninstall the old */
>     178		image = xchg(dest_image, image);
>     179	
>     180	out:
>     181	#ifdef CONFIG_CRASH_DUMP
>     182		if ((flags & KEXEC_ON_CRASH) && kexec_crash_image)
>     183			arch_kexec_protect_crashkres();
>     184	#endif
>     185	
>     186		kimage_free(image);
>     187	out_unlock:
>     188		kexec_unlock();
>     189		return ret;
>     190	}
>     191	
>


