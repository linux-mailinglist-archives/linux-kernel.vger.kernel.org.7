Return-Path: <linux-kernel+bounces-852724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BC763BD9B54
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7916C4E1745
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F082D248A;
	Tue, 14 Oct 2025 13:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ILJyri79"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C322521E0BB
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 13:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760448532; cv=none; b=rz043SvWDmQC+pylmqSz5YKLxsz+iRYuLapMA7iOSJTq6pZmoHTLGp5n7UYTUGvoF3/0lIEc/4xiQ+sdiBvNGvrv4G3zvc1NTJBB0gUmzi7Je1WLNvKSZFia0krYOeADxz4WUCu2qv1jN4vE+OyF4FRLMX5iE49g/oi/N44nnXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760448532; c=relaxed/simple;
	bh=74VghsycGNMWOan5TOjrZsd2bCurtNuYWOOPyoyHuG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H5xItwkXjWYX+XPOpADbgrjACdaOVFZ9cK+0yHSDIVADWD67XDELmuno6wJujD8wsiQHFTCHEDqJovQIQcJ9acz6Wpik3HmqaI1Twdn858KKI5AH+iELOjGfb0VYi4MR3PnX3/a72qYle5PhH69bXbNv+FFnwkBXFXdKBoUEpWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ILJyri79; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59E87LXC008659
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 13:28:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TH3Wy1bSw9Z+42cb2jIA73zJRFGOGkqejjZW60B+Ils=; b=ILJyri79fqu3hf1A
	6sqi4p5WbER2T4+CJZzuONE73jt2WeOyY1QsIQ1tXNt+Qzfbcpz1JcJL3GLpx/wv
	SCeSFYumotXWGIw25qJUeiKQJYwXjLTu1f/2lX4Om8MkMcIo44FE68PjQP0tYG4Y
	2fUm+kXUimquR88R5AmHUpqbszlsamAADUNGl0gUKLE/scDJuKz4f3TGqQkQym4t
	yaZ2XBpDNjJaJQvelWDeAwcyoRebQra+s/mAu6BbdXK7wsSE9/Ek5Hv803lnLqkc
	9WRrbraG5kz8DWsasqkQzISsdr7OrBEJ7dUp05rns0Hst4lCrLL/NtAGHrzTlNyd
	d+MIdg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49rtrt5fhq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 13:28:49 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-883feb13e83so3125600385a.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 06:28:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760448528; x=1761053328;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TH3Wy1bSw9Z+42cb2jIA73zJRFGOGkqejjZW60B+Ils=;
        b=lDTqI+5Prmi0074JdYRQ+nM+V0Fbk4d4m0vsnPVv0kiZrbsPbGIeLZOIoCjhQnzRod
         VIxBsK8eewHEWdELegfye5R3wjf0Fh8JeG5f2bSENPvPb9SNR72TZrfXMipWa/aq1Zfr
         o4d2W5qOxs/G/925NkbqRzqEyed3PaEr3rUsilB9eBcdQWOvJVxCKD6o+nS6kvpNOKth
         oETWYuGbrBMhKrFizTDHfHzqi82BsUZ2iXEWqXJpuFiB/aHhA+3U3c8JE6Ud1vmJE0VX
         ExIN1L2z/lkFa/NO0HKQ+awJu2nCTRYW06YAUy0KeVv3U8rds7m52+IjipBHNlbiFlrd
         Ce8A==
X-Forwarded-Encrypted: i=1; AJvYcCVkhD5Ixh04jnegySWTCRkLgEKw0T7uUDeBQ26U7EkNYILOJbIYn23VmqpkhruYOTC+VLQjpmQez1RxtuM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFCPSQSuAVJiXZ77xvNnE5mH/m9d8S+haW7S3N/UznYMkKxdPD
	0Ig2hR1dxp4JFMiNdyod40BUWUOon+EpGY5nyO38z6g2ITHFDMBaH9hlmW+lj5j4eDzw1i1j7eU
	74gEgUnjx0seA647NJJSIGhZNm9Lpp0tFk0NyqqI/QHniG52H0ThQt73s51R3585w5/VmU/gqY+
	Q=
