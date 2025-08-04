Return-Path: <linux-kernel+bounces-754912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6FEB19E55
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 11:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D63843B899A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 09:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D752459FE;
	Mon,  4 Aug 2025 09:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZBhjMpRd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D44F24466C
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 09:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754298350; cv=none; b=pj/3ABthcKmY4reNDB24bf/pRjhADxBqpyyjnRdSSivsvf/HW6PS6Djls/yJtVaHBLwecessOOdWZj3qSL71NW8meYrnLUzW0zZfUdNV+gSG5jaQ/Jt5P32NFbMZJiHNSVgaH18w2Kx3QjeoW4nI9JspoaNk1bMMRvPhITwY+F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754298350; c=relaxed/simple;
	bh=XLhLsuFvN8m1Yg7NOyWaE14zbAIU/cawTN2q8xnwqOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lVlwE3LV3CizElSAcSOjV8lTqsEGcm3zIZqo7WUWQqmNt39i51ppJTxG9+1HpNZGzrnGiVh4Z13VzfnJCy3bNapiEQwDvrCFDEhEPm5GwSrN8olemNuu8CuM5393sGRWgOkWqQaxnk4ZZ2S1EmlJfGnEuABBpP9xDw4i3prQNaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZBhjMpRd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754298347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hUiAVkdjLA4rx3xkvFei1yIOwvy8NbDquV7Km5sY9Sk=;
	b=ZBhjMpRdqCbfW6L48qOLmgewp5fBb5W4rYxjklzycQyL8FjYfHFjwXxVhszlSRNXF1YYRQ
	ai2IpHTHOAO7/75+oTjLkZpMxguy/Y7tRZk0K9d1OTQq+Pdr2sJ7WrfKvKALtX/VK2N8O9
	etaqBAxbfXrIApeb+b+p+BUau65kCmI=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-L7oYGzUDPhaYlK8Z4GQyTg-1; Mon, 04 Aug 2025 05:05:45 -0400
X-MC-Unique: L7oYGzUDPhaYlK8Z4GQyTg-1
X-Mimecast-MFC-AGG-ID: L7oYGzUDPhaYlK8Z4GQyTg_1754298345
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-31f030b1cb9so6809116a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 02:05:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754298344; x=1754903144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hUiAVkdjLA4rx3xkvFei1yIOwvy8NbDquV7Km5sY9Sk=;
        b=pXeJGZaaV7kLN+VnWNg8OIAHsFF6LuYHvQgImSZ/aaYFzcfhfwcQoDPH4IhukAb7hM
         nkqw4wiEuXTp7azVBuI2CF/9/VStLevtSXX8gLewfCVfi0BUygNKwK1xHvyzlbxDiD6R
         AmKLqoSw4nAb/T91jAgYkLz6ZzBLQgyW3L78k5fGEWi2mko6BaIHmBQ+hztJDHYBc62T
         kXWM2ojzLzOHvoozydmUupG+gAyk/+yGzkfCN5BpMwtIspFIzrjHHRxkZfyDNRgUam7M
         wMarsmAyCvPKsk3FDzHBlkx7Vhl5PoibPiB55+mPMElc83SVZmpYwiuTt5iRLoYkXycq
         t5/g==
X-Gm-Message-State: AOJu0Yz6x0xYJMem6ltoUqG90Z0R9IdHZuhSCG4UPlkwHI1ZuzJJ7Kiu
	CC9bKOoL5HtMFLHQQrzOTE9qwZ+WDsdjo8fIM8vFA1qE5lZ658smbJuKj7EnV7EK2Qf6T7YRNx1
	ig1Ey2WqXky5LIjX5uluJKnisFiTBktK0AjL/s94X4CxoNvfy/2mU3oppSJPiUq6/yLqB4II3py
	EK/msk5stISRFhMyjqRlwHZIuZd8Mi2RCY6kEVxLFIrKaGCMGGOJFe1w==
X-Gm-Gg: ASbGncudIGYvKc1mnd8ntdcHAvPVh+adZr26KDH55LGaANSFjGCjTykv/88DGzLLdhC
	gdIFQ5u7odhwyasBqVfNP7yKPB8UKyn/98zzb1fOXX+kSoQ1s+5AMEq0TWSXVb6RoRylUuw1ymO
	sjEXKcchFnT7t91iKyqVPxaA==
X-Received: by 2002:a17:90b:3886:b0:31e:f3b7:49d2 with SMTP id 98e67ed59e1d1-3211611bdf3mr13178693a91.0.1754298344194;
        Mon, 04 Aug 2025 02:05:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQXDenM37IDZnQLygl5VRDSWfhnz3pikcYYOWWnpyTXl5EIaDDvAQpHsuCb7nnF/VMi5edoCoc0hMP4IbCUIY=
