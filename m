Return-Path: <linux-kernel+bounces-802134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F8EB44DF8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 08:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 754B01C242DF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 06:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81E02BE7D6;
	Fri,  5 Sep 2025 06:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AzVtrVzJ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2902BDC23
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 06:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757053882; cv=none; b=MtPrJGoNFjz3JUMVPo1bpFpsyIvBn6pgKRMtrVEF8oSo9TzSZ8sIXcdycjIw+GIClK+NrKvmmjt2TIvoofK2rJoONZF1p4CaCVLuEhz/838MkG01IrrJfsKM6VAbAeBy0sy3harap1DWBdt7Bu64UXO9IbzLmrB67gn40cvax3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757053882; c=relaxed/simple;
	bh=c+qCkBwUcNTbqtKHddqUYexmmRMT9xAUaD45trrVIqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BOKZX7r7zkXBW/3PQgVe+v2xm8fneaR1VWyC216bgUP3hRMAmTgMlHp0cm7s27QvfVFPvUX767JNQoWrWDd70Pj2pai4H6pR1ob5qdvpTzVbHcoMUCfMK+4fGMOh1JudP07gZhCfpx1OANa4eObxdxsm3kBLRdpSu8y7mrj5+Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AzVtrVzJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584IAL8H022145
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 06:31:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ihUchhbr+BPTutSAMH3QPkZ1k4UUvBlJqLlucFmaUzQ=; b=AzVtrVzJcsW7ElbT
	DqPGbcveokIzhJepOdZCV4f3wFdinbwoKmCv3EtfGrbzcUsHDYAwD6hH5EhbODVj
	dWbTjF2IYUA4f1Uf3lo8K27VoTIPcncYjP9qpUBFWz3PSner+u064gTqQro4RWS9
	33g65acPdZRHB2MdJu9Lx2EEx49d5FFgH3O6xGaywnCRxli/foUdEAhDYMyQlmqA
	EafcfT9dOt2z58QRMGjT80f3VK8piYI6eq7K/69Q0O/z/9F65azI20lArTEOswzy
	TSpCHGOOZDjBQ8WOCz41jVRFRmj4+XFAVHYeN6Vi0knWoDKIAEZSbQbr62bBjU5f
	z3q+lg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48utk99xy4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 06:31:19 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b4c46fbb997so2254958a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 23:31:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757053878; x=1757658678;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ihUchhbr+BPTutSAMH3QPkZ1k4UUvBlJqLlucFmaUzQ=;
        b=gR0DWC8g3PFBcqtHQmDTKcn90fXnxmE+2BnbvDqf8gMHoA+kCAlH7o4RAJkweSBJFX
         fXRWMrgY6WlrWijHEQkWGe7zg6sGEGIJn8ruYmNzyfk+ynRoB8RseULMxmZU7Jr3S7lL
         Ydl6/ufbTMz6wIZtCmu50V7wQrc1TPnUEX03Q5uboJJtrqPXuzM2p59XemOXjgVYuXhS
         r6qGV9qU1oKjvvKpg+xA+3ISnHQOos8c9iS2XqRVTtK4tivbS56nVO8UD3doRrJlWB7U
         S5ea2GPHvaSGwDUtgEc/UP2MJXxqLkQ4DBvcScDX0dam9NZnoEdxVb+Ex/rvvqeWsbo0
         u1mg==
X-Forwarded-Encrypted: i=1; AJvYcCXOStaSy1jbWRhqK6oGYiPUNGjelnGcX4cXAbYstRk27jOFMBDGzsDDAuHjqFV+v6WSnXjl6hqsuJYnei8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwOmwv4G03fJ/bExqxia5zHnqXPUzf+T4C+gqHu7M7Ww2yQ3U7
	aEPLWKoKoAUNnM/ecK49exDdxU1URn+j+OqSiGJOCaQZD58maNnZDCxNK6mUaxUUJSreikC/JnA
	o0fZ+FFe7rka7ueaqk/bKwUgBzWP0Ef6fOIMG2p832KInPv2CNnZcsZJZGRETHqq6ap0=
