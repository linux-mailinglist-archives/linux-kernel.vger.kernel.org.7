Return-Path: <linux-kernel+bounces-879761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B50FC23F70
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF37E5627F4
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 08:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A6F32AAD1;
	Fri, 31 Oct 2025 08:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="djn2CHHI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UfpmAuOw"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C70318135
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 08:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761901029; cv=none; b=N51H2iC9j2EgkTp+S8aF5rOorKnBaLpQGttPoMQhPsE7m/6XDq8H08Z8Q/UZFFX4sVz2LXhdb/vrL2iEjDxSbLT+plssTMz+bdDL1sedYZvCrjLOAPei4mzCOdZx4eu/5DNVkleIgvxLIpph1OcIB4RsdeZ0DDShcazuw6KzIhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761901029; c=relaxed/simple;
	bh=yQ1jDNw6nw/+w3jdr16Cul8rj5akl3On7MjQTMOOtI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f4byNTwN5/zYtA0jwYvaFBNouf/yirPd7W1CwAfIlSm8reMfuYmDAsMjCS38XHEOqsbtwUMtGHaVFIAsW5yscQggHHr+Dn2ISXQanQ2Qckg6Lnciys6SweHC9Imqy6xd1zVLn0tl6CqtOK5I0P3Vax5NzfkhLdCOnBrCY/y6cng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=djn2CHHI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UfpmAuOw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59V73UNm2058979
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 08:57:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6dBNJpoG7oA7MdXWziFc42uzkOgfkuUA/2lceCPcpVk=; b=djn2CHHIJKzpmj0Y
	LpiVxcrXYyyw/KJMCIqc88ykufILLr2MARmeI29XNVsoy7LlTdg8RydzTCmSNbgE
	/CMrooXFUx1SITNWAQyOrALUWt0N/2mWzznMZ9hFRsa79k+hfeJEuCJGBjgvFIeD
	9bRr4p8LbVfxe3V85zgVhD8Dy98NuM7oOK3vfw/po3o1zZri7bRx0eA/veWsuFJQ
	+4pzFwp5kdYik15r2IenYCl6bj2QZMvTLNRzF1akxHmBJ47Og8yb5eVhJRXo5Niy
	G+Z8TJfUwP5AcbRKrSV4qsBkWILUyuRIVPUtOT50Mpy1OrSu5zph4NuPeNE8/NBP
	Po42LQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4rcvg9ep-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 08:57:05 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4eb86039d9aso5981071cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 01:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761901025; x=1762505825; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6dBNJpoG7oA7MdXWziFc42uzkOgfkuUA/2lceCPcpVk=;
        b=UfpmAuOwkDhWO19I6diqeirkUqOPECYuRZGgNEkXF4TdIUbUMtMf4OhIOKz83Y2iXg
         e/yTkqRv+e9vc2ACo2CF5qLcOXYVQKdT0LSJH6mtgrs+IElVuhH1gagTa0zTZ4j4oMLv
         J7wM/OGJRnhTCLGmOItR4GJQPTZhdkUfmI/zElUAkZ1WnDSKpzD7LmoFr70vRjh5yK3J
         w7KI6g1xZdGL9uyE5wjhIi9L+N1eW62jxKJE04MEOrHalS6qHNOVzdnVtzcOEB3JNQAn
         gBPIDazQQeX13Tamte7uIzuhU4VzOLv7xpxSSGQV1whjFv8iujTtoT28goPkcguhdHl+
         NI1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761901025; x=1762505825;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6dBNJpoG7oA7MdXWziFc42uzkOgfkuUA/2lceCPcpVk=;
        b=LfKek9bTsict2qtZvdIvEqYZMr51DrgZ8qfR+b4uKT35p5ZpStNuS343xs7QDOGo/u
         Rj6g0eM32Ssq/bDCqxdvKKRBVHJmALrEz9MvyCdVYB01wiZBC1uz4mBGZ/5hSicQHTRH
         Soi00FXCFvbZu/m6VizLcFTDWhLAYjSfPTcIT/xMxgAHLdN85meT4KH8pSvfDVHyMmbx
         QXanL8go8Y46JV9ces7SSlys8JyPZSr2q90/oo2y/2nxhuz2TFcYhWNABVPopEH5TL07
         dqv/oDDZcH9ipop45qyn2RsiUhd0EO/sXjn9WrznWjfCLyA8KfQHUvHXktYpUOKkOMj5
         Qepw==
