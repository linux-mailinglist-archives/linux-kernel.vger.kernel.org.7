Return-Path: <linux-kernel+bounces-753044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E73B17E13
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 10:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A47241AA00D5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 08:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0816A20E030;
	Fri,  1 Aug 2025 08:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ft53/Vwj"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096AA1D7E37
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 08:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754036075; cv=none; b=PxzJ0bgbtDyFxIMt6QGG00psmflFMxqy4gmy6LW6DTy8aE7jhlTP8sOrVxCO2N5jyj0ShlRfRkBN9R0G39V3BrmA01ezvakPLVBs2QK21komReP8gSYGESXGhxbe5FbthOtlfonCOI/HM/81k2q9Y+3TDkR2+E4pFdwe4ky8lBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754036075; c=relaxed/simple;
	bh=Hlg/KmabxBdC6Cwqj7rLCxayqHkkN63UORBc1c+3xAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bo2sa8DpppU3OB4EAyO9dhqxaPwq2s9u2xVQQhlPQxF8h9JKJYv+Hy8fd+YtI34kPNn7uKJJ9AX2wDawhrzv4Ub/nQltWPCbZrRNMZExrojaC/InycfaNaV0Tew8AJYWUSfPtCN0lzJ1V4O6UQbQuOR08FU3fJ0D0/0EAm6db6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ft53/Vwj; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-240708ba498so63725ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 01:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754036073; x=1754640873; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vY5IloWsNQwsLIRSq+Jk0RbLuNAFATBZvlKueff9YnQ=;
        b=ft53/VwjUE6ANk29jHKYjeFm8S6sqQ1PHuggHmLNkWy7xkLFGMZfa9tRSoyLmOSfzu
         P9W23XFvHrkvHw0HGc7kgQGEaLmIthwC7nSRJi5gLtdXXuTem/VpiNg4+Y7ot2+7rI4T
         1dfF/PkASeGgbCqu+rTws3J9GTSTcjZMack5KURvD87qAbvQOxmm1l3YbkffKrespVlI
         WZiwSDE69FXjOhBw7geAi/zF/7p783IdMZuHSk/XAvF0NgtXGr/nW7pjSCxRmvVzgrfJ
         lEnT55xYLvR4EFLBOryJArmFLalsonnr7kPyday1a4kBQ3FvUMEuyRqTZnTreBEx6UgW
         g7rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754036073; x=1754640873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vY5IloWsNQwsLIRSq+Jk0RbLuNAFATBZvlKueff9YnQ=;
        b=mDX7rL/D/V+tAnqZKOgDb/qb9vlyYgGvujzZwca89rRg82SIxqmmf3noAPHWgzm7+U
         Bi24mBraYXNBFc5gYrX5x0B66ov2wr4CwYtw740gLs0O+HRyoBF1frUIOMUv94ehAHk1
         3/7iOyxrx/oYurgIrzEcD4qJmCxWKQQ4Ql/LVkSl9clpCHKuDQYgl2f2pZkN9DoA2rr1
         1Yb2nNaN5oqqTjTtcNqq7s0O2hMPJ41CBICjXtXuSbHn8IiJmv3H5dyntRV5NbOjAZul
         13PMW1UNEx4Ve5Xr1DhDynxnGIMe1tWZnc8BvGSP6v/J6VC8yzeUJ5jZNm6tHUndttJf
         ktaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjeMswKoQb4jv1vL7tvcmXiQDJTau+Twz7+fbhga+QjBlZKGYrqYc5E4t+W0dAVSmtdnpGuhHuc+K13GQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ11B5T9hAurzgZrYwGJ6tCP3su6jP6MmgRr5tpOTL2yHWunLh
	ZPqp/q6oJFozx1Duc/Yg2dYudgMC3foi8C514mhHUO9XBVjcqa/kPFbyiiGFflsANAuHl3Mv/ni
	SwWuaPw==
