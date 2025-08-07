Return-Path: <linux-kernel+bounces-759332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9628AB1DC34
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 19:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B31121623FB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 17:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133CC272E60;
	Thu,  7 Aug 2025 17:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H9zy3vnp"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D569926CE14
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 17:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754586185; cv=none; b=b4ubEyqszM9iu1n90myX0fIkMxNTPnDF4RYDBHLToJtl4Cu0UuXuqyL2cuYjHaQxGx2+NDuqMIe/5xXe26BMaY7dTfl7FnqJXiY5/nqXDbnmSF2stHVqjueWEFdJJuDMAc27lFp6NBvfmQmXxKm5TKnPXO8RW/iIiWH6jVpaB9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754586185; c=relaxed/simple;
	bh=MRqFzhSuWwMpaPKOkiqO3zfdABs1SDMuFlkVK8Hi3u4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oNRaraOGn9JFUF8k7hM6GhRRZ7g63o2i6ptp9j1YR53q7O5UozTRBHGaEzwl509BwNthKWGDe/ah+qMH4KtCo05PfsDv7cpD2h9OSnQm7ar//KTnjXoIG+4rjQYVK9Oj+cas6ofShTXXrFzBrxXmYQwEBZwU5T7r8lLrOtzLh4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H9zy3vnp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5779DCPQ020091
	for <linux-kernel@vger.kernel.org>; Thu, 7 Aug 2025 17:03:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kT9b3uyCnzcpZ8XsWUfgQTVB6SbH1uKhJl+tlG2vK5E=; b=H9zy3vnpq6MgjC04
	VmGfddc2j/iB+dB+g3TFzNJOnF/pDKU4u6vMZ8DeeC/nPcs5e7O6HRDTnxk23IA4
	ENZmQFyo81AZje4Uxy7qzcALQmLDvAd383lzSUSxsxFIW6p/eOPUvzTjWbysQWJ5
	wRO7vxVTrn2A7QSNjVwgfxviPEUt03OU+IQuUZO/M90jozjQ1F7pihr6X/yHjNsE
	6JLcLYxhLU2PYFbf6EG+ZO5VoRalT0thvBqEFbOYSOtdPVAKmPA4BAmQI41WI9zU
	sfjVVny+O/0uI1J7yR7o20dYs0CnkdQM03n8HO28FV+OvmVs6cfezW/KNS3WRPxJ
	0I6lGQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpw2y10e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 17:03:02 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b06c7cf38eso673751cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 10:03:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754586182; x=1755190982;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kT9b3uyCnzcpZ8XsWUfgQTVB6SbH1uKhJl+tlG2vK5E=;
        b=hpUutzKk5CBtUf1J11QVsGspzal3pSbrfbpjDpRgluXt5lKfjzAVgD+u9srUbYzIEA
         mbI/5em9dn433mpTQA9p/5VXF/KTNb69K9Rb8/hdwu5XRtPylGKbfEQFRMwh7QdocjyE
         hH4auqiAzYLJ5x/xbBEiEpKtoPxKZmsg3e/j98naSt3lZJfgOKkmARiU48xkpSOHsUNd
         5MT9jv4I/Yt5/AKYqiu/17QVbxP+seYD8TisOzYt9462tSyK6zNENEDUSekhODYOTE43
         3D4abz8eZP3pKWBNbO/GSQRvgzh8vc7YKajq0XcFtpaSE3qB05NwbjZe5lDxwszNZd3j
         1Jqw==
X-Forwarded-Encrypted: i=1; AJvYcCWnGjheDK+KYIBfA1hC6X1RCvtBlzpoqAJZgXxHANIVyNcvMyWm+30Tz77naMucYD/g0nHA45R0Zc6LwGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiUy1ibZlQIJ4dKXm5zImLdNy//YS3nbs6/Y267rKoMZpV6bxI
	4zP6OqRcKfgRL3fnWGk9USDsO8xmNRKUa1p1raOPl4XjJY7i3VpjURxYYzlDUfSUvsM1PpcWp5e
	wYn48nTIFBuneXziGyBLfvCtMQqKhReJBTfR9iTfoM7AnVWkyjnt0Cqtrz4QRMIc2jb8=
X-Gm-Gg: ASbGnctmPKwzDf/zbLZZX4uLSFdQgA2af0kYgd1uNJLEGUDMkXYIaMUPep1E6DRfxUQ
	YAAgwstGsQsLx4JTcIfP1ahL92iz981UWGjyGzKYe//bjRKw30XjuuCJiuOL4bhnCLk2o/Co4AO
	tRKMTwuWezWF+gBRInRdQQEQ8E6zt1t0f2AW8nmjeJxxvRWZMAZ2CANDnGGdHPDsYKIAxUppgpu
	tswcu1WKvNue/37dykovJ+qCYU3Yf9ate0FNQ0N0q3RAWJapGjsmb2xL+ELdQOSgP8BlV3LiMvs
	onBzY0sNrQyK3FybwCSLhizK6woVkPuezioUwgLEQAzmk4/007w/g1WTMFgMpB1o8NbZGEOzcEI
	p6pM642a5ZQqdLI7Kdg==
