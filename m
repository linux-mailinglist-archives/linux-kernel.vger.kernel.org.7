Return-Path: <linux-kernel+bounces-777215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A72B2D6ED
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 10:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6017D1886013
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 08:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD192D94A8;
	Wed, 20 Aug 2025 08:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mzmhAOh1"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7729E2BE65C
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 08:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755679232; cv=none; b=MrmLFQJLU1nHcHcUCGhyjDkhHFiFII+r+BS6kKdlmfCy7kv7Z8yt4K5m77Dr4095wR39lkGgi3+3Z/x7AhCh21lkUmKNfi9aMKvHYVB6YHrF7wpnfS6fjVooXrBy6swDO+pS/YDQ+hilraeVFa2QLv5Czkyc2zZAVT77y+llJxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755679232; c=relaxed/simple;
	bh=2Bf5pSIDeaXdAnMClIAwjBEtZlm5MH5beZ6hVM9tf1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OIUJVw0fbQ9+Fk3RoyCefkB+e8wg+7SEkkkWwy7ulSeB/XqCkrzLNkjvDJUOoEIcuqaq/3ldZKP3fW4E29PpYw3D5fV6p2vd8CjimjElrn392raseN6aU3gHZdgdDugFFgxCN39s8jTecmvATWuqph294jHn3sIJ2Pq5Ra/jv4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mzmhAOh1; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3b9e41101d4so3305567f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 01:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755679228; x=1756284028; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uDAEpI+NfZxgApYknmtsZIG8RB0U0WX8Cx+vFwuFF1Y=;
        b=mzmhAOh1OZTSIW+yj55LRwhSnj5zBlU0mZaXWQQQ6qtSZhosqNQr3nX9njKQELyB/o
         OwNHlAwN0cv4NoLko2EehhMrAuSZvh+96/r4kBkewwRGOmiRLl807QV0nqrRjX3k3q/+
         KIIOwykItEKnMVsS7k0kb1a4+pZ/jvXQ7k/BvnCvbAjTexVxUKwTMBsyywIqv/MBaxmA
         xmgHOY1T1a22tYuK+IZGmByBAthYXn3KVVP1XIB/y8icDJcdhCHXjjJi9wLgoSLLR6Br
         xA1LWzssreysvY60tBnnBP8y9rOlDgfCzLjqX17u7bB71KPh4TDZsnInOSl8K/BPBgs/
         VwWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755679228; x=1756284028;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uDAEpI+NfZxgApYknmtsZIG8RB0U0WX8Cx+vFwuFF1Y=;
        b=sJLvBIm8nnRXzfZ/N2Eb1VDzgIAs/bUaKGBEnC3JIulqrg+/ES4N27K1CD2se1YKeL
         Zk+vJJYCX3LNj0oq5vE2LMhFiYKjrv40jqLncVNZtc4uoNktJE7rCqo3waxGQEqb3ubc
         LFRpDBEGGtssCSxZumlFCPl0pMtcRGZT742s4IaQs/cVUmkvjDgiB8GL0tLMeDPT2G2e
         J9cw6asbyEwziIwIAxEoYS4x6lb+70Aj4qW7CA1u/k8Fc/UVghzwC75CtUZlcQDmBra1
         PmNE++iJsLVXMIA3zCnjW/UBgv5NswkWlmnrtF9cwzZ60hpvBftXZDA8puMp+GGndCvu
         eiPw==
X-Forwarded-Encrypted: i=1; AJvYcCXrwESCOdi7ahh7ZSTTQu6sRKn6KbNNUz8nhmVM6tuHLCz/7XbATwd5eFMdfzD30Gfy2u9ZMuVF/gsSV9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKEi8aA31JKeHyTmoRJwdsWU4yKuWLtt8APw6zE2SBOwgnIqpy
	+WurXpdCB2fWZpoknNBRyRIfp1lIgDFZaatMIOr5z0/TlyA03nHYSLz3dn3Ik803c20=
X-Gm-Gg: ASbGncse4tgWQXcB1Vongxf+xfnjifEESnCgVO/86Jn2d4ord8BOjB1TGGZz9hrMx2J
	V/reoBqoyc34WSoeU62Ry6dSKsyu+QIzfy/lNOJ5kZut0rCYGNMud6yG4r+EbQxdqjJq/IYanXj
	RAn42IafN1xG30Mlf/8r9kNDpUSPWpzKhVBdxOOoV8LhraVFZqhERtuE18IQwNKrhhJB51Q+6nI
	33nBZEblpxWDf5II8tB++UMyTjXyoMXk4wMnSST/BOdLoCo3XORGoeDliyQPJwMOKOzFoycl8uU
	KDRSXbHj3I+alT0EUp/breNasnEuo4WoUGS0qWW+89z1dscs3w9zfWTQhTwD1aRTu7fMnml+fAt
	+aE5XouvvVr/7BcU4nVVA7ciTnPWKUfGb0euQ7uTLIEHzzA==
