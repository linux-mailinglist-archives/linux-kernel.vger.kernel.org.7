Return-Path: <linux-kernel+bounces-850135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C06FBD1FDD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 10:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 519774EE3BE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 08:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26062F3C31;
	Mon, 13 Oct 2025 08:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V6L3jrBT"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857362F28FC
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760343551; cv=none; b=NBHl0ybRoTNcPU6gFpNOFRPLHKh7Wjv2OBx1/QfJmNMOcs0nGSgHaPB7+U5x4/wfl2KUbG6B7wH9QrdY33cOIo5gP2PYbonp2hJZ+sUCM8eICGHtS3R3c/cMBbWCx6p8KnTpIbpk0Rhy8nHDEbDj3vvCzljuf5q8nEOIq8nalUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760343551; c=relaxed/simple;
	bh=l71zOi8Iii2rT5j9IBt2SrlxYshazF9y0u6uvVNTzAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EZAAhUfAA6KhMhY+lLHPrfecCgaI1nP0ewU1lV1l3d5lqGOmqVeFAt54TRUeEKglc5UKbqM4CLvF45p3icw2xOtzHhvWUDu6hfyepOp3MR9GIhSazcrH1gbVz8Y+5t60w0ew+SfEdHBYOL6tnkCLe4SZ0ivIGLirABCezFpCTI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V6L3jrBT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59D2nEml011037
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:19:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CnjUTiX3FGPPzQybFpvUaFsk3SaXgmCmOsQbRYEOBOo=; b=V6L3jrBTbTvHHEKo
	qD5U4eFHTxnbpsqXc4cOpzkuMCTQ5epNY9DjJjkGLJL1qr6r0S4OFd5EdlW4yKCJ
	WAgbjSG5zqOQzCbAlZaLfx2fgKrZnyWU+pe1FW+xPMm7zYUVcOgdInhv2VqIb1YE
	/8spKAq0l2LlOD9R/8xSGLcz+mrsa40WnUDOPuUFFaQf3Ot9tdR7CKRQMlJm9mEn
	F1LJmDAFnsYKeaU2FFa4xBj5MdtSGdU9dDsVNnLbD8CdNcWqDqVuiSzP0gCs0uuZ
	bJhuaktE8ndnYcXHi0xu6Klfu6NXf7VeX39SjgEj+cfOzKXJfxzJcj7ggFw+6AUZ
	TM5Rlg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qg0bur2g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:19:08 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-85d43cd080eso248752185a.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 01:19:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760343547; x=1760948347;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CnjUTiX3FGPPzQybFpvUaFsk3SaXgmCmOsQbRYEOBOo=;
        b=OVNmiqD3YRcIuXToGj3vZlOV1an36CYvkmfcOPxSvs7K20gIjInHtx2rb8IN79daRZ
         e3k6KIhSlOc6S3SW+AIwQ8+m9RGO6gOy64zlAC0x51yppyBOYo2waSllnxDVkQQ9pV7y
         uuZUjW2CFT0L1wCLzGWI2p9X86kRuNYqrKD4jzTdPbSm0ocGiwHyc7Ue/XecLKAgzBHl
         scmlvyirzi0ke3Wb2K8Ujpss0Sops5AH5V8utWC0J/zLnIXL5IXBph2aTwZN1V4+KRYY
         0X2ZNjN93EI+DqPtI39ziL8hQZGpg52swJAI6uAJxT22etvh3X0WrD/e0ugDFLzPYEPY
         9u2A==
X-Forwarded-Encrypted: i=1; AJvYcCUGRdimBM2exhsvWI/9tGl5Hhq3+Os2mo62aul02q2dWy4zZM1oIvfOlQ1TuvoElNy9Fm0AvLRNb7xur3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTYPKRoQNgHQixW9BCza4mNkquV4njg4fIyHOBMHU8g3Dsl238
	TiQFXluv+YIYvXLN6mlOVJlBVV+hDmYduVLcdxkNGlsKFwVIiXAMWr6Iuh9a72fTbZSjYguBUX8
	H3JwLmpgd0oHbo8i8bN3MnZrjsur5/f/ylQKoPrqiokSnIDg4WzDHEv22xCq6KhO4I+s=
X-Gm-Gg: ASbGncsxQRqiU7AYjhb4fZjgDTePYjkRiG22Z1fxFQU8RqOSZ2u4XEHbgZDb9n1gdmY
	EbY2ZIYGV5mxLN0syOuKighZRSPw7FkdQ/wTcsi9E6unurRUmA6B1roqMDJo750xvSNOK/hzSaz
	+78oZVc5m80YPiWwodnphhYRbmrfdYIWFjLsEPv15Lu5W83iglQaN8f6Ikj2pZdexqmHA4uFqVf
	69IjN8lc0oZ7b4bGrgRCYub/vOqMAngZWFR8HqFQkXnJrrTO754PgnZJsJAeKwUX05ENMihrV6z
	b19kP9/ptPMapbbNfVi/hTpGYwLDylinYjE1UaPgmW5bwYGX9FQj7G6FclkT+63EB1d0Wxp+EKN
	gdMh/i0csxAcN1q2Zix6eQQ==