X-Received: by 2002:ac8:5f50:0:b0:4a9:7fc9:d20d with SMTP id d75a77b69052e-4b0913be649mr53722611cf.5.1754586181562;
        Thu, 07 Aug 2025 10:03:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHodntMZuoTRllm//xlI3139nJlzflRuOhQf5+gUbl8UpYksDbejgbdK/rIApVL2XVDtz6+aA==
X-Received: by 2002:ac8:5f50:0:b0:4a9:7fc9:d20d with SMTP id d75a77b69052e-4b0913be649mr53722101cf.5.1754586180920;
        Thu, 07 Aug 2025 10:03:00 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8f2c265sm12028589a12.26.2025.08.07.10.02.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 10:03:00 -0700 (PDT)
Message-ID: <d0871d6d-7593-4cbc-b5dd-2ec358bda27a@oss.qualcomm.com>
Date: Thu, 7 Aug 2025 19:02:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: qcom: gcc: Update the SDCC clock to use
 shared_floor_ops
To: Taniya Das <taniya.das@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250804-sdcc_rcg2_shared_ops-v1-1-41f989e8cbb1@oss.qualcomm.com>
 <bnlnz6nz3eotle2mlhhhk7pmnpw5mjxl4efyvcmgzfwl4vzgg3@4x4og6dlg43n>
 <c54e8ac4-9753-47bf-af57-47410cee8ed7@oss.qualcomm.com>
 <d6a2937f-7d63-4f17-a6fb-8632ec4d60c8@oss.qualcomm.com>
 <db8241b0-1ef3-439e-8d74-a3cb86b610ba@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <db8241b0-1ef3-439e-8d74-a3cb86b610ba@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Vbz3PEp9 c=1 sm=1 tr=0 ts=6894dc46 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=F93HE1ha22ImTei5Bi4A:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: JlhOTLS7Xhvq9g-ftd7epeq5YvcHjwzS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOCBTYWx0ZWRfX14D/XQoFxuKN
 uIo9tTZcZ0AyCTV9VfG38woycNfPa4vqpXs/rINMdy+VEnknoVZjhgWpi8yVRa0qLxI0K7bFQzL
 1nXUrADVFi7Xi4hAhJZGujyxN1c3kHzzpHBKOmOPwbFrczR6Vrm+s0wwsYxO3oXsTb9T+1iMJel
 blFRTO0krcX4foKHe1ht7Abzn/zCcpWtbaYDbPd1ezIvh/MSc7dX7zKz4QGajuVMG3DM118gc0P
 Fmhp6baheETF119WJUjKaKT4yoRMcNrBryQOY2NtpPLLyIr4Z1ocVJv7SI04vyzWN52eQdchp99
 B0estNJZ99xuFoS/d+neZR3/q6uO/fsqpi7h78VpnrFj7VaJSqLIV+NvpIMYiB/eVyjr91qCjeD
 VQI2ZqzH
X-Proofpoint-GUID: JlhOTLS7Xhvq9g-ftd7epeq5YvcHjwzS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-07_03,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508060008

On 8/6/25 11:39 AM, Taniya Das wrote:
> 
> 
> On 8/6/2025 3:00 PM, Konrad Dybcio wrote:
>> On 8/6/25 11:27 AM, Taniya Das wrote:
>>>
>>>
>>> On 8/5/2025 10:52 AM, Dmitry Baryshkov wrote:
>>>> On Mon, Aug 04, 2025 at 11:59:21PM +0530, Taniya Das wrote:
>>>>> gcc_sdcc2_apps_clk_src: rcg didn't update its configuration" during
>>>>> boot. This happens due to the floor_ops tries to update the rcg
>>>>> configuration even if the clock is not enabled.
>>>>
>>>> This has been working for other platforms (I see Milos, SAR2130P,
>>>> SM6375, SC8280XP, SM8550, SM8650 using shared ops, all other platforms
>>>> seem to use non-shared ops). What's the difference? Should we switch all
>>>> platforms? Is it related to the hypervisor?
>>>>
>>>
>>> If a set rate is called on a clock before clock enable, the
>>
>> Is this something we should just fix up the drivers not to do?
>>
> 
> I do not think CCF has any such limitation where the clock should be
> enabled and then a clock rate should be invoked. We should handle it
> gracefully and that is what we have now when the caching capabilities
> were added in the code. This has been already in our downstream drivers.

Should we do CFG caching on *all* RCGs to avoid having to scratch our
heads over which ops to use with each clock individually?

> 
> We can add the fix to do a check 'clk_hw_is_enabled(hw)' in the normal
> rcg2_ops/rcg2_floor/ceil_ops as well, then we can use them.

FWIW this is not the first time this issue has popped up..

I don't remember the details other than what I sent in the thread

https://lore.kernel.org/linux-arm-msm/20240427-topic-8450sdc2-v1-1-631cbb59e0e5@linaro.org/

Konrad
> 
> AFAIK the eMMC framework has this code and this is not limited to drivers.
> 

