Return-Path: <linux-kernel+bounces-857917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E67D9BE83C0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 13:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 699B44FECE1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 11:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77572330D30;
	Fri, 17 Oct 2025 11:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UmKcgO96"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86A0330D22
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 11:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760699071; cv=none; b=Ja/GGSFUCkJ8hHSIW3irDOofGvJ+ryYwFRjySjIeq3tNyzZm/jWkC7P1hI6cD158neSJE2cFbCsIICzy8MEp9BhY0zewotvFdrarUrcLOqJ9xnS4V4rimSygHVUquM0STjXbt0vHBc4itejXDpn0yhqMyYYGPS0VRAn2tJV4REk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760699071; c=relaxed/simple;
	bh=CT6Prt+NTbShjQ+f1cmrLR9yqKjs5BUvYa3rp5OHzHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AFBt1r9RRxZURGWvDW2ReZ4M6dO2Vqy12jjJejo3Dbd0WA6aYpDnK6qVyvSp+qprX03CJLcMo9JBeSqCEsrf4LXt+ExeA27QVdJZOFoLLeEvj9ws5Ugi8XMwvG0muhMVVbpDaoFTh7Q2X1BrmdEY0KoTPELr3ZOK11vMr6fuWto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UmKcgO96; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47101c27c9cso55485e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 04:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760699068; x=1761303868; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U0RmTEF1AegUAZ9BdlOfpY9MgQhp1m+IVPxka61nbq4=;
        b=UmKcgO96NOBeHsL+0l/bQDKq32WJ3AT2pzYVu93x1lQjRw5KNnoeDzdlAwULjVTa4B
         al3fxCzKnet+owGfQkH5+84MCoLusXSy56Xe/Hq0Vmw7H7XNiqHlKFX4Y9kBtinEKLYZ
         3Ghq/pxoZCQ/3XhxcwTW6KQo7++smKA9g7FGylSTd1+eVNtOdxQRI1Ok4KWOIa0gjeX4
         l0AUIANLaPI3ubEiv8jCa0p2fpeBEIefqXwMBZPPMW3B6lCOAGYNgdf0DbmsC9bjypL+
         8GrOCwhhntI39miMSNL9KTvURw/nn5sqxtm5u5CMA//0VzvYdV1bd0sIBWnIjGHY3sR+
         edGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760699068; x=1761303868;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U0RmTEF1AegUAZ9BdlOfpY9MgQhp1m+IVPxka61nbq4=;
        b=MXzLagb3kKkTt5PmrZwBD9bahUFVZ3z1RFGwFPCPcPhQREulqpcP00ReeJO1gTCmWc
         fKZMY5RvlJrnlGxIL1x8fWsM9XmBZ3/MrW7F0MwaadLOR/0Rp1Ki+OxarTnDd7RxX/SN
         O1I3UhTCPM8h1eVJsN/9mHzWgz2Cvr0CrjybQR6negO6hTOXFMHdf+o2znsxN3LH+8uY
         GTX6a4L76N87Nsb8d3/toQTUqy1NZbV6VvzXfgpH/g2MGFlsXK7DC7l+IVsmoEOcptde
         Z9ek2glr7+0yMRx4XpB7ajdSo7pqIz8fEzxcXUvXJzdhH1fXh4U9u4kQu+QiUjJqJFOi
         Qouw==
X-Gm-Message-State: AOJu0Yy+gsRXAms/aTiepdQBPYtrWqdb+RDJ9+53NkMoS5unlJsCwAz+
	0hepoDMlsBtmm55/u/VScLTYEfB1G9pCl2gnYn45CElxtOp6y55n3mDHmbb4HLsu5Q==
X-Gm-Gg: ASbGncsQz2aBAPp+yi28+vFYGLz7VBMmsbt7Eim9ztudL+NL/wE5yiVn5t9mycRKV4j
	cNUkHk0q1iTmr0w7wgeb+c80MYLHyDAkN+tS5KNH2D5jDe4lUrgYEK4HcOqaal4hPgxXFmOhUc+
	7iH7v9xCv/HOa6A8ZSO5F3GMWTZQeIm3B2TVe07SPQAFLdT/pAzjl9+PpkyL+T2e3z3u2f/E8Ni
	kiXezTH3KuIWn8FmLLEL2U6DxLycjY4P6FZaFpnKuQLPCo/yJp3LyJuoGS6ShxY+ufjEt+hrTER
	EYGPjbIsjUIrKe9UR+biSJa64Q6Da+gXiaY65b4Yv6wSlu+b77AIJFTY6on/Vt1O10Rhi+Sr5Je
	Q00H8VWds5E+75BbnfF5gyd2Rtl6dqs/AO6Oc/SLe7QJwWCIDJ/hr32TOpTjenuhRjfdpNm/8wM
	agLW8tB98m3LrcSpGXYfsxC4wEjseQ8SuGbgR2jEJXoHDFO5Ah
X-Google-Smtp-Source: AGHT+IE0OUIwlzr2sGs94SA/iu2w+G64ceoEFGzIwviFyFJA2e+cIf3qdIvn6JFYFL+5RiY4Zfv27w==
X-Received: by 2002:a05:600c:a30b:b0:45f:2949:7aa9 with SMTP id 5b1f17b1804b1-470fd88e8fbmr5639675e9.6.1760699067978;
        Fri, 17 Oct 2025 04:04:27 -0700 (PDT)
