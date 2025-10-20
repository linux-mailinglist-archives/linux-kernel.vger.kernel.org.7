Return-Path: <linux-kernel+bounces-860583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C28BF0758
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F65B188D2FE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6205191F91;
	Mon, 20 Oct 2025 10:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YJqDUezh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA912F5338
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 10:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760955099; cv=none; b=kohejQdR5WJ8vrWirJmidBDLNhq57afddlbuCQXSL35buz4x0R+QTsFHTtak7PffmYV4NkwfXBo6OAnjOVDubfkU7hjuPgcYaZXd3y604WzBsLfFNqG7Wl8d82qCO39WyfxW7nub4augJVeJ3eE53AlOm26SSBtp8FAipW6SbHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760955099; c=relaxed/simple;
	bh=ZHTslemG6vD7mveUfKMEef1heksyeaxeei4lGFbU3eA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QdOvWNNK8R1Nu5td09P2WUag3ZzxP9JTldYZaud4/LDWxrj1p1PAJyafH/rc8Zs1jkZlz5XCg/gjmcbquXNEo8r1mtyDkRk7ClSG/QWFXtJxlevWKPJS2kyG2Du1uI0PFiJv+aIkRxPb3boXOMVgpZRKGr6a5LiQmwz95Df/7Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YJqDUezh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760955095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=By7D5EDOrUkPayF85rpQrUjI0fj8mVU6g5pLLb1g4yk=;
	b=YJqDUezhOd/uN5Ep5cY19bXOkRaCzT8P8Y2BM5Kl3dJmsMB6Khq0dCp9bPDPWcKwmJJxd/
	4JYrYhpTrWqyGPJR3ZfGO8bwoXscxzvi5KFARyuW6x8JPMGlbXGKaTLaYyug3ztRMdFTnA
	wswJZEbjL8DwxTzuoOkjhxRHEiauumI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-vwNN3HjLPnedKcJyxL5TMg-1; Mon, 20 Oct 2025 06:11:34 -0400
X-MC-Unique: vwNN3HjLPnedKcJyxL5TMg-1
X-Mimecast-MFC-AGG-ID: vwNN3HjLPnedKcJyxL5TMg_1760955093
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-426feed0016so1711285f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 03:11:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760955093; x=1761559893;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=By7D5EDOrUkPayF85rpQrUjI0fj8mVU6g5pLLb1g4yk=;
        b=fzyf7KSA+JbEQfOjuXWyI8fHQGkKTHqZiKTvBNxIIMp4S1nABP4HWH8MaL6jD+EFxf
         ElrFadyVtNEE8DSTfemHIEd5bwHdM8/TOO1YVHFAPyOOUv3trcyRrZvTI97m7fdXqr4c
         Rbj7HDsmsAT5VhC7pfF5X2bhcF6J2/53QmFQlO4pB+gjkZCrm2NS6Cdz97Q3HbbT+TZf
         ou6Sljjo2WgLmOjGIk8OpIV1MLvC2tpiK7Cx3raRNmb/2T3Udv7nVHf4yQpqRtXYb+ub
         CsrVb7mHKT1Ni0645ctb1rQD8E+xYlOsTTRtyePYA12uFfbV+a4ZqZcULZD+2CXlcsyT
         CoXg==
X-Forwarded-Encrypted: i=1; AJvYcCXC3Qbj22NIxaNmC0uxoir2x50qWugtJKUXkMfhEMqfzDhiCsLTax76weVQK78RDt9wB6gG/dsl5+TYWL4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO7gILqmT5YlzaaAmVZTZmykpe7D4cGmZOsuyMUd4ZX9DS8WEi
	THoTktelbX6YbhPtUFrtHefr6RPooA2YjClbp6CFoxWT40NIIIdSyoO/wcnWG0YPauBjCkdgSd6
	R6FJ3QEz39S5WFEEY6PO+C+Jhy52jFLVcmyS2utE1j0o/ydSkG8kf/LbcCa57aasJhA==
X-Gm-Gg: ASbGnctgzlGu6tm24MmMXeIE54874hyqB0sJmJM1a+Rhs45dXew4CA3nRaWswi0sC0c
	HJ21YiRXLKITWKOCgOnEJ4P6q+s4YjYyT3X089g9p6EEiV3MHhhbIOL+J185LLvyssSi/UxbrQp
	oGW+Et/I+8CE1UC0evhgAScbyu5m1DVCqsqAoBKwhz4Jeh+kyGwCt7PZeAJ+Ku3qCZKSUlt+fSN
	UijtHiDJaAAh+Ol5vKJ0cGuI0Cpt5VcaY7gfhqpVffBnhFD1797vEYM348pWk/WtkAaIGU1mbfW
	ONmB6hs8+kKML9xDr//xxIWNgtoGRhuEUkwER4g33aXjdbFNm2SJbJR87VCnsKXfdzWc
X-Received: by 2002:a05:6000:2512:b0:426:d589:2633 with SMTP id ffacd0b85a97d-42704d993d3mr9607607f8f.44.1760955092891;
        Mon, 20 Oct 2025 03:11:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcCqLGIZso6bGMyB5AaLWkPWA+ClbR/rzs2RDoBD+0IFStoS89flwVj7QRG0ejepqFb1hRXw==
X-Received: by 2002:a05:6000:2512:b0:426:d589:2633 with SMTP id ffacd0b85a97d-42704d993d3mr9607593f8f.44.1760955092488;
        Mon, 20 Oct 2025 03:11:32 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00b9fdfsm14430388f8f.40.2025.10.20.03.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 03:11:32 -0700 (PDT)
Date: Mon, 20 Oct 2025 06:11:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V8 19/19] virtio_ring: add in order support
Message-ID: <20251020061049-mutt-send-email-mst@kernel.org>
References: <20251020071003.28834-1-jasowang@redhat.com>
 <20251020071003.28834-20-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020071003.28834-20-jasowang@redhat.com>

On Mon, Oct 20, 2025 at 03:10:03PM +0800, Jason Wang wrote:
> @@ -168,7 +172,7 @@ struct vring_virtqueue_packed {
>  struct vring_virtqueue;
>  
>  struct virtqueue_ops {
> -	int (*add)(struct vring_virtqueue *_vq, struct scatterlist *sgs[],
> +	int (*add)(struct vring_virtqueue *vq, struct scatterlist *sgs[],
>  		   unsigned int total_sg, unsigned int out_sgs,
>  		   unsigned int in_sgs,	void *data,
>  		   void *ctx, bool premapped, gfp_t gfp);

BTW this should really be part of 13/19, not here.

-- 
MST


