Return-Path: <linux-kernel+bounces-657539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4C1ABF599
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 15:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 099EE1BC406B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 13:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D503C270567;
	Wed, 21 May 2025 13:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L58AkGGK"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C6826A0EA
	for <linux-kernel@vger.kernel.org>; Wed, 21 May 2025 13:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747832959; cv=none; b=lJttv/DqlMCs7o0i8QGLpS8KWnxVEcfUKGfq0i9EMAAUOHmXndw1xtU+lblGdihv7HvbxJZnfkGndGtc/6MzysVigsdUiyCkE1NSIqt7PJUYsf5k/JfL8iY5nUAJWVrrFI6tBQpWsEOGsdxfhoEorT7YQw9QJW8xpKfQLf79BnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747832959; c=relaxed/simple;
	bh=GRe48+T4QOjmzhOAZmrIjCqByP8egxo3tKGqpm7CZoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jkGEW0VcqcOIg3VXQEBPQS6b5nZVyluL4FulZZDqqXp8bK+DYHBa8My7EBjJb3iWeoerel0z4jsw0Rz4+Wga+Larzn6XKknc8Idcko+gj68ng03GYAudqTdXpciSTpqiIKhYb+4OWXXuyW5eEbk+jSYcJfBKUkDRAAtqQ2TWMfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L58AkGGK; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-742c46611b6so4990675b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 May 2025 06:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747832957; x=1748437757; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1xxOxxblIZR/yGk+6+Lstv8BrYyIDhp3OhJhwb5LXrY=;
        b=L58AkGGKPTUBdkXmDujPBF0WpBbhhZ9ZHSZZFf3rjNWT5y5kiFU4mTVIVBPtkBEYaM
         MwqGhEzHQ2Zi4bHqOOSi33PaMpt8Urd1I5lc55gVDQ51Og/Cy82bKOkdmy92kTdh8cvE
         Wgr47q13DVKEpgavHrtIOY0exRXr9Rmwcldeb2vVdfdlyV245obOBp6lBDwnC5X2KurL
         DmGbqRrNGG5A8T2Ooze+G0WEXjw3bP199Pzs9aOvyHkBaV95uByxF+HDipJwXsWTSCuG
         WPMJ0P5nGqZKMqnmzGQSgCVmZeOjLIK7MGPxbH8czcUO2GxGCceRKBNTfSdio/GspjpF
         ItqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747832957; x=1748437757;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1xxOxxblIZR/yGk+6+Lstv8BrYyIDhp3OhJhwb5LXrY=;
        b=uAaibznHzCetknLNkFoLYajK2p/GehM9Me7AEURDHKmUZuo8sIuyMi0WamvDJ4dN+V
         L2POPC9EB+RiiipkUY+UjVtd3iog8J2o3bJ7oQPUlA2FlUUle5xxTCPmKsXmFCCeiQvm
         FInq58GT8x/oVG0WiE9616FoePu2ecTJkCYlw3d60gC3xicEce/PauEXp+xZ9wLTFR6u
         L2WtFixpTgTSRgrA1nX8r0fmcu+OQLUd2ojpPmNBCGs4llCBpns1NFMS9peC9wJ6LJTR
         6foc6BuhqAP3RAMBh7BEQuYb/LXe787M3DQxxnJtxDdkRxiUAQeNYETVCvsNkKNm1b/e
         v8xQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcWm8/cFFU113iUxNLL36PhddnvzeceBlpyPI90yinefI/pKn7YsyiZ32VoewtkxGm/B1AvOVsppZriNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAzlBL51B5AfKt0/l5mUupK8QHWOxsGwsf4SygS5XcrAcly1Uh
	+1KZZ+XEF2fpbHtIFY6ndXQxjsmAzzZQdJggAbGXWPZf1RtFsmZTY8ZC58uwYwf6FQ==
X-Gm-Gg: ASbGncs7BOyzHOacel3QSwgPftmYKCbetjORBmUO1q6i44n6jD9iCzHDHXkyjT8XyFZ
	/NQ7uHR0B5J5GI8usIAZUNK60/Awh/RZIhlHucRPrzmzX5UGsoST3hurFsbjrrXePNnTkstXN2U
	Q1xj7HO8Zp8fC/oPdARuoqhfKL9X/hao/DbWG1UX3AbAS1Tl7yJkP/ZIbviYcscfUCdkqUR9nDP
	auP/lrnfIFUdQlrcBeXy/3opmPzqx+lD3SamtDoXp5GgrFspkizgciWm7aQXkkBrMWPfvOOhoY1
	SE/Zn0EouXrXLGNNTbJvCJ8Zva/GRgBmZ8qetftjK8Riba7t2OkzrTpuXClW
