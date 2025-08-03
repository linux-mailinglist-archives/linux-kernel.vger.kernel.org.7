Return-Path: <linux-kernel+bounces-754406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EADEB193F0
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 13:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F04E23B71BD
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 11:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8647F20E717;
	Sun,  3 Aug 2025 11:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pPjJJlHx"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EB92BAF7
	for <linux-kernel@vger.kernel.org>; Sun,  3 Aug 2025 11:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754222191; cv=none; b=oDkhpXm68VNvIJqCOEiyVJs9SDg2LQmfakkwvjctQTgWYgk4Cd7B+PhlSM8wa23CMJy8vbJFgbShKqYE1WcdqxIl9qDVPqpGU5qej/CT8dXHi3FnHmHHqIBIOnK+XP5dl5v9me6rg4ACGCyGfWYnZZODGa9yihsBdGo6jFtfv/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754222191; c=relaxed/simple;
	bh=BiB9+lX4eCcSSlgXJRyAFhMotOYASVjCR01Gzdfh4d0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/ngg8Y0915L1GuRMTZhSwlyaEoMrGH9t60jdFc4IuziMX6495njPJf4m0ARBCBMbnzCh3/ExTkBqxZCKOk1dZ47LUcYNjyVsgZW9/Y37RjV3LRqmLg2fyTiHEOuvEiQ+DZzgzM5gmk89zihXSnu3hn9RAmIVQtMRvqdsYKD8PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pPjJJlHx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 573BXL7W018863
	for <linux-kernel@vger.kernel.org>; Sun, 3 Aug 2025 11:56:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=6ugECVcJfC4IsqMv4ZT9nbZT
	Iyzca/vp2GaV07FTpAg=; b=pPjJJlHxrVxMi0liS+bqC64qi5JCp8TK5LQzX3sJ
	VD9DMFewGPp+4tiFSuugHmLuwUcyclheRg0zoROjMtQRp8Mm3NemvTlg6LuI5070
	B6E/x5w1FA/SQPWBE4lhcMPdUfZZCjN2VmNu8iZrUDfE/vsPAGuVkZP0xMY5ksHg
	/q/CLh/MXtSue2Xp70oaSOUs9kth39fTUi1Q2/F/RMDSiuHlalWSHjqG3QdzkNWP
	VzoIAhB+3VYmhPwBbckhHpyf/DIqpgdOc0wBMNsyEXIdrPeZVWbfa/W62shp53Ez
	VpqvaoYkRy0Hhrfai9yY7abqnjSAm2DgJZxDfLdVYfaDvw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 489buqj4vg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 03 Aug 2025 11:56:29 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e7ffcbce80so6022785a.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Aug 2025 04:56:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754222188; x=1754826988;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ugECVcJfC4IsqMv4ZT9nbZTIyzca/vp2GaV07FTpAg=;
        b=FZ2K1BN/SNgSLCSqsBa1HbIOyccfViONnVP1+wbKpzuAn7/jHZh9Fa6ZA3ulP3Li/Y
         63giHfoO1V0H69yinyKpa+uSgLDNA1whhwMSCLzNHaDjrf6pNM94kc6HRGTPxp0FgvOj
         yv9wNU1OOr/4T0v+farCuJNqQ16aNkmZJgTNltN1t6v5rldW1Mv8UH0B/umo9FjkYrce
         Rez4K3flpeyVuGrr//1eP+UtUmOvDVD8WLtdZKcrTvm91GFPmxvC+podnyAtM6kNfHtI
         FUeeSsb8lzObrvdlQZ1hSa/gb12ew9F0TQja8DgMqFxzOX1bIS/QmVKrlaXHA9fmZ2QW
         mgqg==
X-Gm-Message-State: AOJu0Yz0MAAQZ/eVfpM9ataFMobBvXZIRqQdjCczgnkpXv/4DAsQFcMS
	EwVLPATiF+oNKiKEZ66/m8jpEOXuBBCeamSjq3PhPAjdhZsUXkdwzwl/qtQoI0C3HNVrB3Uv6AX
	DBu/ueIj0GljaCSXjyajE3tCbDS6snnZPu7dwm2rkaxhyHE8s3+dd7T1OezLeWR0tL8Rezr4fQm
	oG64OP
