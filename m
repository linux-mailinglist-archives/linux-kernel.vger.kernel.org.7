Return-Path: <linux-kernel+bounces-836468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B14E2BA9C5E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 17:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6CD33ACE94
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 15:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A76C309F15;
	Mon, 29 Sep 2025 15:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKfdxAX6"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588A62BB17
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 15:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759159070; cv=none; b=qPBGjDkF3CcmAhwDDq0p90hvfonYjUw/5AmojoBaFZGC9RGBPGXEIjBzjmlAAzNZXgMFGaoqz5oXG6zAGKQQwGwSYAOsy2PMXLSP7OXlilVr9I0SO89BaeS4L0Ah1ivBDUBDx+zV4PJUwMSzJj6Q0ThyFGs9o+rDlqYIHHhgQME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759159070; c=relaxed/simple;
	bh=JVXLpMncXsK7lii3UJPA6maYlWrK0Wh8RIsE/dtvg5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cO6OaeVDBdlOa24SK07s3ajcA9lEDRC4rZI+kTRqUXYF0M/lPTBxIghf7NAWLTCo74XTfv3cdgR6Q+EPtF/yRMm1NyAxdIa4AofkKqvzWh5+YORdoSUJ4B0K4onZN7mOZgj5YjMhKe9UiEZxYj2Bv+zIb3tNZ8vjQvMRhALFL04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nKfdxAX6; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-749399349ddso59309897b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 08:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759159067; x=1759763867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gvOyryAypxH3+4wG3KZkQ2EISvw8ZEcZIHjxhBYkRgE=;
        b=nKfdxAX62iSNPu5MJoDvEaEntVnnCN0hHQFlAZVELRXjAtfLMY6TtC54wDSifD21um
         +o3kcr94U6aIFIa9DeCl9AvlCizlZqPi8yHehvwRZ47786D1YeJcpz8BQzxOUsc+qlNV
         7eRacwvbdCbfTTHgmZkD4bJo1yTdH8GMZKq5P47pZOXqaxkdfWP/dEEuL4r0BcTXrg4/
         bgWGO1+6XnGIjCLlMJu92pYQBl3lY737yMQfcyOdlJtzcXgotvia8e08v6/yRcV0PpiK
         kxFEx68tuQugXrVs5PMiuTevQcR8y8VexGS2RtX2B8huhlKnFx1ngyEqFVgm076Mggrd
         4rgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759159067; x=1759763867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gvOyryAypxH3+4wG3KZkQ2EISvw8ZEcZIHjxhBYkRgE=;
        b=JyFdiOXcw5W6evjug5MBFP+HyMiUFAp8FhuL7g6lsWJziaTHXpJ8VGnKfY3O8PVwWp
         j82sX4w7A6xvIZRaXeevH+vMdwh8kQjQzWdEx3s5dOsoSpbauHDkdvtIG4f6KOVhvF3t
         dAibxTEJzT78hJqrywVPc0IS4Z69rQxmYTTmwqf3FU0wtGcoyxY8P/T/yVEm7KBsJ+lD
         b49jxL18NBx+p2NRAD7hPHr1VDU6OqbTHLFi0rQ3/1WQ2wjKzxrN4fbaWC9srvfG4vJO
         tvZ9KzSqWfKpg5WgRVLvGKnHobxB7i8xR1Y9KuMRkTLNCGqo383XqUpld0LNmzldarE3
         2ARw==
X-Forwarded-Encrypted: i=1; AJvYcCXOHByHVVvP44CJgyTTDLU7EEsBxfRYL1KTJCGvW5owuk9QG5BXEGlNbBU1Nb08cIHiVeP4tkvch5lVKzI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK8xDM7blvb+21Se0rQztoXl5DmCS/58cRaa5rOqxUxDJhhRIv
	ABkE2vx85+l59eif5CfZ3zBNBkM16OT90Vxmoa/+VASi2yY2XUEcX6R1
X-Gm-Gg: ASbGncvjWaxjvpU8Ujl+2AajCLaMUFQBDcYH8En8khQtffCodCce9yvCh5CWKudGTO3
	QYBoWFCFJFDQomvnoDrCUNgGlDEC+zkRzvgdgnuzQc+yAf9vV77yKQNA8RxE03PxfRs0fjFdpVn
	/SCfiuCIY9n0d7kKt/GhmGZvptWDlj/2hZI8gTrKlzfziCrvxNa31Ze+2N1haj/Wo7U5d8pMa2r
	2CJq5O7ITWxGftocpJlecZQwZ6PdE01IaGmLhE4TcnC+4ViOdyCdlkH1q5DCBA5HC3seyKt4fPF
	//jf1gfoJTnYDmc7tcWsNujqPCZlawA+gQItGZTUiAPUwpbso/Eif8Ixvnkk7x5oWfBCM0F4PJ5
	dpByCTNn7G9wmh5idCOdBPhzIo1XoEMcxV8z0y9bMvOuqe/SrntRfpw==
