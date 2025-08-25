Return-Path: <linux-kernel+bounces-784647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC0BB33F09
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42FA017689C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 12:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4276526B77D;
	Mon, 25 Aug 2025 12:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aADJZSdy"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEDE22DF95
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 12:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756123893; cv=none; b=HAsaEZuNOe+o51guATFLMZIxC8RF+sMzPDCJhWsbcjCscKPQjcMRGrQwiPARk1vQ+LHW4qrd6df63o6UqhDuibYHK7Zrh+VViw3jlg0JexRFJ3ywKfJZf294Pd43xx0Ndpx5fcgG72h8Bg0CvhyqtssbJEgDi+FFkJ3ugytKLjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756123893; c=relaxed/simple;
	bh=vLlamXWBSQHZZ9eA+LhLnoR7PU3S7eCIzBFd9n5LXu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ci8CS2VL2//EAAptO0349oXWRNXNiysoZfhjb5GPmcrjZADflBs5zJ3BPcVkkLqs2lf6orZzkQadGcxMf5XtP3uWyRIN63cJ7mJQIkHatAA6etp3Ow63kr3SuMgalRw74REjNVDP7HCHNUnkn7Zk/9wkwwHuuyuwQOx6ZW742rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aADJZSdy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57P8gUId009663
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 12:11:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	K7FbX2s1S4G/T5+nXuI9tHeqbBremko5yoicVgE1dm0=; b=aADJZSdyewjEcbpR
	8APYbLYYmxKu8hAklV8H6/dlFHPjgjuJLwsR7U64gf4WGjHRho+DrgAOvf0XKHsR
	p3vgT5K2ULIQypyMmxb6fAIl0Wr2txBP65kwFgq2l0VjuYDTJywR2o0ovJYd2Jj5
	4UyjBywzESyMFfS6j/ke9QtODvmwHi6cTNJPWw+s7k9A3JbeyAf1KTUj32hFUitk
	fkujqXvu6p5sJpzsFPgnH0z55Bcg/oJLDJ9Ztlj0dFNg+1Bs92OmHugOG7PKHILC
	D9r7I2XjKWmqWPFPDQ26MrglaZRHDT/fkQZkkC68kYt8PmySts3+UMW1pbjrX/Ym
	nWqosw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q6de521a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 12:11:31 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3235e45b815so5115844a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 05:11:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756123890; x=1756728690;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K7FbX2s1S4G/T5+nXuI9tHeqbBremko5yoicVgE1dm0=;
        b=AxI2nS1N8e1/LMd2EB8cZjQ7peHH33hwUBfDnbnEacbYokEWsLf8b0OoCE1+42ujF1
         Ej/2y1hA5MS1muvUp2W2mNQX4b840qvrh1yIN1DverZfVk/GpT42+e2wr8dF/dzCF5zE
         1ZvnA/5SbojorJE8YFbqSuM6zPS1FvzM2P0KX1yeVccU/Po7j1sPTboorZIHP+AVJ/8t
         QWVsCCDvUVirj8CrbCX51Z6bq6P7x8mrGp0iaTRnj/mEd0axEbs5ntbZuko9N3Xlqzzd
         QTpsff00SJc4hXbkHSI39C42hKiF8DD8bw5dbVjMdS8EZC5WYuJj06qr6tGrn089sJ7J
         xTPA==
X-Forwarded-Encrypted: i=1; AJvYcCXOIud8U7RVVzzX9Qw7hy2g/7syOLPHWwFbBMToBohJX1PvqGNpyfPchBKvckvbYW0CKfE1D+eYwSorCpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPKwnrsVdiL1+y6aPfsIeoeX+loi8AeCW3PDvXJmUdpDF9Mb6b
	S1IxpAvbfqhleZVTWAUlkI9mr9MJseJMQ060FoJYINf9oqySwXRF0W+KDgdaM24Za3n/flpctF+
	BrD7dcB93RknwQTPB9EvOCsIgEEsoovc/n0Vg7uns2il/ROGshqwhv+uBkSIEmR26OGlfeHaKoU
	I=
X-Gm-Gg: ASbGnctyqYQVS4KPjsK6aLPzNHFPOnPy5Q9/C5k264IrhY04rIdXs/wPbtuLnad/ERy
	0UdZj+KRC/HDuEwoC7wKiW8JHmBAbU5gd4oIsNZaWyebtg94AIFvASsYKYxxYB0Nb1bSytIp+D2
	1NbMBgr+6CmxbysyIPDozVmj5086Jfp2M61hjLe0GW9dIo7Oho2dTtmV/GlR0wD+BI/8Y7G4LZT
	+lhjz4c4rRJx8fXBUpz2B9CX2zPrYdUrNioNjA+3oQdbOUDwlqizDettrJ46i/dxuDrLambj0c8
	sKMmJpLIX5hgUPRp2sM0i3FuVMwnqMZjJTGycAd1tJRFAxss0BfGys8ZgtXNNd/OKJewrNLl9ld
	6l5KZ+Ic=
