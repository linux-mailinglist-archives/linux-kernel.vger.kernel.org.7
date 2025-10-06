Return-Path: <linux-kernel+bounces-842948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A8ABBE089
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 14:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8B8A84E5DA1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 12:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0225E35898;
	Mon,  6 Oct 2025 12:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LiJcCMmc"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64A327EFE3
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 12:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759753909; cv=none; b=tcEhPxJOeORQaas0/KyrNtm//HHrPSao0RvGy+sGP2avukDydPzWai312XT6Yk5yxX5M01n9sBAjUSfySgkcjyC4vMwLkHCjb23ulZxqAzc2d+4JJOoyF7YMUUyf+EruuUUcpu/58NTHf1N/830Se8hiW3tv6ei71FszKaZimv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759753909; c=relaxed/simple;
	bh=CJ/li2NjwE/vxWhoTWEa6diBIASq688SzguAh5XwGjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r7LqC35qnlpJgqfBt0d+9KtK1iHj/dwmrSuDsNG/p0d5GADJCswgTPoq6G9ajOCRNPDckwVIkIwaMri806O16tOtEVq5dL1mzRqvmKwVQyAncWM9wLqU8qlQZI5hstccbt7gQDg/OoPQFwcDP8d6BnfQuS3k/JCXhdvosHP7amM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LiJcCMmc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5963OFJW007214
	for <linux-kernel@vger.kernel.org>; Mon, 6 Oct 2025 12:31:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MJ03y25vxsCsNKFBtqgk2JlRNOCgTcb9CSsSI7FvbDM=; b=LiJcCMmclSa6bean
	Au3kbgijp3jXTYwbiVF8Qu8VlfptEcTiN45v+R1oKSGEYtUb3RgB/HYh8uuoh8mx
	JHWwhO2Dlj1LbzIk7QKY9nbDLOgU7XcC0lZ0kUdjtogEnMqfs168XZolt0wcIZ/t
	rYsFMbD8jfOLp3J7imNImgJYYoRGhlJyg0fwJe5AzouX3XKqoM+QtpMviF9BuOUr
	sl8IYiBUxYszVFxC+lfE1hXQx/q0xQUzTPo2fhHQzg+WhNquuRWRV2+wA2PgMWfB
	NX+9ttBz3yLQYdXanAULde2QeN+6+QIrNoa8P9X/Y1D5rIoJFf+ZPAGnSBj2wluE
	ngE/6g==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jut1ksd1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 12:31:46 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8747323272dso14876096d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 05:31:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759753905; x=1760358705;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MJ03y25vxsCsNKFBtqgk2JlRNOCgTcb9CSsSI7FvbDM=;
        b=IhW/wXGIHfoDd2cQppPZdoEYXKWylHpKfMRj9joe4DhnlUQUwFkFfP7PhJjzq/H3eh
         tXVm5buPHLvjd+2rBmSRkARSO9sHh7vuI2GEe0zACgZCKobDBQz0G8ojNFp9V9zI7Zun
         YlU9Ld+Cu9Da+boYeyGKKgdk+cLsWBRM97fkfPWvHcS0WLf96Zj6BBK7bM43srGBiPKz
         dDVgVYlChV1iZr9/TBWD1glGVC+00ScoRNEajjveWrpf22ivHTKwBAVT+0NKrZBrK9Ov
         TpfIsDDXcEZuijE4S8hffuxVaPTrJP+gVW7aaGrLt1ZeJyjCGHx5nYmpYrVQ/7VT+TFa
         CR6g==
X-Forwarded-Encrypted: i=1; AJvYcCXmtifaNsny9JgFzpJHvsUKPh6UCmF8Im/gI+CesnCWNqHmOobwqoJYKfiL9rpy9MM2jLb7D4TkmiXyqq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNJ34reeua3hm3cmcaIyG/5kxzy9HkjMgIjxp0klMc62eeRTM3
	6KTY5n9UJbJvKoYKBMqZ7h53ZHec7rYSvuI9+f9ripEIOfSne+07iqWGUy27okn/WDUm+DFCX4l
	DBXSKeaVYu8mo4hugWw7/JXqKveQEfnWriC5FLTsBOjnPZ6SHEJwblsM20Jei02UH+8s=
X-Gm-Gg: ASbGncu1rFpNyc1iUxUGroF1DHuMOhAb9N+QOa4HBBe3kf52DU05YNilxiyLH9gUuzb
	7OjXqz/3rNF08OFs/Ig+kKBiLXkaJ8MMio32KfHzoN/ziPpIftX7ok97fLKRcP5XO0KjS+gyxms
	GQBT9yUnVcmVV5XWt2xtcuYtObFJBTDViPW46Nu7wiWRB36jfmB3oyg9Xgl5MD5ByJbKPy3m7eI
	JczRtbz+/B2cSMR6LsCTN5yN5w0soIcEWLCdYs7ZOeNE3PG3yvA6bjqBTIyB0BIGm0KwZ2s+Tpn
	NSJRWnUT+p+t+8XbNAio6QsTsbm4mr5dVz6ZQgAaxftUu2n5SJATUHy+LLnw3mNdV6tnyLbv5II
	fL2qW0MSMYFuolvh6rAdHEGuRI8I=
