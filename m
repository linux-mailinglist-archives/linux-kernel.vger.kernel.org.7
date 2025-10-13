Return-Path: <linux-kernel+bounces-850310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 547DABD2789
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 12:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9F60F4F1DF3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 10:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9102FE575;
	Mon, 13 Oct 2025 10:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FO3eR9up"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E7C2FE06F
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 10:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760349980; cv=none; b=hHFMCM9W/BdJg+z+hBJD/OB8NsYBK51dIvzxFOdajL37G+rT+w1oJekrZSLepZxFu7H7M4ev76WiPy3rji1iHSzvkvreMsM9fXYJ/ofp7hAf0FZAYjkbRHpRxkDVdlyRi2SUx+qRsmjg64qVtbNFi4n+/AnYr/esbVFmKRkllM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760349980; c=relaxed/simple;
	bh=lDWxaAzr1ubxN9qq1Z03neK8IbO1ZPnCFdTLsJXI13c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YfQWQng/EyX+a2cxMf9er/GIM6FgcYQBCp8Bxpw3gq61EtKU8ZKiSB3b3MDDTAv4KhLG/PK1US49nHjyS2wmPi9BmjyH8dQJ1bO1v/DUB5s5/FxrT9Vor8vPhqnj8ZpT0Xx/FiudSaA6utIy774WeDlXukNPvPlpZ2i3ER3ZyRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FO3eR9up; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59D4pne1020626
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 10:06:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Otv8cx1oiW9ZoWYFXAyZiTDyE5y+heQuSLgS1nHQFWM=; b=FO3eR9up3aA534rR
	8E+4RFs1jxbtjiluWQLaj4dv5LXAMIrccWwmGQsR+fkksA/b34TNlX7M59aQ+9hd
	o30iuT9jt7YCmCFfAxQWY+76ohV4KjUC/lTZb0fs+ztM5Mmu5AI6gXqMpWlh+yJx
	CdrcVCex/AfXx+VreOeet0FcbWQhpnKLIM1kfw3qmiRNMpaAglkd8j+LrypEBFqc
	Zj1E/Dzphs4NKRFJFeQx+9fKwH7Fnne8nRsjwFlEgYZQv5XO5zg/xeAAf2bU7oFM
	iMRaOJL33B5UaI4wiyIBjZ+/iyDIo7JCD0Y/uyTWLeD6lPAYQejEWt6ewRldMf4Q
	JArytw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49rtrt0x67-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 10:06:17 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-853f011da26so287009885a.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 03:06:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760349977; x=1760954777;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Otv8cx1oiW9ZoWYFXAyZiTDyE5y+heQuSLgS1nHQFWM=;
        b=ZL13/kitryaVJvm0YQalk1g2V6O6pc/yslSuFUtHmgGnNfJ4KLI/RXIvx7q0TiE33j
         BXyfsaSiAelk79C8WtLiqcdNGsawnKhEabrcBQ59n8QFccbmMCW8v3S/9RRSYOsnmSOO
         tYjL16yZrRJD/8YEhOUUkGZzHiuSGZCI9XHPlZfJzFajgkLGDEVpBXGGVrBBGjq0ogM6
         pmWw9JMyqjsrBj2Go/gkSiieCW9/0bV3JSRP/djS/adchIipJ6bctLDDlNgckW5vTc6H
         TVX8TidJXBaEoCmjm28ytnFxHqRO6s+nPESPfm21BQd266ULgECUELgkzqiO7+d0QTM+
         GfTg==
X-Forwarded-Encrypted: i=1; AJvYcCUkzIz1P8NmMqTw5XA6UkPVTddHMALZW4enh8a6xaO7TDZKtXT/WJVEHwBJxVyfcbDakcq0AFHBLBpqaEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxavJff392O/1Zb59WwFsOi9wz7YlBaXNwL6HGTPl9xQbdF+CGY
	BF14xz7ivwEaUOjWvbxXJQtgRRC0GzAWpPuhbSPltQXWLN2w0YMIXJ8GrefAGvwL7Sh9WZm8hJe
	2ke+M3lOBV6/nhsVFsupMTDXu+RoN12lua+irEQVcCJwL1wpm+k47wvzkLYlWaeQ+A1M=
X-Gm-Gg: ASbGncvAloOu+wCurnLA8l4igM9DTcicvR+csCarSRUepn5lYGwF66iFreW9MPI/oN4
	f8mbVO0FjAKtpbYrAU08Vs+B5sEh1LnbWXIzAb1J4OWOftAtWgmT1nbwHKlGGyYv9nYTvprj/rB
	nOl1uV5hJDkQcysOLKW2folu7uBDMPHA4IbLdmJ5xtIPzoviwWU5td7Q2sSJWOhHZcRTLOJRrU9
	7ztmDHVsRoeKzHE0s1mohSdJ5CPMZY7K8fvJLDOOH4LpOXoQWmu2gIigYoCkY0csO7ApUmoS9hH
	6gWFGh+GM2/nc/rw4Qa8YdUeADXaAA8kHE1lqEuiFfJmQBD1qFca5mPlCOR9VzM4nM1pevacuFh
	k8KvaKOgCM1uwFnLg1x9X1w==
