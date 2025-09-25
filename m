Return-Path: <linux-kernel+bounces-833356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F73BA1C3E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 00:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 284411C278CC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 22:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CCFA262FE9;
	Thu, 25 Sep 2025 22:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hLHiuUW3"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D9B212B0A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 22:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758838531; cv=none; b=IFy2fOAZvcfG1rlUf/m2/3qR8ZnYAt6Rx94tvl8wXA4fqnq+M6b4lj3myYm3YOsn1yuTXzsyktkOkKSNu4f4OWg9ymNDkL2mlkwlshhvNCIoD98luWENSyz6Tj4np2+ulqgUkC+hieVER2Az6iDPVoRae6xo4sQHbLnqS1HLC0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758838531; c=relaxed/simple;
	bh=nYBpFIreRn6jZ29fZjvMiKti9vNTgVclgycOKztY9cY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tT/QWEE3CK+W0Vc7VZb2VljuYuDOARTgjUKqFItTAqy/9M7OIcrq62cHBmIWjUlUB50goQ1uRCZ0kbFBX3RmN8RghDT/T2ZHAAowpQNGZztTM8ZvKLRnQAH95aEFvkyRZgWfBJtqIxXelJBPnKxTHIiz1m+lMFT7jEdmTToLKnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hLHiuUW3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PIPom1025374
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 22:15:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=sjdi5D29k1kO+lHenvXFjyon
	bfZFH9gQroDJ/bmbuc0=; b=hLHiuUW3Lp7IgkcpDQZ1VoR5a8dnJ7tqj/mFZvxi
	NWbrOmjUceE7DOlplgQMtcppvWStBo7bAxftHRsEQZsBROyh2xa4G91NBvzSWzb7
	2q89/11ibH9XB92lwg83NIFPiip2tCIMJSL5TJzJhCr9622NlM/0tp7H0GW4IjHg
	JuqF2BTbvkoX6RLgm76C+REwzuWwCzOMr5Y6ZxRMeCn0O8F2Q4W0n5vpVOXhP6vD
	9RgCpGIwKKwFSIEQgRC5x35r2r76IIwq14T8V4eLv3fjRhy2Vlm6TS40NglAanuf
	WOaKpGR3b2JS3lZXsYQ1WTEdVM/mbFQ3//HDvVUJVki8dA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db0u0j8v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 22:15:28 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b793b04fe0so33596621cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 15:15:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758838528; x=1759443328;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sjdi5D29k1kO+lHenvXFjyonbfZFH9gQroDJ/bmbuc0=;
        b=oZc11k5iZFqhPf9grBkzgbFZBKoP6D0+XPtUTfiV5IRkxZ+1T2ZKhSyrJ1ucP2Kqcj
         qclrZTf5LZFfA8HhrDp3SXAcqaBVs7E1A5GKOLw46tlJDCqSZceA4kdigapFiVhQWeEQ
         gCFzNRz7sD+emFGPecYyB4oGw3XJKe7ldnlBvoAKj+Ql8juhkIBvHupvoOHXYqDNB5hb
         8SGy4MnjAd+0rfZYKEwqYI7i+drnI4W5ezMeKipY7SqoR8fIIIfnhZV/sbeAdRC7iC31
         MBUrqlvHnUlqKkTKB5hS9Yyv7bo+4V70SwvzurKaEtyz5GhrCVy2LKkTzFq3LIFSGfHC
         GCFA==
X-Forwarded-Encrypted: i=1; AJvYcCXgvFeHNw+AVvhS4dyqJRG7eLgoLyUugiU0QhTeqtSTG0cQ/z+w06Rr9wo1LgP6HuNLoTFrt2HwAekqD7M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0jNJYR1/xRh2Q4rTEtncgeeWlXi8sDTPCMG+xanY0HPIVmtmD
	pJ7hduJ+KsX0n60+TqZa/ibUZuEmWBlKA77zK6CXKtdAu/PnNhl1mEKCUjJxRCJAqrJ5UNWBoS9
	Ko5MavxBMKGkWDJkr3sbGKZyKR3GTj+5lClMNR8e6XxCIlPNqR6K6cAKhmbJD9jfj2Kc=
