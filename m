Return-Path: <linux-kernel+bounces-815939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9005FB56D3A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 02:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5EC0189995F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 00:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D518318B0A;
	Mon, 15 Sep 2025 00:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SUOFF4XN"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54041F5E6
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 00:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757895258; cv=none; b=e8RiODLrIQnaqfLimkV275UcME0vlWlPSoaYfv+dRUfU/vO8ukj+cCzHFiCZ125dm482+wugWAspKyyzyXGtOWAoI5ex/qfLOHAEYJgogYx9KQza4JcoHOIHQ8U5//txvxDTX5FMpeMBtCEnWCV6xx/yqtE+Zj9iGzNlBeDnInA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757895258; c=relaxed/simple;
	bh=WC79OzZ3VedAq9lMgsTQbFWH55VqwdungFuaBpz3XX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CUnhkf/qLbaOXm9463MguAbClzt2N98/jjvw9FAxMWsL+0kK6U4m5p8tNFnck0nw43BqGISNSMbOicb2HafBmL/z86YhLEycgDeqhTXrvArCbGz4iZxHK5jam5ETcrKsssjnzfKwWDevyFTm+4LAWUqRJhm+rmD6kJBS/s3/Qac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SUOFF4XN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58EMULIY009635
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 00:14:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=wfIfmtGDU0fMWPSXfBq3QGPr
	RejWAR38abE4jrrVyJ4=; b=SUOFF4XNRO46ay3UYMsN/RFX10KQxXKyoxTnQuXZ
	jFJzdaDG7YKTMEn9DWCJWxVSXROJy/EXK3NdO04I9mcIXSc+Yh/oybm+zoM+ge5X
	gi4fhfdHiD1oKn3jHPCZVjcbVhwM3M+b5O/K2xeAn5ptq4erGu7d/KduI3Oth0WJ
	+B805Q8T8Djcm8Rj4Ww2v9PMeN3VK6fe56aORWjK90imQIePdZ9NFJr4nuelu3MG
	rhecpEnLlhZspV/JJp+w/R9551cQIuSaCTbO+YqVOXuJrhx273m369UH0Fdvprq4
	MlL1BYxYnMQndpZgj3CiU5DnpjQx81xZnY8MOt7Q2TsqqQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 494yxkayq6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 00:14:15 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-767e5b2a74fso27625586d6.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 17:14:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757895255; x=1758500055;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wfIfmtGDU0fMWPSXfBq3QGPrRejWAR38abE4jrrVyJ4=;
        b=NT5yPwyh+Q4YkkV6vdHvzyyGTy3JQr6rwndX7lRfHAHp198GMd7gvyQ4WHrCj4dcnF
         vDIErpJ6bgeuaMijQXbL7RFwYNepLvNcmt5GxxvXl5oXZvvjF5v/5O5Vwvmz6ObG7VRd
         4AF4FGXXUWkZfCLKOK1w7YdxJZtoJxwZ3jj3OxMoUgGzFHACvyB1rjRezh8JKLaubrpv
         3k6nyrtT5ZI6kxBu0mcqcoBohjH2I9xSoOjIk636VgeIQNX7q7b/ygULZlg73Qb2D1ar
         9/2mnSY7xW+B2qWJQGO3UaUFQHLjPkTWxRAhPxjspIpzt5ByOkclB6ga/7R+4c3jWvpt
         XJlg==
X-Forwarded-Encrypted: i=1; AJvYcCUyvkV/+s8U9SVOEAgCaM8C/2F34rkVC82Dsn7mkCeNeTAPFxIE4kkcNMImWCAw0aJdnjqbkK7ts1lVwcg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj9vynkQO3sxI+6ZEa77JRdX8qmBI2kfx3R+nazk1kQNDfCzcf
	BwyQyQEMo7k8gpYNmC2ktbq7qjBE9gBXQZpvPrFyxHhi/IWaNFlbzWex38nhdwiW5+REP7bDdhd
	gr+3PW/Q860Q5Gy7z+jLbvKFB8h92DUOMBVf6ofjoQdezS3FbIYikOv8/tJwOido22vc=
