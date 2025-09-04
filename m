Return-Path: <linux-kernel+bounces-801791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EB9B449DC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 00:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D0397B5816
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 22:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557392EBDDE;
	Thu,  4 Sep 2025 22:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="koMLMNkf"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153852EBDF9
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 22:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757025661; cv=none; b=cA/+kEfM3R4kyWH7vyhEWXGJBQVsZ6R2lwVWMFZByKEbNrhHbDMMn1/R0mUWRRmCyspNJZk9xGmzJrYUjno4tQDWayt9o+rBHdR6kyGHQ8oTBmTLsM0pPEBoyirWw8AO/y+ibZ8Af6OimAO4VDWBzwidKlnxab1qIoFLICZwknM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757025661; c=relaxed/simple;
	bh=M5bKPGLtnxcO/My2CBGjLL/KtkDRlOItFEzCnDWLWmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lObA/9VmEWmwIga668eCc6YprTmlZF+hvWK6SvFS15sGOR+Vezh7eMn+biEBHm1puNJsE1lIfgwjtKBq/6Kxu1xSN0uYnKLOiZo0eHQakeCdkf3bFb1EzGtesF+N8sl/JZHJlXmZBFlt5CUMGSirRjweW8AfA2xq1vk6r7prNjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=koMLMNkf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584HeMla013631
	for <linux-kernel@vger.kernel.org>; Thu, 4 Sep 2025 22:40:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=q0/2X6fSQzSEu1azufYXnQrj
	q/1XlWAIU3a8iRB/9ls=; b=koMLMNkfOziyamTxK0o+H/EhND0hf2NsWBbSPi8E
	0x/H7UHcx8ajpGl/UjBLanN8J0QK2PvVcuGvYv/JdG2qhZo3yhSduKVSGgJGLPV5
	v9n78CVrQibOQK9K5alkLDKMyUhCeDQk0SYF4TMzS9UH3dvkuB8I8UtclP2/bOe2
	syT1v2h102y/R9ot69gSVxH0PCS6oZHmIPoit3P/orESka8BJ8paAtTDRQxbKTfU
	YZGhCSAlPqVFI8Wlxm6LENHQWa3qt761pTzqFXGmRwZZzybRjYu/HPZGharYXcSR
	sVvA3Z6m+xnVJ/JbzlCXpNGPZWo0HUwiqReao/KJZTyLUg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48w8wyd174-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 22:40:58 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b2f9e8dca6so29108311cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 15:40:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757025658; x=1757630458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q0/2X6fSQzSEu1azufYXnQrjq/1XlWAIU3a8iRB/9ls=;
        b=PDqaNatTaZ0XgVw9jTLw58bqk4SVHUhoQL2fYlUDKhZ44cgU6osea7Yz4VDdZ3+/+S
         KkIDWrMUkp+fv+fvKJaUgg4uTURzQL+Z0DSIfomzbLea++fmZFi3E1ImU/NXgt7FGs1x
         3zbf1VYp+ElesYZmqIJNFoyF5uSKQzEwLuZPqyq6fvhlkDmy4rPJt3tkxAavR4kvbdC5
         6NCrvjZcSna5wYgSlJ4RaCFhNTRmsQgKo3Yt90vyhmhuqTwwSKmqlk7+erd3YWn/xYGR
         cKGvU5YXe0T8o7XVB0N6XsI75POCPjS/+v0PcUOlJ+XaYK3YCt0R/hH+n/bi/mT+ECWh
         B/jw==
X-Forwarded-Encrypted: i=1; AJvYcCWOaC3i5kqV+usOcqFX/Ou9uxvkHaYVwe+U437GJx4tloOpBSWpjLeiOEzO8OSB0oAsQN2nE3oHm2gPj8g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj+yc4/9f19Kbjo124PYJNgY1LEVrJj/5XNqF9EQOKalaC+4Pd
	EbE+QR36Pgk7zeTo72XtsuEVfvh5U5hkGy6g4EP0Rp8GPBsWT0kH45FxtSAipvAsHNV0sTjlkd3
	TVrCBcwvFFcYq0x5UhgFMN5NZMy8Rn7tH8mYUqJ0HSUKfuDR0H38lUJnun0jZdjXvg4o=
X-Gm-Gg: ASbGncva+fzdiOoRysY2qg5YLCa+JQLWcW0yrN1YWV8j/32WZueRtNhYEmuGVYRjXEP
	sTUQQCvkPXuks0g3edIKvmPizU9/42t1TgAjIP5yPSKLmWuUJIAYRJUHVXr9lOHscTl+sViihI0
	ySaCRfm5hSAmdbo6R++RKF2f3XamcE3r7GVAC8/7vvp441/wZnZiZc3HiTSaf6BDwzVgtmUUChQ
	vWJ1c5bnET4YUyu5TVJl5Tj3NUN5SGdWdfl2J5e3DFh3pXQYwO5djFBgWhdCEbJ6gUTEheZlzyj
	SgdAOY/To0zvO1ryxXnENTp5s94jBU+NZy1HdGMR4jWkrj7eQiEFyiI99FYneeM0JJ9fJ6cFd7y
	IbxzAJ48dei+xePTGk39i7crKZkR9OGNVh50JqzwZhHG7Yh3TLxea
