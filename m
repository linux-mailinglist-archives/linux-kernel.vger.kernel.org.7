Return-Path: <linux-kernel+bounces-743110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A92DBB0FAB4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 21:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B02D94E5BE4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 19:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F709221DB7;
	Wed, 23 Jul 2025 19:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l1hsHUTr"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF572153F1
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 19:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753297514; cv=none; b=XzeK2IKOYAF5LIwuE60Y+LI7yI26egnGV/gJhSjBNutu45XkqeFcbVvgjbsIonEEnHDlABV0ZzPeEmSjfpBfLpxScERU4b3L6nr72HTf767KW0cflm+tzc05Oc+iQo1DIkmqOtygsEJT9nod453+xAtcS2fvUo2X9xFH9uRTGvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753297514; c=relaxed/simple;
	bh=yuRgU9ho4OYuBDxZyBu1mHslN88EoGKlcfGO9z9njaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IcQPgX4AxQPh6MZKGBcufJcOeFanYLrQCXGLITUVzLRYIgRGtYMdYjEYWnNv6G6aOWmDBr03Y1tIzKUQOcKbkkYsL5JsuIMLOWwBb163LfjjOhXHa9Vt20MVbwSoZbI8cD2L2wLlohUmbPsrHlgPNRrk0QpKH+lmZji8yXBAkDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l1hsHUTr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NGnXxu003506
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 19:05:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=LlwxGzbxOFLE6tNUdLnrCDcI
	n1YFSoVX4yc5JSgu4+8=; b=l1hsHUTrgTE7qd/eAxzIIAPPwarGjdXcx56NN52j
	F+j9zlJ6VRNZp825RrlRrIUojTEpFyP6CU8DHN3zQj9uhORUL9BRsCaPaGL5OQwg
	Zzat7JfrFHTsTWFHXhub+YhJWBF1s0tOXv6vkP9YIST3k/Aulb06J2NhkND3lg5k
	1Ttuwtd1HB+WuEYWXcwjGJSxatj+yu7GnHQfeaPBGwGApIttVhUPQ/hElc+DnSL0
	sktYR5LPlavblOMiiRdz4Xvkq5+mkNq229iK8Ux4j1Qgeow4CKqGcy3yo0IBDvc7
	Lbjo9VLg3MAVDp2AgV/+NRwpvbybNozyDgyLdZ6KFSVjoQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4826t1dks4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 19:05:05 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e2e8a90a90so33947085a.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 12:05:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753297505; x=1753902305;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LlwxGzbxOFLE6tNUdLnrCDcIn1YFSoVX4yc5JSgu4+8=;
        b=GtqfZ7QkB3sCr+rOTdHm2z+klNY4dGvKFQ7hqup9aRXK5V7oFB9DCm3lVQ0iKHlbDb
         m+3hGmDq2GgOvGYYPfbm7YKiOr+t18yGGJRb7HxDVqi7apIioWE2LY8gzrke7iTp9b6N
         QdymrIyex6cjNmJBavRWiqJ9UBxEBSgNM1ZLvn6lROGffufal0R2rmNd1ikkjoczNWuk
         1W1ub1QJaAB/fAMgCYH3SaeWpsVLPnqi68T2ynaAMmgxIGYEILw+nkJsHB/b9BvE8R8Z
         xXu/dGImw+udHXdkF3kcvLCiC707VIvARhJTQue8e3YCV4g1cl8UWyjtH+bMmVIQbX4G
         ayxw==
X-Forwarded-Encrypted: i=1; AJvYcCVMX1qs4idpNFZWg/kVkxrt/8flB4x2pjXkxLm87KpqpPe800d9btHUlHOYpAFCGiDe0Nf1KxeotlrFVdc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEgmaylnMsQ1yzWt4CkkmobXvMFonEwElF3pqkFizIM0hBaL+M
	H1PKyBULcpnpuJXWBgRM73qX81kJNNij3pK2c4qu73SwOxAkCQVzwgukMSzF/+cwa5PLDVKWGXQ
	XJCoAzO6so27BTfma2c0h2G+u60g5HQVbwaKOuSvlysAkbO125rYRXK7scZVmA/qpov4=
