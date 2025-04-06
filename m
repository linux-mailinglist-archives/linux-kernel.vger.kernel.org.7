Return-Path: <linux-kernel+bounces-590169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC02A7CFB4
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Apr 2025 20:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32137188DA41
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Apr 2025 18:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20559191461;
	Sun,  6 Apr 2025 18:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TOu04ogp"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A711F482F2
	for <linux-kernel@vger.kernel.org>; Sun,  6 Apr 2025 18:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743964527; cv=none; b=cjpJjXtHPGrCr7A9gOzhleo9HqC36RNHJcj9vbPKqHwVxEc7gbKpN3zW8gZnpKxAtItsUkem/GD+U/Ln5KiE8f9ek1O9pyYX6jJ5ETrk7eT0LfISGZNnsDe7zYoc3R1Uk0CtnRGpz1SVqMdFku97SgqsaUS0z8oiVNjdtkqkLBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743964527; c=relaxed/simple;
	bh=xVF3x3UkSJDIxlowMV/5yJWg5CVdZ5Rp/WZSsw2+4XY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i3gytJJPYO9J+wx4C0NdrN/FD5jZx/JolBZ/WvobTn7xmx0OiBbz4SCXWiiQYv/cemem0s+3XMib47JNISbf8PMD2z8g9DjNA1mqNaYQ4fTYD9aalow7H9NqNnaoFQTwxpvDQaGJueykQgySTBxAa+BJSg+RdTRybMAKhZ/iINY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TOu04ogp; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-aee773df955so2868003a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Apr 2025 11:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743964525; x=1744569325; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JG00idBbiuZzkIUnOfUDwBMjIfIGhLtfrBRZuXQ2YbM=;
        b=TOu04ogpGZucH3zRsGvcLUQQKn4G3sZlm3cBv1EG4svsZ6PY0UvU0LO5MXWC86erHM
         FqU/3lurbBpSPOtzSGUw/2duANc2J+UCVh+gIcYqcjNFqTy1K8Uk1kHVNYmstVfGic/P
         OoFCM+s3vPXSKbtyH8yBb+Osw1ylR/iFzA8OaxceQTNnNTg5hftYQnHymuxcFRkuohrN
         C4n5lbTrMjcbu1/R71Pk5GSdexzfLT7VzZz0QvsXEoFFz+Dv6v7NGsuCoNwvNIy3lKPf
         XoTdK4BhOAZ6u83mjFCVD05fuemh5jrNHgX15cwvRzLA+W1KvXa/3xQATdGyf3ng5p4V
         MwkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743964525; x=1744569325;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JG00idBbiuZzkIUnOfUDwBMjIfIGhLtfrBRZuXQ2YbM=;
        b=AqOYt/x1tFr0pTkixvYskRwtV8fIuhoz9g1K8MhPuxGLb3YT4HowFuyS/ogPZ7c4rh
         dTJ1Mqz81jBu0Rv/Q0cFnsEG2zqv9nQ9IAVVRk4E9ipl9cv9aRhG+QKKwLfqFoZf4CBj
         ET0bCMgddcZcOvfybQF9FszGRh/OIwRrYIyFhzgD7WqBtch54Jmh+xUer21MxBpVUbJG
         aIHtcftViYvJsVPMIdHjjXcwI74AngPavmCH2hoADEoaRd0G3g18XXUHx/cboIe4PhXP
         SetP6VK2jb6eyfB2VoNgGrwOTKx7ZAyLxdHNlIJK+SjOUxzBei0dwt+ngX+n4dXpyAP/
         //cw==
X-Forwarded-Encrypted: i=1; AJvYcCUE/GJcScgeyO8AvxK656paacrm+25vDtCr/zXnZq/+UyRDWfK9shvMgZVBTRR8yVCETe/kQaj2JsyQUO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYN3RfVUVySCdj9dOzH4kp9BmYxZu+ub83UT9GhvxAGX+9kwIZ
	3WRcBSk8KPIAqBXKUNm+MOrM0TknWQAAQyLtQBzzsJ42ThI/M0Rg98icnMrjdw==
X-Gm-Gg: ASbGncsdJd8OBtpAee4OlVvvHNXXejMnpKqma32RZLMz38HEx15MW7Vspsp8zQ/IDY8
	3O06xetJUIzL1FTNgBGl+2Wl+yBSSqnJsIglxLAAqO+P1MNvH0HigpJm/EKZripoLUC38HWL023
	2xmKXknNRrslbrHS190K2u5BG5FrEjov+K9Z3KryHgkiNUNYrW7tr4FkFSc8DQAGUlGOde3mMGg
	th6mQB/aRcdfjcs4tk9PUS6w71qS2NUzNVPjnCX41m7cY2ot8N9jPRgf6Cx8yX/HXErzYuB45Ib
	BddvlQH8FjgAapUtpNniJU36pnFehVWv3aK/VgVAOseCCZRcOd+4fiY=
