Return-Path: <linux-kernel+bounces-750692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7424DB15FEA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 14:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 987825638AA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 12:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD6C27B500;
	Wed, 30 Jul 2025 12:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dCFSCEjR"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC60149C4D
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 12:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753876898; cv=none; b=KvAsJEzODzbl3Ml8kMSAzebBiea8+65KnzmxaWU0BEDwfjigoQRAWnSOGtM5QKehwz9b/pTQnVKQkSL88bdTxRkG7Q2+f52xyYf9bQiUeCRuviQoB+ktWZITKlq3skFHjKtYBtoNa+9G5gH1kT6QQtJdy/arGhdNcyDzdNSAZLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753876898; c=relaxed/simple;
	bh=nENZrXVf0xEZ2aFw10idI8zS9pzQ3l3UevWHyh5TXeM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uwCKDMGLDQg8TP6FXHT5Bhd0c6ax/2+P5xtOgTp53gfNieO0IY/K7aj0kluyP2UtMGnXTOWk006OPj74m7HWnkA0qMBSnjHrcHw2fwxdxRLHYlJ+YU8ZBVcOyWTvmkoryLeb4HxV1B5ZIKdcMvXz2o4zzWH/6tXntCF9gUX2Utc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dCFSCEjR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56UBrG56008646
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 12:01:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	h7P4JA0l+stHfoiUVQyDl4hdUnBTOoJrHehJ6ZePN5w=; b=dCFSCEjR282VRba1
	vkgZOkQcVGAHlpXo9djo/qAV3Vt8gviCpLBq67kVd1XG4YBbsi0ugU8i0psfi98M
	ARdp1Pk5H0Dql9iPnBVv6SKsl1wNL65/OcFamj+KjkVRi5esJ8LtkwS2byolC7zo
	yvcKHpo2YduoRKOMZAJmzHuv1Oc46hy6QeSSaoPoSziKZY76xSbN2KajvmzLv5g8
	ba6ZG7a3ZukeX4YQEiL5qh5aAJ7vp1MlvtmT1DMTWR+1tX+1m+4+VeFGEjYgSdjy
	QjREGi42gSCKQq/FAFo2CL6VAosmOxCNdVifoW7d5m5gCd9huTh+Mj+ipOtIH/Rm
	Gvu4zQ==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 487jwer0t9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 12:01:35 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-4fbf290e25cso9548137.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 05:01:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753876895; x=1754481695;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h7P4JA0l+stHfoiUVQyDl4hdUnBTOoJrHehJ6ZePN5w=;
        b=TlwpaHZ77mgMsyTWYddbyeHpDBGUbAG+u2Z7ZXAHArKGqwVbGSphbqU5IxDFEjjkjv
         ABNTsz4n0gh1RvxO5zCorZUrEEXLudd5lGZ2hlH+kd+Pvn1ei3rMvMi+3+shmmBQMcyt
         L5Nk+JDzcSyC1ruBjz8g5TURvVy4gdUU1aZ9I70k2xiSZTYU6Kr6VjKGlsWAgB1kImlC
         6xQhcCZBWAhiUg+xOY6oUm6DmS25PFqN5PqLImVGJtbmWZxxbIW36K7jzCbwW1rEHD4O
         mmW5IGxr2A66b0tQqeAhHwgHn8GeTeT3/4lB3/tfS4yALXJrxFhZZVHz7l8kAvf2ZORb
         eMLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXXfCMBt2gwJF8RSK+7uIkg15E41gcYa5r/2rx7h5zWEJRkgHnvO9aYqcJNlG/8ZpWLzo8W2kYq7T+YMA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3Zg3JKp0TtAkhJVWlO8UYxaEnerXIX5ixHWawhalIc/qJi7fI
	Laf0/kt2Ui+zUoF0vqy4MxCkAIq4adddni/IPVXQYJI9aKg8iiBD/G5N7TRK/wYs2hU7sDk5PFJ
	9SWkDSAKiqeE40mv7aTSBj9jgyDQqcyYe3ZkvtJt1t7mMqJQwGvBHggkW55HohOmIQUk=
