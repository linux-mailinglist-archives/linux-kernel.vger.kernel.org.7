Return-Path: <linux-kernel+bounces-849221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E3CBCFA06
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 19:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A1623B891E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 17:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB81C28151E;
	Sat, 11 Oct 2025 17:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pn0h0OcI"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9701DF75C
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 17:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760202431; cv=none; b=fQQkYPJt54GWZnziGBSSIewjtuH5TMJ4Vo8lCZ49lnmjgkBM+fYRRL+9IUUltI4WgP79IUYd1YK/tpwKIgF5caILceBpNxL8IzIogbBya96SogQPBlu/E+9jEy5J932d29qrvZLzY2Y4jttpyV6B3f/W3tbSGv1NtQOwgfiu++0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760202431; c=relaxed/simple;
	bh=AkFr9QGDyeuz5kArh2v3+a2z3VK8A38QHCu5APZRPds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F0GYgav1xizFzCiO29uQHjpl59Q6ZZTF/nT/bmoR+5TtDRphp/NpdM5d0nzbpe9VZOCF2KCHNzDctJkdYUkHEaR52lGU5aGZoZrTSx4cINlj7Pdpnl6Vk88UdpRT81O+KUIfmF1Xfv2zTH3OPlT4I/ZCsF8iuGzTEi0OqJgemQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pn0h0OcI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59BEf4cH002472
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 17:07:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=mFycPb6v8NKaDe6FYB2/8x+o
	vkGxvomJsSjcJN9pEKw=; b=pn0h0OcIRdlCvpvf8AjJVH6nVCXg8NEJeCQW75q2
	dsToMtpqSi+FaPkkcRIipiaBow3F8Mt0xdph6Ty33wqPLR2jpF+MAGyHWJFRDBVc
	2g6SrzzItdXMZJs4RIo5yF3mVzUscJ5f/jt/1v16S4qXdikK6xk/2yBSH6l5Grxa
	AQvyG2gx0K+oz9bWCm3Wd2g2wskZ6FpJ08hr+IkKiXAJKtNQQ2ZENVco/RnbZkqP
	0ycpTVwbCwXLwDB2OXc/DxiGSnhT3vqtijHOw7tdwBYTXNeYQdUS2/J9Fih49Fi9
	a/UE+LUVGdC+a4YIb1jekPmVYnHt4wT42DujL4yWW+rGPA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfbs0xwa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 17:07:08 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8589058c59bso2541316885a.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 10:07:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760202427; x=1760807227;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mFycPb6v8NKaDe6FYB2/8x+ovkGxvomJsSjcJN9pEKw=;
        b=w7RmBoE370VCUxc5WXlijEMjUxPr/PvciDXAm2W6khGeo0yC/LwG2xgt3tDr1RpmJK
         5Xu2tfS4f46TmH+X/zROOxzntZYQJBflsTg7kJTfKrdKj89RI9uVxKE2T8hSHdD6Ahbu
         EWTuJ0AVONLVGwMYBD4hRcjg2xHbmRtyM7+ZLGu6YysHE9ROpepd4QZVFTUVHFA3gDfN
         9cZ5XOUKyJbkXVdahpa1hg1/vQyzP5Ri+mgnh2av9oI5GT4O6tN9olf66oAtBMSZQqzv
         ex36OF62tJ2Z/TborkWsD6kuMsu8Sw9CjT/Glt+8g6vGQWNbajlRNpLFlfdX73k6KA/W
         Xszg==
X-Forwarded-Encrypted: i=1; AJvYcCWsKZODtkgVKDrkm/v/9CjOjSQ0jsvWsNhm5ZpLijGG9JNbW1KN6BvhTyZyGdFMyObIki6XQjRHREgUaYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDUleH/3OyOByc3xKMUdQJUFMesBQpH2kRWimS7Nw8c9FJD3+v
	q82kbmYqIyTUuRq+bD1TkutPn0aPbY2fZfRDAt6FgRPHH3gYao7Ago8sDoogSg2yMhbKM/u7iDG
	BfsCN7eu1LjowJJmw0a30TGKPK1YLQTa+Qfv8DaAUp6eL65AFwSIYsEFHoGM4uLL1dNU=