X-Gm-Gg: ASbGncu0ke4Su5yblDMvuIAJ3aGYPjQg8ZO6mvXQGL5qQXqnQcuofO1YFWuH021e/mZ
	Gs0ZJI5tNlyerpPJa90bzvvOoBHimT6nxgprWP4cURe0uJ8g8xKJNmdM9Yt9YVvsJhTUdob5jN9
	23uIJe5eMbQjPAXAPq0S+jWC6bl1NbNa6bMf6o9P7YKsp034s4/H+M82cV7G6iVG6ENOkPnM10K
	mruBdZnMNRfz/YH5vmIyXnnUsZYlntkzI1ILJZaIb3Jw02RZaDP310YdzGu35ONU6MxCUzjYhBJ
	PU+uio9o6ubiklgIXSGAlNNJ+Uhy9lVL5KZB888A8hbnIn/tR91Jcql+2o9LvA2yPT9QvlUis2k
	VK655i+8557+0X8+TuyQSj3q8S+gY+zH1rN91ECbxD7jR5JssvGNC
X-Received: by 2002:ac8:57c9:0:b0:4d9:186f:8503 with SMTP id d75a77b69052e-4da4dcc0bc2mr74890021cf.81.1758838528003;
        Thu, 25 Sep 2025 15:15:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNrQu0pE5yE6hbpFhVa7QeLfuYlu7eJGATqKLFH3hTVEDF586F4+O3E+td7C4eAXHv0A1y0Q==
X-Received: by 2002:ac8:57c9:0:b0:4d9:186f:8503 with SMTP id d75a77b69052e-4da4dcc0bc2mr74889411cf.81.1758838527365;
        Thu, 25 Sep 2025 15:15:27 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-583173d2007sm1158596e87.149.2025.09.25.15.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 15:15:26 -0700 (PDT)
Date: Fri, 26 Sep 2025 01:15:23 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Chu Guangqing <chuguangqing@inspur.com>
Cc: tzimmermann@suse.de, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@gmail.com, simona@ffwll.cc, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v5 0/1] [DRIVER] gpu: drm: add support for Yhgc ZX1000
 soc chipset
Message-ID: <ek3ynjxwz5oj37fwwvtnxqcmijhn54h7ncrhcpnistjud7cewe@mrmjzskvzr5f>
References: <ouli257ffd7ocmwzywxq5zlapw7j4aqowy3oeu74x46dmpymah@b6r7py6bixsp>
 <20250925091715.12739-1-chuguangqing@inspur.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925091715.12739-1-chuguangqing@inspur.com>
X-Proofpoint-ORIG-GUID: sYT1NQi69sZEMnvCUtgmd6jkGfffKIrS
X-Proofpoint-GUID: sYT1NQi69sZEMnvCUtgmd6jkGfffKIrS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfX6cD2eWJ0BN+w
 ne4milQjFsRIOUBxUgwpb4dDj9e9Gpbnex5E2ZuIkGm9su1mR37Uu389UAzIYsFOXFSVvg24r3W
 jcspHGwykwS5RbAdGrvWcrECjfYdTgg7M53rDp2vJMdfQ2gdLBYZ3NCMLFbkcXSgq6zNP3FMOQ1
 vb91wsGb/HeBVX4pAxFQhIOn5IspoPl3Ff5k7slaprIKmCHyO8B0fCJ5FQ9tFxsu7opKoKIFYsg
 e3T4i9jOuWLDU3v7ckiItUXm2mhGNWsFu9Y8RPVPFcWBo4YaLfcKjxjlBeXmRVSlu156Lay/dHO
 z1KsjPB713iO2u27UGvQvG/TGqb26C84VFQm0Xy181Y5SgXS4VfSta6ZdoOKy4tugq4sfVk7Mql
 yzEWPX0gA9j2rZPtuByiYTawrV6BkQ==
X-Authority-Analysis: v=2.4 cv=ZsHg6t7G c=1 sm=1 tr=0 ts=68d5bf01 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=F_93P0QhAAAA:8 a=V-VOkMrW4BanMQ8zAPYA:9
 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22 a=v2fne3mUlQEKA94IZ0Od:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_02,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250171

On Thu, Sep 25, 2025 at 05:17:14PM +0800, Chu Guangqing wrote:
> Hi Dmitry,
> 
> I have read Documentation/process/submitting-patches.rst. however, the content
>  is quite extensive. Please point out any omissions if there are any.

Most importantly, don't post new iterations as a response to the
previous one. Always start a new thread.

Also, please respond to the original emails instead of just posting new
iteartions.

