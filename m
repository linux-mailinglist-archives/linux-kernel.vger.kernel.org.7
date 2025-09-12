Return-Path: <linux-kernel+bounces-813719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C78AB549E8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EC4E1CC08A4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1907F2EA499;
	Fri, 12 Sep 2025 10:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aGkRMSDg"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B747A41
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757673156; cv=none; b=cQ6GcgQGIQsRpxV/FTfUOgP1myB/hzbc8tZexPT6qo07uG9mRZjiH9JJH1vHvJrpm5rX65edc2BGEnR3k4kJDywd5YpTrAxX6bUgkbJKPwZ8XLRRb370S3Mt54TSxoiIdV+SfOK7NAfBwaKzMQXyMFo/gIrrLRi58C4FICVdMFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757673156; c=relaxed/simple;
	bh=zYERfnalf3Jo/X9Lwlxqt7HW3A3cVCP0YdwKshWJhhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oh8cBcOmtginc9XIKHsyHcvkIyYLDFDE4hJ4zcVZ/UMCPVrJVFEJw15KnsGogpXQROFFpj/xa7vbMM5/nfUYCcM6vSVdOvBCZrMeVN8SlWY+0Jre5mwximmSi+sqnG5L0RHg3SYn8SLjat4soTEC/IS28O2qENTwRyEBzB0WD9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aGkRMSDg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C9fMGo010869
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:32:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=EoZeu0gL7XFLE2oXZAdYX1fB
	kmSI6sTEmRZW+tG1M4Q=; b=aGkRMSDgGwaaJBbM0weNtqcHcsttdaCvb7pGLCje
	h41WvGyTCjM9CEnXLEGhA6kZ5F15GZd4lRFL0MvmJghIYDljoj5iOX07A6aystRO
	ZsF11XtSDDiNXaJL4/Zk3XPGbq94eQ4kwWA7hPrza3qr+fPdHHyBELrzN5WVUCxC
	JbP8GE618fEiK3OLfIoVVl6DUCY1FDEaj9IJCErQ47wUdiS4ft1ATxsZ3iqeHbXp
	5xr9eTX4t0DCsUOfV/yQsIoZ8c0nVzJxy60A8V2pDW+1kooYbH12I3A0NNM7xz7w
	2C4WI5p55cLsDOLQrvZTeSkDOi6iitmh3Wic73kli9dkmg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490e4mb1b0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:32:33 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-76a9a9326eeso7108026d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 03:32:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757673152; x=1758277952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EoZeu0gL7XFLE2oXZAdYX1fBkmSI6sTEmRZW+tG1M4Q=;
        b=vgXBuF75bflhVRCP8SBZ6vmiA0kmBpZRfqTb91g2r6qOB4RHISHMOXi6v6SgOHHluO
         keOXiuYXSsj0agfYBOxKAv2fugSO37xSIpQYSvmBcXUm26uC4upXVT9H28dq86Vel4CK
         9Ut0mii0w2hRMK49uRkCrVv9ewIckg81eaO1sn+lVYiZLM3q3aXRGLQrQkGUScTOsWml
         EV2nlb3MHVJo7U2aK7BdYch2KQIQZKZ/T7QRjumZKiAnoXW4LQUujdvVHdsvbceffm2v
         WNDImNurDSIrKorzqZd2t8JFgaqRtqhZIRX5NLlWpzbIj+upFgAac3KDNR48T5j5eN2T
         mCUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNroPblR6Ofxeg1cYmE4TBqgL4XokJkHd7614Mg1wNoNnX8n65lfWC7r0EQsvxKe8LzWMiluNmfSMVmyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjyquJqg9+FQn0uqhlcdgixdjgBjKJopIlQoNHHaT2m4KF3LWy
	HS6xCu5NaT/YnF4tV7rdgbNoDatb6y3gzWZbZ+hExMclAUmG1MAJbNQuYPyBFr9a4Ew44nwrKO1
	mD5+s6Uu25M5yLW0TyPeNq9fJlFFOFIZxD7wcxuQMfjRPvrk22wJoBPofOOSHo94nLDY=
X-Gm-Gg: ASbGncvaz026iIEpH+0loOyvHs8z/GLMT+4a1ZbIYe1e4PPfgMzY9Tpont4tVnAfB1z
	O5RFauza8MumQ9pbrQ7xohsGxCPW1rq3f/ru43LW6UHMDWymsX34zNAe8i/VhA5sSSFpqNoanWY
	qMFirhlrHw9qniGZnsJWkNfwwKVVmbakxvC8SO0ni0u7fsFTwQJp1dnhjIx10X7HMMRk9q3JRlh
	lJD6uagJXjUeCunVC6WxqtlvJQXS+ebrmgM682KjLAMAwc3aNQ27+r6MTLx+ShseDyParkDSMyl
	hRvCgfQst75fKhoKexR0xbBnlVx4nuxMRBJKCt/uTYtud2kgGihQ6vP+QaTw+pRN6Mf7s8dQMec
	2jDY36jnbaZcpmn4YXzrnNShpAqOQ269eIQqUvjrf9E/2yLH+8XB/
