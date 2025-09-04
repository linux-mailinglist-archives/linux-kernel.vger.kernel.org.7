Return-Path: <linux-kernel+bounces-800347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA841B43697
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 11:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 295567A5B9D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD93D2DF6E9;
	Thu,  4 Sep 2025 09:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fX984a9m"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AFE2D6E78
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 09:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756976721; cv=none; b=lrrNNKBz8R1t52f+x1s1hzlQT9QK7UT6H1FCMjSuqUmdRianPy/PyTipOUdBCJ5CXiAfoTtTG1q2Oj76Robizep4u3yibKw4/SZ6JEvsUxKQGoDWqsK/fYY8VF4tuHMhpMYcG7pfFQz1YFcQSctDxicRgyF4UH3sD6y4aqM/gUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756976721; c=relaxed/simple;
	bh=Sfrg9M2z5FZ/TjS0lIhxVa3hQyyN5eG2q5tz3HsFm60=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CV+beem5xp7QWEj/yjbP4MiwsNLgunOWErO7bxCuD5wMj2FfzXIvWqHqueU4Hfzg/+tX44IRjIuqhWVwV/sOOYTG3tNfLUIsi/l6J3oqI/skp9bAglVjavACgj2WwojGFwPN9zkK8S8EVbBlvvm6D+aWbDWGSBmFMUprdU7GtOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fX984a9m; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5841S7ON016615
	for <linux-kernel@vger.kernel.org>; Thu, 4 Sep 2025 09:05:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xF0hC6l5JZ6Ge20n6xQnqgPWUXlQn8IFqduagSkQakE=; b=fX984a9mTYG01Spv
	pxVCFwWAwFFqyvnOCW3Ag12UujxQOArmrIlH4hBk0nFg81nmmN+uT6mlCvbWCN6D
	ZnMN3CaQCrukPQhyY+tffHri+v6qJTFg+SGnKaOXnApT8lYG2l8+1GNASh9eOG5R
	ObfdroRmjcdfgfcXIqZohroXczVGJfc8c2DOTy+n4C9hewyOjXUQb0JXBFg6QZ+k
	qNA0GY+DZvR+Yz/DeL3RemU9EoEZ+ie+7s7upBIwb+tzwjEWj5sxwVzhRtYOssi5
	S8VKUYAR/I0v0jFgcz8zL+jmw06d55JOUGGtZvmDVIZEjGvKF9OKntJOKjWQwDbS
	LdoWNQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48xmxj3ecj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 09:05:18 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b331150323so1910841cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 02:05:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756976712; x=1757581512;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xF0hC6l5JZ6Ge20n6xQnqgPWUXlQn8IFqduagSkQakE=;
        b=QmpZx25L/H4uadctcmGlXsCFw2jKz2ttRWqVBCZufm6KIxWHFNzMftwck+pknnG8Jz
         vYT7Vxv2LbaRNCXNZIUlSeljQTmwv/EMhWd1KMebA8iiKZht3BsXhySXYaluqDFwk4hb
         0CEHfp16PyzIBh64DUzMZkptvoN7RdmiH94k7NA0I6hSIU07vebhbiGxP66u5C38U7an
         fNdvkhExTbVWgotojxUHBQWsyhxIcMRhfFsgXMe2YmdulQwJ4y5svLSmoSILOhqLuMwp
         GtHWMc3EX6MM4xyV5jiE8V4FgpELEeK3yBoWKB7PefopteRvt+BAO7ODBBhiAIKFfog5
         TGmA==
X-Forwarded-Encrypted: i=1; AJvYcCW5snSkclMnVCUkG1zzIwbkQ9QsAr0QovXUcEohWD5l9QiVWIERzqPhCIovknjCutsc3ofWUZMgvDHMTbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWygv7+e+2RByVdy8SKSAkecREDjlDoRItOhNbYoD0bgreYvR6
	cZm0ki83JiZ4UPV53z1SsvN5LTYpTNrsHvPI4vl5n5bqtOQ2NRH6RKKo03voxMQ6gpVz281FfIh
	Tk6WhlQiOJTx8J8osKh5bJIvKuD7orKlKsZWWcvBUISLH4gf0WNNw8nASefp/btW5Wys=
