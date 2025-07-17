Return-Path: <linux-kernel+bounces-735952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC6FB095C3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 22:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF60C3BCD73
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 20:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8822AEF5;
	Thu, 17 Jul 2025 20:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X7tc7O3p"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8981F4623
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 20:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752784408; cv=none; b=r/9XZESRGK3VVkNSbRO9OQtmLbgTTzRlZTqW0/3KSA8oQhNIxCANjPvyLbSdQ5MnEMIQgNsN2AsacQyQAp/UrPr+Wv2AYcHtS0XHD+c9Eysd3jlnAVpXpjxJ1ZJ23/hnmq8P1vuNsyRoWcC91pC42ZUZOXd0V3h6lKyF0F9Bj8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752784408; c=relaxed/simple;
	bh=465kQ6yQTPhCxldTUvMEum0rUEyB5JyOVUpOTCjgfok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CE+LSeKfkg1wdmKcexZBpAwzsX6CXha2oMzsjRUA+dBVNPuDEQB+3Lf9THjacX595YxvFWsbCAK46rYyXKni16KCzf1xTsIYZrnq/FYjYNPAvhEkyAe4QEaRj1K64q46I05wHZa/MOsNEAAnxye7kDsVtrex8bu+BNrE34vEvMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X7tc7O3p; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HCstT3021647
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 20:33:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8nModRSVGZSsZ5DL7kr1DuhtFiXYpOSlYAQ311KsRLY=; b=X7tc7O3pUqk4qN7j
	RfmUHeG5JwOtJOe0lIIJrPb0H6dHfDakZ9Hdx3/4GAkQ82gUPKRNh+sNOsVSiIeV
	6IilwXAQZnW1kjMR3cm91DonN0vW7efrAlRKtYLmhSIxjYL/nVdAu72YZcZl5pb8
	Pm3WPV246TQECUTJwiOD80QL24MkfpvfqBN30isWBTRUYRn4QGEJLQKqdZz/I3uv
	gN322mKC/d3opYz4g6BTwlSu5E38BELG24Oh80N4LdoCm8JaYcVEi23mRGCBWoxQ
	ncdY2SgZhChbbTk1m9zqP9I6E2cDYPknO7/6FFeaDgHmAi/2wMVeJSbd1k4Zelgv
	jmbKyw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufu8gxjd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 20:33:24 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e33e133f42so29968985a.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 13:33:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752784404; x=1753389204;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8nModRSVGZSsZ5DL7kr1DuhtFiXYpOSlYAQ311KsRLY=;
        b=qqX6024zlHVM8cExY61VXnVaSRx1djRnPs9Y4OffBQY7SN7mmpcegf9CjAH+01DNPT
         HkHedVXSKvzkcCmmOdg6X2eqcOz8126N29GwuHSRqTvnYgLiTHkNwqfHWOCZCujM8LBH
         ujpu5A6WdcnpyxVa72Gk09E+e5Xw+j1Qg6MNj01qv0u06PqNv1utyhopcQxuguYgQ+AI
         qQyo70iaHu7nEqc4Uw2uylG6kqGcfXJwJWzJwoOLu5g2syFXmpwjn9gk6wDFSItF/R2z
         U0b24+Jjv/+DZU8MrMQVGEbDSdTgb+VpROXEQuqMPC+dexoCzkJxnntJusnrL3BaMsTC
         g02Q==
X-Forwarded-Encrypted: i=1; AJvYcCVHlN2IYLgQm3f7fdox+Qf38vmcK+Oc26DAmq7avCtKPUFpwXfmGfNP7oIrNBEza7hveKYY++eT6QA3QZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwftlU7KlmXRfE/IVI/yC5wUMOR9omKLBGVByozpiVHwY22yoiN
	j8D3CLAf3seQvtUiuob4Oll5SYD3EgNah/3Me8YgWXmuDbRDSIQB7It71wFB6iTttJ+9sOsU61a
	3NvwJH1xvw5BvHOstSwdgZ3uQowfL545rs4Ya6K4NQs0EjuJhD9xMmfYwTwmObQXWiSk=
