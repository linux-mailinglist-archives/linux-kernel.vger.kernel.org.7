Return-Path: <linux-kernel+bounces-751233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1591FB166BF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 21:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 453731767C6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9211A2E11A5;
	Wed, 30 Jul 2025 19:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F+tBuQT8"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604692D8DD9
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 19:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753902836; cv=none; b=lVRT2dY+NM78ouPnBfAEYqgnCXVG+TQsYkWcZichpV7a7p8rGfXsjaEpyQRhaHHftcR2+EX3oU05HWYTf4MifTxZaCRMpdiRKU8Yq1pTinoehox1sJY6Hq3tjJ6hxKOEYzkZCVCyGKgvM1JKTEEZJYF80b5R7NDqX7J7SBzdrR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753902836; c=relaxed/simple;
	bh=Q40vFM47o1aH80LOoTyutooZitVa1Avk/jyW8kw48GY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uMgS43pSWZXUWAgd/UuAz+5poSiuBwBomTHyAw9rHWslk4ThYV/yeb1+fODDYKgGAFK30X3QXFFjWAj9Y48uOzE3MbSkhnO/GIw3Hn0Jo3jShiL3P+h4BQT6HwKak3boAoz/VMwJxqv+9LBK1m0YWulygM+2rErsMscVOnCfPa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F+tBuQT8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56UCb6W9030198
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 19:13:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=aMpNvFPvt2cMAKNRFOUnF1jA
	yCuM7WFPijqR+Ei2D/0=; b=F+tBuQT8LTVPb4S5M+db3HHjBSYUucF1a7lRQtWt
	MIR9SkRhya+99V5V8/lCkZ69XUEV/WfkivHNugmXANg0r1P28+MM2JyoH76OU4yp
	TbYNkbUDeC8lxyKLRmncSo/Tv1OzyRPECGa70SVC/QkPzqjCCixFMMjhKsCehjac
	v6FVx4Zb6O92UC3KAD68jRCtmr0WCwmlFwoCXAxa4yeU+J5q+N+SCJ2WJzwgkUTJ
	5hQZ4/5/16sA898jwCJ0JuaW4Xj1h+vRzRlEpLuCQbQINUwExDgOnUdfHc5Bt08t
	NCt1x7voA+9p6OoZX9Znl7ZxSX4iMQYdS7hIjKYGKz1RDg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 487jwesewx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 19:13:53 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70771983a52so1786636d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 12:13:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753902833; x=1754507633;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aMpNvFPvt2cMAKNRFOUnF1jAyCuM7WFPijqR+Ei2D/0=;
        b=Fn2hU+9rD6kGSW3Vei4ae2qupSk7OFCokGz07igbyHffPTjJbhoYk2rfIfcEtYu189
         rNJLa0TxaYTC5vaXibRVxR8DG7ApHULzq6bS67Jg2SSaMxSG1+0Gjfix1Bc+0ldbflqg
         klwkY7teeARcORMFiboLQmWYG3Uc448RwOyjfsEKUmK1yYdkEdFeA94mW4baYuKYis/4
         v9pzsUbLJiKr9vqaErkr0n/VS68FYsSolcwgL2XpluMnip5sZ63G7JCUKWjKomB9T7QA
         D3aFo3ICEV1zi8uocbGHIC4WC14nExn+mmVJaC49gcUXPWo1nC1VlBtiIIJUKvR6xLkG
         1GYg==
X-Forwarded-Encrypted: i=1; AJvYcCWZu/SQpwAzhUWr9UO1P3JAGRWOvSsbyWCB8Iw/A2ItHA8l3c1ym1DqhayN2RrLefDvQv2PtjvjNOJfWmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDqhY9TIXWESRHhFXZBnMlp5h3sOkeKcbJ0KFs8GFfi/+XZv9f
	90LHQ49mXua+SgODqCQr3fo3+1puCT9bJyGwD9HgpuVJb7n13K1g6StZz+3KGUVkeQxTno1+0ye
	t7pi9At5vyXgbtHIvCANHQI7vxhJbVlK9Dvx1A8FBkIOxaW0USo8fdLIRpYgfSswSZV2qNfFB/9
	MlhQ==
X-Gm-Gg: ASbGncspiajygP3fltm7rQqEke6AuduiOfcXh8DKOtEXzS1ZYXu906ul2nhtJRaovNR
	KzfHkD54eL2DxxJ8pE06s4gTF0KsdQe73NdE981XMrQhfhSA4TQh4SNkRpA+rMDeDuOyWXhiG0F
	PnQIz2mO1JsLvIIbbA+Cp2LzTEGlx/UseY7YTLXpHR1J1EWdF/+i385HgRgWQ0J4unI50LJDaAl
	9b0CXB1L3cXzMO1wT7kIE1/RQHKpdR69HhZLCu3CAuoTRe6xpWWekhRetgQUKc4uLxpasp2Q+uy
	zc0+zSnGl0kbhNlJqOLjguqK1Q8ZM4ehBo6GgwCY5OhqmtDqq8cX7BcdkXepZkQGNJFJkl8GVIM
	JF3qmFhc/RIFU2xvvRr9YwyTLrKUf43KbLGI9lmqNXJIgl9TS5AqI
