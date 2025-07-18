Return-Path: <linux-kernel+bounces-737192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 067A5B0A8F0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 18:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C7DE7AB8F0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 16:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DCB2E62DF;
	Fri, 18 Jul 2025 16:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P/vBc69j"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9452E2644
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 16:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752857522; cv=none; b=l3BAbszEqcqQp5JfRUXo/u6tPXL3GJn82uctAnh/VpqV8xxF+h+3xGgO59wpcMYd5MaZsHmfyZmy/Ss05fI3AISuqwqnXB21Kcqbi5m8TbjCSBtXiy2DHLkbsyIZ7sxJHqUsYxN6TWiVfOXXzKSewn2zO4yELmPr/tjqFZES8R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752857522; c=relaxed/simple;
	bh=ajWRLPha10nm2FkACMYheyrSR1VuxYvlHJUQ1nKkUA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LIrpZcFA3evGesvjGmrF++w2kHGLA0iSsi8ak51uLIhIWvYiBXMevLKWEcL2Mh9WUGETiq8KGxzGciKGWgoVO2C6MB/RatTjskvuucRN2pBbvmuYKI8fuMfIPct4FGRkWlOQYA5t4YoLaQOZn3dfrgX1qCb+XC/jwyKlfwzu3mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P/vBc69j; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56I8h26Z008487
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 16:52:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	i/jJS211K+91WfPtzNzKrjWRU80MmsvCM3rgFx21dfM=; b=P/vBc69jyQvb8sow
	lV/WOYxFLnnzhJsAqu/H721IYea+wKWldZ4xEYW92WXsZSktINoRbl0ftsHf3RFw
	x/1FLPFMwXwG9xAzrRr1gn/M+wzs6rR9jrpm7PFqfcpCe061m5PGDozIRfvr1fSV
	x5Ip0dkql6htf1/vbpv662dOR36r0VSNUp2XahM1HQuwQknuXgRAi3EeWFMXbo57
	ZmW4wtfDwMEKlSGkHEK+X61BYZv3NI767se+yb0V19LFavGHalln4qC7+6fHfQWf
	oi/SngOP17bMOcXoOE/IKlfcsFXN9g9wlPOWUOZyhdmB/pJowmXiJOiwODcz6jUd
	+PHV0Q==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufxbcbht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 16:52:00 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3132c1942a1so3133610a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 09:52:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752857519; x=1753462319;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i/jJS211K+91WfPtzNzKrjWRU80MmsvCM3rgFx21dfM=;
        b=iZsmKfJKL3W4CqFvxwHyjBjk87rQK9uel+cJy4eroM3sTnm9wkPMOyTFWTlXhPMC/r
         rCTlEgGWZIzdZaTxHPi9BPMzi4Rs7/xNCK3FJeJlm52KdhrY3rsDAvPyNeoDX2NDutal
         MXGykh95C3utuAj5s43AQ6u9wVT6wAhB2SiIWjHFQwMKnEtZVsYf85XLkTteEhXp6Dn1
         4L5MN9fvNQXcs7+TmE0zx9WDdBNK0Q9JVNheh8rmJKM/g77idnA9mYOGOMwrXH23By5l
         p1iguhjcR9jsvDA+xAYI5EdvtUHYUlz9JRtMoBwOFV8KEzWStkxsBQ3phIv6uK5d6dZJ
         9J1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUz1qHWXhcWfWHR9MwAfykPErIv7jhWIaXzxCeipwoT9lDc9w2hY/BMS0Eyzs2HI2Xgq1nqg/r6c7/A3XM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8V8LW1MW5uxhzgv4/+u5a8H24/Tom2wFNyz3zyu2XOQoAwig9
	EnoFcUlAX7erZ+rAspTMWfjiv+kOWMVUHP5bY+OTH3D9Gs1rDdSS3r/znON2/dSMr4LsYcm9+He
	RTWC7lQM9K+WWt9AEvQTOhgbzDADN5i/YZ/FdAeLLNxF7nxXaeysmsXTjJpdcDyU2Wqk=
X-Gm-Gg: ASbGnctiP35WlB/ip+azD4bDrC1vhhUN0WrBEU3DUjVe0KWPgHtcFTIHe57FecCLYLd
	oPCdqAqQBoxGdZteJcjeARuVjk4U4bSe/a/q6i69BLqySG/PKzHyPpnb9+WIyQVRMScgM4BUmhu
	l0rPlomTaYPvjcfI7CXrEFt2HK7O9m3/hm/BP1jbZKbRWkQHTyZicxrFvmoGiELVdGrQgCaORNo
	MTWGP2zKnj/UqfN27PjCWUR7L/yaBdzEp0DZ18B4ivSTjWKW0gOdnsJyLVvb1salxpaU0e0QVoe
	wL1P3SyQrNjvoaCcw2nk5wGH2OEJlk/CH9/39R0juIqBg4hpvkgNhC554HBOaLZ4lAfy5Ew1cOJ
	i/glt408h2M6TFw==
