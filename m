Return-Path: <linux-kernel+bounces-871156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E7FC0C88A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AA4BA4F3B3D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA282F7ADE;
	Mon, 27 Oct 2025 08:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TcNoAXd8"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EAE2F83C9
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761555303; cv=none; b=bw7D9BLqphRgmmyvTjmQ0an7CiVW2FAsH17NuC9BddBq50umcJFkSCg3zD0GxQhx82oEU7orH/tsQnsKwqLqHSsDRwCzqfBAnhk2BPjPc5zK2dBM9AMUBYDmjpXtgK2/ROIk1RT18wvlsFg+JgzkrctpxxnIgvfhK6cEhDuOGVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761555303; c=relaxed/simple;
	bh=Pj2lXVMae3CZfgIfkYrPMpSLLllIWvsBpvG3NCusRVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kyvJzN1lTjzaZ4WaYji+moJVEDhCDV7Le2z6ouEJv2PnBO4d0iA86y0uXxYvrzGH7O22iqnLXFvdgr4qZY0aMph+M6nauxQqfRuAknYZOKAijY5UU8PT/PJViHcj3x4QLYiuwrdkchHbQ/MXXY6mpT0Rd6kpddgqb8YspbDop9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TcNoAXd8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59R8MYCu783388
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:55:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	x4U2PWY8cr/FMK0vqdnKMcpIi/sGzwjcU4PI70B7rUg=; b=TcNoAXd81f6HQu+z
	0mbjVanHskwYF7PxYj17zlh46MuRhGKvFLUHC0JZQUDEQpBWCu9AnOY+Wi3uNoqP
	GSDxzEGSEcYLShH9embAkR3kGJU3gtVQIiMACbo9KroVyMWE4aFIcnx8b9DXEjFl
	PyE1GhKNPPznZlno2q8MPXkBJ8yYuzNXckOGt05zEMtnhn3Qq7xqh7Bp96T2SKMr
	HwvHroaPw4wz0ntTmGxNoTp3R//aWWIDvEv8tK8tyQ5dIT8l72eXytsrv4JmNbjT
	PbpgjuFKQmpztXhctc//rGu7/j+hBtgF2tlOFtzUjNua/Sf0vWUx259nMxT5vsQW
	RL332g==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a0p4g3wtm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:55:00 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-87c2d14fc1bso8987406d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 01:55:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761555300; x=1762160100;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x4U2PWY8cr/FMK0vqdnKMcpIi/sGzwjcU4PI70B7rUg=;
        b=ngxTnCpU+rUjQXFy22Qji7HexzqQ7lg+lsrxo/LtK9XU6uR/x5lHoK8OmbCmigOCnk
         N7BFjCerOzLiE9d7iGKNRW3NEjwRLKYjfo3BIgv+aRAfocUSxlsajgoFODcA5lXn36WA
         6mMWWdLxEezYYYk9VL0bq9UzLtQUzkSYhOOpZw7yB0XroV/iJGkxE3hosZOCZAZeuXsd
         VgOikaDK+I9ieE/MZcTy2EECV2GIJD5HP+SrPjWZ9JqO8nxTaFoaqonofJ8iwL7ydK+H
         DdN7MS8YGVcdCdsjVn0Jy9zbnTlgZxtCWC2f0qoJARzLuvi4grmjRPRGwXOFXnQy+Ej6
         8XXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVo8Egznf/1CwpW1P/oFUSF7hXNDAxslHzBpjvufgDSdTgLCVZnk76FMNrtDAgpfTEiFuT82BXVOrL5EWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJbItJ+ziL7KGHafoodtM23c0P/0Wh4QYZILjxNgf+F0sbx0fG
	dTTln1IX1Srik9xXNNAOSFYzpaq4eh1tM/p0mULAROHtWaEnD//hR8k4x0XVf2FjobARNyRSMSq
	bRDfok4otPOjdpd1ex6YArml3x4k5QOfE9o8zLxKsaVizO/IkfcLBWtwufTrSyQURrYo=
