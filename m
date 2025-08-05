Return-Path: <linux-kernel+bounces-756040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6BBB1AF07
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 09:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 086D9189C0F1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 07:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A25222A4E1;
	Tue,  5 Aug 2025 07:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="em3MNbut"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B3842A82
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 07:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754377264; cv=none; b=UpXe3cZcRAJ/40SqPcDG+uk9jOUhBaT8WFbCNnCM/kXF0GfYK63BEfrKgnKpnzN/j5mLTktfp6NvDDe4YTbUnnO/j7TT/pIHU9OGNhSYDgQ/wuvqPJQCrMR4B0PNTeIvODnAg/3sbum5HoOhxsmaoafrN6u0eITbMJwnrs/SKk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754377264; c=relaxed/simple;
	bh=ygCeSeAh0m+wHTDyfFMhYQdNXoKy++DrVVWSwBZlVqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RhSdBc/TvQX9Gk5H9gqlUqAvcDt/NeMhvTQCZjFGyvFqHwfNJ8k4udS4AP7zfz84F0KmtKLnlv+gSCdPaNb1vKQe41FQ/82d0gEb9h5vzsa6h6FF/rhsgExUttNWFWZtkXUD6B3G7F3mX0zRxKZQ+2LnfUk+EjnByqYSXkn7ABc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=em3MNbut; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754377262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dSIbGepWdDgc96njCuHhSUJPUf+KzluXS7gRDoPBvAM=;
	b=em3MNbutoTNo2BAB8nE22QYAhUJu62kIfUkskfAvxFKKlwX/U+3SaWZALTdTw+bJFlIvYD
	CAwknnc7fUOUj/0X9jjUZSArob3MDnqiV6LkhCUt4tDne+sqfkMsDH1rthxAaktwZxGe+O
	FkduSuHiovqFi38YMx5gylNrr+suaWQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-t99-JqKgMBSbdjbrr8xFLw-1; Tue, 05 Aug 2025 03:01:01 -0400
X-MC-Unique: t99-JqKgMBSbdjbrr8xFLw-1
X-Mimecast-MFC-AGG-ID: t99-JqKgMBSbdjbrr8xFLw_1754377261
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e7ffcbce3bso433699985a.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 00:01:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754377261; x=1754982061;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dSIbGepWdDgc96njCuHhSUJPUf+KzluXS7gRDoPBvAM=;
        b=hXJLamisAs8htSPNPTjfRKrnyUGzentWJIkk21Ck1HMptUQ4qPoKeCV1te4A95lWxj
         FPnvaolt9P/JwDsdvRqAMxsyKASaDxp7dQWf3WQP8BG55825omcBDmXoF6z5MCBrG/AR
         bPeJFAfx/yrpDwzPNdXqJK1GSmMJo7drSepYhcSTMp1tK0P0JKY31Lo/D7jnO62NAJll
         5IsYJZShwXSVDRzsa4PWC9hYzlNnYcbwNP5FIDprvIhQ9Lq8SJZ1/CAseKTHV/7wv/GQ
         q1odDQvWlT8eJUj7xBaKKT4Sywvtn+H9bwHD9hTYK7bXV0eEhevICPWxS2cqfcB/xGHF
         JpfA==
X-Forwarded-Encrypted: i=1; AJvYcCWbMUFO6POxoRVH/7maTrCvlV5jgZorNeZEoEt8xUExzOutvRy6tBgW8LMO7SU4uX+FYX30YTQ2fxyf7Ps=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG9KOYG51bsnFPZn9VQWKiTBt/erZ/fsz1yvyBesvROO1BDGMh
	LVL9W7Y4ppOvsfWGxTGGGEginj6hNQy5ThyEoDy5FazSdkIqohQuDUTtRpyEYtnIXigcqkbK6iY
	zyek9A2A0xW+v0YG+x1ctS1zWEo68lgOQRW2tjHI68+GEDvYCeLijHZ84s9Je8g1XZg==
X-Gm-Gg: ASbGncsep7E1T7E9i+2TIhbrot5e8jNE2OVdUwwN1mB1hpFDTCG28soUFYavx2+V7XZ
	WiMqqbTm6ALekVx4uosIRSJ2EU6HGmO14O9Y587Rrg3NvX1crAMvqEl7qzmnM27GdwZPQI0WuBc
	q85vZs8kPCmqYS4BbAdo5p9046Yq63Xqy8zzcwDYY38xBE8WEgLIOOHNtu23sOKHXKFIkVhHrxj
	jYpXv45i+mprhFsQEDte2dCOGNacpQNF52mQ6hcCKTc87m3Oe/hFAEVwcaxvtXgR7rfiXZpgY2G
	MhxWmLwfV9buT0kEiHHe+W4B8KJLbQPBhdDNBtAtCw9cIoLPTERm3to85upNyepa3J6DWAKSq3l
	h68g7qeOtxM4qt2Q=
