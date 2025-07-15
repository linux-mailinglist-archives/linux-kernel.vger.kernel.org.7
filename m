Return-Path: <linux-kernel+bounces-731787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C38EB05985
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 14:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D10B1AA394C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 12:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933672DE6E9;
	Tue, 15 Jul 2025 12:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KMKctzsZ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA9F2DC339
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 12:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752580974; cv=none; b=eFSkQOXA2Xr1eglbJqT79z1FyIyxMWmGeg0DYB+QXNgZak2ick3yo7GpdduTmmtid36j/kNpqMMJSF5FND4lVQJA2LNpMLelxB+uKsWjDmrLFg5P2u5sRrd0zojMwD7nkEgu5D3Sa3KeUFcJL0eBrKeinzAPR9BFnjXcAsluU9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752580974; c=relaxed/simple;
	bh=l37WqW+WBXqkVfu2HOUNHSb1d0veZn9QPcCb8q2egOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tfxoixt7AlrYHLRVPVBQ9QwfsllCnqP0h2DaOJS9JEWdbA9KrXrMpulgeFpY6QKdkCNe6J9txiAd45Gwjx4asc4uZ96e+kKc1lpHIFwlIZvbCXk7uWQYSr00icGX6tQm+0HCZOVSVh41C02fR3Dvm08C1LllcTCt9G0aufh7tjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KMKctzsZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FAlWOa011599
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 12:02:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=UyvvQBMgtajbfKdGdnnoGUgR
	+QFHhmOiew9p+7Bprro=; b=KMKctzsZHgfBy/hGall1wlDYbSjiIYkpbOvYiRTg
	00VsLDU+nvAHFg0qvF1CJkKOta8QR0QYEHcVklkMGv7gCohSn8vnZ+plbUuTPZ7l
	ch/plH44WYR4DyFY7Ouah2MCmSDVSoiFvlJEpmiLRMZV6q5VF5wLy3bwilOWPbSd
	ELqOTNV7AX2xfD+JC3i4PKEB0vq07Tp5u6+5X0l6CtHW4YxIcWCKFJVkm+3PMEtf
	aIl2FqElNjAjjkiDf8XtST/iUc2eIrLCTVrgCnlu+XGri5I6ef1nyEAqVbgU3ezL
	5WwaZz9/H5MRgcB/MNvQeuniDNf6iWE9zaDg7I9xAekEiA==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wnh5r77u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 12:02:51 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-73c88fe25a6so1477959a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 05:02:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752580970; x=1753185770;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UyvvQBMgtajbfKdGdnnoGUgR+QFHhmOiew9p+7Bprro=;
        b=ZJrOKeUT96iKCA7PDjlirQG9y2gqSRQ6kvEa9+5T/G0Tw+ExkBfknJi1jKSBeBiUcR
         gWVzt8yBFEzEHQRKAwEl9aom1+w89fpX+2fVTNfMe5xyMtNM4mrzrhwJ0okzHfeqo0Ze
         1I1Q1jvNfkuVNsLcZY6a82pKtlF61wnx4tUy+Z6oHdwVxnDpi/mn7SAfVbUV14hAbB5w
         fB6ZNykKypkYj1wK0I2fd4iWqkxM3qVb/bhg92i7uP3J0HOOzlHuFHqkT+i2/JKWcDWN
         rKhaRB1WyNfjkUXW4JAxSVQmhhKTQpeOcUVu6CGgPU7523GlFvPJ8nuJtnaFDPWY95lo
         7zvw==
X-Forwarded-Encrypted: i=1; AJvYcCU/Ns7GfHfBWNRwHAlXgbtL1aHO64d0h+P2/WPPbBEqnwiVoMDtez0fdDr/bV/BrhI6MjuQzeM4dT6mFQA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4TEoz5Uw+Zr6yIwBNVVadqeCs7MQV6jgMIx8OJq6gD0VK8YIE
	14QibL20T3zhGQ3xC5GgZ4IuEhSffgwd7NW2zOEITjAZf9n0tP39n0mxQFjqNmQK1b+sf1mu6Ev
	RzMJRcQFAiqRA9rPFot+if45SmzQ8VlfskUwbOkio+KCK7EXkEfHiDwOO0GX76aJ44EQ=
X-Gm-Gg: ASbGncsbFxC7ipPoKEyiU3RDoco+83WWvmPcCWwgtXB7O6S3UTvGqVFwgpy/j5Q395w
	gH8lXXH70E+ZgiwzFkWCKW+wXJIHUJvhj+zGz4jakhioYz0q/hAS7rDttcUtPpTj02dV1CEhqa8
	w/g1DPSlOxpmCnS0IHXQYMRnG0QXkbnWBX950DNzRBljH67mSG/kbpRtM+dWGRWjVneI/pTpgby
	zp8DcwY7G09MfwrcF3tsGlqIV8wQ8N2ViOn7uiCKfBwPgFoByuKVCt/BLAMSfet/KyGqGNiKUFh
	AhMghedutgMDVjXWfi0zHqD8B24PWlWlqLzs1x9kPk7ZDW+9tfCqXX05XWNznarKqF5XCNoHliX
	tSuZMHNCyxWzudDruWskLvheVuXNQ9tS08ZcBlGnovGkaESvtE2cf
