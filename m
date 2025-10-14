Return-Path: <linux-kernel+bounces-852707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF4DBD9AAF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6C2DF4E66B8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F5A314B87;
	Tue, 14 Oct 2025 13:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="iK/ZnFL+"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DE01DDA09;
	Tue, 14 Oct 2025 13:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760447955; cv=none; b=A3Ce1e/TTJMeJXw1NtaMkdujSnOp2zE2cBOsvEH403dTmnt1gmVbdH9f0TPf3vgZMj3LSFW8VwWMWvCFJ3RxSUWF79oYR2fujmnEvOMkFjR3fP3JKrsMGz04c0zh9VsmTiCK2Ic/9SqrMOSLsPQntks9x+hXQ1t8oEbB7ubYI68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760447955; c=relaxed/simple;
	bh=gQxUDGegM8VkIfBkYPZWqsIF3HBSy2cYwjYwHQ7pvC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GhpcOQpA0VU2uNmRFFTt+iNYCjnpErwj9385oy2kyrs6IYeSzYeOT/1liRbeC3C3OqgToOCr15233O6BehJgKiAmuByb90DSp+A6GFDBQLhxRyExt2zNyh+QL6a2QsskEYma9QbEXgYefhkRy26tjEmDpV1dtoXQxSzu43kZpUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=iK/ZnFL+; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760447951;
	bh=gQxUDGegM8VkIfBkYPZWqsIF3HBSy2cYwjYwHQ7pvC8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iK/ZnFL+jXF169b5rN3F52mi251gRInDD9/xPQ8/C9/7szD2G5wZAyninheV9MaQu
	 TFC4rTb07gkWxiROZwPNoItAa0pJ58kyvKCfij1PcgT4B566aZQB2IEmBf+xiTJ3Wc
	 uid6RwjuflaJfoDEVo+iBxLmpcdxskvWTq90NAjmOhDg9B2dfF51VN+vztqZE4zYbg
	 2q0QA3ArZvEVNyaacL9iqwD0hWJMChnnm4ZnB4kUzjk3qh12k01GXXiJ/9W3y/jF9b
	 241yHy8DfmaFSaW0O8HfDH1ssOJvSZvfOMIPdvHO4qjTksbj8MTM9+WeyCpX3pYAkT
	 t6Gtjycqa9LUQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2924B17E003B;
	Tue, 14 Oct 2025 15:19:11 +0200 (CEST)
Message-ID: <831f714b-f27a-4a3d-b256-e170ff0d65a4@collabora.com>
Date: Tue, 14 Oct 2025 15:19:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: gpu: mali-bifrost: Add compatible for
 MT8365 SoC
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20250813-mt8365-enable-gpu-v1-0-46c44c6c1566@collabora.com>
 <20250813-mt8365-enable-gpu-v1-1-46c44c6c1566@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250813-mt8365-enable-gpu-v1-1-46c44c6c1566@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 13/08/25 11:25, Louis-Alexis Eyraud ha scritto:
> Add a compatible for the MediaTek MT8365 SoC, that has an integrated
> ARM Mali G52 MC1 GPU and compatible with arm,mali-bifrost.
> 
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

P.S.: Can anyone pick this so that I can pick the devicetree commits? :-)

Cheers,
Angelo



