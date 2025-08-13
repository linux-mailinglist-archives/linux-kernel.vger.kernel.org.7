Return-Path: <linux-kernel+bounces-766398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94EF9B24625
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 11:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C72417A09D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 09:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D072F1FFF;
	Wed, 13 Aug 2025 09:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="npqVpoSu"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6652EA17B
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 09:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755078497; cv=none; b=bND5pz4IIW2QRQv30SZTp7vx36BLbTMghsFZpAVJfqBVLeZkfhtgOsmS10sk02bFPrZENfimI9qdPzuBz8pBBw5mDvfnOL6fCgnDup6i4BzotbftE6XzxuMnVI72CMN+suDD7vI92yLUqREHo/HTJZfoysmNRQGHbZRY5sNKASs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755078497; c=relaxed/simple;
	bh=yprNOnxZZuuTMVw1H12F4Euaupw8Ojw88+nk0jQgJCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R1ID0RjEPF4jGmjJsZfdQYTa3TfOf3VQJ1qjtO+I4GT06Lbm73Celrh+mpG9u/cn2kK89AvOqHvsJq2p8PxXtVzVS0QzUvgwyoRdJyqaI50yhSorwdDVe3wwp7rDslIQL9Nx6ifnnK9ZYfcFhV1dcierYNRcUDu2fKtLRDCqwh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=npqVpoSu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57D6mY2f019583
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 09:48:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yprNOnxZZuuTMVw1H12F4Euaupw8Ojw88+nk0jQgJCE=; b=npqVpoSuc3/mcQwb
	NxvamAK6aRMS3QzbpmZYoBmNRHNRfNb1Z6G8NqrtlonqqzVNmIvykXeq8h3i+xpK
	Jyw5RBAXxbRuIiO3SA3LYq6L/kOyC4ogSY19J4EfVozr0oXHIXNYA/6+FVOro0iR
	Fk4cI8dEym49x0nypFWxplNqPTU+kSJOvOQ7PdcPRcZryET53rDbo2KVswKIfw04
	l6XvLQ+BcqEfBhBNGZjnxW0RwpXkmGtkUYdCSpBnm4EOwB8N8fmyCOUPvM+wSHKV
	63inInnlI4AAUa0Bjvlp86v1XorQhAvZua3pEra75Xlc+ScQsxK7D47IVeYVyP8/
	Q+XRvA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ffq6q6qt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 09:48:15 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-76bc511e226so6335980b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 02:48:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755078494; x=1755683294;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yprNOnxZZuuTMVw1H12F4Euaupw8Ojw88+nk0jQgJCE=;
        b=i5bv0JbujE/jH+thZrwjxYmtZexAGwHHmZwDoI7QpeAXT8UF4V4sT3IY5FkHUY0MdJ
         FVA5QloAzKET70ratb+K+uiNZjmn9g82S0qJ3XM4bwSWd6tZYeSAeyHrCANq+1FRd4y/
         nvhMbhATDO4FsqGPR8GcRBDA34cZwiTd33z3Ntca4wSbznaYXlInPVsx5ipkvF9STcVY
         QEZAHx4l71HZ69CoPpKepbBuI6EjEuPHzlWwC0GqZrpKwov0I/SZAypObw4xCchxuWQd
         P8s60ZaJw4On3/MNEpNyvQ3HX817wHfvHoxcIfd7LpJ5JXEtGG9p+/hHXTk45XzAo0wk
         BxMg==
X-Forwarded-Encrypted: i=1; AJvYcCWA3zpaP4rOdsd82vrrD2+VecIJEwWJ+RCTDiOfIL/t3qiNQNm+vAe9elHYjamQT693yvXhtQOcgf/PqHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxckOZojBZCerJ7G7fu0MiN/drweJu+6vNi7+qh57TjkfWmyV5B
	KvgZYpibPhthcrNbMzEX89WEfG6/zPXgch33LDji5OjhvUny5DB3djXfkz/Xi9NvmcvQAYC3QBM
	pnH/WZVZC7tp7mpIN9iprquegKYJs5oCWumAypOZGQTTQqdd8pYfHNt3Og0qNCZ8aVuw=
X-Gm-Gg: ASbGnctOqkVx0HwDJ3d4OK5dMRI8z9oNSuaBEaKzgmJhw/TOyPMcByH6vJjc/NsqENa
	ckSEjK/tCb0iS6DMwWXzvzUUs5Y9kgi07duDsW8oBl7EuOpNPNmtfXyUPBfl+aOHYKMiP5GoasH
	cK+UfKucM0HbsA21a7wOxgQ7276qruIVxHiOkbaUzvsli08DbNdfHfjmy+ZLlJzutXmGOlGC8eV
	I0jHYilhKSExOvQNCsrWedsqHnCH+K4EIbt9it8+WpBX47sK5IXhpB1J/V0sBRtN8qHLwP6YV/b
	LGo6oKcXUuipVQsNw4USyNt3mY07gfaBIvYmOEyGBRm/8hxZwi+ZSWp/XkZjZ4kEWiHmukD9hRa
	8qFYGrHBPqChIeH1Nfu7yMEE08ok6LXwayd8P8FHxK+cTwpVko4Gz5g==
