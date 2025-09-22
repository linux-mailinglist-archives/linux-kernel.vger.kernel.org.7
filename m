Return-Path: <linux-kernel+bounces-827986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DED6B939DA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 01:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E593E7A57F4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 23:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D4B286883;
	Mon, 22 Sep 2025 23:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D3W6ofxA"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569591E502
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 23:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758584397; cv=none; b=OY3RgwM/uIcfxnL83ayxZNAtMk4lY9eafMJAOI9+tKnnndsh8bMFjdrew3hMacbJjqwq4VJUaZWsDUfh34Y25e1eBj8yyI9RCNZWIc8pXNol/nA5qQwpo4QhIz5sxjCOi32YxTaiSkLeqL0+Li1Fq3LSZ16IynWKe9rfvTTvOD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758584397; c=relaxed/simple;
	bh=00DvaK0h1Q9OJ62waEECpyMZZI+tqk1Cm+zAQuk1VsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U5WSH5WHxHrAOD0R1K5Qk9WHfPpqOKyFz/3LPoMgSrvyFYagvTcS/ZDZJEXyq9Fx5SK22ZWPO1JoYE2k4hDCbpXQFFBPyo6FBPpXoMynRzggNBMLHU/esgBdRDdYHc9urOpUflP8lVzo2Z8lSdf3QBVyBMVNkid8m74M9qkdwok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D3W6ofxA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58MH6ABR027935
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 23:39:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nyhMdld3iRwlOfrrEDiEApYehLCv9Ntzp5VmwS0Yvcc=; b=D3W6ofxAWgqgKf9U
	ektTvLlg9+CI08ZNS9v2rTbGb4dWAJZr4z5TO6J+XBcpEFCJyZU09pZ7SPaqpNtj
	Oq/wybhLS+QOt2Zly/SnQpdbDVtdvDtXGiyWuh5cN9/OT8qx3H6h++ZllUAIaKy8
	i6ND3+wi0UMs9UxFX1uDEZ9oknTZWREMtrm3T5KAyZeWHT+qRbqA3SrB1ChAoII5
	Ikt16RUh1dsBoIRh4NY1DSzbzs6FfCFeqrCHf9tzMevSzA4fyDA/f0eZHhZwKpXR
	ECE1TgkJxCqtDZAqeF6sRHfAnqwGi0n9H6KRQcgGqDPwBMiwoMsgleo44NNYJ6D0
	XGGRcw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bajery37-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 23:39:55 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-79a3c16b276so70117676d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 16:39:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758584394; x=1759189194;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nyhMdld3iRwlOfrrEDiEApYehLCv9Ntzp5VmwS0Yvcc=;
        b=ENOiziYOkt0Y2/cuThrFMilyCXiRh2BdAUWR1C7SMsuTZJX1hc775WeVsRntp41E2t
         KC8dlZ2tCE10rdoENk7nIFRcr8tjmFJ0P0vLY27QtLHsT08llVoy0C6UdlzyABJ12uqg
         BZWVtd29UG1ajc6YbpxIuKmBETmFeH0jEJzLkLMUj5GnUOhP/t81N5kQBjSNfWeu/Y5N
         XtvKNHZJGtGx+jNIqRk2Mbr3wzABxjkSqpc3RBcEDe7zFJhma32exh6c6BXAGeHOeo3a
         6NK+DfxsSBDMFkg5lureGoPsLQ898K1gcW6bZdLuZNs4y1SRos2NKKwEJbpjojvx2kET
         Vcog==
X-Forwarded-Encrypted: i=1; AJvYcCUR0fWjAmB5UKauwf2lIx5vuAplHEtKM5eTtp9qjbzelXOCQ6Q0orNGRZ+K3KkJvD3oaa44TzuJmltQpfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhPuOADP4HFF7LzAfDLjAKZJ1S44/7LjhXG2Qp07YePdDo4nzN
	JtGyLZlVKb3mV2N8Thu1U/JYixOTQJpzjrgp/lZUDa2DPxRgnLjDUxGPOHVk9qW9XkFJT9jbKfW
	xwzFT+0K8ddZw4eynoq0DZMyEGKlinIdRY65+ZqcMUyLbd24aFa+1XW+yUDfFcZQE0Bk=
