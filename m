Return-Path: <linux-kernel+bounces-875679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AC539C1994F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 32EF53481B5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F952D6401;
	Wed, 29 Oct 2025 10:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eC3rQwc2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IGYfRGGh"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B6123817E
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 10:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761732562; cv=none; b=fDCjSSgbYRLhdK89aaDi2zMobZkDN7n2tqyE/L0jNjc0uKhB3qWC8P0212tsT9m5KLHJDWAv0wsSeT3P8UIYoUEh8TbueIL4zQzp2DLKc+4oQFm+jrqYftvHtTfGSFqDg4GsDtQRVuj9zwNkKNvBineZ/Y0v2HIwymM34sszytk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761732562; c=relaxed/simple;
	bh=T+skC9JZPAVKoGOzV7tmD8ueHFS0TYHsN35wOLfRedg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gWOeL+Z5wl31stkjIkdGoc0Gj9TMl0Efx5bxHCFjaEcy6mGZQ+u6OX+nLxk2gj2nsfOhlahicm305x19EGIQCQcauqS2OcJ3ALS1OEumNlRTyVhLAwAXQWb2MgSC5iC7aj+qXkCQLbft+hxdQndhoxFxXqJHk3fGf8OTm33fDxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eC3rQwc2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IGYfRGGh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59T4uqLv3642836
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 10:09:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9UFoaKdadr1g2i/MVgf4IFB2G1VGBqYfrKXQNVHn/VI=; b=eC3rQwc2rxh5ZH/u
	MLIP7A06hX4U946VpCtfU1TDeWAya3SDZO+zbPnLs8OjMCNSne6rBKyiFzAKGesC
	2VAxvlYKVR3jDhah0+HthQPcelMydWe5YyVPYL4kmyZoYKxJrnezia6C2i2ISW8b
	vTdCFhRCSvnkOaOTIedA1fuZ+nV6kxT0xUi/gHz5KKo4Uec8YqzYqHQWdaUfFCYp
	tQrTex1MG9yFQBsU1HxVcqnALnqVmoKBz9kT4nt4e19TCGhaTnxOK2S8I/oSHPmm
	C4ZkFT8afG09z9lQHaz9WGSorKhZ342Ccz5iWt+pIPsSMlnvGRvnyarTK02YqeOn
	oXrkLw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34a1j588-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 10:09:19 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-267f099ca68so14537495ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 03:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761732559; x=1762337359; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9UFoaKdadr1g2i/MVgf4IFB2G1VGBqYfrKXQNVHn/VI=;
        b=IGYfRGGhKkoBH5WP8LHemVT5Oy5rOZ5ZewTjguxEdOUg/oJfbM4l8RjTsY+C23THvb
         KW1q3tSAbj3MDsPRmTdSdKUMn8/BhnqZ0RzhjLogDYCApp8BFDQcnWAPA55jJlCt/JoR
         gzyBQe8N91pvzuLVcYMByKb7TYAgQAyySTLJ4NotSjyczR7ZD0Z7pWBVH/CfocpOYUmt
         wsrp09Umm+kl1XSAiXsZaN7K/TYgNI5Vz3gibZc637JPrLXoD3jyZaO6IRELjZ13usg+
         kMYBrLO4oIVHI6MTt2kngDCddFJ52vx7ckuFxHJhNjTq9gjmlQIH9MVqDLbt8FsdJVR2
         PL8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761732559; x=1762337359;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9UFoaKdadr1g2i/MVgf4IFB2G1VGBqYfrKXQNVHn/VI=;
        b=ioVG3tk1RdbQqe8xtlXTXuRmAZhnzrcMrfrMVq/pZxB5h0GAgr7rtM3VnQRFeJQMpT
         J+2zMJBsgW1HajcGGxLNGH7W6TGj6rjT9Qswrcogg2SJziPceqBJrfsbW7DVpNSex4tS
         4Ynj+N1qtTr9D00YLMpz5C3dSY8WmIFQnbJxrIDKWfyiVyYp8XXBoo6gPuhgFHoeTGuH
         GK5T0TRQVvSk/NQi6uaD0X8+SWyzPDz8lOk5wE+kAN+FvPjcAJqKJYS6QMTp9ICeqeTO
         zTKR7BGAoDKKjmijqUp5u+nuXBOfGQ3JCj15fu0hXIXi4QGoXVtI71ZTwzOK4h3ygvc4
         +95Q==
