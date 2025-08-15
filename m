Return-Path: <linux-kernel+bounces-771087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A72E2B282BB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 17:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5A397B3972
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 15:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CBD28CF7C;
	Fri, 15 Aug 2025 15:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VDAEzWqT"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C1328C85A
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 15:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755270725; cv=none; b=XnmfmDXRlJUwmidTSLgbiMZ36lgZCfss9W2VXCf8Y16SDtrPKUCfXk1QPR3ROM6qFRuTO4uVVctLbPV1uxn+sd29DivTBi37fDKdrXL0woVM+iR95Co4N4TC39BXykT9+UvLoyqeevVa/PLCCRpefseGEuQyb2qolTaBBNCIPJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755270725; c=relaxed/simple;
	bh=Um/FSnHbnpleB1Zbq+m6k+aINNeqkSikivP+jmfo3kY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HoGHWNk7vxOE8hstJAanYat4UULWaVrRwAhH1tiC9A3j0VfjYKZK4M8JRwSzQSpyzKruoxOkR7vP719c9+J0ZqOB73c3CBWsZ5SCrK1X1U5s8xamoGdDhzgcRfvzc2W6R7KUO9D1KNKgFht5hTPMjib90dXuTqw8L1Iw/MOW+TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VDAEzWqT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57FEJ0d8018435
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 15:12:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=pQvr31n7tCN4up3plvWxhLIp
	NLbMAvSecLvMsmNHzoU=; b=VDAEzWqTc4aFHjJtTA1K5Zt2si0qDygIFr/4dxTP
	IWwjvYBCfdCNH37BiXHc+LD/K1mNnYDBYAtOSN7m7ma2vk870zXvcZ82ISSXlFbA
	fEKtuGYvVeyN8C+FfMvAMnOfJEG20elPyeR9a/186AQygXkSCffm444FxDXNXSRB
	bKBUIWasIpVNFWwpqIce/hR7+TUm1Y50Lcxu0UpXi1dX1E3aQmVpmrt1ZetxernR
	NDGqOTre6eoxeO/TpMtq5KgNh0jV5HfuOo1d4ILrZVCQpcnSYv551OoEOBmguWBh
	pAQUwd+/FpOFL3zmSIi5kUE7FfmZEgmqpRaz1KE1FnaGTw==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48gr9s01rn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 15:12:02 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-50f8af4c592so697739137.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 08:12:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755270721; x=1755875521;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQvr31n7tCN4up3plvWxhLIpNLbMAvSecLvMsmNHzoU=;
        b=LGN1qpiZeu4w1hZf3Abj3YqgPKmaimySH3D1HjkoWblRpt4MDI1ktY1PuP6M+tjnrP
         HHAIuGBfz9tTOVmS6lLR560ODj+4dFoqT6RiwvMNfzNfvh2GFOfYLY1jMO1KtuctTOdE
         /iucjXE4WzHKdn2jS7gRSW8Z/meQO2Z+EBICer404ycuCfJMHyDRo77tksYpp8Z4SLtT
         NGze5tbGpKgYYp6SUwPw1keAkYHm7Oukeyqp5Z47QMN7gMSV/akjzZdPGR1hQta8W3k5
         QFpUQ1/JjcLuxl5Wz0XDE8JEmpfrneZgy7hhIvP/TSxisqXPLAHg83twssR6tNYwPzqH
         v2aA==
X-Forwarded-Encrypted: i=1; AJvYcCXHO0c8Rp+9CIrs98xOAf+T/GXqULHNzgxl1QaUkpw3ZH2QAxC7zjmihFHLeXkAL6bglRnioFFr0iyM8Ls=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEFk2Yywx31rHOebXWXbkO92+hwIhRvD9rRS+JA1Fgaxr+jKXC
	tXwsA+015vhrZIjqWCVknq/XxdmGMO3mjk2Q0/4JNJEZk7SiQIwu+R2RY97vRDJZqypZATIh7wk
	vaEeqDwDB1a3H4c14QeYwj/YKK39U1CLcURSteuo8vFuEA/xbRMP72yJVFv8UKR1rZ8s=
