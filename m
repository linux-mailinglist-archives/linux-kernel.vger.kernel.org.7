Return-Path: <linux-kernel+bounces-746373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD262B125E3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 22:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DF954E4ADB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D7925BEE1;
	Fri, 25 Jul 2025 20:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TqtyCYJR"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FAC25B1F4
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 20:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753477006; cv=none; b=GgR0DMP+tPy1DcsS3HLzO3+fr9PBHs6fiASLfGuwmB0mmPTelXE9vN5TvrCJW97IfVD/BSyPygcfC269JxbYSKmlTVzKT7r/Kj3KAxsw8/nF3UKLxqR1kSmyi5U7fS+Q9c2NsorEYikV4RXDg5dLXNmQHtLJf86h088AeUE/whU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753477006; c=relaxed/simple;
	bh=ISQVMQ+6UGe/JRiSEdFRVWEuwFrTGkBZB+uGAoDQFJ8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=YOkDAN68p2R30TBlHAzdUcXH7XLZbRwj7w9kSKuNH0dnJEOHFohNRFmf8towB7Z5sj1OrzgxCxyZZ5fBbyH6NECXU1yotVQzIJLd1fdZ5l6EOggSeo14//NQMoa9tKP+3f0f7FuLBahIxm8+cOGvctz5YvxQzwCyaEYZkRVToas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TqtyCYJR; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753476991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5MzeVu9MblIz/dg6abSEtLXGpg6w+W/U0C9TJJ7ePW4=;
	b=TqtyCYJRApMe8THfUf0ItZVlHY2rcpwlLjrkBOA8j7KkIFj7c+Lj28wFEn7yjYYc9HgyLo
	X21f+KqKAKrqt0b7dItnmYY2kZqHDBnp/uXf4+QzCbH4PIvf+Y+p5aLgUlo/WG/89dqQxY
	EtH9/ywMBfYubwaMSd+zTHWYzbfC9no=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH V4 19/19] virtio_ring: add in order support
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <20250724064017.26058-20-jasowang@redhat.com>
Date: Fri, 25 Jul 2025 13:56:15 -0700
Cc: mst@redhat.com,
 xuanzhuo@linux.alibaba.com,
 eperezma@redhat.com,
 virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E08AB80C-D1A7-483E-9424-4F893B7161B5@linux.dev>
References: <20250724064017.26058-1-jasowang@redhat.com>
 <20250724064017.26058-20-jasowang@redhat.com>
To: Jason Wang <jasowang@redhat.com>
X-Migadu-Flow: FLOW_OUT

Hi Jason,

On 23. Jul 2025, at 23:40, Jason Wang wrote:
>=20
> This patch implements in order support for both split virtqueue and
> packed virtqueue. Perfomance could be gained for the device where the
> memory access could be expensive (e.g vhost-net or a real PCI device):
>=20
> Benchmark with KVM guest:
>=20
> Vhost-net on the host: (pktgen + XDP_DROP):
>=20
>         in_order=3Doff | in_order=3Don | +%
>    TX:  5.20Mpps     | 6.20Mpps    | +19%
>    RX:  3.47Mpps     | 3.61Mpps    | + 4%
>=20
> Vhost-user(testpmd) on the host: (pktgen/XDP_DROP):
>=20
> For split virtqueue:
>=20
>         in_order=3Doff | in_order=3Don | +%
>    TX:  5.60Mpps     | 5.60Mpps    | +0.0%
>    RX:  9.16Mpps     | 9.61Mpps    | +4.9%
>=20
> For packed virtqueue:
>=20
>         in_order=3Doff | in_order=3Don | +%
>    TX:  5.60Mpps     | 5.70Mpps    | +1.7%
>    RX:  10.6Mpps     | 10.8Mpps    | +1.8%
>=20
> Benchmark also shows no performance impact for in_order=3Doff for =
queue
> size with 256 and 1024.
>=20
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---

This is in linux-next now, but I get the following compilation error:

drivers/virtio/virtio_ring.c:2113:40: error: variable 'id' is =
uninitialized when used here [-Werror,-Wuninitialized]
 2113 |                 BAD_RING(vq, "id %u out of range\n", id);
      |                                                      ^~
drivers/virtio/virtio_ring.c:60:32: note: expanded from macro 'BAD_RING'
   60 |                         "%s:"fmt, (_vq)->vq.name, ##args);      =
\
      |                                                     ^~~~
./include/linux/dev_printk.h:154:65: note: expanded from macro 'dev_err'
  154 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, =
dev_fmt(fmt), ##__VA_ARGS__)
      |                                                                  =
      ^~~~~~~~~~~
./include/linux/dev_printk.h:110:23: note: expanded from macro =
'dev_printk_index_wrap'
  110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                =
       \
      |                                     ^~~~~~~~~~~
drivers/virtio/virtio_ring.c:2077:19: note: initialize the variable 'id' =
to silence this warning
 2077 |         u16 last_used, id, last_used_idx;
      |                          ^
      |                           =3D 0
1 error generated.

Thanks,
Thorsten