X-Gm-Gg: ASbGncvLvxwlcs+G1M01xHXzDf3jt2iPS0W7TFHVoqcafB7Na4YRcfJy9J5J4In7hEU
	DAzWPdlOmi6zsSaD8pcUMoPr80CLtaczKdapGO/0XX3ExQAjoD9aacmVHe3fue6Noe9aSDGzu6G
	H2hHa5qk0rrk5cHxo6bdmsULlaFOG15ScKzPZlbFcw1x7jjqY6nj0dG/7Mf70DNnPcyc7yNw68W
	RQ+rTxdxB7ZFz8GHxdUZbVgsqINd4LT5KJeXTNp1MyTfUxDWqP3qlCYmDSpVkEJG5HfSIDijOse
	UfgERmebj8npGVHL/gb8swF+dXWUWMNBo/w3ms9JlnYY1B54KOTva8bQlOlNgBsGFVQRKU62bdD
	xrqP4lxnJCeBHzqVGY2w3I0Fn3MP56qg1s6dK8LSC9YI4DomF8riX8a1ueFx9+BfzC8wcG0K/lQ
	5Zm3A/
X-Received: by 2002:a05:620a:170d:b0:82a:9b78:3db1 with SMTP id af79cd13be357-883527b69camr3008959385a.69.1760448528071;
        Tue, 14 Oct 2025 06:28:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2bfAyGNnHmgq4ANdRlYx9LaJ9D28SHtQnX5Z/A+4bdTv14DYc6LMQKjCTLblXwmAOSBpbPA==
X-Received: by 2002:a05:620a:170d:b0:82a:9b78:3db1 with SMTP id af79cd13be357-883527b69camr3008954485a.69.1760448527335;
        Tue, 14 Oct 2025 06:28:47 -0700 (PDT)
Received: from ?IPV6:2001:99a:252:3300:d706:9b57:5996:15b4? (n2i9bzmlzk2z87merp0-1.v6.elisa-laajakaista.fi. [2001:99a:252:3300:d706:9b57:5996:15b4])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-590881fe5besm5252949e87.50.2025.10.14.06.28.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 06:28:46 -0700 (PDT)
Message-ID: <7392a020-c749-4928-895a-4e104d7e1769@oss.qualcomm.com>
Date: Tue, 14 Oct 2025 16:28:46 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: usb: ti,hd3ss3220: Add support for
 VBUS based on ID state
To: Krishna Kurapati PSSNV <krishna.kurapati@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251008175750.1770454-1-krishna.kurapati@oss.qualcomm.com>
 <20251008175750.1770454-2-krishna.kurapati@oss.qualcomm.com>
 <odikli6rfdyid5oqavurtqytgnwgh5hpmka2jt5tprpdw7cd72@icpnjnkfowt7>
 <20251009131543.GA379737-robh@kernel.org>
 <cbpne2d7yr2vpxmrrveqajlp3irzsglxroxyyjmviuci2ewted@6ewwp6yyybk5>
 <2a088c8f-5555-490e-a70d-308a876924ca@oss.qualcomm.com>
 <CAO9ioeX51SzaMS4TK7=xfCXBNYi7SGsMBZAv4FrZ1LzONWFw3A@mail.gmail.com>
 <654b804d-fbeb-45ea-a6fd-9d551224c934@oss.qualcomm.com>
Content-Language: en-US
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
In-Reply-To: <654b804d-fbeb-45ea-a6fd-9d551224c934@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: OjNW3k7pNP8PfT12E1D-ASjiIcKFpdUC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDAyMiBTYWx0ZWRfXwQh6/0D1ITgK
 v3D3iGMMCE9v2M+Z//m5C8XNlSoanQVLhSo4B6B5u6y3OGgxqnsCVbYIX920n83xOCXeeteyyjL
 iXTGfSlWNR5BlvBU/ovYZQAabRi8CmwN9LOFdk9HpEYTe5gzBUAL0xs2CswGwUzTK+2k+B2LRhK
 uNMjeE6PhBT0V086RpHZRAlmVdxecqKphOZvL25lGsRmIw2udrfhq4KZJiOK0lzF0DHLANsa3S3
 LQP4IJfBITu6whzVhfbtB6Z9Y168vfJrCB2QZ8XDYn7vtRSXtvk46UweRGbNom76kkyxzwFSvmn
 rigQwsDDDpYmsRfUcoRbgIHX6wroPa9cVCL8lqg0AxiZJNSQCc6Hfh/CQ9Jb+jOlqJJ7dKjhUHW
 MRKXMWMqkAk6WW+tnhMAHs5/uHqP3w==
X-Authority-Analysis: v=2.4 cv=SfD6t/Ru c=1 sm=1 tr=0 ts=68ee5011 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=kfguzciIMWHQBG15V5QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: OjNW3k7pNP8PfT12E1D-ASjiIcKFpdUC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130022

