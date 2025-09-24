Return-Path: <linux-kernel+bounces-830351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EA3B9973C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A05834A8139
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46ED32DF6FF;
	Wed, 24 Sep 2025 10:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="iIsn9hQ+"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC181F3BBB
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758710362; cv=none; b=MX2UzAYACqxMhIOonMz+imqZc4VMRwkSA/bh0Ea9jvHuiebQxXe68zPQsMBeACgkZ3ZdgFFUnfEiBC3/e67T5gfGduZKbxIVxbzZ+gdkGAoA5Vl/zLNcGXtZeyXdKjeKxCgfd+Ao+Lo6KJ9SpzYcFKAUIRSsBrjLGVY2Y0J6zsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758710362; c=relaxed/simple;
	bh=VQ8VOZmpdDGrQxu5JvAU61J13zwKbyZ5/3P7rrRWAdE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rXXLUN/+d/7hTM6+nPgmFQNcMuXC0MxRewsIocFvDdGHrDLb44N5BjcczBrIFzZecZ+MGEiPSmR8BppVQiWUvhvLBjS8Db4jx3bU+4mm2t0pC2W7Wx71BE4BAXlnghPKnxTP7Ck3jYukjjXFGpgSygt6fYmZa2tPP/7V5JwNiq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=iIsn9hQ+; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1758710353;
	bh=VQ8VOZmpdDGrQxu5JvAU61J13zwKbyZ5/3P7rrRWAdE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iIsn9hQ+xV1cS8Kxaeswc1Kb5Tok5ZzW/txEt4ryXjW+JVbp7UaVItzTWHQ4jlK4w
	 uebVDe+MvllN4sLMmJm6Z+49p741d0gJLkwk5zLcauI5m9ziG6/ly5fR0RHpM10eY3
	 WQuzIeI6o2hNgQcTK4TCDkDkF2qHeeDue3ZUAGblrJ7r1fYPIcl7Z4RDLMImq2lEi2
	 tu4OBaQ6bDvXdohCkZ+iXX24RnGPvlv3ge+agRzrnnp3WM1N1zWnrkGvoULwp7kIn2
	 ledvoYaWcTDWSEO2TnlqdwQvZMsIvf7RNFeS8A9sAAjPr9/HySKxb1FwjuXybrNkf5
	 nG6Y1AKpGu2Qg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0E46817E068C;
	Wed, 24 Sep 2025 12:39:13 +0200 (CEST)
Message-ID: <7f3a096a-fb49-4d43-be60-9cb25c4e1d16@collabora.com>
Date: Wed, 24 Sep 2025 12:39:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] drm/mediatek: fix probe resource leaks
To: Johan Hovold <johan@kernel.org>, Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Matthias Brugger <matthias.bgg@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250923152340.18234-1-johan@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250923152340.18234-1-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 23/09/25 17:23, Johan Hovold ha scritto:
> This series fixes various probe resource leaks in the mediatek drm
> drivers that were found through inspection.
> 
> Johan

Whole series is

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



