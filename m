Return-Path: <linux-kernel+bounces-832026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 429B2B9E2B2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 11:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FBE81BC29AA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEEC3279DC3;
	Thu, 25 Sep 2025 09:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IbXvGQX8"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36002191493
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758790883; cv=none; b=ORlkhSrSqbiBF+or6ZJovegR2MULlCGQ8hFtti6jMw6H/dm+KJVqhKbc+khNoCMZk/dSdfzygjn+4FfcOJoFSlkL/7ooCuHrVQN8V786PtNlPwMIE/HQNjGMrGjVSQ6/WipooHH/RGCrKLfQZttb8g0VGvyayZ7nHII8gHbqSkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758790883; c=relaxed/simple;
	bh=EG/AvOrhHFN3S+Jj8IoZt9yabjIQcx+99yVd/FA4AFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G0A7W5amyz6uo6iGSMSnqdRwq20l0i50RIPT2d0JZWo+uFWLUfVn4AU0CoCp58u7jrN0kuPs1lS9/Bcqa4OPSPRCootQOhTqG0DVz/I3RyPtssLS4A8AnRUF1c7rOqehtHx6O7XvOFhTS6yYzxBAx0pgYbAne9NZr+h6eaSrqZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IbXvGQX8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P0sC0e025108
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:01:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nErVNH97ngZj0wOMSCyf5gNqUyVQBeaqG4w7YWWN0t8=; b=IbXvGQX8V1Ly1SAK
	QCenpoRmD7G9gW4DKCPihkJS/26uFuWTsY6DzaXaowj2MkajtHnPhckRXIhbNr8M
	ScsW56gf5klrc2IdAi5BPEjQbsM0bGkPUQzNrIca44ofaRXwmLdOgDBPgJNyaf+9
	rLPO/o0CrnXMYEhtxQ8IIZaC6eklBZsbwUZkLfJx+LXqRLMs4cV1FNKzvmuyZC0t
	Gfe+Agllrq+uKgiTpepP0eC4MH7JWZNP+kiKFr7sVdk6RSR2uEINPQbpbSqY4hkf
	WHFpFDqkOpzVFdo1qeSIhlLo+IvIJIRw/YQjtiZFa5U/gzU2P3EJWxgQnftXOL8r
	5UgDjw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499kv17fw7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:01:19 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4dc37a99897so41301cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:01:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758790879; x=1759395679;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nErVNH97ngZj0wOMSCyf5gNqUyVQBeaqG4w7YWWN0t8=;
        b=HGx8nHyiLXSCudPhGMNL9dbi9njlN8m3SELg6y5aRGo4nrm61zz3tst3iYCl17Lrzo
         HGFLygHqy3BMEW3ehzbwzAY1ioBnPEgI2wxQirtaDYDotNIVX5X4y+dkeqMZUBjLShhx
         vQl7wMLT1xLk6H4QXsrVjoQmGF2Yi8hXW2OcfrXUS3f/fwsp4W/Z2DBX8w//ESBpWmfJ
         RmG9TG1jLouZ8q9OsstsNRApODEDDkc8UPvH0ayrLzAbQLS6v32p9jpgceEm5w8vt82/
         9ryyDSKFMPKJGvMdF6pZFBlw/XnwwYQCnyVAinyrhpuQWLcTJOnu2m28ejwDEpiHtqEH
         5OLw==
X-Forwarded-Encrypted: i=1; AJvYcCWmIpBt8VNdCdM3iXgdRBfcJoVu5epUQnYEQMiudnSycGyC3lrywbxeAZEwkLB5PNn0h59EBhaN3hvLzBk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi89zk3QLx6UHTIGtwAWydqIhRjJ5tljPKWkrzTQ3h3xcQT5Mx
	ilPVHVt8HXCgCZRQh+EK+XnhEUbjimTgEGwHEqgmx4TgrWmdrk7Mlep7oXmQeO7Ddc01ufmiUSQ
	x2MtzkZsyJTCC1YFb4IwkmwLb3dx/riuFB0A37qhnDnbZL476SlxXIIahUURfcm6tG6M=
X-Gm-Gg: ASbGncvBxvjW5IzimnbWH5W+HEEsXX2IIdt5DIZhBYXp7PjwT5ZsZ0ivONc3B4ezOqH
	3L3QhSxLgxWSGT5jqe2m7w3vGW0NQxbkz7Oqs6zJKmP/yvIyOLqN4JMKyDN2pE9gnugWx568mcR
	aNJr+8V0sJ8u9eASd1GKhCKvHh6Fu3HKugNPTheTQfYzTmwP0CaSFNOysEa0SXhQFBmAeFFAW8R
	zz4wi8Ro1HSp4xX3BoK5rbR8jsKPhAqnObw1zRBupu7gY2wuM6KFr3nZxpj1mK6wU4TFmQlXdVd
	M5YRaM7Ie6zslJp7FnftPCIMuG1p2568S+bsYIwEMGRahpndEJQSvh17dYnIEzrFaDj1En+6Mis
	JQrl8ZrMF4xWEV+CO2Sq/Fw==
