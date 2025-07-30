Return-Path: <linux-kernel+bounces-751327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD04B167BC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 22:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C6E87B3259
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 20:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B4C219301;
	Wed, 30 Jul 2025 20:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jbS1IXXc"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322BD17BD3
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 20:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753908393; cv=none; b=CsccBJvsSwVZBo4RebLMMVUTzEWXU1eE7Phdau19RAYE38k0RhkSXE8GauHQ7mmPUgxRmScekUPFFKCFXM+44zmomLJPSQ2XYAOKZwvJqBx/imWTQtDSPHw1MgEQGhLhut0zD/pfnSE8J056B6Iw5LQDL/kVYV+E/rImsOsz3hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753908393; c=relaxed/simple;
	bh=k+8rGz69+jVU5twpfSIM8yqLG/IwW8a2BxuPbsemEXQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kryU7OObQEQQOQ2Mq/C4pAzN9hgvb8QX1Bmr4DFqV2Wop08aBjHuZwNiSmXNII7KXfBjvhm2qPCO61cvDxV6CZqk3cqz05Rs7cTsWmuC0obNceLgTopvAuA7Q8Mvd02qGMJTCwg8oaQWnuCweW9wQqpBcJP9H3VQTzH+0Q+fg6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jbS1IXXc; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7e182e4171bso36207585a.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 13:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753908391; x=1754513191; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0L/xymE2tEopQ7k9G9R6HI2LTmXiFhMqTFzhifdihvs=;
        b=jbS1IXXcfcerfYDWUlziL6iVp8KKKj/kiEt6jO5p2J/LTezcxWTJ16YPa53PmJc8Ih
         8XYZ7CqtJ8WJ9g2KDrB0gLqi6A6l8ZMhQg0j2cPFLcbVM5+G0UWJ70tXCztxTUMOARDZ
         ctqq6ayZSunO/v/C8T4ICzTl1NRvFDHxZKaRRiTH5e84uQi9IZvBh2T4jBqZrgnfNbSk
         VNiqcI8fVt2SyDgRaKB6kpetBuKdq2SC4d9OqaWm2eXmmbWyJc7xfWfoCvERNp7IcUaX
         I6Oo+nsFv+1NOR1BXRAXkP+nnbdwqNZPqeBVOViXtRj9S1gwd4dwkcw6hzfbGSHD5hC/
         9+3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753908391; x=1754513191;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0L/xymE2tEopQ7k9G9R6HI2LTmXiFhMqTFzhifdihvs=;
        b=Fu0Pbc94Mekr6PBD0Q1pDeRNLWQ2oksKQx1xfagHMEbRvGwjBocytjdGyKPvmujI/B
         lyJfVe/BCkTNVuMyGvxjERqlVDd/CZrvKzL/oisWux4mgVQZ5gO57Zd1LPHy5cjnXprV
         DCQ0fTntS54h6tmv/MqajTOWA3OB5A1j7WUavUZAMLCOzNo4BGpHjN3ybPNspSiYDFM3
         0+GjeUe15LvWyEQZD4+6MnEii0RWYHgRSV7OtkWicDbGw1TejTE/AjzqF59UH2TmdEXk
         UTOwmRkl+nFQ8gOnQXn7B3DR/STtfmSrThg5tkNpE8GIlv0Kk45jhg3nfrVM1k/eVHlO
         AbEA==
X-Forwarded-Encrypted: i=1; AJvYcCUoGrrJ0tt7UChTmOIqZwfLOPMu08o7PpaAQginW3h/9x2puM0pjIzTFOFPfmDw57t1q/GirO9NQu4zWcA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4kqMShkqgTrmldAOxy3So9ssleiciUCSCjkHhrNw0l0ji3Nzw
	wH9KfGXRhwPPfkAmTFZgzVy8hfRML9MzhCWdIyLQgJS1rU8cGhxVin7e
