Return-Path: <linux-kernel+bounces-830026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F373B987C5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 09:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C934B1772C0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 07:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C6B270551;
	Wed, 24 Sep 2025 07:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BpvRQHn7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874B626F2AA
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 07:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758698328; cv=none; b=p6Y0lCo34iRmjGcD4Rn7CyXhz/x2mYv200v2zeGyq1JhatinWGbH8PLhn1tlUS6EEazMvpj8kx3ZuXSyhKPBijVCzUVxZ4ZZ7+FE2+Ub0+eN/4e2fY55JZdMAOgg7kqd4umITwfV26Ltz9QGiVioYAjxKJprlX3xpO0EpjVJMB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758698328; c=relaxed/simple;
	bh=vFGV/5SdrXTqAjDg1Z+qtUf7lXuT4QgHCPVLjdBhXkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X7fO+CiLheTHW4KYEN3RwGEassoDs3Q9MWVwEsukmH1I6CJfm2jo7GQlBkKLt0RG0erf9iMM9oaElz8YDZ7qDsjnVM415BRsZ5+d5SEdhzssQXRjU8pN99n3DmyH/f5CEIQjPZWtfxe3NT1hzSAUdfDRcXh7wEPyFwXmY2myyWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BpvRQHn7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758698325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x4iJVB6lD2fruztfkG80c2BDXVSi3uw6WFakzazt5Zo=;
	b=BpvRQHn7cNZq5pWuP49RkKnIJZSwSvxbcsKmuYQldlXbAvde6XqEptmVyzmZH/r09K5D6H
	+7sgFaxferELr0RINM2gvyMLzHBOnWvWwHhcEwdmK8ResiqFRH9VTfBpPHIKlCUJ1AdI+E
	UZBC0o+0lzXyX8gB/7//m/MCdrOGCes=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-XUpShtbKPdW-07zWH4ugbA-1; Wed, 24 Sep 2025 03:18:43 -0400
X-MC-Unique: XUpShtbKPdW-07zWH4ugbA-1
X-Mimecast-MFC-AGG-ID: XUpShtbKPdW-07zWH4ugbA_1758698323
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46e19ee1094so23831525e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 00:18:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758698322; x=1759303122;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x4iJVB6lD2fruztfkG80c2BDXVSi3uw6WFakzazt5Zo=;
        b=ZcCPq9QqHLzxX3jehAVoBSoyUV7ofpnRWefPUo2lum/c5swljwbnaIQ+hlbOE3MU/6
         r/2o+qdv4nWWgdbwOstxl5K9LnTF0G2VgP0m2kSvZCdGd76U12zmbFS/8xJviYoP8zGX
         oEYTc48vqRf3g0Xz4c6EJYcoGTnesiza7e/8tpQcKtjhibwryxf3CgC3FgHGtU7rgSGd
         UYb+T2zJRiRZlIrKhf6XgN87A5645nQC+qfHT8zNud9VB/55kZR0j23Aztt0uvi6n0Y1
         lcVl7atOclXR/oRvBuEHtkOo7JIXmV231Vkfqys8VfgBdEjJ5vGz6C8WYTwv193alaze
         BP/A==
X-Forwarded-Encrypted: i=1; AJvYcCWa3xqBLQIeD4Lz6U9eneZtv6J3HEV9xJl9p0Udqfk/ILj8FmOOBUwSKH5zr6L9BkYJtrCjE3sgkuQnzCM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8HCAroQToH5//se5O417QwYwf/NJOpnOzx3VLZu2QATrfybem
	Ql5OfAq1MTYNpBAAHdt/ZQnqQkmqkpCVhw/LWcCQdDcSRKeXmIB4QbutenAUMnqVk96+SRLgq27
	szsmYdX8ZwNudvEGsjgsb1x9LkJWmY9oyRQtvmZWbQil7HIvhssaUZxo9B0HKZHDneg==
X-Gm-Gg: ASbGnctbD89LVOTfsgw0uLEJ7fF5Wv65fvTB4pAO5zlQb7/A/X9Gk530z71s2VZ92FU
	9rU3GCHhxZFpbXswYi3QA0KlzsAyDQTV25/r79kwEy5mtvlIj0eH2eNF8dondATaNdGA7EwqFUe
	BFW97uxHlfMm1FadCTNDJvExd/EUhH1I+g+SvJxZZWnJYX/mvYz6ee3EjLb+10B0ZvkMnMb2mae
	pwzLEXuvalqu+G0zk4zoNbwfiRu+dmLQ6IJvEMS0/5N2Tk0JJ3hNzuJslgynyK9I5LSmtjmTlTF
	vCyGMHS4LNFOoY07EorbL4PYTSh3m9kYN6w=
X-Received: by 2002:a05:600c:4f16:b0:45f:28ed:6e22 with SMTP id 5b1f17b1804b1-46e1d9789cdmr54641475e9.3.1758698322529;
        Wed, 24 Sep 2025 00:18:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbSI2vy3Xtfu4Q9BvlHbV7J5LuaePh9VoqJOvv5JsIaLhsTV8uduTMFmV9uZ4PhlaEw7WBrw==
X-Received: by 2002:a05:600c:4f16:b0:45f:28ed:6e22 with SMTP id 5b1f17b1804b1-46e1d9789cdmr54641135e9.3.1758698321969;
        Wed, 24 Sep 2025 00:18:41 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2a9b1dd4sm18905645e9.8.2025.09.24.00.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 00:18:41 -0700 (PDT)
Date: Wed, 24 Sep 2025 03:18:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	eperezma@redhat.com, stephen@networkplumber.org, leiyang@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH net-next v5 0/8] TUN/TAP & vhost_net: netdev queue flow
 control to avoid ptr_ring tail drop
Message-ID: <20250924031105-mutt-send-email-mst@kernel.org>
References: <20250922221553.47802-1-simon.schippers@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922221553.47802-1-simon.schippers@tu-dortmund.de>

On Tue, Sep 23, 2025 at 12:15:45AM +0200, Simon Schippers wrote:
> This patch series deals with TUN, TAP and vhost_net which drop incoming 
> SKBs whenever their internal ptr_ring buffer is full. Instead, with this 
> patch series, the associated netdev queue is stopped before this happens. 
> This allows the connected qdisc to function correctly as reported by [1] 
> and improves application-layer performance, see our paper [2]. Meanwhile 
> the theoretical performance differs only slightly:


About this whole approach.
What if userspace is not consuming packets?
Won't the watchdog warnings appear?
Is it safe to allow userspace to block a tx queue
indefinitely?

-- 
MST


