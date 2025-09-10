Return-Path: <linux-kernel+bounces-810908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20020B5215F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 21:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2D0A563BDA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 19:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631AB28CF52;
	Wed, 10 Sep 2025 19:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oAWVem7L"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA7226F289
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 19:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757533632; cv=none; b=kxnemfRZDkKbDRxTHLPxCWbnB64CbkYjScSeo8rxeRzbK6bwmsN+4PIeyy0aNOzD2uEryABC3BpG8p8CTlBoPSxxXfENJ4uh8cWbczF7thpdSEcJY/JSiS/X94A+aODApKCQ7RELl4ovUorI/NQ557Y3nFVhRyzmGMdd80D6fx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757533632; c=relaxed/simple;
	bh=arXJ99FEtVlUyZcOJU0ADHhqC2hh3/FlYeg8g8sOrQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cVCcVGyImt1haP5ZfcOmKBStfUR0bUtRHrD7e+VGJWDHEv49o7BgWR9xL0UThf2pET5WCvIKUyUCQWAvjmpbSl3hYrV8F1UQXJAJM6WlbyYmcFgaxrdH181BL+joFhk4Xb1yxnfqsrO2SLUh7AeUUQRKXXzmfreyV1WtJEfdMAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oAWVem7L; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ACgXDd013799
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 19:47:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5XSyilMow2vsdCL5NWrpdmYD5R/cfL4yovE1XWW+4Bw=; b=oAWVem7LqKomNZNd
	9Gzb1TpJYmZvI6vdbrVFFukkowNwwd7gzUigmzgefFIFFvWHIzxbut7u0EzIL2DK
	V5ICK+qYJkBN4kp0XK7WwYd7J68A6o7TRq7PTvSMyFzi/greCpt/XumiokjXEX2Z
	elzyPYRW7IvEIAb3qt18vYYEwmmPXEPdx+guGr8jo6HKWamA+ghy9FiZWSejQbyS
	aGNqZ3pKPNHyo+/rEips7AsBYaT9gGRXnOQlEGxE0o5JplN7YceTpF6l2Y38WF1V
	IxsqYXZ6bCouuaxfzNbawrXQwOHjucBanCppde3YsLD1Irtef1gXjnFCfyBbjqjG
	tdAHBQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490e8ad2ap-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 19:47:10 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b5f75c17a3so300511cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 12:47:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757533629; x=1758138429;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5XSyilMow2vsdCL5NWrpdmYD5R/cfL4yovE1XWW+4Bw=;
        b=tMjvW4ulHVWOGkwJqb143n1u7Mk2cdifLCI5Cacf56D7/smo/kqoGvB2cD8M5VulO6
         XjgFZmlgyVuppsf5oHMA1VXsOqxdvu/ajlSvs31dP5E3Dc8nNJr7hpXyXWjgp/2twS+7
         YtZRiVXZ4YsKi846+H1EhBuAlt1p7YNM9thlgkwvbxv8DkEcM2oUbS75qIlC0SGllsY7
         tILxoIWDirRtixdm9JvD/FEC9uwVIFt7kldY6MoWYBs2weqj5V/vrVW0DHmtxKbtwDVr
         a3U8O4e/mnY9xqNh+CcJCKYWk+7nFjUZemuSna323qIg+D6OvrBCqwVyYhQlv6N8a0Ah
         U45g==
X-Forwarded-Encrypted: i=1; AJvYcCXElQ79HcWqpvbGN+nIpjPlzFqIHr7RMndhurcha5Fnv7MScvIisaP0734VUJliMjCKSrwVaHuyNvqRR8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwewSjR+CQMmgX2YEgtoD/+xfdyd18zCoTPpCCe32VQWIG51UYC
	3mVzDMUt2j6IirNRtuEKbdLAcZ61t/L+rzDDtqgA7iXMq6vSsN82lTd6yAOwCvH2U7T4uwDOfLl
	GASpyXVndnveZmCB5WIv03FNeLFUEtOUKx7nnquTw+vYCRH1wwwV/ri3Dzix3W/V9NMc=
