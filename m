Return-Path: <linux-kernel+bounces-852178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2E0BD85DC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37DF93BF660
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6394D2E764E;
	Tue, 14 Oct 2025 09:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LLZLrrHP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA722E5B13
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760433227; cv=none; b=XddA7J7O5/LscPjl2PbIL4TTdExnfQCWZhZ17GYOr0eqZL5dDBy9MvUsekihvDpJHl4rHp4H+wYYGcb8+Xq8MwGm86r/lyEXiI7Xq+BHKGRJsmBADKYRzGBtweJ9vdDefQLL8STYlbuL66Ta5A9yJMb9CKYagA3v4y3aYAJg1j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760433227; c=relaxed/simple;
	bh=2v0Bp0WbvCD9vKAk3vczjx5MXMK8Ev3edpRr+RV7MTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I1jV47j/jpWcYdykp5ylJMoxGaZL3mr4chLpT9PettZnlR/arrCJQrqAtBjevLtwe2pwt4NvUHWf7PcG0Fka6YhYCQbbyClZfp7/RIb6mwUsRZEh10dhCzcCjE7sYJJHnmloRd1+KLDnv6CEbcZpJyHCEecE16DqFJ7Xp+rBQBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LLZLrrHP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760433224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G2XgyDPMJ1MFnAPP7MytLHmnMXp+I2XmGE5K1J0UB80=;
	b=LLZLrrHPyVTyeRiYSH18rep8CmYq7aJBjAavZLLULqbLX57jF17QWdHMT4Loxc/IAgyJKE
	U3yTJECoN4VoA5mCOCwO8MOVIts+rqdGxu6U5uMANNfCxIM2lvlOOQZxj4JQr6qDy8x+Yj
	/f8uSzNNdnGf29sypTThtk+msj/ySKI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-1xB6UUICP_2NAF4NQFQ_-Q-1; Tue, 14 Oct 2025 05:13:43 -0400
X-MC-Unique: 1xB6UUICP_2NAF4NQFQ_-Q-1
X-Mimecast-MFC-AGG-ID: 1xB6UUICP_2NAF4NQFQ_-Q_1760433222
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46e36686ca1so46832865e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 02:13:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760433222; x=1761038022;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G2XgyDPMJ1MFnAPP7MytLHmnMXp+I2XmGE5K1J0UB80=;
        b=O7aiBLwjiUuMZ5UPYTLLO1TqLFcZQ6qX2S0NlKnsj20crhQmGNOWveTFPXn37ctZcv
         FypAsX4KWYLHTFUqYfe+PO+kPDdFajvOjvTcI1UCxAwR9TVzUB1rHb9IzWwpcUNw+8vX
         rFnnaM5zyHTVvXwrGmWKtVRvrqqR28LSnP6wT6R9CKQm26ZAYeFKpoIiKogboXNFacTH
         6fHdsTNosw5Ho1/3zaaoItWnXT80taPfVgla1/b2RpHcVjISr7jdX5Jj9smUgno1lCRS
         4B9SHOVuTLj0zxFR9dLI2zbEDWI5VowI6OmC5YUxJoBEN0ml+wFCeKFdX69A0fwBt/gk
         iYdg==
X-Forwarded-Encrypted: i=1; AJvYcCW39LF94TYkDEP1W4aFEM+2bdXMKdLzOW5hvHut/pnfKL/BE/5NsRDQzTE2+yPh+2fuVMIvypHyAUxAs0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7A89ga9qpKSGPQPyUWo/u5G+SaeHA4aJ3gF8KNoWrVYeZyK6L
	/csrRPrKkMOO2jV+IisuVWzicmiXws/l5g8wFMI+xuBREhoP9Q+wkSaLuz3sUJ9gsSXsXVO2qjk
	QOScuQL0QbqDdpVg+2SvlHOERhmlqyXCp9crjF/w8r23YCoqV7x8hX0K6R1WWAVH5dZNrQWv6tb
	7G
X-Gm-Gg: ASbGncufbawbI7Npx3nbzZfcyZHna41YNCCQC63Y5DqAlLion9tS1llPG7KjLUZRMfH
	tUZFf+n/66bFEVgAa5jjody0QJAIXX7X2QMWGMRMVNO+p7OlTZIhIB2CqaCUZgjwslk7rEQ6AT4
	b9FluwuFS7MtlybOprN2MHEq6GAiGKM4R+G98ZrvfhWC8WA0XExXR/IS/Bq5Rk8CoRV6BUVGG9c
	Pd0vnRAptPVGycWnnscUk0nCZx6fjv3amgiYt0iUnva+EE1jw+Cpm2Pxxt6MJLMvRma+PndvScK
	8RR3VCxWalWjZVlUNQkZV0iq4Qm5GuldUw==
X-Received: by 2002:a05:600c:198f:b0:46e:3b1a:20d7 with SMTP id 5b1f17b1804b1-46fa9af8595mr195064705e9.19.1760433221839;
        Tue, 14 Oct 2025 02:13:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHr/6lo3aUFMkwfFsJSFWwzr/cwg1mRhEAlsy8hUJhHzcQrMQ9yYQk5I4elgRIAJAufqX/zbQ==
X-Received: by 2002:a05:600c:198f:b0:46e:3b1a:20d7 with SMTP id 5b1f17b1804b1-46fa9af8595mr195064485e9.19.1760433221322;
        Tue, 14 Oct 2025 02:13:41 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce583316sm22569145f8f.20.2025.10.14.02.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 02:13:40 -0700 (PDT)
Date: Tue, 14 Oct 2025 05:13:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V7 19/19] virtio_ring: add in order support
Message-ID: <20251014050901-mutt-send-email-mst@kernel.org>
References: <20250925103708.44589-1-jasowang@redhat.com>
 <20250925103708.44589-20-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925103708.44589-20-jasowang@redhat.com>

On Thu, Sep 25, 2025 at 06:37:08PM +0800, Jason Wang wrote:
> @@ -683,7 +707,12 @@ static inline int virtqueue_add_split(struct vring_virtqueue *vq,
>  	vq->vq.num_free -= descs_used;
>  
>  	/* Update free pointer */
> -	if (indirect)
> +	if (virtqueue_is_in_order(vq)) {
> +		vq->free_head += descs_used;
> +		if (vq->free_head >= vq->split.vring.num)
> +			vq->free_head -= vq->split.vring.num;
> +		vq->split.desc_state[head].total_len = total_len;;
> +	} else if (indirect)
>  		vq->free_head = vq->split.desc_extra[head].next;
>  	else
>  		vq->free_head = i;

So in order is clearly doing something funky with the free_head.
It's no longer a head of a linked list of free descriptors, is it?
what is it doing and why?  Please add code comments to explain
both where free_list is defined and where it's used.
For example, virtqueue_vring_attach_packed only inits free_list
if not in order. So who will init it for in order? And so on.

-- 
MST


