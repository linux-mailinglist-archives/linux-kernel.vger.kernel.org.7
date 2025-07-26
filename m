Return-Path: <linux-kernel+bounces-746708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6105B12A3F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 13:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EACFF3BE1E3
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 11:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B81239E8D;
	Sat, 26 Jul 2025 11:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kTOpcGCI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CD524166E
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 11:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753528239; cv=none; b=AEt2wUVuyN/yx298or81Py7o54Ce6kUqVLWmg2n23mNRqeXyymYmS24fa4xIlpsc8H2TU1Pu4y3rdrg5O5VMHop0/bVb+fblZ0/3O2fkJUsio4KYeIV35RC8YOvrzRAzWg7HbDsAHcOiJuYcya7Qy+EmyGGfubjhAyj4rVFrQZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753528239; c=relaxed/simple;
	bh=1eJKzVH1xNgzFodAfOnt69K2oi5Y3VOMwnj7CUL0wWs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=n5tKebak9uVPmCVgGGLrFGOmhyW2C1SRlQpkGw4GXsr8VM/K3G5UhYu2TeIRrLR+X6RCLnePLwIiLXyL+J/p9dlrnUSDYPZhlkHquul0w9EwFJDZemruWqh33BjgkEd1zBnHm/7OcapTTK8KYe4fFyfYNf5sALWeC9o1/IuNaqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kTOpcGCI; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753528237; x=1785064237;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1eJKzVH1xNgzFodAfOnt69K2oi5Y3VOMwnj7CUL0wWs=;
  b=kTOpcGCIZPmtU4ey/DKgN8yKFdFkaJ1XbMFX5isZ1h/M9UdjJKfSKtfH
   ArFB/vjWxGa/SA6fkAIm4FJB3Mj2X47h1QTvtsdCTB7l/RmNp5of3oo+f
   oY2l3yc/UyVAmQwz6SZFHb3TJcKSTlDIBKOe+JtU6/ZJLD5Ch9vPZp1Dx
   CJNcVEu8Lf+plgFQ4nbJayAOJsteVigpVAB0P7U04D9A8zjzR6MvuvINj
   s0bOJmfM6A1lqrRK4hW8ev2P4zdpruu5c5Bt0KOeQ+1SKCVLFWbjYRAFh
   vW9L+9jR+/ihxm4hc1aeeBw5ymLDozQ8P6mMXx/KV2a8uOrh4gRRIY5cJ
   g==;
X-CSE-ConnectionGUID: wCZRVdLnTi6HHKzHXc1pMA==
X-CSE-MsgGUID: 3W2y5Nk0SvmKFXqfzZGNzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11503"; a="55057935"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="55057935"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2025 04:10:32 -0700
X-CSE-ConnectionGUID: +Omy/WDHRMm0H/jy+hn4Pw==
X-CSE-MsgGUID: zeGMuGLUTWKJG62zosM3nA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="192442298"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 26 Jul 2025 04:10:30 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ufcnM-000Lv4-1W;
	Sat, 26 Jul 2025 11:10:28 +0000
Date: Sat, 26 Jul 2025 19:10:13 +0800
From: kernel test robot <lkp@intel.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, Takashi Iwai <tiwai@suse.de>,
	Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
	Jarkko Sakkinen <jarkko@kernel.org>
Subject: include/asm-generic/io.h:773:15: error: call to 'outsw' declared
 with attribute error: outsw() requires HAS_IOPORT
