Return-Path: <linux-kernel+bounces-835808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6981BBA81CD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 08:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E9C03B302E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 06:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1397725394A;
	Mon, 29 Sep 2025 06:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UrA/lvtV"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0011E86347
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 06:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759127256; cv=none; b=cw/aCLXnA+hmyrMtBD+3QEYjp1lIkjyuf40fSwsZ2ztsu+m824HTrHxup9Is6NT1S3r5hG9aeWryFXE3OiTkMkaMg/E3pCRsXBmp3PiQSMI3whI4cv6ZRPXJTtYKmCDuDn4PMRn3/hgwhkYU2BKk0bFuB8yan8XPangXZbTcAHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759127256; c=relaxed/simple;
	bh=4gPBWorEr1c/yp7psBYT3NbliQJECRZPN5Au7ds4ceM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JzAtmMnR0ts57tDjnqeQYTljsKluWCI6vyhMZ0JnObWcGkb8wz07XCSJK7COhQuBht2FAmaCD8spcBxWvvxaqfvwEB+Q4Bfaq5jGJhkYUVT9F3jslvfe75fIKCKXWK7KYHJzbakqOfKSoWbSq5ca0x7BJyUOYkAh2kzsIexy4QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UrA/lvtV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58T0NCRC018280
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 06:27:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qP7jymGCWNJxfW+2mG0DDlX9Sdznno9oFQZzwmGy004=; b=UrA/lvtVX9OC1+6g
	EfE614PyrTgKJHb67hg+GBZQDTypH17z01AvdRkRD24z2OV3FMnAjnjUVRQvAgZj
	CLY1hfQq+FZJk83wHKrrGhyz9SJEvbkGlA2sGXl6JgnbrSLmBcVooHgwkKqFwy1n
	Gd+i0ece6xKFWOCCnFH9MplOlaIDCVRWQRBANIkjr3poWk12N+tTYnCobUJekh4u
	phEjd1vCoIQ3QCmoJIUTNDLs7BvH0xswDoBQHuUd8NCI7EYmyZtI2Hz6tYvqqCto
	sFlY5VMy3N9XhyYwXdpHaQI1UmckDxMSqmO0t6LH5EbpJJBMEzSP8o4msZEkIfvw
	B119WA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e59mveg4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 06:27:33 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-32ee157b9c9so3683450a91.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 23:27:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759127252; x=1759732052;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qP7jymGCWNJxfW+2mG0DDlX9Sdznno9oFQZzwmGy004=;
        b=Up4cdPbCSajBaMED9eAo5+wifRomDB+kUTuLZTkgBh75EQnHKqhqXZc4dBQUbHpHgO
         abi16BGelKSY8qv3Vb0Tt4jCbu6ud7twSsoCAtusraMu7Ier1orfgqq8tqfWlaINAC9a
         49UVFFLwgZx7+w40pObkNKhr83UiQq6jPCGspiSu0Zn989QlPHCMGEv+/4K2qeGI/Bfi
         gJBfzxC0Eo/WhrUdfxoRypa4XXazMk7XC+IGtRr2CQ5yGRrjYK3Yb4ySfpDX9eMWf9Gv
         sujxePHhF2OLyH8nuVD1AVnWJjQ7UaYiOECIAo9xMtEatJ/6qir+7Izd6zkd3l3mHZUe
         Uj1w==
X-Forwarded-Encrypted: i=1; AJvYcCU0Ae7qPLyy5W7x6Z9o18LgoaEJ+zuhKXZlAwamLDlU/Zm17BVt7YFU92Toz/jazFHz8JePigG+Ks6bmo4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcKHq8zOQweOJfsYfaiaSqSCh/5Ax9RnJp1Kv3mVXkS6K+bMYQ
	jdvz9k056+ueKmmdHAQp+gZfludLPUjhTroICkcVjnehNAAuAALlgZZyr5DXdqty+xS5HV6U57R
	bw8QCjLG4a+jr8dGDARWrFcPSOPkPt7GTXAG2kOEXUFAaf6hz47jF46NWh4cSJDKD2NI=
