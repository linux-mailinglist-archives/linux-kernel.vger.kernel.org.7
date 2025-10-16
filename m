Return-Path: <linux-kernel+bounces-856891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BC42BBE5584
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 22:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B7FD74FFEA7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 20:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39EAB2E0924;
	Thu, 16 Oct 2025 20:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HY3ukzu+"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E9C2DF3F2
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 20:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760645620; cv=none; b=tutgH/ApWIXgE0jtBYky8Y0Xssr+9GNmMGT2NdzfIZZiRWzp2LPjpfeHcNH7Ob+zy3brQEuK+95f3kVnQHSf10uvTRV/3oKaGi+7C01PXVahLSwLEQ/eevsUM0SL5anqIIrTGkf2efnhwFKOBLAhQQwV7dbuzNUJ2+mOt92JI9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760645620; c=relaxed/simple;
	bh=O7HvVyjJWh1+92gHAyUFdd6vnnoG1EgYJyiOAiUnPK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZJqVsl7yYM7HLwdxWSHcYd0tWKCuVW1JbEGuAvx4l5EtUO1T3rN31g8/YC74JoCk+3ZNXKgTHcU0xGw7BbJTr4L8kiAWTGxh1/3oszmjxJ7kEV7QD3Az2Op5biR+h6SsIp/QEPWkUNDRnejoohWb5czCmKIE2fdPoVwVArtDih4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HY3ukzu+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GFVgXH004230
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 20:13:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=BVqwkBK7C+4usBpdqeZOce1X
	iXkyQyUXbdkjEjS/bvA=; b=HY3ukzu+mNfhq+d/Pav+sgGVuIBjQ2C0Xa5fFe4m
	RoVC2bd+U7S7UezPZ+2AeaAstaYXsDQM0yhWD8nM3fxwMhGP+nb6zOrYt4PNrjaU
	pLYvuQqICD6pu6gLAajfBAX41NUM9t6yrlBTHWdLs5cCyo6PbYrCWurmgInHZRdB
	ThVV6saOvhr1g3uzrrYXu2hsi0j4zbiTkDgby0JX6GbojHGsMxNTAvw+2U+uezM1
	oM4Pz0mgkR3/gkBtyJFMTs2FeX7Kwgi/wk6cP4UhzS1TVF358V4+P2R+xR6RmeA0
	2eQf8/JcjdyAqfUngA4CUyPqLWZctf2TGVWvXkpYEq/Y5A==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49s6mwuyny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 20:13:37 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-86b8db0e70dso82047636d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 13:13:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760645616; x=1761250416;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BVqwkBK7C+4usBpdqeZOce1XiXkyQyUXbdkjEjS/bvA=;
        b=FngkHm0hv3WxEHoazUzidigekarZeC2iG9mvfnM0yBhjV+0GgHQUshMAXgxenivZQ6
         31rrU4LznGMqIjnujNCISMtAGHc0MAfjJmdf0EiakXQ9YZUxQXa/HY6RVXV0eXdVi9xd
         uctkQMr2jXDgi6IjNZhPSg92Z7K3MdTTHEb8NKYXZAs2Ji031LSjpR9Oo0kmtbCAEGoT
         u12UlJsKjlUwGi3UulYUt9ApSGEQh+8AKw3zVbC+D+cnp1O1MWUpevseA4aE7ftubQ9V
         3jmk5UUDOIWE1XxtHZuaGk4HHUOTLdQY2Nn/+ocVZ3nb+EOkJuWIh/lDP/Xr15rSm+bE
         4oCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUenXuzq5hOf84akedQfMk7zMXBAa7mM89+p6AMbLqzAA16/kEP8zeteVZh3Aut5yR5lNJ0jDdJR83uGIo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHyjbKs0vs0X4NXa89WIyOg/AlYQLQQUh+5EA15EAJgll/LvkE
	hnU1fY2ivUkAxkpBkLEigQWUQ7OH2vr8XVrlXd2NtgkDQJONv7nLwio/znVRwyarSEeC4oDXwMb
	amFTeg5aZdeDE6XN2nymQd5mmhysx33RmuDwcuj3czR7TJlH65OgA+mzH83tw732TDEw=
