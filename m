Return-Path: <linux-kernel+bounces-898949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E273BC565A2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 09:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FAEB3B6906
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 08:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C891330316;
	Thu, 13 Nov 2025 08:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ecYx6JBV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="a8uEiwxq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA8D26AEC
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763023778; cv=none; b=Q4b+Hmy4Sva29QxuRF2MKlwOwYEAs6fV3ly3Qw4ees18LaSDDf+En12Euu4Q++BLRbalzzLxn57nlAiU3QkJlJsRolouD2hgsdrqpDVKRAB2vOoN06aazokHD/rsWKzVqVUokfjEwEBGaNomaacZF+rRqqHveMivhlf+gJ2EE6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763023778; c=relaxed/simple;
	bh=3ClZSRwKg6h2JUvk1lfL/Ef52AZNj5csT+dOuK9K3pI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MrK3+c0wkJq7ksUnfd+feZqLeQAgO3OBTC93Ac5KhrIyXZJR48mmo1v6CZmo5sYerQdKhnd9BcMeOvFa5qvD6ULXLOnFbm8Mh0BkNmEOC9TasBSFwPqyjFf2wmfK/Ia+dTox50FY63Yi5BHiC1Jf+HgxJ1BRSwrC2riUcDVXCSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ecYx6JBV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=a8uEiwxq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763023776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p+z22V+mQXu1nf5PZ2QEjbDMajJwQynoOz1yV7a6Q5o=;
	b=ecYx6JBV/kBkP8nvZ9LWwLcd6JsNnYEEpgtUGoY7XbcUeyLBS+0IX/XV/Gl4bgjBa1B4Di
	F1m7tURIzwxsb4RyArqddoVkQjPJ8Ocxx3URmsrLorUiwT5KJgdoolciG/gLcBdpuBFfcK
	RGbeK43t2H8Mvry2JsFrKU/KQF50a0I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-lhS1voJ6PLavlpDC3azZNA-1; Thu, 13 Nov 2025 03:49:32 -0500
X-MC-Unique: lhS1voJ6PLavlpDC3azZNA-1
X-Mimecast-MFC-AGG-ID: lhS1voJ6PLavlpDC3azZNA_1763023771
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47111dc7c5dso2685155e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 00:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763023771; x=1763628571; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p+z22V+mQXu1nf5PZ2QEjbDMajJwQynoOz1yV7a6Q5o=;
        b=a8uEiwxqD2DI4BC2KdJ6Y7svMM6qTDyPRlzI8DGf+W/tN3chbKheW8wQq52fiVejKf
         UKdQvVQtG7jm+jDNLjwPc7cRDcNiL4IVFFabtxgg7IKP6v2X179LYEDxkHZ4l3jk66lz
         eKvkZ35uL1QSd5xeNDS6JO6ylbBI0u6IrJNXIBmL6rFTk4EqRaBf9ZSgpIqC+ZWrFhUC
         4ULrJEpKy5palsTOXEPE1cc1htKOu6aka+R8Cve9ZiDzLxUcVCZe3IXvVye1/a7u5s1w
         pZV3swsmyqZlhEaAUrALgIqniBIY58TJNuWonzfl2Mt8zR9Hn0X7BSxOKH1yehXnxZbQ
         vJXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763023771; x=1763628571;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p+z22V+mQXu1nf5PZ2QEjbDMajJwQynoOz1yV7a6Q5o=;
        b=VlBqMVaEvkwc2Y5WZ6WkvtGrjOunHMXACDN30xQdCI7UCjQwLfdm6+6F019+UEkibu
         WybSzGVHyPcZv8pX9MUJqWeRFCn3K0a+zp5Z08OXmWEAlSBEOkzyh4ZYKKx2aD3riu5t
         8kw1YxDFcpiM9H3Twc2XKsNmjJh9D1DVl23cKhSxdD20sd1/fHWINj/TSqF/8FSMyPAI
         /H0Su3+MJ7rj9gs4BJhkJwONWbXKHOLeQgJqmw8gxFSjRAUYNrVzTsm9DRn87q3SiOJ6
         M8JNs0/XOJqEBXlUYxQuiWfm2N7n+x3pj5qp0pEAVhzWEZ4yYCWtF+v5Y6oJ0i/D0gIn
         svXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSTlr/fpeB1EBXQftZrsoilyHHwfTUdJKZpEWEHIFwACa/4LSINSWwkfcxB43cQl82CLwcyBUoz9/lx8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLDpL2pXR3ARlSqXC/iFds8y8ehmlU6gwNsD9znKfBkPRrvvUF
	2shTxsmanbpGVmZj4DZoiNw82IGREdZa8U6m7w8gF2Nv9hD21AzIXulxUBqe/AKjTzz/RjdE3lx
	8YPv+16u4TTElwhy0Ctb+neCs7oGOIExaXgqPc3JkXpeIy+HTZW32qnMoa15rg7RYQQ==
