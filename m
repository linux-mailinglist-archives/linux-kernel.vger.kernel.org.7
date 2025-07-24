Return-Path: <linux-kernel+bounces-744468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 054E0B10D59
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A91A160B9E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 14:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4432DE70E;
	Thu, 24 Jul 2025 14:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DRZcdVsx"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11E22D8DC6
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 14:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753366675; cv=none; b=D/TdCbJwQwdOKlhFqUDJhkMRiZbiAcsahsoNtjW1+AvMlWrqbKaYkGAP6BtgUmgE/fxvABMXWpuF5bLqovBKqwo7EVfDl4mKSi0nULvmzy31PRVBv1KxSj+xd3l7/qTzpVxbZ0RM37sgmSgmbVZuxMNo6AdPcs8pT2Sg6gU4iqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753366675; c=relaxed/simple;
	bh=M9qIGBMwsRvsee/Aa2Kvz9A+15R7AKW1pzGk8f83Gkk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sXwd+BRpLA1SoQnJARWIB7d/Y3uYxw7cswNG44qqzS3y6ZOIBaYXm9GAJe9LbzdR5B4LD6k/AJGlQYo/ySnd1NN5B94m3LCmYg94EdgiInqxIDspF3jjswopk/fIbLV7EIiaO9To1qWuHCpCixCM0R0+fY93D+/wBV4/zhtZK2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DRZcdVsx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56O9YX6V029796
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 14:17:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	M9qIGBMwsRvsee/Aa2Kvz9A+15R7AKW1pzGk8f83Gkk=; b=DRZcdVsxwlDA5ZnZ
	VOXeELOmCkMFzq9wj3KtErgPnXhdH9tpZYpwv9nKdjfctExQZkJHIaW5WWgMtPya
	v1mGx4LFXJV/GNtAbzRvLQ0gvZ+N0wi37POn7cTZt8d2zHAINzYm+wLIKL/huLA+
	0cU0k8fDxSBKrn5rCLkWpqqhADyLSghK8V4Bcfh3Gp3FbuDlKjMY62OXPEh4HPpL
	5RhdYZhCHboBOs6VAKGgUyspgptdsqgOyBF6AojJeDsj3BLjUWsUsppYMTmdmf9b
	Fvsr/Ppe9R/BU/Dg8KGAknnlWvCfGSxXUF5Bvpuc8Tbxj5WDwZfyRNVYWWt2dboU
	R/PeJA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4826t1gb2u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 14:17:52 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b00e4358a34so832218a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 07:17:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753366660; x=1753971460;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M9qIGBMwsRvsee/Aa2Kvz9A+15R7AKW1pzGk8f83Gkk=;
        b=EXMq/mFxIzszEAlgwoE92/E/VmbEZqMb5i9CUh8+f1gr+VA8wvCXsdH5KT6LZZi2la
         LyqrF0qFXWkjfq8GZQUQr+FXEL4ypu0HqNTJ3SQlhl8r0T6ZiUEdTp5raDWuIm5ZK6uL
         Ok4/1g7NkXoHZCWKl6iyrAzrFXXBOar6E5vb5YAsZe+xCvIehCj03gqkAf5EeVDZmq2H
         fC15Wap8x4d1Q78KskmE4T8PMM+T8LZ+ILGHLRZBAEIV3vLS0macxkXRlcnWF7jj3gAW
         G0HcD38LIhCPWirM0hAHWsfU2P1aFi7WjH50UmV32XD2kZhg0rpjjR6mejGVCRPScCeN
         5sAA==
X-Forwarded-Encrypted: i=1; AJvYcCWkpeUtpZ92eaduasMkawmWwH1OkfxxR2Ef+AUBY8Mswe+z8/vDDpb1FoEqBlFDA4VUZrXlrPvsqINLTT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuCd0ImYC2LxYyJ/zjdOKJgYp0MizSl02U7YwaFnlnLO0+M4oo
	SaPRwGslsBATweayP69xqpSRP5MA94vrsy8FJb/8PrXMciW2q5vAdPzEQrmnNT0QY4AZNcnXlii
	Lh0WdmOl7ZzmzpOyeZX60yx4/C8ioyq7S+SyMmXGt5ilyHVA5LFsBV4NEFLh5U/nRNjA=