X-Received: by 2002:a05:620a:31aa:b0:85a:4bc8:3d2d with SMTP id af79cd13be357-88351fd204emr2008636985a.8.1760349977134;
        Mon, 13 Oct 2025 03:06:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXJ7K8dw++bJphGB127PSJ6QNoV+sG7t2QtOil/vVGVAQL67doMLdc6ejSELgkLCSeMcvtsw==
X-Received: by 2002:a05:620a:31aa:b0:85a:4bc8:3d2d with SMTP id af79cd13be357-88351fd204emr2008632885a.8.1760349976436;
        Mon, 13 Oct 2025 03:06:16 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d9a3fc41sm899555866b.87.2025.10.13.03.06.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 03:06:15 -0700 (PDT)
Message-ID: <375ea9e2-c2d5-4bab-8272-ed54c37f8415@oss.qualcomm.com>
Date: Mon, 13 Oct 2025 12:06:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: x1e80100: add system power domain SS3
 state
To: Val Packett <val@packett.cool>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Maulik Shah <maulik.shah@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251012225950.15475-1-val@packett.cool>
 <0c8735f9-eac0-449c-aa95-b82cec0e6cb2@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <0c8735f9-eac0-449c-aa95-b82cec0e6cb2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: SlZ8odgHfWSQLFGFASftheFZdObgWVHF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDAyMiBTYWx0ZWRfX/UPu6KVVmK7H
 WqO+7XG7qQp0R9sgFZnd3q4Whi2cFQPJyd85BwFUEpMNrjb9ALTniEYtDcAiNN+4NrfAEdoSr6W
 LqdKfyqOzMxsChWUxEe9EK+JJ0URT2/sVbigiVhDkVL7lzMj50t0/aGJnqzPqzA5H857GMxCcA8
 btDcKd7k38mSYVmnHuDhN+buxUs3SIlXfnPf4xIPaZELnvQEVfq76iBiZTCzGhHd2AAxw3sF7aR
 Zy9DEhdbrmLCLQGCwmGI6btqjLXVATEnsuMQSrmA9+b7JxlCL6U7GgMLL7SA7d8wCR+aaH4KELo
 K9snqOIj71g/8fz3fO9UqyGYX8N3+foUfe0xhvi+amGS2zBxF/jYxJ663DaP2ziVtXOuDqzdVCy
 HTzG/InvXfQfMi4Gvyrgdrbk5jYahg==
X-Authority-Analysis: v=2.4 cv=SfD6t/Ru c=1 sm=1 tr=0 ts=68eccf19 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=2QVM00dS0TtG868yuiMA:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: SlZ8odgHfWSQLFGFASftheFZdObgWVHF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130022

On 10/13/25 10:15 AM, Konrad Dybcio wrote:
> On 10/13/25 12:54 AM, Val Packett wrote:
>> Add the same PSCI state as seen on other Oryon-based SoCs like SM8750
>> and Glymur, seems to work fine on Hamoa as well.
>>
>> Signed-off-by: Val Packett <val@packett.cool>
>> ---
>> Tested on a Dell Latitude 7455:
>>
>> /sys/kernel/debug/pm_genpd/power-domain-system/idle_states:
>> State          Time Spent(ms) Usage      Rejected   Above      Below
>> S0             69476          23006      195        21562      0
>>
>> Seems to mostly be used in system suspend, though I've occasionally seen
>> the counter increment a little bit during runtime as well.
>> ---
> 
> FWIW the exact same state is hardcoded to be present if you use
> PSCI_SYSTEM_SUSPEND (which is mapped to `deep` in /sys/power/mem_sleep)
> 
>>  arch/arm64/boot/dts/qcom/x1e80100.dtsi | 10 +++++++++-
>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
>> index 3cf2568def3f..fab8104147bd 100644
>> --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
>> @@ -303,6 +303,14 @@ cluster_cl5: cluster-sleep-1 {
>>  				exit-latency-us = <4000>;
>>  				min-residency-us = <7000>;
>>  			};
>> +
>> +			domain_ss3: domain-sleep-0 {
>> +				compatible = "domain-idle-state";
>> +				arm,psci-suspend-param = <0x0200c354>;
>> +				entry-latency-us = <2800>;
>> +				exit-latency-us = <4400>;
>> +				min-residency-us = <10150>;
> 
> You seem to have copied these time numbers from 8750 as well, but
> it's not a great idea, since they're tuned for getting a good perf/pwr
> profile for a mobile phone
> 
> I attached an old patch I had laying around that described all three
> states exposed in the windows DSDT (although I'm not sure if that's
> exactly beneficial without additional tuning too)
> 
> +Mukesh please take a look

Well, I of course meant +Maulik, sorry..

Konrad

