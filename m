Return-Path: <linux-kernel+bounces-754686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0102AB19AEE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 06:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D1063B6231
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 04:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCA721ADCB;
	Mon,  4 Aug 2025 04:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bo7617qy"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3241C860B
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 04:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754283568; cv=none; b=mU9ERYCBCO7T3WDqdIGuhRMeD5nHsJpfXIUZHBSja3yOXJLF0BDScsYF3yoInIb2nR7YHeTiNoV0Wh/mnpfJwGT8pJ9G8F1jqzRxzRFgKeP5zbo9XpHybdTuX6STZTdfsfrHhy3e2a34FkLYIVZ2/JUu2P+3Cv4ED5Mwjmc2EX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754283568; c=relaxed/simple;
	bh=5OCS7EVJ035go6kQQg0qlr0yXYaMviIjU0BO7hW86uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TQelYwobMW9CmxJLJFjaGptAXJnEsZYjnfq5KDLnc+KE/PF1nM6ft6eA/Plp4ivL7T2/W7/Qzsc9UcpBn3waQE7+Ntu33STzCkACG1aLPkewyXmBHzDPxRnW884oIMXdxfZYMaD+PZLDiz+JlRZJlqr8RqYW0J43Ejd1BDNK3yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bo7617qy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5740sLWO019447
	for <linux-kernel@vger.kernel.org>; Mon, 4 Aug 2025 04:59:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=yeGhNT6CpWXNeXfNa1CkflGC
	25gJ2duSKHQEY7KN6SY=; b=bo7617qyml3M3oHt4aEetrcNFwAT1BVfLs/RKZov
	3jnztyUX6lOxcGf5IgAjuWpv9s67PZsnGbCv0JvrvaEoL32n1zVbXReY0HlVuba5
	NNHNnB9QWEIVkcwm4ek4gNaVsB38+MnJlDPVMWz1Y/uigbzBjM9ok1wo7FxAW7WP
	x2MBUoeKyKkh7E+RGPuakgL5ex6KvfIDCR+oK+LcVn+WnqtobRqi7VLZGZGcysVA
	OZpEeBPneqWs+BSy62jZV9AAb4yfkzE1oPL+9Gy2RHMaAVV65fPXA9ee7lkO2IRr
	dUuEZ6BsLI5VvQDQ6EDLcaYsfb+r2LnWKD+7nzhUi9VgNA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 489bek3f7u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 04:59:25 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4af14c04e5fso55809341cf.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Aug 2025 21:59:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754283564; x=1754888364;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yeGhNT6CpWXNeXfNa1CkflGC25gJ2duSKHQEY7KN6SY=;
        b=atbYJS+7org7d3J2EqGumkIODdcHryHCZdEMrbQNDlV7S8xRIb/z/2shVTiRjFlmhj
         652IHOIkF2d14aqXgZSXyxnWH7pj5khv1P4J9TBFfb+tABpnUcOMjUeZlu7vWzbGKNuo
         EtaEZpoMPD83+DrSc2r+LzVjbOjmI+BqXuJ0E2Km5tR20lSXhoSWa4gG5B1VZRQXCZt5
         CLdbDwSeSsew08ABrzT95SskaOssTkzMTEp4ZsXCA9jVJeN/7pj0P8UJ3rhnaXmKgogu
         EBSnf9RR3fX7mAqctSq//aXvZmbJTaeH607C7KRK4sh6OhgZEZmMytj0E52rzwEEWTvo
         DhxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgW36Nss4892iuXBnUtLOwRzoPTBs2IPOPCZF/U0KNgqtD/6Urs1ClanAuV9ayTRuBDdpqkggOHznnREE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJgAdX8I27EQN3u7AKsvbGp6NynDZ29xe4WJhB4S9rD70VIAx+
	lk+VDKBqBbH8xud8dNv0UfcOp68yZwOmY0yzCJ8xs2Uz/9ZfXs433Cw8ti2XPa3UfPXxjswvZg3
	H0SA34n9KPpcpm0hoyUuNSGvl9twrG4p4bwss6HzIoFFaqwqtrNN3sgSTw3vda9wd1kw=
