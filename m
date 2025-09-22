Return-Path: <linux-kernel+bounces-827479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 57361B91DF0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 17:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 195BB4E26CD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A0F25F7B9;
	Mon, 22 Sep 2025 15:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ch1JZDV+"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726FF2836F
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 15:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758553995; cv=none; b=c9bfBUsKhb5ReCw9CvtCpPradg2+3jV+BMf3RMSQcRrUYUWK7Z8UW8hU2KtqAhN4AvQ6BfYkjELhNg/E6aX6gtW5v3g8Oeidnx/bX6JKCgpqXcmqZfKksFweE/kDGujg1N83GL4oYZuhc2r0xxw5ELka2ml8fhwoCqhVQuyTR94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758553995; c=relaxed/simple;
	bh=B5uTWUUwwDMXefPUA50NB4QAahXRqXQpp9CStVZIpOw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kOSnV2VNZKmEiBnB/O1pfr79XKcTpYbgIyWi1wblim2dSP1jFMSEubREovcn+SV4oipY5iFBSlmr86Thkt1ZS3iRhq1hCWeVqKowLAM455Ho6iNBxea627qYvmQ2IxmHoDQBs9wmN6zPzvGJ+lNB4Kv0SvDmLavFVGr+GnY6tTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ch1JZDV+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58M92XgO023868
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 15:13:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=6L9xQwPvNyqamZukUXThzBL99kp13JUWCh+pkhXMJs8=; b=Ch
	1JZDV+r8a/WgnKlOpaq43F9UXMaE7QwFKQFTc49dqHxNTCmTe3l+dGBTQN5/TPmM
	x39TiYYB18ZZuaM9vNEeWb+M4uOXoYafbF7ZwTD7q/BE14Sa6+odQIFtpSeUm101
	3x+01mzW4QBpFYlbrWORWQakdsbwSJ6C8MLXe1PfNGvdmD5BC/CS/HvHJOXlcXXN
	1rqTpD/saU4PxETzDxSYubavNCNOwKaJ1cMvEytGRhI6JAs8JszfAQgdtIakwr+7
	AC69IdlsFgwwKw91ZpvC++2o22NFJVAh75nm0JaLE4hWAbGUVeyjIWi9ua6WxXtU
	2cZJ8TH7K/nR9ngV2g3A==
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499mn7d6bv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 15:13:12 +0000 (GMT)
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-341451e05f1so1142000fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 08:13:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758553991; x=1759158791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6L9xQwPvNyqamZukUXThzBL99kp13JUWCh+pkhXMJs8=;
        b=ZJoi/GTVClv2idHHaIoRYyW5MTJU5gCbAY9nWH4+iRElVYFUVuWJXj+0KFTH3cEy16
         6fSAodKQH56gztztrTj0Oen43YokZmuO8EWUqNBpCkGxduEk2vLmLTxK14Kirlw+Mc21
         rGn7ceGRRLObRMt31QRbEnYW3Sg7gGD/qqmfN4BhunbjsHQK7nviixqx8XQlerX9ROcv
         rNBzK3mbZTmOry/w0ljLjx45WR8+5ZG92pwJYtFBpkenWzW2D5mfsiGjoPDPE3MVOHX3
         gwCdODwS3NzYhn8Eilzy2w3G3DwvFWLzAL/zQCPJheyZgiTlYTIfKOxz1QqA58U4uAHb
         uDug==
X-Forwarded-Encrypted: i=1; AJvYcCUHSmYMs78rNl2i+wupt/BQx+hre4Aoo4sHRfacApp7YxIShYDqPiM2DRwinSetGjzDT60fNFadSHYVsN0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj5bO/cp7dl6ymjLGDOes2rHaKMvibwm95vMJBFTGQh6aRr5FB
	hOJfdFuK9OoWx7xmeT4IXTgjJ1eemKJwjNugy5hh7Goiia2WukAScC2aIEraRuWNIJOG2bpXCnw
	0lg/FMqrSpDWAlpxBG4XGtA7U8anNHUC2H8FcPauRkCxu79RMqgUN2mlnXrY584POv3swj0jaAC
	IGML7ZerRtpRHGLJxqKCO36Ur1CLXg/Zx+MK4L6zPRqg==
