Return-Path: <linux-kernel+bounces-748531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E746BB1424E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 20:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 289AE17F68E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 18:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C91F276048;
	Mon, 28 Jul 2025 18:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pcFmvrzc"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A603D21FF36
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 18:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753729153; cv=none; b=QbcYAYiwZXgguth5U5cwDeyl2AW2kI5SmPZ6e1gMGVfbcTyzKZR2MELKx9AITkeDf3zMNYjK9SES0itEbhQlyaqlE2/V/RcuLvqjtSuPk8KjyfG0080ujR89wnCpGs+gS1uVcPT/u/3GUHe2XTnEwMQzoKUz9W3aLmEOrAhoHVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753729153; c=relaxed/simple;
	bh=IWpZoNGayIjThY9y6ABT29cNtcvfwrGLV6Mv5IWqx5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f1FihRK2vAB2Q42IcYk9rG23Hif6iIarmkmm8K5lBPqPrUXvcOpbSg6LN5+r8/OnQ8TuhmOlBX91tZUu7d1WUq5r9vZKx4AuDbPI/m2XpfybI45l46moR3mhyE0EA+L03Coiqsyq9WSgLhyX7GJvm3XDGPUGmmcVO+dwFE3FPi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pcFmvrzc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56SAlMJ8023457
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 18:59:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=g3b9mjC0DOS1TwNiZSFPS5aw
	kCSouvEfEECI0Xi46LI=; b=pcFmvrzckhuIL++xLIxfre8lNoQD6k+Ws3MV2M6w
	btcd6Titg9W1w/jUeebgyZbMIgfwYKc71Bk4rnApD8XY5EW56PdJbompNCwbJD6i
	7EJJFtNSbNprjMuS4Q4D1+uFs7lTCMbC4XEfoyKTyeCdskXzGVBU7WRjYpoBY+Ja
	SN0Kvz3cnFujCiq09UUWfWtxoUcdQODiGRdSJW11M7f9iWeef1BK4lwP24g4mlzc
	555Cn72oYPTQ2krMRu6FUoksgZWFWkquoVIClMOc4IjftpJe/tQsP7a79kW4XV8p
	iBmXxnTXff2Xo2YnHgUMWfqh5RrVhqlwsmZAlYSdeqOSoQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484r6qnhe1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 18:59:10 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70708748fbaso78583546d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 11:59:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753729149; x=1754333949;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g3b9mjC0DOS1TwNiZSFPS5awkCSouvEfEECI0Xi46LI=;
        b=M0zCwv7EPGlinjAAR9S6EwhgKio2p3DjtwTndqxNz+ZAggBW1tjGRWRKF5CLv8uUos
         nZJ5r3QNUaVh8XujevACrdV1DKD393Q8s2LQmLLU3bfW51T+guJLpDfJm7x16yJRE2/e
         vDITf632AZBBmhq9z1AgzNj8y5/ghRbnv4wGn+bNUSgyRlxUBYPAF+PFvXO2CQwfM+UF
         P1QpCG1jo2R2AICuae6jOYSeIvUXaSqz9ECzzh/6tCCRIQcILkXVrDoOo2DyOlFaySVH
         T/LiMV6lTuqrD2Q45mPo8Xb7etL/nSCm9PwaZMjy1MX4Sd9DV3DgbFaokO9lGvFgu6pJ
         EW9g==
X-Forwarded-Encrypted: i=1; AJvYcCViWdpNbiQyPw4YwWQCDeZKJ+TFaXrKQBdr0CDuu9lywzTzQDDaqAFiumm5BCD8AmjmAwOuw2l1Lg+xXmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfrOjTXdVswKlsIQ2aFzpV3RpbloeARHKjAfTDHhaeY8YYJ/LT
	fjBkjzg74w19XXXkE5QzYCJhlfodWGwDcc2xzHTTsPDDd8gFH4JfdvUnlM9j5RotrqEGZWTZE/h
	al4YRvc2hTW/9jHa28O5tJktDwvEcuDIddsLm+vFW+ipYr5qeMmzUf7Yo3yMj+FDdyU8=
X-Gm-Gg: ASbGncvfzGFc27PDSsXAsP7cFTO31TrtUs8ZZXc+fQhwrWN84XHqt484A9R5qB4lA1E
	9L3pHx8o6cEmwWB6UF1ZbwpHm4mXC9QFSwdUK8ciz1mBoeFSfVShHtlZtaJSh5OAcSa0DdUCil0
	ajAGpIuJwry7p5DU2p8KWZjcoUBZ6jLyfhVvluvAPWFgbt5PKE6RCikdRtoQ2MtVek11NGYtLJZ
	OnvCwXX0A+df/X98DCFi5ToCrOr42OXQ/PR6FmwrFqTwjLi9udobbCuqouB6gis4X/dneMs1ftV
	WD84aKxDV6WN4t5XuL6Psq3IMGIA+2xi3ao5OmV+sg5nL4GnKQG+USTm59xGcc1Va0oyuNubr/h
	nGg6wabv/L7cyB5pYxAPBid2AxpWLMsrsJEzbbwY/zNvcPiJ69NjQ