X-Gm-Gg: ASbGncvA0gO30orPHMFBU8+K826c81XEE5dui56JiYnW0OZzVcIo7w4rGRZFiMMBZXJ
	7Q4w135VBPrp3vduTe7ILvpKVjvtWuXHJe+5eZph8VmE3FdLV34k/fT4DgiakZ71ERp9I4SEGlb
	Nj8riVnjjlBXCN3kWkLlefXCQsHflAhcGqzf8Qj3M6OL+ROy3ywMm8fb20f/aNKQ+lXM66GVzu1
	ERepxmwqGXfzLN21V/5mI1AgbZxa6dXPcLebWKqAIV7Od62UQHyfy8HjbTSvSMiHD6t3VnIiOMI
	adjECiq2SI8uYYVhoPqyC9reX1O7erJ6409xyUwuDmjNFvtME6o2Befmj/uxKMrxsd7/D4bhRhM
	YsQiomTZEK439nutPdINeCHHCqPssFK9HtC/2sdSg+lBot/+izlzhDW88
X-Received: by 2002:a05:6214:d04:b0:87b:f3de:4959 with SMTP id 6a1803df08f44-87de6fca992mr179760856d6.0.1761555300177;
        Mon, 27 Oct 2025 01:55:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjXyLo7t7IGIUz9QcQc7pLfxebqJLF3z17+lxxzdsBZme+VkOVEPiJh584W8J7OE4nTGI7Cw==
X-Received: by 2002:a05:6214:d04:b0:87b:f3de:4959 with SMTP id 6a1803df08f44-87de6fca992mr179760726d6.0.1761555299748;
        Mon, 27 Oct 2025 01:54:59 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d85413b88sm686752666b.55.2025.10.27.01.54.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 01:54:59 -0700 (PDT)
Message-ID: <053e3b32-12e9-45ed-b1d9-576de89ba10f@oss.qualcomm.com>
Date: Mon, 27 Oct 2025 09:54:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: lemans: Add missing quirk for HS
 only USB controller
To: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Abel Vesa <abel.vesa@linaro.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
        Shazad Hussain <quic_shazhuss@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251024105019.2220832-1-krishna.kurapati@oss.qualcomm.com>
 <20251024105019.2220832-3-krishna.kurapati@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251024105019.2220832-3-krishna.kurapati@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: M5vFOqejogyROAhP1Y5gGzMAO49SHbOR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDA4MiBTYWx0ZWRfX0J+1UHbbWKXo
 UjOlIv/21IWzfSTN81y9XtJ8fmid5SDqO7IgnCuZcgpxVjfiaUHzNhUi77d+O0App7DeDT/lGXW
 eT6SsR1WR03E6CPrr0OunMhMir/5LoMVNXgWFUgPXZmc/VPtJfDitPwM0AilJBb0DZivR+9cwgN
 SkUKHNRCXkpCHTXN7qAZaBqyNoGeXfdynCd9R7hUqJkvrSJxW+T1yvkfryT77cGY/nH1+jh3rnF
 SPutkmFDe8hE9MkOhBhp2QIuxRwgPXUnfuiGv/a/nWrmUWuj5JKEtl8N6dB1CHx8mYn6E5y1+TN
 xS+i7F7zxqI+5G16EROQeZkywhTZQqg5CDJKGK4PpC1/+kL1+ePfMMu8HWwQaMyEI0qWyWV7EZS
 fPumyVlXbPNif3/V8raf/Cb2m9JudA==
X-Authority-Analysis: v=2.4 cv=L9YQguT8 c=1 sm=1 tr=0 ts=68ff3364 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=XwfBWbWjICH4QB9PVrQA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: M5vFOqejogyROAhP1Y5gGzMAO49SHbOR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 spamscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510270082

On 10/24/25 12:50 PM, Krishna Kurapati wrote:
> The PIPE clock is provided by the USB3 PHY, which is predictably not
> connected to the HS-only controller. Add "qcom,select-utmi-as-pipe-clk"
> quirk to  HS only USB controller to disable pipe clock requirement.
> 
> Fixes: de1001525c1a ("arm64: dts: qcom: sa8775p: add USB nodes")
> Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