X-Gm-Gg: ASbGncuoYfCPcAoHLk3wCOb850IiJxf8/+1VffhJ0ZRQIW1MoeQi+MUJyXEVgriLea+
	esfgw7sHByeESxZx+s99lAIawLnkJb6S3KxsCk65DZoqQIPckqA6rxMbd5q6aMTnW3Mm24kTsol
	/amQvZUGnQDuf9fDwQo4+oV+mHJ+YbYhF7XghNAC0M00BI4HuQOQiRa1WzxNoqEmGakArvK5N2a
	yMTPrHcSbyCjGao2Npia/VaW1tJnJb/qiR25Jm9XD8jKdz1dNRFbWjA/AWXnNOiyqp8viOI9x/E
	Vt04XsH+z00X+YBkN68MkiiM598hI14rnXqZbdhAuS0wA/4kdwpUrlJGUd1/RLnvGkoK2VcZYOq
	THqi4QlOb3iRyB9e0cOcJtYUVoOlPWZy9wQBLZuRp1+oMp76GhaCM
X-Received: by 2002:a05:6214:d62:b0:783:aeed:f591 with SMTP id 6a1803df08f44-7e6ff32ee4fmr9470076d6.11.1758584394090;
        Mon, 22 Sep 2025 16:39:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjwGj4dPuDuQgAOpaSc71GX0OUwUXDROsU0ay7TcyRk+yHVyKF7m4w7U22p4wZjnkRg5+6gg==
X-Received: by 2002:a05:6214:d62:b0:783:aeed:f591 with SMTP id 6a1803df08f44-7e6ff32ee4fmr9469836d6.11.1758584393538;
        Mon, 22 Sep 2025 16:39:53 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-57c5687103fsm1861749e87.52.2025.09.22.16.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 16:39:52 -0700 (PDT)
Date: Tue, 23 Sep 2025 02:39:49 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <rob.clark@oss.qualcomm.com>
Cc: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
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
Subject: Re: [PATCH v5 14/14] drm/msm/dp: Add support for lane mapping
 configuration
Message-ID: <t4x7okzjvh5ltyoniwlreoyy76735igtnxpeohpbojn4hkqk4q@v3ayfjrkez3e>
References: <20250919-add-displayport-support-for-qcs615-platform-v5-0-eae6681f4002@oss.qualcomm.com>
 <20250919-add-displayport-support-for-qcs615-platform-v5-14-eae6681f4002@oss.qualcomm.com>
 <j7ooyi5vih6ofnjigdgj6uk3ycutugunpm5pu5zf55pu5ua6r2@agg73zakjicn>
 <CACSVV00Bat6LE=joM+Wh3HnC1=c3_Y=crxUGdhLQWxxpZ17Q3g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACSVV00Bat6LE=joM+Wh3HnC1=c3_Y=crxUGdhLQWxxpZ17Q3g@mail.gmail.com>
X-Proofpoint-GUID: fKSG-hzJSaNMTBxGowZ9KF4rcfH6swas
X-Authority-Analysis: v=2.4 cv=fY2ty1QF c=1 sm=1 tr=0 ts=68d1de4b cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=yZMGBzM-AMQHzKZg3z0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDE2OCBTYWx0ZWRfX5wMAnwR7adna
 Fs5TUUoh8RjNss4ycSMBeahrID251BIrHlNMU/08gUwwnKYvGPZOqaUhpiWyLf9QcMQSEbNPgpq
 K2o7s//G9F2lUwj1HfhQGtnDUeY5aXQRSBbgIDJbcL/gltdiIAZt+XA+yJsbZGbLN5GfP3lYJtr
 Hgv4hgAta+FWUE+w6r9V4Ck1Tmwwrwto+yawhpZd5R/HpwXxLOOWNtFgWc7w8z94hQCjkqpz4jg
 omFUax20UF7fVKxso1ZFKHJAYqIGL5UDF3gaUTMiU/u1CQrGP+/1g0tfzJy0SFYEjPwxnIxw+v5
 7t1ZEEROOiRX36SXLL3j8AmHV4oGBQN1u7FFT/BUr3bfScSfgvxa2Etj9r95DROAsINP2/AHE7M
 ql7dVweg
X-Proofpoint-ORIG-GUID: fKSG-hzJSaNMTBxGowZ9KF4rcfH6swas
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_05,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220168

