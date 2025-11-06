Return-Path: <linux-kernel+bounces-888389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC59FC3AA78
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 12:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E0761899DF5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 11:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4438230FF3B;
	Thu,  6 Nov 2025 11:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O71WoNgu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DA5rHgl5"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED7F30F94B
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 11:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762429331; cv=none; b=mKBvlVVUQah0ZPx4tW/ml6f4DgSnUd99glirmIDa3ISAiphWn9v9EtgZq+QeJ0FP00ydJ/TjGO3gffikPXn7NPImEhcLvJ3Sh3c8y0r29B39uhbFDNlFR5DLnDyqe+Kqi6MoFNl8ck7uXAnBePHBc9sknFxh9QTr4X1KJnpOuPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762429331; c=relaxed/simple;
	bh=sQLg/ltUathCjSADzC6pfsCa5ibsNIbv+YZgTavNDqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tJ8QoR8Sg5Q01Z3EA2lax1LSUHBeQa3l0NbvvKSgV7eLtOzNdyKWGYfII+6bi9KlZwdOWeX25vfrrQBi9hYf/Z+rI+bSqeVd4KvuarsV5hHenFKdhdylCFAK5Pp1Chkowdv3tnSq93upfro1GZFyrQNTy5Hte4am/JHKc+OFsoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O71WoNgu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DA5rHgl5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A6ASqdJ3748999
	for <linux-kernel@vger.kernel.org>; Thu, 6 Nov 2025 11:42:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XyNQCdDuYt8FJ59B50KoPOS+Dq0RnIAj1w8pRuHSc1A=; b=O71WoNgualVbB4gO
	gGKayh8cjXI3XqcJwjUE49yMHZVVhTFb0LumjebySrTqklpZdYeF9dO9kbstU5Ey
	HNSopO0bCzMLyJTFs+RI4p3QKQ2d1mUxd5HYn8ALccQsYmJL3YZD0W4ZbVXfsnBD
	TPuBZwIGW7P2vXXY8iEUIvEcsVsmrHrAs4QrrAH2mT6fX0odpVtgwfjhGzQuWtqH
	S5J5Vb056WkxMeGNcw9cenhHIGg3OPo2eMeJXh9wPqszdRAGu0HIIWYTbRAT77g+
	XAUMkqYyfa71bNdYRKKrtojAPFqe6lcNQNPseKyxQupVJhfQg3bqPW5ZPJL2bhFw
	FKeaEw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8sy6g5mc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 11:42:08 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-297b355d33eso2725145ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 03:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762429328; x=1763034128; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XyNQCdDuYt8FJ59B50KoPOS+Dq0RnIAj1w8pRuHSc1A=;
        b=DA5rHgl5yj5CpSCZ4CnmHyaTV8kaUenE1iTEFY6MuwNXKj+0tbabw70Rg+qO1s4StG
         anFxGh/f1ciuXf0Mnzg2YOGCP6paq3UfYqPG9yrseNdxfom8IR4BKOruq8/PTxfZkJVj
         /dr7Vwwr10wRq9zFh2zomNLop6Oaqz11IA93Z2kijdQAD2oBzP4Yaq1nFAAMcLd48r01
         bPBVY20H246BdnGgbONwnhDKF9g8aZ2We4/Dgv/Ly51yUuprOyDiuC5eVBFl+6wa7AUl
         HcHu+1qGNQPWq7W+eJT/duom2y7C7yU1rCyZbhhySf7Goo3H91T6E/OQLWXvbh9jAH1w
         uD+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762429328; x=1763034128;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XyNQCdDuYt8FJ59B50KoPOS+Dq0RnIAj1w8pRuHSc1A=;
        b=mISvLqLPRFHxDo8Vle8vemsb/VojIhbXNS4cpkqU2pzAowY1pewHPWOumi2dpgn5E3
         y3BfcsZViEJneFi9Ym5LPcFpBYXz0H5itm4dlBbbUAdrfhJ1PJbb7S61F6VZx3ooHEs4
         vEHuAPN7NlCyi29W5xV8mecjLFBrNQl0i30jkCgwz+NKCk/lotf+cpC8IIGUbykUQxvk
         lfV6uxiEUMrvzJf8hSlx+ZJ/LWyGdfLl7+fPbXU4ZsEY9TSGjW0Pofp7CAZhE4y4cZs7
         9hlBY2ksDuDCBWyslAydOJsrgXgPLZJqk2DTjZbO1P+F3HqQY8zIu0e/4z6RMmusT4wS
         pSOg==
X-Forwarded-Encrypted: i=1; AJvYcCXObS2NFZEPisyYhOJadHveaG7cFa3T2bjVZ/FU3HO9cRWhi2Xv9kugQU8tfEaiioSAg1DhHfoOaErk8RI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt1QseYqQqBN5kPpLL5eAFMUdndnwR/SKju62QFVWOu4TGU4sG
	UhxsTobyHo5yN9ePmB8XVQAtf4Tf6hCvRzgMTSrd0qXZcMzo5Vr7klkNiEOh2KJIPjrwofLpWM9
	aGpibV+sxu2Z7eeT/3vXdiMHccQ/j54hvCOdS03I0vuua/vl21duhWHt6jBh4X681SYE=
