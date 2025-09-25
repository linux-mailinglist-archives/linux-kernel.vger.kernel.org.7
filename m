Return-Path: <linux-kernel+bounces-833330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA11BA1AE9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 23:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A89E16792D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 21:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBED227B32B;
	Thu, 25 Sep 2025 21:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AJN3rzCS"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2205D19C546
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 21:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758837001; cv=none; b=DjQsUCRBg/EneFwfH3bomI4NhVw8+vXBaP44mdaRvEj3inHkHGIAK2eOOzbzyfOSb6t/At6jLLNMi4dh/+QufQ3LAGePPYBsWq/0RwlxgKEcnD8AQ5KbfnEkM7P+ANEwsZjQjGwPS89wegINcOi3FZ5ZIJ9ny/wcS1LTUar2pX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758837001; c=relaxed/simple;
	bh=JvB1YVXUJ/sRS9akglH2Uf9pFr6m6kOFJ7nwp5S1qzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IIIyjaTFp+yspG4igJichXq4fuYDPmYkDil3B43tFzGnqGIXl4iOfbJJ6hvT6j5PqHo4EjM4zNDALNZonmtK7OWtY7GbV6tHppwmUXubgjSZtsfdzuTPPT6JcBtqnl3z/voYoHPse8rf13DigbbseDXEI/c86ePz98Mo/6UmUFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AJN3rzCS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PIQUTn008143
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 21:49:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EsE8hUNPrzXdS3krzD+9JlR/Fl7R5Lniz8rFMY5V+pU=; b=AJN3rzCS3cwFnGSP
	nML/5pd++eAelWEQEPJIKHdHdwPsI+g58MPBYbHggsVcdb/MO9sPwWYDNmmW2EIa
	X+fmI+N1/gDPCCal3HZjc5LRJJmhupfLL/bbtSWtkWck8JUpibn0Ugftwk9xsDti
	vmihmNbNaidxcxU28ZGW9O9O3fytzq/jbuNlfrCfp8F3p9I+63XdHGJGijU6MuZy
	r6oFvpw7RiPn334EFQtIEv7TDdb9V97aFJ7BI8ilolbsDXpWMXEP3DEWNqJNeSPk
	07ISru1IvH3lpsn+O9gAvFpkU6xNT/1pN65B8lRwpd/fOovaK9Bu6XwCcSu8Zz9m
	jvb8aA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db0vrg22-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 21:49:58 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4d77ae03937so40371291cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 14:49:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758836998; x=1759441798;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EsE8hUNPrzXdS3krzD+9JlR/Fl7R5Lniz8rFMY5V+pU=;
        b=fQgHOUp1xWPxO7dx/+sDKZ3jToR2hpPCJJUHAj1dPhnh2aDMxFn63uQko7714nnNEA
         uaDVuldJJ7cIPfcHnHNQZBEjUxuf8HUrxw/dqGVesZgZkHvN3uYlVzAiZT3QUK9CXGbb
         j9YM6KrYm0foyOJ0e3tGF6197ubvjgN6hLKSkLNdUtgi4v7bxdPo1tf+7/reWMSfbPlu
         L4KZAPhMuORPhho/WgmEbN9VmXgT2nwDytJ9QlXhSSrlJok/8j4Tfgq/njvkbD7BYHTb
         dEdXrPcYT+MtTpj16eTq6OEQLmvE8kMq76O9wFtADuNPucDu/6OFL4iy1+6XNKfogVW3
         jQHA==
X-Forwarded-Encrypted: i=1; AJvYcCV/+vZYHzWJkAleQ5CimUXJwZfoUkOtAwDbd4p+rT2IN8+nrd0XCdCRIMcOaloE7kWg8yu1iQaHlxalRUM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx++quq/YnaY8I9C0hyiCHVdFGXgaFVXODjnvwXeY/GNHBBi53S
	sxvjBh2MUX4ZqSadxEUU45jMitspAUtz+HiZvhpBfKGaUH+2nTdRYzsw7hq0OYpyUz1gV5EFH9h
	AkqpCBg7JYMHBSenYi8kDWR+yf6OHWVHSUIWnjd9KNRc9CRsczK+wg09FVhI+9wuezv8=
