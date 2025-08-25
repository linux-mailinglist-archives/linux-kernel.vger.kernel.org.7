Return-Path: <linux-kernel+bounces-785000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C72B3448F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DC2E3BFECC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C0A2EE619;
	Mon, 25 Aug 2025 14:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O5D3Ojlp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458C417332C
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756133481; cv=none; b=gqUGhWImyUIoxKOBn6vB57jLMyvxiA7rMDres9BynoJgNk0SyvleKUnpGcSnEqKeR2T4MiCFbUEac5P54TpaEQJtGlVc386+tcv79AzmehcMECoZ1qXX8fbX6CsiaPvERvSOg55GtdBAaYWUcyD2FmEX0G0zapuwvdxsdFUbwR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756133481; c=relaxed/simple;
	bh=oOSJGLCaW8V7KVRsbfS3RhvJdm1vkbZf5LZ3nUtQzq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R+SHrW7wh6XR6yCfp4Sjj/X1rJRUmVT5mFSnrt3dJOJBogjAULuIGVAvQmhRCJOSTtPr37aGLplChDMOKW8dy65g2SDHKcuSIBR4GGuzc0hMF86xDjrPe8Xcuo8ShcIGQ/wEwMq1EhtZTomVTKdRc82WDUUy7oNbj5/dIHioJ7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O5D3Ojlp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756133478;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4AkxrvBIB2UgDH4sPvjPCIhDWeQ8GQfYbkHQCnf6NMk=;
	b=O5D3OjlpVNKm9Z4ULOjYhH591LVX4KkvCB2rZBgiSKs6vH6WE6y5TvLiT2HIUNG6A9xETC
	yVagZBatmWfv+5xI8Oo4Ff1MwiXwAxQgOIIlTVqX2LoMH/X+f4nOShOpWTyIMzjq2q5iMG
	fB9DH6cHM3UwlIkXyQuxsIEy5KPNB60=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-mFYN3xvgNliAsU5Gn1y9Gw-1; Mon, 25 Aug 2025 10:51:16 -0400
X-MC-Unique: mFYN3xvgNliAsU5Gn1y9Gw-1
X-Mimecast-MFC-AGG-ID: mFYN3xvgNliAsU5Gn1y9Gw_1756133475
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45a15fd6b45so26762685e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 07:51:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756133475; x=1756738275;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4AkxrvBIB2UgDH4sPvjPCIhDWeQ8GQfYbkHQCnf6NMk=;
        b=OIvC03z5CH4tNc46Xqoqa4l3+KwBww2X86F6QDYuYW356IIqpvm0F7OxYOrTpyK07r
         1nlkMdjtH/cELLdDIEVpSgpUCC6Gnqwt3DwHEopbZGLva4BuSBZENUR6h992Lohq11RT
         CulYcJ284WJf6YUZVq5BU5DyyYxVBGXqWtIYr2pSuET99GamgVcMbS4Z3DbsVY8v27FL
         RnNMTrDjgeOxYUvbcowjL19fsujWsSD5oBTCqSlq2wKxAOfJ6TsmmMEUk53tO8fjaOgs
         sERsTtcYE3HNUzePASKtvx90bzzpZex4HP9vCFaUqkabIatcod6N84q4CXhxBiZdEA68
         vDIQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2/g4PriqmuAsNbzNIMLRHdctM7+f9teoc/Z0BrsXLQDYSybsQHdXwzeZI1XAQY1ehg3HFRgUz+aNA76w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo03Gia3kYmYGgKZbxPsHB4BzSTHYgbw13wuli4YZap+4u2Wxp
	FVMUiIwBTnk7xdYVmeJFhjK+ptZw70flVHuPOFcABArN45aFGoZYTJFlb2JE2xU0jT6nd1ObvMF
	pLK2Oi6CwIPxuNmcWRiAKJYfQbTVSAwH4RImVI+nUhPFMzuqcNnes7Opmf+hQTfIWaqXC2GVrFB
	Bf
X-Gm-Gg: ASbGncv6DOBa9pwkElXQHdHdVrTNO+S8Sv4oKyJc2VAle0xyMFOqy4tmOd9s5kuIEg7
	Tx/URVMLPEOoa47otUtiorzOrExacHwUUASoLzPFgQEin++qoaemY5SsMxemVKGpZM7jNaazz0M
	XYtu9A8DNLnkfy8s2QFkqM4bOd1rRYz4a6WVl829uAqRcBSFkiMfk3uTNS2CJp5eG2RdNHwob10
	45UBVbGAQau/hqgE0NDARbPpUgMJvqFqkS/PNu+t4LQ3zGOOJ/7A8xIXsChyuOkTCsNDsSQNiTV
	k8e8QtQ/K0YTKdnrJsDIxFYd9wMNs4xt6EW6XL80ahMDug6SxcUUZFuVRFLLxgQ2gFu5eXrcPhJ
	Kbh4IVGYQ7sk=
X-Received: by 2002:a05:600c:1c87:b0:456:942:b162 with SMTP id 5b1f17b1804b1-45b51792539mr113382535e9.11.1756133475232;
        Mon, 25 Aug 2025 07:51:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHk7BeSjA8U4Bh+P4ANTHgxAKR355HH2hRjmjNFnbu9lssUhx/ve8pHFzx43qF+/snZMSFyNg==
X-Received: by 2002:a05:600c:1c87:b0:456:942:b162 with SMTP id 5b1f17b1804b1-45b51792539mr113382255e9.11.1756133474831;
        Mon, 25 Aug 2025 07:51:14 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874? ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b5f4ef19dsm56584745e9.19.2025.08.25.07.51.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 07:51:14 -0700 (PDT)
Message-ID: <3cd48f85-ec6f-44b5-a35a-147e950baad6@redhat.com>
Date: Mon, 25 Aug 2025 16:51:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH] MAINTAINERS: Add myself as VFIO-platform reviewer
Content-Language: en-US
To: Mostafa Saleh <smostafa@google.com>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org
Cc: alex.williamson@redhat.com, clg@redhat.com
References: <20250820203102.2034333-1-smostafa@google.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250820203102.2034333-1-smostafa@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mostafa,

On 8/20/25 10:31 PM, Mostafa Saleh wrote:
> Based on discussion:
> https://lore.kernel.org/kvm/20250806170314.3768750-3-alex.williamson@redhat.com/
>
> I will start looking into adding support for modern HW and more
> features to VFIO-platform.
>
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index daf520a13bdf..840da132c835 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -26463,6 +26463,7 @@ F:	drivers/vfio/pci/pds/
>  
>  VFIO PLATFORM DRIVER
>  M:	Eric Auger <eric.auger@redhat.com>
> +R:	Mostafa Saleh <smostafa@google.com>
>  L:	kvm@vger.kernel.org
>  S:	Maintained
>  F:	drivers/vfio/platform/


