Return-Path: <linux-kernel+bounces-824988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BADB8AA2B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 18:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4394D189C198
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 16:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB8C25FA0F;
	Fri, 19 Sep 2025 16:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K+xaXDXh"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CB22580EE
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 16:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758300420; cv=none; b=WLfxqebcSCI2dPTubRjvu416DUQuFFYdxgRqebOtfb5Nzw8D9/HcK6dF9MCQ7pWWf1fXu//soI670K7Z540hYe3aGBfzU832FPFXpG6kNo9Nf8RAJG1TSKdnfEeafP+t3SXXt6buB4j3b8GW0FjAWPXmh39KvCzDEuRWdTeMpEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758300420; c=relaxed/simple;
	bh=ICtRGgVbCGG9PUkDbHrB6xZ+UsvaoeBqwrVPiRFbC24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MEoNbYYFCzjW1NAgtGXpOqDXgkwM9r2R804WJ0lUiHj9CwdGoD+C+5H9IVeVcZ7gxyEQGVDEZ416vcfYnvbHSCfRwTpvnkuQaSnkS54TdDeQSh2dUsA8rlZUXfUR87P9b+0nZ4/xSamW2ywJE1qo0rHMOpF4iyFs3tqoMAlCOVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K+xaXDXh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JEE04u018046
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 16:46:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Um9tx/y2LwR08t9HZZiDTcTu
	T9zUc9djMRm/CbZ+X1A=; b=K+xaXDXh+okpJGZMNks2h/fbPmM1It3/CUsPmBKo
	/ABpAwdjxm57Q5qXX0C6YdG7Shebb22WpRZVdpi7DZr2iYAnHxLRjnrUFDbE16qr
	wFJucqIb3lGuQS4VfzJ7E+RTzCPWZTFYcNissZeif3uisAwVateOyW7AOqkn05WT
	PF3o401V2KKewh7kCA8Naz8NoeD9D1B8QRUkgy7he6fNAbWk4YhNnQCTU8OuRtPG
	wWyx3oX10GhZI0/wHo72nGQ+ykuoj/jni8FT3zttzwWHR7rYkw9HvAuAEwyhh9bu
	GK0aW48pMOde1CF1FYc4POvpMriWTEOgIW2DGaITLgGuDg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4982defq51-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 16:46:57 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b79773a429so62718341cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 09:46:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758300416; x=1758905216;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Um9tx/y2LwR08t9HZZiDTcTuT9zUc9djMRm/CbZ+X1A=;
        b=eBoD6bymIZUhrOcdKQJnfN+0KksshS4xPSPn1Y9XLiV+sDQ6qyPvEjcEd65MiLya5f
         1N169JdNOlNvfePOQZZEETMTgPEozYjjzrTsol/BPnkbZ+8vy9+SfO6OD2bNamjyhRlp
         6H5pA1nGNs8B6ITTL8bL01rDtKojXpE8fWm0qJ8p/9KqIEL4ltGntI6QiaMGq08lmT3s
         Oq1smtNQyZu4IB7MNSS4MY9R5SZYGL27EoFAlAHAHtHs5c1MZ9o3IABEK95zd1DrEPVX
         MQ7i8/S4EmFcrvmct6GUsF9GNHWPuc1ovulKpvA+2U4+ERRy3tdYOEX16Xn1umlJTt9g
         kVXA==
X-Forwarded-Encrypted: i=1; AJvYcCWDI443NdrdQUPeJTEnJg8bufso+988720DvVkuAf9S9PZtYnNHk4CNNlIgtBPvvJUxDbRA0n1i2SBqTP4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+8FW5SV0asjr6zWQ+0WkR9IwP/vqqXlPWgsQlU/62LImD7j/5
	c4AYylemg3WehVU9zYZIrdGMoW4vcjKtrDkIZO1nYbgb2Y/SVYl/ljF7hMO33X43cVUebjDxJiU
	Z6g1CvswNdA2jQJNvOzGrUek9fLqxMEeJ3paOcAaXMshLOWcQqhPo3w9POe12lQ/7pnw=