X-Gm-Gg: ASbGnctYBbV7+o1lXNLO1tNggH8pip6OeknS7kQDJGkixtTuDHJdC7n7h6bYOstAi64
	VUQTF4KBI1InDk07IBp45n1g+CwqwIyTn3a0VR37XNx+LH1R2GFAGNwrp83mSeprx4rjeZsZLI1
	uKBuXYPWnp2/U14o+k7IYPMNxl5YziDZJ0Piw7djmwe0WIYkRdWe4c55orGDQc/Iqs7KC96D3jP
	/+XqBi28Q28NGGojMUVTax/98devz9pcls/PTRLPh/i+QZ26XOeXaRPs/zAOsMIeLoBgO8ajlng
	1o9Pvt7A1l8SXeBzZVDUgtGZQPLRUgbyMEHSPRUfWtS7Aj4N/B83L3CwKDwmEBnOxGOOuYJIvUK
	yTIrC6eVQoVaUUDn1Ew==
X-Google-Smtp-Source: AGHT+IEPikqxuVzW/jU19uKRHrbMOymk5tIBwqW9qZeJFvmEfpccEvxSUHL4Rc3z/9ki+BjmwEPRcg==
X-Received: by 2002:a05:620a:d8e:b0:7e0:8503:f948 with SMTP id af79cd13be357-7e66f358c22mr713767085a.36.1753908390942;
        Wed, 30 Jul 2025 13:46:30 -0700 (PDT)
Received: from localhost ([142.186.9.88])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7e67f727eaasm1348285a.62.2025.07.30.13.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 13:46:30 -0700 (PDT)
From: Seyediman Seyedarab <imandevel@gmail.com>
X-Google-Original-From: Seyediman Seyedarab <ImanDevel@gmail.com>
Date: Wed, 30 Jul 2025 16:51:06 -0400
To: dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org, 
	will@kernel.org, robin.murphy@arm.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v2] iommu/vt-d: replace snprintf with scnprintf in
 dmar_latency_snapshot()
Message-ID: <i6is7g7gnyaczojw2wv7cw5sg7cqdafnzocfhu25tpbvccdbid@2k3q2r2qr47a>
References: <20250730204037.28159-1-ImanDevel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730204037.28159-1-ImanDevel@gmail.com>