X-Google-Smtp-Source: AGHT+IFpFHFGRg8NqLbFFAyW6EgtIFf1xfDNczo/VyiKqRIj7rrnxNgs7EuDSZwWQLJYrHrtfNhQGw==
X-Received: by 2002:a05:6a00:3e0b:b0:736:34a2:8a18 with SMTP id d2e1a72fcca58-742acd75e6amr31551655b3a.24.1747832956808;
        Wed, 21 May 2025 06:09:16 -0700 (PDT)
Received: from thinkpad ([120.60.52.42])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a98a213bsm9505394b3a.159.2025.05.21.06.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 06:09:16 -0700 (PDT)
Date: Wed, 21 May 2025 14:09:09 +0100
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Nitin Rawat <quic_nitirawa@quicinc.com>
Cc: vkoul@kernel.org, kishon@kernel.org, 
	James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com, bvanassche@acm.org, 
	andersson@kernel.org, neil.armstrong@linaro.org, dmitry.baryshkov@oss.qualcomm.com, 
	konrad.dybcio@oss.qualcomm.com, quic_rdwivedi@quicinc.com, quic_cang@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-scsi@vger.kernel.org
Subject: Re: [PATCH V5 02/11] phy: qcom-qmp-ufs: Rename qmp_ufs_enable and
 qmp_ufs_power_on
Message-ID: <drtwqawkyrtfxgw4gbegybzs2yt7sucvvmralppmjpptu7sdzu@5zu6gdzefz7e>
References: <20250515162722.6933-1-quic_nitirawa@quicinc.com>
 <20250515162722.6933-3-quic_nitirawa@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250515162722.6933-3-quic_nitirawa@quicinc.com>

On Thu, May 15, 2025 at 09:57:13PM +0530, Nitin Rawat wrote:
> Rename qmp_ufs_enable to qmp_ufs_power_on and qmp_ufs_power_on to
> qmp_ufs_phy_calibrate to better reflect their functionality. Also
> update function calls and structure assignments accordingly.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Co-developed-by: Ram Kumar Dwivedi <quic_rdwivedi@quicinc.com>
> Signed-off-by: Ram Kumar Dwivedi <quic_rdwivedi@quicinc.com>
> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> index b33e2e2b5014..a67cf0a64f74 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> @@ -1838,7 +1838,7 @@ static int qmp_ufs_init(struct phy *phy)
>  	return 0;
>  }
>  
> -static int qmp_ufs_power_on(struct phy *phy)
> +static int qmp_ufs_phy_calibrate(struct phy *phy)
>  {
>  	struct qmp_ufs *qmp = phy_get_drvdata(phy);
>  	const struct qmp_phy_cfg *cfg = qmp->cfg;
> @@ -1899,7 +1899,7 @@ static int qmp_ufs_exit(struct phy *phy)
>  	return 0;
>  }
>  
> -static int qmp_ufs_enable(struct phy *phy)
> +static int qmp_ufs_power_on(struct phy *phy)
>  {
>  	int ret;
>  
> @@ -1907,7 +1907,7 @@ static int qmp_ufs_enable(struct phy *phy)
>  	if (ret)
>  		return ret;
>  
> -	ret = qmp_ufs_power_on(phy);
> +	ret = qmp_ufs_phy_calibrate(phy);
>  	if (ret)
>  		qmp_ufs_exit(phy);
>  
> @@ -1941,7 +1941,7 @@ static int qmp_ufs_set_mode(struct phy *phy, enum phy_mode mode, int submode)
>  }
>  
>  static const struct phy_ops qcom_qmp_ufs_phy_ops = {
> -	.power_on	= qmp_ufs_enable,
> +	.power_on	= qmp_ufs_power_on,
>  	.power_off	= qmp_ufs_disable,
>  	.set_mode	= qmp_ufs_set_mode,
>  	.owner		= THIS_MODULE,
> -- 
> 2.48.1
> 

-- 
மணிவண்ணன் சதாசிவம்

