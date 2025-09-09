Return-Path: <linux-kernel+bounces-808033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7AE5B4AC58
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 675B83458CA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1AF32252E;
	Tue,  9 Sep 2025 11:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LcWLajU7"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D0C321F30
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 11:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757418031; cv=none; b=GuRMwLzO2vJ4as1Zu8torLTXZ5djUvUd/hqG1sPRnozJ4zZc/L6vRpPyfMjNAnUT1me/IJiZuU6jvB4gtQILjr7duhYm4r2NJ7rXDlq7YhQzu4fv2oHWwGqwHSzsS689oIEcQ5WRCxlGDCS8pLKzLurrwkSqzYnlqLih29sShSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757418031; c=relaxed/simple;
	bh=BOU4atm98zqe0exxJvBZhUOhA+KpqHaqcfoeWJi/b+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HTJaaXWk4cxvfgqCUZzRWusxTqwg5SIXZxx4h+uh5Od1KZpwCFmp9m/8wbUqD6jOtbSspVvcMSYjr5uZS7xb8P1pvbwG5BxSQ9Qo97TWLD1bBcUC6nafMF0M/2mx6uiljAJntprZ89XrT7zhb9IwoJx9YMADqbfmVglImuR82OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LcWLajU7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5899LT24031521
	for <linux-kernel@vger.kernel.org>; Tue, 9 Sep 2025 11:40:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=WkBZK4nX8r8AkRcyHEfLR0jL
	z865vmuc1R3ut1MxHM0=; b=LcWLajU7pmng9f5CC2hU8jnbi4VfEWJPLitPJqRq
	tVziE2UTN/VxVg5lJ0ZAtXP8Jf8K7mD34WvQcRwyxy/lCr/YKXaS449RDKOxhMoT
	ZeLbpGk4rCwv+leG6flx5+K7DT8VbvZg5gg2sdnEpsdl69IgnsG7aQFTKuWHMWja
	jqhy8pvG4MpwsjBkDQP5R98660muQp6JMZRy+1sowuJk/YOXYhMmHHuRFthLNMqP
	4XaD9UaJDYGdVTn4c0AXPMt45rZe0XOURiTjN9nh79hrEMzEepz24Jdqo9Iuj0Kc
	GHDXpdyjt/q5STE0wBgywjqv1KUuDjAbyUARZLPJLIye3w==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490bws85gn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 11:40:28 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-7296c012e7dso111268866d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 04:40:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757418027; x=1758022827;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WkBZK4nX8r8AkRcyHEfLR0jLz865vmuc1R3ut1MxHM0=;
        b=wfV8RLK1vAvmpDPfA56JEkz5b8B5Sn5477wwFoNfIgYXXI+y3lk2GRSNQ3xigz78Yp
         Htsj6d9c6QJQ6ljYeZDpybmUQIJIr4gBgMziKE2MLYXJlO5dpErBjCP5OUlo6cjiaZyh
         ZfOSD7/7Nb/ucHxv7hUxnCkty1cWTuUbthW3kyfnamZx0zKUpjXhGWir5jLbSsDm0VFj
         c62oJqMJhUIx6jXBEwLKeunhv2HctN+fgDCE1DUjVONWHjYB/XNrSXL0QWJwgqcGVi4X
         ZA0t9czaHV57F4yaJfZLbDLY9BRSZMGOPdI7PydgwzCJRqTPluWr9oKm6tXN1nndveyA
         a+HQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6wlz6HKK/qTrmJqsR3u2MzGYi3vStwY6hF4jFB6iOwLB4+weLx0mVeSKrvIEJk0HMeLM8uFPh0EDnb2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YztESDWWvpz2fzGRXcED/zneTNozS13Hrbp/zC3C62di3PaFa6i
	H36Hp8jhO/TD+1WGk9Yixl92wGTcCg6V2PVFx+Irw5eRL3uJoOVFakRULBbb86gYMMH2mjgWN/d
	60mIyRtZKlGI1cyDJs3nyHc64p4RcG2DFfG9PZE2f8QOa6Jhylq+4hiimGZl8uDbKUX8=
X-Gm-Gg: ASbGncvqKnQGZ+cZmz6YlaMJ6hQE8jln29FVyewbDpRwKY9I9ne/+EDImMZ+ujtWNHo
	ZnVfDtZzkkUSaml3tAkMLBhzdnmV+oy6gm5TsNBZphsqfAadRoQ3v4IBDAzLv98RNa6OTBdq9Yu
	g5J+YYYqfgp0UFLLN2vPbByAzMwcoNQLfnjl4k42DaQb6Tw50b3G2oJLLUG4EV6bU63BeJ1GGPE
	tb9JVWYWH9I30oLUF9v6h0Si6haFIG1oMqzimW/C5g3wQBBlNQUN2DWMBHIP6IQc7B6ZMi2/ibw
	DvyRn1AsvXNDOkMkLJGNxuWrUTI/mEoopD6ZlzcmttYDLQr0Cd57Hs54Lc74NNx370oZsz8he/D
	GRI3BzzoZtoMm/m53P3N9Ic3OhBDV3WTcVHNX1PUJWxs1gLPPM3Kp
