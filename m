Return-Path: <linux-kernel+bounces-831562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D886B9D059
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 03:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C2DA3BAB69
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4CF2DE719;
	Thu, 25 Sep 2025 01:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bIVS/4Yl"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966FF26E6F2
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 01:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758763825; cv=none; b=WelfBqEkrapAYt3ih8k73c1o4QNcv+682AZL/HHf6sY0+pXtkd54+94Z4n1h0ULup8xd9FC48YO7wZGIlIpyZ7YzL2RvhuZIHSJb9W/gAJ6kAaNeypDk7QBWZlb8AzcUTnbciukh5EOVgnFeCH7Rn5pldiaLlM/Sl0115jorvbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758763825; c=relaxed/simple;
	bh=DH4aJWPTM7pVDINdGI0khQskFrk+rsjXqGHqx2g/shQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F8s1n0GvlpZ7du6H2BVEpY/vov7zjt9n6hOLArBki8hpvaEtOQb1fl9dzqC/KxxZvyzZ6d/bScetT/IqxINL9f5xpdvSmYYlPp8o0JljUAr21YGHJ/GK8lEmwQmnP657xhcjxbmOQwjKuwQA3T6EDEV4BTfKOj/a8WT0o17QVok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bIVS/4Yl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P0qvGZ025084
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 01:30:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=7mUyHQNj70Gz7bixQgpoodM4
	fSwBQ4FeRDzfYe3Kgjg=; b=bIVS/4YlSjx/k9zYtxSjYonLhSq5UZNZ6xUK91sJ
	fhbv9Q0+vEAV3bPjX/RSDh7p+0e+n2yW/UQcwS4wHX/UA+krksvwppcUbWplp958
	r4sgttbm5d8miPC5YgzHeWcZDbZkjDNLo+M66r02rXGCCUWCTA2pnHoKcnD7dxaq
	U0Zrl8+u6skEi89VyGT/F3IRasF7SDXVTe6OMQYkBYjX7T3XhL8Jh+/bZE8EjLTD
	3m6ugBeqEuT3ou7zlJF+s4M2Zf/Ej8fqzpYh9F6LU7bh8oXMxkpm0xwiPTV9l0Iz
	RKj2w9D48e+5YSTSNiWarYEQmquPh2fYeK0c/fsdpNwayg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hyexm90-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 01:30:21 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b5ecf597acso9963651cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 18:30:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758763820; x=1759368620;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7mUyHQNj70Gz7bixQgpoodM4fSwBQ4FeRDzfYe3Kgjg=;
        b=KP80fC4BWCNghDvy6409R2/r8uYT88CXy/7SN/wJ11rPbuyqyLrYUK09upBo1Hiodk
         Q0YeqGSFFv1pzmKVqz6pkiTAbbwk3gH5Hfe5CqwdS7sLNf9wAyPXDXD6QgtyufU18X/z
         2B9yftkr7m4p6IgI+yN6d5QE9OpjcmULlP+dvRczWuKpgx/qnDLxi3sguPwQBIWfd7kb
         mLcZ12A+wPJ8MkFkhf3nk7usJAEbCg8Bic8vZQux8w/1aM/5wLjb4aX+rK6MvD6sxHvx
         EooV/cEbayq4d1JXrNcmclQnAhvsBf6tLHBJytcOl2ZiXE8ozRmfXlLer4pjlPrbP62B
         cihw==
X-Forwarded-Encrypted: i=1; AJvYcCXv6bdkY08kSbsnML/SkpoT6xwNYpogOTlzEU9Z7KfmcKuhI8D4fKBhbdlsvONLP3mJFK2d5cOCCO5v4Vo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV7/LMmgYEuCvWExJBA3AZQpFafW1MSbPlKHmivuAzjvJz5fqL
	gx9Vm7JrrkFlIt8KIzbWkLCMkc3gt3FT+ZEoqjBDSLoz30yRwfCl3/vVgZgggR/oKBS4L3CRdmp
	XROsLhdpbDTCwAuZl4TSi0tknnLvEB+1/Fz07VY6QxO/26/BkqUGFMsGcO6CtmKQGyqs=
X-Gm-Gg: ASbGnctCt6E7jNeNx4h2bXdNYtXyxQCSCVfGRLKz+ZixVDdYwaiXPB+Pb35gp0jCrb4
	7p6lQHDh9qjU5x8yVcrWbXGBH6Y3gS61nE3zPRGhe2+O1wnR9e+NXsNtN5V+K37KNRM1ZAZVwAL
	7Z/XZ9Lsi89LAS7ciDmyZd3NKKQOk3U77jP+fRJSW6e12lonF5VgFlJmh4BflBdzLxIncVXzGXd
	gTJZ9hfyttXvAciUWXTnGBnYvOlLGHapJHZO9ac4S3fu8SqyBBrZMcCFR6eEDsFizLyk6St+8Iq
	eBm7JUqC3D0a60r7QdtrWKOfHbAd2JA+b+c2sAhweDBlcxvaeARaqTuZke5RnVnhQzzZL3HHArV
	EGrTeoMEq9DUMesymomFmq/1Mcw0cND3kBoPbJ0Sw1XaHnmZIFxUs
