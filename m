Return-Path: <linux-kernel+bounces-815985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E225B56DED
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 03:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B505189A261
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 01:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539152628C;
	Mon, 15 Sep 2025 01:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A7Xz1Hy9"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A11715E5DC
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 01:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757899985; cv=none; b=pzuHmeOoS6AIDF9smcjARUuCLeBjoqW9e8RJubHAgT2tQ3hEKRfdDQQNX6QxBCfKIPs5cyRyj+gst/4mID6fHzc6/pGMCkFn//v22EhjKdzXI8Np19erKHQYWJwL6vgLJxwRq8TUaf4yDaxZPeiHXFB/kyGrCEy4/izIwQEdpHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757899985; c=relaxed/simple;
	bh=pGghURsuwNu+ABkmeOsoDUpezMwBvSycgDQ5wCnks84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nQpWG1Yx4JaQCQqB46BDhyky+ibkXLHMt6Z9bMRc6SzVP+gzMmjCMgXMAdvpfkYaCXepsxMJRhJa0qqCIIgDUl60/IXbdLZCvVMQU+uFtGtsAcRWaS8/BjZG99354F/h87285+kQj9qA2Y58XXrYE8H2rpfUB9hk57pNXrJRzDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A7Xz1Hy9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58EMWaOM005607
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 01:33:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=1Zu1F6svkPbGpkL46fCjLAFj
	5Y4T5FtR/7zChYLiSmI=; b=A7Xz1Hy9Q1edkC5OOC5mDD+KfqH7NWsAg2rRtLxT
	Kl0Z8gJNdUV/QOtU5f2Ok68A1X3lt14MLnj2kHw6+Dgx2WnUgIakmBu2kvVrTcup
	bxqZUMNKoAiU+SpFtH0Viy/GoHuD1KUm6yEBrrcffN9tbmBXsaX/EtF7lkCW5Mnb
	cqL4sU2hRTZ+HSly8FuEXWopcNQdSL7Lg7Ncl+My2lXAqUlB+2n9QLu+uCHL7CyK
	yPtTU6RWOBc+o/L39soEUVQfgzfoQDFKYdsgnMkug9r52GqwouK0DoZ7cAi78B8b
	zTqYMoDzLoUCMlpyWc/GuLnjV4I/2lmw6Drjp92dmER0Ow==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4951chb0wp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 01:33:03 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b49715fdfbso133048341cf.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 18:33:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757899982; x=1758504782;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Zu1F6svkPbGpkL46fCjLAFj5Y4T5FtR/7zChYLiSmI=;
        b=TvwAZP6+BCxXYsKIvGhz8VufkfirDH4yynb7Hyh12LaiK3Q5QmnxGgO4wCeyn0jwPf
         jOHun0uchZs4B9+l2VDq+o90+KGX6QNkMujKhSf5SFiBzXbug3OOd5MB97gpmZemUCCc
         DbljpetltrqvwmWBHdWTv1UaIyQ9n/N9SVchbHPLwCbfm4QUspZwEARsL1JV/N6wVoDw
         0q3XMqFibodmcwwJxqdzKZb7eaykn2aJVrxnEoFaNwn1JB9uHawe31BwnqevSGc08mmM
         kbZncQCndYcv3Zf1Q8yw7NM5oaTKsNSbiWYYMz6uyh4BBGJGZqCf/33Yrqv//Oo0OvJq
         AsLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiv886GF6qxSpbYgFaX8mH4lF5bjRO2LqefYaBwQ0Wai465N5Ho2/fo69PYU9325dumLxct3qy3jeXp5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdaGT9Cn8kWUMFYt3FqpfaGT92ALpQiIGnAJhz1qEBmqkInNxF
	H+j8RhDi0QSD2KuP+Lo2Px3th2OWzmMrKiVvm3qB8eQ/17jfuN1L+UXSOuQl+46/lwE7xEij/PB
	S+65hfZ7fynv45E9GV2+vgxS1Vou/bB4OuvZYiT8Q1qIYZBgOkMeREjytS5FATl5z1Zk=