X-Received: by 2002:a05:6830:3692:b0:73a:99db:aa30 with SMTP id 46e09a7af769-73cf9df0d64mr11073234a34.11.1752580970543;
        Tue, 15 Jul 2025 05:02:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRldZmaGruwEtV93mfPK7DeHfUeVU3CqYU97eA4DGqB+RrTOx1wiarAqLcagJKllyUevLfNQ==
X-Received: by 2002:a05:6830:3692:b0:73a:99db:aa30 with SMTP id 46e09a7af769-73cf9df0d64mr11073201a34.11.1752580970169;
        Tue, 15 Jul 2025 05:02:50 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32fab9117fbsm18753031fa.98.2025.07.15.05.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 05:02:49 -0700 (PDT)
Date: Tue, 15 Jul 2025 15:02:47 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Andy Yan <andyshrk@163.com>
Cc: simona@ffwll.ch, andrzej.hajda@intel.com, airlied@gmail.com,
        ian.ray@ge.com, jernej.skrabec@gmail.com, jonas@kwiboo.se,
        Laurent.pinchart@ideasonboard.com, maarten.lankhorst@linux.intel.com,
        martyn.welch@collabora.co.uk, mripard@kernel.org,
        neil.armstrong@linaro.org, peter.senna@gmail.com, rfoss@kernel.org,
        tzimmermann@suse.de, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Dixit Ashutosh <ashutosh.dixit@intel.com>
Subject: Re: [PATCH] drm/bridge: megachips-stdpxxxx-ge-b850v3-fw: Fix a
 compile error due to bridge->detect parameter changes
Message-ID: <nrtzmsohsvdux5wsd5g76f27ironu3nnc2s74soo43zl3tvu5t@bald3bp5mldc>
References: <20250715054754.800765-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715054754.800765-1-andyshrk@163.com>
X-Authority-Analysis: v=2.4 cv=dKimmPZb c=1 sm=1 tr=0 ts=6876436b cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=QyXUC8HyAAAA:8
 a=Byx-y9mGAAAA:8 a=8aKB3WWJpCxwycPcSpwA:9 a=CjuIK1q_8ugA:10
 a=EyFUmsFV_t8cxB2kMr4A:22
X-Proofpoint-GUID: 8CoIZpQNQ-Pz8NjuwWg_ZGKFz5RsKbLF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDExMCBTYWx0ZWRfX+V4nbMT8iqY4
 sbUUwWBrCbjexw1VLXsO7r04Wt7LlIJ4Zrl5z5hf5Rot/8KDBqhbB0Unjm6KKIFwxUjo65T5um4
 8oKz5YciqYJHdfkXvrWFXOjYAntGnLlxuZgnacscDC7K40t6gyz/gW6wJzMlCZVoXw1Cef3jiMt
 diglGiwFdu+4n0jncFjjo48No6YrlHinsPUVF8+BUSeRd3txe/CqsYgBu1uJH0fdqttxMn+VaKN
 K0IutIsqCk70V69PA+wxGevylUBrE92/z30iQexoMjMCf9MdXZcOOoSZkMV/gzn82QCd6lEVBMs
 eg7OqLu+OQuXaEXDQjAM+gyIR44CeWJNDBRd3OkFFVt2W2LF64SoujXwWqhqZUAUZJjtdwGQWb3
 0qgYJJE15/oY+zbYY+mAr9ag8ZIrdoEzDO+njENXmLL5pCJdW1a428EXQdFkMqtVXXFFJ0Qq
X-Proofpoint-ORIG-GUID: 8CoIZpQNQ-Pz8NjuwWg_ZGKFz5RsKbLF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-15_03,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 mlxlogscore=730 mlxscore=0 spamscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507150110

On Tue, Jul 15, 2025 at 01:47:52PM +0800, Andy Yan wrote:
> Fix the compile error due to bridge->detect parameter changes.
> 
> Reported-by: Dixit Ashutosh <ashutosh.dixit@intel.com>
> Closes: https://lore.kernel.org/dri-devel/175250667117.3567548.8371527247937906463.b4-ty@oss.qualcomm.com/T/#m8ecd00a05a330bc9c76f11c981daafcb30a7c2e0
> Fixes: 5d156a9c3d5e ("drm/bridge: Pass down connector to drm bridge detect hook")
> Signed-off-by: Andy Yan <andyshrk@163.com>
> ---
> 
>  drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

