Return-Path: <linux-kernel+bounces-858754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DA5BEBC53
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 22:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BBC944E1071
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 20:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB70285CB9;
	Fri, 17 Oct 2025 20:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jHTgols0"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A19283C89
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 20:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760734539; cv=none; b=SZB9Hjdd/uXxwtNBVcsujKcyr0yVIGAJ6scDgNHkS8c+bpwsRtbzLNDnmiLobrRi1CgpkRQjpHWN9acAsigYK1OfZbNf96yMG49x/rfAgGwQjLA3dWFTDQaAXsNYF46WNFC/SNkIeD3p2Lj+GnePjERuy+vI6AUwI3dK+2qtR+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760734539; c=relaxed/simple;
	bh=bgJ8YiYE8qKTRMOZcsa9HNfpRfaTpETkh8zEcph5TEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FwwJ+/SHi7Z4gXieNbDXKlf8dxwrLGRUfYsjhm7RBIhvSf1Y7FZ3abzfSLWuxxwakjvvcffqhs0idzuBlaA2zvUlykoaECDa9wDss8RZoGvrg45D0sbbQSBGuBsNeRMz4KgNogmo/Aa8XYxQLNEVma+8Q8zsnwtOYSGxou39F5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jHTgols0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59HJGWRE032016
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 20:55:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=tBUBJv7YgdO5vYO/psTXoU3h
	cD8pEsOW1XkvnkBW7ww=; b=jHTgols0xXkD6A0AgZxtB+JghLy7pFoXfy/jSFFI
	XWl1v3vCgq6f6Xz0a/RulCIyirvF2UxjtB1ehociEHTu6hp2g5KgJxmmrss7pgp1
	ag2yz1fTFfIoZB9sFFKiVNN4KxOMDz3aiCnp/kDjZ+wy+cPOkeZGrPCWFMic7fzR
	3m0cufGnl1uz4I+WsOU351f4/SVzsN3Z/M1UfRU+RUFkcLaxn9Vf4/Ry4WxNvej+
	sZSKb97Vsf9YVulhZMYtMavWbW3xsuXLg/bo8o1i5DtmRoKBN9QCWLxze5woMbh0
	4eK69us1fMv9mNYPGe3PGyuIO1eH394YUVpJnyBvHZ6Tng==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49s6mx01fp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 20:55:37 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-891215d399dso301869785a.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 13:55:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760734536; x=1761339336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tBUBJv7YgdO5vYO/psTXoU3hcD8pEsOW1XkvnkBW7ww=;
        b=M4I91X0atj2c/4v21PTsNdV9oDQQi+9V+hla+v01UTO/WC8w0mEqJXxi23upvyZrnd
         R1IjG7nn7ZCFfKfkVHxTYfNMRO6fjp2LLeLxpeK3fFEjToqL2Mx4ynJ1p6yR1d9mkbAJ
         wumMhVmtEENMdJ9BwDcpEfz3YOXJIvBI+hkDIsxotiWqz7qX1zSY8IJ1jyttoDpEjY9r
         UoGVyK6fOgjEEWnh1mEGmGrB4wp++KU/XsV+ZNeGyvUSM/RL1APLQClIr31IKnwpawgu
         friQFKztpRGZTdMNsSB/tn0ngurp6JWPSr0VgYpxrvN6PwWRDBjUAMEtBAYjiWhHTedb
         S1oA==
X-Forwarded-Encrypted: i=1; AJvYcCWLR1v6WogWc/z4vkQDuy7whyJ1vwPce4YEZVdSfjFskGClMlGo0oTLnkWSs+mWR0cRe/dd2qr6/elEyJE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2t4yYGpl4gtZNNgZyd60PQvQXowHjOZKrPNtKfsyJJNpA7RHT
	ElM5QQUXtuJDWzEDzlQQjSXK/3Ur5tYoFs035FaLbuVx7hoEK2WJMN6ZJc9ZsHiUsxvn3IswvwV
	qLp4ER4WKZMoIkOLizfKa5cJqiS3DixSAvHLnyLWaa5AeCcOS+9h2wg3UxvoLoTeStKo=
