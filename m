Return-Path: <linux-kernel+bounces-657536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D02ABF58E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 15:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D77354E3D32
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 13:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF08272E5E;
	Wed, 21 May 2025 13:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ACsfUy/d"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB80F270548
	for <linux-kernel@vger.kernel.org>; Wed, 21 May 2025 13:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747832902; cv=none; b=uxvpQ1Z1SCCdnbbxdHmIk8Oe/HvniqzA1WB/TONiPCXVbc9xK0gHVU43wUPXjSg3REEOIP3K7tL9D73jl/R65LXmhkvuaw4qTrVq1Lmrv85VyJ7YLXKObdf4xlPSJx8STFAN7QjdT/st/bunXM9dhvdyiZL+nJ7jkUsz9cmuGb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747832902; c=relaxed/simple;
	bh=y667xlRjshHTCdOcA4582uYlKjS+bp6OLEVTjHaUkzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B4KV8Q6HCUdHkEW3AW/S5K0TSoKTuGS5z+Cjxh+Cae6ImIqyCGqa0MttRbghFsX9oVBFESbgJ9ntZpVczP8T1PbGF2Z4FdF7+c4Ok2/iGe4jkSnqb1yq+6LpSX2h5tDVa1QZ9s2RLMyS1akIGwMz/LN65UsFYKC1axlCEptmd4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ACsfUy/d; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-73972a54919so6339867b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 May 2025 06:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747832900; x=1748437700; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xt5u1NW+UKPTvEFieJrj+mDAWfwc6t4eZFA83UFoe+Y=;
        b=ACsfUy/dVIhtCIa4i4sgWdTlmemyn4/Gh3xS2F+MJJEcEvsfT45SeINJE1Bvn7uXSK
         iXfDX17syhq6H+KIlwADx2kTL6Tymjb5aZfJI5VRCiNwyurLb9mSJCQg7kCPVN+iJaNO
         AMqXjmtXcwk6HSUBUzQaIIVtP2DQLW0be22TX0j7G9vOyQT6l9XKlKLcIY7U0fDEswB1
         kJVtJLYEZZ4veeWtzF96a4GMU/5Fdy6C15rEkK9xLwq9jhK27jlAMOY/d+gbdAYuvHgQ
         D0NRVViMFNX0x35suKzKtTsS6A+xZ+oC9PFdglTKTAvpTfRIxzZM8VCIj88ClTzyGwbu
         Kn1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747832900; x=1748437700;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xt5u1NW+UKPTvEFieJrj+mDAWfwc6t4eZFA83UFoe+Y=;
        b=Xy7nDix9yGkhtWhGv0xULnNwxgV3xgDjsTp0mY54cKpqDBVxwH+khiMt3m7gAp7rg2
         fh8rtdf+l2XRqLD5GfQV66qU7+KqU1VwO9eUIFYeDYv/RFGiKse0kGtpIReVmn0m27XK
         N9MqiiaZ8cOTnPE1H/p92UKXf5/6xspH/aIJCtbfWmDMCRNGx/cfDBUOMNMkfBBtAOns
         vU3zUwW9YpUCF1mr4kPfaAodgyNDV3zQtk1GjZwbQOP42jt1Rb4E08OysICh8UMv7doZ
         e/Z3x36lwpuyC81ujyyOVRGCHuZv7hj1sRUJyvZTax7eTUIsdk4ji+s5ZFagKC+zmBHn
         48CQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAbkQAEIE6+RFia4NebiyNFvYnhT8W6wsYlPpnqpzSk9lv0qaQahYf8yH8Sijjt8UwJNcXy8WJk3nHjRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwugpiBQLoM0v4yYS1nYQVxJV+S26spvpIHykCXc6T3OUtdoLlT
	ee+kh7vbPymrNLBw+6xGTSPyDJpHjn6dG7pR2KV7InMvbi+PqDQe4HDJxMNYquwt5Q==
X-Gm-Gg: ASbGnct80jfMfNQT/be6wXFrvO2yWbyiY3DO2TYhjk4wu+kUH052TAhOK6iVqgk7Yw/
	mThKY5fOIN067D839qbpNrtx7CndaA+w//9chQbK+wpIxNPSOJ0NGosGpzAL03u2fyHRbQw7lpa
	fYM/YNnfZrqzxn7V8f4eizyrA2+F7ZWYdRcyntQGxzjpPcS2ANB1Wis+eX7sguExQZLHjZ2HvDn
	d/ra3O+DO5vCgn+C+H2bIYR9O6yv3+A8kw7ylJrVqWU6vQfZxotjefApWG8U3QQUw28wC5MHa8v
	NgeRM53Li1wcqUop33ehznofSjomcKY/EsSDH97oMCbmFXCYY0zfSMmUBBcQ
X-Google-Smtp-Source: AGHT+IHascvxCoFVkA31LZBdvW7jzau3iUVkHksoNUV8TEsEK7Xh8qeVnLYOu02jnBVSWphaqJ0viA==
X-Received: by 2002:aa7:888e:0:b0:742:a02e:dd8d with SMTP id d2e1a72fcca58-742a98b4a84mr28669364b3a.20.1747832899901;
        Wed, 21 May 2025 06:08:19 -0700 (PDT)
Received: from thinkpad ([120.60.52.42])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a970d5c4sm9842432b3a.65.2025.05.21.06.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 06:08:19 -0700 (PDT)
Date: Wed, 21 May 2025 14:08:06 +0100
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Nitin Rawat <quic_nitirawa@quicinc.com>
Cc: vkoul@kernel.org, kishon@kernel.org, 
	James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com, bvanassche@acm.org, 
	andersson@kernel.org, neil.armstrong@linaro.org, dmitry.baryshkov@oss.qualcomm.com, 
	konrad.dybcio@oss.qualcomm.com, quic_rdwivedi@quicinc.com, quic_cang@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-scsi@vger.kernel.org
Subject: Re: [PATCH V5 01/11] scsi: ufs: qcom: add a new phy calibrate API
 call
Message-ID: <jnftkie5c5hi6nqhliktxqbj7gykj53lvm5gibt3fjdcq7dber@bh4fxrp3fezu>
References: <20250515162722.6933-1-quic_nitirawa@quicinc.com>
 <20250515162722.6933-2-quic_nitirawa@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250515162722.6933-2-quic_nitirawa@quicinc.com>

On Thu, May 15, 2025 at 09:57:12PM +0530, Nitin Rawat wrote:
> Introduce a new phy calibrate API call in the UFS Qualcomm driver to
> separate phy calibration from phy power-on. This change is a precursor
> to the next patchset in this series, which requires these two operations

'next patchset in the series' wouldn't make sense once this patch gets merged.
They all become commits. So you should mention 'successive commits'.

> to be distinct.
> 
> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/ufs/host/ufs-qcom.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index 37887ec68412..23b4fc84dc8c 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -531,6 +531,12 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
>  		goto out_disable_phy;
>  	}
>  
> +	ret = phy_calibrate(phy);
> +	if (ret) {
> +		dev_err(hba->dev, "Failed to calibrate PHY: %d\n", ret);
> +		goto out_disable_phy;
> +	}
> +
>  	ufs_qcom_select_unipro_mode(host);
>  
>  	return 0;
> -- 
> 2.48.1
> 

-- 
மணிவண்ணன் சதாசிவம்

