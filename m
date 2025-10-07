Return-Path: <linux-kernel+bounces-844111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C78E5BC105F
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 12:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A87ED4F4608
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 10:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7B4256C89;
	Tue,  7 Oct 2025 10:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="feEnouAM"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591D33C17
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 10:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759833115; cv=none; b=tyWQEnyac04s6DwJ2gvPVqLEwKuZMq2EpPcI935kYSm6F3ckIlwpP/h90d407N4P0VFNNF1OTKzaHlExBuZyzatkyxcC4qQr5u8xtDUTO/3hKv81CBfqxkGoJ0jSQn/vx2qbSut+QYZWB+NCTtdbOGT+SJyXtD8lArqlXMl7o7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759833115; c=relaxed/simple;
	bh=VoxhNUvQg3/ii55U385Skz6aEN5UOWXXWJdEbfpFYFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=epIYi58HCnKvXfUXc3OViQ44cZE6FzDnv6RNfVxPKdqpXxeKn4xnHFDVyrrwDEr9yzsOnmFeJVXP6eJfP/Ko34W5YKktpkAhC9AeNJxh5rP1eInTQw9WneYx+K01TEFQcTlH/aLlZ1oiI5n8T7XaEsg6M+LGf73knaraJmdY/3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=feEnouAM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5972iRpO027568
	for <linux-kernel@vger.kernel.org>; Tue, 7 Oct 2025 10:31:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6pMruL4RrOD8Ab3ncsU6klJP2YjjkGCkq0lz1ZS5k+o=; b=feEnouAMg6bHP8eH
	NEPUNji/ZPht1l93C6vEPCNXhEgScd+hLzrG1RZannJfhEPkrDy9cH477OUSLpMl
	5MCSG8f6W5RV86VQ5nhwPsnc3W8EAmm5Isu+vEHkeFYEswyNQGVuV3y4r7wtIVqy
	odBfM06KeA6/icfOQJwQVZEx1szCcEIAOYkI29v34wRiC8WsC4P4QZ4AqPHGUYAS
	cj2hEgiUr+5kjlGxZfMOlRQRpxCfecMNoqSy0yCys7KNp4vw9A+HZCDXae0isZXA
	8p5eAyHIUoPNph5khyDmdfq+HJNefSHwFKim5qZWSmKxHqNT0D5aIZA1ow/7yzmi
	4vJYqA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jut1pux5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 10:31:53 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4d880ce17bbso6219871cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 03:31:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759833112; x=1760437912;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6pMruL4RrOD8Ab3ncsU6klJP2YjjkGCkq0lz1ZS5k+o=;
        b=IbUpuGjOOwiArG9gg+GfOcZDLoQXuvv5h234Ty9MRCaIOhRwfVZ61pB1SgMk+TyaSs
         ji2Ti7xfrghZueu/GpK0JwJj98vT/d6EHnXu4Z3n3r3nk3Xpl580TksYN0bVFYqfS9WH
         8l1RcgRIHq+mpZpHQ7q86/W4R4Y0+7PajydMUgmSkK19XRJmkzcSh9YjZagqwe7jOHG9
         BkUuVVWR4ZptBvQTtehJGkb1qF6ONpzdkOOdwBQ19Xr8qOU3EtOJgqIcF1MgGXgqiGdq
         7HfAIeyEuIChzyMKxM6K3eto0br8V5ChroZcy6q+KDbUNIlP67ADww6+t7gll7cY6JOd
         RWXg==
X-Forwarded-Encrypted: i=1; AJvYcCWLx9nlJwVOgT+X7rx1DJIDlyAy386b5sNH7Qv6TtGg+S3jQox1GtI6yclLebQaDKw9f2nZk/Y8s94+8iY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxajbAL3/hETn/baBi9h1FXXhkgnYBoIJ7WHIMFMeNiJq+6yahM
	lJZ4jPr3eQW8X7kWh4mmKrr5Ho+fmpucCSO4+23x8pajmj3eUEv2EA9SgJIIPWpvKiQWs1KgHwH
	Z48T741jSvrX9vJWW+0U447DVoCah9DypTse2OB9p6W7J5XSvoa+hpBa+ZxQ+HNvsnVHKvxz1au
	A=
X-Gm-Gg: ASbGncsiw4LBmxgwsW+mQDbF+rOJc0kYSl0pg7pdj7r1Waq8P+yaQXrSBEI19QkJwal
	dPKrUyEZ+S9dBqn106tZwMC2MJxzkxhARHFgINfX9SBygAZNK8Y9IT6fkd+1m4ItRqG+XoFh4/P
	rElwTpUfxFNszaDOY8r9kzIxInZEpySYnT/pgn7GDflD2XfMefwJ7+1ooQoA/2XuSAtMbL7B9vO
	JPNauDvglVM2xGiRxEJJMoAy58feirffaOv76cswT3Tvn9EOvHn5EfEe8G2kk/acsk/bWKPYVMF
	sKtiGLx9u1L3m53+z9xfAcETpAn+p6m3NazrEvLa0LS0MaePcO4n3f4r4Fg3CFbgRio18PgSAkA
	LUsQEAhEQgfFTC9Yr0hpQjh8ZRbI=
X-Received: by 2002:ac8:5890:0:b0:4d7:e0ed:421f with SMTP id d75a77b69052e-4e576a2e554mr139971181cf.3.1759833112017;
        Tue, 07 Oct 2025 03:31:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF49wJdpC9RNWjrZh/mjq2BnFEU9JH6SZhV7KcMqbJZ1IBEcWUiuSsdgRT5R07pr15Mpi9GiQ==