X-Received: by 2002:a05:622a:906:b0:4b1:22da:e4b2 with SMTP id d75a77b69052e-4b31d8a35f0mr262578641cf.32.1757025657996;
        Thu, 04 Sep 2025 15:40:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9T5slv0159C4I+XtP+od5jkW+4lW4ZBPraMTm+7/Ds81Z7ystyCqgzxYFmEk0u9e8h7INyQ==
X-Received: by 2002:a05:622a:906:b0:4b1:22da:e4b2 with SMTP id d75a77b69052e-4b31d8a35f0mr262578271cf.32.1757025657345;
        Thu, 04 Sep 2025 15:40:57 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608ad5027esm1452301e87.149.2025.09.04.15.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 15:40:56 -0700 (PDT)
Date: Fri, 5 Sep 2025 01:40:53 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Liu Ying <victor.liu@nxp.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Dmitry Baryshkov <lumag@kernel.org>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: ite-it6263: Support HDMI vendor specific
 infoframe
Message-ID: <6i7eyxajmelu3x4ckvwifmizln6jzybt6ykpwlefna3k3noop4@e5zdvzor24fn>
References: <20250904-it6263-vendor-specific-infoframe-v1-1-6efe6545b634@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904-it6263-vendor-specific-infoframe-v1-1-6efe6545b634@nxp.com>
X-Authority-Analysis: v=2.4 cv=Ycq95xRf c=1 sm=1 tr=0 ts=68ba157a cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=8AirrxEcAAAA:8 a=ogkFPinuHE6vtdJhAukA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-GUID: o3mbzLtcMt30-dhHdndSQIPCNTDIvquL
X-Proofpoint-ORIG-GUID: o3mbzLtcMt30-dhHdndSQIPCNTDIvquL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAxMDEwMSBTYWx0ZWRfX9lO/FOfkqs6k
 71+6eKnq/04DhvwNM3cWX2Jc3BVilXHvrWUV4xdSU5e53/exj3xhnH8b1rnWkrX0P/FvhmQTHki
 U3fWVyUf2xFNAAP6ZJ1zPogX7vZAUelRT9H9u1m/OV5Ac8Uv5ns54kMGSARxgNeOEd6q38AVTmr
 2MNrt0hw5EO8ga4uvGSmftYGZSHtMtaOgVu/RF6LCoDzYak4oGUyysoZ3PenewvyIHOBeG63CUM
 8xAOlorn+WaXfTJGd2BVVvn8jIMp0Yrf8pYTn++gIukvi6VQ9oO9IG5BEYS9n2neRQkQegt5QR5
 dUY2zzccW1/FVibTU6pex8/9IQG3q5zrHqWvpweWkdYqbPvT8/RC3uFwrBThYJ4IkWdvsFJhlFc
 KbgNvI2N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_08,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509010101

On Thu, Sep 04, 2025 at 05:10:02PM +0800, Liu Ying wrote:
> IT6263 supports HDMI vendor specific infoframe.  The infoframe header
> and payload are configurable via NULL packet registers.  The infoframe
> is enabled and disabled via PKT_NULL_CTRL register.  Add the HDMI vendor
> specific infoframe support.
> 
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
>  drivers/gpu/drm/bridge/ite-it6263.c | 72 ++++++++++++++++++++++++++-----------
>  1 file changed, 52 insertions(+), 20 deletions(-)
> 
> +	case HDMI_INFOFRAME_TYPE_VENDOR:
> +		const char zero_bulk[HDMI_PKT_HB_PB_CHUNK_SIZE] = { };
> +
> +		/* clear NULL packet registers due to undefined default value */
> +		regmap_bulk_write(regmap, HDMI_REG_PKT_HB(0),
> +				  zero_bulk, sizeof(zero_bulk));

What if you move this to the probe function? Then there will be no need
to write those registers each time the infoframe is being written.

LGTM otherwise.

> +
> +		/* write header and payload */
> +		regmap_bulk_write(regmap, HDMI_REG_PKT_HB(0), buffer, len);
> +
> +		regmap_write(regmap, HDMI_REG_PKT_NULL_CTRL,
> +			     ENABLE_PKT | REPEAT_PKT);
> +		break;

-- 
With best wishes
Dmitry

