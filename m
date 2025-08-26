Return-Path: <linux-kernel+bounces-787014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC382B37033
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 18:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72C0C685493
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 16:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D783730AD03;
	Tue, 26 Aug 2025 16:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dk+dGJuE"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7FB30BBA9
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 16:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756225558; cv=none; b=LlfIgpwS7mHz4p/FHqQCoOpHB3WnbeymcLmI5j1w6uJRynKc9M/4vpTFR2O7Y4SkyNvQ5T8IdbO3o5jWudZWS3pOqJBk41vf+zaME9PDXoYpltEkrnriF6t+KWT9l1P2vj2jRFfdix1+rpIUEqL0WW6e9A9cfmMkguDbfDG5ans=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756225558; c=relaxed/simple;
	bh=SYh53dVtYG9K4Of7ZCRYMDHV+DaFEJ2DHVa9wCHEwDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LAstVK0k1BnQWLgf8s0wxE+G0iaELdrSKQKa8BbOXzAm8l/8vm7Dh3PJwf9xB+DGNGKrP7Wory18JnXmKOnVLrrARpNLsc/gSpp+G8F0u1Km93mqslYBZlbCsq1S2Rt0zc/yeDG5Q82odUteZVMJnIMfEM6MRY8sfVzbuKUaQ+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dk+dGJuE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QGPnY6002835
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 16:25:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=QjWGz3gqfdEf7rQ/ErbYkH19
	pbV61YQqgtpTaicc8y8=; b=dk+dGJuEek8mhgwkbNDTcs4IWQzw0Ct1OMR/t7Jk
	upEJL20tVR6RR7ySNiKgDoTS7KN1RFFAj4kNkDBv+7xzfw6FAClojX/nFPWIJocj
	Lj/W90o9VA0H8VWEoKoA7QhqGD7W1OQWEhhNic07sTUX3rah8kd/9+80238CUI2O
	X7xjoTa7hQuNNWoxQRfNpXPvBH56hNISOFIHmGbu+662K8VbCyw8yQSrBklgOYfp
	qY4NS9G7d39lO3+sBIp8WxAeZyZUbDjXzEk/I5BWXonF7yPw4ZBvZAAtv8EUMC9e
	LNvMGwoV98uwgwBN89zPl+/ujbM4tY7ouRzQUs2XlAEtxA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48rtpeuyn4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 16:25:54 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70dd6d25992so13872586d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 09:25:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756225554; x=1756830354;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QjWGz3gqfdEf7rQ/ErbYkH19pbV61YQqgtpTaicc8y8=;
        b=Rt8Fc4hjUIsuOqeo7vdO5+EnFwDibQ4aOmewrUo2Z9MVQUkKahcBX7olN0+9jae2Im
         bPXh1wwnUlRtwdN+KXCbpic88FTQavZs2kRiajcK5xLXm+9SAZnP2ERVEdQC5fXwlDWb
         eWp8ygsNXiNOLdlFBiKL7nY0NgGJgUvF1tbunlCAgD9qY1tzwqupxsJ3d92b30u5cvoD
         N1vi0f06PVS8GGYRdgkhqRMl2IKu/ikAJcgX/3fcWsU5pouwyYS9Rpr9X/tH5tJTfDWC
         c4D9ejz+mBndHUXWNE8PvXwNwTT0aCJTNlkxYvOPQaJTdiOTpdIHY6zwZSGaB0Y0rywu
         olng==
X-Forwarded-Encrypted: i=1; AJvYcCX73slt1fg6niC76nopa1/tJLL361W3xCXeGO+Kmyn0E8VXKhtzlKxuxGw56Hx2nld+P0faD7KwgBGK29k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLrP8K+D+3cMrYLL8VuWlOKLYqAW7QqbE4L2Z3rjqMa/1MdvCx
	qdNMeAhsU81y7qwUILY2wX4YhmBk/Y3T3MYotdTVyMV135mB7O5gnR9ASN2MlIm9umBQ50sZtlB
	Dim9BWzqfoVwy8A8Sjs6lnyJeg/s2RKwxhTg6F+EQeYZ2GyiT2wZqMuvbLMfbYiWsTCY=
