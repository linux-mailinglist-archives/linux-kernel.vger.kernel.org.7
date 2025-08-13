Return-Path: <linux-kernel+bounces-766419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF81DB24664
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 12:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0710088466B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 09:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA0A2F7450;
	Wed, 13 Aug 2025 09:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jv1gb4ke"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C3E296BDF
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 09:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755078817; cv=none; b=kpSa8JC7+A3R/3OuI6IlgPaK4UHEyFN4QEHrHGghuw07gSY8T71m7GjEqwAE7Kf3SatGw9P9LQiOyMA3Fu4AYzEhsEo9PXu33+b0cdt+rchc/BZD0wA5EEunoiTxrb/W4QJ/Y4o1at0HqH32tEZiviEUDOrUgde889qhZLMpXbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755078817; c=relaxed/simple;
	bh=ht1diEblsf5dN2e1cjhOK7qCFVmjDiqNwW826Qyw2Rw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dLT8XHNZp0itbff8gNz16RuvUYa/sJeVopw4F+Fpe+tc/9lBrbtyS2B/YKtC08OW7TJUDj2bJEA94fI/rXTBevf/7u1TMSbso5gIdgibOiiTWv4CqVzQoMPakeWjlyw9PRmfvyXj2lTAtmlu1fxW0p3iJcrZiprwABQbLA+G24Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jv1gb4ke; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57D6mZBd002889
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 09:53:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0MpY81TRuNNBDJHPaklTYFI4wsF3yIvIsNOVJLMUbFI=; b=jv1gb4keblqk8Oe8
	0IfDMzKm25CeMTPUr3pF7EbmmsPsOLRWBpI00RvmXRswzIs7e8YQH+a0cRyDckIF
	LA4ZoN1AZjOx5pFVY3yJK4jw/QU8r2bxYcFvbcGdFiorQreKFUbhT07kl9Gi+G2N
	f55HidrgJkXBV5yJUT8BuXqNrt4c5PTtAZP+JnoYr5CYrsGIvfgmUEzGc4h7rmVc
	/DqajI7vnQRNFloz+QUnWILumdJbaJEZiGsizqio23jkwNZSN4z803BRoqhfjI79
	Wes3vpWBA5aKH4D6XyhjXc0Xhyb1iJFF9YTwD+0giYsH3PMGy5fLkWA1jfGrVSci
	OBrGMg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ffhjq52s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 09:53:34 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4af23fa7c0cso19229931cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 02:53:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755078813; x=1755683613;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0MpY81TRuNNBDJHPaklTYFI4wsF3yIvIsNOVJLMUbFI=;
        b=g+EsdLT/aoGS9L5Ynz19l1Snfpwn+CLit53n0dFjNe/ltz7xQ7UFkEh7cXVwlE7Z0f
         0CqYUj4YWndiqlimRcy4U++bM+WNOj67MNuibz1ZFbTc5qdEj6hpQfnTf4Oj+RAYoFtd
         Rnef34Qv41I5AE+vEnMFSWIYcXh1y1Ia/1yhLIgjzoTxfUYlKu3iGldLGfbXH1Fh+Lbq
         9SL8kVCrrCGTCaxcw0MKgPhRfQqV9DQYrsVyfeZK0QO16uxRReV6WtEld/LtPj3q5DzY
         g9NzeMrjLgsBT8K/tIILfUwK95bvf+9UKVrYBB2ck8XX35jk6n4lYFU/Da7W8Y33zFDT
         r4xQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgTZhNvBWtlmSuEyCrfqDwgkNzu/ZJ9dUd0OVd3TQNZFfBEb0kDqJIMq3axQtPSE869w4XuRquSFzpRLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkGWAj/pYKgyJmmaoGeDF+dku3MuhUSVcztOKHwQ4wym8nFdUj
	w07pVeL/KcNxjm4LFfse7Hnh8vfK8lWiSF28Lj+UbAlmZzh5j+XaZ6/OGHJ2yEPGzGaTc/rQHvP
	W5304mDEsBOqq1detmMD/SVSWSYoQtIfKG23MIxFgEqhxFjYFz/6PsMSw9aCrwpEFxFU=
