Return-Path: <linux-kernel+bounces-893576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C622C47C14
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DA1304F7433
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B984226AA94;
	Mon, 10 Nov 2025 15:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mRne7PfS"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D79F2236E5
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 15:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762790033; cv=none; b=K+IBCEEf3btq6lV2zpV1jVjgEWjn0HqxIC6dOGzbclMl+nu11yZEcJT+UF8WHD4wVgI1s+TdhOR+P/lb+o3Jn7KJpqib0Jkbva/qpi6orK4nK7yqBrazylOS/+y+0uBjUKmLtSDENpcpiia3WlIMMagCKDsKITknzi1sMwyFS80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762790033; c=relaxed/simple;
	bh=lkBsGazHZtAZpgK8UJxn3IujC+Ee6rWl7RX7ArYAdYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JmVIqbH8/bEVeyw05mW7wur3jwCunk1fdUjjUYobw+fjE7FgR5LZJMhTeMfNZGtlT3vKTaTpyzgD3hqdIjKsNXwHlINtWr73wkNLp9/NLJqKi19JsmRAn6UsJLTcD9qeoNvJmplS4246BZo5SlVPVcVLVmKi5rsShV0aep9e4Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mRne7PfS; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-343806688c5so1469598a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 07:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762790031; x=1763394831; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SjOzrVVqoN3/fu4/RlfN/tt8R12NRcTY3oo2BszH4iI=;
        b=mRne7PfSSBZxN0xC5cN4GWXJPZbYdGyIy21jLjlMbZu86T0uKvwcWWJ/bcYXH1oAzN
         WIPJlr1HBCztMpzA8kiVplPjtMkqHCf9o8u53Kf0aD9cXCCaQreCo/FnHqdvUlFm/Wn+
         soZASBm+8yiB4lhU6IWBUDOtNApmtn1VrFwiklTRXnM+N8A4LRuh8PzhQA2WKMbYV+HH
         3Z/vzWFRclpwj2Ld13GGBDLHddjvXz2RKQLouo7CfUFiltXA9IzVycGipNmds2P7+3H1
         oX7U3cHEo+Jmm/8kwGzcpmvGPHUyaNla6twWTmD6yT9oEjHPvzyXpvsqTYE4FLId/zQZ
         bnWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762790031; x=1763394831;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SjOzrVVqoN3/fu4/RlfN/tt8R12NRcTY3oo2BszH4iI=;
        b=wAcCo6jaosCkAKQviOh4d0m8S3aUIOS51WuAeKB1eMubsb8rh44EKkyMP693LiwsQj
         XRdXm/BFSVYlb7Z298AB/oSEpd5nfwKwUlM2+Yxpl+4i7qKUPmusadz+pBI7dArvHTkB
         C57IAOuvyq1SPEaivzhTVJLyg7tza2g7Newx++A80WzFMg5V05AMtU8cUkjMcpXzZ2Sh
         JgC0op/QFutvuWKdXXR4E6OhRrOxtvovD9aDo8xLzTpu9DSxWqYLWeQFBBRVZb/vHIYK
         DsnbJZ3araTFM3Vu6hdwoTG+k5FvuHdFRBzpsCj73j5Y6o6yB+yqwiH7WyK8pRK8XkCJ
         cL+A==
X-Forwarded-Encrypted: i=1; AJvYcCWeaBNUWtMiEB7sbbxymjEyfPhBQSEiajFNOXQhuUCNCEEm0zrQQqxkRxbmZUCCv5jlFNVOioMVJ1+9d1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMmd/udVMQ5aAvEhvWc6K7VZwCISHU1+5DnydJhlMfkUBS5P7b
	UYNJHlkQBTb4GCMp4ibZFaw/CS31/wxk0tuheJlfrM6NnDaBOQcf6GZK+BuEyoeg6YmT0Ty/z3q
	fnssBksB2+VsJcwMrim5TCisifRAveyY=
X-Gm-Gg: ASbGncvW2ftSyhZc7UBTi08nw8/BBSaEP1rKtd8UftTFcZcVwboyRetnP66M15mzctf
	farnnlqre5DWDtCWloIl2HEsFSP2m4S8oeVUbmHuQ/GjYVOxrnjKYs//l/r3HMCS8SKnaGP57HW
	boJyI2lvj0+k0A3iTIWQTNvcxG9f7RYXVJ2dR7ASSru6tcrDysGM9vodPAvHgenW1QrHmsdfZLV
	wS2iXR3/jghZKopJ5eFFqBkKMSigvbkCZs7dNAN1scqM6nlz6jZnfabsCVLPRF5yakGcg==
