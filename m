Return-Path: <linux-kernel+bounces-871673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F0DC0E191
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 70F2E34E23E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA31C2C21EB;
	Mon, 27 Oct 2025 13:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JWTMpixT"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878A4291C19
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 13:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761571758; cv=none; b=YvxtGyGw9qKfa3Rfm76EWW4cxW8nQ2ArWyaGVUhUunhZWFKb2HeI/Nak2sk7kgrk8obkOh+fOJeHsCSZsfx6geuZ+VefwBhY5y5SByXUpeB6un0TI/djygmwy4iyzFxz8GMipgWx8q6aKG/VkXoQBnDjmSx5sje8y0lyuiet5Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761571758; c=relaxed/simple;
	bh=Pan58HdaZnnEEiGAcmHIdbRZg+I4SnaG0hhYc9UnT+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cT2zGNAwT53nLgZ0CIujN3AvqUxaoZVEK63TJavVI0tXk/K1Yg/EHaY4YXrnLzb6SJsVOjuT6JnTZAHpKT7LsjCM5BIH1Tq4LFW84TtyQ2fQqeK+7BUMafrFHdKZ7SvGmPmLUwRT8I8FA8JNwPxmHai5pQofpiTOdyV26z/R240=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JWTMpixT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59R7JwCP2059323
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 13:29:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	m/wh/2HoBaFbH9FEa4gy1Lf/s3pngC27Kp5NLQ8Yhhg=; b=JWTMpixTNuQLjt9M
	gArB6ZUURQWDVPGISvI6dzysGxKrnytIsSsteQ8oJpmU8KIN1vcLCKW8a/8JXGE3
	kcrFwyokSf8KqfcwmDQLxxKlj3MA7FPVt06SqwN4Co/kOUuV7mXM8T8w+BMmooZn
	dFV54ZLlqyBLo5ekywKi/RSnyX6EC0tO6RKR4Ih0NK8c/KxiyAhmZFfAYrF6Pp11
	tQc3AVpVrzOb3uJsSiJh0pfSBLPqgKbNOMA/ABvqJzCrFXPKy7pErWoKVaNYoAuY
	Avl//qcb1NahgluqVg5m90grqk9sQc+s8CIaR3bFXCb8oP2C1zT1T64XNkfDwQir
	Em19uA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a248p90ya-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 13:29:15 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8a4f7e885c9so29699785a.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 06:29:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761571755; x=1762176555;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m/wh/2HoBaFbH9FEa4gy1Lf/s3pngC27Kp5NLQ8Yhhg=;
        b=g9n3fBCWe2rMlDMQcduivkoS8GCuocSX4Ed7mhWiJ+qyos96n+orKCSkNj8gQIdCDu
         sF0DJGaoPRaGuHkR7/W1OqbD4YGupoZ7ke9unOn45JNnxPfU4/71S++LwsBckqJgT+8k
         Yy1Q35ZCXfN9GLxUv79iF/KlMz+WmloHcOeg1la3yatqjjtg16FGWU0ucnCVPIXjpbTE
         qd2PUn/oDPosQodRYAd5ybRTmPPNTQC9gUR4PC/O7S4sQFO9kUuI6d70RC1mOJlZAcgZ
         xsW0Lk6CTWNALzbeeDizCWMlg8k/iOvzSaMn5gqg2D+PVatAzZcEV9lqWdxrZn/gQk3c
         hSaA==
X-Forwarded-Encrypted: i=1; AJvYcCV6Jp/2FKGznUdFFrO2uvZ4bst8QOHLBsEW/hqN8M6thazyxfyU/IQAQ6/+AIQcUivMc1k9S3Ws79mXEqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YytvOAgJ7Q+PLCRPuTRsX1iBlbMKpUfnboYjRaupmSFO09ukHut
	1sEfNeLI1SyO2sfUzA8RF8ML+GkhSqYYTg3pvonlD3QURdpm9LBh3T43FWHVm84swVR96hF7pth
	ttbXTIyWGTT/cR5fN7oRIbPASrBg8wxXuz7Lv6fOEfqHL6xkDc7+aqAjgn9DXl+IzQR0=
X-Gm-Gg: ASbGncv3Nt6NOCtbGb87k39wGhCyxD+GkgSQDZEURORAHBKEc6M1MIdF2z9GmKKp/lA
	18S4DA7CobUS1zxLDs1vS5a+idDIvrx6yImpNIwn7778AFVndnjBWBN2i6b05WbMpkm7bJfFg7z
	eiKbDvzOttwvXvJOTR7hoRUf/m7FlTj1r5GvO2umWMXQKJk6RuTYprBleIWJ7Nl1DXw7dofXmpL
	btYbEIUSU4lKiVqtIrn4c3oUYnKKEiz3wuQKCLJgzS51M/Be7CMhWBSXM/HJ9w1RoM/rq+L+8pf
	qFVO/TIxwsvDFVBItilVnwLYhyZVIX7kuT9bYqsJ9wzNpydAaioozQviJtoxtGGxBe6AER/tNEu
	BR6qaN+lidzPXk0Ur/zEetnJt40lQBxwNDoQ1BCh4XxT2k8rcopMz7dov
