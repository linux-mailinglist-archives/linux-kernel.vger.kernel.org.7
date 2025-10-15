Return-Path: <linux-kernel+bounces-854311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C00BDE138
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 12:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5777480FE6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 10:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8631B31B819;
	Wed, 15 Oct 2025 10:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gw+DwNSx"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FB3315D4B
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 10:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760525271; cv=none; b=LzybUHozlkyNYPdfSPlDt0uUbcUMUA0zqbthSrsubM8Rz5YReBBl/Eb92/eD03dVTPLaAkmHKOK0KoTrIG253WqHMryi0zw84AlO8Y0VYCGhG09QOWPw/RelydDLTZFmyhjw8eSZNjZu1hMafxsHRsjV6CsefuXwv7UxPjp3E6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760525271; c=relaxed/simple;
	bh=Z/+W43/kgGZy+ENnnhS/XSfFbJZCLvOI+kuHbmyg53k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Td+Cf/mA1QFR3SBSp6M2Vf4GZvRSaDTo1dqFShH54iUx/x+lLo4wj17i6a1Wejc2Jtz2LWEUhI6qC8TuzH29IJYhGQT6guiEflpCDg6sgOkWgHsF2neZCMTQ9wSujr9b4t1HdRQHHOd/rvWghzleHjpiyZPifcm6xidrUi+NE9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gw+DwNSx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59F2s9mh009128
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 10:47:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AZJrvGptOrqMXPxOcK2AJ2pnSX3xUzKaHvxbZnXr0gE=; b=gw+DwNSxlGiCxlmC
	Ex0JbeWJ3ZjFv2iPiIcE2ibawqIMmixh58og6wTMvs5xC5TLkQH4UrhE2f/WwWZp
	u4Bj+r5fKHw+9BMXymEBao88hVRV9YGemE3bA39QSgAiXM87s2yCA1KOEb1plOpD
	RRv0Q3a0w3Z7MqrLWAWXFHhTuUk9lGcYEjeDCqLCDJDxH8516jRxkJI+p6AZQYnf
	OIIspFfdbP8S7g3PJmTfZZBK+1Y8ko5JFR9mnHl5yZgFGVVZnsDZirAOPO0RAZ7v
	4svUtHd0ihI0m91n7ZTKi1pCSBczNZk4ksPn0iO2GIcrpU/dYUlurPRflnn+8KnM
	+/tbIw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qg0c41qb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 10:47:48 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-78106e63bc9so8626437b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 03:47:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760525267; x=1761130067;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AZJrvGptOrqMXPxOcK2AJ2pnSX3xUzKaHvxbZnXr0gE=;
        b=VUEPI9+jOfjKnlEzXWDwa/arl+N5oqL9JrkCPoTqDtxjeovxAF6jja2OY+F5L0uSyl
         oyLaNXfZvISvcKCdy43PkBt7mxjtOTsdEPxQwKQ0y77xK8TRh7wKVzEzcXjCVcupeuUr
         z1rSb5tf7RmXs80ooGZocfGSuNDtNKQqpngniHf9QaLeQeIwVdmm4O/j0K1JFJjff0vW
         abU5PnfCaiI8E5Gp0hwuAxNgJ8ltQAmXTLjL+9JJo12p3AW5Vyq93UCd27Yhph5HpYCq
         hUtT0tZX30gljwxJ7v/KMrNJSSiHr6Xf36jdQQgWQx6RntI6GvkkxgCe5tCXCJ4yM+/g
         xrcA==
X-Forwarded-Encrypted: i=1; AJvYcCVSYeWHUxUv1o4aVsqvmCnsUYXwjA1bjxUhx94a/jQzXhMKzeMnxqCQLB/ReSPUXpUOAn/O80mgPjauj8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrBTwVgOgsD6+pM5jXavTBC7zY6F8i2jJUKbQn4F95UzfuHxdN
	J+ujhMGQdQHjzI5RGcZYMFhFaJn7usAjTBfh8gaNSSpR2rxQwjPQeUsUY31UcT+kgI63O1lJngz
	o5xjH0fZdvtDS7Wh7pAA14HT6/lyKJuug7aS3a4Q2mxHmKZXWdjY/Uhc1DZTNngZvWvY=
