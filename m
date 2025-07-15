Return-Path: <linux-kernel+bounces-731621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 144AAB05744
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 11:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE4224A2834
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 09:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A482D5C7C;
	Tue, 15 Jul 2025 09:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qj1Shhzr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C2F21C9F5
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 09:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752573484; cv=none; b=hBZ6Iw3GQsbcB+EFKiOdbjF8vmQILIi/euTs8eY9lfjzLhAeMtwgUUhXVEBhVFo4ovukkyeijwaR2yi3rZGGzHiNFC2M2VTC2Ikut2StRt4L6hxKj+vnEfM+tJhCn/iE3aKH63nPYFEn87mISsaC3ZhnUbcIdOCqD3ySFWUTtug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752573484; c=relaxed/simple;
	bh=KB31fWp1xQrgG040Mlf2ElwUzGbs6A/75GH2CHRZv9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bgk7qoAklkauoDCffnF+WQ2nFg2N1Aek9b7l/+MWWcdJ9DxIR8YqGMr0rcznpl2pmNeCXjlaLexj6soR6SAleC5YNIWFuunyMegUcjr2oJwLC1CxWOkBH8PCYon5GnQHv5jTLq2cFoYckN3Uyy8TzlUdRnQDzNJPWX/BSJ9pMKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qj1Shhzr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752573481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z1VeWdPuiBqILm73rm3vCe0GB4AUiqLL2VU0aM8SPXo=;
	b=Qj1Shhzr/lGPq0mEQEgxP9bCRdCTFp0s3RDyuD7gH9yQ6iqwk9u52ShVQ6A97DzTIIUUdr
	E5A4Q8yx+MSDwZMX3ElwaqNIiyo0KeMKYV+eXd4S91Vj1Svt/hfENnWg8hBcGZnn7yyGE3
	fCAwb8QyCA9ydR+525qs06YC2dvaWOg=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-XO_LkkuiOBC4eSR4jOhnjw-1; Tue, 15 Jul 2025 05:57:59 -0400
X-MC-Unique: XO_LkkuiOBC4eSR4jOhnjw-1
X-Mimecast-MFC-AGG-ID: XO_LkkuiOBC4eSR4jOhnjw_1752573478
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-748fd21468cso4447618b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 02:57:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752573478; x=1753178278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z1VeWdPuiBqILm73rm3vCe0GB4AUiqLL2VU0aM8SPXo=;
        b=n4hCZ4cXMjtvuIDKXHRnJNHpAhFWm9KU6Da809cPGpUkTRBrIu4R8cs6IzrOwM01Eo
         RVztvSFMIUFmkClhvHV/DtHFxzK7v3wkxnzCAxP/i+PuMRV/nRuEla3he453HcjD+vEr
         ETRnVaoyAQgveCDQ2vVZtWG0tyAWT2KwOa1MkftZS6PV9KNI63jTfu6lZ0KTmYWbGgxX
         p2iat8+QOC8hvBwNCrlgKDdI11pUf0Dv3/SqqCiiuO8IVLQZuCubF88gck5puBqol0fg
         rkHNPN/9X0L0ptKbJdmN9mSPpHX/+IW3117ChsdeYQggtvN++2dcbodfsmqm1TFGQ7fM
         Fgng==
X-Gm-Message-State: AOJu0YxpFz++O/oBT+ku32IVQjfeso4xFLOQ48yl0LE3ViLSDVm2WzUC
	f/WffOE+KYOP8amU5N0wp1Htvb3xqgcV4G+CWimj2QQCu6rgR7fZ7upH2+0MNzpANqMgqCY5uk5
	DqHMrN00fO2oXtbPv2HWMZxkUXhXxKOwvFLCi7RJHCMKMxRxUAyATLloF2RYNsA7L0w==
