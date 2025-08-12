Return-Path: <linux-kernel+bounces-763999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F59B21CB5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 07:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5EEE1888DF7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 05:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA2C2D3ED6;
	Tue, 12 Aug 2025 05:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Dfj80GVM"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33D6278E42
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 05:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754975234; cv=none; b=IezF/X2w0d9h7nRHC8MT6A96PtPdHxoqmCnCZKT9v2AhD5YRTo+dfXuUCGSrVL2XQ/afFz3og0vDAXMAmEN1RK9V+Ge9kURxw+QPQC5muzzf79JH3tgKp4W2egCP0yldq45dWxx4syQCnLOVK7pAc2s0FofCVQRvFL2Ui3WlRt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754975234; c=relaxed/simple;
	bh=JW8imEaLawVdDB6pLuEapa6akjqmjGy+TlVBOIdQTJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hb3Y1h+vNBB4V15pnNoV5v8u01neZgiuVh12XnOUA2zfDKseSOswi5HCdyksQS06KZ+6ykUx38r/OCLPyFcCmLALFFP8GuC1p4WuhEBhWhmUlROUEmtPM0/5mwP4lxloBx1uY4qU9J1ks0CUcd46OZl2Eg7ArOdmn8rHYCSt1rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Dfj80GVM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57C48BJ5019065
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 05:07:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oNkEVDKLytEFqjfBNwlsGmqz4UAUYa8AuW7pBH2uoB8=; b=Dfj80GVM+Y5bhCYP
	zMLeMO2K/ZFS/sru+sGIT+iynd5c/OmM61twuHzNH85UyFCbs+K4OGmJenKBezPh
	NaxmtzjVHBAWnbkQex2yJbts90kd33oFDXGvk3DhyjhIh3imS+RP/hs5LqzBG00W
	tZ8+h8RgRrFz/NH7Q0/ODt3JgAaA9gaitKs66gFt+t8YtW5a7qhX2QNO9kmTfsRp
	aFDChMzZwQpCDr2RT2fngQoCBrA7OF5dCzD6vz1kk9t9nrIvGWgWiznjfdVE+8IN
	bZHhh6lF9YrVM2D3wq7DTwdIRfB547T/+iZRUifZpjjSrNmp3xN5cijwzWfyFMb7
	/3EV3g==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dxduxu0b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 05:07:11 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3217ba6843cso4193311a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 22:07:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754975230; x=1755580030;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oNkEVDKLytEFqjfBNwlsGmqz4UAUYa8AuW7pBH2uoB8=;
        b=rwwoMhCyJuAtQOYM3uNSAalP4vO/JSuXiH4EkWKII5l1x/keJ+VJ2GL9Ko4HnO5ZGu
         61V7/Q7BQjUyaigk0b7DLoCtsagFwK4kXo3BHvGkK657/3PREp27gk9XPEHLN2TYzUmQ
         4bGRF2eW8g9lRJlabvTmGdhB68Xwoa5gICqmHbVC/58+YZtnvuPj8xTn7NIEr5kzgIoF
         ZuYzs/kixskPOtOZo4GI51kAhs9+ffoVp0cmo3OWXPljSmu6YTieC5RdYlzHwH+EC6l6
         UcePoMWn+isf8Q9tRnF0R4ljuqUz1tOy/5MSu9HcINuVSZE86IlbMShY3HhbTEhh9dgy
         UZ/g==
X-Forwarded-Encrypted: i=1; AJvYcCWegwYBu3rWM/4jT2OYyTfHSE8PzijEQq6A9zho2M0AAw1TaPO8+eMBpdQTYy+3NUa4aQXNzfiwavHjPjY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa/bqxbYcpmOo99MP6TnS9cRRmiG0jBNnz0p/XWQ5VofLWhiid
	clpditaEk6Y+a5UUxMnAH4uIMBuU8en7Wz5G1/f/FWU3Co4dEjU9620mN3KEzCHJvGt8LH8kYQ/
	tNpPXYiKZHz0rHa70srk/Pp5/RzX+1A28wt/b5dBTxW0no8LbWwJSYv4KGyUYPMVVrxg=
