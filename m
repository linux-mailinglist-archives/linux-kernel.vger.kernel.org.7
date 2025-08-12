Return-Path: <linux-kernel+bounces-764074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DE6B21DC2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 07:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89E8F3AF57D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 05:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1452882D3;
	Tue, 12 Aug 2025 05:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FhrQzbW/"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7D126C3B7
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 05:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754978141; cv=none; b=gOA77QhXY3yIRhKPxUu7EyZzCopdrRAO3s/ASURyt9hWW88jngxMNUbHrYzH20NvQaGulGwqLwUNli5/XA4twJVLNZkUZZc1Q2jyAQNtYoeqDmpp0iLXrvC4BCKUKkh74a0di4/jL7wBKNWZv4XFkbJYmL1IwgSgBTb18MqGxUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754978141; c=relaxed/simple;
	bh=jVgCYfXMSjJ/9fZtfupDTMepf8WIhFofQBAD5wXcV8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nbJStBARoaRuI7u7JL/M+q1gneN8c2JN4mT6SkdidgHmEIzyNrK6QaDU6yDohOL+MpGpmzBT8uInz8tPjBOQf5kEuUsxJIFls6gizqHMKlc6JRsPKHzXAJC59jctrZi/HaPwGsRfoeEmzvQY9Doa334mjb8gFOprlZRMYoDBOlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FhrQzbW/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57C5TdVh029206
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 05:55:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XI4zA0XPEeDju8LmiA5iAEsb1GjF7x2tJZG8gRPEHcw=; b=FhrQzbW/vDlM2Zam
	Aqq0M+z7LFXJEmSTWYT1ASIuluq9c7fLPwnTy1t4UJX1tW4jKcr6HQpo1wnrTscE
	yZG0t6M4qhQWvZxDXzV4HYqnyKnlbIqZyrbq3oycD29I4myfBbHAK/yZjLDqLyVP
	6JSfbbT8ZZwqw4MqMfcFnhRvFoq7/29rZH6fckzUnzL2D840tlge4T66xiU+HV4p
	CIed+G5to8rHqRsMDn392U5s0Phk3Yk7hsHpnGYUP6gvSFeQ4vHIva4niKR2m6CW
	p7UB6D2ycgRGXSIy2LO/3DplyYSVwbrvcB/8OdA18++tdZjddYuR6uB5Fv2qea0a
	zpNraQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dygmexs4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 05:55:39 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-243030571c2so1975775ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 22:55:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754978127; x=1755582927;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XI4zA0XPEeDju8LmiA5iAEsb1GjF7x2tJZG8gRPEHcw=;
        b=rPGTsrgQfnMEgbChwdgF7ErZN7QpUDE/qXtejMTmB4LYS6QJbsX2VDuvU+Kj4GJXvc
         7eVJjVRD8hzfSxk+vtV16RvOqsa13u7ARxFZWGtDiz4P+N0ZYNtFM1BUuud+eKh63UMQ
         KKc6H4f3IfcfrPiSU/wz+Xz9+98jfQfm14Ji4Oq/KuK1cszP4MYeIvnpu9J+sbzvVI46
         KFl+li87X30M+M+lDIv1U/zrGsqT3aGIvFRx//G/ri0sAKp9RcUlCN923ug9cWCMpGyr
         qvaO2iKHfNRC5J8mKXsmKLEtGumuJwb5ZZbOqe+URh39Z0LzzYTxcZdb8S2A9uwZCX04
         kHTw==
X-Forwarded-Encrypted: i=1; AJvYcCUiBDxRqLfDd3ruK0wzTSenG3CBZBbwcDNAlgBL12aR06pPJZeaG4HQU0QI1Qkx3wGfwW3AMFsBu/6WwUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIW9r+fZZZG/JP2J8hDeI499ggmPS9IwpUZQrvHOTi8bp+35wa
	i1h01uShgUGn5tQ4VThO2s6Jmif/+nLOTtSHjkcsAVRLKf4MMLcY2c/47xX6MjKljaBFq17wlZo
	YC1USMjXwCvLKNpm34qb+bzd4I/c5OWlLXmG2e0pbS5tXR30l1ry8iM/rCDlkFJjfs58=
