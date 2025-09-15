Return-Path: <linux-kernel+bounces-816145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A73E9B57023
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 08:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55BB93A7401
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 06:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C568827FB3E;
	Mon, 15 Sep 2025 06:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qk5FjaMF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988D027FD45
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 06:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757917219; cv=none; b=riaTjczGKuaIX+4fTi2OoWFkUl6wGJoCRlJX5fIUj4uUStdgpYWHhyesbiZxpqybmHyuxHnlEXRDji4qLS90vVbthfvpTU1YXXRwIV+MOQ5wkpgeX5WsTLVY/r5ytEiT1obaAWnVOnv0uNG5MZJhqArGnB4NxV/zM26LyZY5Amw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757917219; c=relaxed/simple;
	bh=vva6pIwIf3d2mZtlJF6HKg5UB//x7948Lc30IK2Mdek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C7oQGl1g1qPZ8lD17DbXZIC687GL81egeoQPcF0cuN7dJWawuaprLgZJGAx3qtjFTiGW7RmDYLZDHZrvtfDeAehVgTSTUdIwOXWBMcfsM7JpsDppCgUKSa0GA/42p4t/ZUvbyvpkk40/fVzIhssdTrHKeTTClbW0fakNg6JZI6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qk5FjaMF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757917216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9cBtHKBe6RRB8Snk7hpO1mjWCGkijKsQ31tvgy2vEzE=;
	b=Qk5FjaMFFz47s8zMcazcG+eLpj9pOno6+YtjDmQODpFIWTUtB/0wZEyin9bCQfMtGtcc/o
	5PgRzSAmyNx9JfpK2zd5lCnUVzWXRkjM0GIqFCivnPw36OX85VRalyVgNBSrJaCTAglwbF
	bHFm/oPOYddyZxAErZLB7RcwPzdNfto=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-VXHrxOgcNLaG90O9xF-1JA-1; Mon, 15 Sep 2025 02:20:15 -0400
X-MC-Unique: VXHrxOgcNLaG90O9xF-1JA-1
X-Mimecast-MFC-AGG-ID: VXHrxOgcNLaG90O9xF-1JA_1757917214
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b54a2ab0f2aso2078628a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 23:20:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757917214; x=1758522014;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9cBtHKBe6RRB8Snk7hpO1mjWCGkijKsQ31tvgy2vEzE=;
        b=K8yCgrDliT3Fa511W1vYuvGexgb0h8MHoTK/CHfdzh0SUqU/hWNoOiTFmCKTwLxOH2
         Pwqf1DJl2Ppft2T3j+wO+ZCs9I+Eq3kTjIFDqdZDbv4qlJbqG3YXcYxlTmmwytnz6a6J
         DHfWc4l50vmGl06yDyIOYtnCxYHu9w7sATjKed84yFc0SIM5CVkFAOwek0LkPlrewJEV
         hTC7PzJ9NhQj/ivpFx+WWrP/RD7L0iBzazOF3GOByYuxumQNZitfmhDroXhqanwNlrjV
         COIMOC/e/yfMXtzO7WNiSs3AOPDrlD1nDJSp9IWFc+XJZUVR7leAauK0GaUHvv+Sf1hR
         Robg==
X-Forwarded-Encrypted: i=1; AJvYcCXAKieyJ0TkXPlGZB68fyoy6z9S3O7SYDDa5sTDejtwyozNh6FPM4LE6IhNProNKyaMl6Vsk3AnjFfUnHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbWG04yPMvOK1vAmagRVR631dcRTb8BtwcU1QdwWOdq74OO3I+
	3n55rj/P8cSrtUCo5yb8daikHnuhLXOj0EQAifwCPE7eEV7JXslKguugutTxYPjeqdSZICka5mZ
	XjEDm4YC2Y35rO76Lj4inwFPkLtVltAjaGfNntsUezUGbp6bcX5YVOw8hvdZiyHDaEA==
