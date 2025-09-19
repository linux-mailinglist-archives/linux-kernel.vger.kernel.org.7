Return-Path: <linux-kernel+bounces-825102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0A8B8AF7A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 20:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62C971B287ED
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 18:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB56C25A2AE;
	Fri, 19 Sep 2025 18:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K/PK5xiK"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EF4259CB9
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 18:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758307385; cv=none; b=FkviinsSAj30ETHqMBpV2VLiUjYN9Mkqq+Ob6xFV+eGQJrFn0ZdXFdNA7GPUoG/NXqxmu0uA++j85oN4Zkrib1zID72jbDJ4PS+MY7uq8AuWNpiCSAVBbiIKbjT99vYf2MBTXz5eXhwc76oqsONh1WrukdALTQuUzUNo7Rd4CCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758307385; c=relaxed/simple;
	bh=vrkEpEkg6sDXkk+i+SIpLer0i3cfnFivhO+rvdi1vww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gR+MhyyY+VSlUqu9Ubr1cjFIEytc793Kud7FcTxCVlrbjIOqsipeKtQa6rsdQMk3JGqmiJUcg85vDwHEsvI5S+T3qztv0NhcmOzdWXEmHtIN20/XPJqVhGNYJLkRDKTIA+feUIlbP6ZJmNNnzGmPwWppy04y0+lmjykCGvaRSFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K/PK5xiK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JE5SU1021417
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 18:43:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=iDUVT1j3d1+CSBXfFOTmyvH1
	fdhZ2PGbb9X8k35Q3Ls=; b=K/PK5xiKgRdHln+rXzsf7M3F+hfCe70jVbWY+97H
	vb8vd4bOKlTFixKmvI69F2HTXw9VGxrQBm46A6YdcUnOoU/SxCmibMOx3jPVlOdW
	EN443q8AcfUV/InJZoSJ279xcEKACXMiBb9dq946wlZRV3RynEUHF3+IQJgtNm5A
	xLR9ytZdCiRF2T8hgyeB9H1YY1+F1PO4SQYthEXMuZX0w58qwerZlXGec1hl44nC
	FkkhWac4GEz4e31yLaU+3N1wBViYWHKzovqtTJBvA/fVLo6XGJPLwLAi3qD+MNwq
	5+1T6yT6KtUTFgjiJg0XWSgIuHSLxemc+SaAdWnrcJdS7w==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fy5khvk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 18:43:02 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-718cb6230afso44755286d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 11:43:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758307382; x=1758912182;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iDUVT1j3d1+CSBXfFOTmyvH1fdhZ2PGbb9X8k35Q3Ls=;
        b=A7p7o9p1DLD7oBbVveFV8/bVsWWJ9XVxPZoY3pM9pdMV/A5H1fiFRMAjRr1U9iBDCy
         88gtujFDWqliHPltcoHNbSSmwM6UTE8nJUQpNEITycd7mV1KVXlO1nW9xfwDVAprtYY8
         6wxTdNC1qNlSQaED3IV8K+crXeJimMCdvk5jGbBVVe6JEfAdSDUOER6TwBU8qqySVsxC
         Q/Go4zZgqa2vVihOVXIGmFV+umhAr30vVMM/eYhXORt6L/ekr71LOG/oselBqLeXT2yR
         HL8awsxC/ell8keo+NYwBE/UKTdYV1vXIa+yWXEwp4n3Bj0Hevhsk/vINZerceEByVgI
         MKGA==
X-Forwarded-Encrypted: i=1; AJvYcCW0rjyfTx6zzsKl36ac90DHGwO4w9Z5LeI4QXSjEAKYdkwSlQ13s0gyIfW5/gaQ+5kgvDZutTy27HGaeyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE1o1qIdn6j+MiLMbkwwkSRgPYxEfXZ20Hb1H1Zx5y8hyLvy7C
	x6F4njIxPo5xhSITL8WPxS4/5ZaHORSTH+I+jeZseLQQuWMJ/wXvHuJqa7XEU+hbfP5D0jG8mRE
	j1ttbgh2k+SqxjATphDnnupG5Gsf3Vq2TiSDa06lmWmOPNOnAKtIjz1yEEkv+RrZmb5w=
