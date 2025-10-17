Return-Path: <linux-kernel+bounces-857820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 079B3BE803E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 12:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E811C568B4C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DEA231197A;
	Fri, 17 Oct 2025 10:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cPEn1LK7"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D056311C05
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 10:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760695942; cv=none; b=suLal7xhkgBXbF/5kmiMZIDC9fsSwCIP5PyBlPCNGZbBNdQkJh+Dzu/fKPA9M6rZhFikNST8jlt169WeehzizFg0tT4HbL/SNZ3W3XYLbKmg3oSiwlxlMs1yaDK5RdKcxokvTrVByt+hHR8d2+6xnuEYrmGT0smSY2gqtJTYPO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760695942; c=relaxed/simple;
	bh=LxfKf1rMuw5rL6S+6Rg17frkQTovaCXaZTfO70TM6oQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vExcAVsMqd9PKNU1W9nGZo57Q9beBaNOgPJfjbQDVvp3huOtprm7mMotfnXYsnymCjyk334pR6tT65qmo39Mwo89EEQQj28MGdnZX3CkZb7fkCB5qmCH7Cn+WI5WLNIiq0w3pMpo4Vwg12itmFLbvDMnQLqYGvDP6ZPZYPGCdyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cPEn1LK7; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46b303f755aso17704965e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 03:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760695938; x=1761300738; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IcAE9gTZ+/oZemSW/gjSvTAcO1JCiHDPx7fInOY/f2o=;
        b=cPEn1LK7lwCmGbxZyLxJQzjYns1f4yVDDZ1Hq7H/fd6ooZmDa6wiYl7KofER2uGUdG
         xxnaO4Jwwr3PNFa5Xtxwpnj8xkaDCyoRBYS0mwYQ/B5TzmrYWwNDunzIlP3xsQyNjBoF
         xwk0oMebDPNwLL60TEH4MKXfKFc+xLS+nlJa2vn4FTx5ikbJaSuD6otTd71u58l1C44F
         sVjI+27VHcO2oP9JpBM+psCclv8n6feV1XHTKwXFm5TcP3VWEWRzzSbh+3Qlg8aw8F9y
         DYXSPmaNpBmwFUO/Y7M3b0EjCKPBToprUngXnZjGWIRmg4JMScIBa8bhFpys3B6nmyE7
         l3yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760695938; x=1761300738;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IcAE9gTZ+/oZemSW/gjSvTAcO1JCiHDPx7fInOY/f2o=;
        b=a1VBWnFnhqXQOPwjh0SiFJDaqWe7NMLn5HPs/VniKgZ5XVGRx2AzRhegKk8ygg6ZV3
         wxcJGgDqZ+cxRBecCCV+153dZKzOQh4/qtAFCLlSU4tlMkmooG9gWsJJKW6BPSPENZN3
         BM530yHLFvJTys/2nchmFMBnSZwlvRvZA6Qx21HYFxiSZrNA0TcmsLNFVwBt/bVorJ2t
         h2oqffu51/FIdi2nUM8m6j/6ge7ZE3zaCksRkWqwPus0Cmt8MKmymjXUiXXFOD+fPuGq
         SNsMIEqLzsbIZdlomB+h7c/K+k+QCri37q/7m2r08uWxosU6Fk9mskyZommEMBbbMVtw
         SHJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPa+Slrj+iKSwaqNHCZug17WjYxGXgEdHiwue1gIVFWX6Y3Sit+LalnXj+206VMuJHFr0dykkg3dK+yUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYUB4ztQkZLsA+Bv+Daom8ezA7Uy/YK+gxeKLLOU1hLEtRtze+
	Bpro+GiczJhnZjBPePU6QMhCqWQTy0WEusxYhWkWskJuIyGtXxOVm0dSG+6uKAfjmnA=
X-Gm-Gg: ASbGncsJq9nDYohEOKVXVj37bDN9nuqCfeAbf9uYbQL7/PWRC7l/ErvZdshaB9VSVsj
	8rBFtt11/mdLvJFJB4Nu1D6Yx5UKVB8WAXfrLJQasKV0vHbQMPNdy3TzgqHiTlGZHozRt6ouBXS
	qxjQ0ynNABRQ7Fr14eydHIl0f15moIfbHUzn9f3r0SKRQM9dmrOLK/LFCtjlBJFBUR8yj+0fIk6
	oytZc5kJxuf7czhEF32vT7+RXsQZ0V+cthHxk9NjJK2X3lrVbI4NwnnX0En6glcr6ujrmiALzPg
	jujSOSPLmQSRhlgJ6hIugwcHyxa2btej52ZStl0EDSa1ao4HEl23TbAG92SfwO/jvJU7NBRYCIO
	F5mHJfnstrjKJ2onfUqnUYoxvCAZcqEhu1WsUg/1b3qSOh0dQUif14/HyMIl4FjALbrvaBjFaxe
	4/kZDCHt1Po7wEHQ==
X-Google-Smtp-Source: AGHT+IFPljBKrOVB/66ijJCXVaRvUIH/JjXGzjIhcC63OF8E63IkVl0Uh+QOhjfWccM7pXPnZ0iuRA==
X-Received: by 2002:a05:600c:3145:b0:45d:e6b6:55fe with SMTP id 5b1f17b1804b1-4711791e7a4mr29591645e9.34.1760695937835;
        Fri, 17 Oct 2025 03:12:17 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4270665efaesm3215957f8f.27.2025.10.17.03.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 03:12:17 -0700 (PDT)
Date: Fri, 17 Oct 2025 12:12:14 +0200
From: Petr Mladek <pmladek@suse.com>
To: kernel test robot <lkp@intel.com>
Cc: Marcos Paulo de Souza <mpdesouza@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	kgdb-bugreport@lists.sourceforge.net
Subject: Re: [PATCH v6 5/5] kdb: Adapt kdb_msg_write to work with NBCON
 consoles
Message-ID: <aPIWfjBhFPjOmESL@pathway.suse.cz>
References: <20251016-nbcon-kgdboc-v6-5-866aac60a80e@suse.com>
 <202510171023.YREXxhMK-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202510171023.YREXxhMK-lkp@intel.com>

On Fri 2025-10-17 10:17:37, kernel test robot wrote:
> Hi Marcos,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on 3a8660878839faadb4f1a6dd72c3179c1df56787]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Marcos-Paulo-de-Souza/printk-nbcon-Export-console_is_usable/20251016-225503
> base:   3a8660878839faadb4f1a6dd72c3179c1df56787
> patch link:    https://lore.kernel.org/r/20251016-nbcon-kgdboc-v6-5-866aac60a80e%40suse.com
> patch subject: [PATCH v6 5/5] kdb: Adapt kdb_msg_write to work with NBCON consoles
> config: i386-buildonly-randconfig-006-20251017 (https://download.01.org/0day-ci/archive/20251017/202510171023.YREXxhMK-lkp@intel.com/config)
> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251017/202510171023.YREXxhMK-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202510171023.YREXxhMK-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
> >> kernel/debug/kdb/kdb_io.c:612:22: error: incompatible pointer types passing 'struct nbcon_write_context *' to parameter of type 'struct console *' [-Werror,-Wincompatible-pointer-types]
>      612 |                         nbcon_kdb_release(&wctxt);
>          |                                           ^~~~~~
>    include/linux/console.h:667:54: note: passing argument to parameter 'con' here
>      667 | static inline void nbcon_kdb_release(struct console *con) { }

This should be:

static inline void nbcon_kdb_release(struct nbcon_write_context *wctxt) { }

Again, no need for v7. I could fix this when committing the patch.

Best Regards,
Petr

