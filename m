Return-Path: <linux-kernel+bounces-597567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2472EA83B94
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 09:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 569A33AA83F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 07:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2E42046B9;
	Thu, 10 Apr 2025 07:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="EM6WTXBV"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D95C1B81DC;
	Thu, 10 Apr 2025 07:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744270880; cv=none; b=ruNkret3EKbotXwoqo2Q0WJQSDZnWpfbyvbFihCHoMt1a/zWCXUl9uXKZELGr4WpCzpCiD/mPW1otW33pYKyZDxw08rvMJgWQvk2O/1fofsWWAS92rhNUVCNCHM80Jc6BtqPRV1+7LNpcfDqMFC8MD3hgyzGxQIAzzf3kLFjNtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744270880; c=relaxed/simple;
	bh=3IfBQopd+IoX5ie8Gxg6Qto+l9rvuKK7VsSNYjenPVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WpDnfDlLsgxrO3j9hMDM/JHqR9fSZOFLjsayagHOiuBozz2Gg/tQjiL7FPu52ov8nK/0v+WD9Ur7hnlLDKPVRDerqx1QX6PISEGVKhfv8pPPLaUQiu78AWK5PGRkJVEkMt39w/sH83wt7FYa/g13huJjdZkl6C6E6MN0j9lQqog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=EM6WTXBV; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1744270876;
	bh=3IfBQopd+IoX5ie8Gxg6Qto+l9rvuKK7VsSNYjenPVA=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=EM6WTXBVfEYoJNmePpaZYrZ3vcMu47q46T6ArViFMYcz63b119GUaJSGSFAEdEc9o
	 hRK+m0ROmvDIU7uR0rRoDWXaxl6pcdfThEGNQOxEzqsD0Wytw2oz0PxbcfOAzOOd14
	 LAJdKTf7fjrQDkJaaPoc6E8OlDuJcKj8UpvnKEfrim4guhAj5/c1yRuLQ5vRzLC+V9
	 0atHJVVa9x1ERppvZErxuZRjJiScUesuEe6dE9nKx+2Krq8rOd5ubwrQK3jzhf70xp
	 47NsaraJllSDi6ICdB69AbXnRYzdNMZn4lS1A7BbyuXEAn0o1UVwwg8AQLCBcbm8/6
	 mNlGMiKNEafnQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id AE33C17E0402;
	Thu, 10 Apr 2025 09:41:15 +0200 (CEST)
Message-ID: <b96286ff-f232-4ca7-94b2-8b7b671edc62@collabora.com>
Date: Thu, 10 Apr 2025 09:41:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: pinctrl: mediatek: Drop unrelated nodes
 from DTS example
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Sean Wang <sean.wang@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Andy Teng <andy.teng@mediatek.com>,
 linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20250324125105.81774-1-krzysztof.kozlowski@linaro.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250324125105.81774-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 24/03/25 13:51, Krzysztof Kozlowski ha scritto:
> Binding example should not contain other nodes, e.g. consumers of
> pinctrl of, because this is completely redundant and adds unnecessary
> bloat.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



