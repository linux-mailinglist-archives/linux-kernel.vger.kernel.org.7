Return-Path: <linux-kernel+bounces-819264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D54C8B59DA8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 18:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF0917B5956
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C74374283;
	Tue, 16 Sep 2025 16:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kS4lkw4R"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E388C343D83
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 16:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758040145; cv=none; b=kwUVNUlBzkLy5sON/6nR3yaIQYFRo8jIPfFbYjbl/pUUfMCUNhZ3lOSGuGRtBMabqO7u/IWgzD/qF3ENgDANKL+ziEC2Q1PyKkbeuXrZe/cOr7SpJeJKQsk4yod1SYc/QLL1wdEhq+wdXT+0FJx1/4602pkI8fJh4mqPXX+dOqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758040145; c=relaxed/simple;
	bh=V6lAa+9GoxL6c9GboJo7qMttke2uib1segmBaCPWwYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uV+gIvevNRAPd+OrxRIU9mwDkd2stETXFwfgwLCXk4GnsAiRHMTQRZStdE+bdAVl0U52Ti0dbmGD2Gf2oqBM7sKNuZnttxExcMmWCcGOJZlK0zGAn8IcpqBsAI6aPESrw1ke0pJ+BJiEWpWEQ6C+NXAMStfJdh6lHaN2bNBRsFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kS4lkw4R; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GAWFLa019586
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 16:29:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6z+mI/JcrpDzLXkYUuAhV+t032JKtC0auFvwYLf3i/s=; b=kS4lkw4Rhpjk1jzH
	ycLSJ5U87zk0eOVpcBxNZq7sUuJu69qpcRQ2DO8P+UcYiguE1u7la5nmNZgw5jtJ
	w6OfL0juOzhm/eLbPvHdbIbBln6GTjYO3UqlHA6sZ6uoPqqBHhy9HVWsQbd9e5+U
	Sv5Jd140IzOPzrHdf3i7sqQZa+a8u1qVgtymhuXynYUKm2MvRxlh13j37fMT0mUD
	Lu41y3jdHloXYs0FNBvfdHnjKu5qy6YRSUY+1ndA7I74kCZy2O0487IfsysUC9wA
	mNBIgZJXvOFMcB/GaoCdSKQWoK51wLiHPM0jITCD7VcjYbAmVh5BFa39ijJ26cRY
	PMLyOA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 494yma9kp1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 16:29:02 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-81621e5b962so132763585a.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 09:29:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758040142; x=1758644942;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6z+mI/JcrpDzLXkYUuAhV+t032JKtC0auFvwYLf3i/s=;
        b=mq0TaGvuOgU+xgNdmJH75RHCzIb1jvzWkNlO9lHAFBMC/JdE/g9WTuoih6V4pppK7k
         RrIGHHxqO+dHbFk0dCY9o7FwkvL2RgJ/92kFc6Vm+ydbulBIpNJTg4FJ/z/x/iGsGsfP
         KKvkoPfYbWzk3Qn5bXmxe+rBkBHkpLvCqTCZdnVLolGDUwLST/6MKm0f7VFJ6dBo7TDL
         Vd5FPjmOf/GjmI6YusAcM5YPqN2Lf5tXy/dIErBl7ICKviVXnfuy0pflhVKx1snBH6A8
         F3ezZjsEMhlUQgWf4tfoZ9g8lI2wG6+F97h8zJ4zAODpjd7fJUsFZ5Lau2qj2Q3ou8Ww
         r5wA==
X-Forwarded-Encrypted: i=1; AJvYcCW1xtl1WU43kRtvOTGE+jqhXNvtltt8Z3V9lIPFBaKNHpmqeSuY6ngnYsOGaQAFv6fqkgzmbNZOh7Mz0Yc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBcsc5iQH8AMSgRuMmOTHpMWQ+rrcr7ijKza5r9mplf5To6BQK
	p9QXQuj8oBEEAfoB2WpAF/okWUDiwoBiQRiBrQcAfKc6nOedQpmdiI15ePiQ5VgUR3Dzl3mW9Qx
	3F3l2hbImcbPUVlv32txFRS3hn0UakAoXWKUkLgPliGE97GDAtigGvEjP9KSLOX/7z7Q=
X-Gm-Gg: ASbGncuD1l6FQQnaexKoIPsuBkR9V954uTqfPnNy/EtYeGdvS5zk48oqLvseTohFMnq
	XkQMqQYHJpCiiTmZv7f7kbZn1fmV1ecxOgZI0mjUStPrPvR2JopUXqoNmB/6QiiJ0/KkI3l7Z6L
	fHARs3OByZK+WTh9LB0G2ySAKeTdN8q4tfifA2s8zRWx960UvSeTFMYXEZGrgovwO83M+spmUew
	lWAQV85vedwYpLULTB08C4Os1FEm8TTufgUuVnnS+fZr7iCIrQeLky+LUwqJOJDhBF9FoddqE4m
	xjnl2RmdnpRp7ego7TZWWBhxeJD5dU+oAahYA4cUoe9lMplNZu+nvxEKqvkK5ZrJSmezezdAQGj
	V0+JvNUVa/dqk2KgV+/sAbg==