X-Gm-Gg: ASbGncvQqdJBug9xDO7JcQzwd6j0ePN2i4Ywv0/6FeRYnLpjaApS21FpFb4aEBBH/9t
	lLNsveGNZ+Ta26M7BNj5GBJw1/E2UPKVbYrcVVLOG0oS16oFK57Rm2PA4XvkX2IYTkl0tBQ2qry
	8NDQU0xC5xtS9tl8bKfnTBHz/moFtvpf6Gqt3ZX15O+Vooz25nZw8i9l1F8/JL91HJTjBuWcE9q
	bsh4QL+jUvVl6NdtLZKAGR3M8aVTnNHx0PnerZdJUqomMkS5LsuM4mw/645vvnnLFfh+vu6b1AU
	feHHAlU1uvLeJnnCxgLuVjft/GnK3RI=
X-Received: by 2002:a05:6a20:7d86:b0:243:b92d:72c1 with SMTP id adf61e73a8af0-25cdefc7abbmr21753636637.0.1757917214013;
        Sun, 14 Sep 2025 23:20:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErivlYOqYNMD1uzOOLvIYOeSFyGjheTCp4Vv8Fmhsfn/ts4DA9nnO0VA6qrA0q8hxFLJc/yg==
X-Received: by 2002:a05:6a20:7d86:b0:243:b92d:72c1 with SMTP id adf61e73a8af0-25cdefc7abbmr21753609637.0.1757917213616;
        Sun, 14 Sep 2025 23:20:13 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54b169f2edsm7546506a12.19.2025.09.14.23.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 23:20:13 -0700 (PDT)
Date: Mon, 15 Sep 2025 14:17:51 +0800
From: Coiby Xu <coxu@redhat.com>
To: kernel test robot <lkp@intel.com>
Cc: kexec@lists.infradead.org, llvm@lists.linux.dev, 
	oe-kbuild-all@lists.linux.dev, fuqiang wang <fuqiang.wang@easystack.cn>, x86@kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Linux Memory Management List <linux-mm@kvack.org>, 
	Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] crash: Add KUnit tests for crash_exclude_mem_range
Message-ID: <x33mpzp6bhnx2awnszjymuyfhgmtvq5hhfs6aoyvuoo6opsbqr@tkegmqv3lucp>
References: <20250904093855.1180154-2-coxu@redhat.com>
 <202509090415.cOytgte4-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <202509090415.cOytgte4-lkp@intel.com>

On Tue, Sep 09, 2025 at 05:25:17AM +0800, kernel test robot wrote:
>Hi Coiby,

Hi,

>
>kernel test robot noticed the following build errors:
>
>[auto build test ERROR on b320789d6883cc00ac78ce83bccbfe7ed58afcf0]
>
>url:    https://github.com/intel-lab-lkp/linux/commits/Coiby-Xu/crash-Add-KUnit-tests-for-crash_exclude_mem_range/20250904-174105
>base:   b320789d6883cc00ac78ce83bccbfe7ed58afcf0
>patch link:    https://lore.kernel.org/r/20250904093855.1180154-2-coxu%40redhat.com
>patch subject: [PATCH v6 2/2] crash: Add KUnit tests for crash_exclude_mem_range
>config: x86_64-randconfig-073-20250908 (https://download.01.org/0day-ci/archive/20250909/202509090415.cOytgte4-lkp@intel.com/config)
>compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
>reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250909/202509090415.cOytgte4-lkp@intel.com/reproduce)
>
>If you fix the issue in a separate patch/commit (i.e. not just a new version of
>the same patch/commit), kindly add following tags
>| Reported-by: kernel test robot <lkp@intel.com>
>| Closes: https://lore.kernel.org/oe-kbuild-all/202509090415.cOytgte4-lkp@intel.com/
>
>All errors (new ones prefixed by >>, old ones prefixed by <<):
>
>>> ERROR: modpost: "crash_exclude_mem_range" [kernel/crash_core_test.ko] undefined!

Thanks for reporting this problem. This issue has already been fixed by
Andrew [1][2] earlier.

This issue happens because the KUnit tests can be built and run as a
kernel module. 

[1] https://lore.kernel.org/mm-commits/20250905031921.E0A26C4CEF0@smtp.kernel.org/
[2] https://lore.kernel.org/mm-commits/20250914001748.77104C4CEEB@smtp.kernel.org/

>
>-- 
>0-DAY CI Kernel Test Service
>https://github.com/intel/lkp-tests/wiki
>

-- 
Best regards,
Coiby


