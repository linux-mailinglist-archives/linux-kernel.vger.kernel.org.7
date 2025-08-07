Return-Path: <linux-kernel+bounces-758988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FA9B1D6B3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 13:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE22618C71E7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 11:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39190279910;
	Thu,  7 Aug 2025 11:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HLAGSglU"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDC2238C16
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 11:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754566242; cv=none; b=WINCKOKUPuTaGYlLma7+B/Kzbyweomqaf8RpPKZZ7n1oDl6KO/LhZJqI0SlcbTkvRXpJZ5y0ep7XjNKbFB4HjMum21jPTolgOk1Hwh2tT8y8T04F60Uc2Ly4rsCs3iwIwtzofadGImidTTt9CT6Ys7woAWy0pF4lTQ0YfksEtYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754566242; c=relaxed/simple;
	bh=1ll+EBd5lYDpGgeKjrKYbgl28Q2HDI13rIt9slkcFLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sJrEOPbkPZ5rPFS/rR6bT9R44TKl3gkldf1cFb1VNG5biaWYGSKyEH9lC1RVS4P4ovTFB6jwyvN9SlPlddxhAGIaj17xjIH2O4WxOjh2B1emwlLks1244uUlu8/H6z+A5NX0uMS8IVrbEA0KYRjq4imDLkTu5HRgLPj7v7518cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HLAGSglU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5779DD2c008013
	for <linux-kernel@vger.kernel.org>; Thu, 7 Aug 2025 11:30:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	i07QIqXhNjjKtS5Fw1YccCoO4yzv0J/LSujugm/+4jM=; b=HLAGSglUTlZq93XQ
	yRncmEvWj4OIWX3Kjh3HFEb7vVO2YPECaOipD6GBFb6T7UX3hQDO+tG9MT+u/xOz
	U3W/N7seJ7UWrDTs0IF6xRJ+Fj/PBZzc7s74ziAyVAxOG7D6ahQed2wpy0Xod5nD
	byhEfOcrYmR9Rb8lsSESbVmZYz0gDcj9Hdl3Bx0hq24D5/Tt3YWIfFhy1Zoffd9k
	fpBPmV5hbxE3/jWeslSuyqPuuUiPwF0EbJmeaQlbCgrwSGYWpcIHBdbyAifhbI2u
	SdB+C6Ez2WUaITridhA08Wq6/fUF1Zat0uibHCvRdDiSN0htsYSfV3Qcur1Fa4Yh
	RPeMUw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpy6x42u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 11:30:39 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b0938f0dabso1516001cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 04:30:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754566238; x=1755171038;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i07QIqXhNjjKtS5Fw1YccCoO4yzv0J/LSujugm/+4jM=;
        b=ezbu6zPSBRtKu9hVp1+rUpVCJ8Jq3+SzE3fhPQYVcyQKDTItFqSCTF1Mfee5YePD2h
         Wl4r/t5zk1xyX5y4jit/uc94MyHnuoRUAXW2zfBRueb9vN4/Q9cCh7LZY6Cfj2fh3Axo
         THNP2YGSNtHeG9kxOeYIClhL/wCulfHjZhbf3zbfAfv1+UaEl9qA9ZYh+LeH1uF4c7B/
         GDYMQiq4mqt0c7e40L359/OQvdJDdrH6xZ267ZAVe9REjouLhm7n8usgTXq9pzDR23fF
         Ho3KMh8qfNC/+q+Ir3MiI+2LusyXXX17XhlkXdT9/dR2K3mMQroHQnaXh78hB1TVeL56
         0SCw==
X-Forwarded-Encrypted: i=1; AJvYcCUSFCBb7Qi3EK2JKV6/fE8296FusVylW4FT2eFSngSamZBHiKGsT0fykkY3UrXJ7RpD4cHEaoI6zyLyRsE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLFH0S7oNangHVgHKqAJ25lUivQrHHOwywmE6966/DpL9xnKxt
	8ZwbQW6gvC95RkahMaCaGqxmMt8o2fmB2OeUAo9I0095B1f7aOKD89cGat73HH+qPdTpYbmtA3L
	dy8AFdFSV13TTO6/Kdu7Vkr/M7hsjNQ+eg1Vt0KS0Au7AUaMtMs6suCHc+/4naGaFEaU=
