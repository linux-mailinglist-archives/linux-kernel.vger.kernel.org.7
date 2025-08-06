Return-Path: <linux-kernel+bounces-757218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0208AB1BF51
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 05:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EC0A18A19D6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 03:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102951DEFF5;
	Wed,  6 Aug 2025 03:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H3NOzBAe"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E121FC8
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 03:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754451150; cv=none; b=OMdueua8S+WNdBhNi2I5df2/88DAhM4YE6nv1Lqw7FTSfx8A9fWAVa3i4QRO2X9RASg+fTzhlv8nNJUCw65XE6m3oFT8LUlK57ygmKj5djx5EJTPK7Uzs5n+3ucIfxEQgXCd5U8uI/WSfdd1f8XQUNKZuygPgMZBB+In5K6jIPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754451150; c=relaxed/simple;
	bh=EB35xsSNGFoT+eMg0mvmqWsWkdQLmupjo4pY0WB7uYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WeE2Zhm3neQidg/RPAuCOZRNipciiAaFLAJqf+Heqx3YO+A94C7+KODQy4KxyIUcN9xpRHi/wuZ+yGv6FPelMRxNortfBtru+KHFMYUb4hUE3TiMQ4PAI8zNUD4TSjEUO0Fuhv0SXd72z8WI5SDBKO29pS3K94VMQXwZAY+GWFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H3NOzBAe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5761fZMs023134
	for <linux-kernel@vger.kernel.org>; Wed, 6 Aug 2025 03:32:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=bp0e1t87ImDZTopBTTYuyUrx
	Q5c7XAIZXEo3/bApLtk=; b=H3NOzBAeKdtKarKmdUnhoOypiXBVExme4WQw68Jj
	e0Ar8g1fQheujC/POvP6jyRILOgNON0357Xa3OpDg//77TllFcPfHdgA0FwhYR2u
	4QTl230rC6WaeSjzBSQwKuk++t3QUtBDKWaq8Mia4nFxR6MKiEJ/Kdl/QsSDFoYg
	Ayjeb2UOdZmm5m6kXRWyOTNZKH0IBg20ufthER5+qhXIZI5EEbB67dfme/b//ovZ
	aOFtYt+JiBhiIqZasgiYnomp1VYLkAepuS//rmPeVwlsFHm0lf8P20ZibCmwhzWT
	Qq6kpVGkFepgyJT1hSF8nN2jq+AVOr73y6S57ZobLxupvw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpw318q4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 03:32:27 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e7ff9e2738so516937485a.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 20:32:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754451147; x=1755055947;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bp0e1t87ImDZTopBTTYuyUrxQ5c7XAIZXEo3/bApLtk=;
        b=vBaMEToIEpafBCCMlDNB2GXvYz5XyN8DydnBh5Zq3d4sHQFbcUs0huQyqhAJHu9tyg
         Endki+bi05i7QDPLoy0Pnos9d8xVY9HnBAe/KRlRA8InUoKt+f2RZM/FxFQxJUIbeKr7
         WdJYcA4kbRwNqinUVj92iZC+1rc73jLkCnEHRJZpAyYIX44GnmprNOZ7mxg1zB+6YRc1
         EUeeXsbcPl4HBqI1J4CXzI/LeKiw3GrWSXL1gtzXe32FbS3Upu4eb9b+rMCIoScSV848
         ExlOr3CaFycNdIE3l3n1oHBF+R3Azui7qTIWcObJqOrNQnnU1IIeN7Sl79dkMSq5g237
         KU+A==
X-Forwarded-Encrypted: i=1; AJvYcCXjNy4JA/VprxriYFZnbnKPj2eFDZp1o5T9F4KRqbAYIuzJKwoa6N4Vm4totGKqS9pt4umu/f6O0IBzpxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQkq7fARFXeiKg52oz3wkAMNuW5A/hRvwNHXbopkHueIaAZ3qo
	7avRsQo8jCsCsmyxDSj/gRg4CIfnW4ku+WyVQTKtFp7ovrLNGXU6H3lseQzCUqIXDILO4+mk/RP
	/Ey3dauBr6RKTK0bNqYtyz0u0bWSx3zR+oPVzLA3X9Y2zWN4NID1UoWem2VN6CZBkr+Q=
