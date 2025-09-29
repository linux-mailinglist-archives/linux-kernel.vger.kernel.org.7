Return-Path: <linux-kernel+bounces-836776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11831BAA887
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 21:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 685A51924288
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 19:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E4B241C8C;
	Mon, 29 Sep 2025 19:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VKjKXhcX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176B31B4236
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 19:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759175672; cv=none; b=mFH0BQYiH2P+OjM1KpzF0F7BhnOeyY4cWWUHFl24j1j4tDQ9zcz1jBJacq/N5ZndtwUTTrcYgNzPe57wTkF2uxU8OFj3SfbSjYz/nKdGGXt1C8bHmMd9/Nw3iJCk9SG2UmPjgtcQMErWPUodVirzmy2IZLHW8g/e3ZxACTprCu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759175672; c=relaxed/simple;
	bh=qUNzPnV32PU/DAWJwLGiD+OFWfCnah077HcVK6ugnWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=djwuEaDSg0DiN89+ur2nbVVGOoYyXC8ihrRn4Az2XnLQBheuiNr6CRSzOvgX+NQ6BwQIbMJr30nBz/mixpX2h7ngYw6QZPwj/aPmeKAMavBjtrZXQLD4FtfJme6xAEP5moM/n6aC/gikwUqXhzU7+99EEW9iR2+NzSuHNHFkA5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VKjKXhcX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759175668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MtPA+6dU4CCxMU2eK/4bdnBfarm4rw4G5s3tke0e2sk=;
	b=VKjKXhcXL+MFZq8U0HbuCV7DtC13cAfBRnnWh+zSYXBvIgmaun7Zjx3U7tBheo7EWqLJE2
	7Y/dGXKELH/bTiPxfAfCq6rAXOBagRZnZNH5yHFWbvFiXzbar9e5Jz//i3No6t40E0tQk3
	JNv5C+YMvz4gGqGxfQOqlbNgcgwW5qA=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-CV7-OmXeMuiC3jUrF1bd2Q-1; Mon, 29 Sep 2025 15:54:26 -0400
X-MC-Unique: CV7-OmXeMuiC3jUrF1bd2Q-1
X-Mimecast-MFC-AGG-ID: CV7-OmXeMuiC3jUrF1bd2Q_1759175666
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4df10fb4a4cso93085621cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 12:54:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759175666; x=1759780466;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MtPA+6dU4CCxMU2eK/4bdnBfarm4rw4G5s3tke0e2sk=;
        b=tY4zHfaWPcuIVLsjk+Nz34DN5ZWoSuWqOVV/qTPCypt19X6uwxRfVFy5dxNAzexxJI
         qdqOgcNs7h9hEdq+JioEKU7G80PJbZIsfDfRcr+tNvp7k4cTKwfUtOz+Ecyv/EE0wKUD
         K1JUdaMwRAdk6M+Hu2iAdTUmbw8sJM4Jp17oRtffruYC0aPeLz3AM7L9yj8CaOFgCOjO
         C7RV08gU6zUaLT0HkNRfMS41raw8BFkoeYNzLJ2gTNWJzllTBOeYV5tM55WKCcXG/ScO
         h2W6oslNhQnjFof/7vyNOPlmkRis0jtG2eNZj2gQNm5QuXPw+mAn1xkgplKRZx/ib8gF
         d3qg==
X-Forwarded-Encrypted: i=1; AJvYcCWhl3cD4Mm3AvNdDqaV6sF1jdOM0PjDNLXirJtaRlEEQCkvTj83OGp9NMg8lWhuB86dfG395IQfYgBbuC0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV/931z5nMFEI8MCgd0kO0mFMB9XPxwj2FzRriYbu6tMbLVk7j
	OVgyr6ACOU+CC13lYveWzdj9ZHLhXeY1Cmqyeo4tQBpwO5cCi9DbGyBdUhqP5A0PvQZtDOUmxcW
	mmCaziquT9OSGEGlbkLh/llR4aPmvq6alpOjyrEaELwgTmiXjd3evCeqmOf7LJul6mw==