On 14/10/2025 05:39, Krishna Kurapati PSSNV wrote:
> 
> 
> On 10/13/2025 2:38 PM, Dmitry Baryshkov wrote:
>> On Mon, 13 Oct 2025 at 04:17, Krishna Kurapati PSSNV
>> <krishna.kurapati@oss.qualcomm.com> wrote:
>>>
>>>
>>>
>>> On 10/9/2025 8:08 PM, Dmitry Baryshkov wrote:
>>>> On Thu, Oct 09, 2025 at 08:15:43AM -0500, Rob Herring wrote:
>>>>> On Wed, Oct 08, 2025 at 09:31:59PM +0300, Dmitry Baryshkov wrote:
>>>>>> On Wed, Oct 08, 2025 at 11:27:49PM +0530, Krishna Kurapati wrote:
>>>>>>> Update the bindings to support reading ID state and VBUS, as per the
>>>>>>> HD3SS3220 data sheet. The ID pin is kept high if VBUS is not at 
>>>>>>> VSafe0V and
>>>>>>> asserted low once VBUS is at VSafe0V, enforcing the Type-C 
>>>>>>> requirement that
>>>>>>> VBUS must be at VSafe0V before re-enabling VBUS.
>>>>>>>
>>>>>>> Add id-gpios property to describe the input gpio for USB ID pin 
>>>>>>> and vbus-
>>>>>>> supply property to describe the regulator for USB VBUS.
>>>>>>>
>>>>>>> Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
>>>>>>> ---
>>>>>>>    .../devicetree/bindings/usb/ti,hd3ss3220.yaml       | 13 +++++ 
>>>>>>> ++++++++
>>>>>>>    1 file changed, 13 insertions(+)
>>>>>>>
>>>>>>> diff --git a/Documentation/devicetree/bindings/usb/ 
>>>>>>> ti,hd3ss3220.yaml b/Documentation/devicetree/bindings/usb/ 
>>>>>>> ti,hd3ss3220.yaml
>>>>>>> index bec1c8047bc0..c869eece39a7 100644
>>>>>>> --- a/Documentation/devicetree/bindings/usb/ti,hd3ss3220.yaml
>>>>>>> +++ b/Documentation/devicetree/bindings/usb/ti,hd3ss3220.yaml
>>>>>>> @@ -25,6 +25,19 @@ properties:
>>>>>>>      interrupts:
>>>>>>>        maxItems: 1
>>>>>>>
>>>>>>> +  id-gpios:
>>>>>>> +    description:
>>>>>>> +      An input gpio for USB ID pin. Upon detecting a UFP device, 
>>>>>>> HD3SS3220
>>>>>>> +      will keep ID pin high if VBUS is not at VSafe0V. Once VBUS 
>>>>>>> is at VSafe0V,
>>>>>>> +      the HD3SS3220 will assert ID pin low. This is done to 
>>>>>>> enforce Type-C
>>>>>>> +      requirement that VBUS must be at VSafe0V before re- 
>>>>>>> enabling VBUS.
>>>>>>> +
>>>>>>
>>>>>> Stray empty line?
>>>>>>
>>>>>>> +    maxItems: 1
>>>>>>> +
>>>>>>> +  vbus-supply:
>>>>>>> +    description: A phandle to the regulator for USB VBUS if 
>>>>>>> needed when host
>>>>>>> +      mode or dual role mode is supported.
>>>>>>
>>>>>> Why are we adding the property here while we can use the vbus- 
>>>>>> supply of
>>>>>> the usb-c-connector?
>>>>>
>>>>> Normally, that's my question on both of these, too. However, it does
>>>>> look like both are connected to the chip. There's VBUS_DET which is
>>>>> connected to Vbus (thru a 900k resistor). So having these here does 
>>>>> look
>>>>> like accurate representation of the h/w. The commit message should 
>>>>> make
>>>>> this more clear. Honestly, that's really the only part I care about.
>>>>> How it works is not so important.
>>>>
>>>> The VBUS_DET pin is used by the controller to detect the VBUS provided
>>>> by the USB-C partner and to identify when it's safe to turn on the
>>>> device's VBUS supply. I think this still fits into the description of
>>>> the connector's vbus-supply.
>>>>
>>
>>>    In case we put the vbus supply in usb-c-connector node, is there any
>>> way we can get its phandle reference in hd3 driver given that the
>>> connector node is not a child or parent of port controller node.
>>
>> Sure. Use devm_of_regulator_get() passing connector node to the function.
>>
> 
> I am not sure if I am asking the right question, but in case there are 
> multiple connector nodes, each one corresponding to one port controller 
> node, how do we get the reference of proper connector node in hd3 driver 
> since the port controller node and connector node are not parent/child 
> or each of them don't have reference to one another.

You have of graph connection between your Type-C controller and the 
USB-C connector. So you can use the of_graph API to get the connector's 
device node.

-- 
With best wishes
Dmitry

