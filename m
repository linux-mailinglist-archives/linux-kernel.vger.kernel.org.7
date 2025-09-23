Return-Path: <linux-kernel+bounces-828248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07230B94410
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 06:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B06AB17FD00
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 04:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2858430CB41;
	Tue, 23 Sep 2025 04:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Bl+LV8UH"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830BD1EA6F
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 04:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758603124; cv=none; b=jjViFv35N9C4NJkqDQiRsbANXmLJogTofSCb77OQMNm52dG5d0snHT56kKQ2bNr/1T7KW/L4Ivg4Lhg4eaJSsMGwu5iJXrz0YN9wXaMh+ovWj2O/7D7vVCTB4qo22wLFxlvfjxpTFLndIW+LMzvYcmlL7gaCzJ3S2XugkF0cp98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758603124; c=relaxed/simple;
	bh=JmRU2x/amfn1zRvRYJcYLMEDdZ4yl+KncZK9Oj8xJ5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U1KBu8h3ku552AkqIU+ItGMdl62Hgub56KODJLPwAuZXgnBWO3MgPwK7Vmoqj5++uRo2w6Rxwg8ns8WX8QfKCjaBHs92+TQm0KhETSij9bWju6ZllPG9JpJp0l4KNstINs1w22/aJlEsSaaoeN3RxflUFjGl9Se9ceBIzJN6W+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Bl+LV8UH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58N4VmvK012079
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 04:52:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1ysyyR+HSBxqCI8FuQWOZHxXbhAf2dscJgNWIhtU+ys=; b=Bl+LV8UHw8nBOeNg
	NQIkWQ/9ghyTSiJpE5s3ltpVJJsx54k2D57hFQg0RSns3glajhRuY9DHDsdHNr7z
	8/Iun4mHhE1YK7M8Y743Mh9rZilV7wAynsNrbt/ATzPy0BNYMzi0plv+VFySLZl0
	YDo+hK6a/y7hmmRc+2AuKr8RmiPAME+hyuztfZbtK6us+/K4HW+XfwSqRqAS8F+h
	+pqyfOw1pcveSMNnazD3JxfhKfPmeutiJFyK6UCOOa040okTLj6ULcvLTiuWqd69
	41Iome+o+KiZfvuPyASZP5AkD/ztoycFxi+7hmuWQpFYAvFedC2EB9xxeFbVMbAH
	8+zQLw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499kv0y6m2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 04:52:01 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-84b9c23b8aeso343453485a.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 21:52:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758603120; x=1759207920;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1ysyyR+HSBxqCI8FuQWOZHxXbhAf2dscJgNWIhtU+ys=;
        b=vJnxWpKhx+r69zUJ5CZc2dt5Smfq+tx4Y1mMiTE34Z5xAXZJb6aRn5xIeqvaMtzoF4
         d7x27He67YTcEq+XE8c/+urrURgN8pzzPSYtLbCuufEl6RSGZR4P4Y8eVuwY6tzRbHkH
         RcDHOwTq2dlQdWOKi0Ehonw++y49A+//O8dmp/uwFQKjF4dIA9JZI1u+eJVNMdsy95zV
         lZk8ymHogymip0nW/15FDxVSXZiu7mhLxIKW6qeWQtuxvdTR98jYjxpTXgik++086rba
         PRpya2f5CXrZtL0Jzjr6VLUkjpSCR76DJi/DAKtVGhDye7/MSXZfocSw1mcqm9nwJoQA
         58YQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaHI91V5jd7FQ8z/ffLYOGf0K9XbWB3sh9MkGPG06jnC190F28I0LSZsdU3suOyUOA+PVlnO1eDzmh3U4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+3lmHT2hF9mSiGVAqQ1x4tPr6nYvEJ0BMjA4GlueuBjy3ptEF
	p/26kbKp0p5GW++aV8oOGA4Vla9p+ll24GJ6pnhMfTabUrcvBry0t7fxQo5DQesQtP3w+HFTQh2
	T44Tu0vEv1OshRcVjxp+rv06JUyxVNu/yZ9L5UzZ1d2SNsYDxI03rl44ZBtr13Ldjx0c=
X-Gm-Gg: ASbGncs5b8oYxDyJMij7xGU0qsNxA8G0simdrujr6EYQZwQAZ6uFNjwYhGM0FqpMUEd
	/4Mr9i93Qsk6Prr6Jgt3pS76YMNnSeMbESzikgZdRLJEz6BTPK4whL/e/caG/uND2fLPlgmWJTZ
	DLSsXVa7sDPexCuwyfn0E8mrY+hbAm+s7T9R5+FZZ1gYpUGHTSNo8qkF9JMrYdCeEC/LWn+mBFO
	JdFV0PiYycPLtUO60h16QZgAKVdfGm6yIyAzvmluB2C+7xwrat4Wbm6WiClScD+f1+xsq649VOk
	46Nigo/uZWGICLefNb8Hfcptj0sQyCaT03la41kh4qEI7pmIXnAPQzNojo7eIGdz1Yywucr2D3U
	05nOnxdm8KmjQEanTuKPZtT7rqyrHDeDW34U69ashZ0C8lAibiO3A