Message-ID: <202507261909.xjSWvFLD-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Niklas,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5f33ebd2018ced2600b3fad2f8e2052498eb4072
commit: 6f043e75744596968b6547c4bd43e4d30bbb6d6e asm-generic/io.h: Remove I/O port accessors for HAS_IOPORT=n
date:   9 months ago
config: m68k-randconfig-r113-20250726 (https://download.01.org/0day-ci/archive/20250726/202507261909.xjSWvFLD-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 8.5.0
reproduce: (https://download.01.org/0day-ci/archive/20250726/202507261909.xjSWvFLD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507261909.xjSWvFLD-lkp@intel.com/

All errors (new ones prefixed by >>):

    #define ei_outb  outb
                     ^~~~
   drivers/net/ethernet/8390/mcf8390.c:141:19: note: in expansion of macro 'ei_outb'
    #define ei_outb_p ei_outb
                      ^~~~~~~
   drivers/net/ethernet/8390/lib8390.c:1067:3: note: in expansion of macro 'ei_outb_p'
      ei_outb_p(E8390_RXCONFIG, e8390_base + EN0_RXCR); /* rx on,  */
      ^~~~~~~~~
   drivers/net/ethernet/8390/mcf8390.c: In function 'mcf8390_block_output':
   include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
    #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
    #define outb _outb
                 ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:132:18: note: in expansion of macro 'outb'
    #define ei_outb  outb
                     ^~~~
   drivers/net/ethernet/8390/mcf8390.c:272:2: note: in expansion of macro 'ei_outb'
     ei_outb(E8390_PAGE0 + E8390_START + E8390_NODMA, addr + NE_CMD);
     ^~~~~~~
   include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
    #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
    #define outb _outb
                 ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:132:18: note: in expansion of macro 'outb'
    #define ei_outb  outb
                     ^~~~
   drivers/net/ethernet/8390/mcf8390.c:274:2: note: in expansion of macro 'ei_outb'
     ei_outb(ENISR_RDC, addr + NE_EN0_ISR);
     ^~~~~~~
   include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
    #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
    #define outb _outb
                 ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:132:18: note: in expansion of macro 'outb'
    #define ei_outb  outb
                     ^~~~
   drivers/net/ethernet/8390/mcf8390.c:277:2: note: in expansion of macro 'ei_outb'
     ei_outb(count & 0xff, addr + NE_EN0_RCNTLO);
     ^~~~~~~
   include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
    #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
    #define outb _outb
                 ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:132:18: note: in expansion of macro 'outb'
    #define ei_outb  outb
                     ^~~~
   drivers/net/ethernet/8390/mcf8390.c:278:2: note: in expansion of macro 'ei_outb'
     ei_outb(count >> 8, addr + NE_EN0_RCNTHI);
     ^~~~~~~
   include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
    #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
    #define outb _outb
                 ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:132:18: note: in expansion of macro 'outb'
    #define ei_outb  outb
                     ^~~~
   drivers/net/ethernet/8390/mcf8390.c:279:2: note: in expansion of macro 'ei_outb'
     ei_outb(0x00, addr + NE_EN0_RSARLO);
     ^~~~~~~
   include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
    #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
    #define outb _outb
                 ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:132:18: note: in expansion of macro 'outb'
    #define ei_outb  outb
                     ^~~~
   drivers/net/ethernet/8390/mcf8390.c:280:2: note: in expansion of macro 'ei_outb'
     ei_outb(start_page, addr + NE_EN0_RSARHI);
     ^~~~~~~
   include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
    #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
    #define outb _outb
                 ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:132:18: note: in expansion of macro 'outb'
    #define ei_outb  outb
                     ^~~~
   drivers/net/ethernet/8390/mcf8390.c:281:2: note: in expansion of macro 'ei_outb'
     ei_outb(E8390_RWRITE + E8390_START, addr + NE_CMD);
     ^~~~~~~
   In file included from arch/m68k/include/asm/io.h:14,
                    from arch/m68k/include/asm/pgtable_no.h:14,
                    from arch/m68k/include/asm/pgtable.h:8,
                    from include/linux/pgtable.h:6,
                    from include/linux/mm.h:30,
                    from arch/m68k/include/asm/cacheflush_no.h:8,
                    from arch/m68k/include/asm/cacheflush.h:3,
                    from include/linux/cacheflush.h:5,
                    from include/linux/highmem.h:8,
                    from include/linux/bvec.h:10,
                    from include/linux/skbuff.h:17,
                    from include/net/net_namespace.h:43,
                    from include/linux/netdevice.h:38,
                    from drivers/net/ethernet/8390/mcf8390.c:15:
>> include/asm-generic/io.h:773:15: error: call to 'outsw' declared with attribute error: outsw() requires HAS_IOPORT
    #define outsw outsw
   drivers/net/ethernet/8390/mcf8390.c:136:18: note: in expansion of macro 'outsw'
    #define ei_outsw outsw
                     ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:283:2: note: in expansion of macro 'ei_outsw'
     ei_outsw(addr + NE_DATAPORT, buf, count >> 1);
     ^~~~~~~~
   In file included from arch/m68k/include/asm/io.h:14,
                    from arch/m68k/include/asm/pgtable_no.h:14,
                    from arch/m68k/include/asm/pgtable.h:8,
                    from include/linux/pgtable.h:6,
                    from include/linux/mm.h:30,
                    from arch/m68k/include/asm/cacheflush_no.h:8,
                    from arch/m68k/include/asm/cacheflush.h:3,
                    from include/linux/cacheflush.h:5,
                    from include/linux/highmem.h:8,
                    from include/linux/bvec.h:10,
                    from include/linux/skbuff.h:17,
                    from include/net/net_namespace.h:43,
                    from include/linux/netdevice.h:38,
                    from drivers/net/ethernet/8390/mcf8390.c:15:
   include/asm-generic/io.h:542:14: error: call to '_inb' declared with attribute error: inb()) requires CONFIG_HAS_IOPORT
    #define _inb _inb
   include/asm-generic/io.h:643:13: note: in expansion of macro '_inb'
    #define inb _inb
                ^~~~
   drivers/net/ethernet/8390/mcf8390.c:131:17: note: in expansion of macro 'inb'
    #define ei_inb  inb
                    ^~~
   drivers/net/ethernet/8390/mcf8390.c:286:10: note: in expansion of macro 'ei_inb'
     while ((ei_inb(addr + NE_EN0_ISR) & ENISR_RDC) == 0) {
             ^~~~~~
   include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
    #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
    #define outb _outb
                 ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:132:18: note: in expansion of macro 'outb'
    #define ei_outb  outb
                     ^~~~
   drivers/net/ethernet/8390/mcf8390.c:295:2: note: in expansion of macro 'ei_outb'
     ei_outb(ENISR_RDC, addr + NE_EN0_ISR); /* Ack intr */
     ^~~~~~~
   In function 'mcf8390_init',
       inlined from 'mcf8390_probe' at drivers/net/ethernet/8390/mcf8390.c:435:8:
   include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
    #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
    #define outb _outb
                 ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:132:18: note: in expansion of macro 'outb'
    #define ei_outb  outb
                     ^~~~
   drivers/net/ethernet/8390/mcf8390.c:355:4: note: in expansion of macro 'ei_outb'
       ei_outb(program_seq[i].value,
       ^~~~~~~
   include/asm-generic/io.h:542:14: error: call to '_inb' declared with attribute error: inb()) requires CONFIG_HAS_IOPORT
    #define _inb _inb
   include/asm-generic/io.h:643:13: note: in expansion of macro '_inb'
    #define inb _inb
                ^~~~
   drivers/net/ethernet/8390/mcf8390.c:131:17: note: in expansion of macro 'inb'
    #define ei_inb  inb
                    ^~~
   drivers/net/ethernet/8390/mcf8390.c:361:16: note: in expansion of macro 'ei_inb'
      SA_prom[i] = ei_inb(addr + NE_DATAPORT);
                   ^~~~~~
   include/asm-generic/io.h:542:14: error: call to '_inb' declared with attribute error: inb()) requires CONFIG_HAS_IOPORT
    #define _inb _inb
   include/asm-generic/io.h:643:13: note: in expansion of macro '_inb'
    #define inb _inb
                ^~~~
   drivers/net/ethernet/8390/mcf8390.c:131:17: note: in expansion of macro 'inb'
    #define ei_inb  inb
                    ^~~
   drivers/net/ethernet/8390/mcf8390.c:362:3: note: in expansion of macro 'ei_inb'
      ei_inb(addr + NE_DATAPORT);
      ^~~~~~
   include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
    #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
    #define outb _outb
                 ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:132:18: note: in expansion of macro 'outb'
    #define ei_outb  outb
                     ^~~~
   drivers/net/ethernet/8390/mcf8390.c:366:2: note: in expansion of macro 'ei_outb'
     ei_outb(0x49, addr + NE_EN0_DCFG);
     ^~~~~~~
   drivers/net/ethernet/8390/lib8390.c: In function '__ei_get_stats':
   include/asm-generic/io.h:542:14: error: call to '_inb' declared with attribute error: inb()) requires CONFIG_HAS_IOPORT
    #define _inb _inb
   include/asm-generic/io.h:643:13: note: in expansion of macro '_inb'
    #define inb _inb
                ^~~~
   drivers/net/ethernet/8390/mcf8390.c:131:17: note: in expansion of macro 'inb'
    #define ei_inb  inb
                    ^~~
   drivers/net/ethernet/8390/mcf8390.c:140:18: note: in expansion of macro 'ei_inb'
    #define ei_inb_p ei_inb
