Return-Path: <linux-kernel+bounces-827991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CDFB93A01
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 01:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8576C1894431
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 23:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D59D2641F9;
	Mon, 22 Sep 2025 23:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IaG2ts2/"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA344A32
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 23:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758584532; cv=none; b=RyeOfCkKAOKnNMkuOuXIaa5CJ0ptXbu2/nzWQupebKnVvXejnD9+YOjbc92CPWe80QEkUmEjIdCSl+U7yWY7bZ2jCq7wGR/0/e+FMF0p4HsA5lvr+T1mCM7HnzEJFQ9sTatd90E8jB4/FceahIa7TQEpsSJPWMMKbMbgd4XQUB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758584532; c=relaxed/simple;
	bh=oHyZaDiA8R4Y9wEbW/1scOyFjbmpQglImEmfOhiImt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=heUkGD8tcLabvUdJBXPBNZlwYOs9aqH3oAAR2j7ZlHf8bhhnzUyakbsynR6fl1ZoXez/gpUQxFsXlP4S/fdRch6JWm+yBX/vLdM1AmTyF/rAIcCfnId70sx0rZj9l7ui/iwWo5OiQZ/njeR+oZNblQhK/0QDsNrq04n+Qkau+lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IaG2ts2/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58MHM7TD029909
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 23:42:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=wKrPMr0tlkE4G5cOmGjs48vk
	F6z+umGdX9J0UdLXMTk=; b=IaG2ts2/uJmj19op1DGaZGmEckol3fdc4E/ER5pR
	vBstcL5JTs4W4h0uMkjkSvRQPyVO8QbQisnPCxaJrL9y0uINT6aP7mHU7DzDDmB/
	Cdq2F5yOIiFgwxpQpWmid0qmHHtnMhTOW329znjbj7ChL2ot93+bRfk+1eYceDIL
	IkGZrEs3q84fuQB+rSaFLBg2q+4z0ZGqyCMVRJ95yHnrwotb9VU8iv+xmR/vM6+V
	+7QstFJG+L3kNz6j/M0pn4O62H32CPFQH02ITOsApKHBzdbOKewJgw73Sb+6Iu9Q
	2FEImUNeLnkjPyk5gVgMZsQ/097EUFpZVDfoIvgwhRpMRA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49b3kk2ckb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 23:42:10 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-79538b281cdso77803966d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 16:42:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758584529; x=1759189329;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wKrPMr0tlkE4G5cOmGjs48vkF6z+umGdX9J0UdLXMTk=;
        b=r88EvLxNxbDRJ0eOVm1RC/N+/oCz9SQz8j9SkTSQPDUByQ/Gh9PzDf2xrBFsQzgMcZ
         PfYGf6frfXPKF1NrZpALnoYPbPHGGbU5Gl8lPxwNYAX9T9nj8crt+/VDc7ciV9VEefHf
         hCkgMAVbqDBMr65GRztlGHMj9xDxhjJi0XwDm+Tx+EDU29Ujo3Yg9i0mVNa01fW/t3YB
         brLVyNpU/OEDEgW6CLqrBX9h6xbbNS0EghOKC/nVS5VeY+0PhVbUPpvYLyqnzY9rHSY6
         348p+lnCXY3EZutuAQcivKrPmXz6W9X0/07xUzvs7wFaO/3uLMhme2s1gKWO+ebksb8X
         Atjg==
X-Forwarded-Encrypted: i=1; AJvYcCVDp5DhQ4xrliYYMbthR7Eo9pjdpWVI80N9WpTddtYZTcOUNJxvSpOUgDmYDkYvLTRU8A/gkRUKUmCtf5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB7q8dNJLlJ40s43Xq9yRKvpX+g+UZTSrjYsozCfdo8h0+jLI8
	ZlMJPnZw++G86198Gv2pm0jB1gwb87YDe78ahBkM2QjG96C7/M+eBfmVlPZh5eKKatcK5pi1vFF
	RM60kI/rWsgJJFgPSP1GhEIEsqR0YQ8NNaFvS3QZY6USnpqQUb7oA2k6tDaPUj139gKE=