X-Received: by 2002:ac8:594d:0:b0:4b7:94ee:4fb2 with SMTP id d75a77b69052e-4e576a4b20bmr93180091cf.5.1759753905526;
        Mon, 06 Oct 2025 05:31:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2WqYRw9tJAwkCWVZULEkhWrsi+IGiAs6DfmjaXLOa0kXsbazcsb/WKotgM+3e30+bN9qdAA==
X-Received: by 2002:ac8:594d:0:b0:4b7:94ee:4fb2 with SMTP id d75a77b69052e-4e576a4b20bmr93179591cf.5.1759753904846;
        Mon, 06 Oct 2025 05:31:44 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b48652aa02asm1139837766b.8.2025.10.06.05.31.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 05:31:44 -0700 (PDT)
Message-ID: <c21a408b-ec4f-4de8-a9b6-ca25410ace6a@oss.qualcomm.com>
Date: Mon, 6 Oct 2025 14:31:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] arm64: dts: qcom: r0q: enable hardware clocks
To: =?UTF-8?Q?Eric_Gon=C3=A7alves?= <ghatto404@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250920014637.38175-1-ghatto404@gmail.com>
 <20250920014637.38175-5-ghatto404@gmail.com>
 <d16e8c07-6c10-4c91-9bbe-a260f0497d29@oss.qualcomm.com>
 <99D0B281-03A5-447E-A6BF-892C99829D0B@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <99D0B281-03A5-447E-A6BF-892C99829D0B@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: deFBVnrf2974DBDyWEr-5rNGdPl0PtJ1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAyNyBTYWx0ZWRfXx4LgdVmkkDqt
 e0I/At9TMjuFgZODR4KV/oLkcwKj+vEtMvBH77tr0iLVi45q6YjXXhb3dEYjM7etB2+uXyw+Lpn
 q2DX8RLM6WfvcPi6d7/R8TmfKxbKT7q69SLOQWKUSWysss84IdVQ3fArtawpc65XMl5VB81f8FV
 tqWTMSkj5bT6NfAvjgQMovXuvMBDeYmnkWFdmGqjMZn5nZiHZhBD7FfvGgjEZ8iS1AgLXvEAYyK
 d4i7AsWAIeJkWCh2iwb9u3NfhElUGRw/7BmIBmcxW8bLByoY8CqggiYVmJrIdf2ZitSCxTvvLGw
 I0zOD+ErRxsJ/MyzNwNtGzRcXX2AmAPRibMz+2rm7VzaH/4CHcB2e6C5nHOuv3zg/KzNF7w2nGE
 Sj3kxNb77du9uht2qztBOzPePNp+JQ==
X-Authority-Analysis: v=2.4 cv=Vqcuwu2n c=1 sm=1 tr=0 ts=68e3b6b3 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=J7BwVpqbZ6fScHfkYVcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: deFBVnrf2974DBDyWEr-5rNGdPl0PtJ1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_04,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040027

On 10/5/25 5:50 AM, Eric Gonçalves wrote:
> 
> 
> On September 25, 2025 10:09:48 AM GMT-03:00, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com> wrote:
>> On 9/20/25 3:46 AM, Eric Gonçalves wrote:
>>> Enable the real-time clocks found in R0Q board.
>>>
>>> Signed-off-by: Eric Gonçalves <ghatto404@gmail.com>
>>> ---
>>>  arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts | 15 +++++++++++++++
>>>  1 file changed, 15 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts b/arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts
>>> index c1b0b21c0ec5..c088f1acf6ea 100644
>>> --- a/arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts
>>> +++ b/arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts
>>> @@ -225,6 +225,21 @@ vol_up_n: vol-up-n-state {
>>>  	};
>>>  };
>>>  
>>> +&pmk8350_rtc {
>>> +	nvmem-cells = <&rtc_offset>;
>>> +	nvmem-cell-names = "offset";
>>> +
>>> +	status = "okay";
>>> +};
>>> +
>>> +&pmk8350_sdam_2 {
>>> +	status = "okay";
>>> +
>>> +	rtc_offset: rtc-offset@bc {
>>
>> Is this an offset you took from somewhere downstream?
>>
>> Generally you *really don't want to* poke at random SDAM cells,
>> as they contain a lot of important settings (incl. battery/charging)
> From another sm8450 device, I'm sure it's okay.

That as an argument alone doesn't sound convincing to me, since vendors
also sometimes repurpose unused-by-Qualcomm SDAM cells

I actually found a data source internally and this cell you're trying
to use is reserved for PBS (see drivers/soc/qcom/qcom-pbs.c), meaning
you already fell into this trap..

Konrad

