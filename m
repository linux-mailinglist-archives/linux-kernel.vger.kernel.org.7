Return-Path: <linux-kernel+bounces-725714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A26B002D6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 15:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ED8B1C43D26
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 13:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18CE427F749;
	Thu, 10 Jul 2025 13:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="alep1I3v"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26ED62580D1
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 13:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752152591; cv=none; b=ezcK9WfkiToL5yb/qU599z98N4kh/3/hLgO0G0YdlN3h9eDgx67JohsinTrvlXaCRPI4ZXY8wFTqc8/rcG3WrWhUDwxlKYYALeoHeZn+UXIbS66RL/R1Ib/5Xu8TVLUrZgpDI3e/wPsZ42oL6w9WXMTDksHMvWWvVyxk4MJV4Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752152591; c=relaxed/simple;
	bh=pUgs9tQcuNvknJfrc6tNawtLAtGlb9im+k1KY/2C5hA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DRzWjy5bqWJnjpyc31/5aMQu4pCHvdtFvemlANgJlaOlaDKjMpX4jB/3POGAuau6XR1KQBsQRokHgH/2BhldHVOyjp2bwcTjRGJq0zE6/ZNY6oD10rqfCKEFjeZjtOc/zG2S1jbdOL0fMwZOPDLNcAri8Nbv/BuJD3fvY+o7y1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=alep1I3v; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A9FVUJ014434
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 13:03:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hjPwmWtX19e7Bo1S75MfSpFjXxGklGbexlJ7/+bDJY4=; b=alep1I3vOjfaKaFm
	5MNv3K+zxXZUZR2mbZ2Ez74LNGCaxJ1y3Bk+oEEqeQ3OdJhp7Sah/uAgiuRqS1du
	D3Ryj9ceUHTZ2iNRRfM4yXPqqqIIYETEclBFVlExAEFSdQrHmkCKf2xQT8Cax7LV
	JLF2O+ecc8ZbazDx07n7U+DTdOUNslUoSJNjmHMYIsoea77OsRaCsrHHkH1u8T2Y
	7cfgsX3gW8LZ/sNZGAvEU1IMDy/bmLbGLFeUP2DYnNM8L8pISv4cBK/4k/R3sJYy
	JDy8f6F6rMLgLbO1w8jhJf1h+Kn1yAD6gvfsIxjclAWeYHO/X7vOgK+eWHdRLwp7
	baDLcg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47r9b15y0p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 13:03:09 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7d3ea727700so15085985a.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 06:03:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752152588; x=1752757388;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hjPwmWtX19e7Bo1S75MfSpFjXxGklGbexlJ7/+bDJY4=;
        b=eBbou7A0h7dOUg0ajxeZyBWol+Sn1mpWa99c1QOc2v58wBpCIKQ0j6d/OQQ6HZuxyK
         EHvtIiDfalL3RJd1u65E4mj3Wdoda/ExYMNxBRupw3D8lUwX2V9h1P24jEp2oRURouH+
         s5uZ18SYSerOY+UDkKf8+cWX7fVbRIkyxHuygOIdqB8k0lx59R/ID0tBGcevSFVu8LuL
         qVe+0/WmsLS5/glrciPJkkjg8wPgJNXboEToF4BJ8OIHzQ8cIPdz1Z47XOUq0ED79isZ
         Utk7wzQRLEkKBQ5yWU37zOXz4TGftyQH0tgPzUCpvBLtKobC+I9lTXhtfbCA3pzwrviH
         YPGw==
X-Forwarded-Encrypted: i=1; AJvYcCXFHS7UxnhS3GYYUnDslKZk4egOKtwC9r9OgrtRZBOpjFrHc6hiZKs38o7U9LzrMUBUcEgCjiJpRSLtRCc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+Ob0FQBR7kZQdlid6CJSHXASZzU9EP1A+OaymTs0kBOYimT2R
	ufbR2Dz7kHl5E8S/eqhfp/w9i5mKBce4S+s08F4vkl632PWfco6GXG4kM6qmRAuxFAhS6HTbOFd
	qFPbAiFuZtEOe/6NU+rQOZhAjEnailb1rHTPgdayOQDmZ4sHxEhDXoHXbd0WgC7CZ0RA=
X-Gm-Gg: ASbGnculicrrO+uTxbN+bUNGoYXysEvONK+OMq3pfT8f4VlHAbrXUpjSx0mWNKQquzZ
	8NnogLlo8pRHr2XVLpcL/TR3odeV3QsbqTS7L70akWr23eTITUW46x/EjOuoxKfa/A55qKBH1Hl
	zZZN+/g3EZULwkIksRAESQb5u6+7LSsXy8Qc6rlrZn7aAkSHlRE8jpu9XR6myBE4uqDdlNlJnHC
	k3BBV/iiom/lF/lcjKVLPsZ9XuXnid+2gPF5tiprkpFC7qhfn2shxrsAxNCFuEY4T+jDSSECzP/
	cfrl9/EPq/smcKqPsGaGhCtnSArrVj0uck3Di7FlwtTLs6rdzvtBPDtDw7nMjczche2x4HHwv2e
	o2Qk=
