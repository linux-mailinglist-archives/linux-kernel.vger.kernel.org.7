Return-Path: <linux-kernel+bounces-741518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 181C6B0E53C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 23:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D4B97B52FB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 21:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C982F284678;
	Tue, 22 Jul 2025 21:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Inhn0cIH"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3260286425
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 21:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753218342; cv=none; b=fNtfqbajr6Zk0bR1Vylo2zPTNVK0qZ7G2x6FY+9+fySurh7naZrcIFclr2GDKIGwfo4InKTdoHoPYt6SDpAopYvzkMfKHeqN3bi1igYc6XHIcz6uwQTDxM+Qvs7c+EZHBs0fqWqeeKhyjqSEXVGSyIc77RnWry+M9zpc2YSmkg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753218342; c=relaxed/simple;
	bh=ydvx5NU4z9Jw6G8c2IMmv+IUBO2ptrL6FEtdDrsqWM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gF7yEDTloBmOOx+HY1i3VltqfZlSI7mYN6ddY4s0FtUsUmD1YqeF9Sxq8J3elpxdHzDMaiKFceybdIczIz3AQqmQEx215NlWPXo0IXS9JPROC3uC9LrahPEtMO2CLgkk9/h+Dpagzv5IC7rWCQjvb5FH+YrUO0bRuZ1pGPRyVik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Inhn0cIH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MKTuml015638
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 21:05:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0355SZkFbrW4clUa8O8bfxTWToKcdMQi7Sj9d0UwLZs=; b=Inhn0cIHMZRRlzL7
	bg+q0pzZBRRLjjBpEcaBW3ohg5fF33XXvQXIm1imaeRIvhPE6+LZizPx901aOTSu
	axaEaoZjfOPT3gnQuWqLScMQT0lMUpRijQQ7zG2G+lCUI8ru7ymvsiFuCr1DW9m9
	bFbISlAgrw6f1uDgzRAbkHao0vJOhWqD1Qaa0u+Wd4c4whUZAFmJKhKtO9h24+Au
	YDwj+syxHybXZ6OvAeI/ppyzGv0U3xcpLLJjMRyMT/xznmPKfkdTQ73R1qH9lsde
	/z21AASY06JAmceQay5N4TkowXx8Pb7UktzP9Ku8JpzPVTn4QCQ4416JelHOB/Wq
	R6TGpw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48045w177b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 21:05:37 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b3f33295703so5342885a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 14:05:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753218337; x=1753823137;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0355SZkFbrW4clUa8O8bfxTWToKcdMQi7Sj9d0UwLZs=;
        b=mnYK3kum2JAwIJ1V9Mp6t0a9IyP9efF27DtJ6n8ed9QwlYMyGl1tph6vXuzM438H6w
         9QUshafzr6/hUq6wa2lmwIdYjvQ9trs8MHjLHON5CkzAdxWDvK9Tg25/rwDy0MBz8oKn
         y4/2HIBItN3hwIbhELmQgLfelzOMoK2AS4OA2CHG24MXiXzovhchx7yIVwLVsGlAL9cA
         7QDdGACt5dV43v3cr/jcCCiU4AX3jch9qeJDMO2ci8qFTGbEZT7tJsSZAbaz4hMZtlsc
         s8dD9JMnrMn+YqCfF/IKsHlbczKLOwOQOpJYAhEKYdLKtfthFBz9aZntlXSeP88uKtPO
         tNpg==
X-Forwarded-Encrypted: i=1; AJvYcCWj8pZemim9C+QPpF4lKrL2JYKZDjJZZZbc+f3L7AmSbzzOSXyxewC0aMl6pG7XgX16Mh9dlYnZ8fiwbrI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxScs6yr4WBAFhmZY/HbkgRZQuETYQQMAEZQ8Zu7B2up6FFur48
	BsanCrnR9t/R+GpKbTnNY0qdk9q2J9LnQOPitOaGEb3ad4HGaspD9ig+re3WkqmNPFq9m2R2dyq
	IuEYyVRb8X74EVUgTw9QRoNiWel503DzWmKHq9ggOZOQpjWQwJL6uyBpCXBfuktdZ1+w=
X-Gm-Gg: ASbGncvORIIDQXCKmAxAO+BGFgA7Eed/Nh115E0R15muovNyM88PIilN+HKsVsctfIc
	eqiJ+PIEkqK/LpvN4ju39bYBI0uIouVkklmAfbnRLXWICzkLZqN2WEbjxLXE08Bh+6RGnyDegUX
	Wgtuc8eZS9PxMmxo3MdopWoGT22mypWyVtYxFmFu7HlD81RO4K5ImqcNlZXcEx2DMbNr3qXJOF3
	Xqk7xwY6rKaPvMtlgxQqS4rboig7p1LA6mB7p8JBAmfdewd7lVYxYka81+bpjKFxQG7yDFgjqLF
	OxMDlIaN6BjFlKhh4ku1rBq75ZS0oLfuAT+4s909cdCo0qXRUNruxeOMUtONUbG3