X-Gm-Gg: ASbGncs6USpCweRuib1mAge3ijzdXwV2SfDnRjyiunFGHl4mlqeojhhTMG/43neDS72
	FHsjTrjcnC6/+UnPPqpqmSdNS5FhSgEIlN129wDOnsSikfC4bL+/GokJ32R4Jo+DPhYNpYz5M+m
	DFPsGLF3msbf/QFiONKSKIq8sYG/He2za4sMFfvnJKW5G+t0oazXFKurDsWEfk0LxrySIkcW2DO
	1ZTlWV6/EeKQn/VXnDyFF+amlgPH/fnFQx3k60upPPNU8DQ0qPeSprHhgUJQnFPa8AL2tBr5KNZ
	+5ed3YWn3+oiPB9SsvxYoy328CR0zMm67ZqjKZB3FFK03RGth0KolFMKiWKFNz4V3Btzc/OefE/
	7A30iWtdZnGf0YyYcPyQ1Pdqttfc4z3s=
X-Received: by 2002:ac8:57c9:0:b0:4b5:781c:883b with SMTP id d75a77b69052e-4da4dcc0865mr214473001cf.73.1759175665675;
        Mon, 29 Sep 2025 12:54:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3rXfc1pQBT6ofriZhAlQo27Y96yvwbHi4cZvFjayDhyDGYvTZaYgQnn2UmUxIX+Jm3FBmfg==
X-Received: by 2002:ac8:57c9:0:b0:4b5:781c:883b with SMTP id d75a77b69052e-4da4dcc0865mr214472691cf.73.1759175665315;
        Mon, 29 Sep 2025 12:54:25 -0700 (PDT)