X-Gm-Gg: ASbGncvOREAn9koXWn9g5eQ3JmUGEwZGEQVrxDzvOEMjdwvyFh5N0VH69gdz0TMAhuJ
	x3xOix2ni1YS9ct9jYQHLQ6z64K2g/9ixq9QIYrVD8kHZWtcT2WEhkCAaiGvrvbVUAB2zQ6d2tZ
	1ORz73WpNnaAvqnCZNjnx5B+mnjS80yOAgMwaHxV4S0Z+ZE/g13QZGfBNJ9sD3qfu9M7/bT7O38
	+GdXTdV3PPAPa/CMKXf509VmJLbRRWphuIac4BjmWfB7vXbBL2JqZT0nmI/M0M/xfCx/Qf+AYBu
	epO8wU6QcyN+G4i4TPa1trdfnLUqz2Tot6Z6c4NirlESE8Agi7JKtpNxo8+he1KUNa0gDCaQq1j
	hIyK2ebUjeU+Hha0YMVFdhW/EJsTamNjiVH8owIWx/gi/UXYAYcjO
X-Received: by 2002:a05:6214:268e:b0:70d:cabf:470d with SMTP id 6a1803df08f44-762262daa1cmr182241996d6.27.1757895254730;
        Sun, 14 Sep 2025 17:14:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHObBFwIlp3GQ+VOBYwejw1PxkvVAwhDilkZbOEooVdFxkX7Rq1AOhro4RGokvljow6YU9iPw==
X-Received: by 2002:a05:6214:268e:b0:70d:cabf:470d with SMTP id 6a1803df08f44-762262daa1cmr182241606d6.27.1757895254257;
        Sun, 14 Sep 2025 17:14:14 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e5c692daesm3255202e87.26.2025.09.14.17.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 17:14:13 -0700 (PDT)
Date: Mon, 15 Sep 2025 03:14:11 +0300
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
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org,
        linux-stm32@st-md-mailman.stormreply.com, linux-sunxi@lists.linux.dev,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v2 0/9] drm: convert from clk round_rate() to
 determine_rate()
Message-ID: <pdodeksqchby7gtr7oukm7wqleu535kzh2g3uaseqmkxv5g7qx@jvh5fcppvutm>
References: <20250811-drm-clk-round-rate-v2-0-4a91ccf239cf@redhat.com>
 <aMawQYUIjPw9m4IO@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMawQYUIjPw9m4IO@redhat.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAyMiBTYWx0ZWRfX49HHrnBcCEg5
 QPC1oHXoh7ryLLEeZIPHO6i4jKeaWcmV/VDfYj9IN+qrwUq34P+y+QEJQiYJpX7IxS6IP630IqV
 P/3onRMTpbLRSTQ0F7akjw9fqmb1nO6gAHZJ5oq4oM1ntDGIxvQLaU62lnxX/a5X6fiAK+h6Pwf
 j3Htjf81qxxiwAWUP2+L3zdAlf0tarEI3xceOUKS3fxCIKiK4SlBhcyikSE6GGHnUwIXTb0xN5P
 aRJCYgMp0uLbA1b/2zAJZ13JCDRDP7pJmO4xscD16ZBWCMgwwbd+4rMXFMsXbrt8q3SLd/pYWit
 Yo4pqKFT5FCAfno5WKLFIiqCU9OqYQ4vzO5Xq+2a0CqEMYhEcodepkSVAafynxpXafE/q2Tieml
 i5h8c8Ly
X-Proofpoint-ORIG-GUID: 7ZBLu5u35kelFCyuWDIqcrFfq_CMcR2J
X-Authority-Analysis: v=2.4 cv=KfjSsRYD c=1 sm=1 tr=0 ts=68c75a57 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=ErCwDgQeR7lfzThPobAA:9 a=CjuIK1q_8ugA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: 7ZBLu5u35kelFCyuWDIqcrFfq_CMcR2J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-14_08,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509130022

On Sun, Sep 14, 2025 at 08:08:33AM -0400, Brian Masney wrote:
> Hi all,
> 
> On Mon, Aug 11, 2025 at 06:56:04AM -0400, Brian Masney wrote:
> > The round_rate() clk ops is deprecated in the clk framework in favor
> > of the determine_rate() clk ops, so let's go ahead and convert the
> > drivers in the drm subsystem using the Coccinelle semantic patch
> > posted below. I did a few minor cosmetic cleanups of the code in a
> > few cases.
> > 
> > Changes since v1:
> > - Drop space after the cast (Maxime)
> > - Added various Acked-by and Reviewed-by tags
> 
> Would it be possible to get this picked up for v6.18? I'd like to remove
> this API from drivers/clk in v6.19.
> 
> I'm not sure which tree(s) this should go through. All of the patches
> except patch 1 have at least one Acked-by or Reviewed-by.

Patches 3, 4 were merged through the msm tree.

> 
> Thanks,
> 
> Brian
> 

-- 
With best wishes
Dmitry

