Return-Path: <linux-kernel+bounces-732123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87890B06262
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 17:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F32E188AA95
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 15:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4917B2066CE;
	Tue, 15 Jul 2025 15:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kms4CHhK"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4064F2036E9
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 15:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752592067; cv=none; b=mnKDjcQQbGPtZNLkAuQMj8IS3MNvvfeC50OXB99Jlsm2xRpHUZb2g1DF7AhOvIKobxKW/75s6eo7sz77kbWhWg5sj1UZhyBW/XE2yqQRB/uOShiWLE+pZ5EqGTTV2F0BOCIwrR4PoDnQ+Jm1en+48Ne+rbLxCAf485M6I955m3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752592067; c=relaxed/simple;
	bh=nw3fUOy4Dyo7OtTrgCRJLRfNiAZiw2FkoPy8uKRJufI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lvYJGruBans2zS/wLgsUn78pcLp4iQtLE4qadU1TkbcsCd3CyMqiR+At25UoQGy06TBDIC0Xrhf4Z0MlYm5QctZM1QasX0MZvbhCrHvkGUDFPbJWXdKHjPcUzUXuYDOL+9vN657d0iUMAjYq7e8SsJ5sC3RjL3RPn9HD/kszZbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kms4CHhK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F7hYiR026465
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 15:07:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=UFE3yd+yxu1P9RbRQyZIroNt
	ei5T0YAfVddPN3zIsz4=; b=kms4CHhKguztPZrh6aMbRBtnl6d9uGu4uOFm50lw
	iMEm3Hk1vAypjt53Ce3yleNqozyM/XTTCxr+e4G/uDCfYHbXQAg9h5hQNPK9y3I2
	udYhwnexMqZsF9/inyxAfUZ76hBWYT3td4TY3OazGAs+vHQuinCcwiorjzrk+l0g
	1Za2lALAmOj85o6c8rScrhk/vR+IhdCd7eBxxr3eg9cgxubjapge0iJaHFWolH36
	PYJa/KbYNYKjmbLO0zdUTqedsIENjxR/LKLsuUc3U4b4zj/FX1nbUJwrZnhLZ3fE
	bV+7Tw6R8Bs9zY0xs7ikJuxKj8mBvjo/d/+R4DU3M38Xdg==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufut8k97-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 15:07:44 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-73e5bd263f8so569354a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 08:07:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752592064; x=1753196864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UFE3yd+yxu1P9RbRQyZIroNtei5T0YAfVddPN3zIsz4=;
        b=Uh+caGN3qOjjnMx0ML3UoZeEqxbQcivhUALozx7ysX+Y2GGmwiiSpi3aDgi3XGMsnv
         CVuNWGM8ERo+1Bw2C1bc6Z9Cz7ql0jvyJcvmWkNp0OVB5ctTQZn5xojGQ+gq0RCpv/yd
         izDqzPajc6tcA76rCxZxM3bhkQTEzSiSwJl/iGJlyyvN7N20VLn8HZ+/bRh9ChypyEBb
         jaiwN537PTNL82od445aibnpqpmGZgGoGoD9EPJL+0y2MnyBqDQY2zg+xO0M4km0Rn0l
         RNK9UEx//xH0uAexs2pipH+EevnaEX5mL1Y/QbgBReVrRWJcUAfvefwk7/+hJOsMB/3B
         AKJA==
X-Forwarded-Encrypted: i=1; AJvYcCWXZmhpswmD+hfkdN5fFUqsGw6hbm3HGzh6tzS/uAP/SAelrQM5TUYiXjZcJjAkqXcYHCersy9fWaAPljE=@vger.kernel.org
X-Gm-Message-State: AOJu0YygAJjkVEUk+qvsLAA1Tue9alyoKN6/gtAQvnqZdP/lA5RAcgXV
	HQZabmFjHYsu2hmAwfi2kAESfKUh61STWZpJLEGmVBaBporU1toio/mMhbnFNJSyUDl4rLNG15l
	C3b1ES2LkvisK1gvwJt0iyHi3H3/ueQdaIkyIXCf0fbak1uyWjV8yZ/1ueqTk5wLsqZQ=
