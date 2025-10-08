Return-Path: <linux-kernel+bounces-845909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 291B3BC6788
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 21:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3F5F18935D0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 19:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58492690EC;
	Wed,  8 Oct 2025 19:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YW2qTIbP"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6100F26A0DB
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 19:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759951548; cv=none; b=kAag//ZNL+dbHYo0YRruDHzXMSpBWEjTUwbtHjBI3wwJoDQ9MrJCTm1s62Nt4TB2dbwX0lT5eQUIfKKH936cQ4VIroiBL6J3NAdPL7Xn/TTjw7E0ndg/JvVro1zIExTOa/YNlYHZJ5lW5aTcdB5833b5pL6JykRyEsliHIn8pkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759951548; c=relaxed/simple;
	bh=wF7FX+MKooFKcpVioZvIboqah4uI93BiDIm8X3C/Fak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=me5Tp/FAaMOCFuTQb1JTXk3+5j9JuMqwQgxBxj0o16IiJaQQR6C5ebUV1ibQgJCK13PixcJNRfFy9sQAZbeQkYi9fWOma1M2ww9+1ZJHLT8RpnHdsnYssEPeEy+XiKwd/NN0zxR5MVuHwJV12YGvANjuMYqlsHfrSOipE+ohD4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YW2qTIbP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 598I5vYT021234
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 19:25:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=5FFib/Un+fm0UChWoIvNR/aK
	HufV+fCUOptgdpGnyRE=; b=YW2qTIbPM4p8KUQBcJY1WJMKL43qYmd535U1G/WF
	mseiN7BiirF8ANGeqv47gcT3qbLQYJThX+/gzvelgLrwKT+0vVSHgVkjh4FZVTVR
	CDze0BgKqdSgwlFpyfjgzXDbuzZuryRSwMQKYow62gMAqWVe9L7O4W5nqHyT8dkE
	55s2mpQz+YIqyvNJMgZRbRB16zGB8Rdw9C0jnLPlpfnsOR8LLyb1rQj9ulbXgXFn
	qPxdpndBmFxP6fspbbQl9Hr+MhLXCRNQr+JYGf4e/Sgtk16z0m2LaIm4uaglcx/r
	MF31s1ME7JLVTTg5Hk9/O/I4LoiGrubD+Q70ykQSVvgiNw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4kgce4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 19:25:45 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4d6a41b5b66so6888101cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 12:25:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759951544; x=1760556344;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5FFib/Un+fm0UChWoIvNR/aKHufV+fCUOptgdpGnyRE=;
        b=f29Sc93um0XP4Nuc0uh8R6E7WRku596ktgoAgCh+ZSRpTrMznb7hjnpSEaiwDHL1cB
         MbQrJu0VRSVN2e1qg3+jXXpa9M0iTTsdpizCcOH0W9Cz63VQuj59KYvo53pYfTExKCKz
         v/M/zDTYDiHRfGadkOtX/KWxjY/2p87ZEGFz0SZBjZoYtNc5ffS4h22Pm+C9B6O8wul6
         WB/LKoRnxEMplREkE79Zv63WPXhDp+0uwPAmwrw+qSvbJIur3k5rwBrgrnVeDrrrFH11
         MEgatl5RrLpU8JJvUshz/ZHFmUe7npLWMK/hPdTj6Zh2fuuqef8Woa3QHdxQSJwcByBR
         hDcA==
X-Forwarded-Encrypted: i=1; AJvYcCVxRRIYAIXizk7zKzzUtnUMxHEOSjoxjmarK2Q1w9ONpdUCjmR0PGLYwcbHOBWKJw9mJC/n6H7/kL2EZhU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8vZM5T8aug2nDrQHLujrB9NXClCwmfm8JRLa0uMdj1vm1c00C
	9nP3JefjNVGGHlF4q69nd88auSU6/pzC/gJ/nApRG/O38kXwZkUdMyzNdzuvp/TpRwzW2NBJIvX
	uhUDLU9gylUInYr3PImePUFGWThhoS19BU5p0kZpfDF8U69kxgiOasVda6uIWopz2WiQ=
X-Gm-Gg: ASbGncufXlbK+5w36sHM8n70XuC0SyqHuF682/fGBnD+3NE3wD2oFD+zfmg0yxM7yBH
	YxCHVrA4sTXaRCCoRQyCFzYLEOCVY+Ss+6Je/73oUzqd1ueNRzIIS5YkHh2N/izq7YFgr8aJtRu
	Si1t6NrHGbAVRZ47rZLWsza0u4/cpoXv1bosFUyi0g2UqOPzyX/LbNEfMCskVq0KfAsMDHvNWdb
	G4UG63FNQpB2vfPWqXN81rNx9pHfrxPlp3hPUMQUORWYSL8H+1v3G4G0cLERB8JQhrcGh6Ca51l
	XJEK0AkNOEfl6eXUSGKRQPwqrF48mFLJ5W4Bb4vnbbMHoN5C0qhBBM8i0pFlop05Ta/9qeI2KFh
	rwdwIyqeuTzZhm1icB0mI8KS4sxRFtNpPn3PxlH2HPWzbPXuZowj4e/n5xQ==