X-Received: by 2002:a05:6214:5010:b0:707:3891:a072 with SMTP id 6a1803df08f44-707669f8c80mr67431596d6.0.1753902831455;
        Wed, 30 Jul 2025 12:13:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHgmYSqHWL1JQSbQgLX/lTKYei8dv1aftQo53r3fvUDU06KrOX+cc9BvRo4AKOH1ZPMuJ35Q==
X-Received: by 2002:a05:6214:5010:b0:707:3891:a072 with SMTP id 6a1803df08f44-707669f8c80mr67430436d6.0.1753902830418;
        Wed, 30 Jul 2025 12:13:50 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-331f427c501sm21257541fa.77.2025.07.30.12.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 12:13:49 -0700 (PDT)
Date: Wed, 30 Jul 2025 22:13:47 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Chaoyi Chen <kernel@airkyi.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chaoyi Chen <chaoyi.chen@rock-chips.com>,
        Dragan Simic <dsimic@manjaro.org>, Johan Jonker <jbx6244@gmail.com>,
        Diederik de Haas <didi.debian@cknow.org>,
        Peter Robinson <pbrobinson@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 0/5] Add Type-C DP support for RK3399 EVB IND board
Message-ID: <3kefqzjewmsyzfvyi33kvlgjd6jphjg3fsnixb3of7yb3xkgs2@hgi6xfkgd653>
References: <20250729090032.97-1-kernel@airkyi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729090032.97-1-kernel@airkyi.com>
X-Proofpoint-ORIG-GUID: U4MIKxG33MoX_WeX41QR3_ilfRODxRAw
X-Authority-Analysis: v=2.4 cv=Wv0rMcfv c=1 sm=1 tr=0 ts=688a6ef1 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=s8YR1HE3AAAA:8 a=14ipHPXA7Wsnq1XJWM0A:9 a=CjuIK1q_8ugA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-GUID: U4MIKxG33MoX_WeX41QR3_ilfRODxRAw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDE0MCBTYWx0ZWRfX0c/9wQGnGw/+
 /OR+LXMvV8Vi2nYU4UA6G4FFI30mEtpVNqTNq9d6DFzDJP54dZrmFaeygo8/oMyvypBo62lT2AH
 z073/VOzrTGbY9+QUvHScdheb+AFtKZk6GtKg+/OFy1mMhaC3dhLgiNBkOv9FieZqMFnudqFPCF
 YIrSHpdsSf/sP4dr8Y3u+d52/KLV/EtvRTXBYF43C0kM4ZLmtsYVDFXu+uGGY9w6QLUt7Ipx+wV
 MoGc4ktsKU8BWol6Is3pdEllf5xpwgS8WdRWtCP4IiA+H+OPUps/r7zsuj3b4BW3vJn7c2Iv27h
 vqQw6L+9JUWqFqOPlcw2CKKwfYvdrGQ11z+ILFbdeBWvktij+YceggOs9e6qu5UutfEO2gpVR/p
 XdC4IoAgf0kohJNWLDG22Vz1MXmJTLRFmnVrHsX1jkQc+Xq4SWViPPRZUFOOvZA3mx0qrrj2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_05,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 mlxscore=0 adultscore=0 impostorscore=0
 phishscore=0 mlxlogscore=857 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507300140

On Tue, Jul 29, 2025 at 05:00:27PM +0800, Chaoyi Chen wrote:
> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> 
> This series focuses on adding Type-C DP support for USBDP PHY and DP
> driver. The USBDP PHY and DP will perceive the changes in cable status
> based on the USB PD and Type-C state machines provided by TCPM. Before
> this, the USBDP PHY and DP controller of RK3399 sensed cable state
> changes through extcon, and devices such as the RK3399 Gru-Chromebook
> rely on them. This series should not break them.
> 

[....]

> ====
> 2. DP HPD event notify
> 
> The RK3399 has two USB/DP combo PHY and one CDN-DP controller. And
> the CDN-DP can be switched to output to one of the PHYs.
> 
> USB/DP PHY0 ---+
>                | <----> CDN-DP controller
> USB/DP PHY1 ---+

Could you please clarify this, can you switch DP stream between two
USB-C outputs? What happens if user plugs in DP dongles in both USB-C
ports?

> 
> BTW, one of the important things to do is to implement extcon-like
> notifications. I found include/drm/bridge/aux-bridge.h , but if the
> aux-bridge is used, the bridge chain would look like this:
> 
> PHY0 aux-bridge ---+
>                    | ----> CDN-DP bridge
> PHY1 aux-bridge ---+
> 
> Oh, CDN-DP bridge has two previous aux-bridge!
> 
> Now, I try to use drm_connector_oob_hotplug_event() to notify HPD
> state between PHY and CDN-DP controller.

Does it actually work? The OOB HPD event will be repoted for the usb-c
connector's fwnode, but the DP controller isn't connected to that node
anyhow. If I'm not mistaken, the HPD signal will not reach DP driver in
this case.

> 
> Patch1 add new Type-C mode switch for RK3399 USBDP phy binding.
> Patch2 add typec_mux and typec_switch for RK3399 USBDP PHY.
> Patch3 drops CDN-DP's extcon dependency when Type-C is present.
> Patch4 add missing dp_out port for RK3399 CDN-DP.
> Patch5 add Type-C DP support for RK3399 EVB IND board.
> 

-- 
With best wishes
Dmitry