X-Google-Smtp-Source: AGHT+IG03Xxr9FsAaNhFS/ao7nWzoRTl2e11K0kClHGJkJfFFVQCaVlVRxoehRsBF6M99SMNTqAnpQ==
X-Received: by 2002:a05:690c:9a07:b0:719:3e4f:60f7 with SMTP id 00721157ae682-76401288ea4mr191557227b3.26.1759159066447;
        Mon, 29 Sep 2025 08:17:46 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:5f::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-765bd126227sm28968727b3.16.2025.09.29.08.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 08:17:45 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev,
	lkp@intel.com,
	Chris Mason <clm@fb.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Kiryl Shutsemau <kirill@shutemov.name>,
	"Brendan Jackman" <jackmanb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	"Suren Baghdasaryan" <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Zi Yan <ziy@nvidia.com>,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v2 4/4] mm/page_alloc: Batch page freeing in free_frozen_page_commit
Date: Mon, 29 Sep 2025 08:17:27 -0700
Message-ID: <20250929151744.2922386-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <202509281204.3086f707-lkp@intel.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 28 Sep 2025 13:17:37 +0800 kernel test robot <oliver.sang@intel.com> wrote:

Hello Kernel Test Robot,

> Hello,
> 
> kernel test robot noticed "WARNING:bad_unlock_balance_detected" on:
> 
> commit: 7e86100bfb0d65a17f3228a9af4c2a49ac38f057 ("[PATCH v2 4/4] mm/page_alloc: Batch page freeing in free_frozen_page_commit")
> url: https://github.com/intel-lab-lkp/linux/commits/Joshua-Hahn/mm-page_alloc-vmstat-Simplify-refresh_cpu_vm_stats-change-detection/20250925-044532
> patch link: https://lore.kernel.org/all/20250924204409.1706524-5-joshua.hahnjy@gmail.com/
> patch subject: [PATCH v2 4/4] mm/page_alloc: Batch page freeing in free_frozen_page_commit
> 
> in testcase: trinity
> version: 
> with following parameters:
> 
> 	runtime: 300s
> 	group: group-03
> 	nr_groups: 5
> 
> config: x86_64-randconfig-161-20250927
> compiler: gcc-14
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202509281204.3086f707-lkp@intel.com
> 
> 
> [  414.880298][ T7549] WARNING: bad unlock balance detected!
> [  414.881071][ T7549] 6.17.0-rc6-00147-g7e86100bfb0d #1 Not tainted
> [  414.881924][ T7549] -------------------------------------
> [  414.882695][ T7549] date/7549 is trying to release lock (&pcp->lock) at:
> [ 414.883649][ T7549] free_frozen_page_commit+0x425/0x9d0 
> [  414.884764][ T7549] but there are no more locks to release!
> [  414.885539][ T7549]
> [  414.885539][ T7549] other info that might help us debug this:
> [  414.886704][ T7549] 2 locks held by date/7549:
> [ 414.887353][ T7549] #0: ffff888104f29940 (&mm->mmap_lock){++++}-{4:4}, at: exit_mmap (include/linux/seqlock.h:431 include/linux/mmap_lock.h:88 include/linux/mmap_lock.h:398 mm/mmap.c:1288) 
> [ 414.888591][ T7549] #1: ffff8883ae40e858 (&pcp->lock){+.+.}-{3:3}, at: free_frozen_page_commit+0x46a/0x9d0 

So based on this, it seems like I must have overlooked a pretty important
consideration here. When I unlock the pcp, it allows both the zone and pcp
lock to be picked up by another task (pcp lock less likely), but it also
means that this process can be migrated to a different CPU, where it will
be trying to unlock & acquire a completely different pcp.

For me the most simple solution looks to be migrate_disable() and
migrate_enable() in the function to ensure that this task is bound to the
CPU it originally started runing on.

I'm not sure how this will affect performance, but I think in terms of
desired behavior it does seem like this is the correct way to do it.

Joshua