Received: from redhat.com (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db09f19da2sm83348481cf.6.2025.09.29.12.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 12:54:23 -0700 (PDT)
Date: Mon, 29 Sep 2025 15:54:19 -0400
From: Brian Masney <bmasney@redhat.com>
To: Yun Zhou <yun.zhou@windriver.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, dianders@chromium.org,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: fix slab-use-after-free when
 clk_core_populate_parent_map failed
Message-ID: <aNrj60UeYQfXmlJ2@redhat.com>
References: <20250929083119.2066159-1-yun.zhou@windriver.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929083119.2066159-1-yun.zhou@windriver.com>
User-Agent: Mutt/2.2.14 (2025-02-20)

On Mon, Sep 29, 2025 at 04:31:19PM +0800, Yun Zhou wrote:
> If clk_core_populate_parent_map() fails, core->parents will be immediately
> released within clk_core_populate_parent_map(). Therefore it is can't be
> released in __clk_release() again.
> 
> This fixes the following KASAN reported issue:
> 
> ==================================================================
> BUG: KASAN: slab-use-after-free in __clk_release+0x80/0x160
> Read of size 8 at addr ffffff8043fd0980 by task kworker/u6:0/27
> 
> CPU: 1 PID: 27 Comm: kworker/u6:0 Tainted: G        W          6.6.69-yocto-standard+ #7
> Hardware name: Raspberry Pi 4 Model B (DT)
> Workqueue: events_unbound deferred_probe_work_func
> Call trace:
>  dump_backtrace+0x98/0xf8
>  show_stack+0x20/0x38
>  dump_stack_lvl+0x48/0x60
>  print_report+0xf8/0x5d8
>  kasan_report+0xb4/0x100
>  __asan_load8+0x9c/0xc0
>  __clk_release+0x80/0x160
>  __clk_register+0x6dc/0xfb8
>  devm_clk_hw_register+0x70/0x108
>  bcm2835_register_clock+0x284/0x358
>  bcm2835_clk_probe+0x2c4/0x438
>  platform_probe+0x98/0x110
>  really_probe+0x1e4/0x3e8
>  __driver_probe_device+0xc0/0x1a0
>  driver_probe_device+0x110/0x1e8
>  __device_attach_driver+0xf0/0x1a8
>  bus_for_each_drv+0xf8/0x178
>  __device_attach+0x120/0x240
>  device_initial_probe+0x1c/0x30
>  bus_probe_device+0xdc/0xe8
>  deferred_probe_work_func+0xe8/0x130
>  process_one_work+0x2a4/0x698
>  worker_thread+0x53c/0x708
>  kthread+0x1b4/0x1c8
>  ret_from_fork+0x10/0x20
> 
> Allocated by task 27:
>  kasan_save_stack+0x3c/0x68
>  kasan_set_track+0x2c/0x40
>  kasan_save_alloc_info+0x24/0x38
>  __kasan_kmalloc+0xd4/0xd8
>  __kmalloc+0x74/0x238
>  __clk_register+0x718/0xfb8
>  devm_clk_hw_register+0x70/0x108
>  bcm2835_register_clock+0x284/0x358
>  bcm2835_clk_probe+0x2c4/0x438
>  platform_probe+0x98/0x110
>  really_probe+0x1e4/0x3e8
>  __driver_probe_device+0xc0/0x1a0
>  driver_probe_device+0x110/0x1e8
>  __device_attach_driver+0xf0/0x1a8
>  bus_for_each_drv+0xf8/0x178
>  __device_attach+0x120/0x240
>  device_initial_probe+0x1c/0x30
>  bus_probe_device+0xdc/0xe8
>  deferred_probe_work_func+0xe8/0x130
>  process_one_work+0x2a4/0x698
>  worker_thread+0x53c/0x708
>  kthread+0x1b4/0x1c8
>  ret_from_fork+0x10/0x20
> 
> Freed by task 27:
>  kasan_save_stack+0x3c/0x68
>  kasan_set_track+0x2c/0x40
>  kasan_save_free_info+0x38/0x60
>  __kasan_slab_free+0x100/0x170
>  slab_free_freelist_hook+0xcc/0x218
>  __kmem_cache_free+0x158/0x210
>  kfree+0x88/0x140
>  __clk_register+0x9d0/0xfb8
>  devm_clk_hw_register+0x70/0x108
>  bcm2835_register_clock+0x284/0x358
>  bcm2835_clk_probe+0x2c4/0x438
>  platform_probe+0x98/0x110
>  really_probe+0x1e4/0x3e8
>  __driver_probe_device+0xc0/0x1a0
>  driver_probe_device+0x110/0x1e8
>  __device_attach_driver+0xf0/0x1a8
>  bus_for_each_drv+0xf8/0x178
>  __device_attach+0x120/0x240
>  device_initial_probe+0x1c/0x30
>  bus_probe_device+0xdc/0xe8
>  deferred_probe_work_func+0xe8/0x130
>  process_one_work+0x2a4/0x698
>  worker_thread+0x53c/0x708
>  kthread+0x1b4/0x1c8
>  ret_from_fork+0x10/0x20
> 
> The buggy address belongs to the object at ffffff8043fd0800
>  which belongs to the cache kmalloc-512 of size 512
> The buggy address is located 384 bytes inside of
>  freed 512-byte region [ffffff8043fd0800, ffffff8043fd0a00)
> 
> The buggy address belongs to the physical page:
> page:fffffffe010ff400 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffffff8043fd0e00 pfn:0x43fd0
> head:fffffffe010ff400 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> flags: 0x4000000000000840(slab|head|zone=1)
> page_type: 0xffffffff()
> raw: 4000000000000840 ffffff8040002f40 ffffff8040000a50 ffffff8040000a50
> raw: ffffff8043fd0e00 0000000000150002 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> 
> Memory state around the buggy address:
>  ffffff8043fd0880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffffff8043fd0900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >ffffff8043fd0980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                    ^
>  ffffff8043fd0a00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  ffffff8043fd0a80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ==================================================================
> 
> Fixes: 9d05ae531c2c ("clk: Initialize struct clk_core kref earlier")
> Signed-off-by: Yun Zhou <yun.zhou@windriver.com>

Is that the correct Fixes tag? What do you think about this instead?

Fixes: fc0c209c147f ("clk: Allow parents to be specified without string names")

Otherwise, the patch itself looks good to me.

Brian


