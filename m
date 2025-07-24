Return-Path: <linux-kernel+bounces-744780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1C0B110C1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 20:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E07D61C23A52
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 18:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D0C2ECE82;
	Thu, 24 Jul 2025 18:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n61+6JW9"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAC22EBB81
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 18:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753381298; cv=none; b=CWhyvKDI/br90gK9vWoOPRLQA6EjHjhnDF1bagocZaSbag52n4/WhWeIrXAkkDwLCVKaW+bXIvooTZFKtV5g7edFUINr1mm8IGIlymEdJ4PFosJjw6AZieQR3WuEDezvMsIYa1Ck5vUiNt7iCkB3g0c3KSENICPuOBbeHFAHMrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753381298; c=relaxed/simple;
	bh=P86RZxhcq4luBoxFp9K2glu21mVN0rpUAcG12WeywIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GnqfUxDq/lBYb/2hBB+E5526q/+FgiHTnbLGmSO62inA4v9Bc0pM3rlykAMqO57TsyNzIOO+hPZszEXhuA856lFwEPdwfcbrXO05RETThOMF4WpoDteQNyNOaSX0KW3+C7jn6ikyz8H1An+ziBU5LfqWqwk04ndI7xsrHFbTJ9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n61+6JW9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56O9Gvpi010382
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 18:21:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	myhiipaB/wUQijkyOLcZiWvOTEGJM1xVMQUaHld2irI=; b=n61+6JW9drxJ9pZk
	mpHo1EtIQ54t5WHCJo5diIH0sfmKMIWNMl41XGSJatRpsPVdOWEg0FafriPhEcdG
	lHULAguO3Ek6P9J/OES3MH//8IZbbCD8oL/6Mq6L5bT6udmeW56Q4HO7U+CStDLj
	BWi3Nboqc269o2k7EGPuB3gP7QQ+W3uDNIH8XjfQXZ8cJrVL/qZieu0pBAhtg3oz
	Pr/h4FFYm9sei22HZ6/SQwOmY9SH8EArdvycm3uBQ6cmLCHxw7cMTaEXStUoy7Z8
	7voQuGnAcKoae86ATFRS9yvk4uHQOdd6by6RLw7RKvrv/4wcIyjU5mWso/CKlc/9
	NyQO7g==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 481t6waxnx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 18:21:35 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-74928291bc3so1247889b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 11:21:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753381295; x=1753986095;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=myhiipaB/wUQijkyOLcZiWvOTEGJM1xVMQUaHld2irI=;
        b=IKu5nio5b6pAG0yAD8DvFl8O/8RZJsjxR5p44qRD9DKwyK7OEVPqoupSj3eYwaC8uU
         uVCJO31Aw6S2lB2yt12MYtuap2xvjoJ9KA/GlwwXGwcWSLFL/F0/FU1wXDmdl4psc+ly
         +FUjQg40XmtAqyD+Bh8D/p1tDdaZ4r/tEM3ZWVkHS9aeFNFVlXTfpK+66SiqY69apk2M
         OlcuWalHGJPXz+KmSKMUQV57epP2JeJwiYFSOVjWzLZgdDmhT/VSCJZTdn+FHdEcWiOr
         R5L6/PUxOAyuVeJ7z3jpC7RPMRURKNfo9WKs7d2C7HO8cNYHl24E8jbWdEBWMT+OuLjL
         Vi9Q==
X-Forwarded-Encrypted: i=1; AJvYcCV5sHoGBh0GF5Vd4uly35btganDY8eUdtnzFWrnrpmweCZssLh0FpdMPc0wExI8rzekZ45TniCzba5cyak=@vger.kernel.org
X-Gm-Message-State: AOJu0YxomrhCIvgUSMRz9Ms2hm4qitbG1/zz+lOuxOMYyu5Fs/eYHPeY
	yDg7Rcl6Ax3S7sCFJtnlg0MzwcpK27RIHFIMN3AO+50P+5xpYSj+8qMEObPTKJba+717URZ++YV
	Qjm0X/owZhJxyfRZA8o4p1FibKHq8cpV8H6rZ/GZb9xfvqcW7wFWdISC7Ap75ziY71co=
X-Gm-Gg: ASbGncsNswVh38FAGrLWsvHReSK2qvGIIZWo52gFEr5i+JskQZL4keXmufsCiPFElfA
	tDFWoFJy9NalVptoIiaPK+SI0fmm3PhCehw34xfNL0xkVVB7ZkbRu+5tea+4HSYg0bEdDYVxPXd
	ewQpqolRCAuJxzi8M49gWQdltzU04Pp2kRNvgfR63Zkjs8YDTDLMBBQigXH4bTADUuJgA1uZNVf
	tFW1iZvhgjXHt/PDKMW7UPHZKRFu+8a04eOFUod2AVvP/JYYHIQE/zzzXJxhHlBaNw9Cv7f82bR
	YkBIwNxTiky04j4abM8d6HMmbFDkvLOFg02vp1+j31Tpq4d7cvkU5IdYYEHtRCd9cgXC/Si7qoq
	M
X-Received: by 2002:a05:6a00:2e16:b0:74d:247f:faf1 with SMTP id d2e1a72fcca58-76034c566cfmr10997081b3a.6.1753381294710;
        Thu, 24 Jul 2025 11:21:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8aaK+IvK/ni16DihbKGYP8ABP6VWfHjhJIfPMM3TuuE2gI7iQAOgMEB1kec1nuMpOExdHcg==
X-Received: by 2002:a05:6a00:2e16:b0:74d:247f:faf1 with SMTP id d2e1a72fcca58-76034c566cfmr10997035b3a.6.1753381294245;
        Thu, 24 Jul 2025 11:21:34 -0700 (PDT)
