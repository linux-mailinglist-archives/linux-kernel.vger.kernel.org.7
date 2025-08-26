Return-Path: <linux-kernel+bounces-787038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3953DB370AD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 18:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A06767B4A60
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 16:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E1C3680B6;
	Tue, 26 Aug 2025 16:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G58DRmbu"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9E4275AF9
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 16:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756226443; cv=none; b=WeeuDz1rl2qQHFf4uiUTHF05T9U+8MxXoUzWmhwnPkzthw0bO/hARaEsQOrdc0+5w7YxY7u4ifG9GroU93Ahrp+61LPfCl+BcoQ+aIGZGx7fvu1g5ub7KVgbKkJfGlsQiJ37L0nG9ydBguXxyFtGUnmH/zx7E+0bCSi1Q7gbtGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756226443; c=relaxed/simple;
	bh=J56EJimurRukl3HtUzV6/w+RvxdfQC5smmvRwJRThGk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eZ3H+T2wW42A1CyfPRDYALNCXRzcwuEjKB+t/IrF9SgOXdEv4GtXRsRz+uczuGUqhYiNoL7L8LbIFiZN8Q8QLNwUkKnHJJw3yBprygbtRjN2x35WCAQCLfW458E2MIkC1m4J3EVvDN2GCGOmt13CO45yMTM2YtoGHsZ+KhK5QhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G58DRmbu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QGMV6O030036
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 16:40:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	D8Cf1CJKboWxP5q6R9op8Umbt3K2i/Dw/P1MbHCzwOI=; b=G58DRmbuwEUS4o2h
	8tV3cbWxBlhGZysuRweeh60AncgOaM3rPSQVPCZoBEAdLGxK60cKoGCIOuJEcL7m
	Q9mNEve5xv+EfeCXpqc3lWz+dr/U9cV+wYYyO1mPltRPWf2NarpdBrziynk4lUsz
	NeFX+VrObpy/5frnVlzvuOKGstYpF33J3323wdw/xDs9NC6GxCFqOLKk3aG9gaF/
	vX/DA3S0beVvqKryKMVJ+L5EZe/2ZKps8tdsnIKx7+EwA68MhxdGvLDSWLRz3R6x
	YAiQoB857POlABA/DuetPtzzqDFQ7rzMPHPm2rA5kM1xdzqfeXjPaA/ca0Jx3Ly/
	ju7H9g==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5y5hgnx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 16:40:40 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-246cf6af2f4so47738725ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 09:40:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756226439; x=1756831239;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D8Cf1CJKboWxP5q6R9op8Umbt3K2i/Dw/P1MbHCzwOI=;
        b=i0NNQPuQug6FJ+rPuhdMSRw7khlNcUzhlG5fyaPetGlWFwnJsO8UfsDdBIz248wTqi
         aDIk3bB+pDQG/mkkyrqbbq5mpYQ4QrM3GpfdVZaoiCkEVsBJ+dlpmN7PP/SzLhWzhgGt
         5APdnQpQ2EaSaQbitIAVV28h1cm4jpYzETXKZB1IqdIP5NOs0OHk5Yvgoy+kUVNH8bsb
         43s8ULbHd5vOK3rndBSkEs152ud4sSc6oMLXSVWAQpGgUYrSNKdcdwDdsJmPCUsHs3Rj
         46Xa1Qdgs9xLR6JxCR7n83t5sf20OHywjo8lTEHUZR2jjHF+G2jN8r7LzkVOqMsx+usc
         anYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfOb+QV/xtJaSCe6H9u7nzTaY3ejMIq6vJ/UgryRCgC+wJGA6DCyhGHB3kduoqRPZXH2yCDfoSw2laeUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4kNpx4ZVa3G9e+haWBA28IPrmQisGPiGfW6Nibj/BCOv1heMD
	E1DArQvReeJNDIiOI7RQe/1MzawVcWu2Jm14tN+841QHvRERDKPsLKZOozWG02HpqIV3w+j2kw0
	/5wzqLFKgh+pXV90A098DRkOw3T/jECpMpt8WJoHlTNvUBFCT7jgq9mHEgInmvdZFYvE=
X-Gm-Gg: ASbGncvtfkd+wys17T1tNMJaTZkBa19rFPqbfYCfNdvzRaNsgsFLKv6z1OrbQNy0MLI
	KmcWoeKK9F4kkYkchzW0NlCMiLecPr0CkrjLtO1cqbKpYHzzycf1A2Bat9FmztOhyEc0LEyLdFB
	QHMT14+5RI2KR6Up7qQevIdixoGgQFRMLUHRjl4Cm//JiWXuwotVvbimuxxDdJwK38dZe4xScKG
	w2NPNk0YFCkphrwLbteaSnygNRcdw1ui7/fPcwIecsOEvAx5uJIHNh3BwgM5+Ttrv7GWUJ1prv/
	3/JACnByDPVYxql0jXFpY86Li8YSo5yYSacwP0Z8Qgd8YIhDZpsWujSK96Ac5hyLeXBm08sq25d
	lD15LSvZAjyuxQutGpto=