X-Received: by 2002:a05:620a:711c:b0:85f:a278:78bf with SMTP id af79cd13be357-8834ff909f1mr2008313585a.3.1760343547283;
        Mon, 13 Oct 2025 01:19:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4znKrO6qzvVeWk9uZKKfQVBsm8qhDDyjnyj9kOQFewTkZRDPaivS5qv0Ack9eGJHz4piu7Q==
X-Received: by 2002:a05:620a:711c:b0:85f:a278:78bf with SMTP id af79cd13be357-8834ff909f1mr2008311885a.3.1760343546780;
        Mon, 13 Oct 2025 01:19:06 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d67d5c2bsm873147966b.37.2025.10.13.01.19.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 01:19:06 -0700 (PDT)
Message-ID: <01122bf2-7f8c-4d93-9557-c625b4eac631@oss.qualcomm.com>
Date: Mon, 13 Oct 2025 10:19:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/9] arm64: dts: qcom: ipq5424: Add QPIC SPI NAND
 controller support
To: Md Sadre Alam <quic_mdalam@quicinc.com>, broonie@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org, vkoul@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
Cc: quic_varada@quicinc.com
References: <20251008090413.458791-1-quic_mdalam@quicinc.com>
 <20251008090413.458791-5-quic_mdalam@quicinc.com>
 <c7848ee9-dc00-48c1-a9b9-a0650238e3a1@oss.qualcomm.com>
 <911ee444-25a9-a645-d14f-72fc239e5eb7@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <911ee444-25a9-a645-d14f-72fc239e5eb7@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: MfCD-aQBRLebntwqdFgOZmXtHC7hb3SY
X-Proofpoint-ORIG-GUID: MfCD-aQBRLebntwqdFgOZmXtHC7hb3SY
X-Authority-Analysis: v=2.4 cv=eaIwvrEH c=1 sm=1 tr=0 ts=68ecb5fc cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=COk6AnOGAAAA:8 a=OlpJZY4RW8OWQeam8GsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyMiBTYWx0ZWRfX3XYLA/f0aera
 lM4bUXy6ENxFDr1r5Q0Zl9JUIWwwCOIcfSBoFdB1JB2WoWMZEOi2s2984Roj9PSIv1Nli7k9vxR
 yB6bWRcpQVym9RN5lkaudB/eH6fHtLPEC3T1cvkwDPDE0xjyXoacC/BVvlxVhV/RXRn8QE8qi5n
 rmcVGHMOA+1hjyb5+dNuMaqlXcjGhTgObDbtkJxZQiufxy6kTZ+TeWvSYGF246kr8vrKTx4+hOa
 cfz9/k/jrejq7HdW/1KWwsIi+YH80YyftveOOCSQrY+fMtCIWRdYb3TPz9muh6wlLQM6qtbJwdW
 rQUpnsH/lXd6QUEixxysK9vR09d/YM+iofCiM0eWWypVmP2mE6JeMNPoKs9dgeLCKpqjOi8q6Jl
 9pDBCxskaEFwhRnHcGrUzan7cXKw/A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 spamscore=0 impostorscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110022

On 10/13/25 8:10 AM, Md Sadre Alam wrote:
> 
> 
> On 10/8/2025 6:00 PM, Konrad Dybcio wrote:
>> On 10/8/25 11:04 AM, Md Sadre Alam wrote:
>>> Add device tree nodes for QPIC SPI NAND flash controller support
>>> on IPQ5424 SoC.
>>>
>>> The IPQ5424 SoC includes a QPIC controller that supports SPI NAND flash
>>> devices with hardware ECC capabilities and DMA support through BAM
>>> (Bus Access Manager).
>>>
>>> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
>>> ---

[...]

>>
>>> +            dmas = <&qpic_bam 0>,
>>> +                   <&qpic_bam 1>,
>>> +                   <&qpic_bam 2>;
>>> +            dma-names = "tx", "rx", "cmd";
>>> +            status = "disabled";
>>
>> Is there anything preventing us from enabling both these nodes by
>> default on all boards (maybe secure configuration or required
>> regulators)?
> We can't enable NAND by default in the common DTSI because the GPIOs are shared between eMMC and NAND.The decision to enable NAND must be made at the board-specific level, depending on the flash type used on that
> particular board or RDP.Enabling it globally could lead to conflicts on platforms where eMMC is present.

Right, thanks

Konrad

