Return-Path: <linux-kernel+bounces-818635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C25C4B59466
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79F971886629
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16562C325D;
	Tue, 16 Sep 2025 10:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BtPW4Utz"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EA92C1786
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758019935; cv=none; b=BCUVqWZGM3w5Kq2TeyKFXsRZ9/RSgTRRWrUvIXd6ISdmgS6LiZOIARr3SqmElMM7xzatC/WxZiul0gu0clIAnYSRGFkaG5HzIQ9JYg81zuaub1sPoRQ4U84uuA0gFpDl3kkD4fetbzt2z+m2G6yZeG8aCpDig9MArgcJbHmrYjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758019935; c=relaxed/simple;
	bh=P+p27NHymp1KBEjbTshHYMpc5jbswDRJWbALHh/yaiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=azJDI2RtaUYz+epoott0okmokLxwNi/nlR6NnIY+d3qFqZKGzNPWwhJBe0buobFMSTzlvbqYTR7JLJRNc91IjAOO16CjkLHaePad/oujndv1YbAheMV0nDCgj94l6pHpvTEJnusdj4WHnS/vpm9eBL5nxHwjyqx+pG5P2qWPFOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BtPW4Utz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GAAXr8020364
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:52:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=GY9jH7r/As2cLmZvQ6njVbL7
	qlDykJ/HIAWkW0p0ibA=; b=BtPW4Utz4Eg6I1MUc2wwGD98DRZa+ISdpEoqL4Ky
	ngX+z7l97ic+4IkQnBeUGZt4hV2/cU8qG7ePHYkjL5eqsRA/f4bp9Kqz/zGpP586
	nvQ7vktJv3W8pCe719WtQrym0TS+YkvyeC3FvzWSSQc6lOJTZDXM+e0NgvzLTj1r
	7CDf+224YSrKUa2huYRrHOHa+fRVJx51SZudT8fPQB1YE8soIJznPd12VhA7Yquw
	ZLn002Bj2EPGzQSAZIrZzlFtZAPj/lXmbKtpKNxmy/mo2wIRY9TqIegLK8Zz8XNd
	DigzkxJxFQyO+UeV52yM/EtxLN3TQFpJR9sFZMGipNBu7w==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4951chggth-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:52:13 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b793b04fe0so60598571cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 03:52:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758019932; x=1758624732;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GY9jH7r/As2cLmZvQ6njVbL7qlDykJ/HIAWkW0p0ibA=;
        b=Dy8D60MVTZ6CiyxC84lEwAoBCxLSHA9dl5waLq/YC/foNxxyCoS/+TFYTYOEvOqUKW
         T2PJreSQsSlmTlx/9z8jTQvEBzZyDI/GEzZhoz3QE4/utu5a0Ra4zNtK+TRtnNIHwaCg
         i7J/ZB8aIb4d7OdNq22huL8mv345UNPXtCQZQck/WrxqTWdgVSzTJDYig2mrkspIU/GQ
         9f1x71yJkzft0Cexv7lAesT55KiwKchdSRqtvrOPELL58y4l+dcLI+h1wOUc487lkEbJ
         9UxOvoezO2oWZVyjfouk1vrcQiZUyGLkBHGsvJtJMfSAO+VAx7TAHwgTBTwwkva0fSMq
         liIg==
X-Forwarded-Encrypted: i=1; AJvYcCXwtnAk5ZxuV7Kb7nVgI5+W+IYxf6gX32bTQPhQCkjrGDBETnxcmQyJhGci5aflDcXVOob2Hto2uiEw1PA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaRqTlw8GQL2TyMknUA21FPW1luegl+ZPNEjHaFj+kLea5ZdCX
	dSJf9+r2C2KGZzJoI5xGirdVm2UeqIMbHQcHpqpgv5gwNgYMJ16wz1SfSxo8u3Otz863LepsMxM
	Hy6W9N8WlgReyg2pKMmA8MkdtUb7XFUD/QgmkIDdJqWhewcZ1Tv60X+2zwZTTcjvA7ZQ=
