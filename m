Return-Path: <linux-kernel+bounces-785646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C9FB34EF9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 00:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C63C04E021C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 22:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C172746A;
	Mon, 25 Aug 2025 22:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M0VnrkVE"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6664A33
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 22:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756160609; cv=none; b=rkpHFPW0PFcc07/jlwvWzJXvAMu3Jv+YB8TqmhbNXIAxLsyRUly8oQzOjWVWD+ofl2rSQEE/MnsE+yXTE8ChECB/Hac9GB9KQgpNddnn0jizUgfKsQy/m+h8ZXhB4zO3x+/EjskmWmspxVeHU3M+60aeqddHuTBybUAfmRrwq70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756160609; c=relaxed/simple;
	bh=pSyVZXZs5RMXZqg0UugXOTG0Wtr/PfJ6jbgDsvrBpQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n/eknnr+dSNGRodi8XVF1GnNcP7Asv6J61WYG6osUN6LoTg1r+JFfb5P6b6m7PqhRO/mNLZSJyYlLa78n7gr8+shLxsBoIp85pVorRC1BaU+JmWjHjn9Pz9HqyK2U6YmdSe6mkTLDzUEkpj3Vgj764uN3ifjqD9wR20VIbZpsW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M0VnrkVE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57PGBZAA025970
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 22:23:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=fjH+xA5Hhh74IqC0r3nz4iYW
	+qHZrS73elo/5Si+ukM=; b=M0VnrkVEwZb5l/PpJpVjvAG369Z6ozbEsYfLWRWK
	6B6QwwR/BG8/zXlbCj+DMb82ZTPNhdHgJRHn4G2Yic3ns5VUKZzcapGJgongaPCZ
	9EmgKmIma0wZtXMtyfGV0joRsi6cUvE47VUpCWYlVPoMmzP5/lBpauK+qa3OGows
	QGmOZomk5chmEDbCpuOl+Nvi6zLEcoR/E4tjEdBQsSqNssPmKEf5vucfeiQSV8oO
	avkXP8h5eZ6PmLMnEw4IFv7SL0ZHtrS5kLlNj9Xcw1f325BWHid2nWGCxIMHYZgH
	yHoO+TZ/UDFjRCjY8PIKr9vpO8tNPp/uheDRSqBfja8SUg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5unpj1e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 22:23:27 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b109bd3fa0so49511591cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 15:23:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756160606; x=1756765406;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fjH+xA5Hhh74IqC0r3nz4iYW+qHZrS73elo/5Si+ukM=;
        b=JNv7YBg+XW+FEL7zZpUP0mXZMrLniytCTs1BI6YWTP/xqooxf8rIkqFqmb5cr8A0lI
         NDqaNt5GiSi7v9jzWdylzRpkM54Wmw3GRZinC2yRQby5vuVy6InmsgYmEvDHV/lCNIe+
         i6GufPu7rrGnrFg+yO+wYH5XCQ8Jpc/uPpWx/qI58yF8RZnilU885pKrXALd9U69cD54
         mw1Z1ieLotMqklkXYvCgjnbmwV+QaLm1Q2Py7jVrXrmUHn0ewKb3yohu7o5EdbnZC28a
         q4MO4vGdWeqXE5yLzm6a/MJCEkIMm5XChSUClIj98/ie014/BVnO0eCGHpuJUKXk2Zj2
         UTsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNK+CmojBj2uJI/C8aNxNqjWzO1Mbcqt5POTvk4/3Ne+1lmNrLQOX9YrKwUQCh16dUvZIl4nYhG5rUA1s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5KnmRg9IWTmb6WUfdeMvJjdlhOHfVn2kCK6yCHPkGaDnHho6A
	GDXtivAuMzO72lawHxwNZgyQKeVuWvWhyg+SVhvEexHZ+1Ma734NPXSynQxaupswscx5UpjsOW+
	xnIOJQA8R1U5LhGLZGdNofdGFy9cOxNiKEX/HI6lhO+dvZB9Bj4NnTskWdYRclrmy1Yw=