X-Received: by 2002:ac8:5856:0:b0:4d9:440c:2992 with SMTP id d75a77b69052e-4da4bfbe724mr22592221cf.58.1758763819789;
        Wed, 24 Sep 2025 18:30:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF456x3zpn/m71a91HI86r+v93v861E9jEgmFun7cueAn6yXuEgN6HFNgHqzD1nVz/Bp3jCWg==
X-Received: by 2002:ac8:5856:0:b0:4d9:440c:2992 with SMTP id d75a77b69052e-4da4bfbe724mr22591811cf.58.1758763819256;
        Wed, 24 Sep 2025 18:30:19 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-583139fb04dsm211238e87.44.2025.09.24.18.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 18:30:17 -0700 (PDT)
Date: Thu, 25 Sep 2025 04:30:14 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, kishon@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, robh@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/10] phy: qualcomm: qmp-combo: Update QMP PHY with
 Glymur settings
Message-ID: <un3pulyn7tv3qihdnqmktsctped32am2eglxzfpwyz3u3tqspf@fnieck3i67j2>
References: <20250925005228.4035927-1-wesley.cheng@oss.qualcomm.com>
 <20250925005228.4035927-8-wesley.cheng@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925005228.4035927-8-wesley.cheng@oss.qualcomm.com>
X-Proofpoint-GUID: QoQwbTny5ZxDgTbrqBq2JZQ_tRo3z3sI
X-Authority-Analysis: v=2.4 cv=YMOfyQGx c=1 sm=1 tr=0 ts=68d49b2d cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=gzIeawRUdsEZb0YUvHYA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwNCBTYWx0ZWRfX5j9uAcm+utSx
 wwVz58XfDq7dNPJedZubxayX6n8h7NvVWPUUHqxyiJLxlGPzuwEFuw7hktRGL6Hc2y7XOgSK+TX
 KVFB6leCTeAlM2v2y14RWFSam+xu3wTnVAtZa14jNiIOOEyl9rqc0lqFMfUX+FSQQD0bj+ZhD+t
 97CoU7lmECvRkRlQZU6GnkemgVCPXDrrmNeTkJeZ8wRQrrfRt7LnRkWNIszTKJLdLV52ykg1Nai
 6ZnseSdtuNHm74rQxu015yYjRqlinIPnQsbn5IqDw8FzffUS0QtLDP/jZpu9ZrnUtSIGcEzoiCy
 ssZXSSw7bfIkPrEiC2S5WD7XAaPNH2KGMbdEuBLDi9edVaX6GT/632/L0jZIQCZQBppgA1KuAfN
 qXnejVnR
X-Proofpoint-ORIG-GUID: QoQwbTny5ZxDgTbrqBq2JZQ_tRo3z3sI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200004

On Wed, Sep 24, 2025 at 05:52:25PM -0700, Wesley Cheng wrote:
> For SuperSpeed USB to work properly, there is a set of HW settings that
> need to be programmed into the USB blocks within the QMP PHY.  Ensure that
> these settings follow the latest settings mentioned in the HW programming
> guide.  The QMP USB PHY on Glymur is a USB43 based PHY that will have some
> new ways to define certain registers, such as the replacement of TXA/RXA
> and TXB/RXB register sets.  This was replaced with the LALB register set.
> 
> There are also some PHY init updates to modify the PCS MISC register space.
> Without these, the QMP PHY PLL locking fails.
> 
> Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-combo.c     | 311 ++++++++-
>  .../phy/qualcomm/phy-qcom-qmp-pcs-aon-v6.h    |  12 +
>  .../phy/qualcomm/phy-qcom-qmp-pcs-aon-v8.h    |  17 +
>  .../phy/qualcomm/phy-qcom-qmp-pcs-misc-v5.h   |  12 +
>  .../qualcomm/phy-qcom-qmp-qserdes-lalb-v8.h   | 639 ++++++++++++++++++
>  .../phy/qualcomm/phy-qcom-qmp-usb43-pcs-v8.h  |  33 +
>  .../phy-qcom-qmp-usb43-qserdes-com-v8.h       | 224 ++++++
>  drivers/phy/qualcomm/phy-qcom-qmp.h           |   4 +

I think yo've squashed too many changes here. V5 and V6 headers should
be a part of the previous patch.

>  8 files changed, 1251 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-aon-v6.h
>  create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-aon-v8.h
>  create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-misc-v5.h
>  create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-lalb-v8.h
>  create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-usb43-pcs-v8.h
>  create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-usb43-qserdes-com-v8.h
> 
-- 
With best wishes
Dmitry

