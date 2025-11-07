Return-Path: <linux-kernel+bounces-890414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C33C40009
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 13:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 110764EC38A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 12:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19552D738B;
	Fri,  7 Nov 2025 12:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NN5WzBuY"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850F52D8379
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 12:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762520061; cv=none; b=kBwbYilImUtImKPDt8xqp87RKRPgPiph8SSovquOyvyFMGW+jWrRgCVESnOgA+SDh4moHcMWAXqX0mb+nFEqW18tjDg+o5XW3Pub/H7/8jipFZfsyKTsDi134GPiys1ixeiTQesTv+EGQVnFEu2mSme6LwxFrXTJ9cQ/KC40BKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762520061; c=relaxed/simple;
	bh=9ihomJcdzMlqUxpOAoozbesot84OU3iYnyVg59ka2h0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=doriW0znvNUd7J3SBrU5V25yI2Bd1eJE42q8mr+kxXrI6hJFRWochDeyenSW/C66ovqShtbBaEcM2abxRdHM78HtFjPVFeX0oNQQkoV+TQJoDSYXIhU4hH+QimNf5MkC6u1tMLEWrNE2yv42SnvgzJJfgm22/b1q0TLlZ+a4ADc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NN5WzBuY; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4e89c433c00so7264821cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 04:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1762520058; x=1763124858; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9dnAfHO8i/KYJkiCOYppyzpEdu6RpKbs1p1aPTZkM1k=;
        b=NN5WzBuYc5NCm+weMPLRZKILmn1ge70SVr6/cS7eKKtogpgA7dOFY2By8KheLnmmns
         wuADMjDNY+P7nptkwpdeuRUSjyoK60JaJhvXryX4/2N6BkZquSgT8b1ai/NlwiyaMTf1
         PXMcHR24FgW4qZV68spK0tRnxDrjDwc1xTU/lcyT42AcfOMj5D7r8THiY3OWYeb9cO6C
         HY8NDakeFUEa9iGKLMoUpbFyetku73onZQ41Vgbq3Xzkg5HgV799N8NB9TNUXmAmwdM3
         p+GRtCkeBNn1mqmdTzwH0t4BhMTk03Sq5hYl2qZpCjwGr8wIQwrc81EdfDd+EraY7gMF
         /BpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762520058; x=1763124858;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9dnAfHO8i/KYJkiCOYppyzpEdu6RpKbs1p1aPTZkM1k=;
        b=fHIhUGbtGvHN2w77pkQd3qfuMG0q8es8rT65pzfx14Z1nDwftuI9EVAfh1Q8uCu3lp
         MfuHA9rS2txyEp027lDKZcqfn2ESo+zLirXdVmNiMfLgTsOnAtfzpkQKW/R29R+VRM4H
         jXPdA5/UB+C4kkdALdBG77zha8cxTlls3nAwM1mDAfKP/1F8Qyz9o6r/pcXfBNvnbEyA
         slCnJf5PjRsHSDBubeYlYj/FZBe7SteBkZmoNRBhlvqEOLcA48bcyBFGFLMKktwxxAxO
         MyMjNIRdQCgrj93wP4gWfNSZSx+D4ZYW+dsCEzJASfF9yoQZQNG1JAVaR4UifV70PnL5
         Kkbg==
X-Forwarded-Encrypted: i=1; AJvYcCW8nyrLa2PEVECrpTVx3VoHsov8pu/uP9eIKNlgR2K4YPKPqv+0ZE1aYNtHqWu9hnbMjhf4luKDE8wMYok=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOwAbOR7tj3BxcCphbSt5KHuSJ82F9fHfktPA6cpnHGrxF5MRv
	cxy/AhrTQhHhAflNwO2qzZCQ1lvhTn2yfxZxgLdL+ppY1g1VJwi7iHYSYJpfuL/2tPI=
X-Gm-Gg: ASbGncuHms01k0k43sJ7Pxdtp1TFMlSctFTCmqSh4sHGty5tssqBXbkhwybv6ezdmDt
	InoEEArBRYBh1BlBjRx/OszuRDvG63Mil5a5CINWJfvOIr8xr15XBmUOXadxEUQ/xXK+lGXbddY
	s/NXJDoNlJoYaji5duo+li1iLGiZxfLUIeSDCnEBlYML3wEJc7wKZVGio6yzQmJg0MYsTCyphuO
	bQ8ET7Eq96Sm/UEUQlR3WgaNoM1Nun88cWRfgKX8E/DFDFVn7CxNY0lf6YNkNvp+eJ4oygFtXdX
	TVYSlLP2AtV8Op1qNenfqT3D04mwouxLXAONRqQcFzhUX8YEHxtar1tLdyptdn4sOkWrZcCXPiY
	0F2hszvBHhtNy87uWkuwXX6N3GKWVFhKnNiJO5kZPwXYP3fctmQs6vkI1SLEMUmJSrgaROSd1K9
	VpIOYUOzjWzXw6mBqu7AfBSvX0w7Ox590Qv+JFRyde3wLMeQ==
X-Google-Smtp-Source: AGHT+IGA66AV0haBXQu8f19fLfBmH0ZQoB8IASgfsT0yBpQE9xCMaY7CQY2kajYY+Xnux41hly8RYQ==
X-Received: by 2002:a05:622a:146:b0:4e8:ad2a:b0d8 with SMTP id d75a77b69052e-4ed949abe66mr35785681cf.30.1762520058362;
        Fri, 07 Nov 2025 04:54:18 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-880828c5101sm40660146d6.6.2025.11.07.04.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 04:54:17 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vHLyr-00000007mZY-0tQa;
	Fri, 07 Nov 2025 08:54:17 -0400
Date: Fri, 7 Nov 2025 08:54:17 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Joerg Roedel <joerg.roedel@amd.com>,
	Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH] iommu/iommupt: Fix build error in genericpt unit-tests
Message-ID: <20251107125417.GB1792527@ziepe.ca>
References: <20251107104701.237041-1-joro@8bytes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107104701.237041-1-joro@8bytes.org>

On Fri, Nov 07, 2025 at 11:47:01AM +0100, Joerg Roedel wrote:
> From: Joerg Roedel <joerg.roedel@amd.com>
> 
> Fix the include of iommu-pages.h in the KUnit tests for the IOMMU
> generic page-table code to make the tests compile again.
> 
> Reported-by: Thorsten Leemhuis <linux@leemhuis.info>
> Closes: https://lore.kernel.org/all/9844d4cb-f517-478b-9911-b6dc1a963b8e@leemhuis.info/
> Fixes: 1dd4187f53c3 ("iommupt: Add a kunit test for Generic Page Table")
> Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
> ---
>  drivers/iommu/generic_pt/kunit_iommu.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