X-Gm-Gg: ASbGncscZwflCCIN23mBvSQDWoGHg2h0Fu/WmQT+mEI2x1T1UdVj5zE+Sr6OuDWeV3u
	cHGdNxCrEwWkuZxeTp1oA1Ye1AP0QL4ABjsvyiNut+eg2EUSD1GfsvA+6oFVO+WCbO0nanpprHh
	wToJPvs+qd/4KGk5ZGdMF1pRZfdYKvMf+PNL76p9UwtR8UDlBva/bU3qv9aQW1KcO1RbF7ZeKbu
	jqLopNjWlgi023iWzYEnGi7BuG2PmHDgUosJzuI0NnYc1uxZWnxaGCZ0F7/Xu9gQThKDjCcwGLc
	4uO4ndvw9qEu4Ghhm9kVLIM+yfOXhBUbHOvn8qm+knIYGH2dApQHjFDhZOaVyGlu1izYim0tYT5
	CwpOeVBPVR/cHL42I+9kSouWXpatrXUhiHQQJgLC6GVNPj4wRckp6
X-Received: by 2002:a05:620a:1645:b0:7e3:39c2:9856 with SMTP id af79cd13be357-7e696268352mr662088285a.1.1754222188233;
        Sun, 03 Aug 2025 04:56:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6BW3ujWZkak3zpCLkrt/tfZsQQRCiNUSKNPAfRJE+y5Gbg2KICgz+ZOmYbwqk9iZpbuxljQ==
X-Received: by 2002:a05:620a:1645:b0:7e3:39c2:9856 with SMTP id af79cd13be357-7e696268352mr662085785a.1.1754222187833;
        Sun, 03 Aug 2025 04:56:27 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88c9931bsm1276838e87.101.2025.08.03.04.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 04:56:25 -0700 (PDT)
Date: Sun, 3 Aug 2025 14:56:24 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        David Airlie <airlied@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2] drm/sitronix/st7571-i2c: Make st7571_panel_data
 variables static const
Message-ID: <w4tlpcw6s6yogacneo4gthor5annn3qjyxswrtrisoqawdbf3p@y5r7gkrmzmdo>
References: <20250718152534.729770-1-javierm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718152534.729770-1-javierm@redhat.com>
X-Proofpoint-GUID: iU4SSOtYp-F3nCCCuAiAtkO9_3moYXqQ
X-Authority-Analysis: v=2.4 cv=VZT3PEp9 c=1 sm=1 tr=0 ts=688f4e6d cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=20KFwNOVAAAA:8
 a=EUspDBNiAAAA:8 a=TIRtq7bqiOsBIkxYvl4A:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAzMDA4MCBTYWx0ZWRfX4kMfNLLcD9/o
 LGjvgSZHasNYAsuQX6hTEyNOOiB+gUwdrEdoGdLptgEQb5Qo2+WgBTwQapozOBC2ozxyZ/yxsY6
 rdK+dgGCKpgpbSQK/uXYz6LBbWK3T3lXHKBNNl4jQh3iiA+gChHEsvoy4e7My2oCuVQIXrHQh9x
 SJKCbJvCJ/xABS0K8O9hltGwN4gOk5v+upKg4/2lTeyDTgCRq0XQ56w1T7NPzbl6kKOwa6cHMOA
 q9W1GvbZuXxaC+s3C/3itQhBgQ1L5c1nXagNq1nzLqJdalEGfC95EotPB2d6KzTW/9BhsFJrzZA
 AlVtnNwIXtW0QPbSBmlSTEIAX4zNYW9MQTSKL0aO5QyHPqKzMSZ4F8IdW93AUTp622Scs/1QzVe
 ro0HyOHz0iHNFpcb2PJoU/0ydv/3nJ6/JTdJV5ZzYYH2zsMRMSmfg0M1i8GcoxBfRnIPH6vV
X-Proofpoint-ORIG-GUID: iU4SSOtYp-F3nCCCuAiAtkO9_3moYXqQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-03_03,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=992 malwarescore=0 bulkscore=0 phishscore=0
 spamscore=0 mlxscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508030080

On Fri, Jul 18, 2025 at 05:25:25PM +0200, Javier Martinez Canillas wrote:
> The kernel test robot reported that sparse gives the following warnings:
> 
> make C=2 M=drivers/gpu/drm/sitronix/
>   CC [M]  st7571-i2c.o
>   CHECK   st7571-i2c.c
> st7571-i2c.c:1027:26: warning: symbol 'st7567_config' was not declared. Should it be static?
> st7571-i2c.c:1039:26: warning: symbol 'st7571_config' was not declared. Should it be static?
>   MODPOST Module.symvers
>   LD [M]  st7571-i2c.ko
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202507180503.nfyD9uRv-lkp@intel.com
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
> 
> Changes in v2:
> - Also make the st7571_panel_data variables to be const (Thomas Zimmermann).
> 
>  drivers/gpu/drm/sitronix/st7571-i2c.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

