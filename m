Return-Path: <linux-kernel+bounces-828159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73714B9414B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 05:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D894E7B1160
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 03:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59001FC0EF;
	Tue, 23 Sep 2025 03:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XHGnxezE"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0CC8F49
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 03:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758597441; cv=none; b=cDrt83p8BD5nPsf/n5VKzMaA/wtXR5Zl5uesroPtmY0D/su+Ew+LDkZs08cRGYO+arFnWtSt+Ok9H/7h2ovJi57gGn8yaiejuo4ivTPbVTGgE5EWpJXZ0kmksFlsE8EmZ8pFKjKaKB0NIj/URzgSuHeHYoWAcS4VeIWIWgdW0GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758597441; c=relaxed/simple;
	bh=xHWXcIC7ovVIz5WR1jBTRhkQKp433dLLRW+sLCWkt+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zi3Et3co9WuolBNYa7JeNEROtB6ePZQ7fkpz7Uy6GCT8i9CzkuQREU5JjNnqKVyH6eMN3mD6/t+opsauY8Z92Ly4f7mc4B1EXtWn/1/zZruomYp0i2MDGyw4o56UswHvRNZY3KxettO2ejQwMtKT+ulbcIIYuf1KpmA/1s5vp3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XHGnxezE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58N2seWx029698
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 03:17:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bMb7C2zDppeQTKGSH4djX/sY8FExMuELVy1N+D87Fjg=; b=XHGnxezEa/2Uh3/5
	AlxnmfeU39uhBRTepsSKDOYGtjOv65Batzfrkr5rmyt64pqUM8zQ0v7jXcgUDnEW
	wdfpN6ICL/zvfPpPg7+UBoPUXeuvVpWime1N7Q7zbvD2/PN9JFNg9fimXQ1Y1erK
	2DxwsfMFlQNsdSseVlu8JduF1Ir67zt3vRoejAPo5UCmAfmcp5RniBb5ci9PxE8d
	mr1yz7bSUjfZYsaTjrW3eqLFq16DnEHnEQeFN1dTSPOw+0ukSVH/irHkqNc0NoNZ
	OICwCifD1C2LCAXl9vlgNMz48sO8ULSNl9geCp54SMI8jQ6O03h6LDXHxZnGONrd
	uhmynA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hmnq96r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 03:17:17 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-792f273fd58so90655866d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 20:17:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758597437; x=1759202237;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bMb7C2zDppeQTKGSH4djX/sY8FExMuELVy1N+D87Fjg=;
        b=KsY5x21PF4P7bRewzc4uiG9PHi7z42nB25aeLPj1DDVM1CxG1sr6wfKGkJEslHNkQw
         eoSXcKdJJ6l4OsvlPw+gjnaiIt90WYbyn+p7od5W0gZv1z4jWR3Ver3yvyKhnAQd+/Qu
         v8uUWSkxSDd1G5cwYnhiRvYj+wIY0eflCBm9dxDr4XzVQ6YUNZd8l601Qg2sTHK3tpTz
         Z/foIi1Hvbf4dOTx9uye52s7+MbqmGWyNHXbANzSNfnPRRGn44qHM8PFtnZSN03qYmir
         oaw940EmHMKZuo/xk2Jv4NNZ8Lwn0UG5vSvE/89ixqe8Mgoj76hgqzV6wYqX/Aeqg42u
         S3qg==
X-Forwarded-Encrypted: i=1; AJvYcCX6wancuGUph4V9VDu9/6MWb1R7WoSJDoq5+q+QS6TRW8aipuxcG3G3B7d/d7vWUE+EIpLJFsfcOyz20PM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJCPzTHp6FItdvyY0ZSm3gixyjtAXt6mLXy22RNlFfpD5475Bt
	NOiX5IJUqrieEer2zE+hU8G3f2ImV0WwI64SFelI+Xvhm/t5n31rsWh8c4Hy18JJgyPcUf1mqv4
	mEQgHl5Mpu+Xflte3Qw8/tfxGLurC/i0PvUFLtAwmnoStKfk+kAxb3USlUdPE9IMHwc8=
X-Gm-Gg: ASbGncuirqCZoZgxjt/aNu9g4EE+5mx5gB1uBepICB8YBmfu+3ABH/9bJ5HfC11o/ac
	j50NC9/VSqqWZBT6BbLoAG/6eMDZeuWAtTOgA/gSqFYfxP3WKzj5yWwxmHeNYwVr72/tDIj6rIZ
	qYZBMAjfOX4+zAIrwGrBTMVsaysBftuVEnI065zvOv0qBBK1F+bAhwtAOhKyAF2K1wbkjspBL/w
	Q6/ljF1uopBhIr5K5ioe/fbiNbtt/C/q/xOL9V3QDg4r1iaJSnr/LputNITOG/bfyVxJyK8+lZY
	tjUAYB8PO0Ubbt4owvlzcfGtb6vNPlZdm+IKjP+vGTNj/6m9Q2+llQxTZZgbCmysxL+wajpGVyC
	ttWOo/HkN5BqAd6Zczvx5W1kM6VQc5B1ntfao4vWXeNXk3shGDMen
X-Received: by 2002:a05:6214:2a8f:b0:741:52cf:a104 with SMTP id 6a1803df08f44-7e70169a36amr13294346d6.5.1758597436479;
        Mon, 22 Sep 2025 20:17:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFn0eBFPbnW3yR2CGZz8WEuSgYw6bETDind9f429+o4fUJgBVTohgVWJzPvbfpV811TCcIXOQ==
X-Received: by 2002:a05:6214:2a8f:b0:741:52cf:a104 with SMTP id 6a1803df08f44-7e70169a36amr13294086d6.5.1758597435854;
        Mon, 22 Sep 2025 20:17:15 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-57a9a81f52asm2678963e87.124.2025.09.22.20.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 20:17:13 -0700 (PDT)
