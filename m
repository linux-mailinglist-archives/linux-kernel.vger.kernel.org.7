Return-Path: <linux-kernel+bounces-806290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F350B4949E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 18:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 150A534030C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B12307AFC;
	Mon,  8 Sep 2025 16:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IQXWo01P"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68D530DED4
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 16:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757347266; cv=none; b=GnNuBT38HfAw7QuptjhpqZWbSjaBGSk3sZ2neQsuUnXXASgoCCm9Mvg5eFjHWBMkQ/Yfj79LJJFKR277Q3oi/GuTnzykxUf8KU8ijBOBwHscWGtJzovhpJokWq31NW/wvj7cc+ZND2cX0zxcem9AFUVP5+IPlajy5zfSZPbQsCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757347266; c=relaxed/simple;
	bh=7WVxX0wapGqwPj8BtXO/4XTyuaHzlAYZDJiR1LsZre0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nc8c+Qmg1wDFjordfbvAG4LpzFzv+7CJKXN+Jm6K2DJNsuJKtqu/y1yGU24VEujn7SHdU04/mmnt8Pl+rQ86gLxMrNAFflW0yNCfiTLl9Sh6EghRwMcLYygbtEypgpDWjE89C0iT+B9fAcjsO9t0Ru+z5i190AeTpIxTJUhCTpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IQXWo01P; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588999cD000749
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 16:01:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UuxH857PCUf2XzeLyUN8XPnPOKSOMUPFIWEWl7nTGFo=; b=IQXWo01POvXIjhQi
	j/7+6qsSGEg2G/Lqa64EyXCcesrKtOh3zbWeW++8VxDTs+hBTAuJriLpHrWIL27/
	NEhRAtQEx2e2PzyzYbAWZDxMKtsr6xHWzlNhOlwVuHQnJo7RvSUaegg1kCT/H8Tp
	+vJZlVHB/neB7Yf3YgMdR3bwDiVlJhDbusu6/mdVNB4c0eK6NfQfvbcqt5SigOMP
	3x1wiawydijZXVeFajEN2FKpeD68ZMV2C2TkkuouQyYvbccW5Ios2Ai5Gfy4YNp8
	g3SVFeEVAIB7Eng9eoHeqRckEVNO+Kf9iJH819TazVMNX2HND+qm1T09wAVWnS3/
	EelQfA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490c9j58qn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 16:01:02 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b5f92a6936so10092771cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 09:01:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757347253; x=1757952053;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UuxH857PCUf2XzeLyUN8XPnPOKSOMUPFIWEWl7nTGFo=;
        b=ghdWPLCLsECbZMQnBh3EFQaROlFWmP5Eu2eP2PGBu4kcBk9jIAWe7rcoak0dLhTp93
         D+boQZc/OLZv+KlhsOVSaMJE11bcis0vvzEFq/A8Ix1tXGzKqCKLauIXtagHKYLRQsX1
         xzilTIIsZMGOzPTe/tEWPsk+scVmLP1tnP/133k9fP6kVz664MGe2mVBjz9/XTa/PSpz
         /8R/Zkvv3hCtstsMtETx7tEdjmzF+NY8/CD3vsOJFskkyhkzzEjgztdfsPTcIwNBKgcu
         3agZbKRA5Kp98S5QsHsV+Vz7gRO092vqt2gyG/cv35lodLTZR5M0vZx8HQ9TTk7VaNGb
         Sc9g==
X-Forwarded-Encrypted: i=1; AJvYcCUTnTD5Bn18MHOMNMjKxGhyDFHv8QomMDSA/CfIIj6BeuNEPM8EZjJs3ZXtoRMgsnCA9YRMWDAd5c3JZxA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3y7uXYDr3Oq/9tX/cVWCX3DVPpTC1Q9mfwJk+brHAI0TkTc5A
	8X+7XjFfQuVSBp7Rl1vnLy+bxMWqTELS6Xqn44Mh9jAb3B6srcCo69pyzLCUk0iJSWiOvXW2IGw
	L2fj6JFF3njpH2xr3fy0Yk3PlcZ25KA+zXy8gpUm1onwLuqH+GVrPWAd2AyZVWCLdDoI=
