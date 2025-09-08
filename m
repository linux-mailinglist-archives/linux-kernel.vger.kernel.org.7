Return-Path: <linux-kernel+bounces-805733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0688B48CCB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 367A53B5273
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 12:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6216E2F90DB;
	Mon,  8 Sep 2025 12:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="K7+WZ+SD"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6B922D4F1;
	Mon,  8 Sep 2025 12:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757333029; cv=none; b=LZ3IDm35AFReeBCmhyK6bndJNT/62vH/r775LYWIPNo+YdCNG/DqT+3aZHDhGiZGVReoJ0Zjh4H5zF5TcQ9AQiQIcYXGsg4umfQ6jGdrARovFf/qrbus/7NinJ7Ex2kN4sLsUjO4J5/NO2XYsZgylnfgACTe82evAPvAzoiVKvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757333029; c=relaxed/simple;
	bh=XIocrUvf1jmeevgA41TfeHrwokbPV3UwDRYwfQCSDcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=F13NwvY+KO1QxOk0vheesJemZ52lXcFjdtg6/MIW2TcObE2wkSMQP3p9IuLCAzLyGFe7rz2+hU4NvxFRNukjCRhe6tJhJkIyOOkEWjs+Af0bcwWzaq3thxsYMZnf9r/rbFeES+OtlJ5f4r1srgJpJiJGJI17cFui+9hxwNA7ey4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=K7+WZ+SD; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1757333025;
	bh=XIocrUvf1jmeevgA41TfeHrwokbPV3UwDRYwfQCSDcQ=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=K7+WZ+SDW3VIBMxsMciwOS4OXqOnKsFWdYtlQ6rWm2l4yIOEI+HPn2yLD5NP0B9eU
	 XyCWtvX5iMqLSBBWNyIWgavYSiTJMYXfFA9NUSg09G5e1v8rEv4UfJEIo1/zrcZmvm
	 kaL9KaYABQhB0dJYdHWC5FwVi91p87FeApP6ZQeOw4mIC4t72iJ+UhWPX2XZScgfCr
	 KLUnf6u1wQWuDPSKZSJIJQ2t1AkKmWpctGofzAfANIQ0pI+M6fxnOW+U1pSvGJPgU7
	 CS9678m7/glziZl6YUOEo9833O9IU1Jlr83K1WESK9aDffIFrwqrgH8icHn5DTaG2k
	 z10JtANyTSlMQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 86C4817E0C96;
	Mon,  8 Sep 2025 14:03:45 +0200 (CEST)
Message-ID: <a0a8a8b6-906f-4a4b-8666-fd323238b52c@collabora.com>
Date: Mon, 8 Sep 2025 14:03:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/1] arm64: dts: mediatek: add thermal sensor support
 on mt7981
To: Aleksander Jan Bajkowski <olek2@wp.pl>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20250907111742.23195-1-olek2@wp.pl>
 <20250907111742.23195-2-olek2@wp.pl>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250907111742.23195-2-olek2@wp.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 07/09/25 13:15, Aleksander Jan Bajkowski ha scritto:
> The temperature sensor in the MT7981 is same as in the MT7986.
> 
> Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



