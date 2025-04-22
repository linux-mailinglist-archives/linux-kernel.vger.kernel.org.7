Return-Path: <linux-kernel+bounces-614467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 253FBA96CEE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 15:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17EDC178229
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 13:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC4B283680;
	Tue, 22 Apr 2025 13:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hqUwLXL5"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B6427C84B;
	Tue, 22 Apr 2025 13:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745328728; cv=none; b=W+Slgypw9dlyykkMpQ2lFZ8KAIlhS0UHYG7wM+d/Uk47iiiZHmUkGjpdyTW4FdBerHW8lUE9+6kGG6wKQQkOvAqjr8qheKWRfxX0VFsB+BUbZpVjDDIgYMq4/d6fa55BghOD7YS7Pj+2qI2+nQFURDfLkxdj/LBKj0zwm4W52Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745328728; c=relaxed/simple;
	bh=LKMZUu3lsZhsa211mHfM7d9uBlEp2aX25uT7PabbRUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FxLRdD4JeuQxFNoxghOveEpQn07uR49hhxNJq51j6xdX7KwBucJX5sk7KwWJVFFizkJ/4WroCUnXPFaKbKjTaJVjQyd77nvGay25FyvGvn8USmrsFAkgPOlit2TXCP6UXfFhCPbSA5mzV8jhV3+8Cp1pNJMa3Hhfmn2SgdtAkvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=hqUwLXL5; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1745328724;
	bh=LKMZUu3lsZhsa211mHfM7d9uBlEp2aX25uT7PabbRUg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hqUwLXL5sCew5VGG9VlKawU3nK/XKVmyT8J3g9Kvz2cTRySHgL8LlMbcQlm+kZ0ph
	 VgSfxHwIOC7nDXdogrzLE2iwjdWXg7FocoCD0eYEGrY4Pdq+OsH34Hdru74vrwvvoO
	 qWD19ETYw5FxnPrjZfDPdzWAQ9dtrvR3/xdgn4Srk0yvnyTvfZZbMjb47v0qfs9wxn
	 o3MmrZD98OG7d1nVH8MXn0MBYx5XCUL38N3RMJY6E28fCqqVybyGv1gR7H/RnWZn6O
	 CfiYggqhpedC/9aqq0UuScuUQpxLlDP1qYj9WOgrWEWFUeEN9QcOTIFX8/iYnItDAn
	 CVffwIyyHyxYw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B4BC917E0CAB;
	Tue, 22 Apr 2025 15:32:03 +0200 (CEST)
Message-ID: <6f7f922e-1a25-4546-b081-835b5140aac8@collabora.com>
Date: Tue, 22 Apr 2025 15:32:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/8] arm64: dts: mediatek: mt7988: Add xsphy for
 ssusb0/pcie2
To: Frank Wunderlich <linux@fw-web.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: Frank Wunderlich <frank-w@public-files.de>,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
 Daniel Golle <daniel@makrotopia.org>, Sean Wang <sean.wang@mediatek.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-phy@lists.infradead.org
References: <20250422132438.15735-1-linux@fw-web.de>
 <20250422132438.15735-8-linux@fw-web.de>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250422132438.15735-8-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 22/04/25 15:24, Frank Wunderlich ha scritto:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> First usb and third pcie controller on mt7988 need a xs-phy to work
> properly.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



