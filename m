Return-Path: <linux-kernel+bounces-801679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D69C0B448B1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 23:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F110542DCF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 21:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2188D2C15B1;
	Thu,  4 Sep 2025 21:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e9Abxpzu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A552C158E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 21:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757021918; cv=none; b=V5HUB8ATI51dhOrmMCaXfuCTHpcHSX2IzTlDmlCPkQ65hcZWf+63fpWV8yOvjuavhuCHXVEvX57/cgLMwpxQEb1jFvz2O5kQN0uLDFNzbYAJnS0TcMz7Qi9KOP+LD/rHzlVhr+NrLWSMVoqavQYZ0oJlfX5ZExD8U7j3x7iRUqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757021918; c=relaxed/simple;
	bh=+ZrUvtnLM9xSVjfFb/jug+Mxt/vh9q4WYgIFgX9cQDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lC4juAFxqlsEOCHiIAH9LbbICeB5D+2h3Aykrs+jByvNBVDPFGWIOlElIwRmVGyz1fjnCY92BqJ24YSB0GjQ8vDpBUXlJS73SD0IRjWFX756rgSjPRo/dSy3pxrI8rb7Di4K7b81dQGLMYvIR+4hsHk+FMbmoWKfaebBX6ZgkwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e9Abxpzu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757021915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9rHD7plJVEZkv8PkFJEx5BeBVBt5QFBtzvV5bLJfU1s=;
	b=e9AbxpzukcoKaOXSeXcp2w3w7k2MS+2IyhSpbfnhUREQ0UIZ7BCE9qj1yqrtxOdSrvzjTC
	YPGkhDyA76fdqF+amJQ3SE2d/QTdtu/tmsliab5J2tRhxI89SVzLzsByv5Ijve04EkS0du
	meZvvHlh2Zv+1cNBUPG2Y5DjPFA8Y5c=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-KH8_y-3LNM6CyEMsXuf4Jg-1; Thu, 04 Sep 2025 17:38:34 -0400
X-MC-Unique: KH8_y-3LNM6CyEMsXuf4Jg-1
X-Mimecast-MFC-AGG-ID: KH8_y-3LNM6CyEMsXuf4Jg_1757021913
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45cb5dbda9cso9151275e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 14:38:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757021913; x=1757626713;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9rHD7plJVEZkv8PkFJEx5BeBVBt5QFBtzvV5bLJfU1s=;
        b=vSDiap/3XRPB5Vx5bCubu7tii/57hvN/hQmWqbZ30RhwXoevcGKQfv61GLyKjQuT2q
         jgCSNdopIvccihLMagsQ1p8YF1MGWnoCxVUzixboYbMUMqzN2dNTXt7BVL8bPNzP67r9
         /6RWZmQyVtkNATeygfq3bJ6Sl0LOv3AhyiNSvhKQR1fwB25+/bg1Di+XJS/OIvz3kTc9
         rznzdyJcB+hOQYBDcCMcBq2kk4ukNsZIFi55F/d/MxQpFOS6C5zBi9eTlg+Sc1AkaArq
         QPGHNWRBYuTwTXDuewyqYme/dyelVAYxdd0hEpUWA+1B4u5juxOJ9Ul+a8vkOZlyq4XB
         hFZg==
X-Forwarded-Encrypted: i=1; AJvYcCUxmu4tZHDAA+G4zyZw2zIYjXtrRXD9ZwA5TxDPTfFuTMAY8eQ9cHGNglV2vMrK/WvXqs4UqlZyOJAB77k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSgTiwFWGnxyHWwWfC0RMW5XjVZ/Ty75l4lIqj2c6DTqMcvllR
	RMx/D5gXAHBgcT9ZEcx/kiys+t4Q6IwaYiMfHG1KAcml6SjvFDiQXJ1AYajaW3RizFDRMxKBgt6
	HlW/OQMXdy6nfUnp9Eec8nqegvf4N4Zf1PcT6wvLwp7vtATkNQCAcLfpUPby2pKfhQA==
