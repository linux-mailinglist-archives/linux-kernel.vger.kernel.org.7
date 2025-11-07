Return-Path: <linux-kernel+bounces-890644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3B1C408D4
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 16:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ADB53B9A5A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 15:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA8232ABCE;
	Fri,  7 Nov 2025 15:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="cJZE8GZg"
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE5B2E6CBC;
	Fri,  7 Nov 2025 15:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762528299; cv=none; b=cjjWZlr8SV2rG2KzdO96grxPgm/5lFrsx/mBQ4j1W9reqrOeyUWC0mk/N9rjn+vIoXVO0RRLLmh+oLgyf9qQh26QFiXbbm3JHO+JojUzqZgOXtHViXPAXJkN+0hJKhgLw3LtQNJRSMGXvryHvmljEOcpboWVatX9Njn6vRc7mtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762528299; c=relaxed/simple;
	bh=yJlWwZ3a12j7omKvOIsqDNOsBjKnkPkdtmc70OuHjRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rhuUxhGlELHUK90jbXRzE7bvDJdkcjXJL7Rhcerxj0XcL3PPb+aoulSk5na+c81aI52v3foBEXD4Pey2Ixh+gPTQ0v/vpmXC1o0PLPX/XncDMKkzeNKS0LiPDWixO4q5LCxtjfmoGgWOgo2fU2GM7JkomAb9SwxTPV5l7leEl44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=cJZE8GZg; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4d32Zg6GRGz9tNR;
	Fri,  7 Nov 2025 16:11:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1762528284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vy+NNLP394OwYxNRijQPvvDO7IMwiwg8RBHcds0M8FQ=;
	b=cJZE8GZg+N198UtZfYrAVmdKAtJBrrVVkioaD4ZOc9/TDy1z63PTOeAv6j+SNs8/bPzYC9
	JOs9bWu2tpIO6uuFgG6AKrXOPYr5cteqWw+aGCwS2s2/qWM3CU7j1k1wkKJXuRv2yIGHhU
	DK4p0zb8zrtlKhxpafKd6RV9/K4EEpYV/ahYx5idiMrpFIddLaL+V5Q3V+Cc1RhUz4jGl/
	E/AaRx5C1kIUJU1pS9Nn8HcZujIGvbsObt1nkRrcFHviOZLerSOkKniqitprQbzSq/oEDb
	uS0DAVnEXSiH0xp/lumQsu6fIDy2GC3b8MMUDf+FwXsA4/0CnqCC1cLaUd6dbg==
Message-ID: <d2c9cac9-17cc-4bc6-8322-bc43edbf45d1@mailbox.org>
Date: Fri, 7 Nov 2025 16:11:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/2] drm/bridge: add support for lontium lt9211c bridge
To: Nilesh Laad <nilesh.laad@oss.qualcomm.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, venkata.valluru@oss.qualcomm.com,
 jessica.zhang@oss.qualcomm.com, Yi Zhang <zhanyi@qti.qualcomm.com>,
 Gopi Botlagunta <venkata.botlagunta@oss.qualcomm.com>
References: <20251107-add-lt9211c-bridge-v2-0-b0616e23407c@oss.qualcomm.com>
 <20251107-add-lt9211c-bridge-v2-2-b0616e23407c@oss.qualcomm.com>
 <30b5f19b-1ce9-4239-bf0a-d83d647608ce@mailbox.org>
 <aQ35tvwp90qm57Cl@hu-nlaad-hyd.qualcomm.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <aQ35tvwp90qm57Cl@hu-nlaad-hyd.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: f902cdf5302f7a21187
X-MBO-RS-META: ii1978emft34czfyu9hytrgg97y7df3e

On 11/7/25 2:52 PM, Nilesh Laad wrote:
> On Fri, Nov 07, 2025 at 02:20:58PM +0100, Marek Vasut wrote:
>> On 11/7/25 2:02 PM, Nilesh Laad wrote:
>>> From: Yi Zhang <zhanyi@qti.qualcomm.com>
>>>
>>> LT9211c is a Single/Dual-Link DSI/LVDS or Single DPI input to
>>> Single-link/Dual-Link DSI/LVDS or Single DPI output bridge chip.
>>> Add support for DSI to LVDS bridge configuration.
>> How does this differ from existing drivers/gpu/drm/bridge/lontium-lt9211.c ?
>> Can existing lt9211 driver be extended instead ? If not, why ? Details
>> please ...
> LT9211 and LT9211C differ completely in register programming sequences.
> Even lontium mentioned that register configuration are different for lt9211 and lt9211c.

Lontium seems to often suggest, that users should use their provided 
register patches without thinking about the content at all.

Do you have access to the register documentation, and can you compare 
LT9211 and LT9211C register layout? Are they identical or do they differ?

> Nearly every function would require duplicated logic with if (chip_type) branching,
> as register sequence are completely different.
> Having both sequences in single file is not looking good, hence want to merge as separate driver.

Can we somehow use regmap_register_patch() and register patches in 
driver data to avoid duplication ?

-- 
Best regards,
Marek Vasut

