Return-Path: <linux-kernel+bounces-735261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 923FDB08CEC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 14:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 492961C2568E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 12:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EE32C1780;
	Thu, 17 Jul 2025 12:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gx3V1iU7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839DD1F3FED
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 12:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752755503; cv=none; b=DAnGRnHmQou62hlIA65hTI2B1yF+fhm8Vg7YepwAAzuQopq7HC9n+RRHcs1fGLOLo8QwiEkzxjMZvoUR5W01OZZegAnzfUQ2cMybw9ysb60vF0LcU1ooHXOwbxgslcm277EwssomZQNGLOK0wSw7KA/HuJLWECxSjNpU/dPGsAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752755503; c=relaxed/simple;
	bh=44t+/G34YxBgSaKHX9d+/SfEpoDPOQU0T/keIoBXs/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W4fpNDW6scEzJ6u9ZXCqWzeypvz+vkki5EqAfDTfZzKrYekikWMFH6B27MbSIKkfYkAJtfi2rx0cmaTNs/8YrNO6U1YWsEA3B4PbnLVTAksBNUzcTP0QiahTdZ6WAT4DSQ/gtTMb0g2my2HrQ/dvjhfaglsaa7n2Xkwjs5EyDKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gx3V1iU7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752755499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sOwtSUDhtL3N1c9JqL5BfWYYoLfY40Sf4zRWujDHUOE=;
	b=gx3V1iU7BElEZTzZ44Nw8glt3ZjB5CYOG9vlSBIKT1frAz4RBq2DN+aSgEyYFuxLbYb3eE
	dV8FL6bPKJPnjOrVg7xoODke80ce+WWhDoE6E9/yLdPeXPqHOcrETQFlVMpnM+BHAT2kY+
	vFBEfqJb7qoc3Zp4JxkGx4qSBShE47c=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-_fTuoCCoPaGQcwPL5LSEsw-1; Thu, 17 Jul 2025 08:31:37 -0400
X-MC-Unique: _fTuoCCoPaGQcwPL5LSEsw-1
X-Mimecast-MFC-AGG-ID: _fTuoCCoPaGQcwPL5LSEsw_1752755497
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45626532e27so6117775e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 05:31:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752755496; x=1753360296;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sOwtSUDhtL3N1c9JqL5BfWYYoLfY40Sf4zRWujDHUOE=;
        b=t65w9a/IBzYbW93y8A901sTwSI1vnBN2iieZMAE7JFJuug1ALn/JIirYQC3ATBOPNy
         Vh3rUF54my5Tkdtj1CXiMvBPpSfkxOEzprTaveGGF8ZSeWscFBBeiwe49X2OdIaqTiHN
         2hBLj6BeI6CsVMvDyA2vVJBN38ASMxND1zQZdmJzmlSUhuxkZ3w1ngu/VBdGuy9PD8Po
         fM2O3SJ5cT1lpFinETiRLOoAu5cMcX4+5kcHX0fVdiXmEAe9ZrYH2bvZnmCc8ceBLFsu
         YRLL+lJNOp4HpWhnYHPl1IjOb+unHUSUC8kMBHtoRZ0W0XJ99ZkpCrgwuAiKV3DMZNrE
         BbXg==
X-Gm-Message-State: AOJu0YzAlXYJ5oVFJjkLyLc0cX2boOF4u9VWYE8VmYEHP3rXJvVWLDpb
	sOmlFAQVdlJ68xb8ZWHCYKKvb4hX7u+p9N9Yqze6uk8vi1oXYxfyCJgON4s8LZW7cVzrEurT+Ua
	z/XIwMgg4wCRv/QFO9wDfHPw4l1NTs6Y6fXtw0gUOxLbHv3I2SpEfH8xQsgbaLj78MQ==