X-Gm-Gg: ASbGncuTnIYMJ2gu77ePgEWB6sKSEEZqXwEefCf1/necCQ/Tm9nOD9EtY+a8Rh+dS71
	G1VT/lBH+o8jGgd9cvZD6+EaPeNm7izrcn/7euPEe4+SeD/7gdZj11Qut26LYco2yBV8VniPuXa
	hCWl1VqA1jPJNHEbf34EKR11O2QhUg9tGS8CidDTuadNj2Y49wk8IojOcDMGLvsSZWF1z0TJ6d9
	+wxY+c/YuLsGFLQLtqWkbdW4NAZD5P3IqSo5p95Lx1VfxfLLb0J2RlVi94jQ6hexyTtuh0XDbEL
	+zdGpLdfYdjh7vJa2PoO5T3xYmcm4vWBSzwsVVvatw9c6+dOj4JlkGU93yQJbj0sou/WFos7cb5
	Rno+g+egmcOEMPGnTFSw6YrciPR92utpkUwkal08ezj6RsNoY1jJ0
X-Received: by 2002:a05:622a:450:b0:4a9:cd88:2ce5 with SMTP id d75a77b69052e-4af10d09751mr121949741cf.43.1754283564354;
        Sun, 03 Aug 2025 21:59:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmwHf8jvLAtm/gyRWNMuLZ9kuudQb+4jLxAHzs9hy9eB9XwniHX4P/UvGkhGHloFivD0TmCA==
X-Received: by 2002:a05:622a:450:b0:4a9:cd88:2ce5 with SMTP id d75a77b69052e-4af10d09751mr121949571cf.43.1754283563888;
        Sun, 03 Aug 2025 21:59:23 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b8898beb4sm1514807e87.30.2025.08.03.21.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 21:59:23 -0700 (PDT)
Date: Mon, 4 Aug 2025 07:59:21 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
        airlied@gmail.com, simona@ffwll.ch, sam@ravnborg.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] drm: Fix potential null pointer dereference issues in
 drm_managed.c
Message-ID: <lkpoiqz6crzief6exijz4khb5liptodcoo75hkvc6dqzacn2i3@uz2rekanykf4>
References: <20250804022021.78571-1-haoxiang_li2024@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804022021.78571-1-haoxiang_li2024@163.com>
X-Authority-Analysis: v=2.4 cv=M7tNKzws c=1 sm=1 tr=0 ts=68903e2d cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=Byx-y9mGAAAA:8 a=EUspDBNiAAAA:8
 a=bfg20SR7mBSTREqmtXgA:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDAyMyBTYWx0ZWRfXxMhb/3mgkHsm
 evJfrFb/Q+dYVXDaqBzHljY1XorP4G0RVgZUYYDj+ndzCtiuNRAuCvb2Wj0j7SubgfiehIZK8rw
 jjAOGelvFzkApNN1QOQg64xzxTPNzFQO019l86H7VM1GOTV9a1fTQjyBg0IgOpdHEjmy9g7E+jk
 wXBd+cQ51tzh2/J6tRvehGtnnJ0N0zXGnmL+ClOjPEUb1jv04ef3YztWeNRIhwLJ+vUzVWpvcTT
 XzXseAGuA7hgB9Rn7jtDMCZAuYsAMqB3XpWC1dYrgtbAT9YIWVSwxxK1+pr/qZrS8DKktBYJmx9
 2DwAG7Tb9DdQQISuTtNAX3Hm58btwAse+S761HZ7q9XRy/7ZL6KJTfRMWQ/htXvz2tc13XIrf9n
 YZC5yAgFomQpOJGu+O+LuxR7IMdkd52zaef0J2kGHXQiDirDPljc63PM28qd3k5JM3RiUbx+
X-Proofpoint-ORIG-GUID: nHk9UcB54I_Xb8dPTbKxtBVdQ8Pvdbx4
X-Proofpoint-GUID: nHk9UcB54I_Xb8dPTbKxtBVdQ8Pvdbx4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_02,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 mlxlogscore=779 mlxscore=0 bulkscore=0 spamscore=0
 suspectscore=0 phishscore=0 adultscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508040023

On Mon, Aug 04, 2025 at 10:20:21AM +0800, Haoxiang Li wrote:
> Add check for the return value of kstrdup_const() in drm_managed.c
> to prevent potential null pointer dereference.
> 
> Fixes: c6603c740e0e ("drm: add managed resources tied to drm_device")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> ---
> Changes in v2:
> - Modify a fix error. Thanks, Dmitry!
> ---
>  drivers/gpu/drm/drm_managed.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