X-Gm-Gg: ASbGncsoepM3HlppgAlY1mMWHfLY1dPzJpTYSNBSVOjUXIABvJZG0SuLiwYzNYlj9nJ
	MkB4+0KXCapWL/UVu5MrVYAB68C1PWlGgfD5drFdhOlGbhdd9TP+7uxfoz/FhCYVjbThUlO3Mmk
	LvS2Tal3IaUd8O5PJEfaScoAEI1hZjAkqasrtnPWM343bvBO2o9lCWGKo6H1b1Qo87NB8MYBf9I
	A572TJSwsfGs8gBUgjiY2z6iXUc2ErNrpYPQlciPtOVN/yLNMsKnb/1DpAJcNUOE8Jo3ne1H5lF
	5yQIg4xpVGUX4ha6nu3CLpUx+ALv3bItU3CRM3YArXkERFUIIxPVJFdg/gob3Y+8Qe3fFZdq+Y7
	pX2ccSStsWLhQSb8uhqC25eQugCc7BJJOSOH3Clg45DaenNIkjRtr
X-Received: by 2002:ac8:570b:0:b0:4d1:f8e7:e468 with SMTP id d75a77b69052e-4da4d3161e4mr68602671cf.69.1758836997955;
        Thu, 25 Sep 2025 14:49:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFV0QG5LOeu0iFHR+g6EDyvJ7468+R0ZRvi5JA5JE2Ojk3+XlsYVWWCMEwvumnpcEUb/6SRhQ==
X-Received: by 2002:ac8:570b:0:b0:4d1:f8e7:e468 with SMTP id d75a77b69052e-4da4d3161e4mr68602381cf.69.1758836997348;
        Thu, 25 Sep 2025 14:49:57 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5831665782csm1153941e87.86.2025.09.25.14.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 14:49:56 -0700 (PDT)
Date: Fri, 26 Sep 2025 00:49:54 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jun Nie <jun.nie@linaro.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 3/3] drm/msm/dsi: Support dual panel use case with
 single CRTC
Message-ID: <gmtcfmanngfrap5fl5622a46nstx662e7kfgvcf3jx7eqrm6qs@tpxarssvehkd>
References: <20250924-dsi-dual-panel-upstream-v3-0-6927284f1098@linaro.org>
 <20250924-dsi-dual-panel-upstream-v3-3-6927284f1098@linaro.org>
 <v3tfzspjck2oqppelx7bmi5uflhs47ixw6tjmq2d7inauzfo7k@gxebj3buyuni>
 <CABymUCMvczXHM-cOXNko77xDVxX8Q6MA2AEZcGx_Yg6TWosMAg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABymUCMvczXHM-cOXNko77xDVxX8Q6MA2AEZcGx_Yg6TWosMAg@mail.gmail.com>
X-Proofpoint-ORIG-GUID: UcIzHIr7rAZjp1n4BAZQ8-xeYwhJ9bqB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfX5CIF7Sjyqdzg
 ebhm1oSjLyc79/SBOmbRVZT2e3FEDRBVr3vwYT5g7VQV/ereBN6w4/IjB0yIWAESKvNuWyIhMLK
 tuqPdufufykEZT3AsTXiPZ/wFv2biEoG/Wp3nDV6DDkP/eVRnAUssq6uqs/KwNm3Wu0mbROETNM
 7izgfA3mMrZFdrEEsW9ML/RvVRMBz6cjNOGjK22OZxb/TJM5t1KluIwhMqSNX0sxuH+WHAM2x27
 3x+UyEUG74NUCR7oD5amSWw8ICuhkCmlsvvERYaKiWx4w5nPBlsyRjnsEwU+G+ztzWX9W+TBSzQ
 bAC6hcj5C0La4hXGDQTw2hFInF1J+E1vGaKNCd91yCqlDk/TsM+ljc2QtdAs5izNoebbcdM8GMA
 vPF1ovpRH1G1W3R2BaJApMIEDO6J6g==
X-Authority-Analysis: v=2.4 cv=OstCCi/t c=1 sm=1 tr=0 ts=68d5b906 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=sWKEhP36mHoA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=qXU7j4J-Xa07SXBApZgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: UcIzHIr7rAZjp1n4BAZQ8-xeYwhJ9bqB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_02,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509250171

On Thu, Sep 25, 2025 at 12:43:43PM +0800, Jun Nie wrote:
> Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> 于2025年9月25日周四 03:21写道：
> >
> > On Wed, Sep 24, 2025 at 11:08:12PM +0800, Jun Nie wrote:
> > > Support a hardware configuration where two independent DSI panels are
> > > driven by a single, synchronous CRTC. This configuration uses a bonded
> > > DSI link to provide a unified vblank for both displays.
> > >
> > > This allows application software to treat the two displays as a single,
> > > wide framebuffer with a synchronized refresh cycle, simplifying rendering
> > > logic for side-by-side panel arrangements.
> >
> > I'd like to understand how is it framed on the overall system design
> > level. If it's a panel controlled over the DSI interface, it's fine
> > since we can broadcast commands over two DSI links. What if the panel
> > (or bridge) is controlled via I2C / SPI?
> 
> You mean there is only DSI data and all configuration is done via I2C/SPI,
> right? I do not have a real use case so far, but it can be supported in the
> same way. Panel driver finds the sibling panel via device tree to get the
> peer I2C/SPI first. All commands are send to every bus in panel driver.

