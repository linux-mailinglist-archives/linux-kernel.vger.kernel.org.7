Return-Path: <linux-kernel+bounces-830361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5571CB9979A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08650325C1A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8742E0B59;
	Wed, 24 Sep 2025 10:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fcVV4Sql"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D228C2D595F
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758710733; cv=none; b=dyh+xYllUFbpIBFR+7h89Tt29i1wnxY4HPA34zfUte42rqQ63ursaf/RBlV2I3t+S5SqHIL1HoJtRZ3vhvKcsh0wELLjhvjvwCfxYinSvMP4ieb+CednaixQ271H/PrC8RZM2g5+2H7BwWIeqtz+937SB4Qdq3Ma63bz46RVQvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758710733; c=relaxed/simple;
	bh=izbfN5zlluTvTDU5QBrF+CRs+L/OG8KsQ9B39AZHdSs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nP1zAyWqCjJHLXLhcZZxPBYiq4QmdSDc1mIEVtJXF4U8cJhEMmuI9jZVUPJ6ZEgvXGa3cm0JW0nVsnQ7PhhY5jPLaWlqbjM5dU8FwEkojsSF9l5i7Bj7qtGwEulZ4GkLZZ3banoc6C/d1qfvIl5a9mlaqw8MVsdo8AB6d+tRil8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fcVV4Sql; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58O4iIgu019926
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:45:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HX6oleHUsB5SDxMPBnujI7fM0fMhWH3Il+PVWdZRijU=; b=fcVV4SqlDbjFTvzq
	4p5+9vemuguxM02OY18H6uYHkGc41gWfit77quaawHdd8rqWA2ekQ1Rv2qWYgkzh
	jbNwb9M9FAHkG55lUs8XUJKc/aiPBXRazmiEbbltZmqMb1czc0szahf6PBbtrnIC
	UnJ3d1W0qGCO96yzE28cJsmyrrmjuV4v0nLkoOrLgvvIXTWvQ/3Vfa4NlKhBbTlc
	LMV4rOt33XS3ASWyXzqj7LVWpBqDQglgysG5LH92A9hF51qSGIIu+FwhMwUSy8RI
	eDFvFxrFJc+pviEABHk3q2TsoLwkWz8105kE7R5UzjCvVYYpYG9+oEbxYQhxplIT
	LHq0xQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bjpdw67t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:45:25 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4cad9f8f93dso8360541cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 03:45:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758710724; x=1759315524;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HX6oleHUsB5SDxMPBnujI7fM0fMhWH3Il+PVWdZRijU=;
        b=xU3qzZo92CMu6wn/iDOsDEHBXENmm/peGkyf1Hye1ACeyqjfwJo7cIZVYMYX5Udsi5
         eu/cXmbbs11hYBIGZC0BJEegxq7d1WvUG3F6JrIverBaxaKSO+RXTIG+rMzeC0Y26Ncu
         PGE/dHpA1su/YGMCcZOOOJgUaHt5O9iyGmX+7uLdheXzGnYpK9r+fTBoJqVpMMPUhRAK
         0uBvWP0QG7OtbTT0pPRv4Q0QNsb1kBBPyhuyiJqV/lG7wJH3L/ujf8zSUPhisejJtdwZ
         XgGeH/YaNt6eo9LIrxehhvfXZfzq331/IDngkDNgRta3w8/o1VrMU0ztoSayNzuTgMk8
         rSXA==
X-Forwarded-Encrypted: i=1; AJvYcCWi8d9oVuCPLNNpJN26iyakgNMILmYFEkrFUrwY3Bs63+dvxLcoboT8lwRViwYWdnAYvqPCN290uM2MJ78=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz18XSE5sAUNe6VZ/wi8Up7SSqnFdialynsoH0jZwN3CZ+Gg1ra
	MhV0I7UMbiRGTarlz+M4K93L7132wyimEMpPYny7uhNUKNMVdutzQ8H/dSJrmaOwXkPsYVJkca/
	E5n1dA0K7q25SofxbQaxvYNcahhF6ZacywpQWHXIcIHc0c6jbo8Et6f85A7lZWiSRBeQ=