X-Received: by 2002:a05:620a:2909:b0:8a4:8825:bc6c with SMTP id af79cd13be357-8a48825c3b4mr194436485a.4.1761571754653;
        Mon, 27 Oct 2025 06:29:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsEwa9PZeblZrs6FSKYXdUAU4qmJqpMUY/0ozBx6tLeFeVJzgObhyAchh3D21rn6rwzttaNQ==
X-Received: by 2002:a05:620a:2909:b0:8a4:8825:bc6c with SMTP id af79cd13be357-8a48825c3b4mr194434485a.4.1761571754058;
        Mon, 27 Oct 2025 06:29:14 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-378ee0d3c29sm20007091fa.37.2025.10.27.06.29.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 06:29:12 -0700 (PDT)
Message-ID: <18e8d5db-e32a-4893-9d1f-5003670cedeb@oss.qualcomm.com>
Date: Mon, 27 Oct 2025 14:29:09 +0100
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
 <ef247fe6-6d9c-4a74-b3f8-a56857332758@oss.qualcomm.com>
 <9a227c15-dc60-4086-8d81-f80e3398a083@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <9a227c15-dc60-4086-8d81-f80e3398a083@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Zvzg6t7G c=1 sm=1 tr=0 ts=68ff73ab cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=YAA2XIu200uozTIaui8A:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDEyNSBTYWx0ZWRfX4hVmU4m8AkNP
 6mg6YCG3JLIdTNWXMUGxkKR7WZQVMSVsSGjySf4qS/D1xrXMv/3Qt7TyeyFDRS1v1+f+obleWWd
 45PxeAFGRoVtgWzSfWKGnK/k438ab6BYKFEQaq4Nl0EtMigE77aMmw8hoT3r7540eU2o0GKzOZe
 GiisyT/ezEKj21BG6SwlO5HkcXU5ofMSnW3k/TcQlshNZIwp+IXssefb1SSTJwVINOxeab/5uKR
 pcGv7A/YKflkrxQDe5qHKmgustDnhCjvCHVZUUXEyALMkQT5RXcnWSoZc+tkT1jWt0sk8My5V37
 xXV75twZkaPmsqFenPYe/HqVZJxQDfuK2qtletgHfy8ifwW5BCMtzUb4jCbkioDICFiwj7UtIqB
 fy1nsZDTqtEu8YrT+/mgk7xyBATKEQ==
X-Proofpoint-ORIG-GUID: bK3f-kFdBaJQK5EIas5vKIIy7q8pLRTZ
X-Proofpoint-GUID: bK3f-kFdBaJQK5EIas5vKIIy7q8pLRTZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_05,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 adultscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510270125

On 10/23/25 11:46 AM, Maulik Shah (mkshah) wrote:
> 
> 
> On 10/23/2025 2:39 PM, Konrad Dybcio wrote:
>> On 10/23/25 10:57 AM, Maulik Shah (mkshah) wrote:
>>>
>>>
>>> On 10/23/2025 1:47 PM, Konrad Dybcio wrote:
>>>> On 10/23/25 6:46 AM, Maulik Shah (mkshah) wrote:
>>>>>
>>>>>
>>>>> On 10/23/2025 2:51 AM, Bjorn Andersson wrote:
>>>>>> On Wed, Oct 22, 2025 at 02:38:54AM +0530, Kamal Wadhwa wrote:
>>>>>>> From: Maulik Shah <maulik.shah@oss.qualcomm.com>
>>>>>>>
>>>>>>> All rpmh_*() APIs so far have supported placing votes for various
>>>>>>> resource settings but the H/W also have option to read resource
>>>>>>> settings.
>>>>>>>
>>>>>>> This change adds a new rpmh_read() API to allow clients
>>>>>>> to read back resource setting from H/W. This will be useful for
>>>>>>> clients like regulators, which currently don't have a way to know
>>>>>>> the settings applied during bootloader stage.
>>>>>>>
>>>>>>
>>>>>> Allow me to express my disappointment over the fact that you sat on this
>>>>>> for 7 years!
>>>>>
>>>>> This was a dead API (even in downstream) with no user since SDM845/ 7 years.
>>>>> Read support was eventually removed from downstream driver too for the same reason.
>>>>> There were early discussions to remove read support from RSC H/W, due to lack of users.
>>>>> Its not realized yet and all SoCs still supports read.
>>>>
>>>> Can we read BCM states from HLOS this way too?
>>>
>>> Yes, Any of ARC/BCM/VRM can be read to get HLOS/DRV2 votes.
>>
>> Wow this is amazing..
>>
>> Do you have code for this already, or should I hack on it?
> 
> No, it won't be of much help, as i said above it gets HLOS/DRV2 votes only for a given resource.
> More specifically, the read does not give the aggregated vote result across all the DRVs.

Hm, perhaps it could still be of *some* use

But maybe reading back rpmhpd and rpmhcc states would be of more
use!

Konrad

