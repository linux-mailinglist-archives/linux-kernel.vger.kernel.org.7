Return-Path: <linux-kernel+bounces-783059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D89D0B328E2
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 15:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D4411C23D15
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 13:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEF5393DFC;
	Sat, 23 Aug 2025 13:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="esScmJq1"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18E417A2F6
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 13:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755956990; cv=none; b=WNPLk7UnM2dJbyiAtJhjNdFNWwREXfDsE4zwqtiDrc47nLxHOgRoRCISJkFzHWESwmOfW0jnous70CCDRbEA77HhIqcNYO0GqEO3AXczvfvO4J+wqCydn78HgEX+xojwDsvpqHCiA7O6jv2x8ycX90gKmWA89VbhgFp6Uymwb5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755956990; c=relaxed/simple;
	bh=8a5YgUlqZW/ubZvLLh0hAur9fmf0pOjpnzLG3GP9Iow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JVgFUQjBZqyzLHCoZyhUtGb5kiPOuazon7+xMW0axqGe4vAIOM01EG6IejV+SUEEh8uiEmB5TGhi/QUlcteOwW1PGruzUyzg/58Ccdd+ocN1mUQPOyssPPI7wkVVpSrd4Jd4UyNKkkI3Fpk3mFZCRtlNTR4h5Pcl6ksxXE+Xr4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=esScmJq1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57N3d77Z019664
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 13:49:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=NJutXUx9GwbOyDCxu0OWA/tm
	x5myteKgI5lzXDqLEUY=; b=esScmJq1afz0shmLdLYmLpDD6Z+89szHUSJ/5+GU
	Zk/vYSEmBVI/mAP/nvVNpIwlBxKYedTO+PWzTV3KdgxOl8g1sEK7kIw1cd8LUkiZ
	koZWRgMkauLbpP6Z7kbxAkP47GEp5gM5G2tKiUCx2ib6ZUpgFp/Dza0H873ag7Xv
	ayc6cfuWZmH1Epkn23t0A55+PoWPQIp3d7QpdsffJ2hEZc1t0UGELxhcY/UOkGVa
	rV34lHMEtr0/Pa5lHtrYl0V+awcr5hUIk9LvxRzG1pMASjQhDddhLDGopFKf9f89
	n96SmbHJsuX3KaW/ImIxm1B/IpzFkmR17lMLNvEAsd0jfg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5wdrwbg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 13:49:47 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b2bf285aa5so9458511cf.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 06:49:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755956987; x=1756561787;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NJutXUx9GwbOyDCxu0OWA/tmx5myteKgI5lzXDqLEUY=;
        b=if48N87agVIUaAGps9DTqesn7VVCeIzMW+C31DDGcsgu/eE716eQgVQzs3QrAbEePl
         h82hk6LwZ5y0ksEGgzR422mwJS3nMjz5YcglX8ywPbiAGDAYZW4ZF+hT05n1JKzHWDoS
         siZnWiVP6zKoAkRoY9RDSjp1iHHG+9EIzDsmrvqhTiZrkxYggnveDj9tE71YaJsHy1mb
         xiOfPvDAJYexx19jCo+A5CQx7YWEtb2Ur/Iy8nYxEnm9nWUUXj4mMM1W3Ol8ooT7JUYn
         dG6RaRi+v0CLns/s1iSlpSrh3HG7VWiq1LrLNfGHPs21o4QzHNhcV0cpr4vLFLbwc5KS
         Aiyg==
X-Forwarded-Encrypted: i=1; AJvYcCUwnWPebAooVLGd5FlY8m0oxcVbWnuQH+TnXWZcXfyH/BSDLqTx81oz+0EvLCpJjJ7926l8ZwWgx646Q98=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/DteSgb2vOUC/pdIYjTJGRs4M5K9OyveF/aRRbvh5eRUPUa1c
	fmzyhF18W8HGW+F+6HD4SMnYD/2NvnZ/BqT5sw75ipWa81jo+b0ifRvafsPPAPUkHusYyATCLTd
	yRKkbrkACbMOBAmpKiG0q/SdoM/HlmfgzLumuZQ7wyXa2PBOXfseZ/9135YIbZL7r4ss=
X-Gm-Gg: ASbGncva61rYKnRt3nKa/i7FUVPfbGAUH78lcj/ZxOhNFX8MEWdamI7D/iBYsgo3Pid
	BSA6+Qz5qG1GfEP9zH/4AF+DosXO6Bi/LOcRJgm8/oKMyUx0c1sTaiIqcprwdqJWCOLJ5RPS7pc
	DbUeZgvKhhjil04zi9yIGxy1tZYd2lXYRKKCDz/Ibj0uCbbO5qmcpE9BbhMqZ7dpLwnaV+innOe
	aEINMONrsWHXSh1DpQ2y0nvNDO60NaXn+vpHJeHAjMCJMpZ7DHz3uVNc0r1wsQQ5tbb2VpCoEZx
	z97TpE+uxbBGfX8wz9uccLNnnogT8HqkQloqm8CM0aGoBNqUiQgoFi159cxRjJUb1pb13e7Ktu1
	ttRig9SAFJguKb9D2KIMw9pyP4aO1TmCUzRd3UuYz8CiCFbw5q5wu
