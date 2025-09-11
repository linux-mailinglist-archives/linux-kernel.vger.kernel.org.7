Return-Path: <linux-kernel+bounces-812098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 050C7B532E7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 14:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53FE21CC0A78
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 12:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDF732252E;
	Thu, 11 Sep 2025 12:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LOFpioyS"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114DB322C66
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 12:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757595450; cv=none; b=stW9CUd8T+tdkfCCkoWWH/+BguX6dc8rG57SVqBfnbXmXMTsV5gYuAyOQ3aHWvhhomc5yHXXpbQZRZSwIcxg1Z1vEmYJ8z+Ag9OmDCPa4jqLVIg5PJjRycKUEHJGQRQJVWbTogBLpkpzp3OFF3+iHQeV4mNR6pX8+odCyK90kjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757595450; c=relaxed/simple;
	bh=eYP9ldOr8fFehKQpvW8BhB6kTjTJQtw4xncb4uUpb7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qIV98ocJ85TH57SK0JdCTBK/KnPZQGfRC22p1Uba/4Ga1W1yFB51UdiQG9lTua4+b3CJEdS5Y8f+KY/nchNsVb+20kH9Lp3MJIOS9OCoDh6nhhrtu8l/0mRVZ0zDmxE7tegWrMTt85xW3/LtWu6fgAxpPhPwUc2AnV+4LpbFwGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LOFpioyS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58B8VsaO003795
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 12:57:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=5F4kfREjeTfa3WqC2b/52lNM
	yv9yD3hosyjF57uJTA8=; b=LOFpioyS9HMKxtSXT1eBG8itb3soeCkkvdviL5y7
	r7k7dvSbrqFumJfMv129e9MLbytCrCNOlkgq/BzGfpKPyQYRXDQfYYsnyhfQ2LzC
	jiFiHMPazPyXNf87ca9RgMd5JlYmblWTs0lIbK7JtevSbJR8Z7XTwpnQI/jZSucv
	CYzI3gpj3CMVywF4txmp9Bo/ZzjqOhO0AhvGbgf83fcSaBLBnI9I1/YT+Up6Y6TP
	PUEG+Lwb/UC6OjzgHy5B4W/pWH4zOSEY4GVR+Gf4t6NDeAcWBOT4ED8XhNLc1Sc3
	il3+Agv3M2bXsMT71eo23InBbrzEKBBlyLkAKgWpuSOylQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 493tyxrscf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 12:57:27 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b3472b7efeso13581011cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 05:57:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757595447; x=1758200247;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5F4kfREjeTfa3WqC2b/52lNMyv9yD3hosyjF57uJTA8=;
        b=EqC9DPl6WMJqt0iOgoRYc91rvWGwRoBoiFyTatU1Q5AhLhLopVCgTCw1hqmNlyl35E
         0QbwYBO28W1kMGld9uS6IWIZaSQiUYOfKJSQGW/7whk9j/V7JW6ezDqgEPfnBHv6W6Ll
         3B5xWRMYncdWP+j5xr2j92+lipEumLMJRR2dx4kyihu8yNm9cwy0C6lskdGhy9Il+t+T
         HlJJnS3rzEOfJOtD4zAz99+Ggiml4FLVkYrcsQxyBphJNqZZEyiVn6bxoAgAsSszbD33
         mbLj75JTbF+hO6K7jR6HKJk9qle2ln5ngLVNGZf7/Mt9sriCbldQYK5c2CzqISxYMxDn
         +pZg==
X-Forwarded-Encrypted: i=1; AJvYcCUTI0z1yTkX146LBqlvWoJCpzofKmLcXlrVW8jaxiAqFuhSyVQeKv/3uKugAxA/G4Ld3/gKsNpNT+NDbr4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrKa4XMWfqmgLPA3b/Kqqi0kvDLyQ5Wg9dCFfpp0JlavKJWFxH
	Q1dLrYmpqVNadsDWvRhWeNdPMFz7TgjM9BuYqX2rfctsaT526n2RRtsUSMNDye86Vl09hteb2dZ
	nBW8XyAohfek4oc9IvsH+jwaGb1npzQNH4DSJZ5UITym2eZb1VuqPL/7Uk5+sbqzWM2E=