X-Forwarded-Encrypted: i=1; AJvYcCWMEOsvxVeLsvLDBHmAOUQ9K+NIc7FrvKLjBiZCKOP91McrSV1xV+2BrsLN3zwmBjNAlAY9aPcDTJAIqGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPk4A5NkWImgmO1rYj2p+GPFz5xPJZuqlBVhaEirivHriBjMBz
	U3ecoxCxa/mpyWY63IR6NCHtJVm7V3NskGyV3pm6ONt8xL/VWcuXpPHXkTlW66/IbkOuvnyTKK9
	dtaUHxknaNNYWdtUG6EFRg47Y//vZ8YVrF/L5jnZK5xpK1rcblzgapP8W3kwG2PyUoEg=
X-Gm-Gg: ASbGncscmcMkq58epU/sPZb9f6dh3c1pMc5SSVxdavmQPrpUjCmDQdLJvl7csgRsZII
	u4PebGdgq1TFUo+QQXxVCLodqFevTXAK9t8rB2IzVmxLimSkCCfDFhjgPNsFOvzQQdudfouL6T8
	Cn6Xd55XtWiriAK+ozdnQSv7s+jT8bt9PomyLuMIwZkprNA3ge2/byMFo9SKNrIp5brw6Q30JW1
	T3GlJFscybRaGaMqg/5kXeP3aN2MUlI6pGm5WRX0dj0s6FyzZYLScBM9z42EYCBP+AntZNK1kHu
	P0GJeReE7VUEerf/tldfBJtI0csvGNC9gbNeZ6VfJHVHQJ0RokOCaZLsjMbdHvwU0wG2L8Mrj1g
	FcyM/l0hYFiNX9WO/TZ2j2SnzYI3AE22MZGVlIrjdHmk9owA9c+2yo7Zd
X-Received: by 2002:a05:622a:2cb:b0:4ed:7ca:5f33 with SMTP id d75a77b69052e-4ed30db06fbmr20600421cf.5.1761901024844;
        Fri, 31 Oct 2025 01:57:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFh6P0sdOosomYGx+CFxn2zJIvjMK1mpVwzKuR4xrxOpWGgcH0e1YP/0Jw2xV2c/IQ2wtaAtA==
X-Received: by 2002:a05:622a:2cb:b0:4ed:7ca:5f33 with SMTP id d75a77b69052e-4ed30db06fbmr20600271cf.5.1761901024350;
        Fri, 31 Oct 2025 01:57:04 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7077975defsm121917366b.11.2025.10.31.01.57.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 01:57:03 -0700 (PDT)
Message-ID: <d9812a14-25be-425e-9b69-20eb998cc4c9@oss.qualcomm.com>
Date: Fri, 31 Oct 2025 09:57:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] arm64: dts: qcom: rename sc7280 to kodiak
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251030-rename-dts-2-v1-0-80c0b81c4d77@oss.qualcomm.com>
 <20251030-rename-dts-2-v1-2-80c0b81c4d77@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251030-rename-dts-2-v1-2-80c0b81c4d77@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=bJYb4f+Z c=1 sm=1 tr=0 ts=690479e1 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=SCbu04D-vPvkWQ6b-rwA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDA4MSBTYWx0ZWRfX2pNkuJyQOost
 wzjpa+zRKPNQSfgV6cwjK/iEvDBPmoXqGiRh2hTa2R5yJ9gKCaWcryMk4T0sR0h3wqKWfmJ7g4F
 uWW9gaQxLkBdPcw8OsmR4cxKegO7DY+7v6MkT7Uv83BDud6NDOfZ6uof6DFWp8IbGHi2p0tr5xY
 Lug4BnH0isHLJLB0PDMT3rit+JPrNrOZVCGuAPkA1K9AcdnJQ9pjjN4tZQitUkdsRU0+5sNiXAh
 jlaX7CfbcEy9bMpir94VPSltpRIl20AGlnYisOxl2jQEB5X1Lgmio3oG/WZr52t8fYsqBTpzGwX
 JVM9ffCHcb2Knbj8CBL0BQEGsOy3G8tBC0kEEzzUEFv3/sb8yTA4ok3ClczoD5wPMGoLkmx/8/Y
 6tFtRfK5LbSS7haeRu27jd3l1lwMzA==
X-Proofpoint-ORIG-GUID: cP2mJvtPRD0fBRABOpTMK8kEofJsvXzu
X-Proofpoint-GUID: cP2mJvtPRD0fBRABOpTMK8kEofJsvXzu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 malwarescore=0
 spamscore=0 suspectscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310081

On 10/30/25 7:20 PM, Dmitry Baryshkov wrote:
> SC7280, QCM6490 and QCS6490 are three names for the same die,
> collectively known as 'kodiak'. Follow the example of other platforms
> and rename SC7280 to kodiak.dtsi.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

