Return-Path: <linux-kernel+bounces-777088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C87BAB2D4E9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 09:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B53AB58019A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 07:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF082D77EF;
	Wed, 20 Aug 2025 07:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T+8V4XH0"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363B62609CC
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 07:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755675257; cv=none; b=Cjb5hzaHgodKIy7NndmSD/TmS0OZIv8F51d8wFdU14qRM+wSr8etVeoALQCTLTtKuUNGM+WRAR7RQtc5y//Cgt6rkgscEe0nmF5QNZF/60O/rBeDv/BkVu+VdK2fbeLnPspLGgM6bymdiA5FKnAwMkzln1T3ZnvuVcvdxYSY3U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755675257; c=relaxed/simple;
	bh=Iisg/7t+/UfhBThWqhBkCbnrYHd0FsQDYG3FNeciXNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TRudou14fXLIFYDv+ou1S7ezXTaIpBoap1Wcf8N5pDzNtFhRHfDzw0OiPdQSgmWfgv0JrmY0PRkRWSpYZKx9c+rwFpkoRFosjLobGrQw3r/F7cbEQHYiSjpQCXnFPbvcEOcIRkIf4+//T7prxTwX0lAEil7k+mQOJAky+ZFXnvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T+8V4XH0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57K1oofq024699
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 07:34:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nly9DoWpxiIK3Bux+9KCd5jXpmFRSSnatyDWGlMobUY=; b=T+8V4XH0XIabcTiH
	+IVr4RJF7+wP1APLtXeMWx4sifFCv2vr/EQlpAAI0REykMRM8JFYRhIU/fUScWc5
	TqP/n7M28abxbu0hCs+Bny+nmQCVkFTiX1lq5+7I3QIeOLWjdAk675s9pJ04a5dx
	eUdS3ok9vpnHMaxob5IferiocSMwMDo0gtgQ0nwNZD83XvidrYZsak0pJGQgBznO
	KDCqAlI7VPaICCx2AMfJMvTGAVHCWILxb2PlJZ/CHTbgaJ+zgKsWe4wqUG40rCF1
	OtGrAAWwoXlSNkiGo5gufFwdICs3jtSPp9crF0ez433cGdYgqWaN3PuBi3GIVwuS
	ZPDMiA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n5290u6d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 07:34:15 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-323266b700cso12282337a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 00:34:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755675254; x=1756280054;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nly9DoWpxiIK3Bux+9KCd5jXpmFRSSnatyDWGlMobUY=;
        b=rw6fkbBTQTzDAzWQJKz1WyTC2YHzxTaV93Vv9GsWHQ7cAqRQiB6z/C5idumu56IhdB
         Rmo/bD7IwS2hLPRgH7/K/65KeD/gzgefhjvXmPFrJubLO+wzeDa9cqqxMOcGNMUvQDyy
         xHxGsVbN1kEVzvr+IDRs9TE+1LiyrOSYMh8SLSetH2058DsFTMI1jAyw/xQA1U58oz9/
         zAzkvmQ7/+D+UlB2CZ0RRy3S5kW/CceepBKQFGeBA1gVL7tfNpddyx3xvl5TeiJE5ABB
         qdqkuwCrDTCWfsl28OviNxsc4BJYLLqzNgsG29A7HH07q0r1W0mPYR+hL/v34Ivo10na
         vcTA==
X-Forwarded-Encrypted: i=1; AJvYcCWB2p0gI/FDMZVz1difACddSy6kMT0BPufzuPVDnufe+G52KGDcq0XiHWETgqRlrARWYLNiJQjccZlNEcY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt65j9txN96qn+XUcWUdUXLzHIHJr1EEBk6yWcqOD/NQTsUotS
	1tM7LSVZ61RHE1ds/Rm72UDGd6sgQQPlsfjbDFBg4bdFYG15YefEmCYxikFflnHR9LkJt0K36BN
	KcW0cnMslHU2WgxHA6U17ylKMhyxu82UlJvivF7BKcR6V/lWnvG9sQUjzRQyhcusmFJ0=
X-Gm-Gg: ASbGncu7lTTfF5V8hVfadOko4Kr4mNsZ3DkLLc42TltFEki7cOE44bZq8yuyOSBH5bV
	qBId9iMAd7WcJUeU/pLp34kUik++yRy5aUxao9OW5UKipC0KY5bxTcMX3drcUYygGUmV9a/PWuu
	NhMwkn5sb8FflkJXQiWzK1Sz6Ua7LuX6pnOfylKSnr8+MjHlEtV01fy5BLyCKy2KiV3YHua8xWg
	0xr8XOa7CB9rAWdm0vgeWeRSdIRTjyGmCR1CZ/qV1k5bpwDZFoBICvSsPp/zM2UmIKMp2DjEf6x
	zOZOwXUIkTLm4jSdawph8REU4rLsmxTUCf2EKzsOR0bylywylbbo1mXsKpuENLy9rUcSfg4Xr8Q
	jSV/oFQOs0WdUo79kYiilrVgmJGMokn/NPqo=
