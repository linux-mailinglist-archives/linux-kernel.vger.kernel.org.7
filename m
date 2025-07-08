Return-Path: <linux-kernel+bounces-721355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC72AFC80F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 12:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67E317AF7D7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 10:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744CB20C000;
	Tue,  8 Jul 2025 10:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z3k1vUVj"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4EC20B1F4
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 10:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751969752; cv=none; b=W6fvhfssHHfrY8XE4hZhLZGMFxQnRjkgXIfwJlK0H7P9q8YOwbsWpfE+PSnzibn1R0gSxvYXsF6dH7WqhYSU5S+xvvxHlVx4vxLkyDVHhlVhUoqN+4y4VkT4QSPiMJk1fsQme76MxX0Djh8sxoErcPacz8D5Qqka0c/zMuHXm4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751969752; c=relaxed/simple;
	bh=4ItLoeTx3HRyKDPaO+sh4Kd3sq4cOgELPmOoot4c30Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d/3dsM63QcOyU/L0zk107+MLPqEpLk0g3MNqlL6gir+cHPuqwZu6OX+QZN1YskI4No4HH/GHA0ncmQcIfX/aPkXZk2HUjmS7dZNCgpTDbSKgQL2mgtV0Iva1GRxD2U+u0AUau1st8yuUExovuatAOX5W1UIPev8HR9j/MmyWtng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z3k1vUVj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568AAOHf003435
	for <linux-kernel@vger.kernel.org>; Tue, 8 Jul 2025 10:15:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wAz8ZIHuo/SWeC7W3wizcPsD4EK5ykNZLoU6WzbK4q8=; b=Z3k1vUVja7wSnnnH
	IketGHiTgcMn3mY3jYohCNO+NLu0OEc70r83fThGNsYDQTR0ehReQXLYWJ8uGIt2
	WmaltGpHUiwLkIAIcNIQG+g67x6KooEIKbNfiHsE2of5ftzRhgUX4ru+7Sah8v0M
	zyvO1FcZ4trf1AvEQLHhcDIZCo+g3H1/uJOvK/edJEF5rB+JFDKm94Gn6BVkVWv/
	4tdYnf6ojHJ+cx3C3ACaoS4BYnU3ozlXQGHxamRdv2Hlk3aAuv4gO2u+g+sBs6uC
	/2vMCceBDTCaZZt15NJziT0oeKr4GQgLUy7aQkUVI5XQ+LP3w5/YIqfCGBSA52O8
	YztW0g==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pvefck46-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 10:15:50 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3141a9a6888so3905497a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 03:15:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751969749; x=1752574549;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wAz8ZIHuo/SWeC7W3wizcPsD4EK5ykNZLoU6WzbK4q8=;
        b=qRN0G8U2UevIe2uLR1MLK1Ks23CqRcCDStqRXW70iT65z9A3VQXTWPuTG3OgH7JN8i
         nw7s7XFOTdj0CBkV1SA2FqlNTd9TeBi78TOhPbGjPYlFmsdezm2nb+1kzrMPlLfBO57b
         ApbRrTuie9h9utJlXLUTnjK1HtXICuxRIAnt+/u+fh2qK/mDXycbfQ/GcqpT+RYbJyrI
         QbI310uTH6G9jp5am6KYIE2xbmv5ZfzEUGXY8N7BKAsEw+OujQzFcG3zII8GtNuIEjRD
         j3SdK8wxYEIlJQes+mL8SpjohqlFpzD4+2MzWPZYNlVNPX60ALFIEYPlGcI+j5Z/Kz8C
         nFyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAeM2ofu3siKR1RmdzbLI4sNPQs/l7oQ4z3an02sL6BNmIa3cNzr06cbSJTXuQHRNfbnPsRZESQll6ask=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh+YW3F6F3FgcR6KfgAYYiz10+0rM0MjzRcF4MYQH13b92TRTb
	pTSOTx6y79okgKPWUztBPcNZrO1h5xjkkW2ccSIZrNXI5zstwtP5DfHloopGe+okZp9LBclztAo
	4ZoEJmw3OPSfRWpkCWyJbmHjkT+5zxW1OPjmmUDLPWBdu3ioKpzJT96qvndIoa7u5Ws4=
X-Gm-Gg: ASbGncv08ujEjs+mZ4+cEkozURQCUo3NObgwnsfZZWymsZSC8J66NQbep5AbS66CFeD
	06fvNpx5BU/Sl0/ksyPW5SKVQUe/w76ActYlv4ZtcjFYECCMC6EKvh2cxjVRe+QOCJrlAgvRsvI
	O88nmXU4Y3QgVYkot0fraWvsBncBF8p02eIo26f8Yah56nSi/lOfE0YJ280+dUt2Z9KUy+/c6qH
	TLfEpb3qtYlZxKmYaWicxIGuuTp+89scX+GJ30I3EROj4pbjt0AUpM1AQKE35Jy1jvhZOKUQJah
	vzS/beoaJg3gQOHnmoOQPoYENN2lOEdG77mLbV0cV4YK+XnZ3IwM
X-Received: by 2002:a17:90a:634a:b0:311:d258:3473 with SMTP id 98e67ed59e1d1-31c21cfbe1dmr2713721a91.13.1751969748727;
        Tue, 08 Jul 2025 03:15:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxrinOt6UxxB4i1n+mV0391ziMXD2TDdWIyM6jJWyQXxor+uM7US8wRj4S5OLlgpGL8Qo77g==
X-Received: by 2002:a17:90a:634a:b0:311:d258:3473 with SMTP id 98e67ed59e1d1-31c21cfbe1dmr2713703a91.13.1751969748239;
        Tue, 08 Jul 2025 03:15:48 -0700 (PDT)
