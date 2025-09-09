Return-Path: <linux-kernel+bounces-807913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FB0B4AB06
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC7384481F9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82AD31DD98;
	Tue,  9 Sep 2025 11:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="E1ZG7ia1"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8D42EBDFB
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 11:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757415688; cv=none; b=tbQNUWX8UxuzV4mELCEWVN0o5Lj0U0Lu2ZUQsrnqtCGbh4Ha6gKl1HQC6Xjy/MkjzgBLsZoGRowmOrq5B/og9ZOycat1q5FcN0UjDr+NefaNQDaDTWqFdpFIyQUj0g0rysalRJjSEaDIRaAahqpyFqCGLH0ks3ZQJw9ApWznynM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757415688; c=relaxed/simple;
	bh=/H0hDZTXJaQsF3wo+YdB4vDsf7w2WQqzw7+YSSGO5mQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ekZBDk2c/w8p8X+/uEwQxHJOCKrVdwBysdTakrqIK6HRwpqdauTH9ULfAn8tVzkkClvj3bcFwKRB+IOpUW/yIDSuPe2JIfAsOm93jMY1sr7Iw3TFKUXLp8Q/1FRy8Lpu5dfZ/o6EIdBRg0QGKlII70cp79xKM0lHlbl8GrLABe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=E1ZG7ia1; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1757415684;
	bh=/H0hDZTXJaQsF3wo+YdB4vDsf7w2WQqzw7+YSSGO5mQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=E1ZG7ia1KW5AXN4oYkSA1kFv4IfwItMU2QZp8Ts6S/pd5Yeh9S5FPAC9hxoKXN8JX
	 yimYLavR90KmVHhWtlgN0SzB3iBBDt4//YHKm1GCWJlYSHePLfec7zmzhiCqYWLRsI
	 ym5hoYWLM8AKS1tpdNTqvCgGVTlTIrkmL6I1UOl74zXqtVho6B2yikjsF8HIeN4CaB
	 7Y3sMYxEOCjOF1UvHc7mGa7SEOmI0fqzdjtZsWS/DYDuzoxlXUmswXuRB+QB2PRjS2
	 3h5W+trWHueiuwH4F+W5KAF0KVvuAF1atVAnCt1M3y+p+W/nd3yRqT5Lv5uNbJh5QA
	 tlGmuUbKIHyXA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7F2DE17E0FAD;
	Tue,  9 Sep 2025 13:01:24 +0200 (CEST)
Message-ID: <58146679-6b64-4a46-919a-a86615765cec@collabora.com>
Date: Tue, 9 Sep 2025 13:01:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] soc: mediatek: mtk-svs: fix device leaks on mt8183
 probe failure
To: Johan Hovold <johan@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Roger Lu <roger.lu@mediatek.com>, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250909095651.5530-1-johan@kernel.org>
 <20250909095651.5530-2-johan@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250909095651.5530-2-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 09/09/25 11:56, Johan Hovold ha scritto:
> Make sure to drop the references taken by of_find_device_by_node() when
> looking up the thermal sensor and opp devices during probe on probe
> failure (e.g. probe deferral) and on driver unbind.
> 
> Fixes: 681a02e95000 ("soc: mediatek: SVS: introduce MTK SVS engine")
> Cc: Roger Lu <roger.lu@mediatek.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



