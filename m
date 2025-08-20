Return-Path: <linux-kernel+bounces-776852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D227B2D21A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 04:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D43FE1C220FD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 02:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4F82517B9;
	Wed, 20 Aug 2025 02:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nvNMWxUn"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51054235BE2
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 02:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755658548; cv=none; b=Uh6CQQk4zfpCZWdJQu3kmBiEDwyV8a3E/U11H3nLG/rpMeuxSzlDIOOjQjowksvPIVczo7FwTKHC00uGFo2KzwFZ4rgDvIcTyAQmxqOEcG63UW0RbSoWop5+Ny+9WtEg0kV9Ein1by/qkS1w2fXUo5Yc5iBdhr+o3dH5hsCGtpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755658548; c=relaxed/simple;
	bh=xU/2aA2D1MSytR7qACtCUwX9lfnjaVK8VsLwR69D1T8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XgOFo9e25b1se+U0AaBwMKoA9DakXqW3K+w2jtSbD6f7eMwpqlSumicdVXbv5NAZ4+UTtLrIvYnYgzk7GRLDmQRrKSOsFQ2NL5geM+Pt+bUNpdW5j9EE3eaefnW4VnjHHGME9BjYSi6AbyieOR5UHAYn+zikEiL56oSS6L8frP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nvNMWxUn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57K1ocGC024155
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 02:55:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cDjR+QnaSGppNI8qcVMUT2dKaPtQ/kTLxQK50E6D+fw=; b=nvNMWxUnlvBXLmiu
	5T41vztnuyL6NBCpJ5MYhcDnR2gorbOWJ3jHboMctCHqggEChYhBLVjjv3vSBkRl
	wbnj7CueIRrjm4XVz682M2k3KFJEtHxx9CKBk9Pz9bRHQFCTks3d/5ewXH0f4tah
	ePyZx1/FYmwuzum5tnGeoy0ScGSoewAY+l1KKcQu5M0Tq6IcKW4P3MvKFRCpMmlR
	OODD6IpnOSdjXiWv7v9M1mKV10CCh2MzWxL0LGyUD/vrT7OcfWignkUET24dFDZ7
	hiqS8hoNK4K+vSxHiMQWkcjknH8F8oJJL1EFfesfaRuAzAc9RnC4tkzZa9/aMnT0
	r6EqBg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52904su-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 02:55:46 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-24458067fdeso73694385ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 19:55:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755658545; x=1756263345;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cDjR+QnaSGppNI8qcVMUT2dKaPtQ/kTLxQK50E6D+fw=;
        b=pf04ELKj7uyfpYWQjITGmU9SKZlECcC6ohnkbFFRhTEyVntlxuwj+8iQaOnXIStpMA
         xd7fAafZHJGRzBwoCOHpUj+V9OUQoeKZUw/xN0yLx3F/pstCyte/C/cZH+0dsroYqhZw
         l/XLGUlNzNbid3t2z5IBk3rRrp3BhdVCIMejmiXsr6Zg6xKCvH9hsEqO/AfsDg5epdKp
         UK+pv1FHWNh21hFIS9jZBbUm4HAgwdj7fKTT3H7ka+hXQozckkAFrWUdtEDdfjlvSaqH
         HtSwpGrkxGh8I0fvXpD+lMYQdxyDzR29f1AGQRXAEjiubLuRapYSpDVDjJDmDu0CLEPK
         yTig==
X-Forwarded-Encrypted: i=1; AJvYcCWouR3RE+2QbHM5HQz/rSh+MVpZNK2bv8p0My+kQOLityUcD1tVo07jnk9iiTHx1e8mU3ZI/1rw9PNHg8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqhAmn8osI+Q372GvgNczthI8AKj4ToHvuECWtN6XCo+OwVfS2
	VA9pGCv+s+mtOJz/pnerJmnzUhjClYdzE28IT+t43d67lxnd74d2hhob8FTg5mVpn/H9M3paMeP
	JQvSzqilRObZJh+aIF8WOE1WUo3EiNQmTQkzSXtpQk4VyFnuVXaqY8aP7mXLMe3BSN1LFBt2aDN
	M=
