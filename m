Return-Path: <linux-kernel+bounces-816872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF27B579B8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 850C416F82B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F43C301469;
	Mon, 15 Sep 2025 12:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="moxlKa93"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621F52FD1A5
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757937741; cv=none; b=lfn4N7/dRvr48STcLvuqzLRL7m4pPG7YI2yKBJUdRqqLxvS2he5dtlsG30n8jphDaJOVBGiTyL6b1oOb6PWsSGgTmKdRkiSx5EWdqh7RHyzW31r8a2LkyTEVK3cukXNty4Z5rFpPSJBw4+tPE3fx7QlOIVOdjFiJDQatQnLAvFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757937741; c=relaxed/simple;
	bh=Oo7O6bPRLLD3MAqlBMumXDbiGCVKFewvPrd138/93zY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pnmm72bV+2Tn7c0+FTDVX+VU5NpAW6zBD3Yl6JRydRya74qzBBnMtD5PxGKk8eBuNJc8dlQiWLh402GXzTuhwMj2tS7E8/Pr2lHKhw04e5wZxt/WvuuFfvNyn3ufUtZfamRjWC6xvV2fj217bgX/TsjIw9rg3+2spMXS8BsdjDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=moxlKa93; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58F8Fm1D027342
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:02:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IvAeXnBrUm3WtAxyNHUahdmztvfLEqQROq3blJbaPBE=; b=moxlKa93gMoU+EA+
	pPc8xR2QA7jLN4py33tSgd6PAQWu3exrp2osAqFc4rJh4hH3YVUl7p8Kd/06k6yf
	RUjEH/fMsY4C1A37rD4e8YJ/BfpqADJtaPT0wS2XQlvPp3yqLExlzDM/1lYUebxd
	z3hgvQQCpvp8RoVhF8/pYmeXr9h4+TY0U2WYlHB1Gyrpmuo57xcKt5u7LW8Jxr89
	1skN0wqWQkD8ydd0gnHU1xmQEW2V+K/ALZIdB4FleK/ZufdxfqIyeN6n779bczUT
	ZSk/Rn3YXBCr2p0pCjPWect+5M7WedM4awVW6QV32zvoeMQGySTYzCAeKTtJuK5D
	EXXoPw==
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 495072mtfe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:02:19 +0000 (GMT)
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-42407cbc8d1so7108625ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 05:02:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757937738; x=1758542538;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IvAeXnBrUm3WtAxyNHUahdmztvfLEqQROq3blJbaPBE=;
        b=pEVmHVnSZeePfMcxa6SwORhPszDBBYTz7CU78cfNXGDMg69iutJWNYusu7wcuoYQke
         gRAlH8hBmcBNQ8kmp258I5g9rbOsWKZJGHVnFKtrzrD7mh8irJRdWwgaQ3pI8n5ceF28
         5V5+c9MKPsXgbeEY5xoWWJux0zrbxpb92ySkUoByfXxpAwRKHd7QjFLpXBejFmiKdaQb
         HFlakloL3+v6xILlx1gyd/JHJq6YyiTdWunOwHzglyGrq+OvZBiu6LkELognBt+nkxrJ
         nABDSUyDUePDZDDDtbJqwH/g5d0x/rQEPN2hBgk81Z0HtfYWP13rf3EclSLMcOCb+aoa
         TR1g==
X-Forwarded-Encrypted: i=1; AJvYcCWvsJKZ/tUbPl/QhVfVSxFzptG56qef6N5nH7EtC8Vr+THbjddidKq0nvrqTVJ6U4Ii0Js6pr0liBWR16g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqlcNm2sRBfo2VKtwqutnOItFNatj6/gMnYW+0W9WwO568tB1v
	PgkAVoc3WGjsxia7Ik4CkIMPFetuFGNSsyVo2N5whmZPckuZ045dMLtm5NgpuJfMkO4AIz5wDjY
	wnZStH5NXKRjWjKYOSwNnXtnr8WHyrM0xyshr2ZpFk4pxz827j//oHOS8kMlFvTaio/0=
X-Gm-Gg: ASbGncsjYw9LPsBD5+k13Kbi42Ca0ID8UTuLFDCShhLKxBiVJOkSfcGtg1+pr8AMNSl
	6yaFLoq/TI4Yb9bgUgpKLvTGH/e1XH0ZbBuCdYg4BQej9IG2TulAyGbN2U91gTakhk5fTh75gR+
	fNBqBsjcH8+V/O/3R/0GWRKaXKe9xCDJWvIORT6aCeXGnyPP0WkHq98UZ2FFAj8prcyVbuy3xSH
	VRqA4GZk/kqPwz9Nd5RA+VF5KDVRUmuDwmi66prurswJCA5i7VI2WuCTp1z8duMOlQ1OwMbA/zd
	G57UaB0zsFbOQt9RFs639lY/l63cZYa4B9mpYTIECoEoqhLYshlem0BxSmqnPKroDmfA8tl6efs
	IY4iMQhjjzi0OxeAkPUYaYgMdW5OQY27lJxApE6R2lkg99QuigBh4
X-Received: by 2002:a05:6e02:3805:b0:424:db:3f52 with SMTP id e9e14a558f8ab-42400db43c7mr31984585ab.30.1757937737612;
        Mon, 15 Sep 2025 05:02:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwSFZp4+rn504zHIkvMkDte9o/xIPIokYa2nEOEEH2hcptgXuwuAlyF+4kk8sIPNl3j0f/aA==
