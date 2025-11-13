Return-Path: <linux-kernel+bounces-899313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A867C575D1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 13:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 092CF4E56D0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 12:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2367134DCDF;
	Thu, 13 Nov 2025 12:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lcuaqM7F"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A216434D4C1
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 12:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763036394; cv=none; b=AhO0HxGdsiXvBtIQzilQMFTblVX8rKOxMpo67tRuRbI/PUypNuZqfi0hpKcK8mVClDa/RGLCDEDMQHFr/qlFpo9WPvGspbpCqcIqiRgwMdafIvnYLFPYVVjIxgUkbt9liffDTGDww0cJ2xrIsgQwSnUX4wOCLSDT4NdtHfYuTMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763036394; c=relaxed/simple;
	bh=hFrCmasW3dJTdQBRMZd6hGI1h3snbWI80Lfv91M7y5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A9C15oVx1P4QY1cf1DON30tQ2nRtGe3bkygIV501yMDvz9AbH4vWfRWzBYeygzuNAlLjDBNT8w2VBW8jPn9DVYdLujtCFV/+6eAcIYhk4ylEckWGeUcdTxPapnBugk/0GKgI/iyRS46BFNV+pks0O1RQJyLTyudqw0wEH0QEpAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lcuaqM7F; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4775895d69cso4188455e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 04:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763036391; x=1763641191; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=duoUSRGaQi6NsgJv/pi2xphHVVy8YVSx2yc+RI8LbNM=;
        b=lcuaqM7FJqIR2jCcmr+onbMPfm33h254BG2NZIL48yjHPaG7uVxl9tGItTF4sC0lV7
         KKpknjevQNwMKL+dmuJM8MNTT2EWsa00yQirXEgwUvMoUyao54q5a4nRCn63dLIzQUwv
         zQeLJVezreN6Xe5cJo2tPt6RG04DrBOmIYgSTuj2DCx7AGjUJQq9FI0ZWmTWDOt02r5s
         yx791dnAi+YIkast4kjoAjFQp3M3vk9OGUNchTLN5RSNnj0SX3Up0L2lR9qbj4FWg7W0
         vWtkS/0Q0xnNVAStOeDBdyX/JEBfYm0UbDLirSpW59TcuXXAUELVHAvjR5bW3yxnJto+
         /3UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763036391; x=1763641191;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=duoUSRGaQi6NsgJv/pi2xphHVVy8YVSx2yc+RI8LbNM=;
        b=PJNY5w6IA4Q2Um01sVXk9DyZgMfoYF1hPnWoyoLyNtBht3q7s/P06vtqu2dJE/UzR8
         lDgZrCpeasDvNpvm8jJmxofEMh1/KHVj687FhQFFpo4/nBqrsZBJxCQY/aQ7Zwr6ruiT
         lsDrFLX1z2ZpDMygrdfUKGq0/URZD59fpoXHCOt2Ky/QSGQjR7mba7rnEoN233YVovPM
         LaOMxDbLH5r5eHvRY7Rai9h/sp/SmGuk5XBSi/xg5obmWE6YT8MW91R25kZwHofvd+B9
         xH54+w0QMz8oliZQegbdgagoTgtUQxaaYvsZw3+b/459rLddqdNKnfF83gl2aRz9JNu+
         il6A==
X-Forwarded-Encrypted: i=1; AJvYcCWgT57DVSJ9P/mhdW8yJdt+WEXyCSDQoOS21e34Uo2Ho9p1+bvTjDVfe6Y7p9cHuTnlVd6oeV1LMAXeNYw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmjx42WvcnsGn1ChAvDtoTI5KKAbj3Jaj79k3wnAIEkaJ0AFDD
	HcFvXvzsrOT8SV0I4c1OLg5w0BTx+dbJ1gr7hApxbtQyyB9LZEUCYnl875DwHCswu0o=
X-Gm-Gg: ASbGncu9AOHtotvM9YhwDaB8tLVhf+zeQAePEc86lmZmAkXOYBWfUAbiYgGqJFRyWY3
	ACy0b7YrT6ABfRptcw14q1836tuWOcLeeyklkKupAM9qibQ5+KmStPKHoQd0QHMOD2D8KZp0Wv1
	nuohMT1g4BpxwTJG/mIcO3B091nWyFxdTFFEBukESBcvz56AUleFoop4CunKWbwvOyHpPgtffUh
	XPz0IwAq13I6I/0t3wNZKhGMppUaG1EqXs5ke7tox7oPWZZl6kPi2zRpq3iKUJ4jmCuFQTaKY6I
	P84fZvCqUYXcauZCFrb07vcVLt9IMjoI2V3+E8kvOlh7IRZJ596kh6nWWYDqtFdBurpT1b/teBi
	uuIiKlhltMMrEjSp8jRtngs7DBDclaaNeGefiaMLNbma3fFnquQK0TX4/BPTo8Lu7nQUmbymJ0V
	5SiKjdCALjH662
