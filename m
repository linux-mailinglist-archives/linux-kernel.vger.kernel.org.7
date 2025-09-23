Return-Path: <linux-kernel+bounces-828043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5132CB93CD5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 03:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C6863AA7C3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 01:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A63C1E8332;
	Tue, 23 Sep 2025 01:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y/oAUNwa"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B6F1C6B4
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 01:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758589972; cv=none; b=byg92Es4HWrh96tcWsjuI4KccNgD8EjzwMOLZCelH+DSVDFy+b1/IfCHixuKQZHpsNh6SpGExYrj1ygC4dxJMlYLGmQbJUnHAxLDN/zMukRhyFAlzcEPQL9LNvtVe3hb4CLIGIFaABABxLkDHCfcGmwo8hs1MGAP3rltQaHDqDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758589972; c=relaxed/simple;
	bh=0Ihn6jNs2bz0gPnWRWoUy+eYodJySBQGgVbqI3AoN+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ewfqCu2QseAEjSlOF6ePw3ZWcBb24oWPb1n7Chd8CuLmSHhSMPBHbJX1eZ03sp79eRD2tHvrZGnvlDdSzXoiFOwE3fjAGgc3TPT/WldSHy5q6rVpeG1JRN1Sjpp+6D6FjDj/xeXjKX8pVqXpJulBeP3nAv7RqSDOaTtfc78gI+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y/oAUNwa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58MH6BVo027997
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 01:12:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=sbAxWvwCeekeeUM4VZkkynWu
	aVVhVwplkcn9qevbOkU=; b=Y/oAUNwanp/8i/Q+2VUyIl68/RpkkET7mLx3+P4v
	ljJWg2/qAV1rTymX99LujG9ghxuiGxKTAdekIxKBy8L8K1KWfdO8wn1CcZvrWGwt
	a/I+r9PwxlfokT1t5hOa0UTGWfaoUMQLP0pwFy5CouAf4k+9MFfw7B2PFofQl2XK
	1CNh90y2zrTCQIgz9CkBiSerl+oBa1oI2rgy+EldK2cX6WLu40ZSD6t78MkU6zs/
	jf5tSPTeVf6WZm9V1RqwZDBBsR1ZW2wkMI0BZcPgp3nAwZJzEPgwxsMFzorBO4bL
	H6zExalqgFFFjjE4Un3U1OP4DQEDAh4yGLt+hmzi7xv34Q==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bajes4g6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 01:12:50 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-726a649957dso97505256d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 18:12:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758589969; x=1759194769;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sbAxWvwCeekeeUM4VZkkynWuaVVhVwplkcn9qevbOkU=;
        b=nv4GthFAolNsse304zu62R4enzKhHL1sqQ7sm2yCuImXRHA0ZYGQ18wmbyaMs6M1sj
         Rth1c70K7mi68YRuhkKq5xSo9cbrJN7AR/5EBcbZ3pERwwCkqid4kSgnuVddHoxMYRLV
         A9W8PhAzgRCFue1F1CfyZb8q2XnqfgAQaYRgt/hzA2QDtdwP1xUxHR7LC0WzcGNaDXGk
         Yx5AHll0nhW+RqAWqtGA8orf5t5esSJxCdIqSYAnt6dKG2Ls7ov5vD/Z6pW4HoCLK7P1
         0nrQl40kh/Fj2M7DM5SGYVL40cTPbFrm6GzoiDJKrgz60lOWDPVjyyOWSkRLSaqCKCey
         8zgA==
X-Forwarded-Encrypted: i=1; AJvYcCXc3KwpDz8NT8ijZysV8RsBM2/wKrjuXM6bam4MpqNFx1YhylwrgLjlGc1UBjxv+f/riU5Ey93wF2oDnrg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbNigzQvp6YLjR4+R1EmYbzwxK2FBR0QAYBZ7poHTxHx5w5rgR
	sAVFMfQ3mUXW4HeyVKUb0qXO/7dktj1DXpCF5YkiiCJBNIYtMC2+hrtY+Edx3mOikn0/zwfZUbs
	W3Vv6oyIb+7/8LPqrXX8/zWaH2EWMHRpblP+R9VRz/CJvW3KFODIBQjb0PkTAh2MJWZA=
X-Gm-Gg: ASbGncvVNEcUMV9f4owpEDomjxRSMrdqAs1xmyY0f75WdSJKi1ZpGRos8Ycusdnx1Yf
	Q8GoEs+f/FOrmFhdJOwmtVF8DhkFVasSuIDWHttFfZowzv7ajt89HURxBfk0VT9fd4FnM0o1EvL
	tDNasCEGbDyVEAhWuYVLMHu/GFFbbCjDQDtaboMl/FX4WtMLNFODmNJiCtijSHW3b+B00xUoZci
	09c8prXLt5hY+P3GgiizafAa2K7meDcZTuhzQrKFLkZtl0/GNnaFC3uQ4pV0v7sy2T4tgQJPHsJ
	qrMqMSeOPI16UyWX/m0iRSMUnsYRWi/ikkLkeQwopj2O9lXdmlLWSk38KThEuI3uLYtF35cr+NO
	6CJ95Edngh7bIkac50YP1tnYuIkAgw+o+uWKvDkeWQdBRWffLfOEH
