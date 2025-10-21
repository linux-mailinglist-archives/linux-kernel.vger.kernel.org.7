Return-Path: <linux-kernel+bounces-862415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4BEBF53A6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DDD5460C25
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 08:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1AC4303A1D;
	Tue, 21 Oct 2025 08:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CYlcS07v"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A9B298CB7
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 08:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761035313; cv=none; b=g9j7nWSRvOA6k8ituCKx/TDlynGMHwP79Pslyx3/MbAptVAXK/hfrULp4LMbnTQ3RFjtXWTUPyhpB7pVdhTQpZez5bRytFr0/rhHUKCYQTo86syDirBHVs2m2JUa1idySRFvYAdkZMqB1KaYD5mKVFcX/uW0EF9NIsVKdO1iyKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761035313; c=relaxed/simple;
	bh=6b74B6VXDCdcmJHeIm2ZbabEvGQgPJOC4TiiYfNyIxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uHj0HP12sGiPy5lFQFdhkaZm16S8y4DuY7lLfUXtcFU4i5Gv6FMAhWhy53WpPLDq8q1c2bbdWyixAGhTuAMbiPbrNvFNEM2wo4TkWzZ+NigpwklHvjEXiS7nZIZXag2u06vWPWGx7/9cPOlNTAwI74im/n9bZNNfXfTa4v5rGTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CYlcS07v; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761035310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9wgX9rXCO2UPANmfcyjOB2pBN8YmhnWytsGw80sw54k=;
	b=CYlcS07vK4w/UQOtsUYIvNUKE+ZmCWnmNHD5zaCWAxwxHHx7VwMXUMKLP2Q35JZsLYPotj
	CaakgnXqSxGuvAggG1EudK+zPfbclD/vZRRca78EniWtJgkVm2bUoT26jDyTeKLbKBm8wW
	UVPETM5pivLcjrAlNM/e3t2/ymnvNis=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-HBSHd0M5OAib-XNXRbTD6A-1; Tue, 21 Oct 2025 04:28:29 -0400
X-MC-Unique: HBSHd0M5OAib-XNXRbTD6A-1
X-Mimecast-MFC-AGG-ID: HBSHd0M5OAib-XNXRbTD6A_1761035308
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47113538d8cso31090305e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 01:28:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761035308; x=1761640108;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9wgX9rXCO2UPANmfcyjOB2pBN8YmhnWytsGw80sw54k=;
        b=qpdegjcf4u0Z0H0IvlrO86YTiKo0XH+v51XCe+RvoZtZwmudzT02YokesvrexpJKZq
         qIQE1tifeUuTA97qQ8R3BO07uWdgMJDcNBXzgpO+ApzjMNFIXhXkL0ULu49RlMFJnjFc
         EwQKUQM7/WDck1bJTX6bo2zt17hgVGfNtevSMp6hhnOoJHGNtzfa21d5qretJ7Wh8qgX
         yUAniCo4lNzos8b6OJCU8Q0e4j2z+zstwKQDynYoPrHioebW4a0qX7cb4pzK+D3qU9Z7
         gUJMfkn5n0uBfdGE662LpOLWPiAoHfrz25GP4ZjeeMl2o6jrcVCFLXf7B78NL19hP8M3
         Gh7A==
X-Forwarded-Encrypted: i=1; AJvYcCUAjiwTG3nb4VBjeaRixXOznUHCRfbGDAQwGMRKux+SfVQxfOlx6QzuSdV7jQBYq3Xr469ZPU7DfR8zWGM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk4pwLXISks//YLyOdqpHADqBskFHOfmJcWsPDcp87X4tI4IC/
	Xz5R4n25BXLi9njBFcivx/D+OpQqy5AARuYYBXE63LUB83Ti9PKAWG2KYq3gcurkIFozLyd3GnL
	Cipz/4BPDLF9sjhURyGrgpO6DvWdD7xxmp6mVDqi84yhEkCyoeNwULkE2UR8Nocrlzw==
X-Gm-Gg: ASbGncvEwpiCxmYXwXrdsLJND4qDJredaRdqyovv8EbK/jtNFjLI7NI0CzXW2Km/SGo
	Cdm7kX0DUvhm/YrBaNvPKfy8A/mLTQ37w2hqBToQYsmf28U0bkbHK6LTB36FmJmezMNZqJNMWYl
	tKYO28XJC+BvfZNsn/YAbOsohA6fpaDUwCWUKNiWFZVeM2WA02A02qmPexrlPOGblG8w1OJWEMT
	7b3mqsJWEyF1BZ1yv+wikc/NUloEoXiPig+nPGL2J8KrVADaIYzhLlXP7uF44IjqRk60+x+afhO
	UoyWC/sFQQ17jY5A8KIuGerzSZEq+araBPvy/WvTdakLEWa44c8VRjtb0xK2JC8sBPGw
X-Received: by 2002:a05:600d:824d:b0:471:1b25:f9ff with SMTP id 5b1f17b1804b1-4711b25fcefmr68406875e9.39.1761035307821;
        Tue, 21 Oct 2025 01:28:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGRVyIsfoQR5BPGvrQHdlbSlAJgPiR7tZMRXYjTySH7Todua5vbiJ9sWTo57eh1Pa8fByUpA==
X-Received: by 2002:a05:600d:824d:b0:471:1b25:f9ff with SMTP id 5b1f17b1804b1-4711b25fcefmr68406715e9.39.1761035307261;
        Tue, 21 Oct 2025 01:28:27 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4714fb1b668sm213055095e9.0.2025.10.21.01.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 01:28:26 -0700 (PDT)
Date: Tue, 21 Oct 2025 04:28:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] virtio-net: zero unused hash fields
Message-ID: <20251021042820-mutt-send-email-mst@kernel.org>
References: <20251021040155.47707-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021040155.47707-1-jasowang@redhat.com>

On Tue, Oct 21, 2025 at 12:01:55PM +0800, Jason Wang wrote:
> When GSO tunnel is negotiated virtio_net_hdr_tnl_from_skb() tries to
> initialize the tunnel metadata but forget to zero unused rxhash
> fields. This may leak information to another side. Fixing this by
> zeroing the unused hash fields.
> 
> Fixes: a2fb4bc4e2a6a ("net: implement virtio helpers to handle UDP GSO tunneling")x
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  include/linux/virtio_net.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 20e0584db1dd..4d1780848d0e 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -401,6 +401,10 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
>  	if (!tnl_hdr_negotiated)
>  		return -EINVAL;
>  
> +        vhdr->hash_hdr.hash_value = 0;
> +        vhdr->hash_hdr.hash_report = 0;
> +        vhdr->hash_hdr.padding = 0;
> +
>  	/* Let the basic parsing deal with plain GSO features. */
>  	skb_shinfo(skb)->gso_type &= ~tnl_gso_type;
>  	ret = virtio_net_hdr_from_skb(skb, hdr, true, false, vlan_hlen);
> -- 
> 2.42.0


