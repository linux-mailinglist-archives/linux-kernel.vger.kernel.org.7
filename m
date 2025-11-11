Return-Path: <linux-kernel+bounces-895229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9519C4D49B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 527873A4F98
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB16357704;
	Tue, 11 Nov 2025 10:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VZE9KAt0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q+UnbB4E"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A12354716
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 10:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762858482; cv=none; b=e+0jj0DG5HTQB1VI911Pw42bqwCpwHyUCTMZOsI/9XUO5ukZ17ufYnr3iLOEovJpHzqxe7PTmuUpu8OPI8RYfJIurXewECrYcDpS0pVU0BcUbUu97WYyUKAJlNJGx8WMn+Ta9mkgBTk66Y52fcDD5tRrYId8MIjs708OJGO0Hos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762858482; c=relaxed/simple;
	bh=uX2FRXbwwZCCv1tYbHwS7dtnDr3CH51sdbhNp9wWUD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RTi2o3wGm2s1hq5GdwRj7eIG8M1kB23LgDUFV412yWZyxj0Id72RvLrrSG1Y54YOv8NVrX08jXFKOvm7T8vKek5o5mQFCChUVNjFwXhmXz+C+p8teyb0Ql3isNEiHfKaiboznXNy0lvoFDw28amZZd46SssKHOrMV1oEBVYuXpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VZE9KAt0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Q+UnbB4E; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ABA5Oci1001865
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 10:54:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=bjzJGvDc5zRS1OfTZQSifCpq
	YpVSEVlEOhF0L9KjMqA=; b=VZE9KAt0/uqTpHpUQlsHtUrGzV2Xaiq2acFdXg9B
	0Oldk1XNUX+M1FOafQpV5D6QJ3w7vkE3cuvA4gyK0ZaWgcnfsbRbLDqWuydJgUSD
	TUwTc7wXaXDRna/cAp+lomRL8nBE5FmtQokVflqaVpOufdXbfX3PAdSl1BP+qeQ4
	gInKNEuGfpxRdqveezwIyNsQoWkxys2ksQh2mu0KL8Gc2yIArPBAgMObTxnc8o6H
	CUq29WUP4BccXcwNsc72oo7yfgMws46TrdCv0uPKImHQyhKAEr1EV5Kw8B2uT7Ct
	Kr4hhxoosmF8uKkkZZhjGFGSDyBAEwM7XSB48SLrxiDYDQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abvhthbtr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 10:54:40 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ed846ac283so19847101cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 02:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762858479; x=1763463279; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bjzJGvDc5zRS1OfTZQSifCpqYpVSEVlEOhF0L9KjMqA=;
        b=Q+UnbB4Ewj2XeOZajBcSkjqCzmU4qlhJZkbBDIcJ4bUqtniuBEJ9lOJMnNLIw92FAr
         VtueYJeLxyh+pc8bDLDyaDK+o0dmbDLHAuf5P1ZoPGbJ5jyKGDOK3SD1pBjdwx9WqFk6
         MTFM0K4nuJypr3CwvJkDQYUTCbIEV2OUMu2hP/gqL7Rq6Zhhk9UObdgYVq+HXe3+siNQ
         1cvV0xulJiMPNQ4kX3PfssHujeO0lG+i3DnljgLjF9kqrCEHcLYPSYS3jZnJ67qwip60
         DKz7kMsBU8b2o3/bYcI9RIwR0PLxuTaqJS/8wbbwnjFt0XTabzOhuG21j9I4ph0ew0LZ
         qQWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762858479; x=1763463279;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bjzJGvDc5zRS1OfTZQSifCpqYpVSEVlEOhF0L9KjMqA=;
        b=dNVFZLqjHeB24GlFOieKkcy/jP8SNXIlbWq1F+JZHMXRhpsw8bA9TE4q7tq/PA/Z9m
         lLuIwin3e1ntkTgnGQkdsNBra4SJGzRBwJPuuVjeO2teXIM3yFWV9EY5VSdgMyQfn4B1
         fnrMDCIjCJ+wv4NUhgGLLk3MC6vVlo3TWwLXpM6y7cl1bl3wwLQANLld5qa+Ltl3oO1F
         GsF8fmpSfwuXoHFBYv0Ldsi55q92AkcJtR4MZzQ+X7fzhdOHsh8CM5YTvTyIf1vsVzZj
         792Ou2JmIhWQLA8fSopfwCMxd6wdViCe4W0p9ny2wyflX+6EO32l6hoTiYXu2Xw+5EIi
         NYUA==
X-Forwarded-Encrypted: i=1; AJvYcCWUV8mSNuDlnv3P0vjZAldn7nPxA25yPRH3fdgz1uiuo7V5xMbjaevmVuOyImUaRKdB/xRy+Pk9B54bjnA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUwvUc0Mb+GmH/r3e1bBZVvBq98Nx14+0M3KfbVKLgoOFNHdFv
	KSufumoG+lXt1X1k+ZmJ9BVjqy7chta8bbklRit0pgT8aKn15Ylvkaai/WEc1FAy8kq/HoHXT0n
	Y7UK9xF1mEqMIlTmDHbAP8A++PmDbCkTZ+yjFrxpe1fSZAtohGo9bU3Xpyz+XZBrvCW4=