X-Gm-Gg: ASbGncu4rPrfMh2h+R/Y6a92hrGk2U5GnlhaFl49E/lriqobnYYYJEZxE39MQl8/LfH
	csyGgQlHrzBcbyHrMRljf5s+opBf7OnMEkcJueVE4eh6HPNBPtFt0nf61gZHmVASVXo8OxU1aZY
	4WWyqP6mv7MaLIOSCgckC0HiJ08OxxQg3Ju9g+C0E1drZ41czjsCxZCMDrTVbSXxwP/s7Gg5QY0
	EEO0kLdqEQT0JE9cMPrMLnRFvDzXgAi6lUhRwYrf0PMMVPYk+ItKZSfkJEIMF7lv3v7TQ7Ddw20
	iMOsD+LlFwshksE7j5KRAKR21q2NDHr+uddSwU6WcyVv+OLYvjQ2p/Edeg2gQJVdkIbeJrDyJ+D
	QSGaZhCxqMp+yJhwY15A=
X-Received: by 2002:a05:600c:2e0c:b0:46f:b42e:e363 with SMTP id 5b1f17b1804b1-4778bd3c9d3mr12295625e9.20.1763023771339;
        Thu, 13 Nov 2025 00:49:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG45gCQVBXnCfVUnX5RAwHFpjHJLZDprccGjGKuZEJPutU0CB1G4S4/9nDPL6TE+hr7KwP6dA==
X-Received: by 2002:a05:600c:2e0c:b0:46f:b42e:e363 with SMTP id 5b1f17b1804b1-4778bd3c9d3mr12295425e9.20.1763023770818;
        Thu, 13 Nov 2025 00:49:30 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f2a7ddsm2605263f8f.47.2025.11.13.00.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 00:49:30 -0800 (PST)
Date: Thu, 13 Nov 2025 03:49:27 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of Linus' tree
Message-ID: <20251113031422-mutt-send-email-mst@kernel.org>
References: <20251113125537.0d08e5ce@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113125537.0d08e5ce@canb.auug.org.au>

On Thu, Nov 13, 2025 at 12:55:37PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next build (htmldocs) produced these warnings:
> 
> WARNING: /home/sfr/kernels/next/next/include/linux/virtio_config.h:174 duplicate section name 'Return'
> WARNING: /home/sfr/kernels/next/next/include/linux/virtio_config.h:184 duplicate section name 'Return'
> WARNING: /home/sfr/kernels/next/next/include/linux/virtio_config.h:190 duplicate section name 'Return'
> 
> Introduced by commit
> 
>   bee8c7c24b73 ("virtio: introduce map ops in virtio core")
> 
> but is probably a bug in our scripts as those lines above have "Returns:"
> in them, not "Return:".
> 
> These have turned up now since a bug was fixed that was repressing a
> lot of warnings.

Indeed. But the rest of header says Returns ... without : so I will just
fix this one to do the same. I also fixed other issues in the comments
in this header while I was at it. Will post shortly.


> -- 
> Cheers,
> Stephen Rothwell



