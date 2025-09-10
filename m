Return-Path: <linux-kernel+bounces-810707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51197B51E2A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 18:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C2FF5E5AD3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 16:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C2D27B35C;
	Wed, 10 Sep 2025 16:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LgNFlrZc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B396279792
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 16:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757522854; cv=none; b=tTTo/U0crPuA/Tg06P5IMjKO/ngAJFq20n7M5J+tSKJnsDajQX1njGa+Hwr51LiRC0GBdvkbrz3VeiVbI5otZsrYVTXNyM3irbypTlgCqDuqszSzyPW90AnMVqsgzuQpQ5osPGpwhk9FC68wt+gx8MLwP09+cRYnvi8JjLTZhj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757522854; c=relaxed/simple;
	bh=/rJmYucUdGKmDKQq0bsceywau+72JwU/Oc4FczQ5d/U=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WaCqtlhpYxf5JZ19E7Wenr6ZR37cEtoeQJLGjcaVZ7jlbIMmgfodObNgXt3boRwXpCCQypc7wKIm6Opd8QP9ma3YC1vZMV5PwnMzKa6yDCeSo5vcCu59gzZxs7I0AXTwY8b69cd2pAxIkd7iAVz4FE0Js5u3wnd+B5qBH7X36+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LgNFlrZc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 424B5C4CEEB;
	Wed, 10 Sep 2025 16:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757522851;
	bh=/rJmYucUdGKmDKQq0bsceywau+72JwU/Oc4FczQ5d/U=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=LgNFlrZccc+8I2WJA4iEs2itRnOo2wIcwKCG5s9QE0CZRKGIYbzwdrQV4YBpE0kkM
	 wwAmQE8VELXd9809tTbkJf86FCcoqFKjayHqDaAHZ9HodCkbaEhZJ6GXlDSM/wwEQj
	 JYcyfRqkifbhD+SndVzqMBDFebaORgpTsqqLOXWDYjsU0LcEAAcRyhuj4WEfVBwrll
	 Pg5ls3p+pBAHDhp9WFhYVtL6UDD7I/7bQR89dPjnhWMunXazzWToDmGd1uBbcRdHPX
	 HtFT58HBmcHjN14fD7+6JEWxwRwEuqljdYLwKrgtPGRoBLiC6+mwp4XT6Z0qZ3P+gc
	 IIq+rLaogui9Q==
From: Vinod Koul <vkoul@kernel.org>
To: kishon@kernel.org, u.kleine-koenig@baylibre.com, 
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devarsht@ti.com, u-kumar1@ti.com, s-jain1@ti.com, 
 Harikrishna Shenoy <h-shenoy@ti.com>
In-Reply-To: <20250807052002.717807-1-h-shenoy@ti.com>
References: <20250807052002.717807-1-h-shenoy@ti.com>
Subject: Re: [PATCH v3] drivers: phy: cadence: cdns-dphy: Enable lower
 resolutions in dphy
Message-Id: <175752284884.484319.2656342366010993504.b4-ty@kernel.org>
Date: Wed, 10 Sep 2025 22:17:28 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Thu, 07 Aug 2025 10:50:02 +0530, Harikrishna Shenoy wrote:
> Enable support for data lane rates between 80-160 Mbps cdns dphy
> as mentioned in TRM [0] by setting the pll_opdiv field to 16.
> This change enables lower resolutions like 640x480 at 60Hz.
> 
> [0]: https://www.ti.com/lit/zip/spruil1
> (Table 12-552. DPHY_TX_PLL_CTRL Register Field Descriptions)
> 
> [...]

Applied, thanks!

[1/1] drivers: phy: cadence: cdns-dphy: Enable lower resolutions in dphy
      commit: 43bd2c44515f8ee5c019ce6e6583f5640387a41b

Best regards,
-- 
~Vinod



