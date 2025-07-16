Return-Path: <linux-kernel+bounces-733627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FD6B0771F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 996E84E52AF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 13:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964061D7E26;
	Wed, 16 Jul 2025 13:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gLCIKI6L"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544D574040
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 13:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752673104; cv=none; b=n/RtII4PoEYA2cK2rhoamzELanEbSjJAZEgj05cJ6u0jiOuXfdkBp8xFwTp6xSmCMgJBAUG29e7EaY8f8ETk+DAu2c8DE5EQQ0FtswK5OEsgqC0UfjyCmA3bvR2pCgXucUvlLoUbxAqeYS4Fg2K03PV+CW7E7s7knKMtD0QpYbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752673104; c=relaxed/simple;
	bh=+iHvtiP4dVRUwu8zgMFFhXFii73LKNAGPkqOJ4OL0iQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UbWTbVghT8J8vYCGad/jhE19Z5vbDrG5z04isDbEaKn71N5KfwRoRyThCR1yl3n7VifgAF+mZp5mrnQ8n/QAM0tOrrH9Qx+j/eHq+LywrTzw5eTPcOx4DSU9jkoV0/IGFc7qccfl1/BSntjmYQ0fb0w77aabTV/cnRwAcSXnAxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gLCIKI6L; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752673101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bbdAneayJf7wacuXl5G+NfMjm/fAiFdmts8eam55w7A=;
	b=gLCIKI6LRb/e/4KcXK2dBSwiWpYbISLVZIQYa6EgAAN051DiHi8FmOpx1KI8B3o/DAPUwB
	fuxLZy+XPi4YqPCIMPR13aOgcDV3yPzBmyAS4Sgb6E7zwWncaggiJ9xTTWNJVMuOQUUbmu
	aNNFyBNAQes2bNfNN1SweOJThxHv6FE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-rQsRkH1HNV-OOa-YY9Ch2g-1; Wed, 16 Jul 2025 09:38:20 -0400
X-MC-Unique: rQsRkH1HNV-OOa-YY9Ch2g-1
X-Mimecast-MFC-AGG-ID: rQsRkH1HNV-OOa-YY9Ch2g_1752673099
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a50049f8eeso2951222f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 06:38:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752673099; x=1753277899;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bbdAneayJf7wacuXl5G+NfMjm/fAiFdmts8eam55w7A=;
        b=Gy23af4Wk1JUhZIGGbOPvMbJCjoC/tmqGcYhjHFfnrBfCgaPGWGepMcNWt7xRPLygU
         dkMb7G64poA9CPm53xxclBa+YoqCDmpQYIDWj6jRKS+lGsaOujXFa+K6H+gZxkhKYcOE
         tQPmLrlPMBK0O8HlwV4GKPcDb31xc5qOjmV8nTgZ4nuUf15lJSrmoavjMiEubzCm8Kwn
         VKYO3wdjmkQ+7xb4Q20GNZ5Z87ra9WHHLsKecbhFekjwSowCtE5wqa19pHj4DplhhFhM
         bS99rohN1jWopli0O6yYab2f3dqddG9kFj7YoIZ45ymnrxIhR6KK090PubHvAyTTMVxY
         ePmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXq5Q53ZiYSTXoi4cwBA/iAkQidXmqFiSh84x9Swav0Y8H9Rq2t1B7GIL3WUY/YsC5J+t3QJ6B0EmN2+ss=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFtyJBSM8l/STovUD3Mur4QpHcB5xkyW/qWYkzin45dccql2Sg
	bOhuNr+VhqVpNqCBs3qxBabjjHQTezVrKDuVyhr+09lqEk7rIktAo3ZSdGKme37p8OThyLBRQ2O
	oUh46eaeNABqBIaoF99AcM3FG4iIpOFRoOL/GsZwuEQCB9XjQoMDSy0vpqNREprhHfQ==
X-Gm-Gg: ASbGncv+eRQmWKV5xzOJI2/bXTfjRBkCUN6w1yAfqH7oEIraxitNQHOdH1/Crm78xmr
	csqyxspSrNnrUw7PlCswFKKoU7aCvwT96ULoa6VV6vvpsB/BUCflYbXV5BoBAoBfhFlDgUy04lj
	U9FpwfqMwNFuSryez076MdmEz/ZrUxw3z1kIVO9fVApcIbBIFYO07YJhEqWsckX3PY0Td5exv/A
	FFqbqGowE8ZIrzzGL10HavDtZFFMiCODuxdLElwL0tJXHxObAH9Zo8HAvfGbUIQ+RaIjsuYi9/Q
	ml5w4Yt/kGQMpf9nV9w7DZZhkUSW9h86