X-Received: by 2002:a05:620a:2810:b0:7c0:b43c:b36c with SMTP id af79cd13be357-7db883e1940mr326979185a.6.1752152587554;
        Thu, 10 Jul 2025 06:03:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6exVhBWalN3mEVmzHEm6fjFFCRoIo9z9jPpENbHQBbPTFSkUeK870F8+4Pggl1oRlRowFkw==
X-Received: by 2002:a05:620a:2810:b0:7c0:b43c:b36c with SMTP id af79cd13be357-7db883e1940mr326975885a.6.1752152586933;
        Thu, 10 Jul 2025 06:03:06 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7e9105csm129701266b.20.2025.07.10.06.03.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 06:03:05 -0700 (PDT)
Message-ID: <c1a48230-c4f5-4c04-a53a-449bd90b1fd8@oss.qualcomm.com>
Date: Thu, 10 Jul 2025 15:03:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] regulator: qcom-rpmh: add support for pm7550
 regulators
To: Luca Weiss <luca.weiss@fairphone.com>,
        Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20250625-pm7550-pmr735b-rpmh-regs-v1-0-cab8ef2e5c92@fairphone.com>
 <20250625-pm7550-pmr735b-rpmh-regs-v1-4-cab8ef2e5c92@fairphone.com>
 <bc27209a-e0f8-40bf-979f-3d747c501ae8@oss.qualcomm.com>
 <23ae6ddb-682a-4c4a-bd63-f0a1adb6f4f8@oss.qualcomm.com>
 <DB7I7D3P01FF.3T5WRSTJIWLVK@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <DB7I7D3P01FF.3T5WRSTJIWLVK@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=dYuA3WXe c=1 sm=1 tr=0 ts=686fba0d cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=6H0WHjuAAAAA:8 a=zB4J7WEKRVuj73cAIgoA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDExMSBTYWx0ZWRfX7FPDNutyik0S
 ayeZrrGZqK9X4rnHF6t/cm7O4FnR6tYZUjbgxkSuQnceyGamwDoEM7UkFKeuWOVA5QeMNz8OY7n
 2js+YZ+Shq5sUmcbXi439i/aJgkJZE7ULqxVHv5imRudqYv9SQR7zzL7jFu6M4j3dr41QHVSvkW
 RuFaag/fVommWxR5yMhVqM7BXmICoMEgoB3M5EUjSgyF2pmQnNE0Uo2nv7uQli2kQy8QcnJT1VV
 /xwn6GVeMSsuCQW8hy+nM3BvPEbzSuye/jmxpGzdb9e7RaxkqXEXJGmVw5JDFEbJw+zXm0HXvBR
 1FaXdiDiqDHFtlHz/6EwnlN5r0mpoE0b9GTWoE23MXHY+0jFYGlBflag4F2EEimuedeJS/UrSYv
 fPhNlaksscveWMe+83qkR10FOS5px6hsIj0nN748tSmYL6DNrZMRxJUzivl0+2BTGsFlwfGX
X-Proofpoint-GUID: N4yY-oEQXwLGY0YQhgen6Byv42BqDq5-
X-Proofpoint-ORIG-GUID: N4yY-oEQXwLGY0YQhgen6Byv42BqDq5-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507100111

On 7/9/25 1:56 PM, Luca Weiss wrote:
> On Wed Jun 25, 2025 at 4:20 PM CEST, Konrad Dybcio wrote:
>> On 6/25/25 4:10 PM, Konrad Dybcio wrote:
>>> On 6/25/25 11:18 AM, Luca Weiss wrote:
>>>> Add RPMH regulators exposed by Qualcomm Technologies, Inc. PM7550 PMIC.
>>>> It has 6 FTS525 (FT-SMPS) and 23 LDOs with 3 different types.
>>>> L1-L11 are LDO515 LV NMOS, L12-L13 are LDO515 MV PMOS, L14-L23 are
>>>> LDO512 MV PMOS.
>>>>
>>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>>>> ---
>>>
>>> FWIW everything you said in the commit message is correct, but I'm not
>>> 100% sure how to map these LDO types to the existing definitions
>>
>> OK so found another page (also made sure that the supply maps are
>> indeed OK)
>>
>> SMPS is OK
>> L1-L11 is OK
>> L14-23 is OK
>>
>> L12/13 -> pmic5_pldo515_mv
> 
> Based on what are you saying that?
> 
> Based on 80-62408-1 Rev. AG for the LDO515, the Output voltage range for
> MV PMOS is "programmable range 1.504-3.544" which matches "pmic5_pldo".
> 
> But yes, in the table next to it, it's saying 1.8-3.3V, which matches
> "pmic5_pldo515_mv".
> 
> If you're sure, I can update it but the datasheet is a bit confusing.
> Let me know!

I was looking at the same datasheet as you and took into account both
the LDO type from e.g. Table 3-12 and the output ranges from Table 3-24

Konrad

