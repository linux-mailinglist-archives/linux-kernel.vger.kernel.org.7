Return-Path: <linux-kernel+bounces-834118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22569BA3EB7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 15:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 481D6623304
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 13:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA23C267B07;
	Fri, 26 Sep 2025 13:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="izncMGYN"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE352F745C
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 13:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758893971; cv=none; b=jWM/km15jj/urxOU0LkkGlRyes8HPvDH0kDNvMvqQ7D/LQBboBv1yJ9u5OhYtA100pYiwOnLc0bOWZlavBGmMwzv5AgFl3PAJnrDJHAvlNRFFbqiYnsInuN+4z0aky0fBLTzrsB2zko1dX2GOAjRitnf9Dh/YRCwq6XHYRjAbOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758893971; c=relaxed/simple;
	bh=j48e7ePqhHhvcJSE6F/tY3Q0p1ZzRgdOesq05a6n2Q0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hVke5oM2alYEeBdjQgQGqkvMNGdrC+Sw1PmN7OBnzub6Lj2PxSbvmMeCEPfpLRgU6HnxeZkwxgctrzS7bj/sYYCaxjtGWxNZcEwJILBkkj2LJce+zDDoutlmPkSgpucVb71QM2ZgPIjvkCfDU6sN8SEnTOHDZm6ktrjQaeN3tNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=izncMGYN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58Q9k7bD025875
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 13:39:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	E63HIm6hfUIUCF/NebOyqvn6g+tEqkfrm8u2QMJ5tw8=; b=izncMGYNdUqo8E3w
	gQZxTs52PektAYwyZSafWsuPESdlDkPK79sbajX8hDHMXorHmH8P9o2HR/1JLQdt
	OpZW+6yye80afqDWs3iqyNoIkqtWPXvbBVX9S/gz6TOPExAM26rAnehCi8+ij/6a
	sueHn0d6nN9i76ndyP9gxQ5IuZbpjfjStLS5a4SAtgzA6G85JfQGvC340XrkHuZN
	EoPyY3RHd44NdBFvJTyblFemUHcRVwdGyCIvhgp2o1W/p0uM55anRT95fpOlt7/Q
	qxZMGKiAyDNoXBfglP4uWeELZgzvUQsTcvKWbVn3cTo6GyMFTnAuLtMonQp5M3Ai
	xsnmDw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49drfwgmtm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 13:39:28 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-77f5e6a324fso3990519b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 06:39:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758893968; x=1759498768;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E63HIm6hfUIUCF/NebOyqvn6g+tEqkfrm8u2QMJ5tw8=;
        b=bTHL2w/CffwmHaK8ApUaUh/vl2kNcmJJjN9J2PmHPTAd12Xi3ytn8rmrPbcIAviOzM
         RhnAkrY+VpbV6PN5ID6rirhEJGSwCLm2JanLQplNob1NRaVAVJENf2Ujen7CHIGXXKjH
         8AmcJDzpL61T9S8NtxcALgyfx97pEMPEjqH9UycBZ9qA48f8EgKSKNJsRLTVODwyFYPI
         BI8BAtFAfzHYTZEbei3XeBdKCxBy8uMG/n+ctB6EvYgH7i3B0EeNuDqAe8n0dFX05vn8
         Wad8gLcS+D+SP+E55G8VNUH8Zm16O9NFC3eOYjPbyN8fCPnH1EKVQPPD359yVQY3tHbo
         5uDQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0/KhBRyyfDCLZvSPJADIZ+RWn/bNtHOGsDelVKdD1t+sjv3tWkPh7yZJlsEQ7Kf2EJTK4iab8mI73+zU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8DYS5QmuwXrRdnFuscclLuarNT8AJmtb3W0/Tru62TXkPWAm5
	Az0L+5fu3QaPFaHWnHTdBq7gStLGEoazLckupHSuJvF7psXx3GnyAHa/0wsSMOHZAJaLwEYIb4T
	gcKoBfqyiKomtHobygAocvxF25e050Qxww51/F7NxzIBdNgZm0QjtGCassmhCZ0e7G60=
X-Gm-Gg: ASbGnctQHGOcSvsASZr4MXBU8VUxs6/FTUIvMOjP0Zq6blYlBv8SeWIzdWpHLzU6sIy
	+6FpHrkIB6MSdNSWdMPZcl3+PQJFVPtrhLLAPvEstQxcJnal2r8/rz5NgH/Dvs6ItffsYaKtKhx
	LU5Y8D74redBlebFXQOA3V53WjEnlVOQzrOaLT/MTwhfJ4D3P5hJVxHwU1zxeORjtd/j7gEEyCu
	WDkLQM3GhGzYA/TUvsopaRtepqEy/QX9LcSIqTIjMETT543adp9qKa2fnPAY/F5L6lDY2eGpSgk
	rVkJmobgU3vAMY6y3oKaouJtS4ZboL7SJJHoTfMpI5YZ9pXs/EPH8yJ8kEBNzxbg/DsITb+bzpM
	=
X-Received: by 2002:a05:6a00:23cc:b0:780:f6db:b1bd with SMTP id d2e1a72fcca58-780fcdd28d1mr8678973b3a.4.1758893967782;
        Fri, 26 Sep 2025 06:39:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiaP1HxRLVUpY8VZEiq5l3q06EZMQQVXQhWmy8UEaYDj2MmG+Nz3UAs4qURBGWNpupm3mF0Q==
X-Received: by 2002:a05:6a00:23cc:b0:780:f6db:b1bd with SMTP id d2e1a72fcca58-780fcdd28d1mr8678917b3a.4.1758893967264;
        Fri, 26 Sep 2025 06:39:27 -0700 (PDT)
