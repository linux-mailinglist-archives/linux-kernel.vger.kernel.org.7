Return-Path: <linux-kernel+bounces-734590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E90B08396
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 05:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFE7CA4547B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 03:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A011F5413;
	Thu, 17 Jul 2025 03:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Ncjk+fUL"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65DA1B87EB
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 03:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752724376; cv=none; b=gvXgoCzgV4tgkeLDU5RN6Ommh6APbpOXnNx61/wauM/Ye3H/GSSxqrYiI88tPz6xup1lkhYzLFSg5nkYxwriQrxvfZUwLO989G+c7s0BnM20Rpc5jISq5SijAkZoNCgOtXIxCybVzq2iDE0FeCrWSmu16c0YY4t6uxGA/HE+7II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752724376; c=relaxed/simple;
	bh=/z4GYwHjaobsFfMLWkEpzmAPQ7BYXuHIegjFwl/GFN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m15fPpmNQ1pMW3BnnE7HuxZZezwv6avjzujvQrBVau0XJIFeKQZC/Q0V6lYkU1qsYaSrlxuq68ftCldLmNihumRudVIB+b1l6p3z9xASqHC7/gaRSyTJGigxtAgmUCUghcg5Hlb10MaBegZmeDPGznp2y5KbiDNiIEumSbzGafI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Ncjk+fUL; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-313f68bc519so439505a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 20:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1752724374; x=1753329174; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oG3EpdW9G1k+entmtME8v9DE+8iik/HrDmrP2Q0Le7k=;
        b=Ncjk+fULRWZ7kwNSbxHDgx8PgQiW5rflJz4MgTZ46y0eMgdjNYIRFQLna/ihzXRJ5U
         t03rNzAL/ll5VGQKmJO0n5XH0ltOXhETlyrGd8gYhuBv4kOb5kz8VGfV6+Lw0/mgH1RQ
         2dKlvWrnUfSmdDqHA9kW6Ek7etd9VDOJybWt5hOIuYN81ypC4CBXcCTTjZp/WD0xQwCC
         qegfM2iXO1D5EdHWp7tgN8YKDkLhP2UFj+1fJIhaG0K4ElIETuEZXS6rnnWg6DFDeMcv
         zV4g4sB1y7IkiZ7FZYOKRRE8BcpzrfFR324LfSpJZiSyLrJaG3C4ydky1Sy9pdlo1oXr
         nNig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752724374; x=1753329174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oG3EpdW9G1k+entmtME8v9DE+8iik/HrDmrP2Q0Le7k=;
        b=YAb8fODCg/qsjAGfruN/Sb/+/c/CjMtI1bWp4fbMRnM/jsWrUfNgidg2AbX02mJInj
         NRARerst5uHQIKHli9BBR0lyXS5QalF3MRD+x7Vd5UsUuByJVB8LzWwbDnf/TwkpHaIm
         +yKKBDOA0SRwwM/8nkfD4tNr0S22o1377efSOzOfxo+JfTffW61hvHRP5mUgTJNfQXPY
         fZ72A4WPO5Tlu6XhatQ7CaLyMlGbnm3RnUo8orkN+ksCK03zm3Hss51wnGuKe0w9VjGg
         8I4XW7SFhGZ39kGnPviMf/2+8ooMm6RmXiBaHmM0TNRhLQqZyBBpcQOWGuZRLokPoUyg
         vzzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWepkKOg5oVw/c7oDLSN2QKADclUWEIEBsdyMV6oX6F75nJGe/tx0ilt7kF2TCPIu5i6nxAa/yfzve6YY8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9s+KdbXlH9xdUSdAGQGuGiku0dMZ36IA6K1JWI9TiDqCusUNY
	mAhcuDVkbsVQtyudVbE2myhIGJbdG9L+DyIvsrj43bQSaINOOf7ljtQxRA5dxSDasA==
