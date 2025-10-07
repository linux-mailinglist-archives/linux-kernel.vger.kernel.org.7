Return-Path: <linux-kernel+bounces-844330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E38CBC1950
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 15:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E67963B31B5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 13:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666EA2E174B;
	Tue,  7 Oct 2025 13:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZJJLtJ4S"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3522E0B73
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 13:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759845233; cv=none; b=d8+PVzcEgoEBZ2pRwFWApu4wXERQ1OFdUUPrSSEr5TTLhuykJPqIIU77K9L5DyofYlya4n+v/Osz771KQaDdHucvyKVFKD45LVEeNJFn1zqBz90/SyUC2PnKonUW3jKAWtIf7QnXUh8uooo4pHaMto0Psyb1af2oXLw9sIloSxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759845233; c=relaxed/simple;
	bh=cdt+xIUTUY+JbHEpPzEj8o59T1ECMCeqF+g9xZCYiJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jefcwTgMK7mYCvQVqNES3uAioSNX+VvpaxXuQ66gM/DfAlMMq5bUlF+6mmiXYeh/9RTwisliSLvGmYqeC4+zy3/5rHgeSEs5p0jkU8fnxH1rPB0WhdprrjcqTo6JaVGl9BQAo/p5KT7cYXVriVPGQTEipNHGLWk7j472aMlrA1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZJJLtJ4S; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 597DPx0h011725
	for <linux-kernel@vger.kernel.org>; Tue, 7 Oct 2025 13:53:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fiNc/ZDld9lHBOfROmDO6f0b35mQryE6GaNus4HaVTU=; b=ZJJLtJ4Sa6IzdQP5
	iOCwOhtwN/oa6v65lFuwMLp6viOO2qJQCR1u9n4wsFGej5IO66wSfYpLEIvDU3x9
	sfEFpIzL9WlAgKKFx1p/YNpZjGplIHMmklsCIFa/A/gnxoPMNGdolZoG+bn6sf8W
	ukOH0mGEWNe+WD5K9qtQJU6Vm7XtP54CJjd5lgLGD4k9irY6rYGS89bTNwWrBr9D
	r70G1YpWIXf5Jh1l9DGm8owSPNqz7SM1hDANDMADWp7Bx5az9+uSRZWltKpFL1sl
	QXxNoLSNEVfIqQJ29d1tfkVaPm9Rp0wabvOXfA3uAJsJYOmKnzsSSV17uLmiQFZy
	Z8shlA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jtwgqece-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 13:53:51 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4dd729008d7so14237961cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 06:53:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759845230; x=1760450030;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fiNc/ZDld9lHBOfROmDO6f0b35mQryE6GaNus4HaVTU=;
        b=Hdfxnv8K17lKOaaN7HNT4upNTxNsbo+cjmCImVpk9d0NSfHNB/o6AHBTN6mJG30pf9
         /NyuiXDZwlu1RpjgRqCwtdnRGIDaX+x2wFaBdfsvmTNrcRe2aI+N5uXCqYKxRmhSMMpv
         bxWMFJCBSnhG6WWx+8dSvdbXkJo2IQ9LwrdyXoy9C3mWLwKMGt+YbdK6FoqKG6PeD3DN
         ppR2EDEwVqLKJFvpEhn5fJaYQX0MgWzzNeqvjKN/xxGkFYOLbZBvRC1Yz2kTxI98KCQl
         WvOos3h8a46u8U+lNbpCnEMTYT1KqoVg8bJnSECgGw4XkE7SFldQ/akWSjmOIxZfsh9A
         zI7g==
X-Forwarded-Encrypted: i=1; AJvYcCUeUUfuYMV4N/CGJ71HJZxQP0WAG2Qg9IjaiJ0bwD0RV9SpAEvMF7O8c31xn4LTT1qLEtryq9oOiMaWAi4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0cKUOjMp3aNJAqwTpZgod5KemfMFS27P05KMHmhwBaV2t/0Ua
	eeWJG5ffJDUGI0htb1tRbRZjZbJvyTzh7Gkhp5qhx8NjFnuP5nmIQ2uKwYR2Th4ZsAuVxv6eQiN
	vJAw7FH0O3W9cD5fqCxqprei92GzsNn2EHO1Pix8NPoUJAKbMg3ww+iH8wBt3JE8kmuw=
X-Gm-Gg: ASbGncupFNheupImNovIuUooNfDbVNX4R2n9tG1DYdShsN96l+SXWX1DQPvnBIE+j8T
	J2aWsozwXXUtXrUl11ayasYUv+x3gKvUhRMm4XFUF1ov+VH3QGVyZmFuCnJdAfdmem7eaPua6DI
	2qd25WeDMlypaj54+7yLr66apLcpdgpbTU+bm3rTjpxNKbxZMnykHBHWeCbEfd9IbrB3JmW8kxD
	lcoYQWXjb0j9xVIFel8aUIxRA6zYUdaafcKnKyJa63uPMwkSuq0ROhZmoB/68xcrlfeQ1NgCUGb
	0uUVmQJU6o+aV0c0hegro5XOFgwkuB+hr92lSoR0RS/F00RTVuzP/4XRMBaaPpTsSC1Tn6E6xLy
	L5yBtoqHhbyunM9yN3NSB286tLD8=