> 
> Q:Is there a need to probe here just print an error?
> A: it will be re-probe at detect_ctx

It doesn't really answer the question.

Please stop pulling the questions from the context. Go back to the email
and answer them there.

> 
> Q:No .disable() ?
> A: yes, we have only implemented the enable function

Why there is no disable() code?

> 
> v5:
>   - remove extra level of subdiretories, change to driver/gpu/drm/yhgch
>   - remove else from > +        else if (!new_plane_state->visible)
>   - remove extra check in function yhgch_plane_atomic_check
>   - remove the extra parentheses
>   - change the author like other modules
>   - use drm_edit_read function instead drm_get_edit
>   - remove debug info drm_warn call
>   - rename function name smi_connector_helper_detect_from_ddc to
>      yhgch_connector_helper_detect_from_ddc, remove extra return statement.
> 
> v4:
>   - remove  VRAM helpers from Kconfig
>   - use the coding style in ast/mgag200 for the DDC
>   - use plane_state->dst instead of crtc_h/w/x/y.
>   - delete duplicate framebuffer's atomic_check.
>   - use FIELD_PREP() directly.
>   - use dev->mode_config.
>   - delete unnecessary drm_atomic_helper_shutdown call
>   - add AUTHOR
>   - using .enable instead
>   (https://lore.kernel.org/all/20250924064954.3921-1-chuguangqing@inspur.com/)
> 
> v3:
>   - The order of the code blocks has been adjusted, and the "warn-on" branch
>      has been removed.
>   - removed the related formats for the alpha channel.
>   - removed the atomic_flush function.
>   - have removed the empty line.
>   - have removed the error message here.
>   - replaced it with the drmm_encoder_init function.
>   (https://lore.kernel.org/all/20250910022311.2655-1-chuguangqing@inspur.com/)
> 
> v2:
>   - Delete unnecessary comments
>   - Delete unnecessary branch
>   - Use drm_atomic_helper_check_plane_state
>   - remove the alpha formats form this list.
>   - use w,h rather than x, y
>   - delete type casting
>   - use a simple call to drm_atomic_helper_shutdown()
>   - delete yhgch_load function
>   - delete vblanking code
>   - delete unneeded i2c type
>   (https://lore.kernel.org/all/20250903054533.68540-1-chuguangqing@inspur.com/)
> 
> v1:
>   (https://lore.kernel.org/all/20250808053508.52202-1-chuguangqing@inspur.com/)
> 
> Chu Guangqing (1):
>   [DRIVER] gpu: drm: add support for Yhgc ZX1000 soc chipset
> 
>  MAINTAINERS                            |   5 +
>  drivers/gpu/drm/Kconfig                |   2 +
>  drivers/gpu/drm/Makefile               |   1 +
>  drivers/gpu/drm/yhgch/Kconfig          |  11 +
>  drivers/gpu/drm/yhgch/Makefile         |   4 +
>  drivers/gpu/drm/yhgch/yhgch_drm_de.c   | 415 +++++++++++++++++++++++++
>  drivers/gpu/drm/yhgch/yhgch_drm_drv.c  | 310 ++++++++++++++++++
>  drivers/gpu/drm/yhgch/yhgch_drm_drv.h  |  51 +++
>  drivers/gpu/drm/yhgch/yhgch_drm_i2c.c  | 114 +++++++
>  drivers/gpu/drm/yhgch/yhgch_drm_regs.h | 208 +++++++++++++
>  drivers/gpu/drm/yhgch/yhgch_drm_vdac.c | 121 +++++++
>  11 files changed, 1242 insertions(+)
>  create mode 100644 drivers/gpu/drm/yhgch/Kconfig
>  create mode 100644 drivers/gpu/drm/yhgch/Makefile
>  create mode 100644 drivers/gpu/drm/yhgch/yhgch_drm_de.c
>  create mode 100644 drivers/gpu/drm/yhgch/yhgch_drm_drv.c
>  create mode 100644 drivers/gpu/drm/yhgch/yhgch_drm_drv.h
>  create mode 100644 drivers/gpu/drm/yhgch/yhgch_drm_i2c.c
>  create mode 100644 drivers/gpu/drm/yhgch/yhgch_drm_regs.h
>  create mode 100644 drivers/gpu/drm/yhgch/yhgch_drm_vdac.c
> 
> -- 
> 2.43.5
> 

-- 
With best wishes
Dmitry