X-Gm-Gg: ASbGnct4QAmcSDIlI4P7VS1ATN3jWPcfXZ6+YSOjVkcp8GTJYVBm4x4cWj43t76fBSq
	BdTeJDOpj3kBkGQ4ZoRlo/CCDteGvYqiE8NGTfWoQuwwsR9lAF1YjuCG44YpyeWtnwdy6tmUSSk
	uwyLa9ixVeRZxRKtag+DG/rn8/wmjWcK2I+BSrGVk4ANS7to+FJWPhGmZe8SCVlT8bbG16zpPem
	tKKL7ZKaGFJNTof4nAcLdKX3/Syg8T90D64bQwYvV9SZpLORus7/VInEnqLXj5ev0AlLGuKPENj
	g7q8kfwxYyQS+qTFY/2euGLtjVy2bke8s1bwsnCOddwo/JLwEaon9DH0IA2Ibry17C6E5f8=
X-Received: by 2002:a17:903:2283:b0:240:9a45:26e6 with SMTP id d9443c01a7336-242fc230f18mr30549735ad.10.1754978127367;
        Mon, 11 Aug 2025 22:55:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/YPzCOCkFvG1QEpOcPR/+AeqBulYJ1CpcEiZvOMQ6dowlNrMRbKyFgKjMlGH5EpOo+tkUlg==
X-Received: by 2002:a17:903:2283:b0:240:9a45:26e6 with SMTP id d9443c01a7336-242fc230f18mr30549445ad.10.1754978126934;
        Mon, 11 Aug 2025 22:55:26 -0700 (PDT)
Received: from [10.206.107.125] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f15092sm290447335ad.66.2025.08.11.22.55.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 22:55:26 -0700 (PDT)
Message-ID: <d1cce1f2-df38-49ea-ab62-a1397be4e599@oss.qualcomm.com>
Date: Tue, 12 Aug 2025 11:25:21 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 1/5] dt-bindings: misc: qcom,fastrpc: Add GDSP label
To: Ling Xu <quic_lxu5@quicinc.com>, srini@kernel.org,
        amahesh@qti.qualcomm.com, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        arnd@arndb.de, gregkh@linuxfoundation.org
Cc: quic_kuiw@quicinc.com, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20250716132836.1008119-1-quic_lxu5@quicinc.com>
 <20250716132836.1008119-2-quic_lxu5@quicinc.com>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <20250716132836.1008119-2-quic_lxu5@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAzNSBTYWx0ZWRfXwchRc0REAd3e
 WFtplayd2HT3aSimAOjp/WpIxVjQ1dtYEjvPeXCrNUiPrVRDxj3SGv/AMHkP9tR/CWQQIYeNudP
 MA4d+SH9ACV6hc8TU+hNYYISTlsCFfwa8EdxYfDrycecS2DKgMyV5pVfePpVfkISCBeJOiVD4XS
 DczPNNPouk+uPdebH6oz4DU6Q/ylupYGI1L143MJ17a4J7+2KJwAAF8bpVRvBr0p/qKZRmFwgST
 TPCoq8ajDOBAWRSnPDAEUV16aOuI4ci1v0qjaepvLepaLLY+ZTaF0vqIxUhwrIMF04NpfLL6dmv
 CM4SnIy/t0WtmtaPmJlIbVfj6XV/V4QrSyeMywv5OT/HbF2Ub0FnPlz/SL18QBkAvW3pRXqSZP+
 gXzyCnuE
X-Authority-Analysis: v=2.4 cv=FvMF/3rq c=1 sm=1 tr=0 ts=689ad75b cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=3zBhIfn5MegWJkNBbEwA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 0e-2ps4gd6TcEkU9EdL8ZZnOj_-ayA30
X-Proofpoint-ORIG-GUID: 0e-2ps4gd6TcEkU9EdL8ZZnOj_-ayA30
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0
 clxscore=1015 impostorscore=0 spamscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090035



On 7/16/2025 6:58 PM, Ling Xu wrote:
> There are some products which support GDSP remoteprocs. GDSP is General
> Purpose DSP where tasks can be offloaded. There are 2 GDSPs named gdsp0
> and gdsp1. Add "gdsp0" and "gdsp1" as the new supported labels for GDSP
> fastrpc domains.
>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Ling Xu <quic_lxu5@quicinc.com>
> ---
>  Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
> index 0840a3d92513..3f6199fc9ae6 100644
> --- a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
> +++ b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
> @@ -27,6 +27,8 @@ properties:
>        - sdsp
>        - cdsp
>        - cdsp1
> +      - gdsp0
> +      - gdsp1
>  

Reviewed-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>

>    memory-region:
>      maxItems: 1