X-Gm-Gg: ASbGncsP+rt9EcGsgDGabZRBI4HEuEyaLTKzdyRiqs/6OPP5TRYx2IbiKjHmVquy006
	IKJFX/4wLaOxEwVtO6oEJ5GzXZSeep9STYqnHDGN9S+4jzx8sJA3Cc15o3XLT8CaGmrNB47yHI6
	lo8/YU1gt+Sj881gW41b72z6Auma0cFw9MEmXfKnGC1yE9+YtI3JUdE6KdvlJG+ngQUAX02wM2u
	tqkTybZ6/VDA6mLtFlrsNOgk2fHFtjI/ZUjjDmYmOTVyAsTO5qSfsboQpo2In7atUd5oWMBH+P2
	OcSIWRoaj/LLXrRoPXkQU6bUxnbTAxmI+gxTpxneD/dWnpplyHxMkGMGV604/2VXrzswCvC+FNw
	fjdxslG9yJCKCsDxwem3D4JlmXMSSNgyZjxmb2tqXdhVxx7swkZqf
X-Received: by 2002:a05:622a:4a8a:b0:4cb:102c:56b2 with SMTP id d75a77b69052e-4e6eabf437fmr231238491cf.0.1760202427570;
        Sat, 11 Oct 2025 10:07:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGnG/nUOQfuTmf4P38ClaQ0pqxIsVT4KwQ6QvBre1kD+zoeTzKlRbXjaxIWC6ayUXFmCULHg==
X-Received: by 2002:a05:622a:4a8a:b0:4cb:102c:56b2 with SMTP id d75a77b69052e-4e6eabf437fmr231238041cf.0.1760202427149;
        Sat, 11 Oct 2025 10:07:07 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59092ed98d9sm1244485e87.24.2025.10.11.10.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Oct 2025 10:07:06 -0700 (PDT)
Date: Sat, 11 Oct 2025 20:07:04 +0300
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
Subject: Re: [PATCH v5 4/8] phy: rockchip: phy-rockchip-typec: Add DRM AUX
 bridge
Message-ID: <jcmn6n4nbyjsmpvg4q47wxulgddizhiwax4dcb4dokrvj23eur@g3nvwkssg2li>
References: <20251011033233.97-1-kernel@airkyi.com>
 <20251011033233.97-5-kernel@airkyi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251011033233.97-5-kernel@airkyi.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX6Lqk3c61Hdc9
 VhsFg0VP3mBk9F08fefqPscJ2srWTeWsZOnK0roOAhY/XwMi0618yVxY5bkLyabnaAbcSjxrAJ2
 Bt7wRjQAyAUMrfXOCMGnoPsNZSNo6qTQC2xYjN39Rle99Ouw+KC5/B8REj7KG8hdco8yBOEmgKE
 LqxrnihDfwEAjTA/qRfJcoDsM4DhhrJpeGXi6DTuyuiB3USN2aCxYRpHgYVMiVztad24UUosUdX
 nXzKpyCCJGMIqm5nzDh1zcUJH722aQWxq9c/xR+0hWqcw70ci1gOdn/XLHKg9vjvGqhXUvq5130
 gEwDsnfuXwhUpTFGZTSVq4ViSXYd+zITqtPr0zNb3ndN6QrIeDCRM9r/0GwUJe1rnZsE0CjnWu4
 sZcnVorVBNXQqDQ1sb5X3mkBYIcT3g==
X-Proofpoint-ORIG-GUID: Uj6rWnloYKj_kKYEztkkx2d__xvDd5m8
X-Proofpoint-GUID: Uj6rWnloYKj_kKYEztkkx2d__xvDd5m8
X-Authority-Analysis: v=2.4 cv=U7SfzOru c=1 sm=1 tr=0 ts=68ea8ebc cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=s8YR1HE3AAAA:8 a=-wB9imSA1xWJEod_rSAA:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-11_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

On Sat, Oct 11, 2025 at 11:32:29AM +0800, Chaoyi Chen wrote:
> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> 
> Using the DRM_AUX_BRIDGE helper to create the transparent DRM bridge
> device.
> 
> Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> ---
>  drivers/phy/rockchip/phy-rockchip-typec.c | 52 +++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 

        depends on DRM || DRM=n
        select DRM_AUX_BRIDGE if DRM_BRIDGE


-- 
With best wishes
Dmitry

