Return-Path: <linux-kernel+bounces-725405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04652AFFE9B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 11:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 722874A1784
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 09:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6E62D5A1B;
	Thu, 10 Jul 2025 09:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fZb2elh2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2FD2D5A0D
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 09:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752141479; cv=none; b=n5VAZqlJwPS7Ef+vm56xLfD4kXqkSQ9oPzfULbwOcVP2HPQmJwWk7CrQbNTJAmaOQyh3sZnXj37b88ggyg/HzRjg75hbBuFXnkUByDtyUlsm/A3RFexAUvj5fJ8DbmKN3gL44GqH8+BWHB8bzWC3S/9njsUC/HLUm8feY1ZAxvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752141479; c=relaxed/simple;
	bh=7xwliJkVJ22YY86sSCdm9ttnnURaGoeDVbNMIvocjHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QpuQdFL8hc2asbrBLA2LsicvneMvFPU0DkifOFXz3OfQHrkI5fEaswaioO93nY27tsPwPTNKSCN3Dvmf2KeM5NI6Ppc5gxFk54PpdfRfhsEy8DR4bKXJPuurjeS/n5qBXIg8m4msPx2uBKuOSeg7HtoOKwJLfqvZeg0nxmaXNDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fZb2elh2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752141477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NDPcEVJCGuQNOn/llIxQqC/tDyrkofeBP4MHIQfFqcE=;
	b=fZb2elh2tGrKuB/y3s3uq3a5x8sJuX68LR97ZOei+MfVfMVoxYZaFQq5r4DxvX0n4g4Pq6
	5vlB2ciYY4+NJIVe8Uy/CSacGrmOnPECbr0o5kyvtfph5cdG155a5S1uf9AV/74yfy0mR1
	R0q/8z4DfkAmO/Vdn++Vni9bI+ypy6o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-EFtV6O8yMOy-sYCqySt_Lg-1; Thu, 10 Jul 2025 05:57:53 -0400
X-MC-Unique: EFtV6O8yMOy-sYCqySt_Lg-1
X-Mimecast-MFC-AGG-ID: EFtV6O8yMOy-sYCqySt_Lg_1752141473
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45311704cdbso5317505e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 02:57:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752141472; x=1752746272;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NDPcEVJCGuQNOn/llIxQqC/tDyrkofeBP4MHIQfFqcE=;
        b=p5FQcmj/svJONh0BOHiNQokbXP71ILZJ/0t0+Q+Bhpcuui3HMsGpSIL9zmZnyuv1Nr
         x0bDTjHVkRpnBPY4EKqP8COJLGaGJMWK3xW7owsDpt3I+FbrBtIbNW9STX0XRqy7zO0v
         kiYKzomd9MakKZyRqUFpl+CyHIVUnqguupAlzt2e0IPP0NbVPrUtwo6Oc82kj+STbGEi
         XAvDvdC/kCDT7q9Zxt3l7YW6NARnqBw51WJCwmdThmUqpSDHLj79wnHtKmp4kdhm8x99
         8OaDOTWaHZqi301CdffDSA6Z3+wE8KM1+oTYOOn1T/2zOCGuslTiNg7QpRTBDOGZHLcX
         jsgA==
X-Forwarded-Encrypted: i=1; AJvYcCX7x5+eYhaeS9u6Da/Qgs4JN2dZQp1OTbbweKzoNZtahr5TqL2IT7I3Pvwj90hEX7Gs0keu9bnx1xE/GVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV/PrurRJcn2DwQusDoxJMvnn6WNIc/2q8bSC6b+TjFsqCMfnR
	DzfOc0UwCur01kkh1hJ3Z0puHckpC9chUlJ3m11YrG1Qbkbv4MPbAVjxSza+YKFrKW4GKjsr5g4
	iuUmt6Ll/SBPg34Z5HSGJVgevbSxMgcGM+paTx5DSWV67icjSFVe1CtA62H/hHAMFEw==
