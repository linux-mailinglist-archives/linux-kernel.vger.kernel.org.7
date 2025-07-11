Return-Path: <linux-kernel+bounces-727173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0727FB01603
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 10:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E52503B191F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 08:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99ABA202F8B;
	Fri, 11 Jul 2025 08:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SP0WPQrM"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04B81FF61E
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 08:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752222437; cv=none; b=NnY6Gda5aRjYZWfRAoT/JFb/rtnse28er6a4cFiCm3aDGl7isPASoMojSLNJkie8LhBHO7RifpySMhXa7OHXij681UGK99Hsrgz4OBoxklOqRWEv04h596igE3cEQ/Sc2PJ2sn4DEv/8gLwP0h/Uv5qjeVudI7r5AchOuorbln8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752222437; c=relaxed/simple;
	bh=frSrt/16VypNMrhlklfbIhGb02n3jTIlRwU6eokGfkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iFafhIKDdY4QD5Zd8eFLfRx6VQUcnO9jBZYjDxvhYZwYTD2IN284d0B+fQjPDqxMyG/dBb3kwY2Mrx/1wMqJ1Vw1h50OWMvyS6eZWGqiD0jp81MSHu9p9dqxe2YL3dBA2/whSKkfuhLTjCoAvoU5ADcqJ/CtuWD3UuWUpi6Y6Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SP0WPQrM; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2357c61cda7so86925ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 01:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752222435; x=1752827235; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3wb1oowbSA1sVzCsjHghmLIDKPJGVzvuDr0F84v8tpM=;
        b=SP0WPQrMPk5sSzKG6XZczhujz3a+35Gp19e8iAzXCEUTIxw/EDwYOhOblT6TsaGVvv
         QHotLpOFlhtRtDgi+LBZYokmemFoGTaVKt1d5IWaG7XzlZsIeQQLU/n8/STav01qFW5L
         quO84rkVKT/xpsIe/75g2hbrXeO3kPJdUtjjlSJQNdY5RI6R1I4lOc4QAM8CTDnuGu5l
         O3B2PdyFikp+KrhDHzudZT2njZVw7pBHN1vP4LuhkzUroRUFX5fLgOmhuDJYDBOivgeu
         KPfP8f8vu9sAw3YtRsISIn0b567vH6N/FOhlOO+pgj3H7hpNmqg+qRfPUseNKgBH14fU
         PH/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752222435; x=1752827235;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3wb1oowbSA1sVzCsjHghmLIDKPJGVzvuDr0F84v8tpM=;
        b=JvWLSxhio+nNF74nHsEnPbMv6NisuNUd1JMOEu2DW4+8iaN/TmNVLvSfDDpG+oQFp6
         gcLsf/Y4a+xIEFXcaKHZMiyBqWbVHzQs0X6CYNIuHRSqlTE5+yNgrSHEaJkaFI8zuDfs
         P08s8EL2gbJeCc7/vYDHi346MriyaL63C5CeuBaiPmPOOXU+nxXUY3dNeLgklJHgt+DM
         W57HCWbf1ODAEG9CCPlNC9Al3EydxMuD8Xep5Mk6bxP9UlFCiAEF/IlFezI3/cy9KdXF
         cgsIlBeMDjNh+e9S0MOobZoMCWOYima2eOHSp8fa/kAhVVv0efLOvi8xyr8IYqOEvlJf
         ZnMA==
X-Forwarded-Encrypted: i=1; AJvYcCW9o3K1xJ2ZNQvERdkBmjZ1pSaOaqXz0T+hNsfEZx/Fb8p7+U3a7tjKOED6XoM6i5BPep6pfMEqYbErAYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnuTL4iALX6tz0SNw+ZODqg8NBm7DhanrMpwQj4s5qmEvF1RDM
	PotBASNsCOWWPrTJqF9J4XUWcYUV2rJ/PIm19nIiLK1a8CHYks/JLXKsZHD884/4cQ==
