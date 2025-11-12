Return-Path: <linux-kernel+bounces-897003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EC043C51C81
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B40424F92F4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843A52FFDF8;
	Wed, 12 Nov 2025 10:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B0spYxp0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FVPJKQFc"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FCE30102A
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 10:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762944350; cv=none; b=YLd6YrEQJvq9GbmVLDzgCkwUQIc5lLAJsSbzknSZI8R9NVCw/6IpgW+PK62aeWJ1Vzdkb4SWr1RO0z7ssEGHo3xR5eshpHiUpHxhHSKx2BDsRG1QQMas98ARa79RuaLC4x/wgrrfFcHG9leUtJWC0EutufxBOv5ToNuQKmqeVo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762944350; c=relaxed/simple;
	bh=9aCCGemIgfyL1AtBT6bYDFC68dSaqm+osp1QFrrWuL8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nL+xOIRNsS8H2pulGwbmjWyMM5XJ+VlvptNugMUPoyuPNKM4xiTBikQrqh84f4mWTyLz5gJSBij+WYgyT06bTUB6sExV8oUBDlh6ozX7MoOvRg0MPDEUji3+BRIgISjc+uXoU/e+WaHLvu/F6jyGlC28VDd8JdiKz+ZFtYv0uFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B0spYxp0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FVPJKQFc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ACA97ZN3060255
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 10:45:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9aCCGemIgfyL1AtBT6bYDFC68dSaqm+osp1QFrrWuL8=; b=B0spYxp07c2RFinm
	0zUe7tJ1YIDKLgOyg0by/xUxowkM/HXagL2HR3LUrrSRsTXmdeW+CZoXCGK0gody
	7Dm9sXYZa7gnj47cd0KbqWc7rdUpi3BIXMkuCEbYRuhfTm2afbbluA8RWD2iRcmw
	vWsEgMmAgkqwzzEG3XUhq7w8rvuTNqDykinI6jAUuE8Y+MpN5gCKnR6HKDa/PMlK
	fKX6hGb6T0gFm4njkSfxJnDWy6EtwWO4yPvTJ95FmYJN6FaXC2jXg5LyQwtnCLnj
	hTEALQSCKOfKDVHce1DnHe5VGWsp8Cbso/CvUxxVZh9JobrHEwGO3Bht/IfQzs5o
	Dhgj2w==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ac988jswc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 10:45:48 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8b196719e0fso26355685a.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 02:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762944347; x=1763549147; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9aCCGemIgfyL1AtBT6bYDFC68dSaqm+osp1QFrrWuL8=;
        b=FVPJKQFcJr+NT+QSNbJuzPjoFr8IP/hLSNxUnIIE/6YOgkPJz6gAhC+wKx3ipK/uKD
         VjWf62DwFtGrinE34LbTVaPOuNElxnIAONpFMKEY7BBZyJM905isMxTedRRioDOKwnn/
         upDTHOJtKy0tHgJHFQaVOsLc81jwIHqXD83EcbMDW77+9TQjCXc8LJGNieZkIMg6cbmb
         mTMOJyutg4MTXCFTMQ9cbBnF+/VUxnnMi/l+rPbC2E40pTqe3uUM2eDjaA2a7ifT0FHW
         flrtnN+4+D6HYzbzzr49y9NsAhzPpNfEaOzTOyNAEJXSs4hMGQAe5qwlkCQP5dcUdT50
         zZlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762944347; x=1763549147;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9aCCGemIgfyL1AtBT6bYDFC68dSaqm+osp1QFrrWuL8=;
        b=A+vtdMA6SFzXSRzYjWXNY7p93dec3x7H2ZzeeY118mKHhE2yCctRTkqkKEN4H5PS8R
         KXz1q0aYTyRjUHLHRN+FycYdkPPYTNeiNxMI9l8qVgcp3kEGPvmzA27Pwzs1kMTXv6kK
         61gTYpbEVZSIsuB05Y1Iekzua8W03wJXglFwGs/Lq7Vnf0eg3I29POi8r66VUDKZT2hm
         VG2WbWvLztgl2a0RWTsHlVjPAZZuyPcC4BfKTmk47Xu6sSFXAcI7wcCOjDewzKgBHsGM
         cYiceOXTtGYMTLdvHhqw70DyLFiBL9qjmoWM2+djvvywAywM15E/6xyLBGhLCkcNPZ7d
         wReg==
