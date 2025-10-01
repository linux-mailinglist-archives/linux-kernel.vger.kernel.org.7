Return-Path: <linux-kernel+bounces-838594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CDEBAFAA8
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 10:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73241189FF29
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 08:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8B427B35D;
	Wed,  1 Oct 2025 08:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kVHewn4u"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7728E283FC2
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 08:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759307882; cv=none; b=OuosWDBlQ+JBHxPYeBhO1+UypOLHxlop6xMmqBOqjqetj7PuELRI4Ph6bEdWl35nw8FOXE4+/fkmmrxrwF2UxGaBG6aJkH/aOxuvX0AL25xP6Ms0lxrSB1/H5sqIsa67OuyBTMPKXUikv/7IiF5aWoGBwZombISdDuNwIS0i8UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759307882; c=relaxed/simple;
	bh=SOdkjX+XhcQsICcnoi6ql60tKZY6QeQ8R+2qWbiph7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jcN/fsSD1yZ/l5/H2+UeK6T+d3fVt6hFMdkTFXTsGQusKirTCZE3seRHz8+8Pfajy5qgi9j76suzHtGWxBiIOPFRED6HqLjTE4yz+hzgekOH0rws2YgBUS4gV66DbmmoYUn2oE2kqnC/O4UlSsHhDh58p9un4E1cWtVnu4GWUJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kVHewn4u; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ULFGSV028127
	for <linux-kernel@vger.kernel.org>; Wed, 1 Oct 2025 08:37:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KUFK/Ss0L+GF41vSD/7pSbyI+R1mc9WDz2eWU41Xx5E=; b=kVHewn4uRHjzBxmN
	Flm/1Jx7dkSemhnTbNVmBuI46bOtjsQ7yoIlvUhPOXiRikvmJ48rI4kBzOsPPiY4
	9aIGbefxkauuk6XciVy0M+ujtPpGMXDVDbO6Rb7VBaTmYxG8xERMLr+rT2/ph2iV
	UhcAnu9UHM9BmpM4o+mTA5l6yAHTAG4fxMnJFwlSO9Wgn0MvF6/0QG0/u6oZbcye
	UnHqVx1aHACN5kUMvGHgTf8s0QJmWSr9H5m1NZYqpdh4ewANAegUIhHOIXKyaOuO
	M35Adk7y1VllkUbKkUumatcevZry4gGj4zqS3oWc/mH1G+/uxDdpD79tJt61/QLe
	iYssKg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e851kvqv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 08:37:59 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-82b15c1dca8so240917185a.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 01:37:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759307878; x=1759912678;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KUFK/Ss0L+GF41vSD/7pSbyI+R1mc9WDz2eWU41Xx5E=;
        b=NHLPYqgdIdunRjmD/gQoQ6kpjNpzxRJCmJIANEc+NNKhEOvGpWh22eT1vXn+M3C9KV
         O9v8bZvLnZiv9D1Mi2XW4+Er3fmW3MRtu4nXQqYjNgZQOw+YpGj3+OfC0nQRQEmhgnFi
         lV2IDjrzg0qDFNsoOwUWCzVI6LzO3DMnEo636N6gxJgyQ8KOuLcOpxjlHq1Tv1JQ+/f6
         8/RFoZWCz4xWyC7n3srOnuCWCowLg8X3GbCfMDmSxz5E9jdMHPqPWRu5VMSvwaxtrgA7
         qL4fmNKpHfUlr8A3yq3iRQuemWiEcXGu6s4YRoQ+65ihgJPjUefm2r+doyO7BPeVurpd
         2eDw==
X-Forwarded-Encrypted: i=1; AJvYcCX4dGTZbOda7Mhurw4GtZrKM/H9x9xP6ITlA3b5grEZ19kMvsEpuL4foiJJ5WHWc4Fijz/H23zoRNTDb5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWvhhd5Wee1OGvlmyTeHzdD6RGSFzu5ejDrbZLuj+1Ch4vSMes
	+fiar8LjZgN6lnpcTm+nc41V/C8KoAdVlk2vpQPzbWsuA7WX5tQfhrOqRkQnXpkusFU2RcKdOv+
	3ZDQaHfph784K1HCcg+7f/0avGIQ4wQlPFy8q1wJ88Rf7vhr+KBqr27nyYIlrkJ+FKS0=
X-Gm-Gg: ASbGnctkPEdtes/dAoiNDIsTM63Dmeyjy2jaw+kHzpBYs1bqTHFfSydxkhfwt085x4y
	QB1vOkp5VSzgVYjNdl86N3FgNDvWMtv+UJR6OFo504OonLy3Ox2OJdWF/yuppdOmN/NJhVH7fL0
	UCWdHsb4wtisopR7UcQpfkdG/Vd4eFMIZ54UJT1HAQx4GsXyyQUOIsUwuK14tZjOhhY2xJyErqV
	zHuCy4WzEygq/znTqXGTJZJXyX//BeVWtK2oWcIdbfgkia1GETcJXLqUVUcjA2uG/pgGmelHL2p
	SYe25rjTUbu+t4e/CtlxM/h1jtzUSFMRDgIf02qdLZw0DLte/zB0zvIctgPHL5PffpyH375JRCA
	/808wbhJppjvHGi91WrvLSlqNpq4=
