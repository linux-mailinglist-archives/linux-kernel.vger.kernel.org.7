Return-Path: <linux-kernel+bounces-746539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F205B127E4
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 02:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38DE31C25406
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 00:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24444A11;
	Sat, 26 Jul 2025 00:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WQIrZPLe"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA79273FE
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 00:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753488886; cv=none; b=LS4hw9GGj+wLTRfOaXLTX5WjwaFqI2reRROdyxDWqjemSZW9OygC+DR/hBIJs9DtvAvW5nKyJ1xGF6YUMIZ/qSmH9+cZ+UPXcg3g6O6rkXbw9WZ7hQLMfzkchEsfPwYY3IUOxthItvHa7S75WyyX1SiQTEroYPKcZndEraYW/Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753488886; c=relaxed/simple;
	bh=fY7r3FRb8cEp+aAm9WecvJIrzZwcJAQUvD8crxOL13U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rlYeGjfocPfC3RcWubeg2lX+pJEo5V0Dwzcpl7uarsMGXo1CERC+TXwU6fBtmFGza/qsKhoMsFGNPqKdepVh9opSGaRsjk6O5i+HGtj5quhtQBftFtsg4I0b/0J+QvpNxPzZSGkpt806kFCT+KA430EwD/Q8XaIEO3+WakH0BNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WQIrZPLe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56Q0AIWF011972
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 00:14:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=CTGcg8JogZ8+3e2c1J28j27/
	pKoaqY9rvoZ/CTXAvIA=; b=WQIrZPLebG37A2p/sAaV1c+nhCPLOEZ7dKd/z8Wc
	1EWqTW2Dz1/JkNdJ/nCiPKnFh+PmSQpBnc1k8kRzygJXo7V8ICN5XTBWNsfXWlNM
	+FVL5Exg4RjvNzbJGVJjC8pWr4B0KXC0bIJs8Xms3O1OBi3j/oh3PiKlnCaMwbaH
	YTWlWvjdgaUtEWO8HHhmyMwsKcVPr+Ey8b4iyE7Z9/uffJa+F9TdUyhLRAfFgqHC
	nZxLN8TKMrteknF+bwg2wtMg7kpADmN+c6doR8bKUja2yay1ysDov89fq2vJeE5X
	mKhZ/Lz4qMRy99m+IS26LwS4s37nq+L04LIc3aOco0Gw7Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484m7wg07t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 00:14:43 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e338e627f1so882494885a.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 17:14:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753488882; x=1754093682;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CTGcg8JogZ8+3e2c1J28j27/pKoaqY9rvoZ/CTXAvIA=;
        b=beybgybk3H1XO/zyxhFTbw49KJBKB/oMLyvyFEzD/J35NqjUxE1Ye8qLuxZPSo2KAE
         n6aqzbyxO1eB3mzs0Wmn4HWQvhI4PnHB+NGLWnfIuXYyRjIzX43s/1pdIknZUeOs7K52
         R15JYC3D2mHv59N+0IuGUWfGTO2FUkZ0R2H1uh0ZJtb8h9ZhT3xKw9vMxDdp+cvvGHj2
         zqhCN1k+i0V2+/jUr5ImRuXYEWepTvX3a48L5BntH7CC2h+EeXZ+PqzUYSDsLAYmv29U
         1aF55yH3zpKhebBwAtGSwf6JXtNjrqunHU/GfLNDEXk4fqP5HgX3u2p0YWnI7p+sPPH8
         n/Pw==
X-Forwarded-Encrypted: i=1; AJvYcCVmhH0Ic84lkQ1zJ0W+sOE3LhzEirKmHGjwBXfPQzsGCNRbn+ugDjzwIkiWprTtIjN839lVU2ecgwoUm1U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2KiTYamiouRpLB7Z04g2vSkzQnYNX+8LqWV1qLkqDS2AJPXRr
	w92jgLKzaTJS+qKHZJ5/M/20IQlnJunuNHbkcpj1f4hDRe948wREOXX9fqYN1ntP2YuRSv7xKjQ
	UDA7pXY9KzgMCZI9QoSRa0CkIdFM2eETeWd12o+t1mvI11YGaKhlmuRMJ4Hdmy8gBzuc=