X-Gm-Gg: ASbGncsDvCCcUfV+lK5G2BDYVFm8Q/q5XocF1u70rECmYqSSnqgUGYxP75rsJ5Q1muy
	+QpVl5yhh8n2eLLL35TA8uvTiCWYnUP2OqrG4blBwwhD3h/Kk5fOqScmOhjCHictA+3WXCXrvtf
	AgK0qJkPc4qcRYj3KnhCcXXTBl0KGkj8O50NWzUmIrgW6P384N2D3x/Depk12tMmr/+h1Yf8ppJ
	hsdz3BQYKt7wyKv+htVd6G3v++t1aBuURKwmuxasFwu8OovEFX8AnyeBcMfpVX9mEX90y3H68Ca
	E+9MXPACnqhwT0oF6jOlVrzVE7CIRgrwUT5Vd7Sk3L0qby2o/Qeo1NmYuH+kHd1eEajYZ+j8oeh
	aX3a6UiZLa04dYwtbSHsNpYtuncXIX4RbvWo=
X-Received: by 2002:a17:90a:e710:b0:32e:ae12:9d32 with SMTP id 98e67ed59e1d1-3342a22beffmr15394494a91.11.1759127252379;
        Sun, 28 Sep 2025 23:27:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdka21IueZPHOO0v3oQ4wpLn8ECcDYHpm9b0HxoaEDoHSl/q1hRi4GMU5/rEoS9U0WZQGyVw==
X-Received: by 2002:a17:90a:e710:b0:32e:ae12:9d32 with SMTP id 98e67ed59e1d1-3342a22beffmr15394477a91.11.1759127251875;
        Sun, 28 Sep 2025 23:27:31 -0700 (PDT)
Received: from [10.133.33.234] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341be383b4sm15846936a91.27.2025.09.28.23.27.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Sep 2025 23:27:31 -0700 (PDT)
Message-ID: <20ac1a08-1c44-49e6-beae-6bf7bb36ee4b@oss.qualcomm.com>
Date: Mon, 29 Sep 2025 14:27:24 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] remoteproc: qcom: pas: Add late attach support for
 subsystems
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        Gokul krishna Krishnakumar <Gokul.krishnakumar@oss.qualcomm>
References: <20250924-knp-remoteproc-v1-0-611bf7be8329@oss.qualcomm.com>
 <20250924-knp-remoteproc-v1-5-611bf7be8329@oss.qualcomm.com>
 <f5808617-9e55-4e0c-98b0-daf2bb49facc@oss.qualcomm.com>
Content-Language: en-US
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
In-Reply-To: <f5808617-9e55-4e0c-98b0-daf2bb49facc@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: FORj4IWs4CL4214aWsMvRWhc-6rB_LhT
X-Authority-Analysis: v=2.4 cv=O4g0fR9W c=1 sm=1 tr=0 ts=68da26d5 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=HOk5XYdhHCy6_sCauzoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: FORj4IWs4CL4214aWsMvRWhc-6rB_LhT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAwMSBTYWx0ZWRfX5wHK8wcJ3cCB
 BDv3p+RmhzFPDLdNUU5dleHLxYLTGaXwyZUTmmCyDKo5uNDS5L0qE5HCQuJiVP6S7k1OP3KAgAX
 R7iERB8GonUXPCGM0Z3F6wGMqECVVhAYwThWwyN6FhCIbgL6GLvmC7fMTpbWfhTOdmX2NUBF54d
 RycZhUtYE2RoiQtNYXftjEhrisxgbT4Zy04T9ljAYnGRDYqIusZnSyytRtqFS6fE2wDMSKLcA5l
 Pn3ZSIekot24mOPxxuNkYd1cq875ZI4KscEiA16jlVApwpMRj9VFBANOuO9vm5RxMKK91sdUxEH
 LMGmq32VV/P9nFasX1hu7GLzKOxOBFQRV6ZPH4eES8xj3/eJtUHjOU7uLK152QmXaR+up90KLsq
 4ECW7f/WeNth/tqn42JXvupEW3oK9A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_02,2025-09-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270001