X-Received: by 2002:a17:90b:6cd:b0:325:941c:ccb0 with SMTP id 98e67ed59e1d1-325941cd8c0mr5253223a91.34.1756123890315;
        Mon, 25 Aug 2025 05:11:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFx8YCW4yGPKF6jpJ2B5L1bLxQQVF62NjexUICV5/Sy9Jos1/wYUBHlSFW4Imyg6eG8ezQ0Cw==
X-Received: by 2002:a17:90b:6cd:b0:325:941c:ccb0 with SMTP id 98e67ed59e1d1-325941cd8c0mr5253186a91.34.1756123889839;
        Mon, 25 Aug 2025 05:11:29 -0700 (PDT)
Received: from [192.168.1.4] ([122.164.82.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3254aa63da6sm7046778a91.20.2025.08.25.05.11.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 05:11:29 -0700 (PDT)
Message-ID: <f5069582-d245-491f-913f-7488227605da@oss.qualcomm.com>
Date: Mon, 25 Aug 2025 17:41:23 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH v3 0/4] Add support to read the restart reason
 from IMEM
To: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck
 <linux@roeck-us.net>, bod.linux@nxsw.ie
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20250502-wdt_reset_reason-v3-0-b2dc7ace38ca@oss.qualcomm.com>
 <175493766109.138281.3436384432329568509.b4-ty@kernel.org>
Content-Language: en-US
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
In-Reply-To: <175493766109.138281.3436384432329568509.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzNyBTYWx0ZWRfX7ejrLRL9U9Rr
 4jq4I5+OJ1WVwRT1vTYiKsCjb6dzPauEFqXbzr/r1h0hJl3ycDFj65jUFB4Y80liBCg7hVaRWHa
 ADm153JTHWkf89r/A9FhLgvqiHBRA+JXoeAaSB8jbRFNHKw/Rujw7hemKOnKVTP5SYxo2aukaCV
 XAtuB0pmos4Kgyseyiqw3vuQWyVd76dYRFKbwT7S3LoejM9Z/r04B+4XDUwYwD/PRYmy+P0sPG0
 zRJA0WEbR054cjV8mytkUx/lOc6L80T0JYPWY5lPRmwJE9GMi8y5fd/MA1isR3Ed1otBq6pmBFv
 4ssnBN1Cup/97M+h2rgGYfj0rUTml3dAgjPKqMxiGy1KeV+y7JjOr6gso+V9pLkuSzDB8zRJbkt
 f6Z1hslf
X-Proofpoint-ORIG-GUID: 93il8_sTno7rxJn2wvPbBusjLboIocw0
X-Proofpoint-GUID: 93il8_sTno7rxJn2wvPbBusjLboIocw0
X-Authority-Analysis: v=2.4 cv=K7UiHzWI c=1 sm=1 tr=0 ts=68ac52f3 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=qL8JkhX1/0pBNNwer7kOkw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=cSn2wggv2xD2pGh0t4sA:9
 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_06,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 malwarescore=0 suspectscore=0 adultscore=0
 bulkscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230037


On 8/12/2025 12:10 AM, Bjorn Andersson wrote:
> On Fri, 02 May 2025 18:47:48 +0530, Kathiravan Thirumoorthy wrote:
>> In Qualcomm IPQ SoC, if the system is rebooted due to the watchdog
>> timeout, there is no way to identify it. Current approach of checking
>> the EXPIRED_STATUS in WDT_STS is not working.
>>
>> To achieve this, if the system is rebooted due to watchdog timeout, the
>> information is captured in the IMEM by the bootloader (along with other
>> reason codes as well).
>>
>> [...]
> Applied, thanks!
>
> [1/4] dt-bindings: sram: qcom,imem: Document IPQ5424 compatible
>        commit: 3fa1095979393d5b178264cc1bdfb473e80ab774


Bjorn, IIUC, based on the discussion [1], moving forward we should 
describe the IMEM as "mmio-sram" rather than the "syscon" or 
"simple-mfd". So we need to drop this change from tree.

[1] 
https://lore.kernel.org/linux-arm-msm/e4c5ecc3-fd97-4b13-a057-bb1a3b7f9207@kernel.org/


>
> Best regards,

