Return-Path: <linux-kernel+bounces-830742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD81B9A701
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8740F17C656
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB11430AAB4;
	Wed, 24 Sep 2025 14:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GmqeUxUL"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECE7221F00
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 14:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758725834; cv=none; b=HNaNiTA+ccv2idmWxBZvzmDNpZcKnnmVu0/YRf8pmbwG7+CdIlif29JA5jQ80kghrZn3WMng1BAHnNSQ2ebJqaKohDVhKjHPapXUQymIw8XRAmBoosZPpmAPKLHNtMlYzBTUoa/LnnLQjI8ha4dYhqTO2utYFyf8XLuMNw5IwFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758725834; c=relaxed/simple;
	bh=egQMVWXofRluc+O3XNLhjP9Calab+RJ26V1U0vRAXkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jq6Tii1o5iXc9B0kMc4C3FpHmEKGdDxFUSOTyHggsbxkUW0aFClv9QvmAEccuIMicY83oRvoF5LXqLhvLVg0TTN3Sk7j7gs3sb4aAvuEmXZ8c+FTzwyalo+F8nCKLkUHTOn5Avly/TAK+FyA/Q52nGOqw7X4+nJOHHm0IbtY2bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GmqeUxUL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ODb2Qg019952
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 14:57:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ckyGnU4M2Rx7XqkYDdLLQ35Tz4lqFcFTvWIE7FLlHNs=; b=GmqeUxULT0MKNMZa
	kT3Wjtu3jdiQvTc+lafWiA/wk+n9rkUTdB1SesDLHcaG/aRBvz97QyoD038SJ97j
	W5TPT079T5u25+o72X2GoEsizAGRXDhdBTQxSSO913dLvKuFnwfqHwytfLH2J6kW
	f0yLiF592DI9lvlG98gTa+ZuV53dTmDRrgKVZDvSvLknm35um30H0710BUq3j9qP
	rm5zvRzWX1CPh1Ne4pNHqfcyGJfx76X/vbnnY3yJ5R8UeT317SMN2CFZTp6kUhP1
	k4auf7tqvFJwHyDpkA/dBodUl+Knqi3y5vfnlucZGsv9sEW2QStzm3gYJzjPga7V
	B4QJhQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bjpdwwwn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 14:57:11 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-7958a07a5fdso951516d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 07:57:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758725830; x=1759330630;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ckyGnU4M2Rx7XqkYDdLLQ35Tz4lqFcFTvWIE7FLlHNs=;
        b=X3VWt4fCJhd7QlXfxRTaFWf0PLLtQThgrpnbU0Mp8Yyj4K0LaQ2ZxGuyQYldpyVl/J
         e4epO5t0joLQzfIbeWFy8hqdFLLZuVSaMY5ImDID30QvMvYOJgYto7DoJ3BhB/gl0HSY
         W6upwoOcTIhhfagpAQGpP+9nDPxMdq54HtKs+t5MJXHdMuaSs6WclpyfV9vnlbodiPkT
         2/gUEbr1DlEDhTWFX1HoVexYsyRDsfLyqDcEVKi14fgx+kCsGwXxhuxnA3OzVAqQpr+f
         OWyNAlqGAICyKCo3oDBzPsBbQ2qXJWXSjYbh6PrkOorpvwNccs6sPkhMhHlaIkRkryXG
         uGbg==
X-Forwarded-Encrypted: i=1; AJvYcCUI1wFV9Vp72uriGE6xW3hZbYguL/ClYLNfbuJx5W6u0qSjD7YxbjWO5NEdTlpqfOakJldE5O1ADxtqS0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI2fCzZn334WAkYm88UHkFJZSF7Jrdp8hywPkoO+gcGJUDlm4V
	2wvJxl5Jv1Ng/ddlH1ntddjUbC+0AW7fpmHbuyNgRTBVRtu71JyAQCqQjP1M6swzS4LPmzVFDq4
	jPiXTiQibJuaLYQMtm/bV9MBW0HJ2goN8bllFx+5dgquyeP1nrm8y+ufHm+2xK/N5IYAfeQua2/
	w=
X-Gm-Gg: ASbGncudmXMV1L2qO4pPshg4krC+/PLdMtaoDsuSjTnBw2ZeCdIF9uKNuQxbz0WiXEf
	3XHHa3wxyA1OzjDUhaA8qt+31luD4RlFCW7h3jwoSeGEamJLi3pSRKN4rXSo3vEAupfXcOsw0Oa
	wzruKwneKYXy6B7w0ZpjO7egIxg8JF9Q2o8MCbtAcrhpdwgtr5dTKsF5vFQj4bpHYJtbpcCFISx
	7hBHXuMJTsNuzqwgHwa8h9SMT3xjRvyWoxXPHNMB45SrmjJo8pXe0OSyTNPPlJyXVEvPf76pq4p
	83NlFfsTwhRzcBtAy4vSfFYgZpWMF0/N3erSU8trm7b2C+DY3Mi1v7wiobwP2ycAmL5O2hCZpNv
	pqgmAIckao9cKVPiD6ftGSA==
