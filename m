Return-Path: <linux-kernel+bounces-660725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4830DAC2156
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 12:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEAF3A4301C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 10:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F40222596;
	Fri, 23 May 2025 10:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nuB7GT0G"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BCA227EAF
	for <linux-kernel@vger.kernel.org>; Fri, 23 May 2025 10:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747997055; cv=none; b=eX1gIvzBXan4RYv3UVjVsS0dZ02dx8FMvXuZHwN30NpSwu/bW9JjCfcYz1wD4KM8leI6wVNoQL0dk/IXkfuCQ7TNHEVYpcdKMFJUG+5n1kDnI3STqhatydXRK4BUa6kPuntgA3XwdTOy/gJ5cUvEv55l0h4lxqfpy4IP7rNmbT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747997055; c=relaxed/simple;
	bh=eDGd1A8CdNRMzewrtGp+LQNqJa5uMr8RmO6vabiZtP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dIrYFZJyDlPRf5m0PPbnum/BuOLEHz+S33dWPTYO+zTODq5ThJl8m8RaCC45FSZnSQt68sQJB/ZiB6XatgRsqw7tW3ZsisgXWh+5NCmm/SstbY6oLvvtJJJWlevSY839OmRR8n2tcT9DYzykdgsz0TgsjegbBaEX+ldGNO0EGwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nuB7GT0G; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54N5aoLW029186
	for <linux-kernel@vger.kernel.org>; Fri, 23 May 2025 10:44:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=0D7e6LvkuMZVb5n+b52vYbIq
	Q+d1bIu9hB6AiSPvDa4=; b=nuB7GT0GhjzJnXndk2Kr4Y/wfFMq0pnQl8xfl4Oa
	zzdnFzprchf2dysPcCjV+IxWykip/ft/3g+FOHoQVHTv3QkG0U6UKWcpWtUoPSNi
	E+RYHwCkVsd6BGJolCfMrBq57ZIcQXEsmQy59+C8AG7TyMg5yDxa//hlCQ/0xyzy
	nmXpMW+xNeY8MDC1QwQcqlHsldIeTx3yXT6ygsC6jlzd67TxpWAp67iA2jQixUen
	Nqrlhd7it590QLFeDFx1TkgSHGwwSkRtz+98Ll2Os2sUnjpkFeQ+JnZIhmqXEGGj
	4dca1vcpYCpXRcSJ/FHi4oHTEUMAKGAYGarADUfyf8/TwA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwf49t0n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 23 May 2025 10:44:13 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6f8c461eea3so96750496d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 May 2025 03:44:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747997052; x=1748601852;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0D7e6LvkuMZVb5n+b52vYbIqQ+d1bIu9hB6AiSPvDa4=;
        b=i2KEuyXUliercqsv9RAZC6r3KJMqhlqwooUfiSvIHNwo5vcsWYCXMatfO4vZ2HZuJu
         Yn7poV6nDXma38EWLzUzAc0MMd+b6auz/W0AxNYdFvJYBbicUgx9YHyHpANRlpnuiarC
         Y+EvQNaxyCresraSwS4mX2A4xmO0e2ZDF5XnVNBLkFdPFJw8pWVJzPsQNnIDfohQ2QW7
         gdXSmZ5PI5R+4gz0dMn2r8MIjNI2KwkF1GRx3Lrk1rGPm7vx/OEsLIQVrcIGvmhbcrCq
         WHIQHwJ0dws554fliLcVvyoJZ+uWWgmq6NXKjiS/qAAaiMAPdOJDPsmbLq7nLHn6c4tO
         JtUw==
X-Forwarded-Encrypted: i=1; AJvYcCUwbErgzxLCaMICh94BlZ8uPqFT/tdG99dKpRBll6UK2ANQPqylo9c446KPCGCSXODfzsXbFx4WgsukCVc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi5VvvVCsXQG508IIpr0ArLvRCRpAda16iKOl2sJgjQQG/6mkm
	akgWkN/cwUskw7GIBfpc5FjWCCowOT5LFsePA7KzGzSsmIqUoEiIGc55WtBQCgPaGDzZB2rG9+i
	OjEPcmuosszSawRRpSxM8Iu4Z9hBYlU7TDzMI6F8zRDYdfpCRegTW9QLkfudQNr4VH3g=
X-Gm-Gg: ASbGnctYSpykW7rEMTlZXKtcKtEfsqDarWLX8ptX4NU1PKGPAbaDc1InS4emR/WUpN/
	Vxq8CETJ6lf/VM0OSYgpQF659B4yNApxc/dwPbhaxaTYd99YyvlV6c1QxnkFGcES5GQkPPDQe/9
	QHaBOu5agX5ffcCBtOVaBGdFshgqATDaMPgawGLjRh8QKeS2n9MD+Z1glUm4+o1K+KXoa4mu32R
	BEExuySPLqo5axzqwvL2iMVVx7A9XpSeWN5ypJAdy4edIJBufx9gKqKl7bYP3NzGR2rQOBzauQC
	Z5vVHu/e5L1bAVZX95gaG+7QXTn19K6zd1LY3EP8eIHHhweMTLK5xNUNgyb5NdmEXOQcCnNhtpU
	=