X-Gm-Gg: ASbGncseIXsn8aR01YXnCJf4uuQCEN0kYTyxRn0y5oqk/qCIGSMDysDy67ogz/NzPeF
	JkxfcBjAaTipkw2QGTKQC62LJ5uCx69KjpaBDmO6tgMWmGbp44y5AbYV1ByQh4TcmPJHXMNOQj/
	rxXQLESgYUCaznER86NHKrjAMN8G1Pc9H1/navqdWuNIIwuG4uYIX/Sqs0SrOxxf4aCWo4c0Vrp
	1UU/sblyMH8n4GgdxUmE1hOVEHnWF7+arGruI/v9C3O6pA2RUSMg1DM/mlbydKawhT6bUdyCGmZ
	d95DCNLmBCjVFEP+H5jmS+LWWP+/TrOdp5dpr72uAa2RVKEH8yVAleaMVV8m/ETvWxEebzMY8aE
	k/oYot8xWpUSEzeMCFS5T
X-Received: by 2002:a05:620a:2697:b0:7e0:2b47:bd68 with SMTP id af79cd13be357-7e342ad5730mr507121085a.6.1752784403726;
        Thu, 17 Jul 2025 13:33:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHq7ne2sTqDVyAUeSU+0dYOV0hFl3hEPNgP0CsgwNgE6XNHuWeZQZvq7BCuCRpH3GkUIIYwqQ==
X-Received: by 2002:a05:620a:2697:b0:7e0:2b47:bd68 with SMTP id af79cd13be357-7e342ad5730mr507117485a.6.1752784402906;
        Thu, 17 Jul 2025 13:33:22 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82dee16sm1424518666b.152.2025.07.17.13.33.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 13:33:21 -0700 (PDT)
Message-ID: <37932b96-fc4d-4321-8986-8f975b0c1350@oss.qualcomm.com>
Date: Thu, 17 Jul 2025 22:33:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] interconnect: qcom: add glymur interconnect provider
 driver
To: Pankaj Patil <pankaj.patil@oss.qualcomm.com>, djakov@kernel.org,
        lumag@kernel.org, a39.skl@gmail.com, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, quic_rjendra@quicinc.com,
        raviteja.laggyshetty@oss.qualcomm.com
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250716151535.4054172-1-pankaj.patil@oss.qualcomm.com>
 <20250716151535.4054172-3-pankaj.patil@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250716151535.4054172-3-pankaj.patil@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDE4MSBTYWx0ZWRfXzbN/MkQiqcPQ
 6xx1g/KzLNDT0j5qSrffCZadD0c8EEQQkWKVKV87gNBZciVbgkWef+qpTsrVsP8bbVZCeA6VGtx
 8cuO6b1lhZdGwF9giusULAy8hJPtyKZyDGF34IyQXo+/NE6JlBul08cSmECrqwCakY6elPMhiAg
 tfasXvc0MBadfyn29BvYX/YL8Z+qo23TeE7EQhAQEaelF1rdxgNImQEM1hC4t+7Bz/URd8iv7nN
 IPDWidpd4hlvC7/8xI283R3YN9Dq8fW6BpjJzXcpk9e4d2bQqg97bSPVD/s4NNudmp3qLLGQGye
 uS+8KSydX0uRhZvALTCYsrClvPwocMmb3LiHwrFiLWPd5dWRyM6zW4immyg4HFoB5l31mThic9B
 rhH2ZKzfeF0KGy2BzCli/EGElpc9SR83iB7y1Uu31wTUhlS7PJWydZH2uKWwa3csM0gDOcyN
X-Proofpoint-ORIG-GUID: ao74z32WgfVmdSbLpngvAt0b558Y4S3T
X-Proofpoint-GUID: ao74z32WgfVmdSbLpngvAt0b558Y4S3T
X-Authority-Analysis: v=2.4 cv=f59IBPyM c=1 sm=1 tr=0 ts=68795e14 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=2uCcKERadT1UtqjeBP8A:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507170181

On 7/16/25 5:15 PM, Pankaj Patil wrote:
> From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
> 
> Add driver for the Qualcomm interconnect buses found in glymur
> based platforms. The topology consists of several NoCs that are
> controlled by a remote processor that collects the aggregated
> bandwidth for each master-slave pairs.
> 
> Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
> ---

[...]

> +static const struct of_device_id qnoc_of_match[] = {
> +	{ .compatible = "qcom,glymur-aggre1-noc",
> +	  .data = &glymur_aggre1_noc},
> +	{ .compatible = "qcom,glymur-aggre2-noc",

Please unwrap these lines, i.e.:

{ .compatible = "qcom,glymur-aggre2-noc", .data = &glymur_aggre2_noc },

I'd also request you work with the author to provide the ICC QoS settings
for this platform (which would be good to see as part of the introductory
commit).

Konrad

