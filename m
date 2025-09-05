Return-Path: <linux-kernel+bounces-802103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F092BB44DA7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 07:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4EA017E8A3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 05:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF2E26F2BB;
	Fri,  5 Sep 2025 05:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eL9N0aeC"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FF52641E3
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 05:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757051078; cv=none; b=WMlCgxizskyZn3BgJJQz8c86Xfg6ZSLHGnTxxYA7zpmHMlE9vuL9CObWtxAyVodvukXOUIePxiHJqMHzKTGvTk81G0ZIqxFlGPXkojLV7/bGCmqguX6M9x4oXplZOy2caS+fn6ZJBjwfW/YUudkj2jJ66yYZB0BijcsqNDA4J/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757051078; c=relaxed/simple;
	bh=l2K9hkdSGW3vzFGYLomASCSKhDoFegz/q+JLfFhJDQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tag0xlfmrShP2rNSP+PF3zmGfplmSEgt+TneeGvZLgpvB860RZpgm+fS+rIh8h1E+xmZVazUHLm1ApHdUtgSiIYaP2bW1PpVaCxg4K8sX94s4VAaBRwoO+wc4YnfHMWyOpVYlqEVyY85WMmKpQp9RPwmutqXe2jhZ129tKqSaJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eL9N0aeC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584J3eFF022976
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 05:44:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ms0JkJGzKTaaIXjP6AglLat7tx0edPS44Ql4Yb4cQWI=; b=eL9N0aeCzJytClEt
	7mGIZwOjR9emg1aa1/VwbQnpG+J8btAILZ0e3PjSBt0c7kuW9JAJBL3/DmGVGP4V
	MEB3ljw3IPuhbd+1tNwxSJ+PU2ayX38C3mjKppS/HnsdzAuBPIo2XKDeD/ebaGa/
	OtxCYPbqMDtP4vl8TXnbKRKOrgxFnaU8OyygOcC0krmelkTamdsqDgEE/Ui8R0JC
	ywHDOQ3kblQRqOhz2DbKQtX7u28PE72npt3jqv/GIxndap0dmW0Eiq91gyzMlvm7
	NmVWv56zdWrzvxzbgfjvDmiHXuCH0UyqBmZHTN4zHnOF20e4OdkV7Fb7HLijpUJM
	W2wypA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uq0et4mq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 05:44:36 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-249118cb74cso21579325ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 22:44:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757051076; x=1757655876;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ms0JkJGzKTaaIXjP6AglLat7tx0edPS44Ql4Yb4cQWI=;
        b=SiIsAKS2I5PBGi+MN9F3oFIN2hzHTLDE34TMKmd6LeI0uetJRXHWtLLpnPZgRfkFG6
         lNcMwamxRRfiG2IrnuSoKOp7spIsjzCn1FVkv/2GZ+omMWMi/EFIdR9tH68Wd0fJ2oxX
         FAygFQWtKIU5iszY2BxYdcANK6AmNjfUyBeC6fHbWZWpKodnxd+rGJjJH/ZpJ85Y6KcZ
         WXDb6YwEP40uDP0CKenhLDvn3/hY2CkZdLPEhHmGXbkyMN3TMjFGb9Z0cP92jodRGXq7
         8rPYkhPfjMIoQbO1SUvjXp2SsDxRKax9cuYLN78wJnqaAS1DYXTSKxKkOy9SwAXsJNAc
         r6Sw==
X-Forwarded-Encrypted: i=1; AJvYcCUeJ2Vn32FzeIp/g/92DTL//9Mzm7aMMLFXr3b57+qlvwq88Jhhb7as2ZpgAoe1UEKLAKFqsLaHH6unpj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEALxW7Hm8rkS7cGJqnMbToVI4z+QycKPZNI72VIXn5Z9F8A6U
	UiO7C2Gg5rqy/JFvwBStkmRogA998JMu3l3oTY1UAD0gmpXdqI04UkN27/FixB/o6+2usqO/or4
	j3MNdKjGnfXDpPZehQzM/T0GrxYzLPdel8wkU6qv+qKSslPT+KC+YGKgDWt8qqxvbr54=
X-Gm-Gg: ASbGncsMseFTpA7bIErWXbriUYMdPkIRfxW1W220re7hL81FT00Z55Tzqgp4+DdogQN
	y3sdQlw2dbSu7j0EUeMaZKtuCmGNB3s6aNME2+UuSizBuaY6Qj5G3RLu149upVojJuyDGBCjupp
	ZgWv6G3skfFkwqXhFNii908FBGKu8OdvxO45R5iis6fcMmz3hBKwBSflCeVqSitfAoNHQc6EsUl
	zw7IqerYEA3EBEGHnUC8+BbhioCuC5Tr7spdXb6XYC82ET9WR6RzVRSc8VKGNsG/vm9h79Vo+EW
	zsI8aQyLJoobrog6vCfHhYgZyLK0vnN122qpHJ6oQ+LdTgXKDs1W7nKEMRdeTDP1MkA4wzZBMw=
	=
