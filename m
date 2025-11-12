Return-Path: <linux-kernel+bounces-897319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C9FC52956
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 272174F35B9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ABD123EAAA;
	Wed, 12 Nov 2025 13:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CugzfM3G";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MqGMTeul"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAA321D3F6
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 13:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762955502; cv=none; b=MVkJ2OemR8lk7QFKNtpkifLh48vOvSKza52XPEpQlh4RTKz27rLSQ2ZNIBU9p7bIAKhFwwKGpfDn6O8tC1Fn+7lJmgsKtw8Ufw/BICEtyJnZAnKjkv1Qi4s+E7xieA/P/vLGxzHM6WCiAuq4slYfLcNkgjdOLto6bpmHD85FsSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762955502; c=relaxed/simple;
	bh=65/ClbOI1CVgdU0S11r5SwYxThjB/AuSM0S0yIDQDsA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aBi+GmM3DCmSzvVl4iiZRj+fd2R3DLKR49oimijd23kjskQjFt4DAM+x8HAKzaC4DmtdrPZZxqcmfY85MFcUDY0KbDAW8Y5i/jcLAOj2DzhFwyMbMykYd1a6r9q0LY70oBMkm2weIaTOeh3HZ5or96tK3JLfNZJiHtvscjVn2Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CugzfM3G; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MqGMTeul; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ACB9Iva3060096
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 13:51:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0lanilZXsOqoFoASvnE/+cQ6cv+YIockWb3Z71quJ1Y=; b=CugzfM3GfmiVKw6K
	q8PoDQ++WDDCmcWeNPEzQSj/NKZ5g70K116ixZSwPKQdlVg0SHWIZ1ZTxPKnaHoA
	26t+eCR0HH1byu0H9oeoK88ZMdXtD3cnTCgU+d69zkXEPHkbYvQvXD3lDSVR0M53
	I2MJvlP4eWV5n/ww6oPXeUY0diNGTGTpOLXjSfoomyJlel3KQIfmchxk6LfX8atf
	h5Fhp/lbyeNrVDUual2xyDn1PGSTlLuwX9DJ6jXKz5bLwH+A2FuqABns6mXfnNZI
	owzxGZy79F2eVy5uOvG5Gt83K3h0dXD+GCoWKELoF0gXfeuzqeGb3zlb3A+M/AfO
	yIMb1g==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ac988k94r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 13:51:39 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ed6317be8cso2680051cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 05:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762955499; x=1763560299; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0lanilZXsOqoFoASvnE/+cQ6cv+YIockWb3Z71quJ1Y=;
        b=MqGMTeul2wS8dn4Zmd8fsVPSjO4ChIW8vICmcxzTRqBQu6gSru80X8+2/5Cxxz7Wdy
         sl800Dpe79p8K0mfYLlknuB9h3okjfgXlPWhrt/MwW9kpRGpvPvCOJ3fFVH1hbJdP8I5
         q5G/0urwDNzYMn2G7KN/sBP0RUZXJvjM6im55qNINHVSdbTIIuPHITwj6ofEjcshGiZF
         BmtdCwmpk70UuHodgWUKNsWS0ohL9WwIQGBOt178Wx4j7Wv04lIHpnzXelz9BMvAPMb/
         dg95vfLq7aVNozXXMlbeE+Y/Al+eMIyP1jIdjg5Q9ccmSfZAtacom/L+IpBbk0mrcqyY
         TeqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762955499; x=1763560299;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0lanilZXsOqoFoASvnE/+cQ6cv+YIockWb3Z71quJ1Y=;
        b=dE6sxfYHHPmKALfibUCwlwTV0zWZCicNlRVRwu/umKwoqttB+uzgNxZzeMcA7oUhE1
         tuzOTNBwlTMcs9K//qrelUe6kVOkfq23xJXfyrKqOwLdDE8xZiTA0J3lM3eCXch+oOLX
         3RB7pkNfUeRWi55f6IvAa0Gc+S9EeNWm8say59mV+mqzOz3nzr89Vhpx4JbEfpvzUqZ6
         pMNUEcV6SlShW0rcsaOT/1rIxGepn3+vHmXm6q0hqfGu2CORvQBbChBMU6gdjsM04fVJ
         qX9Kt+6MYoUAVcOAecJJreW8+y88CbSVRGIBjHaUf4y70dSeQnOAYdu/GjAi/kPDK6QZ
         4mPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxZGS2ylJNa60EqBxqM4pZ3lUVplpVolzpku/zs6qlG/Y4hl4BryoJJAjvrj6CMkkl61ppDZo4UqBiEqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFnNlzElYQk4yOwGGlsdVO0SMXPeIs23Keh6Fac9QcjMMqkdNy
	mTF9y4/EwSgpoOwPP8pXkc7d+t/5qZ1ermUezjcB5yOznJ/kRB3RF5LZFU5NhXoP0d5qKGcVW3v
	w90SJHfHkEMoTC9a4Vje0gXOGGa26qXtEkMaYJzs5owsDDjKHdq/AP5kzJmoaXbiDx9c=
