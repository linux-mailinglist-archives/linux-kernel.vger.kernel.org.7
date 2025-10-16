Return-Path: <linux-kernel+bounces-856886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F22BE5555
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 22:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 060554F14AE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 20:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD292DD608;
	Thu, 16 Oct 2025 20:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V9b7Ms4e"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A183F2DAFAA
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 20:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760645560; cv=none; b=hwyayKnSyJOoglZWZnsDUp5F4uS/RY6hBpxqA79bCsH7nV0sqeWjRc9LWxUdoYzxjK0ebwyqd4RbW0712iKWzRxGqKYmwuU4ob12T0iK8x5bN5h1RXBloLaEEbyqCl1C5JzvoD8oIsZLYJXsyV9IwfX6V3pwZW2cu2IJ8f1ly8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760645560; c=relaxed/simple;
	bh=Yc2rquSHNMuc1rfF+Wxo10/YY4Xo8KeVQbhx60ECIFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FNJDGndC+aXRTch94AAUhVgWkgvDm+pG/lAE/uviJxD1gjRo++MzArS5lsgAgmhR/pcHX9fnOfWNArYW4BYX374rTaq6g1o49H0TTzp3bZQOATdhVntpPWfHtEL9pZUi90nVemb9DqZJRrWRgddqzAenufT8IDfzgqE2jXyACQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V9b7Ms4e; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GDLZAE022809
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 20:12:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=rejfN56i3rrzjApXLDYPUwGP
	UcfTw/rwEpayOvgqk+o=; b=V9b7Ms4elLH2vsKIynD39CNPVY23imAm6pnZxSZ6
	w6B68lYA7KolqhutrlwAGdYLIk6anj1Y0JV7icdl9ocbg6p04vCiFm5jTWH3NqQ4
	WO3R9KdxTuNKRYQf9LRZV7ZnI4ODCYM6Cl2G8AdGhprqywBib3t9U+Ufdj/esjgQ
	Sb7lt1TYqN3nRzblFQyi75BhxuviyHDs/IbQRarSRR+VgyNPzaed/L+UgtfIgLLH
	BnYYGJXancgmkSmf3ewOyO+Bs43KVbaY+jm6ump1+sxDZBBZLf/mhASB4pkvw3JJ
	JlUOQ1MkjNfL467rCoyvH0TTOuLNPiL3QadJwWZ+VPzPPw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49u1h0s9d6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 20:12:37 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-89087f3817cso50511785a.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 13:12:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760645556; x=1761250356;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rejfN56i3rrzjApXLDYPUwGPUcfTw/rwEpayOvgqk+o=;
        b=mLSKYfn5aELZzJ27FtE8Wr+1cIpaAkheniji1DeVnb2oVWCKeyRIfzU0egmujbfVun
         qTdwS2mggcL8d/HmUmO8B+cWYfPbXqylDIpgVKhfevyZaNMFRBZul3vCeBLz569x1Ruq
         7fpumUvRyzTcu6pgnkfYAkTJ4qq/zP+ckDW3OW4JSQiGWrgsPVLgK68jgulRIxWWW9a2
         AOpVly9O24phackELTM0CCKhY1H/Rr5z7CYBI1waR0z72LYsdHYDvdtenHfpYn1ZtVkJ
         r0i9w7RNqhz42Rn0IUi5hRuQ+9OIOcTbWXMtY366KgQJvPVEWK1hir/QATuJUxjp7ibd
         BKHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsDML7oU8nTeyy7+BTi4EEgLsyiz2BnTFzSKQ9WSa/FXEjZ8zWcj/aZUrAhzXHPGnB+Nk2SB/UtUvir/U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+0Cpg1I6u5zgWdHkdUuazSr68H9N1Nj4rcvr2RokUOqPoZhPt
	8NJcA+tT/EMBf4SznfcqH4oRb6GvbfAAI+KxbM5fAJU5Ei/leMFvzhewDnvTKXsTndi5YH4sGc6
	GKYCHurPzMWmy6JVaRjfimQb/fXXk/3IRdaTuOnjuCaO6B4WefZGaV9+8S/3DQ9GP5j4=
X-Gm-Gg: ASbGncsyAHbmB4ANvSB7phAvhG/BIot65aMeI5tRmjzergxu5FsM4AXP0v+zZvMLV29
	XhYvHtuZN3EFP2HJaqQtblqg79t4Fg2tAH8yXy6ol57iJRTkeAJNm2bKSDuWfbftKAUmos/ayQA
	PfDRRBuOUYR3qAdMjrJabNfJtzVHhKRPqAHjIWCQWT+Ax34balfPaGbPqUxfQjpP+FK205YGyI0
	WOhPWmbtl7gOJV22TxyUzDkCgtKPtmSYIKO5kktI2FNSNTUpLuslCcrZ7YPeinfGjarJyO4yAID
	xCOL/UBw/JAmRNRPlAIfKv3MGP7mUF+1xGesCbRlGEiGFtW2f5DcZW2d9bPG3aEEih+nn3lYslY
	zsgDN5EESig6qNoXNzQfracNVPkMiKHuCdQ2diPosm3UCGkO8zDt/RByAuGIQ0Zj/KWqi1JLFVB
	wcO1I8CBsXJYY=
X-Received: by 2002:a05:622a:312:b0:4e7:22c3:2f2a with SMTP id d75a77b69052e-4e89d3f374cmr20498831cf.76.1760645555972;
        Thu, 16 Oct 2025 13:12:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEO5U0g7kRZ1LMCajGgW2ZKcTweTmabQ+ZEUOuyqtJjtkCMrjBTPjj6nQiRD8cUh2pksrXuYQ==
