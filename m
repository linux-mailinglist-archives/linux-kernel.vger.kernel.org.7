Return-Path: <linux-kernel+bounces-846895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DEB4BC95C9
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 15:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 492F23B54B0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 13:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C572E8B9B;
	Thu,  9 Oct 2025 13:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FBvLT4AJ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B6E3D76
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 13:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760017666; cv=none; b=pYKPfzUsoH0BSrAtNPYLiCFuK4A9Umo3ecs/ttbTVlNf27pw5ZaTIlo+8Z3kuPURIS/Aj1wJN5QyjJWAGyv2GicHYmHObLy/akbVaCyE0YVVRfBimLxQWCK/zK9ViUJnk3ANmVcm66sufTehjgwATC53y6lF2mj1EIwrbXS/RVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760017666; c=relaxed/simple;
	bh=RlhAm2Bg9pvi1ogK5q06pE8r0EcxlDXKABHary4XLh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L+IRve3KZFd9sii/k8UqsTjcrAuV2ifqPjDam2ztpT3Cau1M+aDa/kJr2XE4+UG1TA8VmDEu5buAGEWNAr63qWpTYbY2tY+w08IC0fZwn+M8ThbyR3I1IsRcp+5PoZoeIvOgRrKl4NgEScOthR3N3BclqvQyFDn2apk5Jln1K8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FBvLT4AJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5996EOr2010864
	for <linux-kernel@vger.kernel.org>; Thu, 9 Oct 2025 13:47:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QbuhKzYyNn4b/GhuLY4ieUg767B4emhq3As5C0P9FLg=; b=FBvLT4AJolC+mYxz
	clqU1bEJriRfxtkKFOydY9wRkTGhGBrSMw0yoEp5U0+wGBBH2ZPX8mtIKKanvike
	Y9Y9fHlnwrzg7t7EiJEUVRY2PpNyQfC0o20iu8oeQpHHc8Y8w6de60DfFZuFYTB8
	Nkj6y+TzEhklUmW+vkIbdtHU18szRYZ4kwFt2C0lgSGJR6qo2NUUaeFgBVNaZM4Z
	JY2dVnG0GkO8tJbuT26ME+SFwcSG4SvPvzFMLLHvWYiyvi/3vY9jYfzpAMhCpLOn
	v7pNaeVA+xO8lKyTnu8elJ0TpP/IIbPLTHXP6aMIqXjDnUuESGPEscxrqAhYSy70
	XVudew==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv9ab0fd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 13:47:42 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-78108268ea3so2718709b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 06:47:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760017662; x=1760622462;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QbuhKzYyNn4b/GhuLY4ieUg767B4emhq3As5C0P9FLg=;
        b=wzIUWzo9GXzHbcYRkFSgwsfUlnggldHlZD5DB1gm0IfMf/LNKsZBT33iZ/gDqZ2hH7
         wWZKgqWXvaUn/zKKkfLEWcBqaR1oBempW3M+0jQkfSUmZDFYvVC8KbnXMf6Cz3B8iz/x
         mdI6fBwHr/d5Qgy+rs/XBbD+Bnl7p98lDr5FzWkK+AinlswunzM/fppQ9MUfrFYF9kHC
         rvUVYnxNKLRRRL+SAcrDrnHXVRL92pcpj5i8CJuCR+ADnVXyWxDm/dWnkY/zmAD4kQMI
         9lfk3paiZ/XiyWT7sYkg8HrCTFPP8nQdc0KGq1qR0paIn0xRJVmQCEP4v+oqQoPh3D36
         KqLw==
X-Forwarded-Encrypted: i=1; AJvYcCXbBqYZ2sWWsiOr+D4+S5cWr8k6pyuFlaXs+3LjCQFY3GcvCNxgoQvyT3duC+kHmJ8qRXrDvAT+2M14mLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxasvPZGgLgj/Y/zlXewo5W1Ao4s+R4+5tSPV0vbU4FbfrFx0T7
	Mm40tqoYP4rgtP/21K0aI+RDSkJL/dHqNAWDhT1KtYVlV/ZcgPzjQozS+brN/MBG8FnU7KJigYw
	RIKxZODATRXPxwhIJons+9N4baoeXwZ6dcr3ofEJHaP5QhbodmLutg6aj4YnBFDwnuMY=
X-Gm-Gg: ASbGncvLfcBXg8EyQrXOLqvoSxzK1dJrG7kfne9nKqw1fsDoO15K3nbllOk7+OVRZls
	X1ArxJVbsTp589rG7VPohP8wOLO+8wrMxLTlSBamgDCyYT0jSPfQE+u/XbbqDaztpC+O2IcH97u
	LESciEElCzRlFlGyBYZHS/8/OvMyRGYazp6uKL+Hj+T3mpuknDPGpV3/Z0VgWMI4c94KY8kw2rz
	84h2nLid/AJ8A6aXd1+mdvPaIxR2eHvjAhAGt04+voLjyqbXurMu7lFjbUACFQLjXzkb0R26j1Q
	1XbjbXhC8TURTOp6cEZZUjBCFChlG6vF0lA1M3ESuGHBf8nLv7xJWgRrMfETj81Ia+ogqwy6FL+
	I1w==
