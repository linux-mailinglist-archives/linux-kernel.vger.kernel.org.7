Return-Path: <linux-kernel+bounces-846483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD8FBC820E
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 10:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7008A3AEA71
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 08:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B462D3A75;
	Thu,  9 Oct 2025 08:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g6asApzf"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B510C274B44
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 08:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759999905; cv=none; b=jF6ipouxzx6r48Bd+C/8ImDuuMwObVyn12haOEufvEAiRp2SfzYCxNrUaokJ/6CSe5sd1D9IA5Njr0PvOglSIIbaM/JucPiFyTtcfja1UMVVvkdk0asNcvR7XVIyI0chyP0eh3RiNY7OauJ6gqyMgBAaMHPLSXyWDGjDmLP2TGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759999905; c=relaxed/simple;
	bh=QX4v4DxhfkvVUvRBSvFp2IiBTV7+8gg+zeuRWNyVCe4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VcUhsQ/tVThwFUAn7ZgVHme1b9bB6/7/2wIyEeI/ZJm6+xnEO2scc0HsmyswRiEpOZK9uRdSQWEqLOn9fdQ1cU/SmGuoRwEh3EyOiTz3RcxEhnbCkFxlnY8OKp9Aq8fFxmM6+d55psalgIunuooyZdOVF88YBZ9kWa4nR/ntzM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g6asApzf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5996ELD5029455
	for <linux-kernel@vger.kernel.org>; Thu, 9 Oct 2025 08:51:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rozNwP9rNVxJdTGVPBs6oK2WCT/2tAO/uW1pQSfTVxU=; b=g6asApzfeKmK3zLb
	wl//PB0rnxxAAX8m5sv+CLKGbSipro+ye5sHZr8Z5NIxdtKNP9/TDb9EFWeAz72m
	ejccBed6/GW/q8T72DY7ps+OE4IT8hICP+uHj3ZlapAZ291LsDX6SZTzXtWHIcWr
	H99zwm/DMUKXiIlE1NHBJMKebjumVwQknEGuup3lqjBaMoWuKt6SZEtqmxr9zJbu
	vyoNeFzLoNVXfXaO2sWYHxkN0s1iGDwgFsHpvZ4b68/iu2BCeGQmnfc6LFSZZpEw
	+6myKfy1NMuu7oGtUTB+icHtMBtOfOoW+ka7MKoGbNLvVbYKzt5dSiujbfwqOm1Q
	k7TlKQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4nj4ag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 08:51:35 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-850553dfef2so2957556d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 01:51:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759999895; x=1760604695;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rozNwP9rNVxJdTGVPBs6oK2WCT/2tAO/uW1pQSfTVxU=;
        b=fFA7NnfPHJtBkzxLPONrQUgiheO7xwKozbubt3Zf7HEZSRjtWKrqoiY+CFgHD51qXk
         v5zblNJzbx7/l+/CkFZTxZlRysHv8RFj9FRUW635SnburOxQIABw2oBo5tN/O4nncLA4
         jgp2F08wkevEzF0W263pzfGUHfoXq3iykbGC6ELykpHyQYPZkv0CaMpG7X10MnR8Ipgd
         QbHV1mt+YuHLOj011rURNFmgRfYu0xqzcqM7hx6RrhvXTilxhbAW3WodcEMU1SY8nEhq
         nSjyCjRBU6GFzY4HefxEWCA2c5vJhziZO6MjYZe1M6poCXxSW2HUMg4k/ZPiMGKL4ccK
         2iEw==
X-Forwarded-Encrypted: i=1; AJvYcCUZ5Xi6KBrQBVcvEIlwwldnaTY8o4zvmEvmCff/3iJ0kzzpwAPgBUfwbAGnk5UYpL7juDcMlpfVJw+kLn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWvIonl4dfP3mkSI55Ap/Ir/vvx92/orMxk/WdPFpWK1xmLixr
	5NykR6PDaa1kJcRDsUHWRwBq2HEdFJf7ROaNhy/mGxAsJFvYjwrLFgZkMCQgMLlcMzzIVgEkKR6
	YtB1yo5Ev2i4YKobKu9wC/2+xQ/rMdsZM3mNQBVuypo1D7rLrcSD2Zu3wtBr408OpzZ4=
X-Gm-Gg: ASbGncv+/bIrBvinK0W3PVwGV0f331hb7RqbSV0N4tZ8yo3l1pGEFKnmwixNxYWobnP
	Mrf2K9p0QldX3Yur5SSfIEBXUseju6VT00dMacnaHux85rC/joKjioG+XL5or7SrGmVpSICUrce
	7kj6e/MRXmrDDQmS+yr7KzjRSct3Y4qsp1X0/ReADrPQ13iukeXmyHM814a63BDLoPFLoht0EkP
	ZB09ElDAd7v5hcKJG7PXC74QrR9WK50i7T0D2Jn40FBTOiI3anvwTDMRxGtEihi1eGkxTtX3p0x
	swVqBT/vz0P1o0Yl1R30vKcvdsvKSqyMfZyhLvvK7WAhWqgEI1q8ITZpYavZQcTgFfBEL95hLxG
	m3QKfo+3NYHtXgkr5gQxR2Pxnas4=
