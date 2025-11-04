Return-Path: <linux-kernel+bounces-885156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 29979C32254
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 17:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9E7164E96C6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 16:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC023375DC;
	Tue,  4 Nov 2025 16:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LctS5Wzk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DG/n9xKE"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655C93346A3
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 16:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762275084; cv=none; b=Cp/X+OmlhHlHmHDwr/pVN05gudUfjD5j2pZhD15vubk8UJjNmFhvGjaD1liFwT1tr6xdcsVBAgzjcC9JeT5ML0Lo4DQJ643VLf0ezQBRQglwiW5JAR/GyvYSLhke8ESo03Pc6Kv+T+nwFIjs1zB5NdgYQZyg5aBrdX1i6FefFmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762275084; c=relaxed/simple;
	bh=JJL1Rt1wO6SeRyuVC3eLk6feQ2yv20mvpJ4AerD3LTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c3sWSNxdvZroJWVOiL0iSaMkCw5soDvUxbAqfdpujubTFpJqIdIpWA9uf0KMNzRdN2PGujvc0CH58bCXXc+WgUxH7Bl+gVOtVjwJy6FGsedUwIjzLwrP/+ReQwYP3Ae77TpLgTngIgu4YO6lxH5g9fDPV3eJmU2F2kBx097Jg1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LctS5Wzk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DG/n9xKE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A4Gg7aq2551458
	for <linux-kernel@vger.kernel.org>; Tue, 4 Nov 2025 16:51:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ehly9OlPHPUvi5mUdDQW4cNAM2vAplATd034pUg3ia0=; b=LctS5Wzkh5AyGzxF
	AgCgVuDUL6ebQFNeZbzdzhfb6/KKxPPuMeZcfyuDPhfNdXUmcFr3XzKzO0srQzV6
	01GkHRYDP8urRJvGqJWO6PY7axX0Z/7VbMhTB32Gei3KKjNJfadllec3APZl/8bg
	k5h9Y8dkLMUof2JRQ8DKuBBtK6vR+reCKnA6N2dXwuI2pN53bm4DKDMjTPcqbtrK
	3KiLr0f3Gmo3F1/AYU81Yv6cftumnVIwVvLKiEIrmnExq2vyEOI8JG+T48oCs1DB
	wIWKgnVDDfxnDbucH0ik2zKK+antiyXQ6+nbRuDWWMo6W5oEfOkuEln57aiAoHXj
	lZi4PA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7f25166a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 16:51:22 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7a26a53a4faso4443010b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 08:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762275081; x=1762879881; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ehly9OlPHPUvi5mUdDQW4cNAM2vAplATd034pUg3ia0=;
        b=DG/n9xKEQDyC5Bo0b3URBYNiU8m1j+4H7HzQPIgpmaD6imC4rhGuZJwfNWrBesJ2zT
         Fq6NTwEZ44+08GYdCjbf41GgXT0gbqAEHM+Zgr637l+W76mjhIzszQsM6kwmTN/m7jjH
         foTKtD64txbuaDKBZQUcQnVdjLZA4DVjI+83dr9rn215FvR1r2FLFGlS/JfwLSIO0jp6
         0SEQ5tNhsGhp4WAcqYj+m6jRQRmIyE/rGRL+0/uLHP6Z+VHqHe7iNlanXQw3gUMovUs1
         YrsSHXbzB0fc1vxqkbjbOitT4a87YJDWy0BmhLJamfLfvrQRBiLj5UNKrMSpew3aELxB
         0z4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762275081; x=1762879881;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ehly9OlPHPUvi5mUdDQW4cNAM2vAplATd034pUg3ia0=;
        b=Mdwg8N2QrBPbx+0xFWeOfWTfzAaeINgaHyCaQfH1PkBG2x7pEuDf7yTrGMMv1VE1eF
         nwVeQEHnko1nsqqlHUVBUnta16mbOB5PUIWeO2ZbpktF/AI20WS6S/cz1OUP+SCOBDkr
         gC4KFXxszEf5whSMnK5USoYlV8fj+Wkf4kPWBX2aTdLK5FJyuo+nPsRDLqGUFfpj2Cp6
         UZlqPVH2NeCe6PTbp+IfJBLj7vHgtp08qVmSyQ0xi8nzPSdJ6anVyZkyQCOGRjZyyJ+r
         x2mdZxMwSOMnVvxbP8E++19Nfx5XO3UpCoAhTaVC6HQRrFh5SR7oDpxY3iCOkeMiNA5D
         XtWw==
X-Forwarded-Encrypted: i=1; AJvYcCWTrxO+UL6QSr3mebzLaWnsDdjI6WMl9DBmZP6pV+jGy4bKd+KnAjIGe5n1WlkViwjwMZW/HXiLRmK6XD8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZSsicrAMSzrt5yrT20wRHnSCeIGXQZVs1vCZb/tMZUHaAHOYd
	6wWbPKYGK+wYE1C457xq3sIyh/wylc0chxrqZVAn6U1CYwP71Z8q/b8s7iCqoCs0PmmJlOHuzP4
	jfOgicqcsppbhODQL1AXqt5VMRtjg+ydTKjqo1Flh7Iyhu+mg/NoFtTJ5z+mJLlKk0Qc=
