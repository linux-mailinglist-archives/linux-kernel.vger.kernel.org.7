Return-Path: <linux-kernel+bounces-800554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 978C6B4392A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 12:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A7917C1D1C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 10:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5076F2ECEA6;
	Thu,  4 Sep 2025 10:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L8UprB7/"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F422E54D6
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 10:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756982870; cv=none; b=eP5joiuzTq7AButUlgcAJVzJ7xfrLvJyGqByTWUacXbOTrrNIxW+94Zj5S+vwRBn/ZMCqV17+nEsGzvJhwdT2p2G9DLd0UCEqmqVdFNzMclEtyhRTsWhRQ2kFiAgbev+lX60GQgcCNs9XL+S4SdPOfu6dmjgiBZ+OA5gNzl+174=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756982870; c=relaxed/simple;
	bh=+MvyZKV394meBDJI7Ka/R3SOhT63C//XXT5EerNYuUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iuj0Bue5nyuSeS7KgKMYSVsc3v2QoAFkfzXfgu+hq1dXuTJjsMEiDhzVCr1NToZspjPWkCAZvKFD/Qa4/ZBJHZJhFrPw/uN8Wgqcwu2lA6iHbAGK2WaHnjBbswLrljktrz1pAnmNDZFhQySjXAtUBY0FpK2H4U7VrNEVc3UVJQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L8UprB7/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5849X93b007610
	for <linux-kernel@vger.kernel.org>; Thu, 4 Sep 2025 10:47:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sLHQFn6pkMnsAa57RfPomE4K+Un5vLqC03X20SdqDEQ=; b=L8UprB7/oErcgVda
	zKHYwOzjome2tvY4NfHJAWGpY7G+0exIFWN2ZkVyhPP8XRDKv4KTnyNqIL8xKs0v
	nw57QFoAMxeCKT38V8Hatw3UpFmF9zTEyjDDtaGHo2pmCOnsfc8coJ2AeqD0QwrX
	XL/KzBGeTLvCR9ofY7ULvAfMOB8Q+HlMpqemaXcG7Eo511B3UdHI2aHYuOpXXEkQ
	arLY7Nj9MOxmDbINYQEVC6Q6e7E9RMoi6yBi58p+yoepOxl7pvt8Sa0JkbUTXAtY
	n7wQviY+8q/ed3m1aVUltLDbpDQIm4PL7qGf5GbxjgqkdOIcD3Ldatr6U46Z57R1
	fKgYcw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ura8y3g4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 10:47:47 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b32216a52cso2218481cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 03:47:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756982867; x=1757587667;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sLHQFn6pkMnsAa57RfPomE4K+Un5vLqC03X20SdqDEQ=;
        b=w3DgdBTomYHxLicqWJ2oWOtSfhTk7osnhjCfNOKyVLRjq7nEjN5g0uMVDSP0idZTdz
         WTqSSCutU7M3sFIUnLcyr6gZD2iZqkLCfTej63H7+cJ5J0b1jPDDe5L6i5kTxq6auabn
         hNE4svp+boNPZYKGuJcJtNkJFErfPnMje2aqVb3nwthVrTj2Jjjr77a7zexsOUSUsjdS
         PtXl0IVFS97SS9ujAy9lM/LqhPfTDguxFxZ3JWLDI1kqWSxA3uYoMZNoo6m6c3W93F+g
         1btaDUIg19sw8vFNS6hzsVlrz+WbG4tZA63tsEeCN/z9Njpr9RnRwwVjADM8vnHVxjl0
         N5yg==
X-Forwarded-Encrypted: i=1; AJvYcCV4XQx5anLdboDf7gfq+yItfl9D0RKhdDq41ZUIS+HJbyMojmBjZm8oILg2AedgOJ+k1Xkm6NMADUfVpCU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVUNUTTAkLnE0iYg/9Jf1/kgnhIq+kkHcYu6WIHHLLMDjLYS7W
	u4wb0crXJl/KHKjhsp9cxe9Aq9qzAUdtiJwjThpQp9Pi5q5hC0KnC55VTZ56JQYa1PC4VMhrZ3d
	ruzPHfSxWnC5G833eUUSDUFqanNgDEMJMXam5drGICHqVBCBAJfaFgVqg/skvPuqvzhE=
