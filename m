Return-Path: <linux-kernel+bounces-807239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A068DB4A1EB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 08:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C24A3BD23D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 06:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34EB830146C;
	Tue,  9 Sep 2025 06:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="gKfwzkBI"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED637257853
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 06:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757398681; cv=none; b=XJynsn+dLD7PIdnRHY40jkS/3D33a00jmcmffEhD8wqnLr0jLy4Ix1bznuND59LgBC8QdIfmuYo3ml9c/EbOYWUPLGhgT5WcPQMclj1Y76aCBkHlqlRLQKH7H7FLIMRow6Pu36qvOPISNxovVYdSVCebhXJylBqDQ6jOeQYEbbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757398681; c=relaxed/simple;
	bh=4WXIW00rUMuoH/LxiruMwl6Jw8DXTQAxkOm73/utT7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jnghma60cEEsCRj7/eUYKmcSc8CmjYvkM3yOfZcihH5PC9aoy9ua+nL7yHrbNgx9slqWaDAaejWcqFhpSbykklClLOHS4/bdpyoscJ5RG/HZWZVTUKhyN5oC4Ktr6FvAfotqV8xkdLH6UsjfZP1zZPBuGKrUxArOIIlGmIbLdxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=gKfwzkBI; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-25634c5ebdeso20496965ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 23:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1757398678; x=1758003478; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LArI4fz9z2RUHIMVRDEozej8RuFnnFsDypQBKDKEKlM=;
        b=gKfwzkBIDmbqBtGSREyvLs98pI8eD2/FCbdhBPVGBi9skiT8Pna5q1yHx4/2Mt/htC
         3LBcGgb4+vZLOUKJgbzCmN0NXTqSnJK5uzfTusBUjjAbZ5qCW8SIrvAOQM35JG+yaBMW
         v1Ftifsy9+Lrie8rPBwZWK9o+G6m0LYqKY+Gxb5AvzlALnhyzCa21KHjFI2NKYoud+hc
         Hxh8i3nCj7hlKYxoVECvdNHBQFCGV7yG/98tXsvmxyT8712L4Sak7zQcV9CUBW13+fW1
         orKszo4JXU/zc0nWWzA/RyDqnijQK3ogjcMKjvtfw5JodnddWN6l5nHpd+cBwHxhb+5c
         j5lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757398678; x=1758003478;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LArI4fz9z2RUHIMVRDEozej8RuFnnFsDypQBKDKEKlM=;
        b=b/dWnZTsMnxHMo9dPhf3tdfYBlU0NRtaiRHUE8LSESqQnyfbCfMKC/nBRbsNtnmvDa
         rAj6vNr6Z+ditN5KqOpMKUA/g29L4quPeUrY8M35HdNKs+fRND/UrsOt4s9i2c0bWSUI
         2NtNNWAtgqcMrKjw0EgJKJ/EoyZPxRsmB3qer2G1h2DhL68CGXg7T5Dn8mZeLCXE7DAj
         aa1wA+jEUFzCSQfivNwZIqgeywfrovyIiYqRBRiCybMO/zjIdioT09g64lpg1lB+v7xe
         QJ40YRWceCqxe45iRzs1M5jIRFv43mnmQ3ghb/WVcrMSADi9bqnS3GogoWpG14dUE73+
         WJkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUlXgKoNkha4kl/qwg8/TvuHNfVrXv1OTZNV9/Y/gj0FhqebyKF501hcq6H5jI8HBOd2A5J48orz7oWyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8vlX6KlkmiCUl+fv5ZarPq/o1xrP+IwlEbRU0fzOEdCXdadxk
	dqUUa4YkObXojyWs1fhaUACybEpzQDgEjbnlaEVMmtkms6EVrGl5yfXFh3RVy3oobQ==