X-Gm-Gg: ASbGncu9uelwllUJnLrlQhmJwQJDAOp/TuS2Ez/UFkGw80mIpd9j3Pu96aUJl1m8Cb2
	G6DKPraDGYE3L36SmLhcEMWBQc/w8JhudreyJj5ZfL68oOklaU/ERqLhXeMZiWXLJ+1oIXGLO0n
	ytTZpJYIO2qyG3eYwRYhD5jwmp1KDbqCXQ0t399n9lUO8Q7XHk++qTErqqNAFcmfB83woqLLSO1
	M7vCkXWs1XEMAw+BYyfgzCrRUIwxAiRYb+EpKWCaA1sY4KbqW+SDKWTm2Jhd25i1eE5sNq5ofa+
	xIj9WK6Evya4cEKW6ZY/19bKiLKcQC0Aiv7g6MFBHP8kjkS1aJENwWl7QhnOKPrBMtOq7vj0K4J
	nZwB9N3beXxYqLnmwmyUZ3TEdFW9yLN/PTSZ4d3DJ51CUSTC4bF5n
X-Received: by 2002:a05:6214:620d:b0:79e:88e2:1e60 with SMTP id 6a1803df08f44-79e88f16526mr13039866d6.29.1758307381839;
        Fri, 19 Sep 2025 11:43:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBKob9aSVicKYLHzXQPUikT9E64t9XkAJpeGDW6LHYdfXs9n7cQ4eZ9GnUtn4na0s2vbgtzw==
X-Received: by 2002:a05:6214:620d:b0:79e:88e2:1e60 with SMTP id 6a1803df08f44-79e88f16526mr13039536d6.29.1758307381248;
        Fri, 19 Sep 2025 11:43:01 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-578a5f447f3sm1549103e87.13.2025.09.19.11.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 11:43:00 -0700 (PDT)
Date: Fri, 19 Sep 2025 21:42:58 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        fange.zhang@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com,
        li.liu@oss.qualcomm.com, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Subject: Re: [PATCH v5 09/14] phy: qcom: qmp-usbc: Add DP PHY ops for USB/DP
 switchable Type-C PHYs
Message-ID: <zhqm6bqnlx3cu2rlv2wdhbhnuwc35jtia72tjotchyq3utla7x@45ws52wsii3w>
References: <20250919-add-displayport-support-for-qcs615-platform-v5-0-eae6681f4002@oss.qualcomm.com>
 <20250919-add-displayport-support-for-qcs615-platform-v5-9-eae6681f4002@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919-add-displayport-support-for-qcs615-platform-v5-9-eae6681f4002@oss.qualcomm.com>
X-Proofpoint-GUID: rDvT9-UW6NiNsK2E6QhD2G2oXpa8F-kd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX7hT8JCZi1raJ
 f6abFgnnw7LSg+txSTFjp7ZY/mrMPLK8QMHWxlJcSnNFpK//pltPZT+ykeLHJjU6M2i9xzxnvPl
 piS1JXll2UlBdlwY2acjOBnvIPE9W6W8tv2SimZWsNHCgXp+EOT6SRIO6RY1Xwfh/H9aCfqFtji
 EwrmEePhfQIHMbl+wGGSC/qI4J46HUyuy9Gr4Wr2trvg0h5I24DiIhhpRpq/N8/as75c1qOtPCh
 eqVkjGZaNSpTAeVmWGXHV2438aNPl/xrkbBOmpjXOA+pfVd9ZZ3R1fUAcCwBdr1RYY3AENqueAl
 DFZ2p5fSZk26ec49uWRpSpj6nZdskdxDkkyqM75XSqA/jCPMxWXi8uItgBQ4rpzme/LW8hHPD0W
 JmkxzOTW
X-Authority-Analysis: v=2.4 cv=Y+f4sgeN c=1 sm=1 tr=0 ts=68cda436 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=gZRqL4tbKlavufozYNMA:9 a=CjuIK1q_8ugA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: rDvT9-UW6NiNsK2E6QhD2G2oXpa8F-kd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_02,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160202

On Fri, Sep 19, 2025 at 10:24:26PM +0800, Xiangxu Yin wrote:
> Define qmp_usbc_dp_phy_ops struct to support DP mode on USB/DP
> switchable PHYs.
> 
> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-usbc.c | 194 ++++++++++++++++++++++++++++++-
>  1 file changed, 193 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

