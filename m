Return-Path: <linux-kernel+bounces-885488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88312C331C6
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 22:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 839D1427681
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 21:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD2F34678C;
	Tue,  4 Nov 2025 21:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UNNWkds2"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6E22FABF7
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 21:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762293237; cv=none; b=Y5kZvSNjbeqz/TEMp2TCmmS+O4cEigXpTqZoFHhBtB4SBQKYT9YMJMIf2C8h969FD6pQe4cCW8wjiqRc+3X7clDvJUsS5PEnLdigilYPmJBJiN2h07L5YR1/DUa0Ko6C4CD5t21wrzNljP3ECx79wOi1VaWUvGq1ZkMSUdjtaKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762293237; c=relaxed/simple;
	bh=Ag7nHp6KPf1uRxgLm84SehZvG/JEN7e8d4bNXVc5b7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YEo7TWRPYU9gexUqUM+E9mn9aTOA4uHKPD6lUaW/1CFx8fBqaOd2VWnh0kFqJK0sFJuD/PcbCgAgwtNxmerV1Mfx/1XcOzfcysYfn9Cefw2ZYY54BTUl+SHx36FiLm6+Wm/j/80EzQjCqRN60E4Jbi1GCCreAUG9PFZcJJ/U9Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UNNWkds2; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a8f0de1d-07e8-4e48-8495-9cafa0febcf5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762293233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DYMd3nWuvWNKjSkxKxSoso9HfqmlhsjNjxbZY9/Zc/s=;
	b=UNNWkds2nwFp2h/Ss2GzM+XwOsHS+/FnMptQDlclwRKWU4aOg4M+BMKR9GgFDdBfieqlYM
	KS3CjbR4o93ZVWLhpu+ey/0Y5STKB5TOH+JRCmjnPCo8F1vrww3ckteDEEFOD9xa18URIN
	VXkdKbi5wX4AKW+tyt34sd+olRk0I18=
Date: Tue, 4 Nov 2025 16:53:48 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] drm: xlnx: zynqmp_dp: Support DRM_FORMAT_XRGB8888
To: Mike Looijmans <mike.looijmans@topic.nl>, dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@gmail.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.fb98a918-329e-4536-a0a5-a99b22ba0120@emailsignatures365.codetwo.com>
 <20250627145058.6880-1-mike.looijmans@topic.nl>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20250627145058.6880-1-mike.looijmans@topic.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 6/27/25 10:50, Mike Looijmans wrote:
> XRGB8888 is the default mode that Xorg will want to use. Add support
> for this to the Zynqmp DisplayPort driver, so that applications can use
> 32-bit framebuffers. This solves that the X server would fail to start
> unless one provided an xorg.conf that sets DefaultDepth to 16.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> ---
> 
>  drivers/gpu/drm/xlnx/zynqmp_disp.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c b/drivers/gpu/drm/xlnx/zynqmp_disp.c
> index 80d1e499a18d..501428437000 100644
> --- a/drivers/gpu/drm/xlnx/zynqmp_disp.c
> +++ b/drivers/gpu/drm/xlnx/zynqmp_disp.c
> @@ -312,6 +312,11 @@ static const struct zynqmp_disp_format avbuf_gfx_fmts[] = {
>  		.buf_fmt	= ZYNQMP_DISP_AV_BUF_FMT_NL_GFX_RGBA8888,
>  		.swap		= true,
>  		.sf		= scaling_factors_888,
> +	}, {
> +		.drm_fmt	= DRM_FORMAT_XRGB8888,
> +		.buf_fmt	= ZYNQMP_DISP_AV_BUF_FMT_NL_GFX_RGBA8888,
> +		.swap		= true,
> +		.sf		= scaling_factors_888,
>  	}, {
>  		.drm_fmt	= DRM_FORMAT_RGBA8888,
>  		.buf_fmt	= ZYNQMP_DISP_AV_BUF_FMT_NL_GFX_ABGR8888,

Tested-by: Sean Anderson <sean.anderson@linux.dev>

I can confirm that this provides a nice performance boost :)