X-Gm-Gg: ASbGncvFem/4Kpd+GqKW1JqEy72sjC6OHHjbi2V3uUzBqWF6rOlUkyjd/VHInBFEaNJ
	HhvxCr9tJRwAuOC9hzndCPiV3blTVeLwGyGiVTPa5Fh+CEFhCeXcpApThJlxnNBHwU42yj9Etnq
	/jgWFu9veyZLt34fk6shM5PnLrQD91G0A+4tK1EzdpXGf4LqrDnoNpcd0zdWoK34xkEBww2sy/W
	8iIBctxUIAwBQ3r3BCYb+1t8Q9WVneKMQ6T/3Q/phWC/VBfeWyZVMGdHypcGOiJK2gJ1zvs2mGW
	q/Pmk0GFa+Mc0aM5QnRyY4/zY8PQvuJWAOoJ9kh36DjFi6JkFxOOXUsMZdbsvIMFgld1bge+7hp
	NzSjlZyvdscH6am8lv6D9s7i1Rz362eXos7PiebxDADA8iUXTnrpC1PYWkamE
X-Google-Smtp-Source: AGHT+IEkHAzR6Xk0Y97cHdzqv3Qzt2g/2xG94+TwykxPgXHKx13j3+cFe6/+Cc21Ki8tIBcNSVxmEg==
X-Received: by 2002:a17:903:2350:b0:252:1d6e:df75 with SMTP id d9443c01a7336-2521d6ee123mr132890615ad.41.1757398678082;
        Mon, 08 Sep 2025 23:17:58 -0700 (PDT)
Received: from bytedance ([61.213.176.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24cea3c7a83sm116669035ad.9.2025.09.08.23.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 23:17:57 -0700 (PDT)
Date: Tue, 9 Sep 2025 14:17:46 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: kernel test robot <lkp@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, oe-kbuild-all@lists.linux.dev,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Ben Segall <bsegall@google.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Xi Wang <xii@google.com>, linux-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>,
	Chuyi Zhou <zhouchuyi@bytedance.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	Songtang Liu <liusongtang@bytedance.com>,
	Chen Yu <yu.c.chen@intel.com>,
	Matteo Martelli <matteo.martelli@codethink.co.uk>,
	Michal <mkoutny@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] sched/fair: Propagate load for throttled cfs_rq
Message-ID: <20250909061746.GB35@bytedance>
References: <20250908110548.GA35@bytedance>
 <202509091233.f6nP3BVh-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202509091233.f6nP3BVh-lkp@intel.com>

On Tue, Sep 09, 2025 at 12:20:47PM +0800, kernel test robot wrote:
> Hi Aaron,
> 
> kernel test robot noticed the following build errors:
> 
> 
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/UPDATE-20250908-190724/Aaron-Lu/sched-fair-Add-related-data-structure-for-task-based-throttle/20250829-161501
> base:   the 3th patch of https://lore.kernel.org/r/20250829081120.806-4-ziqianlu%40bytedance.com
> patch link:    https://lore.kernel.org/r/20250908110548.GA35%40bytedance
> patch subject: [PATCH] sched/fair: Propagate load for throttled cfs_rq
> config: i386-buildonly-randconfig-001-20250909 (https://download.01.org/0day-ci/archive/20250909/202509091233.f6nP3BVh-lkp@intel.com/config)
> compiler: gcc-13 (Debian 13.3.0-16) 13.3.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250909/202509091233.f6nP3BVh-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202509091233.f6nP3BVh-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
> >> kernel/sched/fair.c:6747:1: error: expected identifier or '(' before '+' token
>     6747 | +static inline bool cfs_rq_pelt_clock_throttled(struct cfs_rq *cfs_rq)
>          | ^

Sigh, I remembered I did a build test with !CFS_BANDWIDTH and now I went
to check that build directory and noticed I didn't have CFS_BANDWIDTH
disabled...

Sorry for the trouble, will send an updated patch later.

And thanks for the report, lkp.

> 
> 
> vim +6747 kernel/sched/fair.c
> 
>   6746	
> > 6747	+static inline bool cfs_rq_pelt_clock_throttled(struct cfs_rq *cfs_rq)
>   6748	{
>   6749		return false;
>   6750	}
>   6751	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

