Return-Path: <linux-kernel+bounces-809604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63051B50FBC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 09:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AD404423BF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 07:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F56030DD05;
	Wed, 10 Sep 2025 07:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="pbYcgpW8"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B8C30C624;
	Wed, 10 Sep 2025 07:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757490036; cv=none; b=PhZFZjYGu2xWA8b0mghJ6ZbR0xxWJic9VrSxdtioTv6AkJdUuv+WyRknrw5NenWPosupCjUhDrHfH5v3Y86eO7HJkJEOC/bH25UL2vmvY2WHHUITb5ak2qNQfabH9iGZv6qu1W3WQ/Dx5f2GiQmUPGMCrBMdFbttfYCtsp3Qt4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757490036; c=relaxed/simple;
	bh=sbTKr6Sv0EFGEa95dRZO+2Ih9nmW5u7BxTNwSFogEQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lJdRpJ+UzekmNIgo0RYtVNTbH7FG1dknIu7P/DhQjvkG9R6uMzQjAcuWmGeqOYqUXaDJXrwPxbtjH4r2d15duNhaXSOHhvdTn5ploDsOwC03a+SBqQSIgNgCuhj/pzYKMWjmYGqmLB5CKiSas3CIf04CM2UhPHa1lLqB9AugAIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=pbYcgpW8; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1757490032;
	bh=sbTKr6Sv0EFGEa95dRZO+2Ih9nmW5u7BxTNwSFogEQM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pbYcgpW8xbv2Kj9bHUM5TRVzh6xO5raDjot9Yn3xvJfLGLkRCBq8B9nEMROV/y7Qu
	 rvk17Qbq+OwkzkVBT+DQcTurGCbxPJlx3gGfQ/ImkXK+eh/i9hdb3f1ZrkhfGYg1Ux
	 MDcoYNp7AxfdT964wGgEZh/H0v8HsOt2/U3+wkozvQHlWaLAde/naI87kd9fdDw9lD
	 RSwXS5tyvr/NCiG95Q30a63L5aPOJP/q2R2gnL5TYIUNOMQRtpKyIfezXlFzM7oit/
	 rKKtkdaVWt/CMukAC6lb4iw6yxbUChiOg4DvFJyKdA76EuFUZxLAWyic0HWYHnvsUn
	 +x0+HMoHV1VUg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 78F8F17E0125;
	Wed, 10 Sep 2025 09:40:31 +0200 (CEST)
Message-ID: <5685f861-9791-48ca-8f94-fde0a4533048@collabora.com>
Date: Wed, 10 Sep 2025 09:40:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] arm64: dts: mediatek: mt8390-genio-700-evk: Add
 Grinn GenioSBC-700
To: Mateusz Koza <mateusz.koza@grinn-global.com>, robh@kernel.org
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
 marcin.czarnecki@grinn-global.com, b.bilas@grinn-global.com, andrew@lunn.ch
References: <20250909163052.446723-1-mateusz.koza@grinn-global.com>
 <20250909163052.446723-2-mateusz.koza@grinn-global.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250909163052.446723-2-mateusz.koza@grinn-global.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 09/09/25 18:30, Mateusz Koza ha scritto:
> Add support for Grinn GenioSBC-700. The Grinn GenioSBC-700 is a
> single-board computer based on the MediaTek Genio 700 SoC. Its device
> tree is split into separate SoM (.dtsi) and SBC (.dtsi) files, which are
> combined in the SoC-specific .dts file.
> 
> More details about the hardware:
> - https://grinn-global.com/products/grinn-geniosom-700
> - https://grinn-global.com/products/grinn-genioboard-edge-ai-sbc
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Mateusz Koza <mateusz.koza@grinn-global.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