X-Gm-Gg: ASbGncta7dcqLXpqcLk0GkjV2d2YKejSa+1+96x0MWYm3sNdkToSJvi+veH07lG3i3Q
	wRa1ENHYK2j+6jjV+ToaNB/Jo3+LSpYg7Db1lvnWEqK3L+uRVCUzPzR2sqhdyvZIbVHmCzj0E7O
	QGjcCA1nb40WFKwcpNIDSGj7c5NZM8z64Cd1rLxge0obwMqXWnJNeT/nO3FKQgVywilCx8xAMVk
	aUGtt7O/ZI8mk+6oQ4lBXy7srIPJ4z1Irvlan4B+FMSqsFDOnvUzb2qe5CN9uPa1tSudJvWzYmr
	7KLUU+K2yPWBzAgwhlXrsYUjh2Nj7F7Le7MJRkhlQG582EZOKI2KuaqX8vj+R94gEffOrK/fn3w
	SioDuG0aldufdy6XpkUutPk+jQ4FfFVddcc6NboVmLRt3ehHBvjYZ
X-Received: by 2002:a05:622a:11c5:b0:4b3:475a:e2fc with SMTP id d75a77b69052e-4b77cf99570mr171341111cf.3.1758019932144;
        Tue, 16 Sep 2025 03:52:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcRGZW2omipw0aiqSBcsit6n4Bg8Aldr7pugdOyDJSjJiRUzpzUc9pe7zJTRaV+Kwy7jPtxQ==
X-Received: by 2002:a05:622a:11c5:b0:4b3:475a:e2fc with SMTP id d75a77b69052e-4b77cf99570mr171340831cf.3.1758019931587;
        Tue, 16 Sep 2025 03:52:11 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e5c3b5fbdsm4247142e87.30.2025.09.16.03.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 03:52:10 -0700 (PDT)
Date: Tue, 16 Sep 2025 13:52:09 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: david@ixit.cz
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Casey Connolly <casey.connolly@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panel: samsung-sofef00: clean up panel description
 after s6e3fc2x01 removal
Message-ID: <m67lqbnli2zsdwj5x2vr52s5irjqleuxv3leqey7xkj6ekpdot@loawiqett4py>
References: <20250916-sofef00-cleanup-v1-1-b29e1664e898@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916-sofef00-cleanup-v1-1-b29e1664e898@ixit.cz>
X-Authority-Analysis: v=2.4 cv=eeo9f6EH c=1 sm=1 tr=0 ts=68c9415d cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=JNL_I6QQloY96jlYc_YA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: Qc6907ZKYzWhOccdxykwn4Eagb17jM6H
X-Proofpoint-GUID: Qc6907ZKYzWhOccdxykwn4Eagb17jM6H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAzNiBTYWx0ZWRfX6JMMrAV1e8eL
 SpDzytEWJqLn/AuRry4jJ2/3TdgxJReEE8WJBgUOJ1tnO12PpOcnRaXlopzAvK2TdvAr0FCfy6g
 42NtBECprkcKi9sWvCvkyamky2THiCWscFiw8G8QNHRexbd/hSjCMA2UFDFrhoE4OmgYtMhyToG
 xVJB5drYxcTmYe/cLVqFURqgouQU27Le4xB2YyS5bsZ3Jam/eJN6HEQEyK456nH8JwxbCd65dgd
 KpAysBN3CuInbNM84TYfZtCyYL97HUTFQcCaVwIr4/3slvts97T/M6cSa860dtOSNiQRZfdn5f1
 ZTqmeqZHo20GWOAC0eeJ68h3bBfNkGjzWUttH/pbrmNdX6TY9ywibGpbZsaVjItSZSbRArVRc5x
 L5qtsDOV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 impostorscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130036

On Tue, Sep 16, 2025 at 02:33:36AM +0200, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> Remove leftover from s6e3fc2x01 support drop.
> 
> Fixes: e1eb7293ab41 ("drm/panel: samsung-sofef00: Drop s6e3fc2x01 support")
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  drivers/gpu/drm/panel/Kconfig                 | 6 +++---
>  drivers/gpu/drm/panel/panel-samsung-sofef00.c | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