X-Gm-Gg: ASbGncuyB9WRxliykCXZS0sxx80Yp5Nr+8VBJFqD6/ZKOH6Au4Ct+lyjclmdyp7w8nv
	EARy0q+LCjvoj+4O4mWUqCNbAqL/nhFNclmbrdJs1ao5xilSgS8QgAGL5wfs3TFJXBAXqXAISyB
	fgJoVMKXhpFAti4rWa9XhBj0bMlv6p9olX8Hlp3WNv9zWDpuySGMZU+WpqIr6utiBvzx0iysjxO
	3vYiGdmaKv/BqiQetDIqtFf8koRWpSmaxLAIKl73N+pOT8E+PQOmbcG4TvMgVPqw7yaBzYugMzB
	5fZANBk2aqkEj3s+qQBf2wG7ODAGHIuWUvoq5a4Z0JqA8qJjkSTJsbhoTESdVLzeLIF0HfjJzM/
	xZUmEmdtFKs85jz2+1nz9AFyhXggjzBslg47mzdz8FMJNHGLNq9Wc
X-Received: by 2002:a05:6214:3f8d:b0:70d:abda:8cb4 with SMTP id 6a1803df08f44-70dabda8d9dmr121204566d6.8.1756225553984;
        Tue, 26 Aug 2025 09:25:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhmABYBqR/v3FHfpEMGPI2QYEd21GJK9nTUSAzXbFrYGClG91shUzppACFckO0y2VhcbKqbw==
X-Received: by 2002:a05:6214:3f8d:b0:70d:abda:8cb4 with SMTP id 6a1803df08f44-70dabda8d9dmr121204126d6.8.1756225553158;
        Tue, 26 Aug 2025 09:25:53 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f35c022ffsm2331133e87.1.2025.08.26.09.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 09:25:52 -0700 (PDT)
Date: Tue, 26 Aug 2025 19:25:50 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: quic_utiwari@quicinc.com
Cc: herbert@gondor.apana.org.au, thara.gopinath@gmail.com, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_neersoni@quicinc.com,
        quic_kuldsing@quicinc.com, quic_gaurkash@quicinc.com
Subject: Re: [PATCH v2] crypto: qce - Add runtime PM and interconnect
 bandwidth scaling support
Message-ID: <2s4ckgz2jhmlad3cm3zzvnzkyl6usgsrbhzosou5eso6pov4dd@zvszprtnipoy>
References: <20250826110917.3383061-1-quic_utiwari@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826110917.3383061-1-quic_utiwari@quicinc.com>
X-Proofpoint-GUID: BpsqkT7tZn8caYd0onDj8_AKHeiZjNfY
X-Proofpoint-ORIG-GUID: BpsqkT7tZn8caYd0onDj8_AKHeiZjNfY
X-Authority-Analysis: v=2.4 cv=Hd8UTjE8 c=1 sm=1 tr=0 ts=68ade012 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=SfFjP_lyd6Op3cYmAakA:9
 a=CjuIK1q_8ugA:10 a=pJ04lnu7RYOZP9TFuWaZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI1MDE0MiBTYWx0ZWRfX+VXQTu0AhLj9
 zkmi4BgVAIWhjHjdeCYolPMK6NF6sbeUbrZRahZvbxWDgf33eq+bycuLWpbgCUdEaMtVbYgYwdA
 PwWU9A5E99qShk1zik7Px5Pq1XWI2rSxn81VkDcAvBQX24BxOXV+vvVRGJ5vuyoDZN1zGLLpBRP
 VFqNtJymcKcz4VJoH3cskcfAyeJDnFL31l8Jh01bDr2c8FonG2jLukfwfRtl7lCVZQs0xep9XdG
 Ol6H0Jzjg5Te+OcihM7qzv6APSp/wI0mB4uaes7JNqijkjW64GCA8AjoEEdvJAeaAVflmvFd7UA
 fPI/TrC+IXSLKWwGqCQ4bnlxWGTrNin8iAJmrfTQ6HjCpocwlJkzIzPEr7tBHASfIp06uNZ2Hmd
 2V9hDzdE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508250142