X-Gm-Gg: ASbGncv7SLOvJxAaqKSZqN7NBDerpBRmKcNrikRuJxxNR/6sJKoUNohT3t2gQQQcpLO
	EuFPfNTghSD1J2pnZJP9kdabktuHNKaiF4KJFIx+chOa+wzW37jYg5RYrERlNDVBaNkCzsB4ffK
	X/kasnIR7iKGOp/lskpN7ZfDjiDW64FAjdoOboAPgPdiYXvne/JJX0bZEPuiTm3K/xLH0rGujKJ
	J+XdNSRyTHTeMFb5G2KH6rm+s9YtLvUzu7+O5guJGetMe+jY2wwbhiFBpHW5r6SHqj9KDqWrgqU
	DpaWoqQxQROahaw8JAZ4RFQyjlAFxst/vBu8fvZj/a/K4AdwWJL4jZKBXFU7bKJtYDePyci5
X-Received: by 2002:a05:6a20:6a06:b0:24c:dd96:54f2 with SMTP id adf61e73a8af0-32da81393f5mr39849150637.1.1760525267446;
        Wed, 15 Oct 2025 03:47:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGd6TU44teoR5OvLjOqJ/FtQbppc7nt+u/aqL5WddhJGIWMv34ctNW6A7b1YLMaWOrgl3CC+A==
X-Received: by 2002:a05:6a20:6a06:b0:24c:dd96:54f2 with SMTP id adf61e73a8af0-32da81393f5mr39849118637.1.1760525266962;
        Wed, 15 Oct 2025 03:47:46 -0700 (PDT)
Received: from [10.206.107.23] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b678de09cb3sm15634186a12.18.2025.10.15.03.47.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 03:47:46 -0700 (PDT)
Message-ID: <0000ffec-c17d-40a4-950b-5cafcbbad5ac@oss.qualcomm.com>
Date: Wed, 15 Oct 2025 16:17:39 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] misc: fastrpc: Update dma_mask for CDSP support on
 Kaanapali SoC
To: Srinivas Kandagatla <srini@kernel.org>, kpallavi@qti.qualcomm.com,
        amahesh@qti.qualcomm.com, arnd@arndb.de, gregkh@linuxfoundation.org
Cc: quic_bkumar@quicinc.com, ekansh.gupta@oss.qualcomm.com,
        linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        jingyi.wang@oss.qualcomm.com, aiqun.yu@oss.qualcomm.com,
        ktadakam@qti.qualcomm.com
References: <20251015045702.3022060-1-kumari.pallavi@oss.qualcomm.com>
 <20251015045702.3022060-4-kumari.pallavi@oss.qualcomm.com>
 <2a6319e5-15e5-4cb7-a2f3-7521383fc30e@kernel.org>
Content-Language: en-US
From: Kumari Pallavi <kumari.pallavi@oss.qualcomm.com>
In-Reply-To: <2a6319e5-15e5-4cb7-a2f3-7521383fc30e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: bJ2V5mbwqYHL6moc_7LolrHiUEsNLXHo
X-Proofpoint-ORIG-GUID: bJ2V5mbwqYHL6moc_7LolrHiUEsNLXHo
X-Authority-Analysis: v=2.4 cv=eaIwvrEH c=1 sm=1 tr=0 ts=68ef7bd4 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=66apGkFR6lJs1WKMTdsA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyMiBTYWx0ZWRfX8/n9/958G6G0
 tdr7UoXe9a7vzjc/VY08baiSNkMAShhZjxIHYSzovrH631eurvOwGQx7gsKAJaLBM7IMwcukCNo
 unDFielAQY1tpo6nzYpVEBDwL2lVd7YUWFhXeVJxgQY19vt3qUTIVLLBUkn1K+z/v31ioqj74iG
 zYMP1AxYR4JbTfHnnOE0E85RrjJeZpgMww9WqYB8gwo8ST4UTjF1KPxDRhtDpXixrdrFafG8srV
 gEOc5n2G4eO+ZXxqV1taVfOlMTAJTg6XSsB8u9qpf732rDqOpDAZlkwpZFSDnpaGgrGjgKfMfhL
 eJBbO39Cpdle9sZNI4FhSC+25iw42ttP3ygMl1SDPa4RFJqZqnSS+m6qd5KfgMwK8BhD1fufBSv
 X4xf+M3MTes74LoRCKNImqfXUYMKtA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 spamscore=0 impostorscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110022