X-Gm-Gg: ASbGncsrbF4n9dVL9TR71KRcJpG/yFFFVcQ1Lb3z0f3MAfQEaL6s8DOJURIt/pZ8eP2
	k+Q4jmcAV4PrRRDqgz+iJXvjFe+wmWL/G1qzgTaTrZM8asQhqfhTLxGcdwfGKovFdpe8iVmhcao
	OunSbtrXWu11IgHYZ6UKa8pdE8yl5l1N/rYsBdGxSpI5vLzTeyFt8t0ggH6c65tcUSSiacK1bGq
	YmE2mQRkOXBrjjAYtN2V99jftI7VEYp3K7vQy6ByEzAB3njAW8n8mypSUQQ021vxnasupFN8OAc
	u4Va+Uje/zCaW9Ma4F5hiA/htyBhcCmyBxsH3/sc4umw2KCHM/Xa47RAbrsR2EG3iOg3mDP9mCJ
	ZLtEpk5tTHnXfWWyhsHtmuA==
X-Received: by 2002:a05:622a:1ba4:b0:4b3:2c2:8843 with SMTP id d75a77b69052e-4b30e98a161mr167907741cf.10.1756976712361;
        Thu, 04 Sep 2025 02:05:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8Qp86ciG228KLCiY7qG9SpMLg/p9RWq4SW9peO7VU4ceuMeQRSa0cHLhEVy2hzVv6Pg6ttg==
X-Received: by 2002:a05:622a:1ba4:b0:4b3:2c2:8843 with SMTP id d75a77b69052e-4b30e98a161mr167907431cf.10.1756976711628;
        Thu, 04 Sep 2025 02:05:11 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b04189de5b5sm1085623566b.10.2025.09.04.02.05.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 02:05:11 -0700 (PDT)
Message-ID: <3a00018f-7573-43c6-867f-eff4041c0ca7@oss.qualcomm.com>
Date: Thu, 4 Sep 2025 11:05:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] pinctrl: qcom: lpass-lpi: Add ability to use
 custom pin offsets
To: Nickolay Goppen <setotau@mainlining.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, linux@mainlining.org,
        Nickolay Goppen <setotau@yandex.ru>
References: <20250903-sdm660-lpass-lpi-v5-0-fe171098b6a1@mainlining.org>
 <20250903-sdm660-lpass-lpi-v5-1-fe171098b6a1@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250903-sdm660-lpass-lpi-v5-1-fe171098b6a1@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAzMDExNyBTYWx0ZWRfX9WrimGWTxDPl
 /IwW76kwmYiNZYsRH3wkmlS/GSvQpoAlb5VSMHKK8MNmKqOBrdEHOzRJjulCWgIfBgc9QectpK7
 kPMA081MPwISwzhfHFUo1Ei4CsRB2CdDXeBw2j3oAebMdtFuSvegeXvCzxcs9y4Au4itlUlH5Lh
 hY/P6hf2YxSncDYlFThL+iPALa0TKuOwnP9zgp9SdF7YsGXNGqkZRUyZmvvKoU5NCKORn1vNRik
 cM7X7NBJyJ95Mxxp0rqBloAP8MnTyGUSyIVrE192G29uJ2XLXn9/+X9+LfqysunTtJutitIzdxp
 2TcrOhpNRaGSHlZs1BSXxE9IQB6fTKTagos/j9q+Dgsy3Wa7ZhLr6iDmuaS16RTaDkhlW56xEOd
 PRT7O/kb
X-Authority-Analysis: v=2.4 cv=a5cw9VSF c=1 sm=1 tr=0 ts=68b9564e cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=qC_FGOx9AAAA:8 a=OuZLqq7tAAAA:8
 a=EUspDBNiAAAA:8 a=BJytJd1QHtw-lo9AdRcA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=fsdK_YakeE02zTmptMdW:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-GUID: 6_-2_oT5gGuFImYxMBkUWEmVCFrwmCoT
X-Proofpoint-ORIG-GUID: 6_-2_oT5gGuFImYxMBkUWEmVCFrwmCoT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509030117

On 9/3/25 3:39 PM, Nickolay Goppen wrote:
> By default pin_offset is calculated by formula: LPI_TLMM_REG_OFFSET * pin_id.
> However not all platforms are using this pin_offset formula (e.g. SDM660 LPASS
> LPI uses a predefined array of offsets [1]), so extend lpi_pingroup struct
> with pin_offset field, introduce extended LPI_PINGROUP_OFFSET macro with
> pin_offet field and introduce LPI_FLAG_USE_PREDEFINED_PIN_OFFSET flag.
> This adds an ability to use predefined offset for pin if it exists.
> 
> [1] https://git.codelinaro.org/clo/la/kernel/msm-4.4/-/blob/LA.UM.7.2.c27-07400-sdm660.0/drivers/pinctrl/qcom/pinctrl-lpi.c#L107
> 
> Signed-off-by: Nickolay Goppen <setotau@mainlining.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