X-Gm-Gg: ASbGncszq0GN/tIXnRJGAbv8bkEVRGlaxcSTZGve/fC7Fonq8oLHVD9O1DC9iFjJADe
	HsECUKnmxbIdQ/XksTxZbkFlosfe0iiJCwfbWXEPi4KbcMOi/qkMk4aF1k1eC1G7HGjBzltYTaI
	CL+doIlLUVjbBZta4JaIGgh/3r5pdIw0RPulG79+Ccdo9VDILNkEtUkQgjmNi3kE7mfw/ymb1Hw
	zV6jV5f/dVIHWCb6XFz+DmCPzTd6fPaowC1srQut1Tii4M5jfi+Q9aGQ1dHek9IkRxHVU3hdasj
	MgYMOD6cek9Pvne1lksejPpEfp7gzEvAewQblvxoDFqmytdB4jXE8jq5wPJyk3IcsX3Fn0sqyvu
	O7sI3Lm3JdIk1+Uh1t6IBEBC1UFtFVEQv41Fo/QTw7NpLELbEFcHN
X-Received: by 2002:a05:6214:258c:b0:78e:5985:92f1 with SMTP id 6a1803df08f44-7e7a3c99478mr7170336d6.11.1758584529330;
        Mon, 22 Sep 2025 16:42:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBTLWQ1yvXxw7dPCeN1omOgmdIcvJix3NNKAQEDZUCozU8Xb/ljY+ZqfX5B8NkKKsPbkx9aw==
X-Received: by 2002:a05:6214:258c:b0:78e:5985:92f1 with SMTP id 6a1803df08f44-7e7a3c99478mr7170146d6.11.1758584528898;
        Mon, 22 Sep 2025 16:42:08 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-578a5f45387sm3686349e87.1.2025.09.22.16.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 16:42:08 -0700 (PDT)
Date: Tue, 23 Sep 2025 02:42:06 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Faisal Hassan <faisal.hassan@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Konrad Dybcio <quic_kdybcio@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: qcom-qmp-combo: Use regulator_bulk_data with
 init_load_uA for regulator setup
Message-ID: <zqj6ojdg5qizvhdec7ubedb7i4ftoth2o7p5ydbu6euszxbzh5@atc4z46iewxo>
References: <20250922135901.2067-1-faisal.hassan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922135901.2067-1-faisal.hassan@oss.qualcomm.com>
X-Proofpoint-GUID: rDggbIGBX6Eu5O8xBlfYvj7X_pdq4CfP
X-Proofpoint-ORIG-GUID: rDggbIGBX6Eu5O8xBlfYvj7X_pdq4CfP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDA4OSBTYWx0ZWRfX2XkzXFd29Rxx
 k3yux6QT4aUTMeO55fmhJ6iPl2V1ls6ztwe+83AReO67emUOfuiWAnOaJ3kXanwI9eKGtr0oVUA
 4Qv9PsXhdocbzyBJBjMAaGtFRInacHvbx+/gFsq9mBNL8dUxI58Fje87eD+ABMCwVLvID9ax8kv
 CEpTY7+7UOOmKn8gWXIm/C/KqiWABqU50S2Gb+PPAXBcnLd1VT1C2cUnO4sqXUQn4UGt7u7mMXM
 CLhtYVjBo62s9avtdY8tryUavvfagx9d4UArz4c57HECeksKRTkACrdSNzGFeTRDjCp0jkIbeA8
 D/KgGDaHVFW4N2DjVkMz1ZmTwM2D/HLgcTLQoflknKkWWY0I/nTdTJTPnYIyzVfGRPkxCKgF3vg
 irvK3mlv
X-Authority-Analysis: v=2.4 cv=BabY0qt2 c=1 sm=1 tr=0 ts=68d1ded2 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=tZu8JuLyvjuD0Hmwe5kA:9 a=CjuIK1q_8ugA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_05,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220089

On Mon, Sep 22, 2025 at 07:29:01PM +0530, Faisal Hassan wrote:
> Replace the custom qmp_regulator_data structure with the standard
> regulator_bulk_data and use the init_load_uA field to set regulator
> load during initialization.
> 
> This change simplifies the regulator setup by removing manual
> allocation and load configuration logic, and leverages
> devm_regulator_bulk_get_const() to automatically apply load settings
> before enabling regulators.
> 
> Signed-off-by: Faisal Hassan <faisal.hassan@oss.qualcomm.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 49 +++--------------------
>  1 file changed, 6 insertions(+), 43 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

