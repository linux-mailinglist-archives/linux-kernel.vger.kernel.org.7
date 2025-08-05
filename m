Return-Path: <linux-kernel+bounces-756053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B07CB1AF41
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 09:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F1787A59DF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 07:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE298238179;
	Tue,  5 Aug 2025 07:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C44mCuBq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF2C1AA782
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 07:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754378157; cv=none; b=LJM+1VuR7Q5/Txya4Bjw9OvVG6UsnC0dxHI41vq+foiva/3+wXYStGzkOmXWsDAzlr7zU30lUaA965DdcxHoxIuqQmtPYoZKZxz3eAgebpD94gL4JWMVMuQV57bZcZtSnV/3HLOA+Vx9IGNrOHVYfWglBNYPERiPSzu/GYvcM/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754378157; c=relaxed/simple;
	bh=ftuIf5p693pbIE28Ca6q+2oPAzEBuJqq8byNCo2RqCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CnGhntWXZSodl6/a+Lgk35HkfjGkUhapT4BnvPF4v/UkzYrBsrVs94hf9C19GX6GhXK6NaL+nitv9fZ++3OQoaeEz5XQ4kbivICdpxyEV/aXEOsqgdoyuu7s0/omzdbTQ3JNvDH5a7t3B+Inaq2PaSDaI3C74HNywCGPpv5qiK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C44mCuBq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754378154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y1lfQQck/gEfvghhrXvc2lp4TNPtdu8JSj2lFK/nD/A=;
	b=C44mCuBqayv7ZDAGvVQqTzGKZacTiQTnoaTkVDPxm6wClF48ivgd5Lg++mRY5JPlIk1F1T
	juQN4+RhrOb4CIhVUJDuzMU3e0QNt4Q1S0xYeXvzSIp6SduNSt+oq9b9pZvfdUGRYKPAKl
	TW9Iqz4RwtYZKSxQq3KsxlicX9DjSqM=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-JYxJQJWOM-u8TvCfNSQExA-1; Tue, 05 Aug 2025 03:15:53 -0400
X-MC-Unique: JYxJQJWOM-u8TvCfNSQExA-1
X-Mimecast-MFC-AGG-ID: JYxJQJWOM-u8TvCfNSQExA_1754378153
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6fab979413fso101563806d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 00:15:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754378153; x=1754982953;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y1lfQQck/gEfvghhrXvc2lp4TNPtdu8JSj2lFK/nD/A=;
        b=Apn4WKYC0n6lGwb0SFe9wcKFWwkfYAfy21XwqfQxzslKvtEQoF0BP2pxbi6Z1V37+N
         EHQvwvKFS4jE1KxMKUbhi4lOoVtJDA9pOaJBLe8/uNcMpYoFklZp/3DsagnU1QndfJmP
         VL8kiKaKz/wnUiL9Ixkg0zf9uwn2+sC5bihFssW4dQR1mjRuU82sg4wpCqTjzCTx+2Pf
         JJVWHp7UbY5kzGYhSl93RoHrXebsDSB7S2bN5P5BxiO7qQh+XxE1clmIbdQjoIgeTljd
         lD2hacqa71Au/1CZ70sl2CHrTQBl4/pMtjx4nrJMhgw9E05xGRv/iurIJv+tJuAJsLh0
         AQCA==
X-Forwarded-Encrypted: i=1; AJvYcCV0pvXvVz1wNcwt57JjlUc2K4Z9CD2RoIn0brxaa8xBrLuiT9U3T/4b9pWNJ7tw65kTWXnITIhc6We8ylM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb6MPvdvQe3xfTSvDaKU92ogt5Vfr0l/0FYRHcmlqUVY9TcNvl
	DC2tYCF7IIcwkBT46Vu+yZllUEepW2qagClFRVTMSVplx3ZJN7Y8NsJDHfrFbLr6ISCOhaWHNTb
	tZS7aodyw1IPArfEYb0aFelUHSdYIVL4BlTdwq9/ZHhrPUJ0X15Cn7uONVpWzxKu5kw==
X-Gm-Gg: ASbGncsr/uDYNmRmX9yxled9xkKZ9SHiPBAO3VeZZWiuw5iQbFnJW0hwlMtvrRRkIW9
	Oe0dqpq0DPUQnx7X5ZU9aLdRyqlDA5nQGqlmceeFll/W4B4ttqPfj9vXDuygxQ+FOXkOArTVxsg
	X5fO6TjYMwAI8jvAtYzRg3zRS/kMwLI7qFiejLmBYvmHlX/zEoHxssbt3vq2gem78SIp6IFGggx
	2WdnXzZ6YmkQ7q4YdThLnBTphhf8WRjjSFVUxUy2c6bI/itZfhor7j/El/e2xWSiS33bBVBU3WQ
	CngeeDQcVXQ3NatNjNCBAmLRJXTeGxyipVYAoP1qm8kcs0wJbpFfm/wgEtthN1efrO7CobLp0DQ
	P2ySn8qBeA12qIOA=