--
    #define inb _inb
                ^~~~
   drivers/net/ethernet/8390/mcf8390.c:131:17: note: in expansion of macro 'inb'
    #define ei_inb  inb
                    ^~~
   drivers/net/ethernet/8390/lib8390.c:267:8: note: in expansion of macro 'ei_inb'
     isr = ei_inb(e8390_base+EN0_ISR);
           ^~~~~~
   drivers/net/ethernet/8390/mcf8390.c: In function 'mcf8390_get_8390_hdr':
   include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
    #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
    #define outb _outb
                 ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:132:18: note: in expansion of macro 'outb'
    #define ei_outb  outb
                     ^~~~
   drivers/net/ethernet/8390/mcf8390.c:201:2: note: in expansion of macro 'ei_outb'
     ei_outb(E8390_NODMA + E8390_PAGE0 + E8390_START, addr + NE_CMD);
     ^~~~~~~
   include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
    #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
    #define outb _outb
                 ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:132:18: note: in expansion of macro 'outb'
    #define ei_outb  outb
                     ^~~~
   drivers/net/ethernet/8390/mcf8390.c:202:2: note: in expansion of macro 'ei_outb'
     ei_outb(ENISR_RDC, addr + NE_EN0_ISR);
     ^~~~~~~
   include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
    #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
    #define outb _outb
                 ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:132:18: note: in expansion of macro 'outb'
    #define ei_outb  outb
                     ^~~~
   drivers/net/ethernet/8390/mcf8390.c:203:2: note: in expansion of macro 'ei_outb'
     ei_outb(sizeof(struct e8390_pkt_hdr), addr + NE_EN0_RCNTLO);
     ^~~~~~~
   include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
    #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
    #define outb _outb
                 ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:132:18: note: in expansion of macro 'outb'
    #define ei_outb  outb
                     ^~~~
   drivers/net/ethernet/8390/mcf8390.c:204:2: note: in expansion of macro 'ei_outb'
     ei_outb(0, addr + NE_EN0_RCNTHI);
     ^~~~~~~
   include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
    #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
    #define outb _outb
                 ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:132:18: note: in expansion of macro 'outb'
    #define ei_outb  outb
                     ^~~~
   drivers/net/ethernet/8390/mcf8390.c:205:2: note: in expansion of macro 'ei_outb'
     ei_outb(0, addr + NE_EN0_RSARLO);  /* On page boundary */
     ^~~~~~~
   include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
    #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
    #define outb _outb
                 ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:132:18: note: in expansion of macro 'outb'
    #define ei_outb  outb
                     ^~~~
   drivers/net/ethernet/8390/mcf8390.c:206:2: note: in expansion of macro 'ei_outb'
     ei_outb(ring_page, addr + NE_EN0_RSARHI);
     ^~~~~~~
   include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
    #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
    #define outb _outb
                 ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:132:18: note: in expansion of macro 'outb'
    #define ei_outb  outb
                     ^~~~
   drivers/net/ethernet/8390/mcf8390.c:207:2: note: in expansion of macro 'ei_outb'
     ei_outb(E8390_RREAD + E8390_START, addr + NE_CMD);
     ^~~~~~~
   In file included from arch/m68k/include/asm/io.h:14,
                    from arch/m68k/include/asm/pgtable_no.h:14,
                    from arch/m68k/include/asm/pgtable.h:8,
                    from include/linux/pgtable.h:6,
                    from include/linux/mm.h:30,
                    from arch/m68k/include/asm/cacheflush_no.h:8,
                    from arch/m68k/include/asm/cacheflush.h:3,
                    from include/linux/cacheflush.h:5,
                    from include/linux/highmem.h:8,
                    from include/linux/bvec.h:10,
                    from include/linux/skbuff.h:17,
                    from include/net/net_namespace.h:43,
                    from include/linux/netdevice.h:38,
                    from drivers/net/ethernet/8390/mcf8390.c:15:
