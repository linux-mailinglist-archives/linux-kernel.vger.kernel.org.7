Return-Path: <linux-kernel+bounces-741087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F06B0DFD7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 17:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3C037B1A69
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 15:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04C32EBB9A;
	Tue, 22 Jul 2025 15:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lzMJhF1r"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80482EA74F
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 15:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753196519; cv=none; b=V0zRP4s5wjmU6x1mvnqZ0745x0K18msg8Ad9bEUeIB4YlbXFvGrPbOPyDyiL/43+HTID81IjWC5bHjPEejPwcB6kt6Xm5XaObWNuSIaeJLKUMotu6/mmSw0mPhf9f2h/lAtJJGFMMQJTypcBByD3RjCcUV+ExH/dGXL/++oJ2uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753196519; c=relaxed/simple;
	bh=YmHvIykm13Ip/tOjb7KoHSGXfOvcdQou2fZ6EnWYQTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ivPmHqcHF5Et7TdzIfC1zUmcssjDY0ST389Y0jnKC2hZz7U+OBCsm1HixO3atzLaRM1WHpxQf45mJ4fx4yzl+3PISCJ6GsUN3191Ok+NzfY5Bnk0Xk9J7iN318GddxRXMSXHTlVdxVlHBlrnProwIp17cUOvEghlrIN+gE4x+cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lzMJhF1r; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MCrag2018032
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 15:01:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nQea+0bC6PD6eejJkZGOzWEWHSsdYyQtTKTo+7Hs0x8=; b=lzMJhF1rrwyfBKv4
	QY1FUQIGo7zdaPMs0+mvmgS6d50hl6NvrGiG8Xj+h0xnai1fCIZBeHDW+URvCzG5
	213nyitbdgiTo+ItZ6nS0EDKPX2BXtutwA+YowM5xMfh0p4M7FdShhhjs40+Ew7k
	y38edEMHc0tMqSZzLlayxhVpQqc4+eLJpcQv08khiTp+f8tOXoeAU1f7mZCG62ZJ
	bTMVKMh+f96wMDjQXvWCYDfxHLGCxX5F79zJXQvL7EtneKg02OyP1yiM94x9uKPj
	gdUEknpoPV7fHkG8O+gOMNWfiwXcMVpHNgo+CGcjDnXUNpajAcFmd8IUJGa+Ok0T
	PmJg4A==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 482b1u8e52-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 15:01:56 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6fac4b5f949so5695046d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 08:01:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753196515; x=1753801315;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nQea+0bC6PD6eejJkZGOzWEWHSsdYyQtTKTo+7Hs0x8=;
        b=kkxDaj5HGPwSmn/Jim3KN2bfS9RmNaRnTWkJVEwcQ146v+Lepo9NNXgXJ5xbM/oK/E
         V8Rl/B/A+oVZicj0RiQY7dGE/enuLgDi6tHw1HCq18AFBtyjqpvk9B1cce4RTtT0/M/h
         V3yV9oHOmdtHLrOcTaB/O4uiqNUhSTeghiQcIOcxwey4a1fwMIrEd2RZOOnnUU43eLMV
         vMsS2Td8nyRUCLYrDMkWILqcWgAy+hvYVTIpUu8oJK4ohUwW09FZQY85FxuNBB6xhPyx
         f8dLXDfukb/+TTE+t/A43RWYDAKAvNNDD5AIFVHH8AueJsfMtyrk0GYJW/l66UpZdNXn
         42EA==
X-Forwarded-Encrypted: i=1; AJvYcCU9GTS8P2iLxCvdYi1VxWiAQjMBaWS86MLaEjUBth4eCfc4TxEGAc3bkD/yFvfDfo9K/wdHiid7eGAHJM4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1q1IGFYwoM7TlxVuFCdsgpoPQ/QWW6NffRohPm/pY2qEj00EP
	M80MpInO8Z5zIJ8sbqPAVLwy5WDoeDrKHWk39y+THj75bv91hU+MwQ/Tnt39uf2aJfXzskCT5JQ
	gsjXZm9tHRtQvdDKBzRQ2MMLdcpMgxpeqe75mKNSxQYafjJEuFLojzehTJC3GHxdKJJQ=
