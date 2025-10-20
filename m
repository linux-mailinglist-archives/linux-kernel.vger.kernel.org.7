Return-Path: <linux-kernel+bounces-860807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BBDBF0FDD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 889D2349C86
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A18E2F5A32;
	Mon, 20 Oct 2025 12:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iGyGx5/f"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47ECA2F3C19
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760962003; cv=none; b=N1WPIMEQjcUqvR8ulLZNJ07k1cx8i/m+9CoE642bgVP5KbGnlQk5kVvcFj0wMIZqkNnQzZee5s2hWDvrH9YBGh0LWJ8EwPJrTVG5JHzDG5LFRA88t4kz0KhzyYRdb2k8ovgMaJwGEdf8AH+uggP1YohrEi6k4bhUXBucVmFgGig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760962003; c=relaxed/simple;
	bh=85eJelY5rLujX3HL0nj5dZhL7tMpDAL3Abbo8qRfrZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U5d/SgSZ3YtDWNwZxOjwlZboJkZuCVoatAi78pZoG6vZ7Yq6mAhqWLi5qW5XMzT+fBFxMaLGhnK8NNMFajAFy0/JOQeXv41ilt/1nsTBpO8uCLY5NXE9eETz3YLGUMWYXbUNpvHMC4clbLtqop1pjYAa2TwTztyK2mxCutH+MiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iGyGx5/f; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KBDxW1025907
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:06:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AM1EAi3c+8jjqOffE3vd1ZWRy962xO7gDGTST1FtuEM=; b=iGyGx5/fiN8jzYSK
	hR9jZAFxmIKb4nYScW/jtcrdQ5HJ5LBfICp97L0/7FBs48JZmqUL0AVwzhTpV5KA
	6/4ahiQY2sVHgaCbVzhGI1mfGjzSGhYQcnqYZp0566poZvncTgh8ZssUF+apUSur
	fWyUzKk8YBp8wqupy8NRKlTrmtKGvm+dmoP6K9OqAoInqWcip1S7ID9WIHlcnY+q
	23yNcylSZhjX5s6y4Vag9vYBpygGwFVXkeUZ8cDP/Ey3HimNHFq8EuGIVodDPrfh
	HIEpnGlK+wyTrPlKc0m5tC6L/peBVxNc559VKcz/NpyBk037Vke0+1D3/MEFSu6X
	pKBIdA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49w08w2a0x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:06:41 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-87c103b902dso18282216d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 05:06:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760962000; x=1761566800;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AM1EAi3c+8jjqOffE3vd1ZWRy962xO7gDGTST1FtuEM=;
        b=u+fQ8Hw7kAPiGZL1HHidhi6xRg+4MwBlP4VnnuImdpjcha5Voofp6HXCzHLix+QHKB
         +v50cqUA3cPS9UnmYqJLkLTRJioc6NBSQqmJQrHJW4GFBSbl8gKbdCrXN8ToC0iIerCu
         DUjBgPHHl9dN2Eg96i2HtqRUZVcGD8CBm3DkjWH/L1BS53PVa3JQsG2/W6nsLfkOY9g0
         dh4uX2tcLwDpvlV7mF5Gs3Jrpi6SHo6Nx7fUOxU1JhebMGVxMpuFerJk6DWh9SJDJ0Pn
         kQOhOPpKfQvlM1VzN3ZaH5xYL1qL3jNstR6t691L+yE2jUQ2ah8VzuyTswLhjAWxx3Va
         lY4w==
X-Forwarded-Encrypted: i=1; AJvYcCVVhmqwJS2MdN2tkjY5Ia+wLgjuS6/WjxUmZQP/+Q5b4irKISKJ0RjtEih/sKWjZrB2iOhwRW0D8wPyWps=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgbuE1deUvypIQthlmhcp6MiSFeU9nZfKBlZe3USjGDzaXsLty
	ch+ISi/l4tyaRXstR33mvcv9Q2FGvzlgFnivSiagmykSMpgvPL1SFEuK9fnyV7TCoVOc5kbvfh3
	2MaU41XwFi6VRUlg+ngsqOpF/Qm8VAu8nkIvb9ibmpqKDvrIQ2zEqIxpJ6riocNYT1hS5N2lEhp
	g=
X-Gm-Gg: ASbGnctIhm1frEM4yoZuTxB30lg8CJ3akd9OduA8AWni4L2+6RuoEmnJ3f+5Y2c6f8z
	uqWzy363wJxNcJpd6tYF0sTRwWRf3xto7h0rhCJmtJsWPj3BSj8e0vLMm3In8aAxTp92Tw1+5rp
	yH8N1YYY/OYXgJxYgYHr/6c5Buq30FUTAGVxb2wZhEvt7vdpH8shgIgjYjzmHfa3ryBwQCUVsNA
	Aq30dkWimhzi+eiTVBx7y6RthZS9vh/Jt4YDMrER7/HXBfRNQw7lh7eyBJ+7W0ioyjtFnGcgOLa
	g7DVGq0jYCHENNMTM7cL9kZHJsMZBXiF8VLqF6E+HeBhu0+7fTo1XRiLBa3TDCZ07cdH8NoqLg5
	9azGfBbZa4VsVwC4yBuveTP5dR2n4aLJfICB4BORus3VX+tmBKqrJPGMX
X-Received: by 2002:a05:622a:1492:b0:4b7:94af:2998 with SMTP id d75a77b69052e-4e89d2cb636mr109379681cf.6.1760962000016;
        Mon, 20 Oct 2025 05:06:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8qCwyyxDM/2fV6Wa+Eg4Sftf+4gxk97dhl6Vpvo4Cc7D7+AvvddfmPWJAlfl8oh36GLDt8g==
