Return-Path: <linux-kernel+bounces-859196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6036EBECFD3
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 14:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 159595E6661
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 12:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FEB27A130;
	Sat, 18 Oct 2025 12:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLM/SFdR"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520882556E
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 12:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760791772; cv=none; b=PFMXiAtu32x3LR+3VZUraLMbSr7nBFENXfjX8flgyn+PmKg1c9mBxCUeRZhZHQrTnW9yK92VZVLNw1U7EIzKBe4bFdwoI5ukpusb7bs4zWfkF27Xf3iSi07cr/RAgUuloOagzKVs5OkoSM5uwdJxgN8l6TQVwMTVO8rjCJwXttI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760791772; c=relaxed/simple;
	bh=xl0J6jTaozT/dHBO6U9Z3rRlo1/kgpuvB4Ao9hHS2MQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Na7PSKI9AFNMH0LGJiS6wHCjc6JUlkoYRcaVBS4bZMPI/Ku60smZyOArYc3lwA3yLohhXUGUPa3OkdUKK+0AZ6O4oL1AhRhKpIrk+SmiwtVa8bjpACbA2QwYNpAFyPImmruXiRXlO5NiksDYUIu2Op0Ro0puNhnkDmKcKyJXFgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eLM/SFdR; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-471b80b994bso5125245e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 05:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760791769; x=1761396569; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BVsHNru5NLHi/zbAVLbblzv/GOgnRaHcf6YnsrPJO/0=;
        b=eLM/SFdRxgRnyTzXidU06FU1pOcKNsCJKGIdfcCzwB15kjsWIDgFJFzOIiS2yKSBu7
         a6Ed7tJKDir5XuLeeXiqSxSjAhfor3DE42rfpH0vZ946jiWZxEdw9Ae7fTQi3Kk/JOLN
         auRRex8s+jRD6lH/+TXfnFjcT6V6JAyI/LI/1rjo83QBQLvAnt/iD9kAopOiFEpZg3zK
         NzAss371dl206Af7waTRGBdP/zM9NIFG8UuTzqhkjGO+BSh7zqkdEQkXciptRZRIi4sn
         Vwg202iist5Hp7tTrRP2mb4ip1U/ttZEUKPpGznhg1f++SqPakXTmgzSG+OcmY3KBGbb
         HthA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760791769; x=1761396569;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BVsHNru5NLHi/zbAVLbblzv/GOgnRaHcf6YnsrPJO/0=;
        b=vNneJP8NUYCmquM2W/Fi76Ti6DGIqfkvTV6LnxaWriH51QlopZBJQijMRUPrTvhjmt
         suq4j7hPpI/mY2f/d/KXjuE9Y65wJuSrAN75PcKQSOuuLAs6m0mN6vfQoMeRBCaIGdIv
         wFceN6VQaqjR5lsvrIH/e5sEc6dp0Vb8dFfU42sy6gd7yDEZplshVnKA95XaScmDxJz8
         Lu2ZaAMH69tQi1D9KUEu+lwBTW3WZOpOe6xgWCMAK8oJQ4xSP3sCSkv06x3aXCJmPbj6
         4F5VVfEHuwutlPnOr5r5ZwBIi1MUlo2btaRUezLcUzCDx5WTOKMz5lpLuXtEUpzxpe87
         B8mQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3f6bMHiCaurNni8CQ3pFXg4NK687ihuPlaAUO2Zun52vTMtt3pF7SVMsLcafzESP9HzU3tRdLlSblHfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpnQHZntXW8Sm/4TrwbbKZiH24qBPnTVFRuivYNx0Y5MoTFI/U
	zriKZM6Y/v8mFShWakGMgG/szymHJhlwfGMAwvxHgTU/SEhjaUKVWgqi
X-Gm-Gg: ASbGncs2iEHVVk7CH886z6qGqfg3dxiX8GvUHy8d7bCjLpvkZY6DVXbYw4/5JwD+ekU
	akXcHq5TEu9IezAJ6m+iYlNPGD9nKsBtfzTbJvyVPYkPpdEKUExcm9HWcp1SpfRlxtlHyI9GZmH
	LiuZwQ+3FHSErIeUsgycSIPeRxwmV8VCC1Bp/zaAvlrXJsfqd/nJtIyA9QJc7kIcP7UYbzFx9gI
	GLZ1V+8RmKrcs0AHYMSkLR4xkevSbRkqovU5mycHAF3Fr5qjtz1yK31HmBDK0T4+/Xf5lEcyJxw
	CfqsZPuXlzv+QGS/WI9vCJjNBFWcbTdRwz8G9bviUEv1E3FFfAHHnXXHgy1AonepMM9AtoDNY/O
	mRrlYWpbhSxjL1/eRSGO2kVAax2TN8l0W3TNrZCqY9nCfmfhgx1DnPdi1kqLSXOEjTo8c0KlcEL
	10kGmEfue20N8APuepJo0hwkVDj9G9RTKyTUWSeKRpxh77j0teoShj4LR9Tug=
