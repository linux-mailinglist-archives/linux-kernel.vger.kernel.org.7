Return-Path: <linux-kernel+bounces-861038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C26ABF1AB7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 891824F5A72
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 13:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BB6319617;
	Mon, 20 Oct 2025 13:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hlaY7ydG"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7783C320A32
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 13:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760968024; cv=none; b=ECxSgGEwwN+XvfShqUHPgD3iJx5JUtANT/tL0LLy0z+cugizraLjY/KJ56pswoSNaZJrGQGsHbwvFNAPLnUKYVW1zIz6LoUUT0b1mgnfqfROMxh/U7keBDUqvDUhlM5Ejpn8KOXW8ZtPsJbUKecHz0YG/Qhl/dZ3+rROhVUg7io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760968024; c=relaxed/simple;
	bh=5N2ARdsS/ZuIaBuo72Vku0v9qrfPbca/h2lmh/Qcn50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DbObezK2m5QSNH5FEaH/9DANiAw6F5QUAKaQRvR1aUu666DXVs2PZ9+WIV2L2CB1lJ3DMvTVOtqv6PsyoD4vzq66vhYrtEYyWHr6NKKOXjYKVcmg4XgNFaSLZ1AE7ZCB2WLGDlkmiPuvqHeCENL6cv3k3W0SzvIBdS/fAA1EVZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hlaY7ydG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KC4pn9002445
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 13:47:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gNmob+5i9GU2NxNnlZc6lAQSEEMIeROWkVxVonp/Vfw=; b=hlaY7ydGU7hivDBD
	2gr5qv92T58Vb5lUdZYRT4ZwHC8HBcWT4aKnIhno+LcnWPGqCJGeS1LCZVT+HtQX
	cfv9tQOSvla5SSVEsrftKW7NCAEJ2qQrFGJozHT+ctfczXhAQnu0KB43KphOT4bo
	JAPs/g03DTCAyS0Y45payV3Kw79GF768HuN1FVU5BHVnIFpW/cFhQoxO67Os6UN4
	kZKo9m2M49fydoClw0XgxYMu87ViEqo+6QJL6zi8+orMcUl3MzKmwrF41SgXIP6W
	431ElNddJETfe78xJrYiapBEivxdNCkvkWCcG62SB5OPFQ080fhXPocPF4wlh83w
	hA5Fbg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v469cug7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 13:47:01 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-78105c10afdso4285696b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 06:47:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760968020; x=1761572820;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gNmob+5i9GU2NxNnlZc6lAQSEEMIeROWkVxVonp/Vfw=;
        b=gLEfGEKhd1ztHX/cHzqsBoB72ILvgwO6i0St34KWOtGwM2Rj3iOQDBmAL0zgmXL4T/
         8YqFfeTYokBfChp0OT/GPqipAunKbdqUJ+2VB1lBEYmANDU6gm3cAnC3VhqzolIzVNfW
         EmkWz+521YG5BP14/FV3pJvqh2bp5kTHQHKta7x/agjPxa04A/Y1N61zhbfLRRzvWTPg
         JP4rhA+lwZDCK3Swy10Xnq7w8scM7ZAg+JX/IGczCd151WY0Y//73ILlLBgILHHEmyuN
         5dQOmEMbGBofDSZ3gs6Av/xLruUlb01DoFLfZOMQcLtq9oArL+3Mj7mCzFzZ4+TcY28R
         aL8w==
X-Forwarded-Encrypted: i=1; AJvYcCWxKDkOI6+euQ8jgJrLZE7TD+IiHHUER24ltI/N77/9jJcrO46DaG2HEY0dlvLnPvX5O2mOBvPIid9VpEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGbLzJpFOHPwiP0ARwmAfwUBLs5LLYNdMb8mKYRndrYoZ9uYJZ
	wsQbzCxytDUYKbk1yz7WKRGO4V15lUJQysVEgTobl5PKBeYzjMDdIBBgWH21d8K7GnlthduQ9Ry
	kgkxFG7YZWkZPJpX789YIOIYqx0JfKhCP6gLXbn34IfUciwHJmEmgW5HtIBRX6H99bRA=
X-Gm-Gg: ASbGncvlVm2GUNDKUH24grnQTg7s4q59kSZwBbBIjI9xwtiFKw5iRu5YX+nRSgN5m+f
	T0HQ1EOB5dpflj6yl71U4Is32tKmExCkCfBEWc1+xNt9CDt8cmBM7hhn80+ohIu2I/KH42LikBJ
	YkfpDMdzSijnw/aKmJxch1CfZu5wl9t7SEvTLOYzd5KefiGL08hX1a/gFwFKpLsPwVE80rCL+op
	fCiv7PpRr8iS6V/QcTWsmAaKrqu5eOrmt/9xPSaLWhrIfMjJJeQPSFBd18ic2NlP8gZngosMywt
	Hd6uWCVO4Z7hWBaiZjuqMUsfikNQquNbypADCguHx/SZyyHUBsRZpphcFS06oKsF6kbq8hCv2ZQ
	bdIE4r215OdzQigDKNBd1PXAUqopaga0RojDzC3ZWLTiYfxF2WPYVTPAR81upYUX+vFg=
