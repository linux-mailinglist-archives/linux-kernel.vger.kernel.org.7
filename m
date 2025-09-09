Return-Path: <linux-kernel+bounces-807968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36AA4B4AB8A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 406AE7C0B1C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6279532C33A;
	Tue,  9 Sep 2025 11:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Er+nx3KA"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4328D3218B8
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 11:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757416451; cv=none; b=SzcChB8Ca2Fj4/smnFjCg0IpX5NrnZsi1Adryxmc0AIgHqyIVzFv+MjBVGJJ0r9VpsypBmX8b1FzfDq8vnKGZTCQFr8CkBoPDAA6MDWrQhglDz8pknIvHJ+7afTvWd7rZwXDCWAmQ9mcsWls1QGf4+1GUaMr7cenf2MwSQJwa/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757416451; c=relaxed/simple;
	bh=0cWRpb4Am+Av7tp1p5YR/jKks8jMS4WHToTiBHvU3kk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=go/EJsS0fkZwRrDsQW1nFEgKfgFVFxIwSNGizES+2QUtgMJUVyR21v+ZrrqHfde1SO0PQQLH8o8dcC3zLQpDfYIf3akbtAzsZqVMSCTl/efIqy9DtUv3B5k0XylQnotSKTou0wFNl6cC0/4mvYywh1oCfjiZCNjq0aNTa+HvfAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Er+nx3KA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5899Li4F004598
	for <linux-kernel@vger.kernel.org>; Tue, 9 Sep 2025 11:14:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=+fwEbLviTXnP9T0PkQ6EB6hc
	vv3Rx7j5rDURlYin4bo=; b=Er+nx3KAG2MgTrbkwII6TsOGrwjCXkD0CSo9LkcA
	bPSJ5kfU9Zjh4Xs82cmL9em3BmeLJWznMEMFWHTwLJCFHJCIOVx/u/Bk+NkXEU6D
	+aMBsB2MUOmqaqRsUeqvMSSoIZybSbgMMAP2la3Si5fZ7a3cDsKCMkwM8ooC+kHC
	lWgtjZB+BRd86Z3KX898GEIgJHRMqmW1TlYdtoY0Bc57L3T/9/2b/KPATxlOBGOp
	vcMWQzto6ml1crRDd9vXX5Qcuf+05Mi/1qbDf9Xd2kRe26jnd0ugyds/mUXU+6IB
	wZdyg0rTQsGV0wY6XexuthJPB0FoaeXjHmSi8zfQaoOexg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490aapg9mp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 11:14:09 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8078f1bc588so1484685585a.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 04:14:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757416448; x=1758021248;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+fwEbLviTXnP9T0PkQ6EB6hcvv3Rx7j5rDURlYin4bo=;
        b=uwHhxhMVYG07yJfR4uiNoBmrrBWIGw7fdTMbNWQ4dhPlIR+bzi+MgjxBmeOwhDRVRc
         wT7AEXBvUam/6xOEKgGkJmmPRelQB9vVGinVU/GFaemV3grLj/wPTHtVpfi/BvQJRsCM
         TDoA7nZ+Tw1bCRezbYBWuUcIPnkXRn8Zds+Z6Ui8A3OOk+aH17F5t4TD64EI1rn/M20K
         xVEuyGIQJ6MSRlJkxzwabRPSWgxMvfMOwSm+XppQ0sUMqPcKkHii7Y3ZDuuQ6pBw2P1X
         0m35y8MHwoPxALQBpllVkRqxJYQmoCaGz6HmdVvxdWBbscfeE4cAgeXix59oxzA4HrN2
         SAQA==
X-Forwarded-Encrypted: i=1; AJvYcCXBiEE3vWNiD/zrTyrbd713DNuITW+0QqDbXFhPGib6vdKK7USENqQ/gWfnlQNNWgjpfGQNXiod1EXHreM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzGAmT9UesLkwXJ/SFY9Bc7t/g6iE1YyHn8MPVUbhtp75LD4la
	L8yyfJMfmhbDPmN1b5ziq1XoElHxIuq5hr+ySSfL7EVop5ghBuTr6SCOTYTEn6lYE0Ah8Yhk2yK
	SCZAf0MEENj9/kqXTNIC9BkHNYHDIWBQDMVg3SKC5iLbpDHpMHr51q25vSPE+vMQ8CLo=