On Mon, Sep 22, 2025 at 08:13:00AM -0700, Rob Clark wrote:
> On Fri, Sep 19, 2025 at 11:35 AM Dmitry Baryshkov
> <dmitry.baryshkov@oss.qualcomm.com> wrote:
> >
> > On Fri, Sep 19, 2025 at 10:24:31PM +0800, Xiangxu Yin wrote:
> > > QCS615 platform requires non-default logical-to-physical lane mapping due
> > > to its unique hardware routing. Unlike the standard mapping sequence
> > > <0 1 2 3>, QCS615 uses <3 2 0 1>, which necessitates explicit
> > > configuration via the data-lanes property in the device tree. This ensures
> > > correct signal routing between the DP controller and PHY.
> > >
> > > For partial definitions, fill remaining lanes with unused physical lanes
> > > in ascending order.
> > >
> > > Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
> > > ---
> > >  drivers/gpu/drm/msm/dp/dp_ctrl.c | 10 +++----
> > >  drivers/gpu/drm/msm/dp/dp_link.c | 60 ++++++++++++++++++++++++++++++++++++++++
> > >  drivers/gpu/drm/msm/dp/dp_link.h |  1 +
> > >  3 files changed, 66 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/msm/dp/dp_link.c b/drivers/gpu/drm/msm/dp/dp_link.c
> > > index 2aeb3ecf76fab2ee6a9512b785ca5dceebfc3964..34a91e194a124ef5372f13352f7b3513aa88da2a 100644
> > > --- a/drivers/gpu/drm/msm/dp/dp_link.c
> > > +++ b/drivers/gpu/drm/msm/dp/dp_link.c
> > > @@ -1236,6 +1236,61 @@ static u32 msm_dp_link_link_frequencies(struct device_node *of_node)
> > >       return frequency;
> > >  }
> > >
> > > +/*
> > > + * Always populate msm_dp_link->lane_map with 4 lanes.
> > > + * - Use DTS "data-lanes" if present; otherwise fall back to default mapping.
> > > + * - For partial definitions, fill remaining entries with unused lanes in
> > > + *   ascending order.
> > > + */
> > > +static int msm_dp_link_lane_map(struct device *dev, struct msm_dp_link *msm_dp_link)
> > > +{
> > > +     struct device_node *of_node = dev->of_node;
> > > +     struct device_node *endpoint;
> > > +     int cnt = msm_dp_link->max_dp_lanes;
> > > +     u32 tmp[DP_MAX_NUM_DP_LANES];
> > > +     u32 map[DP_MAX_NUM_DP_LANES] = {0, 1, 2, 3}; /* default 1:1 mapping */
> > > +     bool used[DP_MAX_NUM_DP_LANES] = {false};
> > > +     int i, j = 0, ret = -EINVAL;
> > > +
> > > +     endpoint = of_graph_get_endpoint_by_regs(of_node, 1, -1);
> > > +     if (endpoint) {
> > > +             ret = of_property_read_u32_array(endpoint, "data-lanes", tmp, cnt);
> > > +             if (ret)
> > > +                     dev_dbg(dev, "endpoint data-lanes read failed (ret=%d)\n", ret);
> > > +     }
> > > +
> > > +     if (ret) {
> > > +             ret = of_property_read_u32_array(of_node, "data-lanes", tmp, cnt);
> > > +             if (ret) {
> > > +                     dev_info(dev, "data-lanes not defined, set to default\n");
> > > +                     goto out;
> > > +             }
> > > +     }
> > > +
> > > +     for (i = 0; i < cnt; i++) {
> > > +             if (tmp[i] >= DP_MAX_NUM_DP_LANES) {
> > > +                     dev_err(dev, "data-lanes[%d]=%u out of range\n", i, tmp[i]);
> > > +                     return -EINVAL;
> > > +             }
> > > +             used[tmp[i]] = true;
> > > +             map[i] = tmp[i];
> > > +     }
> > > +
> > > +     /* Fill the remaining entries with unused physical lanes (ascending) */
> > > +     for (i = cnt; i < DP_MAX_NUM_DP_LANES && j < DP_MAX_NUM_DP_LANES; j++) {
> >
> > Nit: i = cnt, j = 0; Don't init loop variables at the top of the
> > function.
> 
> These days we can party like it's c99 and declare loop variables
> inside the for(), instead of at the top of the function.  My
> preference is to do so, unless the loop variable is used after the
> loop.

Ack, works for me too. I think I'm not used for having theese parts of
C99 allowed in the kernel.

-- 
With best wishes
Dmitry