X-Received: by 2002:a05:6a20:1a15:b0:334:a915:71a7 with SMTP id adf61e73a8af0-334a91571f2mr11670137637.7.1760968020130;
        Mon, 20 Oct 2025 06:47:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFK4JPkGsprZ1gCfkKOcVDQ4Y0shYt+gowjWqeCAmjdy0yHd5glJ0PVmJ0cSuYKP189ubVbcQ==
X-Received: by 2002:a05:6a20:1a15:b0:334:a915:71a7 with SMTP id adf61e73a8af0-334a91571f2mr11670098637.7.1760968019512;
        Mon, 20 Oct 2025 06:46:59 -0700 (PDT)
Received: from ?IPV6:2603:8001:8403:ab62:4d1e:2cd3:d939:feed? ([2603:8001:8403:ab62:4d1e:2cd3:d939:feed])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff15878sm8355733b3a.10.2025.10.20.06.46.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 06:46:59 -0700 (PDT)
Message-ID: <124be1cd-1cc8-4c04-8aca-eede808e736c@oss.qualcomm.com>
Date: Mon, 20 Oct 2025 06:46:53 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: qcom: camss: Enable setting the rate to
 camnoc_rt_axi clock
To: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, Robert Foss <rfoss@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Todor Tomov <todor.too@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Bryan O'Donoghue <bod@kernel.org>
References: <20251014-add-new-clock-in-vfe-matching-list-v1-1-0d965ccc8a3a@oss.qualcomm.com>
 <9984bc23-05ef-4d46-aeb8-feb0a18e5762@kernel.org>
 <bc0caeb8-c99b-4bef-a69e-5ce433e6b890@oss.qualcomm.com>
 <c4fd6bfc-cc9a-4f37-99b3-f36466691a1e@linaro.org>
 <CAFEp6-2=GJL-gc+PSyAL4=prp_sXdZJS=Ewg5nP2kcp_Gu85Fw@mail.gmail.com>
 <33513b43-f6d1-4c76-887b-39611a75e1f4@kernel.org>
 <WnfCknsSyJK68PQZkE2q7COZHRpsLOFlr3dcbwiVR6SBWtF9iRQ4MGzp_9q31O0kyhZwoncQWfHjJQvpz7nyfw==@protonmail.internalid>
 <ab43c5c9-edc5-459e-8ef7-2aa8bec559c0@oss.qualcomm.com>
 <0e6e1b8a-d9ae-42d1-b1ad-4314e0d76ab7@kernel.org>
 <2c0011d3-a692-457c-9ac0-a445fc82df37@oss.qualcomm.com>
 <48bede40-584a-409a-9bca-7ae3cc420667@linaro.org>
Content-Language: en-US
From: Vijay Kumar Tumati <vijay.tumati@oss.qualcomm.com>
In-Reply-To: <48bede40-584a-409a-9bca-7ae3cc420667@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: sK3LkOr-eBa8l0GVd3tSjfOdGjuH8zXD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAzMiBTYWx0ZWRfX+6zmpx1hS6Fg
 /WNwyZw2h73GWq5kT/a3S/Or9GZceL13H4QQPCSufsOBb1e3rWLjHRKlctlczULeCne2oxiLX4A
 fg496HcIbFGsbgsSuDpD3ylqxvDigSIfTJ3ETsNSeNYOQ0gs3Y0bxh6Az2evCG6ssQVjefA2jyV
 HDpPYOGmv8N7JC4rLxg4lFTYSYESDZvAoutmzxkfbMpKJ9mx2dClyv1EUXrg3Kt6HPXPkWJXxjs
 rxD2e67WphVBIh5DBM5IBs6EeYjAVb2tToYojwbtnDgN+avo7RxiXQ/kRlbGKYdkq+j6VD/Nctn
 i47y7A/u5+ur//NqELJa5xm9Nu5OOgYkgeorF/ixxxCqUrgwZ871jnzOAcciWZVNYYTVsmDzf/b
 aUUe5u+OG0SdwiuN/RrWoVFz6d3onQ==
X-Authority-Analysis: v=2.4 cv=U8qfzOru c=1 sm=1 tr=0 ts=68f63d55 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=Tk2DHZSla7mEwSmGk7kA:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: sK3LkOr-eBa8l0GVd3tSjfOdGjuH8zXD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180032