X-Received: by 2002:a05:6a20:3d8e:b0:32a:745f:beed with SMTP id adf61e73a8af0-32da901260amr9717520637.26.1760017661545;
        Thu, 09 Oct 2025 06:47:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSAsehxtpQrazP6VTfIez0ySTkYxB2HS9LUqidFtssn3qRxOFg6kh9acrWvGUQNz8wkh9Ohw==
X-Received: by 2002:a05:6a20:3d8e:b0:32a:745f:beed with SMTP id adf61e73a8af0-32da901260amr9717473637.26.1760017661062;
        Thu, 09 Oct 2025 06:47:41 -0700 (PDT)
Received: from [10.217.217.28] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-794d4b3d611sm2989224b3a.6.2025.10.09.06.47.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 06:47:39 -0700 (PDT)
Message-ID: <db8855a0-d596-4142-9db5-20ac5f262078@oss.qualcomm.com>
Date: Thu, 9 Oct 2025 19:17:33 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/20] arm64: dts: qcom: Add PMH0101 pmic dtsi
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
References: <20250924-knp-dts-v1-0-3fdbc4b9e1b1@oss.qualcomm.com>
 <20250924-knp-dts-v1-9-3fdbc4b9e1b1@oss.qualcomm.com>
 <85ba017c-3ed5-4fb3-ab6e-a64135a15a85@oss.qualcomm.com>
Content-Language: en-US
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
In-Reply-To: <85ba017c-3ed5-4fb3-ab6e-a64135a15a85@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMiBTYWx0ZWRfX5UcYcqnXP8sv
 YIJlE0UIqUEWdfxB3fTDuXGTgDs4NH1Fx2pg6zGpf2R2cR6YiwrD80lSg5qEgQUjzmChSrbYJmv
 dG+LUD94O7cdv20hVWmeDD5g3aXxoNZOdESg8AAi9UbqsMXjHGEsrtbDD3V7Hdo9nTaXWqu+JHX
 1sU7IWx+3tRVEwPY9HMOWyFooV5ce6NTSycSn0JBrkBxoJZXZMmjSodJ32xloEhyiHxiWOfdd1u
 VvcCLI1jgZmbbH8OD5dbtbGCcnFDRCdoFeTnGoZcdGkuR0wLoRQP4hMpTxsmPXpQRtnKxazaS/q
 fT6LfF1vw3fVAFW/goe1QZb7RJ77KhQcOtVzTcmy4EjPNWL3A9D0G2sksdn/A0WtSrUOhuSWI80
 tviPN5LKt/NQfTsbI6owFRBSEEdKDQ==
X-Proofpoint-GUID: 15X1Emeq_JjKZ_3xx9bmAS3GIEQV6a_p
X-Proofpoint-ORIG-GUID: 15X1Emeq_JjKZ_3xx9bmAS3GIEQV6a_p
X-Authority-Analysis: v=2.4 cv=JPk2csKb c=1 sm=1 tr=0 ts=68e7bcfe cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=J1y9QmG_dN3EwAzi9v0A:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080122

Hi Konrad,

On 9/25/2025 5:50 PM, Konrad Dybcio wrote:
> On 9/25/25 2:17 AM, Jingyi Wang wrote:
>> From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
>>
>> Add base DTS file for PMH0101 including temp-alarm, GPIO,
>> PWM and flash nodes.
>>
>> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
>> Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
>> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
>> ---
>>  arch/arm64/boot/dts/qcom/pmh0101.dtsi | 45 +++++++++++++++++++++++++++++++++++
>>  1 file changed, 45 insertions(+)
>>

...

>> +
>> +		pmh0101_flash: led-controller@ee00 {
>> +			compatible = "qcom,pmh0101-flash-led", "qcom,spmi-flash-led";
>> +			reg = <0xee00>;
>> +			status = "disabled";
>> +		};
>> +
>> +		pmh0101_pwm: pwm {
>> +			compatible = "qcom,pmh0101-pwm", "qcom,pm8350c-pwm";
>> +			#pwm-cells = <2>;
>> +			status = "disabled";
>> +		};
> 
> Any reason for these to be disabled?

PMH0101 is used on both Kaanapali and Glymur, but the flash and PWM
peripherals are used on Kaanapali alone and not Glymur, so we
kept them disabled by default and enabled them in the Kaanapali
board files where they would be used.

Thanks,
Jishnu

> 
> Konrad


