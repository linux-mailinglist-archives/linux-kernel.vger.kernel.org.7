Return-Path: <linux-kernel+bounces-896173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 26870C4FCD6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 22:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C777834DA3D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 21:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A23735CBD2;
	Tue, 11 Nov 2025 21:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ApCSoVk/"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F0735CBD0
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 21:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762895379; cv=none; b=YAnDXaX1QL/Xb4DWrxhbIje3YRZOuSuKLX/8B8hcSL9pOVC/gOH/35+Tl4CcySXtbU+Hxjxuz1K/nKvzFr2gN66QcQjNqiaqNwP6fu4yCwWNwIEc+MobYV23xS/TCLdlpv7SG0PJ5hB9Gnzoj5sBwQoW12Si8saOiD2d/sF2NaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762895379; c=relaxed/simple;
	bh=u23M0v91P2RPiO0frHLrWTsHsiBjlgQOEnlCXuYv/OA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=UKVnXQutYDXyXyc9EVIocp943/bPXj/vVUrawrqDg8ffcqBz0Kf0mJOqQTwfJ8rmx/CoPHIEd7Ylcw7nMCpP0M8Yo0JLTiF1PF6W4qLoz19XaiR7VRwXgYJgyntcqpp7eNw+gC/d9CyKL9A+f/7UP83oLcw9Kqx/baGajnG/ozk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ApCSoVk/; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d2759f7e-23a5-4d68-b50f-4c510540bcdd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762895371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PWZSjPeTHOwQQ/fMrt+3ARQrsSB/sn9y1Zax5yNuBX4=;
	b=ApCSoVk/a826CZMkyfwKzQ17VO4isZTG0H6VWc/GDizbMn7q8twT5poc+r2k3fIMGrkoZ2
	Z65SBZKzL1IkVSGYJyzEvMo/hWHyJVeqz8kwRn34epuz3GSZyjoUXy4IVBOk56te2c2DTW
	lyhHBoNPeuzbqaAXC/F8BoiH8X/uHg0=
Date: Tue, 11 Nov 2025 16:09:13 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] drm: xlnx: zynqmp_dp: Support DRM_FORMAT_XRGB8888
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
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
 <a8f0de1d-07e8-4e48-8495-9cafa0febcf5@linux.dev>
Content-Language: en-US
In-Reply-To: <a8f0de1d-07e8-4e48-8495-9cafa0febcf5@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/4/25 16:53, Sean Anderson wrote:
> On 6/27/25 10:50, Mike Looijmans wrote:
>> XRGB8888 is the default mode that Xorg will want to use. Add support
>> for this to the Zynqmp DisplayPort driver, so that applications can use
>> 32-bit framebuffers. This solves that the X server would fail to start
>> unless one provided an xorg.conf that sets DefaultDepth to 16.
>> 
>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>> ---
>> 
>>  drivers/gpu/drm/xlnx/zynqmp_disp.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>> 
>> diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c b/drivers/gpu/drm/xlnx/zynqmp_disp.c
>> index 80d1e499a18d..501428437000 100644
>> --- a/drivers/gpu/drm/xlnx/zynqmp_disp.c
>> +++ b/drivers/gpu/drm/xlnx/zynqmp_disp.c
>> @@ -312,6 +312,11 @@ static const struct zynqmp_disp_format avbuf_gfx_fmts[] = {
>>  		.buf_fmt	= ZYNQMP_DISP_AV_BUF_FMT_NL_GFX_RGBA8888,
>>  		.swap		= true,
>>  		.sf		= scaling_factors_888,
>> +	}, {
>> +		.drm_fmt	= DRM_FORMAT_XRGB8888,
>> +		.buf_fmt	= ZYNQMP_DISP_AV_BUF_FMT_NL_GFX_RGBA8888,
>> +		.swap		= true,
>> +		.sf		= scaling_factors_888,
>>  	}, {
>>  		.drm_fmt	= DRM_FORMAT_RGBA8888,
>>  		.buf_fmt	= ZYNQMP_DISP_AV_BUF_FMT_NL_GFX_ABGR8888,
> 
> Tested-by: Sean Anderson <sean.anderson@linux.dev>
> 
> I can confirm that this provides a nice performance boost :)

Actually, I think a better fix would be to make the "video" plane the
primary one. That plane supports XRGB8888 natively, and then the
graphics plane can be used as an overlay for e.g. windows or cursors.

--Sean