X-Google-Smtp-Source: AGHT+IH8T4ZyL5HYmAGvNL/oZLRRXU8OO4RxTJEHDGnN0oDjnzobpXuL2pV25qu0GlPmyxzXDorawg==
X-Received: by 2002:a05:600c:19c7:b0:477:7bca:8b3c with SMTP id 5b1f17b1804b1-477870c5352mr61064035e9.19.1763036390818;
        Thu, 13 Nov 2025 04:19:50 -0800 (PST)
Received: from linaro.org ([2a02:2454:ff23:4430:e68d:9e37:1627:2b9b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f19664sm3679227f8f.36.2025.11.13.04.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 04:19:50 -0800 (PST)
Date: Thu, 13 Nov 2025 13:19:48 +0100
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
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 12/14] remoteproc: pas: Extend parse_fw callback to
 fetch resources via SMC call
Message-ID: <aRXM5OfxYTt2a8yj@linaro.org>
References: <20251113-kvm-rproc-v7-v7-0-df4910b7c20a@oss.qualcomm.com>
 <20251113-kvm-rproc-v7-v7-12-df4910b7c20a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113-kvm-rproc-v7-v7-12-df4910b7c20a@oss.qualcomm.com>

On Thu, Nov 13, 2025 at 04:06:02PM +0530, Mukesh Ojha wrote:
> Qualcomm remote processor may rely on static and dynamic resources for
> it to be functional. For most of the Qualcomm SoCs, when run with Gunyah
> or older QHEE hypervisor, all the resources whether it is static or
> dynamic, is managed by the hypervisor. Dynamic resources if it is
> present for a remote processor will always be coming from secure world
> via SMC call while static resources may be present in remote processor
> firmware binary or it may be coming from SMC call along with dynamic
> resources.
> 
> Remoteproc already has method like rproc_elf_load_rsc_table() to check
> firmware binary has resources or not and if it is not having then we
> pass NULL and zero as input resource table and its size argument
> respectively to qcom_scm_pas_get_rsc_table() and while it has resource
> present then it should pass the present resources to Trustzone(TZ) so that
> it could authenticate the present resources and append dynamic resource
> to return in output_rt argument along with authenticated resources.
> 
> Extend parse_fw callback to include SMC call to get resources from
> Trustzone and to leverage resource table parsing and mapping and
> unmapping code from the remoteproc framework.
> 
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> ---
>  drivers/remoteproc/qcom_q6v5_pas.c | 60 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 58 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
> index 9feee2cb1883..4d00837db58d 100644
> --- a/drivers/remoteproc/qcom_q6v5_pas.c
> +++ b/drivers/remoteproc/qcom_q6v5_pas.c
> [...]
> @@ -413,6 +414,61 @@ static void *qcom_pas_da_to_va(struct rproc *rproc, u64 da, size_t len, bool *is
>  	return pas->mem_region + offset;
>  }
>  
> +static int qcom_pas_parse_firmware(struct rproc *rproc, const struct firmware *fw)
> +{
> +	size_t output_rt_size = MAX_RSCTABLE_SIZE;
> +	struct qcom_pas *pas = rproc->priv;
> +	struct resource_table *table = NULL;
> +	void *output_rt;
> +	size_t table_sz;
> +	int ret;
> +
> +	ret = qcom_register_dump_segments(rproc, fw);
> +	if (ret) {
> +		dev_err(pas->dev, "Error in registering dump segments\n");
> +		return ret;
> +	}
> +
> +	if (!rproc->has_iommu)
> +		return ret;

Just do "return 0;" please, you know already that it is 0.

> +
> +	ret = rproc_elf_load_rsc_table(rproc, fw);
> +	if (ret)
> +		dev_info(&rproc->dev, "Error in loading resource table from firmware\n");

This is odd, you log an "error" as dev_info(), so is it an error or not?
If it is expected that firmware images may not have the resource table
in the ELF, you should probably just silently ignore this error (or use
dev_dbg()).

Thanks,
Stephan

