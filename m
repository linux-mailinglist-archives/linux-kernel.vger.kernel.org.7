Return-Path: <linux-kernel+bounces-720168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 847A5AFB813
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 17:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 369DB3AA36E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 15:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8747221FBC;
	Mon,  7 Jul 2025 15:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="ss/AozUY"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30D52206B8
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 15:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751903860; cv=none; b=N9H+Kl2iFN0vUSihgVD/nHr9LfUzSRaP+9AxM0OVEGRJV8WZduSl/sbGX05XWXlAg+5PFKZBiB4fAj+guPsHy/ruzspa/GyWlLoFVjIkuH2STbEy7ptvqvisVy7kfSGOb5JhVw3DB9ApYI1dRMKdj5+HUxv04hc7fZeCl/X6KjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751903860; c=relaxed/simple;
	bh=GekIVrGK4ewwojNX69mkqW74yj273UAIP552cTKfajc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pfbMPFBn7rIcotNZJocRiOxNenp9fGU5vO61ph5DljrmTPLWDW6qmD8O2J3QTXMuT3q+VzBAkRCk01w9FYR5+iqybPNlKFQvMXa5a689dkWSD6XAgni/nUrKj6T+9I6PJkxSTY0ZfTeki+iRVg7YTC62KcCO6cqxC3aGq6Fom5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=ss/AozUY; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-70e3e0415a7so29126627b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 08:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1751903857; x=1752508657; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5nyJdBZNGQXRfrLLWrFULNmrJUzDZd+q5i06LyK0ZHY=;
        b=ss/AozUYB1urGta9L+qEj8R68XPB0ndjIlzamNIgzK0U8fu1QDy44+ED1/cyYqWlos
         nVLhQGiG4l4hlpEuv6fA06i7lgzre2MkE5UU8lVJ4ls8AJMLeh1NHoNn3CK6T4xkzBQW
         DlikNfPFumemx0klFZ3h0Gy+V3r/4d0dwPKRU3kXAADxPVkOc6FS7Xc9YQB/fQ2HdMAb
         k2xiFHzhCt0qLWLK4shdasCk4Ru7uG7GbGDImVw3qi5UX2WiL3EBP7GwbfvCsEPOYIVT
         oG0bDHjKNS0PWBbbys8Y0hnof+cb/x/5mCi1Z3ennUBp2lqHIqo/tjXVyLRxdfaGeaQ2
         vM4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751903857; x=1752508657;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5nyJdBZNGQXRfrLLWrFULNmrJUzDZd+q5i06LyK0ZHY=;
        b=wmg/JMBU00SIVZvsJrxiguOIwFCtxTgHDhJUT8N4cPG7A4r+WzFgMFIPvtheONr2DN
         pYccQs1WtVtP+ISIdwK7cJ5M7aLATtfKNFp7xceObeZp3moOpPA6vfNFEh6kd1c9Ylq6
         dEB1axvMVOjmd5yldMGCbiZJ3Gt2/gXMXY5GPUP0jmoqYPzdNhAID+3rYnhk0zyKMJRt
         IozOyV6wvbl30nP0AARjH7/DsgvOY1HaSgBUliMrYNj3jz8z0BZHw4wDnh7ZSssfRqUo
         kFSITEfJ6K4Z2iAD5oN37Yxl4B65cFJAkFyHo2ihyElgC21kK0akQpqtzOWlE6zwL+rr
         A0Eg==
X-Forwarded-Encrypted: i=1; AJvYcCWCokDDkEKr5b+tivLu4/6BxqQQIR+rEEQ8b5d+EGnj6vV94KO2QAMy5TP3u43rFjRvZiiDyKflWgWfFKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFGBAOke1igvXRoB9bmDpp1Ox3A21ZaFfIXY5iSz+uwrBkP7o+
	SdqfZYN13BITciOiT7HOuFUiL21z3zFGfXCmULDxmL/01wB2jHH1M0eZ/y6PwiunKfaJYxOSdOu
	Lz8BeqYcrmWFxZGsow+AOTE0kHF1mIMMK/ygEHjcpyg==
