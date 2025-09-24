Return-Path: <linux-kernel+bounces-830312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DFCB9960F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89943188FFEE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0992D97AC;
	Wed, 24 Sep 2025 10:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Oj9XbcHs"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001E32D837E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758708728; cv=none; b=aANZchJVrDh+Ay6+MBo2p+nep+3vat0dgxv3CMY8hEjgRCGEFn0+SYAC1eYlbRTXbBOuBmdKcIi/n+sH/n9+Dd2l8ijE1cXxhgPC4mV4hgb1+E28wDyNsFw22pShL2c8yuKJbdgDBLTSMa1rbuEHkFSXWl/UNoZKdq57UIeeayA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758708728; c=relaxed/simple;
	bh=qU3G9BG9Ykv/RlUpW2K/aLKHDcUwgzfvCeYGnXNLkys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OXMQq/hgqDkqipgLCvMIX1+Vz9hX/TxWlIz+cnYdJoke0EHPAWAlAWgAsCHOgoJDhDnh2jQfp06DxVdEK7E97q4QnC230yTdjQ2Zt70cN6SWJUJlmw6+vIhvEVilNPoolhwKB+3omzN4qD8MLZP2wlmk/Ji4RiyjsWzj9lR3Vrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Oj9XbcHs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58O4iASl001992
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:12:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6VZxHPqDQuqyBxgI6CajONyRR77vQ7LuPtAXIHSAkHk=; b=Oj9XbcHsNZzCkTSm
	A+AnA2k4LPLPka2usQObFJPXFUfDkMrvrkSVkaATSJBOCgs/7tovWGnR9yEDnXfG
	TBWPkXmp6+9FCPpCReGZ5BQLwmwoJo2fjMNEpPeNJuou/kLnL+JqXQ8kgNEhdz1J
	xlYmR7EAH52RzQAFdsVIOhlJXYEg2aW4c73QoavQtnvTz8nnOzxlYE+SrX8lYakG
	V08ZYp8C+/GqZLq7BP41J0GtK3bp1LXr+021ZWXtpBSrYCAfMgyi6aJ62S1ylrwi
	P+7NlBCr5eVRPnxr2t9Vj/T1Gc6YsozabefmWyUxIh1T6RisElZHSLQlVzbVZPp3
	wX2aVQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499k98kwf3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:12:01 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-7f5798303b3so896666d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 03:12:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758708721; x=1759313521;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6VZxHPqDQuqyBxgI6CajONyRR77vQ7LuPtAXIHSAkHk=;
        b=CAU3k60uKweSwkdSckXyNz2nAVlkpgoa/fNEZnJPF+u6QZi61ZsJaD+Sb9NscAJFaZ
         R0e14melx++75E+o6Ej3hYk+paUoYYQXVmQw0rCog9sPmNLCe5/zfb5JPPc87PIyIoW/
         uSn0Avn4HsbEYaV8R6JoK9rSg2Ly7OS2Y1ZXMCeF8QOwGpcsjjuslFrYLJoUtMLkDQYh
         iogAOUnvD6XR10ifFm3ir0xktWoy+cu33aojAUXMGds0K+FWpimX5ghI4LmQTSQOeqC/
         KXShAYeF6GveZoq0FaI+nvJGxo0P6A5+wmRSap48bY4kDeprS9bAUVs+tPyJ9QU/7Gqw
         T6Rw==
X-Forwarded-Encrypted: i=1; AJvYcCXY3Ii7yiIa4VcZ6ZKcQ86H1A/O+bTsMotPYwm5IaKi6u5nhVidN1kAikOug3BUGxDHkXeR0kzy8SEWdoo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/pkrGPHWAyxLK8ZjWD1iME7fcTLnocW/W6+FXtGyVZ4HYEUjS
	Cdib1HYb+cMXvksZBayvQujVLb4MfZ9i+4DfjPq/UqqCn6c7VetBTx8rTlOUaQh11W0mHNP1M5v
	oqOg4ykCg05nF7bUdsXjr0V57pDHbZgWKDJev9QaVE1TiepZ8Zw6rvwOpzN65ZNXtkC4=
X-Gm-Gg: ASbGnctx2UN67VZhFQi2jd60/qg8VbQ6mYdOPntJlS5KyDgfCRGLJ2qBp25IN2+/TjV
	sxKFFaXBMz1b8dncQwi8x8TIEWnUVDnUyKPXROaNGAXvUKmmzJ4vmr1buWFhukPKtJr7513KIuT
	W+uiSVdGRK+6wlWUIPh65XDeLVDJkcYlm9UslDwCmgLcFClCH7/8hxSD9idtId/qTXFJqXKblo0
	0bQKMXTEJxJINvOE/FDWma6eDiEhXWIvLC3fG2kKI0PmAKcMsd18r66TtlF9Ibhd5iLWBwbiuai
	3iF/42SCmC7QPpKqs5vyN4TYyL3ahM0Kd+KBNdmYLlyy3bj1v6upWoMoLLCjl84REGohyZQ8vgT
	1pooguH9qN4rWOl8JFfIf8g==