X-Received: by 2002:a05:6214:c47:b0:700:c39c:9d12 with SMTP id 6a1803df08f44-70936327c52mr160762256d6.43.1754378152794;
        Tue, 05 Aug 2025 00:15:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFZ6fig7Xx657yIfyOJPg7qs7PE+/ypJzBtTrd0P+Slx/GHljmbFT9/ITIdPwSIwQdwRhc6g==
X-Received: by 2002:a05:6214:c47:b0:700:c39c:9d12 with SMTP id 6a1803df08f44-70936327c52mr160762006d6.43.1754378152227;
        Tue, 05 Aug 2025 00:15:52 -0700 (PDT)
Received: from sgarzare-redhat (host-79-45-205-118.retail.telecomitalia.it. [79.45.205.118])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077ca464acsm68273536d6.36.2025.08.05.00.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 00:15:51 -0700 (PDT)
Date: Tue, 5 Aug 2025 09:15:44 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: bsdhenrymartin@gmail.com
Cc: huntazhang@tencent.com, jitxie@tencent.com, landonsun@tencent.com, 
	bryan-bt.tan@broadcom.com, vishnu.dasa@broadcom.com, bcm-kernel-feedback-list@broadcom.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, Henry Martin <bsdhenryma@tencent.com>, 
	TCS Robot <tcs_robot@tencent.com>
Subject: Re: [PATCH v1] VSOCK: fix Out-of-Bounds Read in
 vmci_transport_dgram_dequeue()
Message-ID: <jqgnivkquty3gdhhedbx3vub7wguhuxyorelkpvwhu6r3mfvzm@q7voouptegpt>
References: <20250805062041.1804857-1-tcs_kernel@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250805062041.1804857-1-tcs_kernel@tencent.com>

On Tue, Aug 05, 2025 at 02:20:41PM +0800, bsdhenrymartin@gmail.com wrote:
>From: Henry Martin <bsdhenryma@tencent.com>
>
>vmci_transport_dgram_dequeue lack of buffer length validation before
>accessing `vmci_datagram` header.
>
>Trigger Path:
>1. Attacker sends a datagram with length < sizeof(struct
>   vmci_datagram).

How?

>2. `skb_recv_datagram()` returns the malformed sk_buff (skb->len <
>   sizeof(struct vmci_datagram)).

The sk_buff is queued by vmci_transport_recv_dgram_cb() calling
sk_receive_skb(). And It is allocated with this code:

#define VMCI_DG_HEADERSIZE sizeof(struct vmci_datagram)
#define VMCI_DG_SIZE(_dg) (VMCI_DG_HEADERSIZE + (size_t)(_dg)->payload_size)

static int vmci_transport_recv_dgram_cb(void *data, struct vmci_datagram *dg)
{
	...
	size = VMCI_DG_SIZE(dg);

	/* Attach the packet to the socket's receive queue as an sk_buff. */
	skb = alloc_skb(size, GFP_ATOMIC);
	...
	skb_put(skb, size);
	...
}

So I don't understand what this patch is fixing...

>3. Code casts skb->data to struct vmci_datagram *dg without verifying
>   skb->len.
>4. Accessing `dg->payload_size` (Line: `payload_len =
>   dg->payload_size;`) reads out-of-bounds memory.
>
>Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
>Reported-by: TCS Robot <tcs_robot@tencent.com>

Please fix your robot and also check your patches.
This is the second no-sense patch from you I reviewed today, I'll start
to ignore if you continue.

Stefano

>Signed-off-by: Henry Martin <bsdhenryma@tencent.com>
>---
> net/vmw_vsock/vmci_transport.c | 5 +++++
> 1 file changed, 5 insertions(+)
>
>diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
>index 7eccd6708d66..0be605e19b2e 100644
>--- a/net/vmw_vsock/vmci_transport.c
>+++ b/net/vmw_vsock/vmci_transport.c
>@@ -1749,6 +1749,11 @@ static int vmci_transport_dgram_dequeue(struct vsock_sock *vsk,
> 	if (!skb)
> 		return err;
>
>+	if (skb->len < sizeof(struct vmci_datagram)) {
>+		err = -EINVAL;
>+		goto out;
>+	}
>+
> 	dg = (struct vmci_datagram *)skb->data;
> 	if (!dg)
> 		/* err is 0, meaning we read zero bytes. */
>-- 
>2.41.3
>