On 10/15/2025 2:55 PM, Srinivas Kandagatla wrote:
> 
> 
> On 10/15/25 5:57 AM, Kumari Pallavi wrote:
>> DSP currently supports 32-bit IOVA (32-bit PA + 4-bit SID) for
>> both Q6 and user DMA (uDMA) access. This is being upgraded to
>> 34-bit PA + 4-bit SID due to a hardware revision in CDSP for
>> Kaanapali SoC, which expands the DMA addressable range.
>> Update DMA mask configuration in the driver to support CDSP on
>> Kaanapali SoC. Set the default `dma_mask` to 32-bit and update
>> it to 34-bit based on CDSP and SoC-specific compatible string.
>>
>> Signed-off-by: Kumari Pallavi <kumari.pallavi@oss.qualcomm.com>
>> ---
>>   drivers/misc/fastrpc.c | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
>> index 1a5d620b23f2..f2e5e53e9067 100644
>> --- a/drivers/misc/fastrpc.c
>> +++ b/drivers/misc/fastrpc.c
>> @@ -267,6 +267,7 @@ struct fastrpc_session_ctx {
>>   
>>   struct fastrpc_soc_data {
>>   	u32 sid_pos;
>> +	u32 cdsp_dma_mask;
> How about making this an actual dmamask ex:
> 
> 	u64 cdsp_dma_mask == DMA_BIT_MASK(64),
> 	u64 dma_mask == DMA_BIT_MASK(32),
> 
> This will give more clear picture of what is going on,
> 

The current approach of assigning a value to cdsp_dma_mask allows for 
adaptable logging behavior, making it easier to trace.

> BTW, these values are not set in the patch for some reason for both
> default and soc specific soc data>

Ack.

>>   struct fastrpc_channel_ctx {
>> @@ -2178,6 +2179,7 @@ static int fastrpc_cb_probe(struct platform_device *pdev)
>>   	int i, sessions = 0;
>>   	unsigned long flags;
>>   	int rc;
>> +	u32 dma_mask = 32;this should come from default soc_data, do not hardcode this here.
> 	u64 dma_mask = default_soc_data->dma_mask;>

Ack.

>>   	cctx = dev_get_drvdata(dev->parent);
>>   	if (!cctx)
>> @@ -2197,6 +2199,9 @@ static int fastrpc_cb_probe(struct platform_device *pdev)
>>   	sess->dev = dev;
>>   	dev_set_drvdata(dev, sess);> +	if (cctx->domain_id == CDSP_DOMAIN_ID)
>> +		dma_mask = cctx->soc_data->cdsp_dma_mask;
>> +
> 
>>   	if (of_property_read_u32(dev->of_node, "reg", &sess->sid))
>>   		dev_info(dev, "FastRPC Session ID not specified in DT\n");
>>   
>> @@ -2211,9 +2216,9 @@ static int fastrpc_cb_probe(struct platform_device *pdev)
>>   		}
>>   	}
>>   	spin_unlock_irqrestore(&cctx->lock, flags);
>> -	rc = dma_set_mask(dev, DMA_BIT_MASK(32));
>> +	rc = dma_set_mask(dev, DMA_BIT_MASK(dma_mask));
>>   	if (rc) {
>> -		dev_err(dev, "32-bit DMA enable failed\n");
>> +		dev_err(dev, "%u-bit DMA enable failed\n", dma_mask);
>>   		return rc;
>>   	}
>>   
> 