X-Gm-Gg: ASbGncuhpFGhAclaLdwPGNd+p1OEOCDuyD1Qa3F+f/8IciHLtswNuX16tPbt4Q5/HHn
	/kNjdgFo+fCDq/sywEdiHyVO/Aoa8+MmBc/iVb0TcpH5/L99ESteVERdbnw/aCs3wRLFglScZ3z
	jNmwKUo01ET6b1+Ac60KA0MyUD9+WnKKoHOmtVICiD151Jz/YPqjAlDY6/MdcYKHfi+bC4XpDS4
	JK76ML/SBdEcfPv8eMkHheqGEKCZdt/BSBdvegKjnyRq8vlYx3HOHEEaSO3mrQnw0ebwMyhHnfr
	BNkhsLl9H7SCqXg3wAMK6VoQjIGMYK5UBsyPELCvoqN7c0NA9XFr/W7lricYn+Qh2xj1vQ==
X-Received: by 2002:a05:600c:4705:b0:453:59c2:e4f8 with SMTP id 5b1f17b1804b1-454dd1fbc3cmr18100375e9.1.1752141472571;
        Thu, 10 Jul 2025 02:57:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIJdl2it7UMshDGjV9veVJZFAmJkxwLppeIY5QkUEZVKY+WX/0RWzk+iU2OR29VnHls7guHw==
X-Received: by 2002:a05:600c:4705:b0:453:59c2:e4f8 with SMTP id 5b1f17b1804b1-454dd1fbc3cmr18100095e9.1.1752141472067;
        Thu, 10 Jul 2025 02:57:52 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:271f:bc10:144e:d87a:be22:d005? ([2a0d:3344:271f:bc10:144e:d87a:be22:d005])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc1ecbsm1422399f8f.25.2025.07.10.02.57.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 02:57:51 -0700 (PDT)
Message-ID: <d808395d-2aad-47a3-a43a-cf2138d1d2b1@redhat.com>
Date: Thu, 10 Jul 2025 11:57:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] virtio-net: fix received length check in big
 packets
To: Bui Quang Minh <minhquangbui99@gmail.com>, netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Gavin Li <gavinl@nvidia.com>,
 Gavi Teitz <gavi@nvidia.com>, Parav Pandit <parav@nvidia.com>,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250708144206.95091-1-minhquangbui99@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250708144206.95091-1-minhquangbui99@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/8/25 4:42 PM, Bui Quang Minh wrote:
> Since commit 4959aebba8c0 ("virtio-net: use mtu size as buffer length
> for big packets"), the allocated size for big packets is not
> MAX_SKB_FRAGS * PAGE_SIZE anymore but depends on negotiated MTU. The
> number of allocated frags for big packets is stored in
> vi->big_packets_num_skbfrags. This commit fixes the received length
> check corresponding to that change. The current incorrect check can lead
> to NULL page pointer dereference in the below while loop when erroneous
> length is received.
> 
> Fixes: 4959aebba8c0 ("virtio-net: use mtu size as buffer length for big packets")
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> ---
> Changes in v2:
> - Remove incorrect give_pages call
> ---
>  drivers/net/virtio_net.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 5d674eb9a0f2..3a7f435c95ae 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -823,7 +823,7 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>  {
>  	struct sk_buff *skb;
>  	struct virtio_net_common_hdr *hdr;
> -	unsigned int copy, hdr_len, hdr_padded_len;
> +	unsigned int copy, hdr_len, hdr_padded_len, max_remaining_len;
>  	struct page *page_to_free = NULL;
>  	int tailroom, shinfo_size;
>  	char *p, *hdr_p, *buf;
> @@ -887,12 +887,15 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>  	 * tries to receive more than is possible. This is usually
>  	 * the case of a broken device.
>  	 */
> -	if (unlikely(len > MAX_SKB_FRAGS * PAGE_SIZE)) {
> +	BUG_ON(offset >= PAGE_SIZE);

Minor nit (not intended to block this patch): since you are touching
this, you could consider replacing the BUG_ON() with a:

 if (WARN_ON_ONCE()) <goto error path>.

/P