X-Received: by 2002:ac8:5890:0:b0:4d7:e0ed:421f with SMTP id d75a77b69052e-4e576a2e554mr139970751cf.3.1759833111321;
        Tue, 07 Oct 2025 03:31:51 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b503c779df2sm33444766b.34.2025.10.07.03.31.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 03:31:50 -0700 (PDT)
Message-ID: <085dbb83-d805-45c7-962c-2cf40a93a31a@oss.qualcomm.com>
Date: Tue, 7 Oct 2025 12:31:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] phy: qcom: qmp-combo: Move pipe_clk on/off to common
To: Val Packett <val@packett.cool>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20250927093915.45124-2-val@packett.cool>
 <e6754738-76c9-4080-bbed-17f02e6535bf@oss.qualcomm.com>
 <2564cdec-9726-4efa-ba07-a2f2646168c6@packett.cool>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <2564cdec-9726-4efa-ba07-a2f2646168c6@packett.cool>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: -qCeaZbiFhiioTHLZJv-F-F2wskinnTc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAyNyBTYWx0ZWRfX14UEB1+qiu8A
 76jovmc3Eq+EXVrsXg2OT1XGflFcqwpuDGAWQp4/qqLmEMqwukU5epaYMkMjvX05qrWV4Eirg6y
 A68s6ZpM5J5fjO7jUbpaEE6QSOySKYDKjxF/XJhQ/9enehRES3uUMwBSmEhXooWhx+8AYehpb/r
 hrFtQLRFjFWN2bYlStYYyFWG+u+Q/iRZDFndisnM6Fe4uspHw99rFsGEGHzYBqr/ubNI53VjpoW
 mPshTp94/D/bWpBeWzIsNTsSJCcXPRbYUCTzpdpRASRPHd/F7vOxUlsuBSt6XmR7rJS+UE+DwRZ
 AzbErPf1v+Ea1hYiVs1W00tu1t24DA71DuvZo85DGbkEZFGjzQQyy+FWPDC55H7Y5nItKBl4Qt+
 mroqPBe2uICorQty6Y+UtsMDCexTtQ==
X-Authority-Analysis: v=2.4 cv=Vqcuwu2n c=1 sm=1 tr=0 ts=68e4ec19 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=p0WdMEafAAAA:8 a=IIrk0cfXZlyaRavtHIIA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=poXaRoVlC6wW9_mwW8W4:22
 a=pHzHmUro8NiASowvMSCR:22 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-ORIG-GUID: -qCeaZbiFhiioTHLZJv-F-F2wskinnTc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_07,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040027

On 10/6/25 6:13 PM, Val Packett wrote:
> 
> On 10/6/25 11:44 AM, Konrad Dybcio wrote:
>> On 9/27/25 11:17 AM, Val Packett wrote:
>>> Keep the USB pipe clock working when the phy is in DP-only mode, because
>>> the dwc controller still needs it for USB 2.0 over the same Type-C port.
>>> [..]
>>>
>>> In [1] Konrad mentioned that "the hardware disagrees" with keeping the USB
>>> PLL always on. I'm not sure what exactly was meant by disagreement there,
>>> and I didn't find any specific code that touches that PLL in the driver,
>>> so I decided to just try it anyway.
>> So what I did was playing around with the RESET_OVRD settings, which
>> dictate what parts of the PHY (and their associated PLLs) are kept online..
>> but I totally forgot that there is a branch/gate clock in GCC that sits
>> inbetween!
>>
>>> [..]
>>> I'm sure it might not be that simple but from my limited and uninformed
>>> understanding without any internal knowledge, the "sneaky workaround"
>>> might actually be the intended way to do things?
>> Normally the clock which you're enabling is sourced from the QMPPHY.
>> The other option (bar some debug outputs) is for it to be driven by
>> the 19.2 MHz always-on crystal (instead of $lots_of_mhz from the PHY).
>>
>> For USB hosts without a USB3 phy connected to them, there's an option
>> to mux the controller's PIPE clock to be sourced from the UTMI clock
>> input. In those cases, the UTMI (and therefore PIPE) clock runs at..
>> well, 19.2 MHz!
>>
>> (you can actually do that on USB3-phy-connected hosts too, at the cost
>> of.. USB3, probably)
>>
>> So I'm not sure how much of that is well thought-out design and how
>> much is luck, but this ends up working for us anyway, with seemingly
>> no downsides.
>>
>> At least that's my understanding of the situation.
> 
> I wonder how Windows drivers handle this.
> 
> The ability to use the UTMI clock sounds more appropriate for when only a legacy USB2 device is plugged in and the entirety of QMPPHY is unnecessary and can be shut down to save power.

How would you hotplug a USB3 device then?

> BTW I'm still seeing USB2 functionality die if I boot with the monitor cable *already* plugged in, but that sounds like a very different issue (the host controller starting to touch the bus before the PIPE clock is up? something something probe order?)

Unclocked accesses would result in immediate restarts

We've had some coldplug woes in the past due to the ADSP Type-C handling..
does replugging (maybe more than once, maybe in a different orientation)
fix it for you?

>> The suspend logic is broken and unused anyway, but that's a nice catch,
>> the PIPE clock in question is even conveniently called "usb3_pipe" in DT
> 
> Hmm. Is it unused? Oh, you mean the pm_runtime_forbid(), right.
> 
> Do you have any pointers about what exactly is broken there? I've been poking at the runtime PM stuff too (https://gitlab.com/Linaro/arm64-laptops/linux/-/issues/14 for USB), the PHYs are the biggest missing piece there overall..

The PHYs likely sip power compared to other things.. (but of course fixing
this would be welcome as every drop counts)

I am not sure what needs fixing, but there exists a chance that because
of the relationship that we're talking about in this thread, the xhci
suspend could use some love first.. I think there was some work on that,
somewhere?

Konrad