X-Gm-Gg: ASbGnctmxjg4CUQIw28PDe9JVnuRGMRE2Yf4iBVeSOuP35zwJ2jQKvYXKwQRk4vXe6m
	1ny59Cgx7g4++dElqiA1sbXch6ERbbpib4nSh554tvNyqdau9Srf5PG18eNCby+36XE6UD85ho5
	xN18XEqHXT8FvoPsQMtHHsKinoNuJKL61IfWZ9zSw5/7ls76+JSd/b8Xusgq9ePuhUiT8TToTgl
	j0=
X-Google-Smtp-Source: AGHT+IGXkinsClHw9T6S8vqJyiAKqsR81bmWFSB3E1wGxVpBShaqy93Jxk6vBcBEnqP8XUAGbCaobGyW++qJmVzyqGk=
X-Received: by 2002:a05:690c:c9d:b0:712:c5f7:1eed with SMTP id
 00721157ae682-71667ecfed7mr187732797b3.16.1751903857530; Mon, 07 Jul 2025
 08:57:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704075225.3212486-1-sakari.ailus@linux.intel.com> <20250704075431.3220262-1-sakari.ailus@linux.intel.com>
In-Reply-To: <20250704075431.3220262-1-sakari.ailus@linux.intel.com>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Mon, 7 Jul 2025 16:57:20 +0100
X-Gm-Features: Ac12FXzisPQw3Zak1z4PISdT8JVI6i-l6yfwQpDlf8066YfTihFWEfCR_f0QlqY
Message-ID: <CAPY8ntCgEb9fd_rMGeWSeR=Hbzf1GNQeSh-gRcubtwzoahqnxQ@mail.gmail.com>
Subject: Re: [PATCH 41/80] media: Remove redundant pm_runtime_mark_last_busy() calls
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Tommaso Merciai <tomm.merciai@gmail.com>, Martin Hecht <mhecht73@gmail.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
	Alain Volmat <alain.volmat@foss.st.com>, Kieran Bingham <kieran.bingham@ideasonboard.com>, 
	Umang Jain <umang.jain@ideasonboard.com>, Manivannan Sadhasivam <mani@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Michael Riesch <michael.riesch@collabora.com>, Mikhail Rudenko <mike.rudenko@gmail.com>, 
	Steve Longerbeam <slongerbeam@gmail.com>, Jacopo Mondi <jacopo.mondi@ideasonboard.com>, 
	Nicholas Roth <nicholas@rothemail.net>, Benjamin Mugnier <benjamin.mugnier@foss.st.com>, 
	Sylvain Petinot <sylvain.petinot@foss.st.com>, Paul Elder <paul.elder@ideasonboard.com>, 
	Matt Ranostay <matt@ranostay.sg>, Nas Chung <nas.chung@chipsnmedia.com>, 
	Jackson Lee <jackson.lee@chipsnmedia.com>, Dmitry Osipenko <digetx@gmail.com>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Vikash Garodia <quic_vgarodia@quicinc.com>, Dikshita Agarwal <quic_dikshita@quicinc.com>, 
	Abhinav Kumar <abhinav.kumar@linux.dev>, "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, 
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Nicolas Dufresne <nicolas.dufresne@collabora.com>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Sean Young <sean@mess.org>, Hans Verkuil <hverkuil@xs4all.nl>, 
	Matthias Fend <matthias.fend@emfend.at>, Marco Felsch <m.felsch@pengutronix.de>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Ricardo Ribalda <ribalda@chromium.org>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hi Sakari

On Fri, 4 Jul 2025 at 08:54, Sakari Ailus <sakari.ailus@linux.intel.com> wrote:
>
> pm_runtime_put_autosuspend(), pm_runtime_put_sync_autosuspend(),
> pm_runtime_autosuspend() and pm_request_autosuspend() now include a call
> to pm_runtime_mark_last_busy(). Remove the now-reduntant explicit call to
> pm_runtime_mark_last_busy().
>
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
[...]
>  drivers/media/i2c/imx219.c                               | 2 --

Acked-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