X-Received: by 2002:ac8:7f81:0:b0:4dd:e207:fbe with SMTP id d75a77b69052e-4e6ead63344mr56475161cf.68.1759951543834;
        Wed, 08 Oct 2025 12:25:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFvT6+SeAUZgbncIUVE+m9s6rkb0Hrmb/CnGS8ndTfP4LoIjq+9senbSZ9FFieCiiwryrGkw==
X-Received: by 2002:ac8:7f81:0:b0:4dd:e207:fbe with SMTP id d75a77b69052e-4e6ead63344mr56474481cf.68.1759951543152;
        Wed, 08 Oct 2025 12:25:43 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5907adaaff0sm272423e87.88.2025.10.08.12.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 12:25:41 -0700 (PDT)
Date: Wed, 8 Oct 2025 22:25:39 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] media: iris: enable support for SC7280 platform
Message-ID: <gdui5coiazt5ynuz6c6mr5slau33vuewr55vx53m5zzyi537at@cs7dbgirijuw>
References: <20251008-iris-sc7280-v1-0-def050ba5e1f@oss.qualcomm.com>
 <20251008-iris-sc7280-v1-8-def050ba5e1f@oss.qualcomm.com>
 <3f1979d4-1438-4c9d-99db-d97a09c5c35b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f1979d4-1438-4c9d-99db-d97a09c5c35b@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=dojWylg4 c=1 sm=1 tr=0 ts=68e6bab9 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=-ppHQGl4qNkU3gb9WSAA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: E9fVu9Bp_uFTqoSb4dW3BH7xwU2p-Qhp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX2eAiIvdn1Q7q
 ySzTYRMq1q/H7sS9nZ9/SvYvyUv+GGz1SCV+ED4fPvpEBHOCVl4RFWVTM9wE4Nn1+mwEB9OuLgX
 EbMCl5/T03q/EdnkpfyHVUsft6eV3r37uoHJhyWbiJi3R+hNsNyuCznNl8NBS+bD93FOCU8Avi6
 gs/RACpwPnvbpcMN4khW4/BSvVv7D0i0wZxC818Dsgr7LPQnsqJ0qBSnGa9T/zwp0yjZ+Jev30v
 O10aS2OS8wBoa5sCNCFTRrHPoLHAlKqxTROQd59sBsg0B5/1aoVoci1p7T7dge8B/+9B7dKbUeP
 hHLXA+RwHTwbnGk5xE+sBUfGVxxG2NRCznNJTcyczK7/NAt8E9/Yf4Flw9a0/O8IdMxtzNC3aZt
 vDBOzxYsb+wTF8jKusUsoGzCybeauQ==
X-Proofpoint-ORIG-GUID: E9fVu9Bp_uFTqoSb4dW3BH7xwU2p-Qhp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

On Wed, Oct 08, 2025 at 10:26:02AM +0200, Konrad Dybcio wrote:
> On 10/8/25 6:33 AM, Dmitry Baryshkov wrote:
> > As a part of migrating code from the old Venus driver to the new Iris
> > one, add support for the SC7280 platform. It is very similar to SM8250,
> > but it (currently) uses no reset controls (there is an optional
> > GCC-generated reset, it will be added later) and no AON registers
> > region. The Venus driver names this platform "IRIS2_1", so the ops in
> 
> Which we've learnt in the past is "IRIS2, 1-pipe"

Well, I'm open for better suggestions. iris_vpu2_no_aon_ops?

