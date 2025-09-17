Return-Path: <linux-kernel+bounces-821386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF4CB811EF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 19:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B4777A526F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 17:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB92C2FCBF3;
	Wed, 17 Sep 2025 17:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TUEtssX0"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21EB2FC871
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 17:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758128796; cv=none; b=r8NOeL2rcKBq4RbPpvivDsCPrggcG2l5UVi/E/RmrQeLHirMusMiZhXE0H6z25wvtQ+QzJeryjdi37QKTI9yFe+AE43+3japyEdBqvTMY/xtBzPQEj5z4mvBuJEqwYf1kTMii/J/rBAuwu8BOoREmrOYt78jo+QXE5R4WxYh0Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758128796; c=relaxed/simple;
	bh=76CbFOoG7fO8/knkAO5zHOpDO4lOmZ2qmfgZf2rMkng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RBNsRBLPmyfxN8+YrMOc9Thj2TvMIfJv6SLePaUEgxOACZxS0z5tCrR+QVupH2n91pvCDg+I6Ih4gsvDPM1/LFTAkljg2LGRa7bjhxJXGR9aU/LCY0F9GEK8OxpqDUZ6m6ujg/EnMzC7EoqJbkU4Cu0ulhmmocQ0d/RIWhuHxdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TUEtssX0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HGHBrn014430
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 17:06:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CldjWF1Kec39RRy7IefPImhF3OKmtV3emAzZ2/VbBsc=; b=TUEtssX0LEp4+Yxj
	JKISkX+yfP9FaUzYI7MnA84nLIbPhWzkDwswuy06e9tZtu1ufEXn9TY5FHq5KtEQ
	QOk2Sj2p4JsG31ZA20mZYG5t9YHKpHhhAVoVeBjdF/eLpsxoUHYoORtpDBHE+DJ0
	8chO+dMThHKCxYrIZ61qXJLb84+83OE+DDc6ZvHWTGHUKtyQ2molI6e45D4FmTWh
	KIlhcFt37AQzo8ZA/XrIFFK/5ZM2U02MzhYZUWb9D1ATL8BYQ0P/S3RVy/sWfa+W
	MaBeAURM1jxhrpN+VzmWeh1tOj9sGaKmamNMjLTXLuk+1nyG7hkXQdrphs2VQmIx
	7Evx6g==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxu3972-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 17:06:33 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-24457ef983fso558325ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 10:06:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758128792; x=1758733592;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CldjWF1Kec39RRy7IefPImhF3OKmtV3emAzZ2/VbBsc=;
        b=bsdYu7Omwl9Kfq56cgK2rvzDwQu+xjYyEXnFJurXvhwGTsAMpVD43yCXEFUQ927B2W
         Nkbsu3ypFwDhlWN4WCvEjCB3NmGVRFUxlTbqXVRFwbmDJ64Jl9kLaAtGoXijDrbjxLWy
         pcnS5sVfcKvAz2raLY8Hs8+T+lExOC496rQfxmO/sPyOovGguE4+DRp8Z8jtRuSeBj2a
         3JPEw4lZ6cO+qiZ/meRKPrWuQksdoxkaXC7VOGJPhuxicZRsUeso+noIUQ9w3jXapXkQ
         Gk4GVupOelBn1t89fFt9xIlySYAANBz3AWzu7WdtFNVSsxRC8jjWqjANw3xXQCibbpZ1
         jUfg==
X-Forwarded-Encrypted: i=1; AJvYcCUnltJY+QeEA0jM23EUOu1mI6eYyiComQ/Q/Hja4m/vtvy4RM+Y0p/GAyZ04KZwIlVrh2FqpkwhHzjvJnY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKumSx8lT/jSKkpk58sD8Udmb9sQVjjZXsiN+uPFngh9IP5lHh
	QHY+G71TyShvTvkSPqAdAaWdY3vad9prWkZLoVvorPDlc6JKkqyRi7tTJq1zmEQdB7QneB89u7/
	+sb3vv/3wA7aRLq2hobOPavD6P1r5s9unH88MvSUMa29ehuV9j/2L45Q05toJfWEPfLc=
