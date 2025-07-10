Return-Path: <linux-kernel+bounces-725245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4756BAFFC6B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F727B40545
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 08:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC6528B504;
	Thu, 10 Jul 2025 08:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qc+UygCz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CFA28C5BC
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 08:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752136258; cv=none; b=iNVv8cNOqZRxqG+ABLp6kKdwmbKWJbsryMUaqxnkBx5T+qO44FO0fzFw0TXOOxCB1aybN/oFkNmzRVvqJS0XxXiFbCly8OGDAy2JMkpKHXOud7t0SYa0Wid1eRl6oe+3BTEcyBHJQMQE7k5fYezW2f58sT/F5Uwjun2lV/CetCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752136258; c=relaxed/simple;
	bh=MGRu2+QngwLs5uFhX6yStKHd0N3yjjMo437iKPhLRpQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uOXhDeyfDKVHFZHZhPMlL5ywUYNgw6S4srcBpgjHGJTMsQWT6CjOg1WUvV2PQ7HAg9OR4a5ta6mXstAe3uo1txSX+XXAPtLfKXa87fckbo8CehbwvRntxM943r/FBv2In4HrytcBeAkPPfymGbTEmE2HUlPHvpWlETsKEh1Kuyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qc+UygCz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752136255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2K9+/07FmEiqTT+1vCXL7HOUD62rjsYkPTRRSfZI4VU=;
	b=Qc+UygCznySEPjA1DWfI0tMbQ2ba8KkR+Up2w9uWnyv342yuhble0/DxJFWnpGwh7MrdgQ
	y96iw9vzpsuNFKR22YNxVnwUwmDS/HKBQp2a26JHNZaX35PxJmOf1863p/XhJXwgBNdI1m
	Py7G07+jHWrNthlArQE5CdIq8cZY+Yo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-VOPTSVITMOyNuyAvml15qQ-1; Thu, 10 Jul 2025 04:30:53 -0400
X-MC-Unique: VOPTSVITMOyNuyAvml15qQ-1
X-Mimecast-MFC-AGG-ID: VOPTSVITMOyNuyAvml15qQ_1752136252
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-451deff247cso8574565e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 01:30:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752136252; x=1752741052;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2K9+/07FmEiqTT+1vCXL7HOUD62rjsYkPTRRSfZI4VU=;
        b=AZ6uU/XaeQbSUIwcibes91ShC5oe07uAx7kqoHvFPn6sJ7p2lf8OxEKPA8wGDPhR4+
         ZEDhcmU7ysQhxIIwQ2VcyQtsbuZQpDRy4+Y6E+NU4LE5h1IrQJGdsB9ldOz+BC/IfEO1
         dTSvfY0Ngj9MLIt/wszIWnA1ilbtRU67kWYQ2OvW4azv1a8Z/RGV3VcehrtZkrgx56TC
         ncxvxvPQuehgiAyYSLZsqiPFR1v59Gwz8fY2odKWEdVR0xM80Xrf1ej+gXhIzDwDu0Ek
         RACRe0rHVhodphcMnLJcvDRgKe57KPcfiGC2VYN5Ixxx9kI1jok95YSEdgC2SZ81VT6M
         9/yA==
X-Forwarded-Encrypted: i=1; AJvYcCUC+QPMcbdoySHqpiKL/7EfIlhdG0q5pQGnvg8hchyOFgG/oE2OQ9tafzr8gEtFMjtQ+8oeU0qRIdmm4Bs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWQBJsTKK3ZsZBAHwtrwKn3yDjtScOqBsYlgqtzK08h6eSaE9U
	qNoEdyv8Ke3nbcsaAchu4ycRxZM2HZGTWJ8Oy0IR5IWLjlKAPn8twPDLJq1bXlJ7fgWYDpG68/Q
	wB4uan/9CR+M0AzlKHIDiQJN/jsNIK92PYdXiLotVf6xqU6A70H1Pvs1t6Dv827rWAA==
X-Gm-Gg: ASbGnctKKON2FRk7KknKhYEy/ZopNyo/9PVewmed4Ghf3woiavcJv0myEnR/8siqaoY
	VJfyykiN9oZMz8Tcgc+ZKWp6XHOw4HJebS/8+uR3hWDNLkVDeonJv0GdXNtLtTdxJ1vzSQkpJdI
	4xubKo8HXsv28x2uWypPLXH0X9UWc+DTz1E69kCslYbwLOXc2RXZnD4p6vR+Enp3yUGdiU6sxM8
	UykzgasNweOErKt40DyAEewuYoyH1RxaMslQdvD28IA0IIxzgWPngf9fvAONBmopdUIUv+l5wjL
	dl2iFJn+rEa+rzt44ISSAkTGUsPCOima1T14/GrQ8c9qdMYu3wATYMnh/I7z4vihZub2Lw==