X-Received: by 2002:a05:6214:5287:b0:734:c868:fb4c with SMTP id 6a1803df08f44-73944249693mr115542126d6.62.1757418027277;
        Tue, 09 Sep 2025 04:40:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1x5yuvHnnOA+bErPR7PqGkCxp1J6nz/QL7NqI2NRrDi1/NlaUQaX5MIKLRDoOyGf3VbZlEA==
X-Received: by 2002:a05:6214:5287:b0:734:c868:fb4c with SMTP id 6a1803df08f44-73944249693mr115541686d6.62.1757418026714;
        Tue, 09 Sep 2025 04:40:26 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-568180679a6sm474574e87.105.2025.09.09.04.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 04:40:24 -0700 (PDT)
Date: Tue, 9 Sep 2025 14:40:22 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Abel Vesa <abel.vesa@linaro.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] phy: qcom-qmp: qserdes-com: Add v8 DP-specific
 qserdes register offsets
Message-ID: <dq6hg2l6mseov3koisg5vsrkhifiwutlfy2phwaehvwzxxfgug@vgtcptgcopmw>
References: <20250909-phy-qcom-edp-add-glymur-support-v2-0-02553381e47d@linaro.org>
 <20250909-phy-qcom-edp-add-glymur-support-v2-2-02553381e47d@linaro.org>
 <3xw54kzk36u7zrfhgva4p577nzle3ctzi3lyhcxapczv2bhceo@23zcaylkqoff>
 <12ae186b-9816-4269-ab3a-7aacdc7cb954@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12ae186b-9816-4269-ab3a-7aacdc7cb954@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: 2fkp2rnM5ZSjq_Z4xlskj9Gln085yXZi
X-Proofpoint-GUID: 2fkp2rnM5ZSjq_Z4xlskj9Gln085yXZi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAxOCBTYWx0ZWRfX5KizElZT+HLf
 FqQIrlXTdSJP12RCWJxbhLRgDtfazYcntoyDHISfQyKXPgFpT32N9k5SuSIFrR1dPER9geEjz51
 AvXhVANx3cq+t3l2GdD1HIlD2YNJAxjuI+hsoD5yt0EGoNbTdLtYuLzPriilbwppeQt0gTBheUz
 8LpnoSp9a9IGRHwRabdXLOUFmPCShPLPce/CWXIjHOKXIdgghepS6e07Cz/dqQjb8hGXBufyOce
 mYgRVTB2r6ObgjiNj/04yGd5EQdwsDX5OPLQfawuPexDYtyxXKrs6dw8V7HQsDLQNukKv2sVEUX
 wFHBk0gSInsO6alRJRCWXKx989jUapT0CQdjoMRA9o+J23nHzPOsH5BypEkkKVxWBFxgjXspftZ
 1Gf8/7bj
X-Authority-Analysis: v=2.4 cv=G4kcE8k5 c=1 sm=1 tr=0 ts=68c0122d cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=pQyaD6lL6sn_3oYIr7sA:9
 a=CjuIK1q_8ugA:10 a=iYH6xdkBrDN1Jqds4HTS:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_01,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060018

