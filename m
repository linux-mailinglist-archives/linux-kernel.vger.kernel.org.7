Return-Path: <linux-kernel+bounces-767637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E0AB25712
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 00:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADC971C28185
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 22:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF01F2FB995;
	Wed, 13 Aug 2025 22:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Mlm+B7aE"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8182FB96D
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 22:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755125717; cv=none; b=fRY/TkbAK+CQp2lRPtHG5+jzwSeITEof2P6UjEfGVqJjL0Sd99WeGgpA7M5HU0zRBLdIlj3abzaXqkHJpdm4Oqn1TAZMY5/QporUjoE5iWyLStwFJZ3LMNHeN6Z/4A0VsFD68xGi/k3wzEmefdO370MBTEYiwujEcU92Qo93ceM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755125717; c=relaxed/simple;
	bh=IRDBklKokVrxIJWgP3cNp+cQqYoCCFC1419AdZuqIVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rlF912/quLY1rGB7I0fOoQz0QpLzU7PCl6HxoKIiYkRwVCyj8jy9lzp4rRDGrMLthjx9saTAtHN1wl099i+fInurf/d5gZDXNMZMRox8jqJxqAtiWr+n/pTadScD+P0PYy0sRa5qWBL7XJ5jzVu+D4gkvUgwU0cCA1kzvbqkppM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Mlm+B7aE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DLpXn0027030
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 22:55:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	15n6L+jgRmpWfdGPkRrYhdr4AzVdCA1CkGjZd9TinAk=; b=Mlm+B7aEgb/H2H/S
	oDv3YBRw/IDZV4u3YHPb4tiivbTejs8GPnkna/krIBRVh/pIFY4rUu4grVJHgqxI
	tyCk0xEe68+QpSiwZR/H93am6LkwTqizlc+IEMSmKTiw9CGfi4+oPMpZNlYMTDcC
	pd+mGYXTRSEumRe9sesQrsP+thI5f9LQcAEfnWR9zB+3AfrBZEkCZ+pOFWCblIXy
	KxHuGb2xwXHhuyFQmi/B8WSAq6nFS3P7E0aX6RdXF2OKpv9pIt8PMhFouaO200NX
	oAuun39iIAzL4kWzThwUwVS9FFDlPiqdQ5Z7LtRvinBXV4kvryspzZ432NYi0cJe
	6Ud24g==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ffhjsayn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 22:55:14 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e8706cb15fso3306285a.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 15:55:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755125707; x=1755730507;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=15n6L+jgRmpWfdGPkRrYhdr4AzVdCA1CkGjZd9TinAk=;
        b=DxUkU1ejZkK/4jLCfJ25k7rvYaiQ8Ob1yRsLdcFXhRe+cU1FR2KDqnEdQCTSS4sBoB
         RbUv/xzOyyjZQ5GxWOGZSuUiDCo/q4WtPdbueEueEPo88ms4anzVUDmHW6SgxzCBto0G
         KmvjVWOxh+rczpCsfKS9imAGDwZIBEWdUbl14x6BR6S2rOKpT5pnjnG/1kgMyqX1Aykj
         Jj8pngw84a+kdqwzIxO2u9cPcwmVnymf/mGg3VBeXgZceC3Nns03qQo2BO5T+llRRsiA
         qm9AQ4PN/fHZwXMggXDlJqxSUtW8AngdiK9k58UwTeLhM9CYyJpn71qtX+E6zGO8UpnQ
         c02A==
X-Forwarded-Encrypted: i=1; AJvYcCVd2rX51I1LlpzG0F7cP04i07sUghYq7B8EtIBdGdTe0yqdxN/6IXGlvmJwN2lg6W8WkJ0GxFZz1LH+N/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFo4gseCNt7U7jo2kvSQLNIl5zglZQmzNhlMEF3N24BfKsnTyQ
	QaJYMhrqwvDX1RVGy3V+1D3KD5blSznCyfmKQqqrb9o7No/E+n2O8gRgnyS2xPpQw5E8s73MCOj
	YyG0fLSd/7uwAW0mo5/bAopjZoBTFgFPson1n37UbJFXgtKoqhWjekeFZT3FHiF7Af2o=
X-Gm-Gg: ASbGncviT41P4p9CicR4ntRCKlR1guljH+e2dGu0HY/54TTKPMUX11pCuGRsX2xlDs7
	k5UHADJ6Q2xF5Ql+pO7kjMN1fbBS2/lS6QJP8pBK9Qs2SguuLDS3fbm0RMC+w1RWOHGVt3oehb2
	56gEZXcZLwFNvLLSMDrFOgs2FMs60Kaw8MdmZXuV7oq/RIemiy08YUHoPCIG+FDJZ7yiLLqW1/H
	xe7ETwFv5As26HuTW5ydCLi6QzOEIILzFPf17z+BXLCq31xxHQDvyPYL78mn4RpI/YX88XINDc8
	ONXdQDztQVu+Ks39UqDLRzzS/gATitNfCtNT4T8T9VEuKAmd4D67rfYJBYetHrY3lt+Ts2CH6Mr
	gsZS5l2AiithTyaf/Zw==