X-Forwarded-Encrypted: i=1; AJvYcCXMUCtJSl0WflM67wI/g2M13wy0FyHfs1GVYOQDOL8pj6/+5yVXeA/F3J4/ZLz6Q+BO1JukLCW46prM0ns=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQcfl59b6AkI69Z/g45kAm/c6SqLEWIZDte8hWeGjL+fFoBan6
	gKoG8hWKJBft+pU0KBsmL3Jhw5BV81y0osKDBYJ0+6W9Y+VLmv6MZoxiEhY8qym3vfD7SrFzLqh
	PSp410CjGWXWlGe3cnWxEMaU3fpsLHuYCrY8gJqCvsSGvcIhnlZzqpBUtKafhgb3KHmw=
X-Gm-Gg: ASbGncuUqAbgtYULl0MVYjnB0x7bmah1eoBEmeHrTL9lmnJquCGigfJ/vJGAj+O/1zb
	jeEXa78cg8fFgmMUYo+eWCioJ1/JgJMUs5J9H+FxEGBgdGpTAMmB5OyZvFqiARCP5Hm8WY/yrqg
	NtY/SKJ1on3j++JntdIkuNfAah1FEsdyRX88dwaV3hYdELVKUFSuoEwoBi/yyL3VqYkAfGoLxjs
	C1UoQ3NA4HZ5F7zbyV0LBUpgPi23HNPtzP2d5qfjKQ2QyAsAi6GzpG62SwwR8vYXHshsFpoQpsg
	gjALJWDCrBqgxFxCMbRauFPvuGK0t7JeLC7tvvEyaRxgDl+P9IhalI9vnG5dEDDYHiUs5h/y4HW
	j1f3zn7hH6udB1jD5fxNZjWilpUux2Y+C1ZyvxFN+pZBwA7+zqyI0W4Ptw4LBYSK4
X-Received: by 2002:a17:903:182:b0:292:64ec:8f4d with SMTP id d9443c01a7336-294def32107mr13268995ad.8.1761732558672;
        Wed, 29 Oct 2025 03:09:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrhQOQPmCxS1LCe2JYoHowXrcsx36JRLe8QavrIxkEGUCUFIlfyO2q3wnnI4V0G19PT7t65w==
X-Received: by 2002:a17:903:182:b0:292:64ec:8f4d with SMTP id d9443c01a7336-294def32107mr13268635ad.8.1761732558014;
        Wed, 29 Oct 2025 03:09:18 -0700 (PDT)
Received: from [10.133.33.95] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d273cdsm144849345ad.55.2025.10.29.03.09.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 03:09:17 -0700 (PDT)
Message-ID: <ca033e96-2024-4418-80d1-5dd119c5d9d8@oss.qualcomm.com>
Date: Wed, 29 Oct 2025 18:09:11 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] remoteproc: qcom: pas: Add late attach support for
 subsystems
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc: tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gokul krishna Krishnakumar <Gokul.krishnakumar@oss.qualcomm>
References: <20251029-knp-remoteproc-v2-0-6c81993b52ea@oss.qualcomm.com>
 <20251029-knp-remoteproc-v2-4-6c81993b52ea@oss.qualcomm.com>
Content-Language: en-US
From: "Aiqun(Maria) Yu" <aiqun.yu@oss.qualcomm.com>
In-Reply-To: <20251029-knp-remoteproc-v2-4-6c81993b52ea@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=dbiNHHXe c=1 sm=1 tr=0 ts=6901e7cf cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=stnUSK8qSH_NtdpFURMA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: M3I3rtMHCX1EvCifSP-9decKxvGlyVEw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDA3NiBTYWx0ZWRfXwpelJc/eKpjk
 eIdLf50agUjZyrGIUuvU0q9YTBeNHOxfOraUk+e0x9A0CO/tOthQFUt04Xk14LYoaJQfWS74j58
 hf9R8GYFvsc1IA2M3PVoRtuLhY5hZlzfwMRWqzxFBMO9aiqAMt3dsoBNX+X8+ZVzoJUwjXmaTHD
 sG+ugkAGCp20v5Qtrct5t4If6ulgjomeq5oyWR8NJAoQsJn0Y9qAmLB3qJXEDzTOwSgZCjG3ytH
 kksL8IgAe5+8W8odu74HwKFIpwRwMjSLdbCU6IMdKK0gS0ZivxJXvfh9ChzWQj5qYyHmcN1ERB0
 zSHjoFlPS4WpzD15PiZMUWARVzuIyBrBHSzPjGj0ZVPI/+BwS123HFlXgGunjIGMl8fVuRU/8DG
 OlYOsXaWdO5Yq/q5/cOinBTD1dYKSA==
