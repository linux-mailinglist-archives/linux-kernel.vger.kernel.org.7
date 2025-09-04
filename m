Return-Path: <linux-kernel+bounces-801142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 970F6B4404D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A307189D425
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CBD23DE;
	Thu,  4 Sep 2025 15:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ErqVU/O2"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38D81F3FDC
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 15:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756999095; cv=none; b=euFztH6ata1kxF+QhD6PzvukLPytXh3WvllEbQj+oVo++yt6pREXVvQ/8knb80KU4nh0LejeDG6HMDvf3h5KAuussRskXQF4ULqp1epf0kKn3trQ3bNgVLg4hjyJlOOCFs7GnmaIjUpvbRf2eP6akInQEA31v58EnacQegkdkEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756999095; c=relaxed/simple;
	bh=SUVu9jUw+uVnd3+t8fJ6j+XRs/vEdFhHWmcDtBLhs94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E2V+P9ssDso4xBZyId048+El+lgGq3LQGXib8WhnlL1+WBaYg0TlGKMtcK8ruepWerIwB4qOjTrOdqQ9gltqIUqlYfwPD0JrNh7rpteuGJVuQwAOdBTOml2Xq+AWhHzW6EZzCa3OKhoFDvKRmb4LiJRhZ+KLm1Z6ApXsDEkcgQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ErqVU/O2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5849X68k013944
	for <linux-kernel@vger.kernel.org>; Thu, 4 Sep 2025 15:18:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	U3ag2rCKadxvADtnF0lA84YiUUgGOpF/6W/RI0t67UU=; b=ErqVU/O2w7Aa7wpO
	0KrwlxDKAoSR+Gx0OlPo3uUYE8ed4eYx4Wim5Oyrs/ucuYVjmXuaDrCJh0NOC4Kw
	3I4oHcZbZpsL0Sh5JS9Bpjt2CWRRJPbJqnrfJff/5Eo6lKH06ln7mX6fQJAGRQOh
	h4gYMsqVzWGv1KqC4xvYb7AwnnoI0fRPjDVD2m9JrT4NHSUCVOyOTmlW/X79bnJm
	5QyfYLnvGuSjIkO+iStYl/Kvs17byD2cjB/z6OpPsFkp74Tf79tq3eel8EjUtlay
	DQ1FMP46PrUvipNzQkpHuKb/T3d/zK5dUGw45yC5hzUhp+SaSSeAavWh8L14Gakv
	okXhwA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uscv832t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 15:18:12 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b32dfb5c6fso3877811cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 08:18:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756999092; x=1757603892;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U3ag2rCKadxvADtnF0lA84YiUUgGOpF/6W/RI0t67UU=;
        b=Jle8mOa92k3lCKzNWrsCL7zP1+Ewjw3A5U1Fzh3fUQkb32n3O/GtE9u9wQaEKEtuZU
         c1x+lEDLmxQG4xrDg4kYtGevaxfJgev1R3s2AqM8WAv7ssna9E1ytUwOBg1qrJ2RbUqi
         HJ5ZUuI0OVxPC0LaT5sfethrF8o7o80+AyKb9Ep61oSPjcCv3nxrT1Ci/Zi+U5bS+c3V
         5BAMfH900QMqQ0zzt3WCH5Anbj+17AIBNVBjeqYBqd7K5fPgMEFO55NslKAJvnbEnX0o
         bEK37sbQirOIx2y8KL8De23eR/dAxyFwWwiSMAqEooCPMYksiLgaEalHjxvNwqZ47WW6
         bP1w==
X-Forwarded-Encrypted: i=1; AJvYcCUNOquEpLwGxDWYuQSsh1P9TaYZ/trGT3RzRzlO9Q9KN+nn+teH/cZBWPBXvJXrtyb26Ur3xbwYjO2qORE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+mD5LUvCLzQoKaiR/f4e+hW7gcpS4Gy7Qyi6dmFCB3v1KWE6y
	qpX1xYxwTFeVm9p6KHnfFjoK9XFhg0cbD6yqk8CEtJOor4Aqs7bw0cIUY6p619qIZOpY0o3teM5
	xLFtUybe6jjX6xeBH7/GglVnENG8SOk/+PskLeVugt//502skmMX8LNaJDoZXCXIRqtQ=
X-Gm-Gg: ASbGncup648nAFvPl4ya8VzaOmhNYBURsn9kMSBtSO9I27voqdsskteex+5RNg+YxN4
	N29c4xYIrVv9mHRsooo8z5ZDtckZs+PI4mrGtcwgz7Y/4d7HXSHteM5kQEhTYQ+2ySc2aHPd4Yl
	1/hUiLwHt75Xcd7yE1BRwCl7IA/cPYXT/Cuk8IWv+jk9c6kSBAZ5odaaGrpWHDrS4oansXKEQrK
	7omXlbkuMnop82DMV/T075+/Q1WoEXhcANFpIWolU22ansHHSQ40LN2+cQ5P58P+e7MgUg24Ufi
	ornfCWB84ezPqzFwprz+QsQbFZF0hSzV0oHFiMbaZGU1mrGHrfbBpJcBzDCdc5Ya49U1uh9ABci
	cTmFHR0NZqSZbXmHa5LDpTw==