On Tue, Aug 26, 2025 at 04:39:17PM +0530, quic_utiwari@quicinc.com wrote:
> From: Udit Tiwari <quic_utiwari@quicinc.com>
> 
> The Qualcomm Crypto Engine (QCE) driver currently lacks support for
> runtime power management (PM) and interconnect bandwidth control.
> As a result, the hardware remains fully powered and clocks stay
> enabled even when the device is idle. Additionally, static
> interconnect bandwidth votes are held indefinitely, preventing the
> system from reclaiming unused bandwidth.
> 
> Address this by enabling runtime PM and dynamic interconnect
> bandwidth scaling to allow the system to suspend the device when idle
> and scale interconnect usage based on actual demand. Improve overall
> system efficiency by reducing power usage and optimizing interconnect
> resource allocation.
> 
> Make the following changes as part of this integration:
> 
> - Add support for pm_runtime APIs to manage device power state
>   transitions.
> - Implement runtime_suspend() and runtime_resume() callbacks to gate
>   clocks and vote for interconnect bandwidth only when needed.
> - Replace devm_clk_get_optional_enabled() with
>   devm_clk_get_optional() and move clock enabling to the resume path.
> - Register dev_pm_ops with the platform driver to hook into the PM
>   framework.
> 
> Tested:
> 
> - Verify that ICC votes drop to zero after probe and upon request
>   completion.
> - Confirm that runtime PM usage count increments during active
>   requests and decrements afterward.
> - Observe that the device correctly enters the suspended state when
>   idle.
> 
> Signed-off-by: Udit Tiwari <quic_utiwari@quicinc.com>
> ---
> Changes in v2:
> - Extend suspend/resume support to include runtime PM and ICC scaling.
> - Register dev_pm_ops and implement runtime_suspend/resume callbacks.
> - Link to v1: https://lore.kernel.org/lkml/20250606105808.2119280-1-quic_utiwari@quicinc.com/
> ---
>  drivers/crypto/qce/core.c | 120 ++++++++++++++++++++++++++++++++++----
>  1 file changed, 108 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
> index e95e84486d9a..70b9d9e739be 100644
> --- a/drivers/crypto/qce/core.c
> +++ b/drivers/crypto/qce/core.c
> @@ -12,6 +12,7 @@
>  #include <linux/module.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/types.h>
>  #include <crypto/algapi.h>
>  #include <crypto/internal/hash.h>
> @@ -91,22 +92,28 @@ static int qce_handle_queue(struct qce_device *qce,
>  	struct crypto_async_request *async_req, *backlog;
>  	int ret = 0, err;
>  
> +	ret = pm_runtime_get_sync(qce->dev);

Use pm_runtime_resume_and_get() instead. Drop corresponding
put_noidle()

> +	if (ret < 0) {
> +		pr_err("error with pm_runtime_get_sync");
> +		pm_runtime_put_noidle(qce->dev);
> +		return ret;
> +	}
> +
>  	scoped_guard(mutex, &qce->lock) {
>  		if (req)
>  			ret = crypto_enqueue_request(&qce->queue, req);
>  
>  		/* busy, do not dequeue request */
>  		if (qce->req)
> -			return ret;
> +			goto qce_suspend;
>  
>  		backlog = crypto_get_backlog(&qce->queue);
>  		async_req = crypto_dequeue_request(&qce->queue);
>  		if (async_req)
>  			qce->req = async_req;
>  	}
> -
>  	if (!async_req)
> -		return ret;
> +		goto qce_suspend;
>  
>  	if (backlog) {
>  		scoped_guard(mutex, &qce->lock)
> @@ -119,6 +126,8 @@ static int qce_handle_queue(struct qce_device *qce,
>  		schedule_work(&qce->done_work);
>  	}
>  
> +qce_suspend:
> +	pm_runtime_put_autosuspend(qce->dev);
>  	return ret;
>  }
>  
> @@ -208,37 +217,43 @@ static int qce_crypto_probe(struct platform_device *pdev)
>  	if (ret < 0)
>  		return ret;
>  
> -	qce->core = devm_clk_get_optional_enabled(qce->dev, "core");
> +	qce->core = devm_clk_get_optional(dev, "core");
>  	if (IS_ERR(qce->core))
>  		return PTR_ERR(qce->core);
>  
> -	qce->iface = devm_clk_get_optional_enabled(qce->dev, "iface");
> +	qce->iface = devm_clk_get_optional(dev, "iface");
>  	if (IS_ERR(qce->iface))
>  		return PTR_ERR(qce->iface);
>  
> -	qce->bus = devm_clk_get_optional_enabled(qce->dev, "bus");
> +	qce->bus = devm_clk_get_optional(dev, "bus");
>  	if (IS_ERR(qce->bus))
>  		return PTR_ERR(qce->bus);
>  
> -	qce->mem_path = devm_of_icc_get(qce->dev, "memory");
> +	qce->mem_path = devm_of_icc_get(dev, "memory");
>  	if (IS_ERR(qce->mem_path))
>  		return PTR_ERR(qce->mem_path);
>  
> -	ret = icc_set_bw(qce->mem_path, QCE_DEFAULT_MEM_BANDWIDTH, QCE_DEFAULT_MEM_BANDWIDTH);
> +	/* Enable runtime PM after clocks and ICC are acquired */
> +
> +	ret = devm_pm_runtime_enable(dev);
>  	if (ret)
>  		return ret;
>  
> -	ret = devm_qce_dma_request(qce->dev, &qce->dma);
> +	ret = pm_runtime_resume_and_get(dev);
>  	if (ret)
>  		return ret;
>  
> +	ret = devm_qce_dma_request(qce->dev, &qce->dma);
> +	if (ret)
> +		goto err_pm;
> +
>  	ret = qce_check_version(qce);
>  	if (ret)
> -		return ret;
> +		goto err_pm;
>  
>  	ret = devm_mutex_init(qce->dev, &qce->lock);
>  	if (ret)
> -		return ret;
> +		goto err_pm;
>  
>  	INIT_WORK(&qce->done_work, qce_req_done_work);
>  	crypto_init_queue(&qce->queue, QCE_QUEUE_LENGTH);
> @@ -246,9 +261,89 @@ static int qce_crypto_probe(struct platform_device *pdev)
>  	qce->async_req_enqueue = qce_async_request_enqueue;
>  	qce->async_req_done = qce_async_request_done;
>  
> -	return devm_qce_register_algs(qce);
> +	ret = devm_qce_register_algs(qce);
> +	if (ret)
> +		goto err_pm;
> +
> +	/* Configure autosuspend after successful init */
> +	pm_runtime_set_autosuspend_delay(dev, 100);
> +	pm_runtime_use_autosuspend(dev);
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_put_autosuspend(dev);
> +
> +	return 0;
> +
> +err_pm:
> +	pm_runtime_put(dev);
> +
> +	return ret;
> +}
> +
> +static int qce_runtime_suspend(struct device *dev)
> +{
> +	struct qce_device *qce = dev_get_drvdata(dev);
> +
> +	clk_disable_unprepare(qce->bus);
> +	clk_disable_unprepare(qce->iface);
> +	clk_disable_unprepare(qce->core);

Replace with a single clk_bulk ops or maybe it would be even better to
use pm_clk_add() instead of managing clocks manually.

> +	icc_disable(qce->mem_path);
> +
> +	return 0;
> +}
> +
> +static int qce_runtime_resume(struct device *dev)
> +{
> +	struct qce_device *qce = dev_get_drvdata(dev);
> +	int ret = 0;
> +
> +	ret = icc_enable(qce->mem_path);
> +	if (ret)
> +		return ret;
> +
> +	ret = icc_set_bw(qce->mem_path, QCE_DEFAULT_MEM_BANDWIDTH, QCE_DEFAULT_MEM_BANDWIDTH);
> +	if (ret)
> +		goto err_icc;
> +
> +	ret = clk_prepare_enable(qce->core);
> +	if (ret)
> +		goto err_icc;
> +
> +	ret = clk_prepare_enable(qce->iface);
> +	if (ret)
> +		goto err_core;
> +
> +	ret = clk_prepare_enable(qce->bus);
> +	if (ret)
> +		goto err_iface;
> +
> +	return 0;
> +
> +err_iface:
> +	clk_disable_unprepare(qce->iface);
> +err_core:
> +	clk_disable_unprepare(qce->core);
> +err_icc:
> +	icc_disable(qce->mem_path);
> +	return ret;
>  }
>  
> +static int qce_suspend(struct device *dev)
> +{
> +	return qce_runtime_suspend(dev);
> +}
> +
> +static int qce_resume(struct device *dev)
> +{
> +	return qce_runtime_resume(dev);
> +}
> +
> +static const struct dev_pm_ops qce_crypto_pm_ops = {
> +	.runtime_suspend = qce_runtime_suspend,
> +	.runtime_resume  = qce_runtime_resume,

Please use macros from <linux/pm.h>

> +	.suspend         = qce_suspend,
> +	.resume          = qce_resume,

Any reasons for not using pm_runtime_force_suspend() /
pm_runtime_force_resume() ?

> +};

This whole struct can be defined using DEFINE_RUNTIME_DEV_PM_OPS().

> +
>  static const struct of_device_id qce_crypto_of_match[] = {
>  	{ .compatible = "qcom,crypto-v5.1", },
>  	{ .compatible = "qcom,crypto-v5.4", },
> @@ -262,6 +357,7 @@ static struct platform_driver qce_crypto_driver = {
>  	.driver = {
>  		.name = KBUILD_MODNAME,
>  		.of_match_table = qce_crypto_of_match,
> +		.pm = &qce_crypto_pm_ops,
>  	},
>  };
>  module_platform_driver(qce_crypto_driver);
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

