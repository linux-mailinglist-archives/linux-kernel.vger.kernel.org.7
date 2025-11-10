Return-Path: <linux-kernel+bounces-893638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B34D2C47F44
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8D3554F3638
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE4128136C;
	Mon, 10 Nov 2025 16:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q15FDMmE"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCB527A442
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 16:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762792084; cv=none; b=i3UE8LGkNchLSUpo/xK3I2l2ykX6NinmbCQHwzLbTMQ+ITCN6xrFoWy9thI/QszVvxSU+as3Sz8F5EC1lqnUxiB8rAKIXY8JdsaAFbmjX/EwK9xJKi+rSgj6WbyswHR3XXFF2bx4+c5n/6TXem0IAwRuVSmroFow05aiLqRfKzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762792084; c=relaxed/simple;
	bh=tBN9AhtVsBHbwNizdKtj/2J8yuNXmt4B3VF2b9obKoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=amx/+HTtpcBfIKJuJkiPRyZ9Y5YK32+7TfGdO1penb3VvdShvPeVvvf9HREjATX1VsgkGJau+2TOKXuKyeCLqh9i+/NowUA9eRCpE+PdsRdYL+O1BDWpn5zj3Miz/WHfMbWHt7GojgJOSmREkWTDRlCor7b+q+Vo0k/CT+Bg6QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q15FDMmE; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b9ab6cdf64bso1152276a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762792082; x=1763396882; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Bdh2/fuv59j6lPYvKx2wt0F4julUgDFPU3TDfHRXW0c=;
        b=Q15FDMmEKfJDY+XUWN9W2jnDMBpbGRL7y8WifnkVZzv4ZhvF2O6Cn/4+gw2IsDsmBA
         xpXogA32JkEj9kEaMJuzgnvFsKdT+6XhO3WOb3YaRxrYQveLPPRN1SRraUVUFoEIGcIP
         3YdIQVPyJIEYyyCe2QkVHwsBaYAPRLlPtCygX2mLVdaRRByg9OIktT2Ap5wPc5SZ8/Y0
         Ghh613OwFB7Eh1KsgTRonI+Q1ZZLzhKMTv1XcDdUQ2iDsYyARdpHPMPryC3llXVy82R6
         YiLDRyuKcQ/sd1RZdESs97XX7DAfOTVZ5IImul8LXgoyfu2B78ghHEeFzpD2Kt2g7jy4
         /Idg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762792082; x=1763396882;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bdh2/fuv59j6lPYvKx2wt0F4julUgDFPU3TDfHRXW0c=;
        b=AvevXFxQrmTHdyQOC3AEd6GnOQY2Jp3blWoEk9UlVaECo+QCvy670TgR2Asq0yQJ4l
         Hi3DlzhZwlWm1Ap/pILnu5vIRbKaiFQc2QiEXczrEG1YFHlDfyKAmMYgoLVtfHUxamn8
         MVY8hsSjfIgn+430dgzh/oQtekNWHT4diEXo9AT5cIuck9rmM/HKmX8bVAWS1D//ob3g
         fwsV0YfmvQCxrsWYvOluWyRbzlNXax7e4Acq65fc9o/ymisIuLoGVRaXDI3llpx75hlL
         OEkfvSNYc+zfDwCUUWjMlGZnutjjobY17T7PG54AdBOETfIW2RzraJ6dO0Z2OM1Y3qTK
         Mpgg==
X-Forwarded-Encrypted: i=1; AJvYcCUwe9VjPIqjEyNshQN0nsoENb2vca8Uxs5OBYKxooTJ0xj4qQGUTsaUGOWDojLn/fyXNixY05r5Sjg4WG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdJYhxG1pnF2tTP5T2AATXAc+Uv5LlF8FS0/dgpN70aS8aDPvq
	HK9g8jcU8b9dG3KFaBlpAdlMFnxk2JHpboe6GIeVIXkM92TKdy7CNSWX
X-Gm-Gg: ASbGncukmrVaqGDW8f7JtvzpZCSQDl0MfSCflfAY8b3s646oSTRE5pJ2QsGwPqRvFiI
	kBsgOv4Uzm0F6uN4DgP8gNCju/Kug/J3AI/M19dpd4O4k5JZ5c4e1NFtyi4H+dBgy6IOgZ54Kzq
	uIcocT6DqFxubqJznvojQ+dQCAv0Fk6l8epcBOQHYHo5qe2Vld+YrhUE5qcztLvX4pJgtRnjHuK
	nWFeZ69LDIVA72IrSyycZHy4KGVVB2NdQ83Ok+UmqRR32iSN1NHDVx9o2Va8nI6h0muXl8lLeZd
	Q+aWJHFsafx44J7Lgbi+Bsf5K4tviCBpn7oiIVIdZegdm38Px9+7hGDVr9MXiKRwKj223WcW1qV
	4RIXsZ2WDIfqg7e8FsxswGHxa0/VKeqZsCI8oJ7aEgxazHa2IMO/G3McMuCEhiX6Z4nlIghtMjD
	ZGNm1AGMKekDMkzzbahu/aOV0O/HIJoJQv1Q4WOZ9BOSEa
X-Google-Smtp-Source: AGHT+IEEdWC+UxJFbOnFiE6h4StiPlXpNa8D2CyYAuq/ZX+Q7gi7EUdCd8OvPyYrowcVZcB6UHmGnQ==
X-Received: by 2002:a17:903:a90:b0:294:fc13:7e8c with SMTP id d9443c01a7336-297e1dcecc0mr144078575ad.13.1762792081714;
        Mon, 10 Nov 2025 08:28:01 -0800 (PST)
Received: from joaog-nb.corp.toradex.com ([67.159.246.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651045bf0sm152026805ad.48.2025.11.10.08.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 08:28:00 -0800 (PST)
Date: Mon, 10 Nov 2025 13:27:52 -0300
From: 
	=?utf-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Parth Pancholi <parth.pancholi@toradex.com>, Francesco Dolcini <francesco.dolcini@toradex.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH 0/7] drm/bridge: tc358768: Long command support
Message-ID: <bskxfzp63qzkeydne6qianvjbfso2lssjloaw4rkogub4zuvb6@xjxpbba5pbox>
References: <20251021-tc358768-v1-0-d590dc6a1a0c@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251021-tc358768-v1-0-d590dc6a1a0c@ideasonboard.com>

Hi Tomi,

On Tue, Oct 21, 2025 at 04:22:56PM +0300, Tomi Valkeinen wrote:
> This series makes some small improvements to the tc358768 driver, and
> then adds support for long commands, commands that have more than 8
> bytes of payload.
> 
> This has been tested on Toradex Verdin AM62 board, with a ST7703 based
> DSI panel which requires initial configuration using commands that have
> 8+ bytes.
> 

Tested-by: João Paulo Gonçalves <joao.goncalves@toradex.com> # Toradex Verdin AM62

Best Regards,
João Paulo Gonçalves

