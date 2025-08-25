Return-Path: <linux-kernel+bounces-785274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5481CB3486A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 19:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C3987B3A2C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 17:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18303019B3;
	Mon, 25 Aug 2025 17:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Mk8agO8O"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264A21D5CC9
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 17:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756142043; cv=none; b=MDyodkpM6vgKjUzDzz943CPuIVqt8ayB2kGDj+O3przwRoEnTcdRO2c8/D7URVs6k1LJPotqnOqNqXwDf83SbXRe7YpYtXSmctMTzzeLY3fnUmueeBiUvcbmNtvtzdi55gTuSf9YoPyhnYkMHhL69bAJ/6PHMRMHrS4xactcPyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756142043; c=relaxed/simple;
	bh=cjqN1QiUmQidH2i0o8JvlIeD8/Kks9qiMj3qly97v/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AsED7jXjdRN7Kmn47xevcEg6KYPLCjmyHTfp2p+Zgc/SmBtLVrrxi+g8R1K80YDhFFHkJ4OtO0JrRcS0yeQzBoZ+kJKVwgSDBwP2/aTHykvvCKd3rAS0/SOBOUgjf6MKgT74t27uchBkBAl92LOpnboRnkvZuw2ZHzb2HBkN3wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Mk8agO8O; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57PG9aln006049
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 17:13:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=7KZRtqKWnJbLSwQpwonaaONT
	oh9dnHVWnrg2acQzYvo=; b=Mk8agO8O4C2cyO+k9l7Xj0Eov1Gkf4uCPjuPRQSM
	4wQ6fsbjA/YpiVyRM8YA/ObGP8v2DaDKOjLcdm0yfOwhCC31FgHCcCD5HitKkhay
	vIuQ0Mb013VlU6lCNuJvVMH1tR2sbQAOn3BHCvKKjLs5/wVdfy/Ns+YqlnAE7rdm
	mE9MK91Y1t/PRgwMNhPuZwHR7TFdI2L6cV/jzJlIfF72naZvrVFatNoA2YPok41w
	fc1NEGOOqiqtdFFe/7f+YCKDKd+5HqE0hIBMukLyEt56/EHYikvNlHB46tdfICQ8
	66GtpfCd20l8YHMVnQsoSCDKyKx9AnuNUzcQ6r2A2r+coA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q6thwwf8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 17:13:59 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70d9eb2e970so87495336d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 10:13:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756142038; x=1756746838;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7KZRtqKWnJbLSwQpwonaaONToh9dnHVWnrg2acQzYvo=;
        b=mEkFxRZngh2gOgsR9GusWZm3pe/VtpOBxfOf3R58Wv7pKJPrVi+/qgbBOe0COxFrKF
         CTp8Gqe8Cf7w9UjKU1BL1Jq3+NFS8Y9+4g913M1kRj4CTcuELmbyesk3sHl/9qaPJ8t8
         QFRtr4ur+Vrvkax+nxpaZZro4Vgi1SrAuN94Kz1fhX1s648psecT8Wwb1tBrHAqlbO5v
         +tEnyqhPaJRAG0S4QsQUGFuamuzfGKPQhG+xfr+67tD2RDKScZ4ZSEEebvv4+FcvT9dK
         BeZo63n/c4k4Uct0aRNnQ0GeHlvIWOhDLbxQC9+VAKTPX0xb9ieAGCtUrQhPCqwo3Hll
         a85g==
X-Forwarded-Encrypted: i=1; AJvYcCWraeqkkla2yadcZWglEklCT1hyTvVSOy6xWLC6eezeZv0Ch8j+w7WSA/LeXSY5TQdtZDZ9Y6I/UKSgmXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGHLPfrCkcJ41Xavx92B+WJbGHJJYYOWeisrTO2LqIWs/Wacdp
	Ekr0m1+KRX7swIIBBuvtj5JhcNKBfwqkg1ZBuH26OZcU6py34t9L7VXDO+Jim9nghmrnzBb4L/W
	tzvh7nmIkDRJ/7LYwua4QW8qpd4LPEID9ACUFUL7oCqnGeBkvF04+YBzLkuA6LbY3E48=
X-Gm-Gg: ASbGncs9owzbl1t8ayBR4n2p6MiwXQD3sKLeuGVk5m8MRhvEEzAHpHnbUiRjp4ZsxUs
	gMQBq2qnx4pwIHmkSZaVkgmaaNbztH5A2y2o/wKyk00wZRVfy8W5X/oo5D+mpJKcaVNuXpHMF6d
	NEiaJz+BBG1zqyOkF138qkUXbrRSb/uMimInv7/f5t95HUpVnEVCcv+1w6Xztvy8vBILpIJK/zJ
	uWZK2Hy5OCTL1HV/q7FyrIYxgUquS9YS3m5C3eHJJvcxl9QfEsOI3vRwdFrHZa1i7qfzLxDmzUM
	RYgJShl4ZRfevk+VFEWTVtd5tkyK2h3qouG/eH+k0O0zNGD4lDSYJiDhTPyx9CVwnxR32pc18gA
	xNjM5zsiQhPYzWLAmV6MpetSFb5nR3A1T49iPNuTsN+S2F+Fzb79h
