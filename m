Return-Path: <linux-kernel+bounces-820228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E2DB7F58D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22E693AE374
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 08:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D4F3090F5;
	Wed, 17 Sep 2025 08:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OnvEYXJj"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A77306B1F
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 08:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758097215; cv=none; b=YTVwQSMEUqEXS9Cn/7sSOqDk1PM+ro2FVI94NJ7Poa0y7Zr7r0hSJf4DzkRj+Vh2FGiaRZNLcx5CEzosnHmCeQ2dV6cvRdFQ0S9OqRCnGYQ5A6AYF17xciOBXzSweW8uMJR3RJ8EHxe09ilpEIifHaozWwg1S97yV39vT+WfPPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758097215; c=relaxed/simple;
	bh=DvsldGskwe7bNZdCNM6b57h99t1SlEsl5eYl/1MgupA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=UkDLLQelwvCj3IkZoQqDx3m2oJv/sqt9JQByp9J9BDqSSuX1uij/kcn5aSanYomce4Tyb2a6OFacqDe+HVSVyC1OyqKA7AqT/ZIQ5hs0/Y8XwjPpAZya83blQuQtypDhSPVfChGJqDWW4uCt54LYFfoOqTLT9ljw0ACVv/+ny8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OnvEYXJj; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-76e6cbb991aso5887656b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 01:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758097213; x=1758702013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=plALJuwISe+CKBv7MdrVqcBAxbqlVW0Bn8MN5VSJY8w=;
        b=OnvEYXJjiKC/R6ouZzaWx2LziOUp8O1S/NAM+tsfH4HZLLAi9e39FhZV+ARyfwAk4f
         nrXCUVfaY1ANtRDscpqB3ix9cExDmeeoA9iFiyicWqRxtnO4ilSyCgAR9RXocX/RliSo
         cKlGXnaei0LMLQyehXr9sZXhv86RmwWgkoafqwdj6PMPZ80jrX6egENjHgwOeNgVQBvM
         1znvdolLigv2GhWOAAB+C+O1g1F9wrGxCJn9gE0KDJtCXvBwJXjjjTImUR6qPcA4ZKyg
         cNs35hDV5qquXkxD3kFeKbEH+j9vAtF0Hsn3KloIcuA/mMn2vy94OsrqMgkWASq4fqiP
         sENQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758097213; x=1758702013;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=plALJuwISe+CKBv7MdrVqcBAxbqlVW0Bn8MN5VSJY8w=;
        b=vTH+HVmYNeHsBgbvFM94unjYCoWGDzt4+VOel2gC6dRghiJB9O+LxrKTeV975/M9Wa
         h+gce2yPMZE9LNUIYdadOysPVOBODILiPP0KPU6l0P9hvtwQ9FEvHm7A3kUQEKsjxich
         9rJLG4wdnJ4Dgssb8vO3NLAWkxIogoaHDkvX7/6V/lgInQl++u0RbngrwmetSVxarygY
         O74E+oxGQLGwz7ORSpSiaZqMTsiJkOCSfGvAIH9vi+pb/IYxqqb22IXO/yHU/AILHl0e
         GbOTvgD9n03Hg4vhTQVimYgZDZn97TY18SRXhhPcBA4hgJd1ZJMFDwWJBprEjIjEHq0w
         EF2A==
X-Forwarded-Encrypted: i=1; AJvYcCVbS9ZIQBSaE68uwkgtw9Efg7OJE/L34mUGRFmjlgXk5WkwH/swshaRsomdiycd9UICK166NdqCjPrHyh0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5KcrHvS6ly2wmhlUadzmPl/+FR/CDW0vN61IKKwrA7iptt5I9
	l/GvJyVkykfNpuemusIEcfZJ41lM8YtEYcivg6jNV8NhBrxricSAoO13