X-Received: by 2002:a05:6a20:4324:b0:1f5:8eec:e517 with SMTP id adf61e73a8af0-23d48fb2511mr523023637.9.1753218337003;
        Tue, 22 Jul 2025 14:05:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1BjhTkdCWRXxjTiz3Zh9W88aQWhh4MT8oN3QDovcTtPwknTU/tKfCx8XWQk2PaJJlB2Ehhg==
X-Received: by 2002:a05:6a20:4324:b0:1f5:8eec:e517 with SMTP id adf61e73a8af0-23d48fb2511mr522956637.9.1753218336447;
        Tue, 22 Jul 2025 14:05:36 -0700 (PDT)
Received: from [192.168.1.4] ([106.222.235.133])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759c8eb0e98sm8313876b3a.66.2025.07.22.14.05.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 14:05:36 -0700 (PDT)
Message-ID: <f1070069-7220-4351-845a-2929d1e65a71@oss.qualcomm.com>
Date: Wed, 23 Jul 2025 02:35:31 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/17] drm/msm/a6xx: Fix PDC sleep sequence
To: rob.clark@oss.qualcomm.com,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250720-ifpc-support-v1-0-9347aa5bcbd6@oss.qualcomm.com>
 <20250720-ifpc-support-v1-5-9347aa5bcbd6@oss.qualcomm.com>
 <avni4utnzdmmafc2mf7aqgva3osbhuiqtia7gdngqswk5cmtn6@zo65ir7gyj6y>
 <CACSVV0346j2y-1Jkj=wasekYy5syax_E495AQZv0bvrrqwCSRw@mail.gmail.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CACSVV0346j2y-1Jkj=wasekYy5syax_E495AQZv0bvrrqwCSRw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=LL1mQIW9 c=1 sm=1 tr=0 ts=687ffd22 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=4dphQItTPUswyQvINXrzgA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=q7gkdMK14rNBkceAJS4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: C52E8jOGGVVq6KS6uvo758MVZyNjtdxS
X-Proofpoint-ORIG-GUID: C52E8jOGGVVq6KS6uvo758MVZyNjtdxS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDE4MiBTYWx0ZWRfXxeehZQSyDKbn
 X+wZqsvKJTADYEciA7tuyaSGrgnR19GRujYha3LGSVGzR8HW+zbf9bkzLr97/4mZw9GTrVyrBl7
 uufqZZC1bqVpYTUFrulKa3odv+v8VcD/FCcPiG3JNZin8LC/kV5KbNJ666czw5Kary5l+mnN7qN
 XcOYiMxFQ04Mv5i30wSuwqY4NWRovMAdTzA0E7YukyJi9mhyz3qrNwLej88R7x2b53vhPCN8rom
 Lph5f1VBjgs0TzrIb2RZZBZo/JzYJtTbBpIBBoS2oKELO1/nOpVc/LSvO6BrBu6uP1SA6f6M7eg
 UfY2/jaEf4tA2pH/A1XJB5eByj7vu5RRtY+aaMjkN+Q4y/r5l9Z79P4KnzODaOPndcKOMg3nTze
 tl5Noe7Lcj6tLNXoAUItmLsUQoJkApZcF5dIRW6sODuSkVuXKRmmtA39Y4G7OkjgTCupMt95
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_03,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxlogscore=999 clxscore=1015 mlxscore=0 adultscore=0
 suspectscore=0 spamscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507220182

On 7/22/2025 10:56 PM, Rob Clark wrote:
> On Tue, Jul 22, 2025 at 6:33 AM Dmitry Baryshkov
> <dmitry.baryshkov@oss.qualcomm.com> wrote:
>>
>> On Sun, Jul 20, 2025 at 05:46:06PM +0530, Akhil P Oommen wrote:
>>> Since the PDC resides out of the GPU subsystem and cannot be reset in
>>> case it enters bad state, utmost care must be taken to trigger the PDC
>>> wake/sleep routines in the correct order.
>>>
>>> The PDC wake sequence can be exercised only after a PDC sleep sequence.
>>> Additionally, GMU firmware should initialize a few registers before the
>>> KMD can trigger a PDC sleep sequence. So PDC sleep can't be done if the
>>
>> s/KMD/the driver/
> 
> IMHO for gpu things "KMD" makes sense, to differentiate between kernel
> and user mode (UMD).. this is perhaps different from other areas where
> there isn't a userspace component to the driver stack

Ack

> 
> BR,
> -R
> 
>>> GMU firmware has not initialized. Track these dependencies using a new
>>> status variable and trigger PDC sleep/wake sequences appropriately.
>>
>> Again, it looks like there should be a Fixes tag here.

Ack. I guess it is not a bad idea to backport this one too.

