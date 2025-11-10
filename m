Return-Path: <linux-kernel+bounces-894287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A93BC49ADF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 00:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8CC3188A69F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 23:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D8C246788;
	Mon, 10 Nov 2025 23:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hZ1hYlCe"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B009C883F
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 23:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762815656; cv=none; b=pTczkkZfuNcJPybrT1vOT86JdwpCG1KXRpkUqeC41W//1+iXbjlX1y7+UpZIyQJ0eeyWSxlYTJs3q0v8j+0tLaTTrwWELqNdcYy/7oC5w52t2M8qTpzzaZniezsMtXzZKu1rDRlWlr/n4MpdQQWUW8nJcEdJ23E1SZFTM9cvgi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762815656; c=relaxed/simple;
	bh=AsQ4Qh6rl8oV34QDJugDwweMhSxWKlo7A+X44Wrrjj0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fwYqqllCeN9jdqMlAd9b+cW4pBHeQE/v3s7BsS/kYpyqVREGTYZOStYrUreEYlMO4qHvAKuMN+q3bw7/Y6pKVv5doAjiKZkqoeHIlZHdWryIJX4iokMR7nC1oYjoIHY5wgChnfcIEvz6wC/W/4ofULvkkjLuGeOrdhnQTtwx/48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hZ1hYlCe; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762815653; x=1794351653;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=AsQ4Qh6rl8oV34QDJugDwweMhSxWKlo7A+X44Wrrjj0=;
  b=hZ1hYlCe4YTHkZ1JbYEa8XpnnfHO6eU29F50XL+1VErVJ6lweVHOyWmL
   b6UA0UCn2KKPuO+xFQ+UgwcHoqwVty6bx0QASNonI5tK6iwHRgYlnO9Xk
   ad6u0DcbTs9yoj3/maKKQIV6LuQrGLRghQEfl2OKk5AnhDPrC2117bJET
   6NM9mNruQEUB81dkUjwlDZDALu2ee5XrbS/+PzT8hExGD0WCyDiWz0cnH
   nyL14nbF+PxLwV+Ff9AbJWiDl63cTxuvp6plG0WSXRO1znG8paSLkHEth
   NOun/G8bhjtDGEjYiLiwBUgyFaMyGYMfEFfSq5k1hDlYU/Q9eVPsMX/GM
   g==;
X-CSE-ConnectionGUID: sWYSaTctSoamGBSd/0IDSQ==
X-CSE-MsgGUID: pEOl7qgcRC2w3pMU53H2Vw==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="76325526"
X-IronPort-AV: E=Sophos;i="6.19,294,1754982000"; 
   d="scan'208";a="76325526"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 15:00:53 -0800
X-CSE-ConnectionGUID: S2yKOcW3T7+i96IMJphQdw==
X-CSE-MsgGUID: sNA4+7HBQ2yHKYX/MHuplg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,294,1754982000"; 
   d="scan'208";a="219451783"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 10 Nov 2025 15:00:51 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vIasS-00017T-1m;
	Mon, 10 Nov 2025 23:00:48 +0000
Date: Tue, 11 Nov 2025 07:00:40 +0800
From: kernel test robot <lkp@intel.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, Takashi Iwai <tiwai@suse.de>,
	Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
	Jarkko Sakkinen <jarkko@kernel.org>
Subject: include/asm-generic/io.h:542:14: error: call to '_inb' declared with
 attribute error: inb()) requires CONFIG_HAS_IOPORT
Message-ID: <202511110659.0E0b38nM-lkp@intel.com>
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
head:   4ea7c1717f3f2344f7a1cdab4f5875cfa89c87a9
commit: 6f043e75744596968b6547c4bd43e4d30bbb6d6e asm-generic/io.h: Remove I/O port accessors for HAS_IOPORT=n
date:   1 year ago
config: m68k-randconfig-r054-20251111 (https://download.01.org/0day-ci/archive/20251111/202511110659.0E0b38nM-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251111/202511110659.0E0b38nM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511110659.0E0b38nM-lkp@intel.com/

All errors (new ones prefixed by >>):

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
   drivers/net/ethernet/8390/lib8390.c: In function '__ei_get_stats':
>> include/asm-generic/io.h:542:14: error: call to '_inb' declared with attribute error: inb()) requires CONFIG_HAS_IOPORT
    #define _inb _inb
   include/asm-generic/io.h:643:13: note: in expansion of macro '_inb'
    #define inb _inb
                ^~~~
   drivers/net/ethernet/8390/mcf8390.c:131:17: note: in expansion of macro 'inb'
    #define ei_inb  inb
                    ^~~
   drivers/net/ethernet/8390/mcf8390.c:140:18: note: in expansion of macro 'ei_inb'
    #define ei_inb_p ei_inb
                     ^~~~~~
   drivers/net/ethernet/8390/lib8390.c:868:33: note: in expansion of macro 'ei_inb_p'
     dev->stats.rx_frame_errors  += ei_inb_p(ioaddr + EN0_COUNTER0);
                                    ^~~~~~~~
