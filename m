Return-Path: <linux-kernel+bounces-771507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 063E2B28834
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 00:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6766D5E2F68
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 22:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE89828399;
	Fri, 15 Aug 2025 22:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kW83flYO"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B061323956A
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 22:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755295915; cv=none; b=RwcFg3vpQe3tLkw/z+xF/arO0ghqVv00l7DRDzjNkfiTS1+nUT/wM+7WacEK7ltQ22h3a7oemszZNowAzVOo1YoS6QzwC+LVHfy9+E+zo6Du1AyqIBLPwhya+lx/W4cs6+y9juauMa590edR8jK3Os2614yhQeDWD6wX8pDpJWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755295915; c=relaxed/simple;
	bh=f+UKnnSodDZgqonVwt9+xswBGG14TU8cblfKES3nCm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bw3pgclcfmEgLHeIqbho/L+sooFps5kDDGfXsJCSj9od2jh817OlXA+mpX3rOm+3kplua7Vpda//85fSobc4tvvp45OlmbieyAbTXRAnTfbzhjXc2HFH1b9C3WjDJDTgcFYslD+jfSdbub+Hd/fqQ65c3nkVZJIByJSbkjqjLas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kW83flYO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57FEIjYV008152
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 22:11:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=/5zM8IHcV3H7gOoelJ/+z7CJ
	/41CkydC6cvDm/kl5Xg=; b=kW83flYO9wLl1Grkz7IRoSfW7jFiDVuHUaG8briE
	O79Z/pyF2XrLqjis7GA/l/wOiSas7jkcYF79tem2ZXVDi6y+D7Q+a4whV7WfvTqQ
	txVAoVEKoVgkMUBVNMbPCQ/7raC9ICkeq4nYI9Z7VO5dbv3BLvksC1ZX12y4nkZj
	3cdNswY098BE69vYOtsNgcI/7kWxoE2W3IqWBT5Xu/4gyzFL/3xs8feZ1fgfpPIa
	H1yWdFP3afcnfZtE9qQ/hSOfwAGs+eMayZw8Bd2Db8JFIwnbu6yscn2IrMfLm/py
	+heQ/omcnxSGSPJCzQn3Pb/tqEMt86aDTM4Epg/sP/P8Jw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48gr9s1003-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 22:11:53 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e870317642so566407385a.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 15:11:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755295912; x=1755900712;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/5zM8IHcV3H7gOoelJ/+z7CJ/41CkydC6cvDm/kl5Xg=;
        b=lx5sep9O55RBzO3act7sYrvr/Lr7iHKp347i1KGn0KbM+frId4YWdCP6tcb6rrH9cN
         5f90p+F1lbom6OkCuY4WObIt0TwKbMlJL62J2GRNXatswtzLfwqjTi/SbqwliUfpEvju
         J6TM1apoT+HB+IhpgQhff2MfNzgnDHw8ukfw/D6JK93Z4jGUn28Oy6qjtTZ5COq2Spsp
         bqTt2mg2ptw9OuY7i1Mq3une3WGLLTLHMOrJC/xHRZKkr7EoCX4FqRK0VfAHtaQBy3tV
         eZ4wHsG8tTlvhUyNWD/eUeiEfdqtkKmQ4cWeie6ppO9DRJP8eHBeERMH9W8oHhMMHuB6
         JXjA==
X-Forwarded-Encrypted: i=1; AJvYcCUjFLQIhKvedTNgpdMJBO2NOw+Emc2xo9X12nhYdE7T7u3kNt4ol5JdqsEVftBpTAhd5dyVfzZM7CTx9LA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkRxmBI+jYBksngbGnpyHPdDV9XiQT+o9AhP67ikfxLnjmIT4K
	MI7YVWlEl0WCjguHsE7ClxL+qXpyEhNOscABKzCWsgs5KfxPB+BZECpPzDQH1fXzkByXEFz7k/c
	7OVhFyFgu7hBuo9Hxh6vwDwdykD/tnZXOliH+eDsBEtx/+QBsgtXuctlDhMk1IrHPypc=
X-Gm-Gg: ASbGncuSw2ExyktbN94holFuTj/xvqYVP50ZziR6j9lfHAHMRYoaV5DwuEuW/USTgF4
	8RrPRLR0NlBAUiczkFWl2ApMW9AE3TAhAbAAndVI0+1Aa/NCu3DMS9Howwc3BxXjNhgINOrHF6Z
	nmnyvCfhga++/CylKx66OQGTh8/8bHjOdoE2GYDjpT/f3M4Qtao9fMxh72L9VxjhBnUxJa+yKaO
	Xc2ytpGt+jbbPKiNoUeyTnIR55bMFHmKpWvnXNixRcPNHUY44tKe5RnqJjfjRVNFaU4ll+cqVrE
	ZsOFYJ3m4+5bJ3vo5vaK4YsJUqthsu4tXauBQwHQJoYfC4rszA7JZwagOUcy5ai9q2uBIcRMGw0
	UpWgWE35K86LsyIex6iNHp6UDX7XPfHTAEgRwtxM/ndKrItqdtp1v
