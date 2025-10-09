Return-Path: <linux-kernel+bounces-846478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68199BC81DB
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 10:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C88F188756A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 08:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5B038D;
	Thu,  9 Oct 2025 08:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ToNIuqHt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE54274B44
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 08:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759999635; cv=none; b=QWKpElR58tSk3CtF63Qm0py5rk5U50xbLsoHl6ilKn7JaUYKS7Tige4WtpRp2nk6XSSndoaFfrayNHxiobDmUdSG1iTej+a9BT1ybTmAbUt7jsn+s7uL4Rbia8k38daxwqitfhI4wWIt+/R6atIMQlMoGAEzJM5WMRfGiRJfqXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759999635; c=relaxed/simple;
	bh=i0+auL9WZo6acyK3t9ckGl7eYBZ0eEV4fO/V99agg+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LHTouUPRJP3j1bi0thCXhhZPmKDEAbGZ0WkEBgSXZ9nhTJlIS6mQy4FZ1ezkNrR/R+x18eLiBr5dXMwHCkX4e9oclRvWr9wO/ztctEu+6m62bfuRKoT4eE0RExDYWTorSYEklhSBW4PsekNhJ22nguwf05Vxn31zp+ADizqda2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ToNIuqHt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759999633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FYPSmMLiVE1vRxaqysXPxWnvNjdPRDnGzEaVSJvhD+4=;
	b=ToNIuqHtOx3FJnJSJkHEHAxpvB0z8BB9hRrsHIdI9JYKlu7WoPxiXZ76Tn9ku9kYzSvd5L
	MGwG3mHuWN+EL6DuvRXtQgOUiuJnuGzdl/H5SOAy3lods86z7OxwPIXUV97LCg6KJlv2l3
	zHldCU3vRGj8bVWsve1QqgWgbcEVEiM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-9TJe2W4bMKqcGtyQwodVmA-1; Thu, 09 Oct 2025 04:47:11 -0400
X-MC-Unique: 9TJe2W4bMKqcGtyQwodVmA-1
X-Mimecast-MFC-AGG-ID: 9TJe2W4bMKqcGtyQwodVmA_1759999629
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46b303f6c9cso4789295e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 01:47:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759999629; x=1760604429;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FYPSmMLiVE1vRxaqysXPxWnvNjdPRDnGzEaVSJvhD+4=;
        b=J8fV36kUqxe7nLNgvrbvcCox9m+WisRNlhVMqQsa/6kA8HQXFjw2IOzTKw/pKINHy3
         F8zOXOfc9fgRtf9cYVOUvvx5Rv3whIJja2hE/Q1V69goFEJYwwNbcw8t3ebrjlWWMUdZ
         vZfMXGGIT4Yi3lKxVEjEYceC8WlU+jHYNbXTh+Khfm+VzwNxspuV0ieLqFeCgpgoD116
         aSisRxVFQSFNcq+c3kcyw0y1P1E5aoT0iOGq8EazIhULghqHYAJdew2Gakc8oYSzmads
         ntsJbBuupQ0u1Ixrbe1euubi51yYp0CssawUc6ttrvMWvlvIKuAaIncFr8GRG3EoAlg5
         5tvg==
X-Forwarded-Encrypted: i=1; AJvYcCXyZ/l2QDP5bDjlBziGwT4PWyiX8qyJGG/SdlFglafXy/SFFVHRLWFUuv0bxL2WesgWjWPG5x3A01BzeFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDJ9WbLZC03GWjk8MI1maVJaRDDNMO+sLeTXY+26XgEBhbKsSG
	zKSfo67PIJia8xzMhBIaGn0X/kDskObzqXGShnygq27NmCcU5HKA+UXQmFR/WhG9K3oExVVcmmY
	XXVf2tITgUDKvXwIFXLAJOEfPWO+Nvfsig1dX9VaEF4O0efL5p1SBVmmyePxE2ZreVw==
X-Gm-Gg: ASbGncveqkrJzgpgdEba/x1Qt9S0VCQusWDoy2P+SeMJMPasRZxSzsO099lBaoqioiO
	fe265JELg45UnqOKBjrxgwXibtOCaVXrUG/vIQ4xZ0JrJs9F83Vdrmz1il3cG6I/ARY11obXqAe
	JoiqJ5QX/qnXw+XngDYyNfgm5c7XyxYxGdROkQxEuK90M6jjdZ+WIFd8U5a/g5dDqNbes0bqX6b
	lt+IkGTYYnjZ2DpXtfRrTH1jHzSn8do7fo13vs5WnCdqXi/ZZZAVzqYLtB1FSYM/+885EetaU/L
	QzEGD5H0xK0O13EcZ3dXJqCCN02cHAiU3uFQKwnab0n6kFqXpde/8PjHVIQJZdNKApcjTXQy7UM
	vzhztQa0AL+Md03++Dg==
X-Received: by 2002:a05:600c:4745:b0:46d:45e:3514 with SMTP id 5b1f17b1804b1-46fa9af3045mr47067845e9.17.1759999629043;
        Thu, 09 Oct 2025 01:47:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhyHsRVdtzI7WBZXfSp8UYaDtELObmhEsuzOkOpCP2sIgluT2oVR/QZMswp1CBbHoakmRFPw==
X-Received: by 2002:a05:600c:4745:b0:46d:45e:3514 with SMTP id 5b1f17b1804b1-46fa9af3045mr47067645e9.17.1759999628643;
        Thu, 09 Oct 2025 01:47:08 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46faf16acc5sm41338355e9.10.2025.10.09.01.47.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 01:47:08 -0700 (PDT)
Message-ID: <a756f384-33c2-4c21-a23a-9223823f296b@redhat.com>
Date: Thu, 9 Oct 2025 10:47:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: cxgb4/ch_ipsec: fix potential use-after-free
 in ch_ipsec_xfrm_add_state() callback
To: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>,
 Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Leon Romanovsky <leon@kernel.org>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Cosmin Ratiu <cratiu@nvidia.com>, Ayush Sawal <ayush.sawal@chelsio.com>,
 Harsh Jain <harsh@chelsio.com>, Atul Gupta <atul.gupta@chelsio.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Ganesh Goudar <ganeshgr@chelsio.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20251006134726.1232320-1-Pavel.Zhigulin@kaspersky.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251006134726.1232320-1-Pavel.Zhigulin@kaspersky.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/6/25 3:47 PM, Pavel Zhigulin wrote:
> diff --git a/drivers/net/ethernet/chelsio/inline_crypto/ch_ipsec/chcr_ipsec.c b/drivers/net/ethernet/chelsio/inline_crypto/ch_ipsec/chcr_ipsec.c
> index ecd9a0bd5e18..29dbc3b6e9e2 100644
> --- a/drivers/net/ethernet/chelsio/inline_crypto/ch_ipsec/chcr_ipsec.c
> +++ b/drivers/net/ethernet/chelsio/inline_crypto/ch_ipsec/chcr_ipsec.c
> @@ -301,7 +301,8 @@ static int ch_ipsec_xfrm_add_state(struct net_device *dev,
>  		sa_entry->esn = 1;
>  	ch_ipsec_setkey(x, sa_entry);
>  	x->xso.offload_handle = (unsigned long)sa_entry;
> -	try_module_get(THIS_MODULE);
> +	if (unlikely(!try_module_get(THIS_MODULE)))
> +		res = -ENODEV;

Here ch_ipsec_xfrm_add_state() had just successfully added a new entry,
but still return failures, which looks inconsistent and possibly cause
more serious negative side effect. I think you should move the module
check before the sa_entry creation.

Thanks,

Paolo