X-Received: by 2002:a05:6214:2261:b0:707:1b3c:4124 with SMTP id 6a1803df08f44-70720514bc6mr139815846d6.6.1753729148792;
        Mon, 28 Jul 2025 11:59:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeR/e5yy2Dmbqpj9B2szzZpphi7NqKMlFSMX2Qojm62xxZ84NsscDMGppFa+sWmqZGFGaQuQ==
X-Received: by 2002:a05:6214:2261:b0:707:1b3c:4124 with SMTP id 6a1803df08f44-70720514bc6mr139815506d6.6.1753729148113;
        Mon, 28 Jul 2025 11:59:08 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-331f4267695sm13324171fa.50.2025.07.28.11.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 11:59:07 -0700 (PDT)
Date: Mon, 28 Jul 2025 21:59:05 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Cc: Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Abel Vesa <abel.vesa@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Mahadevan <quic_mahap@quicinc.com>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Danila Tikhonov <danila@jiaxyga.com>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Yongxing Mou <quic_yongmou@quicinc.com>
Subject: Re: [PATCH] dt-bindings: display/msm: dp-controller: allow eDP for
 X1E8 and SA8775P
Message-ID: <kvnw3wkbn3jedfxryqdikef4db6ij4lobgj4qp4dgrpd3sliga@w6do67fiyhri>
References: <20250717-dp_mst_bindings-v3-0-72ce08285703@oss.qualcomm.com>
 <20250719091445.3126775-1-dmitry.baryshkov@oss.qualcomm.com>
 <8399dc75-6363-4ae1-98cc-59b5b62dc8b5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8399dc75-6363-4ae1-98cc-59b5b62dc8b5@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDEzNyBTYWx0ZWRfX2Aj/iUOfQ72r
 edDJiq+Bpln+cD7ujnePxidVlYbQm94scnGvc95YLp7Ju8FGzuVyLWV6e9C36iv8Q3092MBA61M
 eojev7479QHDGs0BayMD+2CMKPw9gStPmEJq8x5j6lXn6KTSSmBi1O7RzqZO53+zQN1NjkCxr5f
 HOJpw/VD/bagVIhJ7WhSZSQv7mi75/5m5EMTJ5GYVkVTC3SPNlpkjuDfOU2D9oOYJTSc/L2S1xR
 eBt2L37a/rsLg9QpM3bbhsmEHa8NY+cGPQWuYe89G0dp3VqSDkQN1sx6EtwZybGvTnirh7q9TTu
 lynefO7A5/bxuB2wjppw09JVkdWGS1U2kzgNUPzLs2GIG/rz+WYbCR/w5wNdUIhPc7ilrK247JQ
 pgZj3h+no7cyUpZwTrS2LPRHWutt9a0oe2r5zp6PFemNikv6zpJmzB+zpyZrnhrBY20TzH2N
X-Proofpoint-ORIG-GUID: 6v9a0Ss1z-0btaI4-i7NTkR-UPnUJWQX
X-Authority-Analysis: v=2.4 cv=ea89f6EH c=1 sm=1 tr=0 ts=6887c87e cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=_uIZQMxxb9QNBo7-lSMA:9 a=CjuIK1q_8ugA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: 6v9a0Ss1z-0btaI4-i7NTkR-UPnUJWQX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 adultscore=0 clxscore=1015
 spamscore=0 mlxlogscore=672 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507280137

On Mon, Jul 28, 2025 at 11:29:31AM -0700, Jessica Zhang wrote:
> 
> 
> On 7/19/2025 2:14 AM, Dmitry Baryshkov wrote:
> > 
> > On Qualcomm SA8775P and X1E80100 the DP controller might be driving
> > either a DisplayPort or a eDP sink (depending on the PHY that is tied to
> > the controller). Reflect that in the schema.
> > 
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > ---
> > 
> > Jessica, your X1E8 patch also triggers warnings for several X1E8-based
> > laptops. Please include this patch into the series (either separately
> > or, better, by squashing into your first patch).
> 
> Hey Dmitry,
> 
> Thanks for providing this patch -- I'll squash this with patch 1 and add
> your signed-off-by w/note.

Perfect! Then it should be S-o-B and Co-developed-by. Thank you!


-- 
With best wishes
Dmitry

