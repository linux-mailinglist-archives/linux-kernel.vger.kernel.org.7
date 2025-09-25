Return-Path: <linux-kernel+bounces-831652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D5EB9D3E7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 04:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D16841BC07F0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 02:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7EF2E6CBB;
	Thu, 25 Sep 2025 02:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oC6v6fJb"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F2C1C695
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758768903; cv=none; b=b204m3u4LWc/urGiuXIDZJ9X9KSpb0/JsNLq0lRMunt6ToK/mENuw8SHXTmjTEdITxOny/8GZMRoxMsYzj680z+GJ/fx7LPGIMGlwTuqATGJZgBF6gcduszM5Pk37ya/bLIzquOdKu7fL5gjKdTEaSbbe7/tBnJ4hqSi83OVqi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758768903; c=relaxed/simple;
	bh=GRzW2UTFXjkMbCv8ZuBiMaxnc7z24scaXvk2FiPQdfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RIKq1yhec2IUkLpT3ZX/+VqkAN+S45Enr/Itj3KuthN0oB/WXvITlnbiqmGBYa2EPiO0ddQqwFF0DdQkRrrBHIsxp/zd6kyKKOpqgfIHOUgj7tGfW7N22xlTTuLAuAglGMK0jYEmF43BZtFUQZOQYJ5TDB6hozUZecTjKXddBP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oC6v6fJb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P11N2M024516
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:55:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=5qc2kjNdpU+Ilinxlsz6Brx3
	M0lwHT1wZVUtKam6+GA=; b=oC6v6fJbG/C2Sv8NIRf1HC8NhJtgOv1kmlCBKK7V
	W6gZjv97Nth+siQt+Dp7WQb7vfjPWg4+m6Z8ZtbATMtkYqFjUCDeuTn2e1183bZP
	xfiv6fkvr8VrHLmzdfSl//F//rdC9/BlALYGlBZM78WMD4VYBatfJ3Tx0DBZxzci
	f7WMwWx5/Pfsd/MZILKCGUUQ60kkisntAJ3gmytOWKQxRoMv80PZXJxtBuW9UVvt
	SLYaJEccjYJHZbjM7CE5k6xzhfV+/iZyy7y4TzP40IQljR1Xqu1NQm9Y0uhAO57/
	gWa+ArYwrITDdyyiF4NYyNMvVsJB7L4QETVfbQM4x6gXvw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bwp0dhdy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:55:00 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4d77ae03937so13760481cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 19:55:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758768899; x=1759373699;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5qc2kjNdpU+Ilinxlsz6Brx3M0lwHT1wZVUtKam6+GA=;
        b=aTsvTzPHjPBlHT86Bhw9X7H9L8wvzsaNF+AcFJqiXmsYgNeoE1QOwYrldWuLzmRrq+
         JFXn4uLZDLeaeVOJ9sCLji/sbZlavOOKMVM0DRS05dJ/3QM6UjrofFYgY/1Y9LnRLTxQ
         tCRY04EGBErEW04/TftMu+odCsiOeHzViyYjUKVIy0gX7KyyDQW7Vh58pn5L6gLbWptr
         C1fQ3ByIJBAOF0uGF8fVDb+7gjs6FsWfqIsJzMLB3iLSJclE9/eH5D1nIPv0ES5xHCCQ
         V4+ObfDIRti8CzFhqNT9h4ieyA7pzLagrN4R+hkJ2w5UUPN2+h2R49177j5CCoj403SL
         oJhA==
X-Forwarded-Encrypted: i=1; AJvYcCUnvJP5HrbWbLws6ib4wpF06xgd/LnYJndFG5HjQ/4J+TN2DB91pO6uHfumurOgFU02J94bysS2g6OiK1M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6KsjXdFRwp4rLXO3khKWnE0NNHQYAwAAdhQp8gesprxevWBb5
	6lcf8FeF2C+aQnJyhaVPNllS7uztMLpcASU/dlhTkmjZPxMaoAgO6UjdIjACT6YE+1bS9EiqVn7
	agQh2+2+VO/bRiW9aB9Yx3niRg+Fn23m4Jf3nj3+k0LifKamW8nDjmIuit1Db3WKpOBvr1pqAhI
	4=