X-Received: by 2002:a05:620a:916:b0:7e6:856d:bcb with SMTP id af79cd13be357-7e69625cd59mr1302046885a.6.1754377260580;
        Tue, 05 Aug 2025 00:01:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbo+rLta4n3tR1EMLfUV+fq1PsfLHsTA6oRYI7oXpPQbjgFFKmF+wjy0WLjzOdJ4+LHAbjcg==
X-Received: by 2002:a05:620a:916:b0:7e6:856d:bcb with SMTP id af79cd13be357-7e69625cd59mr1302041885a.6.1754377260042;
        Tue, 05 Aug 2025 00:01:00 -0700 (PDT)
Received: from sgarzare-redhat (host-79-45-205-118.retail.telecomitalia.it. [79.45.205.118])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e67f5b528bsm637184485a.21.2025.08.05.00.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 00:00:59 -0700 (PDT)
Date: Tue, 5 Aug 2025 09:00:50 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: bsdhenrymartin@gmail.com
Cc: huntazhang@tencent.com, jitxie@tencent.com, landonsun@tencent.com, 
	stefanha@redhat.com, mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Henry Martin <bsdhenryma@tencent.com>, TCS Robot <tcs_robot@tencent.com>
Subject: Re: [PATCH v1] VSOCK: fix Information Leak in
 virtio_transport_shutdown()
Message-ID: <4sbamls46k3dxlqgreifhhhd66iaosbeoxgbpyvwaipwlnwiba@dep4mseknust>
References: <20250805051009.1766587-1-tcs_kernel@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250805051009.1766587-1-tcs_kernel@tencent.com>

On Tue, Aug 05, 2025 at 01:10:09PM +0800, bsdhenrymartin@gmail.com wrote:
>From: Henry Martin <bsdhenryma@tencent.com>
>
>The `struct virtio_vsock_pkt_info` is declared on the stack but only
>partially initialized (only `op`, `flags`, and `vsk` are set)
>
>The uninitialized fields (including `pkt_len`, `remote_cid`,
>`remote_port`, etc.) contain residual kernel stack data. This structure
>is passed to `virtio_transport_send_pkt_info()`, which uses the
>uninitialized fields.
>
>Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")
>Reported-by: TCS Robot <tcs_robot@tencent.com>
>Signed-off-by: Henry Martin <bsdhenryma@tencent.com>
>---
> net/vmw_vsock/virtio_transport_common.c | 15 +++++++--------
> 1 file changed, 7 insertions(+), 8 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index fe92e5fa95b4..cb391a98d025 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1073,14 +1073,14 @@ EXPORT_SYMBOL_GPL(virtio_transport_connect);
>
> int virtio_transport_shutdown(struct vsock_sock *vsk, int mode)
> {
>-	struct virtio_vsock_pkt_info info = {
>-		.op = VIRTIO_VSOCK_OP_SHUTDOWN,
>-		.flags = (mode & RCV_SHUTDOWN ?
>-			  VIRTIO_VSOCK_SHUTDOWN_RCV : 0) |
>-			 (mode & SEND_SHUTDOWN ?
>-			  VIRTIO_VSOCK_SHUTDOWN_SEND : 0),
>-		.vsk = vsk,
>-	};

The compiler sets all other fields to 0, so I don't understand what this 
patch solves.
Can you give an example of the problem you found?

Furthermore, even if this fix were valid, why do it for just one 
function?

Stefano

>+	struct virtio_vsock_pkt_info info = {0};
>+
>+	info.op = VIRTIO_VSOCK_OP_SHUTDOWN;
>+	info.flags = (mode & RCV_SHUTDOWN ?
>+			VIRTIO_VSOCK_SHUTDOWN_RCV : 0) |
>+			(mode & SEND_SHUTDOWN ?
>+			VIRTIO_VSOCK_SHUTDOWN_SEND : 0);
>+	info.vsk = vsk;
>
> 	return virtio_transport_send_pkt_info(vsk, &info);
> }
>-- 
>2.41.3
>