X-Gm-Gg: ASbGncv5qF1ZBaOwdjjKDzSscG5HmH6qDmnXyVD1+CKLOY4DTjpxMtbwmIbn4YCEbtC
	aK0TDP3a3ZzcEdIwnad/2pJ48WXKAFinBBQHy+AG4xk62cnrGif7HSqSzEk+mjopcWANimz/YbM
	UhF8vapvWiiet6AS5LqUeuFNwzDiQBqD4Sz7ghpzUKa+Sra6qxUlhqyv/3d73hFG4lgV0oZpezO
	3w/Ksoid+n0hgzX8s+i9Ja4XdTJxu7cM3G59RfbXusORUbfFO/135xqiOdulnLuyf7DKgO3Pb80
	tunfz2OAB6/de14wWInHmmxHyVV1hKZq5BII9tYpn1g7eM/rgqmGKXubjDCIcUayUympf2RooR4
	0Eely0d4w5+mGP1p4JzSLew==
X-Received: by 2002:ac8:7d8b:0:b0:4b5:e4dc:1ee5 with SMTP id d75a77b69052e-4d36707e722mr47274301cf.3.1758710724409;
        Wed, 24 Sep 2025 03:45:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlonZ9+W9s9uT6vfFr8FKvlXPmIwYYLXdwCud4N5wiTYqUItOgeQ3pjQWcy/3rqzCLiWuDOA==
X-Received: by 2002:ac8:7d8b:0:b0:4b5:e4dc:1ee5 with SMTP id d75a77b69052e-4d36707e722mr47274091cf.3.1758710723897;
        Wed, 24 Sep 2025 03:45:23 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b29e6597caesm889524566b.73.2025.09.24.03.45.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 03:45:23 -0700 (PDT)
Message-ID: <36372e64-83ec-46d6-9e66-7000c19fb871@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 12:45:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] arm64: dts: qcom: Rework X1-based Asus Zenbook A14's
 displays
To: Aleksandrs Vinarskis <alex@vinarskis.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Glathe <jens.glathe@oldschoolsolutions.biz>
References: <20250908-zenbook-improvements-v1-0-43ecbbf39c60@vinarskis.com>
 <20250908-zenbook-improvements-v1-2-43ecbbf39c60@vinarskis.com>
 <e54daa39-ffb1-4f0e-82c6-42e45efe5044@oss.qualcomm.com>
 <X5l7eScrcspQe6JfPyx8VCIZXmCmq-VBlAoNmIuAAmwfp1z-yNAG5GyIEnp4ByyPOEfJHEtewC0uOgrc0GiLlaz433Gheubseb-pXH1ZfUw=@vinarskis.com>
 <blMLYZBNCKa8x50Dd-zdFPdx7wZNor45QRJeeqjVautVqCR3aIoVAUrxacXkYNAlrC6p6npHSU_ZMfUDvZzoUzXg_2iiXMJPFmW85P-B3HU=@vinarskis.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <blMLYZBNCKa8x50Dd-zdFPdx7wZNor45QRJeeqjVautVqCR3aIoVAUrxacXkYNAlrC6p6npHSU_ZMfUDvZzoUzXg_2iiXMJPFmW85P-B3HU=@vinarskis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Ep8Hmfdd07tqgHN9G20TSCfQjcHGQMn3
X-Authority-Analysis: v=2.4 cv=Pc//hjhd c=1 sm=1 tr=0 ts=68d3cbc6 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=I76Qk8w-AAAA:8 a=EUspDBNiAAAA:8
 a=gxl3bz0cAAAA:8 a=ZGzr1XgpPqI01JkrxgEA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=vUPM0Wvl0xcrLs4nqPIT:22 a=kiRiLd-pWN9FGgpmzFdl:22
