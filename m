Return-Path: <linux-kernel+bounces-837017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1BCBAB195
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 04:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C88E1C342E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 02:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF5E21C16A;
	Tue, 30 Sep 2025 02:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V3iTXAvH"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1563C204F99
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 02:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759200807; cv=none; b=R1X0wSEPpf/laTxRa0Ec6Cl7ggpxvF11pd3tciuRyNOc0dfhsk48Jo0btSEWIxN/jRIZBVAvYSbXNJDAqgLpDfQO2rriNhIoDBpjA890DlLOlk+I4K1wmsc9yK4cv49lUBO0CsZE5OK9RGShLaTWBvMzZxF2EdCcBgRoQFVn7yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759200807; c=relaxed/simple;
	bh=vx+f1fQY2Uwueq3Jx9VQNWKhSt/AYmYcmnwfYaVLCf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L22RfU7WWG+iMPcvpJpw8vkYsS3hSBPPSumQpM34xuBn0Kgvm+9GprKKRhorTOhnf4G3xDpjdLte0bPHT/LwoLjJvBCUBBmK/mhOaRbfG92/ytZ0qteZym0nVvRvOmdKMaYg2d2olegfBQzDnA6MeaULLtT+W5W112m5ERKEXWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V3iTXAvH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58TH0XmJ029091
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 02:53:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ptmEaaTCFgclY0orIxraWd4bdye2B8I3nhnkuntUSC4=; b=V3iTXAvHQu716hMu
	lFlOXMFOLM7FRNpoWINAQOmdXf3hKtyIk+xH6+Gzn5FfR1fFQfa90OodMziHt2Wd
	K3uXTkpB05uEHm8Pr1GTZLdBZZ2kBlXUhw9QIJpNgI4HRrQGi6eXEEauG+lMjgoB
	07/tLRos6R2ifnwv2reoBEnqLOEdePEVWGz2fmlOUt8d/3lzO9QnKXqXyF8TvSQe
	5fEs2m/xpacJs47Fe91l6vuUnrGF9LEmh54ueL8zNeC8xSAtNHn0KLv4zrxPnFvK
	EeJyw2LsCcaTZIkaSaTnRZ2A6Lht6M9p79wf50tK///JrPfLB/TYMlSPdusInv/a
	qgy3ag==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49fppr2vp9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 02:53:22 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-27c62320f16so60927515ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 19:53:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759200801; x=1759805601;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ptmEaaTCFgclY0orIxraWd4bdye2B8I3nhnkuntUSC4=;
        b=WJyVTo8mpyqyUbrwqD4BbRrN8s0V1c866wqmg1clhuKohUWk/UWJNZyL+YsOhOm0rM
         UguyAMEKV/4Ga1l3cbP/1sVETMuqG+z12JyG6z3c92+eNapXQT79qxU2Td9JcI1qA6YE
         gqBLV4uOPKO6bDVjmN3xo+5zW1YErPEjs8nOy94/GXfMwfXCIZC1psOT0m4+Pwl54xjU
         BNe2Y4JEr5a5vVZPGZZmXskziAPXiVpeVd3Le7mueO6Dh8Mt0M8dY7LK8ZAbMKPv9wNJ
         yIHUBCA2fwyQ4UPkgGPNuxlQEsUD2uSAMOEqqfisXc4Hz6iIuQ89fabL+hJwjlYJiqO3
         sVBA==
X-Forwarded-Encrypted: i=1; AJvYcCVtCPQDAKcLMkfi6LzQasjpvbmVEb7iDvdWREK/D9emdbIiHu7opbAEgolhZvXIx/Aw0T1JkSd7rgtytjc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxySO2wdIfOj0EnNiAoyjc/bHxMXr8sF6LS4VMiT3RQuBrqaluz
	34VglCtojMBnTnKpSPwx/ptunI0P7fZN9TUDp5TzAyk5uIRr+jnLUfRL0WbH/+WiTwU3etwql3q
	vHEfnHikH2fYFeioYqKoVUJKPc9TJzaKMGmQzLya5oQcv24P1t0qBl7JdFbCQoe6WaZ4=
X-Gm-Gg: ASbGncvnD/mMdjBOWru0nSDCMxD3lGjuvMV6mlFqGlKmmuQsFn625XQRnK6hGP7scGa
	Kh72IB4kjbx22fJDMHj6YAOp3Oi8HGs94d4ZyxOGWtg2XQ3tQ9Lrd2nm6CfM2UjtdKV/VONGJ1N
	IQOVhCqlqLUZlGdx2wubbuB+haKjZ6lp53zqZ7zshfYXCf33nfs+dS+WWLNwJHmf5Buj+zSzvAG
	7WS16KbD0GFFJaPEa1tJpHVS7IuNRhCF3S6kzjzLmK940umaIMIp+3dO38LrSsxFV7jn2yjGSwg
	+R6bSN36kX5S8nL/MgZBpBYiTU2tIsUG/sLor9ToKFzRghshbPjmXtRomoZhV6JTgb5Sf/QbtHA
	yhXX9zlx+Dw==