X-Received: by 2002:a05:622a:11c3:b0:4b4:946a:df22 with SMTP id d75a77b69052e-4b4946ae541mr50630291cf.9.1756999091626;
        Thu, 04 Sep 2025 08:18:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFT8mTyEJ4P6ECcG4IXEz9vD6IAMkUJ1fj2kQAU8IKBPOb8CPmz+XFCtvntqqARuhsoEFnLhg==
X-Received: by 2002:a05:622a:11c3:b0:4b4:946a:df22 with SMTP id d75a77b69052e-4b4946ae541mr50629731cf.9.1756999090951;
        Thu, 04 Sep 2025 08:18:10 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aff0971379esm1517527966b.102.2025.09.04.08.18.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 08:18:10 -0700 (PDT)
Message-ID: <db5220ad-6153-4f04-89be-5d74838151b1@oss.qualcomm.com>
Date: Thu, 4 Sep 2025 17:18:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/6] dt-bindings: phy: qcom,sc8280xp-qmp-usb43dp:
 Reference usb-switch.yaml to allow mode-switch
To: Rob Herring <robh@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
References: <20250807-topic-4ln_dp_respin-v4-0-43272d6eca92@oss.qualcomm.com>
 <20250807-topic-4ln_dp_respin-v4-1-43272d6eca92@oss.qualcomm.com>
 <20250822212043.GA475528-robh@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250822212043.GA475528-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMSBTYWx0ZWRfXxLk3flAHpOHK
 21KOO8GOH7Jn5WsTojnzbRboGfCICcQpWAScEhrfmoEDXyQL74d7Er/NEX1089hGKtwu9qJ2pFe
 el1TBkDG8dCe6lAdziFTyEJMckrUPuWuKkjwHlRf0+3lwyXqV2IV9rykMNYa2Hp07PlxOF9jAnv
 FDrbBtN1w7rELx0K00OVZYVvrY3Xq0PDdG7wQ+N/GJ/qeDoWT0HK6FoAkFNi6eEEaTAnktJ56AQ
 39SJRVLl3k3paB8sFe6ept63uwOk4YP8tUBCRStkCBw0n3HYdFKhD4mJQO70lnhEOkaZO7cV94p
 J1FCNztM5vwF7TC0rQvvdU/Oib2U1W1gBqxJuGb+Eu9A+GYYZ70/grjFj6og34H1/xq+NsFG4WA
 YAmgbu7b
X-Authority-Analysis: v=2.4 cv=A8xsP7WG c=1 sm=1 tr=0 ts=68b9adb4 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=uu3TWbf2t8eLHAi7i90A:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: p9t62VyfMc-A4WoUaFkMcnhDkdbjSYzf
X-Proofpoint-GUID: p9t62VyfMc-A4WoUaFkMcnhDkdbjSYzf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_05,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300031

On 8/22/25 11:20 PM, Rob Herring wrote:
> On Thu, Aug 07, 2025 at 06:33:19PM +0200, Konrad Dybcio wrote:
>> From: Neil Armstrong <neil.armstrong@linaro.org>
>>
>> The QMP USB3/DP Combo PHY can work in 3 modes:
>> - DisplayPort Only
>> - USB3 Only
>> - USB3 + DisplayPort Combo mode
>>
>> In order to switch between those modes, the PHY needs to receive
>> Type-C events, allow marking to the phy with the mode-switch
>> property in order to allow the PHY to Type-C events.
>>
>> Reference usb-switch.yaml as a simpler way to allow the mode-switch
>> property instead of duplicating the property definition.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>> ---
>>  .../devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml     | 7 +++----
>>  1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
>> index 38ce04c35d945d0d8d319191c241920810ee9005..c8bc512df08b5694c8599f475de78679a4438449 100644
>> --- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
>> +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
>> @@ -73,10 +73,8 @@ properties:
>>      description:
>>        See include/dt-bindings/phy/phy-qcom-qmp.h
>>  
>> -  orientation-switch:
>> -    description:
>> -      Flag the PHY as possible handler of USB Type-C orientation switching
>> -    type: boolean
>> +  mode-switch: true
>> +  orientation-switch: true
>>  
>>    ports:
>>      $ref: /schemas/graph.yaml#/properties/ports
>> @@ -106,6 +104,7 @@ required:
>>    - "#phy-cells"
>>  
>>  allOf:
>> +  - $ref: /schemas/usb/usb-switch.yaml#
> 
> As reported already in this thread, this adds a crap load of warnings as 
> it makes ports or port required. Sigh. Can QCom folks pay more attention 
> to this please. Every cycle the number goes up though that's often 
> temporary because there's no coordination of taking .dts files after 
> bindings. But generally, progress on QCom warnings has stalled.
> 
> Here's the top (bottom?) platforms in arm64. The first number is 
> total warnings. The 2nd number is unique warnings (to remove inflated 
> numbers due to lots of boards per SoC).

I'm sorry this happened, Rob.

I assumed this was a solved problem as I picked up this series, but
of course not testing always ends up biting..

Konrad

