Return-Path: <linux-kernel+bounces-801855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B89B44ABB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 02:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B0953B5731
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 00:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40DBA6F06A;
	Fri,  5 Sep 2025 00:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BQMFWkwB"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35C525557
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 00:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757031493; cv=none; b=JhIyBvYparXvSb33KHrQGXvwAMQUp/ZAj/7/3MdwzEjh9OgDIwjiSlnwTX4sJTIIyHk2SNk8mJ9nuyB1oqWvdhH6tWYnsRGmInPliUhzKJLZ1C1Yx1ZfTZ3LQnP/InFTwU9/K3JKqfzTxxmpPwCPV39ncszXQxu475zYActXgbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757031493; c=relaxed/simple;
	bh=x3/Y9jgH22TWNl40gxSja+/TAHx6XSPt3VTZHImqYi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rWalKQkCmjWx6X0JiIiMRRaNs8OdpUfbQ6WC/xtVIzu96xDAWxNaKCZxCpriSgonhfE9MPIl6ciFU1CyIpMU6JwJR40EKl3gu22hAjOY2USSaSa2qWfa1BQD2shOwxcts4ayhWaZQiey6VYoNmGEh+xwwh/M6oBj2vcXF/dlmO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BQMFWkwB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584IMZQX003799
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 00:18:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KSPaLUuu1/W8mwk0dFo8rOPMChptVSfZuwSuOpPsEcU=; b=BQMFWkwBoJavgg7m
	p/OQEucelcrf/wuWgKcPT6uJHGIBysqZ1dYANfS2zVw6bBYBYDmhUgKpjX88OJ6/
	7nx0OSHKflx77VPa+WToivqwk2ZO5ewbNqAXnlRd42N7wHIM9KPXO+3gg/QVTjCt
	c/F4VvUP7ZLfYdy9IcV59Mf8Ir4/a/FsgLPhxRreKcRTZFYu8BmIa/BEsfc38YUi
	6maz/zuxQKo1tVl2xvj8B7iSsShMyOSPlJbDUbAB6pVMY5csMxKDcbtcZZNcW5gq
	bVJ000ofmarBmedPyd6JWw0rdhU2STNLIZHk5RpN3C3uOG1a9VbP4P9MQfBAcrdr
	QI92aA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ur8s9aqh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 00:18:10 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-718c2590e94so46167216d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 17:18:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757031489; x=1757636289;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KSPaLUuu1/W8mwk0dFo8rOPMChptVSfZuwSuOpPsEcU=;
        b=oVAXJzRp/IRTGv9NDkw+TIKzSJ6vPnUgTVioU7nCY4158z1qh9hEB3zknurGwqw9LF
         patmNxcCrWn/fx/yy4w8S2a6j7IlG84nM/T7NntX9oXBK87mnxcnLnVxVm4jiL7JHDXK
         GS8OLgAb7Q9bTAf1Su7xnNzN/6qHE9GJ4cQt4d5qUpiRtxGnnJcUXwvj6WBj+Ol2st4x
         XyNpf/6IFbMPMK3AcD/scuRj/XXcqoxBiFpDLSDR87xcOWFqEOnkfyRpfpCdhJ5rAB/S
         cK3Edzjg3MnKaTcXrNYOjBjUtd8N5qpY4mkLUYtRilF5dsJiKkmR0zHmltRIMWn2Jpuo
         OceA==
X-Forwarded-Encrypted: i=1; AJvYcCXcW4ApC+ls5hOBjppn+OFL7Lqs21jQFsddivzSZkY50iNq10lcK3bTTLGGR6VYi8Ty1ElBwxUo16lD4GA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy0cH42dcKLQUZ8baWdqCdoC6rqwbkcvjdbmnNtN1E38Qh6duU
	O6VgrCDDVKuOoUXKz1Z2Gdrs5g2NQgNo/RAqdP8Qwida/PVRjI/kLjG1v4Wdf6G2O6Vekby5S/X
	3ASTZyOxmhzNIHI+WeDkcZzLlfRx5xO68EIV0cg+AV/b54lBcGu3pnuB85kVEt+a1VJM=
