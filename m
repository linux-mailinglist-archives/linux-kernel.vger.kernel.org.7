Return-Path: <linux-kernel+bounces-731679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8314B0581E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 12:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B79411C229E8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 10:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC6E2D6400;
	Tue, 15 Jul 2025 10:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jACinTzg"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF06D83CD1
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 10:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752576343; cv=none; b=qQhToelhCBGvlIkq6Mu4IAcvoOP0UcmeGlL+T/xaUKZm8YR/hUDflUUxKpeDHsfSX7c6wxH2QrAHgTkObtziO6MK+yE6iGnvVQSWZemDfyBHOOuMIu7BQLaplWdQl4LUtdpgf5S5AGk/t08qNFNR6dqk7A88MslQWkN8J4GUPh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752576343; c=relaxed/simple;
	bh=CfYh8DkkhWHdbOj70b8Ln5YS/2Tu1reIjDXMJzIQ994=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eysGhOWfJUsWaqeQqAXo5ds5Vst5XAM0qOw58Elkmaxt4cKuQkqpnxLuquhB0Hmvvouyc+qkJLnRJ2WFvmGgfSoZsGR1s93CaHt0FViZHo4w1SCc/4l2W0w275UrEjKyevPmnteQWv548hTvmC4vrq9ZC3OmAj/riLAoV3gbdE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jACinTzg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F6bjNq027809
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 10:45:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tr9WXr9Wgj7PvxNWPB9n3YKLwTySkY/xbEpjc9/ztVQ=; b=jACinTzgr1v0nWpu
	WZ6WR/aJa/cwBUlYXeoSTuw25mB3o97uUfdlBxz+Ebl3dHXmEdysfaw8EAD1HQ7r
	KeJbix/ryqbYrOHg0VKzmTiYJ4IP0yGnQ6zgHIzfxuZbspnB2/N1jL8GhJSUmhAG
	HjSxABCmfW4Ok/OD3pRKEc71ExtxEWrz6+XBSL3/V7SQ1Bs9t51niDnlJW1gGcaP
	M0Fuwuyrzl2fNMp+aSn088/WoWDyrS4oUrE238MvnLPg1i+htgAfikjELpUug2cR
	fi0ogDj1HTrjHN4kPBVDB6L5GKTqkHgzpFk7bi7jYkxxs5G4uXzDMFIjNX7NP1tq
	pGok6w==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ug3800wk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 10:45:40 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ab7a01c38cso3777021cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 03:45:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752576340; x=1753181140;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tr9WXr9Wgj7PvxNWPB9n3YKLwTySkY/xbEpjc9/ztVQ=;
        b=xSV8Y2Yym0TlUWjiSXS+ERDL6zsRbV5Pu8ZWAwzGDuZNtAGTE+aY+OpMQPi2O9FGqP
         GBnfRkuF5SeYjqk6KKBBgbiqyLFQekL/FP3J6CxxBBnfBOnZkJsDbABNjj7dpCuZgAaG
         VDJ0vKVFdSjJ/oVE/6lb65scnsoOe+iadN7VKBMj0fKGVODL5ioXFvuZeUIzWYospDrx
         87cI3nWasa736CvSIFNQorqxJMCvWgGPGdEegb9BmCItdLiEvGJT3abvEEzae9xsXKDq
         f4qlkbAoBYOkaDFnpm3cshrwufGRfLjgA4d0Nms2kYnLl9/RpJsGUKBqFlQslkqyHN1t
         h/LA==
X-Forwarded-Encrypted: i=1; AJvYcCU1+a3KFWoJjTX/vi8A5/mPR5/t/c62vin8aK1LSZuDZGsIr9ZkKH5WcznfcvGRcGu7JLhMJL5SSPpL20U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8MXKhFGnmoNU7hzcSPl1lFpW0b0qqQXb9tiNODBkzJD2wTGhO
	WJYJnwhuqOU7ZcD4bmKbEisveOxKtm1QNPeT5eOuk6gJhvPYVL8l8vuCmLtCKd9SHeQFVdqdO1B
	A0FEflCpr5IuuHviDDZc4ZE0FUjnRtpPcPWvUKRq0wNkpoEuVnrFEWv4mmbcOoUck6OI=
X-Gm-Gg: ASbGncvJZOi0qbQuPn+fiyx3Cps1dBH4MM8ptw7OIL7vsvFKBxJ7+sXmUKshdjFLMt1
	X6AF+Qsu7dMoPvx7B/8GSKuFNg6qZKSgr2PknuYkRn5k5xq2moSOxCKtXrA7qrTpC9k6OI5dwTA
	jxTPUeqWoL6fxlNgUYd46QFPskORwoeogUR39LtSzeL/0k9l453Z4bpSqI+fXWzD4gqYItWpbPb
	L/XKKn8rJ9VjbRsK1UNJBwwDbajr1U8phtEYjpTarX/HnkSeMsPm1QRRuAZq5BMrnEDtomajKvC
	hJdFVSgmrgEkdIPIqm9WqJbmeaAhRCTEZAmzikjOA5OZagOpobeWoEJ/RrSgUpWX8zt2xu1SHez
	E9WHW2Nq7S+F4fSY+ftsx