On 25/07/30 04:40PM, Seyediman Seyedarab wrote:
> snprintf() returns the number of bytes that would have been
> written, not the number actually written. Using this for offset
> tracking can cause buffer overruns if truncation occurs.
> 
> Replace snprintf() with scnprintf() to ensure the offset stays
> within bounds.
> 
> Since scnprintf() never returns a negative value, and zero is not
> possible in this context because 'bytes' starts at 0 and 'size - bytes'
> is DEBUG_BUFFER_SIZE in the first call, which is large enough to hold
> the string literals used, the return value is always positive. An integer
> overflow is also completely out of reach here due to the small and fixed
> buffer size. The error check in latency_show_one() is therefore unnecessary.
> Remove it and make dmar_latency_snapshot() return void.
> 
> Signed-off-by: Seyediman Seyedarab <ImanDevel@gmail.com>
> ---
> Changes in v2:
> - The return type of dmar_latency_snapshot() was changed based on the
>   discussion here:
>   https://lore.kernel.org/linux-iommu/aIDN3pvUSG3rN4SW@willie-the-truck/
> 
> 
>  drivers/iommu/intel/debugfs.c | 8 ++------
>  drivers/iommu/intel/perf.c    | 8 ++++----
>  drivers/iommu/intel/perf.h    | 7 +++----
>  3 files changed, 9 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/debugfs.c
> index affbf4a1558d..c4aca0eb5e29 100644
> --- a/drivers/iommu/intel/debugfs.c
> +++ b/drivers/iommu/intel/debugfs.c
> @@ -653,12 +653,8 @@ static void latency_show_one(struct seq_file *m, struct intel_iommu *iommu,
>  	seq_printf(m, "IOMMU: %s Register Base Address: %llx\n",
>  		   iommu->name, drhd->reg_base_addr);
>  
> -	ret = dmar_latency_snapshot(iommu, debug_buf, DEBUG_BUFFER_SIZE);
> -	if (ret < 0)
> -		seq_puts(m, "Failed to get latency snapshot");
> -	else
> -		seq_puts(m, debug_buf);
> -	seq_puts(m, "\n");
> +	dmar_latency_snapshot(iommu, debug_buf, DEBUG_BUFFER_SIZE);
> +	seq_printf(m, "%s\n", debug_buf);
>  }
>  
>  static int latency_show(struct seq_file *m, void *v)
> diff --git a/drivers/iommu/intel/perf.c b/drivers/iommu/intel/perf.c
> index adc4de6bbd88..7e726e1ba40b 100644
> --- a/drivers/iommu/intel/perf.c
> +++ b/drivers/iommu/intel/perf.c
> @@ -113,7 +113,7 @@ static char *latency_type_names[] = {
>  	"     svm_prq"
>  };
>  
> -int dmar_latency_snapshot(struct intel_iommu *iommu, char *str, size_t size)
> +void dmar_latency_snapshot(struct intel_iommu *iommu, char *str, size_t size)
>  {
>  	struct latency_statistic *lstat = iommu->perf_statistic;
>  	unsigned long flags;
> @@ -122,7 +122,7 @@ int dmar_latency_snapshot(struct intel_iommu *iommu, char *str, size_t size)
>  	memset(str, 0, size);
>  
>  	for (i = 0; i < COUNTS_NUM; i++)
> -		bytes += snprintf(str + bytes, size - bytes,
> +		bytes += scnprintf(str + bytes, size - bytes,
>  				  "%s", latency_counter_names[i]);
>  
>  	spin_lock_irqsave(&latency_lock, flags);
> @@ -130,7 +130,7 @@ int dmar_latency_snapshot(struct intel_iommu *iommu, char *str, size_t size)
>  		if (!dmar_latency_enabled(iommu, i))
>  			continue;
>  
> -		bytes += snprintf(str + bytes, size - bytes,
> +		bytes += scnprintf(str + bytes, size - bytes,
>  				  "\n%s", latency_type_names[i]);
>  
>  		for (j = 0; j < COUNTS_NUM; j++) {
> @@ -156,7 +156,7 @@ int dmar_latency_snapshot(struct intel_iommu *iommu, char *str, size_t size)
>  				break;
>  			}
>  
> -			bytes += snprintf(str + bytes, size - bytes,
> +			bytes += scnprintf(str + bytes, size - bytes,
>  					  "%12lld", val);
>  		}
>  	}
> diff --git a/drivers/iommu/intel/perf.h b/drivers/iommu/intel/perf.h
> index df9a36942d64..dcf2741c2d53 100644
> --- a/drivers/iommu/intel/perf.h
> +++ b/drivers/iommu/intel/perf.h
> @@ -35,12 +35,12 @@ struct latency_statistic {
>  };
>  
>  #ifdef CONFIG_DMAR_PERF
> -int dmar_latency_enable(struct intel_iommu *iommu, enum latency_type type);
> +void dmar_latency_enable(struct intel_iommu *iommu, enum latency_type type);
>  void dmar_latency_disable(struct intel_iommu *iommu, enum latency_type type);
>  bool dmar_latency_enabled(struct intel_iommu *iommu, enum latency_type type);
>  void dmar_latency_update(struct intel_iommu *iommu, enum latency_type type,
>  			 u64 latency);
> -int dmar_latency_snapshot(struct intel_iommu *iommu, char *str, size_t size);
> +void dmar_latency_snapshot(struct intel_iommu *iommu, char *str, size_t size);
>  #else
>  static inline int
>  dmar_latency_enable(struct intel_iommu *iommu, enum latency_type type)
> @@ -64,9 +64,8 @@ dmar_latency_update(struct intel_iommu *iommu, enum latency_type type, u64 laten
>  {
>  }
>  
> -static inline int
> +static inline void
>  dmar_latency_snapshot(struct intel_iommu *iommu, char *str, size_t size)
>  {
> -	return 0;
>  }
>  #endif /* CONFIG_DMAR_PERF */
> -- 
> 2.50.1
> 

My apologies, please don't apply this. I'll send a v3. I forgot to amend
the current patch... it changes the prototype of dmar_latency_enable():
> -int dmar_latency_enable(struct intel_iommu *iommu, enum latency_type type);
> +void dmar_latency_enable(struct intel_iommu *iommu, enum latency_type type);

Seyediman