X-Gm-Gg: ASbGncsDfBz8DiO4EnXU4iZv+aSpAcxAsG1M/jdZgRfw+PrHeNOpgZgzkqHH/qUSzDM
	nwol/w2VZjEjKBIGJJCqwXeWVw0xMQkip933Yo+Tlk03aWmIft+FSeAb4tV0NR30hQ5uAnQbaMW
	QZ0feZvMiCd52wcjev0dLdZb8s0WF1CCdhkxFi9TafwWOsRP3FRySPBEZF2IgYlunt+/d5EeFPw
	qQPiToZX4R+ASfYbOF1B0p/Wt0kUjx3sIrQ3UI9QgZjYnwK/1BQxw+Y6d0ufAmMRkilj2hOhrUu
	VkbQQJwOtrNH9o2lUtLT0EodT+Y6NirBScVhzvo0dunB/8fUiVws0EFnH7bOBmJ8GjtqVvoQvPw
	NYKFkrlO2Pw7/qRFQinxsGPiBeCstXnU2dnMPPfaisLFabkB/EkUf
X-Received: by 2002:ac8:5f53:0:b0:4b7:9ddb:abbd with SMTP id d75a77b69052e-4da48c83c0fmr29976591cf.27.1758768899008;
        Wed, 24 Sep 2025 19:54:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+wX0KgM5CRfCAhfR9yvHW5QMrj5JET9e3yAt5sYvlw+SROD2nT79PnMZGnXjEN0cJtYx4zA==
X-Received: by 2002:ac8:5f53:0:b0:4b7:9ddb:abbd with SMTP id d75a77b69052e-4da48c83c0fmr29976331cf.27.1758768896998;
        Wed, 24 Sep 2025 19:54:56 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58316ff5f0fsm256240e87.135.2025.09.24.19.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 19:54:56 -0700 (PDT)
Date: Thu, 25 Sep 2025 05:54:54 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, kishon@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, robh@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 07/10] phy: qualcomm: qmp-combo: Update QMP PHY with
 Glymur settings
Message-ID: <oecyjwj7ouufjbiq2fpvlhhuaof5agm22fdsruf3ppayiu4kkm@wvi4no53x64y>
References: <20250925022850.4133013-1-wesley.cheng@oss.qualcomm.com>
 <20250925022850.4133013-8-wesley.cheng@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925022850.4133013-8-wesley.cheng@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=KNxaDEFo c=1 sm=1 tr=0 ts=68d4af04 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=bgMNcTsuivlx1WpOe6cA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: d5-VfOR_IGmI6-LXC-lbDEnRyugx9GJ7
X-Proofpoint-ORIG-GUID: d5-VfOR_IGmI6-LXC-lbDEnRyugx9GJ7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDEzOCBTYWx0ZWRfX/sLNFyiI3yZG
 Vx1zi007mIpulNo8Ade2//WK3rCWx/HhEi+Ynw7pzSbqa4eCAYjhaFesh2ltYdBtKO1kik/eKKw
 LQTDxAGvtb2vNiVDfMmbBnhho5ZeLJ6qe3vNjniDI28AW38m909jFYGrnTg2OVzASSPu6J2I/5y
 3PnnKxmJkmxQgrA2AsgAgFj+sJWAHcvyQbQZ8wDdjl3hKhciKqlxIg57HZzXt1FngEsilgoUJ4P
 2Px0991MUEF1GW6TJtBrib30B7iyESqUY2l8lkce3bC8I+uNEbtTySA+760Fd0f1D/cuJYuLPt9
 6PG5qtjIW4oJRZqVwDcei/Rm7hy8P8q6dg6r5A8JAo6ABF3x6TJj6WsorgKHUtD5X7CjvGY7wJM
 fy6Xsm5/
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 clxscore=1015 phishscore=0 suspectscore=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509230138

