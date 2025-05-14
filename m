Return-Path: <linux-kernel+bounces-648402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54763AB7661
	for <lists+linux-kernel@lfdr.de>; Wed, 14 May 2025 22:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 446C47A5D92
	for <lists+linux-kernel@lfdr.de>; Wed, 14 May 2025 20:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755AB295512;
	Wed, 14 May 2025 20:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HlQB81u8"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B89619D09C
	for <linux-kernel@vger.kernel.org>; Wed, 14 May 2025 20:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747253143; cv=none; b=dy3BnEPl2tJctjaH6oeL/TiNdOAy4L1VMw/ce+ww2iX2JFBXE+BqQ4A85lht604jHtsKTh5XhXlrHq/TUFnTyxR9+266Uso7e1S96PXTo2bURAG3lHoJ+YMvMYaLGbhrQgBIZurqlSaLiqDj2rllZ3vefCiDuOkNpjoz/xfmtwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747253143; c=relaxed/simple;
	bh=IFZ+iX/sQaBQiYQQc8gcbfjyGFq+Lmq4HztD4wulIvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bwn9ZDwTyu4abf5/vOK6/i38+dwGBkeKLELPPD5NjhPs0gPsaiW9pghFbPKDIHI2QT7hKAiVTvnCqxNmXYRWLvGI2hF8n12nSMXKpDlk2nSFWYbgP8Icepo+5CVd0Mr5jsOWO9i0fNuOfXnrvk2C03FOoyO3lKCGZ8qxLcZaHZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HlQB81u8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EJWsw7025453
	for <linux-kernel@vger.kernel.org>; Wed, 14 May 2025 20:05:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0egVoFkhlIxFKQgj4/+4xdNBa7NE99qByFd27WH7Qxo=; b=HlQB81u8h3vfpQmH
	R9pszwc7o4iKCVaVpcpI38BXSXqt6kwCoV4Wsg3RyRMEDG6bGjS5Uzu+YS5eAZWj
	7zYkZK21ZEgZtorGzNtx6/oFF7fvYbwXEW2qf+Dsb9YKi/U7keU9FEOq1yvwXKq4
	Zd7aN3KTNpFd349J8xd5VqCKFltdFetEHwAslQL6bqLRB9nOx/gGMfg+sPh6Ypuf
	olboXxZJTDBUjGUhCDTFlzIPBga3FwrDy33Fa3ho7ps1X9ChqjMV+u6VpPyQmalA
	j5yuckZY+6l4YzTb3ImkYWt/dHVohlpZBgV8EJYN0Xc+VHg+bTvyvyqSj3p8QZ7Z
	f14Kmw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbew3v6p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 14 May 2025 20:05:40 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c76062c513so2539885a.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 May 2025 13:05:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747253140; x=1747857940;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0egVoFkhlIxFKQgj4/+4xdNBa7NE99qByFd27WH7Qxo=;
        b=RmI9iZ6A42iDbymPtbJco0Ndq7pq6lqPY745KEy9On4LGErzIRqBoq96t9PEaHtQRS
         UavU5TR1OkxGnMwFU1/o8bUounyraQdmq3nEhL78N16t2dtJ7g/oFjmtctEgkrmiPANq
         gPqqEZOsqwdA6xaE4E9wyIU1KkfoUE1LWyFo+LFX6EVf3XSlTjR80rnxUT1yXuipDiHw
         xmGK6yOlz5hwHAkNyHTmYrqTLGKdPIc9MHpGiNbdbWu6+SKMPDK4rgWy8QrKbOIcqlFM
         HK8uSEr9n8VZMEtAgsHaKtnlzFJgjlGoW2G5jzuNPdvAW9fFKO18rDZ827vproElj7/h
         s2jg==
X-Forwarded-Encrypted: i=1; AJvYcCWI2FOF7+YESkzoCt3S/wja+2pCiFVvNC7HBS4ZesRmC3Bu9owJi5yDwb3CLFu2QwdvNtIWInbqO3AaVL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKmRpiLSaMZLlrGaEPX59/VI3brE9h+OkDsFvZixqk2exNpT0x
	XkOH48tFz3URL21xxmGcGh9iH5Wajlkc7MoAVdLlG95RgQjLtdTHRkWk+/0gINKcDV1S0nEYGc+
	1EmRcWj87PrgFh1CtL3vNdPDFVYWOpmr9YLGKb6HM+HI9W/AFSxzlzuhMmj67pB4=
X-Gm-Gg: ASbGncv4iSdfAAbkmkdRqO47p2ZuwbZimi99wtTfJjFe8oEQmAEFjm6tylG/j32lqx4
	JHoB0tuwqaCpVVempuhdAqCcJ2WzcOxy0uMxus5IgJA5LIhaOMJKYZckVKWw1zJ5FQcPGL0Nf3P
	6qYrTF5hs9w4L4JAE6ea4U+xNIlHgzFxngyJ3rF75fLsBXapaoGj2E5VMf6EMpbRdOegTkRLVtD
	II60CiqSXbRKTEaXewB236iUOGOhNGn/kgLfQI57DvnvSvKnPwn1vDfuvyu2oUciwyNh+2iULyP
	XxKoHhgM2HmkyGzu+Zcu1btzjfHVk2W80ST3YH49AvQ+Uwm6wDyznWHJkbC4Fsq9Hw==