X-Gm-Gg: ASbGncskj2D06g0OOH2khm7YG1u39gdmOKykjGgbIANv0FKd6N5KAS3FPNqlq5Ro9Zf
	OKbu9He8UtG6LmuTzTfy5d6MuPr1RNQM32q+TbBUl0dnvqDH4yzFA8tfbrHnMQNTKe5+QMF8odk
	Hf9M3vZLX0giu7tYiUtbDhJngpugX5FeoaAmEQh/drLlKb4Vmq/4Y2zEQ5WiBNx9osJWA+a0A6v
	JPVpWfJUajXgAP2mVdygUz6+6oJKJyHU/rmrpFXs343GUzHKUuzxafffDfttEh/hGQk7GTpMNNr
	oAKxPs7gQCIrpxA31fDAqgXPik64ZofX0RNrDX4u7dijo9z+m+EwC7D4pYkGChm1Ihn8w+5dQN6
	QPCfVW6BSUX2CoJfom/rt8lmMGGJl54R5qmropsoFvLV8w5k/akrd
X-Received: by 2002:a05:6214:2246:b0:70d:ee9b:9cdf with SMTP id 6a1803df08f44-73930fd5d84mr129752706d6.18.1757416448072;
        Tue, 09 Sep 2025 04:14:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuYUXflq31tC9iMPaPvSoW8UAsh4FK80jrKd85IRJdZ5xoSa42MbchBXglv6LvXrIwyp7+3Q==
X-Received: by 2002:a05:6214:2246:b0:70d:ee9b:9cdf with SMTP id 6a1803df08f44-73930fd5d84mr129752096d6.18.1757416447467;
        Tue, 09 Sep 2025 04:14:07 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56817959addsm451687e87.81.2025.09.09.04.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 04:14:06 -0700 (PDT)
Date: Tue, 9 Sep 2025 14:14:04 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Imran Shaik <imran.shaik@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Jagadeesh Kona <quic_jkona@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] clk: qcom: dispcc-glymur: Constify 'struct qcom_cc_desc'
Message-ID: <m6xwficrn7me33hnkaeyjzywmb7qhawkfcj6lomajux3voe4l3@g6uhhrjcgegr>
References: <20250909-constify-dispcc-glymur-desc-fix-v1-1-6cb59730863f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909-constify-dispcc-glymur-desc-fix-v1-1-6cb59730863f@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=eMETjGp1 c=1 sm=1 tr=0 ts=68c00c01 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=eHRkPKsZTjWJbIN5jncA:9 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: mMGhVJaUtoL4CptFoHckmgC9sE7xL4aC
X-Proofpoint-ORIG-GUID: mMGhVJaUtoL4CptFoHckmgC9sE7xL4aC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAwMCBTYWx0ZWRfX5AN38mgIiWFn
 i7/P65KtDzbNXH7pBt9Eo889iqCuRodvvOUWpPMhkz8/sXD5WxXaQUh8FFXhb+fGe1scksqWujh
 3kcl+y65NGNQi31vXNegPMidOwqIKK9X46/2z/tmwZPFWzsXiLB/IMF++UuAOVgSMznnqxNvvsh
 NJFCimvxZZxUoVS+wjvTt2G4Rkiz4CpE4XJDllQtoTxBgqsC2SQ4dGBFWIJ2We8UNTPT3JpyheF
 R/QcoGF1+MSB0g33qm+/0VH89O+/1gjNC/m5mZEjl0jkNpqjpgWwfZyzCOh7Lb1YQEKixUM7mH4
 7pkc5v/g0rgyxhe7OQkyLP+dQb37eCPiUODlGtTOnPpBISgrmyQnGCCgjVujbUn1g7DhnVDseoY
 2FkeQb6D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_01,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060000

On Tue, Sep 09, 2025 at 03:17:59PM +0530, Imran Shaik wrote:
> 'struct qcom_cc_desc' is passed to qcom_cc_map() and
> qcom_cc_really_probe() only as pointer to const, so make the memory
> const for safety.
> 
> Suggested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
> ---
> This commit is similar to [1].
> 
> [1] https://lore.kernel.org/r/20250820124821.149141-2-krzysztof.kozlowski@linaro.org
> ---
>  drivers/clk/qcom/dispcc-glymur.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