X-Received: by 2002:a17:90b:3886:b0:31e:f3b7:49d2 with SMTP id
 98e67ed59e1d1-3211611bdf3mr13178651a91.0.1754298343708; Mon, 04 Aug 2025
 02:05:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c86063c7a1dc47ea679f45a5cabfc0378e4fdaea.camel@gmx.de>
In-Reply-To: <c86063c7a1dc47ea679f45a5cabfc0378e4fdaea.camel@gmx.de>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 4 Aug 2025 17:05:32 +0800
X-Gm-Features: Ac12FXzD1O8fk5ZO6JYisWA3U4VT9njcM8VQfcqrL64OIpaC7ZoXuFzZfagNNuA
Message-ID: <CACGkMEtog0jx0tR35L=6XXsyctDvGiN7YPC+OQVJBkaQ9886PA@mail.gmail.com>
Subject: Re: vhost: reproducible vvhost_net_release -> vhost_dev_cleanup ->
 host_dev_free_iovecs -> kfree -> KaBoOM
To: Mike Galbraith <efault@gmx.de>
Cc: lkml <linux-kernel@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mike:

On Mon, Aug 4, 2025 at 3:14=E2=80=AFPM Mike Galbraith <efault@gmx.de> wrote=
:
>
> Greetings,
>
> While trying to reproduce a possible sched issue Linus met, met the
> below reproducible LTP inspired crash instead.
>
> [ 3577.421177] Oops: general protection fault, probably for non-canonical=
 address 0x3fbf76982fc0008: 0000 [#1] SMP
> [ 3577.421195] CPU: 2 UID: 65534 PID: 8325 Comm: read_all Kdump: loaded N=
ot tainted 6.16.0.g186f3edf-master #182 PREEMPT(voluntary)  85e6fa82a94c1c6=
8749cb9dc59977997ab1f7c98
> [ 3577.421207] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 0=
9/23/2013
> [ 3577.421212] RIP: 0010:kfree+0x6f/0x360
> [ 3577.421220] Code: 80 48 01 d8 0f 82 fe 02 00 00 48 c7 c2 00 00 00 80 4=
8 2b 15 9b c2 ff 00 48 01 d0 48 c1 e8 0c 48 c1 e0 06 48 03 05 79 c2 ff 00 <=
48> 8b 50 08 49 89 c4 f6 c2 01 0f 85 1b 02 00 00 0f 1f 44 00 00 41
> [ 3577.421227] RSP: 0018:ffffd348c1cefc60 EFLAGS: 00010207
> [ 3577.421233] RAX: 03fbf76982fc0000 RBX: ff000000ff000000 RCX: 000000000=
0000000
> [ 3577.421238] RDX: 0000751f40000000 RSI: ffffffffc1c7cda3 RDI: ff000000f=
f000000
> [ 3577.421242] RBP: ffffd348c1cefca8 R08: ffff8ae1944c6ee8 R09: ffff8ae15=
4fc9250
> [ 3577.421246] R10: ffffd348c1cefc60 R11: ffffffffffffffff R12: ffff8ae14=
b9c0000
> [ 3577.421250] R13: ffff8ae146f7fb20 R14: ffff8ae1407c0cc0 R15: 000000000=
0000000
> [ 3577.421254] FS:  00007facec89e740(0000) GS:ffff8ae49b0e4000(0000) knlG=
S:0000000000000000
> [ 3577.421259] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 3577.421263] CR2: 00007efc8c7a5000 CR3: 000000010ec1b005 CR4: 000000000=
01726f0
> [ 3577.421268] Call Trace:
> [ 3577.421272]  <TASK>
> [ 3577.421278]  vhost_dev_free_iovecs+0x73/0x90 [vhost 3c674dad08c506310e=
daf87107e3d1cb15256ce4]
> [ 3577.421290]  vhost_dev_cleanup+0xa0/0x220 [vhost 3c674dad08c506310edaf=
87107e3d1cb15256ce4]
> [ 3577.421299]  vhost_net_release+0x47/0xe0 [vhost_net 4ef709b820ec57b610=
84d8295f282af45a90d07e]
> [ 3577.421306]  __fput+0xf4/0x2b0
> [ 3577.421313]  __x64_sys_close+0x3d/0x80
> [ 3577.421317]  do_syscall_64+0x7f/0xa10
>
> To reproduce, from LTP home directory:
>    testcases/bin/read_all -d /dev -p -q -r 3testcases/bin/read_all -d /de=
v -p -q -r 3
>
> Config attached.  The original was enterprise derived tune for maximum
> lard, this one is bisect ready (but execution unlikely today at least).
>
>         -Mike
>

I've posted a fix here:

https://lore.kernel.org/virtualization/f2d3027f-44d1-44d2-b89c-e01085c6d036=
@linux.ibm.com/T/#t

Thanks


