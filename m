Return-Path: <linux-kernel+bounces-899307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 901F6C5758E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 13:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E52424E5DBC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 12:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7FA34D92E;
	Thu, 13 Nov 2025 12:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CYNF0ml1"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7511034B69C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 12:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763035946; cv=none; b=Gdpr4vK/TZLTWhDGTOaeAG9xGukkpUEznvE7U5SjoABDHaJoEEMod+0p1mmh6h+cvw+TSsmS8iaFnH2RhELGoi4ntx/gvoQupTpzb+YyFvluVzvZ1W73bAFPmH5smORDcxI5tfX0f6M4G4BP2pioffTU9ez2Bu9jq6bwHfx6Iks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763035946; c=relaxed/simple;
	bh=tIRyBtq6ZgmwZ/RdMREj1gR29I0tL8lowm1gb91/zSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=npUItDiiJkjRaHSTVUHIxuHq+yVL6JAFs4qUvx9KNjOnWZ8xSwfPFuWcbfdugRzoaYUoLNjZjCrm5uTsqgwWzSso434GszdnIi9FLVXcqLwsd5JpgE/wL7p6YpMJCwpqSFvvaGg9wMO5IxLJX+BmDdG5lSaMGOPXH739rtdmkDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CYNF0ml1; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-640a3317b89so1205467a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 04:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763035943; x=1763640743; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZmL32TLheuHbN2HDaUa3UG1QnGtlOG9N/Q5N775z6d0=;
        b=CYNF0ml1DpleNUfz+G+2lL9hhJrYQUWslZOJEJWeGWEs6q9d8EhrKwnukmTypyCk5e
         i4oJiVHSZF5EQTq5CLRYHRHr0JctLV6pRJTInSCEO2WrjGW0vTwzBMBooviHxzvuzxRa
         thld1GQu+rf+00Xjt4dEjBuU55mjjMlPj3Ty482vLZ1oUT64CxGKf0t7hCG0h11YOHSC
         COGZYFk5DJMpaepmWN1NjFBEvvCv1BdLXaJJKoWL8cI7AF45m+dgi4z0BlXeEPAw1crt
         YUIZa+v6Wqtt02fy+NoA/fIBp4sR0iyE3ZLdH8kMmKpHzcDcFDOCpL1yuC/fTXyAOqOP
         tJxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763035943; x=1763640743;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZmL32TLheuHbN2HDaUa3UG1QnGtlOG9N/Q5N775z6d0=;
        b=qn0g73ADDDPce6JrtHRs3cOnf9Si4MLC7rg/32Q92ksVkBM/NGJ/ojwm/Tc7GzahGe
         DXZb+5kug/PKQKkKYPDcU2D1h6lS22LNjQuH9QjxmbneLt5YreAbVnitSiyVUN+oR65z
         vRKcFlZXqYkW4DBAhiuCtIyxR7YG8k0z8927Ylvsp0SsVh1tIx/qOWfDNrnoNDyclBpC
         T0x6hdomq3MfSuB0NBsIIfjBNnjS5u6ZpaB4XZsPG1pNYVJpPMJwBrB7kWgGHBy9we9S
         Z1aFsEZ0eUNE2/2ADu+G5OwhWQFcuvciHYcvIr280Sz/CKEkyi1jeDcu5ZuZLoyzAz43
         gxJA==
X-Forwarded-Encrypted: i=1; AJvYcCXwYxdwwSbD47OeQyAR4muqFfPnC2S6Nrh2mwl1lHU/zuy3Ljq7f749q6O42AHzdep0+fkj4UbeQI6MiJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWefXqirIfwBV+nVneW3N3eezOTzC9OiXHFUFw+tnFOzlrz4CG
	yZvc0LsWfaw7CmTmH9gGrM813sgTBWqgTterFPCFmgKxRoyNFzx9Lxu9aV7CMIP6cP4=
