Return-Path: <linux-kernel+bounces-859193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 765C4BECFBE
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 14:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6E4B94EAF4F
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 12:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB11827A900;
	Sat, 18 Oct 2025 12:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YwBsGlES"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6670E1E511
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 12:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760791601; cv=none; b=Reh4YEzO7kJk+m01VCDAzSQ8Er6tiT7kJ5voAtvV7C8IDwzhxLUpTpLegzkC7BGxZ+sqYjWdPdkQNEDbMczjOm3M8CUHTBhtCSsMwyZQyF2csC8/qmHwk8FI+MWmy76lZZcYJpkfiP8/wZLayz8IakLHXivru44Zzvqpxp1g+UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760791601; c=relaxed/simple;
	bh=9SHJU52Ukj3vS5n8j3mN94TcvuvNdEkAm/urmcspB2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kJJGCIYdRCXUp9wAA1FG0obFKAMi+8HDrjuJFJauxGtujba42wIWmLk0jj+ta+207goxRcz/RmFXCiDwPe4TGivYUy49xraPig4Sl/Zwa6EQuuH10WUDw62rWXMWAGrphk5XUuTkdhQMTQ2r7Ff+hVHsLK5w4tswMsMlWJHqtr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YwBsGlES; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-471076f819bso22928445e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 05:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760791598; x=1761396398; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=InrI7Nfp1NYd+ZIKEO2xbQ29jEdwIZK3y4xYlXvgeH0=;
        b=YwBsGlESyjTuOFhel+miJnIrWbHolRQxbcM6fMHgOJHd307ke5mNlMILPkpEdK/+41
         0+1HxyM4zvcvAI3FhrKJrqaEKry2PgbS7Kj1HQaaMMzPuv1744FFhsV0veG7xabBsH0k
         dqKeCjGbGno91ZHJTFmBVq3ckfyU83cfEU39cV+gWftAl4Misxz9STRgnCVhpVS/Lxn0
         q3Y27GiZy10Ojxl3o8Tp8A96AQ2OXTOLGjvRN2hBHEjJUPkM3dOpdooLyE3zSCZzKimn
         9r5pXDJqnzTfg1tmw21RCkXmbArPPEUPOHHxLl+2c8YImAYfmBMrj1n9bvLn2d9nvBai
         NOvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760791598; x=1761396398;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=InrI7Nfp1NYd+ZIKEO2xbQ29jEdwIZK3y4xYlXvgeH0=;
        b=r4+qUJ5TQH/z6pjiL7fjsGZ083pXpCpS/ptgUYdPpVomHtZsATv7Hpiyp3+NM2RTWg
         LfrBZN376lYozJ0LZQ7ZNxs2secIAaII2g3dMukVpQWAh9+lD8buU7+Rdbng9phRwH7j
         1vcZ2UpraEAIm1itqfYl6EAp18Fh+bm1pRBHTatbgvPpQo7zvH42z7h/9em/Lyi8r2+E
         8hbkKUpQ3SPNuoAk8Vgzp2rtmdFaXs4vGBOS8ZE5FUJLtpwV/y4w0dlVcYSlXeiySZcF
         dQmgWOSmkfF2QdyOJxJSVgUWeV3TRWesMxoqZycxEakMhozc8ndRbFfhtbWJSjG2IhWc
         +c+w==
X-Forwarded-Encrypted: i=1; AJvYcCWudKftRxOqFwVBBVl1WXxJ9yMiVZaO6hJWRuh8Au0RN75ANSPTrTD9DA7mUL2Vl9AxmBObOWvOcXpHAT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKYoZNKifHEKBKpYPpM6CLctzyaoA1YQkRRqFDIvZ+oA8akXCK
	uigxUmcMoK/c4XCGdqcDrdR5DhJ5CraGsirO9buyMzs8fc8w4fDhh9Wg
X-Gm-Gg: ASbGncvOiKQEJ7D8NUdjzXqDlSQ9YDf8NVp0zOTJmAlInMCi06UekJdnVYr4HCECerf
	5j6dfwOY4SmtZ3SoNzC8rvFmHM0QTf6Jm4Jhrx+/UzhPHXaXUeH4f6ctsAKyWy9NicO0xphItDH
	INOWquNU6ybQ07cZ2HsWsuwpzBZFptQSr9eTlJIGqfcg56N+A5vJiDu1aaE2JndNw/829hrRyuM
	8ZwG3wzi1Am+HdAsC7JB9yL9qwwPHWQsqxQsvT0RSrV59U8VvC+CeAv529radrF5wD82O4cmvAe
	PnFa5fLPy7oPXYUzK4jxWCboc/O1T+s5sYvBuAZueVKKxTnKo2SPYt0tMYNcI3FRTJsnEoEjW1m
	1SNB3hasbXEbcEUCrYYAOtoqbVxMzF7sKXKsE7979fARiX/lxcnywJhJof/oNVFlOcx+m95e3Nn
	wwMgs5Nhwzxa05H3HXMcf+48Tk0xlNhaWdE4MlQqCGnxU/QP4jZBcYnPGWsSY=
X-Google-Smtp-Source: AGHT+IENxpeW+lY77m0+5KTzVSjMas6cNGY59trgXHqIQUrSp7xcHqXWQxlyCxX/qR2myN3RoqtoKA==
X-Received: by 2002:a05:600c:3581:b0:45d:d5df:ab2d with SMTP id 5b1f17b1804b1-4711790bf23mr51028465e9.26.1760791597612;
        Sat, 18 Oct 2025 05:46:37 -0700 (PDT)
Received: from ?IPV6:2001:861:3385:e20:2acd:89a8:83d9:4be5? ([2001:861:3385:e20:2acd:89a8:83d9:4be5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00ce3e2sm4754007f8f.47.2025.10.18.05.46.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Oct 2025 05:46:36 -0700 (PDT)
Message-ID: <ba6e494d-d318-4cf2-8ff0-c29100099dad@gmail.com>
Date: Sat, 18 Oct 2025 14:46:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] drm/bridge: document that adding a bridge is
 mandatory before attach
To: Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Alain Volmat <alain.volmat@foss.st.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20251003-b4-drm-bridge-alloc-add-before-attach-v1-0-92fb40d27704@bootlin.com>
 <20251003-b4-drm-bridge-alloc-add-before-attach-v1-3-92fb40d27704@bootlin.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?Rapha=C3=ABl_Gallais-Pou?= <rgallaispou@gmail.com>
In-Reply-To: <20251003-b4-drm-bridge-alloc-add-before-attach-v1-3-92fb40d27704@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 03/10/2025 à 10:59, Luca Ceresoli a écrit :
> At the moment it's not documented that you need to add a bridge before
> attaching it. Clarify that.
> 
> Suggested-by: Maxime Ripard <mripard@kernel.org>
> Link: https://lore.kernel.org/all/20250709-sophisticated-loon-of-rain-6ccdd8@houat/
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
Hi Luca,

Reviewed-by: Raphael Gallais-Pou <rgallaispou@gmail.com>

Best regards,
Raphaël