X-Google-Smtp-Source: AGHT+IHLLrG5j4m2n4PoPbuVmHZ69tvqUkFHujUfl3v7biPGdGGV8XmptNv3G0R/8+E6s3OfCTAULQ==
X-Received: by 2002:a05:600c:5026:b0:470:bcc4:b07c with SMTP id 5b1f17b1804b1-47117925d38mr58012555e9.37.1760791768501;
        Sat, 18 Oct 2025 05:49:28 -0700 (PDT)
Received: from ?IPV6:2001:861:3385:e20:2acd:89a8:83d9:4be5? ([2001:861:3385:e20:2acd:89a8:83d9:4be5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4710ca4931csm75020945e9.0.2025.10.18.05.49.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Oct 2025 05:49:28 -0700 (PDT)
Message-ID: <f3904ae1-bf1b-455f-b5ba-5d625b76222f@gmail.com>
Date: Sat, 18 Oct 2025 14:49:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] drm/bridge: enforce drm_bridge_add() before
 drm_bridge_attach()
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
Content-Language: en-US, fr
From: =?UTF-8?Q?Rapha=C3=ABl_Gallais-Pou?= <rgallaispou@gmail.com>
In-Reply-To: <20251003-b4-drm-bridge-alloc-add-before-attach-v1-0-92fb40d27704@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 03/10/2025 à 10:59, Luca Ceresoli a écrit :
> This small series enforces that DRM bridges must be added before they are
> attached as discussed in [1].
> 
> This is part of the work towards removal of bridges from a still existing
> DRM pipeline without use-after-free. The grand plan was discussed in [0].
> Here's the work breakdown (➜ marks the current series):
> 
>   1. ➜ add refcounting to DRM bridges (struct drm_bridge)
>      (based on devm_drm_bridge_alloc() [0])
>      A. ✔ add new alloc API and refcounting (v6.16)
>      B. ✔ convert all bridge drivers to new API (v6.17)
>      C. ✔ kunit tests (v6.17)
>      D. ✔ add get/put to drm_bridge_add/remove() + attach/detach()
>           and warn on old allocation pattern (v6.17)
>      E. ➜ add get/put on drm_bridge accessors
>         1. ✔ drm_bridge_chain_get_first_bridge() + add a cleanup action
>              (drm-misc-next)
>         2. ✔ drm_bridge_get_prev_bridge() (drm-misc-next)
>         3. ✔ drm_bridge_get_next_bridge() (drm-misc-next)
>         4. ✔ drm_for_each_bridge_in_chain() (drm-misc-next)
>         5. ✔ drm_bridge_connector_init (drm-misc-next)
>         6. … protect encoder bridge chain with a mutex
>         7. of_drm_find_bridge
>         8. drm_of_find_panel_or_bridge, *_of_get_bridge
>         9. ➜ enforce drm_bridge_add before drm_bridge_attach
>      F. ✔ debugfs improvements
>         1. ✔ add top-level 'bridges' file (v6.16)
>         2. ✔ show refcount and list removed bridges (drm-misc-next)
>   2. … handle gracefully atomic updates during bridge removal
>   3. … DSI host-device driver interaction
>   4. ✔ removing the need for the "always-disconnected" connector
>   5. finish the hotplug bridge work, moving code to the core and potentially
>      removing the hotplug-bridge itself (this needs to be clarified as
>      points 1-3 are developed)
> 
> Series layout:
>   - patches 1-2: add missing drm_bridge_add() to the 2 drivers known for not
>                  calling it
>   - patch 3: document that drm_bridge_add() is required before attach
>   - patch 4: add a warning in drm_bridge_attach() is drm_bridge_add() was
>              not called
> 
> The added warning might reveal more non-compliant drivers, in that case
> they will be fixed as they are found.
> 
> [0] https://lore.kernel.org/lkml/20250206-hotplug-drm-bridge-v6-0-9d6f2c9c3058@bootlin.com/#t
> [1] https://lore.kernel.org/all/20250709-sophisticated-loon-of-rain-6ccdd8@houat/
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
> Luca Ceresoli (4):
>        drm/sti: hda: add bridge before attaching
>        drm/sti: hdmi: add bridge before attaching
>        drm/bridge: document that adding a bridge is mandatory before attach
>        drm/bridge: add warning for bridges attached without being added
> 
>   drivers/gpu/drm/drm_bridge.c   | 6 ++++++
>   drivers/gpu/drm/sti/sti_hda.c  | 5 +++++
>   drivers/gpu/drm/sti/sti_hdmi.c | 2 ++
>   3 files changed, 13 insertions(+)
> ---
> base-commit: 0f2efbe6d8305b91c9b2c92ebaf8c24a614bc305
> change-id: 20251003-b4-drm-bridge-alloc-add-before-attach-ef312c0b8a8c
> 

If drm-misc maintainers agree I can merge the whole series.

Regards,
Raphaël> Best regards,


