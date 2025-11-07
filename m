Return-Path: <linux-kernel+bounces-890950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B35BAC41716
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 20:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2FC4834A6B9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 19:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCED305E10;
	Fri,  7 Nov 2025 19:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ow+LvC77"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDCC304BB8
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 19:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762543837; cv=none; b=X+RbgIz+P2Gd47jr8OBPIcMPRxt+o6KD/LO5m9s7tN+UuHnUuTMkZndRMU02SdWuTxCh05cI6V6mR/lTlfUBOFId1b7ZTkxRkjJYzDLfOii/pNKoreIIcCm6EhEgxQtL/X2oyOT7idd2tcDjRzVrt08wFqgmUg8F7ZSr6Aa+vOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762543837; c=relaxed/simple;
	bh=XygVhSD3HlTOEAa9BQJmws4+jogICxDOzJiVToEZzsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JwTo0Ili1UtfgDd3/g2Yu+8XC+NbQgl2RtuQHLz6vubGjXjtX1TZmQqPJ85aCW21fms3gmAJQ7iS3EcMaeow8MfRJTWtjL4tSdZXNe4r+sosu3lmcJZFS1cZ9NWOrjdRqeinYzsHQOo2S+fS4sLFsf9gINxQB9Di64ThmaZssDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ow+LvC77; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-297e13bf404so21055ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 11:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762543836; x=1763148636; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ii2K5/lD+aBTxicdOXZF0Rxje4qtvj62/HMAMykB+YY=;
        b=ow+LvC77nX6ApsyVqnZeTG8wgfO/nJviKPmnOV5LP2i7249MOJGDepmPKWqT4vcwqF
         q6B9l/G9oKffG/M7Ji0BD+jvV0XqZxUQJI6FHAtd8ov/YEhcXDuQCuLZO1770ZXBWs0I
         CzrISVwmiXFgilZwp6keY6oN2aznws+92SZQITFEMKTyhU+fU+qYZ2DURvcDfVu05KFp
         Ch2RdAdSrXqy8EkJ0myPDf7EbQaJxPwf+fuI4mhuBT+Q1LPD70WCgdV7ANlRNvPwIduw
         hf2s+LV/whVcYiX/yCF7hMFGmxq7fxFrn+5m6nPAO4lmwPv8dhtc3MYO5O7MYPUZb7bL
         2pJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762543836; x=1763148636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ii2K5/lD+aBTxicdOXZF0Rxje4qtvj62/HMAMykB+YY=;
        b=Yl075+JJQSZ9woL23GycCAGkvmWqPI4c/PKWA57BmyBOeluBkOY/J9rGDsf+MgeoXz
         Q9oiGMSTufgIrPvhIpDQQlWDcpTEtvMwra1mP9SVFCsGMUjkWSI4zGKOHYwnCz5t3pLh
         w40nukIqIIFLOAQ3Vxu3O+k7kXbHSMmi86AFU8OcEJmv9lWVvOf5ePtswp0+k/yH/AEE
         UE3OK2RmJOphHsj7Wrq63H+q7PEV/QceSxQHEKEWDyYp6anJzzvf/og7KFiwUS7V7P+r
         Ueoh5wdWt2THlMwCjmQP3IIzCo0jIq1db0EKCUY5m6ZrXbax6pYMZekaFP6X1Q6COQZr
         guCA==
X-Forwarded-Encrypted: i=1; AJvYcCULg2MiONxRqwOjcvCmw6N8/Gf0cASAJF6kTIFOenSv8VF/RcsFvBNaqMcNC/5mbiA0gGS42Z5OBUeUz48=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyby6VaywjCPV8praO6pfS16Iq50u3hEGOln/iqbS7yzyqDWJ12
	o5x5M0JlnDsKtHBGYulN3eH2FtEXUNPB9QUo5LDqK41XgwN3c8kaJlaxsZIwwlMR6w==
X-Gm-Gg: ASbGncs37XjaD8hq6s/WQbnbBd+9yJaZhIhwcCieNxa6RSh5YPUhWDWx5j7hxE3kkmZ
	IiyzP7kfRSyhESE+xEULDxTmw+6m3YpIrlOefoy3t4A7CXRc4sCoAHj1a/oLZT/3Kyo4hci8Eg0
	nPRcfVnsHRhEWVgCZZgUfFK2on/GviMHqaR2UsQrE4GYEo7WOIQej6sLJH065XfzBtF/L5jDw+D
	keEMrb8SsqcRkM67ya3yDNQTSYWMNF7OW0lpsGRvZPlO/jZpJ4v13gQls1JC3Fi5ydm+kj1F8y1
	WZ6ji4CROHkQ4PzheRuZuvnbNSe/5qlaN/NhdaP9b3c7COuvDkIVau0wbDWi5f2OsyRVPsZ/11f
	Wz8ZeZBfKolmPk8T15cCCHjFieuEW+OMEReIvm3gpBCb53WWV4sqKvgVGmvnOKixp7ZDTT2UTT2
	SQmGloGyAP3Z2SaNcHBkNFfwm1p46Ix/Hye6NUtjwMyl8PS04C
X-Google-Smtp-Source: AGHT+IGrZxEpsvavP2SSGDlxEEDNvgmombMxNJOrhRHYLBt6v8Cu6925mPYDaXVNFvL+7VqE7SGZkQ==
X-Received: by 2002:a17:903:32c1:b0:297:d83c:9c37 with SMTP id d9443c01a7336-297e56624e7mr492925ad.12.1762543834993;
        Fri, 07 Nov 2025 11:30:34 -0800 (PST)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a68aa1edsm10072092a91.1.2025.11.07.11.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 11:30:34 -0800 (PST)
Date: Fri, 7 Nov 2025 19:30:28 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Ryan Huang <tzukui@google.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Daniel Mentz <danielmentz@google.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Fix error check in
 arm_smmu_alloc_cd_tables
Message-ID: <aQ5I1OYwWbfbA95X@google.com>
References: <20251107190917.2858684-1-tzukui@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107190917.2858684-1-tzukui@google.com>

On Fri, Nov 07, 2025 at 11:09:17AM -0800, Ryan Huang wrote:
> In arm_smmu_alloc_cd_tables(), the error check following the
> dma_alloc_coherent() for cd_table->l2.l1tab incorrectly tests
> cd_table->l2.l2ptrs.
> 
> This means an allocation failure for l1tab goes undetected, causing
> the function to return 0 (success) erroneously.
> 
> Correct the check to test cd_table->l2.l1tab.
> 
> Fixes: e3b1be2e73db ("iommu/arm-smmu-v3: Reorganize struct arm_smmu_ctx_desc_cfg")
> Signed-off-by: Daniel Mentz <danielmentz@google.com>
> Signed-off-by: Ryan Huang <tzukui@google.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks for the fix!
-Praan