X-Gm-Gg: ASbGncthINDiVeDjpjsINc/I0i3MPpd7R3gW6TTIkAgAHFn8fe4BhHpjdA6ZB06mmT2
	Dqw4McAZ4WnAnVJLBf9M/CDGJjyQgTvZ1RDhOiddCAp3NeIIdT/2UiNdNW4TKqiD44NdJJsS8UG
	s2qnQQ8i9+wm3Mt2zPyNJKn88iKssAksEU/vgpwtRK8ybIvHTgALUcadDx95VIVwOsOWsSP6jON
	aJGdTb1JE3wCleEQy6f+/m6azZD8A+r994+1imEXT6egFqoXyIJs1gGrLclMkrwGSDtIJZ1BGWE
	XJNPq/HHNyJL42qsSBA1gR9to27IKLopuuTSVjHVYDFpcBv9qh/lChxXfKnWFfAASduUqZ2ERlj
	SULhQJQojlyIucr1QMhBKKoI8rBXxrzi9w3M=
X-Received: by 2002:a17:902:e743:b0:242:9bc4:f1ca with SMTP id d9443c01a7336-245ef2a827emr12434385ad.57.1755658545037;
        Tue, 19 Aug 2025 19:55:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYWiwV5y8RHJF84lWSVJjKu3Owq0+l/8s5e+spsF//U1keVzXap3hJwWNCadNua0rlA41efg==
X-Received: by 2002:a17:902:e743:b0:242:9bc4:f1ca with SMTP id d9443c01a7336-245ef2a827emr12434095ad.57.1755658544591;
        Tue, 19 Aug 2025 19:55:44 -0700 (PDT)
Received: from [10.249.23.102] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed4f7b77sm11170125ad.117.2025.08.19.19.55.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 19:55:44 -0700 (PDT)
Message-ID: <aae972ca-5b8f-4329-ab32-12da1522e01b@oss.qualcomm.com>
Date: Wed, 20 Aug 2025 10:55:38 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] pinctrl: sx150x: Make the driver tristate
To: Linus Walleij <linus.walleij@linaro.org>,
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
Content-Language: en-US
From: Fange Zhang <fange.zhang@oss.qualcomm.com>
In-Reply-To: <CACRpkdaeAqD=mpG4y16CPKwJ=pjATY9TxeRnXR9abziCOQb-0Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ZJKOWX7b c=1 sm=1 tr=0 ts=68a53932 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=UVvxqbSGffHEz0aJwqgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: QdE6ulKC-X7qTtScF88__f6GFu4S1cuZ
X-Proofpoint-GUID: QdE6ulKC-X7qTtScF88__f6GFu4S1cuZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX+WnzvCV6UmGy
 U6jDkzdKNEH7c65i2PanFtn6xpDt8uqqdEN5huiyvffpWkhgWZ8EEm7fterexIjZzWGViCcPI14
 VcQHsiYoR7GNp6XsB7cWutXr85oqLkSJD7wzGWq0TpOFyB4j4pVsgWmZbL6o+PLC7p/0QH7zahL
 ciAEr6CFnB1r0T9kYOVxeOfNMZlBjBZFXLUzfO0r+VwTpk8JfnZiNvGGx6c0ljG+FyEmMW373KZ
 uZKU+bQ10Tbcz+qg4TSjyLbxz13TnXj7ZSfhooAslqyO+s1P4wlWL90DRAyTT8QwaWTGp+rQEjw
 OnCOBJZrZLI2UorVWLAHPvtF6g1maXWGqVsQI6rRAu/dHnB+eJBVIvMax4H76Opbe7m+2hPmpSd
 P9ZgfHwa1Cg45V1Lien4Sh5iE9Ijwg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013



On 8/19/2025 8:55 PM, Linus Walleij wrote:
> On Mon, Aug 18, 2025 at 6:41 AM Fange Zhang
> <fange.zhang@oss.qualcomm.com> wrote:
> 
>> Set PINCTRL_SX150X config option as a tristate and add
>> MODULE_DEVICE_TABLE()/MODULE_LICENSE() to export appropriate information.
>>
>> Signed-off-by: Fange Zhang <fange.zhang@oss.qualcomm.com>
> 
> Fair enough!
> 
> This patch 1/2 applied to the pinctrl tree.

Thanks

> 
> Please funnel patch 2/2 through the SoC tree.

Hi Bjorn, Konrad,

Would it be acceptable to include this defconfig change, or is there a 
preferred process I should follow to get it reviewed and accepted?

Thanks,
Fange Zhang

> 
>> subsys_initcall(sx150x_init
> 
> I seriously wonder about this. It feels like this driver should
> be a pure module_init() device. But other users may disagree.
> 
> Yours,
> Linus Walleij


