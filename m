Return-Path: <linux-kernel+bounces-854306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DBEBDE104
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 12:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C9D93A2B46
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 10:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63AEE315D59;
	Wed, 15 Oct 2025 10:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1pEoY+yP"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BEF31B119
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 10:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760524847; cv=none; b=m85/yESxxCFGcvC8rc+7/5dgNbUeuJ/FaVAbgerPW4dMG2LehYKlzAmTQd9/Znizdl5MEuzPnxJHpIdpxwJE515MMVHZ0tCY2cCc4LzoWvrMiiAH8sETO7T1GnjRLi2A9HaUJWksx9jEsxa/ZFepYzhWcDD5087qQkofFQJ7jVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760524847; c=relaxed/simple;
	bh=J3keoaIKR6jiGAqY3loIQe49C02ju3/VcU8EQo5I3NY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N++odzmfchsiKNZryoaFHYRrBM9yTo0osE6KY4LaPyzsHPw7uz62jVr4kultW3lmw82vyaxSz6+JQu1Wau7iomojP4zbY4WhGEU9uhQ7o3DUY+wcQKZ9uC98NH9rSE1rkVwpc715RVkVG4W6mf+xSp5MLPZuEMoeE8EB0oYGIEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1pEoY+yP; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-862cbf9e0c0so807018185a.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 03:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760524845; x=1761129645; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n0C67Rez8jNbQi/FTuBuwdBEEDVIvW5Ga9c16aQCFpE=;
        b=1pEoY+yPXy2R5ejKFaa1w/qbhpgbe900Igr9BkcdfIoLK1ScO/DHf56dUnevi1KNSw
         9/JCsnhBpSGI39Aws+YPMr5ha2Z4GJYBMPbxdKOcvfmb85EradyYa1ZFVXxYy1CpIXIX
         +ijFoE5XZEpQZMjs4MYtp1vSriDThOcaA4jND7vLkI9Lo7e3JUUY9winf64cZ5foM+bx
         8UF1wLnt1BZ6lO6gfqVNKNFlDDJ1ca3RbzKGZrbU3Hnsm/2D4F6SZJpRvBVnZMC6PYjN
         C5Si/IHajsMbly3APskzLHf4HMWx3RVsI9xLSFFBZVG1oFAmhM3wByXi+FacbqwfnEnp
         Ae+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760524845; x=1761129645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n0C67Rez8jNbQi/FTuBuwdBEEDVIvW5Ga9c16aQCFpE=;
        b=MQVPtNmhMVXtt2Y2Kmg4fzrk35icN8TKdrYFOAoQi/p2tipj8Lq+dZhqGP2J3FQD46
         b0QQ3bwyZj8Wnpoe7ZBrBL/7jU11nNeWRYzIYcTcx/Kpedh1vSweiarvmGhAZbJ+AOKq
         sv29L6CsGr5uOvve5WhqHPmOeNeXvn0Ifql76HBdzb7QiU5xTtHBSEpYko/5WmEzLVHm
         i7i5Pb5QZWFoSKAhqvbnfM7rwZ+57FKkM0V8r/ECzWcd28xgua6gLTeQ236Ktp87l955
         mH1muiHXyXw5Fsjp70WDcvsh9IHa0BfhZE0zpyjnt9r1xzKxQ+xa75N1sf69zdowX7WO
         gTBg==
X-Forwarded-Encrypted: i=1; AJvYcCXJ8/BciuPFPtrsG39RlB0wtr1G947X4OEKrxogVv0IbP+cPmab025MUkfOgkmJkUR2lTNgi8Oc5p4yWY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEtnOYTI4ICe0vrKURy2R5bMOKhWmMu2WM/J5WgyRxRpzASV2E
	lcSoF6yC1ATy6J4dy8J6xV4vxFyutxUFOZzwyxxeMrkQFddReZemOXEYoTxi3Mu98qYGgZ/XO5c
	E3BXoIg0SaOQx0+ANTF6+3nEl2/sqYL7JfhUvfaaO
