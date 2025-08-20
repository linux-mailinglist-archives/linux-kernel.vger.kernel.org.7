Return-Path: <linux-kernel+bounces-777604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B46B2DB87
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 13:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 972B86849DB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A5D2E2EED;
	Wed, 20 Aug 2025 11:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f+ArhmI1"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF6F21CC71
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 11:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755690388; cv=none; b=cwnvmuGdTYMErtNsjJbHw2cQMO03QKfUdkz/d58R60qWMPRkIsULI+C7XxEqZKlQlGUmpAFg7A88EzZSwde21etHnNxfVnSNuppCo72yxgHVw1Zv2XeeivroKjDFhEth/PlmO8DyeyuI8KLt4yyTxA31FeqgvVx6AfLujzQ4XzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755690388; c=relaxed/simple;
	bh=vGFR3vP8nyO82cAmfCuW+hvuIZljUq1p0jyyI10ddHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LyCUN2rv/rkQ3LstnQwnI7t7DHyddv1/dL8TUX0Ec8GXuFFVTSllIYNAieiiBc8RfIrn8bSLtm0ol/j7tVl/2t7TToh7kvPcOdnaODM4PrvUl6pQXDAdlDPkpv1JrIKiC6K4Nk0FSmisaQSWvbZ0/f2FvwcOg2JUYa2BkR2Xo30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f+ArhmI1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57K9vvSc025126
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 11:46:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=75L42tl0MI8KDN3dC/5xm80p
	bNugX+cDtHPbn4TsTaM=; b=f+ArhmI1e80n2E11S0VAGAHBmTj7HCLAeDvtlL56
	+k4LpOIw3P67j6da/lsVzoHX+IUnXFXe1GQ1pdLSdyzZNIWh2S5mDJMJXbxxAGx/
	3HtprMmldnr6sfITJY7LfmQwx838XN2D+yhlDylMSYdOh4mkP0NqzRllWF8rZinS
	Pd+IXCpQKKojyrZDd4waTrWOVWtOPAlVlIPrT1srooK9IcXftGSt+1mrG6RpfH06
	KiNEJgkUWbMeaaUG1VzwKUp5aasgESdXV2uURKnfRWWQLhZlEze7EDRAVXH+EqM8
	NNjCp9eOQY4JHk5n397t3haCiQQsmELZeY4aBmcrgFgfUg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52a9kkj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 11:46:25 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70a8b32a6e3so126674546d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 04:46:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755690384; x=1756295184;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=75L42tl0MI8KDN3dC/5xm80pbNugX+cDtHPbn4TsTaM=;
        b=dJhDHSrh8Lq+hxMs7E97k2V33Hn51iCprIcmAnfCR3700JHAYndyoUTNTJk9dMQkzR
         T476fW0gy+2ZKkPOCxJW97aRv1+QjlNEv/q1NiLdndvMcrhZOxRurwX4JRXal+ZbUAGL
         qyt8BwiXMLhYeRTmHDi3SeUS4diFJgF0zSwokRZVDKSpmE8hwj7zuae+BkIuFoczvmc4
         jbF75WChGGR8Z1/au4iDMWS0W78/fr7EDViSn6ra6c8yR8dub/RqAo+TFPuLpf+j8oBa
         H0DEj0Y+DRlYQeydQehtaC8E/75qlphVg4dfXDrqX+e7DtfNMklT+4OdaQP9IzjW5LRg
         vy2A==
X-Forwarded-Encrypted: i=1; AJvYcCVWrT1gl77c2ab5J9sVrHSzhqef9Ndn1gyeU5pgxugI6wZPfzaL/WurH0Sk86xY32VlZDHJ1SQrLkVKRlE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPYHU5Ro3swPTz+5NwZz4bDqEV+2XqauB4+SlWwxcDLpbb1coK
	qTuI7q5m+y9i48NdUdmG0+HV1ZVF+WH6lMp5geO6mEIpoLeMUnHUQ+zZajUmVEQrDmia5zhD7In
	C+FEUDoPr8U9xUgvaJka00T2+tUF0ylhn0TMGE5i235hf9qhrsmH5WH4C3gWxXEfjruY=
