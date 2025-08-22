Return-Path: <linux-kernel+bounces-781767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4566CB31678
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3627A0533C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91652F8BF9;
	Fri, 22 Aug 2025 11:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fefZzZ0s"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BF02F49FF
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 11:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755862796; cv=none; b=jU5T/N+8xHhG0ZjaSMHnJ26U+lS1Fp196Csv4B1vms775v9yAHoeL8mJF5iVvK84ufrH1//VH6vTsqe+7Evl0y9Dgfwh9AjkWIXv6OGDNrG8eCwEN5seONULmV0uRIybVyNEAtCplxrC950Cxy/A5UdEwKRd9Yxo4ViN6kADnh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755862796; c=relaxed/simple;
	bh=f1sfJBo9o9dJwhSGCcqMGBl3Mfx9Jh4l5ycFIjel2jU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=avaGdURAST7Y8CrCR9GTSjKFz+UV1MP0Mlek6Hd7crJM9jI8SArOfV33qfFblL/8nxCRP8oIhJZMPxjWlL5eoEah+j9CeZCdL5dyKytGj+S6adz8x4uasRG+zBs/iHvZ5HpVr8vcogYiD1Td1zCnDk00HJu/I3aN79HByiPCnj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fefZzZ0s; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M8UQBI006312
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 11:39:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=mFLMQVHg9cUjUEhLaX2Ovvk3
	EYltYMYiOOM3208zwIA=; b=fefZzZ0srzoPiQhmmzfGpi1DyaX9SAVzKXnhgT/d
	bV65ZO1PHEya7vwAm9CF/psxiTiQfLRHpeGZl0SbBuTCQZWo35ysFq+IYBuojt38
	bUK0n8xt7tTXm8bOl4BAqTeDbq95f3URJiFP/2zR1GZDLhSGzjBWhZQYvw5zrkLp
	0iCtOmSnuRh+DMrOFpakiwuTX0QV0IEoDZx6VfW4mMf9dU+LFnxbJV0lgHwOn2hL
	Hok9bVosGimlmduYCY3RJcAlNCJp/ZgMQQmf8ojs+TZEI45VFLiNf8k+GgtUItDb
	V+Sl0jGBcZPaRB7r8TO+9w5QCaSdSxPj142NH7NkyAn8iA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52911rd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 11:39:51 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e8702f4cf9so505073485a.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 04:39:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755862791; x=1756467591;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mFLMQVHg9cUjUEhLaX2Ovvk3EYltYMYiOOM3208zwIA=;
        b=sfcrhT8xwLPC2Do1fBSFMm2Wg5tbHoAK99wN1gMiy4WiVuXjj2ZHmJy7f0bxlTOVQH
         vdoGWUhLmMcq5gnp3Zh+yAr/bTkQTx2fujXSx1z0nAXyQsjV+S8Bi8f9DEJn32uOXcdC
         sqJB47VWX462QlkK8riAR09dpRrrhyOnEZRKZOWsSptX8D6i5p1wNu1jVhDZJbOxIGOx
         DSveNRcoLOH8ii870S7n01Y1boLObsfb+uHqwErLmy0GVBNsNI+ywRvWFGjrCxEUluV3
         0fYCvWLwdVks38WpI27PWRxeT6gh2cprncDbeSyeuDu6cPXjE+eO+Q1NUkvvo587Eso0
         5Ewg==
X-Forwarded-Encrypted: i=1; AJvYcCVW7Vn8EkyX63Leq5CyWcDvuM2mq3KG0gPMRO3nbJkG/WY0Eh8PhNFu+kTzbFeoO48YN5K6Q3oQmZhO5Fc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuL05JBaN3680M4i4hp6Z35+NZZiIagBy1wXXDb3ke2Lbel5Sz
	AXXegVaKTU6/Q16iQo2ubMDuZA/CfOnZSW6gY8hE8eEyZKvE5P8z/uRx5Mh9MBI+jxXrrjbBTsr
	4tsxJApNrHenKt3OcuUdl6GB/wphwk33KOc33E4roSQrHPP0QBH5SajenohKUWg/fDgg=
X-Gm-Gg: ASbGncsgiOEzZikba45PU6/xgkXrNzQMZwONIEkzxji5ykqqop3E9MzOfM23q+CyMTJ
	E7Pt0nN3S5GuenXJsCZstF/jyw2DJU1waFF72+K3H15j1NUX8qc/9RgBS5XYH04scrV5DZasz0z
	2ssaCvagr3DJlDo5L4jF5O9WNUbYHkl0kkYzj8R6DaN5d+xrWd0mFNq/gYClPYFm23kDCIxYuNH
	oi9WX0yLEoZV+wI5xBoASKnFsiGqWBq9yj+Sz7kUU98tkWtu87YHsaxuWjxYiFRjfFxDpfcZfZ3
	1lxAjmOS3Y9XMZ0vvbwOVpASsE18UINk21TbdEKZQns1n3sWasY6pWI48wEZC4dDtJ0yb4L+JeW
	IMDKCyCIhjL9F4klbFk8OHebP7nILPJWW1EP+d4Fdc8dYVfCJaoBm
X-Received: by 2002:a05:6214:d43:b0:70d:82f7:180e with SMTP id 6a1803df08f44-70d971ed40bmr37217076d6.50.1755862790494;
        Fri, 22 Aug 2025 04:39:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkbMfEBfr5OYFm9+slBBWnRivUg5jHHYuYw9w+zfkzG2JGT2dc4mFkYoJUMqOd72SEqiVvCw==