X-Gm-Gg: ASbGncvXK4qTedGpw7U0FbEV7dTPAl6yNxhf5QN9sfOT2pcEu7fBQXcEuvZqcPwTzAz
	eIFDjxrxXRQUza0dH9MGFtay2y0nzcHeSmSTtfbUUroJeDxG7cyjBMuNc4r0ez3YvPlO+m7wl2Q
	0vHOLyrHRN7RTwnXpF6wGFgHf2+uATrkIsvnsHDJ1rkyqgJ62+lm+nVJPu+MHQgbnUvPp/XE1fe
	2QS42qmBkBlJ0u8ZagMfnowkDmiIgqTlUQjt0mZcD18UjZy86o+J7iG0w6iCwKv9jJJ45imoJH1
	ZLzOSdkMibvh/Wd2VVG+9AvKfMq8A/0y+scULlSrBStkUG34Car+qqJxAsocXEaA1bJSaYQPbyq
	j7HmQOQtCHV4+MidsIrWzh99PnMQDofD2rexpx40OItaLjpzGOGpG
X-Received: by 2002:ac8:5f14:0:b0:4b3:50b0:d7f with SMTP id d75a77b69052e-4b5f8464d8amr166081191cf.61.1757533629367;
        Wed, 10 Sep 2025 12:47:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8wquYMa19XEyPw/QfhleXZDPv465xQ6dUWPMr0z2Sj2aWYLvr2qI9QQ8LGJkWNi7M4zEUYw==
X-Received: by 2002:ac8:5f14:0:b0:4b3:50b0:d7f with SMTP id d75a77b69052e-4b5f8464d8amr166080581cf.61.1757533628861;
        Wed, 10 Sep 2025 12:47:08 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-337f50d3354sm44101601fa.68.2025.09.10.12.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 12:47:06 -0700 (PDT)
Date: Wed, 10 Sep 2025 22:47:03 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Matthias Kaehlcke <mka@chromium.org>, Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] drm/panel: visionox-rm69299: Add backlight support
Message-ID: <e2xzrkocmv5qtiuquccdmph3j56iezzerslyi4csazcwgmtjkp@ft2h667uhccz>
References: <20250910-shift6mq-panel-v3-0-a7729911afb9@sigxcpu.org>
 <20250910-shift6mq-panel-v3-3-a7729911afb9@sigxcpu.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250910-shift6mq-panel-v3-3-a7729911afb9@sigxcpu.org>
X-Authority-Analysis: v=2.4 cv=H7Dbw/Yi c=1 sm=1 tr=0 ts=68c1d5be cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=ze386MxoAAAA:8 a=EUspDBNiAAAA:8
 a=UV-YmP5_J7MdQozCVrMA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22 a=iBZjaW-pnkserzjvUTHh:22
X-Proofpoint-GUID: OmoRa_E4roiU5HBTYg4LDIVj7F9RqnNE
X-Proofpoint-ORIG-GUID: OmoRa_E4roiU5HBTYg4LDIVj7F9RqnNE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzOSBTYWx0ZWRfX6G9dHpTVGCjs
 kK1WHTicrNFynmUEKxE2YMXkThx37I6t8T2y6lcJV3HCKhrwIAxRY30IZV2ztv98e2TBRj7wT3p
 N4Wf7MDYnlhL9489Ntr/x57pKqz1E5hOPvhhfR3LUs+1PXatVQyYwwbFsDp6Xh98/6xKwDKYy4W
 RHWfIuTgv0QXx3wGl4iz/kXZmeFDip5GthFTAD//8MdO+US+j3wucxT1tH79SguFVEMhTtTNhay
 /NNxEAbE4gK04QzBk19FncLPSOSWc4wCLAwhkUhi9YqUKasRdFaoj/mX9xX6FOPB+GxVrX1c4Ep
 7cxSZnzXU7OWEXecJB2i3okbHmW5X3In5nb5/gH6NsjiH/YQHwQbOclnAlWzwy6cUVJaq/MSmTz
 3jWwbEbt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060039

On Wed, Sep 10, 2025 at 06:39:58PM +0200, Guido Günther wrote:
> The shift6mq's variant supports controlling the backlight via DSI
> commands. Use that if a max_brightness is set in the device specific
> data.
> 
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> ---
>  drivers/gpu/drm/panel/panel-visionox-rm69299.c | 67 ++++++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

