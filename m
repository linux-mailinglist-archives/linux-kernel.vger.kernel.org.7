Return-Path: <linux-kernel+bounces-746475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F957B12722
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 01:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6362584001
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 23:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173EE25C81F;
	Fri, 25 Jul 2025 23:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eUO6gcNm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA2722F767;
	Fri, 25 Jul 2025 23:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753485155; cv=none; b=hUvAC8qdhHGdQomHPiPQRBT5ySyupPoQZvYr0SIJlOKIWbNMgi62ySSnhQ/TkFt0VS3vhJe3Vr/wTVp/iOnBItHIpjtm7D1pALl5OoMOoGrayZNDLW3OyH2RuaYeqYczu/RqavaB2IA6qGygkGskDF4F+GZ0hX8+KRIIAhGHFYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753485155; c=relaxed/simple;
	bh=lKPeV4dbiMZgeOgy5vCWxzKkrNkCOUiKusQlfwyyh4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dwe8Ep+3E6WnFRQ8awZeT5YBoi8lQIrnu2c4rob0FhYzuqRxVBapbD3DuTL9aYjgzsLwk+hBwaU5UFeAuIZLabjbgc0G99H8Jy+3wdJh9n4aTQ8B2L7wLZY5JnJ7Ayg6plQq/GYmUBLOmKhRJXAeKikxsQtXiPYwc+QcedxvJFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eUO6gcNm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4F03C4CEE7;
	Fri, 25 Jul 2025 23:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753485155;
	bh=lKPeV4dbiMZgeOgy5vCWxzKkrNkCOUiKusQlfwyyh4g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eUO6gcNman3Vtu/exvEYRzEjR7cFwafa00xuS8x2urfr/gOW2Bj7tembJ35BQTYTM
	 sg1PZAIPVXEHqG9QluUBkbzuEdOZRuljdC6ARmZ8pyWDWdeVH5i0aatgDw3RtEdxEg
	 xpPlkVUvOHHg19vB7hidb0J5UytvvysKl/vIvKGSIUtThtJWJLydupBWpQiuEqjs+d
	 EzUemwm89JaJBGb4llfCrohBuQSTN0iG/CNdVtQYdI5LqZlXNTaLvXEVJPyV5Ma7mP
	 IiLffzZHtemi1ChCQZZQA3i9Qtc0PnkfDdorR1wTC+RJH5m1NC7GGDg4VXVy14umvk
	 lCRTefb+Hgb5w==
Date: Fri, 25 Jul 2025 18:12:34 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: u.kleine-koenig@baylibre.com, mturquette@baylibre.com,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	sboyd@kernel.org, krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org, geert+renesas@glider.be,
	kernel@collabora.com, devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org, conor+dt@kernel.org,
	matthias.bgg@gmail.com
Subject: Re: [PATCH 1/3] dt-bindings: clock: mt7622: Add AFE_MRGIF clock
Message-ID: <175348515340.2008768.1491160057381781606.robh@kernel.org>
References: <20250724083907.61313-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724083907.61313-1-angelogioacchino.delregno@collabora.com>


On Thu, 24 Jul 2025 10:39:05 +0200, AngeloGioacchino Del Regno wrote:
> Add the missing AFE Merge Interface clock to MT7622 to make use of
> it in the audio subsystem.
> 
> While at it, also remove the useless CLK_AUDIO_NR_CLK definition.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  include/dt-bindings/clock/mt7622-clk.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