X-Received: by 2002:a05:6214:d43:b0:70d:82f7:180e with SMTP id 6a1803df08f44-70d971ed40bmr37216476d6.50.1755862789959;
        Fri, 22 Aug 2025 04:39:49 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3363b33a986sm4244671fa.48.2025.08.22.04.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 04:39:49 -0700 (PDT)
Date: Fri, 22 Aug 2025 14:39:47 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/3] dt-bindings: phy: qcom,sc8280xp-qmp-usb43dp-phy:
 Document default phy mode
Message-ID: <kxevo35c7tsbjeu4b7ep3f4eld5t4ohy35x4igaki6n7uvteev@ifotwczstsn3>
References: <20250821-topic-x1e80100-hdmi-v1-0-f14ad9430e88@linaro.org>
 <20250821-topic-x1e80100-hdmi-v1-1-f14ad9430e88@linaro.org>
 <yc7ceoq3bn3lkxdwkrk64ecubej64vblpwlwzyj5cuep2wmjui@nln2t2yicu7o>
 <018751b8-8b9c-4966-94e2-f3ec8625f87d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <018751b8-8b9c-4966-94e2-f3ec8625f87d@linaro.org>
X-Authority-Analysis: v=2.4 cv=fpOFpF4f c=1 sm=1 tr=0 ts=68a85707 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=shYPb7jLr3MzxgU6IIEA:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 4GqLXd3CVlyIBa-R-NaNOVqxzQNKIOGU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfXzbO8hyLhVzei
 CX9/SDC3VbiRRRa758LD/DXEowwjaJmc4R1nmL0n+YBN8peucxPx1UcxCiBOROtCD7zjw6FoelM
 rs4+9kGuofQIDAvsbqePq+pYQ/Xu7mPDugj2ADisbRYx7Vg+Dh4PZ2Fx6EyJiDpxYyZ2JAqjYAX
 MgrvrgH21tg8etP/OYnxVHD6vOREo++Fv5Jl12QBRJIVJw0T66zkvhSeRcKqaIhLJbOVaHsVf+K
 DUjbzSudp9ig9HumqxA5XdqvkI5Yz+52NtTXSdMx5KLNBjYHdbqKvFd66h3IZaL2v6JWIcKlw+z
 2j9M1s/Q5yOonOK5vQBYNlverB47kEaa/Kn9J1OK5NYLoWK7EWhDZYuKMaZiL9EGmO/4+yDKT92
 Kfw/X2t+Wk+zSNqfrcf5XJF/UaCyHQ==
X-Proofpoint-ORIG-GUID: 4GqLXd3CVlyIBa-R-NaNOVqxzQNKIOGU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 clxscore=1015 adultscore=0
 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

On Fri, Aug 22, 2025 at 01:02:21PM +0200, Neil Armstrong wrote:
> On 22/08/2025 12:57, Dmitry Baryshkov wrote:
> > On Thu, Aug 21, 2025 at 03:53:26PM +0200, Neil Armstrong wrote:
> > > The QMP USB3/DP Combo PHY hosts an USB3 phy and a DP PHY on top
> > > of a combo glue to route either lanes to the 4 shared physical lanes.
> > > 
> > > The routing of the lanes can be:
> > > - 2 DP + 2 USB3
> > > - 4 DP
> > > - 2 USB3
> > > 
> > > And the layout of the lanes can be swpped depending of an
> > > eventual USB-C connector orientation.
> > > 
> > > Nevertheless those QMP Comby PHY can be statically used to
> > > drive a DisplayPort connector, DP->HDMI bridge, USB3 A Connector...
> > > 
> > > But if a 4lanes DP->HDMI bridge is directly connected to the
> > > QMP Comby PHY lanes, in the default routing 2 or the 4 lanes would
> > > probbaly be USB3, making the DP->HDMI bridge non functional.
> > > 
> > > Add a property to hint in which layout mode the QMP Comby PHY
> > > should be as startup.
> > > 
> > > Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> > > ---
> > >   .../bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml         | 13 +++++++++++++
> > >   1 file changed, 13 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
> > > index c8bc512df08b5694c8599f475de78679a4438449..129475a1d9527733e43ded5a38aad766f9810fe7 100644
> > > --- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
> > > +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
> > > @@ -76,6 +76,19 @@ properties:
> > >     mode-switch: true
> > >     orientation-switch: true
> > > +  qcom,combo-initial-mode:
> > > +    description:
> > > +      Describe the initial mode of the Combo PHY configuration.
> > > +      The Combo PHY is a wrapper on top of a DP PHY and an USB3 PHY,
> > > +      sharing the same SuperSpeed lanes with either DisplayPort over
> > > +      the 4 lanes (dp), USB3 on a pair of lanes (usb3) or both
> > > +      technologies in a 2+2 configuration (usb3+dp) as default.
> > 
> > SPecifying this as an initial mode means that it can be switched later.
> > Should we generalize this and desribe it as bus-type (from
> > video-interfaces.yaml) and allow it to be present only if there is no
> > mode-switch property?
> 
> I was not sure about that, and yes we should do that instead but I'm not
> sure about how.
> 
> bus-type sounds great, but the numbering doesn't match so I was thinking instead
> something like phy-type with a string or use the numbers from include/dt-bindings/phy/phy.h

Well... we can add more entries there and map them in the driver.

> 
> The thing is, do we want to keep the dual dp+usb3 as static ? I think it's very possible
> a board would connect the combo phy to an USB3 A connector and a 2lanes DisplayPort connector.

I'm not sure I follow the question. Could you please explain what you've
meant here?


-- 
With best wishes
Dmitry

