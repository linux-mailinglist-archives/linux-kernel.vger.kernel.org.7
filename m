Return-Path: <linux-kernel+bounces-737213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C329B0A94B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 19:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88AA41C25FF4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 17:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF8F2E6D26;
	Fri, 18 Jul 2025 17:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FJ8MecaE"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97A94503B
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 17:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752859295; cv=none; b=Uv5Npt+Hk+iF+gses6o+NrjxhtaijOxfrWIPrqu2W6osjW2FvHSnE1908HQnDVOyP751c3KcgNyLLHT8RWUevPbH5PkdgEb8OVRCMuSBBo+3FQUx72tkPPRsHm8JXtA1w2l48vpnSe7brvXsyLWv0rObQ/anoHjtx7MH1R/Igkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752859295; c=relaxed/simple;
	bh=Iw5grXdfExOBq5dniqWhDt/znX4b7nSrmolECaBxpeM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u7e/koRbWQ5sIi6B/+FsMvMGxVWewo1h4F04f8CzPCqp1JG7gFnGa1vAo+98hjdgrNYu1i26BEzkGmHmh6DpHAiXbUJapdRgKZhpYKg3ZmLRLfjbOxzMOtrjHOZwxIMF6KGrSqVRTTdlfRmQ0k4zMkPLSc0JxE+WRPqqJAEaMg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FJ8MecaE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56IGlMUp000541
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 17:21:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	06hO/weMed7fQm79ThGdUddmr6lCUcgv7otkkBDExXA=; b=FJ8MecaE0Y5zWt8X
	iuI0TJRtb8i9imFz5W0YZSMuxetvadmBH4VL/oXt4Y1Wv7NIZP/mIlkJhAGx+qe6
	JZxkyy2KuvYiBmSFLiefJKXxBsYskfZ4yiIiGM3zn6StR+A0JQGlwwSRVs94vZf6
	S0gSmemesLXJnYbcKRl9Lk61yoWts3fLlk1uX9hyHjFbY2nRxiFAs03YRih+nfth
	ZFA0vC4c5gSbPPS2vHu7pkN40VEV3GyTYwXevPZ23BMm3KKXg+CgsuzyxcSNFm8Q
	hmQk2DzOwYsgvs+aVl+80s+1TCWvvPSjzKtuw4hK9+PKpcIsZAP2if7sd+OgyEw4
	kql3AQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5dryf9b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 17:21:32 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ab61b91608so6648101cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 10:21:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752859291; x=1753464091;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=06hO/weMed7fQm79ThGdUddmr6lCUcgv7otkkBDExXA=;
        b=RhipfsyMoJweekdwRM5xnff6OG0E11Rp1Dqfm3mFFk7IgMMGtPxQ057+M34LC6oaxl
         AaCiOdbq2ggjM16a6RailSKfhJ1I7kV8cA75SCYvERZrmhOIs+NW97/4gGwY++ODCg2L
         I01FODAN4C69vKsIeA5QfjnZkp2RK/pXj7WfdTjZhoU+Ui8rfoifhyCpmnUAFXkAR3Pe
         OiI696vUK5cUevVa4cMemi7vbzp/kPBgeBF+DlQy1JGD/vH2yUPHtFrQyQMTh5PiPSHG
         AHpXTJSx9jQQLkjK3B7X5DGtDQhlUEMy9KAUuq3oNBXbMB5E1vOOxdF3KBWLBcD0gbp5
         bkRg==
X-Forwarded-Encrypted: i=1; AJvYcCWBk/R4rPph7mU/8l2rTT363J4KSOYFxoFDvSfb8XLNmbqeOwHNrN1om+j/f5qCiAufkoRyh+Xa8Rt4NLI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyIy/9O5MOtoebE3wl2QoR6rhswaZe9XfHYdlbETMqEExlGs6U
	jIIeu7sN7tqjHlHPuBo7+XMPyVFSfqEBctyqNthVlqZj8rE3m2mO25n+5wAN7RN6ENc/uVaMoYn
	muqHiM5YUJBoXBvcnqxjQjKj4cyUG+vVE523ltvUWsLYyCv9FwMg+cE3O/6fynM+2umA=