>> include/asm-generic/io.h:542:14: error: call to '_inb' declared with attribute error: inb()) requires CONFIG_HAS_IOPORT
    #define _inb _inb
   include/asm-generic/io.h:643:13: note: in expansion of macro '_inb'
    #define inb _inb
                ^~~~
   drivers/net/ethernet/8390/mcf8390.c:131:17: note: in expansion of macro 'inb'
    #define ei_inb  inb
                    ^~~
   drivers/net/ethernet/8390/mcf8390.c:140:18: note: in expansion of macro 'ei_inb'
    #define ei_inb_p ei_inb
                     ^~~~~~
   drivers/net/ethernet/8390/lib8390.c:869:33: note: in expansion of macro 'ei_inb_p'
     dev->stats.rx_crc_errors    += ei_inb_p(ioaddr + EN0_COUNTER1);
                                    ^~~~~~~~
>> include/asm-generic/io.h:542:14: error: call to '_inb' declared with attribute error: inb()) requires CONFIG_HAS_IOPORT
    #define _inb _inb
   include/asm-generic/io.h:643:13: note: in expansion of macro '_inb'
    #define inb _inb
                ^~~~
   drivers/net/ethernet/8390/mcf8390.c:131:17: note: in expansion of macro 'inb'
    #define ei_inb  inb
                    ^~~
   drivers/net/ethernet/8390/mcf8390.c:140:18: note: in expansion of macro 'ei_inb'
    #define ei_inb_p ei_inb
                     ^~~~~~
   drivers/net/ethernet/8390/lib8390.c:870:33: note: in expansion of macro 'ei_inb_p'
     dev->stats.rx_missed_errors += ei_inb_p(ioaddr + EN0_COUNTER2);
                                    ^~~~~~~~
   drivers/net/ethernet/8390/lib8390.c: In function 'NS8390_trigger_send':
>> include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
    #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
    #define outb _outb
                 ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:132:18: note: in expansion of macro 'outb'
    #define ei_outb  outb
                     ^~~~
   drivers/net/ethernet/8390/mcf8390.c:141:19: note: in expansion of macro 'ei_outb'
    #define ei_outb_p ei_outb
                      ^~~~~~~
   drivers/net/ethernet/8390/lib8390.c:1081:2: note: in expansion of macro 'ei_outb_p'
     ei_outb_p(E8390_NODMA+E8390_PAGE0, e8390_base+E8390_CMD);
     ^~~~~~~~~
>> include/asm-generic/io.h:542:14: error: call to '_inb' declared with attribute error: inb()) requires CONFIG_HAS_IOPORT
    #define _inb _inb
   include/asm-generic/io.h:643:13: note: in expansion of macro '_inb'
    #define inb _inb
                ^~~~
   drivers/net/ethernet/8390/mcf8390.c:131:17: note: in expansion of macro 'inb'
    #define ei_inb  inb
                    ^~~
   drivers/net/ethernet/8390/mcf8390.c:140:18: note: in expansion of macro 'ei_inb'
    #define ei_inb_p ei_inb
                     ^~~~~~
   drivers/net/ethernet/8390/lib8390.c:1083:6: note: in expansion of macro 'ei_inb_p'
     if (ei_inb_p(e8390_base + E8390_CMD) & E8390_TRANS) {
         ^~~~~~~~
>> include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
    #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
    #define outb _outb
                 ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:132:18: note: in expansion of macro 'outb'
    #define ei_outb  outb
                     ^~~~
   drivers/net/ethernet/8390/mcf8390.c:141:19: note: in expansion of macro 'ei_outb'
    #define ei_outb_p ei_outb
                      ^~~~~~~
   drivers/net/ethernet/8390/lib8390.c:1087:2: note: in expansion of macro 'ei_outb_p'
     ei_outb_p(length & 0xff, e8390_base + EN0_TCNTLO);
     ^~~~~~~~~
>> include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
    #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
    #define outb _outb
                 ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:132:18: note: in expansion of macro 'outb'
    #define ei_outb  outb
                     ^~~~
   drivers/net/ethernet/8390/mcf8390.c:141:19: note: in expansion of macro 'ei_outb'
    #define ei_outb_p ei_outb
                      ^~~~~~~
   drivers/net/ethernet/8390/lib8390.c:1088:2: note: in expansion of macro 'ei_outb_p'
     ei_outb_p(length >> 8, e8390_base + EN0_TCNTHI);
     ^~~~~~~~~
>> include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
    #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
    #define outb _outb
                 ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:132:18: note: in expansion of macro 'outb'
    #define ei_outb  outb
                     ^~~~
   drivers/net/ethernet/8390/mcf8390.c:141:19: note: in expansion of macro 'ei_outb'
    #define ei_outb_p ei_outb
                      ^~~~~~~
   drivers/net/ethernet/8390/lib8390.c:1089:2: note: in expansion of macro 'ei_outb_p'
     ei_outb_p(start_page, e8390_base + EN0_TPSR);
     ^~~~~~~~~
>> include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
    #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
    #define outb _outb
                 ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:132:18: note: in expansion of macro 'outb'
    #define ei_outb  outb
                     ^~~~
   drivers/net/ethernet/8390/mcf8390.c:141:19: note: in expansion of macro 'ei_outb'
    #define ei_outb_p ei_outb
                      ^~~~~~~
   drivers/net/ethernet/8390/lib8390.c:1090:2: note: in expansion of macro 'ei_outb_p'
     ei_outb_p(E8390_NODMA+E8390_TRANS+E8390_START, e8390_base+E8390_CMD);
     ^~~~~~~~~
   drivers/net/ethernet/8390/mcf8390.c: In function 'mcf8390_reset_8390':
>> include/asm-generic/io.h:542:14: error: call to '_inb' declared with attribute error: inb()) requires CONFIG_HAS_IOPORT
    #define _inb _inb
   include/asm-generic/io.h:643:13: note: in expansion of macro '_inb'
    #define inb _inb
                ^~~~
   drivers/net/ethernet/8390/mcf8390.c:131:17: note: in expansion of macro 'inb'
    #define ei_inb  inb
                    ^~~
   drivers/net/ethernet/8390/mcf8390.c:157:10: note: in expansion of macro 'ei_inb'
     ei_outb(ei_inb(addr + NE_RESET), addr + NE_RESET);
             ^~~~~~