X-Received: by 2002:a05:620a:294a:b0:863:88f9:3edf with SMTP id af79cd13be357-873768a51dbmr256003785a.13.1759307878242;
        Wed, 01 Oct 2025 01:37:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdWKramJMBSaYig5g7VcPPZxYTiTru0aoo2NQ2bTcuSp9N2EDYIbAH6ZqLIO1HALQ6lWfzyA==
X-Received: by 2002:a05:620a:294a:b0:863:88f9:3edf with SMTP id af79cd13be357-873768a51dbmr256001385a.13.1759307877747;
        Wed, 01 Oct 2025 01:37:57 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3f57c9c2e2sm562881666b.68.2025.10.01.01.37.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 01:37:57 -0700 (PDT)
Message-ID: <d2b1aef1-b367-482e-87f3-eb08d0bee9cd@oss.qualcomm.com>
Date: Wed, 1 Oct 2025 10:37:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] arm64: dts: qcom: qcm6490-shift-otter: Enable RGB LED
To: Luca Weiss <luca.weiss@fairphone.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Casey Connolly <casey.connolly@linaro.org>,
        Alexander Martinz <amartinz@shiftphones.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luca Weiss <luca@lucaweiss.eu>
References: <20250930-otter-further-bringup-v1-0-7fe66f653900@fairphone.com>
 <20250930-otter-further-bringup-v1-5-7fe66f653900@fairphone.com>
 <fc5d2d9c-7200-416f-ad89-4c1907e313c9@oss.qualcomm.com>
 <DD6UFOT1KRFG.3M6QJRGYRAJF9@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <DD6UFOT1KRFG.3M6QJRGYRAJF9@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=OJoqHCaB c=1 sm=1 tr=0 ts=68dce867 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=dlmhaOwlAAAA:8 a=6H0WHjuAAAAA:8
 a=_VV5rCy9AiPTaJ_phtcA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=y4cfut4LVr_MrANMpYTh:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAzMiBTYWx0ZWRfXwwl1E/x3E65b
 gaNsEhsGdXVGXlhUwHwDZOsuI4m1QTrpfJId3YldNzL0uumkdwfyYDrkaswz9clblzfobKjuq6O
 TqvMto+KtVbfA1zdIplpjRUQnzbxDn+MSahdv2cCE1OHH6AW9ItGetPoBd5/wCiugb/QoW+vwYV
 pEuovNZ550+xMxud6Mo/GsN6ItOfRRxX4N+vKBFYGT+G7VGshmfdxdoGpCNcMLdAxf4RYz9yK8l
 LL0NJuuYw+QzDrCtSXYL5q91G5FdYgGNC48UHTK0pr9Kd7gBH0Xn8v9rrGgEFPnyWk7HzRhH4do
 IGy6QpHGCvMLz1P2/HKTh7ADCZgHp/5EVIlOaQ/stiTTeSm3sWd5R1/cPQDj701lSSD09sCLVLh
 q0kecIdZoWDgZ5M5Er7K3+R31TPYcg==
X-Proofpoint-ORIG-GUID: Ui2WHYlGOWWbXywVQ_C-Cj73KCXa_B1K
X-Proofpoint-GUID: Ui2WHYlGOWWbXywVQ_C-Cj73KCXa_B1K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_02,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270032

On 10/1/25 10:30 AM, Luca Weiss wrote:
> On Wed Oct 1, 2025 at 10:29 AM CEST, Konrad Dybcio wrote:
>> On 9/30/25 4:32 PM, Luca Weiss wrote:
>>> From: Luca Weiss <luca@lucaweiss.eu>
>>>
>>> Enable the RGB LED connected to the PM7350C (PM8350C).
>>>
>>> Signed-off-by: Luca Weiss <luca@lucaweiss.eu>
>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>>> ---
>>>  arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts | 27 ++++++++++++++++++++++++
>>>  1 file changed, 27 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts b/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts
>>> index 36cc67469615974c193ea3a9db1b2362869d56bb..b4c69dc50ed0f0b3cb45341a01c89210bd261993 100644
>>> --- a/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts
>>> +++ b/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts
>>> @@ -632,6 +632,33 @@ led-0 {
>>>  	};
>>>  };
>>>  
>>> +&pm8350c_pwm {
>>> +	status = "okay";
>>> +
>>> +	multi-led {
>>> +		color = <LED_COLOR_ID_RGB>;
>>> +		function = LED_FUNCTION_STATUS;
>>> +
>>> +		#address-cells = <1>;
>>> +		#size-cells = <0>;
>>> +
>>> +		led@1 {
>>> +			reg = <1>;
>>> +			color = <LED_COLOR_ID_RED>;
>>> +		};
>>> +
>>> +		led@2 {
>>> +			reg = <2>;
>>> +			color = <LED_COLOR_ID_GREEN>;
>>> +		};
>>> +
>>> +		led@3 {
>>> +			reg = <3>;
>>> +			color = <LED_COLOR_ID_BLUE>;
>>> +		};
>>
>> I assume you managed to confirm these mappings are correct.. sometimes
>> they are not what you'd expect
> 
> If you mean, that red == red, green == green and blue == blue, yes. The
> RGB configured from user space matches the color on the LED.

Yeah that's what I meant, thanks

Konrad