X-Gm-Gg: ASbGncuKbNvzcjbFqOo30IuOrDm1G7p0cdQoAUbQcyCWUxGmi2W6U6QeX/yQh57fFnt
	VDR2Mxziz2TQ6XBjEaQ/xm/ywCB+swau2HRkoWkVAwmv7/9GPILx2KAzXtWvghnx2elHDubIcDi
	xDSUjOrId4/gaENrxiDKrN4vY/KfWrwOd5fYYzSzL+9i2euaoCoAY4lldh1rCaCf8zOxd1C7MjW
	28n+9tzfHNRbi918qR2e58Nd5iD3NMGW+1e8xDiCjyl3Aw7V1yeHEHhLEYIeKO87Cq1dLedSxlO
	awoiXfPi2ALCGGHlTr68HxYGEWfRJIhh7ybWnR09hA==
X-Received: by 2002:a05:6a20:914e:b0:21f:4ecc:11ab with SMTP id adf61e73a8af0-2317dbd4f1dmr22897068637.9.1752573478223;
        Tue, 15 Jul 2025 02:57:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWQGcFR1RyTALwdsG+0AcGsG1+kH2rVM1KjDsLtN/xS5dDJPTTql59MnYtr/kxTQlIq0P5Iw==
X-Received: by 2002:a05:6a20:914e:b0:21f:4ecc:11ab with SMTP id adf61e73a8af0-2317dbd4f1dmr22897034637.9.1752573477769;
        Tue, 15 Jul 2025 02:57:57 -0700 (PDT)
Received: from sgarzare-redhat ([5.179.142.44])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9e064a9sm11751862b3a.47.2025.07.15.02.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 02:57:56 -0700 (PDT)
Date: Tue, 15 Jul 2025 11:57:50 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, Keir Fraser <keirf@google.com>, 
	Steven Moreland <smoreland@google.com>, Frederick Mayle <fmayle@google.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH v3 6/9] vsock/virtio: Move SKB allocation lower-bound
 check to callers
Message-ID: <kcntvqjud6wixfoq6w2heqqdblurjigzaasz7333fsd2p22vai@ettf5254doz5>
References: <20250714152103.6949-1-will@kernel.org>
 <20250714152103.6949-7-will@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250714152103.6949-7-will@kernel.org>

On Mon, Jul 14, 2025 at 04:21:00PM +0100, Will Deacon wrote:
>virtio_vsock_alloc_linear_skb() checks that the requested size is at
>least big enough for the packet header (VIRTIO_VSOCK_SKB_HEADROOM).
>
>Of the three callers of virtio_vsock_alloc_linear_skb(), only
>vhost_vsock_alloc_skb() can potentially pass a packet smaller than the
>header size and, as it already has a check against the maximum packet
>size, extend its bounds checking to consider the minimum packet size
>and remove the check from virtio_vsock_alloc_linear_skb().
>
>Signed-off-by: Will Deacon <will@kernel.org>
>---
> drivers/vhost/vsock.c        | 3 ++-
> include/linux/virtio_vsock.h | 3 ---
> 2 files changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 1ad96613680e..24b7547b05a6 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -344,7 +344,8 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
>
> 	len = iov_length(vq->iov, out);
>
>-	if (len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE + VIRTIO_VSOCK_SKB_HEADROOM)
>+	if (len < VIRTIO_VSOCK_SKB_HEADROOM ||
>+	    len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE + VIRTIO_VSOCK_SKB_HEADROOM)
> 		return NULL;
>
> 	/* len contains both payload and hdr */
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index 4504ea29ff82..36dd0cd55368 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -57,9 +57,6 @@ virtio_vsock_alloc_linear_skb(unsigned int size, gfp_t mask)
> {
> 	struct sk_buff *skb;
>
>-	if (size < VIRTIO_VSOCK_SKB_HEADROOM)
>-		return NULL;
>-
> 	skb = alloc_skb(size, mask);
> 	if (!skb)
> 		return NULL;
>-- 
>2.50.0.727.gbf7dc18ff4-goog
>


