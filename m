Return-Path: <linux-kernel+bounces-874355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A1EC16202
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 18:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7439C3ADB41
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553993491F2;
	Tue, 28 Oct 2025 17:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rW1MW/YY"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3F423C505
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 17:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761672019; cv=none; b=HzbSWkSAIusPzBzu678+Fps/xNArqWzOPYOLLcvaS1lm2/l3SrrPtsXfJ2f+Rhcy0LImNusxFugnPuJqSsZervZhmQNavys3cnNAi5U7ow99Cr7OI8BSJIZG6fvACGu1blqHriPJyPZkw4PBSjgP0Yzrosqjz4fLPA2L+XOQDJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761672019; c=relaxed/simple;
	bh=ne+oS5H6z7JHWav73oVglAywE3vtySrxSDIgfblNIW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PTmM2zP9o+0OiSl44bRSP67fetvWikgPfoj48rCrqciprsfuyNHbWfb0QfR4cFvtVE/dIPGFAWS42f1gXEMNMPF2Yom28Mpn92c5ChMM+uFdwP9w/WS46R/0j57SlfUoZ7fJ9fe/8Zjwnc+tlnA8zcyRoDYQtGrU1BSIiMaw+l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rW1MW/YY; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-426f1574a14so4111343f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761672016; x=1762276816; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uFNR+yqQDNKQ0KUWuXjjm3zqWjAn6Hk7JWkoBuP7tog=;
        b=rW1MW/YYiUVs7KqNWW5S/wzwzAjVgMFN72mwu1dgDqGdZjwXhMNiqXeP/EmrrhJHvx
         ln1GVWiGYgqr0QGP/M0sS/cSneBYSd+Gu23MEM5bPZmG+YSiZvv4SU84un9Q9fE5pICB
         QCp5d3CZ6C6wdRdm8tOhQBjjD0raXvWio7Crl9gyRzuYVMoPaXeHskjP25K0SJ/jQwI6
         R38AQwmt59slAd3ge7LO1B023I0INudwQGHxSgMtMOv+qlazbsvM1s+VMRSiATZTf5eP
         Xix123DVpvLOdf/3y2pB8Zpf1Yds11RgsTxu3ta5HbKR0ZvX2z/gAfl3ECrcSKO1iZan
         7hww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761672016; x=1762276816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uFNR+yqQDNKQ0KUWuXjjm3zqWjAn6Hk7JWkoBuP7tog=;
        b=GNJzcXzz/p03Ds2kbB3I5LAMZyofP7IPSELCFg8d6AGNPoyDEHxohQP3wKxQdHqZ2L
         2jc/yqCK/N5Qa++wu4MzTWqPPTQTCFV3tZEGlNNiCmHVENWXKzeue/ydhyPaVg52+/F6
         l1TQFngm0s5XZnhksgnLyOh5qVo7f9RLX5zXsEuRzdgsmrHG2kWnWuIFA0yj7ZfX+C4b
         Z0YoCC/g7q+bSRI6VX49m6hiB+SBxYenXYT3otaCDYK8Ui/tyxBmBUkcXlUHIpj9gWgb
         ldVIjUmZ4j+pSPD3li45jt3NEBGdsgZcWwDrflTX+0zHmM6JGK3w6YkGPZyMJ3kYmD3D
         rs0A==
X-Forwarded-Encrypted: i=1; AJvYcCVukKcRco4+Snv4xDHGFZQq/YZ2L8XNs5k7/KN4e3wHft2zpbMjZHU7HtJLlLMs1Ba3N3qHaRSE7C13K9k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi3RvlzRzRD4ScXd2RXvSJ/j5JzapncWy4VK64lIS6IEOo8wQl
	6X8xMw4trrs+Qjuf12hCaBZ1yCkpo1vxzHXPxlZYU9l4hmtNot4nPMcEzl0mhgaVyGmNxdrKLfy
	1Pyg3
X-Gm-Gg: ASbGncs5Li1tAvrzeatAeYVa2fw6xviEO4/O72ZIEgl+1GB4MmXBzstjccZOIu1kmpp
	5pecdT5Z8EO9ZtuMmTgmhTT+GVKdFF03tZEAd+KV96h2mylvkwim01goBRh59gWkOI2x57AH79S
	5NBlq7zxp4jMCgLF7wTGh9X2RbohcyX0pZB9+PzEhgR5hYpW3apuZ4iiU9zVZEw3Vum/AtA0KYZ
	t6h+dH6eeWNRTuAxUcv19UGAiu4pirGrjgX7x/HSPEUitg86yNrrsgFAtLcJYdWsdG4aw0kLr+2
	kmynMNLVg3adjVTvIFbdImRzrUydyJZ1Z/oCOiHQ92JcuWe71FUPjJPz7fZHNjT2QsS/Mn/grCw
	MwMat4RCXN4xN4r5NDIlAcA+/baq6wUsfdiAqkN/zPPrL6do5lZva8qNxy/VNxhW85N5eTB14
X-Google-Smtp-Source: AGHT+IHcdJ1fq9ADGcrcW4ZZKZhaA9eWlkrpV7+uDO6SDMKBeox7ZwKnGdmhFMB9LLUGwuioqWc7tw==
X-Received: by 2002:a05:6000:2c05:b0:428:4354:aa36 with SMTP id ffacd0b85a97d-429a7e919f2mr3775348f8f.58.1761672015770;
        Tue, 28 Oct 2025 10:20:15 -0700 (PDT)
Received: from linaro.org ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952db99asm21844711f8f.32.2025.10.28.10.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 10:20:14 -0700 (PDT)
Date: Tue, 28 Oct 2025 19:20:13 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] soc: qcom: pmic_glink: Add charger PDR service
 path and service name to client data