Received: from google.com (140.240.76.34.bc.googleusercontent.com. [34.76.240.140])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4711444d919sm77014225e9.14.2025.10.17.04.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 04:04:27 -0700 (PDT)
Date: Fri, 17 Oct 2025 11:04:24 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Zhang Yu <zhangyu1@linux.microsoft.com>,
	Jean Philippe-Brucker <jean-philippe@linaro.org>,
	Alexander Grest <Alexander.Grest@microsoft.com>
Subject: Re: [PATCH 2/2] iommu/arm-smmu-v3: Improve CMDQ lock fairness and
 efficiency
Message-ID: <aPIiuLj9c4IJlmIn@google.com>
References: <20250924175438.7450-1-jacob.pan@linux.microsoft.com>
 <20250924175438.7450-3-jacob.pan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924175438.7450-3-jacob.pan@linux.microsoft.com>

On Wed, Sep 24, 2025 at 10:54:38AM -0700, Jacob Pan wrote:
> From: Alexander Grest <Alexander.Grest@microsoft.com>
> 
> The SMMU CMDQ lock is highly contentious when there are multiple CPUs
> issuing commands on an architecture with small queue sizes e.g 256
> entries.
> 
> The lock has the following states:
>  - 0:		Unlocked
>  - >0:		Shared lock held with count
>  - INT_MIN+N:	Exclusive lock held, where N is the # of shared waiters
>  - INT_MIN:	Exclusive lock held, no shared waiters
> 
> When multiple CPUs are polling for space in the queue, they attempt to
> grab the exclusive lock to update the cons pointer from the hardware. If
> they fail to get the lock, they will spin until either the cons pointer
> is updated by another CPU.
> 
> The current code allows the possibility of shared lock starvation
> if there is a constant stream of CPUs trying to grab the exclusive lock.
> This leads to severe latency issues and soft lockups.
> 
> To mitigate this, we release the exclusive lock by only clearing the sign
> bit while retaining the shared lock waiter count as a way to avoid
> starving the shared lock waiters.
> 
> Also deleted cmpxchg loop while trying to acquire the shared lock as it
> is not needed. The waiters can see the positive lock count and proceed
> immediately after the exclusive lock is released.
> 
> Exclusive lock is not starved in that submitters will try exclusive lock
> first when new spaces become available.
> 
> In a staged test where 32 CPUs issue SVA invalidations simultaneously on
> a system with a 256 entry queue, the madvise (MADV_DONTNEED) latency
> dropped by 50% with this patch and without soft lockups.
> 
> Signed-off-by: Alexander Grest <Alexander.Grest@microsoft.com>
> Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 24 ++++++++++++---------
>  1 file changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 9b63525c13bb..9b7c01b731df 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -481,20 +481,19 @@ static void arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu)
>   */
>  static void arm_smmu_cmdq_shared_lock(struct arm_smmu_cmdq *cmdq)
>  {
> -	int val;
> -
>  	/*
> -	 * We can try to avoid the cmpxchg() loop by simply incrementing the
> -	 * lock counter. When held in exclusive state, the lock counter is set
> -	 * to INT_MIN so these increments won't hurt as the value will remain
> -	 * negative.
> +	 * We can simply increment the lock counter. When held in exclusive
> +	 * state, the lock counter is set to INT_MIN so these increments won't
> +	 * hurt as the value will remain negative. This will also signal the
> +	 * exclusive locker that there are shared waiters. Once the exclusive
> +	 * locker releases the lock, the sign bit will be cleared and our
> +	 * increment will make the lock counter positive, allowing us to
> +	 * proceed.
>  	 */
>  	if (atomic_fetch_inc_relaxed(&cmdq->lock) >= 0)
>  		return;
>  
> -	do {
> -		val = atomic_cond_read_relaxed(&cmdq->lock, VAL >= 0);
> -	} while (atomic_cmpxchg_relaxed(&cmdq->lock, val, val + 1) != val);
> +	atomic_cond_read_relaxed(&cmdq->lock, VAL >= 0);

I think that should be "VAL > 0", as it is guaranteed that we hold the shared
lock at this point.

Otherwise,
Reviewed-by: Mostafa Saleh <smostafa@google.com>

Thanks,
Mostafa

>  }
>  
>  static void arm_smmu_cmdq_shared_unlock(struct arm_smmu_cmdq *cmdq)
> @@ -521,9 +520,14 @@ static bool arm_smmu_cmdq_shared_tryunlock(struct arm_smmu_cmdq *cmdq)
>  	__ret;								\
>  })
>  
> +/*
> + * Only clear the sign bit when releasing the exclusive lock this will
> + * allow any shared_lock() waiters to proceed without the possibility
> + * of entering the exclusive lock in a tight loop.
> + */
>  #define arm_smmu_cmdq_exclusive_unlock_irqrestore(cmdq, flags)		\
>  ({									\
> -	atomic_set_release(&cmdq->lock, 0);				\
> +	atomic_fetch_and_release(~INT_MIN, &cmdq->lock);				\
>  	local_irq_restore(flags);					\
>  })
>  
> -- 
> 2.43.0
> 