X-Gm-Gg: ASbGncseDUVjDVZnuOCDzV3AB+5eQvosbG/bqy4j7cieEJl+mX8m6LtHsLD2q7Di62A
	KHom0rlctG9QAmoe1T4HeQhIn74XpExUFmAjceqG7vUfL1b8Kgd1bMCQ22KXJM7HeMK/h9a46VC
	EQM0P0WU2TSvXC0ZuGTSKHlvzn9io7azDhsSqRFAVW9pPALyOplTx957DdjQuhuLSYt2HkwVqZc
	6iUZCJdDuKh5LJgVX2Q/hxHa97O2psWDKZLAqe9CBUXW3e34cGi3ncNynP2PHVhiDR1/Vzl3xUx
	Tn9ud3sHwZ+Hgtpi+wIsMdspa9egn21MnegmbnHAnWL+0cKjZaeifR0iOi6KmfGdZVdesOHjSNI
	Hw5kkIRBqEVL/C6Wiv1hfg5pWp/7vMxzIJBa5SRn8oQYfwrTtA2r2pa/6
X-Received: by 2002:a05:622a:1195:b0:4ed:a574:64cb with SMTP id d75a77b69052e-4eddbc6b690mr27974091cf.3.1762955499057;
        Wed, 12 Nov 2025 05:51:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFLERtVCAbAsBFIDkC2l2nbCe7apGB2UyAVJXf++DcUzHj3l0TPdlFo6l2euGgQ30c2D/AZrw==
X-Received: by 2002:a05:622a:1195:b0:4ed:a574:64cb with SMTP id d75a77b69052e-4eddbc6b690mr27973771cf.3.1762955498536;
        Wed, 12 Nov 2025 05:51:38 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bfa11367sm1583115866b.68.2025.11.12.05.51.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 05:51:37 -0800 (PST)
Message-ID: <f8ae7491-cae4-4e47-a1d4-344e57117e7b@oss.qualcomm.com>
Date: Wed, 12 Nov 2025 14:51:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] arm64: dts: qcom: sdm630/660: Add CDSP-related
 nodes
To: Nickolay Goppen <setotau@mainlining.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux@mainlining.org
References: <20251110-qcom-sdm660-cdsp-adsp-dts-v3-0-d1f1c86e2e6d@mainlining.org>
 <20251110-qcom-sdm660-cdsp-adsp-dts-v3-1-d1f1c86e2e6d@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251110-qcom-sdm660-cdsp-adsp-dts-v3-1-d1f1c86e2e6d@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: wBs-bDH2yLDc6S69c0njEkqCWnxZW25F
X-Authority-Analysis: v=2.4 cv=eO4eTXp1 c=1 sm=1 tr=0 ts=691490eb cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=OuZLqq7tAAAA:8 a=EUspDBNiAAAA:8
 a=7Oru3VZ2rc5tXTzVnmAA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDExMiBTYWx0ZWRfX5XlPBxmpsG+K
 wuFv7+Xnd3kSAR+5F/goPDm2HdeDgsZivV3paxqMrT4V8TyxWeDj06bN5IdR56cfTKVgygkJF7a
 /LKetQ1/wf8sKCue5G2hv08aYrpKKUoj+2tfJQDrlSAsb0bgFutbEgMIGVRUE80m4qSn0XNYfhl
 xsLpeRfcTwr6PGiBXBe8w6OcomatcU5AXke/VK8cfTjFbxWG7FbPYvyu2q6qF+wGgoPmisZcX18
 QNQxJWgl1Cp7BTw3y8FcVwoMdIQxMsFoCPnYIhX9kKzP9/r/W8R2v63hED0JPu0hol4rZFEpUld
 4aT159raKQVVPzwQwFGFFc89dDe1Br5UHNcVhSi6jZBXDAvS10z2XmGrPNBItWY82bR6sm2aBXj
 KEpv7oscCsFfjtsdLhS/F4LQ8zbAXg==
X-Proofpoint-ORIG-GUID: wBs-bDH2yLDc6S69c0njEkqCWnxZW25F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_03,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120112

On 11/10/25 7:55 PM, Nickolay Goppen wrote:
> In order to enable CDSP support for SDM660 SoC:
>  * add shared memory p2p nodes for CDSP
>  * add CDSP-specific smmu node
>  * add CDSP peripheral image loader node
> 
> Memory region for CDSP in SDM660 occupies the same spot as
> TZ buffer mem defined in sdm630.dtsi (which does not have CDSP).
> In sdm660.dtsi replace buffer_mem inherited from SDM630 with
> cdsp_region, which is also larger in size.
> 
> SDM636 also doesn't have CDSP, so remove inherited from sdm660.dtsi
> related nodes and add buffer_mem back.
> 
> Signed-off-by: Nickolay Goppen <setotau@mainlining.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

