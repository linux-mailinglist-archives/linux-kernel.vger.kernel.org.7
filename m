Return-Path: <linux-kernel+bounces-753593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B89FB18504
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 17:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8226172916
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 15:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEB22749D9;
	Fri,  1 Aug 2025 15:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e6GskBDL"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B62B14B96E
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 15:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754062392; cv=none; b=g41KkrdkPcJHlrqzQQvIPni8bIVU4SEXNNetP5PEkKMQaB25CH6I17whceEt/Gn9cjhdWzfbvmUwDIX0ipWb27O2J6+TcA0UiR5vjOjen0AD4w+2N8XkI1DZ3zLO/+lOTXe3MI3TnUEQlD9fzSwqXApMU2q+wdsUoMTphvX/aXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754062392; c=relaxed/simple;
	bh=G8XzIPRtm4xk5lge123mz0p0xgKBk3goA4ZlLuaJzb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rqQrep3Prg3NObtvoYdigmF5X6H/br2SxHjCPMywbMgIUnWGinX/cllJiXYKbPi/5+wa1EWI9v0NKxnCv53nDSfnWgvuBsE6R/rYt8yr02WrsneKGXMhVfcM+MpwSEKqyWPsvOBuMlH2sRGI3bpAVxYpAmkgSjoDvrx2Sk6YNwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=e6GskBDL; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3b783ea502eso1663255f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 08:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754062389; x=1754667189; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KMuhTiNgWdKprDSY7tl08r3yTLD5z9VbtaB9UQkibdQ=;
        b=e6GskBDLWvI5xgp6IaOORg6iAFkwfJENMf8NQF6p3+G21pz+LDmuf0nIgUmD+9x4PY
         sdRkmzzCnjyaLdsy98YzIdDN3gC39yXwdVyZlussTug7JGg/ugP1lwyX5ZAKSnJ6km0X
         3KNgRMVPoOozd3ORBWQVYV+5qYCnKmUH0KRuii3wH+mNmguUe8KPfzk8PpvrpUn+V8vE
         MoeCYQmr7NTeY9lazQ0WauhwgwmPi3mNvMTELfow+3+5QM7cOEjHnvTmNz5aBni/no0m
         gLAUMBJxqr6XAHmYsH9MH/LIbaek8F0HijKEcGcBkOQPfVbvDH24U4odqozY2nJGFkMb
         dZOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754062389; x=1754667189;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KMuhTiNgWdKprDSY7tl08r3yTLD5z9VbtaB9UQkibdQ=;
        b=cSFF8r4oDitw5vaOFpxM2i3Nrc5kue1M38947qJo8JBiZYkEpot5QotuMdCA76XBdx
         rXvcA06J4zHVZ/3fBq7qY70B5IvjxaY1TvPivAO6yB0PQnY1fww7giOHhVScFVL4IEWP
         BQARxEg3Kett26poIZ5t8RrrK9HeEWYUpZEtUAwF7vFClL1eGNSl8mOu8K1R1hxLY4H0
         rb9x/ksGWa82HNrf0APRs8Fn9e25NTO4hm4nFjcrkz28WkwjRCKL55ocTNLoTuihWxc0
         rblE2OlUFdE6NdyRLm47FU+PatP9gAV74BaWqfjgRT9zP3lV54G9c539qdv7Dw6Sh/Ms
         FLAA==
X-Forwarded-Encrypted: i=1; AJvYcCUzlad5PgqsFz+LQse3uDxuHaZfddS6Cu5ez8ItA39r+pIjfD89e6Xa8ERe357CUlMgLuwmzAvTvzGU8d8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx+uQFsBFVkeS6+0DXYOHn1zAlK/bSmK//w3dBazFPeG17lmli
	8k7KUGiNS17sw68nAmY0ijBOvQu1oEhuQNbs/gwNGmhcxcFKc2k1pEflO5xDb8CH108=