X-Google-Smtp-Source: AGHT+IHwofBfxv3uf6UTJA+nG/6elxBUHAGiuiZgIJf8LSdifcxj/UCi0qF/Jl1IG2tMfvgt6HThdUni33rI90wW01k=
X-Received: by 2002:a17:90a:e18b:b0:340:bb5c:7dd7 with SMTP id
 98e67ed59e1d1-3436cb7ad33mr9591676a91.5.1762790031464; Mon, 10 Nov 2025
 07:53:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250630202703.13844-1-gert.wollny@collabora.com>
 <20251110144625.18653-1-gert.wollny@collabora.com> <20251110144625.18653-3-gert.wollny@collabora.com>
In-Reply-To: <20251110144625.18653-3-gert.wollny@collabora.com>
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Mon, 10 Nov 2025 16:53:39 +0100
X-Gm-Features: AWmQ_bnENdxpeUHNoYb1iPcyeu_sjQjTbH3dxEXcrczuKmzcLLDFO1caKW3SHpY
Message-ID: <CAH9NwWfuBF=fZMxU2QnGVWkeXqk-y8NiATjhixY-JS6xxmc-oQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] drm/etnaviv: move some functions to a header to be
 able to use them externally
To: gert.wollny@collabora.com
Cc: Lucas Stach <l.stach@pengutronix.de>, Russell King <linux+etnaviv@armlinux.org.uk>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi, thanks for the patch.