X-Received: by 2002:a17:903:90d:b0:268:baa6:94ba with SMTP id d9443c01a7336-27ed4ab65b8mr164718615ad.53.1759200801557;
        Mon, 29 Sep 2025 19:53:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9BYMWp6hNCw9FidFOi2WDNeI5c08GRWhasex0PVEvIzKhELgPVQ9in2bgdPZSp3Wkfk1VQA==
X-Received: by 2002:a17:903:90d:b0:268:baa6:94ba with SMTP id d9443c01a7336-27ed4ab65b8mr164718445ad.53.1759200801090;
        Mon, 29 Sep 2025 19:53:21 -0700 (PDT)
Received: from [10.218.15.248] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed699ecacsm144700875ad.109.2025.09.29.19.53.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 19:53:20 -0700 (PDT)
Message-ID: <91821a59-d893-4807-a9da-bf7cb75a30f0@oss.qualcomm.com>
Date: Tue, 30 Sep 2025 08:22:29 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] interconnect: qcom: add Kaanapali interconnect
 provider driver
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com
References: <20250924-knp-interconnect-v1-0-4c822a72141c@oss.qualcomm.com>
 <20250924-knp-interconnect-v1-2-4c822a72141c@oss.qualcomm.com>
 <2mq2qqrgm5x4hj2cnstzsqzfk4lmzhg223hmobrjnqu62facc4@p57wbmkys4in>
Content-Language: en-US
From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
In-Reply-To: <2mq2qqrgm5x4hj2cnstzsqzfk4lmzhg223hmobrjnqu62facc4@p57wbmkys4in>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI5MDA4MiBTYWx0ZWRfXzfCtDZYIz9ce
 ZBXjxssPbhnK7jEUjRl5NkkHvm0YCM2izm4gc7f9itv1J7GrXt2R78udLbsBFGD2iXcac0anX0v
 e4AWr4MgsIY8Z/VWVaYi25WVhy1XPEj0wVJuyKEdaWU9ZsIpWsqm05kOVOw71dxR5OgKwGENfuu
 3+0EIFj7c1pLHgyI8Q+eUVuJGvgR5DjsAcjPsq9lge/wSmBfUVtRu6peHUqSGO4Z/nMcDlQcOZC
 7SMU5U34iKyC2tjjuyoVHs4yFR6i6A6HmMZ0Qm2STFh5+ryIJGthomrb64bGPVAn0T67MTRgSL3
 JxOQCdowfBYLjDjBL7ngJBo9vbh9fFmWaybu3P2Ot2OSPE+niJp/jon4PgmGb2rTWMz0sIbJN+4
 t2KFLJpv7vitlpyYddajanWFAPB6Ig==
X-Proofpoint-ORIG-GUID: s5jAJ5lD7jVf4KUO0JdHBbK8Y9vtWsbH
X-Authority-Analysis: v=2.4 cv=GLoF0+NK c=1 sm=1 tr=0 ts=68db4622 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=U-4vxhJDZ8N_SHWVoUYA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: s5jAJ5lD7jVf4KUO0JdHBbK8Y9vtWsbH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_08,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0
 impostorscore=0 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509290082



On 9/25/2025 8:17 AM, Dmitry Baryshkov wrote:
> On Wed, Sep 24, 2025 at 04:02:45PM -0700, Jingyi Wang wrote:
>> From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
>>
>> Add driver for the Qualcomm interconnect buses found in Kaanapali
>> based platforms. The topology consists of several NoCs that are
>> controlled by a remote processor that collects the aggregated
>> bandwidth for each master-slave pairs.
>>
>> Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
>> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
>> ---
>>  drivers/interconnect/qcom/Kconfig     |    9 +
>>  drivers/interconnect/qcom/Makefile    |    2 +
>>  drivers/interconnect/qcom/kaanapali.c | 1868 +++++++++++++++++++++++++++++++++
>>  3 files changed, 1879 insertions(+)
>>
>> +
>> +MODULE_DESCRIPTION("Kaanapali NoC driver");
> 
> Qualcomm Kaanapali ...

Will be addressed in next patch revision, thanks for the review.

> 
>> +MODULE_LICENSE("GPL");
>>
>> -- 
>> 2.25.1
>>
> 