X-Received: by 2002:a05:620a:7114:b0:7e8:deb:2b88 with SMTP id af79cd13be357-7e8652610cdmr341648685a.5.1755125707349;
        Wed, 13 Aug 2025 15:55:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHL+JE0kMKFEu4kSodVCBMSDyNOEdDfPuoTQBCZSYXiPZDVvx1jvbqJkcBjR+WKF+Ba2gnIkA==
X-Received: by 2002:a05:620a:7114:b0:7e8:deb:2b88 with SMTP id af79cd13be357-7e8652610cdmr341646185a.5.1755125706781;
        Wed, 13 Aug 2025 15:55:06 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a3cecsm2470000066b.53.2025.08.13.15.55.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 15:55:06 -0700 (PDT)
Message-ID: <cd2ded3a-ab91-4199-9edf-8acc8d6d11ba@oss.qualcomm.com>
Date: Thu, 14 Aug 2025 00:55:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/24] media: iris: Allow substate transition to load
 resources during output streaming
To: Bryan O'Donoghue <bod.linux@nxsw.ie>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil
 <hverkuil@xs4all.nl>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Vedang Nagar <quic_vnagar@quicinc.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Renjiang Han <quic_renjiang@quicinc.com>,
        Wangao Wang <quic_wangaow@quicinc.com>
References: <20250813-iris-video-encoder-v2-0-c725ff673078@quicinc.com>
 <20250813-iris-video-encoder-v2-5-c725ff673078@quicinc.com>
 <24714b00-cc15-4c9b-b0d4-8c76d702fcc2@nxsw.ie>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <24714b00-cc15-4c9b-b0d4-8c76d702fcc2@nxsw.ie>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA3NCBTYWx0ZWRfX0qw3O4VkWaZT
 z9FMaNBXE3VzjyFptY2dIKCI6Haj444mR7OpMnJZcaIZEwsgLbaNle3g8fwA6hVqMB5xdz52dD3
 2w4Pagrapodw4bUnNY+8QJIlXDmKR34V1yKRLolGscIC5Deff0PVLyTXqXsp3T8cum7ZmqARlsn
 X3LxLGQX2R7c818H1YiBaVHQ3hiWvLR7/UwTwCJVLJjslbe1V8RuVXvC8G03FyxZn+doM8EkFjS
 uaObsU+p1s0GiQzQes6zBsW6kYyV9Sb0cvoXhGmpq/BAdhog0Y6T8wCUHA59cy0o7s9zqndI9BO
 wzNUNjIFOe4BtEhOomBbHzL+xGETJXkqgOMnzXpm8zs/ddK36J1Gbh7+ghBkaZU/gWQ659BQyZI
 tATe3fHV
X-Proofpoint-GUID: AbHvNVk3V6FLU_GUh3a5V-m88cdJImc1
X-Authority-Analysis: v=2.4 cv=TJFFS0la c=1 sm=1 tr=0 ts=689d17d2 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=rixuZvB9KV6YaslLPPsA:9
 a=QEXdDO2ut3YA:10 a=1R1Xb7_w0-cA:10 a=OREKyDgYLcYA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: AbHvNVk3V6FLU_GUh3a5V-m88cdJImc1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508110074

On 8/13/25 11:51 PM, Bryan O'Donoghue wrote:
> On 13/08/2025 10:37, Dikshita Agarwal wrote:
>> However, now after removing that restriction, the instance state can be
>> OUTPUT_STREAMING when firmware start is triggered and substate needs to
>> be moved to LOAD_RESOURCES.
>>
>> Fixes: 547f7b8c5090 ("media: iris: add check to allow sub states transitions")
> 
> If a restriction has been removed, has that restriction been marked as a 
> Fixes: ?
> 
> If not then we can't actually backport this fix as the dependency - the 
> restriction removal has not been marked for backport.

Please stop confusing fixes and backports..

If you're really paranoid about this commit getting autoselected, see
'noautosel' under this section:

https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Konrad

> 
> Please evaluate if the necessary change you have stipulated here has 
> been marked for backport with Fixes: and if so mention the appropriate 
> commit SHA in your commit log.
> 
> If you are referring to the commit immediately preceding this patch "Fix 
> buffer count reporting in internal buffer check" then again you should 
> mention that in the log so _which_ dependency you mean is clear.
> 
> If I were trying to follow this series on some kind of -stable kernel, I 
> don't think this commit log would reasonably tell me which depends I 
> need as an antecedent.
> 
> ---
> bod
> 
> 