X-Gm-Gg: ASbGncvi5ah0VfX6K28MuKvWtUAkf0kLi4Shpmpc22UGO8emEI9HKxllhWYqel8iI2K
	42oTkYZFfuOrUW/9d8Bk5P/9Wsq8XXWYgTRJzAdn20Wu/EYYgr1IEwblWLtKmyr+hQ+S0Bsm0MK
	r1PBjSZvHTeg4xj1jV5Flgnrbg4yNb/SKbeQR9PgcI7uVZ+fSbaLAF1iEoZSsIuEJutHC7/ibY3
	B5X17vtkVVojisXiGJW/Usf0QCWQEz0LUPp5i5yQjwGndF7x3M7DQvDMV+w1qTWlh+ayxjgG8RU
	i/ltJ+/8M5KAW0/NqGd4dZ4exDgd6zLOGToayLdeRRClfmij4yh9s5eJs5OS9QmLNZ6oBKihY/4
	UgKgnyi7KscnCfFHzHrm7fX7BYuCsaWasEAp/c/JXMZSo+iTnrw2l
X-Received: by 2002:a05:6214:528f:b0:72a:6d80:89 with SMTP id 6a1803df08f44-72bbfe90ba8mr24025256d6.14.1757031489460;
        Thu, 04 Sep 2025 17:18:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPZjJiYgWml8xQq4nDFW2YEEIvWursEzB+vla8NQKjU89+gENfmatwzlUeLOhHRC82sA/uCg==
X-Received: by 2002:a05:6214:528f:b0:72a:6d80:89 with SMTP id 6a1803df08f44-72bbfe90ba8mr24024826d6.14.1757031488941;
        Thu, 04 Sep 2025 17:18:08 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608ab5e530sm1491374e87.10.2025.09.04.17.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 17:18:08 -0700 (PDT)
Date: Fri, 5 Sep 2025 03:18:05 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Conor Dooley <conor+dt@kernel.org>, David Airlie <airlied@gmail.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh@kernel.org>, Robert Foss <rfoss@kernel.org>,
        Simona Vetter <simona@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: drm/bridge: ti-tmds181: Add TI
 TMDS181 and SN65DP159 bindings
Message-ID: <muyjifaaftf7zmgl755xng3dx5uzgttauqanfdqktdfdd6n3qc@jsev7gs4dwsi>
References: <20250901142958.843678-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.edc18686-244f-441e-a6ac-0b62492b96c8@emailsignatures365.codetwo.com>
 <20250901142958.843678-2-mike.looijmans@topic.nl>
 <pml7rfbkerzkx5df26x7kxn3tk2o7oqrkqnx26tzikeg53djn5@islb4hlm4ks7>
 <aa80b3c4-01b5-4d4c-9fe0-523cdb895eb3@topic.nl>
 <37czaypq2newm3hn6nfuy5ndkibvaqf53nx6zvv3mhddh4qku5@psqqxbu7bycf>
 <abda9bc1-bd5a-4f60-8786-e3ebd6852073@topic.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abda9bc1-bd5a-4f60-8786-e3ebd6852073@topic.nl>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAxOSBTYWx0ZWRfX4qbG4VTkKO4O
 9cCXivEl499NbT+n/gepjsCje1J8W6+8NCf272EIftnHnYMAskR32YXUgRjqj5LFDxu1RHCZHR/
 btUsa3Zqg4O3y6B+Y2B6KTPCsPuxxhBgBkckfMHWskJ3HeQ3QAYNcXNK8Sa6W/FHb8U33SjW05M
 bzFMW0poY4foobYHQran/AcLR4YD7w3oXZe7a9nlWYyT95R50TD+EpiQkwIHltmFzb+qx3JGzYx
 IGphF/XHz2Yin9prS2dwR6BLKEYPOrQcb0uyIcgRWx7Os3pYIJTm40RJstsLiir1gQ5elg+1ljj
 8s9ViC+yr8FaiX+mjP5zFdmJf4gb2ZTUmDZOjs6EwszYHiOY54Lw7UKqKrDnR7luLUh+sHlc9fM
 nvY/+oEK