X-Gm-Gg: ASbGncsHYdgIS8nBqxL9xktzGFHMxdK8N1W0zvh7EC1KU0JsDQOtcR0XKRgWhzWTtqC
	3r64tD2AZSqv5QoUHdnAtL4P06I3icD60vgRDqVRwcOyUoYCIcSehf6tlumLYC/zjzNVJkSitBV
	mnXpjCpqwDYyazdtlyRRE0zFadD1esHRqkpMXSWFzsRYzOWRMSsfZau2tt7wAGXbYpHL9UTWyN2
	Gn2+SEtd0UEE9Oe06XwQG+mSH5/WTPXe1GtDVK3KHnDCN+/svCl8ve8yFjjsjtde7d8GPtY2pfQ
	/u8oAe90LSHgRkBzz9Yz2HUlibLI4OqLNNZJAPTTJ3c802MV4j4AzgQv1YYs+ATZ1WHNg+w6ZxB
	D8XnzXGWxxt58sBpb/PjwOQrZlbFK6vh+TfV0Lk10IRzkcNTPyO8J
X-Received: by 2002:a05:620a:a201:b0:7d3:f883:6047 with SMTP id af79cd13be357-7e62a19e6bdmr438161585a.51.1753297504550;
        Wed, 23 Jul 2025 12:05:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVikEHzskkn5r6WHCg2DXMAwpPQxlleG1dXDP5Na0HIBh6BhiLe+Oy1cOXXzmZ/m6sol52RQ==
X-Received: by 2002:a05:620a:a201:b0:7d3:f883:6047 with SMTP id af79cd13be357-7e62a19e6bdmr438155485a.51.1753297503926;
        Wed, 23 Jul 2025 12:05:03 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a4e0338casm527398e87.190.2025.07.23.12.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 12:05:03 -0700 (PDT)
Date: Wed, 23 Jul 2025 22:05:00 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Chenyuan Yang <chenyuan0y@gmail.com>
Cc: robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
        jessica.zhang@oss.qualcomm.com, sean@poorly.run,
        marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch,
        tglx@linutronix.de, krzysztof.kozlowski@linaro.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dpu: Add a null ptr check for
 dpu_encoder_needs_modeset
Message-ID: <ciawdvjevycjjuowmykfux2v25lvr66kzey4jklq7t5cjzqalj@qfcva77k2bvr>
References: <20250722211740.3697191-1-chenyuan0y@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722211740.3697191-1-chenyuan0y@gmail.com>
X-Proofpoint-GUID: 4MLpV-UferEd8Z-RXSGnyB4V6Y5Wthv-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDE2MSBTYWx0ZWRfX8/NOHD74V9r2
 sOCSZ2Zz3juf1koO9ZA2tfuxcIkYnHUcQB8YHYAgnO5LSakDXUMIWooXZXhXQLHDm7//rCuEX2U
 fs4FkjkyL9ouFQwK8v/EYo34AwnNHVHkrbCfaY1uiU7rsWuMcdowq5X9KNMwO2hvpL3BdZONgbR
 3AI2+n5f2HYIq4NOdkYAlMLId7bl+fC2n0/rURPeV+3CBjSRxxzzT2pzm2oPdcWxOoAzNFWG871
 Ak7rT2k7YaRtwTGVi7FbxY6cJe/FDG6282TDIeuATz41jIvGIiI4sHqpclioZG7ZdOsH4rMm3Iq
 3o28KIa00aqSePwg3XgIya7cDxmncdYbtLIVhIWyyD6WLE790s7IIH80JGvTGUktv8FGmgemlx4
 rwsiopzn0Ut/ZBu+DooPBK60fV/PmaDYND9evv00d/ttwDkdLtA0ojudB4/TBVDruJMF3ea7
X-Authority-Analysis: v=2.4 cv=E8/Npbdl c=1 sm=1 tr=0 ts=68813261 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=pGLkceISAAAA:8 a=_XfERVBWgaszTNbD_PYA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: 4MLpV-UferEd8Z-RXSGnyB4V6Y5Wthv-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_03,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015 phishscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230161

On Tue, Jul 22, 2025 at 04:17:40PM -0500, Chenyuan Yang wrote:
> The drm_atomic_get_new_connector_state() can return NULL if the
> connector is not part of the atomic state. Add a check to prevent
> a NULL pointer dereference.
> 
> This follows the same pattern used in dpu_encoder_update_topology()
> within the same file, which checks for NULL before using conn_state.
> 
> Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
> Fixes: 1ce69c265a53 ("drm/msm/dpu: move resource allocation to CRTC")
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> index c0ed110a7d30..4bddb9504796 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> @@ -729,6 +729,8 @@ bool dpu_encoder_needs_modeset(struct drm_encoder *drm_enc, struct drm_atomic_st
>  		return false;
>  
>  	conn_state = drm_atomic_get_new_connector_state(state, connector);
> +	if (!conn_state)
> +		return false;

Did this happen in a real case or is it just
yet-another-static-analysys?

>  
>  	/**
>  	 * These checks are duplicated from dpu_encoder_update_topology() since
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

