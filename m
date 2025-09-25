Return-Path: <linux-kernel+bounces-833219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E184BBA1729
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 23:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CB36627ACA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 21:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F4121ADA7;
	Thu, 25 Sep 2025 21:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M0VOHOhW"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF39261B75
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 21:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758834024; cv=none; b=Pe5BhHzX+Xa1pRlrPpaHVB5RqOZOaywlsVgrPJTAUgMnLbg7Ot4EHQSbg00o7YiwiNYLgHvmbujJezBFKtKtADVdCpMp7vxp/FaPQKuuKGp3s7fEf9sIC1WyR+HTMWMI15u82JwDDHG0/fI0va+DdPGVL159ZfGKubMKNXqDmqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758834024; c=relaxed/simple;
	bh=T4iNv5cr2miRA9ws/Q/OPuwuH/G+wg5LNI8CS99kHMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CvBd8afzwIWbk4+1XbN6aNxOeVu0Q73gZ2am1HR8LdOGRemb/gFMiKO+CHa2zRHW2BhbOy+sKMpYHYwmpSlvGp9y9N/4Xotemj1k+SsHyNWxVsLHmebYXvwVjQhf1MzzZN+FZ7xNOTz/71i0sD4yl69fFyHZiDBJzHbVClg70DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M0VOHOhW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PIQXiR005410
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 21:00:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=J0Sf/sBWadKXsMJGTZZ12sEI
	LrsGXuVR6yrh2onEh/I=; b=M0VOHOhWE/Cx9fVGigWqZ3bYbPn0y1apqtVbeGMd
	lnrnbt8IQaVzwyMIw+itSBFXgJJ0XYnavQSHF/Vrmd8aqExIL/6rW03dZcfulQAv
	f23oJXiTbEI3W3VbDrBT2G8PPgXwNxKUnHTKLKkRJaFW0qaaGaLy0q07AM/rMH8e
	/eOeSiWuZQzRBwm4cR8yqWqHOaOrVleQ753l8Fe7BYKuA9X73d1EoPp8iIUX64hz
	zQ7M8Wirx4vT94oRenIRmOUOH0Gf0FW92p6lC3XgoUv6f/IENciZXOnJy2rK9cfV
	vD5fNIxK8JDKaxVBuSw0AjB4L9KPJQTmo+N2xxTZAT/pwg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db0u0dbv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 21:00:18 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4d77ae03937so39246521cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 14:00:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758834007; x=1759438807;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J0Sf/sBWadKXsMJGTZZ12sEILrsGXuVR6yrh2onEh/I=;
        b=PkAzojQxthchcRPkVPp6m2liPt8ibhd8VAU2JxyGcRGRWoXgHDzVNhRN0rIMPYbafL
         FRNE58EZpss8gWQajddH1NN6TfMLDBUr/BKOTyIaCuG2NvhOOCi+0CuB5BGnSB4OPqh+
         W3Iq273DDQlXYLQuBnLwhA5PRDBXd7Kz92gxJSJbn2NVjn9zdEpccQ4Ur1SWiKiCmWsz
         9YYH6XsOYp/hRItDTbVE6A/dcB+ecTXBYeIgr5xM31eFABBzJ0LFpfqVG7TU0pzqOUTe
         wTuCT9YTaJ6WNZAJsZdOtniEWv4sjduvdxjNQpVMoxn3NbyTWKMl0Sqnd0amSoto1Kde
         0idQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdarYUisjwB01gdktVlvO+Y5EvIQ3omoyDDDt9I9SSbZ6Fv9f/bZZxW8E5uQT9+pJKmGJoPYhPgusFBnE=@vger.kernel.org
X-Gm-Message-State: AOJu0YztqyfYbd5VPPXMQ4H8482O8Xv0tF2/EGyP9+L4SxIBM9Syp58q
	aGkWLfA0+w/Ll3wNY6CLzRD3H0RiGctII9ojMBBZp6dBgV9C7jlZZLwQj7cR0u2xT3WNjKQVuOJ
	O/V8MfSS9Zm8NQ14URbfGO6t4krLs1wk6wrXoK8B8pywlkSYc3jx57oEG/wOgiUof++w=