X-Gm-Gg: ASbGncuv/VpaAZGvHihbAxgHEm6K9WRAzRRPcGeSimvCveFra5XuB8gM6V/bd4jmnrx
	V0r26UUT+euFKS0t83ynZwXuAN20hWyNMTtRARg6EskU29iB6Xl/L9XBwvwZ4vkKO3xsrO8tEYh
	MU3yZPv3pOC+kdfCUukVrb1Z9rXEQr5JnubjNqNVxsJIydilYloweQmdtppWGynyPEIrUEcXwtb
	DPGa15wDVm5hre8Y40tfXwazN3kuxUD72QlsI+uFFQ7X2LVaO+HXbsFkj6zSzHeaj5jFukJjXVd
	QuaOJQ6GK3ysJpRD46bqpCjuerKRUP48h5TZcnI3WC1i3sqobjAICZHhIvTxQkS+rbGuPayjZmZ
	cvXBIhP3+LIfU6D5FPbZCGN1QXoBmlGYg3x7yLNpRZPQYb282UwVy
X-Received: by 2002:a05:6102:6891:b0:4ec:c548:f953 with SMTP id ada2fe7eead31-5126cd3887fmr843538137.17.1755270720999;
        Fri, 15 Aug 2025 08:12:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2tJ+kEbGySiNX8BGOfeA9aiGUSDtWwX7qz7beS8LBiMUWDN+aqqPSPCUpy9yJVSNdquHzkg==
X-Received: by 2002:a05:6102:6891:b0:4ec:c548:f953 with SMTP id ada2fe7eead31-5126cd3887fmr843472137.17.1755270720456;
        Fri, 15 Aug 2025 08:12:00 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef3f3e91sm325962e87.124.2025.08.15.08.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 08:11:59 -0700 (PDT)
Date: Fri, 15 Aug 2025 18:11:57 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Maxime Ripard <mripard@kernel.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>,
        Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <lumag@kernel.org>
Subject: Re: [PATCH RESEND v7] drm/vc4: hdmi: switch to generic CEC helpers
Message-ID: <pz5luqbagulactqp7h237apoostl64rcrnvmu53eauvtb6cqly@nsmzsvbfixrr>
References: <20250705-drm-hdmi-connector-cec-v7-1-d14fa0c31b74@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250705-drm-hdmi-connector-cec-v7-1-d14fa0c31b74@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDA5NCBTYWx0ZWRfX3y1nmgj+nIl/
 ZimpvaU7cqepidh27lXFyo3KMocZjIzK9EW3Bfm7XVgObMiBk5ZxTrXrLtIQnKCMTzJ75ykxOnY
 arg1D3kqGj+6vx+oqRHllGS8aYrmRMg0Dd2SvWn+oNQZMo3x80tFXYyk7FxQw5tmJ409YmUyksJ
 GeO+zZToCn5lMeByE028zyoz3PX8UzvdZc/H2F+Ed3xfsWuJ7Pc9rt1kVjJx7sf3kD/zkjXH8b3
 C7nA8C1yvZtmezcKAFU2x9H/v8S/ov5im7mtsw4tuhP3/0d6QoaaQqoot8Tola4qc34IaFdGT71
 z9lC9SG5wD+o9TQk1Y/wh9e3ILIC+z5xVZi9MAhQazFqf6SUQ/o0VlS3ILU9rYbxVxvEFxd4tGn
 u6uAMsXj
X-Authority-Analysis: v=2.4 cv=NIrV+16g c=1 sm=1 tr=0 ts=689f4e42 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=EEIU--A85-CMqN2ZW2gA:9 a=CjuIK1q_8ugA:10 a=ODZdjJIeia2B_SHc_B0f:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: D90jqyrZazlehF__Y_1o35myxPzRGgIG
X-Proofpoint-GUID: D90jqyrZazlehF__Y_1o35myxPzRGgIG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_05,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0 suspectscore=0
 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508130094

On Sat, Jul 05, 2025 at 01:05:13PM +0300, Dmitry Baryshkov wrote:
> Switch VC4 driver to using CEC helpers code, simplifying hotplug and
> registration / cleanup. The existing vc4_hdmi_cec_release() is kept for
> now.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Reviewed-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
> This is a part of the HDMI CEC rework, posting separately to let it be
> tested by the maintainers.
> ---
> Changes in v7:
> - Dropped all applied patches, keeping just VC4
> - Link to v6: https://lore.kernel.org/r/20250517-drm-hdmi-connector-cec-v6-0-35651db6f19b@oss.qualcomm.com
> 

Can I please get Tested-by for this patch? It has been R-B'ed, but I
totally don't think it should be applied without testing on the actual
hardware...

-- 
With best wishes
Dmitry

