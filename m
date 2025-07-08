Return-Path: <linux-kernel+bounces-721747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 185CDAFCD67
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 16:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A90CA48219B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 14:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996412E0921;
	Tue,  8 Jul 2025 14:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VJNiH6ms"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B172DFA39
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 14:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751984511; cv=none; b=CP0zevA5GGVzruYhZhkT+B5yNAqPro78b+uFeHUlozgIDI6qJnZ+oo+MYapRBAdX5QV9j0gtNyJo6RXcRnuOAt1zGOpLXdDSM6F2CuDWmQUC+xQvwDB0R0lA/fOOY3hPa+v8Dru2a2LETkw4koRuFNV9lA8TeW5dXFfEUtDv+RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751984511; c=relaxed/simple;
	bh=ugicuqbU1yS1yCvIzcXqiNr1oJADRuqRGHGqN3D/WO4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jPnc6ne99bBkWfoLewft0GKBGo/bbvj+uwsy8Zs14OZ+I4tghvc73AzAJIL6lwu8Fs3ivn3CzGlq6OdhFv9AfLubDo21ai9WmI75OfMQrlx1PAr+WTmgUqpiLIx4l/PwdZ4T7BObr4lp4lIo7Uu39MeSE/mmA6eI6DEjuyLyQzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VJNiH6ms; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568AAEWJ000313
	for <linux-kernel@vger.kernel.org>; Tue, 8 Jul 2025 14:21:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cQuSWDFSA70+qgC1klmaXdIjk5aF+kYMGvQICocunPY=; b=VJNiH6msDsbeHFjP
	arrXtXidBm25fdeM4YcJHLNIyGmR7XnmoqRc9hBsAn7CkUhaTwCLwZ6aC+yoISAL
	wF1FjBMxUMZD7emboQbEXQntcoDRckVcu2NP0wpkYUATws3tLkXjioqoTsA8ifcD
	lHkVqDtktdh234urapuag2baC/pTgIQ9MB9JcNCbrnLVOx84YDkG0V9hROY7OKtD
	mH7Da0KcMpVaEz6tfVvBgL7xACd0KuRHqzSlyL958zJtQVtPG4T9RbVi1hCfKuoG
	UREriNUvwiEDVRdpzWGmTm4WhL0S2bFz5FZIrrfF8FDMm0W3lFrQeie51jlPSjSu
	a2MZPQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47psrkp45u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 14:21:48 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6facde431b2so15472236d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 07:21:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751984507; x=1752589307;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cQuSWDFSA70+qgC1klmaXdIjk5aF+kYMGvQICocunPY=;
        b=wTAPc5biznhWV3JqFNvpHmobnz/GOy6V1Gt9X/k9GTit7mR3S9RCSWvxEU6gqc31fI
         EpqZVJcqfl+dp/DDP6I7AVdOcO/msGLqcfOFtpD15d2tF6qv7caVFbVJWqWsX+1DquoR
         YDowZcMjUZSB62PknST8lU3sFGu1YmueISq0R+DOHoLd3G3NgXsqf9/8W+HV6dwhfe0W
         Mk3yNQJPeYNb0W/g1BkyBYhtHzOIkgeJjRurikUsCe1efFGN1BEH1Tf1mqIF7kLUojPE
         6m77Mnn3FvEGR1+7JVfhg35cId40LuoDXN7qcPo6JClpvO2PhCd9I9nStCL/eiqvcZhq
         Q6Nw==
X-Forwarded-Encrypted: i=1; AJvYcCVIn4QDex6zY7tJX903Epiw9eB+QbR0fOhKabqjgzzjly1PRVfwJOIClAka57+TQMHiiJRhoWcQm2ZX8lc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlDmWuxYE5ri4msesXbVR1CnibaBk8o8T3lg2XkZbBTw2GYY1O
	HO83DrX+KNKhoXPZWEeNugWQPee4aRLnOLmM7Hhsim4ad9yIUFwzt3Jw+z+FAdGF6xFBxa/oz1z
	tsJCYXzIFHU9xQOQCkyA2+N1L8nTJiXxIxUp1b61mQianWNEQMC4ZaTfaOtIGuf5XCH0=
