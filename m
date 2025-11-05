Return-Path: <linux-kernel+bounces-885750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3048EC33D3F
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 04:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CF74C4EA2D0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 03:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA86725A2B4;
	Wed,  5 Nov 2025 03:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a178WsMB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09E02222CB
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 03:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762311968; cv=none; b=i7KwepzvmTc3KqJcAntRAu4kbsckWcoF2m1mYXTmbleZl/qLaEiLHHkLusimfi+geFcg18T5/7EaAXA60sZCwc72bTXYZCAHIJAMtE9pwDhwZnyEFsJ+za7o1rTSvfBM2ummrcwETN9MqYc9abgKd4MVB/ZZpA3f3HUhYvI5ePo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762311968; c=relaxed/simple;
	bh=4mXR76ILA9VURLkx6zip1KXgauTY3FxwFC4wf9S6klQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N6s7wIX0xZ4bOER1Kzplio9/7lYobRT2cDK31eTcAgNfTNzKBnnN8+pvWen/636cSCj2ZkBpg+pN5co091Mq/8HjuZjgeexpFn2MXsc9uFLy44N1cKVhsxuLu/HRH2TaJBAAKJ9QVLpQxMqUfIus1tYDCtanXFr92TYt7i50wFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a178WsMB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762311960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VhEMZ0Jtb0EKH5oYWlO6UeXbTt7H19J688oVkjT6urY=;
	b=a178WsMBu9c6s5oFijrLbqWRni8e+hh/F6jAxs8igDv6mTfO5BTSChb0ypUDGrdZf4/K98
	Eeh0usulcV82UA7/+Qf44Frvtsza1A/CtPahna7rHQ3DePj3F3BAvhUGAqoSOZr7BYpBvD
	lChmh90HyuPKzLKhCxlorUAF29eaGAQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-75-r8hCIRS2MHu6lJasDsMnvw-1; Tue,
 04 Nov 2025 22:05:57 -0500
X-MC-Unique: r8hCIRS2MHu6lJasDsMnvw-1
X-Mimecast-MFC-AGG-ID: r8hCIRS2MHu6lJasDsMnvw_1762311956
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 65A34180060D;
	Wed,  5 Nov 2025 03:05:55 +0000 (UTC)
Received: from localhost (unknown [10.72.112.190])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C5550180035A;
	Wed,  5 Nov 2025 03:05:53 +0000 (UTC)
Date: Wed, 5 Nov 2025 11:05:44 +0800
From: Baoquan He <bhe@redhat.com>
To: Qiang Ma <maqianga@uniontech.com>
Cc: akpm@linux-foundation.org, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] kexec_file: Fix the issue of mismatch between
 loop variable types
Message-ID: <aQq/CHi10ihT8/sn@MiWiFi-R3L-srv>
References: <20251103063440.1681657-1-maqianga@uniontech.com>
 <20251103063440.1681657-5-maqianga@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103063440.1681657-5-maqianga@uniontech.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 11/03/25 at 02:34pm, Qiang Ma wrote:
> The type of the struct kimage member variable nr_segments is unsigned long.
> Correct the loop variable i and the print format specifier type.

I can't see what's meaningful with this change. nr_segments is unsigned
long, but it's the range 'i' will loop. If so, we need change all for
loop of the int iterator.

> 
> Signed-off-by: Qiang Ma <maqianga@uniontech.com>
> ---
>  kernel/kexec_file.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 4a24aadbad02..7afdaa0efc50 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -366,7 +366,8 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
>  	int image_type = (flags & KEXEC_FILE_ON_CRASH) ?
>  			 KEXEC_TYPE_CRASH : KEXEC_TYPE_DEFAULT;
>  	struct kimage **dest_image, *image;
> -	int ret = 0, i;
> +	int ret = 0;
> +	unsigned long i;
>  
>  	/* We only trust the superuser with rebooting the system. */
>  	if (!kexec_load_permitted(image_type))
> @@ -432,7 +433,7 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
>  		struct kexec_segment *ksegment;
>  
>  		ksegment = &image->segment[i];
> -		kexec_dprintk("segment[%d]: buf=0x%p bufsz=0x%zx mem=0x%lx memsz=0x%zx\n",
> +		kexec_dprintk("segment[%lu]: buf=0x%p bufsz=0x%zx mem=0x%lx memsz=0x%zx\n",
>  			      i, ksegment->buf, ksegment->bufsz, ksegment->mem,
>  			      ksegment->memsz);
>  
> -- 
> 2.20.1
> 