X-Gm-Gg: ASbGnctEayXa3RRdwTs9sSc0HyBG666R1JkcgOu5m652C66jGy2gudyJmrOnjg2VkYY
	Kq5PkYxzfkIb4TblpdkZShb8KCqb+2blfATe4btEyCJEZv01EnMxh2uLFTPl9c5aiEI/9rR6Y9l
	JoGX4BiS0o+MfGWHT5RAe3Ng4lotlQEWLH5/PYHbOLBQ9CCZHHGHwglB3XyfOcpGph7mrx4qxqs
	atBMDbDJzeRZMUPZ+adWrlUc7rTabGR32w0fLJRg1R//w9mUs5BqY+/Qll0chScDY4Oy0tIZ+Tk
	41b7BNytuH8wQfZtgpXhWPSL4gKzX0R5yoX7FpbpYC16NThV4nhvLgoKu0h1cO+1zGtt6f5P+C7
	pmsm3G/acWicVZyxA5QUzREaykhENEKunMcQEHc/kWRkHP9dhzS3P
X-Received: by 2002:a05:622a:130d:b0:4b5:6f48:e55a with SMTP id d75a77b69052e-4b6346f39e1mr42311821cf.12.1757595446940;
        Thu, 11 Sep 2025 05:57:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmfeR7fqbYQsz/Cx0vhB0h7BtieRzZWfwREik41OqRawcDy0H0xPFZm8LueVdNLZmIIf7boA==
X-Received: by 2002:a05:622a:130d:b0:4b5:6f48:e55a with SMTP id d75a77b69052e-4b6346f39e1mr42311341cf.12.1757595446424;
        Thu, 11 Sep 2025 05:57:26 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e5c3b5fadsm422254e87.6.2025.09.11.05.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 05:57:25 -0700 (PDT)
Date: Thu, 11 Sep 2025 15:57:23 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] drm/msm/dpu: Add support for Glymur
Message-ID: <d7his4r3txgmpgptl6ohnjzslm5s3wquxxsi67gli4wcyszlsd@klru2kjlk6i4>
References: <20250911-glymur-display-v1-0-d391a343292e@linaro.org>
 <20250911-glymur-display-v1-5-d391a343292e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911-glymur-display-v1-5-d391a343292e@linaro.org>
X-Proofpoint-ORIG-GUID: fV7wTx7oyHS5UH_WmOsxo0rJRQZ8COwv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTExMDA3NCBTYWx0ZWRfX+s89CqZ9t0/G
 1ymD8vtI6fCd4SxTiDdQTTQKvg5cw6VpSdFmjYh2jAtzl80XT2hUJKqF/5FGLpaSaIhOSRv8Nq1
 6QIUJXcLRpLsrbWxaTiiFx/KUi1Kg3eLwHo9uuXtgaTJeTVwyrlqH3HzcZnPC2EibQRpmiZsZGl
 5ywvnKWgGa2LqZFHsz56tlGOmoAQYF58pTA4rQT6Xffj8SPeIAbDhwRjjnmux+NNuTwLOZZ3ZNU
 0tcMVuSy73aYtPzIgnvJVFBE2Z2DiXl88Zsbs2Ov18fp6Iw/EN0C0d3vAhlYlMDpcHJKzkQjlbQ
 sgbQHcvb8+8ot7HtKBOi//TGNnriyHChUqASGBZq2GiuDhXgNv/N0nV+QKF7rNDgSxhvAZZH82X
 WKsmhvoQ
X-Authority-Analysis: v=2.4 cv=VZn3PEp9 c=1 sm=1 tr=0 ts=68c2c737 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=Z5WwtQVXMiuTecYWR00A:9
 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: fV7wTx7oyHS5UH_WmOsxo0rJRQZ8COwv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 spamscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509110074

On Thu, Sep 11, 2025 at 03:28:52PM +0300, Abel Vesa wrote:
> Add DPU version v12.2 support for the Glymur platform.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  .../drm/msm/disp/dpu1/catalog/dpu_12_2_glymur.h    | 541 +++++++++++++++++++++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |   1 +
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |   1 +
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h        |   6 +
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |   1 +
>  5 files changed, 550 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

