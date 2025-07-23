Return-Path: <linux-kernel+bounces-742579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD083B0F3F3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 15:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17843166B8E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 13:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F8F33DF;
	Wed, 23 Jul 2025 13:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YSqeGXi1"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F6278F3E
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 13:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753277217; cv=none; b=WIy86eY6UXbUrAXg0OtkY5mV9K1KCEHCVEcPXOMSquqkeQeUWzNgQ1CZnPBYV17zUCJQqUd1oXx/gJKLknH/Wy0+dl9FMeN124jkGGG51StEL9eDNhxzJSVuBfbRNfBp3B8ByBJ+2gaIKf2/8JjUqUL03+qmonuO4KTrL5ziL7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753277217; c=relaxed/simple;
	bh=l69WMMjrmPPmNmPc7QEi4cxh7DmmEGEO/ny7mE23F3Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZyqtahAO5gDnjp8bNgO8SgJi6usxhBX9MlYFD2dIqGMpQuca7qgaK7sJ/O6iSR13sFkE7a7yQmhWNHF1Vci2zpr4HHvxVvkqMbbWBH4Mk96l0jlqDy2Wa+QysHyL/vjuqN7VtikEP3MqkASbFpGLmyex6mmMV0phIgDhfHVuyC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YSqeGXi1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N920po024749
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 13:26:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	v142A/UiqMfzDvaGD5c3CeLLc9g8lfXOT8p9oEHfIXY=; b=YSqeGXi1Vz8lf0zh
	KGMJFUY0vfZUHkLHZsEdKCduYiDKKcc3syvCxisEs91VtIwfAgZ0oQlDtE7xIgAd
	/45XoR8/s5x/ehKlNCD+hiWsYmffeysN0+TxsTkKhVogfKarr08MXEpf4SPz9DNS
	j9k5DVKvivbzdKzYyS5YMeh70JkrOXQSCsPj20/YlsaDDZjxh3EibolI7fJlvCNc
	xV1O036CZJq3YdxSZt4AezOTC/5xi/Dm76HXR/34cPadz9AP7B3vxYkjCZjnEVgq
	DLxytAUt71JiwyqoZdQtBQ9/8Vh8X2tkbblBG25/kkitU9t1VbkFhJfPO8KMig1u
	bl0MSQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48044dn3f2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 13:26:55 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6facbe71504so10129416d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 06:26:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753277214; x=1753882014;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v142A/UiqMfzDvaGD5c3CeLLc9g8lfXOT8p9oEHfIXY=;
        b=gQWTIfduOp664lBP/SlvdM9nwcnFEko0hh7UZgZBFpiUS+oT6qkn+kQib2Snc4ZSSH
         wxo5s7B+NQF+egwmNIFOYPZ+FlPeh3WecAOtESfslJHF5OViw1p7ERit1HlEii/aBeXt
         m+ECn00zqsd91iu7+QAkI35vjApUZYbmVbcGc6qwvMP6a8MXkqcyKi43P/ImzrKZUlBd
         N1SVkdqvsHU8Rap9o9TBWMm+oWWtsrE4zRKWxxyRpNnsAKkIi9sLQZcGgJKQdBygeEXY
         EuyVp58rtmXiDujJ7ydygor4xEWFY7OS02At5TrmVRaCAeskH+k7e7bJ+mnshf8XJ10z
         SG1A==
X-Forwarded-Encrypted: i=1; AJvYcCUhJ29ZesVqAdXsgBGfawZVU2hllKqyV5+4GsC4yqKM5o7YNW2kH7Bbo1V9Yb6mAIfg21PDivr5FX50y9c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqre6cdnsVQK/PKXAN9qPrVxouI56fStPlwI/uIH2aJ0LzeLeM
	bzsis6JvbsjGM9tI3D6qVKt5SqrN6sp8REgaWmNZgIIusMegIxRRLEesgDwnPzjIaL5ctQm7Ris
	yTYKPjbEAb9MJr2K4hJbb4Oj1ZDDdAFI58EydmsvKTGjeTjoHzukBGDLzQ41FFemz++Q=