X-Received: by 2002:a05:622a:24a:b0:4d8:7b08:64b1 with SMTP id d75a77b69052e-4da488a2d68mr24551911cf.5.1758790878926;
        Thu, 25 Sep 2025 02:01:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIEEiaQAm71DQ+NEF1w75pObhl5w775CkYKjl3dcMT0LtvrfJMaGLfpVDOYjnPi8DQxbLxdw==
X-Received: by 2002:a05:622a:24a:b0:4d8:7b08:64b1 with SMTP id d75a77b69052e-4da488a2d68mr24551451cf.5.1758790878342;
        Thu, 25 Sep 2025 02:01:18 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b35446f7547sm122337066b.67.2025.09.25.02.01.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 02:01:17 -0700 (PDT)
Message-ID: <050b2cc8-ddbd-4a79-879e-4a2c9e7d95f0@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 11:01:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] media: iris: Add support for multiple TZ CP configs
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vishnu Reddy <quic_bvisredd@quicinc.com>
References: <20250925-knp_video-v1-0-e323c0b3c0cd@oss.qualcomm.com>
 <20250925-knp_video-v1-3-e323c0b3c0cd@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250925-knp_video-v1-3-e323c0b3c0cd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: OfByLEVKxR2xCCIHlOr2xf6Edc4xbwg2
X-Authority-Analysis: v=2.4 cv=RO2zH5i+ c=1 sm=1 tr=0 ts=68d504df cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=i6MhSZCOMBc9aSuCptEA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyNSBTYWx0ZWRfXyIcsYrpkGvdA
 Km/UIbNWnhVZXZHjp2QduFQIj9fA7605LPZzomWzsh0hXKWHHwG/+4irz65LI9QsfGkJSW6uwqf
 3DnxSh9BKCSdQCSHncomPbhpQAzB2T9TqCmqFn69kMlG2VWox89NBt+bIm+8WQPzqnQ5SqXzEdu
 EqhCfJM9CRlmvwyyOIsXlyusl1ZpJLP/obu08AVoRTZtEmqr/7260yfJESORS1jxFkWYQPOIqR7
 t22GMUkrm4d2d3QQ8FZZHKJ0Fvhx/roaI+myQA6K0Bzo0JsIfr+FRgzPweROKlISSN1pXOI9re2
 ubaltpOCAae8xlU0QhO8ihvCldthVoUIJJrk5yUCMz7j4zLbA+qwtlg/7xORYmFRnf9byaIhSwf
 oKb2JNZJ
X-Proofpoint-ORIG-GUID: OfByLEVKxR2xCCIHlOr2xf6Edc4xbwg2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200025

On 9/25/25 1:14 AM, Vikash Garodia wrote:
> vpu4 needs an additional configuration w.r.t CP regions. Make the CP
> configuration as array such that the multiple configuration can be
> managed per platform.
> 
> Co-developed-by: Vishnu Reddy <quic_bvisredd@quicinc.com>
> Signed-off-by: Vishnu Reddy <quic_bvisredd@quicinc.com>
> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> ---

[...]

> -	ret = qcom_scm_mem_protect_video_var(cp_config->cp_start,
> -					     cp_config->cp_size,
> -					     cp_config->cp_nonpixel_start,
> -					     cp_config->cp_nonpixel_size);
> -	if (ret) {
> -		dev_err(core->dev, "protect memory failed\n");
> -		qcom_scm_pas_shutdown(core->iris_platform_data->pas_id);
> -		return ret;
> +	for (i = 0; i < core->iris_platform_data->tz_cp_config_data_size; i++) {
> +		cp_config = &core->iris_platform_data->tz_cp_config_data[i];
> +		ret = qcom_scm_mem_protect_video_var(cp_config->cp_start,
> +						     cp_config->cp_size,
> +						     cp_config->cp_nonpixel_start,
> +						     cp_config->cp_nonpixel_size);
> +		if (ret) {
> +			dev_err(core->dev, "protect memory failed\n");
> +			qcom_scm_pas_shutdown(core->iris_platform_data->pas_id);
> +			return ret;
> +		}
>  	}

Do we need to do any "un-protecting" when unrolling from an error?

Konrad