Received: from [10.218.37.122] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c21d6797csm1746635a91.14.2025.07.08.03.15.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 03:15:47 -0700 (PDT)
Message-ID: <b72b3635-1c09-444f-98f5-30fcc219b297@oss.qualcomm.com>
Date: Tue, 8 Jul 2025 15:45:39 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] bus: mhi: keep device context through suspend cycles
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
        Youssef Samir <quic_yabdulra@quicinc.com>,
        Matthew Leung <quic_mattleun@quicinc.com>, Yan Zhen <yanzhen@vivo.com>,
        Alexander Wilhelm <alexander.wilhelm@westermo.com>,
        Alex Elder <elder@kernel.org>, Kunwu Chan <chentao@kylinos.cn>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Siddartha Mohanadoss <smohanad@codeaurora.org>,
        Sujeev Dias <sdias@codeaurora.org>,
        Julia Lawall <julia.lawall@lip6.fr>, John Crispin <john@phrozen.org>,
        Muna Sinada <quic_msinada@quicinc.com>,
        Venkateswara Naralasetty <quic_vnaralas@quicinc.com>,
        Maharaja Kennadyrajan <quic_mkenna@quicinc.com>, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Cc: kernel@collabora.com
References: <20250630074330.253867-1-usama.anjum@collabora.com>
 <20250630074330.253867-4-usama.anjum@collabora.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20250630074330.253867-4-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDA4NCBTYWx0ZWRfX7khgg/FfEGXR
 yVbDZsGwpda8/bVf8uIlAh/AOeyBJW3/xNns8Csll+W9HFAD/DrrOjr9pIzb1tM26bJ3NR05NrK
 JJE50Sn4XKYOxnWkpeV65a8En6r6gQq7HI5KXilwqyNKXXyaoc7ZjWLErrTGuCVOlWPejVY5Tb9
 iAXWQWgLnnnNqoI/DFL4BcFlrLotN7qYYeCDgPMXL1f32UsXOeCMsD6fHbEVzckNW7WtmIfaEd4
 gjq+iaAb5vkH7zvOxlWgauSXPD6jwMi/p2cdGmAdm/KYBKlzZsP03mP8ZPcD0jS8zVzYKeRUeBf
 L1a1B2g4VhPV22G90ueiaMEvGYMTcUJsnywqbmsisVgFDoeD2dnDkJXqRorGScbQVF9r7/F6JdG
 NwmmkgVTmNp3nEGOYKOkhdLt+3WWb6DVKAdQ/mqzosFsB7yHjvfpDj8cfiaJqdsFM8z68zRE
X-Authority-Analysis: v=2.4 cv=dciA3WXe c=1 sm=1 tr=0 ts=686cefd6 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=QX4gbG5DAAAA:8 a=bcI8x_0Kv5OOx9b6aR4A:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-GUID: byFMLTTMe21bfHd0aJVS_VAgJNuBNfY0
X-Proofpoint-ORIG-GUID: byFMLTTMe21bfHd0aJVS_VAgJNuBNfY0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_03,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 impostorscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507080084



On 6/30/2025 1:13 PM, Muhammad Usama Anjum wrote:
> Don't deinitialize the device context while going into suspend or
> hibernation cycles. Otherwise the resume may fail if at resume time, the
> memory pressure is high and no dma memory is available.
> 
> Tested-on: WCN6855 WLAN.HSP.1.1-03926.13-QCAHSPSWPL_V2_SILICONZ_CE-2.52297.6
> 
> Fixes: 3000f85b8f47 ("bus: mhi: core: Add support for basic PM operations")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>   drivers/bus/mhi/host/init.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
> index 2e0f18c939e68..8f56e73fdc42e 100644
> --- a/drivers/bus/mhi/host/init.c
> +++ b/drivers/bus/mhi/host/init.c
> @@ -1133,9 +1133,11 @@ int mhi_prepare_for_power_up(struct mhi_controller *mhi_cntrl)
>   
>   	mutex_lock(&mhi_cntrl->pm_mutex);
>   
> -	ret = mhi_init_dev_ctxt(mhi_cntrl);
mhi init dev ctxt also initializes the ring pointers to base value,
I think we should take care of them also ?

- Krishna Chaitanya.
> -	if (ret)
> -		goto error_dev_ctxt;
> +	if (!mhi_cntrl->mhi_ctxt) {
> +		ret = mhi_init_dev_ctxt(mhi_cntrl);
> +		if (ret)
> +			goto error_dev_ctxt;
> +	}
>   
>   	ret = mhi_read_reg(mhi_cntrl, mhi_cntrl->regs, BHIOFF, &bhi_off);
>   	if (ret) {
> @@ -1212,8 +1214,6 @@ void mhi_deinit_dev_ctxt(struct mhi_controller *mhi_cntrl)
>   {
>   	mhi_cntrl->bhi = NULL;
>   	mhi_cntrl->bhie = NULL;
> -
> -	__mhi_deinit_dev_ctxt(mhi_cntrl);
>   }
>   
>   void mhi_unprepare_after_power_down(struct mhi_controller *mhi_cntrl)
> @@ -1234,6 +1234,7 @@ void mhi_unprepare_after_power_down(struct mhi_controller *mhi_cntrl)
>   	}
>   
>   	mhi_deinit_dev_ctxt(mhi_cntrl);
> +	__mhi_deinit_dev_ctxt(mhi_cntrl);
>   }
>   EXPORT_SYMBOL_GPL(mhi_unprepare_after_power_down);
>   