X-Gm-Gg: ASbGncuRu/gUDvkr6BLqg85qPuOfIw/zrl0LtTCfuPlTf3oIgwgUZWoOwrSZobo1K8D
	hJEO51DY8phk+t7zFGWtllpUdql0j+cuDTckU+XWRGNHgS/XpBbPON7qM/UH8fvLn59rrQ9V5Xh
	nT04OuXRoWxQ8Yvai8tB/XX0jDpbkMndDKMtjCJgOgqg6L9hfNieG4RUSj+329FQ+H2He+bbdUO
	LEi+2deLBoc7M+Quu02OWM3kFCVgX1ERKWfqzH848W+uI5eojqkGHqX0pCM0FvywoAmY6cVGE6V
	LMXRO5/0Bt5pLawNYf9K52/2FdgqNxjQrT5Xb+FbWY3h4803i64cuMb0aa/BEmVkDZG/
X-Received: by 2002:a17:90a:ca96:b0:31e:c95a:cef8 with SMTP id 98e67ed59e1d1-321c0ae441bmr1689051a91.32.1754975230171;
        Mon, 11 Aug 2025 22:07:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUuQTvbkjznzZD3wAoSWPaV/NV4ZMjR4FA8Z5+ChKoQlXLWNgp3NjNrHW6g0TBMCJaplmSmA==
X-Received: by 2002:a17:90a:ca96:b0:31e:c95a:cef8 with SMTP id 98e67ed59e1d1-321c0ae441bmr1689037a91.32.1754975229729;
        Mon, 11 Aug 2025 22:07:09 -0700 (PDT)
Received: from [10.217.217.159] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-321c2be2c2csm735782a91.12.2025.08.11.22.07.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 22:07:09 -0700 (PDT)
Message-ID: <7da20363-7b7c-4b98-9068-d82a186170fd@oss.qualcomm.com>
Date: Tue, 12 Aug 2025 10:37:04 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: clock: dispcc-sc7280: Add display resets
To: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250811-sc7280-mdss-reset-v1-0-83ceff1d48de@oss.qualcomm.com>
 <20250811-sc7280-mdss-reset-v1-1-83ceff1d48de@oss.qualcomm.com>
Content-Language: en-US
From: Taniya Das <taniya.das@oss.qualcomm.com>
In-Reply-To: <20250811-sc7280-mdss-reset-v1-1-83ceff1d48de@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=IuYecK/g c=1 sm=1 tr=0 ts=689acbff cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=C2TcYtzuST-dhkRVSHAA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: mN7W5QTfx4HO5BhQlXbCCZr1AV4-76Hk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAyNSBTYWx0ZWRfX048mIqh4NaZb
 v9amDIE1NO1tDomRD+OvkmFjSWCEFTT+5gxsa3LSIxn4TvLJ/0wQy2YwqNnlCEM7cN1dnRuSnJr
 uH80xdPVIqHLQcgtSc8Ibb2HgniKGtin3oIXHSq59QG0dFPX5Yg6iu79LH2mvo2f6yc3ZTJcach
 GvimLLizc2/WCuuqh8e+GhCkEG7yi1b9oM9LtbnrB2/fjBiB6UbFy5G29nfh1Gw4w31OsdI+q3t
 2aW6VQbLZSjbIdukxfieIib+pTO4mtv9aiu8x8vMi0gYk72cE9/fyLlGrvNluyjjmJzFl7iAbcu
 F4A4TqvcnZpqGC/F+5pfz0hWf/YzxUk/2QHw+dCCEETRKBfHBYgrYnGT1bcI4juqOd/0m0QqTuB
 hDy6Vbsa
X-Proofpoint-GUID: mN7W5QTfx4HO5BhQlXbCCZr1AV4-76Hk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 phishscore=0 suspectscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090025



On 8/12/2025 8:41 AM, Bjorn Andersson wrote:
> Like other platforms the sc7280 display clock controller provides a
> couple of resets, add the defines to allow referring to them.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
> ---
>  include/dt-bindings/clock/qcom,dispcc-sc7280.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/dt-bindings/clock/qcom,dispcc-sc7280.h b/include/dt-bindings/clock/qcom,dispcc-sc7280.h
> index a4a692c20acfc954251fd1a1a59239ac62b20015..9f113f346be80b8a7815ffb17a6a6ce5e008f663 100644
> --- a/include/dt-bindings/clock/qcom,dispcc-sc7280.h
> +++ b/include/dt-bindings/clock/qcom,dispcc-sc7280.h
> @@ -52,4 +52,8 @@
>  /* DISP_CC power domains */
>  #define DISP_CC_MDSS_CORE_GDSC				0
>  
> +/* DISPCC resets */
> +#define DISP_CC_MDSS_CORE_BCR				0
> +#define DISP_CC_MDSS_RSCC_BCR				1
> +
>  #endif
> 

Reviewed-by: Taniya Das <taniya.das@oss.qualcomm.com>

-- 
Thanks,
Taniya Das