On Wed, Sep 24, 2025 at 07:28:47PM -0700, Wesley Cheng wrote:
> For SuperSpeed USB to work properly, there is a set of HW settings that
> need to be programmed into the USB blocks within the QMP PHY.  Ensure that
> these settings follow the latest settings mentioned in the HW programming
> guide.  The QMP USB PHY on Glymur is a USB43 based PHY that will have some
> new ways to define certain registers, such as the replacement of TXA/RXA
> and TXB/RXB register sets.  This was replaced with the LALB register set.
> 
> There are also some PHY init updates to modify the PCS MISC register space.
> Without these, the QMP PHY PLL locking fails.
> 
> Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 311 +++++++++++++++++++++-
>  drivers/phy/qualcomm/phy-qcom-qmp.h       |   4 +
>  2 files changed, 314 insertions(+), 1 deletion(-)
> 
> +
> +static const struct qmp_phy_init_tbl glymur_usb43dp_pcs_misc_tbl[] = {
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_MISC_PCS_MISC_CONFIG1, 0x01),

Why is this V4 all of sudden?

> +};
> +
> +static const struct qmp_phy_init_tbl glymur_usb43dp_pcs_tbl[] = {
> +	QMP_PHY_INIT_CFG(QPHY_V8_USB43_PCS_LOCK_DETECT_CONFIG1, 0xc4),
> +	QMP_PHY_INIT_CFG(QPHY_V8_USB43_PCS_LOCK_DETECT_CONFIG2, 0x89),
> +	QMP_PHY_INIT_CFG(QPHY_V8_USB43_PCS_LOCK_DETECT_CONFIG3, 0x20),
> +	QMP_PHY_INIT_CFG(QPHY_V8_USB43_PCS_LOCK_DETECT_CONFIG6, 0x13),
> +	QMP_PHY_INIT_CFG(QPHY_V8_USB43_PCS_REFGEN_REQ_CONFIG1, 0x21),
> +	QMP_PHY_INIT_CFG(QPHY_V8_USB43_PCS_RX_SIGDET_LVL, 0x55),
> +	QMP_PHY_INIT_CFG(QPHY_V8_USB43_PCS_RCVR_DTCT_DLY_P1U2_L, 0xe7),
> +	QMP_PHY_INIT_CFG(QPHY_V8_USB43_PCS_RCVR_DTCT_DLY_P1U2_H, 0x03),
> +	QMP_PHY_INIT_CFG(QPHY_V8_USB43_PCS_TSYNC_RSYNC_TIME, 0xa4),
> +	QMP_PHY_INIT_CFG(QPHY_V8_USB43_PCS_RX_CONFIG, 0x0a),
> +	QMP_PHY_INIT_CFG(QPHY_V8_USB43_PCS_TSYNC_DLY_TIME, 0x04),
> +	QMP_PHY_INIT_CFG(QPHY_V8_USB43_PCS_ALIGN_DETECT_CONFIG1, 0xd4),
> +	QMP_PHY_INIT_CFG(QPHY_V8_USB43_PCS_ALIGN_DETECT_CONFIG2, 0x30),
> +	QMP_PHY_INIT_CFG(QPHY_V8_USB43_PCS_PCS_TX_RX_CONFIG, 0x0c),
> +	QMP_PHY_INIT_CFG(QPHY_V8_USB43_PCS_EQ_CONFIG1, 0x4b),
> +	QMP_PHY_INIT_CFG(QPHY_V8_USB43_PCS_EQ_CONFIG5, 0x10),
> +};
> +
> +static const struct qmp_phy_init_tbl glymur_usb43dp_pcs_usb_tbl[] = {
> +	QMP_PHY_INIT_CFG(QPHY_V8_PCS_USB_LFPS_DET_HIGH_COUNT_VAL, 0xf8),
> +	QMP_PHY_INIT_CFG(QPHY_V8_PCS_USB_RXEQTRAINING_DFE_TIME_S2, 0x07),
> +};
> +
> @@ -1667,6 +1899,12 @@ static struct qmp_regulator_data qmp_phy_vreg_l[] = {
>  	{ .name = "vdda-pll", .enable_load = 36000 },
>  };
>  
> +static struct qmp_regulator_data qmp_phy_vreg_refgen[] = {
> +	{ .name = "vdda-phy", .enable_load = 21800 },
> +	{ .name = "vdda-pll", .enable_load = 36000 },
> +	{ .name = "refgen", .enable_load = 936 },

Is this a meaningful value?

> +};
> +
>  static const u8 qmp_dp_v3_pre_emphasis_hbr3_hbr2[4][4] = {
>  	{ 0x00, 0x0c, 0x15, 0x1a },
>  	{ 0x02, 0x0e, 0x16, 0xff },

-- 
With best wishes
Dmitry