X-Received: by 2002:a05:6214:230c:b0:75b:f634:4a67 with SMTP id 6a1803df08f44-767bc026421mr29049046d6.14.1757673152235;
        Fri, 12 Sep 2025 03:32:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH65A47IPcjTGPJhYbtV51wn+vb+zZhqr0yJiBbHtP4GFqDciGEAz/Luthqfq7hIknGdaf0oQ==
X-Received: by 2002:a05:6214:230c:b0:75b:f634:4a67 with SMTP id 6a1803df08f44-767bc026421mr29048346d6.14.1757673150876;
        Fri, 12 Sep 2025 03:32:30 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e63c63c87sm1082936e87.69.2025.09.12.03.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 03:32:30 -0700 (PDT)
Date: Fri, 12 Sep 2025 13:32:28 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
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
        li.liu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Subject: Re: [PATCH v4 11/13] phy: qcom: qmp-usbc: Add USB/DP mutex handling
Message-ID: <nfugwwknnlxls75yo5rex6ggu5nzpq6enyx6e6nfnfei3icxjg@t7dnzcfcjw4o>
References: <20250911-add-displayport-support-for-qcs615-platform-v4-0-2702bdda14ed@oss.qualcomm.com>
 <20250911-add-displayport-support-for-qcs615-platform-v4-11-2702bdda14ed@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911-add-displayport-support-for-qcs615-platform-v4-11-2702bdda14ed@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzOCBTYWx0ZWRfXx+VwWnyEDKXv
 3QfYUBffSNw/ycnwTdoqtCSVlyXL2RZDBtscU1clPrhS9qW+k3FyHabGldBExpTpddpxDKF6mXa
 ke0BcD6LNKlaNhJiu/EmnR+6Ur2Knrm99+RVLsSTBZ+N8NF+Fv7maydDRbLFM6i/8ayvLah2yTP
 /cxTc5cqW0PZDkjhNfYKoqzBQTO2CNw5xdWzgohPxojcPW9MtAN4VtTr33mYT9M12JVmKRmqkYM
 2J05SbO3ItO119Anhhe0VT8k1aGhydIh948vZ7ed0kaAUm4q8tpFvm0A9CgwxeacOXHleXHwDrK
 +KMeYcyCsNbMuTNB98J4JQplJIbB2g6sd3GuBL7wwaYz7ZAP1+bizCd0CZloy+/2BjCT/xvARCf
 kCROblJ+
X-Authority-Analysis: v=2.4 cv=J66q7BnS c=1 sm=1 tr=0 ts=68c3f6c1 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=JLxk_RO0mVMWDHH2qmEA:9 a=CjuIK1q_8ugA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: oTloY1Kwz96wJ4s0gfkNcZ5rgUY4GOeW
X-Proofpoint-ORIG-GUID: oTloY1Kwz96wJ4s0gfkNcZ5rgUY4GOeW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_03,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060038

On Thu, Sep 11, 2025 at 10:55:08PM +0800, Xiangxu Yin wrote:
> Introduce mutual exclusion between USB and DP PHY modes to prevent
> simultaneous activation.

Describe the problem that you are trying to solve first.

> 
> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-usbc.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
> index 613239d15a6a3bba47a647db4e663713f127c93e..866277036089c588cf0c63204efb91bbec5430ae 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
> @@ -1061,6 +1061,19 @@ static int qmp_usbc_usb_power_off(struct phy *phy)
>  	return 0;
>  }
>  
> +static int qmp_check_mutex_phy(struct qmp_usbc *qmp, bool is_dp)

mutex has a very well defined use case - a sleeping lock. Please find
some ofther name.

> +{
> +	if ((is_dp && qmp->usb_init_count) ||
> +	    (!is_dp && qmp->dp_init_count)) {
> +		dev_err(qmp->dev,
> +			"PHY is configured for %s, can not enable %s\n",
> +			is_dp ? "USB" : "DP", is_dp ? "DP" : "USB");
> +		return -EBUSY;
> +	}
> +
> +	return 0;
> +}
> +
>  static int qmp_usbc_usb_enable(struct phy *phy)
>  {
>  	struct qmp_usbc *qmp = phy_get_drvdata(phy);

-- 
With best wishes
Dmitry