X-Gm-Gg: ASbGnctHigC7nwh1UEBakQK+XRzL2UwjhCx7o2VpeDc85bQeiRcPVHub7sxm9LftyAu
	90jCTxf0SSLmoC+O99vwhYXQRE0bpIZgqJzoUjT37L5Q6I4vG5/T+icMJxqod67c8zyQq59sUYY
	zj/wWEN1alF+4cNIUljOlZhTdWnql8smVS9wdpj09m5Qj3HyLy/LIhMulr22foMhjFsBfXHaKH0
	LfW4ggJUbfkYz2HvWOVGdZmVdhOcgLWEuXaUKiNKUtiGHkNe3hNuTtJV1NihxDdqmqPCZc3VGAm
	R1+GqBGcrkzjaZ93uwGjffLytoEnHFKvA7H17cl/FH+5ylZijYNc7v/Mz2JvhcU=
X-Received: by 2002:a17:903:3d0d:b0:266:2e6b:f5a7 with SMTP id d9443c01a7336-26813d04f4bmr37704485ad.58.1758128792203;
        Wed, 17 Sep 2025 10:06:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiYS06pnxVlJyVc8usIQK/iQa6m8Xw/xXXNj5CZpC/OXWCWIJ7/dsM3zh0SSUhq8YicFepBA==
X-Received: by 2002:a17:903:3d0d:b0:266:2e6b:f5a7 with SMTP id d9443c01a7336-26813d04f4bmr37703845ad.58.1758128791682;
        Wed, 17 Sep 2025 10:06:31 -0700 (PDT)
Received: from [10.216.34.136] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980053dbdsm1270735ad.9.2025.09.17.10.06.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 10:06:31 -0700 (PDT)
Message-ID: <472265f5-8463-e0ed-6386-f52478d4f2fd@oss.qualcomm.com>
Date: Wed, 17 Sep 2025 22:36:22 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v14 01/10] power: reset: reboot-mode: Synchronize list
 traversal
Content-Language: en-US
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Vinod Koul <vkoul@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Andre Draszik
 <andre.draszik@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        Elliot Berman <quic_eberman@quicinc.com>,
        Srinivas Kandagatla <srini@kernel.org>
References: <20250815-arm-psci-system_reset2-vendor-reboots-v14-0-37d29f59ac9a@oss.qualcomm.com>
 <20250815-arm-psci-system_reset2-vendor-reboots-v14-1-37d29f59ac9a@oss.qualcomm.com>
 <7eqa3rs3nvy7htvrkwyh5m7ok34n6c3h2dxn7xm2abdjzav4hp@i275ed4owgru>
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <7eqa3rs3nvy7htvrkwyh5m7ok34n6c3h2dxn7xm2abdjzav4hp@i275ed4owgru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX6mSOx/YZQzQy
 bA/zgTd4cudF5hWPgZNTXdHqN92+tDqBtDymQ5ZphvaFOdtAMTe+8ij5emRSH1wbTZBOYIOrhvg
 JkQxso6EE6M9NjUfX4ipztxc1gAwumFg1V+ptkf6YOHHz3TPKOXrFULMaoLnisnIS+Z5nEAJOCG
 S5Fo0Wxbol5lTG7tOX/aOG7yBefBO1rrEchQGmZvvhrGyMpi+XFuKW6ilbwaLvdmhZgt0MHUU/1
 WwafY/sSHj7HsX0p1M7TZx5N/iBWvObwHpDQvpxS3Y1Be7n+gwf4XE+GMRccYC/1kEEKSDAbw5/
 h3cYE4l4VOenNbd4Lg6TeESWYhTmaUY/OawVOZvAw/TVei0EPgBQEeP+tDmPgpvcVG13sZfykH4
 d5nsynRs
X-Proofpoint-ORIG-GUID: Bl6p-wcLBaGHd0SvrLmVPPW1TrX3pN0h
X-Authority-Analysis: v=2.4 cv=R+UDGcRX c=1 sm=1 tr=0 ts=68caea99 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=hMdzhsAlQAsAiGmCIg0A:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: Bl6p-wcLBaGHd0SvrLmVPPW1TrX3pN0h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202



On 9/17/2025 12:14 AM, Sebastian Reichel wrote:
> Hi,
> 
> On Fri, Aug 15, 2025 at 08:05:06PM +0530, Shivendra Pratap wrote:
>> List traversals must be synchronized to prevent race conditions
>> and data corruption. The reboot-mode list is not protected by a
>> lock currently, which can lead to concurrent access and race.
>>
>> Introduce a mutex lock to guard all operations on the reboot-mode
>> list and ensure thread-safe access. The change prevents unsafe
>> concurrent access on reboot-mode list.
>>
>> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
>> ---
> 
> This should use scoped_guard() and a Fixes: tag. Otherwise LGTM.

ACK. Will update this patch based on scoped_guard() and add a Fixes tag.

thanks,
Shivendra

