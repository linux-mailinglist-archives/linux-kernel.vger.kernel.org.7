Return-Path: <linux-kernel+bounces-745488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 821D2B11AA6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 11:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FF743B1702
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 09:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20AE227585F;
	Fri, 25 Jul 2025 09:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ild5GXSh"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B506D274B3C
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 09:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753434830; cv=none; b=qhhqA8ZSRZOgFCNkLhqmvFVhH9rFHBVlyqpu5Hxj7zS8V+1II86EYa39XZIZYk7Jk4TW3AXstgdOLo3g7Bbe4GB0tQJBpdoldyRFcV1+kjbv07sDOAahOvsPTPqciBRSeZo5IPU004KG6qM1ifuNHxrMP3rm+UAsfYox0km3i0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753434830; c=relaxed/simple;
	bh=PaBfkP9n62fPauaryWWVRFcxPJrOXO55ZQmLOGK6kpA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SMNd+tT+Aq+u7+7aoebfMa0fowzWDkRIcRfa9HwPzWzSG2rphpMcXm1b+ZyxK39/A1MM7HzLndXbM9xJBN3s2P3ZMR0afMuCdDK8Qe6gWk7zCIgXI69j0aa1boeNwnX673tCork2b1eAcwO5Szi7KBlsQiDEWDEYopBcqQryZak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ild5GXSh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56P88opf008752
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 09:13:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bEV4DPbLykBJZVuPLhGCPh0I2ttNyDmYPVal2jJWRtc=; b=Ild5GXShfumqR5rM
	uStP62mpxylPBAdooPdL9Oz363aKSsFJOVXe7xs8qPBaDau+3rUeKABmKCdWSvAU
	hiciaj+hPTTjnA3GoyvkriGQ3Vw+DWi9ZjWebGIQYqfXqJ5/hzI7K9T0NOdFHoay
	MBJ4iQrtdBztmcd2OlTqt7lE9jUs21kCZS7cZ/pS3SGok66vYxdyGzcJHcuRVPpD
	wWksrLjhvmWg51Jk2MBydfKF74sWO64uX0/4hzpsZCGug5vo0jfvN70NUmuH+RKK
	Rbm1zddVbiDKvsHUFNitCpwoKD4Hx+hHcTSmEeCfOlSgxkMP78zB+VXIJudIIsZx
	r/eaeg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48465905u1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 09:13:47 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ab3bd0f8d5so1394031cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 02:13:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753434826; x=1754039626;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bEV4DPbLykBJZVuPLhGCPh0I2ttNyDmYPVal2jJWRtc=;
        b=RyGHl/pIVmcoCOSWmVb8626NVpTUcAlmCqBn12PPtdkbVeQhoSQ8ISXeyGrr5051C1
         UdeKfax1lDBkE4MGLEeGur3BwuzwU/5L8YzIdQvKynZNK153AhGbxprmtfKd8qoZaBBv
         ex1aixilgO1QDpGOiDMNhmhvi5gxPvcsX8zagpfPzP+MO9x4wg3Vr9d6FoO4GEqOaFcl
         PejBgmZDMbPWFxIv5t3nBELX8TftuRW1fwgZNPTBANdEWtlPLBzZPXRPSi8BQ5tDJpWQ
         50qksGEWZmBgwHwsSb1SnFAJwU88QAPFV21wdtnc+/enA5j40NmcNqD/UaQSOlntPj/T
         RZJQ==
X-Forwarded-Encrypted: i=1; AJvYcCV06Wyl2MgR4J64aoNxYjZcx0hGPw8DUcopGUJUMDA5WU4MhscrtFVAv18njIs07vY+T/fySMWFjX3jc/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpmZX+gFJW60xNSHOaeP5UB9hBYEJCZl7vCqO2ZXjp1C8+WbF+
	rPWrMImgTk53llRSjSqTkI7JCam7uGJG2WSEeI/h+/2J7P+AKER8VegWFOLge3p4RJyBAO0G8Sz
	abpvzrEHfXcnQsERWeVpUtSeT/TB5bUMTdlRqEnPcrY/wNGjV7DGLJbHwEbdEarCy6VrFV06Nxd
	s=