Date: Tue, 23 Sep 2025 06:17:12 +0300
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
Message-ID: <mpyfe63tzxzxyyqf4vxwmrewzeosnaftlkko7pq2ynld6u3lcz@wlpixckov4hg>
References: <20250922012039.323-1-kernel@airkyi.com>
 <20250922012039.323-3-kernel@airkyi.com>
 <eb6ogrepo5acwcj5gpdolxxyg3xrx7kz6zrbizzseqyavvitfd@cnzurelqeh4t>
 <533d41bd-9293-4808-85f3-8fb6dc8bcda7@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <533d41bd-9293-4808-85f3-8fb6dc8bcda7@rock-chips.com>
X-Authority-Analysis: v=2.4 cv=YPqfyQGx c=1 sm=1 tr=0 ts=68d2113d cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=yJojWOMRYYMA:10 a=s8YR1HE3AAAA:8 a=KKAkSRfTAAAA:8 a=uIhu009UdGQP6qFfJxgA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10 a=OIgjcC2v60KrkQgK7BGD:22
 a=jGH_LyMDp9YhSvY-UuyI:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: k7oSbjBy36lOxzl85RgOXutL0VmQGvqR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwMCBTYWx0ZWRfX01ZjRlUwM7rF
 2pyRXgNKZSjqaMDb3PwvRhh4D0KzTIqpwIrk+kc9dn/pyFDFp2u7zXDOe7Rwfii2waC+aDVNA5W
 IDnyMGoOmFloxBsp8NnFalHkXgTFqrxO8gRIjjEZHw/++81NWz0P+9yLtVNXNXlMk3/ebu//MBx
 QcsurDFsGSHeUrwF+F3Cdps9o29gvHIU0K2Nc63u7xscUfZPREYfkm/0VWdKkRuktouuHfvCmWd
 mJDcnRum3G+gM3lIlboP1CCD4wdE33YD9JyXyOMwiU9Q/B8jCNtJbqwDMH6/Fe2aGcmf8WRcXxW
 SykC/yA0I/2WFOjPsONtEgwneLlN2odL4XDLILi0NY0ixdsP0Znellg+JSJbSR9WoMxx/ldkwkL
 5hGcUTUY
X-Proofpoint-GUID: k7oSbjBy36lOxzl85RgOXutL0VmQGvqR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_01,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0
 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200000

On Tue, Sep 23, 2025 at 09:53:06AM +0800, Chaoyi Chen wrote:
> Hi Dmitry,
> 
> On 9/23/2025 9:12 AM, Dmitry Baryshkov wrote:
> > On Mon, Sep 22, 2025 at 09:20:34AM +0800, Chaoyi Chen wrote:
> > > From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> > > 
> > > The RK3399 SoC integrates two USB/DP combo PHYs, each of which
> > > supports software-configurable pin mapping and DisplayPort lane
> > > assignment. These capabilities enable the PHY itself to handle both
> > > mode switching and orientation switching, based on the Type-C plug
> > > orientation and USB PD negotiation results.
> > > 
> > > While an external Type-C controller is still required to detect cable
> > > attachment and report USB PD events, the actual mode and orientation
> > > switching is performed internally by the PHY through software
> > > configuration. This allows the PHY to act as a Type-C multiplexer for
> > > both data role and DP altmode configuration.
> > > 
> > > To reflect this hardware design, this patch introduces a new
> > > "mode-switch" property for the dp-port node in the device tree bindings.
> > > This property indicates that the connected PHY is capable of handling
> > > Type-C mode switching itself.
> > > 
> > > Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> > > 
> > > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > ---
> > > 
> > > Changes in v4:
> > > - Remove "|" in description.
> > > 
> > > Changes in v3:
> > > - Add more descriptions to clarify the role of the PHY in switching.
> > > 
> > > Changes in v2:
> > > - Reuse dp-port/usb3-port in rk3399-typec-phy binding.
> > > 
> > >   .../devicetree/bindings/phy/rockchip,rk3399-typec-phy.yaml  | 6 ++++++
> > >   1 file changed, 6 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/phy/rockchip,rk3399-typec-phy.yaml b/Documentation/devicetree/bindings/phy/rockchip,rk3399-typec-phy.yaml
> > > index 91c011f68cd0..83ebcde096ea 100644
> > > --- a/Documentation/devicetree/bindings/phy/rockchip,rk3399-typec-phy.yaml
> > > +++ b/Documentation/devicetree/bindings/phy/rockchip,rk3399-typec-phy.yaml
> > > @@ -51,6 +51,12 @@ properties:
> > >         '#phy-cells':
> > >           const: 0
> > > +      mode-switch:
> > Having the mode-switch here is a bit strange. I think the whole PHY
> > device should be an orientation-switch and mode-switch. Otherwise it
> > feels weird to me.
> 
> I think this is a difference in practice. In the previous binding, there was already an orientation-switch under the usb-port. I trying to add both an orientation-switch and a mode-switch to the top-level device in v2. And Krzysztof reminded me that adding a mode-switch under the dp-port would be better, so I changed it to the current form :)

I couldn't find the comment on lore. Could you please point it out?

> 
> 
> 
> > 
> > > +        description:
> > > +          Indicates the PHY can handle altmode switching. In this case,
> > > +          requires an external USB Type-C controller to report USB PD message.
> > > +        type: boolean
> > > +
> > >         port:
> > >           $ref: /schemas/graph.yaml#/properties/port
> > >           description: Connection to USB Type-C connector
> > > -- 
> > > 2.49.0
> > > 
> -- 
> Best,
> Chaoyi
> 

-- 
With best wishes
Dmitry