X-Gm-Gg: ASbGncuK3uwI7jtuIl4iCu7aSd6IEzSkkff/dEiq9OFomRKKg9mtYIuAZ7djf2c4Qts
	pLfMHYe1/tjNhrVmfyAJwkVEHdPtJBu5FV4kKO3jqa/Lc4rdNuQ3g0r4NVy8Em1weYCj6H1Ys25
	UbctNi7cjh/eTseeBl9W9VH67a0lyz3F/d2ydn6vxVRCE/6U2HhsJ5gGYa3IGER/Ph8LlNhjtHz
	ctJXLyBDoxViuwdKvkfXKJ622jMIddhIj9sbE1S60UTXgvsDCKzCXAHOhWJhmnTzF7Tvn0+kdTq
	1tEL4IW0t1Ix19FivxcvyfS+vFV1b86ffFXX4AVCnm+p6F9qtvJ/htIesrAhi8XYLkeMeLXiLUd
	hDYuzaTRujx/9/v2/hO/qYT6KuZONJ3JCogu+VEq+3IkNF6G8MDsr
X-Received: by 2002:a05:622a:a94a:20b0:4db:16f6:9049 with SMTP id d75a77b69052e-4db16f69d23mr37264681cf.70.1758834006838;
        Thu, 25 Sep 2025 14:00:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSqyJMyZZeC0SdYv6VOMpLT31YAW82OV1CV5+LhKhpeDE/XPG6jushTLuxUA1OesOxbqQQ/g==
X-Received: by 2002:a05:622a:a94a:20b0:4db:16f6:9049 with SMTP id d75a77b69052e-4db16f69d23mr37264331cf.70.1758834006373;
        Thu, 25 Sep 2025 14:00:06 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58313dd66fesm1110678e87.54.2025.09.25.14.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 14:00:05 -0700 (PDT)
Date: Fri, 26 Sep 2025 00:00:03 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: david@ixit.cz
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
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
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        phone-devel@vger.kernel.org
Subject: Re: [PATCH 7/8] drm/panel: samsung-sofef00: Invert reset gpio
 polarity
Message-ID: <anrdocs56hbunj7ga573kopcol34pw5cklrwneqevpfhhlm2bc@qvih2y7vm7q7>
References: <20250925-s6e3fc2x01-v1-0-9293016768f7@ixit.cz>
 <20250925-s6e3fc2x01-v1-7-9293016768f7@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925-s6e3fc2x01-v1-7-9293016768f7@ixit.cz>
X-Proofpoint-GUID: gfBpfzkNH2HNx2IVjKivzU10SFneqiOq
X-Authority-Analysis: v=2.4 cv=PYXyRyhd c=1 sm=1 tr=0 ts=68d5ad62 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=RX7N6JFfHuZ5v-HjQggA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfX91lyKs3xbLL5
 Iexxbno6XXqwWf/+AcJL+K5ZeThoEGr9ez6Q2lOnnFRCwyg7pxZY2FAvKIhbxmkHM3E5XSFfL0a
 NY5AAFn1qpNNqv8T9JuW/Tz02zX2FIcaaqB9pRs5Z8nrtVrjKTwUZaJ2yWZfuxRj8t9vKfgPulS
 nAziPK0DK2eHVCseNU4sSjWEPW71U6oyHaunX330GLrpBV4y3LJ5IcAQMstI+Ff4uQkxjDYTIIk
 Zv6c5Z8Q5UX2lEjyUmauD31x20R5/0h2BZTAw9WA0uzFug9t8VBtZ9Ysb4Jb76HfQgdXGVRO6bU
 dd5dNPuiri0UQHDtBqibjntchBDcWLby7g3HuiNbNYWKZgL1HX5hCsJQpCwdBGLACQBbn13S3fo
 OFLLnjPX0y14dWhlWGVcSg3axVY2yw==
X-Proofpoint-ORIG-GUID: gfBpfzkNH2HNx2IVjKivzU10SFneqiOq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_02,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250171

On Thu, Sep 25, 2025 at 11:12:53AM +0200, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> Follow the device-tree change for OnePlus 6/6T and invert the reset
> polarity in the driver.

Reset is usually active-low. On most of the boards it is described as
RESET#.

> 
> Fixes: 5933baa36e26 ("drm/panel/samsung-sofef00: Add panel for OnePlus 6/T devices")
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  drivers/gpu/drm/panel/panel-samsung-sofef00.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 

-- 
With best wishes
Dmitry