X-Received: by 2002:a05:6214:d8c:b0:70d:6df4:1b0f with SMTP id 6a1803df08f44-70d973bae47mr165335756d6.61.1756142037835;
        Mon, 25 Aug 2025 10:13:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdj+FFZ2fiH2yMSwN4KYEuhBhcuKZOiJBSCzLyu+64VlJ0OHTuoJtak8qkNW7VvT0uU7U8+g==
X-Received: by 2002:a05:6214:d8c:b0:70d:6df4:1b0f with SMTP id 6a1803df08f44-70d973bae47mr165335226d6.61.1756142037066;
        Mon, 25 Aug 2025 10:13:57 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3365e5d1b1asm17681701fa.50.2025.08.25.10.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 10:13:56 -0700 (PDT)
Date: Mon, 25 Aug 2025 20:13:54 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: Re: [PATCH v3 03/38] drm/msm/dp: break up dp_display_enable into two
 parts
Message-ID: <xwvuajrm76flwhnciclz3bxzj6vmvladm4t73mr2pyrblczi6e@wbyq3x2yabrk>
References: <20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com>
 <20250825-msm-dp-mst-v3-3-01faacfcdedd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825-msm-dp-mst-v3-3-01faacfcdedd@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDA0MyBTYWx0ZWRfX29q5MEyuVWC9
 Naj8Gu0amf4OVwp8uguAZSYuGnAfqlKfyYXUs4zfMPkSJPFTa3wVQJlNx6/H+mAXAkYqUBQ4Cri
 2F4fbb2G7Wu90+eI9zlEKcMXTzmY95ZxkGUpmhwvdKb77kIY19x50GAJtG9FdxxykVIswAtenng
 OBvwj+4M5xJVtLpv1S8k31k6uN17x+zDcpMaf4aa6B5rK+VR0QDZ+Gqcj4dVi2F4Zn3s3TDPqUC
 rVHq1GMSeLRtNdf5U/OHLx5kn9fQjSGt/vCV41YCC+O24E6uYVF3a/OZTqZvqFbOmwqu6KAjcw6
 fFw7MiKFyRn/yl+cW2KZcPJ7L/phcAFBJLNBaU5W+SmS0O/Ef0qpGU9RW7BLgJCSf1TITMUx+mo
 w9fyo1GJ
X-Proofpoint-ORIG-GUID: wtF6FJy6IZpoBf9DFl54M0ANW9bNbehN
X-Proofpoint-GUID: wtF6FJy6IZpoBf9DFl54M0ANW9bNbehN
X-Authority-Analysis: v=2.4 cv=W544VQWk c=1 sm=1 tr=0 ts=68ac99d7 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=ryBzyUWMAq7bL-B5d80A:9
 a=CjuIK1q_8ugA:10 a=OIgjcC2v60KrkQgK7BGD:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_08,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230043

On Mon, Aug 25, 2025 at 10:15:49PM +0800, Yongxing Mou wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> dp_display_enable() currently re-trains the link if needed and then
> enables the pixel clock, programs the controller to start sending the
> pixel stream. Split these two parts into prepare/enable APIs, to support
> MST bridges_enable insert the MST payloads funcs between enable
> stream_clks and program register.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c    |  51 ++++++++++------
>  drivers/gpu/drm/msm/dp/dp_ctrl.h    |   3 +-
>  drivers/gpu/drm/msm/dp/dp_display.c | 113 ++++++++++++++++++++++++------------
>  drivers/gpu/drm/msm/dp/dp_display.h |   1 +
>  4 files changed, 113 insertions(+), 55 deletions(-)
> 
>  void msm_dp_bridge_mode_set(struct drm_bridge *drm_bridge,
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
> index 60094061c1029bc7a06ffaa80d9403b40aa07eb1..2fbf16f27842bb7639efaa2baecac7bdf8908432 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.h
> +++ b/drivers/gpu/drm/msm/dp/dp_display.h
> @@ -20,6 +20,7 @@ struct msm_dp {
>  	bool link_ready;
>  	bool audio_enabled;
>  	bool power_on;
> +	bool prepared;

Why do you need this? The msm_dp_display_prepare() function can only be
called from within the atomic_enable() callback, which is not supposed
to fail and which is always called in pairs with the atomic_disable()
callback.

>  	unsigned int connector_type;
>  	bool is_edp;
>  	bool internal_hpd;
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

