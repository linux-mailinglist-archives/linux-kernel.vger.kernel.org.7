Return-Path: <linux-kernel+bounces-735016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFDEB0897D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 11:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 186804A5265
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 09:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A0728C022;
	Thu, 17 Jul 2025 09:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z8VaZxfN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CF328C021
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 09:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752745165; cv=none; b=lhBTEG1J0X2H6zqSqFiS52Q7uI5zdcuPBJfRQiH1yefmoWbwj/2c2ChITkalcgQt4tuSxYDwliNkESEbFxaiP/53WbJxoA9EQgKpeGH6iW0VppXUvXSxvcwh9qUpcdox5JX7uwVsTaiR6tRDFO0wmA1GTMUtg/CufXAjSPIgOfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752745165; c=relaxed/simple;
	bh=dXeJz3vwBSLIWWCWuP+elspZU7SI9LsUKQsf9/I2RiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rFbNgj4IIVmrIMMPgH67mZ9wl3ktSNE/G8/RlxOaVA+0DGkkoKY0lvwyIhPtZ9O5rA5cfTERGJA77h1roOltsoQwO9JOnLN6pWUSw/56Cp7EImrm1AL2QMS8TZkNikB1RsIQLVPoFtnnB2A6PN2+anFYETrX9lwR4E2fvgiVzdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z8VaZxfN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752745162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lKvVQQJMq+hy7WZue3QcEAM5iltBaD3HiRA66HLusuo=;
	b=Z8VaZxfNFkV1AGl5or+bB5GffslxDGGKuUH7zV2GdKS9KvDecs0b5BQYxGLvaCSu8ET5Ch
	xOS6udZjE+wuSCEyoXPC/Its47UYN2mZf8EsAnc2eF//+Dh1+qN/yIIQtrQWv/E3DEgjnz
	oDfFCjly88HDmxTNazUwcDorGIUmavA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-YCmbM5r4MQy_a5j0TMWGwg-1; Thu, 17 Jul 2025 05:39:21 -0400
X-MC-Unique: YCmbM5r4MQy_a5j0TMWGwg-1
X-Mimecast-MFC-AGG-ID: YCmbM5r4MQy_a5j0TMWGwg_1752745160
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7da0850c9e5so116037485a.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 02:39:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752745160; x=1753349960;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lKvVQQJMq+hy7WZue3QcEAM5iltBaD3HiRA66HLusuo=;
        b=N4jz+GOyJWdJq5TXQeCaOqRu1OVvtk5BH2j8thr/rWMiYM5bTMmJgiRO4POfbLscLZ
         Z+fGAEmIN2NvmMQYBV6wHeHE7jcjMMQ3WcHSyqVWwSe8N9ohAbsYNRsUdsHaQsqBfoSh
         9KTKUWvLws9iaKohcTfVpMPpfZL0LQbJNcrY/XKqYbtg+9XfHXLJ0lH+r+H8QwbIAth4
         5pOrmyHFdUCR3dDHrTlRzHnKltnQuzLeFAzs9569c7556mlmjixv5shO0Nlj54Jj43T1
         3xAq7kXvoYPVNuzMJgzw5baFIlrhOm9kImG9g2PVbJSwo7pWb8+CmAsKXXXZM2qJz3dv
         q1CQ==
X-Gm-Message-State: AOJu0YzcSL3gnNKx8mHjIPzOOnS18elBPotWGkIz3Xe1l18UR89T/sWd
	TajTDOwiVG2Zi78/Xc5l7Y0/xf181AlC56qYraMz0bJPGgMKyEtGQ1B8AXzPSSpdUj0tI8uCFay
	Ni+pCWhj1boMwkY1WDFCQrU2Y2evFJSKNP2brkLq0lPqW+OsVjbyPlwt6lK8tZvXDNA==