X-Gm-Gg: ASbGncvb56myF4Yl3xOLcIWa7S/fWOwgHm9RmriNTZh8M9LPhnM92BgPw31it3gjYX7
	rXBUJQ4/4jw5hJXf3DKOEa9wNJhok8dm3pMfTBUjZzzAmnxCEjxIkWmAlOw7zUKWz3n33r6zYao
	5/tuO3/lYRD6lIwj74sTupbXBQZmzepHaz5y9QGjT50M7Ol6mrr5CFKb20Hpcx9+F1dT8QzvmRj
	5UB6s+/1U4NUXGI4hnSbd2t7AI0JgEOhYdaa5LQB5o5+kV0FCb7iIou0rrqu38PYo32WNl6FXVA
	H8GVV9L2RsPXmAeGwPxQa1DCHJ/2Glsuk0zyxbI1vdbuozDrX26wddbnbMXmFOAG3zEqzX0zR0h
	z2IIYtaZPbV0e6L6Yeg==
X-Received: by 2002:a05:622a:143:b0:4ab:63f8:ef30 with SMTP id d75a77b69052e-4b0fc6f5abamr14652561cf.3.1755078813078;
        Wed, 13 Aug 2025 02:53:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHL9p/V8kgz7pgbQLj/2LkDGUoYpwD7WnZTmIEKh4brnTqRmXHLFYJ1dJDBYqoeMLjGgWK2g==
X-Received: by 2002:a05:622a:143:b0:4ab:63f8:ef30 with SMTP id d75a77b69052e-4b0fc6f5abamr14652161cf.3.1755078812394;
        Wed, 13 Aug 2025 02:53:32 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af92a2ec9cbsm2254739566b.79.2025.08.13.02.53.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 02:53:31 -0700 (PDT)
Message-ID: <f015c644-1176-47b3-8ce2-2567e529081e@oss.qualcomm.com>
Date: Wed, 13 Aug 2025 11:53:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 06/11] firmware: qcom: scm: add support for object
 invocation
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Apurupa Pattapu <quic_apurupa@quicinc.com>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
References: <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-0-ce7a1a774803@oss.qualcomm.com>
 <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-6-ce7a1a774803@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-6-ce7a1a774803@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA3NCBTYWx0ZWRfXw2GCEqFvvYP3
 6kFsG8lLA19sE/jDfZx4whJWfA10lED7TNMcvw1nrfUc9fgpzR9oJ0gfzloSXyNOW9bm0ohhpWT
 afxr157HWyx8mbOOi3JW7hdCHVEkb8TP9xNGL/4adQV8OCvQZxweghRhOdnCP/t9BtE2r51vNSF
 q1xD4WY2/fpV7BYvnMQre24ero2FzZZSVfbyw9Phk9AgOG905UeWuxgT+U1CS4bcU08MpxpRFPe
 gNuvG0lPE4JIXT+ZJuOEXIs9IInencHLrh9QFoNXLxqUiWj3dwoYMMM8sVDgV5WCeK+3EccvJT8
 eNJoPVaAU26VGhWZwj0ndl1fdpz1gUPxz0heG764EWU2lBAmS4lrDB5IGgCQ/+nHwRiEObWL6yd
 AwOysDD7
X-Proofpoint-GUID: 1VF5FxzYUr6IFGE_AIl3dKfsrNg6c4kB
X-Authority-Analysis: v=2.4 cv=TJFFS0la c=1 sm=1 tr=0 ts=689c609e cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=ZC-EX8TnQz-G3DLW9GIA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 1VF5FxzYUr6IFGE_AIl3dKfsrNg6c4kB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508110074

On 8/13/25 2:35 AM, Amirreza Zarrabi wrote:
> Qualcomm TEE (QTEE) hosts Trusted Applications (TAs) and services in
> the secure world, accessed via objects. A QTEE client can invoke these
> objects to request services. Similarly, QTEE can request services from
> the nonsecure world using objects exported to the secure world.
> 
> Add low-level primitives to facilitate the invocation of objects hosted
> in QTEE, as well as those hosted in the nonsecure world.
> 
> If support for object invocation is available, the qcom_scm allocates
> a dedicated child platform device. The driver for this device communicates
> with QTEE using low-level primitives.
> 
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
> Tested-by: Harshal Dev <quic_hdev@quicinc.com>
> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
> ---

