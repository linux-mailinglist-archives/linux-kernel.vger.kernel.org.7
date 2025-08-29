Return-Path: <linux-kernel+bounces-791972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D95B3BEE4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 17:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BA797A6CDA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 15:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470F8322521;
	Fri, 29 Aug 2025 15:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b="nuViS/F7"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A102135CE
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 15:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756480290; cv=none; b=Mi9Sktd9DCJDdvrY7CeJ6eIrWihtEAy5NaX2epnrKT+R0J9QUv7uWcptFkT+4oS8y/EF2ZApmB1qaxGjS4XCGAduVYS/sFEcjfMjGZV4WqOJ0ze1mmADL0YcqCPHWa5I/sJlCvJb6dFVpQrvDr0fhpjPSw8clMRNB7fn5sOufn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756480290; c=relaxed/simple;
	bh=MKVIGNn1cEq2YWpF5MnDqFEUCjnk9rekqsdebgbty2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jCl4B9X+DbBJq09A1UUTX/gw1RRvn+fxdRV1PR+kENN2zQ1IRQFhEeg1jLoER1Yd3/PYzUlhNbH/EwTzbl/FLNuPaGYv9TvSwUn4JxNxgdBhKXlF1kuI+ST0wxB0WdBhE+kcowR1mw28r01G8r7uuGKmSf9DfLtIkUWBL1w8Al8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org; spf=pass smtp.mailfrom=fooishbar.org; dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b=nuViS/F7; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fooishbar.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2445826fd9dso26285025ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 08:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar.org; s=google; t=1756480288; x=1757085088; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MKVIGNn1cEq2YWpF5MnDqFEUCjnk9rekqsdebgbty2M=;
        b=nuViS/F7FeH323M0y5cTX6mQX8efvYqxWSyhH08NuPp4VLWdFlJHLyKlVsck/xfb17
         RmQ6C6aEiuKcp+6JV6pTN4HsoQYEgrQL17N76c0ZBmSrcMe6VoVrSnH1akFkAXwdv77s
         1vcy9cA3iS+dty9N1xY6eEVxZzNh23z+W8WW3Z9kU/Dacp4gYLZemJPB1yVf1UFxzmoZ
         PAO9y1lQNNAoElZ6ylwkbZ4mTYad1BepvV0YmCZAz1frVvRpimSkmDIAa3ED6w5Pug+Y
         oeTF4AJMW2/ySLKyyiqUg/PwSRIwkCpEsegdbsvmjsAOhvKkJA0gSoGE/p2BbMoG+sNX
         RCkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756480288; x=1757085088;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MKVIGNn1cEq2YWpF5MnDqFEUCjnk9rekqsdebgbty2M=;
        b=DMKssUhKrM9NQRc2Xbg2D90ZB3DIki9u9kxbBQaFGqhUM3D043RhO9jgqjxZUxPT5G
         TQ7H9WcI9025WI3rcqOxkM14NF0jz6XjFTTG4Hn1W5cIngDsA9TZEPfnGKSLygo7EzNY
         7jY0qFZHIYjQNxzIXbN+tXqsl1j6Sh+mCqJ6Q5ifOHiUhJYPeguP8XO6+7SJQ6L7TuXd
         tHfE+xr1PCJqAYka+QeYK8RNJ6s6jCoFzCVxUdZP+rs7TbFeZ8BCLQCHXs3gkhytZZWh
         /Yuyg5cZWe/jZZB9Qn+q6hR7WcJoXw9SGqE3nl4InoMtI6ni2qaUcbajUeHhVnA/Qoud
         umAA==
X-Forwarded-Encrypted: i=1; AJvYcCWx1YxYY4rGLIXXRWLGKk2pL+zTMdqbxZqTqwZrSUGwWF+29YXtzcUU/b9jX7kUQ29zN+VrPmse2b3GRP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQul+Sz7EjZfy0JWOmddUIA2Bik6vv5lPCfK/h1sqDBoZ/P/Nw
	hcf/QsrN3RupueABc4lRR2dLngbkClyTl1IazUatU+c/2uJ7G4vhf+BbX0UZaGSKo7dBnH6xV+x
	jpR+DTjBD4N+gwwA2feFg20cpm0kAAYE5Xr2p8EmfTQ==
X-Gm-Gg: ASbGncsoTydMTvVw7WbCU3nYhV5Hrwjq3m20D3nE/aLZnDsSvrBMcdShNEyD/XK7o07
	cT+ohekZ3sSr8+lGKqWxN/v+0PoICYiRh4XChmX/LHd5dhwhiVms8PAOztBIIcFiyAexJPyDph0
	Y9sotxmxXEwLyj94pAWfaY9KRFamL0Hg9wZGyX86Kof98xMnP3563bm1n84jK3t0Mlk4FTrp7uz
	Muig+pH13Y+gXCY
X-Google-Smtp-Source: AGHT+IHGuK+XPEJZnoxSJC5I7lDP0ZoQ+n66AiaBsrF0OgVB4dkv+81+YUciDWeRwKYQ7j4CfvTN3OcksYb1HiKXD3Q=
X-Received: by 2002:a17:903:b0d:b0:246:d70e:ea82 with SMTP id
 d9443c01a7336-246d70eee46mr278790365ad.5.1756480288279; Fri, 29 Aug 2025
 08:11:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825-rk3588-hdmi-cec-v3-0-95324fb22592@collabora.com> <20250825-rk3588-hdmi-cec-v3-4-95324fb22592@collabora.com>
In-Reply-To: <20250825-rk3588-hdmi-cec-v3-4-95324fb22592@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Fri, 29 Aug 2025 17:11:16 +0200
X-Gm-Features: Ac12FXw0jSvkKD9n-NKvt8cWwlJ3T6SlQZFX3ax5d_8FYdRiZJRd202BjgA0Vpg
Message-ID: <CAPj87rNf3JHveEbtBB-DpmpobDG-kE5nOeNPUaVW-xn70V1jTQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] drm/rockchip: dw_hdmi_qp: Provide CEC IRQ in dw_hdmi_qp_plat_data
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
	Andy Yan <andy.yan@rock-chips.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, kernel@collabora.com, dri-devel@lists.freedesktop.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 Aug 2025 at 10:57, Cristian Ciocaltea
<cristian.ciocaltea@collabora.com> wrote:
> In order to support the CEC interface of the DesignWare HDMI QP IP
> block, setup platform data to include the required IRQ number.

Reviewed-by: Daniel Stone <daniels@collabora.com>