X-Received: by 2002:a05:600c:4746:b0:453:84a:e8d6 with SMTP id 5b1f17b1804b1-454db8815a6mr26571235e9.1.1752136251816;
        Thu, 10 Jul 2025 01:30:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfmngUjFtTpgc3VNRVQxUoFiGh7p4WIxZ5kf23OkSlRKWn+OvYDDDdXEdex3RWzzxe0vUghw==
X-Received: by 2002:a05:600c:4746:b0:453:84a:e8d6 with SMTP id 5b1f17b1804b1-454db8815a6mr26570895e9.1.1752136251383;
        Thu, 10 Jul 2025 01:30:51 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:271f:bc10:144e:d87a:be22:d005? ([2a0d:3344:271f:bc10:144e:d87a:be22:d005])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d575cbbfsm47859325e9.32.2025.07.10.01.30.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 01:30:50 -0700 (PDT)
Message-ID: <d86d4ca3-5d3e-461f-ac8a-9d8715413dcf@redhat.com>
Date: Thu, 10 Jul 2025 10:30:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] virtio-net: fix a rtnl_lock() deadlock during
 probing
To: Zigit Zo <zuozhijie@bytedance.com>, mst@redhat.com, jasowang@redhat.com,
 xuanzhuo@linux.alibaba.com, eperezma@redhat.com
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250702103722.576219-1-zuozhijie@bytedance.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250702103722.576219-1-zuozhijie@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/2/25 12:37 PM, Zigit Zo wrote:
> This bug happens if the VMM sends a VIRTIO_NET_S_ANNOUNCE request while
> the virtio-net driver is still probing with rtnl_lock() hold, this will
> cause a recursive mutex in netdev_notify_peers().
> 
> Fix it by temporarily save the announce status while probing, and then in
> virtnet_open(), if it sees a delayed announce work is there, it starts to
> schedule the virtnet_config_changed_work().
> 
> Another possible solution is to directly check whether rtnl_is_locked()
> and call __netdev_notify_peers(), but in that way means we need to relies
> on netdev_queue to schedule the arp packets after ndo_open(), which we
> thought is not very intuitive.
> 
> We've observed a softlockup with Ubuntu 24.04, and can be reproduced with
> QEMU sending the announce_self rapidly while booting.
> 
> [  494.167473] INFO: task swapper/0:1 blocked for more than 368 seconds.
> [  494.167667]       Not tainted 6.8.0-57-generic #59-Ubuntu
> [  494.167810] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  494.168015] task:swapper/0       state:D stack:0     pid:1     tgid:1     ppid:0      flags:0x00004000
> [  494.168260] Call Trace:
> [  494.168329]  <TASK>
> [  494.168389]  __schedule+0x27c/0x6b0
> [  494.168495]  schedule+0x33/0x110
> [  494.168585]  schedule_preempt_disabled+0x15/0x30
> [  494.168709]  __mutex_lock.constprop.0+0x42f/0x740
> [  494.168835]  __mutex_lock_slowpath+0x13/0x20
> [  494.168949]  mutex_lock+0x3c/0x50
> [  494.169039]  rtnl_lock+0x15/0x20
> [  494.169128]  netdev_notify_peers+0x12/0x30
> [  494.169240]  virtnet_config_changed_work+0x152/0x1a0
> [  494.169377]  virtnet_probe+0xa48/0xe00
> [  494.169484]  ? vp_get+0x4d/0x100
> [  494.169574]  virtio_dev_probe+0x1e9/0x310
> [  494.169682]  really_probe+0x1c7/0x410
> [  494.169783]  __driver_probe_device+0x8c/0x180
> [  494.169901]  driver_probe_device+0x24/0xd0
> [  494.170011]  __driver_attach+0x10b/0x210
> [  494.170117]  ? __pfx___driver_attach+0x10/0x10
> [  494.170237]  bus_for_each_dev+0x8d/0xf0
> [  494.170341]  driver_attach+0x1e/0x30
> [  494.170440]  bus_add_driver+0x14e/0x290
> [  494.170548]  driver_register+0x5e/0x130
> [  494.170651]  ? __pfx_virtio_net_driver_init+0x10/0x10
> [  494.170788]  register_virtio_driver+0x20/0x40
> [  494.170905]  virtio_net_driver_init+0x97/0xb0
> [  494.171022]  do_one_initcall+0x5e/0x340
> [  494.171128]  do_initcalls+0x107/0x230
> [  494.171228]  ? __pfx_kernel_init+0x10/0x10
> [  494.171340]  kernel_init_freeable+0x134/0x210
> [  494.171462]  kernel_init+0x1b/0x200
> [  494.171560]  ret_from_fork+0x47/0x70
> [  494.171659]  ? __pfx_kernel_init+0x10/0x10
> [  494.171769]  ret_from_fork_asm+0x1b/0x30
> [  494.171875]  </TASK>
> 
> Fixes: df28de7b0050 ("virtio-net: synchronize operstate with admin state on up/down")
> Signed-off-by: Zigit Zo <zuozhijie@bytedance.com>

@Micheal: I think this addresses your concerns on v1, WDYT?

/P