X-Gm-Gg: ASbGncvQoTjh9SdS/tz82OUwVDw2SRGwOGNvikxWrhEucZkLKuZjHTI+QOO5MRld6km
	S6kIH7Ue7+pZf+T1V/TEPdky61BYMJVR2K4x4SSMZA6jfWRUx1vVF4um5Nq4XWKxv8WAGXcnhsU
	E3GtcD8Zuss/Qjfq8pk8fSeN7ey4Fopm4LDvapnNkjPYitqt0SDa7q3JGMDMFIdfLsFXMjTIIdJ
	QYb2Y1F+gFJHGCLSREzHvsUx2fhG2Ks+Nh9pR6WdOP/9muodMth7JlKu7tgWpYRwoc3hNQoVZ1l
	wr3aDbKuOS8r3YLf27iTXjbPICYt/qp2Y12OwcSx7HmlAoqM4zHFE9NEkNDtmDVYLLLWenXVOkK
	M0oWua/+VtRFR5YRqT0iCBQ==
X-Received: by 2002:ac8:578d:0:b0:4ab:63f8:ef30 with SMTP id d75a77b69052e-4b5f8376f33mr68087541cf.3.1757347252395;
        Mon, 08 Sep 2025 09:00:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8zMue7mVLsV476ogTf1WxQvSyUzv/MogiVSN5i83GQvuAFdA+F/TY1A449LD64lrkaf3+Yw==
X-Received: by 2002:ac8:578d:0:b0:4ab:63f8:ef30 with SMTP id d75a77b69052e-4b5f8376f33mr68085911cf.3.1757347250485;
        Mon, 08 Sep 2025 09:00:50 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61edb0fdf1dsm12548489a12.18.2025.09.08.09.00.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 09:00:49 -0700 (PDT)
Message-ID: <14a35ea6-0a93-4759-83f3-dcd7b6b35584@oss.qualcomm.com>
Date: Mon, 8 Sep 2025 18:00:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] arm64: dts: qcom: add initial support for Samsung
 Galaxy S20
To: =?UTF-8?Q?Eric_Gon=C3=A7alves?= <ghatto404@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250905190931.27481-1-ghatto404@gmail.com>
 <20250905190931.27481-4-ghatto404@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250905190931.27481-4-ghatto404@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyMiBTYWx0ZWRfXzr3lNCTw8/T/
 pd11xml4svBAyHAlQxIp1i5BjPaZXz5DV9/hC0nXV/nTOXFd/Bb/m1QZVGwyl8AENo8kC3oxhxW
 VzoyVtcQDIOHvXRqE70W/Bu+y41UilO/GW0NoJYzC8QI+kaSX4nMxkd29W0Ym7bvbbw5rg8D2q1
 VszYRPmfW1uYfnWam3TjTVmXOTlCqB+v5AsbiHbEZA8kcIoxUqx2vcCEU7pUdMNSHcpNVifp0KL
 SueTnpA3poCyKWt1lmRDjFlXu1lRHNs+EuHfHVKvu73+u0nD56p5tQdhrmwTdgcp6PG6SmI83HM
 m4r8OceiiNx9ZGwtFtwePw5U/pdnxc6yl8OiM2GtnefMoxbGM7VqVHnIt0/jKKtLZSeZ6dnwugR
 nSIzOdUp
X-Proofpoint-ORIG-GUID: 01Tepkl6ykRjTP8T3zkJ6IFJv5lhq2Jt
X-Authority-Analysis: v=2.4 cv=PpOTbxM3 c=1 sm=1 tr=0 ts=68befdbe cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=O1J3YDS7JPEwnonmoL0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: 01Tepkl6ykRjTP8T3zkJ6IFJv5lhq2Jt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060022

On 9/5/25 9:09 PM, Eric Gonçalves wrote:
> Add new device support for the Samsung Galaxy S20 phone
> 
> What works (common dtsi):
> - SimpleFB
> - Pstore/ramoops
> - GPIO keys
> - UFS
> - USB
> 
> Signed-off-by: Eric Gonçalves <ghatto404@gmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