X-Gm-Gg: ASbGncuJohb/6HNkDpieDgU2rdGQ2mV6buE81paL3m0r7tbttz4aBCTZE0dNlGxF2Lh
	D1W8AdQjw8NH8iYOodyrc9EYLvmofDdEanrkAkIa8UjxSPrLs4ElHSLZDpaV811oek+GkeXKRHa
	/SgOaxEHQavwAK9jwWSEIKyR/YU5u+OfFZ5saFMuVYrUMSUfRLG+a+LhbiC+/ETK9MmNred88i1
	Hk4FnH43/Mpeaah7pwP4lzvt1K0RP1ctzdg4tbZa7T5cOKFHkpYSJtnpTBfh7VA0QzaAXT3LLcv
	ZdCpPxkLskoKHA0YtoOXLj/i4fjdK7KOQndwOCzVJVkHWIwAKtp90Ctj9oLfMR8cggqyAFwTSfm
	7kG6mMKsKCak2c9yEhESOtKQpELQ=
X-Google-Smtp-Source: AGHT+IF9pkrPJ7jZbeEE0PxlWTyARsA424FL3piKfJ4GOT1hGtsLhG5zjtxmcgLX2NPTV/vFIv7f9w==
X-Received: by 2002:a05:6000:2c0b:b0:3b7:9703:d98b with SMTP id ffacd0b85a97d-3b8d95aaff0mr48794f8f.28.1754062388815;
        Fri, 01 Aug 2025 08:33:08 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4696c8sm6121767f8f.55.2025.08.01.08.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 08:33:08 -0700 (PDT)
Date: Fri, 1 Aug 2025 18:33:05 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Konrad Dybcio <konradybcio@kernel.org>, kernel-janitors@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Julia Lawall <julia.lawall@lip6.fr>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH] scsi: ufs: qcom: Drop dead compile guard
Message-ID: <d7093377-a34e-4488-97c6-3d2ffcd13620@suswa.mountain>
References: <20250724-topic-ufs_compile_check-v1-1-5ba9e99dbd52@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724-topic-ufs_compile_check-v1-1-5ba9e99dbd52@oss.qualcomm.com>

This patch removes some dead ifdeffed code because the KConfig has a
select which ensures that CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND is set.
Konrad was wondering if there are any tools to detect this sort of
thing.  I don't think so.  I think the only thing we detect are
non-existant configs.  But let me add a few more people to the CC who
might know.

regards,
dan carpenter

On Thu, Jul 24, 2025 at 02:23:52PM +0200, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> SCSI_UFSHCD already selects DEVFREQ_GOV_SIMPLE_ONDEMAND, drop the
> check.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
> Is this something that could be discovered by our existing static
> checkers?
> ---
>  drivers/ufs/host/ufs-qcom.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index 4bbe4de1679b908c85e6a3d4035fc9dcafcc0d1a..76fc70503a62eb2e747b2d4cd18cc05b6f5526c7 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -1898,7 +1898,6 @@ static int ufs_qcom_device_reset(struct ufs_hba *hba)
>  	return 0;
>  }
>  
> -#if IS_ENABLED(CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND)
>  static void ufs_qcom_config_scaling_param(struct ufs_hba *hba,
>  					struct devfreq_dev_profile *p,
>  					struct devfreq_simple_ondemand_data *d)
> @@ -1910,13 +1909,6 @@ static void ufs_qcom_config_scaling_param(struct ufs_hba *hba,
>  
>  	hba->clk_scaling.suspend_on_no_request = true;
>  }
> -#else
> -static void ufs_qcom_config_scaling_param(struct ufs_hba *hba,
> -		struct devfreq_dev_profile *p,
> -		struct devfreq_simple_ondemand_data *data)
> -{
> -}
> -#endif
>  
>  /* Resources */
>  static const struct ufshcd_res_info ufs_res_info[RES_MAX] = {
> 
> ---
> base-commit: a933d3dc1968fcfb0ab72879ec304b1971ed1b9a
> change-id: 20250724-topic-ufs_compile_check-3378996f4221
> 
> Best regards,
> -- 
> Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