X-Gm-Gg: ASbGncuLDC/YnbyQoJ5FKUGQbMPQmuACb61gjX64apMLxJ3x2Kduw63JkMRBV7ZSznL
	YSVm7IOq9T8r5UQQvjz9Qqw/ZDyISrTOfxVIsMwG5P/tiDbNwrkjgUsWDSKBy309dAHxgRFoN86
	RFj5aG9VPzKx8Q5/fGZOw/d3LOgvf3hFY8M/COf+jap8sXBsfN7ao4qDgY44WeFNadHfKCQap4V
	X171VoXIewBpayqktvsx9pvzTh+b4rWG+9oXbQGggEtDsTFoNrQbWrV7CiteYhVz5Kv2lEvhEg3
	k93wsb/Bufg4ZBi4wAk2mH+d8CSAPPSgmQR0ksHSWpoNOIpXUUYpd2DwtS4C5ggxqSsKm5rEPGz
	sQf8=
X-Received: by 2002:ac8:5813:0:b0:4a5:aaeb:dce2 with SMTP id d75a77b69052e-4a997874756mr89452151cf.10.1751984507340;
        Tue, 08 Jul 2025 07:21:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdN7Ey91h929pRUN3VOhjB4VPDzQq/iGbSnqJOc5DJSrf1PKUFAopp+cxtucXt0oKQalORIw==
X-Received: by 2002:ac8:5813:0:b0:4a5:aaeb:dce2 with SMTP id d75a77b69052e-4a997874756mr89452011cf.10.1751984506884;
        Tue, 08 Jul 2025 07:21:46 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6b5e86fsm905004066b.147.2025.07.08.07.21.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 07:21:46 -0700 (PDT)
Message-ID: <ea030c64-61d9-44e4-b4de-eddd626dffd6@oss.qualcomm.com>
Date: Tue, 8 Jul 2025 16:21:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] arm64: dts: qcom: ipq5332: Add the IMEM node
To: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250708-imem-v2-0-692eb92b228e@oss.qualcomm.com>
 <20250708-imem-v2-6-692eb92b228e@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250708-imem-v2-6-692eb92b228e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: E8hq9JSU4dqX98z9TduyYz624EorhPQz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDEyMCBTYWx0ZWRfX6kKsDbxPrB6T
 WeG2navaHuVXej1PGjZ3eIVGVCtCsbWeplfJSdv87ThYK4fvTfKa/NzGVc7Sc6GSLgPNQAo67cO
 q2tjP2MmG+2VD8AZz2M/vnfh91blT9w2qsilJUu3CPOp5a9jAb0kc+8nGSfGDV0gVzqis4YUler
 cIgqy+Hd9mdhm4U6ULnfEU9MuSVf1+F2PQ44ZmmebhWEZOlDxZCeSWNa3G8H0j5epL3bkGS0dJ4
 RNkf/DNFNq74lLJoy1JkVtkYrXdlGhugWJZgjpxeuMWyCQlx1pLWREARj84F9Iwv7sF0ChenMZu
 QIV4GO00LyTPNesYhNQf6XA5wrXGIqpw8Ce5OrMHCB4L4F5l0EAru+ici1+MWZg78JZPVBYZatb
 mYpyeoXj8ntinKa4SuAQEtEFhnXMQxiDh58o6g9UIDRqGXd8ATB34MnpSc9zoU4m8YNP647O
X-Proofpoint-GUID: E8hq9JSU4dqX98z9TduyYz624EorhPQz
X-Authority-Analysis: v=2.4 cv=GtBC+l1C c=1 sm=1 tr=0 ts=686d297c cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=owAxAYLDMf__z6yt7SIA:9
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_03,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015 spamscore=0 adultscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 suspectscore=0
 impostorscore=0 mlxlogscore=744 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507080120

On 7/8/25 7:39 AM, Kathiravan Thirumoorthy wrote:
> Add the IMEM node to the device tree to extract debugging information
> like system restart reason, which is populated via IMEM. Define the
> IMEM region to enable this functionality.
> 
> As described, overall IMEM region is 80KB but only initial 4KB is
> accessible by all masters in the SoC.
> 
> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

