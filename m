Return-Path: <linux-kernel+bounces-744253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FE2B10A1F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 14:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43AA15A1DE0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 12:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25602D130A;
	Thu, 24 Jul 2025 12:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Mfr1dc8a"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E99823ABA6
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 12:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753359927; cv=none; b=Ls2wGgrZiyOkE//FMjpOH5nYQR5nDlYF1i0hm32I1/H9q2rGm4TbR8CS73n4v0MGPdAZSPfptkX6oRGOa3gE38OvvBpIojU6flYwns70TfrBiRgn6EMx1sVQVbG6l83JFF0k2IV7m4fTc7IDC2p6ukfEZhH4GOo6imNV03hYIsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753359927; c=relaxed/simple;
	bh=m7mnvsvZsHXBpWj7n28YYrnKFs2IYeSdflZGX9/AAqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gnaBuYdcNRQX0RbE/rQ0JPu30P8KfDZ/VoQy2IUqLtw+JE1j0CPXT4N5syw1qlpT2jfOUa53iZdZFTr10Bq9iBAvDOsXFID8J1hS+q5Yz/uugcC8tRAc5e5ohjaCpI+EoEtZqz9ZIrRv9xMrCEjpgogZ41q6HOhfUsT05UAI1Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Mfr1dc8a; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56O6dCRc025347
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 12:25:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	616i8C2JxPPICwxxSnMg22TWk26CQbgVBwMD64cTZdQ=; b=Mfr1dc8aR7HOqg8f
	g76ke8SbLoNMiTccOAkKmI5QJH+wm9+MTfcbcIMA038PYN4gtttN8znq57+zH6zH
	6YJaQt7kWWaVir5sYQyI01qovePtvFueTA+qMG6jXIFe/XC+jWIGGnMiute9g9kV
	qu/vDSQ/JH8urSJmuyUPuxQMrDbe3hjOjEVxm5bJZPqBSRXYteRnZZNwoX8lTxDE
	bbkPs6EUxgXcFZB+y/+0mT4w7ylRAGEy2tyzuSXE4T67g6md2g6fob6Ax85w8W3p
	R9fNytR0uGmGQnGvZFcygzuiIlSEnHCpDSa2XNwa+55N7omxpVE2QPiKTa2DU312
	AWqSFg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 483frk10k2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 12:25:24 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ab3bd0f8d5so2057471cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 05:25:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753359923; x=1753964723;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=616i8C2JxPPICwxxSnMg22TWk26CQbgVBwMD64cTZdQ=;
        b=wZQ/Q5Z8EeTPbaOOEln17YvDpKoHeqJeDVJIB6C9MG0HCJkgTPC6DdjU2+8bmOLDwO
         QftHK2LBDYJROtPo6mavkNLkvr6PJf4FRLN9jwvYPYGKR1S31U/vlw8tWBbb7sLnJ//v
         kFP6leIz4i4fI+GdIRxhBSVWE5WfC0u5mPOafIMI/1W0i0Tpo3+zrwF01/+C7h8SS7zP
         m8W7cIZ2xB2L37A0E1CEcOoWFboVZuFx0Ygs19ani+uTOpn5DkgiatbKNk7F44v03rof
         jmrvWl8ahK9o/8JhQ79buEPEC8zzavok9KqeNju2ha5m/lnODiGuNkdGRfw9M12NM0p1
         eeYw==
X-Forwarded-Encrypted: i=1; AJvYcCVRAR6tbsSwGmG7H9qIaOza1EEviP3MTMLi8J9MiUMe0FjLob1Qw/q9dCvxKCtqO0yVTJRSEjfsbSgONV4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+RRouQqkTCzKfzkVjClfvnYclGqRiQ1jY9XpwxgEeVqAOjZqE
	eXQdPTLZ2bTEwJwMycDKyijgmSq9bzrnLyWwDDCPxg5xEEhzX6w6ag5VsGVZNKRDyCQ14hQOTvw
	7lqJ3lqofFz4y1UgrqQMGuY0aD14kIVZkHxL9ejFODJXQhqhaeTo6WRTb6jC7uwnaDRY=
