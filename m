Return-Path: <linux-kernel+bounces-832292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E630B9ED55
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D8F27AC942
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A652E2F5468;
	Thu, 25 Sep 2025 10:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a8mKxqVW"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E4014658D
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758797776; cv=none; b=nw9vzWpSG85bPcPaeYlEznoxkVqDPv1SObaxHS7ay8XbOlet4DaZK7OM/69L6WEon8zXRgXWwu+JVQuod1pMCKahuXRO3izgh67c5xzQ6cqs+vr1+GjUqMcszSGGjNcgOmUJaarR8sPi2G1elb8LlJJwMnHnpXRJ3cSv7wwrR+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758797776; c=relaxed/simple;
	bh=I2bl8BGD/H/CX+NvF9/Yg+OntFs4E15hjJBJxZW8mtE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R1DbworZACi5sw6OK5/uAfbSjbNTfowWYyZ7pvYc/4STU+BBvuLR6W/vr8owDH6ePix5Qs7CS80ZA6rrY+9hCmYpY1P3lhiraxuEo0CzQApzefTxb/HLMmo45imUpj16M8Pd8QMNLXIrB+Qqs7WbF3uhT0e5mUWaVpcmFy8w0ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a8mKxqVW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P4auk1028515
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:56:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tV0QaNscBMzvzZmNYQ2PtLUDDoPXdVBFyYeeoWv3d0A=; b=a8mKxqVWMpDLu3q2
	vy5yUqi/JfO3yBPyfBohcGa6/lQkuIWAM7rjZBM7NZMBbPIeTNU6G6a20r4X+ncw
	G4oV4fqFN/M8oejme2JyMJgB4ktNE7qRs0LLMkqn54i1TRLzZQRpKGwimTcyZhwy
	pHdbmG8FTe1lH3nMBsGyki2v6DWr/3XYOge8nmc8L7mTvN6Ybh/xF6hDLTILgjll
	2ealkRGYTCBXPkbPpHu0SakR2I+lwSbNwZpH4wy8zaxbSCKf0xL3dSFJhWOhUNb8
	eL/r3DQAiypDKK8mzoPAXOCAklM7IQ0pvouGQEuxBYfvMy2VHyh9OSZ5YAVuyWOY
	z3tBRg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49cxup11db-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:56:13 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-78df9ea0c9fso1768966d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 03:56:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758797772; x=1759402572;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tV0QaNscBMzvzZmNYQ2PtLUDDoPXdVBFyYeeoWv3d0A=;
        b=ofwWm68HLPFvXQnyZnGmoSZWHPL3xOJXHte3w616KbZPzrym0xhXa81M8Q8fSnVZK8
         J+RPMN68FAFbGp3xM4GNs1Y5mQkhc0kYwuIMp5D9dCcc5DJtMxvkuM8D+o4Q58yVzg7f
         1YEjX1c2ugHI/PAi86v/9UV+9ELJGhkLzRjgjf0XeUx67ZFvnK/138Ji2ReHvG/MmZmM
         Mb2Wn5DaeJj1h2XUjMwLcyu7ouHoGi1VcaWDjgf6R1lJmlC3apbx3g+rZIX7TfPvw97d
         /wSYowrU7TKS8ECT4oW9G+vN0whd7NUuO2nr2ZvsxTHLoy755fDMFebLMRjBaxPh4LxT
         q/PQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2iSneJc9FDrrurljrD7Unm5rc9Tp54LcEal7dY96t6n4QnREpo+Z0ZunV5BO/JzXGK6n+GpBepDy5rfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFrdJX2BuvpNfkEDFSNOqo/WHCKMR4xu4KGErw87cgn2rLvyT8
	qJ6h7hvRmTPnG/8vYkV5UtmsG8dYymkfz7pHYHurvG5ApxXgsCmNnU0mkeEEdVqQ08n00JyQcjH
	76H2+r5btPLmGLfVEyBKJG0Gbw/1ZOzPfWj1xhD5AJoV0gsEasiX3Ey/hDTJXidu8SfE=