X-Received: by 2002:a05:6e02:3805:b0:424:db:3f52 with SMTP id e9e14a558f8ab-42400db43c7mr31983785ab.30.1757937736970;
        Mon, 15 Sep 2025 05:02:16 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-353725e1bc6sm19307291fa.27.2025.09.15.05.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 05:02:15 -0700 (PDT)
Date: Mon, 15 Sep 2025 15:02:13 +0300
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
Subject: Re: [PATCH v4 07/13] phy: qcom: qmp-usbc: Add DP PHY configuration
 support for QCS615
Message-ID: <yvhj3blwga7dkc2cr5prc7covfcw5lrg56fptynn2j3pbmtrk3@el4qlbecbg2o>
References: <20250911-add-displayport-support-for-qcs615-platform-v4-0-2702bdda14ed@oss.qualcomm.com>
 <20250911-add-displayport-support-for-qcs615-platform-v4-7-2702bdda14ed@oss.qualcomm.com>
 <sy4kyh3kd6s4nr75unt5r6gxnyeqq6bfjj4tizwiw2fvbw4ala@i3theqmwiv3d>
 <1741620e-1f92-4db9-8135-965a96f12590@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1741620e-1f92-4db9-8135-965a96f12590@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAyNSBTYWx0ZWRfX2kdGuvWTGQPS
 xCyN/15pw3/NlfxcPCQ2FRsG59f5mRBawOlRq6C34Cz3IZmSlJHy2KN90P8OkoOmuArn+wWDBv5
 AZrNSaqLeUQkYQd+oUeAAuRjWy66mScD2QAgz5CIjzy7qEwL/lL8DoMssrJi1o8lsUIWjpoEiUO
 NzG5al8MGMwYpqgQQzRAK7u5HGONeWMtBg7oEcDbgTYuS3lzfasZucN/jyYhBzwUeZzziWKWYch
 hy2bu7g2ZG/jqWoG3SiuPUXkpk/dRtjeTXCS6aDSZwM2IcD/P+9NjGy/QjMVLvJWguQHQuflA0q
 e9zJpGeasGE6KjXSwSEP2IisSadHB/9evdsBlrZe0zFopyecjQbYKRU7an6JTSmVo+YPdW+6f4Y
 o8Ny76fs
X-Proofpoint-GUID: kqZfoAaACjfOZtVT5I0H86oTuZ8x49f-
X-Authority-Analysis: v=2.4 cv=WcsMa1hX c=1 sm=1 tr=0 ts=68c8004b cx=c_pps
 a=i7ujPs/ZFudY1OxzqguLDw==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=gzlAuExvAKsCTSaEeBUA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=Ti5FldxQo0BAkOmdeC3H:22
X-Proofpoint-ORIG-GUID: kqZfoAaACjfOZtVT5I0H86oTuZ8x49f-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_05,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130025

On Mon, Sep 15, 2025 at 07:29:08PM +0800, Xiangxu Yin wrote:
> 
> On 9/12/2025 6:12 PM, Dmitry Baryshkov wrote:
> > On Thu, Sep 11, 2025 at 10:55:04PM +0800, Xiangxu Yin wrote:
> >> Introduce DisplayPort PHY configuration routines for QCS615, including
> >> aux channel setup, lane control, voltage swing tuning, clock config and
> >> calibration. These callbacks are registered via qmp_phy_cfg to enable DP
> >> mode on USB/DP switchable Type-C PHYs.
> >>
> >> Add register define for QMP_DP_PHY_V2 series.
> >>
> >> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
> >> ---
> >>  drivers/phy/qualcomm/phy-qcom-qmp-dp-phy-v2.h |  21 +++
> >>  drivers/phy/qualcomm/phy-qcom-qmp-usbc.c      | 251 ++++++++++++++++++++++++++
> >>  2 files changed, 272 insertions(+)
> >>
> >> +static int qcs615_qmp_calibrate_dp_phy(struct qmp_usbc *qmp)
> >> +{
> >> +	static const u8 cfg1_settings[] = {0x13, 0x23, 0x1d};
> > Are these the actual values or is it a C&P from the combo PHY?
> 
> 
> These configurations are the same as those in combo, and I have compared
> that they match the downstream sm6150 project configuration.

Let's keep them as is, thanks for the confirmation that you checked it
against the vendor kernel.

> 
> From hardware programing guide, only defined AUX sequance with 
> DP_PHY_PD_CTL set to 0x3d and DP_PHY_AUX_CFG1 set to 0x13.
> 
> Shall I update table to {0x13} only?
> 
> 
> >> +	u8 val;
> >> +
> >> +	qmp->dp_aux_cfg++;
> >> +	qmp->dp_aux_cfg %= ARRAY_SIZE(cfg1_settings);
> >> +	val = cfg1_settings[qmp->dp_aux_cfg];
> >> +
> >> +	writel(val, qmp->dp_dp_phy + QSERDES_DP_PHY_AUX_CFG1);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >>  static int qmp_usbc_usb_power_on(struct phy *phy)
> >>  {
> >>  	struct qmp_usbc *qmp = phy_get_drvdata(phy);
> >>
> >> -- 
> >> 2.34.1
> >>

-- 
With best wishes
Dmitry

