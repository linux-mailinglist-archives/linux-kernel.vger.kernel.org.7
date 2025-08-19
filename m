Return-Path: <linux-kernel+bounces-775583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 921E1B2C0D1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 396A9178190
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C425832275C;
	Tue, 19 Aug 2025 11:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FLm3RxZ8"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29C627A12D
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 11:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755603873; cv=none; b=F2tOqRC9+7aur4XbZCwsZkfY8VX6S7S9GPRJCgY4q1g6hHEXUYMhrgAUD+xnSmMrIJY7OWd13YFtO3jDkUVgUJd1b3oXbNRa6EvSrgK/VTsg9ZJD1kswMTUkIN1PV5YsN9TZ/yB3ahogVT0FXREixQGNVrMadsyq+z7mXZdgGIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755603873; c=relaxed/simple;
	bh=Zea5ljBd6XshKIFWKGdfW1rTw6x2L14SIAqoCkfBcsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V/aNokOztYoWVybxDPEAvv1V9Yd7UKZsLbQQRKQDVDnICStWWKYjmncMQy8X+lmYv+Z6pAQSDmj9oacfUYq4Fq7mhX1Q6IKJ64qK0d4HBYJCNLy6LG4lmDH77tk4l+gHxbOOT+V5nDNwhIly/v5wkVsnJX6lMvVthnk71LWZ2w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FLm3RxZ8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57J90dJk032436
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 11:44:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=t+IK/PazK4gmkqL94P8OwZrz
	YQaHpy0GRokgzbSriT0=; b=FLm3RxZ8JlEsTtL2P8CZMPQqteKc8VpeL4J3rZq4
	iz+hxSr7W5LBCbT2UI7P9xrdb3my/00MsSz19+VSDZI2MGMrCbNEfMFRcRMFQ3wF
	i8O5S48WyqOJUfcj8VNWDAESLXwb/baCvpdcSSOi0sWB/TbpNM78PpLbnZMnHFj8
	Vv96TSYbKM+9yrOuleNorJpUwONeHfZxtBPMJbOg+TlCCUQlu+LuYeayHJQszzzS
	i7SOcgC9U+Q/1SeTVHJ2XiYmVrjBzpKbJcz+cpibyevRjfTsRZRTsE2ffsRI4gZu
	ywj6jXrTQFeABm+p1xq3FHSlvtCJlyLZSA2KXChff0ljxA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jj2ugdr6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 11:44:30 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b109affec8so149586811cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 04:44:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755603870; x=1756208670;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t+IK/PazK4gmkqL94P8OwZrzYQaHpy0GRokgzbSriT0=;
        b=D4eZLSgHv56IsHLaS68/9K9Cev2IZsMqyVMEI41Zmism7ZvDgCbHXOsLtck1RHoG1s
         tjyep5AAeTH4MXbVRSJhHJmU1+woLtOQmL2C8hbtlhyNKyCVGS5z/9HwvVP8hPTCtTu6
         pC1LnfUeJZMbbvXBQOkSDBusWQrDJPHyYXxmI+kmJMUhuPzQk/In4T3en25bVVjXqTW6
         WSrNytObXA1F/cRClRo8OVw/uhdcMTwzJJZm1XK7YoHC/qtx68258XKFioymqsGgcuj5
         qLCc18IeiLRmV8XfDoz5vvJDby0Ssvgfkt/kGOXzW4v6XwJAiWK+oK1QGXqkiG/ZU/IK
         GaZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDG5eXRD0NAjqdklXXVgsa13c7/oMhtpmfjcDIVjHLCxuoh6WXPKwrvXAvbS9+2Fo0ngK7Qc/ayr8kWUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzkPBDNJXWfY/0Fs+IBG/nPNbMFzzVI4czF5P3KUYQjIJNibH2
	Ybi1t54bczLQ5NYv+LHbMadiLTQJCkXUAyOtmVkU4TwH1/3EqZm8hL0Nw9Mr4JSZVcuQ59FhI7H
	sxhxRgewmU/mXam5++el4IHEM5C+sEuorr8YpqHFJM66CiPZ5YvMyYhdiVw8IM6bVqow=
X-Gm-Gg: ASbGncs2S0hJ4hScFTvKrnZXwUOPygJaaGVzkFBDQkVoooxW2H07mxqSqoSJJgJ2/sa
	U6rKhkIAUIWX1ilA+sVfbYdI2xtAfBGExQasxSG3X4a9SoIjHn//7usvntk8CKjL0IgCkQ5flwj
	9SMBArp8B0Rs/mihEoE0WGRG3iQ0FPFYnWd8+rFMgPz7TmEmcrTNUIyqNpz+l5XpWYEwtmygfdZ
	A8cFbl1+wz+WZn1mhcys91WVtqYaTizq2jEzbSC95vciDZgNLljExNIVKrWL7YE2D4pZJFq1zQa
	3CNWR0PaRHO6gW/jU6gFA9qHQiXt5duzHRLJfXG90hkSebK7SmWcJya73auK7kurBWuZOKCCBn0
	WAsS++BEbB96qebvZq5ORSMb+ARWctI91jw3pLVCf61S5x/PiI0Kq