X-Received: by 2002:a17:90a:ec8b:b0:312:1ac5:c7c7 with SMTP id 98e67ed59e1d1-31c9f3993d8mr17038315a91.2.1752857518929;
        Fri, 18 Jul 2025 09:51:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9NIA98X5HRDDVuwcioD+0TFYXDcZBMvtr4Luz9HPLr/CXztRxjI3u8ZOFya8id3YrAIy6yQ==
X-Received: by 2002:a17:90a:ec8b:b0:312:1ac5:c7c7 with SMTP id 98e67ed59e1d1-31c9f3993d8mr17038273a91.2.1752857518544;
        Fri, 18 Jul 2025 09:51:58 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31cb6ad7257sm3078809a91.42.2025.07.18.09.51.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 09:51:58 -0700 (PDT)
Message-ID: <2de96bf3-0c63-4db9-b581-f011bc1446c2@oss.qualcomm.com>
Date: Fri, 18 Jul 2025 10:51:55 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 1/4] drm: move drm based debugfs funcs to
 drm_debugfs.c
To: Sunil Khatri <sunil.khatri@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org, simona@ffwll.ch, tzimmermann@suse.de,
        tursulin@ursulin.net, phasta@kernel.org, dakr@kernel.org,
        linux-kernel@vger.kernel.org, Oded Gabbay <ogabbay@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>
References: <20250704075548.1549849-1-sunil.khatri@amd.com>
 <20250704075548.1549849-2-sunil.khatri@amd.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20250704075548.1549849-2-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: waKBTu9PZxEHLxkjh_cx19oU-9nmxdFS
X-Proofpoint-ORIG-GUID: waKBTu9PZxEHLxkjh_cx19oU-9nmxdFS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDEzMyBTYWx0ZWRfX6iPrNwZpDO/v
 FPb4KQ3EMkjheEqRDz6NzIbKNmWFSXfX5aY3fo7qJenrzav6/9yCiJ0zIgR4HulyE+LJkO02Vwm
 HgS7fThaEU6xSLSqBa9wQM25Oae8JJBiaejuBJtgxYoVM0/Rdxqeuny3cR75EZh9p4qMt/vPjVv
 Dzpu4vmG6Z8MibPdWhZFjK7JAK1e2ZcT76JiZUCkDpKHXkBHKKl+h0sQ4bawxsLcRSj7a+6OXoy
 iz0AtnaBp++HtBreT6e1cpC1FmuOvKh1YUP2OSmdobtO8A/haNJgMfcesS3yAKN0wCfCEWqMfoa
 z0OdzOeKoJ6ufTsPJ4qge5q6+XeBv192nE8D/6VR9jRnRCqfiCvPGGPiKMu1q9eESBh2Pnqz5v8
 FKJ4yx++Yu05RQRXakGP8rXe2/31h3xumhqQYCc2J5AWqzEcG3yZneHodgQNpt2CD88LO60u
X-Authority-Analysis: v=2.4 cv=Xc2JzJ55 c=1 sm=1 tr=0 ts=687a7bb0 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=zd2uoN0lAAAA:8 a=EUspDBNiAAAA:8
 a=qFjxPv6tQ-BECiE8w1cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_04,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0 priorityscore=1501 adultscore=0 mlxlogscore=699
 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507180133

On 7/4/2025 1:55 AM, Sunil Khatri wrote:
> Requirement is to create per client-id based directories to
> hold key debugging information and for that access to
> root debugfs dentry is need which is not in one place
> and that information cannot be stored in drm_device.
> 
> Move the debugfs functionality from drm_drv.c and drm_accel.c
> to drm_debugfs.c This enables debugfs root node reference
> directly drm_debugfs.c and hence enable to create per client-id
> directory.
> 
> v8: Create drm_accel dentry only if it's config is enabled (Jeff, Hugo)
> v8: Merge drm_drv and drm_accel debugfs patches (Koenig, Christian)
> 
> v10: Since we moved drm_debugfs_root, hence to handle drm bridge
> debugfs add a new function which call drm_bridge_debugfs_params where
> drm_debugfs_root is accessible.
> 
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

 From the Accel perspective, this seems ok.

Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>