X-Gm-Gg: ASbGncvKMCHApp3nI0AMcZv7zoNoMJoyMENrX+Jn982WasJIwQLug0StzeM1n5zTZWY
	CxUSEI9AR81KeASzgHRT7f807Q8Mqh7Jk5ywKofCyrCwNq/lTWcAlHVNkihsd1zX5ZuFryMdzzK
	xTfGKNW/+OynpEEx86S/gxRGZZrYWNYoVRslFkmKzFFZGvPfYt+FGCdyJQig3w8ces9+KoPSYhW
	OvHcAnhSChnvVc2rasfgVXDrLkhsn/CpXvcex/8YvWAnJwtlPRQO9Z8CeOnEoSax2h7IKAfKJwm
	6EOkT4kc9wFwDkF3J/39o8B5/JwTzBrf4WpYU+0guVM/qi7XQ7+mmaKWvXL9zjkoXZTF+q8S1fH
	hCaB9dvT64vfx29bn1mnP
X-Received: by 2002:a05:620a:8089:b0:7e3:3419:8ed with SMTP id af79cd13be357-7e342ab82c0mr1516901285a.6.1753196514616;
        Tue, 22 Jul 2025 08:01:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9HTTcR+tQSzuEDJ8+Kt0u51iSbuGAMBmDowZbgYVk1n01G8uxA0VUwMaUyhdWRTPvV72rbA==
X-Received: by 2002:a05:620a:8089:b0:7e3:3419:8ed with SMTP id af79cd13be357-7e342ab82c0mr1516895185a.6.1753196513449;
        Tue, 22 Jul 2025 08:01:53 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6ca310aasm867940766b.72.2025.07.22.08.01.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 08:01:52 -0700 (PDT)
Message-ID: <88a22bcf-2c31-48e1-8640-867727c02ea2@oss.qualcomm.com>
Date: Tue, 22 Jul 2025 17:01:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] arm64: dts: qcom: Rename sa8775p SoC to "lemans"
To: Wasim Nazir <wasim.nazir@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        kernel@oss.qualcomm.com
References: <20250722144926.995064-1-wasim.nazir@oss.qualcomm.com>
 <20250722144926.995064-2-wasim.nazir@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250722144926.995064-2-wasim.nazir@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=LdY86ifi c=1 sm=1 tr=0 ts=687fa7e4 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=ziRkMoTaCqJTGmMilkgA:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDEyNCBTYWx0ZWRfX1XCLA24Nlc2C
 209UP54NbXgYnLT5sNyESy4sGYC82KCQsPXfb6etdtWOJrLNnvyPZ96aqFc6EeaYzwa1Naqd4zO
 GAt7h7akbEjs97OYjCjBC16wr8DgTXEULKUdjg0bs4LX2CzjdwGHCwtkgXBfJkQX0/QieuUpuIE
 /P048lLbQtq9kLt11U7bMtxb+nJ4fwB99ugaamk4OZo7+q8TJfnqDgtuwj7/Oi71pPGhiMTlgsK
 8nbrJczEvt+4jzMAY3TYQYe7A5/OaHvBIcKjLR7fDs82B/xaI0ECIb683qLoLA6OmR822wIr0TD
 qEY+DMaPE6L84c24dVPf26vrpzcoQwIMjZkLAJSWtehQEIQ028sGJNv7pbQjdBq58tzpjxkoan+
 VbLhbf4dKi/uwwLjw9yrc7pw8haT+QYikqsP/BfiZeVVJYVGs83fbT+8i3GoLq3izcouF588
X-Proofpoint-ORIG-GUID: 1brdzrgmecTLAUqxKxeN02hR7sjal-Lj
X-Proofpoint-GUID: 1brdzrgmecTLAUqxKxeN02hR7sjal-Lj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0 priorityscore=1501 adultscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 suspectscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507220124

On 7/22/25 4:49 PM, Wasim Nazir wrote:
> SA8775P, QCS9100 and QCS9075 are all variants of the same die,
> collectively referred to as lemans. Most notably, the last of them
> has the SAIL (Safety Island) fused off, but remains identical
> otherwise.
> 
> In an effort to streamline the codebase, rename the SoC DTSI, moving
> away from less meaningful numerical model identifiers.
> 
> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

