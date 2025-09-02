Return-Path: <linux-kernel+bounces-795711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0987B3F6D9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 596821A83DB9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 07:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574012E7198;
	Tue,  2 Sep 2025 07:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GpUoSuu7"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1147A27F01E
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 07:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756798986; cv=none; b=gGVRn08csJyEFHxMQ+TASy69G3Ph9i+cNn1rKL6B6tKoBPuG1d2lXp2A03XJneRlfjgIwUKERumhkjeQDOU4/AEtIV/2UfgtEzO58Xulrkbi/Rc/gKVHq2OEiaWRCV529oCrdguDZR/D7OTF/QPFwRSD7voz3VJZP0paeK3JjpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756798986; c=relaxed/simple;
	bh=9161Tb2vsz/ycUKyk9lbGIMLVgrJs1NhOmzvlhGTsaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eMCKPsp4pbhoS3Vqgluv0htX/cz9imyanVLoAYJ17gGt9ZUb3vqPqob0zGf2YtpZ/m4GNeBp2CXTkhXwu6j03D3LL1FHsnYCByqXgwSB+BlDDQ/Ap3DUuNrJZUBHBsUaiopx1OuKfvwjBwvpnwZB7HNd2xiAtQ0+1Ookvw7kZ48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GpUoSuu7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822RkFj016550
	for <linux-kernel@vger.kernel.org>; Tue, 2 Sep 2025 07:43:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fnjTF+IaCjsvagtTVWlYOHKpZG1AVIayRYMdSpwzC9U=; b=GpUoSuu7mKd8Hyro
	/q/p0CkBzAU7HRLqZm4RO77++CCtkoxWiTOPqKHeAPZwRkf3nfZQ/nGGN1e43L1h
	sgGacleD8tpHlRpV1c/mqbwi3QkRvMkb6DRQQtFYytniJATyn6q0ZcM70J+2X3lL
	qeWF9hXYn9z5ZzmLmhSOluSoKl+9zmiqvUqIjsI61LYJwCT56cq/cfoRkZSgLWdO
	86AMe3sbpaxf9DEP3pmAozt979kkE08scF2tWo5YrSK7cFI4k9kMid6FrhnG7pv3
	ojF007vIh5VZVmK0r8iApiz5JXbqdNVorX/Gpk3Obkhm2PVtX0GdirrZxrOlVTbv
	e6LYyA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48utk8xska-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 07:43:04 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7724688833bso2513194b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 00:43:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756798983; x=1757403783;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fnjTF+IaCjsvagtTVWlYOHKpZG1AVIayRYMdSpwzC9U=;
        b=CPTxQ0qQ0A4Y7pEgXCwOwZEdqbNA/UuDAQsEF8VcQ+zFDYL3CoS5PbWm1CB47P0QV4
         FMMc9NUYBgAkF35lHY2hPqA+3KBGea6W1ddvybey9AvX+uq10VXQ5cJyz+JJax9eHgKH
         tkYLZSLHgBmzyppXvG7xmTqopLGNe9fydfLafufqXUFYaXMIWGyqCNFYutlorl8GeF0z
         MOQcQv6o8oOeNjzm44OHBiviyL5A2x1iLQLDUASw3Btn8QUW62UepmN4cfMrJgsnnHOB
         gw09uZekvic39FBV5F0yeUKRbfSFUFog+BwZntTMm3QNhzzmExuGnHzqm5pWKd03BhCt
         CsEw==
X-Forwarded-Encrypted: i=1; AJvYcCVTTkT5XgNLkBMcMz0YfqaRgnUpiPuDx2sRRlF3q0+wqe+uhTpszsXttXtLhodEWiuYQ+1438WORv8mXtg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOiVpKyBbT2wEZVDYuIsOA4bQWMTUtFY7gZiKMAWXp575RnX/6
	bqn63CpUVT1mgav/md/wJKvP40K//mcLREYhNI1E1ioa2Yx4kjhrJvYhPikk6d70P5OMu5kokwJ
	YW/WIGgxzlBoUqsepjcr7WMXVpGo5rqRHXLyUmvbdl90lGR9nzhL2ffcALthri/uGRng=
X-Gm-Gg: ASbGnctpxyf79Ac9XzSic26xzM/L8ld6LO9s2okTi/J/0sdhvQ6G0rxNFWx+dyMMhP9
	4BB64WsGm6ngaiO81jt/3KpT1UXtPm2NsVYL4zatFwdYKsA5m62O2VBIcD5Rf8Nl0kxqEs+WO5P
	VJ7zuS869M5CVZuUYq95zu3WdFJutKPjvesKNOGTqESrn065uu6aBsive29U8FCPjt5HoMNIri4
	88fN922FjJ8X6OoDQI/ZS0kTQemTlsn4pBbL/juYzGecWQwVaEomMwwe9ff2YPGJX03lBRBYrPx
	SdARX/JJyUOEBU5g6W7pDo+XRN55h0HjgcoXusKtmkvmIqZYl//dyVgucbQMAEYO/FusqwneyUS
	iM72Fqvh2adwvNjpDVOxlyhNfj3gvCQ==
