Return-Path: <linux-kernel+bounces-772672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6E3B295E3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 02:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F406719628EE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 00:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06411217F3D;
	Mon, 18 Aug 2025 00:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MDW5UKnb"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A26C20E6E1
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 00:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755477738; cv=none; b=Azbn+4U1DNu7HWpGfHefayi37iQ6Kkjlb+tsPP4X1TGQ8iVp9LVE/ziR/6OKBq4mbMk3b8yQYStE1LBfT9l1Gz1sDyTCMuZsFZdgRuRZ2TnK0BKKFVWkAJL1pXpkuoztGYC9QoBuUmEQj6ZtXxJwoPAdHNTzTkegZTZq23B0vDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755477738; c=relaxed/simple;
	bh=bfq0l2jEO0lJYI6LUPTmA4Y1PemWVGgflNXu1DOPuc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sxXu64pxJxWPkTSO9htY4Vzkq16bJUewhZbOyLu/pM+a0UVjRDy5OjUbUuabe8gfajN0NIpFXgZ5e1sKXgmqWohP1czSlUBKjy4m6KkkRuR2lKvPH0tZrxv58QP1oWQm9Zvpzj5sTpJCbCg8axVomcgwg3lT24ZYcMT6mqcCDE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MDW5UKnb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57HMnUw8018574
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 00:42:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=TTIHaooodPnPN/uV4iXuYwFR
	FvxVYdQqEnjkEjkUyXs=; b=MDW5UKnb8wZXu3Rq3kr0ghlak3YhUwLOHMqkBlbb
	gCsLJSXJWev5fu5tMdafOzJ6PVg5cwEvCVpvdP2mqqbfdRkFxtoNHCaRHHYrRJ5M
	RdQ6EdgcgzlogYwr/96OA9d3y4zwCvzug81MFhlaj4vFZxVWdMgpbdps4ZD23+rt
	0FvPy3nCf4uZmk2vGaU94TXPtqJybKfKuRP8PV+/nv9jLL30eVT4hwXKMDiYx/yK
	Cfy/B6ZXYhgSUJBGutqr4qSc7ywUuCSKIyA4xEza+qHK/jOZC1U9PT7qBr3c4pVX
	tWCcFfN03QP+rg8PISsy8Oyr6idoFYJns/Cdiib1PnfPOg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jhagtv5t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 00:42:14 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70a88dd1408so84199626d6.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 17:42:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755477733; x=1756082533;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TTIHaooodPnPN/uV4iXuYwFRFvxVYdQqEnjkEjkUyXs=;
        b=LM6Es7PHLBYKQGfzR5/uOCVS5GXm8IvQDLV/Xf7gC2IbvZ5PaLmGaMIImhv9WaoCVW
         4n56GVRnatVwCeNxcUKJqXOIf1EypA+h1WOS7uzHRNofr+1z5sIGq4/6vMP6699bce00
         MzG0gOef8ljN018LcQFvgPZkM8TvDll7nJYBxPDEaVkFwWf3isdj9ZggHHOAaq02euua
         W++FGSX6EXEYQZMDRPT9tRplYcdPnw5S5ckRV17vT8k+YESB6ccZRYv1xPNXlihQDSrm
         57yBqkLypEisOOHfMf6n9wCSpckJ8YIX0g0ygXyZAOCEJrgyC9n41jIra5fGc/0a79bn
         9pYw==
X-Forwarded-Encrypted: i=1; AJvYcCVI2UEdlx41MpzeJLyLHAKyTABjSRkQiU7vJUXIg1UVZWmqBsPxUzYSk63/cH+Ddq8sebzpxKrLsbhfnzc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRrgS+bvivA2S21dMa2zDue1Jq+kyJGiKDRRHfpQZFqULeztzQ
	uuCZ6zZMKn38fR2tH0KMD05acs4u6Gj+l02sTeVA1ZvpuFolsS0DykUR7DLZCOzwpNX+FdWF7cf
	NEKQd3RP6UAjnjmxdYTLmgo6XXvmp2VsMLctMdXUerQ5bczud596XuuuJMa6in0nVdBo=