X-Received: by 2002:ad4:576d:0:b0:87a:a954:4073 with SMTP id 6a1803df08f44-87b21027da1mr56827866d6.2.1759999894536;
        Thu, 09 Oct 2025 01:51:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdr0m1qJjPCGx95tl5+kQQ8Lc5k1Lvq51C86DjFACuanr/UCQghW1BHHi6401yO2k5MyRZFA==
X-Received: by 2002:ad4:576d:0:b0:87a:a954:4073 with SMTP id 6a1803df08f44-87b21027da1mr56827646d6.2.1759999894039;
        Thu, 09 Oct 2025 01:51:34 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-639f40f23f2sm1850757a12.38.2025.10.09.01.51.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 01:51:33 -0700 (PDT)
Message-ID: <74893f76-1b7d-4cfb-ba7a-9fd64427762b@oss.qualcomm.com>
Date: Thu, 9 Oct 2025 10:51:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] dt-bindings: panel: Add Samsung S6E3FC2X01 DDIC
 with panel
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, david@ixit.cz
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thierry Reding
 <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Casey Connolly <casey.connolly@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        phone-devel@vger.kernel.org
References: <20251008-s6e3fc2x01-v2-0-21eca1d5c289@ixit.cz>
 <20251008-s6e3fc2x01-v2-1-21eca1d5c289@ixit.cz>
 <7askbazrkbny5jlw6cpxcpjyw5nyiozmksoyj5b5momcc7w5hn@r3x6kddatf3u>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <7askbazrkbny5jlw6cpxcpjyw5nyiozmksoyj5b5momcc7w5hn@r3x6kddatf3u>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfXxHh6mz0BMGhL
 etgmM7UX9Si/L3cFmT8s8kgYb4c7GAQMM/2PIVQSjrQ5lESeB74sI1qzYvQP9vAJ/LwHf/27LAh
 blH8bJFpzyf9D1k00KmnZ+S5n5Dc1o/niWiNdzQ7rVO1tgtQoFprlZp633EA3fFwcMvm18yqn/e
 OPkibQOC+5H4SdpHJlikDncvxiGF4f1yxGTevfJ7sLnIYGLaiZ6agAEotbWTe3altAK85lLup6/
 QWyRlaAr5oTLY2dqHmzrf1XDyjktcv+BoYJbpICPgXPR1/LmPf3IMx+D41sZjylti5gIUWd88P5
 MORFRugD+Ak0zr49MBVQGaXdDUOqd28wlDJmgVAjJpOPJJniCrk7F0qC8TYOAM/kHGI1sDSKS3C
 Xe5jJYXs9wbqLX16A4oeaKB7NstvzA==
X-Proofpoint-ORIG-GUID: OwIGxEwuWxKBYC-M4cRQyEH1HjvTmQKz
X-Proofpoint-GUID: OwIGxEwuWxKBYC-M4cRQyEH1HjvTmQKz
X-Authority-Analysis: v=2.4 cv=VK3QXtPX c=1 sm=1 tr=0 ts=68e77797 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=LME89Ewccn7mWiF1t2gA:9
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 clxscore=1015 impostorscore=0
 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

On 10/8/25 8:57 PM, Dmitry Baryshkov wrote:
> On Wed, Oct 08, 2025 at 04:05:28PM +0200, David Heidelberg via B4 Relay wrote:
>> From: David Heidelberg <david@ixit.cz>
>>
>> Basic description for S6E3FC2X01 DDIC with attached panel AMS641RW.
>>
>> Samsung AMS641RW is 6.41 inch, 1080x2340 pixels, 19.5:9 ratio panel
>>
>> Signed-off-by: David Heidelberg <david@ixit.cz>
>> ---
>>  .../bindings/display/panel/samsung,s6e3fc2x01.yaml | 78 ++++++++++++++++++++++
>>  MAINTAINERS                                        |  5 ++
>>  2 files changed, 83 insertions(+)
>>
> 
> Please also describe, why it's not enough to use defined compatible,
> samsung,s6e3fc2x01. Why do we need a separate schema and can't use the
> panel-simple-dsi.yaml

panel-simple works for 'dumb' (perhaps a harsh word for 'made with
just the in-spec DCS commands in mind') panels, but Samsungs are
widely known to require a ton of vendor magic

Perhaps the original change was made with an "oh it just works
surely there's no drawbacks possible" attitude, as the panel
was left initialized by the bootloader

Konrad