X-Gm-Gg: ASbGncuH2KfQW6CSv1xa0wSBkLUSm1JvhsusklF5d/quYnYHFdVDXcdyLud2L420if0
	Ak+zkpOds4wakI/1JtHTonc7quAfrAhJ60SNgXwgBuAvfUpUMVgjMyKCi61tYEULsdsfr0fwnFR
	rU1p58/74o5lDKStMfgDbpd3+5vorkHiI65zNmgf2lBuZmWt0TGQhML56W5w8doM34DOt0dn15t
	de7EaWg6aaKGUErBH3pOP3T8w0mkToT0ituDohJ9GXR1Q7hkPUmOmkFsSl+yMIhuf4kowTEdbAf
	om/LzfbefxmPIndzdFKh8ewtE3ptcFCao40jZfz2IeJGEAzAsrFuk8EudmkVBBjkIA4apodBAwA
	3l+tD/88QO53EjW2ijvANrq86Ypk51xZ9OLD4EG03/Kh2aO+t64kFeyXh
X-Google-Smtp-Source: AGHT+IGXJ0oDUg8x3lalK0qa+IS9YcsVUdYwosMrUSgYdRWE/44m5WMnRi51aRiN1cRnb1G5Gn4Zxw==
X-Received: by 2002:a17:902:d490:b0:240:48f4:40fd with SMTP id d9443c01a7336-2422a435a05mr2506505ad.19.1754036073034;
        Fri, 01 Aug 2025 01:14:33 -0700 (PDT)
Received: from google.com (232.98.126.34.bc.googleusercontent.com. [34.126.98.232])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f1efe8sm36422045ad.69.2025.08.01.01.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 01:14:32 -0700 (PDT)
Date: Fri, 1 Aug 2025 08:14:27 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, will@kernel.org, joro@8bytes.org, robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH rc] iommu/arm-smmu-v3: Fix smmu_domain->nr_ats_masters
 decrement
Message-ID: <aIx3Y3qIstTceTC0@google.com>
References: <20250801030127.2006979-1-nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250801030127.2006979-1-nicolinc@nvidia.com>

On Thu, Jul 31, 2025 at 08:01:27PM -0700, Nicolin Chen wrote:
> The arm_smmu_attach_commit() updates master->ats_enabled before calling
> arm_smmu_remove_master_domain() that is supposed to clean up everything
> in the old domain, including the old domain's nr_ats_masters. So, it is
> supposed to use the old ats_enabled state of the device, not an updated
> state.
> 
> This isn't a problem if switching between two domains where:
>  - old ats_enabled = false; new ats_enabled = false
>  - old ats_enabled = true;  new ats_enabled = true
> but can fail cases where:
>  - old ats_enabled = false; new ats_enabled = true
>    (old domain should keep the counter but incorrectly decreased it)
>  - old ats_enabled = true;  new ats_enabled = false
>    (old domain needed to decrease the counter but incorrectly missed it)
> 
> Update master->ats_enabled after arm_smmu_remove_master_domain() to fix
> this.
> 
> Fixes: 7497f4211f4f ("iommu/arm-smmu-v3: Make changing domains be hitless for ATS")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

arm_smmu_remove_master_domain() needs to see the old ats_enabled state
for the cleanup.

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 312bc31d7e8eb..3c81139faecae 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2997,9 +2997,9 @@ void arm_smmu_attach_commit(struct arm_smmu_attach_state *state)
>  		/* ATS is being switched off, invalidate the entire ATC */
>  		arm_smmu_atc_inv_master(master, IOMMU_NO_PASID);
>  	}
> -	master->ats_enabled = state->ats_enabled;
>  
>  	arm_smmu_remove_master_domain(master, state->old_domain, state->ssid);
> +	master->ats_enabled = state->ats_enabled;
>  }
>  
>  static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
> -- 
> 2.43.0
> 
> 