X-Gm-Gg: ASbGncuRD06KmlnZvRtyrIwwdXCvi6e0mglWfVnKSmxMWO96q1fT73+trYiqH7h5zdv
	XJlvxvWvb2DloZgzDI4qR8ijK8ZG6vrUBQFNPd+pTpNZZ5o4KkQh/ECSpTY25u029b8IeyYJL/E
	72+AVaYhAlXViTCRpQSbjQyOCf6tzJJBTHgahkcG7KbflUDYSeBN8X51FoXP5nus61ycG0QpcPk
	eWYjrsPHkXhzR13gWS6eFEyqCqayVZEMmQqJe401bo8SaL8vY3djlSer57rgt4Cn1ITPhj1zVo6
	YVAOR8je38plL2OkBry8pB0+FpddhTXpokFXlt3e0+ulMrYq46jV7EOFU6/2/nDpLtbHDB8sj5o
	abb5hNrQgyFzPt1FpH8V14ONJyS3qy8soQdFfzEvrVm9tAD6ozcBh
X-Received: by 2002:a05:620a:2549:b0:7e7:12c1:8f93 with SMTP id af79cd13be357-7e8167979cdmr148178085a.63.1754451146925;
        Tue, 05 Aug 2025 20:32:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7yVn7ORcrOBeeziceNORYHI0f/zhevLvW7M4a3MwVZorhSohXkORjlxptKKnzNulfEggRxQ==
X-Received: by 2002:a05:620a:2549:b0:7e7:12c1:8f93 with SMTP id af79cd13be357-7e8167979cdmr148174785a.63.1754451146366;
        Tue, 05 Aug 2025 20:32:26 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-33238272d10sm22210681fa.4.2025.08.05.20.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 20:32:24 -0700 (PDT)
Date: Wed, 6 Aug 2025 06:32:20 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <quic_yongmou@quicinc.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 5/6] soc: qcom: ubwc: Add QCS8300 UBWC cfg
Message-ID: <xfhxrzrzct6n25jtoaacptf2grd44gazfm7fkiyqlhq5bjqujz@bjvacutguagv>
References: <20250806-mdssdt_qcs8300-v6-0-dbc17a8b86af@quicinc.com>
 <20250806-mdssdt_qcs8300-v6-5-dbc17a8b86af@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806-mdssdt_qcs8300-v6-5-dbc17a8b86af@quicinc.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOCBTYWx0ZWRfXx2TK/bvKl/cu
 fNCQz4vf02mn2FrsTAs7EPEJJ5Oau03ZgZcQ5/WqoVWy12+kwsOIzX3VOCCsaNwK9cKBuNUVmGl
 0Ar6mF2pwo0CJcZCaWtSxYnleYnU/vNq7QSu+aN0Q9lHx5mT0xaBobLbZL2E16JF6IfAtvjUqRb
 GHIq5nKGBlVV9ciIso0A6EswzU0Us+UOQW0AjEYS1ufXegVY2EKF1CxqTkaUdZWW2aSCmXXMtI/
 Vsh69PW9Ir/Pa5DqRl7Sh3FX0q61KQPp8/Larf/ZuQYjDwSdQF3hXPNNb9Y2Yl7adtt7oGx8qkI
 fDQ6a6Z2/mUMGQ7jA2OOvd+FA84+yOffYEh0PPnVnT0qSKg0IglVm/MR3gQGAZpfKz89qkiDab0
 ZamVx67t
X-Authority-Analysis: v=2.4 cv=J8Cq7BnS c=1 sm=1 tr=0 ts=6892cccb cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=qcYK-ZiiYIKsHLxbHAsA:9
 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: F-YlAnJu1oVtwfhJotaflWYGmCpQwydv
X-Proofpoint-ORIG-GUID: F-YlAnJu1oVtwfhJotaflWYGmCpQwydv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_05,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508060008

On Wed, Aug 06, 2025 at 11:16:49AM +0800, Yongxing Mou wrote:
> The QCS8300 supports UBWC 4.0 and 4 channels LP5 memory interface. Use
> the SC8280XP as fallback for QCS8300 according to the specification.
> 
> Signed-off-by: Yongxing Mou <quic_yongmou@quicinc.com>
> ---
>  drivers/soc/qcom/ubwc_config.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Bjorn, is there a chance that you'd ack merging this through the msm
tree?

-- 
With best wishes
Dmitry

