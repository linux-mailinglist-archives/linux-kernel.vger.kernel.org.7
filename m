Return-Path: <linux-kernel+bounces-791970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F277B3BEDF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 17:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1E767A6CB2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 15:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3165B321F3B;
	Fri, 29 Aug 2025 15:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b="X28/S6Lf"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE782135CE
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 15:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756480207; cv=none; b=F14oOefl5twPXptOC8zMDo9bqF1Yqo7J+n8MNoJQeoZR8trMnpPlVVm1b7cN7IOBjIgehMGx8Bs7V136RX4S+Mu8V5ahrCxvpgwp8LtLsleJNJXf/xf/LVdk4+ibRdefrXPKsdsNWl950wYZLy+hLzgVoeQ1cticxH6CrqlaYV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756480207; c=relaxed/simple;
	bh=EGLIvrEeA6aZSH5bbWcCyh35lvNtwwlGEu4excYVUnY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PJ6+5FlrICW5EsIc7sJJioR6V3O14TXR9PWXXnS4cqjrHuqQut/Gzxi0yG5jVXQCVqsySMXc5+IIoog545qpCdlSImibUe8Kzj6lqVO66/wEiV0EpPakvYYkLu/0LTQPFTKqflTDc0P0cYIkt6d3WAo31PIg/pfHN3iS8ZF+5qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org; spf=pass smtp.mailfrom=fooishbar.org; dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b=X28/S6Lf; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fooishbar.org
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7f6f367a1f0so262773285a.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 08:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar.org; s=google; t=1756480204; x=1757085004; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EGLIvrEeA6aZSH5bbWcCyh35lvNtwwlGEu4excYVUnY=;
        b=X28/S6Lf3SOPtz57BX37eXHkt4NsGL5RCG8+HSd97quKaYhU6faHKmQP9+A23DM+QH
         mOcQWhNTE2yoXUx7QukBN8VjRl1wbyTszzWyj2cwZ2m8p38Hkr2WSDAfAahztSm2mpF5
         lfSQ+FePztAc4DrnHbhTB/oyp9CVvqf5PQHybC5Ji7dreTgvjDMjT9RpLtNCK5WTgycl
         lyuITQKYpMwDTEJLNn7/FLuds9ekqLFiw7PyeTSTLw7+rMRlcRbPW3nRrZSK+fxhWxj5
         HtrlIeROtfUhdSWjMp0yrxP45CXt7VacZunhk0zLV3T8HMIzHzvxTmmnWLvuH0rJLNGd
         /a6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756480204; x=1757085004;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EGLIvrEeA6aZSH5bbWcCyh35lvNtwwlGEu4excYVUnY=;
        b=H+Qnoky0YTqd2pkuKTgTEgZe/0zgt4FLHCL8G1dUKeZrmZ20Bmi5N3+LQRHtO0u8VV
         Yd2njD5sGwvhjaYq5eHXgXKUXpQrs62A2KQnI7uNCo62FBX1ZRvB7hp7GXBAt66wdr6A
         oqGcgqgmVm9z2WmZSZhkIVdjXvAEnQBUSZBqMmrOWvmt6woV1okRnGftbL/pLD12wm1G
         XQkrpKGu3neLsx4N8Gs5K7EjsF3AZx8gqXmCc53sS9ZZNtXi49DVEZ22KPAbYu5D36zs
         mKOsa6/vO3fsL4eRcv/r6QUpc8AER3BsgPwVsVtPmKGNYh3WBB2TwutPproo9kFJNkvx
         Eodw==
X-Forwarded-Encrypted: i=1; AJvYcCUPyV61Wdla/0VAsQi38xk0THIUnHK9R4Gn97cswD3UzooT8hhcR/C1N7X517tUNP7PHT2bpL8c4DCyA8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeCUKsOQ/qEkBn5PbjC3Pl+DosFNOrTm21KghrCFCj4uDyDTpx
	7vkJ226W0GGffFAQ4AM6QysmlDI2AIEaEjrQQ+1FZQbiUxXfvbaFDB/0HyNri1p0MT2xhz6baNw
	0cyjHYVBmTILGYLsdYkN07H9KP+7TETrM9hxL1DTf0A==
X-Gm-Gg: ASbGncuwmp/FurlwY5TP1HlW8JVCQR+1LL/TPX2ZPv8AUNqdJfZpywz9W8sbvEk2TeI
	1Q+BTjCoFZrGfHTM0vwm41OlvGUMp3kMcdHeoejVD53LVRtedMGnRZ7Gs8bJyfrmJ3lWYX8/ftz
	ZdOoNQL6TGs4+3eJ/Nq3FiXpR3KXGx/0zZEMGpk+APGTRLbPNpmGnpi5W3k1GPMRWm1MLUl9RXj
	XAYzQ==
X-Google-Smtp-Source: AGHT+IGKh7Y20GWjms5CEWqUFYK6Fhl4aSsCjrhVa2muuLuQNwyCT8KtW05eeJgqP4jwNECHf4vjyNzCIEKa9V1tI+Y=
X-Received: by 2002:a05:620a:269b:b0:7f9:98ca:af1f with SMTP id
 af79cd13be357-7f998cac79emr862285085a.32.1756480204505; Fri, 29 Aug 2025
 08:10:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825-rk3588-hdmi-cec-v3-0-95324fb22592@collabora.com> <20250825-rk3588-hdmi-cec-v3-3-95324fb22592@collabora.com>
In-Reply-To: <20250825-rk3588-hdmi-cec-v3-3-95324fb22592@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Fri, 29 Aug 2025 17:09:53 +0200
X-Gm-Features: Ac12FXxjT2DMgVXZUD7stQTdp-evPmAyNIHAST4h_-TfcQ_juOKoIsGqjkI2p6g
Message-ID: <CAPj87rPhhhhEHrPqAcKNtWwAtCQRANp_=8sQtg3urqf5wcrmsA@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] drm/rockchip: dw_hdmi_qp: Improve error handling
 with dev_err_probe()
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
> The error handling in dw_hdmi_qp_rockchip_bind() is quite inconsistent,
> i.e. in some cases the error code is not included in the message, while
> in some other cases there is no check for -EPROBE_DEFER.
>
> Since this is part of the probe path, address the aforementioned issues
> by switching to dev_err_probe(), which also reduces the code a bit.

Reviewed-by: Daniel Stone <daniels@collabora.com>

