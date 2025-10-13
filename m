Return-Path: <linux-kernel+bounces-849846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7533CBD1121
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 03:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6BCED4E5A70
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 01:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8923A1F8722;
	Mon, 13 Oct 2025 01:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Yr16g2if"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22C642050
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 01:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760318235; cv=none; b=p4vYoI7hcnvSuO6hrjg2aHWF5yEacz+n7UnBdOaG/WDLyUFF6egd96btzRC8jkYmZiYBFko9OdAvwhnlwe8X6toixCBXrh5yqSoVTdeWISHMk0F2+3Oit3muW7f/Qg9+0o1FK5ajzJeiEYYQUk5G6z5J5zO5yCtKVZGVADr5kmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760318235; c=relaxed/simple;
	bh=eLDXrWIZIZS9HoCmx0lw5R7FSldNWeUebH17d50SzwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PJMcs3FPRaxUV3eA5M1Lc8Zg8+hz0ajWV1Ev2IJZb2AA3vMszoVyBlIX5PMGuz84oH9SmomwA7Kpe6rlZ/Fwt4ibZXE3ZVxn5DoS4Qu0hxZSz1FLYTCRTSkU4TBxncqE2k0+kjTJkbD6IeLGWPHeg1IsmMlMO0dw4TxCINbgc/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Yr16g2if; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59CLsrOB000713
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 01:17:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Kr0l1PGyoz3ywSkxFsHdAj7RmD+86+u7L70Zpf7p2Ic=; b=Yr16g2ifz0A5E27m
	0jOePQAkbUw+Mc4ML2vKzh1MUuAPcktIQ7xn9sza/C6bKWe10zPxoQx327O/SHQA
	CTLvI736DXEM4y6f7seIwm6W5fhbXWdiY9u1pQwF6LAQodwKDGKZ5OIfQ6x9gDiC
	661ShsfImEi7ndY8zYPJjOhtiQFHRuW3i7p8zPXPEP2Is/797bt/TJVEF3xfX3Sr
	6ofPtdBccm1GS1TLp9rivdZS3EJ+aQFnv4PLUMNKhAxnAxoK4QFCPvfYkvZwKdtN
	BUpY/aG/jTSY43IdB43KCxfv9+W7lo9bE7GIcWr7GUeuonrxV0GBkKIVBx+mlyVH
	hMJKWw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qgdftr32-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 01:17:12 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7810af03a63so13098568b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 18:17:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760318231; x=1760923031;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kr0l1PGyoz3ywSkxFsHdAj7RmD+86+u7L70Zpf7p2Ic=;
        b=vRyg8c+1qk+/MBAKnDCGy7wiSCgD7dryXr11HIoluKKHtG7Kd8sgzcLMTYrudojgk4
         8x/q7xZQrieWnQiT1HSdl1n8rY/vZwW8ZvKJBXudoE4ZiRegubFK0TqaChHSK+KWo4Oy
         AxbPm4xqNmnRd7UE07fh04AAW0a3KN6a8UPxnIL0WuDrFPGHhQI2npFyw94ViNWjoe00
         0+fdXIrgCSiaQG99xcbwJyZUz0CX4jvdPS90YGoc0U//5kv2HrkMjncnpMyNoX2nF8Mh
         P6vi+d/KyaflV3a9x2hOuUmY4wGFW2iNQmzJDuKWXP1FAvTQqwCVV3khAEM20OhFQ12/
         quog==
X-Forwarded-Encrypted: i=1; AJvYcCVSA06e6tSrNbyhyGHz8h4gqRDiLdI+AObDSaBlL/QocLa6xu9z1imxASK/oCCbKSlt52N9x46jJ387eiM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+8Q8o9C20tf6fynjx5aqXWqWKDcJloLWGtPdz9RIo1e5/yjMO
	q+4B6W1QjNfmAh1wZ74Ed5TswG6do+NzCDr7ebPDDO11RHDNpRl0gZlf0dVo9gdxwdw3ZgsthkK
	FkyGybu/I5mzIoQnKSnoa29LR4FZkqlhavxrivUX1ONaFNoFLYEpO6jrCy9CsjRb/EHU=
X-Gm-Gg: ASbGncuzNPqcIHrQPe48CswiBqVaqTQkStGAz/lGPeMSfUBb37HI7W352Hap2BUN1Oq
	C9s3lY+SQGD/s4KnZ0t77PbRK2dWH01GWafUiNk8AudXbqG9o7Q3gz/kanbX+pm524BhiJBYdUy
	5xrMoxF04UL+Le7avJrtcQ11fodXVsckxkbESex1tg/D2uBqB1+OijMukwCIhDBXK2TOUqTuq4s
	kdX62QqL7U3y49mEu+SDzVtEMD+WumjKELiGLVatl0lIRq/0iC6+ntfMvkHyBIF6/B40xOb/dmE
	zLtj4+mU2WSXWKjTqbOZub82NKw9RyzNzjz1JiUASiW9/5ty6KCEOM37k2j3531moH9yKpvBoiT
	S
X-Received: by 2002:a05:6a20:94c9:b0:2fb:530a:d665 with SMTP id adf61e73a8af0-32da845feb7mr24545149637.47.1760318231231;
        Sun, 12 Oct 2025 18:17:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbXXwK6X9WWZzaeXl2x5oqTCDc2a3vDXCVPXq5BQZntaW2UbpT4Pvzz/GZ/t/MTiejgocc2A==
X-Received: by 2002:a05:6a20:94c9:b0:2fb:530a:d665 with SMTP id adf61e73a8af0-32da845feb7mr24545126637.47.1760318230792;
        Sun, 12 Oct 2025 18:17:10 -0700 (PDT)
