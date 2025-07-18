Return-Path: <linux-kernel+bounces-736840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA07B0A3D3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 14:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E76A583E79
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 12:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E3D2D948C;
	Fri, 18 Jul 2025 12:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LdSzPevX"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5C32D8DC5
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 12:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752840359; cv=none; b=QuCPAZFDWYUNI6eCvJAFrEyVHt8p9E9L6Kk5QobMWdGoshucJevA5v7Gi3h7ig06yyCKD7FDPD639OuiJqwawf1bw2/kakpR3JUzH1LzYnDRoY1Fe8nmuhQJiJHd6j9/4Lvgub2k2aOdT15TOnvHjQPj11HuOKQLaH57r1ToeiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752840359; c=relaxed/simple;
	bh=7U4qOHFZvZLxWGVMYR7f8oDY3EFaK/os9tDzF6lr9FQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NhBLNCRHyyPF15YS4o3YEOb8VIUsnO4wT9Hhjga7LoEs9R9Mo9kXioSnyarorrnVUBY7nwub5A3xLMHXWNS4ZibGeAjMq6fmIFJrk430LknWCBTOm0/DQTw+jUw45rYAoy19EG8dWGgmHJD1k/V4yn2f8xOCg0aTOIK/QDcUF6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LdSzPevX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56I6wFGG020667
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 12:05:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8UtRmvk1FOoWe2iPf/lIbg2tWc6zOKHKHM5RupZ8S24=; b=LdSzPevXM5JAsAu9
	vM34FB2+xLk17yZoA0lKX72401EL72yks9USgrWEBlt/LD0mH/XLGDU8hk0xPQjI
	XgiyPzGR/y0MWdDP9gqCUxYjggQLyaAyQOjPijvFMVG5t8VeO66PUylBgNtYgX+g
	VIuoFHzlpQd6V7HX5tJM2B23KAZHidkAJUGJc+wsVRdqma4+o7ZZWPFFslU6p3ry
	22bFHQA4RqApjI9IoG1LkI35YJyTE22HLMG6Al/4mvfFMwcPAZwPNzdOJun9zp06
	9r75YE2ue0Vc7H0g/bYXHvSdYzOwgiyYbZ5OWV9/YcC+3VWDPO6veWrc2Mt8Mzw4
	oLDMYA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5dppfp0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 12:05:56 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ab77393308so5415351cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 05:05:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752840355; x=1753445155;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8UtRmvk1FOoWe2iPf/lIbg2tWc6zOKHKHM5RupZ8S24=;
        b=HySaCsfz3SyGbO8qg8rd9fqRCQ8SgRW1MtddYJhc4v4XYfHrW9haP0yoHVch4cDb7J
         wucJvPdis+j8aeVtPW33JbF3CwHboslW+JH0s/jNrkTjmEj2lmdrz3UG9vO/R7QUZ7KL
         tt7dGoIzjaH2QRJa61jmbvzq9YVjxyakbvrMIWMCbN2m/NXnnmraDxj2VmJ10J07byh8
         nfLCIM0nD1Fk1HfdRpYBE6E8vXHGEL3Ai12np56jy7+NIJ8mxEiIfJfDDSn/M7HzbkIK
         HumeLq6IDxcg7b47NAwIOZhNNKi8E2E9+bF/H2bUiJoa3DwVykG81cB9spWn25Wgd+B5
         Hixg==
X-Forwarded-Encrypted: i=1; AJvYcCUW3N7xr8CPHiLUZe3fAQS8LwaotEmBgVR/4V/RdR3Fpa1oXK9dOyzxEKS5jxOvlJs9aRh6/vaYF6z+pE4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIAClP8TwofafKFOYWKKs6DObn2tiQuS/H+cIq1ngBTWPO3W0V
	gyxNkKxgbNNzpwV2oiO+U17nvprXHrQ3dgPaK+iq3e3XTVNVeA5scmHw0oO+l5W4XXn9WiCWD9n
	4EeML7Sq1YzN1syDcx9qsUCpLvjQ5zIKfrjoFPCBGlW0Sd2+iYYfevWgADo3GT3aYfb0=
X-Gm-Gg: ASbGncv8ikKAdxULB3lROFG+uBPNJeCWFO3kGRlNX5AIrOQXxcudYb3h8Amr80hhHsk
	sUxDwiLFFoLxApkr/O5Ckj//sbZ75swQekdM2rgjRLEVcGiw1yNVJxXdEVOYhF6ZSAv1r7MIhLy
	s94z9Vz4HXgnto+xFqjtEmjswLaZBqlGFpB4chmE5N8PGmFDYV2b8D06SUAbl+grBIKbYrJDf9R
	6yUxk2BgFjnHOrHe57laEQaAFrWLvHEW1msC5Jef0lJT7BWOp29x/DOOd2GeOlYKBRGIm4uhkdv
	L2bQ8nX0WvfzWBCCYKDKzcH9v83Fd1+cUJoa2VkPGoZdGx+AfhQ3UFGAlfH1AxXtBYN+oGKCOx+
	lmowAczzlwle146GZO614
X-Received: by 2002:a05:622a:302:b0:4ab:6499:785d with SMTP id d75a77b69052e-4ab90729467mr67177691cf.0.1752840355057;
        Fri, 18 Jul 2025 05:05:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEul6bHo97RUTHI+UU0ltJXObJlfOp/FKdGwuUle+uoI3cN3nXxhZnpbltIlsaOTmG/aibb8w==