X-Received: by 2002:a05:622a:15ca:b0:4ab:56e5:f7a with SMTP id d75a77b69052e-4ab86f019bbmr6093181cf.8.1752576339743;
        Tue, 15 Jul 2025 03:45:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYZ+kADfcmFUm38+00lNuVDsKPEuidBQZWRv82Z/GlBci1nkAns1DuTkn8l/4Flef3Jxig1g==
X-Received: by 2002:a05:622a:15ca:b0:4ab:56e5:f7a with SMTP id d75a77b69052e-4ab86f019bbmr6092921cf.8.1752576339109;
        Tue, 15 Jul 2025 03:45:39 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7e8f9b4sm990861366b.11.2025.07.15.03.45.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 03:45:38 -0700 (PDT)
Message-ID: <55f2e014-044c-4021-8b01-99bdf2a0fd7f@oss.qualcomm.com>
Date: Tue, 15 Jul 2025 12:45:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] PCI: qcom: Move qcom_pcie_icc_opp_update() to
 notifier callback
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
References: <20250714-aspm_fix-v1-0-7d04b8c140c8@oss.qualcomm.com>
 <20250714-aspm_fix-v1-2-7d04b8c140c8@oss.qualcomm.com>
 <b2f4be6c-93d9-430b-974d-8df5f3c3b336@oss.qualcomm.com>
 <jdnjyvw2kkos44unooy5ooix3yn2644r4yvtmekoyk2uozjvo5@atigu3wjikss>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <jdnjyvw2kkos44unooy5ooix3yn2644r4yvtmekoyk2uozjvo5@atigu3wjikss>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDA5OCBTYWx0ZWRfX98nkU0dLMaeX
 gl6hY/ry49kQbVKxA7ytwc+9T+MC3fP5mxu6GWgt+OND1Ywny3e9HBowCqt6cf/JupU6xaC+/FI
 mLNO4+zLPbYGp4nzxNF59EEdUg7Cls9jv+LhyLYZOsy5k1Vc/yqmW0D3E+kfQLa/HmIzHMzUkdM
 BJFLutviLaSne5GO4dZ1sB7lo6ZJEqkAL4TvwjJd5fUuLES8n5C043U3x2Df0aM6H1VbvWyutZy
 nIDftkVxHPfikCuvYxM822/vhngC9sdgE9+YB7BBLE7nL8hEKPOAYCbOh0YR6XT6hmGtdOKLm0N
 Jld2OID9PnwJVHwLRZ6mtfgM1w/pEtqI6oOAHYaVBtq2UFVrZKKCGzisfM97JZoW5AhY9hKh28T
 5MjcjiS91hwk5u7QG2NkHLijVqoaT1dMhrcQ1SPBj6aV8sLwMf9nTsiXzksKJpmXtVEXNKWu
X-Proofpoint-GUID: -xFEfyIfsC83olICZZgQgUFs7UO9eAP5
X-Authority-Analysis: v=2.4 cv=SZT3duRu c=1 sm=1 tr=0 ts=68763154 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=uNiOjgRUHSxkwL6ZQ2AA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: -xFEfyIfsC83olICZZgQgUFs7UO9eAP5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-15_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=999 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 spamscore=0 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507150098

On 7/15/25 12:36 PM, Manivannan Sadhasivam wrote:
> On Tue, Jul 15, 2025 at 11:54:48AM GMT, Konrad Dybcio wrote:
>> On 7/14/25 8:01 PM, Manivannan Sadhasivam wrote:
>>> It allows us to group all the settings that need to be done when a PCI
>>> device is attached to the bus in a single place.
>>>
>>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>>> ---
>>>  drivers/pci/controller/dwc/pcie-qcom.c | 3 +--
>>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>>> index b4993642ed90915299e825e47d282b8175a78346..b364977d78a2c659f65f0f12ce4274601d20eaa6 100644
>>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>>> @@ -1616,8 +1616,6 @@ static irqreturn_t qcom_pcie_global_irq_thread(int irq, void *data)
>>>  		pci_lock_rescan_remove();
>>>  		pci_rescan_bus(pp->bridge->bus);
>>>  		pci_unlock_rescan_remove();
>>> -
>>> -		qcom_pcie_icc_opp_update(pcie);
>>>  	} else {
>>>  		dev_WARN_ONCE(dev, 1, "Received unknown event. INT_STATUS: 0x%08x\n",
>>>  			      status);
>>> @@ -1765,6 +1763,7 @@ static int pcie_qcom_notify(struct notifier_block *nb, unsigned long action,
>>>  	switch (action) {
>>>  	case BUS_NOTIFY_BIND_DRIVER:
>>>  		qcom_pcie_enable_aspm(pdev);
>>> +		qcom_pcie_icc_opp_update(pcie);
>>
>> So I assume that we're not exactly going to do much with the device if
>> there isn't a driver for it, but I have concerns that since the link
>> would already be established(?), the icc vote may be too low, especially
>> if the user uses something funky like UIO
>>
> 
> Hmm, that's a good point. Not enabling ASPM wouldn't have much consequence, but
> not updating OPP would be.
> 
> Let me think of other ways to call these two APIs during the device addition. If
> there are no sane ways, I'll drop *this* patch.

Would it be too naive to assume BUS_NOTIFY_ADD_DEVICE is a good fit? Do
ASPM setting need to be reapplied after the PCIe device is reset? (well
I would assume there are probably multiple levels of "reset" :/)

Konrad