X-Gm-Gg: ASbGncuRvj2ypgvnOZtHzNc+3IzTWIcXAeTl4IpaxR8jNJHkAw6szLjEVtdvljdRdOk
	Jprw13U3uVSLbzBIm056ylnmezUyYXjkZxo4YrnJ/4AC5yXbiEkf2pX9gNr1KE3pne+atn5Xji8
	u/XMLdkgTkI4WQlgyrGpUlEpSDs3c8V3mwolD2qlQQrWoECAfpb1nnHSqIojupKIIv8Ja6BsGLI
	qfSRTswUKJjRd9pF7puPzWb7zPW5uHHjA==
X-Google-Smtp-Source: AGHT+IFpKiB8l5sJXgqXrxFIDHsEAdxSp5hBT8fr88c6BsttKayM9LMDHyRVDEWhht18AqHem6pvE5WJNEYxAaTUh4Y=
X-Received: by 2002:ac8:5a0a:0:b0:4e8:8a5e:6dbf with SMTP id
 d75a77b69052e-4e88a5e712dmr10420031cf.83.1760524844485; Wed, 15 Oct 2025
 03:40:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015101417.1511732-1-wangliang74@huawei.com>
In-Reply-To: <20251015101417.1511732-1-wangliang74@huawei.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 15 Oct 2025 03:40:33 -0700
X-Gm-Features: AS18NWD7kex-EyZWDoaEndbSnHbz2_cerLFXLa6_UQRwZL16Wzh9UttwcoHnbxI
Message-ID: <CANn89iLZBMWpU7kMjd8akT+L8FbsnO+wqgjCaXF2KOCFz9Hiag@mail.gmail.com>
Subject: Re: [PATCH RFC net-next] net: drop_monitor: Add debugfs support
To: Wang Liang <wangliang74@huawei.com>
Cc: nhorman@tuxdriver.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, yuehaibing@huawei.com, 
	zhangchangzhong@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 2:51=E2=80=AFAM Wang Liang <wangliang74@huawei.com>=
 wrote:
>
> This patch add debugfs interfaces for drop monitor. Similar to kmemleak, =
we
> can use the monitor by below commands:
>
>   echo clear > /sys/kernel/debug/drop_monitor/trace
>   echo start > /sys/kernel/debug/drop_monitor/trace
>   echo stop  > /sys/kernel/debug/drop_monitor/trace
>   cat /sys/kernel/debug/drop_monitor/trace
>
> The trace skb number limit can be set dynamically:
>
>   cat /sys/kernel/debug/drop_monitor/trace_limit
>   echo 200 > /sys/kernel/debug/drop_monitor/trace_limit
>
> Compare to original netlink method, the callstack dump is supported. Ther=
e
> is a example for received udp packet with error checksum:
>
>   reason   : UDP_CSUM (11)
>   pc       : udp_queue_rcv_one_skb+0x14b/0x350
>   len      : 12
>   protocol : 0x0800
>   stack    :
>     sk_skb_reason_drop+0x8f/0x120
>     udp_queue_rcv_one_skb+0x14b/0x350
>     udp_unicast_rcv_skb+0x71/0x90
>     ip_protocol_deliver_rcu+0xa6/0x160
>     ip_local_deliver_finish+0x90/0x100
>     ip_sublist_rcv_finish+0x65/0x80
>     ip_sublist_rcv+0x130/0x1c0
>     ip_list_rcv+0xf7/0x130
>     __netif_receive_skb_list_core+0x21d/0x240
>     netif_receive_skb_list_internal+0x186/0x2b0
>     napi_complete_done+0x78/0x190
>     e1000_clean+0x27f/0x860
>     __napi_poll+0x25/0x1e0
>     net_rx_action+0x2ca/0x330
>     handle_softirqs+0xbc/0x290
>     irq_exit_rcu+0x90/0xb0
>
> It's more friendly to use and not need user application to cooperate.
> Furthermore, it is easier to add new feature. We can add reason/ip/port
> filter by debugfs parameters, like ftrace, rather than netlink msg.

I do not understand the fascination with net/core/drop_monitor.c,
which looks very old school to me,
and misses all the features,  flexibility, scalability  that 'perf',
eBPF tracing, bpftrace, .... have today.

Adding  /sys/kernel/debug/drop_monitor/* is even more old school.

Not mentioning the maintenance burden.

For me the choice is easy :

# CONFIG_NET_DROP_MONITOR is not set

perf record -ag -e skb:kfree_skb sleep 1

perf script # or perf report