X-Gm-Gg: ASbGncs6ogV9SNEV3c3SoQGKt9GGIRX9VVixM61new5MAkbSv8M6+Lf1s+vjU0uARPe
	zKEti3u55ykO1H/vEcFqnXPb26STSw0YdmYqRVmPE2zkZI+dybK76ztrGUN6/Hqzcel4BjCCbdY
	rnEVHZk2TH2UXcEMER521kJmTjB++OPZui9hdBezpxIo4bSXLco1r9YgJ3YOgTBWVtslmFFmqDF
	9eSYuIJaKzQXRdMyWqdpSa/PWpXRZrySDiUt6AzEebo0kGSEkimqhXHrAiEsKhDsGCd85FKENdU
	eX1yEpyovAWCnFKW2ErjxpIuykxUba8SmGNU2IXB4PSYoAmWS+iwI3fhL73uusPr7OtJ7MTgquy
	mEHJppeYsOBvfAXHTNaYcVPRMgQzit44EmwWyZX5Kl83uTzFvpjGE5ZyekpxCFpL5M1y9V4LQ26
	CsJfl4oM04VVo=
X-Received: by 2002:ac8:5f91:0:b0:4e8:91bb:2636 with SMTP id d75a77b69052e-4e89d3712cfmr69650001cf.52.1760734536001;
        Fri, 17 Oct 2025 13:55:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWIYr4LhZulc9IbG/CVqJdzUA3qxE7l19KYbIdEcG//A7H2l6zjHkzk29nEiAzo0m1WKreKg==
X-Received: by 2002:ac8:5f91:0:b0:4e8:91bb:2636 with SMTP id d75a77b69052e-4e89d3712cfmr69649761cf.52.1760734535547;
        Fri, 17 Oct 2025 13:55:35 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-377a966e379sm1750451fa.55.2025.10.17.13.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 13:55:34 -0700 (PDT)
Date: Fri, 17 Oct 2025 23:55:31 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: qcom: qmp-combo: Add polarity inversion support for
 SAR2130P
Message-ID: <ywovlyojskgv7hbkr5tjtmsiwkf7tmgzw4puy7zb54kvmt3mzw@zq5etee6pjwf>
References: <20251017203438.744197-1-krishna.kurapati@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017203438.744197-1-krishna.kurapati@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDA4MyBTYWx0ZWRfX4Z5My/kijhI6
 Yx1I+q/PUhB3vuJpwOSWQYAdb/nMRfwqjt9xBimfCzA0nt2c8oCpAJvZLoCT3q1pvMt+58YW1oi
 tEV4WIpFtNUSLF+YpAgRuAWzQ0FeKE4UEBNSCfFSdM6WssIRdXMgwTMuqWdG6w4ZpBDPtlXwHly
 AZvnHobrn6RAhqIyg41+RlLOLLLKkDekwDjdP99UAIC6PcUwAlF86uYcP1QEvfJHMfCyLeDHQJR
 0tqIDIUirr7UtOk8BFsuK5rb9pcVnGIq5U8exC8bzwurjiyKVgH7rrY1yCyJWNkl4f143qewVEJ
 2kgr/Xja4tL9ntpGNfusyFCKf4bgy7HA6EEWgi46vK1mx2Og2Sp4+cbgEuU/GeKmvg88qj2//n7
 f4L/lZqwr3n33JO6spPOzNdbHCQTzg==
X-Authority-Analysis: v=2.4 cv=Fr4IPmrq c=1 sm=1 tr=0 ts=68f2ad49 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=gZxxQWLh4rD7iasbu2EA:9 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: qx0ac7k3zrfXlMEmNGmoLu_6I042q3z4
X-Proofpoint-ORIG-GUID: qx0ac7k3zrfXlMEmNGmoLu_6I042q3z4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130083

On Sat, Oct 18, 2025 at 02:04:38AM +0530, Krishna Kurapati wrote:
> On SAR2130P QXR Platform, the CC Lines are inverted and the lane
> programming is to be done reverse compared to other targets.
> 
> As per the HW specifics, Bit-2 of TYPEC_CTRL register indicates
> port select polarity. This bit is to be set for SAR2130P.
> 
> Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

I wasn't able to test USB 3 while I had the device, but this seems to be
correct.

-- 
With best wishes
Dmitry

