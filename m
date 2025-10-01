Return-Path: <linux-kernel+bounces-838578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 909B4BAF9C4
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 10:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 166E14A2F35
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 08:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56002275AF5;
	Wed,  1 Oct 2025 08:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cPeC22l3"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436D025771
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 08:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759307205; cv=none; b=VS35nGifflTVGLn7nqlSoJeI+ejBy0IsAnu+j5JsfVhJCA79Vd/0BfTNdLGLfH0e0xHaaw464JWrogT9sfgmJ2UAacWENO70IqDzZCyWUKpmX33h3fwZO8Lf1IYNcjQCPZR2qHQZT/PL/16fatN/RcpO/sd01soXT4rPwQpXuq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759307205; c=relaxed/simple;
	bh=YO6u26nFzlPOkPOOXGthr8BF1ZfQylY9VojhkWegnB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P1WNJpRZClstmiiHi+YjOZEUH/OS+zOLWfre+XIKWb/9KAJ6QEQrw6PC6eEbkCN7v9w+qbIFhBMGLhLL2PdOtOpGGVuYzNWtPvqdtUgs5LN5Yqc0vEnbnP/GnRK0kAlpYo+wL4Lar+haQMHz9h6x/ZWozOVaLEIHzwlVsHCIgHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cPeC22l3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UMIJ5h022345
	for <linux-kernel@vger.kernel.org>; Wed, 1 Oct 2025 08:26:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mlCMGBeTBT6Wlu0Hvmm3aAKB1BK/Vj2tfJ0fRSaoa2U=; b=cPeC22l37gZgPeGa
	oPnbj1Yq4shDQsFs+3DjmuycIEK94gGCXqcYbBluNgA/dyKETdYShxoWUoxbpNSF
	3zO9XsXzrWaaqF0l/kn/7ppPuwOmT4r2OCHXPr/NyqIHhsReMbrAiaiY3ydKhv22
	/V4Wd99EEOBBf+bkXVyvVeIwBTa1PwXoSXFejBsLfjVvWwGDfnsK0rVAPxmB80lK
	SCaMhFzhuDKtL6PLr2D2DusSi91vTIVwQU581Tf2R39h5QdDqBg8EUjzA/szmxFa
	dG1yl7jxnGQNyfLFCAsldjaJ6FtVoEXV7px3yfdJYCaaDxyL33W4w0v/q7pWmVvo
	h41Vjg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e6x5v0qu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 08:26:43 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4dd3c89ad67so4718621cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 01:26:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759307202; x=1759912002;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mlCMGBeTBT6Wlu0Hvmm3aAKB1BK/Vj2tfJ0fRSaoa2U=;
        b=fnJmXhuLo0wGIqJ3vyd3LNktq74sTA+sJXe6v67p2PtJe3NIbtnLjrqS+HJ2DICnKL
         sPn190BGYRxwCEhwdsrWcm1WzORpIJHOOHyIEVkcJ5IviFR7rzOhJU4JfT6QUXc6Jkbm
         JAtrCQCHfQlm4gQIxBUNHvDgQd+WGDkmV+YNgxCWQaqbfka1e99mXp7UDcpgdtIf5cfh
         cN3bJ4LAZg8h237PGEOZPzHCSom3rTgt9sPjbNOAMHr1sP5SYdVvK+Ra6HPJ9SNqrmeE
         nmS3o/CVBnY634sn0e382jjxbaP/v9OMLF6aMupIBB+CqsfV2VgXk0nXhroZIEP0eoit
         2Xvg==
X-Forwarded-Encrypted: i=1; AJvYcCXVw+pkTO2Ecxh8LwxEi5kAQTGtV9smYaUHC6IGHk7M25FXLOqSEgRi/OhSsdCxc+chTdzo+HR9pJfI9VM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeOI5jKfrY6zlRImTkH1HXmmV2HQl1VDOsPqHv9jom6U84+T2O
	xH5f4a2kPmXVVvPlDio8+h0noyRoEkypGrIQQbkL1NtpBPtYl93eCzPACc1dk9CU47YdRrA/kdD
	+zlzhrWVH5gYx09VKLEGsQ1h+yvp/wzVhYiccN6eYYaRIqPo0An/CDnS7a/Gz0pZRe2s=
