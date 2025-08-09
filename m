Return-Path: <linux-kernel+bounces-760911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42374B1F1EA
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 04:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F0375644F6
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 02:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC80274B4D;
	Sat,  9 Aug 2025 02:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IQtr0TCA"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2A3197A8E
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 02:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754705698; cv=none; b=ih9TxFDBsx8iioCL4E39n8e2KdW8JYnTgdUb+4u25NtWMxnKY+1KmpYNOqgo1zgmIn1//7D9WomJ3f537EXNcqd2hnJccl/PiOHsLk3OEuwYSskvxxRZ/lIuBYdG2PjV3QH8jc8czkww/iSD2J8hvoVr7KaigET+GndtE3X5kBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754705698; c=relaxed/simple;
	bh=XEHcXFeB1JLeJqc5dVktvb+4u89AId7IC1+S2hcUAzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kNfsFwM8oAlsiU6FcGGGDIKYrnnEa6tCoWLN8sw4IOJLpdhNUcgz62BZChZMGur2T+7UWDAgBArkPDtDVWpwfH7PM9RdjrqRAOyLRl+u040Afsu4k/FiYhkrpBnlzvY9EzvuBnJzyRgCAEzDrGPhxhFhqPRY96BXUHgZrfVRVKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IQtr0TCA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 578EjP59007642
	for <linux-kernel@vger.kernel.org>; Sat, 9 Aug 2025 02:14:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=d8V82vBwUz1mJ+IWuJuo2vsL
	/UFk1BqGFbx/Lzd+kf8=; b=IQtr0TCA51V0mY2vJcxwuMa31dpLyn09YQndPGAQ
	A3OZw2KyvMcC3QdCOOdDXibEQxO/wXrJJj8VRgTI5TWUWVdYXemWlaTHCzX2mKg6
	/ZjWguNe9BwlAE1Px+zzEFmMqGkR1XNgIW21jEzqW9djN8Ql3kSYOcwutgptrdj7
	H70st6UGLQtW6HLcv/59csvO5g6Oc04FoSNDjT8QYi9JCqerP7a6Mf8h29z3CyLD
	VxR0BihDXoNfq97n6fbtlupB6eiqIXajqC9wctCo7rjXN9v5k5B75Avnb9/NMAlT
	g09B6ofPria46uQ0aR+OScIKET3vdp2HhF1NRy3Qg8OXQg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48c8u28q3q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 02:14:56 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4aedd0b5af9so55554001cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 19:14:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754705695; x=1755310495;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d8V82vBwUz1mJ+IWuJuo2vsL/UFk1BqGFbx/Lzd+kf8=;
        b=RY2AXueMiaaZk6+G6CbqSbn6+gMifCyR2YhnzXrHSGmioB6g5gDVZ/Qe8Yal5uS69d
         ADoSYHoE+MuESAQKBpaHJFHAdRFVLjj2j/7KFU3FQdkgN93X5dtJFaS4NIpMEd16HI0G
         bp3ZApoAq17faoOykEPgCIMYAoh2eOy906/iyeLQpeKeFn8+NkcNtMSTU8Z5fI+EnV1u
         Mq04DFXbSRGIn3CCWRCndj0+p/4G81cVIiKW+ZvuG8g1o7j3OopCdhMj8iYY2ZPEyHTE
         pYYrmS2A0skjeN6CQj0xjBlfiifx0t2c+yB6wIl+BWdYkzDmiFywHTA66oaSvmX77aXc
         +upg==
X-Forwarded-Encrypted: i=1; AJvYcCUkJRHfMTXnxxHQINAhZqtMPoLYdQulcULBz02Nk7z8d6p9ETBOJA49FpRu8xiXglLphkzKCxxxoSfl0YY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJTO85+T+x6cnW8l4IlFtJFkgGBGTP+rpA0AcxdnSMmPH29BF1
	p6PWYPx+pav0wbx1zPcOePw+F3/GZhdqZy7qzmntdIrs5HBsIglQ/ax3FCwoDumZJdYUlasWUdL
	stCV5xw85lcGmQPzWmKZAh3V7ITqixm11jpwFhQRAL5L2IuoGVBR6N9F2/Hy2Q6CJZVI=
