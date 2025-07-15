Return-Path: <linux-kernel+bounces-731618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B009B0573C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 11:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47B44188C891
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 09:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF41F2D542A;
	Tue, 15 Jul 2025 09:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PIxct8Vo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3B41E487
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 09:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752573381; cv=none; b=FReA91HJk6PctF98HqwfWGB8ZJpKlsLeEqjM6Y01PH8+pz3EPXlseKO8NujyOwMhJ8jFa+7sONpj3NrgH8eO8afWekvRE3Tqn9R7VmP6/uUZLV0BJDKPNWROpX6bHCQTi30XI/+51ZB6D3o9FhJQS9HE/llEp+aR+TMJ5xAPAIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752573381; c=relaxed/simple;
	bh=MJi+etYdzWp9bbuS3/ZtoZpHvZ+o85wo5Ie6Vrai3Ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zv6asyl7Q6jg6j5g1d2EjcdRMmwzcJD4yinIwswoKRSMs6HHKG4I+DqKO3uQ4HFthc+m0Z5jp2OulgvVwaa2uuKYwh6AFWJuJ8B2KBp2lVK+wect7BTZmdnbu4zteP/3nFm7qWrxPlg/0K//QP/fXtEW8R5yUir8iJdWyra9eX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PIxct8Vo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752573378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X2FJHrc9DBBnLku6YbG4qZNKfRKciZ4CloiHEsZ1eSA=;
	b=PIxct8Voit1QrabfK/EeZg5+PNcrpZ1ztVa1BKQKfBPVCl0KeVug+vaDM3IjGA8WG8zEde
	ISmtvwlihQipZ9PrNQ57iAWG90w+IOQEY1IwjUBgriGfeORSnuSIIfV+LjxxZ7F0XdUiLG
	LsCTCzICByd1BfGDsr/iBxbuhbbkQ0c=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-N5XUDV0oMQaxLxOryDdqnA-1; Tue, 15 Jul 2025 05:56:17 -0400
X-MC-Unique: N5XUDV0oMQaxLxOryDdqnA-1
X-Mimecast-MFC-AGG-ID: N5XUDV0oMQaxLxOryDdqnA_1752573377
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6fb01bb5d9aso75115756d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 02:56:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752573377; x=1753178177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X2FJHrc9DBBnLku6YbG4qZNKfRKciZ4CloiHEsZ1eSA=;
        b=v2IRcsM1xxCRZe9bpEhR5R8bDklzFKLc8226HgzLtZ0fNw2X71O8sCoQdo1PA8A06K
         HCZLiFw7Oirvf6DBcbQV5SfpQWZ/fofxoTG+TTjhffdv+GO8EXkHrd7AyryBjB0CUx4X
         KtVtsBKANPK9vRCZJVOESR1RzBzod/uDHVpJ50dOa32sLHwX94u/tMnHNie5RAX+/frH
         l05m9Gkrp2dz1wSNxnoY7r93PxLsZdLynWHa9NqtgK9IE0BEcbYLmOLBdblq6MTHIIh5
         O9Ewk+bksc7KlglnAWZUT3XW8cpzSMH7+w76iInS9WvD/Kzlo85qrducVEeXgmXDJUOS
         X6XA==
X-Gm-Message-State: AOJu0YyXo1L25GH44JS2KDrQidHfVQiS8J/n1VZBH9bNVwro2WuxWjsv
	tr1jGjIcWRBkn66UP+SbM+2dhhcy305OcjayRVedOcXCecFESPDnULkAMQoTgZWX3ZEb26J//+B
	YI7kN1bGrWRKUUP43K3oR+Ml4Pb74pvEScEBeMmnResp1495EgvjsfsoRkPrlsMy18w==
X-Gm-Gg: ASbGnctdj6tuSOMxuPT+vik5VwnhhQwxjDEprmesCMYK9/ct07F4F/RmScH+8OzpMvE
	W9Qkd3IZxFj15npWQZtE5C0JQAnquJygUbUDxAxjA8E2xWXrUYA9JOkqgVw0E3m1s4m5QRU8cY4
	GsGfrNXQhsgZnN5Or2kSbm6vhtFKvIjng4VUgFNr4rXAG7AOzFYbF/97RizbrvGpkWDh5Bevlu1
	qvJ8MfidHfI6D/3aBgK+NL+gxHgLGWvDIVpuCnPPCkTacYSYiNCu0HGw0tt2rRizYNZ/dG7otv6
	LmTtozSO8te1iydaUYP0B8Srwoqiz73BzIqH/Qbn6g==