X-Received: by 2002:a17:90b:3844:b0:31e:c630:ec93 with SMTP id 98e67ed59e1d1-324e131a899mr2888521a91.16.1755675254435;
        Wed, 20 Aug 2025 00:34:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXDivTvpj3UqHfz74ALWqU9rV4LJoYCvA5ve9X5L/gyN4sJRnjaY/HUd8dxtuv2EansQoL7A==
X-Received: by 2002:a17:90b:3844:b0:31e:c630:ec93 with SMTP id 98e67ed59e1d1-324e131a899mr2888485a91.16.1755675253861;
        Wed, 20 Aug 2025 00:34:13 -0700 (PDT)
Received: from [10.249.23.102] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d0d14efsm4661557b3a.2.2025.08.20.00.34.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Aug 2025 00:34:13 -0700 (PDT)
Message-ID: <453a4f7b-78dd-4831-904a-27d882400c6e@oss.qualcomm.com>
Date: Wed, 20 Aug 2025 15:34:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] pinctrl: sx150x: Make the driver tristate
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dmitry.baryshkov@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        xiangxu.yin@oss.qualcomm.com, kernel@oss.qualcomm.com
References: <20250818-modularize-sx150x-gpio-expander-v1-0-c2a027200fed@oss.qualcomm.com>
 <20250818-modularize-sx150x-gpio-expander-v1-1-c2a027200fed@oss.qualcomm.com>
 <CACRpkdaeAqD=mpG4y16CPKwJ=pjATY9TxeRnXR9abziCOQb-0Q@mail.gmail.com>
 <aae972ca-5b8f-4329-ab32-12da1522e01b@oss.qualcomm.com>
 <ab60bd1f-0000-47a8-94fd-899b4e3eefd7@kernel.org>
Content-Language: en-US
From: Fange Zhang <fange.zhang@oss.qualcomm.com>
In-Reply-To: <ab60bd1f-0000-47a8-94fd-899b4e3eefd7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ZJKOWX7b c=1 sm=1 tr=0 ts=68a57a77 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=ss4ELvlYdx4pI-vPaQ0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: GdPPvUrwyCaTaN7jIg7d17Mc9gpSv2W-
X-Proofpoint-GUID: GdPPvUrwyCaTaN7jIg7d17Mc9gpSv2W-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX/PJ7MUP3+Q4Y
 FyH5s0GKtZLt+N6rJ8mskeqIMhMseuOL4jEgHX6HRozQankqh0xlIc1AtLdX1Zic6Tkaduz5UjP
 GCXy6PmCZM/019HYK82aQn8liepJKSElQ+pzCvuYDFvn2QQsC9+W5OXDkIa8nqhT/CyP2KXfpbn
 QRon2heDi1j/ptMnCkKbD3VldSrKeLUAWECR+q7f175CIsQ9D3JFfDpxCxXtWEixn+lCnAcnxP7
 ICUYw2U+PlKhDVgDietRDb9/zIyzg1rjk5ErO4exIY2NvPqWOd9MqvZuyMcJGQwgyl8eLZO73Q0
 0gba01OQ2M4PqAdsEGh/1LQwRV6VzCkg9fCkugFNHKaP0/6+BmdiiLrwDDTTaAkiYPbgA2uQZdZ
 ltl7MZvkaBRNT4FIgE2IMMQkWUV6Eg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_03,2025-08-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013



On 8/20/2025 2:18 PM, Krzysztof Kozlowski wrote:
> On 20/08/2025 04:55, Fange Zhang wrote:
>>
>>
>> On 8/19/2025 8:55 PM, Linus Walleij wrote:
>>> On Mon, Aug 18, 2025 at 6:41 AM Fange Zhang
>>> <fange.zhang@oss.qualcomm.com> wrote:
>>>
>>>> Set PINCTRL_SX150X config option as a tristate and add
>>>> MODULE_DEVICE_TABLE()/MODULE_LICENSE() to export appropriate information.
>>>>
>>>> Signed-off-by: Fange Zhang <fange.zhang@oss.qualcomm.com>
>>>
>>> Fair enough!
>>>
>>> This patch 1/2 applied to the pinctrl tree.
>>
>> Thanks
>>
>>>
>>> Please funnel patch 2/2 through the SoC tree.
>>
>> Hi Bjorn, Konrad,
>>
>> Would it be acceptable to include this defconfig change, or is there a
>> preferred process I should follow to get it reviewed and accepted?
> 
> You need to send it to them... Cc-ing people on random email does not
> solve the problem. You need to send the patch to proper maintainers.

Got it, will update in next patch

> 
> Best regards,
> Krzysztof