X-Received: by 2002:a05:6214:4114:b0:784:bd2b:abbf with SMTP id 6a1803df08f44-7e705012f87mr8722996d6.24.1758589968791;
        Mon, 22 Sep 2025 18:12:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiSggGDRCsPU6/BaBSgPAIZ5+GwGUc8VAqZE9Y5TXkhtP0zAelL39yGsfxtACdIf0BhfPDXQ==
X-Received: by 2002:a05:6214:4114:b0:784:bd2b:abbf with SMTP id 6a1803df08f44-7e705012f87mr8722576d6.24.1758589968268;
        Mon, 22 Sep 2025 18:12:48 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-57a8b1ed5c4sm2579538e87.138.2025.09.22.18.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 18:12:47 -0700 (PDT)
Date: Tue, 23 Sep 2025 04:12:45 +0300
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
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chaoyi Chen <chaoyi.chen@rock-chips.com>,
        Dragan Simic <dsimic@manjaro.org>, Johan Jonker <jbx6244@gmail.com>,
        Diederik de Haas <didi.debian@cknow.org>,
        Peter Robinson <pbrobinson@gmail.com>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v4 2/7] dt-bindings: phy: rockchip: rk3399-typec-phy:
 Support mode-switch
Message-ID: <eb6ogrepo5acwcj5gpdolxxyg3xrx7kz6zrbizzseqyavvitfd@cnzurelqeh4t>
References: <20250922012039.323-1-kernel@airkyi.com>
 <20250922012039.323-3-kernel@airkyi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922012039.323-3-kernel@airkyi.com>
X-Proofpoint-GUID: 1qoDuJgffpJnTlCnMinlM676hlOVu6x_
X-Authority-Analysis: v=2.4 cv=fY2ty1QF c=1 sm=1 tr=0 ts=68d1f412 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=s8YR1HE3AAAA:8 a=KKAkSRfTAAAA:8 a=s_Y808Q6mXF3CJQU57wA:9
 a=CjuIK1q_8ugA:10 a=iYH6xdkBrDN1Jqds4HTS:22 a=jGH_LyMDp9YhSvY-UuyI:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDE2OCBTYWx0ZWRfX5JHyi9QLl72i
 eQOjbhcGN/U3gHzyVaTud5mesamYyA0Vkpg6gAVkP5sSUyDxN6LrvVxdNpN9lGPth3wROeBWzPS
 3Hbzzdzcv23BgwYqDuH5UbuEdSqgUUQ6xKtkh9k7ao9+YRLkV6ZpQth9rJLuR/NVN1Osdrsb/5q
 vfeg2mm7AN+K7HzfNqhn8Zyc4qwYoiAlrYsXec4ZUXzJ/ZWBILj3ni8jzjqdNhUhM0pcFCgLyza
 Mnu6Tb1hn5OJ+t4IZzjogu+AorhUqgg8m1BXDEHwnfwlYnDmhnQ0Y+WW03otP7SVoq/ksw7qhn8
 fM4EvEZDWEBuBt/HDzspBp9HfiYc3VtT1v9pcFU2luzfPp04wUuOsXQGnoipdFmKSsD2oOAztWx
 rfz98dsX
X-Proofpoint-ORIG-GUID: 1qoDuJgffpJnTlCnMinlM676hlOVu6x_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_05,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220168

On Mon, Sep 22, 2025 at 09:20:34AM +0800, Chaoyi Chen wrote:
> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> 
> The RK3399 SoC integrates two USB/DP combo PHYs, each of which
> supports software-configurable pin mapping and DisplayPort lane
> assignment. These capabilities enable the PHY itself to handle both
> mode switching and orientation switching, based on the Type-C plug
> orientation and USB PD negotiation results.
> 
> While an external Type-C controller is still required to detect cable
> attachment and report USB PD events, the actual mode and orientation
> switching is performed internally by the PHY through software
> configuration. This allows the PHY to act as a Type-C multiplexer for
> both data role and DP altmode configuration.
> 
> To reflect this hardware design, this patch introduces a new
> "mode-switch" property for the dp-port node in the device tree bindings.
> This property indicates that the connected PHY is capable of handling
> Type-C mode switching itself.
> 
> Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> 
> Changes in v4:
> - Remove "|" in description.
> 
> Changes in v3:
> - Add more descriptions to clarify the role of the PHY in switching.
> 
> Changes in v2:
> - Reuse dp-port/usb3-port in rk3399-typec-phy binding.
> 
>  .../devicetree/bindings/phy/rockchip,rk3399-typec-phy.yaml  | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/rockchip,rk3399-typec-phy.yaml b/Documentation/devicetree/bindings/phy/rockchip,rk3399-typec-phy.yaml
> index 91c011f68cd0..83ebcde096ea 100644
> --- a/Documentation/devicetree/bindings/phy/rockchip,rk3399-typec-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/rockchip,rk3399-typec-phy.yaml
> @@ -51,6 +51,12 @@ properties:
>        '#phy-cells':
>          const: 0
>  
> +      mode-switch:

Having the mode-switch here is a bit strange. I think the whole PHY
device should be an orientation-switch and mode-switch. Otherwise it
feels weird to me.

> +        description:
> +          Indicates the PHY can handle altmode switching. In this case,
> +          requires an external USB Type-C controller to report USB PD message.
> +        type: boolean
> +
>        port:
>          $ref: /schemas/graph.yaml#/properties/port
>          description: Connection to USB Type-C connector
> -- 
> 2.49.0
> 

-- 
With best wishes
Dmitry