X-Gm-Gg: ASbGncv0DDZ1s/4K6zugNXyTLbuFbpeSKwgC9jCMCxphv3ID/mUTTrWa9BB3gX8GKDc
	4V7pp6P+M+2corxhiIoNjtxFtIZMnlQNqT4sYw4CrON6fDtPTqcucGKrzlnJXyvhXgax2kSOGum
	HXpiTgkGSAAP46J0OGnKWPnOHEtmd3AviauDOpnjxObdwpd/E6kyCkOe8QFUUb+EwZ2eVq7BDMC
	vnjF3YJ29E6Ag5hF+wwKfn6yebuQJWbPMdhTT7mAn2RJpdHuBRcyyvXFznFmYfeD/7jiSioFU+C
	Qk0QnubS8spMqchTYozYK9mMVmr65ru55sKX+atp61ZGg0fU731HIsjJHP7xmlJSCHmWrMpZT/c
	kPNBPQbwrWiPiFpRFbn+0tMKGcGReIy+T
X-Received: by 2002:a05:6a20:1611:b0:240:1e4a:64cc with SMTP id adf61e73a8af0-24e7f5ad1c8mr3634916637.12.1757053878337;
        Thu, 04 Sep 2025 23:31:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnzYt3qIjxJ2UxKLfHlG3uR/JqPIbskDDWIrtlfTXdYVFfX5BCyUCF90DYXyEmWrm4+f7kkg==
X-Received: by 2002:a05:6a20:1611:b0:240:1e4a:64cc with SMTP id adf61e73a8af0-24e7f5ad1c8mr3634875637.12.1757053877874;
        Thu, 04 Sep 2025 23:31:17 -0700 (PDT)
Received: from [10.133.33.61] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4f80181dacsm12244112a12.40.2025.09.04.23.31.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 23:31:17 -0700 (PDT)
Message-ID: <d7e5cc9c-4918-496f-82de-05924c61d06e@oss.qualcomm.com>
Date: Fri, 5 Sep 2025 14:31:11 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 3/3] arm64: dts: qcom: Add base HAMOA-IOT-EVK board
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250904-hamoa_initial-v9-0-d73213fa7542@oss.qualcomm.com>
 <20250904-hamoa_initial-v9-3-d73213fa7542@oss.qualcomm.com>
 <cf873dbd-1f97-4796-b973-a0d6ed569f37@kernel.org>
Content-Language: en-US
From: Yijie Yang <yijie.yang@oss.qualcomm.com>
In-Reply-To: <cf873dbd-1f97-4796-b973-a0d6ed569f37@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 52Oy_tzAt_eOrQRjc6ZNtqn0gFTeRb9G
X-Proofpoint-ORIG-GUID: 52Oy_tzAt_eOrQRjc6ZNtqn0gFTeRb9G
X-Authority-Analysis: v=2.4 cv=ccnSrmDM c=1 sm=1 tr=0 ts=68ba83b7 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=K1182fJEmGhiR4m-f2wA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=M91JV_wKSCcA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDA0MiBTYWx0ZWRfX94ZKWw/lyE2e
 8Lp9ROHD1NXIUyt6csyCfeza8WBdpLy6xuW2ZgNltihmGn6uphSh5SAxybJecll8Qp/1vsNAdd2
 ZqI3RC9w2+fPi6Kv6Pa4aBHbatVdtnToZYuMSttMaHxtQQEYjmFXyZ1Fh5HldZ+RsGMGtM8ViDE
 9IGYgEzW4XVn1ouFbmVuG+WxfXM4vazE7tvpnO+YAIukkH8cDILowJdcWA178h6fGredCX6PszO
 5LsP9rIeWiM5q2d5E/PK+wAWSpy6RiiSxEvOUrFZ2XA6qeMD1/FivZYjTPzxZgLlNQNFTLaqMAd
 v7EazAPlgY+Y+iH02wQCr6xuIG7F3Ws5sn1bNepTFOIwe03jmRFF+hAyosyhkixJ+uUFf2I3ind
 nE9mh4xB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_02,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300042



On 2025-09-04 23:15, Krzysztof Kozlowski wrote:
> On 04/09/2025 09:48, Yijie Yang wrote:
>> +		#sound-dai-cells = <1>;
>> +	};
>> +
>> +	chosen {
>> +		stdout-path = "serial0: 115200n8";
> 
> Huh, why bothering with testing prior to sending to mailing list if
> community can work for free...

Sorry I missed this — I’ll fix it.

> 
> Best regards,
> Krzysztof

-- 
Best Regards,
Yijie