X-Gm-Gg: ASbGncvMOunWopBq74rgQjgNpOK73J1z7aTsseAhe/2FuEEKVhfmKTateOJTWSePNmV
	p0o60Ia8GElYi5vQ0Pp57tU0m+Le0lPS45N9ZclDOiCHoqbyb6FIwcHEr8ayZem+Uu3o5Z9NR+a
	XFAOc8dCDpirF8356vwUWud4rs/AHveKf10Mg4YPZQC1zOXHVDjOig
X-Received: by 2002:a05:6870:d203:b0:321:27af:4b0 with SMTP id 586e51a60fabf-33bb387a8efmr7066561fac.21.1758553991363;
        Mon, 22 Sep 2025 08:13:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeI3VUzLWw/6kf7cmjW8nkegRTNOSrOJHdfgWLSr9Z07F+QepvdikPR1+KMJ0NepSDMgedO2i6ynxIGcy1040=
X-Received: by 2002:a05:6870:d203:b0:321:27af:4b0 with SMTP id
 586e51a60fabf-33bb387a8efmr7066517fac.21.1758553990880; Mon, 22 Sep 2025
 08:13:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919-add-displayport-support-for-qcs615-platform-v5-0-eae6681f4002@oss.qualcomm.com>
 <20250919-add-displayport-support-for-qcs615-platform-v5-14-eae6681f4002@oss.qualcomm.com>
 <j7ooyi5vih6ofnjigdgj6uk3ycutugunpm5pu5zf55pu5ua6r2@agg73zakjicn>
In-Reply-To: <j7ooyi5vih6ofnjigdgj6uk3ycutugunpm5pu5zf55pu5ua6r2@agg73zakjicn>
Reply-To: rob.clark@oss.qualcomm.com
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Mon, 22 Sep 2025 08:13:00 -0700
X-Gm-Features: AS18NWDsjwQT4-UMvgr22Kwg3NRpxj1iGVDde1kRYPcz2iKyW9TnGKIpG41ve0w
Message-ID: <CACSVV00Bat6LE=joM+Wh3HnC1=c3_Y=crxUGdhLQWxxpZ17Q3g@mail.gmail.com>
Subject: Re: [PATCH v5 14/14] drm/msm/dp: Add support for lane mapping configuration
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzMyBTYWx0ZWRfX05eL+OU2Wdaf
 jV0wIaS+inbFd+juIh9lGR+0QhHB7GXqRT1SaMKwYixXrOdZORotU6IQzAYJDoZ8hLQqIRZfUJd
 xc1GuPMu4rOtjeJjW5+5NWf5I7AdMaFx01xgxrKhnuXl1YVeqKhd8hmKEJkV9ToCGuHFvWawaX5
 AdCZHDvaPK/wLv8MQZL6mxf3CNRUEy0Exr4zUNxcvBmJtS9vb0HJxl3KK9hLn+Pi1tvoMUwgnQz
 w4EXnUaH5PNXSaDmgspvADYWmnNWYRUY8Q1Xy6qRdGFCsRWqG1EJE2nClKvD1V6SqcACkso4qXu
 cFOEDTMkwqUqbD3pcgrnAS+plT8w5pEcZ2ZW0nS4GKLt8RdkPardo1lZR8PSfnobb36ejAg0Fog
 zi6cY4SF
X-Proofpoint-GUID: 0je8DbeuR7orWEuYcmaMS6BMflaO3E56
X-Proofpoint-ORIG-GUID: 0je8DbeuR7orWEuYcmaMS6BMflaO3E56
X-Authority-Analysis: v=2.4 cv=EZrIQOmC c=1 sm=1 tr=0 ts=68d16788 cx=c_pps
 a=Z3eh007fzM5o9awBa1HkYQ==:117 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10
 a=EUspDBNiAAAA:8 a=Ck2O2MNpSjHhtJkipUsA:9 a=QEXdDO2ut3YA:10
 a=eBU8X_Hb5SQ8N-bgNfv4:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509200033