X-Gm-Gg: ASbGncsGVG+HpI93KvMsu5ygMqbf7JnSdUd+0WSG8OJHJdV9jZtZJCABx+DTz6oJfYs
	e95BeJt3TJXWDspiQbZqHPZ9pLPJ3uB2lJbfDeoZCQ5vylTpZ7yU21bqsj8AvPp5B6GANilmPFi
	0HXK8Iw+DCD1Efjcadx/HEaFsAi99NurjdJY7GnNDE9lHACtN/tXXcSmOBAKdfpBIGT27mAi/W9
	RvSmOCTolChtle5ghxz2ZpZKa66iBWXR+h4INlK/z9i5lRz4ZfILPodkI09ZjvbQd/FsX4zyAPE
	a9hYBgSeSPxBBG2jvUK8vbTndf2VMCYToMQNH+HKfWAZt7IPJs55OQzkZ9F7eyrcDLNlIM7u5FZ
	wAJX0c9ycmHSZRdfMULfc8xZK04xcf9VBPMjSJt+Bi5JUpKfeFtjr
X-Received: by 2002:a05:6214:5194:b0:709:deb2:3dcd with SMTP id 6a1803df08f44-70d76fd4c15mr24701716d6.25.1755690384289;
        Wed, 20 Aug 2025 04:46:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH83ZZdKQ60Ug1Lmf0IPGuUmaz4M2F4mxHsaVgPhdq8EvO/IDjNwV6zVABnr6KJ/OabGfXT+Q==
X-Received: by 2002:a05:6214:5194:b0:709:deb2:3dcd with SMTP id 6a1803df08f44-70d76fd4c15mr24701406d6.25.1755690383793;
        Wed, 20 Aug 2025 04:46:23 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef3f3525sm2531156e87.108.2025.08.20.04.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 04:46:22 -0700 (PDT)
Date: Wed, 20 Aug 2025 14:46:21 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
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
        Kuogee Hsieh <quic_khsieh@quicinc.com>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, fange.zhang@oss.qualcomm.com,
        yongxing.mou@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, quic_lliu6@quicinc.com
Subject: Re: [PATCH v3 03/14] phy: qcom: qmp-usbc: Rename USB-specific ops to
 prepare for DP support
Message-ID: <ay4ss7cwpiz6zwiwiav4ts5hwhxjpc6ogc2uirwzfcyhi2crln@3azxsu5hvyhy>
References: <20250820-add-displayport-support-for-qcs615-platform-v3-0-a43bd25ec39c@oss.qualcomm.com>
 <20250820-add-displayport-support-for-qcs615-platform-v3-3-a43bd25ec39c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820-add-displayport-support-for-qcs615-platform-v3-3-a43bd25ec39c@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: ePt62TvJklLCrm_jeQnwlbu3KgYwaXOy
X-Authority-Analysis: v=2.4 cv=B83gEOtM c=1 sm=1 tr=0 ts=68a5b591 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=H4SNA-w7Ihemelo7scQA:9 a=CjuIK1q_8ugA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: ePt62TvJklLCrm_jeQnwlbu3KgYwaXOy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfXxjlpy4sGHZNX
 yFntgWKEXR/YnjD9VOwsJAT6PJ1UCZba2o2iPFNM2FYQYfT9wzqnYVMqZ31ICR/e7IPWFJLrUve
 9O7fJRqvU+TGglGI0ygJuCgqBA6Wki/lhsFbN4FJwVBgw4TNgYQ2TM7FnqUVF5VQqjxr/liLzkX
 1B+IT2Vu41jUC1ngcsicAkECCYVABC/la1mkzjFvz/7daGerz1jHa6uDUZJ1o+HK0Zi92c8PPJj
 nGfntLpQqchd0eIIHTEbQLvtLfqn3dUmUURs1sCCLXlZ6fv8ndfAvHRajdcBIIoMQaZthjaU9TE
 cNvSD2sMigJEQOcFA9SApvUkxiz5ETRDy8n0aT0BpkxhC8IGm4g/c2q3dnIGwUTIZC/+5ZgyAHw
 bfPShR2UiGe5pVlxn3NDW6pcScodjQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_03,2025-08-20_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

On Wed, Aug 20, 2025 at 05:34:45PM +0800, Xiangxu Yin wrote:
> To support following DisplayPort (DP) mode over the Type-C PHY, rename
> USB-specific functions and ops to clearly separate them from common or
> DP-related logic.
> 
> This is a preparatory cleanup to enable USB + DP dual mode.
> 
> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-usbc.c | 50 ++++++++++++++++----------------
>  1 file changed, 25 insertions(+), 25 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

