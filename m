Return-Path: <linux-kernel+bounces-875475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 29331C19135
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 697E0564CE3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012B633F8BE;
	Wed, 29 Oct 2025 08:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KfywDkZB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9134F324B0C
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761725934; cv=none; b=ZrXvH2Qw08D8Q/PnQThSvvY2gn2I3cKJ9bLywOaucBdZX7rGYp41n3mcyeuWF+5YivzrsuCY9lF71CeL/wlR6dLgcNghdfbL1ZWvl4JZd8nkQaNOXJLXEmeNWlzozCaCtMXkk4NAykXqXpx+ypbzodreSXb1d8PW7aWzkNHkv1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761725934; c=relaxed/simple;
	bh=8H8soxGYOT3vCG44vOBwzgrU1KAhGT6U13rFxFdobrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k3azMBqti6WAqEfKrB52ZwmntR8lP6IOQttFmlu4m+rwA8liIa+CQOLqq55jz3DO/Kd+Vz5/pF+/Fr8s6gHDPfi5IOnRTa6BCjI20j2ZaUizO0u75GDgHgY0idZMd7z3JEw0MGS+53lvNd2DAdWnqE8lIuihFkMsMk3KGJOQhkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KfywDkZB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761725931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+CcZI/qnw6B1L6zkF86iXEfjDjYa1qezAoXbeln8mok=;
	b=KfywDkZBEPV0P1bey4jIWH22s+XaVwTnw8GAeGVz10VfNfnigEUZUG3qOuy8hr4t4TkZTS
	X6x3fq06E1+whpa6e973ILcWwWvB90Go+21NIyoSAPZI3YqduTguDRnJYhoY+U+gpMLcBZ
	MiEwNQaOLg/PEo5NTnNZmcjJzXl1NdU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-jQjf76tBP-KtPlhf8Zo4mQ-1; Wed, 29 Oct 2025 04:18:50 -0400
X-MC-Unique: jQjf76tBP-KtPlhf8Zo4mQ-1
X-Mimecast-MFC-AGG-ID: jQjf76tBP-KtPlhf8Zo4mQ_1761725929
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-476b8c02445so35809245e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 01:18:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761725929; x=1762330729;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+CcZI/qnw6B1L6zkF86iXEfjDjYa1qezAoXbeln8mok=;
        b=tp0ulBlo5rRfbvQtoh6gMDeDKIC9eilIxeeTnUS+tvPaZMnFYTZTk2u+g1ycNpJ23u
         TmnBhqg7BVCDyKwycJPJmhY+RVH8zcuq0DBmyNWWd8JALVmgOhz8EF++WpsvJKLKN0s1
         Wqr44cBIUKiYCGO5bDJRDkE5k9uV4wABhc/E7235M/d2tBLEPzQgKp34CwLX4rNkSmQI
         3PhnLdeK41nNoz3guqjvDLv/INtd5arbFEeCIG10Gd86pwITEc4d7UpIczuNScYtAIsT
         P4nNh1rnm93LeY0OLsG1mwdIFN8vTxxQbgKIqaysNvUzfibIsOik74Dh+FGFY1NbAc2x
         TejQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBtob3lfav01+d98nhfZtyATYaEHqksKjsEdSpP7wgPQZs+YmV5sQULj6elOp/S4DnY4ZNo/P01YpP5M0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5q4XUUyFke4H0AjYuRhkuQ0qamILZqoQa6VpdWm4F0qq/jb4T
	Q5QwgBIQ0KteVpEcGvDg3Ptr2rNlPiBA4oK1j7EagGQ5NwZuttmDcez626fc56a51ukF7yKdi2k
	DuPovBtDW8D+ICjUyYhxupKh3WWw8pKe2wNQ3cKgXiuXaCYoHQEMzTYjU1yi3tRrKZw==
X-Gm-Gg: ASbGncv/DtQewXTujK+wxf0l9tU1Mp56ToJ6D1SHVCIMO7ReG/RebuLbTLcNh+kYPKY
	piI2X4dK9IZuaSHzInC1xSUxIypg+MI36DyBeZoWYNt2Qdk9skkFpbXkY4eQZg+UvKzMsE+bANm
	BITc7/VhuPvaoVC7C7m97+1SDTijIqimNevcI7pU9WM9xkmvIS93m0EcMSm3aBmPft9WqUCyTfq
	RItgrY70+JFVBZQm1K9/oitG7OknbUNwqbxR1JL30mh7ofMqdRijEBA3YD2Oiphk5pMvDrG9b2U
	1Mfembsp2DlW4nXitIL+ew9hvsCYK5ZBjq5dhthMrPEbHteDNgHDCPrkeu6/s8acN9YNSyt9gqR
	0jaIPKYJ3gfLQ9kvxPDXo4QFLdDNCBsnC52oX+cXbmcMYEJo=
X-Received: by 2002:a05:600c:474d:b0:46e:2562:e7b8 with SMTP id 5b1f17b1804b1-4771e1cb161mr18373165e9.21.1761725928782;
        Wed, 29 Oct 2025 01:18:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEF7JQwZ5gI4oKfKp7iQpZcTNE4SIKlKh608B1gAeQM0JjYtj8qEfOSjsYmJMqvyHD8orGB/w==
X-Received: by 2002:a05:600c:474d:b0:46e:2562:e7b8 with SMTP id 5b1f17b1804b1-4771e1cb161mr18372985e9.21.1761725928400;
        Wed, 29 Oct 2025 01:18:48 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952df62dsm27290030f8f.45.2025.10.29.01.18.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 01:18:47 -0700 (PDT)
Message-ID: <96f6d774-457e-4bdf-a0b1-eb6f64b99a46@redhat.com>
Date: Wed, 29 Oct 2025 09:18:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] virtio-net: calculate header alignment mask based on
 features
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20251028030341.46023-1-jasowang@redhat.com>
 <20251028101144-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251028101144-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/28/25 3:38 PM, Michael S. Tsirkin wrote:
> So how about just fixing the root cause then?
> Like this (untested, if you agree pls take over this):
> 
> ---
> 
> virtio_net: fix alignment for virtio_net_hdr_v1_hash
> 
> 
> changing alignment of header would mean it's no longer safe to cast a 2
> byte aligned pointer between formats. Use two 16 bit fields to make it 2
> byte aligned as previously.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

FWIW, I like this solution. With the u16/u32 change, feel free to add:

Acked-by: Paolo Abeni <pabeni@redhat.com>