>> include/asm-generic/io.h:733:14: error: call to 'insw' declared with attribute error: insw() requires HAS_IOPORT
    #define insw insw
   drivers/net/ethernet/8390/mcf8390.c:134:18: note: in expansion of macro 'insw'
    #define ei_insw  insw
                     ^~~~
   drivers/net/ethernet/8390/mcf8390.c:209:2: note: in expansion of macro 'ei_insw'
     ei_insw(addr + NE_DATAPORT, hdr, sizeof(struct e8390_pkt_hdr) >> 1);
     ^~~~~~~
   In file included from arch/m68k/include/asm/io.h:14,
                    from arch/m68k/include/asm/pgtable_no.h:14,
                    from arch/m68k/include/asm/pgtable.h:8,
                    from include/linux/pgtable.h:6,
                    from include/linux/mm.h:30,
                    from arch/m68k/include/asm/cacheflush_no.h:8,
                    from arch/m68k/include/asm/cacheflush.h:3,
                    from include/linux/cacheflush.h:5,
                    from include/linux/highmem.h:8,
                    from include/linux/bvec.h:10,
                    from include/linux/skbuff.h:17,
                    from include/net/net_namespace.h:43,
                    from include/linux/netdevice.h:38,
                    from drivers/net/ethernet/8390/mcf8390.c:15:
   include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
    #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
    #define outb _outb
                 ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:211:2: note: in expansion of macro 'outb'
     outb(ENISR_RDC, addr + NE_EN0_ISR); /* Ack intr */
     ^~~~
   drivers/net/ethernet/8390/mcf8390.c: In function 'mcf8390_block_input':
   include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
    #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
    #define outb _outb
                 ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:132:18: note: in expansion of macro 'outb'
    #define ei_outb  outb
                     ^~~~
   drivers/net/ethernet/8390/mcf8390.c:237:2: note: in expansion of macro 'ei_outb'
     ei_outb(E8390_NODMA + E8390_PAGE0 + E8390_START, addr + NE_CMD);
     ^~~~~~~
   include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
    #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
    #define outb _outb
                 ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:132:18: note: in expansion of macro 'outb'
    #define ei_outb  outb
                     ^~~~
   drivers/net/ethernet/8390/mcf8390.c:238:2: note: in expansion of macro 'ei_outb'
     ei_outb(ENISR_RDC, addr + NE_EN0_ISR);
     ^~~~~~~
   include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
    #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
    #define outb _outb
                 ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:132:18: note: in expansion of macro 'outb'
    #define ei_outb  outb
                     ^~~~
   drivers/net/ethernet/8390/mcf8390.c:239:2: note: in expansion of macro 'ei_outb'
     ei_outb(count & 0xff, addr + NE_EN0_RCNTLO);
     ^~~~~~~
   include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
    #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
    #define outb _outb
                 ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:132:18: note: in expansion of macro 'outb'
    #define ei_outb  outb
                     ^~~~
   drivers/net/ethernet/8390/mcf8390.c:240:2: note: in expansion of macro 'ei_outb'
     ei_outb(count >> 8, addr + NE_EN0_RCNTHI);
     ^~~~~~~
   include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
    #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
    #define outb _outb
                 ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:132:18: note: in expansion of macro 'outb'
    #define ei_outb  outb
                     ^~~~
   drivers/net/ethernet/8390/mcf8390.c:241:2: note: in expansion of macro 'ei_outb'
     ei_outb(ring_offset & 0xff, addr + NE_EN0_RSARLO);
     ^~~~~~~
   include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
    #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
    #define outb _outb
                 ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:132:18: note: in expansion of macro 'outb'
    #define ei_outb  outb
                     ^~~~
   drivers/net/ethernet/8390/mcf8390.c:242:2: note: in expansion of macro 'ei_outb'
     ei_outb(ring_offset >> 8, addr + NE_EN0_RSARHI);
     ^~~~~~~
   include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
    #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
    #define outb _outb
                 ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:132:18: note: in expansion of macro 'outb'
    #define ei_outb  outb
                     ^~~~
   drivers/net/ethernet/8390/mcf8390.c:243:2: note: in expansion of macro 'ei_outb'
     ei_outb(E8390_RREAD + E8390_START, addr + NE_CMD);
     ^~~~~~~
   In file included from arch/m68k/include/asm/io.h:14,
                    from arch/m68k/include/asm/pgtable_no.h:14,
                    from arch/m68k/include/asm/pgtable.h:8,
                    from include/linux/pgtable.h:6,
                    from include/linux/mm.h:30,
                    from arch/m68k/include/asm/cacheflush_no.h:8,
                    from arch/m68k/include/asm/cacheflush.h:3,
                    from include/linux/cacheflush.h:5,
                    from include/linux/highmem.h:8,
                    from include/linux/bvec.h:10,
                    from include/linux/skbuff.h:17,
                    from include/net/net_namespace.h:43,
                    from include/linux/netdevice.h:38,
                    from drivers/net/ethernet/8390/mcf8390.c:15:
