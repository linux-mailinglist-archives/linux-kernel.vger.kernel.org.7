Return-Path: <linux-kernel+bounces-834722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DE6BA55D2
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 00:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B71F43BF6F7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 22:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607E829B229;
	Fri, 26 Sep 2025 22:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g9kdadyk"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CBF1B3925
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 22:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758926746; cv=none; b=YgJnkxVJM62IG2Jd0yO6EDrdR0ZVY8ZKD+u7WIH22c+3+UpJXmxy1s1xS8EuKrdceH2JlntDF8Gr9ObamwnRazGc+rjEPlqqftlDfBIqaI1JP1dbWLW1A7QyVfVq1mbhDlwWbB8Hk+Mv+7+NsTo3AudaEXO6t/FXzyw86yYIMNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758926746; c=relaxed/simple;
	bh=p5XvchawsOENanpzit5coWI2GxGks3nacGZ9hQTUsvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pMarqQW2rOkvaYulqqCrGbtCw+FI4N7fqwxKM2vdFgzQxGtE9W9TpnN7Th80L3DmBKryMf86TWjwym01uxiHO+0micEzFf/8R4tjg7sSprPYbaiIyBvSZ4ETvLZmc+YLJuAKU6TUEWzuFV+MibgN5bHs47wnb7Vm02rIyhbp5iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g9kdadyk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58QEX49N006917
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 22:45:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=sW/+vR8VmYRg0AyYThaCLKBv
	e8fCpAHlijREnAutP8U=; b=g9kdadyk3brJcAfoaIMpWd0XsAWx20JKzU8mdbfw
	1TVSnIQHptLVeLOJAZIdfhx4L4HuS3Na/OohxN8h5fDxbbXzUROWRkbhTZ224qiQ
	pfzKoaJTnw9KDV4qhWMEPB0CFrNRcmW8vr9zWbHf6H3IQE3HhG91aanoZW/MeGjP
	1nVWZx7NT7FvyCDQIXIa+k2SP/q/joUryI8GxKxAbnlxeCPZ1/NdioCDynYHHUoQ
	cZJjO/YbcxMrpZ5oJV2BKzUtHwu93THFj4GsnBKvoqrx32CdteNKnLZbiuySihMt
	Tpz9Ad5Da2k59I6kiXE+WbkV3yS6zarY9Fe9gjLoqCU1GA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db0qvau8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 22:45:44 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4d9ec6e592bso53144511cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 15:45:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758926743; x=1759531543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sW/+vR8VmYRg0AyYThaCLKBve8fCpAHlijREnAutP8U=;
        b=MPrnuytECOU4cFs8sUudY2WgAp5f71jsea7mILgYK778rbNkRS9DIgPQs0jpZokJ/D
         Jmt4cJqNUf4D3s1azeRnJz0bnRvt660/GNzf6b4rKhoaz0FOkkxyJoapJAzHZIpix5Yz
         +Q0xSdlu2rtfbd/Rf/xp+dzqwnH8pGq3B/FVFZ2yqnT+SiYLK37DT6vbmYUBQHK46KtS
         +Rf/t5SRp9GZ2sSsixRr3ggIGO2MrVIpdZU7nvcbXaSA3ZzUfNvLsY5Yg1YzWHAayp/m
         ShAvuoKszVo0QXxjj0XBU+N1zuh/crbvHrcywjNYbL7SpSq+RHQndHaJsmeKeUo+UD18
         r6Jg==
X-Forwarded-Encrypted: i=1; AJvYcCU9bD+qpoqkEckxB+4oqQE3yt/xalJLJnOsSOlos0mbcGK7tbJKizO1avnY+QQAByoJ9AcbtLZbEhaklSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKbf7RNb583RSlS7sXtof8N1BvPOB0wpY+K3P3oR7ivQ4v5L4u
	HwnlPotKsqHeJq3QvEaqSbYkXYJFVI2EL4MSjXoNcLUZE8IBBFkq99CK4r3L1RryEGZxvRtYqoG
	XMhzemCVmbsV3+00EB1OJa+uFWXEEMDT56l8zcP1dcwI74RewMbdpMNX58Wnk/s4WD4w=