X-Gm-Gg: ASbGncufQfQeTN1hY9jHDYAtlHKLDVlVjNfZOPDnKvtfHZunBr8iibqHbeVzKG+uBnB
	hDMj2SYHue8ol8x3RSGLL99u9MlQGKxp7aPWQeaFn5D3BwnPNETjiu+C5Vs0eiNwHGAOxbjZlNZ
	Ey2WEywKSeD7w6lKKr70PH5FsHzxU5W9o7bEKgYNldN1s8CH0PxYT7vdoCXe/MjbaiwBS74r88x
	Zdei71ChRrUo53LrzsR9YditA93Pql/7uLYkVqKT5ojFx9D7BgrKxXyDrzwEoG9RRVZjdcYpgw9
	Ih/CEVhW4abOobRRCUAxYbe0RXuIvdOhzOs4NcH5QLsQJhroS5RzQBYQ7h8nG4ZKlUOFMl8E9sr
	5VK/0kQ0obVJWNg/+K+cWBH93Yzsd0VEZhMo=
X-Google-Smtp-Source: AGHT+IGXTqXi5/oKOuNJkyWQroVyhauuyjO0/0kVNO/Ok5QEBRkeeZWwJb8nEKAeBneaygeEj1Byhg==
X-Received: by 2002:a05:6a20:1594:b0:240:1ad8:1821 with SMTP id adf61e73a8af0-27a9586ba61mr1835791637.19.1758097213513;
        Wed, 17 Sep 2025 01:20:13 -0700 (PDT)
Received: from [183.173.12.7] ([183.173.12.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-776158bc82fsm14818579b3a.23.2025.09.17.01.20.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 01:20:13 -0700 (PDT)
Message-ID: <5724b1b3-05c2-41fe-8f5c-879b3e6fd318@gmail.com>
Date: Wed, 17 Sep 2025 16:19:25 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Tuo Li <islituo@gmail.com>
Subject: [BUG] net: plip: a possible race in plip_preempt() leading to UAF
To: andrew+netdev@lunn.ch, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 boehm.jakub@gmail.com
Cc: netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

While analyzing Linux 6.16 with a static analysis tool, I noticed a
potential data race in plip_preempt() that may lead to a use-after-free.

Consider the following execution sequence in drivers/net/plip.c:

1. In plip_preempt(), nl->connection is checked to be not PLIP_CN_NONE and
nl->port_owner is set to 0 at Line 1184, indicating that the bus can be
released.

2. Before returning, an interrupt occurs and plip_interrupt() is invoked.

3. Inside plip_interrupt(), rcv->state is set to PLIP_PK_TRIGGER at Line
949 and nl->connection is updated to PLIP_CN_RECEIVE. Then plip_bh() is
scheduled at Line 952.

4. If plip_bh() runs and the parport bus has been preempted by another
device, the subsequent call to plip_receive_packet() at Line 376 may access
released resources, leading to a potential UAF.

One possible way to prevent this race is to hold nl->lock while updating
nl->port_owner in plip_preempt():

  static int
  plip_preempt(void *handle)
  {
    struct net_device *dev = (struct net_device *)handle;
    struct net_local *nl = netdev_priv(dev);
    unsigned long flags;

    spin_lock_irqsave (&nl->lock, flags);

    /* Stand our ground if a datagram is on the wire */
    if (nl->connection != PLIP_CN_NONE) {
        nl->should_relinquish = 1;
        spin_unlock_irqrestore(&nl->lock, flags);
        return 1;
    }

    nl->port_owner = 0; /* Remember that we released the bus */
    spin_unlock_irqrestore(&nl->lock, flags);
    return 0;
  }

Additionally, plip_receive_packet() (Line 376) may need to verify that
nl->port_owner is still valid before accessing the bus.

However, I am unsure how to proceed once nl->port_owner is found to be 0,
so I am reporting this as a possible bug.

I am also not sure whether this possible data race is real. Any feedback
would be appreciated, thanks!

Best wishes,
Tuo Li