>> include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
    #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
    #define outb _outb
                 ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:132:18: note: in expansion of macro 'outb'
    #define ei_outb  outb
                     ^~~~
   drivers/net/ethernet/8390/mcf8390.c:157:2: note: in expansion of macro 'ei_outb'
     ei_outb(ei_inb(addr + NE_RESET), addr + NE_RESET);
     ^~~~~~~
>> include/asm-generic/io.h:542:14: error: call to '_inb' declared with attribute error: inb()) requires CONFIG_HAS_IOPORT
    #define _inb _inb
   include/asm-generic/io.h:643:13: note: in expansion of macro '_inb'
    #define inb _inb
                ^~~~
   drivers/net/ethernet/8390/mcf8390.c:131:17: note: in expansion of macro 'inb'
    #define ei_inb  inb
                    ^~~
   drivers/net/ethernet/8390/mcf8390.c:163:10: note: in expansion of macro 'ei_inb'
     while ((ei_inb(addr + NE_EN0_ISR) & ENISR_RESET) == 0) {
             ^~~~~~
>> include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
    #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
    #define outb _outb
                 ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:132:18: note: in expansion of macro 'outb'
    #define ei_outb  outb
                     ^~~~
   drivers/net/ethernet/8390/mcf8390.c:170:2: note: in expansion of macro 'ei_outb'
     ei_outb(ENISR_RESET, addr + NE_EN0_ISR);
     ^~~~~~~
   drivers/net/ethernet/8390/lib8390.c: In function '__ei_start_xmit':
>> include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
    #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
    #define outb _outb
                 ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:132:18: note: in expansion of macro 'outb'
    #define ei_outb  outb
                     ^~~~
   drivers/net/ethernet/8390/mcf8390.c:141:19: note: in expansion of macro 'ei_outb'
    #define ei_outb_p ei_outb
                      ^~~~~~~
   drivers/net/ethernet/8390/lib8390.c:325:2: note: in expansion of macro 'ei_outb_p'
     ei_outb_p(0x00, e8390_base + EN0_IMR);
     ^~~~~~~~~
>> include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
    #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
    #define outb _outb
                 ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:132:18: note: in expansion of macro 'outb'
    #define ei_outb  outb
                     ^~~~
   drivers/net/ethernet/8390/mcf8390.c:141:19: note: in expansion of macro 'ei_outb'
    #define ei_outb_p ei_outb
                      ^~~~~~~
   drivers/net/ethernet/8390/lib8390.c:369:3: note: in expansion of macro 'ei_outb_p'
      ei_outb_p(ENISR_ALL, e8390_base + EN0_IMR);
      ^~~~~~~~~
>> include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
    #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
    #define outb _outb
                 ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:132:18: note: in expansion of macro 'outb'
    #define ei_outb  outb
                     ^~~~
   drivers/net/ethernet/8390/mcf8390.c:141:19: note: in expansion of macro 'ei_outb'
    #define ei_outb_p ei_outb
                      ^~~~~~~
   drivers/net/ethernet/8390/lib8390.c:404:2: note: in expansion of macro 'ei_outb_p'
     ei_outb_p(ENISR_ALL, e8390_base + EN0_IMR);
     ^~~~~~~~~
   drivers/net/ethernet/8390/lib8390.c: In function 'ei_receive':
>> include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
    #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
    #define outb _outb
                 ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:132:18: note: in expansion of macro 'outb'
    #define ei_outb  outb
                     ^~~~
   drivers/net/ethernet/8390/mcf8390.c:141:19: note: in expansion of macro 'ei_outb'
    #define ei_outb_p ei_outb
                      ^~~~~~~
   drivers/net/ethernet/8390/lib8390.c:673:3: note: in expansion of macro 'ei_outb_p'
      ei_outb_p(E8390_NODMA+E8390_PAGE1, e8390_base + E8390_CMD);
      ^~~~~~~~~
>> include/asm-generic/io.h:542:14: error: call to '_inb' declared with attribute error: inb()) requires CONFIG_HAS_IOPORT
    #define _inb _inb
   include/asm-generic/io.h:643:13: note: in expansion of macro '_inb'
    #define inb _inb
                ^~~~
   drivers/net/ethernet/8390/mcf8390.c:131:17: note: in expansion of macro 'inb'
    #define ei_inb  inb
                    ^~~
   drivers/net/ethernet/8390/mcf8390.c:140:18: note: in expansion of macro 'ei_inb'
    #define ei_inb_p ei_inb
                     ^~~~~~
   drivers/net/ethernet/8390/lib8390.c:674:16: note: in expansion of macro 'ei_inb_p'
      rxing_page = ei_inb_p(e8390_base + EN1_CURPAG);
                   ^~~~~~~~
