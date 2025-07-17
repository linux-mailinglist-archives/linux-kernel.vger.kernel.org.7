Return-Path: <linux-kernel+bounces-734978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B364DB08902
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 11:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE03BA44FED
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 09:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6082E28934D;
	Thu, 17 Jul 2025 09:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LEaeJ85g"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00725288525
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 09:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752743427; cv=none; b=HF10ny9d6ZsxRWodyM4RjZOvLkwOtlNzPviVeKemAVNb+fZ08tQaVLrg19Z61ni1N8eyUo129SuuwMjybehgyAIwlIMZdWV6njrFEJHGqEWVIF4UYhx/CwdRl7vTVKW9VJp1NJLacP6mGeKvkZKYD5b7aBpTmGeLXjF5R0EkpyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752743427; c=relaxed/simple;
	bh=529Qak/sfp59pYGiC/TZea5yPOltqRTolGUKXHD1UeE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MHjT82I3Mh53OhY/JuKnA8BBvNYhpV/i/58GhxQ0SEQvkQq3nSU55O1KMvAOjxCeOTGhCfkmq8ykkynEFrxCEnyxLdi0SdNEmib7oSmcDlN/J7ztixCBfAs1nLPEQMIlM7XhnuEMZudqONDB4RLCjtsPqGGBCyz4O48XWE6MM/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LEaeJ85g; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752743425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Fw27KCFfE/h9klyh3V20croFMoBwa4Sovv5KHmr7cY=;
	b=LEaeJ85gNsAg2kvXhDqyyf1mAwHEv0Wnno82jir/o3JaAkGMtQFyilMpIREH1hvTkcdPMe
	4JvyU/fe0hbq5kC6qAj6XlsZFLbcl2F66dhUSl4Sp5UOps/vDBv9oWeuYhBvSKMJeIrCiY
	JTrL8yPq5xrcP9AnPHlcRP7o01I0p4U=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-0oEgZ9kvMfCH9DNYZ5QoGg-1; Thu, 17 Jul 2025 05:10:23 -0400
X-MC-Unique: 0oEgZ9kvMfCH9DNYZ5QoGg-1
X-Mimecast-MFC-AGG-ID: 0oEgZ9kvMfCH9DNYZ5QoGg_1752743422
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-53473ab4992so320440e0c.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 02:10:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752743422; x=1753348222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Fw27KCFfE/h9klyh3V20croFMoBwa4Sovv5KHmr7cY=;
        b=jkxdHKtksnDl96ZpsKolXCOI7JD6qw0IBlJBjUB4fwG7P6DoC/ErQsZCf49O3DYY/k
         Hjkf8AdZ95BnSn5CC8sXtj6woZ+/CyXS6aJyEkoGBQbbvHJh09senHDCk5rfAAliwgvG
         fIb/FAG5EDHBSi7Bo9zhVlAXJwHMnfTgDwmFZ6Cb6lEJUQ9B8qGnr2jefe3SZZIO/jlv
         p1Ly1tDEnzsCWAdycCJKMKhOt7SNz+xSDtSTI8h3+cvVHzQIYPTVaF8d8ym4Rt1pEPn6
         9vdCxDIyERysYRbymoHbfIdW8czc61hCMQjueBvOxkipiFf5KcyPOXRQ185KF5YULFYW
         vClQ==
X-Gm-Message-State: AOJu0YzcBAFEcovgsyEoLDr53ArVrcjLpgFfAscXF3+HrcxuT/pnuJZU
	3r2147K8PE5n6Usx4WM8XDSM+LWRC/jywOrjraSxwMHOyFsEKeBVn/BU2GTYZEgYVGIFLUiX56D
	HDh5Gtwd78CIMZ7WWhPriTENZe9m5+yYfK/UZFoysAt/uoa5fVgKmKQjiX3tn1go2pbPDPrRnY+
	jM3XAYloDR1pHUkfF93PIoQk+s1hGK4IYh32iXtfVZ
X-Gm-Gg: ASbGncuZI1zXx3H23YAgUCzJT92iOpG8IxqG+xyIfH+QzaxkSKfwRChxhjfvle7UJVH
	Fzzj6NH2gCRTyq2X+q+yxnuSitxMVHlF+8KScQk1fYNFaHLtBWchb+ZW3Kta7RM6ZIHJffsK74X
	nIhSvGq8i3meppVjakgtZ4
X-Received: by 2002:a05:6102:5127:b0:4eb:2eac:aaa0 with SMTP id ada2fe7eead31-4f89996cb49mr3005688137.19.1752743422239;
        Thu, 17 Jul 2025 02:10:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECuZg4tnD3dbPOqkK7QLQFXVz6s0zEI1WL38YU/sbDVqoEGpcLhizaAQH/UfHtx1VrdY5RMF+LxyJoII3bJZE=
X-Received: by 2002:a05:6102:5127:b0:4eb:2eac:aaa0 with SMTP id
 ada2fe7eead31-4f89996cb49mr3005681137.19.1752743421877; Thu, 17 Jul 2025
 02:10:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717090116.11987-1-will@kernel.org> <20250717090116.11987-2-will@kernel.org>
In-Reply-To: <20250717090116.11987-2-will@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 17 Jul 2025 17:10:07 +0800
X-Gm-Features: Ac12FXwF3a40TcBiFPolR067u2ZE0YBPsrx96TsMziyQKG9t5JlhF_12qsJ9G6U
Message-ID: <CACGkMEsoBj7aNXfCU7Zn=5yWnhvA7M8xhbucmt4fuPm31dQ1+w@mail.gmail.com>
Subject: Re: [PATCH v4 1/9] vhost/vsock: Avoid allocating arbitrarily-sized SKBs
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, Keir Fraser <keirf@google.com>, 
	Steven Moreland <smoreland@google.com>, Frederick Mayle <fmayle@google.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 5:01=E2=80=AFPM Will Deacon <will@kernel.org> wrote=
:
>
> vhost_vsock_alloc_skb() returns NULL for packets advertising a length
> larger than VIRTIO_VSOCK_MAX_PKT_BUF_SIZE in the packet header. However,
> this is only checked once the SKB has been allocated and, if the length
> in the packet header is zero, the SKB may not be freed immediately.

Can this be triggered from the guest? (I guess yes) Did we need to
consider it as a security issue?

>
> Hoist the size check before the SKB allocation so that an iovec larger
> than VIRTIO_VSOCK_MAX_PKT_BUF_SIZE + the header size is rejected
> outright. The subsequent check on the length field in the header can
> then simply check that the allocated SKB is indeed large enough to hold
> the packet.
>
> Cc: <stable@vger.kernel.org>
> Fixes: 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff=
")
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  drivers/vhost/vsock.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index 802153e23073..66a0f060770e 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -344,6 +344,9 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
>
>         len =3D iov_length(vq->iov, out);
>
> +       if (len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE + VIRTIO_VSOCK_SKB_HEADRO=
OM)
> +               return NULL;
> +
>         /* len contains both payload and hdr */
>         skb =3D virtio_vsock_alloc_skb(len, GFP_KERNEL);
>         if (!skb)
> @@ -367,8 +370,7 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
>                 return skb;
>
>         /* The pkt is too big or the length in the header is invalid */
> -       if (payload_len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE ||
> -           payload_len + sizeof(*hdr) > len) {
> +       if (payload_len + sizeof(*hdr) > len) {
>                 kfree_skb(skb);
>                 return NULL;
>         }
> --
> 2.50.0.727.gbf7dc18ff4-goog
>

Thanks


