Return-Path: <linux-kernel+bounces-834383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEA5BA495F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 18:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 233FB7B7EE2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274AF258EED;
	Fri, 26 Sep 2025 16:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hj/NhLVB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA6B24BBF4
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 16:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758903354; cv=none; b=sLIL+FS3YBvdCC4r9AyHkfr4yFaxHq5jlD2fElEPt9WnfLOrqvsFW7ZFUCvuphPifouiXoNypWXW1OD1+D4ZqtW0k9TM++r0EG1NHCV/cY80XiLObDIbbnXwGJfA+Oa6xKZzRrMFbCQ4hkKdhWO1dZFHDpRxmIjQ2MYGxz127+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758903354; c=relaxed/simple;
	bh=de5+oDDVsgvGv8gkgdX1kmDXXsYWScA7Vf9sIiPm1sA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LAVzH68Fp4ZghhTeR2yWIE3FeN2NefhmvM+x8HHKF7uHCx7KU/vmxY8hYn14QDrHnho/UjU8LAmt5L030hsSlicXe29uShUTZTWf8p36qrHKw+3vaITZHdIv7YqVWuUcrwpAiJVdqFiNyHVIyqGAT8tv6y76Fi7tG+1DWpN51xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hj/NhLVB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758903351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d1MsLjQnmPTfFCIHbux9eMDbdADdPspQOJNP4rI8N8o=;
	b=Hj/NhLVB1E5ZWq1MSO5Kd2FCgb8bHixvp7xSM1oJ2uUobqMm4BoR619/bK5f65yr54GTCD
	SPACY/+dsS9XypFrGdVrKfLfxlT5RW+2DBQ7qzb/wXa/RNUqvEJEmnFRdEZC1SYEsVrZrV
	M+ewdbIZgCv76H0vxhN/It5AMzprfkQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-FNk4x2JvOr-1qtox8FLyow-1; Fri, 26 Sep 2025 12:15:48 -0400
X-MC-Unique: FNk4x2JvOr-1qtox8FLyow-1
X-Mimecast-MFC-AGG-ID: FNk4x2JvOr-1qtox8FLyow_1758903348
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46e36686ca1so17187695e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 09:15:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758903347; x=1759508147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d1MsLjQnmPTfFCIHbux9eMDbdADdPspQOJNP4rI8N8o=;
        b=gsWGSzN2Bi9xUxB4/yfZDVwMta0vADfRcfxl8IyiqlouV5PUr7wjMRpmmHxn1Xt/nB
         wBU5M2RoCNgiCSMHF1R/+pxBolyU3fFFBn5H3/CnbMs5cMQcwFNbzfG5Ov3KMSQy1F/7
         zjYaveEIqIp+NOqxznCD9xDZ70zi0XqzXfq7mBukjp0urCXt1cyIGyLsIvifwoU0dPC+
         JalR6Cc2AEyyN0AmyLq+ewG5RyN05ZaQTJR9N15fapflErjimtVsqLcVzWpDDEOZAIi+
         nucfIRPtCDl2W1xGFh9sHOkPBu3LSeOqV9zrFAHG+A2pB8tIhbLqcPC/GGIIApQNDMEx
         OAew==
X-Forwarded-Encrypted: i=1; AJvYcCUF2H/1FtNA8dJ5vzqmRETXzFVIBdk8f6fS4sm6t1VGQ4H8spZA8swWuvMMHtl042YxTSAV62yOqVErD+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL+U1mhRViE8wI6S7SDPOXXa+pFJCdXxGJFKo53DsUCOUa7fvb
	gXfVR75bK0ly29Yy1B5amzQ9HsUKcen8UK46vdkM/2yJOsSYtM6UmZ2Jzzm2EgyvwHglbdkQ4Zn
	lVtXYbKzWcRVaVPAq5cpTu5qvaP915n9RZvzZ5ZiOh7CWd+vTLusIbCyz2jw0RIwcfQ==
X-Gm-Gg: ASbGncvaLW44d0Xi0z2sjgu93XBe+08N9Q4yaW9J11h2O2NuYZyOYgQbS+RBOE1Utlm
	fn6cDJOVfoHkpIjhO9QrnCfd2CpBMtE4N26oXQU+9gPxmI2GOqZbopWziEF2z1vZpu6duLjoir4
	XRrT+xm3YkCEWCt+PWMG67XEd6AKW3jMPiQTB2au+xCGdrjl2vnKppYG853x/duzq+cOjD+p6Vl
	09RpjIUX8dLV1uA9f42h1S7a6xoyTSuIL/sut/+A8j5p0EuRNqkkb2mIvBJtp0THJmilXsHyhAy
	oc3uaD8OLUxapWaOz2y6uLmozpVobHNajDR1YS4G