Received: from [192.168.29.113] ([49.43.224.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102c048fasm4502469b3a.75.2025.09.26.06.39.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 06:39:26 -0700 (PDT)
Message-ID: <4a3f9494-27a2-47d6-bdef-0b1bcbd99903@oss.qualcomm.com>
Date: Fri, 26 Sep 2025 19:09:17 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/9] PCI: dwc: Implement .start_link(), .stop_link()
 hooks
To: Bjorn Helgaas <helgaas@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        chaitanya chundru <quic_krichai@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Jingoo Han <jingoohan1@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, quic_vbadigan@quicnic.com,
        amitk@kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, jorge.ramirez@oss.qualcomm.com,
        linux-arm-kernel@lists.infradead.org,
        Dmitry Baryshkov <lumag@kernel.org>
References: <20250925172517.GA2169496@bhelgaas>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20250925172517.GA2169496@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: DhIdM54dHMLPel2c_BDpLy2Jm0J84rhW
X-Authority-Analysis: v=2.4 cv=JKA2csKb c=1 sm=1 tr=0 ts=68d69790 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=w+9hNF1SH6wH5mqaHp+xkw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=AYVm423qkfQxZcs1cpAA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: DhIdM54dHMLPel2c_BDpLy2Jm0J84rhW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI2MDA4OSBTYWx0ZWRfXzFEnkQjajQq3
 iaGYKLWsch9K5rbMUX3/Y2TotimAxOQnUXRXj6FKlPLVAxu+5quG4I3T0nNCyXPSOURvMpfqH+K
 G2ptq8TQxNn3sxcivMgyZMDhxvv5/MRAYZBRF0ApzuwC9UvQv8E2d4ENV5b+eLL4+YptKqhCAWB
 29GgLfLEdfoMTGgjG9kMKkJvhZlqWzxe6KBGXIkOqCo+p/33ptYqT02e8eBZ4hVUMc3NA1o2UGi
 4ClsdBric8bL9aGoSteNPnzVqT+bglmBSom4/G+X6qMJ5RyiDi3WZkuX3qojKjQUMJVJUrS4aaK
 0XYf0D8GvNsZYq/CKgc08m9NeDm081k++u7Dn4c5mxa98davv5PBCyXa+5rxLi0bUpIGZ38V/U5
 Tc+yyVPtlAOwSbFrcDa50F8WAiIDKw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_04,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 suspectscore=0 bulkscore=0 spamscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509260089



On 9/25/2025 10:55 PM, Bjorn Helgaas wrote:
> On Thu, Sep 25, 2025 at 09:49:16PM +0530, Manivannan Sadhasivam wrote:
>> On Thu, Sep 25, 2025 at 09:54:16AM -0500, Bjorn Helgaas wrote:
>>> On Thu, Aug 28, 2025 at 05:39:02PM +0530, Krishna Chaitanya Chundru wrote:
>>>> Implement stop_link() and  start_link() function op for dwc drivers.
>>>>
>>>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>>>> ---
>>>>   drivers/pci/controller/dwc/pcie-designware-host.c | 18 ++++++++++++++++++
>>>>   1 file changed, 18 insertions(+)
>>>>
>>>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
>>>> index 952f8594b501254d2b2de5d5e056e16d2aa8d4b7..bcdc4a0e4b4747f2d62e1b67bc1aeda16e35acdd 100644
>>>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
>>>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
>>>> @@ -722,10 +722,28 @@ void __iomem *dw_pcie_own_conf_map_bus(struct pci_bus *bus, unsigned int devfn,
>>>>   }
>>>>   EXPORT_SYMBOL_GPL(dw_pcie_own_conf_map_bus);
>>>>   
>>>> +static int dw_pcie_op_start_link(struct pci_bus *bus)
>>>> +{
>>>> +	struct dw_pcie_rp *pp = bus->sysdata;
>>>> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>>>> +
>>>> +	return dw_pcie_host_start_link(pci);
>>>
>>> This takes a pci_bus *, which could be any PCI bus, but this only
>>> works for root buses because it affects the link from a Root Port.
>>>
>>> I know the TC9563 is directly below the Root Port in the current
>>> topology, but it seems like the ability to configure a Switch with
>>> I2C or similar is potentially of general interest, even if the
>>> switch is deeper in the hierarchy.
>>>
>>> Is there a generic way to inhibit link training, e.g., with the
>>> Link Disable bit in the Link Control register?  If so, this could
>>> potentially be done in a way that would work for any vendor and
>>> for any Downstream Port, including Root Ports and Switch
>>> Downstream Ports.
>>
>> FWIW, the link should not be stopped for a single device, since it
>> could affect other devices in the bus. Imagine if this switch is
>> connected to one of the downstream port of another switch. Then
>> stopping and starting the link will affect other devices connected
>> to the upstream switch as well.
> 
> Link Disable would affect all devices downstream of the bridge where
> it is set, same as dw_pcie_op_stop_link().
> 
>> This driver is doing it right now just because, there is no other
>> way to control the switch state machine. Ideally, we would want the
>> PERST# to be in asserted stage to keep the device from starting the
>> state machine, then program the registers over I2C and deassert
>> PERST#. This will work across all of the host controller drivers (if
>> they support pwrctrl framework).
> 
> I don't think there's a way to implement .start_link() and
> .stop_link() for ACPI unless it's by using Link Disable, which is why
> I asked about this.  If Link Disable *does* work, it would be a very
> generic way to do this because it's part of the PCIe base spec.
>
Hi Bjorn,

We did test as you suggested but unfortunately the setting are not
getting reflected we need to explicitly assert perst to make sure
pcie is in reset state while applying these settings.

- Krishna Chaitanya.

> Bjorn
> 