X-Received: by 2002:a05:620a:9482:b0:827:1a76:e8f3 with SMTP id af79cd13be357-8271a862d1emr782817885a.7.1758040141771;
        Tue, 16 Sep 2025 09:29:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEazc1AwmHCnYAYH/ad0hiuc9j4t/7hoTAeblgvj8r7zz/qfCWQgQ6/hxOe2uHonNnxY7+aLw==
X-Received: by 2002:a05:620a:9482:b0:827:1a76:e8f3 with SMTP id af79cd13be357-8271a862d1emr782814485a.7.1758040141090;
        Tue, 16 Sep 2025 09:29:01 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07e1aed5ffsm791617666b.81.2025.09.16.09.28.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 09:29:00 -0700 (PDT)
Message-ID: <ccf1b22b-8b6d-4aae-ac27-e84943b7ffd0@oss.qualcomm.com>
Date: Tue, 16 Sep 2025 18:28:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PCI/ASPM: Override the ASPM and Clock PM states set
 by BIOS for devicetree platforms
To: manivannan.sadhasivam@oss.qualcomm.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam
 <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        "David E. Box" <david.e.box@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>
References: <20250916-pci-dt-aspm-v1-0-778fe907c9ad@oss.qualcomm.com>
 <20250916-pci-dt-aspm-v1-1-778fe907c9ad@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250916-pci-dt-aspm-v1-1-778fe907c9ad@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAxOSBTYWx0ZWRfX3YwLCO+cMqHB
 8Ut47vWj+UlGixhpK9CDILpkNq8Lluxp96BtC/KwbK1uon63eubfD/BXBVIc1ZUGkGIupmYgSTi
 H/WaGpcf1uWCiG1PSb5299EeHwJDQXNNLlX9dYFD3ZCnYcgBQHRTDVeC0zJ1WiLOoi1MGDkAhdO
 Q0/KKf//VYrdKGoS+WsJugBSfR+ArJo9KTQdQ0nUSrl+yiDIBtYen+wMwjb0gBvVd9TSCuZnfQp
 3m8KUppRUwY0ZPS5CjiGZAU71YUOjCL2z6ZKSHMQF/ogsB3oJR6PYKRdXiwmaD4ZfnaGes6B6qm
 WR9w8MldNz8ZBGM644Y9oOkEoU1xG1+4X97Bhk42KsWjo/ZUNBB6kBH54zEAiFigtfsGJcWF8M+
 DMzgjJz+
X-Authority-Analysis: v=2.4 cv=cdTSrmDM c=1 sm=1 tr=0 ts=68c9904e cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=AEKlotozOucuHJhDSDgA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: fyTKeRuhHgdDH-W0y4Vy53aTeXMfkYEI
X-Proofpoint-GUID: fyTKeRuhHgdDH-W0y4Vy53aTeXMfkYEI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509130019

On 9/16/25 6:12 PM, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> So far, the PCI subsystem has honored the ASPM and Clock PM states set by
> the BIOS (through LNKCTL) during device initialization. This was done
> conservatively to avoid issues with the buggy devices that advertise
> ASPM capabilities, but behave erratically if the ASPM states are enabled.
> So the PCI subsystem ended up trusting the BIOS to enable only the ASPM
> states that were known to work for the devices.
> 
> But this turned out to be a problem for devicetree platforms, especially
> the ARM based devicetree platforms powering Embedded and *some* Compute
> devices as they tend to run without any standard BIOS. So the ASPM states
> on these platforms were left disabled during boot and the PCI subsystem
> never bothered to enable them, unless the user has forcefully enabled the
> ASPM states through Kconfig, cmdline, and sysfs or the device drivers
> themselves, enabling the ASPM states through pci_enable_link_state() APIs.
> 
> This caused runtime power issues on those platforms. So a couple of
> approaches were tried to mitigate this BIOS dependency without user
> intervention by enabling the ASPM states in the PCI controller drivers
> after device enumeration, and overriding the ASPM/Clock PM states
> by the PCI controller drivers through an API before enumeration.
> 
> But it has been concluded that none of these mitigations should really be
> required and the PCI subsystem should enable the ASPM states advertised by
> the devices without relying on BIOS or the PCI controller drivers. If any
> device is found to be misbehaving after enabling ASPM states that they
> advertised, then those devices should be quirked to disable the problematic
> ASPM/Clock PM states.
> 
> In an effort to do so, start by overriding the ASPM and Clock PM states set
> by the BIOS for devicetree platforms first. Separate helper functions are
> introduced to set the default ASPM and Clock PM states and they will
> override the BIOS set states by enabling all of them if CONFIG_OF is
> enabled. To aid debugging, print the overridden ASPM and Clock PM states.
> 
> In the future, these helpers could be extended to allow other platforms
> like VMD, newer ACPI systems with a cutoff year etc... to follow the path.
> 
> Link: https://lore.kernel.org/linux-pci/20250828204345.GA958461@bhelgaas
> Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---

[...]

> +	/* Override the BIOS disabled Clock PM state for devicetree platforms */
> +	if (IS_ENABLED(CONFIG_OF) && !enabled) {

JFYI CONFIG_OF=y && CONFIG_ACPI=y is valid, at least on arm64
Maybe something like of_have_populated_dt()?

You can then choose which one to use with e.g. acpi=force

Konrad