Message-ID: <5uyhz4uv7ccsj7cevimqrsoywne6f5ax5j2t4uosz6a7due4ac@3x4ouutt5nwy>
References: <20251027212250.3847537-1-anjelique.melendez@oss.qualcomm.com>
 <20251027212250.3847537-3-anjelique.melendez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027212250.3847537-3-anjelique.melendez@oss.qualcomm.com>

On 25-10-27 14:22:50, Anjelique Melendez wrote:
> Currently, the charger PD service path and service name are hard coded
> however these paths are not guaranteed to be the same between PMICs. For
> example, on Kaanapali and Glymur, Charger FW runs on SOCCP(another subsystem)
> which does not have any specific charger PDs defined.
> 
> Define charger PDR service path and service name as client data so that
> each PMIC generation can properly define these paths.
> 
> While at it, add the qcom,kaanapali-pmic-glink and
> qcom,glymur-pmic-glink compatible strings.
> 
> Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
> ---
>  drivers/soc/qcom/pmic_glink.c | 66 ++++++++++++++++++++++-------------
>  1 file changed, 42 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/soc/qcom/pmic_glink.c b/drivers/soc/qcom/pmic_glink.c
> index c0a4be5df926..aa5ba9a0285e 100644
> --- a/drivers/soc/qcom/pmic_glink.c
> +++ b/drivers/soc/qcom/pmic_glink.c
> @@ -23,13 +23,19 @@ enum {
>  	PMIC_GLINK_CLIENT_UCSI,
>  };
>  
> +struct pmic_glink_data {
> +	unsigned long	client_mask;
> +	char		*charger_pdr_service_name;
> +	char		*charger_pdr_service_path;
> +};
> +
>  struct pmic_glink {
>  	struct device *dev;
>  	struct pdr_handle *pdr;
>  
>  	struct rpmsg_endpoint *ept;
>  
> -	unsigned long client_mask;
> +	const struct pmic_glink_data *data;
>  
>  	struct auxiliary_device altmode_aux;
>  	struct auxiliary_device ps_aux;
> @@ -285,7 +291,6 @@ static struct rpmsg_driver pmic_glink_rpmsg_driver = {
>  
>  static int pmic_glink_probe(struct platform_device *pdev)
>  {
> -	const unsigned long *match_data;
>  	struct pdr_service *service;
>  	struct pmic_glink *pg;
>  	int ret;
> @@ -302,12 +307,10 @@ static int pmic_glink_probe(struct platform_device *pdev)
>  	spin_lock_init(&pg->client_lock);
>  	mutex_init(&pg->state_lock);
>  
> -	match_data = (unsigned long *)of_device_get_match_data(&pdev->dev);
> -	if (!match_data)
> +	pg->data = of_device_get_match_data(&pdev->dev);
> +	if (!pg->data)
>  		return -EINVAL;
>  
> -	pg->client_mask = *match_data;
> -
>  	pg->pdr = pdr_handle_alloc(pmic_glink_pdr_callback, pg);
>  	if (IS_ERR(pg->pdr)) {
>  		ret = dev_err_probe(&pdev->dev, PTR_ERR(pg->pdr),
> @@ -315,27 +318,30 @@ static int pmic_glink_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	if (pg->client_mask & BIT(PMIC_GLINK_CLIENT_UCSI)) {
> +	if (pg->data->client_mask & BIT(PMIC_GLINK_CLIENT_UCSI)) {
>  		ret = pmic_glink_add_aux_device(pg, &pg->ucsi_aux, "ucsi");
>  		if (ret)
>  			goto out_release_pdr_handle;
>  	}
> -	if (pg->client_mask & BIT(PMIC_GLINK_CLIENT_ALTMODE)) {
> +	if (pg->data->client_mask & BIT(PMIC_GLINK_CLIENT_ALTMODE)) {
>  		ret = pmic_glink_add_aux_device(pg, &pg->altmode_aux, "altmode");
>  		if (ret)
>  			goto out_release_ucsi_aux;
>  	}
> -	if (pg->client_mask & BIT(PMIC_GLINK_CLIENT_BATT)) {
> +	if (pg->data->client_mask & BIT(PMIC_GLINK_CLIENT_BATT)) {
>  		ret = pmic_glink_add_aux_device(pg, &pg->ps_aux, "power-supply");
>  		if (ret)
>  			goto out_release_altmode_aux;
>  	}
>  
> -	service = pdr_add_lookup(pg->pdr, "tms/servreg", "msm/adsp/charger_pd");
> -	if (IS_ERR(service)) {
> -		ret = dev_err_probe(&pdev->dev, PTR_ERR(service),
> -				    "failed adding pdr lookup for charger_pd\n");
> -		goto out_release_aux_devices;
> +	if (pg->data->charger_pdr_service_name && pg->data->charger_pdr_service_path) {
> +		service = pdr_add_lookup(pg->pdr, pg->data->charger_pdr_service_name,
> +					 pg->data->charger_pdr_service_path);
> +		if (IS_ERR(service)) {
> +			ret = dev_err_probe(&pdev->dev, PTR_ERR(service),
> +					    "failed adding pdr lookup for charger_pd\n");
> +			goto out_release_aux_devices;
> +		}
>  	}

But this does nothing on Kaanapali and Glymur. Am I wrong?

Yes, you do not have a charger PD on Glymur, but you do have an ssr,
for which you do need to register a notifier instead.

You need to be doing something like this:
https://gitlab.com/Linaro/arm64-laptops/linux/-/commit/2cd84e303d263d8fd5de3730714a16c29cc6788b