>>
>>>
>>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>>> ---
>>>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 30 +++++++++++++++++++-----------
>>>  drivers/gpu/drm/msm/adreno/a6xx_gmu.h |  6 ++++++
>>>  2 files changed, 25 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
>>> index 3bebb6dd7059782ceca29f2efd2acee24d3fc930..4d6c70735e0892ed87d6a68d64f24bda844e5e16 100644
>>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
>>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
>>> @@ -279,6 +279,8 @@ static int a6xx_gmu_start(struct a6xx_gmu *gmu)
>>>       if (ret)
>>>               DRM_DEV_ERROR(gmu->dev, "GMU firmware initialization timed out\n");
>>>
>>> +     set_bit(GMU_STATUS_FW_START, &gmu->status);
>>> +
>>>       return ret;
>>>  }
>>>
>>> @@ -528,6 +530,9 @@ static int a6xx_rpmh_start(struct a6xx_gmu *gmu)
>>>       int ret;
>>>       u32 val;
>>>
>>> +     if (!test_and_clear_bit(GMU_STATUS_PDC_SLEEP, &gmu->status))
>>> +             return 0;
>>> +
>>>       gmu_write(gmu, REG_A6XX_GMU_RSCC_CONTROL_REQ, BIT(1));
>>>
>>>       ret = gmu_poll_timeout(gmu, REG_A6XX_GMU_RSCC_CONTROL_ACK, val,
>>> @@ -555,6 +560,11 @@ static void a6xx_rpmh_stop(struct a6xx_gmu *gmu)
>>>       int ret;
>>>       u32 val;
>>>
>>> +     if (test_and_clear_bit(GMU_STATUS_FW_START, &gmu->status))
>>> +             return;
>>> +
>>> +     /* TODO: should we skip if IFPC is not enabled */
>>
>> Is this a question or a statement?

It was a reminder to myself which I forgot to revisit later. Will
addresss this in the next revision.

-Akhil.

>>
>>> +
>>>       gmu_write(gmu, REG_A6XX_GMU_RSCC_CONTROL_REQ, 1);
>>>
>>>       ret = gmu_poll_timeout_rscc(gmu, REG_A6XX_GPU_RSCC_RSC_STATUS0_DRV0,
>>> @@ -563,6 +573,8 @@ static void a6xx_rpmh_stop(struct a6xx_gmu *gmu)
>>>               DRM_DEV_ERROR(gmu->dev, "Unable to power off the GPU RSC\n");
>>>
>>>       gmu_write(gmu, REG_A6XX_GMU_RSCC_CONTROL_REQ, 0);
>>> +
>>> +     set_bit(GMU_STATUS_PDC_SLEEP, &gmu->status);
>>>  }
>>>
>>>  static inline void pdc_write(void __iomem *ptr, u32 offset, u32 value)
>>> @@ -691,8 +703,6 @@ static void a6xx_gmu_rpmh_init(struct a6xx_gmu *gmu)
>>>       /* ensure no writes happen before the uCode is fully written */
>>>       wmb();
>>>
>>> -     a6xx_rpmh_stop(gmu);
>>> -
>>>  err:
>>>       if (!IS_ERR_OR_NULL(pdcptr))
>>>               iounmap(pdcptr);
>>> @@ -852,19 +862,15 @@ static int a6xx_gmu_fw_start(struct a6xx_gmu *gmu, unsigned int state)
>>>       else
>>>               gmu_write(gmu, REG_A6XX_GMU_GENERAL_7, 1);
>>>
>>> -     if (state == GMU_WARM_BOOT) {
>>> -             ret = a6xx_rpmh_start(gmu);
>>> -             if (ret)
>>> -                     return ret;
>>> -     } else {
>>> +     ret = a6xx_rpmh_start(gmu);
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     if (state == GMU_COLD_BOOT) {
>>>               if (WARN(!adreno_gpu->fw[ADRENO_FW_GMU],
>>>                       "GMU firmware is not loaded\n"))
>>>                       return -ENOENT;
>>>
>>> -             ret = a6xx_rpmh_start(gmu);
>>> -             if (ret)
>>> -                     return ret;
>>> -
>>>               ret = a6xx_gmu_fw_load(gmu);
>>>               if (ret)
>>>                       return ret;
>>> @@ -1046,6 +1052,8 @@ static void a6xx_gmu_force_off(struct a6xx_gmu *gmu)
>>>
>>>       /* Reset GPU core blocks */
>>>       a6xx_gpu_sw_reset(gpu, true);
>>> +
>>> +     a6xx_rpmh_stop(gmu);
>>>  }
>>>
>>>  static void a6xx_gmu_set_initial_freq(struct msm_gpu *gpu, struct a6xx_gmu *gmu)
>>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
>>> index b2d4489b40249b1916ab4a42c89e3f4bdc5c4af9..034f1b4e5a3fb9cd601bfbe6d06d64e5ace3b6e7 100644
>>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
>>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
>>> @@ -117,6 +117,12 @@ struct a6xx_gmu {
>>>
>>>       struct qmp *qmp;
>>>       struct a6xx_hfi_msg_bw_table *bw_table;
>>> +
>>> +/* To check if we can trigger sleep seq at PDC. Cleared in a6xx_rpmh_stop() */
>>> +#define GMU_STATUS_FW_START  0
>>> +/* To track if PDC sleep seq was done */
>>> +#define GMU_STATUS_PDC_SLEEP 1
>>> +     unsigned long status;
>>>  };
>>>
>>>  static inline u32 gmu_read(struct a6xx_gmu *gmu, u32 offset)
>>>
>>> --
>>> 2.50.1
>>>
>>
>> --
>> With best wishes
>> Dmitry


