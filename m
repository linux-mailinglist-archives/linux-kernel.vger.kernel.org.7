Return-Path: <linux-kernel+bounces-657549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA406ABF5C1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 15:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 419A33AABD0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 13:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D4A27584F;
	Wed, 21 May 2025 13:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fkT7ecYS"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2659E267B74
	for <linux-kernel@vger.kernel.org>; Wed, 21 May 2025 13:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747833207; cv=none; b=rKG6Iokdvr2wC3+M+wqfvxxTzcYmvIwV2B666VmovMGkLo1tUyBClKH2yhRYwQIZdBPsnAZTPPaKzZAC+B+RIqHrxSgkjrBMi+J9ct3jWQSuRBaZJ1R4WBpxLcZeu3evq3vcquMEGQyJwZ5Ae4lXeZCadVS2QexwuLe/Iv8+Wuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747833207; c=relaxed/simple;
	bh=PEUw8oNToGBQUpdkFgey1gEWtLuJRmRd/HOWRufD8D0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FB1yh9Q4NBvrQlm2YS2h6cR+NezMI3km9y98zscXVkoJYN6dGI2XVtAPGZJ9K6sU+O3UsKKMgNkE5c1qbLUUHjLCoQHL8P9uFWYSVCQo0rhJ7eq8WvXL7ATUaYS4ec4IoDWFYN/Y9tIjDVtIQ0oOEOSwVXLgslI3UuMXezPPrOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fkT7ecYS; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-742c9563fafso3304217b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 May 2025 06:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747833205; x=1748438005; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DowZvl7qA/uAhVQuHMif7vNt8RT6sHwwCijVL4Xt204=;
        b=fkT7ecYS4NICRdU9xSXBycNBBO2wEeOv8x98W23bZv5PalpY/RfLCWEWsPN8ASvqIe
         xWhuWEv7/Maxzuy8dc2VDBKr+unlLE3TXASK6NgmMvrKkzFVNXiKTHZnfV4lmoQqGCkZ
         kQf71OtCRbnNxQaUeGO7YF7azPIQ7+u4HS1mF6jYGUCAFyTvH76V/bHmpU/g9AcHe4zU
         46lUJ5a/7Nr1ouwad8XRCiq/L5d3lmnlpBXLONENK/bLoBHRWPJDCfUYOTZgpY8paW9N
         W7mVKp8DqaPIMSOqy8FVuqxkUSejPxRYtaTIu685/z9qnjRVMB4aLN+oxVXTWb2bAW5S
         EdrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747833205; x=1748438005;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DowZvl7qA/uAhVQuHMif7vNt8RT6sHwwCijVL4Xt204=;
        b=fIkgfwKnGLKcSxhmOCGrb/IPlB9rdL8iM67dk4z8+QSp1brICoVxxinI8Zgy4Xv5dG
         6LtlW/WM2/TISZYncKTih3P7vjs3kFl6LThLhudocxZdp+OXefk/JQBcXM0QWx9IB8os
         j7YPofOXI2+et9WT8U95sSHnGiANrff1hfS4M/LnD2xP5vMXai/apcFdsQwbVfZhtwJo
         eQykV8k2wyS9WfAL5LYAq3EULx+ldUesTMbQTGZe1d0yFAb/djvHKoP//vOs6/4ib0da
         O/brQt1WqSIbBSjGl8lE4WfiSPTCty3SPIK5UfcuKCBoj0YHH0SrvZ8cLrnhdPhJmiuD
         Zjmg==
X-Forwarded-Encrypted: i=1; AJvYcCU+iDPv6YcLRc2gJL9dNzW/T+SiOKQXkHrBCK8uAksLs7efs71TDV5tfkcYHyKUFkKINdvGvOckdtrQ3XE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzffrzUg3MjMywty+l5WN+C96IjYAET/bCJHe7jmeLj9mxNgfm2
	chzN46jnrcYa/ZVGoZ0vNXHz9Jcyqoe4CDS+QASTDAFLmobiMOkjQkO+VlXqF9pJ1w==
X-Gm-Gg: ASbGncsNgBcIjKGY7f1Mg0lgOE0MgAztQchyIRdW4ZVzLHtw/tKNFX8wYT5gPiRZtt/
	ojx1Eflg/zQP7SnjaqetUBQymY0p+N/K/E8Ld4yxKuLerF56a0LkuJZXf3JFXPUhtiI7zDotdLa
	ArDoH8uVDKOMlNNtTITaXLuskd//UWBljh04IrgYod9E/DdUfeKUw7s9LYxKijA/Fno+b5y1rea
	Uv58XExOOxXwltfXOFbBx2L9pW/TNJllVqODvRQtIH72I/UX3ucfQtjJtW6x0cbD7qQczDbAZWz
	21YpKpCgmW72u7Razxb6B/f5InUMZAI93VgrYsBxNr4RjZiV/f5QegPrNRK2
X-Google-Smtp-Source: AGHT+IHiH2b/i4vvEt/AHMBHqqPS0yIzh62+h+3L9fGQ7pUd2qcx4hY61OfXdJ/u8TfPs3p6Vnp3eQ==
X-Received: by 2002:a17:90b:4b0f:b0:2fe:8a84:e033 with SMTP id 98e67ed59e1d1-30e7d4ebdbcmr32842704a91.2.1747833205356;
        Wed, 21 May 2025 06:13:25 -0700 (PDT)
