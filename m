Return-Path: <linux-kernel+bounces-881454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AF4C283D4
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 18:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1C13D4E61DB
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 17:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180652F7479;
	Sat,  1 Nov 2025 17:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3+jusDp"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33CC296BC2
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 17:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762018028; cv=none; b=MR5t9E9b0FuGd1/N+/AvQWEdquQayz+r/4D6q0WtK/oVx7tfAoCh8KUt4bjIGonlcgMFbPIkoFevfpjLoLgDtfZAYW+nlCJv9FCovuI0S8pZor2ZjhZXK5c/tq5QyGIh+wUdRfI0w+xXxOFxi8rEkcUfDtNh/s7AVeSR4KUQBZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762018028; c=relaxed/simple;
	bh=s4/TiKaj17Yu18xCMU1SBAKYBuHNi0409rT9tWoIuec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MgpQB1BLvTf07wW1w5JlpQ8m/5E91SdKPH36QcZKnLmes4F3oBCEEb0J1uAmDwUEf4s91uaGl7DGZPMgSOnoNYPJNpG5wepneZtMK3z+WsA1P5SKcEhbFeJgagKsjM2kN4jNkWDTKXimP92sBch8eKbox9oiYIX60D65EWz7F9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I3+jusDp; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-475d9de970eso21703035e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 10:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762018024; x=1762622824; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FbWnJy2qvToz3lRO6LsUfQP9kSkNdSH0CV+AqxPKYkU=;
        b=I3+jusDpVWJx1L9LCAZaO/L1Pcay7UWyz4HuxI0n2ck4a5eTK7ujnupFb8nyxrcnZS
         yw0pQdouPMRntcjcRZ/PbZru3/fYPjKHtvNltvCfMWdtl1+bTYIdOxZdGT9+i/AbMh5T
         py9Lpz5tPVBb0biAm8Mg2gP/fM7HwzcR0RWFzgbapZ0rk15ONmf5EeFrVwyNrs++CIAY
         qtn3y6WAgrE0KPGLksrKtGdU4+mww+SJ4E94qikDX9Uv1BAxVF2ZEnteSg47QntyD6YD
         CezIIHDh4avVXk/B9uLVmcutVDzZQdBzSvLuWHtfRgBtlRiy9nMnG8BQq5yoFwzPfdOF
         Uw8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762018024; x=1762622824;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FbWnJy2qvToz3lRO6LsUfQP9kSkNdSH0CV+AqxPKYkU=;
        b=HmM+xDdvXJNCyr8DhWzLKlte8edCRzLv7kXZJQEVgLFZlQDbVndr7VLP4b3AoC3U+p
         H976z+jPagvIjkjLHmP1j2+Yu23Oq3EwJLRE/YkS6v2VZ2Dg3s/22OJws7qTirAMOWTZ
         Wdg1MHveMvkRavBoLibZWRrPMiuE0Usl28ThtnknmfCa9WHqRNhaEejPQYCzreF1WAOM
         A3PR0PZK34hTjKBvpqaG9WDO8q6ISAoOtHUHyVCIlG/HfTasAmUikI1zD5UXif7PYFYt
         LG33fdgL9KJhdK/V3IW2nVfZ7VoXXazKPvHTZwMAgw4qlY3mrtONmQA2aCBNTaRotO/3
         NcWg==
X-Forwarded-Encrypted: i=1; AJvYcCXQbuIhFdGWG7OcK9Kp9EL3oUcd2vRShtrRngbmkQyCbNcjJpNkoG4jjNC6BYiWkCXhZFueYDvQ5leGePo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgn3mrw/WL83I3Z63N/vUJ5A1v7G0eiofwpW3ZmmE5rSstD8g4
	JvEjBqWl0ajOcTeInF5LsG/ryep5zcUvC+ojLygjVPZ+fT7SuDmF6mr1
X-Gm-Gg: ASbGnctt4ZwPKPmaDBm4qKNKdVfh/bo0rm9FCeRzehE0HN0acFEjnFZJhgnG6VzAzww
	cabDzr1w0V/qyaRiFlqptkc2taCpRossNNY+45s41OQT6WLoHGLLfZHU2ggrxdt+BSYdPjgXL/n
	RvCj+SCd+nkKc1OJ8NwlFN4me3RV7q3/CIv63QXodN4SJXVvi9DyJjxZ3lpOifcZraPicYhjQpH
	FelINRbcPwB4B4lQcaEiFtnwMK2FmZy6vFASt5ovPIJQTOqZNarl5t4BcHF3DWqekWMR4sitVQM
	oN+RhWE7F1M+e6MCnok45szW8lh3zNhKvmn/xN/YuZTEEVJ61FDZ/IXh3r9Ru3+4TJ3nBr9gaC0
	5NsDbpK4FkmxMS9IZ7C6Zg70GHpZjzQZQb/Ky0gFIieHF3Qk7eO56lnQvQ7YpDlX27+cODFjK6K
	Iing==
X-Google-Smtp-Source: AGHT+IHAkUzD34H7H16cKENp3oNKZcbe/ZJey18IMsChHD+t7D8pxRPIyXbIWzgon9sgvH3z56VsCw==
X-Received: by 2002:a05:600c:468e:b0:475:dd59:d8d8 with SMTP id 5b1f17b1804b1-47730793c2amr81536255e9.8.1762018023809;
        Sat, 01 Nov 2025 10:27:03 -0700 (PDT)
Received: from localhost ([2001:861:3385:e20:f99c:d6cf:27e6:2b03])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772fd280fbsm46567395e9.5.2025.11.01.10.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 10:27:03 -0700 (PDT)
Date: Sat, 1 Nov 2025 18:26:54 +0100
From: =?iso-8859-1?Q?Rapha=EBl?= Gallais-Pou <rgallaispou@gmail.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Alain Volmat <alain.volmat@foss.st.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Hui Pu <Hui.Pu@gehealthcare.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/6] drm/bridge: synopsys: dw-dp: add bridge before
 attaching
Message-ID: <aQZC3gr55C1r2uuX@thinkstation>
References: <20251028-b4-drm-bridge-alloc-add-before-attach-v3-0-bb8611acbbfb@bootlin.com>
 <20251028-b4-drm-bridge-alloc-add-before-attach-v3-6-bb8611acbbfb@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251028-b4-drm-bridge-alloc-add-before-attach-v3-6-bb8611acbbfb@bootlin.com>

Le Tue, Oct 28, 2025 at 11:15:47AM +0100, Luca Ceresoli a écrit :
> DRM bridges should be always added to the global bridge list before being
> attached.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> 
> ---
> 
> This patch was added in v3 after searching for any remaining bridges not
> using drm_bridge_add().
> ---

Hi Luca,

Reviewed-by: Raphael Gallais-Pou <rgallaispou@gmail.com>

Best regards,
Raphaël