X-Received: by 2002:a05:6a20:5483:b0:23f:ff7a:4d69 with SMTP id adf61e73a8af0-240a8b5e283mr4270083637.40.1755078494475;
        Wed, 13 Aug 2025 02:48:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQi28wBETX/FfzYkh9vYqVOP0sSfPKuwwUYnt2NYefL8rquOBU1sF704aafnQm7XBD0r47EA==
X-Received: by 2002:a05:6a20:5483:b0:23f:ff7a:4d69 with SMTP id adf61e73a8af0-240a8b5e283mr4270038637.40.1755078494038;
        Wed, 13 Aug 2025 02:48:14 -0700 (PDT)
Received: from [10.190.201.48] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422bacbb74sm26978433a12.42.2025.08.13.02.48.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 02:48:13 -0700 (PDT)
Message-ID: <1c27e30d-9d99-4348-a92b-e9fe86d0c339@oss.qualcomm.com>
Date: Wed, 13 Aug 2025 15:18:09 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/2] pinctrl: qcom: Introduce Pinctrl for Glymur
To: Krzysztof Kozlowski <krzk@kernel.org>, andersson@kernel.org,
        linus.walleij@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, rajendra.nayak@oss.qualcomm.com
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250813065533.3959018-1-pankaj.patil@oss.qualcomm.com>
 <17b90fbc-ccce-4eb1-b334-5fdef82c094c@kernel.org>
Content-Language: en-US
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
In-Reply-To: <17b90fbc-ccce-4eb1-b334-5fdef82c094c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA3NSBTYWx0ZWRfXy1LH0JjRLbCI
 QU7gl0aoma0868Zrn2WaqYIqB1+9U71MxMu+6zA6wCvnlpunmIB0xB1GCo1eQKYzZQa5+G4xj3Q
 uxevcR1ePJIMCz1speS74QRIISA/gsZjmfhZMDoggisIcOh2Wq8Jw5ACDhGCByryf30Zuc9bcTb
 p4SUqAydv+8/cIe+l0zVGyCNvBntfI2Oisd5sGz92DrsxnbeceovnakW6+oSCzb81Wb535fPpAD
 RUhK624fMlXbj+6B8cteMDZgJuki1RGtUTzYa9b1kakrYk4QkbzcCeP4GKzM6McGtMtzjPc4B7z
 8x6SOPYX1Y3zfkXD7mHAeM+xziGpsAnseNTVtGCcBMqR2fxiyhvLCvnOpMYrwQfcpdD3bh3MdBr
 opRbvpLu
X-Authority-Analysis: v=2.4 cv=TLZFS0la c=1 sm=1 tr=0 ts=689c5f5f cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=DNT5GobofFhSdjKMTB0A:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: Ed9AggK7s_4-filhukZVZPm_92sCVeRT
X-Proofpoint-ORIG-GUID: Ed9AggK7s_4-filhukZVZPm_92sCVeRT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110075

On 8/13/2025 1:01 PM, Krzysztof Kozlowski wrote:
> On 13/08/2025 08:55, Pankaj Patil wrote:
>> Introduce Top Level Mode Multiplexer dt-binding and driver for
>> Qualcomm's next gen compute SoC - Glymur.
>> Device tree changes aren't part of this series and will be posted separately after the official announcement of the Glymur SoC
>>
>> Changes in v5:
>> Rebased on top of v6.17-rc1
>> RESOUT_GPIO_N changed to lowercase in bindings and driver
>>
>> Changes in v4:
>> Updated bindings to column length of 80 char
>>
>> Changes in v3:
>> Fixed indentation for example tlmm node in bindings file
>> Fixed s-o-b and review comments in the driver
>>
>> Changes in v2:
>> Fixed dt-bindings error from example node's reg propery
>> Fixed gpio-line-name maxItems
>> Driver UFS_RESET macro updated
>> Removed obsolete comment for pingroups
>> Updated ngpio to include ufs_reset pin
> Where are lore links? Why aren't you using b4?
>
> Best regards,
> Krzysztof
Here are the lore links for the old series, I'll setup b4 from the next rev.
Do you want me to share another revision with lore links embedded?

v4:
https://lore.kernel.org/all/20250723103644.4058213-1-pankaj.patil@oss.qualcomm.com/

v3:
https://lore.kernel.org/all/20250721163221.310746-1-pankaj.patil@oss.qualcomm.com/

v2:
https://lore.kernel.org/all/20250721143037.20983-1-pankaj.patil@oss.qualcomm.com/

v1:
https://lore.kernel.org/all/20250716150822.4039250-1-pankaj.patil@oss.qualcomm.com/

Thanks,
Pankaj