X-Gm-Gg: ASbGncvqv5BGpawECuvudW8CHSkMVv1OTjuOcfpaXEXauH/PIjTpAjD68WAwGEJ+SMt
	/OGxyZe2F77GpjXxOdP2ZGRYj/yHZ6ygcwmwVa6T/+JuCcZ6Mzr3Yc5URiwXyAMOiLly+JjF2dj
	j4SaQUZLxCjAmHqVGDtMjabn5oMJ6uS/sZj+bWGkBceX2vIIOizGPcBTekgZgWZj32bQF7vMYxA
	O9CG22R4Xo0rCO83UOzhMhvSo1mMDbFIjE5mdZebDj8qsqK5ZhB5DKOeRi3w4CGJQKU2wRjXDHv
	660CauaRMeKIyA/RpwSEDT9KNn+pA8MibQjdFeYecbwY9oKOU7LpkGBbqweb9LSt29c0DypdImA
	aMJtjZPLP56V342dEAG9XcPeV9abtdFh4+AbiZmGSUeqB7sCcb432BF6LR1DqQRJ5sCvUsdsvsi
	rtqXM24XcoQ9Y=
X-Received: by 2002:ac8:5790:0:b0:4d5:eedd:688d with SMTP id d75a77b69052e-4e890fdfa5amr71048541cf.30.1760645616393;
        Thu, 16 Oct 2025 13:13:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxGdezOd1qF+LssL/Y7iPaJQpkE4Smw0fe36efmwylumTn5FP8jrXp4xfot/RsukELYTcXfw==
X-Received: by 2002:ac8:5790:0:b0:4d5:eedd:688d with SMTP id d75a77b69052e-4e890fdfa5amr71048241cf.30.1760645615972;
        Thu, 16 Oct 2025 13:13:35 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59088563a48sm7309026e87.83.2025.10.16.13.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 13:13:35 -0700 (PDT)
Date: Thu, 16 Oct 2025 23:13:33 +0300
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
Subject: Re: [PATCH v3 6/8] arm64: dts: qcom: sdm845-oneplus: Implement panel
 sleep pinctrl
Message-ID: <f5guyszcggcjnsp52uwexw3gfbcb5vakpydcr2g5blpblsgg44@qzx23rn6ycco>
References: <20251016-s6e3fc2x01-v3-0-ce0f3566b903@ixit.cz>
 <20251016-s6e3fc2x01-v3-6-ce0f3566b903@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016-s6e3fc2x01-v3-6-ce0f3566b903@ixit.cz>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDA4MyBTYWx0ZWRfX82q5SxjVjNr2
 K+B406nwpOQ4lICl+k8uDNeVH7kCEYuvxtfaiOm62zm3BzvFXTInnYEKwW3XWkemg2fXZ623TOW
 tA5I7tev4Bkdh0Uc+LYCkoRS54H06OyjOuXanNBg8nvE7waszccC/+D4J5hqlFZzJ4Je/5imK0I
 1AzeOYswGQxPGPDlk9Kptde5xlKnCntuhac/f6afmdZTkJ8pR9C+SvCtW1ZwbIlLjbCIXMt6lTI
 l66kxQIcICG+idUpKRcUOO2Rds5F+2UIOFYc1PzAyo5+OJi5l3DTBTRq4BLdblVLG5HRI5mxXC9
 pX9N/gyXlOV7bv94qUimkj7NIM4fgcRRq1xrP00dsav/NPNGRvi5n9MxHzqLQhG5yby4NQmPpjf
 nGQpuzeKMA2bWwDD8PRZBXGAiALLeQ==
X-Authority-Analysis: v=2.4 cv=Fr4IPmrq c=1 sm=1 tr=0 ts=68f151f1 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=WaRAvzN972V7znxJzTQA:9 a=CjuIK1q_8ugA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: -LIVQnIhMR-_3jWaDQjmjpBfsFUparKr
X-Proofpoint-ORIG-GUID: -LIVQnIhMR-_3jWaDQjmjpBfsFUparKr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130083

On Thu, Oct 16, 2025 at 06:17:01PM +0200, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> We can DSI pin from 8mA to 2mA while suspend, do it.
> 
> In theory, should give us extra 2 hours of idle battery life.
> 
> cosmetic: sort pinctrl properties.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  .../arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi | 26 +++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