X-Received: by 2002:a05:622a:312:b0:4e7:22c3:2f2a with SMTP id d75a77b69052e-4e89d3f374cmr20498221cf.76.1760645555357;
        Thu, 16 Oct 2025 13:12:35 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-590881e4e21sm7292388e87.2.2025.10.16.13.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 13:12:34 -0700 (PDT)
Date: Thu, 16 Oct 2025 23:12:33 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: david@ixit.cz
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Casey Connolly <casey.connolly@linaro.org>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        phone-devel@vger.kernel.org
Subject: Re: [PATCH v3 4/8] drm/panel: Add Samsung S6E3FC2X01 DDIC with
 AMS641RW panel
Message-ID: <didkbltadu4ql6xcqtjrtf2iguody5bgy6mqlwtbyfgbambaii@mzofzymnfbju>
References: <20251016-s6e3fc2x01-v3-0-ce0f3566b903@ixit.cz>
 <20251016-s6e3fc2x01-v3-4-ce0f3566b903@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016-s6e3fc2x01-v3-4-ce0f3566b903@ixit.cz>
X-Authority-Analysis: v=2.4 cv=esXSD4pX c=1 sm=1 tr=0 ts=68f151b5 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=WFa1dZBpAAAA:8 a=bBqXziUQAAAA:8
 a=JZHlp33AlScNdFJXQgwA:9 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=MZguhEFr_PtxzKXayD1K:22 a=BjKv_IHbNJvPKzgot4uq:22
X-Proofpoint-GUID: djj4VAN_WxYCEOHYYCzhxD1GbgMdJHsy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDA5OSBTYWx0ZWRfXwMRVK/8ux6lv
 21jen1naDRNxcCvSp83JW1dLMm9zEod0HHGax00dA5IOiKpHIu5NiTB3RjEarteS1flFnEXX9DL
 5//9Kx/68om6Q/ztrsq3C3xl3ZQDculnmcfzAvleTANMWn/Q2nJFwE/s5xplfRL+ZOOMxRynZPg
 QerVn0i6C3JPEAL64A/9rZN6/0XsFP5wza23+Vjuig348lye9lo+YoRmh7TxnXNUg8TEQEmbHMm
 BNhnPAwuSo47WxTJuI+BvqTmLZqhcPICrop+Y6/tQuf1uEAsBJ6OMBN0eLIE4XT+4DhwixU0BGC
 ls4S6/fD+yUA7aLvNY+oppVojuT8pwoLSKg248WoCRZWkNDMU6bzVm4ttDsotf3tmxnSnYgvza5
 qE9UWxC3MExZaeBJsYa1rvChCK86vQ==
X-Proofpoint-ORIG-GUID: djj4VAN_WxYCEOHYYCzhxD1GbgMdJHsy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510160099

On Thu, Oct 16, 2025 at 06:16:59PM +0200, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> Add panel driver used in the OnePlus 6T.
> 
> No datasheet, based mostly on EDK2 init sequence and the downstream driver.
> 
> Note: This driver doesn't use previously mentioned "samsung,s6e3fc2x01"
> by OnePlus 6T device-tree.
> The reason is because DDIC itself without knowing the panel type used
> with it will not give the driver enough information about the panel used,
> as the panel cannot be autodetected.
> While would be more practical to support the original compatible,
> I would like to avoid it, to prevent confusing devs upstreaming DDICs.
> 
> Based on work of:
>   Casey Connolly <casey@connolly.tech>
>   Joel Selvaraj <foss@joelselvaraj.com>
>   Nia Espera <a5b6@riseup.net>
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  MAINTAINERS                                      |   1 +
>  drivers/gpu/drm/panel/Kconfig                    |  13 +
>  drivers/gpu/drm/panel/Makefile                   |   1 +
>  drivers/gpu/drm/panel/panel-samsung-s6e3fc2x01.c | 399 +++++++++++++++++++++++
>  4 files changed, 414 insertions(+)
> 
> +
> +static const struct drm_display_mode ams641rw_mode = {
> +	.clock = (1080 + 72 + 16 + 36) * (2340 + 32 + 4 + 18) * 60 / 1000,
> +	.hdisplay = 1080,
> +	.hsync_start = 1080 + 72,
> +	.hsync_end = 1080 + 72 + 16,
> +	.htotal = 1080 + 72 + 16 + 36,
> +	.vdisplay = 2340,
> +	.vsync_start = 2340 + 32,
> +	.vsync_end = 2340 + 32 + 4,
> +	.vtotal = 2340 + 32 + 4 + 18,
> +	.width_mm = 68,
> +	.height_mm = 145,
> +};
> +
> +static int s6e3fc2x01_get_modes(struct drm_panel *panel,
> +					struct drm_connector *connector)
> +{
> +	struct drm_display_mode *mode;
> +
> +	mode = drm_mode_duplicate(connector->dev, &ams641rw_mode);
> +	if (!mode)
> +		return -ENOMEM;
> +
> +	drm_mode_set_name(mode);
> +
> +	mode->type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
> +	connector->display_info.width_mm = mode->width_mm;
> +	connector->display_info.height_mm = mode->height_mm;
> +	drm_mode_probed_add(connector, mode);

drm_connector_helper_get_modes_fixed()

> +
> +	return 1;
> +}
> +
> +
> +static const struct of_device_id s6e3fc2x01_of_match[] = {
> +	/* samsung,s6e3fc2x01 will default to the AMS641RW mode (legacy) */
> +	{ .compatible = "samsung,s6e3fc2x01", .data = &ams641rw_mode },

Is there a need to probide this kind of legacy?

> +	{ .compatible = "samsung,s6e3fc2x01-ams641rw", .data = &ams641rw_mode },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, s6e3fc2x01_of_match);
> +

-- 
With best wishes
Dmitry