X-Received: by 2002:a17:903:19eb:b0:24c:c8fe:e273 with SMTP id d9443c01a7336-24cc8fee5d8mr71914435ad.7.1757051075754;
        Thu, 04 Sep 2025 22:44:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRJUcOuTKyrOxFLUCjdl9XJd/rnpeZLAb9neaQ8aeqiBCGunSyzzjqZ5ctTOwZOmAqKHh8Lw==
X-Received: by 2002:a17:903:19eb:b0:24c:c8fe:e273 with SMTP id d9443c01a7336-24cc8fee5d8mr71914135ad.7.1757051075247;
        Thu, 04 Sep 2025 22:44:35 -0700 (PDT)
Received: from [10.218.42.132] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24d17d6b694sm9499055ad.136.2025.09.04.22.44.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 22:44:34 -0700 (PDT)
Message-ID: <e825026d-f365-4e95-bb1f-3eec5f0a8305@oss.qualcomm.com>
Date: Fri, 5 Sep 2025 11:14:31 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Fix potential kernel panic by calling dev_err
To: Adam Xue <zxue@semtech.com>, mani@kernel.org, jeff.hugo@oss.qualcomm.com,
        quic_yabdulra@quicinc.com, chentao@kylinos.cn,
        quic_mattleun@quicinc.com, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: imocanu@semtech.com
References: <20250904183405.32986-1-zxue@semtech.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20250904183405.32986-1-zxue@semtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: XJERygJs3CTyz4bWUrBVAGnVWlqwvK8g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwNCBTYWx0ZWRfXwrJaiEGKqn32
 6AjHYbQF51tXcJHrCFX9zKDpHvOUl2A2i54MnPfv/IoT9wRWnJCYNX5kyCX/7xYq0+edNjSv7lR
 3ZlATP+AumVbJ/sHkGPYU6fUMUQzdn2gdUtDhkD6JQJ3v40OXtkcZ3MAMVbwGqMJqnsU89vqVmO
 nyek6Iwi8eyEGt3aulR2zeXWcmHUBiT2rLyxvh9amnYGVwj7k3lcK9i70pCunJNhVG4RaXfI+Nz
 v6uF+1tMgPJs7bQl+4gPWqRrKIVh931WaEPtrSVOxgwOigbhLjJy82fALsencjdmE1m747n9Kew
 PJhid8DvqFptcJMd02qnh2qgJOiSqrqoWDpbFXdlUTvaTLWth6XaUUfcW5qVhr+t5BnkK7JAeIn
 R4OzPRVK
X-Proofpoint-ORIG-GUID: XJERygJs3CTyz4bWUrBVAGnVWlqwvK8g
X-Authority-Analysis: v=2.4 cv=ea09f6EH c=1 sm=1 tr=0 ts=68ba78c4 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=SfXQzQb2AAAA:8 a=EUspDBNiAAAA:8
 a=7zsGc3PXLyXOka2lzKcA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
 a=187EmVsF5pRpP46aC3wK:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_01,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300004



On 9/5/2025 12:04 AM, Adam Xue wrote:
> In mhi_init_irq_setup, the device pointer used for dev_err was not initialized.
>   Use the pointer from mhi_cntrl instead.
> 
Don't we need fixes tag.
> Signed-off-by: Adam Xue <zxue@semtech.com>
Reviewed-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>   drivers/bus/mhi/host/init.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
> index 7f72aab38ce9..099be8dd1900 100644
> --- a/drivers/bus/mhi/host/init.c
> +++ b/drivers/bus/mhi/host/init.c
> @@ -194,7 +194,6 @@ static void mhi_deinit_free_irq(struct mhi_controller *mhi_cntrl)
>   static int mhi_init_irq_setup(struct mhi_controller *mhi_cntrl)
>   {
>   	struct mhi_event *mhi_event = mhi_cntrl->mhi_event;
> -	struct device *dev = &mhi_cntrl->mhi_dev->dev;
>   	unsigned long irq_flags = IRQF_SHARED | IRQF_NO_SUSPEND;
>   	int i, ret;
>   
> @@ -221,7 +220,7 @@ static int mhi_init_irq_setup(struct mhi_controller *mhi_cntrl)
>   			continue;
>   
>   		if (mhi_event->irq >= mhi_cntrl->nr_irqs) {
> -			dev_err(dev, "irq %d not available for event ring\n",
> +			dev_err(mhi_cntrl->cntrl_dev, "irq %d not available for event ring\n",
>   				mhi_event->irq);
>   			ret = -EINVAL;
>   			goto error_request;
> @@ -232,7 +231,7 @@ static int mhi_init_irq_setup(struct mhi_controller *mhi_cntrl)
>   				  irq_flags,
>   				  "mhi", mhi_event);
>   		if (ret) {
> -			dev_err(dev, "Error requesting irq:%d for ev:%d\n",
> +			dev_err(mhi_cntrl->cntrl_dev, "Error requesting irq:%d for ev:%d\n",
>   				mhi_cntrl->irq[mhi_event->irq], i);
>   			goto error_request;
>   		}