X-Received: by 2002:a5d:5e88:0:b0:3a5:7944:c9b with SMTP id ffacd0b85a97d-3b60dd51291mr2892566f8f.16.1752673098837;
        Wed, 16 Jul 2025 06:38:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHONniWygBXciPr26x3pHj0nvSDyjvuSRdQI8CkI7uj3vzxwTl+/0L6TJlAmz7DGZ27LNtzhw==
X-Received: by 2002:a5d:5e88:0:b0:3a5:7944:c9b with SMTP id ffacd0b85a97d-3b60dd51291mr2892536f8f.16.1752673098367;
        Wed, 16 Jul 2025 06:38:18 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e80246asm21517885e9.10.2025.07.16.06.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 06:38:17 -0700 (PDT)
Date: Wed, 16 Jul 2025 09:38:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: jasowang@redhat.com, eperezma@redhat.com, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH] vhost: Fix typos in comments and clarity on alignof usage
Message-ID: <20250716093552-mutt-send-email-mst@kernel.org>
References: <20250615173933.1610324-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250615173933.1610324-1-alok.a.tiwari@oracle.com>

On Sun, Jun 15, 2025 at 10:39:11AM -0700, Alok Tiwari wrote:
> This patch fixes multiple typos and improves comment clarity across
> vhost.c.
> - Correct spelling errors: "thead" -> "thread", "RUNNUNG" -> "RUNNING"
>   and "available".
> - Improve comment by replacing informal comment ("Supersize me!")
>   with a clear description.
> - Use __alignof__ correctly on dereferenced pointer types for better
>   readability and alignment with kernel documentation.
> 
> These changes enhance code readability and maintainability.
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Thanks, I applied parts of it.

> ---
>  drivers/vhost/vhost.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 3a5ebb973dba..0227c123c0e0 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -594,10 +594,10 @@ static void vhost_attach_mm(struct vhost_dev *dev)
>  	if (dev->use_worker) {
>  		dev->mm = get_task_mm(current);
>  	} else {
> -		/* vDPA device does not use worker thead, so there's
> -		 * no need to hold the address space for mm. This help
> +		/* vDPA device does not use worker thread, so there's
> +		 * no need to hold the address space for mm. This helps
>  		 * to avoid deadlock in the case of mmap() which may
> -		 * held the refcnt of the file and depends on release
> +		 * hold the refcnt of the file and depends on release
>  		 * method to remove vma.
>  		 */
>  		dev->mm = current->mm;
> @@ -731,7 +731,7 @@ static void __vhost_vq_attach_worker(struct vhost_virtqueue *vq,
>  	 * We don't want to call synchronize_rcu for every vq during setup
>  	 * because it will slow down VM startup. If we haven't done
>  	 * VHOST_SET_VRING_KICK and not done the driver specific
> -	 * SET_ENDPOINT/RUNNUNG then we can skip the sync since there will
> +	 * SET_ENDPOINT/RUNNING then we can skip the sync since there will
>  	 * not be any works queued for scsi and net.
>  	 */
>  	mutex_lock(&vq->mutex);
> @@ -1898,8 +1898,8 @@ static long vhost_vring_set_addr(struct vhost_dev *d,
>  		return -EFAULT;
>  
>  	/* Make sure it's safe to cast pointers to vring types. */
> -	BUILD_BUG_ON(__alignof__ *vq->avail > VRING_AVAIL_ALIGN_SIZE);
> -	BUILD_BUG_ON(__alignof__ *vq->used > VRING_USED_ALIGN_SIZE);
> +	BUILD_BUG_ON(__alignof__(*vq->avail) > VRING_AVAIL_ALIGN_SIZE);
> +	BUILD_BUG_ON(__alignof__(*vq->used) > VRING_USED_ALIGN_SIZE);
>  	if ((a.avail_user_addr & (VRING_AVAIL_ALIGN_SIZE - 1)) ||
>  	    (a.used_user_addr & (VRING_USED_ALIGN_SIZE - 1)) ||
>  	    (a.log_guest_addr & (VRING_USED_ALIGN_SIZE - 1)))
> @@ -2840,7 +2840,7 @@ void vhost_signal(struct vhost_dev *dev, struct vhost_virtqueue *vq)
>  }
>  EXPORT_SYMBOL_GPL(vhost_signal);
>  
> -/* And here's the combo meal deal.  Supersize me! */
> +/* Add to used ring and signal guest. */
>  void vhost_add_used_and_signal(struct vhost_dev *dev,
>  			       struct vhost_virtqueue *vq,
>  			       unsigned int head, int len)
> @@ -2860,7 +2860,7 @@ void vhost_add_used_and_signal_n(struct vhost_dev *dev,
>  }
>  EXPORT_SYMBOL_GPL(vhost_add_used_and_signal_n);
>  
> -/* return true if we're sure that avaiable ring is empty */
> +/* return true if we're sure that available ring is empty */
>  bool vhost_vq_avail_empty(struct vhost_dev *dev, struct vhost_virtqueue *vq)
>  {
>  	int r;
> -- 
> 2.47.1