>> include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
    #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
    #define outb _outb
                 ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:132:18: note: in expansion of macro 'outb'
    #define ei_outb  outb
                     ^~~~
   drivers/net/ethernet/8390/mcf8390.c:141:19: note: in expansion of macro 'ei_outb'
    #define ei_outb_p ei_outb
                      ^~~~~~~
   drivers/net/ethernet/8390/lib8390.c:675:3: note: in expansion of macro 'ei_outb_p'
      ei_outb_p(E8390_NODMA+E8390_PAGE0, e8390_base + E8390_CMD);
      ^~~~~~~~~
>> include/asm-generic/io.h:542:14: error: call to '_inb' declared with attribute error: inb()) requires CONFIG_HAS_IOPORT
    #define _inb _inb
   include/asm-generic/io.h:643:13: note: in expansion of macro '_inb'
    #define inb _inb
                ^~~~
   drivers/net/ethernet/8390/mcf8390.c:131:17: note: in expansion of macro 'inb'
    #define ei_inb  inb
                    ^~~
   drivers/net/ethernet/8390/mcf8390.c:140:18: note: in expansion of macro 'ei_inb'
    #define ei_inb_p ei_inb
                     ^~~~~~
   drivers/net/ethernet/8390/lib8390.c:678:16: note: in expansion of macro 'ei_inb_p'
      this_frame = ei_inb_p(e8390_base + EN0_BOUNDARY) + 1;
                   ^~~~~~~~
   include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
    #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
    #define outb _outb
                 ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:132:18: note: in expansion of macro 'outb'
    #define ei_outb  outb
                     ^~~~
   drivers/net/ethernet/8390/lib8390.c:714:4: note: in expansion of macro 'ei_outb'
       ei_outb(ei_local->current_page-1, e8390_base+EN0_BOUNDARY);
       ^~~~~~~
   include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
    #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
    #define outb _outb
                 ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:132:18: note: in expansion of macro 'outb'
    #define ei_outb  outb
                     ^~~~
   drivers/net/ethernet/8390/mcf8390.c:141:19: note: in expansion of macro 'ei_outb'
    #define ei_outb_p ei_outb
                      ^~~~~~~
   drivers/net/ethernet/8390/lib8390.c:767:3: note: in expansion of macro 'ei_outb_p'
      ei_outb_p(next_frame-1, e8390_base+EN0_BOUNDARY);
      ^~~~~~~~~
   include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
    #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
    #define outb _outb
                 ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:132:18: note: in expansion of macro 'outb'
    #define ei_outb  outb
                     ^~~~
   drivers/net/ethernet/8390/mcf8390.c:141:19: note: in expansion of macro 'ei_outb'
    #define ei_outb_p ei_outb
                      ^~~~~~~
   drivers/net/ethernet/8390/lib8390.c:772:2: note: in expansion of macro 'ei_outb_p'
     ei_outb_p(ENISR_RX+ENISR_RX_ERR, e8390_base+EN0_ISR);
     ^~~~~~~~~
   drivers/net/ethernet/8390/lib8390.c: In function 'do_set_multicast_list':
   include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
    #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
    #define outb _outb
                 ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:132:18: note: in expansion of macro 'outb'
    #define ei_outb  outb
                     ^~~~
   drivers/net/ethernet/8390/mcf8390.c:141:19: note: in expansion of macro 'ei_outb'
    #define ei_outb_p ei_outb
                      ^~~~~~~
   drivers/net/ethernet/8390/lib8390.c:930:3: note: in expansion of macro 'ei_outb_p'
      ei_outb_p(E8390_RXCONFIG, e8390_base + EN0_RXCR);
      ^~~~~~~~~
   include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
    #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
    #define outb _outb
                 ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:132:18: note: in expansion of macro 'outb'
    #define ei_outb  outb
                     ^~~~
   drivers/net/ethernet/8390/mcf8390.c:141:19: note: in expansion of macro 'ei_outb'
    #define ei_outb_p ei_outb
                      ^~~~~~~
   drivers/net/ethernet/8390/lib8390.c:931:2: note: in expansion of macro 'ei_outb_p'
     ei_outb_p(E8390_NODMA + E8390_PAGE1, e8390_base + E8390_CMD);
     ^~~~~~~~~
   include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
    #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
    #define outb _outb
                 ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:132:18: note: in expansion of macro 'outb'
    #define ei_outb  outb
                     ^~~~
   drivers/net/ethernet/8390/mcf8390.c:141:19: note: in expansion of macro 'ei_outb'
    #define ei_outb_p ei_outb
                      ^~~~~~~
   drivers/net/ethernet/8390/lib8390.c:933:3: note: in expansion of macro 'ei_outb_p'
      ei_outb_p(ei_local->mcfilter[i], e8390_base + EN1_MULT_SHIFT(i));
      ^~~~~~~~~
   include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
    #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
    #define outb _outb
                 ^~~~~