X-Gm-Gg: ASbGncudYUxTCKQu2J4ucAfaFBl+k5lwswqmsQ8mNopViIOVocsKIGRusINrJpKyig1
	iCVtKX+5TFtx1kvcbI3wXmongvom7lvVCDw+SljnN2hAhZ/DPsbVDt7O4dFZ7FTapyML0HZMy4P
	w7toWd9HMxCe/4foEsmadNn0e+Lv+ghnzOAyUWCZmUO780K5QPn6m6LP8Vd/s7mJmrkx1R9SX2i
	8MEEfDFrshPZC1a41OOhCuohQQEjwlRM1aL8MD0eWiaYaHEyjyK3CZ6O5B0XI2dq+SJtXRdgtg+
	v3b9ThhnjncEzDkeLumo9YXqOWLrqJTExG8zPiRx5pNfgAA3fk7f5hNdpFZnl27AZibdYMI7eiJ
	0BAAUE2lQu7SVK++BTm1+i2jrMcRiVQLw8rdUoUAZRVZH3CK7YWCR
X-Received: by 2002:a05:6870:5b96:b0:2ff:8f89:950d with SMTP id 586e51a60fabf-2ff8f899b18mr3018672fac.11.1752592063800;
        Tue, 15 Jul 2025 08:07:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzt/a91mT3BodYIFDMVy8jVt1HoRKIa+1bUOyQbH9aZS0Ib97nHGb4Ty6uV5H10BORptHD0g==
X-Received: by 2002:a05:6870:5b96:b0:2ff:8f89:950d with SMTP id 586e51a60fabf-2ff8f899b18mr3018555fac.11.1752592062451;
        Tue, 15 Jul 2025 08:07:42 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5593c9d092csm2317122e87.114.2025.07.15.08.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 08:07:41 -0700 (PDT)
Date: Tue, 15 Jul 2025 18:07:39 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Brian Masney <bmasney@redhat.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Yannick Fertre <yannick.fertre@foss.st.com>,
        Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        Philippe Cornu <philippe.cornu@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>, Stephen Boyd <sboyd@kernel.org>,
        dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org,
        linux-stm32@st-md-mailman.stormreply.com, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 4/9] drm/msm/hdmi_pll_8960: convert from round_rate() to
 determine_rate()
Message-ID: <qk4v2znryznnvg2vcye2m7taurfhoozjjdtye3fmk4fgawm5jq@2qlqgg4htfnl>
References: <20250710-drm-clk-round-rate-v1-0-601b9ea384c3@redhat.com>
 <20250710-drm-clk-round-rate-v1-4-601b9ea384c3@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710-drm-clk-round-rate-v1-4-601b9ea384c3@redhat.com>
X-Authority-Analysis: v=2.4 cv=e7gGSbp/ c=1 sm=1 tr=0 ts=68766ec0 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=oBXrOfH6mq4iYN50PBoA:9
 a=CjuIK1q_8ugA:10 a=eYe2g0i6gJ5uXG_o6N4q:22
X-Proofpoint-GUID: F7FDaMWE24ZBUwETiyeRSDIRlpprLgaJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDEzOSBTYWx0ZWRfX9GIA6TBP1JrR
 MwAFIgG2giiZkXGJCgylcW+C1JewuN2JGz48h4nSXX4Uw+KSckwNEAmUqJB0slNV6/kWsCTwjth
 0rIsmFt0JapIzvNyAuT2Kk3ro3Hyrp8xEBWFxhOdbNke1qOsPmQeqNwDQ2KRSZb92qx/fTDmd8A
 y80TdznSZIvOpDH0ezmGXZuX9pUcZhDmg0wP5+a0yG72H96/ttG+s2egWdvbAKuMZrK896SWR9b
 IrI6/TADhd+Yv/fHEIekd4DWb42JFk7k3zjEHHXOfsbxr5jzd4iR36E/2OErFlueO+2NXoGIq8s
 0rUVzSEO8VSujC2ADZ0LXzfraRHUJx6VjkWYWN2nsSyZbKmYbrt9SBOiwVhHaF8LE5aLK5uEJ8u
 61p7ATETt0gC/t0PJxbLayI7ckGMnpVhi5Z9vWj+YnzQQdPbtkWUZ1CmoUxUuUivwl2WKAb5
X-Proofpoint-ORIG-GUID: F7FDaMWE24ZBUwETiyeRSDIRlpprLgaJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_04,2025-07-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 spamscore=0 suspectscore=0
 phishscore=0 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0
 malwarescore=0 mlxlogscore=830 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507150139

On Thu, Jul 10, 2025 at 01:43:05PM -0400, Brian Masney wrote:
> The round_rate() clk ops is deprecated, so migrate this driver from
> round_rate() to determine_rate() using the Coccinelle semantic patch
> on the cover letter of this series.
> 
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> ---
>  drivers/gpu/drm/msm/hdmi/hdmi_pll_8960.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 

Acked-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Please take this via the drm-misc tree (I assume the rest is going to be
merged that way).

-- 
With best wishes
Dmitry