X-Received: by 2002:a05:620a:1923:b0:812:48b9:2eb0 with SMTP id af79cd13be357-8516a8202bamr136831685a.19.1758603120300;
        Mon, 22 Sep 2025 21:52:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKxvB+ebtnxiMgBizv494obsHW1ZlzjCI32T27z/Odi7Kl2wEkCUAGK1+a+EPj6Wq2e5gDkQ==
X-Received: by 2002:a05:620a:1923:b0:812:48b9:2eb0 with SMTP id af79cd13be357-8516a8202bamr136828685a.19.1758603119745;
        Mon, 22 Sep 2025 21:51:59 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-365694f1be4sm23536661fa.17.2025.09.22.21.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 21:51:58 -0700 (PDT)
Date: Tue, 23 Sep 2025 07:51:55 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Chaoyi Chen <chaoyi.chen@rock-chips.com>
Cc: Chaoyi Chen <kernel@airkyi.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>,
        Andy Yan <andy.yan@rock-chips.com>,
        Yubing Zhang <yubing.zhang@rock-chips.com>,
        Frank Wang <frank.wang@rock-chips.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Amit Sunil Dhamne <amitsd@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dragan Simic <dsimic@manjaro.org>, Johan Jonker <jbx6244@gmail.com>,
        Diederik de Haas <didi.debian@cknow.org>,
        Peter Robinson <pbrobinson@gmail.com>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v4 2/7] dt-bindings: phy: rockchip: rk3399-typec-phy:
 Support mode-switch
Message-ID: <jm32ujhxslsx5snes4o66t2grb5uxhsaapjqahektfck66g6hb@fx6f53yojlcr>
References: <20250922012039.323-1-kernel@airkyi.com>
 <20250922012039.323-3-kernel@airkyi.com>
 <eb6ogrepo5acwcj5gpdolxxyg3xrx7kz6zrbizzseqyavvitfd@cnzurelqeh4t>
 <533d41bd-9293-4808-85f3-8fb6dc8bcda7@rock-chips.com>
 <mpyfe63tzxzxyyqf4vxwmrewzeosnaftlkko7pq2ynld6u3lcz@wlpixckov4hg>
 <8396dd15-9111-4ceb-a561-6ed57727546f@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8396dd15-9111-4ceb-a561-6ed57727546f@rock-chips.com>
X-Proofpoint-GUID: lofJEyzJsYJgqLHUhS1vEs9IcWKShPnT
X-Authority-Analysis: v=2.4 cv=RO2zH5i+ c=1 sm=1 tr=0 ts=68d22771 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=ePr-TV-LAAAA:8 a=JfrnYn6hAAAA:8
 a=s8YR1HE3AAAA:8 a=KKAkSRfTAAAA:8 a=SBpjGD6abgB5dFENKZUA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=uGDpjx9DKq9E8W49yboe:22
 a=1CNFftbPRP8L7MoqJWF3:22 a=jGH_LyMDp9YhSvY-UuyI:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyNSBTYWx0ZWRfX/hBTLAQ95mCj
 JpHrS0h2H9d58DowUm3a80lrfxYrfqLJne7ZtrrJU4qsh9rw0raqdoaE27x+RuR9NlNxgAKG+Zc
 Zoiupl25NdE/pe/JDymgIXu9nFQCbq/+HzRX5KWAP19NyEYV4kb4Es3Nnfu+J81/9k9NAnBvbVT
 HkQNPM7Jlgf3lVPuKN4v9aRatMo8Zrt+AvM9hKBx9QV8LUMyPTs1po1IYFskpDUghEEuhF1zSkI
 JEb0LcuD08F3Ejxv6co19umZ/NibTzwucwnOMvRUwOtcQx9ruC1L1OtK0ZXjrJQZzssRdD48pIs
 lhNCJ0zSUWb14S9Ol5gQViWsnHdv4kH1N5zX7qGWrZutUVlOCTdSkVuOFxNkUrorBae9q3yHTkX
 SqSAd6FY
X-Proofpoint-ORIG-GUID: lofJEyzJsYJgqLHUhS1vEs9IcWKShPnT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_01,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200025