Received: from thinkpad ([120.60.52.42])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30f3638710esm3578317a91.20.2025.05.21.06.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 06:13:24 -0700 (PDT)
Date: Wed, 21 May 2025 14:13:17 +0100
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Nitin Rawat <quic_nitirawa@quicinc.com>
Cc: vkoul@kernel.org, kishon@kernel.org, 
	James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com, bvanassche@acm.org, 
	andersson@kernel.org, neil.armstrong@linaro.org, dmitry.baryshkov@oss.qualcomm.com, 
	konrad.dybcio@oss.qualcomm.com, quic_rdwivedi@quicinc.com, quic_cang@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-scsi@vger.kernel.org
Subject: Re: [PATCH V5 03/11] phy: qcom-qmp-ufs: Refactor phy_power_on and
 phy_calibrate callbacks
Message-ID: <g6neasajgbbu3iqy3kj6zzizichz5xvrsktepl46ahxepy2nus@whq2j35lc5fe>
References: <20250515162722.6933-1-quic_nitirawa@quicinc.com>
 <20250515162722.6933-4-quic_nitirawa@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250515162722.6933-4-quic_nitirawa@quicinc.com>

On Thu, May 15, 2025 at 09:57:14PM +0530, Nitin Rawat wrote:
> Commit 052553af6a31 ("ufs/phy: qcom: Refactor to use phy_init call")
> puts enabling regulators & clks, calibrating UFS PHY, starting serdes
> and polling PCS ready status into phy_power_on.
> 
> In Current code regulators enable, clks enable, calibrating UFS PHY,
> start_serdes and polling PCS_ready_status are part of phy_power_on.
> 
> UFS PHY registers are retained after power collapse, meaning calibrating
> UFS PHY, start_serdes and polling PCS_ready_status can be done only when
> hba is powered_on, and not needed every time when phy_power_on is called
> during resume. Hence keep the code which enables PHY's regulators & clks
> in phy_power_on and move the rest steps into phy_calibrate function.
> 
> Refactor the code to retain PHY regulators & clks in phy_power_on and
> move out rest of the code to new phy_calibrate function.
> 
> Also move reset_control_assert to qmp_ufs_phy_calibrate to align
> with Hardware programming guide.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Co-developed-by: Can Guo <quic_cang@quicinc.com>
> Signed-off-by: Can Guo <quic_cang@quicinc.com>
> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 26 ++++++-------------------
>  1 file changed, 6 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> index a67cf0a64f74..ade8e9c4b9ae 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> @@ -1797,7 +1797,7 @@ static int qmp_ufs_com_exit(struct qmp_ufs *qmp)
>  	return 0;
>  }
>  
> -static int qmp_ufs_init(struct phy *phy)
> +static int qmp_ufs_power_on(struct phy *phy)
>  {
>  	struct qmp_ufs *qmp = phy_get_drvdata(phy);
>  	const struct qmp_phy_cfg *cfg = qmp->cfg;
> @@ -1825,10 +1825,6 @@ static int qmp_ufs_init(struct phy *phy)
>  				return ret;
>  			}
>  		}
> -
> -		ret = reset_control_assert(qmp->ufs_reset);
> -		if (ret)
> -			return ret;
>  	}
>  
>  	ret = qmp_ufs_com_init(qmp);
> @@ -1847,6 +1843,10 @@ static int qmp_ufs_phy_calibrate(struct phy *phy)
>  	unsigned int val;
>  	int ret;
>  
> +	ret = reset_control_assert(qmp->ufs_reset);
> +	if (ret)
> +		return ret;
> +
>  	qmp_ufs_init_registers(qmp, cfg);
>  
>  	ret = reset_control_deassert(qmp->ufs_reset);
> @@ -1899,21 +1899,6 @@ static int qmp_ufs_exit(struct phy *phy)
>  	return 0;
>  }
>  
> -static int qmp_ufs_power_on(struct phy *phy)
> -{
> -	int ret;
> -
> -	ret = qmp_ufs_init(phy);
> -	if (ret)
> -		return ret;
> -
> -	ret = qmp_ufs_phy_calibrate(phy);
> -	if (ret)
> -		qmp_ufs_exit(phy);
> -
> -	return ret;
> -}
> -
>  static int qmp_ufs_disable(struct phy *phy)
>  {
>  	int ret;
> @@ -1943,6 +1928,7 @@ static int qmp_ufs_set_mode(struct phy *phy, enum phy_mode mode, int submode)
>  static const struct phy_ops qcom_qmp_ufs_phy_ops = {
>  	.power_on	= qmp_ufs_power_on,
>  	.power_off	= qmp_ufs_disable,
> +	.calibrate	= qmp_ufs_phy_calibrate,
>  	.set_mode	= qmp_ufs_set_mode,
>  	.owner		= THIS_MODULE,
>  };
> -- 
> 2.48.1
> 

-- 
மணிவண்ணன் சதாசிவம்