X-Gm-Gg: ASbGncut1ZcZylNKF0GBPQ9UlU9GzqxX5PHgGWUKf+4ZonIbOH2H4a/c5BytZYY20PX
	u5Jc0IXcx44OomXlyV5uSEczDcU8yfsGRJnDohC05DQaX0adU6KR9MbXhwi2scXYHBL62zONy3q
	Jx+ijxQf7KuP7Y7URTJ/7rSWK0pkafF+OsX9XNuwTXFO5hvpT2hFiLaGoo9pF1PuSUqWIbStWAP
	od3mDG1gHCSzzPvbLEHYdIFm7DzxPNbr3SrkwJj0Qx42bUXcChOkRcd2eRiSTiNYGZjCvSHknxw
	XHRFbMA3yEoxuELGFo0AnABEqkcf3Sdp
X-Received: by 2002:a05:600c:310d:b0:456:13b6:4b18 with SMTP id 5b1f17b1804b1-4562e2a59a6mr74472275e9.31.1752755496534;
        Thu, 17 Jul 2025 05:31:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElUNLRLQmETtxRLBXnwmbrI7MpDiljAY5jueDojwiosgbm0KlFcY6TQxSyKJFFVblPJMsaew==
X-Received: by 2002:a05:600c:310d:b0:456:13b6:4b18 with SMTP id 5b1f17b1804b1-4562e2a59a6mr74471715e9.31.1752755495990;
        Thu, 17 Jul 2025 05:31:35 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45634f6c007sm20924585e9.19.2025.07.17.05.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 05:31:35 -0700 (PDT)
Date: Thu, 17 Jul 2025 08:31:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, Keir Fraser <keirf@google.com>,
	Steven Moreland <smoreland@google.com>,
	Frederick Mayle <fmayle@google.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH v4 0/9] vsock/virtio: SKB allocation improvements
Message-ID: <20250717082741-mutt-send-email-mst@kernel.org>
References: <20250717090116.11987-1-will@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250717090116.11987-1-will@kernel.org>

On Thu, Jul 17, 2025 at 10:01:07AM +0100, Will Deacon wrote:
> Hi all,
> 
> Here is version four of the patches I previously posted here:
> 
>   v1: https://lore.kernel.org/r/20250625131543.5155-1-will@kernel.org
>   v2: https://lore.kernel.org/r/20250701164507.14883-1-will@kernel.org
>   v3: https://lore.kernel.org/r/20250714152103.6949-1-will@kernel.org
> 
> There are only two minor changes since v3:
> 
>   * Use unlikely() in payload length check on the virtio rx path
> 
>   * Add R-b tags from Stefano
> 
> Cheers,
> 
> Will

Acked-by: Michael S. Tsirkin <mst@redhat.com>


Who's applying them, me?


> Cc: Keir Fraser <keirf@google.com>
> Cc: Steven Moreland <smoreland@google.com>
> Cc: Frederick Mayle <fmayle@google.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Stefano Garzarella <sgarzare@redhat.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: "Eugenio Pérez" <eperezma@redhat.com>
> Cc: linux-kernel@vger.kernel.org 
> Cc: netdev@vger.kernel.org 
> Cc: virtualization@lists.linux.dev
> 
> --->8
> 
> Will Deacon (9):
>   vhost/vsock: Avoid allocating arbitrarily-sized SKBs
>   vsock/virtio: Validate length in packet header before skb_put()
>   vsock/virtio: Move length check to callers of
>     virtio_vsock_skb_rx_put()
>   vsock/virtio: Resize receive buffers so that each SKB fits in a 4K
>     page
>   vsock/virtio: Rename virtio_vsock_alloc_skb()
>   vsock/virtio: Move SKB allocation lower-bound check to callers
>   vhost/vsock: Allocate nonlinear SKBs for handling large receive
>     buffers
>   vsock/virtio: Rename virtio_vsock_skb_rx_put()
>   vsock/virtio: Allocate nonlinear SKBs for handling large transmit
>     buffers
> 
>  drivers/vhost/vsock.c                   | 15 ++++----
>  include/linux/virtio_vsock.h            | 46 +++++++++++++++++++------
>  net/vmw_vsock/virtio_transport.c        | 20 ++++++++---
>  net/vmw_vsock/virtio_transport_common.c |  3 +-
>  4 files changed, 60 insertions(+), 24 deletions(-)
> 
> -- 
> 2.50.0.727.gbf7dc18ff4-goog