X-Gm-Gg: ASbGncuz+SymTYPojGztLpc12CMiyO8+q/IV9Q6h9f3djILeR9K9Z9Hm5ZDG/sq9mto
	ykDl2/Hrdr7RNBfh9ibO2nJ8607W1RalBCLSxbCp8k7vZI4+fAFajSV4OGsr8OvNCPVlrDLPhT1
	TLqlJA891vE1MVx6m8lqUzuNseWJ3gsmyS+NcEStlSK0K1z3lQwMzRwfLy8YU6gCZCHy2jGdulj
	Io/dysJOF1ZrT8J8cb9Yf/O6VWEQ8XxNvtS8zVpV5R9/JMSDPD2w04yaLhltohxjoN6d3FV+tyh
	vObHmhS5qwMaBnaiyOHgCzL7M9JKG8ExSOS0AqH9zKMgXvrHJ0jmyQmJ/2TC8z5B7XsLqWVnOvM
	4XiRlwuWK0gq5ffWOYg4YoA==
X-Received: by 2002:ac8:5d56:0:b0:4b5:f521:30f7 with SMTP id d75a77b69052e-4da482d67b4mr26782971cf.4.1758797772407;
        Thu, 25 Sep 2025 03:56:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqXUcPax237mPbdSTq35nVlSJQ6+FGxXdGzGfHOshUkR2/9tb/83bzcLQibplmsMiS5BCMxQ==
X-Received: by 2002:ac8:5d56:0:b0:4b5:f521:30f7 with SMTP id d75a77b69052e-4da482d67b4mr26782691cf.4.1758797771814;
        Thu, 25 Sep 2025 03:56:11 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b353e5d2eb6sm142800866b.13.2025.09.25.03.56.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 03:56:11 -0700 (PDT)
Message-ID: <1c8ae43d-ceba-499d-abe9-8014dab5087d@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 12:56:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/20] arm64: dts: qcom: kaanapali: Add support for PCIe0
 on Kaanapali
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com, Qiang Yu <qiang.yu@oss.qualcomm.com>
References: <20250924-knp-dts-v1-0-3fdbc4b9e1b1@oss.qualcomm.com>
 <20250924-knp-dts-v1-4-3fdbc4b9e1b1@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250924-knp-dts-v1-4-3fdbc4b9e1b1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=B4a50PtM c=1 sm=1 tr=0 ts=68d51fcd cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=h3lg3G5xWeWm8zZk3TwA:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDA0MiBTYWx0ZWRfXzHPnJQ5NrZTf
 koejRg3mqvCiPjTDGVCBzpl7kUi4UWgZRp5yTWgJYM0B59yiDy3J8IsiV8qlWwVHZjDXAHS0m3a
 umO0z2beVqG3tSjXrI9f5YAHbwxiWi+UtmDOhmexmXSKKlvXskmWEOpBVzNtLWb2AD1Hylqqwge
 4eT4HVYZ8QreHnubtSwYzOshEdrmapDnk4mNfvDRlDFTtOPfp7/rp0c6uDHgER8ZkMvl0uZQ9Kc
 FzatXGLeGJpveoZ5hb2rZEsoeAQ61p3rDdWPcRTcT6LNeqXnw3/EfiQOQRAGveF1IVzua+5Dq6W
 4oRPpzQte5AVklc9FwBRCJRHpGm8XKomVw3F2o6V0/bqqZbF2qhjaTUoRqia6584YhMvE3iqHVY
 DoslRSbB
X-Proofpoint-GUID: -HHl2f6xZuYyaXJpkyM-gMLfYl2iGNU2
X-Proofpoint-ORIG-GUID: -HHl2f6xZuYyaXJpkyM-gMLfYl2iGNU2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509250042

On 9/25/25 2:17 AM, Jingyi Wang wrote:
> From: Qiang Yu <qiang.yu@oss.qualcomm.com>
> 
> Describe PCIe0 controller and PHY. Also add required system resources like
> regulators, clocks, interrupts and registers configuration for PCIe0.
> 
> Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> ---

[...]

> +
> +			pcieport0: pcie@0 {

"pcie0_port0:"

> +				device_type = "pci";
> +				reg = <0x0 0x0 0x0 0x0 0x0>;
> +				bus-range = <0x01 0xff>;
> +
> +				#address-cells = <3>;
> +				#size-cells = <2>;
> +				ranges;
> +				phys = <&pcie0_phy>;

how about:

device_type = "pci";
reg = <0x0 0x0 0x0 0x0 0x0>;
bus-range = <0x01 0xff>;

phys = <&pcie0_phy>;

#address-cells = <3>;
#size-cells = <2>;
ranges;

with that:

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