X-Gm-Gg: ASbGncvkKFJ4Z8LUobBtLfqvM2gIlJOzaxg9gTRel1SgbN3L2F5EEEdMAxK6TqTeNp2
	ef5jHPv2hsJgGbIgbT8UmVC5Zy9p7UZtwNK7a+kVi5RfLKH5GTymZHd6ONyy0tSzGwY+E35LM14
	5Ly5jPOnekfw3dHTNnvVIXE5RogqmzXJ20yW5+HWmltwWdYaUIC6JMVMr9vcC49iwnZ21HX1K+6
	Px0SOzSdNOmal+aKOCbep+nu3dK2EwKBnnE3LGAW/d4Wyr40KNbrnw0gBOOKzxZmCEaPAjoeB4m
	dr/31bv3U0eR9keYq/bvvumedTgYUlPbbhpqIsL7vkQhVZpGIe5IFHss1/l3c93c2BP8fySuU/R
	e3CN9QBXW1Yz5rruZ2xR1+cI3hL82D693XGteYjzaixcGFvDAseIB
X-Received: by 2002:a05:622a:2443:b0:4b2:8ac4:ef8e with SMTP id d75a77b69052e-4b2aab65f01mr179201391cf.73.1756160606407;
        Mon, 25 Aug 2025 15:23:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/gWs5Q3U2MNb4IhmQlYIuCMvPeaLXJdn7Nhfi+5p06NJqrdTdO3fCjgpZVxrr1qDOV5nUzw==
X-Received: by 2002:a05:622a:2443:b0:4b2:8ac4:ef8e with SMTP id d75a77b69052e-4b2aab65f01mr179200941cf.73.1756160605874;
        Mon, 25 Aug 2025 15:23:25 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f35c8ba2dsm1836524e87.77.2025.08.25.15.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 15:23:23 -0700 (PDT)
Date: Tue, 26 Aug 2025 01:23:21 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: Re: [PATCH v3 25/38] drm/msm/dp: Mark the SST bridge disconnected
 when mst is active
Message-ID: <bgo6yni27nqe4gkhvurrnzvgih4hn47itpwg7afgtctspin52n@mtf7e2jzcukb>
References: <20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com>
 <20250825-msm-dp-mst-v3-25-01faacfcdedd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825-msm-dp-mst-v3-25-01faacfcdedd@oss.qualcomm.com>
X-Proofpoint-GUID: JXgxgTQM85D7nKMCcD7NUV2MUvXsMSAk
X-Proofpoint-ORIG-GUID: JXgxgTQM85D7nKMCcD7NUV2MUvXsMSAk
X-Authority-Analysis: v=2.4 cv=JJo7s9Kb c=1 sm=1 tr=0 ts=68ace25f cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=Cr4VjbKX6U7v81t0Q-gA:9
 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMSBTYWx0ZWRfX/hKk40UwQRzx
 DraA9peUxVLBA4dJgD6XEw1kz/FMMePgBpJ9rw05uPQVogkBMKrTvey949X46kkxDlfSPTUDqN5
 G2nvvfR3qs6mBzaG7T7fS9tZVgzi5HxilIq/ag7qAOGSufU1xtvBuxCNIrbJoO3qiC+OV6Gw928
 4X6s2TG6LFTgQtFLamL3yBJSIXxEs49bpnstbbJUbWcpcf3VlPeIC09XDBK/CE65rCowcyu3De6
 6FARCWRKMvJZIPT6gPXBB2vQk7Hj2AckLe7AdoDgaTb/sWc7uPNAGTtyv1RsrE9ZswMhUKvTeVO
 Uospq4XvACYGavXjY76Xje+ckMMtPQBX5v7TIG8OcbUrQPz7h1Hxu1f7NKcKsritwEbGw8SzTtD
 9e0uJFhD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_10,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230031

On Mon, Aug 25, 2025 at 10:16:11PM +0800, Yongxing Mou wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> The bridge detect function is only applicable for SST. In MST mode,
> connector detection is handled by MST bridges. This patch skips
> detection for the SST bridge when MST is active.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