X-Received: by 2002:ac8:7dcd:0:b0:4b2:967f:cb4b with SMTP id d75a77b69052e-4b2aab242c5mr75185691cf.63.1755956986646;
        Sat, 23 Aug 2025 06:49:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2g0EFzejzCmD7mV9QSqwLqUbabc5ibMXHvpMqoKZRAVTOkV1CMYQolhIhiB2z113FQRZ/OA==
X-Received: by 2002:ac8:7dcd:0:b0:4b2:967f:cb4b with SMTP id d75a77b69052e-4b2aab242c5mr75184991cf.63.1755956985376;
        Sat, 23 Aug 2025 06:49:45 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f35c01e5asm529627e87.26.2025.08.23.06.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Aug 2025 06:49:44 -0700 (PDT)
Date: Sat, 23 Aug 2025 16:49:42 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Alex Robinson <alex@ironrobin.net>
Cc: robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
        jessica.zhang@oss.qualcomm.com, sean@poorly.run,
        marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm: fix race in Adreno header generation
Message-ID: <6sdzghcc4uynvmk6r4axpwgqlmgxqzi457ttedqlrql7f7lt47@glsrzu46a63x>
References: <20250823020919.9947-1-alex@ironrobin.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250823020919.9947-1-alex@ironrobin.net>
X-Proofpoint-GUID: OsivXWGZCLgjRO5Sy3Tj5NOO9Ym0G7HT
X-Proofpoint-ORIG-GUID: OsivXWGZCLgjRO5Sy3Tj5NOO9Ym0G7HT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfX9rRvXH/+UjA+
 CT0aMvPPHlkiDQ8NCtAq3knFwf2CTFxTyPh5BRAI88LgKpCJRaBuM+q/dKrr/OtXzPTGNBYyy4a
 7mkKDfo7F7uD+u6xMRZwHbefn1BKPD/hpZt0a/XDSCvJxgDPavEwBhMWyBE2j3BVjKnvUSOy0SY
 KOZQzasUJskhhgO5++lmhQJvoSyiqYTctGmKfG7gGMC7GG8TxCdyOpjf6dDEa6JaRFvZOxh/WCQ
 jNgUT8wDHTcJNdwTeV8Q7fRWA7j75bhB1Sxk77qtXHpvlKzHTfkQD9fpu9KfViX7nGNSwg8Zi41
 CzhQ82bRDzsbwePTEZSwX1Ol1pwhiS4qGUu0/QPMzuNgtD0HdLD+GfNlknVxberaJM1oH5jJ8Tj
 NIasS6CD
X-Authority-Analysis: v=2.4 cv=BJazrEQG c=1 sm=1 tr=0 ts=68a9c6fb cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=foaXouvCAAAA:8 a=lkkxZxBEGYBqsCjUt94A:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=lBkOZJTZZNyIbKe29SIT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-23_01,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230033

On Sat, Aug 23, 2025 at 02:09:39AM +0000, Alex Robinson wrote:
> Builds can compile msm-y objects (e.g. msm_gpu_devfreq.o)
> before adreno_common.xml.h is generated in trees that generate Adreno
> headers at build time. Make msm-y depend on the generated headers,
> removing the race.
> 
> Signed-off-by: Alex Robinson <alex@ironrobin.net>
> ---
>  drivers/gpu/drm/msm/Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
> index 0c0dfb25f01b..1a918d44ac48 100644
> --- a/drivers/gpu/drm/msm/Makefile
> +++ b/drivers/gpu/drm/msm/Makefile
> @@ -221,6 +221,7 @@ DISPLAY_HEADERS = \
>  	generated/sfpb.xml.h
>  
>  $(addprefix $(obj)/,$(adreno-y)): $(addprefix $(obj)/,$(ADRENO_HEADERS))
> +$(addprefix $(obj)/,$(msm-y)): $(addprefix $(obj)/,$(ADRENO_HEADERS))

I'd say, no. The idea was that msm-y should not depend on
ADRENO_HEADERS. If there is any dependency, please move it to adreno-y.

>  $(addprefix $(obj)/,$(msm-display-y)): $(addprefix $(obj)/,$(DISPLAY_HEADERS))
>  
>  targets += $(ADRENO_HEADERS) $(DISPLAY_HEADERS)
> -- 
> 2.50.1
> 
> 

-- 
With best wishes
Dmitry

