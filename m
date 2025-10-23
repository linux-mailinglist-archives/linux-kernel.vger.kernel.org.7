Return-Path: <linux-kernel+bounces-866575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA3AC0022E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CAEE1A64B41
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57872FABFA;
	Thu, 23 Oct 2025 09:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CObmossL"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868F4226CFE
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 09:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761210556; cv=none; b=Gwsrdpq5xLzWhZxE8nfPsPbCNnzKbB/9lSCmSG4qiJxQHb1wUnCGF4BOPH2Go3KoZCOoDdXz5ps+ovtBmgK+b1TGC8I+FugXfPUDk6yfoBCSNaqDbBjmmPs6R/xG6DkzMZr4VZsSfvBHIjI5RvtW7a67dvooqfbxmWwkvYkCKZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761210556; c=relaxed/simple;
	bh=X4HUs0gSmGTGjJAhjczq+fOWi7ZDdDt7wx2L3+WVzg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WwXF6dtaFsdK/OC0lAUcw9IDrsvVPLJrA5xRM+NnjC1/zWSpdq/sRO7HjXzp+gEs5BFXYiyvOxoMqJRzzKWghTe1ahHZgJETUIZdeRhSJ0SPTU6Ybfx4lzdXUMuTUrvyovYb8qT9Xd1DlUzm2AWnKIIX6084NUygu2Bb6jANT2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CObmossL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N73lAH005711
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 09:09:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eL1FDaV1hb+GknaszdE1bYLZJtOeHi5W6tjFQW86BtE=; b=CObmossLcRRzB2dD
	UTqJEbFn4Bffdyi6PMhujhgnKWGf129SUY4FG011MswWPEEEx0oFuR40Wf15hh9S
	BmY3OM0n5AKbV2NQcObo+7U8eKlwO68tupwdSKI6B9nhCtJWnlxoo5dg+dDYa7S5
	RL9UnVgxjJW/mcgYpzYJcpg8wh4JXFY/Wst1ne3nxOTHGqVmdrLWlmBKCwOTbyfC
	A9L78qsvWkspqfADTkOZIFC8W06B9SHHsM+5Ff8akyTIYNTYQzRr9iSOpfbiCXyq
	SjSDIPtIerrDVZKTYE99bqFmIHFxFpI0QHNUzDPTxyFG7MjWXbCbdnd7EhREUg6f
	fEXH7g==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v27j7pk6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 09:09:11 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-87c1c70f1faso2474636d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 02:09:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761210550; x=1761815350;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eL1FDaV1hb+GknaszdE1bYLZJtOeHi5W6tjFQW86BtE=;
        b=rHjpmtU8Zm+ze0MZvetzTtqNwDkFK9Zb+CpUZjb225SN4XLP4qTYlTzT4RMIiBPhNZ
         a/jqqgC+P94DHed/N1URprwdoyZT73trazDCcIDykrTlSzqIYK7sALy3wiv8yd8/9P0r
         3o0ViZi/pLEagfDTOrJdLktAyHMF2q0gKCZsRCLSCsQ+dAX51EkADMCcvsHn6GrzSgT4
         2SpmVSMpLMVs6TRCDYHbFDX75urUibFDxCwyjO7WTavHHoqc2dh16CCZS1L7Xv1bi2fl
         NpdcpFAII44rVJJT+Gzwk8JCwCm1GisbslZYH1QYV254hsRzQqHw830GnWN4QfBnlGIy
         gGyw==
X-Forwarded-Encrypted: i=1; AJvYcCWTClmi32Aq+7Cf1TZqyNavdmeXEoXCjNPSjOjdJoek+iZHwwZUO3uuHf9huoO/Jtk3nIGdpMQvf52TjTU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPj8nO7BSfEVHrkJQP6FlCEgM36AwKyY0O7iJ5jEJ6r5DRrnoX
	H8YWRBCaiIm7bhCykO+/881MsJ2cSU5ENc4CPenZsjE/SqlBm0vKshEMfQeFeKLR2ycv9FycC2M
	Zz9DsMki7qDWy8ac+Nem82kDisKgrJdPO7TFJjIxGU1RYVCwO0oyIH3a6hVc898GOeMfxhTSZhx
	4=
X-Gm-Gg: ASbGncs7iTwynUr9KUBM2OjoRhZXMQiV25OenKxTLMo9c7UhHYWPaKq9KKM2uYMjOVH
	NcfpbaWH4T67tmH5tTaYx1crexuLXN6ozO/CvOGwpEC2l90jsouBSqvU/+es1ib6kFgZSoKAVh1
	ByE4/rqbeoF2UQ9FqjNhph/b1tUpoSzFpzuInCY4/raHaYn7Y2fhp7jIGjQvV7ruZWJo3Srr7HY
	aX0z6AsAqPFHvAxKUJ+bvFUx4CcIyip4eGqcDjirvP9jwrsBHEAl7f62W/nWJztYhqz2EmTeuRN
	KjeJJskkxSOlsXffSsuWaYS0cRf8En+GsoYP+P7qmygHTIphPc3dWlJ+fQ68fmkS4by99SxZOU3
	vsM6QOkPR/8bf+74obFHCaugv3YKGFblSlqs6pTicQIU2UM8MB1sShJlh