On 10/20/2025 6:35 AM, Vladimir Zapolskiy wrote:
> Hi Hangxiang.
>
> On 10/20/25 06:23, Hangxiang Ma wrote:
>> On 10/17/2025 7:41 PM, Bryan O'Donoghue wrote:
>>> On 16/10/2025 21:53, Vijay Kumar Tumati wrote:
>>>>
>>>> On 10/16/2025 8:31 AM, Bryan O'Donoghue wrote:
>>>>> On 16/10/2025 13:22, Loic Poulain wrote:
>>>>>>> I'm - perhaps naively - assuming this clock really is required 
>>>>>>> ... and
>>>>>>> that both will be needed concurrently.
>>>>>> AFAIU, the NRT clock is not in use for the capture part, and only
>>>>>> required for the offline processing engine (IPE, OPE), which will
>>>>>> likely be described as a separated node.
>>>>>
>>>>> Maybe yeah though we already have bindings.
>>>>>
>>>>> @Hangxiang I thought we had discussed this clock was required for 
>>>>> your
>>>>> setup.
>>>>>
>>>>> Can you confirm with a test and then
>>>>>
>>>>> 1. Repost with my RB - I assume you included this on purpose
>>>>> 2. Respond that you can live without it.
>>>>>
>>>>> ---
>>>>> bod
>>>>>
>>>> @Bryan and others, sorry, I am just trying to understand the exact ask
>>>> here. Just to add a bit more detail here, On certain architectures,
>>>> there is one CAMNOC module that connects all of the camera modules (RT
>>>> and NRT) to MMNOC. In these, there is one 'camnoc_axi' clock that 
>>>> needs
>>>> to be enabled for it's operation. However, on the newer architectures,
>>>> this single CAMNOC is split into two, one for RT modules (TFEs and IFE
>>>> Lites) and the other for NRT (IPE and OFE). So, on a given 
>>>> architecture,
>>>> we either require 'camnoc_axi' or 'camnoc_rt_axi' for RT operation, 
>>>> not
>>>> both. And yes, one of them is a must. As you know, adding the support
>>>> for the newer clock in "vfe_match_clock_names" will only enable the
>>>> newer chip sets to define this in it's resource information and set 
>>>> the
>>>> rate to it based on the pixel clock. In kaanapali vfe resources, we do
>>>> not give the 'camnoc_axi_clk'. Hopefully we are all on the same page
>>>> now, is it the suggestion to use 'camnoc_axi_clk' name for
>>>> CAM_CC_CAMNOC_RT_AXI_CLK ? We thought it would be clearer to use the
>>>> name the matches the exact clock. Please advise and thank you.
>>>
>>> The ask is to make sure this clock is needed @ the same time as the
>>> other camnoc clock.
>>>
>>> If so then update the commit log on v2 to address the concerns given
>>> that it may not be necessary.
>>>
>>> If not then just pining back to this patch "we checked and its not
>>> needed" will do.
>>>
>>> ---
>>> bod
>>
>> @Bryan, I test two scenarios individually that also consider @Vladimir's
>> concern. I confirm this clock rate setting is necessary.
>> 1. Remove 'camnoc_rt_axi' from the vfe clock matching function.
>> 2. Remove 'camnoc_nrt_axi' from the vfe clock resources in camss.c.
>> Both of them block the image buffer write operation. More clearly, we
>> will stuck at the stage when all buffers acquired but CAMSS takes no 
>> action.
>>
>> I agree with @Vijay to keep 'camnoc_rt_axi' to distinguish between the
>> new one and 'camnoc_axi'. The disagreement concerns how to standardize
>> the camnoc clock name or how to differentiate between RT and NRT clock
>> names if a new RT clock name is introduced. Other chips like sm8550,
>> sm8775p depend on 'camnoc_axi'. Meanwhile, 'camnoc_rt_axi' and
>> 'camnoc_nrt_axi' are both necessary for QCM2290 and X1E80100. But chips
>> like QCM2290 and X1E80100 may not need to set the clock rate but
>> Kaanapali needs. @Vladimir
>
> Thank you so much for performing the tests.
>
> I would want to add that I've made right the same tests for SM8650 CAMSS,
> which also has two 'camnoc_rt_axi' and 'camnoc_nrt_axi' clocks, and due
> to my tests the latter one is not needed for the raw image producing, you
> may notice that I've excluded it from the v3 series sent for review:
I agree. The NRT AXI clock shouldn't be required even for Kaanapali for 
RT blocks. @Hangxiang, can we please try to understand this better? 
Either way, I think the NRT clock part is not connected to this patch 
series I guess? Just as Bryan advised, we confirm that the 
'camnoc_axi_clk' is not required for Kaanapali to close out the comments 
on this series. Perhaps, we can continue the discussion on the NRT AXI 
clock in the Kaanapali patch series? Please advise.
>
> https://lore.kernel.org/linux-media/20251017031131.2232687-2-vladimir.zapolskiy@linaro.org 
>
>
>> We now prefer to add 'camnoc_rt_axi' (Right?). Maybe its better to add
>> comment lines to remove the ambiguity whether 'camnoc_axi' denotes to RT
>> or NRT. Please advise and correct me. Willing to receive feedback and
>> suggestions. Thanks you for all.
>

