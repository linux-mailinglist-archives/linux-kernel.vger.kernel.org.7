Return-Path: <linux-kernel+bounces-890445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A781FC40130
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 14:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E284B4EDFD1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 13:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF86148850;
	Fri,  7 Nov 2025 13:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Utrsb2Tw"
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177AD290D81;
	Fri,  7 Nov 2025 13:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762521671; cv=none; b=jaHqsQnsJWXn4m9N7bVbmgQFsRQMMdDN7U1a3kVZk2MNDy+KFQv9nY3t4Ny8Av4REElywDI7BamUasmb5l7/pSTuUPQGJEXfHVg2Fv+sTgeDwdqG+Ig0b6ACf6ltkazEFpUO80/VaKJT7f106nYsbieW+fhzwB0kB7J1mMAvOkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762521671; c=relaxed/simple;
	bh=96E7URd/JBMmeOeSqdqyu1X4/m6NGu3byeNUEJcl/yk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SGkGThArr4kuH/vhWqcMU2DYPnlzrAKbJ0E/t/JcO+19pvxfIVMydeNgUr/OEB9zShEWpSPIydy2smQsUjaiFsKlk2MDgxRFT151injzgz7AvQrkSMkTVh1wapZF5fpORwKX69Mzkn/LZUR0pSVyPVA8u5Pnu8vkJMB6h7sQ5t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Utrsb2Tw; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4d307N6kz7z9tGx;
	Fri,  7 Nov 2025 14:21:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1762521665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wx+vZv28+HE6MSimwPiuQydOQKun8ZFnuH4lyJBNIpU=;
	b=Utrsb2Tw9ZLQ3r8Vb2EA+Xq+47eZ5XohMIgAjo9ut6h6voQqszZYotz00fVIF2CcLFp8lZ
	OiGbgXwQsC9cbY5hPE5sw0j8m5rOPPBbMW02566fTPR6deKdt9yQO5KhofOY3ehxdZu+VZ
	Q0T1OSPwPCB0gfjsdRaFfePuUg2NLd19v2Irv1YnzrmTyQuipe3sibBUfYn+XZXpxuoD7K
	sB7dIi5A9QbUsG8Zqv1gJ9pajt4x7kVw2AyU0Ej1asC5m0FZ4XmpdEzqMTDYmW4G/jRskT
	X9Ybwd3VONaPGSEbSsIJ2PZyz3DvAJJF3y0uo/B/zC8FRo76Z+FehBNJPU8cXw==
Message-ID: <30b5f19b-1ce9-4239-bf0a-d83d647608ce@mailbox.org>
Date: Fri, 7 Nov 2025 14:20:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/2] drm/bridge: add support for lontium lt9211c bridge
To: Nilesh Laad <nilesh.laad@oss.qualcomm.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, venkata.valluru@oss.qualcomm.com,
 jessica.zhang@oss.qualcomm.com, Yi Zhang <zhanyi@qti.qualcomm.com>,
 Gopi Botlagunta <venkata.botlagunta@oss.qualcomm.com>
References: <20251107-add-lt9211c-bridge-v2-0-b0616e23407c@oss.qualcomm.com>
 <20251107-add-lt9211c-bridge-v2-2-b0616e23407c@oss.qualcomm.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251107-add-lt9211c-bridge-v2-2-b0616e23407c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: c023b755a867ac5c4c7
X-MBO-RS-META: kabyjstd7kknyaoc5reuyraju3n6868d

On 11/7/25 2:02 PM, Nilesh Laad wrote:
> From: Yi Zhang <zhanyi@qti.qualcomm.com>
> 
> LT9211c is a Single/Dual-Link DSI/LVDS or Single DPI input to
> Single-link/Dual-Link DSI/LVDS or Single DPI output bridge chip.
> Add support for DSI to LVDS bridge configuration.
How does this differ from existing 
drivers/gpu/drm/bridge/lontium-lt9211.c ? Can existing lt9211 driver be 
extended instead ? If not, why ? Details please ...

