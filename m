Return-Path: <linux-kernel+bounces-803105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE50DB45AB0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 16:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22210BA0940
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077E136CE1E;
	Fri,  5 Sep 2025 14:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Jf5ezg7j"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6F535FC12
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 14:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757082770; cv=none; b=cyT4XKCB2ju/6/9xuealfrvp2RFmQcvDDLXfK5QHJ4iYYT2zzg5EKeOu0vycZ6ysYe8M7ECCPiG2nC8ywqUjpGSb4NwhuinLw6bYvbTFhjIPCz5lh9UbPsCTfMjFARjGvERFkOAWnoGErdBkPs2RvWJcXY7j9lZ7xeMk/YiKJtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757082770; c=relaxed/simple;
	bh=4jBWw9rOxbhMrI6Fio/4LOaWWJUdEQvodcvhN7h6dos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HOM56hGx+Qr2MqqdVTAGovf3A3tTjECQUe5L/ZTVIMw3LNVHLe4K8bkpzG5r5QqtYFJNDrBh+QOxEK9xppdBtiXIKesHrmZnrKWvvsQI3mstIUuJbaUOY5xGseCHe9ejO6C30YFtNTDs1YR4axE3dWpGGmdbJFVN10WRSARZ7jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Jf5ezg7j; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5857UcwN007991
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 14:32:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2blvhr/dbGiJffwZJCFo7AuxYx4MvDnwJkLcFgb+E/0=; b=Jf5ezg7jKEfuSLmE
	QhCA82MK47MA9tyOYEr6pErZQJDBB9hqgJV3BXDGqFBUtr9wj8fUkXfhuA1GcCZk
	I0MG4jRnI9Rt5sQtPjDckWFld5fAO+fUz8Jn2rOBGZ5G96+/4rOIRBJm+nFDwWJz
	utB639Q7kiEX6cUXa/lU+H0T2gkAFIcN9NvDlMwhfv3tzX6FMndKm5274MYzOFW2
	PzHifR6r/UtYAvFZlBRiBUr2giahmfACP+xQAvndYO+eU+zRennNQpvYxzG7f348
	9AbCFZSw2/Mgned8c2b6YeY7a/vVhW471QRi18AihrW5VJK+Q3cB71HEGpojLe7y
	tkQT1A==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ura939up-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 14:32:47 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b5d58d226cso47705051cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 07:32:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757082766; x=1757687566;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2blvhr/dbGiJffwZJCFo7AuxYx4MvDnwJkLcFgb+E/0=;
        b=J5z8Ei11bV/ikmjtmz880F7BJ9QxBQG6xj5okkHUi+7HIFPntGXZ+gC5VahDXqZv9p
         k/P2ufZ0CWmCEQ16PGZL3casPwcIXZMvWNKbGegkFO7BYFpEDG1u0g3sly9Z+GKDpZsH
         eeU84/S8fD8k/gl3+/DVlR5f4eEiTk5XpcHrkHw3+ut7jyiRstsZemdR8SVfKGxRLh0G
         Xwf0Z6jZm5YVHhgwxO45WnEZ1xN0XIXTzc3ns8VQq0r+hCbSyM9Cjain0pu6XdIckJxE
         6mqsN6N1ZMmeakAAKCNs5R7EwvHjcbAHIkJEzEu3TDbSis0nEfHTnolXm+gZIEHVHdsA
         x5Hw==
X-Forwarded-Encrypted: i=1; AJvYcCWsF/QLHOYgs55KfqHkxQ8UUxi54OFpYxwoTNhN/C8UhmKNGDw09aaeIBg4oSa9q8THjcl++LarXW4Ay2E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6XwR+f3cu+jWk0wQf7yvZVsLeOsqZ0zl5ihxnFTWuAHKLZxSK
	gz0gGBBNWmy6YOXtX0tPAl1XeUEPH8CwxHrKIhhT6vb5uLrLWXu0seEC/+5qWCYK3xDi5h5CeHt
	vs+XiplnAvHTMvia+478vyuyinZbML95Lzy0Fg4CkxvbPoacRAsvh9ylT2JbE/WFMslc=
X-Gm-Gg: ASbGncv16FCgCO62KrtqNy6nJemjFT902RmVBK4qrx5PPDd/orrkey/tUcx+Bq04Vb2
	+rXI6T1EGMm/IIim2TFUd7+0SZDH6MaDs6ZM+f8lXSh97hDBKgLs0MUJNMHhgqvPgqYZQcmushE
	oinAyL9jk0Po3W+8LpWmfamqr/VeSHEbzZh07FcniDmV0ggS5hBOZwenv8rQ3O2l5LiqVnllsGJ
	3ufdkjv3WnU5qdb3Jdcv5w0mwoEIk2BkK4EIg2fnClOsY5nXSydId++reIbMYf47oJru7QcGpsa
	sbMYKrf47DxwllQ3r1OCj20iOqybrdQ+/fmEefFppOwdoPepx/yXK7Z8x+3vloNyPqXZT5Kb+5+
	vcZEpUSPUmIsn886txt7ksn5bwQA4tJoPCGanIWN2WC9y+iUM7Ror