Received: from [192.168.29.115] ([49.43.231.85])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-761adc70302sm2162883b3a.27.2025.07.24.11.21.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 11:21:33 -0700 (PDT)
Message-ID: <58eb8f0e-a029-cb7f-e63a-9eac6a6444df@oss.qualcomm.com>
Date: Thu, 24 Jul 2025 23:51:23 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v12 0/8] Implement vendor resets for PSCI SYSTEM_RESET2
Content-Language: en-US
To: Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Vinod Koul <vkoul@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        =?UTF-8?Q?Andr=c3=a9_Draszik?=
 <andre.draszik@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Elliot Berman <quic_eberman@quicinc.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Elliot Berman <elliot.berman@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20250721-arm-psci-system_reset2-vendor-reboots-v12-0-87bac3ec422e@oss.qualcomm.com>
 <beb26682-d2e4-40e6-89ac-87f18c0401d0@broadcom.com>
 <56599da9-0200-72b5-012e-942a1fc954b2@oss.qualcomm.com>
 <a1d3264f-a46a-42c4-b518-a66c8e0b70b4@kernel.org>
 <f4725f3f-1b45-ebd2-aaf4-4f986a44eb8e@oss.qualcomm.com>
 <36f62026-9517-42bd-8f9a-92f39fcdc136@app.fastmail.com>
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <36f62026-9517-42bd-8f9a-92f39fcdc136@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=SPpCVPvH c=1 sm=1 tr=0 ts=688279af cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=EAZcAn6cL6OfK3FglxxoPA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=YF7pu-sQtpgReH5imSgA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDE0MSBTYWx0ZWRfXy/0pCwaTDa8q
 OzUOw1R0Vi9XyjhSdBkP3F0DjXFDxmXk/76mAV6MOhQlEBemDlcA3gPYTYXiOLEdilukLfLthUW
 OL9tbgYkFOjeN88F/ueI4qNRkPJ4hVSymf+fobTaZ2c7c4HzgVIAKCHe6IJkGxwbrMgSaCmPwDw
 Xs+7Vdd98FldBeMSQzpmtskzi13xNJLp02kbuHRbr2lgMfa34T9wdxXmlr16LwGmJHF4gHmQCae
 yD6Tzv39RvXZJEyFrPM7ge+/s43dy2srt6f+qsUQqS9yxUj+9tiCNoNwY2p1997nG1CTW2atsdP
 92atopOpIlWmEOwjz1BFvhYknaJu+ZnVRUcXb98uRuoOXhtgXbU5KP3lJwFe5utGb5KEUEMl2kd
 AHVQdRqg3+y3+WuqNOacYmdVxBSdUsB3CLhX+V3hdxo4O1+c6jPpn0fHc8Hdxa1KkAbIVpxx
X-Proofpoint-ORIG-GUID: LMqomSh9n3pH0BhG2L04pB8nhJzYIhN4
X-Proofpoint-GUID: LMqomSh9n3pH0BhG2L04pB8nhJzYIhN4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_04,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 mlxlogscore=986 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507240141



On 7/24/2025 8:13 PM, Arnd Bergmann wrote:
> On Thu, Jul 24, 2025, at 16:04, Shivendra Pratap wrote:
>> On 7/24/2025 6:18 PM, Krzysztof Kozlowski wrote:
>>> On 24/07/2025 14:24, Shivendra Pratap wrote:
> 
>>> I strongly insist using compatible as way to find your device, not node
>>> names.
>> It will look better to switch to compatible. Will define a compatible for
>> psci reboot-mode binding and align the patch to use the compatible for sysfs.
>> Current patch defines reboot-mode as a property to psci, hope its fine to
>> define a compatible for this property like "psci-vendor-reset" or
>> "psci-reboot-modes"?
>>
> 
> How about using the reboot driver name as the identifier in sysfs
> instead of the compatible string? That would make it independent of
> devicetree.
In current patch, psci driver registers to reboot-mode using a device-tree
node. So reboot-mode does not has a driver name for psci's reboot registration.
its like -  reboot_mode_register(reboot, <struct device_node *np>)

Now when we want to use the registering reboot driver's name for sysfs,
either we- 
1, Pass an explicit name from psci driver(say "psci") while registering
to reboot-mode.
or
2. Create a virtual device in psci driver with name say "psci" and then
register for reboot-mode.

which one is preferred? suggestions? 

> 
> I had a related idea to provide some namespacing on the actual
> reboot syscall parameter, as we have two (or more) orthogonal
> concepts here, when there is more than one reboot driver and
> drivers support multiple modes.
> 
> E.g. you could use
> 
>     syscall(__NR_reboot, LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2, 
>             LINUX_REBOOT_CMD_RESTART2, "watchdog");
> 
> vs
> 
>     syscall(__NR_reboot, LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2, 
>             LINUX_REBOOT_CMD_RESTART2, "psci");
> 
> to pick one of the drivers, or
> 
>     syscall(__NR_reboot, LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2, 
>             LINUX_REBOOT_CMD_RESTART2, "bootloader");
> 
>     syscall(__NR_reboot, LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2, 
>             LINUX_REBOOT_CMD_RESTART2, "recovery");
> 
> to ask for a reboot from any driver that supports a mode, or
> combine the two and ask a specific mode in a specific driver like
> 
>     syscall(__NR_reboot, LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2, 
>             LINUX_REBOOT_CMD_RESTART2, "psci:bootloader");
This will introduce an additional feature in the reboot-mode driver.
If a colon is present in the command like "<driver name>:bootloader",
Call the "<driver name>" specific writes only. 
We want to add this feature? 
> 
>    Arnd