X-Google-Smtp-Source: AGHT+IGOGFfSBcmfodUPLiDGYIY4DGC8r1k7PhYjbfzDdhTnlzgvWrXr4fTTmrOrq1dg8IG68Osutg==
X-Received: by 2002:a17:902:d482:b0:223:4d5e:76a6 with SMTP id d9443c01a7336-22a89a241d6mr131992235ad.1.1743964524915;
        Sun, 06 Apr 2025 11:35:24 -0700 (PDT)
Received: from thinkpad ([120.60.71.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2297866080csm66260455ad.125.2025.04.06.11.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Apr 2025 11:35:24 -0700 (PDT)
Date: Mon, 7 Apr 2025 00:05:19 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Manish Pandey <quic_mapa@quicinc.com>
Cc: "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Avri Altman <avri.altman@wdc.com>, Bart Van Assche <bvanassche@acm.org>, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, quic_nitirawa@quicinc.com, 
	quic_bhaskarv@quicinc.com, quic_rampraka@quicinc.com, quic_cang@quicinc.com, 
	quic_nguyenb@quicinc.com
Subject: Re: [PATCH V2 2/2] scsi: ufs: introduce quirk to extend
 PA_HIBERN8TIME for UFS devices
Message-ID: <hcguawgzuqgi2cyw3nf7uiilahjsvrm37f6zgfqlnfkck3jatv@xgaca3zgts2u>
References: <20250404174539.28707-1-quic_mapa@quicinc.com>
 <20250404174539.28707-3-quic_mapa@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250404174539.28707-3-quic_mapa@quicinc.com>

On Fri, Apr 04, 2025 at 11:15:39PM +0530, Manish Pandey wrote:
> Some UFS devices need additional time in hibern8 mode before exiting,
> beyond the negotiated handshaking phase between the host and device.
> Introduce a quirk to increase the PA_HIBERN8TIME parameter by 100 µs
> to ensure proper hibernation process.
> 

This commit message didn't mention the UFS device for which this quirk is being
applied.

> Signed-off-by: Manish Pandey <quic_mapa@quicinc.com>
> ---
>  drivers/ufs/core/ufshcd.c | 31 +++++++++++++++++++++++++++++++
>  include/ufs/ufs_quirks.h  |  6 ++++++
>  2 files changed, 37 insertions(+)
> 
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index 464f13da259a..2b8203fe7b8c 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -278,6 +278,7 @@ static const struct ufs_dev_quirk ufs_fixups[] = {
>  	  .model = UFS_ANY_MODEL,
>  	  .quirk = UFS_DEVICE_QUIRK_DELAY_BEFORE_LPM |
>  		   UFS_DEVICE_QUIRK_HOST_PA_TACTIVATE |
> +		   UFS_DEVICE_QUIRK_PA_HIBER8TIME |
>  		   UFS_DEVICE_QUIRK_RECOVERY_FROM_DL_NAC_ERRORS },
>  	{ .wmanufacturerid = UFS_VENDOR_SKHYNIX,
>  	  .model = UFS_ANY_MODEL,
> @@ -8384,6 +8385,33 @@ static int ufshcd_quirk_tune_host_pa_tactivate(struct ufs_hba *hba)
>  	return ret;
>  }
>  
> +/**
> + * ufshcd_quirk_override_pa_h8time - Ensures proper adjustment of PA_HIBERN8TIME.
> + * @hba: per-adapter instance
> + *
> + * Some UFS devices require specific adjustments to the PA_HIBERN8TIME parameter
> + * to ensure proper hibernation timing. This function retrieves the current
> + * PA_HIBERN8TIME value and increments it by 100us.
> + */
> +static void ufshcd_quirk_override_pa_h8time(struct ufs_hba *hba)
> +{
> +	u32 pa_h8time = 0;

Why do you need to initialize it?

> +	int ret;
> +
> +	ret = ufshcd_dme_get(hba, UIC_ARG_MIB(PA_HIBERN8TIME),
> +			&pa_h8time);
> +	if (ret) {
> +		dev_err(hba->dev, "Failed to get PA_HIBERN8TIME: %d\n", ret);
> +		return;
> +	}
> +
> +	/* Increment by 1 to increase hibernation time by 100 µs */

From where the value of 100us adjustment is coming from?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