X-Received: by 2002:a05:622a:1a9c:b0:4b0:699c:6083 with SMTP id d75a77b69052e-4b286eb8fa5mr20491001cf.54.1755603869721;
        Tue, 19 Aug 2025 04:44:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcjjGf0YmdQDLA+f53MBcfPsM3Y7DcIQachNiyj5czwadbiyRfo7iRyUgewgc90wLBYBktsg==
X-Received: by 2002:a05:622a:1a9c:b0:4b0:699c:6083 with SMTP id d75a77b69052e-4b286eb8fa5mr20490741cf.54.1755603869221;
        Tue, 19 Aug 2025 04:44:29 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cf4d0d472sm1491778e87.48.2025.08.19.04.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 04:44:28 -0700 (PDT)
Date: Tue, 19 Aug 2025 14:44:26 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Sibi Sankar <quic_sibis@quicinc.com>, Abel Vesa <abel.vesa@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Konrad Dybcio <konradybcio@kernel.org>
Subject: Re: [PATCH 1/3] remoteproc: qcom_q6v5: Avoid disabling handover IRQ
 twice
Message-ID: <czaabkgp3aerp7fntqnpwgilipnum5vmdwwrkem5mugcs7vvd3@q2mwq6ijfbmt>
References: <20250819-rproc-qcom-q6v5-fixes-v1-0-de92198f23c7@linaro.org>
 <20250819-rproc-qcom-q6v5-fixes-v1-1-de92198f23c7@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819-rproc-qcom-q6v5-fixes-v1-1-de92198f23c7@linaro.org>
X-Authority-Analysis: v=2.4 cv=MJ9gmNZl c=1 sm=1 tr=0 ts=68a4639e cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=NkVUA5Dj0ueqCG6wnC0A:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: N_iPM60USmMIrnsL9nilSldO7V296yRG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAzMSBTYWx0ZWRfXwtdiZiKNFDfH
 Buj7MARbmUtoVy2F34Kgj8LWswPYRQtqcM+Sinv4i0ruYlAGWIEwKB6I0+2pBTv8RvH1EFarv8q
 ZuAI/+sv9KWVA+A/Nlv+6LXaNoDQeIQzntfM4GWklSgW6l4N1f4egiDKWxYFeeL7iFyZ/e7XhbK
 BUC+dcSDUqyjQnQ0onCorbTRXX1ZMFvV1T1wI1GN6vVCCnWUrr0NTZKiMA077/+FraKli3xrgSt
 sEJ1ThaHVXeWzeMQ3qoRwMIefYV5vR67lg/I1n/KuRtjrX9zsb61R59U7g8QyIu72S94XSllCsj
 FcvSA9TELuPgyW/FY9ZkuY5jttFu7rdI3V4g3OKqpDbt4tfeG6nqxyourHJFyEAXnFBppcmAUQk
 QkpUYXVA
X-Proofpoint-GUID: N_iPM60USmMIrnsL9nilSldO7V296yRG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160031

On Tue, Aug 19, 2025 at 01:08:02PM +0200, Stephan Gerhold wrote:
> enable_irq() and disable_irq() are reference counted, so we must make sure
> that each enable_irq() is always paired with a single disable_irq(). If we
> call disable_irq() twice followed by just a single enable_irq(), the IRQ
> will remain disabled forever.
> 
> For the error handling path in qcom_q6v5_wait_for_start(), disable_irq()
> will end up being called twice, because disable_irq() also happens in
> qcom_q6v5_unprepare() when rolling back the call to qcom_q6v5_prepare().
> 
> Fix this by dropping disable_irq() in qcom_q6v5_wait_for_start(). Since
> qcom_q6v5_prepare() is the function that calls enable_irq(), it makes more
> sense to have the rollback handled always by qcom_q6v5_unprepare().
> 
> Fixes: 3b415c8fb263 ("remoteproc: q6v5: Extract common resource handling")

Didn't earlier versions also have the same behaviour?

> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> ---
>  drivers/remoteproc/qcom_q6v5.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5.c b/drivers/remoteproc/qcom_q6v5.c
> index 4ee5e67a9f03f5f766f04396b9a3e45f77293764..769c6d6d6a731672eca9f960b05c68f6d4d77af2 100644
> --- a/drivers/remoteproc/qcom_q6v5.c
> +++ b/drivers/remoteproc/qcom_q6v5.c
> @@ -156,9 +156,6 @@ int qcom_q6v5_wait_for_start(struct qcom_q6v5 *q6v5, int timeout)
>  	int ret;
>  
>  	ret = wait_for_completion_timeout(&q6v5->start_done, timeout);
> -	if (!ret)
> -		disable_irq(q6v5->handover_irq);
> -
>  	return !ret ? -ETIMEDOUT : 0;
>  }
>  EXPORT_SYMBOL_GPL(qcom_q6v5_wait_for_start);
> 
> -- 
> 2.50.1
> 

-- 
With best wishes
Dmitry