Received: from [192.168.1.3] ([122.164.228.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b678df48a83sm8135399a12.31.2025.10.12.18.17.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Oct 2025 18:17:10 -0700 (PDT)
Message-ID: <2a088c8f-5555-490e-a70d-308a876924ca@oss.qualcomm.com>
Date: Mon, 13 Oct 2025 06:47:04 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: usb: ti,hd3ss3220: Add support for
 VBUS based on ID state
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Content-Language: en-US
From: Krishna Kurapati PSSNV <krishna.kurapati@oss.qualcomm.com>
In-Reply-To: <cbpne2d7yr2vpxmrrveqajlp3irzsglxroxyyjmviuci2ewted@6ewwp6yyybk5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyNSBTYWx0ZWRfX1eJbQvQltpeo
 gAtyCAFd6BnlB4PPCBNtuLj9Q3dBWOGkxciU+mBfcDAbzX1xgIDOxChr+cyxT0QnI9koAUZWDee
 StvmwVyc1VuVjyDGJbz3tRt4LGbkJj7f/HMCdscXXczH5TgOqj75i+OzJersgsY3MbzzV6ml6dp
 oBpUel073dsWVf9tWXa44Fv3de3y9wdVyx8gbE8CJRpudw9WIIpw9fvPktElR3BhWBiTzjSiwYu
 g9lX7IRGmr9VJa5pTUoB6E6GFb/GDKxVh0R9ztQItjg+3iNnz6CNSQ+KZGDEyXe/IAKwy36jCEY
 t3hJtpEGhDQm0dQiBLCN9qeY5x2M2OXN6+URJ4gyNAnzbmmNK6vLefMQTJxqvRwE5gBhESXuAMX
 y+iCrsoDNkSlWv9xFCORe79b6uTKqA==
X-Proofpoint-GUID: 1fK6vgLcF9vnOGUXKWtAah6_rWxzdAAl
X-Proofpoint-ORIG-GUID: 1fK6vgLcF9vnOGUXKWtAah6_rWxzdAAl
X-Authority-Analysis: v=2.4 cv=J4ynLQnS c=1 sm=1 tr=0 ts=68ec5318 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=8YinarrYfdS0Dhyguhy4yQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=JupwLAayHTYr5Hx-38AA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 bulkscore=0 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110025



On 10/9/2025 8:08 PM, Dmitry Baryshkov wrote:
> On Thu, Oct 09, 2025 at 08:15:43AM -0500, Rob Herring wrote:
>> On Wed, Oct 08, 2025 at 09:31:59PM +0300, Dmitry Baryshkov wrote:
>>> On Wed, Oct 08, 2025 at 11:27:49PM +0530, Krishna Kurapati wrote:
>>>> Update the bindings to support reading ID state and VBUS, as per the
>>>> HD3SS3220 data sheet. The ID pin is kept high if VBUS is not at VSafe0V and
>>>> asserted low once VBUS is at VSafe0V, enforcing the Type-C requirement that
>>>> VBUS must be at VSafe0V before re-enabling VBUS.
>>>>
>>>> Add id-gpios property to describe the input gpio for USB ID pin and vbus-
>>>> supply property to describe the regulator for USB VBUS.
>>>>
>>>> Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
>>>> ---
>>>>   .../devicetree/bindings/usb/ti,hd3ss3220.yaml       | 13 +++++++++++++
>>>>   1 file changed, 13 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/usb/ti,hd3ss3220.yaml b/Documentation/devicetree/bindings/usb/ti,hd3ss3220.yaml
>>>> index bec1c8047bc0..c869eece39a7 100644
>>>> --- a/Documentation/devicetree/bindings/usb/ti,hd3ss3220.yaml
>>>> +++ b/Documentation/devicetree/bindings/usb/ti,hd3ss3220.yaml
>>>> @@ -25,6 +25,19 @@ properties:
>>>>     interrupts:
>>>>       maxItems: 1
>>>>   
>>>> +  id-gpios:
>>>> +    description:
>>>> +      An input gpio for USB ID pin. Upon detecting a UFP device, HD3SS3220
>>>> +      will keep ID pin high if VBUS is not at VSafe0V. Once VBUS is at VSafe0V,
>>>> +      the HD3SS3220 will assert ID pin low. This is done to enforce Type-C
>>>> +      requirement that VBUS must be at VSafe0V before re-enabling VBUS.
>>>> +
>>>
>>> Stray empty line?
>>>
>>>> +    maxItems: 1
>>>> +
>>>> +  vbus-supply:
>>>> +    description: A phandle to the regulator for USB VBUS if needed when host
>>>> +      mode or dual role mode is supported.
>>>
>>> Why are we adding the property here while we can use the vbus-supply of
>>> the usb-c-connector?
>>
>> Normally, that's my question on both of these, too. However, it does
>> look like both are connected to the chip. There's VBUS_DET which is
>> connected to Vbus (thru a 900k resistor). So having these here does look
>> like accurate representation of the h/w. The commit message should make
>> this more clear. Honestly, that's really the only part I care about.
>> How it works is not so important.
> 
> The VBUS_DET pin is used by the controller to detect the VBUS provided
> by the USB-C partner and to identify when it's safe to turn on the
> device's VBUS supply. I think this still fits into the description of
> the connector's vbus-supply.
> 


Hi Dmitry,

  In case we put the vbus supply in usb-c-connector node, is there any 
way we can get its phandle reference in hd3 driver given that the 
connector node is not a child or parent of port controller node.

Regards,
Krishna,