>> include/asm-generic/io.h:733:14: error: call to 'insw' declared with attribute error: insw() requires HAS_IOPORT
    #define insw insw
   drivers/net/ethernet/8390/mcf8390.c:134:18: note: in expansion of macro 'insw'
    #define ei_insw  insw
                     ^~~~
   drivers/net/ethernet/8390/mcf8390.c:245:2: note: in expansion of macro 'ei_insw'
     ei_insw(addr + NE_DATAPORT, buf, count >> 1);
     ^~~~~~~
   In file included from arch/m68k/include/asm/io.h:14,
                    from arch/m68k/include/asm/pgtable_no.h:14,
                    from arch/m68k/include/asm/pgtable.h:8,
                    from include/linux/pgtable.h:6,
                    from include/linux/mm.h:30,
                    from arch/m68k/include/asm/cacheflush_no.h:8,
                    from arch/m68k/include/asm/cacheflush.h:3,
                    from include/linux/cacheflush.h:5,
                    from include/linux/highmem.h:8,
                    from include/linux/bvec.h:10,
                    from include/linux/skbuff.h:17,
                    from include/net/net_namespace.h:43,
                    from include/linux/netdevice.h:38,
                    from drivers/net/ethernet/8390/mcf8390.c:15:
   include/asm-generic/io.h:542:14: error: call to '_inb' declared with attribute error: inb()) requires CONFIG_HAS_IOPORT
    #define _inb _inb
   include/asm-generic/io.h:643:13: note: in expansion of macro '_inb'
    #define inb _inb
                ^~~~
   drivers/net/ethernet/8390/mcf8390.c:131:17: note: in expansion of macro 'inb'
    #define ei_inb  inb
                    ^~~
   drivers/net/ethernet/8390/mcf8390.c:247:20: note: in expansion of macro 'ei_inb'
      buf[count - 1] = ei_inb(addr + NE_DATAPORT);
                       ^~~~~~
   include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
    #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
    #define outb _outb
                 ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:132:18: note: in expansion of macro 'outb'
    #define ei_outb  outb
                     ^~~~
   drivers/net/ethernet/8390/mcf8390.c:249:2: note: in expansion of macro 'ei_outb'
     ei_outb(ENISR_RDC, addr + NE_EN0_ISR); /* Ack intr */
     ^~~~~~~


