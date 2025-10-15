Return-Path: <linux-kernel+bounces-854310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E679BDE12C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 12:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CBA118974F0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 10:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92AD031B819;
	Wed, 15 Oct 2025 10:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iBv+zLJ8"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B4630B518
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 10:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760525263; cv=none; b=T+PXXvC4Vouw2X6G+PnWYoydku4aPIEChVQhZaAckpI535MKBl42nWVwpy+krdnMa333Ixk1IgecqBRswKNwhf4M3kwjAkFCR5m3W9gOXE25o6ugFkIgoxs4w5TdkyD/0GW3b/TR20rseZU5XCcs+GMSWrIj737sqAntmgx8wOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760525263; c=relaxed/simple;
	bh=c3IZtW87v3ljTjIpruFmkRtvbZWmdkUO//r+kCqbBFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m5O1xt6II9SzuAzYoTTKTF552Pk28a2ks/tM7yxmzUDfgyI+ixg3EevsrmGr6ZXpW0/w63ASQ8BVOjplBzi7VlT/qF1gK7pybKVNyPkTtwXJuXZ/cmOMz7k55wZZoxCz/q/0ENx9Nyw0uLRY8rzz0rkg8Py9djC0iSKVTpL1Uq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iBv+zLJ8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59F2sGlS015343
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 10:47:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VwSKkIT+1Bc65l4iTbwnkxxWrUC4kGa69c8ubnneGy4=; b=iBv+zLJ8gnAfMNEN
	F+bjt8xwtZ6NKDtt3eQxAYOdLnGbQgo18s0xpuZXxEtPEiyT1Gc8QpwZnZSrf6go
	oOEPmyWrZ2UVdEOeyOXbQj5XxLlZWuiFzeQ3mIhJgHgqJm2Be2+71H/fuomIa/8K
	9pIkc8LgeTyzFoSJ1/lxvh4umaQqjW31pG+AA7iQFpNvjfV4EWt05d7anFXEBmlK
	Tn9YieDWH1dB6Ar8P2DiuPK94bB0S7ahz70FO5I6BcvojSdb46jm3e4I/sIQ9xr1
	tU/IFombG+/Cy46Uvq2q+J6p5tMzHC1Sub+ehbfAkzhLdLWKqVXgJhWPTnurM4qF
	b9tx8A==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfm5m7bt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 10:47:41 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-33428befc5bso12783639a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 03:47:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760525260; x=1761130060;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VwSKkIT+1Bc65l4iTbwnkxxWrUC4kGa69c8ubnneGy4=;
        b=IHZ62+y35LanhFZjx9ZfNp+YfVQYcJzkU64GJz5OUsclrSeS2lvkMssZNwmwfvoKcy
         p5/JT7S9sizK5NoPvM7aILH2vHcmQnH4uCwGPhFXC/kFjRcY+4TM2k7h4F8H5NR+i1bj
         VRHo7mCfYy7nzfUolxDysULzjEO9T4rsbfogiy0rmWT5JAKtx7VBXgJ2Me95mVpaK4CZ
         HenGqV9c96283BfHI7tyKqNdiraMmB62g9b+sQcVgcQoxY/bo/l9V5r7eiTLcKnpn1rP
         plHgEV2XWHnEnp3hWm9hWnzmKB67I0Xld6DbpEZwCvUX7+qXx6faeUj7CIYTLCtxC4y0
         cTSA==
X-Forwarded-Encrypted: i=1; AJvYcCVqS3Lt19U57JXYgxKST906oiaHKUvwxgsNG2+WjY1BZLPcAviCr12YwMdgtwFNYNHZSSb4EWpeAjbLEfU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy02siJD0Z9Ov4SC83NoUPpwtAOzwkX6QkXv8XBkEC7XlAe0f07
	CTP/IlSjokWUvVaQQaCJOltsy99w6ZF2XWzeXLGl90jjR9xlFoDc8WfDYy3wVGL1AUo02YlsO2D
	pCsbSH0iui6QHVtp6LgGDTmrNRi3uEFesoaB5jaozr+P2/z64aEpYNTEpfph9r++Vd/8=
X-Gm-Gg: ASbGnctR2hPzYA78F+X7XZazSrOZUOrJjJNm21aYuKtoVP1q+/pKeU4z2Rotnazmr1l
	Tfis9IZqxVTVDJt+s3wcRoyX1bB/zJ5TG94H1jU4lXvrBavgr9xvrUZ38RahMkER7c5VhJq3wmR
	MUbeLCsnQdEwPC6S6EDhho1rB0Stv0OieiqkLWr1JC65rDtwsl5p1RUNlTHGq1fstiSn4kIwGgn
	HDkH3zySN2CCZsxHNH7CYN5qVQ4XZ0n1OYiD9mLkh/r/iKmBknzXEHSUBbt7V59q0CqfFwiZnOI
	v4Pg5IV3j8rndmtbJTIP1YbczK2EWs2taplT6eq7k4E32+RxvhS9vtzhcof0M0D5V+yVE54=
X-Received: by 2002:a17:90b:3843:b0:334:18f9:8008 with SMTP id 98e67ed59e1d1-33b511174e6mr39869573a91.8.1760525259866;
        Wed, 15 Oct 2025 03:47:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKDVtK4+j8XSL0ehHOvb/Mrov6iyLzDKcqsN4t9m+LQpWe/azkn+M9OD0xo7TCIUXYtC8boQ==
X-Received: by 2002:a17:90b:3843:b0:334:18f9:8008 with SMTP id 98e67ed59e1d1-33b511174e6mr39869550a91.8.1760525259396;
        Wed, 15 Oct 2025 03:47:39 -0700 (PDT)