On Fri, Sep 19, 2025 at 11:35=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> On Fri, Sep 19, 2025 at 10:24:31PM +0800, Xiangxu Yin wrote:
> > QCS615 platform requires non-default logical-to-physical lane mapping d=
ue
> > to its unique hardware routing. Unlike the standard mapping sequence
> > <0 1 2 3>, QCS615 uses <3 2 0 1>, which necessitates explicit
> > configuration via the data-lanes property in the device tree. This ensu=
res
> > correct signal routing between the DP controller and PHY.
> >
> > For partial definitions, fill remaining lanes with unused physical lane=
s
> > in ascending order.
> >
> > Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
> > ---
> >  drivers/gpu/drm/msm/dp/dp_ctrl.c | 10 +++----
> >  drivers/gpu/drm/msm/dp/dp_link.c | 60 ++++++++++++++++++++++++++++++++=
++++++++
> >  drivers/gpu/drm/msm/dp/dp_link.h |  1 +
> >  3 files changed, 66 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/msm/dp/dp_link.c b/drivers/gpu/drm/msm/dp/=
dp_link.c
> > index 2aeb3ecf76fab2ee6a9512b785ca5dceebfc3964..34a91e194a124ef5372f133=
52f7b3513aa88da2a 100644
> > --- a/drivers/gpu/drm/msm/dp/dp_link.c
> > +++ b/drivers/gpu/drm/msm/dp/dp_link.c
> > @@ -1236,6 +1236,61 @@ static u32 msm_dp_link_link_frequencies(struct d=
evice_node *of_node)
> >       return frequency;
> >  }
> >
> > +/*
> > + * Always populate msm_dp_link->lane_map with 4 lanes.
> > + * - Use DTS "data-lanes" if present; otherwise fall back to default m=
apping.
> > + * - For partial definitions, fill remaining entries with unused lanes=
 in
> > + *   ascending order.
> > + */
> > +static int msm_dp_link_lane_map(struct device *dev, struct msm_dp_link=
 *msm_dp_link)
> > +{
> > +     struct device_node *of_node =3D dev->of_node;
> > +     struct device_node *endpoint;
> > +     int cnt =3D msm_dp_link->max_dp_lanes;
> > +     u32 tmp[DP_MAX_NUM_DP_LANES];
> > +     u32 map[DP_MAX_NUM_DP_LANES] =3D {0, 1, 2, 3}; /* default 1:1 map=
ping */
> > +     bool used[DP_MAX_NUM_DP_LANES] =3D {false};
> > +     int i, j =3D 0, ret =3D -EINVAL;
> > +
> > +     endpoint =3D of_graph_get_endpoint_by_regs(of_node, 1, -1);
> > +     if (endpoint) {
> > +             ret =3D of_property_read_u32_array(endpoint, "data-lanes"=
, tmp, cnt);
> > +             if (ret)
> > +                     dev_dbg(dev, "endpoint data-lanes read failed (re=
t=3D%d)\n", ret);
> > +     }
> > +
> > +     if (ret) {
> > +             ret =3D of_property_read_u32_array(of_node, "data-lanes",=
 tmp, cnt);
> > +             if (ret) {
> > +                     dev_info(dev, "data-lanes not defined, set to def=
ault\n");
> > +                     goto out;
> > +             }
> > +     }
> > +
> > +     for (i =3D 0; i < cnt; i++) {
> > +             if (tmp[i] >=3D DP_MAX_NUM_DP_LANES) {
> > +                     dev_err(dev, "data-lanes[%d]=3D%u out of range\n"=
, i, tmp[i]);
> > +                     return -EINVAL;
> > +             }
> > +             used[tmp[i]] =3D true;
> > +             map[i] =3D tmp[i];
> > +     }
> > +
> > +     /* Fill the remaining entries with unused physical lanes (ascendi=
ng) */
> > +     for (i =3D cnt; i < DP_MAX_NUM_DP_LANES && j < DP_MAX_NUM_DP_LANE=
S; j++) {
>
> Nit: i =3D cnt, j =3D 0; Don't init loop variables at the top of the
> function.

These days we can party like it's c99 and declare loop variables
inside the for(), instead of at the top of the function.  My
preference is to do so, unless the loop variable is used after the
loop.

BR,
-R

> Other than that:
>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>
>
> > +             if (!used[j])
> > +                     map[i++] =3D j;
> > +     }
> > +
> > +out:
> > +     if (endpoint)
> > +             of_node_put(endpoint);
> > +
> > +     dev_dbg(dev, "data-lanes count %d <%d %d %d %d>\n", cnt, map[0], =
map[1], map[2], map[3]);
> > +     memcpy(msm_dp_link->lane_map, map, sizeof(map));
> > +     return 0;
> > +}
> > +
> >  static int msm_dp_link_parse_dt(struct device *dev, struct msm_dp_link=
 *msm_dp_link)
> >  {
> >       struct device_node *of_node =3D dev->of_node;
>
> --
> With best wishes
> Dmitry

