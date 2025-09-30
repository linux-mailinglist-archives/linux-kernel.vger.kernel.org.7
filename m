Return-Path: <linux-kernel+bounces-838094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A134BAE6BF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 21:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BA2016E2C0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 19:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35065287516;
	Tue, 30 Sep 2025 19:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HeCoswil"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4F2287259
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 19:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759259825; cv=none; b=RoBAw9ZWh5yJPy18jmjp9KQCRulXj/wKsj8cwnfAF1xO/Ncx9PhWuUDUtjpAwQ+pas5tI7xe6lieM0wclvpzA5/ptdy+QLdmWrbs88Dv4xqBxX7IDMwT98byI504FYJA8nzJobe/wYiwyaM/JNScCSImSVhT+OW95nDn/+5CsVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759259825; c=relaxed/simple;
	bh=44UG9dRy9/fwmbXTFNYj/VESWJLHlVWNqviEeWagbFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UUsevykAXEMzsLfcBqPyDHCa+vmnC4BYSvej5uy5ByvxxZV4r60JR2oKpzm8OkNBJesqLtQL8DBW9INj+uQ577I6O6NeKdEyytesKhRsA+3Wcdk4lWoxwaixWzRB6pa58E/b/G7PqfNirhCWSpDfebK1QpvnKI0QLQCkIo5a1aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HeCoswil; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UBolnR027554
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 19:17:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=fIoZL4IX42meIGYJZYMC2O1w
	w+tUNy4ioZpD/pNofyA=; b=HeCoswil0oy1BaLEp8q1C2pWmz6i9r+lSHqgt1dT
	Qkx0d7Z7hD5sp4Wrx0iw4Mm8E4c6fMaB+zTCM761UN+kV3XUGcx/KZBsMgio/Kip
	zFtAdzbBAyPBkc0+nyjtRYbd8RhTS3KQuiDnljECzyVt7wuCYE9jGabdPZr3ObYk
	v81OcjQhpJ/9Du9FQN9tzl7XvywEzTn4qHHwx7oq2feYHNPI4jlVaNs3rF+ZmJGN
	KrgGMxiWXjjKbxm7cz6DS9/U/AgZ3Hsu3lofjw0c23td9txPNLj41JQURqenDRD/
	22yu8cegpvj94L9y1IXSdcyYXnoeoj2BPPVk6ZhSInTDJQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e851j5fj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 19:17:02 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4de801c1446so102049661cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 12:17:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759259821; x=1759864621;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fIoZL4IX42meIGYJZYMC2O1ww+tUNy4ioZpD/pNofyA=;
        b=HIhp68dh4TdMByWYpWEwXzcDCoM0OLlYnpiGmbZM7/6kcH7vvpeIySUR+xRJ0n33JC
         2Q3XpGSuN9RTpTTkHTrgMYL6xuTfhHoWO92/PruVR7ZQKNL/uBTWMuGr5I0pGk48VY1c
         8aEmrCeN+mbe1XJPgzP5ttI6eYTBU3HU0VyJWGPKcGfjP5j9Ezlsd4xPm6jpEqAy79xf
         2oq0DuTAqu9t4v2E+y6gZPY6br/OkFNqOIIPH0U+Z3aqvXedbwDyVsUzGXZ18K+NksqH
         B1cbj95qevmt+EzZysrE06/Oz28K/S3ZOoLEggIbvrPxpBCJQqBLgjKMJguGkbLHrldu
         Zc7Q==
X-Forwarded-Encrypted: i=1; AJvYcCX9WhEH7Q7vYNvmS2B5vg8hyb8FFjPyQuI9d35R+hr4UdjTLcfkyYifCZgNyW8+Za+TXVHUWHGLOvxGBRw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa4OUI/TKelSvq9BEfvTg5iCRlJf9x3ugjVBi9E0Qv+RKgLRMX
	SCYx1rrn9xXstCORbvcXjqpRwtMEgZA2EseVjSO+5bEh7KKFQlGTWT6D4YYzCeGJEudpJTjTGiu
	q+F20faO8c+246ZJ3Aspg47A0LPagY7WBw7d3pgbaDHvqTplMgjVaU4niJD5uK9rEvao=