Received: from [10.218.44.34] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b61a3cbf2sm19328967a91.8.2025.10.15.03.47.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 03:47:39 -0700 (PDT)
Message-ID: <e4d1cee0-6156-488e-abfd-957eb494a97b@oss.qualcomm.com>
Date: Wed, 15 Oct 2025 16:17:33 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/24] arm64: dts: qcom: glymur: Add QUPv3
 configuration for serial engines
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250925-v3_glymur_introduction-v2-0-8e1533a58d2d@oss.qualcomm.com>
 <20250925-v3_glymur_introduction-v2-4-8e1533a58d2d@oss.qualcomm.com>
 <dmuhltvj5shmysyjmzjhf6q6nvng45odpwbxsi7frmziunxtgq@xppf6cpyqt2r>
Content-Language: en-US
From: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
In-Reply-To: <dmuhltvj5shmysyjmzjhf6q6nvng45odpwbxsi7frmziunxtgq@xppf6cpyqt2r>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: YuUSsQVzRT9hoCAPyJQz--FE8DOy3OAF
X-Proofpoint-ORIG-GUID: YuUSsQVzRT9hoCAPyJQz--FE8DOy3OAF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyMCBTYWx0ZWRfXzcJWK50smkvd
 GV6uIp8qxjCn+HhVLCHzi8DrY1HhLs+QehisX/DSQap4VOUTWUkDW4XT6WzqHuLdixGqlbiiRnH
 jY+f6SQ9e5BgbrtOpu+e/YZxB9xYygzaT51sTlVPTbdAMA43YlCOpNv0IW0P+zrtvca9XFrLROH
 bgMTZrnEda8uRS3pHArSvrzuxBChKOlRtL4L8mCbLbZCzokbZtdCKjpXd+L9jW8ksi9w0yZyMnV
 yk+QNzGE0GqV8ex4Pr3TEZ7NjSwfAQFW84F964Y+BRK4MTaoUmfTVIpeCyU0VG02o3tAc/QZCss
 UWArV8cONgsdlr2UreP3qPhonfqaYunK8MwlnSHN+hh9nbqYSYkLIyaJb70A7PIw0hEAA7Hfol/
 JsqLbX0rVA/YP5r8X4wVwLrQ9donTg==
X-Authority-Analysis: v=2.4 cv=V71wEOni c=1 sm=1 tr=0 ts=68ef7bcd cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=kNkCFnuda-ERNw0Xt_AA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0
 impostorscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110020



On 9/26/2025 2:46 AM, Dmitry Baryshkov wrote:
> On Thu, Sep 25, 2025 at 11:58:10AM +0530, Pankaj Patil wrote:
>> From: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
>>
>> Add device tree support for QUPv3 serial engine protocols on Glymur.
>> Glymur has 24 QUP serial engines across 3 QUP wrappers, each with
>> support of GPI DMA engines.
>>
>> Signed-off-by: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
>> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
>> ---
>>   arch/arm64/boot/dts/qcom/glymur-crd.dts |   43 +
>>   arch/arm64/boot/dts/qcom/glymur.dtsi    | 3041 +++++++++++++++++++++++++++++--
>>   2 files changed, 2936 insertions(+), 148 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/glymur-crd.dts b/arch/arm64/boot/dts/qcom/glymur-crd.dts
>> index a1714ec8492961b211ec761f16b39245007533b8..4561c0b87b017cba0a1db8814123a070b37fd434 100644
>> --- a/arch/arm64/boot/dts/qcom/glymur-crd.dts
>> +++ b/arch/arm64/boot/dts/qcom/glymur-crd.dts
>> @@ -13,6 +13,49 @@ / {
>>   
>>   	aliases {
>>   		serial0 = &uart21;
>> +		serial1 = &uart14;
>> +		i2c0 = &i2c16;
>> +		i2c1 = &i2c17;
>> +		i2c2 = &i2c18;
>> +		i2c3 = &i2c19;
>> +		i2c4 = &i2c20;
>> +		i2c5 = &i2c22;
>> +		i2c6 = &i2c23;
>> +		i2c7 = &i2c8;
>> +		i2c8 = &i2c9;
>> +		i2c9 = &i2c10;
>> +		i2c10 = &i2c11;
>> +		i2c11 = &i2c12;
>> +		i2c12 = &i2c13;
>> +		i2c13 = &i2c15;
>> +		i2c14 = &i2c0;
>> +		i2c15 = &i2c1;
>> +		i2c16 = &i2c2;
>> +		i2c17 = &i2c3;
>> +		i2c18 = &i2c4;
>> +		i2c19 = &i2c5;
>> +		i2c20 = &i2c6;
>> +		spi0 = &spi16;
>> +		spi1 = &spi17;
>> +		spi2 = &spi18;
>> +		spi3 = &spi19;
>> +		spi4 = &spi20;
>> +		spi5 = &spi22;
>> +		spi6 = &spi23;
>> +		spi7 = &spi8;
>> +		spi8 = &spi9;
>> +		spi9 = &spi10;
>> +		spi10 = &spi11;
>> +		spi11 = &spi12;
>> +		spi12 = &spi13;
>> +		spi13 = &spi15;
>> +		spi14 = &spi0;
>> +		spi15 = &spi1;
>> +		spi16 = &spi2;
>> +		spi17 = &spi3;
>> +		spi18 = &spi4;
>> +		spi19 = &spi5;
>> +		spi20 = &spi6;
> 
> This is a very weird numbering. Could you please add a comment,
> explaining it?
Hi Dmitry, will add aliases for the necessary ones and remove the rest.>
>>   	};
>>   
>>   	chosen {


