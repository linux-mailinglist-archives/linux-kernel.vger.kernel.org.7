Return-Path: <linux-kernel+bounces-827995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A237B93A34
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 01:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD85019052E4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 23:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11292DEA6F;
	Mon, 22 Sep 2025 23:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RsOPHmQd"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796E5296BBB
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 23:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758585037; cv=none; b=eNxzdhTNyz+0DZUQw7FcGm+MTyz3eGy1rNopjywgmx855gR8WddmQaF0Gl7G6siFRfy2bXcvBR47vRFR7THs1mBnTfDGwiTLRVRaBTUfPV06Mz4cEvPE/AWO+g8WQcJUOMDf4XA39GzTRzlyiA6/Jj44S/UkDDLzoUN917gjuPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758585037; c=relaxed/simple;
	bh=+eQG3Ga4/T2VozUewF1Au5/Jh3XqjTII/FxJPKybY0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CbJyEuQuDZRJsqh1kb3N0uj0Kp3USM73wVdgeaUzUtHMloLDJklBWSW01jglWTiqiahUmfMXKVNv9x9A10N4k5eomwvDfc5hGBbXaTP8oEQNcc9JIl8V1NOwPEk0JbYKtyi1SQpKtZXYBon3T5moMDugiUO3/qIVEAkmB9AWJrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RsOPHmQd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58MH68j6027923
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 23:50:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=akMAt+oUQPKktf6eCkzkJKDk
	y5jxsD9+xpwyL5NmVEo=; b=RsOPHmQdKbQ3dBaKvEywzLEP+FiPkKnG3iD4rNA4
	OIWMW57/5T42PZ7wMGPXSNSjQ4GRdI9T2kZeIbOas3NxKhb6RhAieuW3NKJKRrs0
	qFa7w0HOMc1f6g6DY8+HKvOVXMxyBYvuhKPhQEzOL5Wrb9Qi1Hb7+JQGpBZpnSO/
	kAri0Q2HXXQkg6F3TRzjQBpFSftZMF4VrnfoXpPdn+w7BRF8ielQCAErj2ZkgPx4
	l088QfuGTuEDub7g1i2pVXsYZp/apHuxYuzWl/9VHYu/09B1HI+X98xOBoUQX4C4
	MmM/JJAZrwTSD9sRYpB22vgcFoXHjlErEtsntgYh77u4Tw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bajerynn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 23:50:29 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-726a649957dso96416506d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 16:50:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758585028; x=1759189828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=akMAt+oUQPKktf6eCkzkJKDky5jxsD9+xpwyL5NmVEo=;
        b=D4gRtKiBtBJjK04VHInrPrXv0vq+skwH7Hk30d6UgH/xk036Tl2wXU9ZLfD9Fy32lu
         upsB6RxXlc7o/LCwSdthGoocKJqC01viSGK5r40b5tpw+oxXM23koNkfuMmq67AjXWAl
         XYh0HCN2i0Ztmxylztz6ydnMTq0SSl0iZgZHXXq92Oe5acivR7fQARknPCr9wKl5XdqM
         s9gKe0VhN6J5+p6k2UXAo5GV36XBoVlJJux65Um6O+4AP3Zh2ByQj1cyXnGz8Zp5eBIS
         DnrJaWL2NDqd9w/GES7Q7NJ4cc/mCofLiNa6gv+ov0M7DQ4jmeQMjE4CgMt2kptOYVEP
         hFfw==
X-Forwarded-Encrypted: i=1; AJvYcCVTOjUkEBXD660XP2MofuNS3k94Kfb4HNqCq/MDvrJNVySzbXwNv4Nk8vf204lnf8MruDE3XnWt2lPapuM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBbaLzRgg6Ar4YMX/4wBHi6YRZYjIoDWYo7j/k3z4ttyhpBtPs
	EwW4fg9DYr4bRvvspaMQEY/uCEs9MmJ5gQv4VKhqwPlE2eCB4qbynPs0tp/ExeMQeMfZTZPnfvQ
	lG59o1XOdSZkH2k1Klug9lJbjadzvYNhS+XoDIWDC2qtYvAqcog+OKKXmZIDFYOsKZ6Y=
X-Gm-Gg: ASbGncuycU/YjTu7vRXV0PyB6CEdh/b/LPq0AEMDob/QzwGCvFieoTNMXIoudG2rqan
	Nr2vYJZ7Pxd2Z+3b8Hpmf7evdc+YleBl8hWIWQGGi/dgBqeSIORkPTzukIyqzb3xiFk9kEtLCt2
	G+LuHNEQwYdDAFkNsFFhPyVEJrKk8vx6A/LI5DGssB6MqWn2r3SmDUfzRhP7W5D1IE4PSOkWF5a
	scUqZGXalDdhvXkMoJi12BEHNAEGk3EYdIp8+nDEQTZNjNc1Zh68TGOAgQoSL4hdJwl/BOGJyv5
	7TkuLV21a/cOAkAQCRISEZu84t5iRSJJ+9os4zOXQ2Apl548fR+rrhoT8TDDlA2HhkSOadZmvnK
	vSZgHEtDoNoEQVLMCQ9RE3/V717hG83nBTq2n3SHjjrVk0iiVNOTK
