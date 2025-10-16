Return-Path: <linux-kernel+bounces-856882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD8FBE552D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 22:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0DC9D4F1D83
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 20:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1F52D46B2;
	Thu, 16 Oct 2025 20:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GRoQMH21"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00872D9EED
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 20:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760645335; cv=none; b=k36xqq0LJZGmz96bQvQDEZvsDGLQ06L3v+mxN65tb/DoyVV2ytTAZ7rBVgyMpn7HPUk9Ws4kPxChXrxZsM/fYns3xhB7JxJeYrezGiDsrh01o6ajRmS8+WknEWCnP5LYpNRq0qYh/naE4wfGp13PvV/jT8Yzo4IcbHLOTjIX6sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760645335; c=relaxed/simple;
	bh=J+Zwp0E9tqCVCXtH1TLr3bcBFxCc5MDrmVDUvbChza8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cL9Lx94Hl7WojfRU5Aj7+ikXOjCMmTL2v7UbQ5JCVwKvNwj1yrfYYijANCcDtBeViQyO1qEcS3YOx7D2j/ayUY3DvpV6HMO4LnENErIlrZeWEI9LqqPaywv6Q4wfqmvDaPu2eKHm0yw1auANXvF61VjlF3NAZ9nSuJ5vx+w8XCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GRoQMH21; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GAhlck022118
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 20:08:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=XW25WTUPjM0HYbFzO4qQOv0a
	rYQaTxvpGuWa+PN/BYQ=; b=GRoQMH214l9ZktR6yEwxRJNDcIkLrBGBary+WEiB
	gk568wNkQnbNtkD+GEL1hRkPTWZ/2dm4uFYIutRag5FBldkDVnAWfyXdr2+zYpbr
	qx1FYrJ4jOq3ppXR/hcqkq+JfOaBuHUAjRUToTk4TAHCykw8Euz4m9BqNQLBh/tG
	/g5mHJuHsoxuQNOvChjTXEy+l54mJM6APFKcXFcIFrSTuiTrba9o4mvG+mIGXyuR
	LU0RrLb5OVeep+Z9OjfIyzsNzYaiNpJxTeb7ZsQFfDHKXvliCzJjZw5In9jH7VFU
	hQTKA2+A3pLHJkUm1BXyp/86N9+KDx5TaelhK3jit4MsSQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49tqvpjyy0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 20:08:52 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-78e45d71f05so34336666d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 13:08:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760645332; x=1761250132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XW25WTUPjM0HYbFzO4qQOv0arYQaTxvpGuWa+PN/BYQ=;
        b=VWGf22UTLG9zApLnVIgz0lj1psju0zlrrsB0mDh8pfmIAXOB47jqMQmgCNKuafHMnH
         K7mFayml5Hx5INYZ4DdVaSOkNgkyn4BAUEGgkSnsH4nxFOg5b0Fl6+foeZH576vgYydu
         x+rYGtC/QYgFVOqdORZVGpCmiNVxpClW+/72AJIxLVS4sCfDtWEKdOlsdU42HzRc84Bt
         XcIvmUiaX4YFSHlKocvg69Mrm4j3VLwJCavmPs140FjsgGvXkRJdGn82x/ZlAMYtAC1u
         zJy4q1WA5A1Pxg2B+zS1TbZFtey3tkI3TEZZeLxG283IhzBH3BHpFmryQZYU251xyWsS
         wVBg==
X-Forwarded-Encrypted: i=1; AJvYcCV/r+MMR3hoKOjCwyPykU7Piu/zsm2/av8Y+uXrTmKIXXPPsba7YFG06r8XZlADgpfDm++JwsMrE245KMY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9UJR96e+ipanL22UmRpqoZVTRHEuR16+b5GUQh0zzzUuZZ+/1
	BXRKtuFuNHiGmuUZbCcHgmsSjupV/9qSZXGnRDySLQO/yPBp7lkVIOcFChnOP0NX/tQqoO/wG3O
	OnXnAHhlEJIJTDU/YPju4bYAJSkVl9gdMJeluVigi4/SAxwuDUQX5trxujap6VsD210U=