X-Gm-Gg: ASbGncvXPdW8M9PVrPMBn24s9PEiES2tgbZhbx9qO7PfhDG9T9otVDeNJSN5GrsZmPv
	SNIwXaVCHK5MgT5tnHFPLE/V7xmMwQXeWDsXXUosWoTw/JkcZJk2AblTwxd/36xm5UtzP06iw4w
	n9DGoYGiY1Lyq+qJwK+5znILfCVGf7c9ZGqq9V0ypAV9HxKTp19OTrHn+dBRWG1LpIGY8RMSY/S
	7pPIOX9SCOL8gxJfIE1SZm9UvVJgAOjQiOhIcunwx5IKn4M70sht8lpMmNIZE5ApVOtYaOPy4+F
	5V6gh+UcTrdZnN2RFyumTyiay+cF47IM3jfHsHvC+m+v3Isq/rmCgsbpRIrJbjQUFobYE04xcN9
	7Z8Urw8/lmSe/M5ws7819AhSjRzKFUMTYCufoHzrcONww/uplK9VU
X-Received: by 2002:ac8:5749:0:b0:4af:1f61:7d39 with SMTP id d75a77b69052e-4b0aed21313mr106146031cf.29.1754705694675;
        Fri, 08 Aug 2025 19:14:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5aRbQ/NlwN7L7iMrcnkgPVM/w6fIHpvroCwE+0c/uE92MdaewoP1y/ibErVYY6x3kEp26cA==
X-Received: by 2002:ac8:5749:0:b0:4af:1f61:7d39 with SMTP id d75a77b69052e-4b0aed21313mr106145681cf.29.1754705694224;
        Fri, 08 Aug 2025 19:14:54 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b8899f897sm3194466e87.49.2025.08.08.19.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 19:14:52 -0700 (PDT)
Date: Sat, 9 Aug 2025 05:14:48 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Yongxing Mou <quic_yongmou@quicinc.com>
Subject: Re: [PATCH v2 05/12] drm/msm/dp: Drop EV_USER_NOTIFICATION
Message-ID: <ykbudesvb2ya2gbtgbyrcn5niesul2bnpfsrl2hourpw56zwdn@y7kmcd2ejwxz>
References: <20250808-hpd-refactor-v2-0-7f4e1e741aa3@oss.qualcomm.com>
 <20250808-hpd-refactor-v2-5-7f4e1e741aa3@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808-hpd-refactor-v2-5-7f4e1e741aa3@oss.qualcomm.com>
X-Proofpoint-GUID: Nd-c7j9Td9soU2tqeeB75mL-xVpB3rp4
X-Authority-Analysis: v=2.4 cv=Q/TS452a c=1 sm=1 tr=0 ts=6896af20 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=93MD9rSA5G_0oRVq-qYA:9 a=CjuIK1q_8ugA:10
 a=zZCYzV9kfG8A:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: Nd-c7j9Td9soU2tqeeB75mL-xVpB3rp4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDA5MCBTYWx0ZWRfXxNx/04li5n9J
 RbRR0+rOERP0jqig77HugSqxalZPtsEtAyaDxs3iBs0NHBDW1IiYDPPLqh/GxwNAfCXNePMBRlc
 ihQdgxQGcyFNLN+SXGRuNOpPNrIJw+9kljBnHpK7pt3o2ToFkvQu/JOPVqAN+DQZydT+u+f4kxV
 ZxlifYlO/OkpmTYVPQo0fqWJsR75/J85q/XE90Bys1eoWG3WtPbsVlFhuygwGfVM4D6evrdNdIN
 c/I3JAv65wuJe5LN8qW+WC6w6fbdaOBDK4yURsL07BP9mAjg31hZrdzHVsYb8eqFCGESR9iKz8Z
 ergs+eF3119mCoPlepao4Uj4cfymNypXHi4VoYyu+QGhzJMcy+Kh33dkIZV9wwkz5pz9qiEKto8
 gIMVUojQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-09_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508060090

On Fri, Aug 08, 2025 at 05:35:17PM -0700, Jessica Zhang wrote:
> Currently, we queue an event for signalling HPD connect/disconnect. This
> can mean a delay in plug/unplug handling and notifying DRM core when a
> hotplug happens.
> 
> Drop EV_USER_NOTIFICATION and signal the IRQ event as part of hotplug
> handling.
> 
> Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 

This removes serialisation around
msm_dp_display_send_hpd_notification(). This means that it can be called
this function can be called in parallel, so we need to add locking
around .link_ready access.

-- 
With best wishes
Dmitry