X-Gm-Gg: ASbGncuW58pYWX/tGKh1yp5cv5gIUWhsluDSwnsC8EsaDCsOQ2egi4Th7pbx5fVEphz
	SpedXa/e5ZRPqyI4++bouvIKW8uVvKFANjgufHhOjeCFQsnU3eJyzv7eEOUFy0McsccN+bouQlG
	91aXjzXl3cDNpgZtaQ7kJs+BslGvfvkF+n08k4TePBveUwCKjBvLyw4WmY5ohSjj8NlqYf9Qg3G
	coaSgE/mJXdvs5UIjib/xSOiPv3Enof3vCKAUd1Tdr2MMcARYmzzx/nCG94iMQyoUZDFgoIcar8
	/iPpXVt79clQ1q6x1ZycZB9df5IzdStXTuVNXMgFusd56jJHwfGm1CSxBw4rV1SpUixn5sleOmL
	jBq3PqFz8tqGmTx0+X8OBG89bkJHFHa3l5kFkjkM2AAjhw89sXt2G
X-Received: by 2002:ad4:5c42:0:b0:709:b6bc:f6f4 with SMTP id 6a1803df08f44-70ba7bf7612mr120609016d6.32.1755477733401;
        Sun, 17 Aug 2025 17:42:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaOFAA4xzAEpkq1pbcegEcpv96JKuWHG5xRULfd/dnlRxyzciJwghtw+nPoI3WDSgIvg3ZsQ==
X-Received: by 2002:ad4:5c42:0:b0:709:b6bc:f6f4 with SMTP id 6a1803df08f44-70ba7bf7612mr120608736d6.32.1755477732843;
        Sun, 17 Aug 2025 17:42:12 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3340a604690sm15654081fa.41.2025.08.17.17.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 17:42:10 -0700 (PDT)
Date: Mon, 18 Aug 2025 03:42:07 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Henrik Grimler <henrik@grimler.se>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, replicant@osuosl.org,
        linux-kernel@vger.kernel.org, m.szyprowski@samsung.com
Subject: Re: [PATCH v2 3/3] drm/bridge: sii9234: use extcon cable detection
 logic to detect MHL
Message-ID: <r2u2odrkzfezohq44nh4jw6oj23j46gohuzsh6k7jpwnzojxqk@vdus4jj5lv7x>
References: <20250724-exynos4-sii9234-driver-v2-0-faee244f1d40@grimler.se>
 <20250724-exynos4-sii9234-driver-v2-3-faee244f1d40@grimler.se>
 <ldhyfuczwtwydwnvno4xn6ppjtt7mtcj35fp52xrqaajtfbtpb@2pgkytczb5k5>
 <20250808095259.GA31443@grimfrac.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808095259.GA31443@grimfrac.localdomain>
X-Authority-Analysis: v=2.4 cv=D9xHKuRj c=1 sm=1 tr=0 ts=68a276e6 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=ZUfLXKp3AAAA:8 a=QyXUC8HyAAAA:8 a=zbyRAtfhQp2mi0id9n0A:9
 a=CjuIK1q_8ugA:10 a=iYH6xdkBrDN1Jqds4HTS:22 a=RYC_AntYK8rCuVhA8xHq:22
X-Proofpoint-ORIG-GUID: 2o-f0WZvMhlM4UxNQla0MklvXNp-Bdpv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAyNCBTYWx0ZWRfX8X/Paa3KHZaB
 DiIbseYug/eFFM12QoYgvr7c0NgfrysAh1Ii2OI8eoVFISzCxO9DYATsBbrWHEPb/WQ1oBIKSu2
 svVTZzZFmxgMCShv8cWSDzb26cReNGNvgGWNJF+jC6HpoxaKW1OPZSI9x+qmC2TtAMOGfbypZrH
 9ydE/Fvuq8XixE7OlQl86F4TJiJBDbIAZbXEbKZAbTkxLQvYwwmjVSJuFQx2ZUwkZ7Ew7Y7HtB4
 6jjN3pAfLfp+qREUluqm43kNOP3AouwXlrQhdVaewKgQTkDQRZgC9DrNvnU6Iz1Hggl05mEu+GH
 bhoxw4Z8DymaUUzX9oOWInTEZTva1IofijPb/Q7/VRJrjRfguecvjQpWqfg7XjyfsSKsBD/Merx
 UgBpQqJo