X-Gm-Gg: ASbGnctAcQ2DihpHjKar7sQyCokoJ62KCcA61UiF9d4nahYELrsJNW+PZDRAQ8wgyqH
	zy5MnBfjr/XYZR2tM+85QqFahXpZlHlSWhjT5ZOWchBd9uCvFDmf27fRnHgxF8jhlI//g5mOfLz
	eNvf5NF/baUCeRbGlPko/altrjU/O8LZwY6XApveYdGJEPWUbjKJ/XyG4xRyABNWNTevnVH3iw1
	XHgI7K9ol7j08H6h7q+54jYqpfp+mapMt+gPLmDmXWFMB7aEXgE27/Sh7G9kshjp3YMkDPCDaGN
	iMEJexVIL2dm2tJOCg4W0XoI19ynE0K1Hz1MGzee4Q4c8mX/toO4/KGBQHqj/UD7ykyceD7l52Z
	yq5W7wUP6
X-Received: by 2002:a05:6a20:734a:b0:231:6ba:881c with SMTP id adf61e73a8af0-23d48fe3d5bmr10681858637.6.1753366660604;
        Thu, 24 Jul 2025 07:17:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhvtFG0W6tRYiyGDcyMpsBo+LUbFikSwfNcVBQeALnG8xoshy53s7tiH9UcHqZ0iY3/+7/5w==
X-Received: by 2002:a05:6a20:734a:b0:231:6ba:881c with SMTP id adf61e73a8af0-23d48fe3d5bmr10681794637.6.1753366660018;
        Thu, 24 Jul 2025 07:17:40 -0700 (PDT)
Received: from [192.168.1.6] ([122.164.87.238])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-761adb7876dsm1830391b3a.6.2025.07.24.07.17.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 07:17:39 -0700 (PDT)
Message-ID: <807d50c4-5ee7-43d6-beab-7ce220911d41@oss.qualcomm.com>
Date: Thu, 24 Jul 2025 19:47:33 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] arm64: dts: qcom: ipq5424: Describe the 4-wire UART SE
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250630-ipq5424_hsuart-v3-1-fa0866b12cbc@oss.qualcomm.com>
 <kad3hqxufsdescelmjhwy45ggnukh435wmo5wbbl6pfz2gq5ge@ycfsgtuwdkcl>
Content-Language: en-US
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
In-Reply-To: <kad3hqxufsdescelmjhwy45ggnukh435wmo5wbbl6pfz2gq5ge@ycfsgtuwdkcl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 4Qoa_QWpJizRvDjsYuGbqEH7iWQ5D4Fp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDEwOSBTYWx0ZWRfXz90bhs02ySdN
 e3Mm6sn6P/ISVAy8XLMUmIDllTv6jG4a9kSEc/qX7ooO4CSZWaqQHWdgjblV8HlkqT9ZYhvPN0j
 DoanWbAMOfJPDbxIaH5vpX0ZJrzO0UpPWDqC3vDM6MzAzyBBMxVW6XTeL7EIBJuKIjPVMHbofgn
 sPYP6XRuOV8EEJIWeXFZavA2wLJSwhAN2pUIIQ6Je/ADNjMzpoFZxJeL17xYGs3X3nruQxVPxgf
 2CmoU4w0KkbSEcvQrQCrCxVKIqJxrIIod2CbZHXebsD/573JjvOlSgi1noBEsvnIw4gu6qdZ4yd
 3wRQyoyMSnS5kgcqm7PdBhsJoInasSXLPUjCZo5bTjtIOvlxmKZdw0fJyN+cfOlYCyPGQVidG64
 BI7NeUqVICGHq9BlZCdNPjw2APVRTyQC9Ll6MKRiHVeABDJ/aumo+v3NZIzshObL0uWyLoIR
X-Authority-Analysis: v=2.4 cv=E8/Npbdl c=1 sm=1 tr=0 ts=68824090 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=JWbiWFiXhu80OzE02/OSSw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=Xs_gmOcz2JqXoP2f-ooA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: 4Qoa_QWpJizRvDjsYuGbqEH7iWQ5D4Fp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015 phishscore=0
 mlxlogscore=580 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507240109


On 7/23/2025 5:00 PM, Dmitry Baryshkov wrote:
> On Mon, Jun 30, 2025 at 02:20:15PM +0530, Kathiravan Thirumoorthy wrote:
>> QUPv3 in IPQ5424 consists of six Serial Engines (SEs). Describe the
>> first SE, which supports a 4-wire UART configuration suitable for
>> applications such as HS-UART.
>>
>> Note that the required initialization for this SE is not handled by the
>> bootloader. Therefore, add the SE node in the device tree but keep it
>> disabled. Enable it once Linux gains support for configuring the SE,
>> allowing to use in relevant RDPs.
> What about documenting it as status = "reserved" + comment and then
> enabling it once QUP patches land?


Sure. Let me update it in the next spin.


