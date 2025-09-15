Return-Path: <linux-kernel+bounces-815964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 015E8B56DB1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 03:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A93BC1767C6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 01:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635801CAA85;
	Mon, 15 Sep 2025 01:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OxpcoiT4"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AE8130A73
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 01:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757898031; cv=none; b=hRGvJSzIjUqvotaQ/n1oX2p3tC4+k9zVLWf42SYGWiAuZmku5m+0z3w8PXHx6hr7yOa0lmbIZVyaF/28yc3Y2WFjMc1+3wZTu+V0QWGX11ogUZe64o2D7/17Hgn8iHmM6SEa5T1LHgYmBFMx8Nz7Uu6rMNJNOwPZMIl53t09BWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757898031; c=relaxed/simple;
	bh=0s5pIJRj2Ly706SK/vH8OJ7sZK45JIuAC7nedl4x0/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TAuL+6FjOAwycIlAlySegn3rgs1sG8YtM3frISvE8mZ9z3+yTk1QQdmrHITJgpjTI+maYBBwstUiM0aAxrKDii2azDXQJWc+83yZ/xNjTas/56w3BD7i2G8xvMFc6Dauk+OX3VDt098cQzBdX+Nnxsbby++AuM+XZ9h/e2STxB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OxpcoiT4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58EMuHD0026714
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 01:00:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yqfHnDEOnUdvEnKTky9oFQEnKcCdVMPVRKAhxqjE5l8=; b=OxpcoiT4hM+IRFi7
	bb6Fi9SXD6Seu0hGf8gqbpPvTbnhR54ccyNBLgEsGN2kWQ5TGy0FycY9D6j72HiT
	XaUYOypQsYYOd6GGFeOwSA7FOKDquOE7AlC9hsIIya92+yHZeXpDQ8uT9xvP835g
	1DQZFTx3qYU3qgZ+c71zKGHp5zXX+W1EhpDQiRzyGZryZPO6HCE8NccvHxD5HUL0
	b1/dnyyekBkzFiz8cPfdR36xJnJl3x50U/l/25TrGIJLOB4DqFGk8zP92G90DgwV
	LgIMd/vvxCrmokP/GpyYtKjezPwJbVq2k4yh6FUK60WxUAXp5kCN6ohpZMqlBaPQ
	mfCJ2g==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 494wyr386x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 01:00:28 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b5fbf0388eso51802271cf.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 18:00:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757898028; x=1758502828;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yqfHnDEOnUdvEnKTky9oFQEnKcCdVMPVRKAhxqjE5l8=;
        b=aN0teGOVYES4o30Qg1/AQy+6j9CFlgUADMSfmG9jyGDnxEaddaVolxLJMezFqx3GMo
         VBer97BpR4iQBMLSatSvueyw/IwtqEvJwB8KS9WJ7Y9pIOF/Cc/rVZNAtomoE+KDrAAS
         zTjafUVuZuRdGDAMZKrpmf4+BiaaNZFog5BUuUeRAMyr45c/1umy0bDc7T2fBhMFeXl7
         jctyA9z0gPstt8VV8Wwvvssfcy/j8aM9feJNDVR59Ba3SZzy28RREk3Gs1m6v7jwtJmL
         ncvUU7kRKaAokKccodV14s9wpjsKZ+X7vL7mdExPZ5gCwpzQFZYR63oDYZPSMiOZc8gb
         x0ZA==
X-Forwarded-Encrypted: i=1; AJvYcCVfMvsjcaYRTiC3KTw6+R4Jq3/1f8Ymq7lQyUxkNPnJnhGjRxLX3Xu77SNDQ1ijEdA6wF0mLSmFY8Y9JFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBhRGzpvDnx8GYk39uY+m9vymS5d1ski+jpljwuGuw7PrKzdQ4
	WMmDTs+HUxLPxWxAcQ/OBucwJIOXd+Jq0qlvTyQRGMQ5/gvxM20oon1LVmeSaWxgs6e8sGNrFsd
	0y9vAtLfThUWi4DjpD0eAAVwpynJjoAnTmnRpjcqo1rJtAi0CotXf0JM1/m84KIXtMtA=
X-Gm-Gg: ASbGncsed9P62oeD3wAOI468sgr/vN8kc6wH+ugNASssZrcpN6ukO4DasVzhQDnip76
	xXQWk9HsHqthGukf2OH01c3G1XXxpIMbXzdtEgpZq6c2r8JcTuvj9U20BXaYm9CU67EKVaFQlWS
	NfCdjLRfJ7SzcbJZYMeJ2DlM2q07yJ4pztSJGa0SA/YrExL9/5zVkzh3vx2heHCDpSUrl704KOt
	1udiQTX/KYUqt8J5zYVUdyJMfW/t/HJjt1esEJHJakirzSASX324EtK/PP81uUSI298TGEBEJZL
	H06yaJrKIZOqi0KRaG50Xlk4HT8B2BdnY2cSiwjmhePDB178qWV6P1TxbldG8hc90MahyjFP+Jk
	IZ74abPh72hhqT/uZxoImGVhp4e+9H4mcpMrjdaOKwzJ0iDxZadft
