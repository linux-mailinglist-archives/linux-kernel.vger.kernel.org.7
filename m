Return-Path: <linux-kernel+bounces-740338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D09B0D2F8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 09:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5FFD5615DB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 07:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C16128A718;
	Tue, 22 Jul 2025 07:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QI/8PSMm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39231B87F2;
	Tue, 22 Jul 2025 07:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753169221; cv=none; b=FR/P0wV7Nu1iXAv7rI4GqJJOa7p8kVlCx8VLjohcPN6GW2doiCfYOwXcQmVPpC/HiauQT+j3UYm7/wOfEoJbyWwK6b+1IJcKV4+s3WNAQ7OSgdY658UC3Ae3jQdNdbwIKV7xlevJ3v55u/UTUgr+jbeb1TlRO2NGL59MG41Wqm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753169221; c=relaxed/simple;
	bh=kX4jVjMeEtvNf+e/+zPa2nRUpF6fl0hMQ8tg2YCObjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LBKoIllCcZclQvD8h4t1nj3S0fNdf3Dl9nubYXHk0TKT4u2RzKyoOKonuRGX/+HoWXiVNMwr3UqRYZAZzYsnYXpEOrrvfLmzsc7Y+pA862vMTux63bZP2hHPwLlzRBfqUH710/yYwSHmATV1cvJJSw6vCPN/H2G+BF8wkGkPFgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QI/8PSMm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94E14C4CEEB;
	Tue, 22 Jul 2025 07:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753169221;
	bh=kX4jVjMeEtvNf+e/+zPa2nRUpF6fl0hMQ8tg2YCObjU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QI/8PSMm+0FvCxJWAU94AXrriQPRXIONz78aRf9CawzIcjgyiKOJBxX2lJwJaPSib
	 CuiLLiGT0RWY2Eh+JWwMGNKs0pIIKvyYHdWTZIv/AvQg5WegOuCxGxICOgGB0oxv7a
	 n63l3abcJAS73Fg0dEhAQ1MLU2KIIxscUs/7d6xutUQ8OmxUpUrTzkiSsNQvBuSDSp
	 K1WBLbIau9/kx39CbzVIXSC40CvSJrJmYcvRVOyqZ0akXezBYPlscWZCZM92DZda5W
	 AVphlhK2eu4lr7c/7AYVTaxmSKbLFAMYO3Oja3ZA792tNdaz2iXO7yWQ8+Qw5ALERu
	 I0XUqVBaULGtw==
Date: Tue, 22 Jul 2025 09:26:58 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kyrie Wu <kyrie.wu@mediatek.com>
Cc: Tiffany Lin <tiffany.lin@mediatek.com>, 
	Andrew-CT Chen <andrew-ct.chen@mediatek.com>, Yunfei Dong <yunfei.dong@mediatek.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Hans Verkuil <hverkuil@xs4all.nl>, 
	Nicolas Dufresne <nicolas.dufresne@collabora.com>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
	Sebastian Fricke <sebastian.fricke@collabora.com>, Nathan Hebert <nhebert@chromium.org>, 
	Arnd Bergmann <arnd@arndb.de>, Irui Wang <irui.wang@mediatek.com>, 
	George Sun <george.sun@mediatek.com>, linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, Neil Armstrong <neil.armstrong@linaro.org>, 
	Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>
Subject: Re: [PATCH v1 7/8] dt-bindings: media: Add MT8189
 mediatek,vcodec-encoder
Message-ID: <20250722-lovely-mustard-scorpion-e07e92@kuoka>
References: <20250721105520.5625-1-kyrie.wu@mediatek.com>
 <20250721105520.5625-8-kyrie.wu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250721105520.5625-8-kyrie.wu@mediatek.com>

On Mon, Jul 21, 2025 at 06:55:19PM +0800, Kyrie Wu wrote:
> Add MT8189 encoder compatible string, which will reference SCP device.

And the device is not compatible or is different because of what?

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