On 9/25/2025 1:56 PM, Zhongqiu Han wrote:
> On 9/25/2025 7:37 AM, Jingyi Wang wrote:
>> From: Gokul krishna Krishnakumar <Gokul.krishnakumar@oss.qualcomm>
>>
>> Subsystems can be brought out of reset by entities such as
>> bootloaders. Before attaching such subsystems, it is important to
>> check the state of the subsystem. This patch adds support to attach
>> to a subsystem by ensuring that the subsystem is in a sane state by
>> reading SMP2P bits and pinging the subsystem.
>>
>> Signed-off-by: Gokul krishna Krishnakumar <Gokul.krishnakumar@oss.qualcomm>
>> Co-developed-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
>> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
>> ---
>>   drivers/remoteproc/qcom_q6v5.c      | 89 ++++++++++++++++++++++++++++++++++++-
>>   drivers/remoteproc/qcom_q6v5.h      | 14 +++++-
>>   drivers/remoteproc/qcom_q6v5_adsp.c |  2 +-
>>   drivers/remoteproc/qcom_q6v5_mss.c  |  2 +-
>>   drivers/remoteproc/qcom_q6v5_pas.c  | 61 ++++++++++++++++++++++++-
>>   5 files changed, 163 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/remoteproc/qcom_q6v5.c b/drivers/remoteproc/qcom_q6v5.c
>> index 4ee5e67a9f03..cba05e1d6d52 100644
>> --- a/drivers/remoteproc/qcom_q6v5.c
>> +++ b/drivers/remoteproc/qcom_q6v5.c
>> @@ -94,6 +94,9 @@ static irqreturn_t q6v5_wdog_interrupt(int irq, void *data)
>>       size_t len;
>>       char *msg;
>>   +    if (q6v5->early_boot)
>> +        complete(&q6v5->subsys_booted);
>> +
>>       /* Sometimes the stop triggers a watchdog rather than a stop-ack */
>>       if (!q6v5->running) {
>>           complete(&q6v5->stop_done);
>> @@ -118,6 +121,9 @@ static irqreturn_t q6v5_fatal_interrupt(int irq, void *data)
>>       size_t len;
>>       char *msg;
>>   +    if (q6v5->early_boot)
>> +        complete(&q6v5->subsys_booted);
>> +
>>       if (!q6v5->running)
>>           return IRQ_HANDLED;
>>   @@ -139,6 +145,9 @@ static irqreturn_t q6v5_ready_interrupt(int irq, void *data)
>>         complete(&q6v5->start_done);
>>   +    if (q6v5->early_boot)
>> +        complete(&q6v5->subsys_booted);
>> +
>>       return IRQ_HANDLED;
>>   }
>>   @@ -170,6 +179,9 @@ static irqreturn_t q6v5_handover_interrupt(int irq, void *data)
>>       if (q6v5->handover)
>>           q6v5->handover(q6v5);
>>   +    if (q6v5->early_boot)
>> +        complete(&q6v5->subsys_booted);
>> +
>>       icc_set_bw(q6v5->path, 0, 0);
>>         q6v5->handover_issued = true;
>> @@ -232,6 +244,77 @@ unsigned long qcom_q6v5_panic(struct qcom_q6v5 *q6v5)
>>   }
>>   EXPORT_SYMBOL_GPL(qcom_q6v5_panic);
>>   +static irqreturn_t q6v5_pong_interrupt(int irq, void *data)
>> +{
>> +    struct qcom_q6v5 *q6v5 = data;
>> +
>> +    complete(&q6v5->ping_done);
>> +
>> +    return IRQ_HANDLED;
>> +}
>> +
>> +int qcom_q6v5_ping_subsystem(struct qcom_q6v5 *q6v5)
>> +{
>> +    int ret;
>> +    int ping_failed = 0;
>> +
>> +    reinit_completion(&q6v5->ping_done);
>> +
>> +    /* Set master kernel Ping bit */
>> +    ret = qcom_smem_state_update_bits(q6v5->ping_state,
>> +                      BIT(q6v5->ping_bit), BIT(q6v5->ping_bit));
>> +    if (ret) {
>> +        dev_err(q6v5->dev, "Failed to update ping bits\n");
>> +        return ret;
>> +    }
>> +
>> +    ret = wait_for_completion_timeout(&q6v5->ping_done, msecs_to_jiffies(PING_TIMEOUT));
>> +    if (!ret) {
>> +        ping_failed = -ETIMEDOUT;
>> +        dev_err(q6v5->dev, "Failed to get back pong\n");
>> +    }
>> +
>> +    /* Clear ping bit master kernel */
>> +    ret = qcom_smem_state_update_bits(q6v5->ping_state, BIT(q6v5->ping_bit), 0);
>> +    if (ret) {
>> +        pr_err("Failed to clear master kernel bits\n");
>> +        return ret;
>> +    }
>> +
>> +    if (ping_failed)
>> +        return ping_failed;
>> +
>> +    return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(qcom_q6v5_ping_subsystem);
>> +
>> +int qcom_q6v5_ping_subsystem_init(struct qcom_q6v5 *q6v5, struct platform_device *pdev)
>> +{
>> +    int ret = -ENODEV;
>> +
>> +    q6v5->ping_state = devm_qcom_smem_state_get(&pdev->dev, "ping", &q6v5->ping_bit);
>> +    if (IS_ERR(q6v5->ping_state)) {
>> +        dev_err(&pdev->dev, "failed to acquire smem state %ld\n",
>> +            PTR_ERR(q6v5->ping_state));
>> +        return ret;
>> +    }
>> +
>> +    q6v5->pong_irq = platform_get_irq_byname(pdev, "pong");
>> +    if (q6v5->pong_irq < 0)
>> +        return q6v5->pong_irq;
>> +
>> +    ret = devm_request_threaded_irq(&pdev->dev, q6v5->pong_irq, NULL,
>> +                    q6v5_pong_interrupt, IRQF_TRIGGER_RISING | IRQF_ONESHOT,
>> +                    "q6v5 pong", q6v5);
>> +    if (ret)
>> +        dev_err(&pdev->dev, "failed to acquire pong IRQ\n");
>> +
>> +    init_completion(&q6v5->ping_done);
> 
> Hello Jingyi,
> 
> Since no IRQF_NO_AUTOEN flag is passed to devm_request_threaded_irq(),
> the IRQ may be enabled immediately after registration.
> If the thread_fn q6v5_pong_interrupt runs before
> init_completion(&q6v5->ping_done) is called, it may lead to accessing an
> uninitialized completion structure ?
> 
> 

Hi Zhongqiu, q6v5_pong_interrupt will only trigger after we call qcom_q6v5_ping_subsystem,
which must be called after this function.

Thanks,
Jingyi

>> +
>> +    return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(qcom_q6v5_ping_subsystem_init);
>> +
>>   /**
>>    * qcom_q6v5_init() - initializer of the q6v5 common struct
>>    * @q6v5:    handle to be initialized
>> @@ -245,7 +328,7 @@ EXPORT_SYMBOL_GPL(qcom_q6v5_panic);
>>    */
>>   int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct platform_device *pdev,
>>              struct rproc *rproc, int crash_reason, const char *load_state,
>> -           void (*handover)(struct qcom_q6v5 *q6v5))
>> +           bool early_boot, void (*handover)(struct qcom_q6v5 *q6v5))
>>   {
>>       int ret;
>>   @@ -253,10 +336,14 @@ int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct platform_device *pdev,
>>       q6v5->dev = &pdev->dev;
>>       q6v5->crash_reason = crash_reason;
>>       q6v5->handover = handover;
>> +    q6v5->early_boot = early_boot;
>>         init_completion(&q6v5->start_done);
>>       init_completion(&q6v5->stop_done);
>>   +    if (early_boot)
>> +        init_completion(&q6v5->subsys_booted);
>> +
>>       q6v5->wdog_irq = platform_get_irq_byname(pdev, "wdog");
>>       if (q6v5->wdog_irq < 0)
>>           return q6v5->wdog_irq;
>> diff --git a/drivers/remoteproc/qcom_q6v5.h b/drivers/remoteproc/qcom_q6v5.h
>> index 5a859c41896e..8a227bf70d7e 100644
>> --- a/drivers/remoteproc/qcom_q6v5.h
>> +++ b/drivers/remoteproc/qcom_q6v5.h
>> @@ -12,27 +12,35 @@ struct rproc;
>>   struct qcom_smem_state;
>>   struct qcom_sysmon;
>>   +#define PING_TIMEOUT 500 /* in milliseconds */
>> +#define PING_TEST_WAIT 500 /* in milliseconds */
>> +
>>   struct qcom_q6v5 {
>>       struct device *dev;
>>       struct rproc *rproc;
>>         struct qcom_smem_state *state;
>> +    struct qcom_smem_state *ping_state;
>>       struct qmp *qmp;
>>         struct icc_path *path;
>>         unsigned stop_bit;
>> +    unsigned int ping_bit;
>>         int wdog_irq;
>>       int fatal_irq;
>>       int ready_irq;
>>       int handover_irq;
>>       int stop_irq;
>> +    int pong_irq;
>>         bool handover_issued;
>>         struct completion start_done;
>>       struct completion stop_done;
>> +    struct completion subsys_booted;
>> +    struct completion ping_done;
>>         int crash_reason;
>>   @@ -40,11 +48,13 @@ struct qcom_q6v5 {
>>         const char *load_state;
>>       void (*handover)(struct qcom_q6v5 *q6v5);
>> +
>> +    bool early_boot;
>>   };
>>     int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct platform_device *pdev,
>>              struct rproc *rproc, int crash_reason, const char *load_state,
>> -           void (*handover)(struct qcom_q6v5 *q6v5));
>> +           bool early_boot, void (*handover)(struct qcom_q6v5 *q6v5));
>>   void qcom_q6v5_deinit(struct qcom_q6v5 *q6v5);
>>     int qcom_q6v5_prepare(struct qcom_q6v5 *q6v5);
>> @@ -52,5 +62,7 @@ int qcom_q6v5_unprepare(struct qcom_q6v5 *q6v5);
>>   int qcom_q6v5_request_stop(struct qcom_q6v5 *q6v5, struct qcom_sysmon *sysmon);
>>   int qcom_q6v5_wait_for_start(struct qcom_q6v5 *q6v5, int timeout);
>>   unsigned long qcom_q6v5_panic(struct qcom_q6v5 *q6v5);
>> +int qcom_q6v5_ping_subsystem(struct qcom_q6v5 *q6v5);
>> +int qcom_q6v5_ping_subsystem_init(struct qcom_q6v5 *q6v5, struct platform_device *pdev);
>>     #endif
>> diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c b/drivers/remoteproc/qcom_q6v5_adsp.c
>> index e98b7e03162c..1576b435b921 100644
>> --- a/drivers/remoteproc/qcom_q6v5_adsp.c
>> +++ b/drivers/remoteproc/qcom_q6v5_adsp.c
>> @@ -717,7 +717,7 @@ static int adsp_probe(struct platform_device *pdev)
>>           goto disable_pm;
>>         ret = qcom_q6v5_init(&adsp->q6v5, pdev, rproc, desc->crash_reason_smem,
>> -                 desc->load_state, qcom_adsp_pil_handover);
>> +                 desc->load_state, false, qcom_adsp_pil_handover);
>>       if (ret)
>>           goto disable_pm;
>>   diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
>> index 0c0199fb0e68..04e577541c8f 100644
>> --- a/drivers/remoteproc/qcom_q6v5_mss.c
>> +++ b/drivers/remoteproc/qcom_q6v5_mss.c
>> @@ -2156,7 +2156,7 @@ static int q6v5_probe(struct platform_device *pdev)
>>       qproc->has_mba_logs = desc->has_mba_logs;
>>         ret = qcom_q6v5_init(&qproc->q6v5, pdev, rproc, MPSS_CRASH_REASON_SMEM, "modem",
>> -                 qcom_msa_handover);
>> +                 false, qcom_msa_handover);
>>       if (ret)
>>           goto detach_proxy_pds;
>>   diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
>> index 55a7da801183..99163e48a76a 100644
>> --- a/drivers/remoteproc/qcom_q6v5_pas.c
>> +++ b/drivers/remoteproc/qcom_q6v5_pas.c
>> @@ -35,6 +35,8 @@
>>     #define MAX_ASSIGN_COUNT 3
>>   +#define EARLY_BOOT_RETRY_INTERVAL_MS 5000
>> +
>>   struct qcom_pas_data {
>>       int crash_reason_smem;
>>       const char *firmware_name;
>> @@ -58,6 +60,7 @@ struct qcom_pas_data {
>>       int region_assign_count;
>>       bool region_assign_shared;
>>       int region_assign_vmid;
>> +    bool early_boot;
>>   };
>>     struct qcom_pas {
>> @@ -430,6 +433,51 @@ static unsigned long qcom_pas_panic(struct rproc *rproc)
>>       return qcom_q6v5_panic(&pas->q6v5);
>>   }
>>   +static int qcom_pas_attach(struct rproc *rproc)
>> +{
>> +    int ret;
>> +    struct qcom_pas *adsp = rproc->priv;
>> +    bool ready_state;
>> +    bool crash_state;
>> +
>> +    if (!adsp->q6v5.early_boot)
>> +        return -EINVAL;
>> +
>> +    ret = irq_get_irqchip_state(adsp->q6v5.fatal_irq,
>> +                    IRQCHIP_STATE_LINE_LEVEL, &crash_state);
>> +
>> +    if (crash_state) {
>> +        dev_err(adsp->dev, "Sub system has crashed before driver probe\n");
>> +        adsp->rproc->state = RPROC_CRASHED;
>> +        return -EINVAL;
>> +    }
>> +
>> +    ret = irq_get_irqchip_state(adsp->q6v5.ready_irq,
>> +                    IRQCHIP_STATE_LINE_LEVEL, &ready_state);
>> +
>> +    if (ready_state) {
>> +        dev_info(adsp->dev, "Sub system has boot-up before driver probe\n");
>> +        adsp->rproc->state = RPROC_DETACHED;
>> +    } else {
>> +        ret = wait_for_completion_timeout(&adsp->q6v5.subsys_booted,
>> +                          msecs_to_jiffies(EARLY_BOOT_RETRY_INTERVAL_MS));
>> +        if (!ret) {
>> +            dev_err(adsp->dev, "Timeout on waiting for subsystem interrupt\n");
>> +            return -ETIMEDOUT;
>> +        }
>> +    }
>> +
>> +    ret = qcom_q6v5_ping_subsystem(&adsp->q6v5);
>> +    if (ret) {
>> +        dev_err(adsp->dev, "Failed to ping subsystem, assuming device crashed\n");
>> +        rproc->state = RPROC_CRASHED;
>> +        return ret;
>> +    }
>> +
>> +    adsp->q6v5.running = true;
>> +    return ret;
>> +}
>> +
>>   static const struct rproc_ops qcom_pas_ops = {
>>       .unprepare = qcom_pas_unprepare,
>>       .start = qcom_pas_start,
>> @@ -438,6 +486,7 @@ static const struct rproc_ops qcom_pas_ops = {
>>       .parse_fw = qcom_register_dump_segments,
>>       .load = qcom_pas_load,
>>       .panic = qcom_pas_panic,
>> +    .attach = qcom_pas_attach,
>>   };
>>     static const struct rproc_ops qcom_pas_minidump_ops = {
>> @@ -760,7 +809,7 @@ static int qcom_pas_probe(struct platform_device *pdev)
>>       pas->proxy_pd_count = ret;
>>         ret = qcom_q6v5_init(&pas->q6v5, pdev, rproc, desc->crash_reason_smem,
>> -                 desc->load_state, qcom_pas_handover);
>> +                 desc->load_state, desc->early_boot, qcom_pas_handover);
>>       if (ret)
>>           goto detach_proxy_pds;
>>   @@ -774,6 +823,16 @@ static int qcom_pas_probe(struct platform_device *pdev)
>>       }
>>         qcom_add_ssr_subdev(rproc, &pas->ssr_subdev, desc->ssr_name);
>> +
>> +    if (pas->q6v5.early_boot) {
>> +        ret = qcom_q6v5_ping_subsystem_init(&pas->q6v5, pdev);
>> +        if (ret)
>> +            dev_err(&pdev->dev,
>> +                "Unable to find ping/pong bits, falling back to firmware load\n");
>> +        else
>> +            pas->rproc->state = RPROC_DETACHED;
>> +    }
>> +
>>       ret = rproc_add(rproc);
>>       if (ret)
>>           goto remove_ssr_sysmon;
>>
> 
> 