> 
> > the driver are also now called iris_vpu21_ops.
> > 
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > ---
> >  .../platform/qcom/iris/iris_platform_common.h      |   3 +
> >  .../media/platform/qcom/iris/iris_platform_gen1.c  |  66 +++++++++++
> >  drivers/media/platform/qcom/iris/iris_probe.c      |   4 +
> >  drivers/media/platform/qcom/iris/iris_vpu2.c       | 130 +++++++++++++++++++++
> >  drivers/media/platform/qcom/iris/iris_vpu_common.h |   1 +
> >  5 files changed, 204 insertions(+)
> > 
> > diff --git a/drivers/media/platform/qcom/iris/iris_platform_common.h b/drivers/media/platform/qcom/iris/iris_platform_common.h
> > index 104ff38219e30e6d52476d44b54338c55ef2ca7b..36e33eb05a6918de590feca37b41c07a92e9c434 100644
> > --- a/drivers/media/platform/qcom/iris/iris_platform_common.h
> > +++ b/drivers/media/platform/qcom/iris/iris_platform_common.h
> > @@ -42,6 +42,7 @@ enum pipe_type {
> >  };
> >  
> >  extern const struct iris_platform_data qcs8300_data;
> > +extern const struct iris_platform_data sc7280_data;
> >  extern const struct iris_platform_data sm8250_data;
> >  extern const struct iris_platform_data sm8550_data;
> >  extern const struct iris_platform_data sm8650_data;
> > @@ -50,7 +51,9 @@ extern const struct iris_platform_data sm8750_data;
> >  enum platform_clk_type {
> >  	IRIS_AXI_CLK, /* AXI0 in case of platforms with multiple AXI clocks */
> >  	IRIS_CTRL_CLK,
> > +	IRIS_AHB_CLK,
> 
> Interestingly, 8250 also has an AHB clock, but the clock driver keeps it
> always-on..
> 
> >  	IRIS_HW_CLK,
> > +	IRIS_HW_AXI_CLK,
> 
> This exists on SC7280 and SM6350, perhaps as a result of the bus topology

These parts are still a bit unclear to me (as well as resets usage for
sc7280).

> 
> >  	IRIS_AXI1_CLK,
> >  	IRIS_CTRL_FREERUN_CLK,
> >  	IRIS_HW_FREERUN_CLK,
> > diff --git a/drivers/media/platform/qcom/iris/iris_platform_gen1.c b/drivers/media/platform/qcom/iris/iris_platform_gen1.c
> > index 2b3b8bd00a6096acaae928318d9231847ec89855..d5288a71a6a8289e5ecf69b6f38231500f2bf8b4 100644
> > --- a/drivers/media/platform/qcom/iris/iris_platform_gen1.c
> > +++ b/drivers/media/platform/qcom/iris/iris_platform_gen1.c
> > @@ -364,3 +364,69 @@ const struct iris_platform_data sm8250_data = {
> >  	.enc_ip_int_buf_tbl = sm8250_enc_ip_int_buf_tbl,
> >  	.enc_ip_int_buf_tbl_size = ARRAY_SIZE(sm8250_enc_ip_int_buf_tbl),
> >  };
> > +
> > +static const struct bw_info sc7280_bw_table_dec[] = {
> > +	{ ((3840 * 2160) / 256) * 60, 1896000, },
> > +	{ ((3840 * 2160) / 256) * 30,  968000, },
> > +	{ ((1920 * 1080) / 256) * 60,  618000, },
> > +	{ ((1920 * 1080) / 256) * 30,  318000, },
> > +};
> > +
> > +static const char * const sc7280_opp_pd_table[] = { "cx" };
> 
> Wonder why this is different..
> 
> Oh, I can bet good money SM8250's Venus isn't fed off of MX alone..
> 
> Let's check the sauce..
> 
> It was always supposed to be M*MC*X with MX just for the VIDEO_CC
> PLLs..
> 
> [...]
> 
> > +/*
> > + * This is the same as iris_vpu_power_off_controller except
> > + * AON_WRAPPER_MVP_NOC_LPI_CONTROL / AON_WRAPPER_MVP_NOC_LPI_STATUS programming
> > + * and with added IRIS_AHB_CLK handling
> > + */
> > +static int iris_vpu21_power_off_controller(struct iris_core *core)
> 
> This is 1 : 1 the existing sm8250 code except...> +{
> > +	u32 val = 0;
> > +	int ret;
> > +
> > +	writel(MSK_SIGNAL_FROM_TENSILICA | MSK_CORE_POWER_ON, core->reg_base + CPU_CS_X2RPMH);
> > +
> > +	writel(REQ_POWER_DOWN_PREP, core->reg_base + WRAPPER_IRIS_CPU_NOC_LPI_CONTROL);
> > +
> > +	ret = readl_poll_timeout(core->reg_base + WRAPPER_IRIS_CPU_NOC_LPI_STATUS,
> > +				 val, val & BIT(0), 200, 2000);
> > +	if (ret)
> > +		goto disable_power;
> > +
> > +	writel(0x0, core->reg_base + WRAPPER_DEBUG_BRIDGE_LPI_CONTROL);
> > +
> > +	ret = readl_poll_timeout(core->reg_base + WRAPPER_DEBUG_BRIDGE_LPI_STATUS,
> > +				 val, val == 0, 200, 2000);
> > +	if (ret)
> > +		goto disable_power;
> > +
> > +	writel(CTL_AXI_CLK_HALT | CTL_CLK_HALT,
> > +	       core->reg_base + WRAPPER_TZ_CTL_AXI_CLOCK_CONFIG);
> > +	writel(RESET_HIGH, core->reg_base + WRAPPER_TZ_QNS4PDXFIFO_RESET);
> > +	writel(0x0, core->reg_base + WRAPPER_TZ_QNS4PDXFIFO_RESET);
> > +	writel(0x0, core->reg_base + WRAPPER_TZ_CTL_AXI_CLOCK_CONFIG);
> > +
> > +disable_power:
> > +	iris_disable_unprepare_clock(core, IRIS_AHB_CLK);
> 
> ..for this line

Not only. You missed the absense of AON_WRAPPER_MVP_NOC_LPI_CONTROL /
AON_WRAPPER_MVP_NOC_LPI_STATUS. Which in theory can become a flag in
iris_platform_data.

> 
> but this could be added to that one instead, since both clk APIs and the
> Iris wrappers around it are happy to consume a null pointer (funnily
> enough this one returns !void and is never checked)
> 
> similar story for other func additions

In fact, initially I had them merged, but then I couldn't find an
elegant way to handle AON regs. I can squash them back, if that's the
consensus. Any idea regarding AON regs?

-- 
With best wishes
Dmitry