X-Received: by 2002:a05:600c:444d:b0:468:86e0:de40 with SMTP id 5b1f17b1804b1-46e3299a5c0mr65454995e9.4.1758903347567;
        Fri, 26 Sep 2025 09:15:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTjqxVm23Seu1emihYmKwo45GTVLo85bMBuuc3NdcYCq5ID+za/F9XBnzGN2W1Z6Hc9IxXiQ==
X-Received: by 2002:a05:600c:444d:b0:468:86e0:de40 with SMTP id 5b1f17b1804b1-46e3299a5c0mr65454655e9.4.1758903347022;
        Fri, 26 Sep 2025 09:15:47 -0700 (PDT)
Received: from sgarzare-redhat ([5.77.94.69])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33bf70dcsm78264455e9.23.2025.09.26.09.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 09:15:46 -0700 (PDT)
Date: Fri, 26 Sep 2025 18:15:37 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>,
	g@sgarzare-redhat.smtp.subspace.kernel.org
Cc: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, berrange@redhat.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v6 2/9] vsock: add net to vsock skb cb
Message-ID: <bnsgxged7onwkc4jxxttt6b5yb5ct5xekhybdhcduy75rwwprh@u5o6o3gtgvlj>
References: <20250916-vsock-vmtest-v6-0-064d2eb0c89d@meta.com>
 <20250916-vsock-vmtest-v6-2-064d2eb0c89d@meta.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250916-vsock-vmtest-v6-2-064d2eb0c89d@meta.com>

On Tue, Sep 16, 2025 at 04:43:46PM -0700, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Add a net pointer and orig_net_mode to the vsock skb and helpers for

Why? (Please try to always add the reason we are doing something in each 
commit to simplify the life of reviewers but also for the future).

It takes a lot of time to understand why we need to store these info for 
each skb.

>getting/setting them.  This is in preparation for adding vsock NS
>support.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>
>---
>Changes in v5:
>- some diff context change due to rebase to current net-next
>---
> include/linux/virtio_vsock.h | 23 +++++++++++++++++++++++
> 1 file changed, 23 insertions(+)
>
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index 0c67543a45c8..ea955892488a 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -13,6 +13,8 @@ struct virtio_vsock_skb_cb {
> 	bool reply;
> 	bool tap_delivered;
> 	u32 offset;
>+	struct net *net;
>+	enum vsock_net_mode orig_net_mode;
> };

This structure starting to get big and isn't optimized in terms of 
layout. Since it's basically in every packet, should we start thinking 
about optimizing this structure?

Thanks,
Stefano

>
> #define VIRTIO_VSOCK_SKB_CB(skb) ((struct virtio_vsock_skb_cb *)((skb)->cb))
>@@ -130,6 +132,27 @@ static inline size_t virtio_vsock_skb_len(struct sk_buff *skb)
> 	return (size_t)(skb_end_pointer(skb) - skb->head);
> }
>
>+static inline struct net *virtio_vsock_skb_net(struct sk_buff *skb)
>+{
>+	return VIRTIO_VSOCK_SKB_CB(skb)->net;
>+}
>+
>+static inline void virtio_vsock_skb_set_net(struct sk_buff *skb, struct net *net)
>+{
>+	VIRTIO_VSOCK_SKB_CB(skb)->net = net;
>+}
>+
>+static inline enum vsock_net_mode virtio_vsock_skb_orig_net_mode(struct sk_buff *skb)
>+{
>+	return VIRTIO_VSOCK_SKB_CB(skb)->orig_net_mode;
>+}
>+
>+static inline void virtio_vsock_skb_set_orig_net_mode(struct sk_buff *skb,
>+						      enum vsock_net_mode orig_net_mode)
>+{
>+	VIRTIO_VSOCK_SKB_CB(skb)->orig_net_mode = orig_net_mode;
>+}
>+
> /* Dimension the RX SKB so that the entire thing fits exactly into
>  * a single 4KiB page. This avoids wasting memory due to alloc_skb()
>  * rounding up to the next page order and also means that we
>
>-- 
>2.47.3
>