X-Received: by 2002:a05:6a00:92a0:b0:771:fc48:7c1a with SMTP id d2e1a72fcca58-7723e396d7cmr13352188b3a.27.1756798983196;
        Tue, 02 Sep 2025 00:43:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0cW22l8sm4wVKSWuN7QJXzlTLBwumx+hGhHMDLGo3x0YH0EYLjibSDkyAAzWcl6azzB/umQ==
X-Received: by 2002:a05:6a00:92a0:b0:771:fc48:7c1a with SMTP id d2e1a72fcca58-7723e396d7cmr13352160b3a.27.1756798982704;
        Tue, 02 Sep 2025 00:43:02 -0700 (PDT)
Received: from [10.133.33.25] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7725d5b90fasm4602173b3a.100.2025.09.02.00.42.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 00:43:02 -0700 (PDT)
Message-ID: <e59fca7a-4145-4aab-80a5-8305f935e8d4@oss.qualcomm.com>
Date: Tue, 2 Sep 2025 15:42:55 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 2/6] dt-bindings: display/msm: dp-controller: document
 QCS8300 compatible
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250901-qcs8300_mdss-v10-0-87cab7e48479@oss.qualcomm.com>
 <20250901-qcs8300_mdss-v10-2-87cab7e48479@oss.qualcomm.com>
 <20250902-speedy-overjoyed-dove-edf2ee@kuoka>
 <fe2867dd-50a6-42d8-92b0-0e29fa7691ee@kernel.org>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <fe2867dd-50a6-42d8-92b0-0e29fa7691ee@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: fzPOoNMHhWAMQVAC0V2rA7aK4hUTLVOg
X-Proofpoint-ORIG-GUID: fzPOoNMHhWAMQVAC0V2rA7aK4hUTLVOg
X-Authority-Analysis: v=2.4 cv=ccnSrmDM c=1 sm=1 tr=0 ts=68b6a008 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=MLVnLUUmlBKzLzVVyHoA:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDA0MiBTYWx0ZWRfX8oTWXpROg6lI
 UTs+23ATPX+WsnMYxgqNwImHeDS0h9zLG/77x6hxujhDtSgkJhc3TZx2AP2q1qiXksPgNFH4/ZD
 VtbWZo1ZFgK1SvTM7ik6qO3miAkJSsJSV0Pd/KNvBtXZYDkoRkJheGIECbAD/c+p76BVqmyWkFq
 5RZMOjaTI2MPx7Fe5KzC5IbXHy4kfevjryXijgAgzHjrrr68vEsw0jcyP2+/89hJC6Atjy3TXbl
 tnswTK35K7/fSGKZldEgr6kUHcH9RoXnmel8Q7PbewwSFtXt7ceufqlGzOeVIsdaw95pSVWE5T5
 VsWTFlWt0Uu37fsej0NmLfeCsKcEX5vKg22bnnBNPmBSd99Q5VgBwHPLNA7vtdyYY4/7/hWCR0E
 ZfU/OxNJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_02,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300042



On 9/2/2025 2:41 PM, Krzysztof Kozlowski wrote:
> On 02/09/2025 08:38, Krzysztof Kozlowski wrote:
>> On Mon, Sep 01, 2025 at 05:57:30PM +0800, Yongxing Mou wrote:
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            enum:
>>> +              # QCS8300 only has one DP controller that supports 4
>>> +              # streams MST.
>>> +              - qcom,qcs8300-dp
>>> +    then:
>>> +      properties:
>>> +        reg:
>>> +          minItems: 9
>>> +          maxItems: 9
>>> +        clocks:
>>> +          minItems: 8
>>> +          maxItems: 8
>>
>> Clocks have only five items, reg has 5. At least in my next from few
>> days ago.
>>
>> Nothing explains any patchset dependencies, so this makes reviewing more
>> difficult than it should be.
> OK, I found the dependency in cover letter (I was looking at wrong cover
> letter), but the dependency does not have relevant clock changes, so
> this is still wrong.
> 
Hi, 
https://lore.kernel.org/all/20250829-dp_mst_bindings-v7-7-2b268a43917b@oss.qualcomm.com/ 
dp-controller.yaml descriptions for regs and clks have been added. 
Compare with SA8775P, QCS8300 don't have DP1 controller which supports 2 
streams MST, so its minItems and maxItems clocks is 8. > I suggest to 
slow down with this patchset. It's v10 already with
> simultaneous other changes and two (!!!) dependencies.
> Sorry for that, will wait until the dependencies become stable before 
updating the patch.> I don't know how I am supposed to review this.
> 
> Best regards,
> Krzysztof


