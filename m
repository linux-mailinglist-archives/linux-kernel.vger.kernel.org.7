Return-Path: <linux-kernel+bounces-874755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 898EEC17063
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 22:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2EACE4F7D4A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D30E3590BF;
	Tue, 28 Oct 2025 21:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OstP8fKM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MPQK72h3"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500ED351FDE
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 21:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761686797; cv=none; b=U9X5JsxEs0JifrBtaJZSOXGAXppwwQySo7jtKsaQPnDzDWX6wVRGMjsSuLzhVzXym4MwUxNQcve8WI4xub7xAfIn7P2Nm3Xqp7goUi8vVfdhM1qu/GvfNbZvhSAZ4L3IcsRxpjzhrnxsAndS90MDNf7zGETE+kAg5GzV9DhOxYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761686797; c=relaxed/simple;
	bh=PX0MeDsoigCBZQCBcVCwvWH4qF8r8NfW03sJjjwPMSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iIVxJKOaYZv3a9TelyPF1hrcp+H2IEZ7Bergz8kKpSU2T+tt4DGRLsN7msxMNkfnpXf0EN6TgwLj7AnU3WUcroCzHUQCUE2kMSvXhasiyiOBb1ILgTRK7p4ht+nLhjGh6UmffECRYpm19qNvACYujW4KmWJonq6VgQbVl/0lfxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OstP8fKM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MPQK72h3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59SJlPQj2554360
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 21:26:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=vb6dVEBF1GsrTqvUi/V9O4Oe
	gNy8kFowkn6bq/8s4Qw=; b=OstP8fKM1OdJjzrC0fYc/V3QRu5HUJQJ6KPqVswF
	ZtdSTSs/dDuwJIrnG+kRESf2fAKb9wWMO2b/XI3bKWanEJTdG8c5bN3w5sZJ/LOH
	E5IWqEuV2AfPsGKvo81T+58eFaL/kfwmbZ+jc2bEZTC/B/fJ9OCwIVL3d0uTsb+1
	/g64V2YyWY1MYpHnwyr6UYLUx2Qt68tqUa9yj/5SirENKyq1jmkWysLOS6HrM7df
	No5LbEWEZsax5CBhwg95Q2911BPQk8LqX6pnVKTESI2ZTaF7Bd3733gwpOnTwx6B
	eW5iHNpmIoMVftAuHVh1a8PzlMfWEGf8BvBdujcjwps4ug==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34a107yt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 21:26:35 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ecf8faf8bdso136190951cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 14:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761686794; x=1762291594; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vb6dVEBF1GsrTqvUi/V9O4OegNy8kFowkn6bq/8s4Qw=;
        b=MPQK72h37cDSSD6veEcrF/PQrAEKtXlebeAL6A14NcnYd1WLscJC0f8zjnpLhKLyBt
         I7y8k8SYawTtx3RyV1NMFJD5qpNNba9GfclFcTusPuccVp+OWxUvILWV1Rt4ZTqDJJpd
         cWT/X40jhmGxIIn+A6uzRkCqnfnPmmoG8KoK2m7QFmDg3tV1a3RTlNGWywohI1DovA89
         U6XIsrv1ECMAFdaOlx3swJtKl25p2YL6XYZA/7A63GIevzX3RBzkouWsYot78/yiCXf+
         7yFU370Ey4D1UFDa578F928E/HcPY7rvNz+EVaXS/5m024HBzFkSZktXUiCzovwRV7cB
         zDpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761686794; x=1762291594;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vb6dVEBF1GsrTqvUi/V9O4OegNy8kFowkn6bq/8s4Qw=;
        b=wWk1pD0EVCaKR/scWYUCHYmc2dNWKDj5pfDrIuY76IElVL2VlERfCLg17HPqa8dZPk
         OQfMYq4Xr1s2YNfntF79YWdpgAHiWbDIjWRmRMxtBTdQ5AM4W53XFkpG/xZcT4ySmN+1
         pb2iUnI7L4Y7+dP+hj0K8Z+63CfleS9XJigoUH7iUeKBs87jPkLQTnuxx+1fpaQJ0L2d
         c77BD0dr308cJqsCN3EbptGfvVxFksjUQNU6rfXXiViPhWJHIRH2AyCudT5b3K8BvtQ1
         G2o9q7hTZ13JUJRMG4Muzgg0qlL0PveVdjBuYJm09vPdh+yveYxLwQryY6UH44wH1WgL
         bXyw==
X-Forwarded-Encrypted: i=1; AJvYcCWiUiaBHNqVxXoVl0hhhbVRjn8gpbdj8Y4fsOt9pFv6NfErb0d2V+nDd5qY5HZe76XqF0wwwpu5TQ18QIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdeOK6GZ+zRXiyHCwBeGpxkx5jCxDKQXT5SmnDyVKPDrfDvZLI
	H+CTCFD4jf+syrstz5I4eOuLJbpFxhcvQfijL9yJC4qNVxmbe6gbyWpmLoWTb2ab1lzYrb1CIx+
	VuyIbP3ou65F4FyyKlCjU5dWo8VFAiXMI0hp3b+8rpU4XoZvYPMDUuS6vsvhSFetTlss=
X-Gm-Gg: ASbGncvkEWL4Vxy/aFsMxvbtm0xktY4fmgHts7UqbZqTQE+F5/vXGtmSDK6X4GRwCcH
	qGjeNWBnTURewrchWoAiqMNxCc00XyApp8cT7SlkScC40Uz/7W/7SloHcMgRCsg0Fc2YgtGjNEu
	4wYhQVztSZc4rpRxY/poyCfCr+4mPdIpIvOQ72xfD0D/lcVFUf1rVmaQ/+t7z8Ou8wMSH32l5jU
	SQ5YrLIPNG9wR8+eYalb4W2TYK7GYo5y8RiCNVAzO1M5tAHkBINW7xTtfj4BiONKbW7WfgQlbxm
	G1Xn9tJlwLKLNcdBUo681TKLqzYIZ58MU3SyJqSL68E9USXHeGw6QgJRPrpwO5BX2P0CXSNhbUw
	LJGvlQahJ7S41kSsp5ieOsl9FKUzjn8JlxC1t3FwbaAp7n2jYMSH3YJl6qLT0RGkjc2oy0pZhe7
	++4OyfsewVWBFW
X-Received: by 2002:a05:622a:1105:b0:4eb:7807:1816 with SMTP id d75a77b69052e-4ed15b5ab08mr9646311cf.35.1761686794447;
        Tue, 28 Oct 2025 14:26:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoc7W3OAdXR6z0ZRmTUyu9evmiDq4dbWddJKVeKeXcDDjGijRuSjVD978ICY7up4qhMEzYew==
X-Received: by 2002:a05:622a:1105:b0:4eb:7807:1816 with SMTP id d75a77b69052e-4ed15b5ab08mr9645881cf.35.1761686794002;
        Tue, 28 Oct 2025 14:26:34 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f864aasm3284263e87.109.2025.10.28.14.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 14:26:33 -0700 (PDT)
Date: Tue, 28 Oct 2025 23:26:31 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vladimir Lypak <vladimir.lypak@gmail.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Kalyan Thota <quic_kalyant@quicinc.com>,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        =?utf-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] drm/msm/dpu: Require linear modifier for writeback
 framebuffers
Message-ID: <6qev23tgzl3b2nkxgxgjkgd5tjljop37zhfm64unla46angtek@2fychx75wsqy>
References: <20251017-b4-dpu-fixes-v1-0-40ce5993eeb6@gmail.com>
 <20251017-b4-dpu-fixes-v1-5-40ce5993eeb6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017-b4-dpu-fixes-v1-5-40ce5993eeb6@gmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE4MCBTYWx0ZWRfX1niUwHQFuz/v
 NuvmjYkmh8vJpczB4k7Oedl4fzw85fcAotMZ+p1S6+iTSjU2+HID/edyTbyCxPs/sJMoTa8bGIU
 ddUqzs7Rbq5+6hRqOVRuLCGWVXpd0XawlVGNvy+9eL2J3LiUygJeaLTGkdP27ZyugRJe0j/+Yaw
 B6d7dLBpdDjhVk8/YI7i6DJ6cw7mxEpgSigf+IONABdzjLXZ6TPubezaB1aF/aLMm/lovQodBMM
 3O04CSZEb0FMaiRVKV6RhzOVeepTsFp329HO+6U1387FEcBBfeZtVlxXjIC9AZNdGj+VsI7DF47
 juX30vGXAqbjMXC8pH1F0biRhV1XAV87+4Au+jJjqykI86NpyJIezZpfFa87wUW0cBmpUE2US0o
 I+3r3bWURFzUpKMiUiFAT7e9Hd1e5g==
X-Proofpoint-ORIG-GUID: Mg5QT4P43UxQUXxLA3q8Bmqhb-xiYo9C
X-Authority-Analysis: v=2.4 cv=EKULElZC c=1 sm=1 tr=0 ts=6901350b cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=AghEqMNuFSJYpPmXAAYA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: Mg5QT4P43UxQUXxLA3q8Bmqhb-xiYo9C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 suspectscore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510280180

On Fri, Oct 17, 2025 at 07:58:39PM +0000, Vladimir Lypak wrote:
> UBWC-related register configuration for writeback is not implemented in
> the driver yet but there aren't any checks for non-linear modifiers in
> atomic_check. Thus when compressed framebuffer is attached to writeback
> connector it will be filled with linear image data. This patch forbids
> non-linear modifiers for writeback framebuffers until UBWC support for
> writeback is properly implemented.
> 
> Fixes: 71174f362d67 ("drm/msm/dpu: move writeback's atomic_check to dpu_writeback.c")
> Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