X-Gm-Gg: ASbGncsLOYln7TWXYEDH+ZABPUWh9vgrbS1d01/jE5IsGcLVqKSR/cCRqUy3vWWKjzC
	/hpyov8ZOGbpzQt19MTyDBNS3jJJsxg7x1U5gRCr/HedrTm3EowtLZkxE7BylNoXTDcacV/REDU
	jeRdxQcY4Vo0+1lwtyBjNV8xQyYtcjzhJmOesghJQZF1flitPXC6FQg3RJNvHJAkIStyQ2V0WlY
	VdsfnpDNXS5hJv8IMpvrNHMIgrahE5pYRQMspJuuhYpHWp5zNVte5PQdMuEvs6hF1cr7cPQtF+L
	SzmHj08q1SxM+xNGuseatFOb2iOf1D0VovAY3IPPn+JDc0ud7lIahVgW46QlwutM4XC2o0OfEN+
	K7x94myghimnrVdu7RmPI
X-Received: by 2002:a05:622a:1b1f:b0:4ab:609f:d7d2 with SMTP id d75a77b69052e-4ab90c8cf06mr71803171cf.12.1752859291268;
        Fri, 18 Jul 2025 10:21:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPssClCCUe/Z8bo8MgUBvYHGyuUUl0g0+QJt9SpC2YT2VaORgZHpAgbDhXA+B6Btw9D6W3ZA==
X-Received: by 2002:a05:622a:1b1f:b0:4ab:609f:d7d2 with SMTP id d75a77b69052e-4ab90c8cf06mr71802891cf.12.1752859290758;
        Fri, 18 Jul 2025 10:21:30 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-612c90a9098sm1287395a12.65.2025.07.18.10.21.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 10:21:30 -0700 (PDT)
Message-ID: <eaab7061-a02c-43fd-9a02-6ff9625401a8@oss.qualcomm.com>
Date: Fri, 18 Jul 2025 19:21:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] dt-bindings: power: qcom-rpmpd: split RPMh domains
 definitions
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20250718-rework-rpmhpd-rpmpd-v1-0-eedca108e540@oss.qualcomm.com>
 <20250718-rework-rpmhpd-rpmpd-v1-1-eedca108e540@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250718-rework-rpmhpd-rpmpd-v1-1-eedca108e540@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: GqzKCodCy4JsTqfMnIpTGDWCptpRRKJK
X-Authority-Analysis: v=2.4 cv=D4xHKuRj c=1 sm=1 tr=0 ts=687a829c cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=0q-T4vpNF8mo4nd_0X4A:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: GqzKCodCy4JsTqfMnIpTGDWCptpRRKJK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDEzNyBTYWx0ZWRfX8w1VXaWSksUF
 QluRvt5pA7NXjyDRflbQGIfEoRcisMYTZqV9BRPk2/mC0rDQSBL30/KZunkPLKSZ/k2ZYlQp/80
 3PapFhWBN6a1/emQRgXB1AnGw04FknR6PIVt45nRwewr2D1BUfTotqoaHKKeImA6vKPc2fJRMi7
 KAmYr4zuaJZh7JwzyZA3CDmGqpfw5ENtoaBNE1ZLumTR5UQuNIVajzbRqxY4osf59CdHBevZM+z
 gew/vO6xAiXJ6+FpQG8guNGqmbT2fGT322GvjjfWNc9PK34BTYBxbu+yhTHl+808fGEH3ZscBvT
 YhYied0qPVgIwXc3nfenbTUixAyTlhNaiHnw8N/h2gFVqyu3Yl4G++4JO/GNzwV5Headcs8RpFc
 ultBLPH2I/q5ubv60Le2NqozS8rOQ4ZopDWnzPjftOhVGXrMRME2frcWmjBSQiKcV3FYC7HN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_04,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=642 impostorscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507180137

On 7/18/25 6:13 PM, Dmitry Baryshkov wrote:
> Historically both RPM and RPMh domain definitions were a part of the
> same, qcom-rpmpd.h header. Now as we have a separate header for RPMh
> definitions, qcom,rpmhpd.h, move all RPMh power domain definitions to
> that header.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

[...]

> -/* SC8280XP Power Domain Indexes */
> -#define SC8280XP_CX		0
> -#define SC8280XP_CX_AO		1
> -#define SC8280XP_DDR		2
> -#define SC8280XP_EBI		3
> -#define SC8280XP_GFX		4
> -#define SC8280XP_LCX		5
> -#define SC8280XP_LMX		6
> -#define SC8280XP_MMCX		7
> -#define SC8280XP_MMCX_AO	8
> -#define SC8280XP_MSS		9
> -#define SC8280XP_MX		10
> -#define SC8280XP_MXC		12
> -#define SC8280XP_MX_AO		11
> -#define SC8280XP_NSP		13
> -#define SC8280XP_QPHY		14
> -#define SC8280XP_XO		15
> -
> -/* SDM845 Power Domain performance levels */

I was never a fan of these comments but whatever, it's an include

if the dt folks don't object, this is good

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