X-Gm-Gg: ASbGncv3h0p+Vxxqn+l+mjXAe5w0LGlMtcqEMxOxi7dZ/k9Oj5oMOvWLUuPshzfrha3
	J6P7CvA8PNfey+KODy3b/dUrJXPRbZ6AJNkPIXfErEBdIdxWin4Wv17+PgpjMXohtvTzsM/Jd3p
	JUfGz0YjgAphgAtdI84sxjUj3UXFCHNK2QkRNDV7tDK5Yt7twOoSc4SPqW0dQoQz4+CxeU1wWKb
	z4Vx8MBDgV8MU6ZEEnIu61R6A3YQiMgFy/UpFNq2bVIK5D9mME5+LKm9h5VjWGlTv4l/eAdTpfj
	+Xc+d8yBWId9gx8SE19+2+LiJP6kW2T0viLm80KoIwiYUoNH0uW0AWIYuvStw4XMlCQYGFOhZQE
	3+SauCmFjFM7JtaFmD9lPxsM9Kr8qmFfWlJa8mo+Sfnpr4jLRJ5Od
X-Received: by 2002:ac8:7e89:0:b0:4b4:96a8:f79c with SMTP id d75a77b69052e-4b77d12c8ebmr140170831cf.79.1757899981910;
        Sun, 14 Sep 2025 18:33:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGBvsRDgTKSkuwUsdqfubmsZj2hQouxrHcRhgR849mIt5XnK0aMWxJZ1JOLD8JxXV0ZmVt3Q==
X-Received: by 2002:ac8:7e89:0:b0:4b4:96a8:f79c with SMTP id d75a77b69052e-4b77d12c8ebmr140170421cf.79.1757899981448;
        Sun, 14 Sep 2025 18:33:01 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-571d16e79d0sm1964626e87.86.2025.09.14.18.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 18:32:59 -0700 (PDT)
Date: Mon, 15 Sep 2025 04:32:57 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Damon Ding <damon.ding@rock-chips.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        simona@ffwll.ch, dmitry.baryshkov@linaro.org, l.stach@pengutronix.de,
        dianders@chromium.org, m.szyprowski@samsung.com,
        andy.yan@rock-chips.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] drm/bridge: analogix_dp: Apply DP helper APIs to
 get adjusted voltages and pre-emphasises
Message-ID: <mxdaghfmr7fqt6ud6bhca72kewanaauhyuic6xl2izo6yp3r3y@6oytrsfxposs>
References: <20250911112756.4008435-1-damon.ding@rock-chips.com>
 <20250911112756.4008435-5-damon.ding@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911112756.4008435-5-damon.ding@rock-chips.com>
X-Authority-Analysis: v=2.4 cv=eeo9f6EH c=1 sm=1 tr=0 ts=68c76ccf cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=s8YR1HE3AAAA:8 a=hD80L64hAAAA:8 a=EUspDBNiAAAA:8
 a=u2CTiyuJROzRloHrWhUA:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-ORIG-GUID: -MBekhn16Zh50KDEDgd_YOzC1RUP02zH
X-Proofpoint-GUID: -MBekhn16Zh50KDEDgd_YOzC1RUP02zH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAzNiBTYWx0ZWRfX51o4XybF+jQq
 heIGdci60JLOksIW7zweO3uVmGaAjXbuODcrfkiYNFmWn30ycNgl6Ea87ZXgeGynnOSk8VyaGPa
 Jj3uyVIk1Z0saC3zJYYs5/gr0Z6v6oHpG/D+bTIJ9vNnTTMgwOKsdGo44nxK0Dh/KltlQZ7mXID
 UMkvB/Tj6v386CYpFcoixVKOoptnxC4AFQBKy5sM5LlKwi5EFInaVqPRmX/n/jaDRwmHOJVCd7R
 orbUjQ+RZ97MHq2ac/+JN4SJ2MayOkvqhp0BEaWayFLsO1NHAzIlJNll5zhtzwmR1E2Vr4M+s2y
 SPNGkJnWKjLEIXhs5QyntkY2sgwhlhbDDlmaCeZaj7Y4IWfWfCOibURrcjyWrs6P5P34YuISp8h
 omxxPm2M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-14_08,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 impostorscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130036

On Thu, Sep 11, 2025 at 07:27:56PM +0800, Damon Ding wrote:
> Replace analogix_dp_get_adjust_request_voltage() and
> analogix_dp_get_adjust_request_pre_emphasis() with existing DP helper
> APIs with the same function.
> 
> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  .../drm/bridge/analogix/analogix_dp_core.c    | 49 ++++---------------
>  1 file changed, 9 insertions(+), 40 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