vim +/_inb +542 include/asm-generic/io.h

3f7e212df82ca0 Arnd Bergmann   2009-05-13  534  
9216efafc52ff9 Thierry Reding  2014-10-01  535  /*
9216efafc52ff9 Thierry Reding  2014-10-01  536   * {in,out}{b,w,l}() access little endian I/O. {in,out}{b,w,l}_p() can be
9216efafc52ff9 Thierry Reding  2014-10-01  537   * implemented on hardware that needs an additional delay for I/O accesses to
9216efafc52ff9 Thierry Reding  2014-10-01  538   * take effect.
9216efafc52ff9 Thierry Reding  2014-10-01  539   */
9216efafc52ff9 Thierry Reding  2014-10-01  540  
f009c89df79abe John Garry      2020-03-28  541  #if !defined(inb) && !defined(_inb)
f009c89df79abe John Garry      2020-03-28 @542  #define _inb _inb
6f043e75744596 Niklas Schnelle 2024-10-24  543  #ifdef CONFIG_HAS_IOPORT
214ba3584b2e2c Stafford Horne  2020-07-26  544  static inline u8 _inb(unsigned long addr)
9216efafc52ff9 Thierry Reding  2014-10-01  545  {
87fe2d543f8173 Sinan Kaya      2018-04-05  546  	u8 val;
87fe2d543f8173 Sinan Kaya      2018-04-05  547  
87fe2d543f8173 Sinan Kaya      2018-04-05  548  	__io_pbr();
87fe2d543f8173 Sinan Kaya      2018-04-05  549  	val = __raw_readb(PCI_IOBASE + addr);
abbbbc83a210e9 Will Deacon     2019-02-22  550  	__io_par(val);
87fe2d543f8173 Sinan Kaya      2018-04-05  551  	return val;
9216efafc52ff9 Thierry Reding  2014-10-01  552  }
6f043e75744596 Niklas Schnelle 2024-10-24  553  #else
6f043e75744596 Niklas Schnelle 2024-10-24  554  u8 _inb(unsigned long addr)
6f043e75744596 Niklas Schnelle 2024-10-24  555  	__compiletime_error("inb()) requires CONFIG_HAS_IOPORT");
6f043e75744596 Niklas Schnelle 2024-10-24  556  #endif
9216efafc52ff9 Thierry Reding  2014-10-01  557  #endif
9216efafc52ff9 Thierry Reding  2014-10-01  558  
f009c89df79abe John Garry      2020-03-28  559  #if !defined(inw) && !defined(_inw)
f009c89df79abe John Garry      2020-03-28  560  #define _inw _inw
6f043e75744596 Niklas Schnelle 2024-10-24  561  #ifdef CONFIG_HAS_IOPORT
f009c89df79abe John Garry      2020-03-28  562  static inline u16 _inw(unsigned long addr)
9216efafc52ff9 Thierry Reding  2014-10-01  563  {
87fe2d543f8173 Sinan Kaya      2018-04-05  564  	u16 val;
87fe2d543f8173 Sinan Kaya      2018-04-05  565  
87fe2d543f8173 Sinan Kaya      2018-04-05  566  	__io_pbr();
c1d55d50139bea Stafford Horne  2020-07-29  567  	val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
abbbbc83a210e9 Will Deacon     2019-02-22  568  	__io_par(val);
87fe2d543f8173 Sinan Kaya      2018-04-05  569  	return val;
9216efafc52ff9 Thierry Reding  2014-10-01  570  }
6f043e75744596 Niklas Schnelle 2024-10-24  571  #else
6f043e75744596 Niklas Schnelle 2024-10-24  572  u16 _inw(unsigned long addr)
6f043e75744596 Niklas Schnelle 2024-10-24  573  	__compiletime_error("inw() requires CONFIG_HAS_IOPORT");
6f043e75744596 Niklas Schnelle 2024-10-24  574  #endif
9216efafc52ff9 Thierry Reding  2014-10-01  575  #endif
9216efafc52ff9 Thierry Reding  2014-10-01  576  
f009c89df79abe John Garry      2020-03-28  577  #if !defined(inl) && !defined(_inl)
f009c89df79abe John Garry      2020-03-28  578  #define _inl _inl
6f043e75744596 Niklas Schnelle 2024-10-24  579  #ifdef CONFIG_HAS_IOPORT
214ba3584b2e2c Stafford Horne  2020-07-26  580  static inline u32 _inl(unsigned long addr)
9216efafc52ff9 Thierry Reding  2014-10-01  581  {
87fe2d543f8173 Sinan Kaya      2018-04-05  582  	u32 val;
87fe2d543f8173 Sinan Kaya      2018-04-05  583  
87fe2d543f8173 Sinan Kaya      2018-04-05  584  	__io_pbr();
c1d55d50139bea Stafford Horne  2020-07-29  585  	val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
abbbbc83a210e9 Will Deacon     2019-02-22  586  	__io_par(val);
87fe2d543f8173 Sinan Kaya      2018-04-05  587  	return val;
9216efafc52ff9 Thierry Reding  2014-10-01  588  }
6f043e75744596 Niklas Schnelle 2024-10-24  589  #else
6f043e75744596 Niklas Schnelle 2024-10-24  590  u32 _inl(unsigned long addr)
6f043e75744596 Niklas Schnelle 2024-10-24  591  	__compiletime_error("inl() requires CONFIG_HAS_IOPORT");
6f043e75744596 Niklas Schnelle 2024-10-24  592  #endif
9216efafc52ff9 Thierry Reding  2014-10-01  593  #endif
9216efafc52ff9 Thierry Reding  2014-10-01  594  
f009c89df79abe John Garry      2020-03-28  595  #if !defined(outb) && !defined(_outb)
f009c89df79abe John Garry      2020-03-28 @596  #define _outb _outb
6f043e75744596 Niklas Schnelle 2024-10-24  597  #ifdef CONFIG_HAS_IOPORT
f009c89df79abe John Garry      2020-03-28  598  static inline void _outb(u8 value, unsigned long addr)
9216efafc52ff9 Thierry Reding  2014-10-01  599  {
a7851aa54c0cdd Sinan Kaya      2018-04-05  600  	__io_pbw();
a7851aa54c0cdd Sinan Kaya      2018-04-05  601  	__raw_writeb(value, PCI_IOBASE + addr);
a7851aa54c0cdd Sinan Kaya      2018-04-05  602  	__io_paw();
9216efafc52ff9 Thierry Reding  2014-10-01  603  }
6f043e75744596 Niklas Schnelle 2024-10-24  604  #else
6f043e75744596 Niklas Schnelle 2024-10-24  605  void _outb(u8 value, unsigned long addr)
6f043e75744596 Niklas Schnelle 2024-10-24  606  	__compiletime_error("outb() requires CONFIG_HAS_IOPORT");
6f043e75744596 Niklas Schnelle 2024-10-24  607  #endif
9216efafc52ff9 Thierry Reding  2014-10-01  608  #endif
9216efafc52ff9 Thierry Reding  2014-10-01  609  
f009c89df79abe John Garry      2020-03-28  610  #if !defined(outw) && !defined(_outw)
f009c89df79abe John Garry      2020-03-28  611  #define _outw _outw
6f043e75744596 Niklas Schnelle 2024-10-24  612  #ifdef CONFIG_HAS_IOPORT
f009c89df79abe John Garry      2020-03-28  613  static inline void _outw(u16 value, unsigned long addr)
9216efafc52ff9 Thierry Reding  2014-10-01  614  {
a7851aa54c0cdd Sinan Kaya      2018-04-05  615  	__io_pbw();
c1d55d50139bea Stafford Horne  2020-07-29  616  	__raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
a7851aa54c0cdd Sinan Kaya      2018-04-05  617  	__io_paw();
9216efafc52ff9 Thierry Reding  2014-10-01  618  }
6f043e75744596 Niklas Schnelle 2024-10-24  619  #else
6f043e75744596 Niklas Schnelle 2024-10-24  620  void _outw(u16 value, unsigned long addr)
6f043e75744596 Niklas Schnelle 2024-10-24  621  	__compiletime_error("outw() requires CONFIG_HAS_IOPORT");
6f043e75744596 Niklas Schnelle 2024-10-24  622  #endif
9216efafc52ff9 Thierry Reding  2014-10-01  623  #endif
9216efafc52ff9 Thierry Reding  2014-10-01  624  
f009c89df79abe John Garry      2020-03-28  625  #if !defined(outl) && !defined(_outl)
f009c89df79abe John Garry      2020-03-28  626  #define _outl _outl
6f043e75744596 Niklas Schnelle 2024-10-24  627  #ifdef CONFIG_HAS_IOPORT
f009c89df79abe John Garry      2020-03-28  628  static inline void _outl(u32 value, unsigned long addr)
9216efafc52ff9 Thierry Reding  2014-10-01  629  {
a7851aa54c0cdd Sinan Kaya      2018-04-05  630  	__io_pbw();
c1d55d50139bea Stafford Horne  2020-07-29  631  	__raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
a7851aa54c0cdd Sinan Kaya      2018-04-05  632  	__io_paw();
9216efafc52ff9 Thierry Reding  2014-10-01  633  }
6f043e75744596 Niklas Schnelle 2024-10-24  634  #else
6f043e75744596 Niklas Schnelle 2024-10-24  635  void _outl(u32 value, unsigned long addr)
6f043e75744596 Niklas Schnelle 2024-10-24  636  	__compiletime_error("outl() requires CONFIG_HAS_IOPORT");
6f043e75744596 Niklas Schnelle 2024-10-24  637  #endif
9216efafc52ff9 Thierry Reding  2014-10-01  638  #endif
9216efafc52ff9 Thierry Reding  2014-10-01  639  
f009c89df79abe John Garry      2020-03-28  640  #include <linux/logic_pio.h>
f009c89df79abe John Garry      2020-03-28  641  
f009c89df79abe John Garry      2020-03-28  642  #ifndef inb
f009c89df79abe John Garry      2020-03-28  643  #define inb _inb
f009c89df79abe John Garry      2020-03-28  644  #endif
f009c89df79abe John Garry      2020-03-28  645  
f009c89df79abe John Garry      2020-03-28  646  #ifndef inw
f009c89df79abe John Garry      2020-03-28  647  #define inw _inw
f009c89df79abe John Garry      2020-03-28  648  #endif
f009c89df79abe John Garry      2020-03-28  649  
f009c89df79abe John Garry      2020-03-28  650  #ifndef inl
f009c89df79abe John Garry      2020-03-28  651  #define inl _inl
f009c89df79abe John Garry      2020-03-28  652  #endif
f009c89df79abe John Garry      2020-03-28  653  
f009c89df79abe John Garry      2020-03-28  654  #ifndef outb
f009c89df79abe John Garry      2020-03-28  655  #define outb _outb
f009c89df79abe John Garry      2020-03-28  656  #endif
f009c89df79abe John Garry      2020-03-28  657  
f009c89df79abe John Garry      2020-03-28  658  #ifndef outw
f009c89df79abe John Garry      2020-03-28  659  #define outw _outw
f009c89df79abe John Garry      2020-03-28  660  #endif
f009c89df79abe John Garry      2020-03-28  661  
f009c89df79abe John Garry      2020-03-28  662  #ifndef outl
f009c89df79abe John Garry      2020-03-28  663  #define outl _outl
f009c89df79abe John Garry      2020-03-28  664  #endif
f009c89df79abe John Garry      2020-03-28  665  
9216efafc52ff9 Thierry Reding  2014-10-01  666  #ifndef inb_p
9216efafc52ff9 Thierry Reding  2014-10-01  667  #define inb_p inb_p
9216efafc52ff9 Thierry Reding  2014-10-01  668  static inline u8 inb_p(unsigned long addr)
9216efafc52ff9 Thierry Reding  2014-10-01  669  {
9216efafc52ff9 Thierry Reding  2014-10-01  670  	return inb(addr);
9216efafc52ff9 Thierry Reding  2014-10-01  671  }
9216efafc52ff9 Thierry Reding  2014-10-01  672  #endif
9216efafc52ff9 Thierry Reding  2014-10-01  673  
9216efafc52ff9 Thierry Reding  2014-10-01  674  #ifndef inw_p
9216efafc52ff9 Thierry Reding  2014-10-01  675  #define inw_p inw_p
9216efafc52ff9 Thierry Reding  2014-10-01  676  static inline u16 inw_p(unsigned long addr)
9216efafc52ff9 Thierry Reding  2014-10-01  677  {
9216efafc52ff9 Thierry Reding  2014-10-01  678  	return inw(addr);
9216efafc52ff9 Thierry Reding  2014-10-01  679  }
9216efafc52ff9 Thierry Reding  2014-10-01  680  #endif
9216efafc52ff9 Thierry Reding  2014-10-01  681  
9216efafc52ff9 Thierry Reding  2014-10-01  682  #ifndef inl_p
9216efafc52ff9 Thierry Reding  2014-10-01  683  #define inl_p inl_p
9216efafc52ff9 Thierry Reding  2014-10-01  684  static inline u32 inl_p(unsigned long addr)
9216efafc52ff9 Thierry Reding  2014-10-01  685  {
9216efafc52ff9 Thierry Reding  2014-10-01  686  	return inl(addr);
9216efafc52ff9 Thierry Reding  2014-10-01  687  }
9216efafc52ff9 Thierry Reding  2014-10-01  688  #endif
9216efafc52ff9 Thierry Reding  2014-10-01  689  
9216efafc52ff9 Thierry Reding  2014-10-01  690  #ifndef outb_p
9216efafc52ff9 Thierry Reding  2014-10-01  691  #define outb_p outb_p
9216efafc52ff9 Thierry Reding  2014-10-01  692  static inline void outb_p(u8 value, unsigned long addr)
9216efafc52ff9 Thierry Reding  2014-10-01  693  {
9216efafc52ff9 Thierry Reding  2014-10-01  694  	outb(value, addr);
9216efafc52ff9 Thierry Reding  2014-10-01  695  }
9216efafc52ff9 Thierry Reding  2014-10-01  696  #endif
9216efafc52ff9 Thierry Reding  2014-10-01  697  
9216efafc52ff9 Thierry Reding  2014-10-01  698  #ifndef outw_p
9216efafc52ff9 Thierry Reding  2014-10-01  699  #define outw_p outw_p
9216efafc52ff9 Thierry Reding  2014-10-01  700  static inline void outw_p(u16 value, unsigned long addr)
9216efafc52ff9 Thierry Reding  2014-10-01  701  {
9216efafc52ff9 Thierry Reding  2014-10-01  702  	outw(value, addr);
9216efafc52ff9 Thierry Reding  2014-10-01  703  }
9216efafc52ff9 Thierry Reding  2014-10-01  704  #endif
9216efafc52ff9 Thierry Reding  2014-10-01  705  
9216efafc52ff9 Thierry Reding  2014-10-01  706  #ifndef outl_p
9216efafc52ff9 Thierry Reding  2014-10-01  707  #define outl_p outl_p
9216efafc52ff9 Thierry Reding  2014-10-01  708  static inline void outl_p(u32 value, unsigned long addr)
9216efafc52ff9 Thierry Reding  2014-10-01  709  {
9216efafc52ff9 Thierry Reding  2014-10-01  710  	outl(value, addr);
9216efafc52ff9 Thierry Reding  2014-10-01  711  }
9216efafc52ff9 Thierry Reding  2014-10-01  712  #endif
9216efafc52ff9 Thierry Reding  2014-10-01  713  
9ab3a7a0d2b417 Thierry Reding  2014-07-04  714  /*
9ab3a7a0d2b417 Thierry Reding  2014-07-04  715   * {in,out}s{b,w,l}{,_p}() are variants of the above that repeatedly access a
9ab3a7a0d2b417 Thierry Reding  2014-07-04  716   * single I/O port multiple times.
9ab3a7a0d2b417 Thierry Reding  2014-07-04  717   */
9ab3a7a0d2b417 Thierry Reding  2014-07-04  718  
9ab3a7a0d2b417 Thierry Reding  2014-07-04  719  #ifndef insb
9ab3a7a0d2b417 Thierry Reding  2014-07-04  720  #define insb insb
6f043e75744596 Niklas Schnelle 2024-10-24  721  #ifdef CONFIG_HAS_IOPORT
9ab3a7a0d2b417 Thierry Reding  2014-07-04  722  static inline void insb(unsigned long addr, void *buffer, unsigned int count)
9ab3a7a0d2b417 Thierry Reding  2014-07-04  723  {
9ab3a7a0d2b417 Thierry Reding  2014-07-04  724  	readsb(PCI_IOBASE + addr, buffer, count);
9ab3a7a0d2b417 Thierry Reding  2014-07-04  725  }
6f043e75744596 Niklas Schnelle 2024-10-24  726  #else
6f043e75744596 Niklas Schnelle 2024-10-24  727  void insb(unsigned long addr, void *buffer, unsigned int count)
6f043e75744596 Niklas Schnelle 2024-10-24  728  	__compiletime_error("insb() requires HAS_IOPORT");
6f043e75744596 Niklas Schnelle 2024-10-24  729  #endif
9ab3a7a0d2b417 Thierry Reding  2014-07-04  730  #endif
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

:::::: The code at line 542 was first introduced by commit
:::::: f009c89df79abea5f5244b8135a205f7d4352f86 io: Provide _inX() and _outX()

:::::: TO: John Garry <john.garry@huawei.com>
:::::: CC: Wei Xu <xuwei5@hisilicon.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