X-Received: by 2002:a05:6214:629:b0:798:f061:66bb with SMTP id 6a1803df08f44-7e6fff99518mr47394226d6.1.1758708720687;
        Wed, 24 Sep 2025 03:12:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPa5t9eCVyUNXMj7BXSIPr97UVSHRGddnfRS8EgwDZlymFI65Y8wlIZIkRwrav1CKAZYeiJw==
X-Received: by 2002:a05:6214:629:b0:798:f061:66bb with SMTP id 6a1803df08f44-7e6fff99518mr47394106d6.1.1758708720234;
        Wed, 24 Sep 2025 03:12:00 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62faab2b84dsm12172731a12.37.2025.09.24.03.11.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 03:11:59 -0700 (PDT)
Message-ID: <87dee3d8-1532-4ba7-94ef-737a90c2c469@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 12:11:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] arm64: dts: qcom: rename dtsi files for sm6150,
 x1e80100 and qcs8300
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Luca Weiss <luca.weiss@fairphone.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250923-rename-dts-v1-0-21888b68c781@oss.qualcomm.com>
 <DD075WC7A6KR.NJJA1Q4WAJUZ@fairphone.com>
 <7o2n3wcjlb3ltbqndehfntqvsdpnn633pk4rlfq3h7fz2ygaus@na326qso5rs4>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <7o2n3wcjlb3ltbqndehfntqvsdpnn633pk4rlfq3h7fz2ygaus@na326qso5rs4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: vv-5MLDeYTvtIUUQKiJFqs-IM2qUvink
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxOCBTYWx0ZWRfX5STySFlNMjNU
 Mm9YPdE2vAdzSxbib9WmEAhB5T6pAz8F1Hwhh8g6aUcnVnX1JSHb77WrUnTGJMSR6YCBuzBBeH8
 PpbHhZEsoMwEt2STJjrKnLqrbjU9dHEQmKFkUTa6y9n7Gnxwv+TeRHaE2TltF2l+tDtPGyUpK/a
 Q6dBasD4p2yz0+jhTMBz888CPodDLuObpikl0PzTKknNVXfFsWnfvtM6kYJGvC8LazrSBXEaDND
 yVJGLiBnOQtJ4Y6/18qQv8iAHuXA6NW3hpjtfbMRhCg+mMS4CLorfOeYB4cIjcO38QzNw5CAh4c
 SOI6EpcF/s0x8sFZECE762+s5aBVNsukVwbx8r73ADD7gMlI8Ym2RFQM5zxeIlvJZB3pyscXyD2
 dcNx76Uh
X-Proofpoint-ORIG-GUID: vv-5MLDeYTvtIUUQKiJFqs-IM2qUvink
X-Authority-Analysis: v=2.4 cv=Dp1W+H/+ c=1 sm=1 tr=0 ts=68d3c3f1 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=spyb8OjkCO_OKQTeHmkA:9
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_02,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200018

On 9/23/25 5:17 PM, Dmitry Baryshkov wrote:
> On Tue, Sep 23, 2025 at 03:00:19PM +0200, Luca Weiss wrote:
>> On Tue Sep 23, 2025 at 1:01 PM CEST, Dmitry Baryshkov wrote:
>>> Bjorn said to me that he disliked the conseqeuences of renaming
>>> qcs615.dtsi to sm6150.dtsi. Let's increase entropy even more and rename
>>> even more base DTSI files.
>>>
>>> Leaving jokes aside. It's not uncommon to see different names for the
>>> same SoC (or almost same SoC, with no visible differences from the Linux
>>> side). The platform now known as 'lemans' is a good example, because it
>>> had been using SA8775P, QCS9100 and QCS9075 in different contexts for
>>> slightly different modifications. QCS8300 / QCS8275 is another example.
>>> All such names cause a lot of confusion when somebody tries to follow
>>> the actual SoC used by the platform.
>>>
>>> For 'lemans' after a lot of trial, error, Naks and reviews we've settled
>>> upon having 'lemans.dtsi', the core DT file for the platform and then
>>> naming individual DT files following the marketing name for the platform
>>> or for the SoC.
>>>
>>> Apply the same approach to several other platforms, renaming the base
>>> DTSI and keeping the DT names as is.
>>
>> If we're doing this already, sc7280 -> kodiak? That also covers sc7280,
>> qc{m,s}6490 & 5430 and sm7325.
> 
> And few other platform names with multiple SoC names per platform.
> 
>>
>> Also, does this mean that milos-based Fairphone 6 the dtsi should be
>> milos.dtsi while dts should be sm7635-fairphone-fp6? The latest patch
>> series uses milos-fairphone-fp6.dts.
> 
> I'd leave this to Bjorn's discretion.

I think this only makes sense if milos-nos-sm7635-fairphone-fp6 has
physical differences that stem from the SKU being equipped with a
differently capable SoC (which remains mostly software compatible
otherwise)

Konrad

