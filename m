Return-Path: <linux-kernel+bounces-826409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C62E7B8E76C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 23:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA6E7189CB01
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 21:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304E72264B2;
	Sun, 21 Sep 2025 21:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="S2OH+Oq1"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B368B49620
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 21:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758491303; cv=none; b=awUBbYgURHCv69LghUM46orrcXt51QCT5HrkG5mOSylSEL+wQMEedgDsbq7ZKzHpeYwTUUNlMM8Rsh6XJsOfX7cbq/MUCvcGDsrpQSCbmU4ZQ98FMIW1ZMGL/mNT9/q6ZFmbwKtkS8wqMG84JkHzZTPEIzU1YBCLpnNTr7+y0Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758491303; c=relaxed/simple;
	bh=n5VEIgBJ1tx/K7qDtE5eY9tByIFi2ZNEuEd3DFHJUQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uMyw+5yXVh1OAC35C1czVEoCtMH0GUUrTz9hWPPbT24/N45BJWVKnDgqq+DAXYowrC2cw65YmgwPYutgW9juOIRIlFtVsha39j4A5jpF+U5o+sJ8NC/pPIQedLVvAgVCL2jJ5BKatDx4nRrwN2UWkOzgvKMzWERvS7O6mr6a5h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=S2OH+Oq1; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id EC33C4E40A1A;
	Sun, 21 Sep 2025 21:48:17 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9EBD460634;
	Sun, 21 Sep 2025 21:48:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4E9F0102F16B6;
	Sun, 21 Sep 2025 23:48:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758491296; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=nDN+Ym8c7sH2R/7tI7o+YzmL4F1zM8tUGpD/GJ+ShwQ=;
	b=S2OH+Oq1zklMOrUbDIki+S10Ft5I2PKC5G4E0fB+7nFALWNZ+o2zGrpt15K9p9T828NkfJ
	HfW1EzSKHif/2am7h1MfYkZnoVsA71uZD2Jz+CWKTSquWxONiRHu01Lz/AqJtCMRvfW4ko
	sYwlj7AKxaWW862F/oHKrgxBnMHuBY1wDZcSjyXZLcb14K3TSxDCzRVzIVupfc9tpx0uEi
	zvmgBbiVskSbSp9k8dBw+4/Rg5tfjhlQhlhv79VOB95U9oY7X3Wj5sS3sRFHshAzZWdpzp
	jo4aA5LMXeIWj5a6NLV2eKvwT2ufbZ4KKiRz68aV6dMBI1pYQV9LE5tbzg8veA==
Date: Sun, 21 Sep 2025 23:48:05 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: kernel test robot <lkp@intel.com>
Cc: Wolfram Sang <wsa-dev@sang-engineering.com>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>
Subject: Re: drivers/i3c/internals.h:54:9: error: passing 'const void *' to
 parameter of type 'void *' discards qualifiers
Message-ID: <202509212148052be5ea9d@mail.local>
References: <202509212320.yCuqvnVn-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202509212320.yCuqvnVn-lkp@intel.com>
X-Last-TLS-Session-Version: TLSv1.3

Hello,

On 21/09/2025 23:54:32+0800, kernel test robot wrote:
> Hi Wolfram,
> 
> FYI, the error/warning still remains.
> 

As replied multiple times, the error is in the sparc64 code, not i3c.

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   f975f08c2e899ae2484407d7bba6bb7f8b6d9d40
> commit: 3b661ca549b9e5bb11d0bc97ada6110aac3282d2 i3c: add missing include to internal header
> date:   8 weeks ago
> config: sparc64-randconfig-001-20250921 (https://download.01.org/0day-ci/archive/20250921/202509212320.yCuqvnVn-lkp@intel.com/config)
> compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 7c861bcedf61607b6c087380ac711eb7ff918ca6)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250921/202509212320.yCuqvnVn-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202509212320.yCuqvnVn-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from drivers/i3c/master.c:21:
> >> drivers/i3c/internals.h:54:9: error: passing 'const void *' to parameter of type 'void *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
>       54 |         readsl(addr, buf, nbytes / 4);
>          |                ^~~~
>    arch/sparc/include/asm/io_64.h:265:41: note: passing argument to parameter 'port' here
>      265 | static inline void readsl(void __iomem *port, void *buf, unsigned long count)
>          |                                         ^
>    1 error generated.
> 
> 
> vim +54 drivers/i3c/internals.h
> 
> 733b439375b494 Jorge Marques 2025-06-24  44  
> 733b439375b494 Jorge Marques 2025-06-24  45  /**
> 733b439375b494 Jorge Marques 2025-06-24  46   * i3c_readl_fifo - Read data buffer from 32bit FIFO
> 733b439375b494 Jorge Marques 2025-06-24  47   * @addr: FIFO Address to read from
> 733b439375b494 Jorge Marques 2025-06-24  48   * @buf: Pointer to the buffer to store read bytes
> 733b439375b494 Jorge Marques 2025-06-24  49   * @nbytes: Number of bytes to read
> 733b439375b494 Jorge Marques 2025-06-24  50   */
> 733b439375b494 Jorge Marques 2025-06-24  51  static inline void i3c_readl_fifo(const void __iomem *addr, void *buf,
> 733b439375b494 Jorge Marques 2025-06-24  52  				  int nbytes)
> 733b439375b494 Jorge Marques 2025-06-24  53  {
> 733b439375b494 Jorge Marques 2025-06-24 @54  	readsl(addr, buf, nbytes / 4);
> 733b439375b494 Jorge Marques 2025-06-24  55  	if (nbytes & 3) {
> 733b439375b494 Jorge Marques 2025-06-24  56  		u32 tmp;
> 733b439375b494 Jorge Marques 2025-06-24  57  
> 733b439375b494 Jorge Marques 2025-06-24  58  		tmp = readl(addr);
> 733b439375b494 Jorge Marques 2025-06-24  59  		memcpy(buf + (nbytes & ~3), &tmp, nbytes & 3);
> 733b439375b494 Jorge Marques 2025-06-24  60  	}
> 733b439375b494 Jorge Marques 2025-06-24  61  }
> 733b439375b494 Jorge Marques 2025-06-24  62  
> 
> :::::: The code at line 54 was first introduced by commit
> :::::: 733b439375b494e8a6950ab47d18a4b615b73cb3 i3c: master: Add inline i3c_readl_fifo() and i3c_writel_fifo()
> 
> :::::: TO: Jorge Marques <jorge.marques@analog.com>
> :::::: CC: Alexandre Belloni <alexandre.belloni@bootlin.com>
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

