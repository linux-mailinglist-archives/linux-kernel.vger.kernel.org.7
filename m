Return-Path: <linux-kernel+bounces-744289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 505DCB10A8A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 14:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09D87165E6D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 12:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2D52D46DD;
	Thu, 24 Jul 2025 12:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nh1WWtEz"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316381C695
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 12:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753361272; cv=none; b=FvJToq6RaZau4wK6AygOY/qj8uWwSqhGxTsbHIuePAHSxG1xsV2L4aA6qiEcq62ITbpQi2vPzIviw7Y7d+tSPjLVfpzrbxp2p5mYqjBxsRdNqVkThrZT1q+JWZBouI4mPlLjDFBgCx59dluIMA6Sz34lTkZ2kYfWPI5qrbJaGD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753361272; c=relaxed/simple;
	bh=j705TJQJk3x7OHyAVKzeGEgdS46JMPnBxolChxBMvjM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=odvCu1FquEqtZX5bVWrTBrE3kQMNMJUbAsxNwQCtuFWV7ffEYIv7JEearqB8W/zbenOmfavlQNObHKPwn44xpcPyfhE1cn5C0jBBfxezKsr/vK9/G/PZVxGGeecf+WQ6N89w8hrGkD/iG9KdffuVIHaqFR/PpA9DOshPJd9C26E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nh1WWtEz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56O9fC7r028528
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 12:47:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0FM2xPuyNBnGL8vNJqSnDEcqFKlOQpC0+BnPbT25j0M=; b=nh1WWtEzJEJ0nnvL
	24zfprhbqKdrDt1dh3kTwGPd8nZ53puQpkEUefg9sPjJf0NByZeYo1XmDDBGW1LB
	ltExW/fI2wfpHJbwQgpyFzTnGvNnM17peT9qtGshqZVlQWwM6ZMUeqIhfAGNUYxO
	JfYBDZwDHEdCziHV15Wi0SMH0eRdYfw5mtTxBncc+vGCfEBh/4gWs6LWO/g/B+1p
	VMDoWiTAsw1NyAAi7Dbs92JC/N1lKpQ1VbSZ1G2/sLFWkuoAJGWfNWPybtsnGItl
	YDNGurBRuQm170vTnnQwWlBaiukNZ1y0L/mQCacJH5ZF5XD08nxHZutQrHziMofR
	IKwkkQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4826t1g2fx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 12:47:47 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-7071981e657so265426d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 05:47:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753361267; x=1753966067;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0FM2xPuyNBnGL8vNJqSnDEcqFKlOQpC0+BnPbT25j0M=;
        b=lpSCgvf1jM2ZOfMLBuNCfscE9hIJHYZRbj69nzBNl+kBCCaz9PqkR9TvZyaM31MprN
         vJyiqahJ4yrb/5HdqZZp98iNzQEAuJ+q8A7HQWZT1jtXoLHkCyPvT+lYLwKnn29ZPnYV
         5Vs0b5OKy2SoVvf5urOiQy9Br3UqeGLWqy0aiu/OU4azu6KBZPO7Fqoijlk5dp3YuL34
         hyNw//6qbBO85GSzKiskrBPvGWB+kKl0lX5elgQQYnQxCLDCc4YGg+WxBhXnbhSLEl2R
         Nsffvcu14lQgKHAqNAUa5iJwFPEsbfuuEJSHbJzRBx2LmXC/KJLtlNvFXzGv+03KM6jr
         WVUw==
X-Forwarded-Encrypted: i=1; AJvYcCU73S7FqFWmrQXME0gW/E93Y8dtqhMlVQg9VznqWfN2nK2yeftMsdlPYL9f8jBsyXhvCAKBx28+cwEXSGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQDy6Ar8S3XT+ApsI+3Rj0fwjfO33Nc6/4gZWgwc0LhZ/y1O6O
	OplesYEkX4rx8hDV8QblwCvLoGqWclLfy6d0BT99kAGVYh7y6c+dfoEALNd3znDrORfx9kmkflU
	NvpmcsNqiV/JnwdfI49v/8h0eFfaLL7DyQhmBb8Ft43VrM0dyW21/My1lB2EKCsvW7wM=
X-Gm-Gg: ASbGncukQj2lqTubaf9KlUk2uEPDwosq8W+42xkySr6lLGDyj0x3XFUL3DUYmTGPPjD
	3suIFNevH2uaZ4azZXJKbPLxoxUQuI+6NDC4wozxSEhdPLNyOCoR0+C0XbWnhQLaGEBuLyfgHjJ
	N2bz/YQdwjzEc3HA+wS+kwRqkblc89g18mqNaCXksEe0RGTVPhM/XOpXiDDAygFvA73QBjZRLfs
	PN6rxIiMMgV6/ZyuYaup4LcEeEV7f/Xtab6/V5HWq3lZVIKJLG+VQ9IyMGLjfFHjr3QjTapenZK
	KqvcJ4uCEnlnPjv3IwmtcmJKiEK1+6YDLfnIJEkS3c5GsghxqJ1xjYD+ppxKuX6HQxcEx8UZpp5
	AjkUslvtFNbpr6LZ/1w==