X-Google-Smtp-Source: AGHT+IHakuPXJb6UDVHhwXpy7g5RVnX29BC7QeSWaXwaUg59mxu2UH0QUGlOgcXzbq0X2DsjOIEiJA==
X-Received: by 2002:a5d:5f81:0:b0:3b8:d15f:45a2 with SMTP id ffacd0b85a97d-3c32c52bb4dmr1325595f8f.14.1755679227764;
        Wed, 20 Aug 2025 01:40:27 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:ef30:8a2d:c0da:b2f2:1f41])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c0771c1715sm7255505f8f.36.2025.08.20.01.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 01:40:27 -0700 (PDT)
Date: Wed, 20 Aug 2025 10:40:25 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Vikash Garodia <quic_vgarodia@quicinc.com>,
	Dikshita Agarwal <quic_dikshita@quicinc.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-media@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH v2 10/11] remoteproc: qcom: pas: Enable Secure PAS
 support with IOMMU managed by Linux
Message-ID: <aKWJ-c6B5Pvjw_jx@linaro.org>
References: <20250819165447.4149674-1-mukesh.ojha@oss.qualcomm.com>
 <20250819165447.4149674-11-mukesh.ojha@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819165447.4149674-11-mukesh.ojha@oss.qualcomm.com>

On Tue, Aug 19, 2025 at 10:24:45PM +0530, Mukesh Ojha wrote:
> Most Qualcomm platforms feature a proprietary hypervisor (such as Gunyah
> or QHEE), which typically handles IOMMU configuration. This includes
> mapping memory regions and device memory resources for remote processors
> by intercepting qcom_scm_pas_auth_and_reset() calls. These mappings are
> later removed during teardown. Additionally, SHM bridge setup is
> required to enable memory protection for both remoteproc metadata and
> its memory regions.
> 
> When the aforementioned hypervisor is absent, the operating system must
> perform these configurations instead.
> 
> When Linux runs as the hypervisor (at EL2) on a SoC, it will have its
> own device tree overlay file that specifies the firmware stream ID now
> managed by Linux for a particular remote processor. If the iommus
> property is specified in the remoteproc device tree node, it indicates
> that IOMMU configuration must be handled by Linux. In this case, the
> has_iommu flag is set for the remote processor, which ensures that the
> resource table, carveouts, and SHM bridge are properly configured before
> memory is passed to TrustZone for authentication. Otherwise, the
> has_iommu flag remains unset, which is the default behavior.
> 
> Enables Secure PAS support for remote processors when IOMMU configuration
> is managed by Linux.
> 
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> ---
>  drivers/remoteproc/qcom_q6v5_pas.c | 63 +++++++++++++++++++++++++++---
>  1 file changed, 57 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
> index 1e0f09bf1ef2..180528bcd57c 100644
> --- a/drivers/remoteproc/qcom_q6v5_pas.c
> +++ b/drivers/remoteproc/qcom_q6v5_pas.c
> [...]
> @@ -424,7 +459,8 @@ static int qcom_pas_parse_firmware(struct rproc *rproc, const struct firmware *f
>  	if (!rproc->has_iommu)
>  		return ret;
>  
> -	ret = qcom_scm_pas_get_rsc_table(pas->pas_id, NULL, 0, &output_rt, &output_rt_size);
> +	ret = qcom_scm_pas_get_rsc_table(pas->pas_ctx, NULL, 0,
> +					 &output_rt, &output_rt_size);

Unrelated formatting change, should be in previous commit.

>  	if (ret) {
>  		dev_err(pas->dev, "error %d getting resource_table\n", ret);
>  		return ret;
> @@ -726,6 +762,20 @@ static int qcom_pas_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  	}
>  
> +	if (of_property_present(pdev->dev.of_node, "iommus")) {

I think you need a dt-bindings change for this? You had one in v1, but
dropped it entirely for some reason.

> +		struct of_phandle_args args;
> +
> +		ret = of_parse_phandle_with_args(pdev->dev.of_node, "iommus",
> +						 "#iommu-cells", 0, &args);
> +		if (ret < 0)
> +			return ret;
> +
> +		rproc->has_iommu = true;
> +		of_node_put(args.np);
> +	} else {
> +		rproc->has_iommu = false;
> +	}
> +
>  	rproc->auto_boot = desc->auto_boot;
>  	rproc_coredump_set_elf_info(rproc, ELFCLASS32, EM_NONE);
>  
> @@ -800,6 +850,7 @@ static int qcom_pas_probe(struct platform_device *pdev)
>  	if (!pas->dtb_pas_ctx)
>  		goto remove_ssr_sysmon;
>  
> +	pas->pas_ctx->has_iommu = pas->dtb_pas_ctx->has_iommu = rproc->has_iommu;

Nitpick: I think this would look cleaner if you separate it into two
lines (only one assignment on each line).

Thanks,
Stephan