X-Received: by 2002:a05:622a:1492:b0:4b7:94af:2998 with SMTP id d75a77b69052e-4e89d2cb636mr109379411cf.6.1760961999585;
        Mon, 20 Oct 2025 05:06:39 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c48ab54desm6624844a12.13.2025.10.20.05.06.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 05:06:39 -0700 (PDT)
Message-ID: <30704150-54d6-4ba8-8dcc-74145f77cdfc@oss.qualcomm.com>
Date: Mon, 20 Oct 2025 14:06:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] arm64: dts: qcom: r0q: enable max77705 PMIC
To: =?UTF-8?Q?Eric_Gon=C3=A7alves?= <ghatto404@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250920014637.38175-1-ghatto404@gmail.com>
 <20250920014637.38175-4-ghatto404@gmail.com>
 <53b1a622-3afc-4fd9-98b1-3c166f563ad0@oss.qualcomm.com>
 <BB4E3024-F897-452B-9D3F-250ED2D52195@gmail.com>
 <823af9ee-df4e-40de-bf30-084442bb1d2c@oss.qualcomm.com>
 <17433470-8B99-4910-AB3C-494C7C27BC29@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <17433470-8B99-4910-AB3C-494C7C27BC29@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Lw05VzE3-4qmkYJvzHXQUFvE5YzuKUX4
X-Proofpoint-GUID: Lw05VzE3-4qmkYJvzHXQUFvE5YzuKUX4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE5MDA5MCBTYWx0ZWRfX2TL5Sawn8L9E
 tmh23LqbFaGxqixpteQRg3SYLnF24FI9WDqeKZZWya73+W3CvpfRXX4gAbq6mqVi+Y715pdRD1o
 D+Ui2yGOg7ZLTIyNxZNTjCT0z6ib2CA0YufcMb91g/OGmwKATNZGJxqFGi9OOvbNN/Hs2Zgg2ji
 mUg7agqD2Iun3m3qQs6QYw+Hitxk8MNHZohkUCNFZ58lyWq4y6vBdbsrtPMZ+xjSKbz93bGXN1y
 uzvkcU+3Byf5+XnQZpwsXOzIDOpkClp0cbPZ5KgkNGQQCcG7N4krRq2qmIpLJwY0/++h1A0SPcF
 1DnkXoeqri0nT3JBG1EMBH+SsHlHWZK9mdk/lyXkTqqRCo1uY9ZssVuca7lcSk89Pc9HtgFbocf
 ExOVp1T01xEGL+UQ259PsDYvi1MoKA==
X-Authority-Analysis: v=2.4 cv=V5NwEOni c=1 sm=1 tr=0 ts=68f625d1 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=o0PnOtkDTcW85J4-gJcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 suspectscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510190090

On 10/9/25 10:31 PM, Eric Gonçalves wrote:
> 
> 
> On October 8, 2025 5:34:00 AM GMT-03:00, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com> wrote:
>> On 9/26/25 4:19 AM, Eric Gonçalves wrote:
>>>
>>>
>>> On September 25, 2025 10:06:53 AM GMT-03:00, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com> wrote:
>>>> On 9/20/25 3:46 AM, Eric Gonçalves wrote:
>>>>> The Samsung Galaxy S22 uses max77705 as its charger, fuelgauge and haptic
>>>>> PMIC, enable the fuelgauge and charger for now.
>>>>>
>>>>> Signed-off-by: Eric Gonçalves <ghatto404@gmail.com>
>>>>> ---
>>>>
>>>> [...]
>>>>
>>>>> +&i2c5 {
>>>>> +	status = "okay";
>>>>> +
>>>>> +	max77705_charger: charger@69 {
>>>>> +	    compatible = "maxim,max77705-charger";
>>>>> +	    reg = <0x69>;
>>>>
>>>> Please use tabs consistently
>>> Sure
>>>>
>>>>> +	    monitored-battery = <&battery>;
>>>>> +	    interrupt-parent = <&tlmm>;
>>>>> +	    interrupts = <5 IRQ_TYPE_LEVEL_LOW>;
>>>>
>>>> interrupts-extended = <&tlmm 5 IRQ...>, here and below
>>> why extended?
>>>>
>>>>> +	};
>>>>> +
>>>>> +	fuel-gauge@36 {
>>>>> +		reg = <0x36>;
>>>>
>>>> sorting by unit address is welcome
>>> Sure
>>>>
>>>>> +		compatible = "maxim,max77705-battery";
>>>>> +		power-supplies = <&max77705_charger>;
>>>>> +		interrupt-parent = <&tlmm>;
>>>>> +		interrupts = <5 IRQ_TYPE_LEVEL_LOW>;
>>>>> +	};
>>>>
>>>> These nodes should be children of "maxim,max77705"
>>>> (see drivers/mfd/max77705.c)
>>> What do you mean by this? I looked at the driver, 
>>> should I add the pmic@66 node and put
>>> the units inside of it? Because starqltechn doesn't do that and
>>> places them outside. Also, by adding the
>>> pmic@66
>>> node it expects to have led/haptics nodes as well.
>>
>> Well, the chip comes as a single package, so this only makes sense
>> and the bindings (mfd/maxim,max77705.yaml) corroborate that.
>>
>> Just looking at the YAML, you should be able to omit the LED part
>> if it's not connected anywhere
> Well, looking at power/supply/maxim,max77705.yaml shows
> that this is how it's meant to be defined, (outside the
> maxim,max77705 node), no?

If you grep for maxim,max77705-charger, you'll notice that the MFD
driver defines a MFD_CELL_OF

So it's reasonable to assume the bindings example is simply not making
this obvious

Konrad