>
> From: Gert Wollny <gert.wollny@collabora.com>
>
> v2: Add license info to header
>
> Signed-off-by: Gert Wollny <gert.wollny@collabora.com>
> ---
>  drivers/gpu/drm/etnaviv/etnaviv_buffer.c | 71 +------------------
>  drivers/gpu/drm/etnaviv/etnaviv_buffer.h | 86 ++++++++++++++++++++++++
>  2 files changed, 87 insertions(+), 70 deletions(-)
>  create mode 100644 drivers/gpu/drm/etnaviv/etnaviv_buffer.h
>
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_buffer.c b/drivers/gpu/drm/etnaviv/etnaviv_buffer.c
> index d4f1307d574f..5be9978e34d9 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_buffer.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_buffer.c
> @@ -10,6 +10,7 @@
>  #include "etnaviv_gpu.h"
>  #include "etnaviv_gem.h"
>  #include "etnaviv_mmu.h"
> +#include "etnaviv_buffer.h"
>
>  #include "common.xml.h"
>  #include "state.xml.h"
> @@ -18,76 +19,6 @@
>  #include "state_3d.xml.h"
>  #include "cmdstream.xml.h"
>
> -/*
> - * Command Buffer helper:
> - */
> -
> -
> -static inline void OUT(struct etnaviv_cmdbuf *buffer, u32 data)
> -{
> -       u32 *vaddr = (u32 *)buffer->vaddr;
> -
> -       BUG_ON(buffer->user_size >= buffer->size);
> -
> -       vaddr[buffer->user_size / 4] = data;
> -       buffer->user_size += 4;
> -}
> -
> -static inline void CMD_LOAD_STATE(struct etnaviv_cmdbuf *buffer,
> -       u32 reg, u32 value)
> -{
> -       u32 index = reg >> VIV_FE_LOAD_STATE_HEADER_OFFSET__SHR;
> -
> -       buffer->user_size = ALIGN(buffer->user_size, 8);
> -
> -       /* write a register via cmd stream */
> -       OUT(buffer, VIV_FE_LOAD_STATE_HEADER_OP_LOAD_STATE |
> -                   VIV_FE_LOAD_STATE_HEADER_COUNT(1) |
> -                   VIV_FE_LOAD_STATE_HEADER_OFFSET(index));
> -       OUT(buffer, value);
> -}
> -
> -static inline void CMD_END(struct etnaviv_cmdbuf *buffer)
> -{
> -       buffer->user_size = ALIGN(buffer->user_size, 8);
> -
> -       OUT(buffer, VIV_FE_END_HEADER_OP_END);
> -}
> -
> -static inline void CMD_WAIT(struct etnaviv_cmdbuf *buffer,
> -                           unsigned int waitcycles)
> -{
> -       buffer->user_size = ALIGN(buffer->user_size, 8);
> -
> -       OUT(buffer, VIV_FE_WAIT_HEADER_OP_WAIT | waitcycles);
> -}
> -
> -static inline void CMD_LINK(struct etnaviv_cmdbuf *buffer,
> -       u16 prefetch, u32 address)
> -{
> -       buffer->user_size = ALIGN(buffer->user_size, 8);
> -
> -       OUT(buffer, VIV_FE_LINK_HEADER_OP_LINK |
> -                   VIV_FE_LINK_HEADER_PREFETCH(prefetch));
> -       OUT(buffer, address);
> -}
> -
> -static inline void CMD_STALL(struct etnaviv_cmdbuf *buffer,
> -       u32 from, u32 to)
> -{
> -       buffer->user_size = ALIGN(buffer->user_size, 8);
> -
> -       OUT(buffer, VIV_FE_STALL_HEADER_OP_STALL);
> -       OUT(buffer, VIV_FE_STALL_TOKEN_FROM(from) | VIV_FE_STALL_TOKEN_TO(to));
> -}
> -
> -static inline void CMD_SEM(struct etnaviv_cmdbuf *buffer, u32 from, u32 to)
> -{
> -       CMD_LOAD_STATE(buffer, VIVS_GL_SEMAPHORE_TOKEN,
> -                      VIVS_GL_SEMAPHORE_TOKEN_FROM(from) |
> -                      VIVS_GL_SEMAPHORE_TOKEN_TO(to));
> -}
> -
>  static void etnaviv_cmd_select_pipe(struct etnaviv_gpu *gpu,
>         struct etnaviv_cmdbuf *buffer, u8 pipe)
>  {
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_buffer.h b/drivers/gpu/drm/etnaviv/etnaviv_buffer.h
> new file mode 100644
> index 000000000000..ae1ba1db6c8a
> --- /dev/null
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_buffer.h
> @@ -0,0 +1,86 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2014-2025 Etnaviv Project
> + */
> +
> +#ifndef etnaviv_buffer_h
> +#define etnaviv_buffer_h

#ifndef __ETNAVIV_BUFFER_H__
#define __ETNAVIV_BUFFER_H__

> +
> +#include "etnaviv_cmdbuf.h"
> +#include "etnaviv_gpu.h"
I don't think we need this include."

> +#include "etnaviv_gem.h"
I don't think we need this include."

> +#include "etnaviv_mmu.h"
I don't think we need this include."

> +
> +#include "common.xml.h"
> +#include "linux/printk.h"
I don't think we need this include."

> +#include "state.xml.h"
> +#include "state_blt.xml.h"
I don't think we need this include."

> +#include "state_hi.xml.h"
I don't think we need this include."

> +#include "state_3d.xml.h"
I don't think we need this include."

> +#include "cmdstream.xml.h"
> +
> +static inline void OUT(struct etnaviv_cmdbuf *buffer, u32 data)
> +{
> +       u32 *vaddr = (u32 *)buffer->vaddr;
> +
> +       BUG_ON(buffer->user_size >= buffer->size);
> +
> +       vaddr[buffer->user_size / 4] = data;
> +       buffer->user_size += 4;
> +}
> +
> +static inline void CMD_LOAD_STATE(struct etnaviv_cmdbuf *buffer, u32 reg,
> +                                 u32 value)
> +{
> +       u32 index = reg >> VIV_FE_LOAD_STATE_HEADER_OFFSET__SHR;
> +
> +       buffer->user_size = ALIGN(buffer->user_size, 8);
> +
> +       /* write a register via cmd stream */
> +       OUT(buffer, VIV_FE_LOAD_STATE_HEADER_OP_LOAD_STATE |
> +                           VIV_FE_LOAD_STATE_HEADER_COUNT(1) |
> +                           VIV_FE_LOAD_STATE_HEADER_OFFSET(index));
> +       OUT(buffer, value);
> +}
> +
> +static inline void CMD_END(struct etnaviv_cmdbuf *buffer)
> +{
> +       buffer->user_size = ALIGN(buffer->user_size, 8);
> +
> +       OUT(buffer, VIV_FE_END_HEADER_OP_END);
> +}
> +
> +static inline void CMD_WAIT(struct etnaviv_cmdbuf *buffer,
> +                           unsigned int waitcycles)
> +{
> +       buffer->user_size = ALIGN(buffer->user_size, 8);
> +
> +       OUT(buffer, VIV_FE_WAIT_HEADER_OP_WAIT | waitcycles);
> +}
> +
> +static inline void CMD_LINK(struct etnaviv_cmdbuf *buffer, u16 prefetch,
> +                           u32 address)
> +{
> +       buffer->user_size = ALIGN(buffer->user_size, 8);
> +
> +       OUT(buffer,
> +           VIV_FE_LINK_HEADER_OP_LINK | VIV_FE_LINK_HEADER_PREFETCH(prefetch));
> +       OUT(buffer, address);
> +}
> +
> +static inline void CMD_STALL(struct etnaviv_cmdbuf *buffer, u32 from, u32 to)
> +{
> +       buffer->user_size = ALIGN(buffer->user_size, 8);
> +
> +       OUT(buffer, VIV_FE_STALL_HEADER_OP_STALL);
> +       OUT(buffer, VIV_FE_STALL_TOKEN_FROM(from) | VIV_FE_STALL_TOKEN_TO(to));
> +}
> +
> +static inline void CMD_SEM(struct etnaviv_cmdbuf *buffer, u32 from, u32 to)
> +{
> +       CMD_LOAD_STATE(buffer, VIVS_GL_SEMAPHORE_TOKEN,
> +                      VIVS_GL_SEMAPHORE_TOKEN_FROM(from) |
> +                              VIVS_GL_SEMAPHORE_TOKEN_TO(to));
> +}
> +
> +#endif
> --
> 2.51.0
>

-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy

