Return-Path: <linux-kernel+bounces-742397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81977B0F136
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 13:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FD8F7AE68F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 11:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8B52E49A3;
	Wed, 23 Jul 2025 11:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y1/Q8lel"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD3C28CF7C
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 11:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753270267; cv=none; b=ZY0wY8+lH5ZDjvtuBEW+WetLZWndYw+FBFJ5QROc19SuKzhnMmczRJkSNcBFkq39HF4Q1RNAUHgrefkXxkDISoDFErhVOoW3kzUYVullqDPEnN99bNv3bdecvOiCXSoIVmaXgPo3N7mIsMaRd1xD2R87PJ7hX1Eun8WTt9aUdV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753270267; c=relaxed/simple;
	bh=8R/2LqL8EYjHk+vjnbWhMiilF7QLr2f1y5Aen+tPoN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jdfx+0lugbg91we3N+zmfaUNqSOgZ5gObCzS4WBNwBTarYdvSwm+PpGCXFjYRDDqO69s5q/o5uVaVGZN5XSmMpAiC99JaNuyfLa7qjuc6PVghMQ85yKM41faaQ+z7aThfsSfLI/PEau0I8ZwtaUumgPbRv6HKDpuEfVG8xCXQi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y1/Q8lel; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N9RcLX014861
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 11:31:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=LEy+cd4XZeFNsCcKEQ8NGnzC
	xyrPqaqP08OMrM8m9/E=; b=Y1/Q8lelxaYHM9CS8hCLfOfC/sejyZRu/Dxaw2jJ
	RSNy+cchs6J90LtctQBth+U+2BGHsnG49Skhsl2l62LDgYfp6WTbFrMVKwIyuQx2
	5MC/PLU3SIYZz8ViUCBocs3O6sIRYaIdDZO4BMtnrLqiYNHPicHtyseQCyHr/IKK
	DPgyieLj/j4Vxx70j1K57/N4+p2tp34640qRP8X9Rzfk6HgYD4QqI+pyfy0mVVz3
	W3UpLIa5/oVd72s9LENFDcgLx+NH3WOckYKMmblhNdzTPTgOzJp8ze4pl4CxwPxu
	Tcxy1aaowmU0rRAShauvgGZ1P6XFzne/iW4YS0q8yEFuKw==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48048vbac4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 11:31:05 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-4e7f9ad4deeso446006137.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 04:31:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753270264; x=1753875064;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LEy+cd4XZeFNsCcKEQ8NGnzCxyrPqaqP08OMrM8m9/E=;
        b=OccPr7cAPm+2J6XkezbArzKQz/yU1XKxJ1RMjGP1yNavHNgvZ5RgRQno1hTzQUBD9Y
         EFmzZ+75d7XNMd/qY7dxIGBtGwUECMjInOkrvOnXIDEr+W4N7LEN+8oKymTJSLpGIVGP
         3oxC9pIAKkzBjE6fxFI1j83tYjExEGroCwvw0wR8MGRPDmZ5if9A+KAIIHCNIVL2KlXM
         gGzYrlr9nkxHUCo6E9F9Sn1rHNBqgKjOeH67Kjhhw9LxU/WB3KtEsulP/5lj9KGwcvUR
         3EHU57qRih5UijIEgZn/y+iI7kTK5Bzxqi9QaolW35DG7CBIJW0VZFzq74ZZjKuQdhsa
         P70w==
X-Forwarded-Encrypted: i=1; AJvYcCUu2BtZmAPRK2JIWGGTrm8SL/71bdzN3llNTeDp0ihF9mQkf7iM+Ph7tN5ibCA20BiRcStjBG6n+BpN/AA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+B1/BuJvPJknDhphdbyrbim5sxSTyD+FIypQ5Pr93Cij+Kvcu
	zcsShqLLgi5JGzlLMldjQ9DFOD3lQGctSRT3PDjBfLVfX3hD6VmNyXE4OpiYjvfXLPrOKHYTysh
	IzSVc7aSI5Nwfe5B4C6k58ImMIeJ+dT6MN5WDbSa5pjc+zPkYofLucMJPvpCvK1yYru8=
X-Gm-Gg: ASbGncuA7k32qnJCUfvlpswk//ObszJiEE6fTlwVfzgOH9bA1HanFlhgSeGHZcimpWz
	RAMMTWkfjpzMUAHsKcQRh7TI5zb8vKldrbCjKbpdS6TsZSWM+7Dvqmyj2aIaEAzWw0z4JVU9oCX
	MnjkSEsVxoXXNOo9yBXdZfXjnNPzqole3gPpcbICwZHhczJo3y04pgUG2D8A6nkhGTGSm+kfdLN
	GECmChPcnPsjDWhZh8AIaEpFqmIUo9Gcv/J07mFuBVyN3y85DmNRpGU/OT5lP38hjiFtz0Rzi4x
	lU3metmqTGquJGLIpQ+/9OjYiYhvIfcRZJ2EykgEW1EO61JWVxIShUpnK4aI/l0hp7fkzznDiqK
	gEXU71pB3rVvuDmD/XVhPgzPo9Tfo74GbyU2Fuzx5bAP9O2yBID2S
X-Received: by 2002:a05:6102:6d2:b0:4e5:9323:d2b9 with SMTP id ada2fe7eead31-4fa14ff205amr839587137.2.1753270264133;
        Wed, 23 Jul 2025 04:31:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElI+nLaRgSNGVDgEVXqwotYLUYVXhaufngd/MK3e1G8/fbHHtEjIQSDAJaJfnpO2XvBgiojA==
X-Received: by 2002:a05:6102:6d2:b0:4e5:9323:d2b9 with SMTP id ada2fe7eead31-4fa14ff205amr839574137.2.1753270263645;
        Wed, 23 Jul 2025 04:31:03 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a31d92160sm2268566e87.162.2025.07.23.04.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 04:31:02 -0700 (PDT)
Date: Wed, 23 Jul 2025 14:31:01 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: dmitry.baryshkov@linaro.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
Subject: Re: [PATCH -resend] drm/msm: use dev_fwnode()
Message-ID: <6newddw6tnus7yhzd4d2sin7czbr5x77qdhlxwpjuulnq27jxq@vfntrc6tffit>
References: <20250723055512.1800438-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723055512.1800438-1-jirislaby@kernel.org>
X-Proofpoint-GUID: PVS2B-38zmUYDFJXPQgf0r8ha-mXDnys
X-Authority-Analysis: v=2.4 cv=SYL3duRu c=1 sm=1 tr=0 ts=6880c7f9 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=COk6AnOGAAAA:8
 a=tVI0ZWmoAAAA:8 a=e5mUnYsNAAAA:8 a=EUspDBNiAAAA:8 a=-sS6WOwEsJUFamFQ3l4A:9
 a=CjuIK1q_8ugA:10 a=crWF4MFLhNY0qMRaF8an:22 a=TjNXssC_j7lpFel5tvFf:22
 a=-BPWgnxRz2uhmvdm1NTO:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDA5NyBTYWx0ZWRfX0G0yZQZU1Y2i
 v7uiYkXHNbJsA2FiABLlBa5cUVP8YAL8qo6DaGZRC+H7iDayqKV2zbm7HLfKQKatypbUB5/ht0q
 sCtxoIy9rIRWKjtXqSMyiNIo3dco3/8OEbofd/WJyVUoMO3Ki2DmAXvC9rtXMp0H2tGxnoo+/gd
 7xr1GSLERE/bijKrAUZA+3Hn/Zv03VAusqMmlR5Ky0oLmRkfUdPgV4TsEAhnS3smYjxeJLeoNrb
 /PqNgcBjJaYw9QnjHfps6GuI2Yp8eutVY2/3dGmMwctWDeurNwu04yBEL2qDs3uDVfmBlWyC3IO
 2/Rl30nARxOSM+b/mJpTrCNxvnBPViIgxaIzyanVTz2MdqMpYy6r53S46RXajbblc6+44bJPr8D
 E8SLOBlqJFFoH/JWBui9kVrFIHw/TNZBxWLvvVF2IL9pBbxyEeiUj7YcuJ178CQarixax+1p
X-Proofpoint-ORIG-GUID: PVS2B-38zmUYDFJXPQgf0r8ha-mXDnys
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_02,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 mlxscore=0 bulkscore=0 mlxlogscore=762
 lowpriorityscore=0 phishscore=0 malwarescore=0 spamscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507230097

On Wed, Jul 23, 2025 at 07:55:12AM +0200, Jiri Slaby (SUSE) wrote:
> irq_domain_create_simple() takes fwnode as the first argument. It can be
> extracted from the struct device using dev_fwnode() helper instead of
> using of_node with of_fwnode_handle().
> 
> So use the dev_fwnode() helper.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Rob Clark <robdclark@gmail.com>
> Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Cc: Dmitry Baryshkov <lumag@kernel.org>
> Cc: Sean Paul <sean@poorly.run>
> Cc: Marijn Suijten <marijn.suijten@somainline.org>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> 
> ---
> 
> Cc: linux-arm-msm@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: freedreno@lists.freedesktop.org
> ---
>  drivers/gpu/drm/msm/msm_mdss.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