X-Gm-Gg: ASbGnctky88+OVlY+48ThaGipa7916kzTLUGVoa4yHfU3cMvkeRlNiyExYkVlfGLzF+
	sS/dx0nDgppGrXo2FYRbggIP4x26OSRrm1GZXbyn3mjVyUHZydoOm2bMB+wnWsbsVS50oMf9CwJ
	RSUOdLtmvJxfpLeH4dPpFlAQ02gAZVid06oVl7QdlepKKI6Fcz8pM1zBbdduFSF6Y/tEOgnCTjM
	sMezDVupeUttNsF5nR3jTGEoL7lWfMiaqHtz9aWQTRu9mikJn/Z5PGfqdtREGyBlZ5wNucZ1dOp
	C/85+Wvj1BnoiAK9kSR53IZoaVgfwZmbgniG21WdC6a674Q+0xQdTSMgVZcVcjU/Jz0upt5cd8a
	AxAoxSbUAi0T1dzaFMw==
X-Received: by 2002:a05:6214:1c81:b0:709:8842:56f5 with SMTP id 6a1803df08f44-70988425dfbmr20817676d6.3.1754566237857;
        Thu, 07 Aug 2025 04:30:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnXnONHbLA12/95Kl68dFu09ciwfUyG+iTcQrE/PkzMq5QqD4Es4erSTnNv0lGdP5+u6x8zQ==
X-Received: by 2002:a05:6214:1c81:b0:709:8842:56f5 with SMTP id 6a1803df08f44-70988425dfbmr20817256d6.3.1754566237129;
        Thu, 07 Aug 2025 04:30:37 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8f16062sm11590909a12.18.2025.08.07.04.30.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 04:30:36 -0700 (PDT)
Message-ID: <4d2140ee-f757-425c-8014-3909873e7de3@oss.qualcomm.com>
Date: Thu, 7 Aug 2025 13:30:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] spi: spi-qpic-snand: fix calculating of ECC OOB
 regions' properties
To: Gabor Juhos <j4g8y7@gmail.com>, Mark Brown <broonie@kernel.org>,
        Varadarajan Narayanan <quic_varada@quicinc.com>,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250805-qpic-snand-oob-ecc-fix-v2-1-e6f811c70d6f@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250805-qpic-snand-oob-ecc-fix-v2-1-e6f811c70d6f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: cFnu1FgH96XyioIgxudA89ckvl5DAkgy
X-Proofpoint-GUID: cFnu1FgH96XyioIgxudA89ckvl5DAkgy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOSBTYWx0ZWRfXxP2sYVjdQJ2R
 ml9o9PY49KWARP0EaVmZcFmfpb2cg/nmnb71ghJc48YYwrc84sJl+5dYkp8/iAGalf1ahDo3WLx
 3j9V3e87ELHAMoYMjnvTOYMFguvbj9+f8mCrZ3M4SJGfENmMF/o/l01Lyam9cAXMAtMraTgxweV
 Q+o+2ftebYDfspltO8OfrOPhEYsrQN/6aPzGLPgc7NvBTl4yTSLDidRwuwQM6Dr5imFHAGmxKeu
 nSmuVVAdl6VnADWHqB0ttiP7dzIdWfmdity+jbJEF55dUxkFQRl9UZHqV00mygRVk+0nHlyFtlu
 XN4bScxHS7d2JiFbEx+myqKpddtlfafF6ZrxCLpFyd+teoPUFCS/mU1vPXaqrbeKIodNen65n8c
 XkYJ+JyU
X-Authority-Analysis: v=2.4 cv=LNVmQIW9 c=1 sm=1 tr=0 ts=68948e5f cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=Al3NFTvqZ0TCkL53jQIA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-07_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508060009

On 8/5/25 6:05 PM, Gabor Juhos wrote:
> The OOB layout used by the driver has two distinct regions which contains
> hardware specific ECC data, yet the qcom_spi_ooblayout_ecc() function sets
> the same offset and length values for both regions which is clearly wrong.
> 
> Change the code to calculate the correct values for both regions.
> 
> For reference, the following table shows the computed offset and length
> values for various OOB size/ECC strength configurations:
> 
>                               +-----------------+-----------------+
>                               |before the change| after the change|
>   +-------+----------+--------+--------+--------+--------+--------+
>   |  OOB  |   ECC    | region | region | region | region | region |
>   |  size | strength | index  | offset | length | offset | length |
>   +-------+----------+--------+--------+--------+--------+--------+
>   |  128  |     8    |    0   |   113  |   15   |    0   |   49   |
>   |       |          |    1   |   113  |   15   |   65   |   63   |
>   +-------+----------+--------+--------+--------+--------+--------+
>   |  128  |     4    |    0   |   117  |   11   |    0   |   37   |
>   |       |          |    1   |   117  |   11   |   53   |   75   |
>   +-------+----------+--------+--------+--------+--------+--------+
>   |   64  |     4    |    0   |    53  |   11   |    0   |   37   |
>   |       |          |    1   |    53  |   11   |   53   |   11   |
>   +-------+----------+--------+--------+--------+--------+--------+
> 
> Fixes: 7304d1909080 ("spi: spi-qpic: add driver for QCOM SPI NAND flash Interface")
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

