Return-Path: <linux-kernel+bounces-809943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EACAB513BB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 727801C26F48
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03EBE314B92;
	Wed, 10 Sep 2025 10:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Uq7JbDI0"
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2536314A8F;
	Wed, 10 Sep 2025 10:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757499540; cv=none; b=r9UUTvOU7gCnT5sV+73dstqfX5cn6+sPdkI4c2fMg4x/JyLJXNolrLdFnQaxs+UPWu84Qy1h3azGuzEGG2xajUfdORSuzoutxzKH26TSQkd4frNAqBOi9dF3pS8S3HQD4ZOGI2M4PrDAuh0NJ5NFGVNvlZwDJWcQG+WlI0IMHJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757499540; c=relaxed/simple;
	bh=mtfzlV23itZxMpFL9qqRSRbfw+eJl1lkap3louVt2Mw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UEWgiL4kLRhTu7lzfipHOwPLA77YmAGeZDPOMMCdEDJSZ+nhdRMR0eQJI7OEHVrYB+N1oeDSd5UjPjbrX+XafRO08SEwQVjoNE0GsO9zNe6GqolM1bL+x9OJm0jji3yMHPP4l00AM0MuBZG+9ZyMqK8ZMMoPP6BxlYKFxCuiDYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Uq7JbDI0; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cMGqr0z6Rz9tvy;
	Wed, 10 Sep 2025 12:18:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1757499528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d3DfTTe4dUU7JEgX+YGY1qShcMAdyIkpmMhLNWRyQYo=;
	b=Uq7JbDI0bKNyQICkGQU8D46MR9OqRcHti2JdFmhz37MJVgYJOL8hT551xIL5u15m9nbd3F
	K4zjT60aKKJ4TK2avAjHCKf0vnQer1jrjOS4vnTR33dg1Xnyc757ySko6Pn6QuP2sXsVqt
	ZY+6qFNJnYMAvNtrLgF9mWGwDaSHm7sC6FJzUH8vkGan3S+BxDGDT+1I52rvTslzuPZh4Q
	64Rry5+Yw4QETLGWd2ybTMr1Tke8u8jZJ8wwb6ii+wjumoqDyFwIQM5TaFxC1kWWzNhHgw
	JZwsUYrp44ahHdARo/R4CWHMXLTvd02RUT+3iwUgdzGRBw7Xsz3bs96+SD6Oaw==
Message-ID: <df3067e4-5597-4557-b61f-26afb7d731d2@mailbox.org>
Date: Wed, 10 Sep 2025 12:18:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] dt-bindings: bridge: lt9211c: Add bindings
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
 jessica.zhang@oss.qualcomm.com, Yi Zhang <zhanyi@qti.qualcomm.com>
References: <20250910-add-lt9211c-bridge-v1-1-4f23740fe101@oss.qualcomm.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250910-add-lt9211c-bridge-v1-1-4f23740fe101@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: b9zx9d1nxxuk6tzn1ubrzj7i4wm6bzsh
X-MBO-RS-ID: 9ea7b904f0daaed315c

On 9/10/25 9:37 AM, Nilesh Laad wrote:
> From: Yi Zhang <zhanyi@qti.qualcomm.com>
> 
> Add bindings for lt9211c.
> 
> Signed-off-by: Yi Zhang <zhanyi@qti.qualcomm.com>
> Signed-off-by: Nilesh Laad <nilesh.laad@oss.qualcomm.com>
> ---
>   .../bindings/display/bridge/lontium,lt9211c.yaml   | 113 +++++++++++++++++++++
>   1 file changed, 113 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/lontium,lt9211c.yaml b/Documentation/devicetree/bindings/display/bridge/lontium,lt9211c.yaml
Can you extend 
Documentation/devicetree/bindings/display/bridge/lontium,lt9211.yaml 
instead ?

How does this chip differ from lt9211 ?