X-Gm-Gg: ASbGnctPF7BvDXfNr/Xvo0aQSdfGXpgwzv0HlF/uiw4CeRIDZPxk1yCv5Ps+IPYuOJQ
	5Xqf0oCL/jmuPaYGv64i9bZFeis2nuCtuUSSr3onHukgkmuXGVX2jfg0epDMa3mwKYK6DasAiJa
	bV3J7h0vzsMLqBjaatN9IVzrELNFncWcFZbMJYLZDsXUvv4qUivJf8D4AAGDnQIKcpHfYjOnD6R
	k9uVa8su6nAwrx11fz4/9D121ijwp5E25bapF6LQqZV4/daevndPPeUqvL8FKNMNgVQx3PCRJrx
	kUKl2j5MghS+37ZOxHlLVR/rnz9uhVXbu4lm9/R9NFi2EqVvVuXtyVR6djvpjdWzy6r3dkGMonA
	s+kPFnQbnElT8ieGrzS7oU5FcRnONW21qjwQUARxdOEtXfO7817f+cExT
X-Google-Smtp-Source: AGHT+IGeQ9pS0bpSEY5lDbAotdJ5VOyrB44rPnDqbo9ssdh5gUYxMq4qPQG8JgMf7SMyjdyq4iZMZg==
X-Received: by 2002:a17:903:2b0b:b0:237:ef9c:ffd9 with SMTP id d9443c01a7336-23dee1c636bmr2323505ad.2.1752222434466;
        Fri, 11 Jul 2025 01:27:14 -0700 (PDT)
Received: from google.com (232.98.126.34.bc.googleusercontent.com. [34.126.98.232])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42aefe2sm42788465ad.65.2025.07.11.01.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 01:27:13 -0700 (PDT)
Date: Fri, 11 Jul 2025 08:27:08 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, joro@8bytes.org, jgg@nvidia.com, kevin.tian@intel.com,
	baolu.lu@linux.intel.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH rc] iommu/arm-smmu-v3: Revert vmaster in the error path
Message-ID: <aHDK3PIpwWvkwJtB@google.com>
References: <20250710233003.1662029-1-nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710233003.1662029-1-nicolinc@nvidia.com>

On Thu, Jul 10, 2025 at 04:30:03PM -0700, Nicolin Chen wrote:
> The error path in the arm_smmu_attach_prepare() was introduced with the
> arm_smmu_enable_iopf(). Due to a rebase issue, it forgot to include the
> revert of the vmaster.
> 
> Move kfree(state->vmaster) to the error path, to prevent memory leak.
> 
> Fixes: cfea71aea921 ("iommu/arm-smmu-v3: Put iopf enablement in the domain attach path")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks!
Praan

> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 181d07bc1a9d..3c79cdbbd9e7 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2906,8 +2906,8 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
>  
>  		master_domain = kzalloc(sizeof(*master_domain), GFP_KERNEL);
>  		if (!master_domain) {
> -			kfree(state->vmaster);
> -			return -ENOMEM;
> +			ret = -ENOMEM;
> +			goto err_free_vmaster;
>  		}
>  		master_domain->domain = new_domain;
>  		master_domain->master = master;
> @@ -2941,7 +2941,6 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
>  		    !arm_smmu_master_canwbs(master)) {
>  			spin_unlock_irqrestore(&smmu_domain->devices_lock,
>  					       flags);
> -			kfree(state->vmaster);
>  			ret = -EINVAL;
>  			goto err_iopf;
>  		}
> @@ -2967,6 +2966,8 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
>  	arm_smmu_disable_iopf(master, master_domain);
>  err_free_master_domain:
>  	kfree(master_domain);
> +err_free_vmaster:
> +	kfree(state->vmaster);
>  	return ret;
>  }
>  
> -- 
> 2.43.0
> 
> 