X-Gm-Gg: ASbGnct1WosM0uSz2kAK3UqO7vHo1k2Tj+ao1KD3sdUL7uhpri3qZSqe+UkU4tANzqA
	nHzm9CED5RcwQMNd370QvAca5YMnMxERStIJncyHxdRVPFZl3Te/yYnXnJA2gdusDS8RzzWx/RX
	By4AgrPShQqvzIMb6OQvt2NTvxfiQpQyDIIN135D4+iQwY82NMX9zGX35JOXZBkAKm1Unougi9e
	hbHVIfTlXvgF1kjMLrE4Fa9jeioof8RWNK31R87vDbSvsgB7TPF5RMjj0/YR8c9Da9Lie5aFicY
	S0EBSVcG2Er4rYar5aT+yKcPSzkc7KGqhOP5hkpqiThxVbdtHo1HNfFds2Z6knFWcSSdbkj3jKr
	95TmEi6exuFARgd99bNWLag==
X-Received: by 2002:a05:622a:1a04:b0:4b4:95d0:ffd3 with SMTP id d75a77b69052e-4b495d11860mr34284851cf.1.1756982866877;
        Thu, 04 Sep 2025 03:47:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXASXN0Fwg00LcigTqQaOYYWJNuiGp81igsFg+arEoNr/lKhb7mhDv0j6dJtANX8BbKakqPA==
X-Received: by 2002:a05:622a:1a04:b0:4b4:95d0:ffd3 with SMTP id d75a77b69052e-4b495d11860mr34284721cf.1.1756982866457;
        Thu, 04 Sep 2025 03:47:46 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc51e109sm14011468a12.41.2025.09.04.03.47.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 03:47:45 -0700 (PDT)
Message-ID: <bf5e7ea2-9f0f-4d83-a567-028ffbe184bf@oss.qualcomm.com>
Date: Thu, 4 Sep 2025 12:47:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] phy: qcom-qmp: qserdes-com: Add some more v8 register
 offsets
To: Abel Vesa <abel.vesa@linaro.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Wenbin Yao <wenbin.yao@oss.qualcomm.com>,
        Qiang Yu <qiang.yu@oss.qualcomm.com>
Cc: Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250904-phy-qcom-edp-add-glymur-support-v1-0-e83c6b9a145b@linaro.org>
 <20250904-phy-qcom-edp-add-glymur-support-v1-2-e83c6b9a145b@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250904-phy-qcom-edp-add-glymur-support-v1-2-e83c6b9a145b@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: o3JpUOl3ky_YzjGQfiRa5NrAQcb1SKSQ
X-Proofpoint-GUID: o3JpUOl3ky_YzjGQfiRa5NrAQcb1SKSQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyMCBTYWx0ZWRfX6/6G8audSA6l
 i7uRG5ntuAITOdXXmg2Qa9PT5LHkg5tUaprnPEMZE4PLSGP/LdHwVKL+HVCNGBzuMBBW5v37IcH
 g8pYCLd96yjX+JQJudYLiiTfx9qKrQHBgGeZR2j+wZz1tO4He9KK6iaa0ZfmG/USc6b0GE0PcVz
 QzXnJFWGh3vKPERP8tFpgaE4P3utgB7HBB2LEZIE0gVE6yvbVIgL6mpvBbCfTIHPvIL76AjZosN
 1Ru9unYuN81+LBfWsBX8f51doG18jXe02Dpowwo3BJbuQM1UfUoF7BH1k3KwXLG+elNyu5qxwMa
 WkIncKhwyS4sRlFKawquPlppE+Ex3eh93fBhr2VogbvMTzmjLBLy7vIChVqZHOd2NNmGXOHRMr5
 UvoPJM6e
X-Authority-Analysis: v=2.4 cv=VNndn8PX c=1 sm=1 tr=0 ts=68b96e53 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=0CiQ1jBnox6ZqaB-0zAA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300020

On 9/4/25 8:55 AM, Abel Vesa wrote:
> Add the missing v8 register offsets needed by the eDP/DP PHY driver.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---

+ a couple folks that I talked to about this lately

Please create a separate header for this, Glymur contains multiple
"v8"/"v8.x" PHYs that are not identical to one another (or vs ones
present on different SoCs), even if advertising that revision

It may be a partial match, but there are also stark differences

Konrad