X-Received: by 2002:a05:6214:c47:b0:87d:cb51:4015 with SMTP id 6a1803df08f44-87de70be665mr82433266d6.1.1761210549917;
        Thu, 23 Oct 2025 02:09:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXMVFPiut7DKZKJFSlHN3s7xnOIyeF4GLAo3/pwNAvecNJgx4w2pkSuvhqwoLZa5ksRW7vcg==
X-Received: by 2002:a05:6214:c47:b0:87d:cb51:4015 with SMTP id 6a1803df08f44-87de70be665mr82433106d6.1.1761210549402;
        Thu, 23 Oct 2025 02:09:09 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e3ebb3738sm1163047a12.3.2025.10.23.02.09.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 02:09:08 -0700 (PDT)
Message-ID: <ef247fe6-6d9c-4a74-b3f8-a56857332758@oss.qualcomm.com>
Date: Thu, 23 Oct 2025 11:09:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] soc: qcom: rpmh: Add support to read back resource
 settings
To: "Maulik Shah (mkshah)" <maulik.shah@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251022-add-rpmh-read-support-v2-0-5c7a8e4df601@oss.qualcomm.com>
 <20251022-add-rpmh-read-support-v2-2-5c7a8e4df601@oss.qualcomm.com>
 <litd6qcxuios7uwwcrz55ea24kj26onrjo2aekouynsce6wslj@vatjbulg64mb>
 <4831d12b-a42a-464a-a70f-e0e40cf4ae4b@oss.qualcomm.com>
 <5c0b4712-4a54-4a1a-ad73-dc3bdb21a0ff@oss.qualcomm.com>
 <cb361d77-6845-45c9-b418-67649880495e@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <cb361d77-6845-45c9-b418-67649880495e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAxOCBTYWx0ZWRfX76eM7GwcxJ1m
 LA2FCZUfkE1bTr0nj8sMZI3r5nSHLPZhmBfN9o++X8pnmAMXmRKJxiJGg/zhmC1aXudf1zOCWTN
 1s8yni6ukY9jtIvTjAEYsJBDP3Y23jdegykJGZPoqf9ACf5M+61O9STKmSpfwNZbNH1DQ2f5rE8
 Rh+rOg9HrnOyVIlHYmAxtya1/L/v39f4s4Q+h8WuCCVLEfQZJNymici48oZuGTSTYXOYxNqhg5n
 lxjhWIdIXAAKah7RzbrfpULClIcJtH4GrD/H5AibZHKxjsvLk+4oec0EC0fjJCwSr6jWXGiR+TE
 9SjlEhLal7EyWT9VgAR47VQGXWO3jW5rN/UeldlQWUIhztM2+RBocLj7AbyNaaX0PtgTTPj/09O
 0Wdb8L29Hp8Lm/3Y1CORhXzfZC5u2Q==
X-Authority-Analysis: v=2.4 cv=G4UR0tk5 c=1 sm=1 tr=0 ts=68f9f0b7 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=YAA2XIu200uozTIaui8A:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: j-uzh2I2ant3B5Bjuwo9v6FNkwlounz3
X-Proofpoint-ORIG-GUID: j-uzh2I2ant3B5Bjuwo9v6FNkwlounz3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510180018

On 10/23/25 10:57 AM, Maulik Shah (mkshah) wrote:
> 
> 
> On 10/23/2025 1:47 PM, Konrad Dybcio wrote:
>> On 10/23/25 6:46 AM, Maulik Shah (mkshah) wrote:
>>>
>>>
>>> On 10/23/2025 2:51 AM, Bjorn Andersson wrote:
>>>> On Wed, Oct 22, 2025 at 02:38:54AM +0530, Kamal Wadhwa wrote:
>>>>> From: Maulik Shah <maulik.shah@oss.qualcomm.com>
>>>>>
>>>>> All rpmh_*() APIs so far have supported placing votes for various
>>>>> resource settings but the H/W also have option to read resource
>>>>> settings.
>>>>>
>>>>> This change adds a new rpmh_read() API to allow clients
>>>>> to read back resource setting from H/W. This will be useful for
>>>>> clients like regulators, which currently don't have a way to know
>>>>> the settings applied during bootloader stage.
>>>>>
>>>>
>>>> Allow me to express my disappointment over the fact that you sat on this
>>>> for 7 years!
>>>
>>> This was a dead API (even in downstream) with no user since SDM845/ 7 years.
>>> Read support was eventually removed from downstream driver too for the same reason.
>>> There were early discussions to remove read support from RSC H/W, due to lack of users.
>>> Its not realized yet and all SoCs still supports read.
>>
>> Can we read BCM states from HLOS this way too?
> 
> Yes, Any of ARC/BCM/VRM can be read to get HLOS/DRV2 votes.

Wow this is amazing..

Do you have code for this already, or should I hack on it?

Konrad

