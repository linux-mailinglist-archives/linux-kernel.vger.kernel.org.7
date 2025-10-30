Return-Path: <linux-kernel+bounces-877925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F99CC1F5D4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC22F1893842
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0EF344040;
	Thu, 30 Oct 2025 09:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AQMGjkqz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D728934405F
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761817380; cv=none; b=pGeGBvDMtTMmty1OkGmJ/fy5IRqkxFT9wHxMV+6qymGKHevYNO/tZTyZW1JtPqrCtIyLOXgmwIh6ujon+ir+IYqpfwEtO23oHx7BqkmwB3ihgR4gHEIVTmR6f0VLUg9z9e89DaOM/Gu+J1pgYkdTwQ3oeG+s1ddY+mKeS26APno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761817380; c=relaxed/simple;
	bh=Np22CFW2rpYgK9dDD1Y8bEUqDC6k+OG0tNqc+noIq/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UYN0nUBccjTsjeIXxtvV5BnDdhnq4Kl432CMAIsQERNQcMLm1Aka2dZJtxIcpcyD1xFHL/foOCIilIllAfqTctSIJLme2DQLFsKkb4Ai622QGgo/VfBj+PS5Hu/XYlCqejvu6wdQCo8Tjb7hwgifkBdfzxobBDpeuFiWo+FP9u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AQMGjkqz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761817377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K34hQaDO0kSec4wlIUkIP+V+fbeM+87hWSGKBoo6EDY=;
	b=AQMGjkqzG1A13bhXTn1jfohF4d6lqvzsmfOtYRUbaL+KM5vhtNpASUyVbbYJK6iqEJwhuv
	H3dVxF0V6zku7jkfHVVw2WHdtEJogi6duJdCh0fwrZj4FCckQHe+12/iJu3EoIPG5VJUWf
	krkevUgU36rbkD9kglKDohGJiaL0Kl0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-125-I7Y9IzywMoCE9eQ0Z-7eOA-1; Thu,
 30 Oct 2025 05:42:54 -0400
X-MC-Unique: I7Y9IzywMoCE9eQ0Z-7eOA-1
X-Mimecast-MFC-AGG-ID: I7Y9IzywMoCE9eQ0Z-7eOA_1761817373
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5F84F180A22D;
	Thu, 30 Oct 2025 09:42:53 +0000 (UTC)
Received: from localhost (unknown [10.72.112.46])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F40A830001A1;
	Thu, 30 Oct 2025 09:42:50 +0000 (UTC)
Date: Thu, 30 Oct 2025 17:42:46 +0800
From: Baoquan He <bhe@redhat.com>
To: Qiang Ma <maqianga@uniontech.com>
Cc: akpm@linux-foundation.org, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kexec: print out debugging message if required for
 kexec_load
Message-ID: <aQMzFnqMC0MnLZFO@MiWiFi-R3L-srv>
References: <20251030073316.529106-1-maqianga@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030073316.529106-1-maqianga@uniontech.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 10/30/25 at 03:33pm, Qiang Ma wrote:
> The commit a85ee18c7900 ("kexec_file: print out debugging message
> if required") has added general code printing in kexec_file_load(),
> but not in kexec_load().
> 
> Especially in the RISC-V architecture, kexec_image_info() has been
> removed(commit eb7622d908a0 ("kexec_file, riscv: print out debugging
> message if required")). As a result, when using '-d' for the kexec_load
> interface, print nothing in the kernel space. This might be helpful for
> verifying the accuracy of the data passed to the kernel. Therefore, refer to
> this commit a85ee18c7900 ("kexec_file: print out debugging message
> if required"), debug print information has been added.

kexec_file_dbg_print setting when CONFIG_KEXEC_FILE is set. I doubt it
doesn't work when you unset CONFIG_KEXEC_FILE.

> 
> Signed-off-by: Qiang Ma <maqianga@uniontech.com>
> ---
>  kernel/kexec.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index 28008e3d462e..02845a7499e9 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -151,7 +151,15 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
>  	if (ret)
>  		goto out;
>  
> +	kexec_dprintk("nr_segments = %lu\n", image->nr_segments);
>  	for (i = 0; i < nr_segments; i++) {
> +		struct kexec_segment *ksegment;
> +
> +		ksegment = &image->segment[i];
> +		kexec_dprintk("segment[%d]: buf=0x%p bufsz=0x%zx mem=0x%lx memsz=0x%zx\n",
> +			      i, ksegment->buf, ksegment->bufsz, ksegment->mem,
> +			      ksegment->memsz);
> +
>  		ret = kimage_load_segment(image, i);
>  		if (ret)
>  			goto out;
> @@ -163,6 +171,9 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
>  	if (ret)
>  		goto out;
>  
> +	kexec_dprintk("kexec_file_load: type:%u, start:0x%lx head:0x%lx flags:0x%lx\n",
> +		      image->type, image->start, image->head, flags);
> +
>  	/* Install the new kernel and uninstall the old */
>  	image = xchg(dest_image, image);
>  
> -- 
> 2.20.1
> 
> 


