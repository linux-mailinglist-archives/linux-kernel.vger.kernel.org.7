Return-Path: <linux-kernel+bounces-755904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A874DB1AD21
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 06:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 640533B90BD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 04:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD882153C6;
	Tue,  5 Aug 2025 04:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kThrxO3m"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB6D15E8B
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 04:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754368032; cv=none; b=YD6OS/IB/g0JkX6aZ1LKMc90Z2qg4jbpeRTJg3PqiRQRKwSabvO5tGWIpXdNPjrd1qhr22NywzX5WMGAOnqhwmU432e/lniOMlLhnWHNSLQRD2JdRbrGL9DS56yDnGurbbH5msTJhRmflH0JLZbls2RwSrLrBQYXrlsxLuU6opw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754368032; c=relaxed/simple;
	bh=8Hr9h14k+JMHtkWuKF8W6cTI23XIk8rTEu77cj7T03A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tG5R3qJpakTLD6ub1qCEmj3jS1iA+IQBAWWo277W++ySu82TqykG29EaA/XCQ6lDStzz1AdVlvh0gkBEed/+W0RaU9ogGBUmjAZ2xsm6aRpV1x8IST2iW6KXfW5QwX7LvlZB0+NfQCmQm5XflC3+4GRB8UnQFYafdCCHj7k1/Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kThrxO3m; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 574K3mCk031543
	for <linux-kernel@vger.kernel.org>; Tue, 5 Aug 2025 04:27:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oOc6z05PE+JQqEEqbcSZYn5GdoipElasSOcBl/QC7mg=; b=kThrxO3mtDNyptln
	ENj7Vn4UHb1q8h4R/1TPBHteW6nAWsKccbCxgqx3M2Tsp5BF4lbQSBXdzn7Y8CvX
	unP4tP0f7Eg8v9agYfX/RG4oyuQLzYthdK/1fTVj1Dmgn2zvDqhovuJL+k4ZlIQN
	l65RRm8cSYq7nQspXUEBeRnUflH/zkRDomKPWp9LrQhQGNVwtM5pEhUipo4AXWUr
	Z7Jw2K2YJI3/NRya0dPmhBGmELtQy4/iCNm56LtqumsWlbB09EjccwrVPXSlt3pe
	CIA0lIWAnYImH0wM/Jbf6oMIYuvZC1xMWW9ArpYQaqrKIzlzmK1fo3y5k8d0O2S3
	Z2U1Qg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ak5a3wn4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 04:27:09 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-76bf8e79828so4145675b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 21:27:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754368028; x=1754972828;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oOc6z05PE+JQqEEqbcSZYn5GdoipElasSOcBl/QC7mg=;
        b=nLL0wcP2H+brNqmmXTZUWhDT+79X4cWK1dqgEY67fiMZtFhGQNeq8+cUfMnshZHCA4
         +xWCWhBPQr/91rBSVkytWxz5Gl7SHtWqxN5scbLZXZMf+Pd5nIkJpQy+9zNFnxorp4K2
         PYqOPLKGBrAG9lVQzs3Rwh6OsJs7Qc1186czuMtU/6m1oWkOqSls+DDPpXiTi1MHAZqU
         BzgGWQzpqKfex0Asc/Amj354HNUtn2Lb2bbfUinlmzPIIWKs8SAxKmQPTrxMB6PyzJbT
         No+7r7jESgh3JGBHp5zfmiYMqXZ7Y6ISqOV8qF35TptsjTuw/5lELOFXDSzfvBQBWwmI
         QOnw==
X-Forwarded-Encrypted: i=1; AJvYcCXvFVpriQVx6p1igJKS6wL/ykoqQiXwXJCgvdYorZc8PoRAtiSITdwgGc+9/y6FYVkTGlqWNVJgunJIfZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLCEkDmtSyM78Dv0y/C5ZDbPASJ1tkrYzn84v5jrHzHy2XumJ2
	AGcCjnzfmb/wotnUsqNungnEvX6ENnFgx6f18oNAt8HQnEBUxwJE9zXVRxuR/SwFFzLOsVmLPcn
	/LLU+JTMjD1NcwVwsGngt524LNQ2rDDNHLjKWZ8me5o9eNpXulDtkPQaCqAmzWN0ZHm8=