X-Gm-Gg: ASbGnctMnTygbRDMKCc3M+5+dDHfCsJTBN3lu8NzLE96S0BnnBMx1SVeqGlR4GWvcFy
	muph3xiEY1L73uqUdiDas3Dgavg46TSx38hvtNkqF4vUCF5YlieGfhTCe7uK8h9Nwpiq+OUo89U
	IAqZhHs79GZHqFfRMgPeGslCPI0cfFVKGfqafhHzqhvTyRK+DMSKXkDQkKjTOn4l1OnailWKInd
	bj+LkC3DS68Nh5/d+8TmFeZEKi7Bv4iqMIGgLR+beXdjI56gK/g41tLvg93oRA1NvNKgnDPYybA
	HsKX/SCh4pnzFBxuYQeMQrUjJn78cfNLjZu4bd335JIeIdhecT3onO4iB0INPiPWzw==
X-Received: by 2002:a05:600c:1d10:b0:45b:891f:afcf with SMTP id 5b1f17b1804b1-45b891fb24dmr144597925e9.27.1757021913372;
        Thu, 04 Sep 2025 14:38:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWbBDlkpyRRxeIt/+qH4VagktWDBCJazVbSXDHRMhx/diXSZUFSBaQ6M24PtRDNYL0yu7m/g==
X-Received: by 2002:a05:600c:1d10:b0:45b:891f:afcf with SMTP id 5b1f17b1804b1-45b891fb24dmr144597725e9.27.1757021912965;
        Thu, 04 Sep 2025 14:38:32 -0700 (PDT)
Received: from redhat.com (93-51-222-138.ip268.fastwebnet.it. [93.51.222.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf3458a67fsm1872200f8f.62.2025.09.04.14.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 14:38:32 -0700 (PDT)
Date: Thu, 4 Sep 2025 17:38:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-efi@vger.kernel.org, virtualization@lists.linux.dev,
	David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v3 7/7] virtio_balloon: Stop calling page_address() in
 free_pages()
Message-ID: <20250904173824-mutt-send-email-mst@kernel.org>
References: <20250903185921.1785167-1-vishal.moola@gmail.com>
 <20250903185921.1785167-8-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903185921.1785167-8-vishal.moola@gmail.com>

On Wed, Sep 03, 2025 at 11:59:21AM -0700, Vishal Moola (Oracle) wrote:
> free_pages() should be used when we only have a virtual address. We
> should call __free_pages() directly on our page instead.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/virtio/virtio_balloon.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index eae65136cdfb..7f3fd72678eb 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -488,8 +488,7 @@ static unsigned long return_free_pages_to_mm(struct virtio_balloon *vb,
>  		page = balloon_page_pop(&vb->free_page_list);
>  		if (!page)
>  			break;
> -		free_pages((unsigned long)page_address(page),
> -			   VIRTIO_BALLOON_HINT_BLOCK_ORDER);
> +		__free_pages(page, VIRTIO_BALLOON_HINT_BLOCK_ORDER);
>  	}
>  	vb->num_free_page_blocks -= num_returned;
>  	spin_unlock_irq(&vb->free_page_list_lock);
> @@ -719,8 +718,7 @@ static int get_free_page_and_send(struct virtio_balloon *vb)
>  	if (vq->num_free > 1) {
>  		err = virtqueue_add_inbuf(vq, &sg, 1, p, GFP_KERNEL);
>  		if (unlikely(err)) {
> -			free_pages((unsigned long)p,
> -				   VIRTIO_BALLOON_HINT_BLOCK_ORDER);
> +			__free_pages(page, VIRTIO_BALLOON_HINT_BLOCK_ORDER);
>  			return err;
>  		}
>  		virtqueue_kick(vq);
> @@ -733,7 +731,7 @@ static int get_free_page_and_send(struct virtio_balloon *vb)
>  		 * The vq has no available entry to add this page block, so
>  		 * just free it.
>  		 */
> -		free_pages((unsigned long)p, VIRTIO_BALLOON_HINT_BLOCK_ORDER);
> +		__free_pages(page, VIRTIO_BALLOON_HINT_BLOCK_ORDER);
>  	}
>  
>  	return 0;
> -- 
> 2.51.0