X-Received: by 2002:a05:6214:cc2:b0:6f8:ac64:64ca with SMTP id 6a1803df08f44-6f8b0828750mr382110866d6.6.1747997051720;
        Fri, 23 May 2025 03:44:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeS62dzPel9ch9lSgqWKEmbxy/diUVrvetaVUG0ypD79ipE/0sxsqSYTwSLfgB7z3VmBMJgQ==
X-Received: by 2002:a05:6214:cc2:b0:6f8:ac64:64ca with SMTP id 6a1803df08f44-6f8b0828750mr382110556d6.6.1747997051372;
        Fri, 23 May 2025 03:44:11 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-328084cabdasm36493711fa.44.2025.05.23.03.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 03:44:10 -0700 (PDT)
Date: Fri, 23 May 2025 13:44:09 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Sebastian Reichel <sre@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: qcom_battmgr: Add lithium-polymer entry
Message-ID: <xwr5xiwbiyl27x3uhe5z2kvyqdkwdp3nnwzcbufr3fgmkqa3gz@oacrb7zk7dyp>
References: <20250523-psy-qcom-battmgr-add-lipo-entry-v1-1-938c20a43a25@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523-psy-qcom-battmgr-add-lipo-entry-v1-1-938c20a43a25@linaro.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDA5NSBTYWx0ZWRfXxE3RPz2hWAuV
 pwUE9kdhYT+voz/44zOZaEz0LnJTbeppm3sTC40Y7T3BzM7jS1N/+glRG7wQUMUs+6TFiDZ3qFR
 zOVfRWNDKjRYZh10rk9SAbhJAi1uD1/AqILru4jQI6pAFPUBa+yiMo/7PBauYjIicZN8WJ0Tg6D
 aiKJvDtlwDdDR4m2QOYrCwO+7w/qfNhu1R5jinWarIDLNecrgFAtsfHaYsggJKJKgBrpQMmx8X5
 Dlla8f+0Kyx4RzRm3bhqFEMGUOWnGHaw+AMx0es8e7oksyLJQR6EQJpXVh6NufttIQQaSlosPJq
 KHyahiG3n+WWcH4dBKYxYa+ga72IdfKzPJGgLFSfLs5/+O15gKZB7VvwfzNB6j8Z7bi5uMMNfrP
 c49+bS26yaeGNcfrDzCBcnsBqSPOIf0lvXAEW7fCcQ0XVobH23s3pWZOeR5Z5BXUHuSIql1T
X-Proofpoint-GUID: 8xZPZR9_qR0WX8Npw9Ll2jFQP8BT2ZXX
X-Authority-Analysis: v=2.4 cv=Ws8rMcfv c=1 sm=1 tr=0 ts=6830517d cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=dt9VzEwgFbYA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=rZQgA2wR-xeWlAxma3cA:9
 a=CjuIK1q_8ugA:10 a=1HOtulTD9v-eNWfpl4qZ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 8xZPZR9_qR0WX8Npw9Ll2jFQP8BT2ZXX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_03,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0 mlxscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 adultscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505230095

On Fri, May 23, 2025 at 01:14:22PM +0300, Abel Vesa wrote:
> On some Dell XPS 13 (9345) variants, the battery used is lithium-polymer
> based. Currently, this is reported as unknown technology due to the entry
> missing.
> 
> [ 4083.135325] Unknown battery technology 'LIP'
> 
> Add another check for lithium-polymer in the technology parsing callback
> and return that instead of unknown.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/power/supply/qcom_battmgr.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
> index fe27676fbc7cd12292caa6fb3b5b46a18c426e6d..32c85939b8973422ee417c3f1552f2355658cf06 100644
> --- a/drivers/power/supply/qcom_battmgr.c
> +++ b/drivers/power/supply/qcom_battmgr.c
> @@ -981,6 +981,8 @@ static unsigned int qcom_battmgr_sc8280xp_parse_technology(const char *chemistry
>  {
>  	if (!strncmp(chemistry, "LIO", BATTMGR_CHEMISTRY_LEN))
>  		return POWER_SUPPLY_TECHNOLOGY_LION;
> +	else if (!strncmp(chemistry, "LIP", BATTMGR_CHEMISTRY_LEN))

no need for 'else'.

With that fixed:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


> +		return POWER_SUPPLY_TECHNOLOGY_LIPO;
>  
>  	pr_err("Unknown battery technology '%s'\n", chemistry);
>  	return POWER_SUPPLY_TECHNOLOGY_UNKNOWN;
> 
> ---
> base-commit: 176e917e010cb7dcc605f11d2bc33f304292482b
> change-id: 20250523-psy-qcom-battmgr-add-lipo-entry-e75b3be303b6
> 
> Best regards,
> -- 
> Abel Vesa <abel.vesa@linaro.org>
> 

-- 
With best wishes
Dmitry