X-Proofpoint-GUID: M3I3rtMHCX1EvCifSP-9decKxvGlyVEw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-29_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510290076

On 10/29/2025 4:05 PM, Jingyi Wang wrote:
> From: Gokul krishna Krishnakumar <Gokul.krishnakumar@oss.qualcomm>
> 
...

> +
> +	/* Clear ping bit master kernel */
> +	ret = qcom_smem_state_update_bits(q6v5->ping_state, BIT(q6v5->ping_bit), 0);
> +	if (ret) {
> +		pr_err("Failed to clear master kernel bits\n");
> +		return ret;
> +	}
> +
> +	if (ping_failed)
> +		return ping_failed;
> +
> +	return 0;

Prefer to just have:
return ping_failed;> +}
> +EXPORT_SYMBOL_GPL(qcom_q6v5_ping_subsystem);
> +
> +int qcom_q6v5_ping_subsystem_init(struct qcom_q6v5 *q6v5, struct platform_device *pdev)
> +{
> +	int ret = -ENODEV;
> +
> +	q6v5->ping_state = devm_qcom_smem_state_get(&pdev->dev, "ping", &q6v5->ping_bit);
> +	if (IS_ERR(q6v5->ping_state)) {
> +		dev_err(&pdev->dev, "failed to acquire smem state %ld\n",

Change from "failed" to "Failed" to align with log format in this file.>
+			PTR_ERR(q6v5->ping_state));
> +		return ret;
> +	}
> +
> +	q6v5->pong_irq = platform_get_irq_byname(pdev, "pong");
> +	if (q6v5->pong_irq < 0)
> +		return q6v5->pong_irq;
> +

Maybe place here for before any chance of q6v5_pong_interrupt:
init_completion(&q6v5->ping_done);> +	ret =
devm_request_threaded_irq(&pdev->dev, q6v5->pong_irq, NULL,
> +					q6v5_pong_interrupt, IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> +					"q6v5 pong", q6v5);
> +	if (ret)
> +		dev_err(&pdev->dev, "failed to acquire pong IRQ\n");

Change from "failed" to "Failed" to align with log format in this file.> +
> +	init_completion(&q6v5->ping_done);

Better to have the init_completion before the pong_irq's
devm_request_threaded_irq.> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(qcom_q6v5_ping_subsystem_init);
> +
>  /**
>   * qcom_q6v5_init() - initializer of the q6v5 common struct
...
> +static int qcom_pas_attach(struct rproc *rproc)
> +{
> +	int ret;
> +	struct qcom_pas *adsp = rproc->priv;
> +	bool ready_state;
> +	bool crash_state;
> +
> +	if (!adsp->q6v5.early_boot)
> +		return -EINVAL;
> +
> +	ret = irq_get_irqchip_state(adsp->q6v5.fatal_irq,
> +				    IRQCHIP_STATE_LINE_LEVEL, &crash_state);
> +
> +	if (crash_state) {
> +		dev_err(adsp->dev, "Sub system has crashed before driver probe\n");
> +		adsp->rproc->state = RPROC_CRASHED;
> +		return -EINVAL;
> +	}
> +
> +	ret = irq_get_irqchip_state(adsp->q6v5.ready_irq,
> +				    IRQCHIP_STATE_LINE_LEVEL, &ready_state);
> +
> +	if (ready_state) {
> +		dev_info(adsp->dev, "Sub system has boot-up before driver probe\n");
> +		adsp->rproc->state = RPROC_DETACHED;
> +	} else {
> +		ret = wait_for_completion_timeout(&adsp->q6v5.subsys_booted,
> +						  msecs_to_jiffies(EARLY_BOOT_RETRY_INTERVAL_MS));
> +		if (!ret) {
> +			dev_err(adsp->dev, "Timeout on waiting for subsystem interrupt\n");
> +			return -ETIMEDOUT;
> +		}
> +	}

How about:
if (unlikely(!ready_state)) {
	ret = wait_for_completion_timeout(&adsp->q6v5.subsys_booted,
					  msecs_to_jiffies(EARLY_BOOT_RETRY_INTERVAL_MS));
	if (!ret) {
		dev_err(adsp->dev, "Timeout on waiting for subsystem interrupt\n");
		return -ETIMEDOUT;
	}
}

dev_info(adsp->dev, "Sub system has boot-up before driver probe\n");
adsp->rproc->state = RPROC_DETACHED;



-- 
Thx and BRs,
Aiqun(Maria) Yu