X-Gm-Gg: ASbGnctPqhdsolEQu4XlkDeAmR9dhHbeBKN3HIz/XuvkYLZLHLpToE8bG2FTysyuUFB
	tFQJxP1v8JhrFKI4Imbv43xpepSwEEUsoQsqXxN2z6ksCGp8UXCqWdVN2K4ujwslzysqZDKUK7r
	j6qDSyT2ZoFAosBD0YaMr8jRKDjUaIn49PBqOrN1HjUzh61GetN3dWCqbc1I6MxbqpFbY+W/mZh
	KGcLS97PCKBe/GlXam3HXolelzbnqrwyeqCUycGsX2jO7V9GNcrjDa1mjshw9RliTsLku6UzxMy
	hbxbno9Et0nrIIZhLFph0vI0sHoB1sHoxFD9Xb+VhyoV+8a67EMfrADgDpRLdsadfswNGlKpGVs
	SimucAeh1cM/JWQ3tVS5VNOFZ4xQ=
X-Received: by 2002:ac8:5842:0:b0:4b7:aa56:c0f8 with SMTP id d75a77b69052e-4e41c5460bemr23012071cf.4.1759307202155;
        Wed, 01 Oct 2025 01:26:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqJd90oNLdMpoZhb4jGAg5bwDcTi/Jv7Qcxlk9kT5t8J+o925AOCw315gte5BBxsiD/DLshA==
X-Received: by 2002:ac8:5842:0:b0:4b7:aa56:c0f8 with SMTP id d75a77b69052e-4e41c5460bemr23011991cf.4.1759307201702;
        Wed, 01 Oct 2025 01:26:41 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3df8c7aef1sm652456866b.11.2025.10.01.01.26.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 01:26:41 -0700 (PDT)
Message-ID: <687b4b99-287f-46f3-af07-76b49cf573c9@oss.qualcomm.com>
Date: Wed, 1 Oct 2025 10:26:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] arm64: dts: qcom: qcm6490-shift-otter: Remove thermal
 zone polling delays
To: Luca Weiss <luca.weiss@fairphone.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Casey Connolly <casey.connolly@linaro.org>,
        Alexander Martinz <amartinz@shiftphones.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250930-otter-further-bringup-v1-0-7fe66f653900@fairphone.com>
 <20250930-otter-further-bringup-v1-2-7fe66f653900@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250930-otter-further-bringup-v1-2-7fe66f653900@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: wMSyxfnqd07nPwccmNeiTTexk75YM9LX
X-Proofpoint-ORIG-GUID: wMSyxfnqd07nPwccmNeiTTexk75YM9LX
X-Authority-Analysis: v=2.4 cv=ZtPg6t7G c=1 sm=1 tr=0 ts=68dce5c3 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=7Ovdx5uLAAAA:8 a=Q9X1YL7jsAXwpJAzmCoA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=TQZWkJv5rNK5-PaLMsrg:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAxOCBTYWx0ZWRfXxcXj6wWwbsjf
 3z2mjq6cc8LafJQ9JJs05wGXK6UYFlQqjT6x5BdP8vmPRDYGKRxWtDSffrD+VhlFSLbSAs6rf45
 duW0tKRH4cs8ofzr1ZPro1oi6j2luC8peA68ZsCob9uUAUjb3+aK3DlXQ2FMJPA8svsFjNv27hF
 KjfnT0uaMobuwrE9rAP7Z3n93O212jl0VoPpqhQoyvMaaUQK0x/l123bN+4UVVE04UuZ4CO7cG7
 1PWOgTscTnL8+fKDVcCG9ZSot475bYCGvcVeZGrRkCJes88Fd0OP96uneJYbGdU6QjwhpN/7hn6
 6cY23vO2BgxcDf0c9roRUJrozr3vRs3sYz/NDHl+QuUN6mP+BpMV/VajfGg4DogH/BBX4Hg+4AI
 UeQy+4eQG4UR56nmjVb5L9/LDsUbiw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_02,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270018

On 9/30/25 4:32 PM, Luca Weiss wrote:
> From: Alexander Martinz <amartinz@shiftphones.com>
> 
> As with all other devices in commit 7747a49db7e5 ("arm64: dts: qcom:
> sc7280-*: Remove thermal zone polling delays"), apply the same change to
> this device.

Your passive delays are <0> too (which has been the default value if
absent for a while) - IIRC you don't need either if you just want
userland temperature reporting, but you may need/want it if you hook
up any cooling devices

Konrad