X-Received: by 2002:ac8:594d:0:b0:4b0:7989:13db with SMTP id d75a77b69052e-4b11e2ca210mr52381711cf.58.1755295911607;
        Fri, 15 Aug 2025 15:11:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrQWvY1JLzgvTKFhi3lkvOceh7xXj0igfHgQCFQG8XwNnsUGy125Fd59SjzF+Z00CJp0H2qw==
X-Received: by 2002:ac8:594d:0:b0:4b0:7989:13db with SMTP id d75a77b69052e-4b11e2ca210mr52381311cf.58.1755295911092;
        Fri, 15 Aug 2025 15:11:51 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef3cc6a3sm519733e87.102.2025.08.15.15.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 15:11:50 -0700 (PDT)
Date: Sat, 16 Aug 2025 01:11:48 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        johan@kernel.org, linux-arm-msm@vger.kernel.org,
        Christopher Obbard <christopher.obbard@linaro.org>,
        Rui Miguel Silva <rui.silva@linaro.org>
Subject: Re: [PATCH v7] drm/dp: clamp PWM bit count to advertised MIN and MAX
 capabilities
Message-ID: <b3h3anmvna2p37gkio7xh7dgl4h7cz7weimu33mwhfk5rtytb2@wvhoskaiwhm4>
References: <20250814-topic-x1e80100-t14s-oled-dp-brightness-v7-1-b3d7b4dfe8c5@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814-topic-x1e80100-t14s-oled-dp-brightness-v7-1-b3d7b4dfe8c5@linaro.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDA5NCBTYWx0ZWRfXyXTxfW1YtGt7
 NUU824L44N3ShluI8svWa3lft6PqqYF3dQSdyaKFruqFWUIt8OPc5ZeIJK3vZ2UfTaNDaRGbgnY
 X5qu7DR4OTjk0B6LeVgcwwxV1EdHDerjmrC96kEc9TIlf/ZqeXpOhENRZC6IKry4xLPEUuqkkaT
 s72/fYKGVPCnCOPvSDQUdB1j9xfbuL2yKBkFzx6kjnqgVvd2g4lxCdHgMC97lT5rgWr0D/4SEH+
 dsW+mWZRQ5/Znsh7LM0WFVcFJMMmxZzl3iyEqOgDbsN3J9MAnD/eOQGGgD9BdYNUuvl9NMsKxj0
 kRyNd10Cm53ty0JEXzu0nGgZCE/eCxX95gCkACoqYcH4OwGN8yfWXS0xz8R00EnLdjWLfILP6eG
 Wj7UN3R5
X-Authority-Analysis: v=2.4 cv=NIrV+16g c=1 sm=1 tr=0 ts=689fb0a9 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=YrjviDGP2Rj_hCM7jl4A:9 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: kh91xTXwBHNhE7K1g6OrGl93lJDLrmVJ
X-Proofpoint-GUID: kh91xTXwBHNhE7K1g6OrGl93lJDLrmVJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_08,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0 suspectscore=0
 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508130094

On Thu, Aug 14, 2025 at 04:16:09PM +0200, Neil Armstrong wrote:
> From: Christopher Obbard <christopher.obbard@linaro.org>
> 
> According to the eDP specification (VESA Embedded DisplayPort Standard
> v1.4b, Section 3.3.10.2), if the value of DP_EDP_PWMGEN_BIT_COUNT is
> less than DP_EDP_PWMGEN_BIT_COUNT_CAP_MIN, the sink is required to use
> the MIN value as the effective PWM bit count.
> 
> This commit updates the logic to clamp the reported
> DP_EDP_PWMGEN_BIT_COUNT to the range defined by _CAP_MIN and _CAP_MAX.
> 
> As part of this change, the behavior is modified such that reading both
> _CAP_MIN and _CAP_MAX registers is now required to succeed, otherwise
> bl->max value could end up being not set although
> drm_edp_backlight_probe_max() returned success.
> 
> This ensures correct handling of eDP panels that report a zero PWM
> bit count but still provide valid non-zero MIN and MAX capability
> values. Without this clamping, brightness values may be interpreted
> incorrectly, leading to a dim or non-functional backlight.
> 
> For example, the Samsung ATNA40YK20 OLED panel used in the Lenovo
> ThinkPad T14s Gen6 (Snapdragon) reports a PWM bit count of 0, but
> supports AUX backlight control and declares a valid 11-bit range.
> Clamping ensures brightness scaling works as intended on such panels.
> 
> Co-developed-by: Rui Miguel Silva <rui.silva@linaro.org>
> Signed-off-by: Rui Miguel Silva <rui.silva@linaro.org>
> Signed-off-by: Christopher Obbard <christopher.obbard@linaro.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
> Changes in v7:
> - Take in account invalid bit_count
> - Write bit_count back if clamped within BIT_COUNT_CAP_MIN & BIT_COUNT_CAP_MAX 
> - Link to v6: https://lore.kernel.org/all/20250330-wip-obbardc-qcom-t14s-oled-panel-brightness-v6-1-84ad1cd1078a@linaro.org 
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