X-Gm-Gg: ASbGncuKRvOt9Jir9fshP9iD4MeKBQHUMjI2U/CNOJgAMPqbc9811VNwe7h3RKuVtlk
	XH/tsc8r0a6BJKDZUOoVJDI4Adzka3C036cEn9S0myIeHcqh32/3ADcFScMO3NxKrCkdCvNijLt
	/2IbCX7qZw2nrdB9TiKH56bN11wYKEdTmkuDkHiO0E4zJSto4xF58DWG8BmdXOLd2wcK7esV5I7
	y3CEGz/rxfpLiVHgQyv1tRy0B3zZwdW/kBoxg8HP0voIjTc3lgPGxmBZ+5Rx9HTnUaTU8atqnvf
	1WhS2e5SN47zzgUkK+57E5bVi+WM8neiTBO/pNOOJPDhxHUkfup6msIO0zeMod50G1/xc8xPwvP
	ftaQ3/JyMI1BZJ8NxTPgB2sSv72zaFeCuhvj504CYZciuWDCrPSGJb7P4SiPcjLQwy04FYIvIxp
	uw2X1l+y6vupo=
X-Received: by 2002:ac8:5fc9:0:b0:4b4:8ee1:7d98 with SMTP id d75a77b69052e-4e89d21c3d6mr24692871cf.8.1760645331603;
        Thu, 16 Oct 2025 13:08:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELwSY0pYfGnC1kz4S53qSyk4kBH14qSenJ7X/Cza61k+EVAgrYsjLisx7xZsfpWVeiZg6fEg==
X-Received: by 2002:ac8:5fc9:0:b0:4b4:8ee1:7d98 with SMTP id d75a77b69052e-4e89d21c3d6mr24692431cf.8.1760645331106;
        Thu, 16 Oct 2025 13:08:51 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-590881fe5besm7293872e87.50.2025.10.16.13.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 13:08:50 -0700 (PDT)
Date: Thu, 16 Oct 2025 23:08:48 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: david@ixit.cz
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Casey Connolly <casey.connolly@linaro.org>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        phone-devel@vger.kernel.org
Subject: Re: [PATCH v3 2/8] arm64: dts: qcom: sdm845-oneplus: Describe panel
 vci and poc supplies
Message-ID: <62iuzoisxavlgadhz3gfrlwxqu6vl4gtlyrarjkmwihepjr4hf@nuzpsaj6jcg3>
References: <20251016-s6e3fc2x01-v3-0-ce0f3566b903@ixit.cz>
 <20251016-s6e3fc2x01-v3-2-ce0f3566b903@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016-s6e3fc2x01-v3-2-ce0f3566b903@ixit.cz>
X-Authority-Analysis: v=2.4 cv=aPD9aL9m c=1 sm=1 tr=0 ts=68f150d4 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=CJSKMeR5ttdQttduZpoA:9 a=CjuIK1q_8ugA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDAxNyBTYWx0ZWRfXwkNZvPLNeCvY
 +ChTgBcW2ObnadhrOCB+iNIaiPDbeSwGGGm5IUQ9+FQE+N1QsTCNdSumguMP++7d47TobkmcwWt
 qWBTKJLjJZ/NyhjqQi/DH7HvBjyZPQhhvsmllbWhLlfcfGR+hkxG/XFntHYxqC+0ei1dkw6kAfW
 TqQ+r2wvmdenLmHptqaSwbOnCwgpDscJxW5zWbf9rVynfIfr9mSgMTRjv3i6faeN0QTPbYSxIo9
 ICGV0WuKP2VTsJixgaLE44cbBuxB31ZixphfFFCM3/OdMIs0U8kIzrrHn5lXhv6AdLOdniSwmtN
 iDJh7oCirBkZJTC7E9rhFNB3ll3xX1mFthbv9ijRzkShXwIjZs4a6Lkwz7bS3SrjyTLfQ6Ou9us
 6sE5BNrhv2neKYpROI8mnanGXsJYLQ==
X-Proofpoint-ORIG-GUID: ZU_V3Y-qQfWFNryIkYhRhg3_tZxilmc7
X-Proofpoint-GUID: ZU_V3Y-qQfWFNryIkYhRhg3_tZxilmc7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510160017

On Thu, Oct 16, 2025 at 06:16:57PM +0200, David Heidelberg via B4 Relay wrote:
> From: Casey Connolly <casey.connolly@linaro.org>
> 
> There are two additional supplies used by the panel, both are GPIO
> controlled and are left enabled by the bootloader for continuous splash.
> 
> Previously these were (incorrectly) modelled as pinctrl. Describe them
> properly so that the panel can control them.
> 
> Fixes: 288ef8a42612 ("arm64: dts: sdm845: add oneplus6/6t devices")
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> Co-developed-by: David Heidelberg <david@ixit.cz>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  .../arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi | 46 +++++++++++++++++++++-
>  1 file changed, 45 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