X-Forwarded-Encrypted: i=1; AJvYcCVRLRjzpnefno4TiFYC7t3BdnbcVUOFGPXed+bTTxDJgrIyPDUKTLXJRmIxENrxHIKtxt1VVmdHa995ZWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjG9+a41om+CJ7GPQBeDdauQs9Vcon6raCSBisJZnU0lqZz/O9
	tpzYFRySz4/ldOBV9M9NjHhlk8euPkYCTG8UFvIJcbOUbJX5j35GUI5Q1z/QPyhqy9adCAhcna3
	8pTeM3j2ojbNdyQzqctZyhqBmKfR2OHL/hCYwPrIKZSTc5Eh13zoDMfDqH7tcWMpJEYc=
X-Gm-Gg: ASbGnctNx2+ohjEjSz1kWlPTSJxreIHd1Ie0Ubriv+6pFTWGnRaLlefNeGRRvUiGOVl
	D0wuqviT/G2/BDtRkFE9FDcwztwBZBo0YN2lhTs2HBq4ZJc6TTzNn6nWDHh3yne8kAxLk4rL9sn
	tqFcUvJaRy7pAbC5FhCK8MHlqZyDSH2NIn21iUBgcnRiViBB7//DwECmibSTqL/D+f4OeOdLh1j
	S9J8/9PPSReoRZbDByB1WnRRhO/WdyK6EwlInZoJm6FxcIl7SmLitlwxy/OddimNF1LVFXmBMDS
	VUMVxCnF6RpifNmsqgQAgyam7AmWRxTFo4R+xkXiwdiR4v5vdAqUqVKK3cLt9pDK1JnnLzQmHsP
	z5HLm/ocE8ITrblFIfvd58JirrmZpR82tnWx8GtcfRiCbS1dzhhUw5Und
X-Received: by 2002:a05:620a:2902:b0:827:d72a:7b45 with SMTP id af79cd13be357-8b29b84bfa4mr230424985a.12.1762944347623;
        Wed, 12 Nov 2025 02:45:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmUZ6M7Ck+27xqrfsG5hm0htonAsU8tstfxsb5T0QT+xpDF0ubgz8pOWj8QPScfpGkr3uNqw==
X-Received: by 2002:a05:620a:2902:b0:827:d72a:7b45 with SMTP id af79cd13be357-8b29b84bfa4mr230422985a.12.1762944347194;
        Wed, 12 Nov 2025 02:45:47 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f862cbesm15459349a12.31.2025.11.12.02.45.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 02:45:46 -0800 (PST)
Message-ID: <103ff788-54cf-4c26-9465-165f03ecae04@oss.qualcomm.com>
Date: Wed, 12 Nov 2025 11:45:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: arm: qcom: add Dragonboard 820c using
 APQ8096SG SoC
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251111-db820c-pro-v1-0-6eece16c5c23@oss.qualcomm.com>
 <20251111-db820c-pro-v1-1-6eece16c5c23@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251111-db820c-pro-v1-1-6eece16c5c23@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: rGoP1eMQTMQlKsjZE_FgBDp87HN7RvIq
X-Authority-Analysis: v=2.4 cv=eO4eTXp1 c=1 sm=1 tr=0 ts=6914655c cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=TCvPXp2ldiIvP41x-ckA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDA4NiBTYWx0ZWRfX1vYUsKtPsl1V
 qtgnmQM1LkIsmR8UIBqOcGTXZ2uuab8bAUbVNqDtJxyZbCAssUFvc95XaQaD3azzhCrFJUaCCTO
 EbyOYi8MHfaMYGD0BiZU0x/Xah/4EK01fhnwWDjkWiFpNavCyMxHc7+MlkCYwux7L2/8um3evHS
 w9fj3Lbp9UDWfZfuLHXeJY7N0PZWeVJSJk0gEzTmSPomhxKRnIOFsbQoryoQ2ua0RROgwF2xKKG
 TKmcCDaP50wp9pcoUR05cx+eOX2daOa7lPbyI9mvGF4jCOFQr1CaudTd0O1zdWB9FOCam/Acxvd
 PAvLPtvJHXdbdMmAYEpW+7kZY9fF8J2WDzU809LqllkcVth22MI6Xgx+cq2hvNAtHh2dgUY+b65
 DfkpmmvHMI2pUvrSMo14YM++jcglRA==
X-Proofpoint-ORIG-GUID: rGoP1eMQTMQlKsjZE_FgBDp87HN7RvIq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_03,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120086

On 11/11/25 5:02 PM, Dmitry Baryshkov wrote:
> There exists a variant of the DB820c board, using the APQ8096SG
> (MSM8996 Pro) SoC. Describe it in the bindings.

Apparently it's an IoT SKU:

https://www.qualcomm.com/processors/application-processors/products/apq8096sg

Konrad