X-Proofpoint-GUID: 2o-f0WZvMhlM4UxNQla0MklvXNp-Bdpv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-17_10,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160024

On Fri, Aug 08, 2025 at 11:52:59AM +0200, Henrik Grimler wrote:
> Hi Dmitry,
> 
> On Sun, Jul 27, 2025 at 08:07:37PM +0300, Dmitry Baryshkov wrote:
> > On Thu, Jul 24, 2025 at 08:50:53PM +0200, Henrik Grimler wrote:
> > > To use MHL we currently need the MHL chip to be permanently on, which
> > > consumes unnecessary power. Let's use extcon attached to MUIC to enable
> > > the MHL chip only if it detects an MHL cable.
> > 
> > Does HPD GPIO reflect the correct state of the cable?
> 
> Yes, the HPD gpio pin changes state from low to high when a mhl cable is
> connected:
> 
> $ sudo cat /sys/kernel/debug/gpio|grep gpio-755
>  gpio-755 (                    |hpd                 ) in  lo IRQ
> $ sudo cat /sys/kernel/debug/gpio|grep gpio-755
>  gpio-755 (                    |hpd                 ) in  hi IRQ
> 
> so that is described correctly.
> 

Ack.

> 
> and in captured trace I see that on cable connect we get an irq that
> is handled through:
> 1. max77693_muic_irq_handler
> 2. max77693_muic_irq_work
> 3. max77693_muic_adc_handler
> 4. sii9234_extcon_notifier
> 5. sii9234_extcon_work
> 6. sii9234_cable_in
> 7. hdmi_irq_thread
> 
> Raw captured trace dat file can be found here:
> https://grimler.se/files/sii9234-mhl-connect-trace.dat
> 
> Maybe you were asking for some other type of order of events log
> though, please let me know if I misunderstand.
> 
> > Should the sii9234 signal to Exynos HDMI that the link is established?
> 
> Maybe.. Sorry, I do not know enough about extcon and drm yet. I assume
> you mean through drm_helper_hpd_irq_event() and
> drm_bridge_hpd_notify(), I will experiment a bit and add it to the
> driver and see if this improves it.

If you are getting the HDMI IRQ event, then I'd suggest checking that
you are actually getting the 'plugged' event, etc. I was worried that
you are hijacking the DRM chain. But if you are getting hotplug events,
then it's fine (and most likely correct).

> 
> There is currently (as I wrote to Marek Szyprowski in a response in
> v1) an issue where device screen stops working if cable is connected
> when device screen is off, maybe proper notification would help..
> 
> > > Signed-off-by: Henrik Grimler <henrik@grimler.se>
> > > ---
> > > v2: add dependency on extcon. Issue reported by kernel test robot
> > >     <lkp@intel.com>
> > > ---
> > >  drivers/gpu/drm/bridge/Kconfig   |  1 +
> > >  drivers/gpu/drm/bridge/sii9234.c | 89 ++++++++++++++++++++++++++++++++++++++--
> > >  2 files changed, 87 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> > > index b9e0ca85226a603a24f90c6879d1499f824060cb..f18a083f6e1c6fe40bde5e65a1548acc61a162ae 100644
> > > --- a/drivers/gpu/drm/bridge/Kconfig
> > > +++ b/drivers/gpu/drm/bridge/Kconfig
> > > @@ -303,6 +303,7 @@ config DRM_SII902X
> > >  config DRM_SII9234
> > >  	tristate "Silicon Image SII9234 HDMI/MHL bridge"
> > >  	depends on OF
> > > +	select EXTCON
> > 
> > Either this or 'depends on EXTCON || !EXTCON'
> 
> Feels like depends is a better description so will change to it,
> thanks!
> 
> Best regards,
> Henrik Grimler
> 
> > >  	help
> > >  	  Say Y here if you want support for the MHL interface.
> > >  	  It is an I2C driver, that detects connection of MHL bridge
> > 
> > -- 
> > With best wishes
> > Dmitry
> > 

-- 
With best wishes
Dmitry