X-Gm-Gg: ASbGncu5K6gXrUSZC2LjeCO06pKBGwQ0pPYT8FhizlDO0rFVGY4hl0itFmokPJWSbZy
	6ctskr+9zqRuLPKEH97UDCeyNqKF5AbZfjasLcOyxkAod9IdkuiFMiJaYu3t3pG+xUg8wqTuthE
	ytfnOHpmqY1CnyxI3z7VaP37tn83pyUYqPNOmxTmIdszNSsvWRsfDDFx2yxclqvvn9yofrrOxa8
	q6caYNMaph0P0Ati4z1LLbaMvffUrRWbHBka6YN5RPPQGf/57W3DwvSt4CLV5wC9OJdq2q2uS50
	r//ihjuu6DavIiWMWlDuOjMGSkV20tsdcLusffp/7EceDmr+EdwD6IFjNCUmLkBVd/l+Q4dqkAy
	YyPa4Lcd7yRpNk88/TmP2/wFUC8mnEoHOCbd99xFec/YgGpOguphl
X-Received: by 2002:a05:6214:1c41:b0:6fa:bd17:313 with SMTP id 6a1803df08f44-707205a701fmr50123126d6.30.1753488882377;
        Fri, 25 Jul 2025 17:14:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdQpwGUCkqR1lOUKTKaqZouyRm9icTapQyzE9JidQYLs6U2H/kr9H1AePaGwZvW49Mwo6Dww==
X-Received: by 2002:a05:6214:1c41:b0:6fa:bd17:313 with SMTP id 6a1803df08f44-707205a701fmr50122636d6.30.1753488881831;
        Fri, 25 Jul 2025 17:14:41 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b6337568csm188598e87.129.2025.07.25.17.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 17:14:39 -0700 (PDT)
Date: Sat, 26 Jul 2025 03:14:36 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Damon Ding <damon.ding@rock-chips.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        simona@ffwll.ch, jingoohan1@gmail.com, inki.dae@samsung.com,
        sw0312.kim@samsung.com, kyungmin.park@samsung.com, krzk@kernel.org,
        alim.akhtar@samsung.com, hjc@rock-chips.com, heiko@sntech.de,
        andy.yan@rock-chips.com, l.stach@pengutronix.de, dianders@chromium.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v3 06/14] drm/bridge: exynos_dp: Remove unused
 &exynos_dp_device.connector
Message-ID: <ovlz5hotvqyn4gnrmidfq3aafq6tkjjpnpgt43yterf2cd73ys@dkarreyoctbh>
References: <20250724080304.3572457-1-damon.ding@rock-chips.com>
 <20250724080304.3572457-7-damon.ding@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724080304.3572457-7-damon.ding@rock-chips.com>
X-Proofpoint-ORIG-GUID: Z-9kzd7pcFwiLYvPTCJ9EhDJOToB-tIh
X-Proofpoint-GUID: Z-9kzd7pcFwiLYvPTCJ9EhDJOToB-tIh
X-Authority-Analysis: v=2.4 cv=F4tXdrhN c=1 sm=1 tr=0 ts=68841df3 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=s8YR1HE3AAAA:8 a=EUspDBNiAAAA:8 a=xX9fryL7oNgbU_NKkWoA:9
 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDIwOCBTYWx0ZWRfX9kUKzWvmhOj5
 7drc7VqHdfg1El8JqgOXgqUkmKIO38+MN83xZ0EY+ZRYvnpnscw0ggTiE9tiT50K8OKY82QJrdS
 v2VffJr+UDc5MpFPZg7PzMI89CnuouJ1emU4wiHuaHgisfhAVUdUpb1VrOkCQIJcI097FdjLmqQ
 0DwgZD7jp/DSmoS5QIxoSud172mLe2WbysUrfOGApOGF6p0So9KAdnw6t2VDNqpuPpCfzWU8sz1
 ea8M3Btd2didrRpYCmvMoJQGdkj9GihNNU2/UMDbFiESwjRhvGkgvGKyPQuwYdbv5LZdHGeVXVn
 7nYqkh39xHprMqQDmAehNClp/dYVOII4xM6Dm/7MFABHAlwRQMZPJUaX1KCSE4ZxX/zTBx3cLdI
 920kIPqrG9JKLiqVcMQLtokM+6s1W2+1+YgtGFxWNaaYjvpaD6nRIxwc7ellQwUkntxNLTJ3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_07,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxlogscore=728 suspectscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507250208

On Thu, Jul 24, 2025 at 04:02:56PM +0800, Damon Ding wrote:
> The &exynos_dp_device.connector is assigned in exynos_dp_bridge_attach()
> but never used. It should make sense to remove it.
> 
> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
> ---
>  drivers/gpu/drm/exynos/exynos_dp.c | 3 ---
>  1 file changed, 3 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