X-Received: by 2002:ad4:5d48:0:b0:702:c140:b177 with SMTP id 6a1803df08f44-704a6f0a0bfmr299514876d6.8.1752573376920;
        Tue, 15 Jul 2025 02:56:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHncLWJlra3O9RCPuPRVNz4dTmRyr/J1M2mv3kg+JaRnitmozIljcP/8mhgPfagbomiL7D0Dw==
X-Received: by 2002:ad4:5d48:0:b0:702:c140:b177 with SMTP id 6a1803df08f44-704a6f0a0bfmr299514466d6.8.1752573376483;
        Tue, 15 Jul 2025 02:56:16 -0700 (PDT)
Received: from sgarzare-redhat ([5.179.142.44])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7049775443esm56373906d6.0.2025.07.15.02.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 02:56:15 -0700 (PDT)
Date: Tue, 15 Jul 2025 11:56:10 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, Keir Fraser <keirf@google.com>, 
	Steven Moreland <smoreland@google.com>, Frederick Mayle <fmayle@google.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH v3 4/9] vsock/virtio: Resize receive buffers so that each
 SKB fits in a 4K page
Message-ID: <i5gsr2exiuhxdupdpbypr5mph3mbd2rfwdwxbg77kcclih2ffd@k5o7dwo3q2pw>
References: <20250714152103.6949-1-will@kernel.org>
 <20250714152103.6949-5-will@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250714152103.6949-5-will@kernel.org>

On Mon, Jul 14, 2025 at 04:20:58PM +0100, Will Deacon wrote:
>When allocating receive buffers for the vsock virtio RX virtqueue, an
>SKB is allocated with a 4140 data payload (the 44-byte packet header +
>VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE). Even when factoring in the SKB
>overhead, the resulting 8KiB allocation thanks to the rounding in
>kmalloc_reserve() is wasteful (~3700 unusable bytes) and results in a
>higher-order page allocation on systems with 4KiB pages just for the
>sake of a few hundred bytes of packet data.
>
>Limit the vsock virtio RX buffers to 4KiB per SKB, resulting in much
>better memory utilisation and removing the need to allocate higher-order
>pages entirely.
>
>Signed-off-by: Will Deacon <will@kernel.org>
>---
> include/linux/virtio_vsock.h     | 7 ++++++-
> net/vmw_vsock/virtio_transport.c | 2 +-
> 2 files changed, 7 insertions(+), 2 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index 97465f378ade..879f1dfa7d3a 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -106,7 +106,12 @@ static inline size_t virtio_vsock_skb_len(struct sk_buff *skb)
> 	return (size_t)(skb_end_pointer(skb) - skb->head);
> }
>
>-#define VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE	(1024 * 4)
>+/* Dimension the RX SKB so that the entire thing fits exactly into
>+ * a single 4KiB page. This avoids wasting memory due to alloc_skb()
>+ * rounding up to the next page order and also means that we
>+ * don't leave higher-order pages sitting around in the RX queue.
>+ */
>+#define VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE	SKB_WITH_OVERHEAD(1024 * 4)
> #define VIRTIO_VSOCK_MAX_BUF_SIZE		0xFFFFFFFFUL
> #define VIRTIO_VSOCK_MAX_PKT_BUF_SIZE		(1024 * 64)
>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index 1af7723669cb..5416214ae666 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -307,7 +307,7 @@ virtio_transport_cancel_pkt(struct vsock_sock *vsk)
>
> static void virtio_vsock_rx_fill(struct virtio_vsock *vsock)
> {
>-	int total_len = VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE + VIRTIO_VSOCK_SKB_HEADROOM;
>+	int total_len = VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE;
> 	struct scatterlist pkt, *p;
> 	struct virtqueue *vq;
> 	struct sk_buff *skb;
>-- 
>2.50.0.727.gbf7dc18ff4-goog
>