X-Gm-Gg: ASbGnct8pVefV3tTn1QbgsDnr9Pp9xnQx8PxNAR5ry3zxUH51bzaMo6j++npouOg3eD
	b5LyKnjG95pE+h1YhsL7gbfXUNNZ/5mpu3T/AYJajZPOHCWbrfmg4Gj0UXKNR8W5csrLFpbsr2z
	mM03ZR0b1m6ylmRwLVdF8ZlcjHQZBZbujYdTTsB0wZaMuCKzfz132vTF9E/3SrtEEZz0gAiA0xH
	Btb4xKugaRMpCD2qQONE2uwsmdwOY+sxzJg6O+jIyyGm6zOQFSB/gKUKvGAwYQRZ8Ztg9FHJq2B
	jq+5aIrQ+OIoTyLShpL5gI3vO6n4u83+cuVWcMG5vOGSqwo9SIAuWNZcYh//DZyvBWI5KZerehR
	8rbhFtfGOoJQyC2LRW5l284GCHd62w6PoqikP+bdJU8tLwlogi2rZ
X-Received: by 2002:ac8:7dcd:0:b0:4b6:39a2:1de1 with SMTP id d75a77b69052e-4da4b42c2d5mr130498971cf.52.1758926743130;
        Fri, 26 Sep 2025 15:45:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRfXtG/PeJOoa7YFdPRlCu9ZjyORleotSKki25Y6iLSpr2s7WbBrqGeVtAyk0UN9k7S1S1Zg==
X-Received: by 2002:ac8:7dcd:0:b0:4b6:39a2:1de1 with SMTP id d75a77b69052e-4da4b42c2d5mr130498621cf.52.1758926742648;
        Fri, 26 Sep 2025 15:45:42 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5847fd56eaasm945718e87.137.2025.09.26.15.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 15:45:40 -0700 (PDT)
Date: Sat, 27 Sep 2025 01:45:38 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
        airlied@gmail.com, simona@ffwll.ch, andrzej.hajda@intel.com,
        treding@nvidia.com, kyungmin.park@samsung.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] drm: mipi-dsi: Fix an API misuse in
 mipi_dsi_device_register_full()
Message-ID: <m6fvifsbb2yjbx6txqc7luii5mwukrpiw2n6bcnrmgidm5cxjv@ksmcnqg6sv23>
References: <20250926091758.10069-1-haoxiang_li2024@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926091758.10069-1-haoxiang_li2024@163.com>
X-Proofpoint-GUID: ESva3d9mvGwC2JCPgjFVNieUZyCAMGDu
X-Proofpoint-ORIG-GUID: ESva3d9mvGwC2JCPgjFVNieUZyCAMGDu
X-Authority-Analysis: v=2.4 cv=api/yCZV c=1 sm=1 tr=0 ts=68d71798 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=Byx-y9mGAAAA:8 a=EUspDBNiAAAA:8
 a=tUFaMFilNNX-uVKmuBsA:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfXzh+f0LnibDct
 0jt3jrDbZ8RvmQQPJTsLl3g05VW9KPiS8AenbwgRUgL/T5C86d4QuqLjqNLJ/IGX6yevZpJjZ97
 d3yuvzPVlTyZCuObYVMzoJS+Nuqpt0LcjsajLp5ucANlvuuVVC0MMj781jvJs2ZY1JVBVb4JDUV
 j34catx1AK2kBIX54WAV3xansFN/6tRMkCMwR5E7tAv84aph1/SXaWCuGQkYBQCnOjVVNCAy62l
 BQ3hvQK8N7lTA15q6GiDtq6CMN8ydyBot7UNdDzuqrVm9zJbiX46p370QtX23l5tveJAsgbKxlU
 0mF4fTvxhfVzr4rWFqRnJRXIzJ6bTcb+dRH+Ij547R6LPKVaK02I566dybJpZBtKDSUUzHwuvVQ
 FPgJ2WidqY6Y4lAqGToQeoRUpwhEpA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_08,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250171

On Fri, Sep 26, 2025 at 05:17:58PM +0800, Haoxiang Li wrote:
> mipi_dsi_device_alloc() calls device_initialize() to initialize value
> "&dsi->dev". Thus "dsi" should be freed using put_device() in error
> handling path.
> 
> Fixes: 068a00233969 ("drm: Add MIPI DSI bus support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> ---
>  drivers/gpu/drm/drm_mipi_dsi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