X-Gm-Gg: ASbGncv9W/nezjs6m+GcZ7SgVr88b7H/PWbnEWv1LBdL5KPSwph4NExuA2gUDOZ99jA
	D8TIWpg0R5uXgXnZNUeXiW6TeQFf9Lfrb+WwQphMW0OWeA815gvKhkNieBLkQdLB1Thg9GUndpx
	zNQaRnfOc200ycVr6ZTR4ApKHGWlzOiSXuAH3LfiO5z1QrB/LiM8p/WV1qn0iXFNg40g8LZhBRt
	/1f2zLW1ggT519ZETODpzbcaw0PtxbTH0vu2GVdgtPacHEQexAkwJmwddCD3fc9W1Bzw1IHf6+j
	6LfHtTVrRqGkEK0IjPG75kUCppeVJh9oONchAjDQm7rCQ8R1dL0Fkw5GQOAK/9JzmwU2r/HCO+I
	lKXogRLMDac6zstj+q29eGs3dad2YYS6bd5VdJYrpPyLyQI847zc5
X-Received: by 2002:ac8:5f8f:0:b0:4b7:9b61:e6c9 with SMTP id d75a77b69052e-4c06e3f84c7mr46464731cf.25.1758300416401;
        Fri, 19 Sep 2025 09:46:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDuHu+pCXreZlW6yMOlA1oYpTJZZVjarPXitMYqbWZSgljRDCeRfsjix8zFXY3l/JofzsvjQ==
X-Received: by 2002:ac8:5f8f:0:b0:4b7:9b61:e6c9 with SMTP id d75a77b69052e-4c06e3f84c7mr46464201cf.25.1758300415762;
        Fri, 19 Sep 2025 09:46:55 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3624319eb49sm12152421fa.50.2025.09.19.09.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 09:46:53 -0700 (PDT)
Date: Fri, 19 Sep 2025 19:46:52 +0300
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
Subject: Re: [PATCH v5 06/14] phy: qcom: qmp-usbc: Add USB/DP switchable PHY
 clk register
Message-ID: <xtosrpz6rzdvtmpyq73gboeckl3c2x23iqehlxzbaszqmzugjd@ixhj25qujqxo>
References: <20250919-add-displayport-support-for-qcs615-platform-v5-0-eae6681f4002@oss.qualcomm.com>
 <20250919-add-displayport-support-for-qcs615-platform-v5-6-eae6681f4002@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919-add-displayport-support-for-qcs615-platform-v5-6-eae6681f4002@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=YfO95xRf c=1 sm=1 tr=0 ts=68cd8901 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=LgMYyniohzYkqyhK0zYA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: WusY8a-sUzjjtiSDjeRitklvGGDMZYr8
X-Proofpoint-ORIG-GUID: WusY8a-sUzjjtiSDjeRitklvGGDMZYr8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE3MDE4MiBTYWx0ZWRfX/nbLOUqmtMla
 +11Ln/wIZAqzdABJFnExm71VGQ2ExDtp9/H/dYWUkd8IATuE4R2ynWmTsE9d1A9zj112VNvcaBa
 18gHhDY5k7yhCs59j6GaCV+95QU/Nq5HPz4T3mvXKMqEhnJojEVocu6YF0oIuIb19E6Yv1M1+Of
 qGx5jbuiktkTdONBUazN4GUBjKB7YznmpRwcLSLkP0EDmrVKTBqKVUCA0OG498dpYvnKZ5ZVTye
 1zn/PioH64Au5jeAZkuG4j52+VRrFRp3A7DBjOt+Wixp8cSqBDunGw7QeHgoXzomuGHTAoXFbgt
 Eizb/P8t3OMA1GoyoEs0rcEXKFJKY152mHA7KjjnmvAcJKlz3pHuZtXr7LQRm0WTk3TqrdzxYCh
 DGN8r6Gb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509170182

On Fri, Sep 19, 2025 at 10:24:23PM +0800, Xiangxu Yin wrote:
> Add USB/DP switchable PHY clock registration and DT parsing for DP offsets.
> Extend qmp_usbc_register_clocks and clock provider logic to support both
> USB and DP instances.

Why?

> 
> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-usbc.c | 210 ++++++++++++++++++++++++++++++-
>  1 file changed, 204 insertions(+), 6 deletions(-)
> 

-- 
With best wishes
Dmitry