X-Gm-Gg: ASbGnct5oUXRtbXj1bbyUX7FDPTXsUNVja62If+e0d8aXf09gkbuDWFgic3KPxVnqXC
	DBiHXz1TjjveQhluyVoQbHqBFMf/OjqtN69AtPS5YdwnmLzwOunPG7kZ/XQS5peqaV6ZNqj1L5x
	T6E7+IF1SxztII1HTDG6D85HNV7GzbhsT9bvW7bUXtMPjn3J1a+u90YgGl2whYuZQ7iypDJCBLk
	0MefRos9ejB+54ECEXLR5x9Ilvdgr/pHNsc+lpgeTlvNaWNpIzAvAPODBwxufuv2fZdXg7wulFi
	CE44m45KYn1FheH0Z9xm8kj2/VrrJujmVHXr5vZu9no5PabDR3DMD+Rk5zagI2hVXlcAHT7iVWX
	9jm+NRFRA6XlxY4AJ6g==
X-Received: by 2002:ad4:5c6c:0:b0:702:d9d3:cc54 with SMTP id 6a1803df08f44-707006aa41fmr15997326d6.8.1753277214222;
        Wed, 23 Jul 2025 06:26:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZJ8dwmCFipYmE82A1CvPITOOD58pCVlEI5f3YLgSgX6gVOcfR4jnt3jQebHNiXAgJLM3rdw==
X-Received: by 2002:ad4:5c6c:0:b0:702:d9d3:cc54 with SMTP id 6a1803df08f44-707006aa41fmr15997086d6.8.1753277213600;
        Wed, 23 Jul 2025 06:26:53 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c79a089sm1046197366b.20.2025.07.23.06.26.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 06:26:53 -0700 (PDT)
Message-ID: <242d4174-d01d-4a65-a4a6-1f4d4e2d4fa7@oss.qualcomm.com>
Date: Wed, 23 Jul 2025 15:26:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] soc: qcom: ubwc: provide no-UBWC configuration
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250723-ubwc-no-ubwc-v2-1-825e1ee54ba5@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250723-ubwc-no-ubwc-v2-1-825e1ee54ba5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=BJ6zrEQG c=1 sm=1 tr=0 ts=6880e31f cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=5JVmSJ65WXatj3hz380A:9
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: whfuIDYhuEFz57lEHEic9l76EWbKeuzZ
X-Proofpoint-ORIG-GUID: whfuIDYhuEFz57lEHEic9l76EWbKeuzZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDExNSBTYWx0ZWRfXz/dk3Db2XkMk
 PTijUrjTcbsfaIJTOrhASOoaBcNvklkPMCggm8lfXLZCPr+6xmT7fo5J5cpQ6D95z5nGBSZIZ8I
 Y/qO1K5987YBLPUoEmjuGYWs/unjqZ7gvDqDqCk/bZESUUFaiZvhVdihzIXimRNqHJ8cMYVeIZC
 9ghepm0xD41/vE9FUqWH1gU0i/tolTY7ehYZ2x3Mpvg3RMwUQJ3K9gP0JhsFliFRnEZysajzFNR
 Jh39RFKBEVWsMqtRavLk9awZZxAbWQ8A/xd3IemqBl9PslR+nUn/zJWyn+GPDJ+lp8nLutlMyI0
 1dNSB3MqHybgL3s26MEjCNO6C/Aw3hGmltmFZ9TBufq4pswLMco5hhc95JvT+zSMC3W8UZMBydG
 VWgron+cMOB+jD/NZHsEWOramSm5yF7K2eoCohnhVw3LM4YwuW5kbHd+RPk3VabUQZCFa9QF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_02,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 mlxlogscore=737 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0
 mlxscore=0 malwarescore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507230115

On 7/23/25 3:23 PM, Dmitry Baryshkov wrote:
> After the commit 45a2974157d2 ("drm/msm: Use the central UBWC config
> database") the MDSS driver errors out if UBWC database didn't provide it
> with the UBWC configuration. Make UBWC database return zero data for
> MSM8916 / APQ8016, MSM8974 / APQ8074, MSM8226 and MSM8939.
> 
> Fixes: 1924272b9ce1 ("soc: qcom: Add UBWC config provider")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