X-Received: by 2002:a05:620a:2781:b0:7c0:b43c:b36c with SMTP id af79cd13be357-7cd287e172cmr305028985a.6.1747253139867;
        Wed, 14 May 2025 13:05:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFf8UD3BUMMgFpbToJEXmlzYBN1m9L8+A/f6qEFMV/uyiI1zpi1wE/usnt5J2H9YM2otSN8gg==
X-Received: by 2002:a05:620a:2781:b0:7c0:b43c:b36c with SMTP id af79cd13be357-7cd287e172cmr305026385a.6.1747253139440;
        Wed, 14 May 2025 13:05:39 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9cc526b2sm9665865a12.47.2025.05.14.13.05.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 May 2025 13:05:38 -0700 (PDT)
Message-ID: <9a05d545-1bf2-4f66-8838-b6969ba37baa@oss.qualcomm.com>
Date: Wed, 14 May 2025 22:05:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFT v2 13/15] soc: qcom: ubwc: Fix SM6125's ubwc_swizzle
 value
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20250514-topic-ubwc_central-v2-0-09ecbc0a05ce@oss.qualcomm.com>
 <20250514-topic-ubwc_central-v2-13-09ecbc0a05ce@oss.qualcomm.com>
 <lkkwnmnk32igcev3gykmtxsohyskj6ehylaypg2dyxbedvksee@lnuc4lfmzrkm>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <lkkwnmnk32igcev3gykmtxsohyskj6ehylaypg2dyxbedvksee@lnuc4lfmzrkm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: LmfWxk0zNFOwVvMXTn05e7uhWg5vwOC9
X-Proofpoint-ORIG-GUID: LmfWxk0zNFOwVvMXTn05e7uhWg5vwOC9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDE4MyBTYWx0ZWRfXzAfE5SCscAly
 i1hB0dtN6FG4WfovyCaPt6vWOAet6FwobswSSU22Md4Dqva5YHAtu+cyoYj/UFJtTbyeV0GTsVn
 Ic8b2LbSTDzUdNqLRNkh4PYl64EXINM3+kxUw3gDbLFimi4vwcnZsAJizzaoGC7hJt0kKfnGnvi
 oRmipFRzpjUG1FXOnhryitLw+VFoRdxrMakpII8ozyDGniOibQM1rc374INZiITNPAxFL0Xl6CC
 BKVoO1/ZhTnvmHdlmxsuHW4MAJ8NlB3uPyfUwqvTJGOxwP5oEvQ+faXwGiD8D75O59czBS+Ntb9
 8OhfYrqo9+27lJMPFkqXQ6GBoRhBH8J47YSM2bnjyQETATBnh/XK3VLmTyN3/z0A9ENwr6vGaUv
 uuRZ8wRn2EmgE3WtaFE6Ia2d4CaZng7gcUoyd5KSvqGicCY4bOfbQjMg7zZGORvxR4s+lO7+
X-Authority-Analysis: v=2.4 cv=LOFmQIW9 c=1 sm=1 tr=0 ts=6824f794 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=q9V0nb-VcvmKcQyn-R0A:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 impostorscore=0 bulkscore=0
 clxscore=1015 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505140183

On 5/14/25 9:23 PM, Dmitry Baryshkov wrote:
> On Wed, May 14, 2025 at 05:10:33PM +0200, Konrad Dybcio wrote:
>> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>
>> The value of 7 (a.k.a. GENMASK(2, 0), a.k.a. disabling levels 1-3 of
>> swizzling) is what we want on this platform (and others with a UBWC
>> 1.0 encoder).
>>
>> Fix it to make mesa happy (the hardware doesn't care about the 2 higher
>> bits, as they weren't consumed on this platform).
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>> ---
>>  drivers/soc/qcom/ubwc_config.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/soc/qcom/ubwc_config.c b/drivers/soc/qcom/ubwc_config.c
>> index 9caecd071035ccb03f14464e9b7129ba34a7f862..96b94cf01218cce2dacdba22c7573ba6148fcdd1 100644
>> --- a/drivers/soc/qcom/ubwc_config.c
>> +++ b/drivers/soc/qcom/ubwc_config.c
>> @@ -103,7 +103,7 @@ static const struct qcom_ubwc_cfg_data sm6115_data = {
>>  static const struct qcom_ubwc_cfg_data sm6125_data = {
>>  	.ubwc_enc_version = UBWC_1_0,
>>  	.ubwc_dec_version = UBWC_3_0,
>> -	.ubwc_swizzle = 1,
>> +	.ubwc_swizzle = 7,
>>  	.highest_bank_bit = 14,
>>  };
> 
> Add a comment and squash into the patch 1.

I don't think that's a good idea, plus this series should be merged
together anyway

Konrad