X-Gm-Gg: ASbGncujo3gQrxcKsj47mQcTlRQSdx5Ioj2jrBIJcl009Tsv3V6a89MIP+6lDLlnp8u
	rk44bD2Vdsytu1w6WSizDCSUUs7xB0XUg37BsAJkTTL+K6BzscDaluQsEwpf3hzlXe9fszegLnU
	j+Hkjrz4Q/aFxjhxAcswB+2eMvxPdF2tI9vyQ9HIOEJ25HImltDUe2PdV7SmmalwAZ7CZMNurIB
	6tlLusRn6mWVkk5Kb3VSxzsX7Ihf4Klrg483nJ7maXS3DJyPF/fpxvsSfiwrbLCLxuBj5JkcXIe
	vqhZsNPXG3nf1hAgy0IqU0hBwe7cZkPrRFKn0+d/2SVCVMzBz818vzY7PLsP6EEvWMeAb70Adrj
	vK7wkoehTM/pBNdKPLQ==
X-Received: by 2002:a05:6102:5615:b0:4ec:c4fa:c23a with SMTP id ada2fe7eead31-4fbe8743c77mr527582137.1.1753876894210;
        Wed, 30 Jul 2025 05:01:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvqburrLqOLTBhCJ6VDYkYHQwA8Vqi6itxndJTY3cfPYNQiShJQvXD/euk52g60pv2Ga9FOw==
X-Received: by 2002:a05:6102:5615:b0:4ec:c4fa:c23a with SMTP id ada2fe7eead31-4fbe8743c77mr527548137.1.1753876893774;
        Wed, 30 Jul 2025 05:01:33 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61544a81df7sm3572090a12.59.2025.07.30.05.01.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 05:01:32 -0700 (PDT)
Message-ID: <b99d2b54-b684-4efb-afc7-3a18635fcd5e@oss.qualcomm.com>
Date: Wed, 30 Jul 2025 14:01:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: qcom: Add missing TCSR refclk to the eDP
 PHY
To: Abel Vesa <abel.vesa@linaro.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: Johan Hovold <johan@kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20250730-phy-qcom-edp-add-missing-refclk-v1-0-6f78afeadbcf@linaro.org>
 <20250730-phy-qcom-edp-add-missing-refclk-v1-3-6f78afeadbcf@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250730-phy-qcom-edp-add-missing-refclk-v1-3-6f78afeadbcf@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: ckQKh5HU4XqTcdKIspgvGVoaiU14XL1y
X-Authority-Analysis: v=2.4 cv=Wv0rMcfv c=1 sm=1 tr=0 ts=688a099f cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=GIX-IF3Huo6piQy2-QAA:9 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: ckQKh5HU4XqTcdKIspgvGVoaiU14XL1y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDA4NSBTYWx0ZWRfX07Zp5wUb1u4F
 XDTpbqTBbIKqJ3ytaU5LULA8HR+krgDPf2nA3lJLREHl9dFY1mV2BiRkpEQ3jVtrMEuc/KMWb0r
 njcyX4o2KmnOiDm7+DVAzbJohK82k35HjxMEaNe/hPw1GHuv+uGkqzvKkvP9ra6abeS0w7/Jw/P
 +CPn6/udhCrZXF15hTJJjVZ8qqVJQ5bEsf5/ELts7kutf7J3PnS8DSHe5fAIlt5vqY8TeN8SlMq
 9+Abjg3hIxIafnGBOIDIHvBN+j4luvCMf9okN4yNucw60hwpUsw0V5YgqgsSgVZOZ+RAJ+2IRkK
 /Mg4eHVqlacHSkX9uIlC60+nGFruQzR2gusMuO/CQbaOzWmVRDE8pj2UHV01DKZpX9hE4u3n1ty
 C8jLUaUyxTH6Qo/SjN+g+WVq3pEPstv37sA+S5jVK0IEoR5eNqSRFoJ171x3942GMWdJg8Ii
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_04,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 mlxscore=0 adultscore=0 impostorscore=0
 phishscore=0 mlxlogscore=757 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507300085

On 7/30/25 1:46 PM, Abel Vesa wrote:
> The eDP PHY on X1E80100 needs the refclk which is provided
> by the TCSR CC. So add it to the PHY.
> 
> Cc: stable@vger.kernel.org # v6.9
> Fixes: 1940c25eaa63 ("arm64: dts: qcom: x1e80100: Add display nodes")
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