X-Gm-Gg: ASbGncvtimIJ8i7tgf9FlXH/gcA1k72mJDnr1746H8koXPZjVdi0ITwCixm/qYkeZxc
	9kepEgUj4lcDnU3m0y8zMj3W/sIQvwhWenis9A5Xkwk6OHCUxJ06CpmxTEhap0LA1LQdk++yx0N
	sML/r8IvAZaJxYP+KULBSKrlIc62nT+S67z+iWJzrBTTyBvvLVjK+FvHy8XGy5+ZxyonoptHCd+
	/ojGBK1a/3hp3kx52nXOCmsY5q6DX1zhksRuIn1hwMLFM5E5ZA1nxmyD69P3mQ+y7XmQh7RMsPZ
	n/5a3MieAb3qd0jxvGEUCzmZzIV1RQ2+BH/MM+/gpo9ZRQHDkhJCiYn6fIpEIF+u8uDO5lEwMKq
	NKnVMnYGDmp6zrrWuug==
X-Received: by 2002:a05:620a:d87:b0:7e6:23df:a465 with SMTP id af79cd13be357-7e63be3ddecmr57812685a.2.1753434826308;
        Fri, 25 Jul 2025 02:13:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEExgv8ZCapXOzq8o1kxrwx1MV3NNUzeObfI4hzLnJrsbPQ9KAQEat9qeWt5LdoLPLNJ5W3vA==
X-Received: by 2002:a05:620a:d87:b0:7e6:23df:a465 with SMTP id af79cd13be357-7e63be3ddecmr57810685a.2.1753434825949;
        Fri, 25 Jul 2025 02:13:45 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-614cd3191b3sm1846833a12.46.2025.07.25.02.13.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 02:13:44 -0700 (PDT)
Message-ID: <510b1761-7eb2-4215-8910-67dc1676ecb0@oss.qualcomm.com>
Date: Fri, 25 Jul 2025 11:13:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] dt-bindings: arm: qcom: Document HAMOA-IOT-EVK
 board
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Yijie Yang <yijie.yang@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250724-hamoa_initial-v2-0-91b00c882d11@oss.qualcomm.com>
 <20250724-hamoa_initial-v2-1-91b00c882d11@oss.qualcomm.com>
 <d49d2755-2967-4bb9-b789-8be5f138d4cd@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <d49d2755-2967-4bb9-b789-8be5f138d4cd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 1f4teBzTnpd58CAtVTZFWzYJEr1zIbRZ
X-Proofpoint-GUID: 1f4teBzTnpd58CAtVTZFWzYJEr1zIbRZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDA3OCBTYWx0ZWRfX/xfh7/VOe1Zl
 8kFNeueeExeP95oIYRaw85YpNRnq1SZmQoWDwIIMz/E1yviGJGYf0PKexGBtaiUpHobYPHzfeyU
 srVSAKtIQraaZuU4eUYjVk1HeEKl040KniY4KH9C+rC8ROyMBiOyEYp5Y+4ZPnxO/P+C9hiRC5Q
 ifQzJODoc0ja1TSdnSxx1n0H7OKMvezIDXE+vOou4p8++daJYdlko8KNTqr6WtMbMXx7ZEPXkYF
 gIIdK6n05VoRyOd6NcdWcCsBXqOLOaA+EKOpmRRXZwB3/6ueV2EvD6LIAc2vBBWIUQNJktxdAjG
 btZTTj/cdvXxw/wuq9M65osqJBiY7wHf5XMNEgMIRqte1VbKkyV66E+HbJsf9mFJOfbnSUw4xle
 njyGBr3fFKzsCYj3PuuRyUtG1Rll4d9fFyNrLMXBA+8heivkCWfjCoewy+fUT4kli2QiC7YS
X-Authority-Analysis: v=2.4 cv=Vo8jA/2n c=1 sm=1 tr=0 ts=68834acb cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=YlCazyIblZRc-Zwj5O0A:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=952 adultscore=0 impostorscore=0 suspectscore=0
 phishscore=0 spamscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507250078

On 7/25/25 8:55 AM, Krzysztof Kozlowski wrote:
> On 24/07/2025 10:15, Yijie Yang wrote:
>> Document the device tree binding for a new board named "EVK" based on
>> the Qualcomm Hamoa-IoT platform.
> 
> What is hamoa-iot?

Marketing

> 
> Later patches claim this is a SoM, so explain here why you are not
> expecting it to be used outside of EVK (not following standard SoM rules
> like every other vendor)?

The SoM is unsurprisingly called... hamoa-iot-som.
EVK is the reference carrier board. The expectation is that more boards
will be added in the future, as the SoM is adopted by third parties.

Konrad