X-Gm-Gg: ASbGnctxz4GAdZaRkWy7mPtAfsKWBTH/eMmlEPNMHzOgtxImpRcTFM1KrqnzuruvAC3
	4j1hz8aHN8VJMUM0i9rUHYH2w5wMqf4wZT72GMAwbFFTP0oM4h3sbFpMXZ6dFKBS2W7oHdP2dqg
	j4ox65hfrriYQX95Cd6TB0iv6KrOdlnak6UsQYZFPUZJpODIxZMmLZNI51qKp7DzbVyfFfdcbZg
	RmIxX6I8LyXCDXDjpsiAX99YEYcbhbStOh2ENKRizp78hjil0K6ffIdkJPI6cTPTtSDs0eQ+M1U
	+p+ajPPYuBLhb7EbI6qD+m1QzFOBZqQRPMK0QyOp+A8iinrf10usFNTVwxrksUmElcDkWBzCZ/S
	Y1X0p159uF3JEUWjjCa015+mDqTL0Vs4=
X-Received: by 2002:a17:902:d48e:b0:24b:25f:5f81 with SMTP id d9443c01a7336-2962ad16addmr101807125ad.17.1762429327225;
        Thu, 06 Nov 2025 03:42:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGA9TIB8orqE5oPIwoVJXvrc38Pb3yNWldPGYOvWIlv3ebdEia7DEdvxcYxMUiRoVSNBpxMMw==
X-Received: by 2002:a17:902:d48e:b0:24b:25f:5f81 with SMTP id d9443c01a7336-2962ad16addmr101806835ad.17.1762429326694;
        Thu, 06 Nov 2025 03:42:06 -0800 (PST)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650c5fdb5sm26117435ad.44.2025.11.06.03.42.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 03:42:06 -0800 (PST)
Message-ID: <d739102c-d7b1-4c5c-9246-200e17cf1ef1@oss.qualcomm.com>
Date: Thu, 6 Nov 2025 17:12:01 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: qcom: Program correct T_POWER_ON value for L1.2 exit
 timing
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mayank.rana@oss.qualcomm.com,
        quic_vbadigan@quicinc.com
References: <20251104175657.GA1861670@bhelgaas>
 <e459b4de-52f1-4c20-be84-07efdc9fed93@oss.qualcomm.com>
 <tecoemfjvcuwrvhiqxla2e7b27tgsmkahrbe2msr6vlh65alvp@vhlklrfasjd5>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <tecoemfjvcuwrvhiqxla2e7b27tgsmkahrbe2msr6vlh65alvp@vhlklrfasjd5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=AYu83nXG c=1 sm=1 tr=0 ts=690c8990 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=lcPbnEz4b48S40dIIKQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDA5MiBTYWx0ZWRfX5ru53ICLCePI
 mwkJA5KsvIoz1qCOBOVdEBhdRV6BLgEQnIHE5dJzcMaxY+wuQrcZbsDNqdO026k8zWl7+DIYrpz
 bAvKbBCBhz1DvwzlMQkM7z1HQQo137k26lcKdjzzaZmwiPTuWfW1lzzr3keV+onSciuyzF2C6Ga
 CkaPUAK2rYrVLKgcyWyE1ZXV0qB5LZyAckbZmbptzKmj2UBVg8x3J8DnL1o1rggZ2wPAqHk8g1d
 zA632SbMRw/Ru5UfnbQxHtrCP9gqkiOyJzUI1tVvvAtHdZtjyktB4EZ9Ce2DbPQUOTSNmljlMp7
 HzFOniSho8Gy+c+kdm8e34Y6mw4ZurTZwxewbjGL25QNvTf9Xk1MUxEZdxQJcaJHxZNsflzBUqR
 7J8IsZskjWfP7XjjQmUGvZUF8d6MuQ==
X-Proofpoint-ORIG-GUID: UBBGH1pWgmTkjzBFC4dwIreWGjZCXpgS
X-Proofpoint-GUID: UBBGH1pWgmTkjzBFC4dwIreWGjZCXpgS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511060092


On 11/6/2025 11:51 AM, Manivannan Sadhasivam wrote:
> On Thu, Nov 06, 2025 at 10:30:44AM +0530, Krishna Chaitanya Chundru wrote:
>> On 11/4/2025 11:26 PM, Bjorn Helgaas wrote:
>>> On Tue, Nov 04, 2025 at 05:42:45PM +0530, Krishna Chaitanya Chundru wrote:
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
>>> I think the question is whether the value depends on the circuit
>>> design of a particular platform (and should therefore come from DT),
>>> or whether it depends solely on the qcom device.
>> Yes it depends on design.
>>> PCIe r7.0, sec 5.5.4, says:
>>>
>>>     The T_POWER_ON and Common_Mode_Restore_Time fields must be
>>>     programmed to the appropriate values based on the components and AC
>>>     coupling capacitors used in the connection linking the two
>>>     components. The determination of these values is design
>>>     implementation specific.
>>>
>>> That suggests to me that maybe there should be devicetree properties
>>> related to these.  Obviously these would not be qcom-specific since
>>> this is standard PCIe stuff.
>> Yes Bjorn these are PCIe stuff only, I can go to Device tree route if we
>> have different values for each target, as of now we are using this same
>> value in all targets as recommended by our HW team. If there is at least one
>> more target or one more vendor who needs to program this we can take
>> devicetree property route.
>>
>> I am ok to go with devicetree way also if you insists. - Krishna Chaitanya.
>>
> Since this is a PCI generic value, using devicetree property makes sense to me.
Raised devicetree change here [PATCH] schemas: pci: Document PCIe T_POWER_ON

<https://lore.kernel.org/all/20251106113951.844312-1-krishna.chundru@oss.qualcomm.com/>- 
Krishna Chaitanya.
> - Mani
>

