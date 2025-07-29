Return-Path: <linux-kernel+bounces-749234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D28B14BBD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 11:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFE7A7A9875
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 09:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3731288525;
	Tue, 29 Jul 2025 09:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cXNIE86Z"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7ABF28724F
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 09:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753783010; cv=none; b=XcvAP4Vc/0MacM6mOvd3uKqO4PqaduGntkkgHeCzzKRxTn0Yb7aF6LZ75RZDbrnkoTqqLonqs7KxWcWLzklCeqtvZzZCKvkSjEZFwK1AldRTNbyEMbAtfDXSr5jX3AcVG12ZqBeJInXi48P6Cl2sYfVhQQl78zU+H3J9UVjX5sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753783010; c=relaxed/simple;
	bh=zs5ODgjq88Dh/p97NrIETQcV4sqEQTVPW1IHpVCIj5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OUB/UhiTitqjw/pJFetMRichonSiVSTLgGC+usmI4tGQAfVt4Ns5DWpx1dyfifCoWbzsO1uLq8z0Mu6jIX5f6pshWeewZwhxolg415OgLiCj0FOafV57vzYJfKXlp4JQyw7bct9cJDwoyN14Sw/iu6Wmz0jv2q1O8TqNjSJ4IuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cXNIE86Z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753783007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v9Q72PwGeVTj3y8z/xg+PR9uIGfJgkCfjcqVd6z2uJw=;
	b=cXNIE86Zcy7SZMXeY209e6lf4p+0ZiAe5fbXpyXJNVDwgHEcKCCM9qGYKQ5Zofdgt7dREU
	IgE4pqFEoN5/+3uEZe/CMrYmWNvWIr0WC/d002sxwqk50mzhULDBny5D5Kw4r64YidCh7R
	UQVcxy4VzLvzzOMXo/5NbVaJlxOBY4w=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-5BEZHa0TN9C0iKY5OhQMtg-1; Tue, 29 Jul 2025 05:56:46 -0400
X-MC-Unique: 5BEZHa0TN9C0iKY5OhQMtg-1
X-Mimecast-MFC-AGG-ID: 5BEZHa0TN9C0iKY5OhQMtg_1753783005
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ae9bf1c5947so69652266b.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 02:56:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753783005; x=1754387805;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v9Q72PwGeVTj3y8z/xg+PR9uIGfJgkCfjcqVd6z2uJw=;
        b=BMVsCN47SJfknL50DFAsS7Uf9VstyhsrSB2L+ihhF2bcGNRfJeyFaOaVAAxI72fNRW
         aTlSGiqdCM+gXHK5CAOJ8u/nh+iQfFK15887A5D8I5Gkr6lYH6ItQJxkZPJrEznwC4GE
         KGjpabe+nVAhRDq+hyy5nxiyhma/lP3DviLVGtw5sG31tTW3H+/OC6ZHuLnurb2dwy1J
         wqXVNEzwrqaN52QO+O86LGelHdQC20lvE8HeVPo93aK+aiBuEOsIZoNDsBptD2tZ0337
         YLOocg8U8+iqOfsA19rjQfaYDw8Dqsq2Dr3qLJS6PbyiN3z3Y5IxZZLAt0T7YjBB+DkQ
         aXAw==
X-Forwarded-Encrypted: i=1; AJvYcCUShtdvWsbwrENVc3Bkd0BJ40Bh4JGmn2L/eD57fL7dnMPb4G8cAsvqMDdcPjwUmWwFebZWRdzjSmF2AoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1LYRpkdWDL8pncPxvJixj7KC5YXYqQUBRHWsmUYSnXvbE4hjk
	kmF5FIVcmnU6r9en8JZtV51HhcxDag0qo4lvKLcUqhYsILBjUBSml68+jbmfmndJNJuIzf4SUg0
	V1+cTXZiaUuUIC6yLR2uWbMh+F1y1Yg9Wb80D/IWbKycuTLoBT6SZMXu+gvpsAubw5A==
X-Gm-Gg: ASbGnctsoqP7EdTcPzNwL7CP1LGpRX1P+tXy16LJgme/QJ1EvQjAKTxOi64JwEi4Xho
	cuAL/Izx6Y1UTVGo0hqmIRY2dYYdNmbgfGMNHE9EtXXEtMdsca11XtD08oOfyBT/6YKDsFENUzQ
	8PDLpheX/skoJJn3vrRR5Sqgt6pOd9Fcwwb8I1mbnbYMytbBl0haV3ItYEuxM2rt02yVcEa7RRa
	gni7FzDX0OcPt7ozZvMrbxjuHFjwYQUqgw+SLCwS0OU6IebjJscD0WTLN8OGg7aEIVxzd4TA7D7
	UKuzXK23qAzTjKgOfRS6zrMhNnqCzZylMkU/iPlprtbCAfQ0s6fbxI+jkNBTnsdqnHyZUzefW3R
	6wkPE3Tw2EyStmOw=
X-Received: by 2002:a17:907:3da1:b0:af2:4690:9df3 with SMTP id a640c23a62f3a-af7bfd85f30mr309161066b.14.1753783004784;
        Tue, 29 Jul 2025 02:56:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGikTxgu8BzOOJSc5KnbVu6iBWvoq2vv43KLwCvZ/Y6ueWN7/Ah83jj2TRypRMINdlKpJ2KOA==
X-Received: by 2002:a17:907:3da1:b0:af2:4690:9df3 with SMTP id a640c23a62f3a-af7bfd85f30mr309159366b.14.1753783004396;
        Tue, 29 Jul 2025 02:56:44 -0700 (PDT)
Received: from sgarzare-redhat (host-79-45-205-118.retail.telecomitalia.it. [79.45.205.118])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61500addc6asm4421025a12.53.2025.07.29.02.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 02:56:43 -0700 (PDT)
Date: Tue, 29 Jul 2025 11:56:40 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, eperezma@redhat.com, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	will@kernel.org, JAEHOON KIM <jhkim@linux.ibm.com>, 
	Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH] vhost: initialize vq->nheads properly
Message-ID: <6yp7ww6misiazdkeumkklrds2e7s3cmgf42lafvukhhqtopby4@ex6h5km4hq5y>
References: <20250729073916.80647-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250729073916.80647-1-jasowang@redhat.com>

On Tue, Jul 29, 2025 at 03:39:16PM +0800, Jason Wang wrote:
>Commit 7918bb2d19c9 ("vhost: basic in order support") introduces
>vq->nheads to store the number of batched used buffers per used elem
>but it forgets to initialize the vq->nheads to NULL in
>vhost_dev_init() this will cause kfree() that would try to free it
>without be allocated if SET_OWNER is not called.
>
>Reported-by: JAEHOON KIM <jhkim@linux.ibm.com>
>Reported-by: Breno Leitao <leitao@debian.org>
>Fixes: 7918bb2d19c9 ("vhost: basic in order support")
>Signed-off-by: Jason Wang <jasowang@redhat.com>
>---
> drivers/vhost/vhost.c | 1 +
> 1 file changed, 1 insertion(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index a4873d116df1..b4dfe38c7008 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c
>@@ -615,6 +615,7 @@ void vhost_dev_init(struct vhost_dev *dev,
> 		vq->log = NULL;
> 		vq->indirect = NULL;
> 		vq->heads = NULL;
>+		vq->nheads = NULL;
> 		vq->dev = dev;
> 		mutex_init(&vq->mutex);
> 		vhost_vq_reset(dev, vq);
>-- 
>2.39.5
>