X-Received: by 2002:a05:6214:1c0c:b0:782:1086:f659 with SMTP id 6a1803df08f44-7e707846c97mr7811296d6.26.1758585028059;
        Mon, 22 Sep 2025 16:50:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8SQsuqffPmbCFgiG+W9BrKws9UQB4tVnyo8wnkCaikEbrcZDprsLMa2pYefWv8Aef414ssQ==
X-Received: by 2002:a05:6214:1c0c:b0:782:1086:f659 with SMTP id 6a1803df08f44-7e707846c97mr7811116d6.26.1758585027602;
        Mon, 22 Sep 2025 16:50:27 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-57b5da082b0sm2121692e87.54.2025.09.22.16.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 16:50:26 -0700 (PDT)
Date: Tue, 23 Sep 2025 02:50:25 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abel.vesa@linaro.org>
Subject: Re: [PATCH] drm/msm/dpu: Don't adjust mode clock if 3d merge is
 supported
Message-ID: <cjoxzwkvzjv7pqelcxcepafanauxjt7p5b3qevjdr5bsomifce@i67l2hzavctj>
References: <20250922-modeclk-fix-v1-1-a9b8faec74f8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922-modeclk-fix-v1-1-a9b8faec74f8@oss.qualcomm.com>
X-Proofpoint-GUID: rHNfwq7eBo0N483xYz-qltgv5GJTnUr3
X-Authority-Analysis: v=2.4 cv=fY2ty1QF c=1 sm=1 tr=0 ts=68d1e0c5 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=Gz_hOIZ2IhTx4crym2oA:9
 a=CjuIK1q_8ugA:10 a=pJ04lnu7RYOZP9TFuWaZ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDE2OCBTYWx0ZWRfX8caOyHunLTxl
 fS8HGeTbSkjnqs9VeSgfvjTqUpgwrGj1Qdb5CROZ/KBmrx9rRGLwIBIuyIDRQ4GHQppLm4PwoDu
 dgzhfTLsmQy9JlX5hkzLoCDhl7skp4RCJA5ShaCm77HcoBJowvIx6NAaFvPmV6LshgsDBoc7PlM
 8+ul5W5YSH6NZpcjGTTdDPH9GSJp7iydZBmwZVk5XQIo8Hq6M9hKkjT1ytVpDu4p716AN6t7vk6
 vsi6YeY16EZ8KSFF0iVvt3/SfQOfNRy6F6s2mX+j7v0UWW9YPgjCiydAGhH6oqKOqu7QiCiIqxW
 Fkrn2yfqfr55Flsx01WxmCxwyJ8dksNJq/LvL3N6VlOqA+GbBZthujQWUP25NMIFL82CCZIU9Qt
 kbfyelQP
X-Proofpoint-ORIG-GUID: rHNfwq7eBo0N483xYz-qltgv5GJTnUr3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_05,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220168

On Mon, Sep 22, 2025 at 04:32:39PM -0700, Jessica Zhang wrote:
> Since 3D merge allows for higher mode clocks to be supported across
> multiple layer mixers, filter modes based on adjusted mode clocks
> only if 3D merge isn't supported.
> 
> Reported-by: Abel Vesa <abel.vesa@linaro.org>
> Fixes: 62b7d6835288 ("drm/msm/dpu: Filter modes based on adjusted mode clock")
> Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> index 4b970a59deaf..5ac51863a189 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> @@ -1549,7 +1549,8 @@ static enum drm_mode_status dpu_crtc_mode_valid(struct drm_crtc *crtc,
>  	 * The given mode, adjusted for the perf clock factor, should not exceed
>  	 * the max core clock rate
>  	 */
> -	if (dpu_kms->perf.max_core_clk_rate < adjusted_mode_clk * 1000)
> +	if (!dpu_kms->catalog->caps->has_3d_merge &&

Well, not quite. If 3D merge is available, we should allow 2x of the
clock, instead of skipping the check completely. I don't think that we
should allow 8k or 16k just because the platform has 3D Mux.

> +	    dpu_kms->perf.max_core_clk_rate < adjusted_mode_clk * 1000)
>  		return MODE_CLOCK_HIGH;
>  
>  	/*
> 
> ---
> base-commit: b5bad77e1e3c7249e4c0c88f98477e1ee7669b63
> change-id: 20250922-modeclk-fix-a870375d9960
> 
> Best regards,
> --  
> Jessica Zhang <jessica.zhang@oss.qualcomm.com>
> 

-- 
With best wishes
Dmitry