X-Received: by 2002:ac8:7fc8:0:b0:4b4:9773:5870 with SMTP id d75a77b69052e-4b49782a0abmr117944841cf.21.1757082766299;
        Fri, 05 Sep 2025 07:32:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgurbO0eCRsGdU/aokL+NeCbcf/yjmx/Jn5Y5VhJVqbPt0y1YnlOogs/MWAp71DHWK7oEdoQ==
X-Received: by 2002:ac8:7fc8:0:b0:4b4:9773:5870 with SMTP id d75a77b69052e-4b49782a0abmr117944111cf.21.1757082765691;
        Fri, 05 Sep 2025 07:32:45 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608ad523b3sm1776126e87.151.2025.09.05.07.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 07:32:44 -0700 (PDT)
Date: Fri, 5 Sep 2025 17:32:42 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Andy Yan <andyshrk@163.com>
Cc: heiko@sntech.de, mripard@kernel.org, neil.armstrong@linaro.org,
        andrzej.hajda@intel.com, jernej.skrabec@gmail.com, jonas@kwiboo.se,
        Laurent.pinchart@ideasonboard.com, maarten.lankhorst@linux.intel.com,
        rfoss@kernel.org, simona@ffwll.ch, tzimmermann@suse.de,
        knaerzche@gmail.com, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Andy Yan <andy.yan@rock-chips.com>
Subject: Re: [PATCH v7 1/2] drm/rockchip: inno-hdmi: Convert to drm bridge
Message-ID: <6qouaxhcwr4rxva7vgq7yy274imiufdtp3ae4mmirzt7hycxc6@4g26bzmhc37h>
References: <20250903110825.776807-1-andyshrk@163.com>
 <20250903110825.776807-2-andyshrk@163.com>
 <u72vkfojufgvuqwuqpvgvnip3wogpgdcuc7bn46zo3bp7ogbu5@fmqotgyahrsn>
 <786c050a.6d2.1991751593e.Coremail.andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <786c050a.6d2.1991751593e.Coremail.andyshrk@163.com>
X-Proofpoint-ORIG-GUID: puxoSNEiRgEFGw9MtECGwa7-t-hFBC6Z
X-Proofpoint-GUID: puxoSNEiRgEFGw9MtECGwa7-t-hFBC6Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyMCBTYWx0ZWRfX9HBT+SM3r5l4
 RDP/MDtwkyxZCp0RnYAjyGvtkSB4NYssGGxLTrWMPtOnTYdClU8khGRK4aLd2ldksthTRGAnO49
 nuCo0KrJZ+06sn8cO022emNAIwtvLHobKP6ATB0/NMWmYqk2eXrJe/XnbfayAlfUo+ZVlo5tH5D
 QnFD4F6gIUc1RI7ebTBxHSA2JHf5SxkFPoCpHpcbHgEJXKDmYH3K7Hj8s6nBHA8eciRQ8jTPLGb
 lAufWpHwB43+GW0CNoLN0yDGLND/csMtJAmvYii5eJ29/nwfGoar55mvQnPL+JBr56/4qUB/Y5I
 r5Dgxw2Xn5Zh3agJW2ZHdrYAWbkQdyQoj8Ug87gGaw8xKTd5ZGG7NhpwCmb0wNXk3ubXo/ism6z
 DpzwHtzP
X-Authority-Analysis: v=2.4 cv=VNndn8PX c=1 sm=1 tr=0 ts=68baf48f cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=Byx-y9mGAAAA:8 a=EUspDBNiAAAA:8
 a=s8YR1HE3AAAA:8 a=5KrWf_2bJ-0ShaoMUpsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_04,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300020