X-Gm-Gg: ASbGncs6u6xlSTqWBKnYooh/RSup+PNJYFbJ9SpBNloHmWT9DN1v0E4RJCV7HVH4Bk5
	XovQC9/Byc8WtWl7pntUPSjfy2rRg8my3tQzH6LyCUdhOeHVyEZ6jKBHJgnn+jpazsf4fQHtWx8
	t6Kup4EOQyyCTVlzyXPZmANS4vE8Wzyz1WJ8/VYGX60LVDQ9auphL54QYNXbjwBwDwVHGNKMZdq
	g+jA5vtxGtdFLjfAS0q88x17nq6iDS7U+QSflCNxKYZzSzS14LKLyNOABra3L7oo2yw/f6ptynH
	JqbUd1VK+8TrLo07oRruBph7OO5LkLzwcB+cK/hEBbKNz+BQV0LbQpq3gb9w+/ppuNV3wabD1D5
	mnnIFzkjFCXgDZHSCgg==
X-Received: by 2002:a05:622a:189f:b0:4ab:8107:6c0f with SMTP id d75a77b69052e-4ae6df46e42mr41888751cf.10.1753359923196;
        Thu, 24 Jul 2025 05:25:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvftYunv/MazVjRvCSyIsGgRpyDGuWrEWabff4oLUu1zX3oYTlb9qbheMaUUAmqLP6+s54Qg==
X-Received: by 2002:a05:622a:189f:b0:4ab:8107:6c0f with SMTP id d75a77b69052e-4ae6df46e42mr41888391cf.10.1753359922601;
        Thu, 24 Jul 2025 05:25:22 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af47c58b3c4sm106943666b.10.2025.07.24.05.25.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 05:25:22 -0700 (PDT)
Message-ID: <8a55bcae-46ec-4a2b-8e2f-041c3a358d9d@oss.qualcomm.com>
Date: Thu, 24 Jul 2025 14:25:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] arm64: dts: qcom: sc8180x: add empty mdss_edp_out
 endpoint
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250724-move-edp-endpoints-v1-0-6ca569812838@oss.qualcomm.com>
 <20250724-move-edp-endpoints-v1-1-6ca569812838@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250724-move-edp-endpoints-v1-1-6ca569812838@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDA5MyBTYWx0ZWRfX7oNu05HqCbNK
 W7X/bXIpA+S3sLJG6JUVinqTofzHOFur/Pk79+0chQ5HUn7XEcrPItZHspSZyU7Bn232LdrpfxB
 dOHx56PB9Xslrr+m0Rpdn4MRgkBz5AJ3IaCGVfh1HudPcPygXOHf46IKqCOnG5E4jxXWSUibCmS
 bXUXOJ9+yHdmt/wJY8mZyCx3Q0zWHJT906EtlnqJIG6h3M1Ic3Dt8s//6Y87cXJEMqpBU9HSxV9
 V6mxr1N+gWp0JuiUysT5CXffoWPIE9hlxxfceg/3b8+zNC4KED1y6WYWBPYsiNBhyfv6Itlu+dj
 /goldfQj3X7fBhbHwoV+kGRP+Xo+BIu1hsf4YuZBwQhNodcll1yFwuBMeVS2RFEwkt0bCAksI95
 alwG0qHwvztryVwAHHmyzsEHX0vBzzYvjE7bx/AcOuXsHhvN5Jj8WYbqeqawoVyZ4vNx/SPy
X-Proofpoint-GUID: n4L9GNK44SrRZv6GBnXWetjII0vZ8kJK
X-Authority-Analysis: v=2.4 cv=WbsMa1hX c=1 sm=1 tr=0 ts=68822634 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=B7dxrb8V9Gn_lHFWds8A:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: n4L9GNK44SrRZv6GBnXWetjII0vZ8kJK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 mlxlogscore=744 bulkscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507240093

On 7/24/25 2:23 PM, Dmitry Baryshkov wrote:
> Follow the example of other DP controllers and also eDP controller on
> SC7280 and move mdss_edp_out endpoint declaration to the SoC DTSI. This
> slightly reduces the boilerplate in the platform DT files and also
> reduces the difference between DP and eDP controllers.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