X-Received: by 2002:a05:620a:2606:b0:7e3:4410:84a3 with SMTP id af79cd13be357-7e62a03804fmr308919985a.0.1753361267148;
        Thu, 24 Jul 2025 05:47:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyI2zhNTupwdsIDnxsXopNUvVOzCpZF9qWtxp5NPNExIrW5W6unnaR6wpmZfExbg7wpVtu9Q==
X-Received: by 2002:a05:620a:2606:b0:7e3:4410:84a3 with SMTP id af79cd13be357-7e62a03804fmr308917685a.0.1753361266512;
        Thu, 24 Jul 2025 05:47:46 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af47cd65089sm109986566b.56.2025.07.24.05.47.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 05:47:45 -0700 (PDT)
Message-ID: <159eb27b-fca8-4f7e-b604-ba19d6f9ada7@oss.qualcomm.com>
Date: Thu, 24 Jul 2025 14:47:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] arm64: dts: qcom: Rename sa8775p SoC to "lemans"
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        kernel@oss.qualcomm.com
References: <20250722144926.995064-1-wasim.nazir@oss.qualcomm.com>
 <20250722144926.995064-2-wasim.nazir@oss.qualcomm.com>
 <20250723-swinging-chirpy-hornet-eed2f2@kuoka>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250723-swinging-chirpy-hornet-eed2f2@kuoka>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: gbXYwmnj_xoHIbWYmYu-yoOF9gkCgJdi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDA5NiBTYWx0ZWRfX1C13STiKVN9/
 nNL8F6wRXKWcNqLhMr5+C6TU8d10m0j1R6CwLse6YzVrx60leSg2L5zD0K420Rmgudqpgn7A2pF
 vGX8FT2sUMtAcLU05b9vGCpf1aT43x8bWem1WyIQDzY3H24gbukFJ2lpo++7w/sJ/3RvdgcPKG+
 R+J9c1HPbjldmlzRDpl+wHu3XbKoZfDyCKyiX2I6wXeQUpMlMs7Rn4r6zwZmdR0mWNuayPxmkFV
 MRpBunn655T5pRlxCwYhcqr1hJqNcJI1eTsRNoix8IP30SUuqjJ+fSz0aKYfbbl/Ix7KVtKwLoU
 9j3VOnpCR7ZQOQ4UKxdL/wxmoS9PrRAGq0Y2KF0MdDGPmFJ2zHX14hXd8LBpG3sKcg/GAig3tk+
 dmsRwtUyOzRBDDzgA5JqwXcUBqFiTANXelU3vfZkj6XblVFSQ3RFL1pt2cEIzW6ocGmcze05
X-Authority-Analysis: v=2.4 cv=E8/Npbdl c=1 sm=1 tr=0 ts=68822b73 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=yoiuoX9zeVfpJc3uYVUA:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: gbXYwmnj_xoHIbWYmYu-yoOF9gkCgJdi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015 phishscore=0
 mlxlogscore=896 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507240096

On 7/23/25 10:29 AM, 'Krzysztof Kozlowski' via kernel wrote:
> On Tue, Jul 22, 2025 at 08:19:20PM +0530, Wasim Nazir wrote:
>> SA8775P, QCS9100 and QCS9075 are all variants of the same die,
>> collectively referred to as lemans. Most notably, the last of them
>> has the SAIL (Safety Island) fused off, but remains identical
>> otherwise.
>>
>> In an effort to streamline the codebase, rename the SoC DTSI, moving
>> away from less meaningful numerical model identifiers.
>>
>> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
>> ---
>>  arch/arm64/boot/dts/qcom/{sa8775p.dtsi => lemans.dtsi} | 0
>>  arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi             | 2 +-
> 
> No, stop with this rename.
> 
> There is no policy of renaming existing files.

There's no policy against renaming existing files either.

> It's ridicilous. Just
> because you introduced a new naming model for NEW SOC, does not mean you
> now going to rename all boards which you already upstreamed.

This is a genuine improvement, trying to untangle the mess that you
expressed vast discontent about..

There will be new boards based on this family of SoCs submitted either
way, so I really think it makes sense to solve it once and for all,
instead of bikeshedding over it again and again each time you get a new
dt-bindings change in your inbox.

I understand you're unhappy about patch 6, but the others are
basically code janitoring.

Konrad