On Tue, Sep 09, 2025 at 01:24:02PM +0200, Konrad Dybcio wrote:
> On 9/9/25 1:19 PM, Dmitry Baryshkov wrote:
> > On Tue, Sep 09, 2025 at 01:07:27PM +0300, Abel Vesa wrote:
> >> Starting with Glymur, the PCIe and DP PHYs qserdes register offsets differ
> >> for the same version number. So in order to be able to differentiate
> >> between them, add these ones with DP prefix.
> >>
> >> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> >> ---
> >>  .../phy/qualcomm/phy-qcom-qmp-dp-qserdes-com-v8.h  | 52 ++++++++++++++++++++++
> >>  1 file changed, 52 insertions(+)
> >>
> >> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-dp-qserdes-com-v8.h b/drivers/phy/qualcomm/phy-qcom-qmp-dp-qserdes-com-v8.h
> >> new file mode 100644
> >> index 0000000000000000000000000000000000000000..2bef1eecdc56a75e954ebdbcd168ab7306be1302
> >> --- /dev/null
> >> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-dp-qserdes-com-v8.h
> >> @@ -0,0 +1,52 @@
> >> +/* SPDX-License-Identifier: GPL-2.0 */
> >> +/*
> >> + * Copyright (C) 2025 Linaro Ltd.
> >> + */
> >> +
> >> +#ifndef QCOM_PHY_QMP_DP_QSERDES_COM_V8_H_
> >> +#define QCOM_PHY_QMP_DP_QSERDES_COM_V8_H_
> >> +
> >> +/* Only for DP QMP V8 PHY - QSERDES COM registers */
> >> +#define DP_QSERDES_V8_COM_HSCLK_SEL_1			0x03c
> >> +#define DP_QSERDES_V8_COM_BIN_VCOCAL_CMP_CODE1_MODE0	0x058
> >> +#define DP_QSERDES_V8_COM_BIN_VCOCAL_CMP_CODE2_MODE0	0x05c
> >> +#define DP_QSERDES_V8_COM_SSC_STEP_SIZE1_MODE0		0x060
> >> +#define DP_QSERDES_V8_COM_SSC_STEP_SIZE2_MODE0		0x064
> >> +#define DP_QSERDES_V8_COM_CP_CTRL_MODE0			0x070
> >> +#define DP_QSERDES_V8_COM_PLL_RCTRL_MODE0		0x074
> >> +#define DP_QSERDES_V8_COM_PLL_CCTRL_MODE0		0x078
> >> +#define DP_QSERDES_V8_COM_CORECLK_DIV_MODE0		0x07c
> >> +#define DP_QSERDES_V8_COM_LOCK_CMP1_MODE0		0x080
> >> +#define DP_QSERDES_V8_COM_LOCK_CMP2_MODE0		0x084
> >> +#define DP_QSERDES_V8_COM_DEC_START_MODE0		0x088
> >> +#define DP_QSERDES_V8_COM_DIV_FRAC_START1_MODE0		0x090
> >> +#define DP_QSERDES_V8_COM_DIV_FRAC_START2_MODE0		0x094
> >> +#define DP_QSERDES_V8_COM_DIV_FRAC_START3_MODE0		0x098
> >> +#define DP_QSERDES_V8_COM_INTEGLOOP_GAIN0_MODE0		0x0a0
> >> +#define DP_QSERDES_V8_COM_VCO_TUNE1_MODE0		0x0a8
> >> +#define DP_QSERDES_V8_COM_INTEGLOOP_GAIN1_MODE0		0x0a4
> >> +#define DP_QSERDES_V8_COM_VCO_TUNE2_MODE0		0x0ac
> >> +#define DP_QSERDES_V8_COM_BG_TIMER			0x0bc
> >> +#define DP_QSERDES_V8_COM_SSC_EN_CENTER			0x0c0
> >> +#define DP_QSERDES_V8_COM_SSC_ADJ_PER1			0x0c4
> >> +#define DP_QSERDES_V8_COM_SSC_PER1			0x0cc
> >> +#define DP_QSERDES_V8_COM_SSC_PER2			0x0d0
> >> +#define DP_QSERDES_V8_COM_BIAS_EN_CLKBUFLR_EN		0x0dc
> >> +#define DP_QSERDES_V8_COM_CLK_ENABLE1			0x0e0
> >> +#define DP_QSERDES_V8_COM_SYS_CLK_CTRL			0x0e4
> >> +#define DP_QSERDES_V8_COM_SYSCLK_BUF_ENABLE		0x0e8
> >> +#define DP_QSERDES_V8_COM_PLL_IVCO			0x0f4
> >> +#define DP_QSERDES_V8_COM_SYSCLK_EN_SEL			0x110
> >> +#define DP_QSERDES_V8_COM_RESETSM_CNTRL			0x118
> >> +#define DP_QSERDES_V8_COM_LOCK_CMP_EN			0x120
> >> +#define DP_QSERDES_V8_COM_VCO_TUNE_CTRL			0x13c
> >> +#define DP_QSERDES_V8_COM_VCO_TUNE_MAP			0x140
> >> +#define DP_QSERDES_V8_COM_CLK_SELECT			0x164
> >> +#define DP_QSERDES_V8_COM_CORE_CLK_EN			0x170
> >> +#define DP_QSERDES_V8_COM_CMN_CONFIG_1			0x174
> > 
> > The registers are the same at least up to this point. Would it make
> > sense to keep common part in the same header and define only those bits
> > that actually differ between DP and PCIe parts? (Is it really about PCIe
> > or is it eDP vs everything else?)
> 
> No, there's a wild amount of variation between various "v8" PHYs and this
> is impossible to catch by eye

I see. Let's see how it will surface later. For now:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