X-Gm-Gg: ASbGncu41sk7gQzFr9oR+KCv4dZgvHycBn6stf8xjXQIioerstmj/FUe2r8ibfLDxXN
	PRnVSiYITGIwvrhdaFLRJ3e/2D+EraqA1rzDxDtp6yucVLlefCnyXBbM9IDgt0wMj9kZ/kxQEwJ
	kqcgPKwjzmU5Z4BjjsFnONH4c8WMRSqlH6Gi/fYCYmNxRqxUKB/1tINpIONf7AO8CoC4EJPHwsz
	Z4pDC/bP1K4OVEAdj3kvDa/CH+wVWOfi1a9XvT45gFvY3ErJSFqLEad18nqYJWwpbciOMM37XqB
	F0a5M6I/HeOA2k/gA5YRjoDSLIWi4A5UF1Ft85sDVsOEdSEM2manltKMXvKoeu22rznbX0KbU+0
	7V0GxyLPmffjiqyNdnLANWypKyvxhzWWv7o0RMeYgYUY=
X-Google-Smtp-Source: AGHT+IELl7UWfL6ReDIoZqrYNbMcjyrb0hKdAQ12X0Ce9k4vgLuaUhoqNyvz4Zmk/h8IJ45JTVxenQ==
X-Received: by 2002:a17:90b:3909:b0:311:e305:4e97 with SMTP id 98e67ed59e1d1-31c9f4a6b52mr6301277a91.19.1752724373988;
        Wed, 16 Jul 2025 20:52:53 -0700 (PDT)
Received: from bytedance ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31caf7aa70esm497490a91.6.2025.07.16.20.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 20:52:53 -0700 (PDT)
Date: Thu, 17 Jul 2025 11:52:43 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: kernel test robot <lkp@intel.com>
Cc: Valentin Schneider <vschneid@redhat.com>,
	Ben Segall <bsegall@google.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Xi Wang <xii@google.com>, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>,
	Chuyi Zhou <zhouchuyi@bytedance.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	Songtang Liu <liusongtang@bytedance.com>
Subject: Re: [PATCH v3 3/5] sched/fair: Switch to task based throttle model
Message-ID: <20250717035243.GC32@bytedance>
References: <20250715071658.267-4-ziqianlu@bytedance.com>
 <202507162238.qiw7kyu0-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202507162238.qiw7kyu0-lkp@intel.com>

On Wed, Jul 16, 2025 at 11:20:55PM +0800, kernel test robot wrote:
> Hi Aaron,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on tip/sched/core]
> [also build test WARNING on next-20250716]
> [cannot apply to linus/master v6.16-rc6]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Aaron-Lu/sched-fair-Add-related-data-structure-for-task-based-throttle/20250715-152307
> base:   tip/sched/core
> patch link:    https://lore.kernel.org/r/20250715071658.267-4-ziqianlu%40bytedance.com
> patch subject: [PATCH v3 3/5] sched/fair: Switch to task based throttle model
> config: xtensa-randconfig-r121-20250716 (https://download.01.org/0day-ci/archive/20250716/202507162238.qiw7kyu0-lkp@intel.com/config)
> compiler: xtensa-linux-gcc (GCC) 8.5.0
> reproduce: (https://download.01.org/0day-ci/archive/20250716/202507162238.qiw7kyu0-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202507162238.qiw7kyu0-lkp@intel.com/
> 
> sparse warnings: (new ones prefixed by >>)
>    kernel/sched/core.c: note: in included file (through arch/xtensa/include/asm/bitops.h, include/linux/bitops.h, include/linux/thread_info.h, ...):
>    arch/xtensa/include/asm/processor.h:105:2: sparse: sparse: Unsupported xtensa ABI
>    arch/xtensa/include/asm/processor.h:135:2: sparse: sparse: Unsupported Xtensa ABI
>    kernel/sched/core.c: note: in included file:
> >> kernel/sched/sched.h:741:44: sparse: sparse: dubious one-bit signed bitfield

Same problem as last report.

I've downloaded this compiler from kernel.org and confirmed there is no
such warnings after using bool.

Thanks,
Aaron