X-Received: by 2002:a05:622a:15d4:b0:4b4:9062:69a4 with SMTP id d75a77b69052e-4b77d018f7cmr125417741cf.35.1757898027822;
        Sun, 14 Sep 2025 18:00:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQoKXTfHUZm4ewMDtxrD3cLgoJBG5H4zVtX42N1as3HFiF8AaH1mekFLSfDZC/KfKVIHKxMQ==
X-Received: by 2002:a05:622a:15d4:b0:4b4:9062:69a4 with SMTP id d75a77b69052e-4b77d018f7cmr125417221cf.35.1757898027212;
        Sun, 14 Sep 2025 18:00:27 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e5c3b628bsm3230962e87.15.2025.09.14.18.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 18:00:25 -0700 (PDT)
Date: Mon, 15 Sep 2025 04:00:22 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: display: simple: Add innolux,
 n133hse-ea1 and nlt, nl12880bc20-spwg-24
Message-ID: <ufmwjrlnaq6tucfpqishzvdpgsxartxgohjrgyr4eccahb5jrc@5ausrm3osivb>
References: <20250912185159.1118209-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250912185159.1118209-1-Frank.Li@nxp.com>
X-Proofpoint-ORIG-GUID: bRmi9Lvo6BroOGc2IViA9kEknKgmiAbL
X-Authority-Analysis: v=2.4 cv=SouQ6OO0 c=1 sm=1 tr=0 ts=68c7652c cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=yJojWOMRYYMA:10 a=8AirrxEcAAAA:8 a=CqteVLWsAxVuTjZik0AA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=dawVfQjAaf238kedN5IG:22 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAwMCBTYWx0ZWRfXwi3vawrNOzO1
 obokxcZBa1VLgk3wwlhHQoHwdVtcYmCTh9OBMyn3X23tAx9Gp8OkYgZx78YIyNkxEhqWQOtzfsm
 qD5YX2oZ13Q7UlNlRILJuvuMJcA1CIZXR+xpdGpabnZutR3kDEh+BnngXeMvgsXFTM+omxyCqSV
 FYmWiCCAtqt7Jq2H8rps3w6UB3yHB4zyik3e6mCsvNpB2S9ZKVl+60nYIDZiyDrd+V+8UlzxCOt
 w52MeHvgEz6hLWBHGuCtefVOdag5Gw8Dk8jpYEXOjcJ9Ftb4lleSYRiiea87SdyxVTWE4P7Nqc9
 CjvqMuVRSo3vUL4RmT9aZA7DdFZJ4K1jSMig+B3Jqe7fD0h3qwQjBAWfh6XRpk5xx6zL6G8ANzD
 GmQFpOKk
X-Proofpoint-GUID: bRmi9Lvo6BroOGc2IViA9kEknKgmiAbL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-14_08,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130000

On Fri, Sep 12, 2025 at 02:51:59PM -0400, Frank Li wrote:
> Add innolux,n133hse-ea1 13.3" TFT LCD panel and nlt,nl12880bc20-spwg-24
> 12.1" WXGA (1280 x 800) LVDS TFT LCD panel.
> 

And no driver bits?

> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../devicetree/bindings/display/panel/panel-simple.yaml       | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> index 48344ce74a6e7..742ec6033b724 100644
> --- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> @@ -180,6 +180,8 @@ properties:
>        - innolux,g121xce-l01
>          # InnoLux 15.6" FHD (1920x1080) TFT LCD panel
>        - innolux,g156hce-l01
> +        # InnoLux 13.3" FHD (1920x1080) TFT LCD panel
> +      - innolux,n133hse-ea1
>          # InnoLux 15.6" WXGA TFT LCD panel
>        - innolux,n156bge-l21
>          # Innolux Corporation 7.0" WSVGA (1024x600) TFT LCD panel
> @@ -230,6 +232,8 @@ properties:
>        - netron-dy,e231732
>          # Newhaven Display International 480 x 272 TFT LCD panel
>        - newhaven,nhd-4.3-480272ef-atxl
> +        # NLT Technologies, Ltd. 12.1" WXGA (1280 x 800O LVDS TFT LCD panel
> +      - nlt,nl12880bc20-spwg-24
>          # NLT Technologies, Ltd. 15.6" WXGA (1366×768) LVDS TFT LCD panel
>        - nlt,nl13676bc25-03f
>          # New Vision Display 7.0" 800 RGB x 480 TFT LCD panel
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