X-Gm-Gg: ASbGncsPMzyBim7NM48nFFJb0eGKYdhPYvMOVu0kwpjGGUXk1fk1SJ7bA5Q3WFPhhD0
	tXH6ZdQUVAE7UvUAvaZjNxcpDNMkxBg25fkcXQYMHkKXc0g2indbv/FZBaGngNsiSLXLsxRKQuC
	GEzsQkZkMZkc08ajO9XezQm7Eg7hGAGOfGjWJsWwTyK1BItFPtYo2xjcUeEGHAnOHpZ9lP4mAPu
	AGm99soh0j+4GTlCsFXQYKfxCEW/qKhLR3abOENp9wV5yWfVphnTsEgIbicRUvOiPCRLQx89NQQ
	jgteIUUs0opAz2K5sr1ZSx+JgolK4e1z1jEs9NVUNKnR3GwLhWM/EevR1hwCc2wLIsUR49DZPHh
	pxZiIW6KI6V4lat0=
X-Received: by 2002:a05:620a:6542:b0:7e3:4413:e494 with SMTP id af79cd13be357-7e34413e88dmr561234485a.60.1752745160465;
        Thu, 17 Jul 2025 02:39:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLjVGLBAruZTnyYcI3XjIk2LiSOrCmNEhnAfiMWz9ibsQjoRXzWcmxwJLI++dPE/3qhXbt3A==
X-Received: by 2002:a05:620a:6542:b0:7e3:4413:e494 with SMTP id af79cd13be357-7e34413e88dmr561231885a.60.1752745159997;
        Thu, 17 Jul 2025 02:39:19 -0700 (PDT)
Received: from sgarzare-redhat (host-79-45-205-118.retail.telecomitalia.it. [79.45.205.118])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e2635b0b2fsm519799085a.0.2025.07.17.02.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 02:39:19 -0700 (PDT)
Date: Thu, 17 Jul 2025 11:39:12 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, Keir Fraser <keirf@google.com>, 
	Steven Moreland <smoreland@google.com>, Frederick Mayle <fmayle@google.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v4 2/9] vsock/virtio: Validate length in packet header
 before skb_put()
Message-ID: <y6taqbyskzr4k7tetixgkhdo2z2dgrionsor3jriuo4bxlqdfc@fjnq7tig4bik>
References: <20250717090116.11987-1-will@kernel.org>
 <20250717090116.11987-3-will@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250717090116.11987-3-will@kernel.org>

On Thu, Jul 17, 2025 at 10:01:09AM +0100, Will Deacon wrote:
>When receiving a vsock packet in the guest, only the virtqueue buffer
>size is validated prior to virtio_vsock_skb_rx_put(). Unfortunately,
>virtio_vsock_skb_rx_put() uses the length from the packet header as the
>length argument to skb_put(), potentially resulting in SKB overflow if
>the host has gone wonky.
>
>Validate the length as advertised by the packet header before calling
>virtio_vsock_skb_rx_put().
>
>Cc: <stable@vger.kernel.org>
>Fixes: 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")
>Signed-off-by: Will Deacon <will@kernel.org>
>---
> net/vmw_vsock/virtio_transport.c | 12 ++++++++++--
> 1 file changed, 10 insertions(+), 2 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index f0e48e6911fc..eb08a393413d 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -624,8 +624,9 @@ static void virtio_transport_rx_work(struct work_struct *work)
> 	do {
> 		virtqueue_disable_cb(vq);
> 		for (;;) {
>+			unsigned int len, payload_len;
>+			struct virtio_vsock_hdr *hdr;
> 			struct sk_buff *skb;
>-			unsigned int len;
>
> 			if (!virtio_transport_more_replies(vsock)) {
> 				/* Stop rx until the device processes already
>@@ -642,12 +643,19 @@ static void virtio_transport_rx_work(struct work_struct *work)
> 			vsock->rx_buf_nr--;
>
> 			/* Drop short/long packets */
>-			if (unlikely(len < sizeof(struct virtio_vsock_hdr) ||
>+			if (unlikely(len < sizeof(*hdr) ||
> 				     len > virtio_vsock_skb_len(skb))) {
> 				kfree_skb(skb);
> 				continue;
> 			}
>
>+			hdr = virtio_vsock_hdr(skb);
>+			payload_len = le32_to_cpu(hdr->len);
>+			if (unlikely(payload_len > len - sizeof(*hdr))) {
>+				kfree_skb(skb);
>+				continue;
>+			}
>+
> 			virtio_vsock_skb_rx_put(skb);
> 			virtio_transport_deliver_tap_pkt(skb);
> 			virtio_transport_recv_pkt(&virtio_transport, skb);
>-- 
>2.50.0.727.gbf7dc18ff4-goog
>


