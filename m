Return-Path: <linux-kernel+bounces-731598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF3EB05703
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 11:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCCCA7A0762
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 09:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA1A2D46AB;
	Tue, 15 Jul 2025 09:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fAJGalPM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3DA23BF83
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 09:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752572848; cv=none; b=nJDxqUTPn0+o/tkfoOvJ8nZmalMdBE93exth/ypzUpD5IReDqEfrzDqaDNa44tDca1ijVG6X7hlJt7sgmRfbSUOtpNYYSFwjXjM1sfkuRrpvLqCLWtRrRCifTXQOPycfEEtA6HWYqquKDeWdAS9FuUlohHhDhXCA4UISpIKDcrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752572848; c=relaxed/simple;
	bh=9lxLx87i+PuaUy4b5HDvysuGPPM11GdUfv0DuiWleUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MjPCNPpDyIzwlmYYBrDWmEGaVM2Fjl62xIo3hCPfdMAoJTwpSJp62KR1tRI45NySY5TXGgD/7oYKbRRpGyEQ5cXaMhVan7bWFFT805vwkFp3bYA446oVPq+SJgnegPmLyT7s8/k+pZwQuBJWIq1x4Fd8r8/1k37NJDsmNFWhU2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fAJGalPM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752572846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zv21o4YQGbJUN8noeML7Ss7jbQevDPMoV/ulGUv/mjg=;
	b=fAJGalPMp8/fxmh+/o/ffKqpA1S75GriNZkVLZd0iE9NUdCWCC/9BhQGWr2mTTWhDvBrQ8
	IktmEJ1T0cSQ/AwfBRlKwI5jxNYQi4BKNmLOnRjPo9XQN3LC0tO+zOUBAzipKgVQ3S9LhN
	IL2v5Ydj8MEVn73CIELw2vtWor8TIxU=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-qOcxxjXnOPe91Kja408BRQ-1; Tue, 15 Jul 2025 05:47:24 -0400
X-MC-Unique: qOcxxjXnOPe91Kja408BRQ-1
X-Mimecast-MFC-AGG-ID: qOcxxjXnOPe91Kja408BRQ_1752572843
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-235c897d378so52874515ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 02:47:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752572843; x=1753177643;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zv21o4YQGbJUN8noeML7Ss7jbQevDPMoV/ulGUv/mjg=;
        b=pNSA/fgjqoVDSlMUNC1kLJ+dPokJ9BnOqwITkDz3/pnxrozZnlj30hcIr/FkPfpa2Q
         fOcPa5AKJeE5JGLolGOc+JHttW1uXVHo5YpRthXX19e/ZGJRTEBOh7T5sHcgDibweOW6
         G6gY7mdXrMYSlBm+kG99o6gnCvOuGqHCMvu78gtC5JITNajfCVsWQXZzSNQ0T2+cZgev
         IF4lVww5yWe0n8v4HkmY18E00rUEQ3/rwyLoMgg/WgpjeGyCmRjBxjn9GLLEoR37BsVx
         kfi3d1H18gV2EM23Xx8TaTwkjlpcpjaEW8x6fJiN0eyZkfWYqE1CoP8oMJeqosALvo+O
         E1Fg==
X-Gm-Message-State: AOJu0YxjP7eB+mhofYxTTtzwu26CFti3MwjHLmEwkBgSiDVLIUbbVzR4
	SduQ/NvKqM0q6FIAAQM1UsAlSVkdcVIPEUNPclsIxi85gJ24fH3zff2mNY/YaWatrFF3/pL1j7W
	ZU9FOwUu/niEKn7DyB2NWmy5oR4pmMrEWG/WDny0BjrNvuc+EZ8I3QE7gS6KmTAOo2g==
X-Gm-Gg: ASbGncs5rG/ISmMHFZlXr/Cvu3qHkAzI7YxGK49RNx6ZdaTjRqoOe83YavW10qI3bhc
	Gfhw+n80RD+KkbA3Y8n4vT7tmzyENGO3FmknPa9chyKSU18F6LztqTHAYHcQ1yfXv9932xo+0d+
	h5STXIl1en6+Ni63PWR/m55urKx/cS5sBdg/X8A5eTCW3yURQrecL6Ycj0IrcwVF8FFTrToBdZS
	QRl7Z5mS98LaOBH9NI8rgcaazoCfxVaywUwaFChXHN0NZT1k/7gUOSY58724+tVZtUImSY2DAfd
	dB2aP8/XRFIGqw6uVOtwZJ7ZQ9elgAVOtR+p2EZ3Mw==
X-Received: by 2002:a17:903:8c3:b0:235:f45f:ed49 with SMTP id d9443c01a7336-23e1b170830mr31658665ad.33.1752572842977;
        Tue, 15 Jul 2025 02:47:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFw6Q76ji3E4T0X070GuEwtmCWmxMCF8YU2BHFI5N2HYUKvQ3kiM+lmllOTIzW1Yz+SYAp4Q==
X-Received: by 2002:a17:903:8c3:b0:235:f45f:ed49 with SMTP id d9443c01a7336-23e1b170830mr31658265ad.33.1752572842509;
        Tue, 15 Jul 2025 02:47:22 -0700 (PDT)
Received: from sgarzare-redhat ([5.179.142.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42b3c3fsm113125655ad.88.2025.07.15.02.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 02:47:21 -0700 (PDT)
Date: Tue, 15 Jul 2025 11:47:12 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, Keir Fraser <keirf@google.com>, 
	Steven Moreland <smoreland@google.com>, Frederick Mayle <fmayle@google.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/9] vhost/vsock: Avoid allocating arbitrarily-sized
 SKBs
Message-ID: <h3zu2fsjvuftgv5gmkluyqipcak47a2koh54idqqfmstos44o5@c4so6ajec72k>
References: <20250714152103.6949-1-will@kernel.org>
 <20250714152103.6949-2-will@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250714152103.6949-2-will@kernel.org>

On Mon, Jul 14, 2025 at 04:20:55PM +0100, Will Deacon wrote:
>vhost_vsock_alloc_skb() returns NULL for packets advertising a length
>larger than VIRTIO_VSOCK_MAX_PKT_BUF_SIZE in the packet header. However,
>this is only checked once the SKB has been allocated and, if the length
>in the packet header is zero, the SKB may not be freed immediately.
>
>Hoist the size check before the SKB allocation so that an iovec larger
>than VIRTIO_VSOCK_MAX_PKT_BUF_SIZE + the header size is rejected
>outright. The subsequent check on the length field in the header can
>then simply check that the allocated SKB is indeed large enough to hold
>the packet.
>
>Cc: <stable@vger.kernel.org>
>Fixes: 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")
>Signed-off-by: Will Deacon <will@kernel.org>
>---
> drivers/vhost/vsock.c | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 802153e23073..66a0f060770e 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -344,6 +344,9 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
>
> 	len = iov_length(vq->iov, out);
>
>+	if (len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE + VIRTIO_VSOCK_SKB_HEADROOM)
>+		return NULL;
>+
> 	/* len contains both payload and hdr */
> 	skb = virtio_vsock_alloc_skb(len, GFP_KERNEL);
> 	if (!skb)
>@@ -367,8 +370,7 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
> 		return skb;
>
> 	/* The pkt is too big or the length in the header is invalid */
>-	if (payload_len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE ||
>-	    payload_len + sizeof(*hdr) > len) {
>+	if (payload_len + sizeof(*hdr) > len) {
> 		kfree_skb(skb);
> 		return NULL;
> 	}
>-- 
>2.50.0.727.gbf7dc18ff4-goog
>


