Return-Path: <linux-kernel+bounces-801618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5E0B447A2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 22:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D551058766F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 20:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E44284B33;
	Thu,  4 Sep 2025 20:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ASsq+nhj"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE877275B19
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 20:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757018726; cv=none; b=Wh6lOwvvaia8+UCJxdeRQ7vNFTNPS//fkk8J69A5cEiBFuqqEa7JhD1cQID/Vyq8pPC6Ke4pwF8WLD//tGKP/euctcoXRjulpf3UVI3DJuTjC8jTvxTivzM5j+fItepvD8flRdSG7YFYFltWhUUnRExXnVZwbqVTVd5u0R/zMpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757018726; c=relaxed/simple;
	bh=goHFT5Fojx7NPl6TJEnx+eQN9pctyR3h8wRytbQqm7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z8EdBS1gWhWqGegZajG0lNoE9qUtP0v/31ucf00l6uWeavPB+JIUHNRkmn6M05bFIDmXo9uEYKja6BjsF3ToQVgYI+cATVk3Q07H42v7RJ7xND21ihtoWWNAZsXlxy9alYqG2V3dmvheUC0+wkJlaq4IkYGgNkYuC8fbiTL8lJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ASsq+nhj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584IAEZd031754
	for <linux-kernel@vger.kernel.org>; Thu, 4 Sep 2025 20:45:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ah8XoJw+rgAX/8W20N8ua7Zu
	YMCg6XGeT4CJSEmlEg0=; b=ASsq+nhjXy0T/utxPI0L81ICdz13PV+WiSq4OoGB
	9pa7gEUH/ByTZFniwt19U98nOgxrN/BWLh6G3dVN5LEtJTVf3IRoOg4eBA02kWb1
	GT7mIt013gPkB2Ph9I9NgdfBsisfb+8erqoPgv9NFGkX6YAGuUuMahEweMBKBfwP
	CyTRn1yV+HjzvhI+grE4Unkjko8LUQMeV9dheKVNofoea+CxxAl/HWvc63yz7pA1
	X3x5ggfNdmdTdUcB5tyy7UuG/hco53ZIDoBTA6GHXDMYhOcLsQi90jYixQ+cdTJm
	sO9ENsmffFJWkPSVC8gUwQsfEzisALm9VcJgVfAW698Iqw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urw08x2e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 20:45:23 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b32fe42b83so24169611cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 13:45:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757018723; x=1757623523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ah8XoJw+rgAX/8W20N8ua7ZuYMCg6XGeT4CJSEmlEg0=;
        b=c8BhdpvPC5E4lYEPPBftDKllEdiRndh809EktmhG86VWoS3kYjHLEplPC8eMz9C2L9
         nZcLC5/xJCxMm6Q93mGKNqEq4A5lx3A1P5EBu7CIim+c4AkFsFnG6i3rL4jNTMcUnh7V
         NisBgB++6yiSKWVcu2yAsNuC2uQjqjRwhBMaMg0F5HleNzsHPsm7DNXTNu7BHG4DbrAJ
         7D7JspksFG93cCit2cDfKVrPIQWRdt774TMHiVUXtuj1w+UBznf3nLc9BlrBzBxtoSRa
         ZH7EFIP3vn5hMZkSpsJO3jduRJwUWWdH5cptZMsXX0iirZLPeOOY53uoNfxeVMZDAbiH
         +mdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWb0YCXHI3f5t7zP7eZI1+1N3ZgiNekxdXHRlHu7sbqZhY3HRgDkzlGu8gXt0S+csO1af800syddPRVGUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYu1JFZp6Q0o4jhQIjKzuwkgsbAuIFpJ//YUZd90PLxXdApecx
	E1suZi4WotOxK9vrYa++z4TodU/fn0MGzivHfot7Cl5FPbbsTiji8vx7LymDGxBGwBjD3pDr9IL
	GSJEHBUyPjKf4yxr1OyLyw+jORQ4+PVi7Jpgv4EZBsUfSIlvdfgqLfaiJQlaSG2PjdMc=