X-Gm-Gg: ASbGncsduGlDay9bNSc5zCxpe9KIpNcbBxPzxHSIQZXIk9EaijQcaRcLnpVKeiA9VFe
	FlkUZSPE3VvGZyUAJkApBUnJ2lgMB0sx4B4ZOoNd2/kUhYgsYZVdesGo/IFjNBtIrWNMtn0//W7
	psaeMDKCbs+N6aXDPpAbTWKqlvJDkOUHrHDSwBP6SCES9MMF3/bUHsQKfYl49ycnf/maQX61yfe
	HrLeGSG3tkygAit3h5l14WXFvdH2sLxKZlEa65Ib0kZVl8bQbN2vTy8o7VqekwirN4WUn+iIT3P
	ynuWaDGsFxfHgcOL8NICrmNRInAnplZuvLzQdlpLZoGMv8qD8n4jjtnHP9MLiElfFL29fLp+IXN
	xvwjK0faRCxMX/JsHghwkdUJhOej3HuKUIHS/mLtPT+5DLffJGWDoR1sbvA==
X-Received: by 2002:a05:622a:4acc:b0:4c7:e39a:388b with SMTP id d75a77b69052e-4e41e15df77mr10119771cf.47.1759259821091;
        Tue, 30 Sep 2025 12:17:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOjGw/13ibdEaq67tmXZnXJFrkmO3DlfDDREr0t+56wazs2jNMn8OyuMT31Gg9i7tKZgg2lQ==
X-Received: by 2002:a05:622a:4acc:b0:4c7:e39a:388b with SMTP id d75a77b69052e-4e41e15df77mr10119381cf.47.1759259820658;
        Tue, 30 Sep 2025 12:17:00 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-583166560d1sm5130604e87.71.2025.09.30.12.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 12:16:59 -0700 (PDT)
Date: Tue, 30 Sep 2025 22:16:58 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: TangBin <tangbin@cmss.chinamobile.com>
Cc: srini@kernel.org, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, linux-sound@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: codecs: Fix the error of excessive semicolons
Message-ID: <dxuyn3sa55f7k7ecwhxi4v3y6n3kw7nyftkrbmwt2ufobya4bd@ipdy5bz4yrzu>
References: <20250930094103.2038-1-tangbin@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930094103.2038-1-tangbin@cmss.chinamobile.com>
X-Authority-Analysis: v=2.4 cv=OJoqHCaB c=1 sm=1 tr=0 ts=68dc2cae cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=R5C9hjxsAAAA:8 a=EUspDBNiAAAA:8 a=foHylL8Yi6giCiIZhfYA:9
 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAzMiBTYWx0ZWRfX4tOaGHpXA3qS
 dSMQR+NDHg0w0V3V50+bhAnH7zXOlv2PRf7C8BMAQRXnAavI9vDDoG5N5YRsk2kpdIV1du5PoXz
 vOihnjUBKd/uXPD7+yRNufRi0Gqc1a/jApLXTuk24k5G9OsuWkZMyu9bsevAnTsOBsj1wzvaINT
 xEkD5EL/a6wQFR27Jjs0mV+m1UyndsN31Lg5kfjt/jOM8hsEccejlzi+x9EMDGQD9on8yGc7Srt
 53MSCtxkqRHx9eYO1I2j2Qz4RKRkFobWK9hpsEEJB5lhkJp1NQSZoYpEOOiKYcTik710pYNJhD2
 ey3Ky9AR67zdYdO7q4F0gFuI92BnRfOzF81uHex4tgrOkVIcnrmlMrxh1ayaBIvHILfSxJKLwIk
 Psi7I3tA85Tq8tLJb8Xj1KHJfGKQLA==
X-Proofpoint-ORIG-GUID: kyBSua3kuAJKKfdTAOrRDnbP4hesN1aB
X-Proofpoint-GUID: kyBSua3kuAJKKfdTAOrRDnbP4hesN1aB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_04,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270032

On Tue, Sep 30, 2025 at 05:41:03PM +0800, TangBin wrote:
> From: Tang Bin <tangbin@cmss.chinamobile.com>
> 
> Remove unnecessary semicolons in the function
> pm4125_codec_enable_adc and pm4125_micbias_control.
> 
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> ---
>  sound/soc/codecs/pm4125.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