On Fri, Sep 05, 2025 at 08:40:31AM +0800, Andy Yan wrote:
> 
> Hello Dmitry，
> 
> At 2025-09-05 08:05:06, "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com> wrote:
> >On Wed, Sep 03, 2025 at 07:07:38PM +0800, Andy Yan wrote:
> >> From: Andy Yan <andy.yan@rock-chips.com>
> >> 
> >> Convert it to drm bridge driver, it will be convenient for us to
> >> migrate the connector part to the display driver later.
> >> 
> >> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> >> 
> >> ---
> >> 
> >> Changes in v7:
> >> - Rebase on latest drm-misc-next
> >> 
> >> Changes in v6:
> >> - Rebase on latest drm-misc-next
> >> - Link to V5: https://lore.kernel.org/linux-rockchip/20250512124615.2848731-1-andyshrk@163.com/
> >> 
> >> Changes in v5:
> >> - Split cleanup code to seperate patch
> >> - Switch to devm_drm_bridge_alloc() API
> >> - Link to V4: https://lore.kernel.org/linux-rockchip/20250422070455.432666-1-andyshrk@163.com/
> >> 
> >> Changes in v4:
> >> - Do not store colorimetry within inno_hdmi struct
> >> - Link to V3: https://lore.kernel.org/linux-rockchip/20250402123150.238234-1-andyshrk@163.com/
> >> 
> >> Changes in v3:
> >> - First included in v3
> >> - Link to V2: https://lore.kernel.org/dri-devel/20250325132944.171111-1-andyshrk@163.com/
> >> 
> >>  drivers/gpu/drm/bridge/Kconfig                |   7 +
> >>  drivers/gpu/drm/bridge/Makefile               |   1 +
> >>  .../inno_hdmi.c => bridge/inno-hdmi.c}        | 502 +++++-------------
> >>  drivers/gpu/drm/rockchip/Kconfig              |   1 +
> >>  drivers/gpu/drm/rockchip/Makefile             |   2 +-
> >>  drivers/gpu/drm/rockchip/inno_hdmi-rockchip.c | 188 +++++++
> >>  include/drm/bridge/inno_hdmi.h                |  33 ++
> >>  7 files changed, 366 insertions(+), 368 deletions(-)
> >>  rename drivers/gpu/drm/{rockchip/inno_hdmi.c => bridge/inno-hdmi.c} (69%)
> >>  create mode 100644 drivers/gpu/drm/rockchip/inno_hdmi-rockchip.c
> >>  create mode 100644 include/drm/bridge/inno_hdmi.h
> >> 
> >> @@ -637,14 +584,13 @@ static void inno_hdmi_init_hw(struct inno_hdmi *hdmi)
> >>  	hdmi_modb(hdmi, HDMI_STATUS, m_MASK_INT_HOTPLUG, v_MASK_INT_HOTPLUG(1));
> >>  }
> >>  
> >> -static int inno_hdmi_disable_frame(struct drm_connector *connector,
> >> -				   enum hdmi_infoframe_type type)
> >> +static int inno_hdmi_bridge_clear_infoframe(struct drm_bridge *bridge,
> >> +					    enum hdmi_infoframe_type type)
> >>  {
> >> -	struct inno_hdmi *hdmi = connector_to_inno_hdmi(connector);
> >> +	struct inno_hdmi *hdmi = bridge_to_inno_hdmi(bridge);
> >>  
> >>  	if (type != HDMI_INFOFRAME_TYPE_AVI) {
> >> -		drm_err(connector->dev,
> >> -			"Unsupported infoframe type: %u\n", type);
> >> +		drm_err(bridge->dev, "Unsupported infoframe type: %u\n", type);
> >>  		return 0;
> >>  	}
> >>  
> >> @@ -653,20 +599,19 @@ static int inno_hdmi_disable_frame(struct drm_connector *connector,
> >>  	return 0;
> >>  }
> >>  
> >> -static int inno_hdmi_upload_frame(struct drm_connector *connector,
> >> -				  enum hdmi_infoframe_type type,
> >> -				  const u8 *buffer, size_t len)
> >> +static int inno_hdmi_bridge_write_infoframe(struct drm_bridge *bridge,
> >> +					    enum hdmi_infoframe_type type,
> >> +					    const u8 *buffer, size_t len)
> >>  {
> >> -	struct inno_hdmi *hdmi = connector_to_inno_hdmi(connector);
> >> +	struct inno_hdmi *hdmi = bridge_to_inno_hdmi(bridge);
> >>  	ssize_t i;
> >>  
> >>  	if (type != HDMI_INFOFRAME_TYPE_AVI) {
> >> -		drm_err(connector->dev,
> >> -			"Unsupported infoframe type: %u\n", type);
> >> +		drm_err(bridge->dev, "Unsupported infoframe type: %u\n", type);
> >>  		return 0;
> >>  	}
> >>  
> >> -	inno_hdmi_disable_frame(connector, type);
> >> +	inno_hdmi_bridge_clear_infoframe(bridge, type);
> >>  
> >>  	for (i = 0; i < len; i++)
> >>  		hdmi_writeb(hdmi, HDMI_CONTROL_PACKET_ADDR + i, buffer[i]);
> >
> >It's not an issue for this patch (and I think it can be fixed after this
> >series is merged). I took a quick glance at frame programming. It feels
> >like the clear_infoframe should be poking at registers 0x9c / 0x9d. And
> >write_infoframe then can support HDMI, SPD and Audio infoframes in
> >addition to the AVI. I don't have hardware to experiment (nor time :-)),
> >but would there be a chance to improve this?
> 
> Okay, I'll keep your suggestions in mind and look for an opportunity to try them out later. 
> The hardware for this board is indeed very scarce at the moment—I put in a lot of effort just
> to get my hands on one. The main reason I'm modifying this code is to convert all of Rockchip's
> display interface drivers into bridge mode, which will make it easier to separate the connector
> part into the display driver side in the future.

No worries, it was just a quick observation from some TRM excerpts that
I found.

-- 
With best wishes
Dmitry