X-Proofpoint-GUID: Ep8Hmfdd07tqgHN9G20TSCfQjcHGQMn3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDAyMCBTYWx0ZWRfX74226H5uSJM2
 uqxZKJBljF/a+LAvGeYBv7to1sNg4Cv6vNz232lOR98fRQx9uOwA1kElhcBSWHMsn92p+Lx8p6t
 rGUpk9hJoCYKFLKrqQ8eEbETcRxtLI/8L7i1jgerggBouu/eD1z4YjkLMeAy84f1rxabLirISnc
 ZWBW/6lFOms+qpmf2eFLbIkrZfRMXIiRH1NCg3F2ISRgZC0SYrnUN7QGIIuXNKxJbbd4AAP3he3
 xTgZI3ZzTvwT90q19EfeZBRHYM09XjZTDuUnLBIFXvPfkNEBf0KhrhvVg7vTHMI3UurzAbMYN/E
 fQOiVRdMQnpx9FiFLS58NXCd2M0lfE8im6v6K1B5jsg2r0OsqpRdQAAZi1VaQ8Zb/wjvi1ZzbpR
 lgPYFrlw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_03,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 suspectscore=0 clxscore=1015 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509230020

On 9/23/25 9:21 PM, Aleksandrs Vinarskis wrote:
> 
> 
> 
> 
> 
> On Friday, September 12th, 2025 at 18:52, Aleksandrs Vinarskis <alex@vinarskis.com> wrote:
> 
>>
>>
>>
>>
>>
>>
>>
>> On Friday, September 12th, 2025 at 12:44, Konrad Dybcio konrad.dybcio@oss.qualcomm.com wrote:
>>
>>> On 9/8/25 8:45 PM, Aleksandrs Vinarskis wrote:
>>>
>>>> The laptop comes in two variants:
>>>>
>>>> * UX3407RA, higher end, FHD+ OLED or WOXGA+ OLED panels
>>>> * UX3407QA, lower end, FHD+ OLED or FHD+ LCD panels
>>>>
>>>> Even though all three panels work with "edp-panel", unfortunately the
>>>> brightness adjustmenet of LCD panel is PWM based, requiring a dedicated
>>>> device-tree. Convert "x1p42100-asus-zenbook-a14.dts" into ".dtsi" to
>>>> allow for this split, introduce new LCD variant. Leave current variant
>>>> without postfix and with the unchanged model name, as some distros
>>>> (eg. Ubuntu) rely on this for automatic device-tree detection during
>>>> kernel installation/upgrade.
>>>>
>>>> As dedicated device-tree is required, update compatibles of OLED
>>>> variants to correct ones. Keep "edp-panel" as fallback, since it is
>>>> enough to make the panels work.
>>>>
>>>> Signed-off-by: Aleksandrs Vinarskis alex@vinarskis.com
>>>> Co-developed-by: Jens Glathe jens.glathe@oldschoolsolutions.biz
>>>> Signed-off-by: Jens Glathe jens.glathe@oldschoolsolutions.biz
>>>> ---
>>>
>>> [...]
>>>
>>>> --- /dev/null
>>>> +++ b/arch/arm64/boot/dts/qcom/x1p42100-asus-zenbook-a14.dtsi
>>>> @@ -0,0 +1,141 @@
>>>> +// SPDX-License-Identifier: BSD-3-Clause
>>>> +/*
>>>> + * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
>>>> + * Copyright (c) 2025 Aleksandrs Vinarskis alex@vinarskis.com
>>>> + */
>>>> +
>>>> +/dts-v1/;
>>>> +
>>>> +#include "x1p42100.dtsi"
>>>> +#include "x1-asus-zenbook-a14.dtsi"
>>>> +
>>>> +/delete-node/ &pmc8380_6;
>>>> +/delete-node/ &pmc8380_6_thermal;
>>>> +
>>>> +/ {
>>>> + model = "ASUS Zenbook A14 (UX3407QA)";
>>>
>>> 'model' in .dtsi is 'eeeeh'
>>
>>
>> Followed example of Thinkpad t14s and CRD, as they set it to
>> 'default' in .dtsi, and overwrite in .dts. Could fix it starting
>> with Zenbook here, but in this case probably makes sense to also
>> drop 'model' from higher level 'x1-asus-zenbook-a14.dtsi' as well?
> 
> Hi Konrad,
> 
> Any comments on this?
> 
> Alex

Yes, ultimately model and compatible should be in .dts only

Konrad