On Tue, Sep 23, 2025 at 11:40:33AM +0800, Chaoyi Chen wrote:
> On 9/23/2025 11:17 AM, Dmitry Baryshkov wrote:
> 
> > On Tue, Sep 23, 2025 at 09:53:06AM +0800, Chaoyi Chen wrote:
> > > Hi Dmitry,
> > > 
> > > On 9/23/2025 9:12 AM, Dmitry Baryshkov wrote:
> > > > On Mon, Sep 22, 2025 at 09:20:34AM +0800, Chaoyi Chen wrote:
> > > > > From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> > > > > 
> > > > > The RK3399 SoC integrates two USB/DP combo PHYs, each of which
> > > > > supports software-configurable pin mapping and DisplayPort lane
> > > > > assignment. These capabilities enable the PHY itself to handle both
> > > > > mode switching and orientation switching, based on the Type-C plug
> > > > > orientation and USB PD negotiation results.
> > > > > 
> > > > > While an external Type-C controller is still required to detect cable
> > > > > attachment and report USB PD events, the actual mode and orientation
> > > > > switching is performed internally by the PHY through software
> > > > > configuration. This allows the PHY to act as a Type-C multiplexer for
> > > > > both data role and DP altmode configuration.
> > > > > 
> > > > > To reflect this hardware design, this patch introduces a new
> > > > > "mode-switch" property for the dp-port node in the device tree bindings.
> > > > > This property indicates that the connected PHY is capable of handling
> > > > > Type-C mode switching itself.
> > > > > 
> > > > > Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> > > > > 
> > > > > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > > > ---
> > > > > 
> > > > > Changes in v4:
> > > > > - Remove "|" in description.
> > > > > 
> > > > > Changes in v3:
> > > > > - Add more descriptions to clarify the role of the PHY in switching.
> > > > > 
> > > > > Changes in v2:
> > > > > - Reuse dp-port/usb3-port in rk3399-typec-phy binding.
> > > > > 
> > > > >    .../devicetree/bindings/phy/rockchip,rk3399-typec-phy.yaml  | 6 ++++++
> > > > >    1 file changed, 6 insertions(+)
> > > > > 
> > > > > diff --git a/Documentation/devicetree/bindings/phy/rockchip,rk3399-typec-phy.yaml b/Documentation/devicetree/bindings/phy/rockchip,rk3399-typec-phy.yaml
> > > > > index 91c011f68cd0..83ebcde096ea 100644
> > > > > --- a/Documentation/devicetree/bindings/phy/rockchip,rk3399-typec-phy.yaml
> > > > > +++ b/Documentation/devicetree/bindings/phy/rockchip,rk3399-typec-phy.yaml
> > > > > @@ -51,6 +51,12 @@ properties:
> > > > >          '#phy-cells':
> > > > >            const: 0
> > > > > +      mode-switch:
> > > > Having the mode-switch here is a bit strange. I think the whole PHY
> > > > device should be an orientation-switch and mode-switch. Otherwise it
> > > > feels weird to me.
> > > I think this is a difference in practice. In the previous binding, there was already an orientation-switch under the usb-port. I trying to add both an orientation-switch and a mode-switch to the top-level device in v2. And Krzysztof reminded me that adding a mode-switch under the dp-port would be better, so I changed it to the current form :)
> > I couldn't find the comment on lore. Could you please point it out?
> 
> Sorry, it is v1. I added an orientation-switch and a mode-switch in the top-level PHY [0]. Comment is here: [1]

My interpretation of [1] doesn't quite match yours. It doesn't say
anything about moving mode-switch to dp-port. It basically pointed out
that you already have two ports.

Also, I'm not sure how the current construction works: you register
switch and mux for the dev_fwnode(tcphy->dev), however the lookfup
functions should be looking for a device corresponding to the port OF
node (which doesn't exist).

> 
> 
> [0] https://lore.kernel.org/all/20250715112456.101-4-kernel@airkyi.com/
> 
> [1] https://lore.kernel.org/all/4dfed94c-665d-4e04-b527-ddd34fd3db8f@kernel.org/
> 
> 
> 
> > > 
> > > 
> > > > > +        description:
> > > > > +          Indicates the PHY can handle altmode switching. In this case,
> > > > > +          requires an external USB Type-C controller to report USB PD message.
> > > > > +        type: boolean
> > > > > +
> > > > >          port:
> > > > >            $ref: /schemas/graph.yaml#/properties/port
> > > > >            description: Connection to USB Type-C connector
> > > > > -- 
> > > > > 2.49.0
> > > > > 
> > > -- 
> > > Best,
> > > Chaoyi
> > > 
> -- 
> Best,
> Chaoyi
> 
> 
> -- 
> linux-phy mailing list
> linux-phy@lists.infradead.org
> https://lists.infradead.org/mailman/listinfo/linux-phy

-- 
With best wishes
Dmitry