X-Gm-Gg: ASbGncuBlbK9prqQ2M4stoZikzw9GquCTawhOb7zuJuNN97hu8fomjfMPFNsc7pMaDq
	NgJasDjQxV7FKHQTiyx7xAvrTPxbrBJQHY3Go/iDBxRC77EXuYSO12t75hUJipWLVJ+y96B3gWw
	a6qrfVvmyfsIMHEg00CCesSS/kYflyZi+5fGfzkoXyBAHKCNiGyv+GQAQI+uyBsl1fpS/GU7vBB
	yg+XqAQ6+9doveU4MSpEjQYCbBtc2Yk0rcSsOhNyn0bwfCwGoLB2/t3EfsLtrQJXe+K2ftok5/z
	mnLG0/bIOKMcrW30vH3mnhFXyTDMqaiZChkyeIxDier5wWqX97JgcT0l0U4=
X-Received: by 2002:a05:6a00:21d4:b0:74e:ab93:422b with SMTP id d2e1a72fcca58-76bec2f304fmr16590708b3a.4.1754368028222;
        Mon, 04 Aug 2025 21:27:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFw0pS+Af4/vl57IxtwquJOBQTfIqG+DV8SuowUeMiLkLhA25xCUY8PxbXrQoBIQT63gbcfpA==
X-Received: by 2002:a05:6a00:21d4:b0:74e:ab93:422b with SMTP id d2e1a72fcca58-76bec2f304fmr16590676b3a.4.1754368027830;
        Mon, 04 Aug 2025 21:27:07 -0700 (PDT)
Received: from [10.5.16.15] ([14.99.203.242])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfd4893sm11746425b3a.107.2025.08.04.21.26.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 21:27:07 -0700 (PDT)
Message-ID: <3e880194-5ac8-4056-929c-ac103bedc737@oss.qualcomm.com>
Date: Tue, 5 Aug 2025 09:56:57 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] Add Type-C DP support for RK3399 EVB IND board
To: Chaoyi Chen <chaoyi.chen@rock-chips.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Heiko Stuebner
 <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>,
        Andy Yan <andy.yan@rock-chips.com>,
        Yubing Zhang <yubing.zhang@rock-chips.com>,
        Frank Wang <frank.wang@rock-chips.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Amit Sunil Dhamne <amitsd@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dragan Simic <dsimic@manjaro.org>, Johan Jonker <jbx6244@gmail.com>,
        Diederik de Haas <didi.debian@cknow.org>,
        Peter Robinson <pbrobinson@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org
References: <20250729090032.97-1-kernel@airkyi.com>
 <3kefqzjewmsyzfvyi33kvlgjd6jphjg3fsnixb3of7yb3xkgs2@hgi6xfkgd653>
 <63ec11cf-7927-431a-995e-a5fc35ef1ba7@rock-chips.com>
 <pk5wecbbpxn7v4bdwtghhdnm76fmrmglelytljwfb4cgvpu2i6@rk5turgyt5xq>
 <0207826d-a987-4464-b306-29bdbfac45bc@rock-chips.com>
Content-Language: en-US
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
In-Reply-To: <0207826d-a987-4464-b306-29bdbfac45bc@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDAyOSBTYWx0ZWRfX7fAQwxmQ7DaI
 EqKPDrGcvbdjzKiz5Un2jzJlAzgrs6Mj5G9K2oj+9KNSsqV/xO4FRfyb0JYJxee8SXd4fTxe5pd
 S6NEuV8DGe6FzkjqjXqaLPslePkA8YdKahQ6QCzJISCvn5Qv7Q6HCVRx9sVzDpTpcsYO9URlJTy
 u8SpBmtNLZS3XgGCPGxNxk9tMeK+CwnjD3DaOYxfBfTH+hAH2VHZopSzfurlELD4cotPj80zrgN
 19+qJqzvfCXJb/2/1amvzY7pV5yqRgUjRUKyuDZRdJk5JIGS7dJR9uhFHRgalFnZaHZJ/R8jhc3
 aNRhNSzwBxHFaeoUAFr957pWEWEHx/babTrBvDSVvOPzeGM3jSzwmJmGCNGUaVfjyVEIJ8Fk8Oa
 caspHTc6R16+3oS2ox2Qvss3/DHKYjyntQp3o/LvY6Lx3JppVTD0AaK5WQSM8Nz/IqXxEEx2
X-Proofpoint-GUID: 79jdYJCt1Iu1UCSvyVudMo9a9zPa4QO1
X-Authority-Analysis: v=2.4 cv=LP1mQIW9 c=1 sm=1 tr=0 ts=6891881d cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=BCJAbJEDZziWQyy0sFgk6w==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=cm27Pg_UAAAA:8
 a=lJfCAnFZCnoPuUJW_CAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: 79jdYJCt1Iu1UCSvyVudMo9a9zPa4QO1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_10,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxlogscore=999 suspectscore=0 spamscore=0 impostorscore=0
 phishscore=0 adultscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508050029