X-Received: by 2002:a05:622a:302:b0:4ab:6499:785d with SMTP id d75a77b69052e-4ab90729467mr67177501cf.0.1752840354617;
        Fri, 18 Jul 2025 05:05:54 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6ca7ea53sm109360366b.133.2025.07.18.05.05.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 05:05:53 -0700 (PDT)
Message-ID: <a569a2c3-2fb2-4a40-8d54-898e7c36f4b3@oss.qualcomm.com>
Date: Fri, 18 Jul 2025 14:05:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mmc: Avoid reprogram all keys to Inline Crypto Engine
 for MMC runtime suspend resume
To: Debraj Mukhopadhyay <quic_dmukhopa@quicinc.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, kernel@quicinc.com,
        Neeraj Soni <quic_neersoni@quicinc.com>,
        Ram Prakash Gupta <quic_rampraka@quicinc.com>,
        Nitin Rawat <quic_nitirawa@quicinc.com>,
        Sachin Gupta <quic_sachgupt@quicinc.com>,
        Bhaskar Valaboju <quic_bhaskarv@quicinc.com>,
        Gaurav Kashyap <quic_gaurkash@quicinc.com>,
        Sarthak Garg <quic_sartgarg@quicinc.com>
References: <20250718110217.1929526-1-quic_dmukhopa@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250718110217.1929526-1-quic_dmukhopa@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDA5NCBTYWx0ZWRfXyIPy9WLYs+Pm
 XQHxL8PrfLAdsR+BNqncQKAtKp+N+eXFdCZpEPlwXkbtfcAlsTu8DdmeG2NbyJEk1NYX/q0Pf+o
 Fg6W9RgMa25f7fQl817L56Xdz+CMxiCZRugrjthg9Ip40fhshWqDE17/8eoC/N+ICGolF02B90w
 GVzcws8eXb1WBEs4x1v0VCQ3PguDDKKiRF7Oo8AVkVQyMtg3oYqoJlz4E3iMKbPTup4TYMHMMIv
 UTaGISosOHsLoHjUScatOEwyPZ6Z4Cu20kb+bx19M0GlM9b+4blVxqTyIptA1zuoCBa3Run4PLj
 bD2OiXlWNfmbBxq+olP6kK558NtY2q6wRm+v7UJd3w9S+oorIzkPZwWu3D9t+YpfXt3JGkggEmN
 SFjA10LTNtiG4sSYSdseriYdg+vYgxXkdBbOM6evvhpCJZBipGx3YRtwqU6FwRxYkCGwgBqe
X-Proofpoint-GUID: db7BZ8T84LcW8UGtQ_6_MIHxUMhr6INw
X-Proofpoint-ORIG-GUID: db7BZ8T84LcW8UGtQ_6_MIHxUMhr6INw
X-Authority-Analysis: v=2.4 cv=Y+r4sgeN c=1 sm=1 tr=0 ts=687a38a4 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=K0aOVt1QNMoejPNc-jgA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=999 phishscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507180094

On 7/18/25 1:02 PM, Debraj Mukhopadhyay wrote:
> Crypto reprogram all keys is called for each MMC runtime
> suspend/resume in current upstream design. If this is implemented
> as a non-interruptible call to TEE for security, the cpu core is
> blocked for execution while this call executes although the crypto
> engine already has the keys. For example, glitches in audio/video
> streaming applications have been observed due to this. Add the flag
> MMC_CAP2_CRYPTO_NO_REPROG as part of host->caps2 to control reprogramming
> keys to crypto engine for socs which dont require this feature.
> 
> Signed-off-by: Seshu Madhavi Puppala <quic_spuppala@quicinc.com>
> Co-developed-by: Ram Prakash Gupta <quic_rampraka@quicinc.com>
> Signed-off-by: Ram Prakash Gupta <quic_rampraka@quicinc.com>
> Co-developed-by: Sarthak Garg <quic_sartgarg@quicinc.com>
> Signed-off-by: Sarthak Garg <quic_sartgarg@quicinc.com>
> Signed-off-by: Debraj Mukhopadhyay <quic_dmukhopa@quicinc.com>
> 
> ---

Let's take a step back - do we need to ever program this more than
once on QC? What about other devices (e.g. the generic cqhci-crypto)?
Do they also lose the crypto context over a runtime pm cycle?

If our hardware is fine with set-it-and-forget-it approach, maybe
we could limit this to a small if-condition sdhci-msm.c

[...]

> @@ -459,6 +459,11 @@ struct mmc_host {
>  #define MMC_CAP2_CRYPTO		0
>  #endif
>  #define MMC_CAP2_ALT_GPT_TEGRA	(1 << 28)	/* Host with eMMC that has GPT entry at a non-standard location */
> +#ifdef CONFIG_MMC_CRYPTO
> +#define MMC_CAP2_CRYPTO_NO_REPROG	(1 << 29)	/* Host handles inline crypto key reprogramming */
> +#else
> +#define MMC_CAP2_CRYPTO_NO_REPROG	0
> +#endif
This (and the crypto ifdef for MMC_CAP2_CRYPTO) looks like unnecessary
churn - crypto functions should never be called if the config is disabled
in the first place

Konrad

