Return-Path: <linux-kernel+bounces-752821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4C2B17B46
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 04:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFBEF5A2000
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 02:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154B0155CB3;
	Fri,  1 Aug 2025 02:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="gupBsixI"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719061F5EA
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 02:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754016192; cv=none; b=ep112cBr5SiIiQdDlrVm4yB0ywb9uE+clPs1E8xBfI6kbfcvKwozRVW0pRPd4JE6/GiXKdu55/EgeyymmwvatpTh/5VkrS2xlqV8+QHZP++9LM1Jd3/4q1bHCCeBulLajRcd1mqgRNfrKtTpo3z6LvPKMBxzmInkvRJ99cs21w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754016192; c=relaxed/simple;
	bh=nzD6WB5RkC6BGze6HMUMTiSxxJJtsLrFFAQICpP6Gnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cpahp3QDAZk3yimvUo0g1UiZL7yFmGkY28yMYuk6kru8s8l2WJ13QOAIuDlw+AXkCv/AVWDwJOyuR+vo6hTF7sueJAPuWTk70ANVRbYknf/FzIZ9a1lG8dOfY8ch4x9v2bmZKP4/DgY+TIses8fG/QfbC0uwSxrVkDMvYpKFyo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=gupBsixI; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76b36e6b9ddso1376307b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 19:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1754016190; x=1754620990; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CzF4jXxLSwk12tntJ9tivy32DZakdcy3HZY4JGEQh/8=;
        b=gupBsixIXfr8wppqm3Oklx9+Hm0JALoSR7odU9BgYWtecgnz+A8mGdF5lZrp6XG/lO
         g65zitZc6csQd1DrlCseYNck9GZoQfy2N8T2fLDUI32BK++txJgn8+E+GivLNvK7ymP6
         UbqiH8hIUwSGrwlvBxckmyg8aFX0EWLkdjikyy5suOThd1zGBJyprXavdyJgk/GBTRj9
         0FS5IH+al9m4SZz/Lk8Zz9o7Nj52AwdmBKH0LQGFQ7hpztOm9qBBmq9wge8Yl5UEKW1P
         bOxKyFUBFpvExfcIXM/BeVyP7MJOU5seL8odXwmIuma0H0Y/OHOvfh1o1Xuzn2nLk0Pq
         27zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754016190; x=1754620990;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CzF4jXxLSwk12tntJ9tivy32DZakdcy3HZY4JGEQh/8=;
        b=taQdxtnEV56R5uBpkApynfYXaZ8ZNKBVcc3E5T1o1ZsJhxj1d0WGuuk2+rfPc+Kj1Q
         qvwEbSqE9j4lC9W55ek4IWV5jXbp0JK5jqZd7G4n2SE6NPcCVjuzF3zvnXRzatMigl+X
         zj68atQYc3ZPVsqg2VTVD+kr48LlMr7bBt1oiKiWiV1k9JTB5MH3xrZEMLoAXA7e7PuP
         MLJCkeL/b93lYw4eOb01cDZJhtdLKUUBFmXgs+v1XdYVhIi7gAHLYa6zcLlU42BnrJmp
         qLFGBK2f7v2qmsL4RhihJ68We0xwpuU+uhnuzlgKYt53/nzm9ZnFAwJNBl6r/JbUsTJM
         S15g==
X-Forwarded-Encrypted: i=1; AJvYcCUZSyXw6wIGLBZQecuIWkHdS8mcu6/Z0Xnnq/FlFNN2Dccp0ob+eD8W6O9pNDgMYXTkpIrLl0Kd33/vkjw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyit890iLu9c4kar0Qbc/ITziaT2dUqNnpfUBNRaPjfTfdPGXAc
	EP3tRjutTBaO3kthsj8E9cvjp4aZ0HjTv2n1sMLzpgmNZnOLrbzzSSJiQDeWPYLzVw==
X-Gm-Gg: ASbGncty5Ul9iQoN2Jv5XZLrsFA/9F4z5DpF0VfgR9dc4cebgtvmT4gg+Wrd+516ft+
	/oOoGFqjmfNRt8HSJycXh+lW0as5ExqBNQ48JfGPu8kJGa4xamqLQlDISxoDk3EROQeAbPJUVj/
	wLlbTbHrMo0OjL2WTpEmRrwR8CTxE6lgStk4MdeJ+2MDO2C5WVpQmurNiLOmkece5AxGBD6jq9B
	8UnSZ2eDFJe+NvMloPpc+lhDPOZTf5tpvTGs8f+TX9Pc5OtFpAKy6+nLKlCLDdxld21PVDybcdC
	cethm7oWS4U9SRzRJJ5kHO1FQdbdhFbaLA8WiPSzS6fRLSMSR4YT+geiyrW/6+RvfV1oqzZhPie
	pCK6vRmVq0sQC5pm1Q5w/nydq9hx7Pdpo0pXY3H98RvLwbKbE2e03Qg==
X-Google-Smtp-Source: AGHT+IH+UDQ7iOpF4B7kF0iLPjzpWWshotanqhyLxmLjhjWrs9mQTlq560Ea7kIcPBTsIu2VocDCVA==
X-Received: by 2002:a05:6a20:914c:b0:21f:4ecc:11ab with SMTP id adf61e73a8af0-23dc0cf63e6mr14331609637.9.1754016189706;
        Thu, 31 Jul 2025 19:43:09 -0700 (PDT)
Received: from bytedance ([61.213.176.55])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422bb19069sm2363362a12.65.2025.07.31.19.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 19:43:09 -0700 (PDT)
Date: Fri, 1 Aug 2025 10:42:53 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: kernel test robot <lkp@intel.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clocksource: Use correct limit for wd-cs-wd read back
 delay in printing
Message-ID: <20250801024253.GA360@bytedance>
References: <20250731120454.GA309@bytedance>
 <202508010911.AmkxEw1p-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202508010911.AmkxEw1p-lkp@intel.com>

On Fri, Aug 01, 2025 at 09:48:40AM +0800, kernel test robot wrote:
> Hi Aaron,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on tip/timers/core]
> [also build test WARNING on linus/master v6.16 next-20250731]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Aaron-Lu/clocksource-Use-correct-limit-for-wd-cs-wd-read-back-delay-in-printing/20250731-200709
> base:   tip/timers/core
> patch link:    https://lore.kernel.org/r/20250731120454.GA309%40bytedance
> patch subject: [PATCH] clocksource: Use correct limit for wd-cs-wd read back delay in printing
> config: i386-buildonly-randconfig-001-20250801 (https://download.01.org/0day-ci/archive/20250801/202508010911.AmkxEw1p-lkp@intel.com/config)
> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250801/202508010911.AmkxEw1p-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202508010911.AmkxEw1p-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
> >> kernel/time/clocksource.c:293:43: warning: format specifies type 'long' but the argument has type 'int64_t' (aka 'long long') [-Wformat]
>      292 |         pr_warn("timekeeping watchdog on CPU%d: wd-%s-wd excessive read-back delay of %lldns vs. limit of %ldns, wd-wd read-back delay only %lldns, attempt %d, marking %s unstable\n",
>          |                                                                                                           ~~~
>          |                                                                                                           %lld

Thanks for catching this, will fix it in next version.

>      293 |                 smp_processor_id(), cs->name, wd_delay, md + cs->uncertainty_margin, wd_seq_delay, nretries, cs->name);
>          |                                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~