On 05/08/2025 09:13, Chaoyi Chen wrote:
> Hi Dmitry,
> 
> On 8/2/2025 5:55 PM, Dmitry Baryshkov wrote:
> 
> [...]
> 
> 
>>> Currently, the software simply selects the first available port. So 
>>> if user
>>> plugs in DP dongles in both USB-C ports, the DP driver will select 
>>> the first
>>> port. This process is implemented in cdn_dp_connected_port() .
>>>
>> I think Stephen Boyd has been looking on similar issues for Chromebooks,
>> which were sharing DP controller between several USB-C ports. I don't
>> remember what was his last status. I think there it was easier since the
>> bifurcation point was the EC.
> 
> I think the latest progress should be here: [0]. It seems that it hasn't 
> been updated for a while.

Might be :-(

> 
> [0]: https://lore.kernel.org/all/20240901040658.157425-1- 
> swboyd@chromium.org/
> 
> 
>>
>> I think, CDN-DP needs to register up to two encoders and up to two
>> connectors, having a separate drm_bridge chain for each of the DP
>> signals paths (in the end, you can not guarantee that both branches will
>> have the same simple CDN-DP -> PHY -> USB-C configuration: there can be
>> different retimers, etc).
>>
>> Both encoders should list the same CRTC in possible_crtcs, etc. Of
>> course, it should not be possible to enable both of them.
>>
>> This way if the user plugs in two DP dongles, it would be possible to
>> select, which output actually gets a signal.
> 
> That makes sense, but this might make the DP driver quite complex. I 
> will see if I can make it happen.

I think it's trading one burden for another, because CDN-DP currently 
has a complication of calling cdn_dp_get_port_lanes() / 
cdn_dp_enable_phy() in a loop rather than just enabling one instance.

> 
> 
>>
>>>
>>>>> BTW, one of the important things to do is to implement extcon-like
>>>>> notifications. I found include/drm/bridge/aux-bridge.h , but if the
>>>>> aux-bridge is used, the bridge chain would look like this:
>>>>>
>>>>> PHY0 aux-bridge ---+
>>>>>                      | ----> CDN-DP bridge
>>>>> PHY1 aux-bridge ---+
>>>>>
>>>>> Oh, CDN-DP bridge has two previous aux-bridge!
>>>>>
>>>>> Now, I try to use drm_connector_oob_hotplug_event() to notify HPD
>>>>> state between PHY and CDN-DP controller.
>>>> Does it actually work? The OOB HPD event will be repoted for the usb-c
>>>> connector's fwnode, but the DP controller isn't connected to that node
>>>> anyhow. If I'm not mistaken, the HPD signal will not reach DP driver in
>>>> this case.
>>> Yes.  What you mentioned is the case in
>>> drivers/usb/typec/altmodes/displayport.c . I have also added a new 
>>> OOB event
>>> notify in the PHY driver in Patch 3, where the expected fwnode is 
>>> used in
>>> the PHY. So now we have two OOB HPD events, one from altmodes/ 
>>> displayport.c
>>> and the other from PHY. Only the HPD from PHY is eventually passed to 
>>> the DP
>>> driver.
>> This way you will loose IRQ_HPD pulse events from the DP. They are used
>> by DPRX (aka DP Sink) to signal to DPTX (DP Source) that there was a
>> change on the DPRX side and the DPTX should reread link params and maybe
>> retrain the link.
> 
> Sorry, I still don't quite understand your point. I think the entire 
> notification path is as follows:
> 
> Type-C mux callback -> RK3399 USBDP PHY -> PHY calls 
> drm_connector_oob_hotplug_event() -> DP driver
> 
> Are you concerned that the IRQ_HPD event is not being handled somewhere 
> along the path? Is it that the Type-C mux callback didn't notify the 
> PHY, or that after the PHY passed the event to the DP driver via the OOB 
> event, the DP driver didn't handle it?

The IRQ_HPD is an event coming from DPRX, it is delivered as a part of 
the attention VDM, see DP_STATUS_IRQ_HPD. It's being handled by the 
altmode displayport.c driver and is then delivered as an OOB hotplug 
call. However, it's not a mux event, so it is not (and it should not) 
being broadcasted over the typec_mux devices.

The way we were handling that is by having a chain of drm_aux_bridges 
for all interim devices, ending up with a drm_dp_hpd_bridge registered 
by the TCPM. This way when the DPRX triggers the IRQ_HPD event, it is 
being handled by the displayport.c and then delivered through that 
bridge to the DP driver.

-- 
With best wishes
Dmitry

