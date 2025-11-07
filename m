Return-Path: <linux-kernel+bounces-890938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB985C416AD
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 20:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94D7D3B34A7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 19:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2B13009CB;
	Fri,  7 Nov 2025 19:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Ksn7BBLa"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D06301492
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 19:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762543013; cv=none; b=btaYzFaFmnqc9OJsQ6LVD9x0DLLwssCIS3fxDwjqe1u6iwJ6rz0F1hVS4kR0oUt3secTBA/3dIaY7i1BLKoHKB9l96uzwM51pi0w4MK3yW9tp61ujpRNrr3x10Xo6b6GJk2YftcuU+autQMw5fi4uyNPCilA4g8zwxeTMe08GXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762543013; c=relaxed/simple;
	bh=VOdPNLzT1eZ1NEB09xe83HjehWmI3iXz/M9xFWPtPBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i6QFDfUjodvYrZevOpJXu6T/grW9r+o+CcauN2Snw5+Ckt5b+kIkBwrheMoOHs2YIr0XQExnqw/UKCkZIoKJjBji1yYpwsO7arPAhB2u6EuVHeQWb042HKb4yeOOCVVLSOMVHfzxmwbKN0G4WeARkqcrM8Tg15clvmFSne8w7Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Ksn7BBLa; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-87dfd3cfafbso10416676d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 11:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1762543008; x=1763147808; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uecw5GuJ6xKMR/52t0KK0j/pRrv42h6jWvdNot4nYIc=;
        b=Ksn7BBLaoKIGTzBg892R6V+pwjUJqZcA0k73BXvCKD2YpdtItXOamwKrf55QqoDDIb
         J/lEvZBmacJTDZGzF8UmCWwf+XX7YlMe3Nks3jle0YiAWAoLycIfjl64TFIPCc8CiJTN
         IAeNuCqIxOLuWHmXKmvZ40nNmbY0Bjgwe8yyke7GVJHVs/oau4BKQkw+IcxLcZZBGaWz
         xoVSeq2Xv52A/TRCZiFi+9bm25CuAlFaly2elsQKTk2ku1Ra9yESWvq+NCmYCyoEIFFq
         dMJky1NXNlEk/0teQ9sRAC0wnGqWANdu2YtozK8aeDRmoZOZ5j1F2avVO01y9kE1rCA+
         fyag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762543008; x=1763147808;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uecw5GuJ6xKMR/52t0KK0j/pRrv42h6jWvdNot4nYIc=;
        b=WjsEPLL3OmFVG1RN5ZZAdcpEHYB7q7PT1C0PBddptezOqt888/sJrj5PCL+VyBr+te
         xtqmshKmZoWc+TKgucO/bLoUZi/AT7wwe6SV6anw5t3/QOmh0m7wC/hAFCQc+U0auvQR
         wh5aSCNUwTVOQIRUcDUE0Wr/9vjzZDZD4GgXrEXts0cc+2QCZ1UVqsQIP/4kZOTWeBkM
         i+tqwh3yQHFYAB5jCgGwF/RarnChb5UqNKIU6PvFPh4qpQx2biau1v0olRdmT9MZa2OA
         LLJICdhFPGPntUht0+4S7stA2ZY63oUWkMc23Vd7WlwSJyNd3zfS7QJ3bxoWIMtZamMG
         mTRg==
X-Forwarded-Encrypted: i=1; AJvYcCVu+2iSI3WERq1Lts408xIBtT+6WidyfWvnfcwKj5mZqfWuN2oR6A7+1dADjOcSV39weB4hjglnrfQsClU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuxmMRc0V7hPBJbfrdc4pCaEpFkPI+Xl8UKnFGhxeUWEBPF7kB
	ccjtWwZxe+ESBdZVCIVE0bdPRAtMsPlPdeUjeWEWkvgZENqTcS9dPufQsNsxs66+2sU=
X-Gm-Gg: ASbGnctkkQjOQn1bSQd/0cYia2KgqFWnwYZGPGOWLkG1+3QLE3++7hdbSohV5Yv9qO9
	znSh+qSg7mj30sK/nFIazB5SOWSO5Mfb94yy2GAdmscUk+FBh9mRXdDcCwBkWamHkIj67zs5RTZ
	ybaP41dYcHPlQROWvfx3Gmv8FFzndA/FMYARFNXMZYJQgN093Uwu9bYsoLFafGToalz9MNMyoly
	KF9fk6A4dIb7JuFBQ9+OHaEUrVJMlzk7j/LjPcBIuQDL/whrQHEDE+A41eX3FYKHpHnJRKQj2VT
	AOLWnAcZoSib5C9GUTcT/zKNQ/3NqX1oJY1N0UKj5VDkiC/k8FGoFJMpJPib6NpfNEFcDVxCfTf
	Jh29og3tfqN7AZolwHwJNqUphrzDj1AoYstHHGYwG1men/LHc84/GHiVHxMGIV8ReRhjeN+MbHT
	InzA+C2bveliYrdeVvjSNZn0oQEox8j1RJstXLd3gfvrV8Jw==
X-Google-Smtp-Source: AGHT+IFuKO535u2kiOv/DIfBewHOhom5AEVBkvPZuA5a9xJpNKB2nCPzp+ZUXTed1YvzsoYZhtcP/A==
X-Received: by 2002:ad4:5c66:0:b0:880:224e:aab1 with SMTP id 6a1803df08f44-8823871af07mr2487486d6.66.1762543007674;
        Fri, 07 Nov 2025 11:16:47 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8823896a8d9sm593576d6.17.2025.11.07.11.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 11:16:47 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vHRx0-00000008LqN-30pE;
	Fri, 07 Nov 2025 15:16:46 -0400
Date: Fri, 7 Nov 2025 15:16:46 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Ryan Huang <tzukui@google.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Nicolin Chen <nicolinc@nvidia.com>,
	Pranjal Shrivastava <praan@google.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Daniel Mentz <danielmentz@google.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Fix error check in
 arm_smmu_alloc_cd_tables
Message-ID: <20251107191646.GB1859178@ziepe.ca>
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

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

