Return-Path: <linux-kernel+bounces-807912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D90E7B4AB05
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AEF3445E17
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A58313E21;
	Tue,  9 Sep 2025 11:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="mp5GhEvg"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00772264D9
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 11:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757415686; cv=none; b=DoY6n6A4tfKx4IKLxyE9jQSwst1ikXuSRJGFqEq8aSDO/S44xuVWBih/XmdJ0qWpBqzz3tRbL5CyD0woEmTI1g/JlPX8Ux4k6l43YRdvHQ2uR08QO7+GERpr2xTNG5HFLRa7RMgCYnYo8/wzDip/Nnc7fSY/QoJCS2a1062IJUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757415686; c=relaxed/simple;
	bh=GwLe3BWnVqoVmWve5L+P+wWFpq3U3m3OTRVEQk0trjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eOe9PEvJZ049PugAbnBaELKmMjpAGl//HgYvqvBSBDDhZwHVBXcTUfNCpwyZhqvrS+zl4khYpPe44CAHlFpXKvG0TW+TxE2ivn3wPpIh666/FsQPp7qIG4vI6jGZj24EwAwejgfO+xQrIcEzAZn5kFhibNk7+h+JY02OCmBjic0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=mp5GhEvg; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1757415683;
	bh=GwLe3BWnVqoVmWve5L+P+wWFpq3U3m3OTRVEQk0trjc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mp5GhEvgZuEF3MugtGPGTuNn/LPQmca9FT/kdi/z7f7jYK29uvogXsR42ZluToyvE
	 fWMd1+EKts0Dss/bl6Cc+7q4+VqF2KwEgq0VqJgyq85NsXlElaH1o/Rw2kzXRYA3SJ
	 ZtaQd0G6EArh6iM3G+hQMxXmg7Rl1O0ik9aD9QQYAHD+vavJ58Owi0rL9w7HfEwtz1
	 MCGJB4QWApkvHqKvBulH1jhSCSsucHhIOMV0ONF5PYSirY6Pr3IvyAJCydXvlgZMHe
	 WNsbBVVDaM13xAM43jqcl4rQ6rLctInNjc5tKvv4eY2nz8eqQVbSbYaCmtfavZsMsU
	 H2DKmW38WioWg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D538117E0C96;
	Tue,  9 Sep 2025 13:01:22 +0200 (CEST)
Message-ID: <e0200aac-570b-420e-ab16-e543e85997e4@collabora.com>
Date: Tue, 9 Sep 2025 13:01:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] soc: mediatek: mtk-svs: fix device leaks on mt8192
 probe failure
To: Johan Hovold <johan@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Roger Lu <roger.lu@mediatek.com>, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250909095651.5530-1-johan@kernel.org>
 <20250909095651.5530-3-johan@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250909095651.5530-3-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 09/09/25 11:56, Johan Hovold ha scritto:
> Make sure to drop the references taken by of_find_device_by_node() when
> looking up the thermal sensor and opp devices during probe on probe
> failure (e.g. probe deferral) and on driver unbind.
> 
> Fixes: 0bbb09b2af9d ("soc: mediatek: SVS: add mt8192 SVS GPU driver")
> Cc: Roger Lu <roger.lu@mediatek.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