X-Gm-Gg: ASbGncsE1pNn5xR73eUoFUxbEWc4ahUtSdNjnEvk7HPb5JGRV13xPJOclF6u2cHkufw
	vfN7ttlbyLAiufF8Xlq4bstIQ/LuzRLzWcuguI3O28C1Gp22kOZBg5DYRXjT4UgdCDpqhm6rLaM
	xLGJXvZqNrGYViIESiqbXnm9GRdgoVqP0BzyJx3jNp2IzJW8TYs1B/MKNEt3k+kNttrCHe2SWYe
	Jf3iCds6C/tmFJqJEmsnOHNhCbwjYbofr8jADHO1sewOWwgJjEvBDiv92pdZV87hiuX7AmmNONH
	qhWxM/YKPHjZ9UsPMchQzUdkfWjpitYGpr2GjKbCjPS/FM1qfOt3uP3S1p1XtLfsJ6WpAJXoxVM
	EQ0oXJ3n9JIkfTDF0CTYD7cb7NE/jzjqU59DL28hgVDMC8uQnedrj
X-Received: by 2002:ac8:5d0f:0:b0:4a4:41d5:2a03 with SMTP id d75a77b69052e-4b31d7f0a03mr103406451cf.4.1757018722500;
        Thu, 04 Sep 2025 13:45:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+J8L1I5811Gh82XYHGA2tv3WmCtFswhuFoDmxujp1dacvtjBsEDeCAlLFIU0h8/1YiIUj8Q==
X-Received: by 2002:ac8:5d0f:0:b0:4a4:41d5:2a03 with SMTP id d75a77b69052e-4b31d7f0a03mr103405881cf.4.1757018721940;
        Thu, 04 Sep 2025 13:45:21 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-337f50b0898sm16424661fa.58.2025.09.04.13.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 13:45:21 -0700 (PDT)
Date: Thu, 4 Sep 2025 23:45:18 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vladimir Yakovlev <vovchkir@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/panel: himax-hx83102: add panel starry xr109ia2t
Message-ID: <to4alnxchf56lkvguacmh35bquzbczlonhqi5xoi33alufu36j@4cgkzx3sgzod>
References: <20250904002232.322218-1-vovchkir@gmail.com>
 <20250904002232.322218-3-vovchkir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904002232.322218-3-vovchkir@gmail.com>
X-Proofpoint-GUID: s88d_WZDm0xnuEp52WCfxvsG-9YBZjbz
X-Proofpoint-ORIG-GUID: s88d_WZDm0xnuEp52WCfxvsG-9YBZjbz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNyBTYWx0ZWRfX/L6wUj/kFAyz
 IXvozH1WR/eknDTlGCDN5sTZL4ek7SnxK3x4I3iIauldU+Ka//2poga9CHm7nG3CtY4G2w/w/xX
 fgOnK2z6x6Me+QqqHkbnYU2gOIsIrB8HIkOwwS5aAvB6bNyzzHleiJBog4/rBJLwgPnYxL7KF4t
 ReLplc784mUMpQFWUO+yjEA647Gg7ds2rbU7ZffhMsNHGH20Q7VkK/55iDRGiivV8FUrgMVop+4
 8i0nPEz3u/u92EAeJ7rgk9m+Pni2+BJmlTLqOMU9uk8yOZhFDIGZd80uf6nmXK3rYxppAth5INA
 gU2bbo5GA0NgLFoO6y/WjEkuP18/lAQRBHFWq+uf7zYITlO+oYS3tqMKShMyBT7TjvWDgvmsgCI
 TkPIyWLC
X-Authority-Analysis: v=2.4 cv=NrDRc9dJ c=1 sm=1 tr=0 ts=68b9fa63 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=ACYfBu3xzRVhRnfl0NsA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_07,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300027

On Thu, Sep 04, 2025 at 03:22:32AM +0300, Vladimir Yakovlev wrote:
> The STARRY XR109AI2T is a 10.95" 1200x2000 (WUXGA+) TFT LCD panel with
> himax-hx83102 controller. Hence, we add a new compatible with panel
> specific config.
> 
> Signed-off-by: Vladimir Yakovlev <vovchkir@gmail.com>
> ---
>  drivers/gpu/drm/panel/panel-himax-hx83102.c | 193 ++++++++++++++++++++
>  1 file changed, 193 insertions(+)
> 

> +
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETPOWER, 0x2C, 0xB1,
> +				     0xB1, 0x2D, 0xED, 0x32, 0xD7, 0x43, 0x36,
> +				     0x36, 0x36, 0x36);

The rest of the file uses lower case hex. Could you please follow the
pattern? The rest LGTM.


> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETSPCCMD, 0xD9);

-- 
With best wishes
Dmitry

