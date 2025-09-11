Return-Path: <linux-kernel+bounces-811752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB5CB52D74
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6995758457A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 09:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112612EA74B;
	Thu, 11 Sep 2025 09:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="auR0wkXT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47B022126D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 09:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757583714; cv=none; b=ftZ4vEWvfKzTwY7xkws+3liVMJi95SkQSbwd7kpdHhwzpL2FcrjPeH4fj9V/enzRcNtLvBK3Xz1usT9wwAaUFp1shB3fIZBp9UBWSTRJF9yWggHUY8zJvUnmyk+3QB0j+myjYbZYw9mbUfSPsuj82ryGqrpzvWNj65/9dey2T+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757583714; c=relaxed/simple;
	bh=tQxV2WY+J/WNmibFIFKSN4Ql06nD8wj19NMC0ffo9rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EwnrKArlPQZE7O6yvHhXHYLrGR2U2gKPSwhokzBHOsPX117eCuRhglpFxhWEL7jqHBbjVB6RISCEmWqSdxdg5D1YYcJ8H+QoPFKa+xOl2NsW8hqp7BFvcajaxE0nTzshtKdv5/gv1mkLncbDsK5s4cmHtfQhXuA5aTokGEkKyHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=auR0wkXT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757583710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ESVr/PCO5mj3Euf7na2oraMPrefSP5rEhizD9JtmFJg=;
	b=auR0wkXT/RpshyyfTBec36ht3is5LRaUFFI/391zaf4kWe/3OkJrUWc/ATu2Fsyp5Uplzf
	hyfn1sN40oEP4OCnaxkvLHSqKiXFU1dJKrWkuSImEbuKKB0t5fa1+7exxD38jbAMapZhmw
	c9cF6nT5trIzXAG/uf0jsDl339XMVS4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-573-Iz-BNOapM1ycJmmJ9f-N4g-1; Thu,
 11 Sep 2025 05:41:46 -0400
X-MC-Unique: Iz-BNOapM1ycJmmJ9f-N4g-1
X-Mimecast-MFC-AGG-ID: Iz-BNOapM1ycJmmJ9f-N4g_1757583705
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DC3AC1800378;
	Thu, 11 Sep 2025 09:41:44 +0000 (UTC)
Received: from localhost (unknown [10.72.112.78])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 378AE19560BB;
	Thu, 11 Sep 2025 09:41:42 +0000 (UTC)
Date: Thu, 11 Sep 2025 17:41:37 +0800
From: Baoquan He <bhe@redhat.com>
To: Justinien Bouron <jbouron@amazon.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Petr Mladek <pmladek@suse.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	Alexander Graf <graf@amazon.com>,
	Steven Chen <chenste@linux.microsoft.com>,
	Yan Zhao <yan.y.zhao@intel.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Gunnar Kudrjavets <gunnarku@amazon.com>
Subject: Re: [PATCH] kexec_core: Remove superfluous page offset handling in
 segment loading
Message-ID: <aMKZUY/zg31qN+68@MiWiFi-R3L-srv>
References: <20250910163116.49148-1-jbouron@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910163116.49148-1-jbouron@amazon.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 09/10/25 at 09:31am, Justinien Bouron wrote:
> Kexec does not accept segments for which the destination address is not
> page aligned. Therefore there is no need for page offset handling when
> loading segments.

Do you mean we will adjust the memsz and buf_align to PAGE_SIZE aligned
in kexec_add_buffer()? That better be explained in log.

int kexec_add_buffer(struct kexec_buf *kbuf)
{
	......
	/* Ensure minimum alignment needed for segments. */
        kbuf->memsz = ALIGN(kbuf->memsz, PAGE_SIZE);
        kbuf->buf_align = max(kbuf->buf_align, PAGE_SIZE);
        kbuf->cma = NULL;
	......
}

> 
> Signed-off-by: Justinien Bouron <jbouron@amazon.com>
> Reviewed-by: Gunnar Kudrjavets <gunnarku@amazon.com>
> ---
>  kernel/kexec_core.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index 31203f0bacaf..7d4c9eebea79 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -761,9 +761,7 @@ static int kimage_load_cma_segment(struct kimage *image, int idx)
>  	while (mbytes) {
>  		size_t uchunk, mchunk;
>  
> -		ptr += maddr & ~PAGE_MASK;
> -		mchunk = min_t(size_t, mbytes,
> -				PAGE_SIZE - (maddr & ~PAGE_MASK));
> +		mchunk = min_t(size_t, mbytes, PAGE_SIZE);

I am not so eager to remove it as keeping it makes a little sense on
defensive programming. Surely, I am not opposing it as it's truly not
necessary for now.

>  		uchunk = min(ubytes, mchunk);
>  
>  		if (uchunk) {
> @@ -815,6 +813,7 @@ static int kimage_load_normal_segment(struct kimage *image, int idx)
>  	mbytes = segment->memsz;
>  	maddr = segment->mem;
>  
> +
>  	if (image->segment_cma[idx])
>  		return kimage_load_cma_segment(image, idx);
>  
> @@ -840,9 +839,7 @@ static int kimage_load_normal_segment(struct kimage *image, int idx)
>  		ptr = kmap_local_page(page);
>  		/* Start with a clear page */
>  		clear_page(ptr);
> -		ptr += maddr & ~PAGE_MASK;
> -		mchunk = min_t(size_t, mbytes,
> -				PAGE_SIZE - (maddr & ~PAGE_MASK));
> +		mchunk = min_t(size_t, mbytes, PAGE_SIZE);
>  		uchunk = min(ubytes, mchunk);
>  
>  		if (uchunk) {
> @@ -905,9 +902,7 @@ static int kimage_load_crash_segment(struct kimage *image, int idx)
>  		}
>  		arch_kexec_post_alloc_pages(page_address(page), 1, 0);
>  		ptr = kmap_local_page(page);
> -		ptr += maddr & ~PAGE_MASK;
> -		mchunk = min_t(size_t, mbytes,
> -				PAGE_SIZE - (maddr & ~PAGE_MASK));
> +		mchunk = min_t(size_t, mbytes, PAGE_SIZE);
>  		uchunk = min(ubytes, mchunk);
>  		if (mchunk > uchunk) {
>  			/* Zero the trailing part of the page */
> -- 
> 2.43.0
> 
> 