vim +/outsw +773 include/asm-generic/io.h

9ab3a7a0d2b417 Thierry Reding  2014-07-04  731  
9ab3a7a0d2b417 Thierry Reding  2014-07-04  732  #ifndef insw
9ab3a7a0d2b417 Thierry Reding  2014-07-04 @733  #define insw insw
6f043e75744596 Niklas Schnelle 2024-10-24  734  #ifdef CONFIG_HAS_IOPORT
9ab3a7a0d2b417 Thierry Reding  2014-07-04  735  static inline void insw(unsigned long addr, void *buffer, unsigned int count)
9ab3a7a0d2b417 Thierry Reding  2014-07-04  736  {
9ab3a7a0d2b417 Thierry Reding  2014-07-04  737  	readsw(PCI_IOBASE + addr, buffer, count);
9ab3a7a0d2b417 Thierry Reding  2014-07-04  738  }
6f043e75744596 Niklas Schnelle 2024-10-24  739  #else
6f043e75744596 Niklas Schnelle 2024-10-24  740  void insw(unsigned long addr, void *buffer, unsigned int count)
6f043e75744596 Niklas Schnelle 2024-10-24  741  	__compiletime_error("insw() requires HAS_IOPORT");
6f043e75744596 Niklas Schnelle 2024-10-24  742  #endif
9ab3a7a0d2b417 Thierry Reding  2014-07-04  743  #endif
9ab3a7a0d2b417 Thierry Reding  2014-07-04  744  
9ab3a7a0d2b417 Thierry Reding  2014-07-04  745  #ifndef insl
9ab3a7a0d2b417 Thierry Reding  2014-07-04  746  #define insl insl
6f043e75744596 Niklas Schnelle 2024-10-24  747  #ifdef CONFIG_HAS_IOPORT
9ab3a7a0d2b417 Thierry Reding  2014-07-04  748  static inline void insl(unsigned long addr, void *buffer, unsigned int count)
9ab3a7a0d2b417 Thierry Reding  2014-07-04  749  {
9ab3a7a0d2b417 Thierry Reding  2014-07-04  750  	readsl(PCI_IOBASE + addr, buffer, count);
9ab3a7a0d2b417 Thierry Reding  2014-07-04  751  }
6f043e75744596 Niklas Schnelle 2024-10-24  752  #else
6f043e75744596 Niklas Schnelle 2024-10-24  753  void insl(unsigned long addr, void *buffer, unsigned int count)
6f043e75744596 Niklas Schnelle 2024-10-24  754  	__compiletime_error("insl() requires HAS_IOPORT");
6f043e75744596 Niklas Schnelle 2024-10-24  755  #endif
9ab3a7a0d2b417 Thierry Reding  2014-07-04  756  #endif
9ab3a7a0d2b417 Thierry Reding  2014-07-04  757  
9ab3a7a0d2b417 Thierry Reding  2014-07-04  758  #ifndef outsb
9ab3a7a0d2b417 Thierry Reding  2014-07-04  759  #define outsb outsb
6f043e75744596 Niklas Schnelle 2024-10-24  760  #ifdef CONFIG_HAS_IOPORT
9ab3a7a0d2b417 Thierry Reding  2014-07-04  761  static inline void outsb(unsigned long addr, const void *buffer,
9ab3a7a0d2b417 Thierry Reding  2014-07-04  762  			 unsigned int count)
9ab3a7a0d2b417 Thierry Reding  2014-07-04  763  {
9ab3a7a0d2b417 Thierry Reding  2014-07-04  764  	writesb(PCI_IOBASE + addr, buffer, count);
9ab3a7a0d2b417 Thierry Reding  2014-07-04  765  }
6f043e75744596 Niklas Schnelle 2024-10-24  766  #else
6f043e75744596 Niklas Schnelle 2024-10-24  767  void outsb(unsigned long addr, const void *buffer, unsigned int count)
6f043e75744596 Niklas Schnelle 2024-10-24  768  	__compiletime_error("outsb() requires HAS_IOPORT");
6f043e75744596 Niklas Schnelle 2024-10-24  769  #endif
9ab3a7a0d2b417 Thierry Reding  2014-07-04  770  #endif
9ab3a7a0d2b417 Thierry Reding  2014-07-04  771  
9ab3a7a0d2b417 Thierry Reding  2014-07-04  772  #ifndef outsw
9ab3a7a0d2b417 Thierry Reding  2014-07-04 @773  #define outsw outsw
6f043e75744596 Niklas Schnelle 2024-10-24  774  #ifdef CONFIG_HAS_IOPORT
9ab3a7a0d2b417 Thierry Reding  2014-07-04  775  static inline void outsw(unsigned long addr, const void *buffer,
9ab3a7a0d2b417 Thierry Reding  2014-07-04  776  			 unsigned int count)
9ab3a7a0d2b417 Thierry Reding  2014-07-04  777  {
9ab3a7a0d2b417 Thierry Reding  2014-07-04  778  	writesw(PCI_IOBASE + addr, buffer, count);
9ab3a7a0d2b417 Thierry Reding  2014-07-04  779  }
6f043e75744596 Niklas Schnelle 2024-10-24  780  #else
6f043e75744596 Niklas Schnelle 2024-10-24  781  void outsw(unsigned long addr, const void *buffer, unsigned int count)
6f043e75744596 Niklas Schnelle 2024-10-24  782  	__compiletime_error("outsw() requires HAS_IOPORT");
6f043e75744596 Niklas Schnelle 2024-10-24  783  #endif
9ab3a7a0d2b417 Thierry Reding  2014-07-04  784  #endif
9ab3a7a0d2b417 Thierry Reding  2014-07-04  785  

:::::: The code at line 773 was first introduced by commit
:::::: 9ab3a7a0d2b417773e8e8a880fc3a69f7fc1f57a asm-generic/io.h: Implement generic {read,write}s*()

:::::: TO: Thierry Reding <treding@nvidia.com>
:::::: CC: Thierry Reding <treding@nvidia.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

