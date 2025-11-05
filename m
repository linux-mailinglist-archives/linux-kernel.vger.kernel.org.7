Return-Path: <linux-kernel+bounces-885748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF8CC33D36
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 04:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EC1E934C157
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 03:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F652638B2;
	Wed,  5 Nov 2025 03:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C9+RH0ib"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9A423BD1D
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 03:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762311681; cv=none; b=hbFixRQHx/1rc7enmrD2GjIQTBorHV34sDyxFvgd3CKVtgA2zfuky+bCNdaSaJBDDWZ37f/2gBHX/5G2vKi8j3F2gHhULj4dhJ0hXZid4QEMwzxgmGa6K/dy9H9/jdevD0MuC4OMvEwo5wGPSK28jZld2vFJyUsedcWRnD2DWtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762311681; c=relaxed/simple;
	bh=9XL6yTf5ZFoxCPA4q4bFFZ/abnHD6x9k7H1OsaBRFxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qv9BY09BLQg+phZNKIZmh2rIBER3e1RH6LFg3Kt+KCnPMHiOfErYDR9Z9W4GdhBIvifiW3bheCUwI64MUhqh2+iCQmN1aJHQy8BJnbioOrRCmCdixPGhQGymkv/2Hi6U0M2K5cahwW9GM0xdJKyK/BhTKRFdjBovlpLPZda4LIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C9+RH0ib; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762311676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sd8XQMJuB4OI1OioyM6KgZgMEGhu9mj32m9cQ9oNvF8=;
	b=C9+RH0ibah0WEgTwF4R+C6cANgQnY5h62QGSDk2pScdLTJNX3wfnY15mJM16doPnMrOsUZ
	UCuCa9jMNtjeFYlXspvzNaKi5Rt0JHdVwEieoWAnO00ZXdZ9B38ju04jSR9c5oomlOJ1AE
	tDeFAar1BHYV/OM0x2ePb6zxORm9DSU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-2hJoqEcBNlOtp5S1kBwjDg-1; Tue,
 04 Nov 2025 22:01:15 -0500
X-MC-Unique: 2hJoqEcBNlOtp5S1kBwjDg-1
X-Mimecast-MFC-AGG-ID: 2hJoqEcBNlOtp5S1kBwjDg_1762311671
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 89C8119560B3;
	Wed,  5 Nov 2025 03:01:10 +0000 (UTC)
Received: from localhost (unknown [10.72.112.190])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 53AD618004D4;
	Wed,  5 Nov 2025 03:01:07 +0000 (UTC)
Date: Wed, 5 Nov 2025 11:01:02 +0800
From: Baoquan He <bhe@redhat.com>
To: Qiang Ma <maqianga@uniontech.com>
Cc: akpm@linux-foundation.org, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 3/4] kexec: print out debugging message if required
 for kexec_load
Message-ID: <aQq97iGeYvZdr3SX@MiWiFi-R3L-srv>
References: <20251103063440.1681657-1-maqianga@uniontech.com>
 <20251103063440.1681657-4-maqianga@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103063440.1681657-4-maqianga@uniontech.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 11/03/25 at 02:34pm, Qiang Ma wrote:
> The commit a85ee18c7900 ("kexec_file: print out debugging message
> if required") has added general code printing in kexec_file_load(),
> but not in kexec_load().
> 
> Especially in the RISC-V architecture, kexec_image_info() has been
> removed(commit eb7622d908a0 ("kexec_file, riscv: print out debugging
> message if required")). As a result, when using '-d' for the kexec_load
> interface, print nothing in the kernel space. This might be helpful for
> verifying the accuracy of the data passed to the kernel. Therefore,
> refer to this commit a85ee18c7900 ("kexec_file: print out debugging
> message if required"), debug print information has been added.
> 
> Signed-off-by: Qiang Ma <maqianga@uniontech.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202510310332.6XrLe70K-lkp@intel.com/
> ---
>  kernel/kexec.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index c7a869d32f87..9b433b972cc1 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -154,7 +154,15 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
>  	if (ret)
>  		goto out;
>  
> +	kexec_dprintk("nr_segments = %lu\n", nr_segments);
>  	for (i = 0; i < nr_segments; i++) {
> +		struct kexec_segment *ksegment;
> +
> +		ksegment = &image->segment[i];
> +		kexec_dprintk("segment[%lu]: buf=0x%p bufsz=0x%zx mem=0x%lx memsz=0x%zx\n",
> +			      i, ksegment->buf, ksegment->bufsz, ksegment->mem,
> +			      ksegment->memsz);

There has already been a print_segments() in kexec-tools/kexec/kexec.c,
you will get duplicated printing. That sounds not good. Have you tested
this?

> +
>  		ret = kimage_load_segment(image, i);
>  		if (ret)
>  			goto out;
> @@ -166,6 +174,9 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
>  	if (ret)
>  		goto out;
>  
> +	kexec_dprintk("kexec_load: type:%u, start:0x%lx head:0x%lx flags:0x%lx\n",
> +		      image->type, image->start, image->head, flags);
> +
>  	/* Install the new kernel and uninstall the old */
>  	image = xchg(dest_image, image);
>  
> -- 
> 2.20.1
> 