X-Gm-Gg: ASbGnctHxCv2gdFyvCCGe7GaK1oNY3XpbuUdzU3UGdqTBU++QCVvwuUPaIJUPxNRn1a
	KVIvacZatxkJrEkH2Pus9Bjl3XN73aaRAQvQAuMcuhf4gAGE5L86AEj6w+xnNjSTg1/DpJOXFAK
	84egGDsQCS+xYF+VEuf7G5fip6UeBq8JhWhIfaWH3/r8LTaa/gItlZC2TOJn4cXEvQyjT3hZgSn
	r8VLcUqqvFBzM6XIlFxOPUpMRGGvWY5CuWcQWOVpd1pYeA/eVwYlkH/wFT8vrEGIi6GYnNJe07Z
	lRVp0LTKrc+G688BXDt9TDXMCIqHNVE7fW95BiDWwYwXi4Gino7rl9kQ1jKQjYqpHk0obEnS9o+
	OIPYxkSXeoRtXMiha9a0nuOKGQ102YAhF+pzM3tZiz7QH4/mbnZCscWlkhL/220ddiZc0y9m3EO
	DfdqC0MfB4pbF5
X-Received: by 2002:a05:622a:188e:b0:4e6:ded9:6b29 with SMTP id d75a77b69052e-4edcaaa3ea4mr32888491cf.3.1762858479498;
        Tue, 11 Nov 2025 02:54:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGlDf0js8yY75bKRYmabDEAq0elXP2pI/iZd6RI90nqeKsx02RoVZL9jJHhTzE+f6l/HKMiwg==
X-Received: by 2002:a05:622a:188e:b0:4e6:ded9:6b29 with SMTP id d75a77b69052e-4edcaaa3ea4mr32888181cf.3.1762858478897;
        Tue, 11 Nov 2025 02:54:38 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5944a0b74b6sm4784539e87.64.2025.11.11.02.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 02:54:38 -0800 (PST)
Date: Tue, 11 Nov 2025 12:54:36 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Manivannan Sadhasivam <mani@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v5 2/3] net: mhi: Add MHI IP_SW1, ETH0 and ETH1 interface
Message-ID: <ljrvtl447meb34zfgzef3dw4oqfp6j3ixxwoooewxxvqsi23tz@fbg4zkpctddn>
References: <20251106-vdev_next-20251106_eth-v5-0-bbc0f7ff3a68@quicinc.com>
 <20251106-vdev_next-20251106_eth-v5-2-bbc0f7ff3a68@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106-vdev_next-20251106_eth-v5-2-bbc0f7ff3a68@quicinc.com>
X-Proofpoint-GUID: H8MysA6J97GHCVGQtC44ivNNSOzTZbYI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDA4NSBTYWx0ZWRfXzcUX1wJ9MJVP
 X0l8+OtsaNBZ5+U7xzBlXSNi/SYvinxByv24x/pmZdG/4RG3QCh1Fz6Bjj0FTyhfHNSyG/vGajI
 8zA0RN8JgEmBm0+lnYotqVNGEnRfclLa6I1df6XKmbHN9iAbaOU68FjNObDwWAH99JtdQzNm6jl
 1d6vl5TH7QDwKPwNZ/b24HDrTLVr8X6fkuOi2FYcWZkxDSC85QuQ8SjMQtT1CxvRTkO7BYv1W+t
 35tjRcP4zkra2QkTEWp3+LiXHh293194X5womVuAHnFvpJ3ttuGR/cTdbJdhy8HnqbTXKarNy8h
 e+se1SpQSMtklbCpPFBlOjIKYjS4ZsQ66hbgRbVdMeHpHFuSHaBtRrLZiVT6d5S8L3IP+hPCXvq
 qPLRiHH0l+ukFptD6ltk7lJ9a3Bs/w==
X-Proofpoint-ORIG-GUID: H8MysA6J97GHCVGQtC44ivNNSOzTZbYI
X-Authority-Analysis: v=2.4 cv=d4b4CBjE c=1 sm=1 tr=0 ts=691315f0 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=bC9JWDkrhmRD4PJ24AEA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_02,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 suspectscore=0 phishscore=0
 adultscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511110085

On Thu, Nov 06, 2025 at 06:58:09PM +0530, Vivek Pernamitta wrote:
> From: Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>
> 
> Add IP_SW1, ETH0 and ETH1 network interfaces are required
> for M-plane, Nefconf and S-plane component.

This is a very useful, totally uncryptic message.

> 
> Signed-off-by: Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>
> ---
>  drivers/net/mhi_net.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/mhi_net.c b/drivers/net/mhi_net.c
> index aeb2d67aeb238e520dbd2a83b35602a7e5144fa2..7fca7b1ec7b8250fca5b99ba6d1be470fed87995 100644
> --- a/drivers/net/mhi_net.c
> +++ b/drivers/net/mhi_net.c
> @@ -449,6 +449,9 @@ static const struct mhi_device_id mhi_net_id_table[] = {
>  	{ .chan = "IP_HW0", .driver_data = (kernel_ulong_t)&mhi_hwip0 },
>  	/* Software data PATH (to modem CPU) */
>  	{ .chan = "IP_SW0", .driver_data = (kernel_ulong_t)&mhi_swip0 },
> +	{ .chan = "IP_SW1", .driver_data = (kernel_ulong_t)&mhi_swip0 },
> +	{ .chan = "IP_ETH0", .driver_data = (kernel_ulong_t)&mhi_eth0 },
> +	{ .chan = "IP_ETH1", .driver_data = (kernel_ulong_t)&mhi_eth0 },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(mhi, mhi_net_id_table);
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