[...]

> +int qcom_scm_qtee_invoke_smc(phys_addr_t inbuf, size_t inbuf_size,
> +			     phys_addr_t outbuf, size_t outbuf_size,
> +			     u64 *result, u64 *response_type)
> +{
> +	struct qcom_scm_desc desc = {
> +		.svc = QCOM_SCM_SVC_SMCINVOKE,
> +		.cmd = QCOM_SCM_SMCINVOKE_INVOKE,
> +		.owner = ARM_SMCCC_OWNER_TRUSTED_OS,
> +		.args[0] = inbuf,
> +		.args[1] = inbuf_size,
> +		.args[2] = outbuf,
> +		.args[3] = outbuf_size,
> +		.arginfo = QCOM_SCM_ARGS(4, QCOM_SCM_RW, QCOM_SCM_VAL,
> +					 QCOM_SCM_RW, QCOM_SCM_VAL),
> +	};
> +	struct qcom_scm_res res;
> +	int ret;
> +
> +	ret = qcom_scm_call(__scm->dev, &desc, &res);
> +	if (ret)
> +		return ret;
> +
> +	*response_type = res.result[0];
> +	*result = res.result[1];

These are dereferenced without checking, which will surely upset static
checkers (and users)

I see that res.result[2] should also return some (aptly named) "data"
which you handled in v1, but dropped in v2 (without a comment AFAICT)

Looking at it, we could probably wrap it in qcom_scm_qseecom_call()
which this seems to be fit for

> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(qcom_scm_qtee_invoke_smc);
> +
> +/**
> + * qcom_scm_qtee_callback_response() - Submit response for callback request.
> + * @buf: start address of memory area used for outbound buffer.
> + * @buf_size: size of the memory area used for outbound buffer.
> + * @result: Result of QTEE object invocation.
> + * @response_type: Response type returned by QTEE.
> + *
> + * @response_type determines how the contents of @buf should be processed.
> + *
> + * Return: On success, return 0 or <0 on failure.
> + */
> +int qcom_scm_qtee_callback_response(phys_addr_t buf, size_t buf_size,
> +				    u64 *result, u64 *response_type)

These should be aligned

> +{
> +	struct qcom_scm_desc desc = {
> +		.svc = QCOM_SCM_SVC_SMCINVOKE,
> +		.cmd = QCOM_SCM_SMCINVOKE_CB_RSP,
> +		.owner = ARM_SMCCC_OWNER_TRUSTED_OS,
> +		.args[0] = buf,
> +		.args[1] = buf_size,
> +		.arginfo = QCOM_SCM_ARGS(2, QCOM_SCM_RW, QCOM_SCM_VAL),
> +	};
> +	struct qcom_scm_res res;
> +	int ret;
> +
> +	ret = qcom_scm_call(__scm->dev, &desc, &res);
> +	if (ret)
> +		return ret;
> +
> +	*response_type = res.result[0];
> +	*result = res.result[1];

this also seems like a good candidate for qcom_scm_qseecom_call()

[...]

>  /**
>   * qcom_scm_is_available() - Checks if SCM is available
>   */
> @@ -2326,6 +2444,16 @@ static int qcom_scm_probe(struct platform_device *pdev)
>  	ret = qcom_scm_qseecom_init(scm);
>  	WARN(ret < 0, "failed to initialize qseecom: %d\n", ret);
>  
> +	/*
> +	 * Initialize the QTEE object interface.
> +	 *
> +	 * This only represents the availability for QTEE object invocation
> +	 * and callback support. On failure, ignore the result. Any subsystem
> +	 * depending on it may fail if it tries to access this interface.
> +	 */
> +	ret = qcom_scm_qtee_init(scm);
> +	WARN(ret < 0, "failed to initialize qcomtee: %d\n", ret);

This will throw a WARN on *a lot* of platforms, ranging from
Chromebooks running TF-A (with a reduced SMC handler), through
platforms requiring QCOM_SCM_SMCINVOKE_INVOKE_LEGACY (0x00) cmd

Konrad