X-Gm-Gg: ASbGncvK3UcFqSCMide7lEDYh03FEqEZmytKFjc1Trv8odH7swm5VsYPDmt769tvJn1
	OOiZJ2hyJzsP0fpewXtBFGdaogdY1/pEKfTVSh9Bxd2IXhn67v0QI+4XOaUtp6Mg8OOzdvwLDJv
	sfwyw9q3phY+M5s5SelMuQ+dZWGz/212ZuUvZFuxuVu5Jnsx4D5MBekhOiMXTZK7c12VsyOOuix
	jz2IWO5chTzAZtFnK/0vn+VcJLzA8u/Dw89yS0P1zpCx9MH9ejpYCjm0HTePHH71/KJam6E3B9p
	nZ7OKUbwup7sd2DhzH6ayDcmq42DsPOkV38PKlOoiVN5QnjS0DIIBVb5yXdHgevlvaZw5IcClds
	SXifW91wKSw+NPurjjTVmr37MFHjfDvY82V4cCrxm1MA4vvO2XoxGWiCafGD55e/TQUaYJm9BSA
	O6YIfBJOXV8M29B3iNO8kZfZ4=
X-Google-Smtp-Source: AGHT+IES54zSRW8sTH8TIe84JLMl9O+9k+g7kEG/EMcHoTIpOAkv6hlmsk6iKOP7BgiRYf1ZJ102EA==
X-Received: by 2002:a17:907:6ea6:b0:b72:c103:88db with SMTP id a640c23a62f3a-b7331960ea3mr649017866b.9.1763035942693;
        Thu, 13 Nov 2025 04:12:22 -0800 (PST)
Received: from linaro.org ([2a02:2454:ff23:4430:e68d:9e37:1627:2b9b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fd80d27sm151837166b.40.2025.11.13.04.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 04:12:22 -0800 (PST)
Date: Thu, 13 Nov 2025 13:12:20 +0100
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v7 09/14] firmware: qcom_scm: Simplify
 qcom_scm_pas_init_image()
Message-ID: <aRXLJL632V0ys6rs@linaro.org>
References: <20251113-kvm-rproc-v7-v7-0-df4910b7c20a@oss.qualcomm.com>
 <20251113-kvm-rproc-v7-v7-9-df4910b7c20a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113-kvm-rproc-v7-v7-9-df4910b7c20a@oss.qualcomm.com>

On Thu, Nov 13, 2025 at 04:05:59PM +0530, Mukesh Ojha wrote:
> Simplify qcom_scm_pas_init_image() by making the memory allocation,
> copy and free operations done in a separate function than the actual
> SMC call.

Nitpick: This feels more like "refactoring in preparation of the
following patch" rather than a real simplification.

> 
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> ---
>  drivers/firmware/qcom/qcom_scm.c | 58 +++++++++++++++++++++++-----------------
>  1 file changed, 33 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> index 550707f2b46d..1d8a2c537c44 100644
> --- a/drivers/firmware/qcom/qcom_scm.c
> +++ b/drivers/firmware/qcom/qcom_scm.c
> @@ -590,6 +590,37 @@ void *devm_qcom_scm_pas_context_init(struct device *dev, u32 pas_id, phys_addr_t
>  }
>  EXPORT_SYMBOL_GPL(devm_qcom_scm_pas_context_init);
>  
> +static int __qcom_scm_pas_init_image(u32 pas_id, dma_addr_t mdata_phys, void *metadata,
> +				     size_t size, struct qcom_scm_res *res)

The metadata and size parameters do not seem to be used inside this
function (also not after your follow-up patches), do we need them here?

> +{
> +	struct qcom_scm_desc desc = {
> +		.svc = QCOM_SCM_SVC_PIL,
> +		.cmd = QCOM_SCM_PIL_PAS_INIT_IMAGE,
> +		.arginfo = QCOM_SCM_ARGS(2, QCOM_SCM_VAL, QCOM_SCM_RW),
> +		.args[0] = pas_id,
> +		.owner = ARM_SMCCC_OWNER_SIP,
> +	};
> +	int ret;
> +
> +	ret = qcom_scm_clk_enable();
> +	if (ret)
> +		return ret;
> +
> +	ret = qcom_scm_bw_enable();
> +	if (ret)
> +		goto disable_clk;
> +
> +	desc.args[1] = mdata_phys;
> +
> +	ret = qcom_scm_call(__scm->dev, &desc, res);
> +	qcom_scm_bw_disable();
> +
> +disable_clk:
> +	qcom_scm_clk_disable();
> +
> +	return ret;
> +}

Thanks,
Stephan