X-Gm-Gg: ASbGncsageb/510nrmISYX8acDKHdcqHYXFqOtrZpNSzLAGFlhMbHaCaXY6RkdGzItd
	G3NYHlXa0/dP27DSQLmiWKyoegypwtFPzbZUZxRJvV7RYHoOCyVy5pxjJ6021sXousB9GVaZkH3
	6dXL8FkqG4xKGb24iX05I5dDbv5luNbKUI2nrZZsKkqFkldnfy858rB7aSbNH58uc9bH74jd8sm
	me0lJH9umqvTwtGOu2wY70H4CQEnNtZR/bJkf7t405PhzJNvf3KdZPHxPfvpgZORuxOldUVupSA
	8eOX1EPyMOfdDJSwrhKBAb1IUOr3qKZzfQKFLgtGe2czqR6gNlcIcwlZjCc3oFsavQc7+7lJI9v
	EBReSWapx0m9wpJKXgj5F+WVU19YOmNETNw==
X-Received: by 2002:a05:6a20:7286:b0:2ff:3752:8388 with SMTP id adf61e73a8af0-348cbda9840mr22906013637.32.1762275081096;
        Tue, 04 Nov 2025 08:51:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGaLO6FN0FgIEDIwpqrjcy5p2PW1tPvFsUVt6Qr/tHg7dp6PNqNViYh5WVOVGls3SLKLHAw1w==
X-Received: by 2002:a05:6a20:7286:b0:2ff:3752:8388 with SMTP id adf61e73a8af0-348cbda9840mr22905967637.32.1762275080450;
        Tue, 04 Nov 2025 08:51:20 -0800 (PST)
Received: from [192.168.29.63] ([49.43.227.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3415a1c3c6asm5091872a91.8.2025.11.04.08.51.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 08:51:20 -0800 (PST)
Message-ID: <8c664765-2c5a-4e42-8390-5969f0bce671@oss.qualcomm.com>
Date: Tue, 4 Nov 2025 22:21:13 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: qcom: Program correct T_POWER_ON value for L1.2 exit
 timing
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mayank.rana@oss.qualcomm.com,
        quic_vbadigan@quicinc.com
References: <20251104-t_power_on_fux-v1-1-eb5916e47fd7@oss.qualcomm.com>
 <29b32098-39ca-440d-9b51-915157b752b5@oss.qualcomm.com>
 <2d4a192f-45b2-4aee-bcc9-dbe0dce0aa93@oss.qualcomm.com>
 <571d5733-be1b-449c-ba5a-414e0f950463@oss.qualcomm.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <571d5733-be1b-449c-ba5a-414e0f950463@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=dNyrWeZb c=1 sm=1 tr=0 ts=690a2f0a cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ISmZZG41GQzdpg15mxjwIw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Kzw4ZGRcYsZX5uRzB6oA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: oEFQA3xV_ELSo3NyIUPkA5dSzpG_SD1N
X-Proofpoint-ORIG-GUID: oEFQA3xV_ELSo3NyIUPkA5dSzpG_SD1N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDE0MCBTYWx0ZWRfX+OLvQfrW5bZP
 L+Z/dK+ydbghILm5IaM/XP8bxHFuMwgWVZF5e997i8E2iuxEQCR741841QCGyAUQpwHpEz8sjUw
 PO3u5YSLUaa0Si8BkdYXuyOvyTbou9hJfIY/OYyTgxN1csyis56+SGl9VpH35HzG+Bsam2lfqIR
 GPO0OwSf+G8/Ku/rMdsMFoZjnvCGXgRZahTSQd37BDRBusm3+QZV5FBoRDVftdhEj962tzLkj0W
 TF9rzwa5XqVG/Fu09mnQy8BiVlr6jKLMLydx+7BGnyvyQzny/Au2TjtwP6jok1ObF9MDtjx3Et7
 VW6bWaxiZpAN1Z7SvpYGj8tZxiPYt12+thSsZ4YG5Crw4koBJaJ95ZOTzHXwZKQckAtMVWTLFkM
 posnNxYUak4uKVju8zVEaFxrQ3RCaw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-04_02,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511040140


On 11/4/2025 10:13 PM, Konrad Dybcio wrote:
> On 11/4/25 5:38 PM, Krishna Chaitanya Chundru wrote:
>> On 11/4/2025 5:59 PM, Konrad Dybcio wrote:
>>> On 11/4/25 1:12 PM, Krishna Chaitanya Chundru wrote:
>>>> The T_POWER_ON indicates the time (in μs) that a Port requires the port
>>>> on the opposite side of Link to wait in L1.2.Exit after sampling CLKREQ#
>>>> asserted before actively driving the interface. This value is used by
>>>> the ASPM driver to compute the LTR_L1.2_THRESHOLD.
>>>>
>>>> Currently, the root port exposes a T_POWER_ON value of zero in the L1SS
>>>> capability registers, leading to incorrect LTR_L1.2_THRESHOLD calculations.
>>>> This can result in improper L1.2 exit behavior and can trigger AER's.
>>>>
>>>> To address this, program the T_POWER_ON value to 80us (scale = 1,
>>>> value = 8) in the PCI_L1SS_CAP register during host initialization. This
>>>> ensures that ASPM can take the root port's T_POWER_ON value into account
>>>> while calculating the LTR_L1.2_THRESHOLD value.
>>> Is 80us a meaningful value, or "just happens to work"?
>> This value is given by hardware team.
> Sorry I asked the wrong question
>
> Is it something that comes from the spec (PCI or DWC), or is it qc
> specific?
T power ON value is part of the PCIe spec, expectation is this value 
needs to be
set in the hardware only, In QC this value is Zero so it requires sw support
to program this correctly before enumeration.

- Krishna Chaitanya.
> Konrad