X-Received: by 2002:ac8:7f87:0:b0:4dd:3948:3380 with SMTP id d75a77b69052e-4e576ac46b6mr127531731cf.11.1759845230233;
        Tue, 07 Oct 2025 06:53:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZXrDJuWwO6h54DXmE2fdQYzL8QfITc/WlKY36C1qhe93i2ttKGEhMEDPLcHC8FVYGtfGAqA==
X-Received: by 2002:ac8:7f87:0:b0:4dd:3948:3380 with SMTP id d75a77b69052e-4e576ac46b6mr127531481cf.11.1759845229682;
        Tue, 07 Oct 2025 06:53:49 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b48652a9f50sm1393040366b.9.2025.10.07.06.53.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 06:53:49 -0700 (PDT)
Message-ID: <fd8bf93e-f6e5-45a3-8e7c-7e63a918809a@oss.qualcomm.com>
Date: Tue, 7 Oct 2025 15:53:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/13] arm64: dts: qcom: sdm845-lg-judyln: Add display
 panel
To: Paul Sajna <sajattack@postmarketos.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, David Heidelberg <david@ixit.cz>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        Amir Dahan <system64fumo@protonmail.com>,
        Christopher Brown <crispybrown@gmail.com>
References: <20250916-judyln-dts-v2-0-5e16e60263af@postmarketos.org>
 <20250916-judyln-dts-v2-5-5e16e60263af@postmarketos.org>
 <6145be40-3b2b-4554-9d5e-c1f9fab0363b@oss.qualcomm.com>
 <da2f17a144374f326de9e0c5bec638829a31cd1e@postmarketos.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <da2f17a144374f326de9e0c5bec638829a31cd1e@postmarketos.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAxOSBTYWx0ZWRfX0r0VetmWTgN2
 aViapGHxGYZIsjh8aAZdNd6m280L+mWBYk2VLdEmxDvDfg9PNPbdkqhnh0N8IVDszbRyNHjDrKY
 zla1PnD/Hou13gR8JrSdHfUbVVGH922/ocIYEjZGw3Bp+DOIZN9azUllhEuao+efI8loFl9Qaws
 CAW5U3NGn8tdvSLPJHIC7BdAGJBguoEVUnCG4BnZaIHZyNzI2wFMOZtEDA0U5cJo16YP8NDe4Qn
 w/Ptqi1dyNVvP79AZFrxgmzsVujXfA+W1ferEa7qW2gUHe8PCuT2ie3RMVqgv+ctLZ6bxFBP8f/
 7mDH0vFGavkuajuGSwd/O3ineM4TSeENPzZNGRW4UjFUCrJQ7iNI5qrPl0xyZ0i+Qr9DS4jHbo8
 eIGTJU0NXtBlGBZjCHQ0cUllgoIhPg==
X-Authority-Analysis: v=2.4 cv=B6O0EetM c=1 sm=1 tr=0 ts=68e51b6f cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=NEAV23lmAAAA:8
 a=XKEg-W0rSRFBAHshmuIA:9 a=lqcHg5cX4UMA:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: 2749-gAPgLF3It4pZgx62ANw8YVVWNxB
X-Proofpoint-ORIG-GUID: 2749-gAPgLF3It4pZgx62ANw8YVVWNxB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-07_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 adultscore=0
 impostorscore=0 spamscore=0 bulkscore=0 phishscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2510040019

On 9/18/25 3:38 AM, Paul Sajna wrote:
> September 17, 2025 at 1:50 PM, "Konrad Dybcio" <konrad.dybcio@oss.qualcomm.com mailto:konrad.dybcio@oss.qualcomm.com?to=%22Konrad%20Dybcio%22%20%3Ckonrad.dybcio%40oss.qualcomm.com%3E > wrote
> 
> 
>>
>> The vendor kernel (for Sony phones at least) does pull-down on both
>> active and sleep, making them the same
>>
>> Konrad
>>
>>>
>>> + };
>>>  +
>>>  + sde_te_sleep: sde-te-sleep-state {
>>>  + pins = "gpio10";
>>>  + function = "mdp_vsync";
>>>  + drive-strength = <2>;
>>>  + bias-pull-down;
>>>  + };
>>>  };
>>>  
>>>  &uart6 {
>>>
>>
> 
> https://github.com/LineageOS/android_kernel_lge_sdm845/blob/lineage-22.2/arch/arm64/boot/dts/lge/sdm845-judy/sdm845-judy_common/sdm845-judy_common-pinctrl.dtsi#L109-L148

Take a look at these lines instead

https://github.com/LineageOS/android_kernel_lge_sdm845/blob/lineage-22.2/arch/arm64/boot/dts/lge/sdm845-judy/sdm845-judy_common/sdm845-judy_common-pinctrl.dtsi#L137-L161

Konrad