X-Received: by 2002:a17:903:187:b0:235:ec11:f0ee with SMTP id d9443c01a7336-2462eded8bbmr208960545ad.14.1756226439412;
        Tue, 26 Aug 2025 09:40:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkvFu2SKqaYn2g8jSdQZR+kEMDsbfiuYDSgXyjcnbv8H+hGCJesN+r1R0F9BmVI7ktbx+DaA==
X-Received: by 2002:a17:903:187:b0:235:ec11:f0ee with SMTP id d9443c01a7336-2462eded8bbmr208960165ad.14.1756226438902;
        Tue, 26 Aug 2025 09:40:38 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24668864a4fsm100775575ad.91.2025.08.26.09.40.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 09:40:38 -0700 (PDT)
Message-ID: <e4178055-f3a6-4cb3-8c86-731130c6f25a@oss.qualcomm.com>
Date: Tue, 26 Aug 2025 09:40:35 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] wifi: ath12k: Use
 pci_{enable/disable}_link_state() APIs to enable/disable ASPM states
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: manivannan.sadhasivam@oss.qualcomm.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam
 <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        Jeff Johnson <jjohnson@kernel.org>, linux-pci@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        ath11k@lists.infradead.org, ath10k@lists.infradead.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Qiang Yu <qiang.yu@oss.qualcomm.com>
References: <20250825-ath-aspm-fix-v2-0-61b2f2db7d89@oss.qualcomm.com>
 <20250825-ath-aspm-fix-v2-6-61b2f2db7d89@oss.qualcomm.com>
 <2fab10a7-8758-4a5c-95ff-2bb9a6dea6bf@oss.qualcomm.com>
 <705a4fe5-658e-25ac-9e4d-6b8089abca46@linux.intel.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <705a4fe5-658e-25ac-9e4d-6b8089abca46@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfXxQPCfHC9470L
 noOydqaNyXVZGYEwzszFW1k1pf+8ChbmbSkiheErSQi/+ApuxXGv8wRM3QxNbq+HSoTD1f4gvaE
 NrwvtZ8PPu2U6XzcObqzylbLk9iq8V2JnR4wTp7FYZk7cOS5oq6Sux5kA9XSVr3zWyoXlK1zpKe
 qlM0MrynEij2uARZ16ZV6OTwVr362896dxYZv7I4MnJps9FDclR15m+tQ6rf5SkVIMF2Gp/eBb1
 0RCrFlzaGKe/ES6Ov9sznrNdXEGQYtcLHibd9E/Xh9fb8m88dmie9of8KsZ9j+hqOg0VFb+Xl5K
 pyBnV8r4NH0R19Q0ARZjyBiC3WQVKNKaVsekaw62uOaEw9y/OD/cWmCKuQsdrAPhA21E4/Qasf0
 6Fruryes
X-Authority-Analysis: v=2.4 cv=Lco86ifi c=1 sm=1 tr=0 ts=68ade388 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=8JU3Fd4Pt_mHVKaqA_UA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: WS9L0d8hbfl5KjhuCSgQElfN238KFifQ
X-Proofpoint-ORIG-GUID: WS9L0d8hbfl5KjhuCSgQElfN238KFifQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033

On 8/26/2025 9:00 AM, Ilpo Järvinen wrote:
> On Tue, 26 Aug 2025, Jeff Johnson wrote:
> 
>> On 8/25/2025 10:44 AM, Manivannan Sadhasivam via B4 Relay wrote:
>>> --- a/drivers/net/wireless/ath/ath12k/Kconfig
>>> +++ b/drivers/net/wireless/ath/ath12k/Kconfig
>>> @@ -1,7 +1,7 @@
>>>  # SPDX-License-Identifier: BSD-3-Clause-Clear
>>>  config ATH12K
>>>  	tristate "Qualcomm Technologies Wi-Fi 7 support (ath12k)"
>>> -	depends on MAC80211 && HAS_DMA && PCI
>>> +	depends on MAC80211 && HAS_DMA && PCI && PCIEASPM
>>
>> As you point out in patch 1/8, PCIEASPM is protected by EXPERT.
>>
>> Won't this prevent the driver from being built (or even showing up in
>> menuconfig) if EXPERT is not enabled?
> 
> It doesn't work that way, PCIEASPM defaults to y:
> 
> $ sed -i -e 's|CONFIG_PCIEASPM=y|CONFIG_PCIEASPM=n|g' .config && make oldconfig && grep -e 'CONFIG_EXPERT ' -e 'CONFIG_PCIEASPM=' .config
> #
> # configuration written to .config
> #
> # CONFIG_EXPERT is not set
> CONFIG_PCIEASPM=y
> 
>> Should we consider having a separate CONFIG item that is used to protect just
>> the PCI ASPM interfaces? And then we could split out the ath12k_pci_aspm
>> functions into a separate file that is conditionally built based upon that
>> config item?
>>
>> Or am I too paranoid since everyone enables EXPERT?
> 
> One just cannot control PCIEASPM value if EXPERT is not set. ASPM is 
> expected to be enabled, or "experts" get to keep the pieces.
> 

Thanks for the clarification. I now have no issues with the ath driver patches.

/jeff