Not quite, because why and how should a normal DSI bridge driver know
and care about the 'peer' device? How would you describe that in DT and
in the DRM bridge chains framework?

> 
> >
> > >
> > > At the DSI host level, the frame width for each link must be that of an
> > > individual panel. The driver therefore halves the CRTC's horizontal
> > > resolution before configuring the DSI host and any DSC encoders, ensuring
> > > each panel receives the correct half of the framebuffer.
> >
> > >
> > > While the DSI panel driver should manage two panels togehter.
> > > 1. During probe, the driver finds the sibling dsi host via device tree
> > > phandle and register the 2nd panel to get another mipi_dsi_device.
> > > 2. Set dual_panel flag on both mipi_dsi_device.
> > > 3. Prepare DSC data per requirement from single panel.
> > > 4. All DSI commands should be send on every DSI link.
> > > 5. Handle power supply for 2 panels in one shot, the same is true to
> > >    brightness.
> > > 6. From the CRTC's perspective, the two panels appear as one wide display.
> > >    The driver exposes a DRM mode where the horizontal timings (hdisplay,
> > >    hsync_start, etc.) are doubled, while the vertical timings remain those
> > >    of a single panel. Because 2 panels are expected to be mounted in
> > >    left/right position.
> > >
> > > To maintain synchronization, both DSI links are configured to share a
> > > single clock source, with the DSI1 controller using the clock provided
> > > to DSI0 as below.
> > >
> > > &mdss_dsi1 {
> > >    assigned-clocks = <&dispcc DISP_CC_MDSS_BYTE1_CLK_SRC>,
> > >                    <&dispcc DISP_CC_MDSS_PCLK1_CLK_SRC>;
> > >    assigned-clock-parents = <&mdss_dsi0_phy 0>, <&mdss_dsi0_phy 1>;
> > > }
> > >
> > > Signed-off-by: Jun Nie <jun.nie@linaro.org>
> > > ---
> > >  drivers/gpu/drm/msm/dsi/dsi_host.c | 10 +++++++++-
> > >  1 file changed, 9 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
> > > index de51cb02f267205320c5a94fc4188413e05907e6..1fddcea7f86547258be18a51a0a3e3f96f6c3838 100644
> > > --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> > > +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> > > @@ -177,6 +177,7 @@ struct msm_dsi_host {
> > >       bool registered;
> > >       bool power_on;
> > >       bool enabled;
> > > +     bool is_dual_panel;
> > >       int irq;
> > >  };
> > >
> > > @@ -935,7 +936,10 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
> > >                       return;
> > >               }
> > >
> > > -             dsc->pic_width = mode->hdisplay;
> > > +             if (msm_host->is_dual_panel)
> > > +                     dsc->pic_width = hdisplay;
> > > +             else
> > > +                     dsc->pic_width = mode->hdisplay;
> > >               dsc->pic_height = mode->vdisplay;
> > >               DBG("Mode %dx%d\n", dsc->pic_width, dsc->pic_height);
> > >
> > > @@ -1609,6 +1613,7 @@ static int dsi_host_attach(struct mipi_dsi_host *host,
> > >       if (dsi->lanes > msm_host->num_data_lanes)
> > >               return -EINVAL;
> > >
> > > +     msm_host->is_dual_panel = dsi->dual_panel;
> > >       msm_host->channel = dsi->channel;
> > >       msm_host->lanes = dsi->lanes;
> > >       msm_host->format = dsi->format;
> > > @@ -2492,6 +2497,9 @@ enum drm_mode_status msm_dsi_host_check_dsc(struct mipi_dsi_host *host,
> > >       if (!msm_host->dsc)
> > >               return MODE_OK;
> > >
> > > +     if (msm_host->is_dual_panel)
> > > +             pic_width = mode->hdisplay / 2;
> > > +
> > >       if (pic_width % dsc->slice_width) {
> > >               pr_err("DSI: pic_width %d has to be multiple of slice %d\n",
> > >                      pic_width, dsc->slice_width);
> > >
> > > --
> > > 2.34.1
> > >
> >
> > --
> > With best wishes
> > Dmitry

-- 
With best wishes
Dmitry