X-Received: by 2002:a05:6214:2502:b0:7a0:a767:a178 with SMTP id 6a1803df08f44-7fc0eab2cb9mr3300406d6.0.1758725830013;
        Wed, 24 Sep 2025 07:57:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGO2Vs3swRlyTQ8GDhqQm+/1/ktn7C9+edXnhTJgkKpujjA5KbntbkQppXM7aYx9IqAay9SnA==
X-Received: by 2002:a05:6214:2502:b0:7a0:a767:a178 with SMTP id 6a1803df08f44-7fc0eab2cb9mr3300156d6.0.1758725829452;
        Wed, 24 Sep 2025 07:57:09 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62fa5f1221fsm13219669a12.32.2025.09.24.07.57.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 07:57:08 -0700 (PDT)
Message-ID: <bb25208e-a6a6-4a81-9dd5-5c5eb1cf16b4@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 16:57:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] soc: qcom: smp2p: Add support for smp2p v2
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Lew <chris.lew@oss.qualcomm.com>
References: <20250923-smp2p-v1-0-2c045af73dac@oss.qualcomm.com>
 <20250923-smp2p-v1-2-2c045af73dac@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250923-smp2p-v1-2-2c045af73dac@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: gMGwOqNF6kDgm48dFVYdX-6E6Ce61i3C
X-Authority-Analysis: v=2.4 cv=Pc//hjhd c=1 sm=1 tr=0 ts=68d406c7 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=Fh-lqomsUFxGDEjQWKUA:9
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: gMGwOqNF6kDgm48dFVYdX-6E6Ce61i3C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDAyMCBTYWx0ZWRfX+ADW/U4V3TzI
 55d39aYKi+H5KsB6c/Uiwz9BK3S8QVioxMhcEGEvze5o02sixcCDfjFAi0ce2OXVnZOPVjcfMWZ
 jegWOwidE9VGR0neRdULQiONLgX1bh95qxaoVBrZqEGxKoe6czCM4lCmG2HQn4tHUWDS51OpSdg
 mxP9S2l8SGpwEtAmZa3h3JVfXJsRxETwCJ8jOBz7tal1edwgcfM8Oxt2HZTbR+ooaFsRFrdB1UN
 Yy3WNlRwX2/w10mAKsWLhkr+MFrcjt9g5rs0FKHFi8cUKQcWoo31MlV0PDWF9sFCJoVOdCRMekq
 o/0hoox/K5MwjkuvlwXIwPmwixAxxrjkATJC82ba1WUKKHZh14i200fTzc198YtZHf4ylg2lR7h
 h5YFbKEK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_03,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 suspectscore=0 clxscore=1015 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509230020

On 9/24/25 6:18 AM, Jingyi Wang wrote:
> From: Chris Lew <chris.lew@oss.qualcomm.com>
> 
> Some remoteproc need smp2p v2 support, mirror the version written by the
> remote if the remote supports v2. This is needed if the remote does not
> have backwards compatibility with v1. And reset entry last value on SSR for
> smp2p v2.
> 
> Signed-off-by: Chris Lew <chris.lew@oss.qualcomm.com>
> Co-developed-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> ---

[...]

> +static int qcom_smp2p_in_version(struct qcom_smp2p *smp2p)
> +{
> +	unsigned int smem_id = smp2p->smem_items[SMP2P_INBOUND];
> +	unsigned int pid = smp2p->remote_pid;
> +	struct smp2p_smem_item *in;
> +	size_t size;
> +
> +	in = qcom_smem_get(pid, smem_id, &size);
> +	if (IS_ERR(in))
> +		return 0;
> +
> +	return in->version;

are in and out versions supposed to be out of sync in case of
error?

> +}
> +
>  static void qcom_smp2p_start_in(struct qcom_smp2p *smp2p)
>  {
>  	unsigned int smem_id = smp2p->smem_items[SMP2P_INBOUND];
> @@ -516,6 +542,7 @@ static int qcom_smp2p_alloc_outbound_item(struct qcom_smp2p *smp2p)
>  	struct smp2p_smem_item *out;
>  	unsigned smem_id = smp2p->smem_items[SMP2P_OUTBOUND];
>  	unsigned pid = smp2p->remote_pid;
> +	u8 in_version;
>  	int ret;
>  
>  	ret = qcom_smem_alloc(pid, smem_id, sizeof(*out));
> @@ -537,12 +564,14 @@ static int qcom_smp2p_alloc_outbound_item(struct qcom_smp2p *smp2p)
>  	out->valid_entries = 0;
>  	out->features = SMP2P_ALL_FEATURES;
>  
> +	in_version = qcom_smp2p_in_version(smp2p);
> +
>  	/*
>  	 * Make sure the rest of the header is written before we validate the
>  	 * item by writing a valid version number.
>  	 */
>  	wmb();
> -	out->version = 1;
> +	out->version = (in_version) ? in_version : 1;

= in_version ?: 1

Konrad