X-Proofpoint-GUID: h6UK_gNeSO__0EhFtryNI3gNxgqm5t0Z
X-Proofpoint-ORIG-GUID: h6UK_gNeSO__0EhFtryNI3gNxgqm5t0Z
X-Authority-Analysis: v=2.4 cv=PNkP+eqC c=1 sm=1 tr=0 ts=68ba2c43 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=yJojWOMRYYMA:10 a=5nLynkxtY9vo5Cl7bzAA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_08,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300019

On Thu, Sep 04, 2025 at 07:54:30AM +0200, Mike Looijmans wrote:
> On 03-09-2025 17:25, Dmitry Baryshkov wrote:
> > On Wed, Sep 03, 2025 at 08:17:33AM +0200, Mike Looijmans wrote:
> > > On 02-09-2025 19:29, Maxime Ripard wrote:
> > > > On Mon, Sep 01, 2025 at 04:29:01PM +0200, Mike Looijmans wrote:
> > > > > +  ti,retimer-threshold-hz:
> > > > > +    minimum: 25000000
> > > > > +    maximum: 600000000
> > > > > +    default: 200000000
> > > > > +    description:
> > > > > +      Cross-over point. Up until this pixel clock frequency
> > > > > +      the chip remains in the low-power redriver mode. Above
> > > > > +      the threshold the chip should operate in retimer mode.
> > > > Why should anyone want to tune this at the firmware level?
> > > It's a board property. You'd set this based on the hardware you've soldered
> > > on. If your clock and serdes are good quality, there's no need for the chip
> > > to be in retimer mode (it will consume more power and actually make the
> > > signal worse). At higher speeds, that situation may change, hence the need
> > > for a way to describe that. The chip has a similar function built in, but
> > > with only 2 choices of cross-over point.
> > > 
> > > To tune these parameters (retimer, equalizer), you'll probably have to take
> > > your equipment to a test facility (like we did). It's not something that
> > > end-users would want to tune themselves.
> > > 
> > > Most of these settings can also be done using pin strapping. I guess it'd be
> > > helpful if I added that to the description.
> > > 
> > > 
> > > > > +  ti,dvi-mode:
> > > > > +    type: boolean
> > > > > +    description: Makes the DP159 chip operate in DVI mode.
> > > > Ditto. Both describe policy, not hardware.
> > > I would set this flag if I've soldered on a DVI connector instead of a HDMI
> > > one. I'd consider that hardware.
> > Do you need to set this if you have DVI monitor attached to the HDMI
> > connector via the passive cable?
> 
> In our testing, the setting didn't appear to have any effect on the video
> signals. Activating the I2C interface blocks the pinstrapping setting of
> this bit, that's the only reason it's there.
> 
> I've been digging through the datasheet. It appears that the DVI mode
> disables an I2C slave on the DDC bus, when in HDMI_SEL mode the datasheet
> says:  "Device configured for HDMI (Adaptor ID block is readable through I2C
> or I2C-over-AUX."
> 
> Apparently a better name for the pin would be "disable-adaptor-id-block".
> 
> Another approach would be to just always disable it in the driver. It
> appears to make the retimer "visible" in the DDC path and even allows to
> change some settings that way (most noticeably, turn it on/off), which will
> interfere with the driver's functions. If we're directly controlling the
> device over I2C, one shouldn't be using this secondary interface.

If I understand correctly, it's a part of the DP++ standard, so it might
be a good idea to keep it enabled.

> 
> 
> > As for the connector type, you can check it in the .atomic_enable by
> > checking drm_connector::connector_type.
> 
> Assuming this is the last bridge, yes. But see above, I suggest removing
> this from the bindings and just always set it in the driver.

-- 
With best wishes
Dmitry

