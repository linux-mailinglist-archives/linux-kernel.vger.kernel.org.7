Return-Path: <linux-kernel+bounces-875557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 926BDC194B0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 18392585CEA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44C231DDB8;
	Wed, 29 Oct 2025 08:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WEV4PnwV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D6B3126A1
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761728095; cv=none; b=l2l6HjjfaPGqG+edPfCe6Yc115IUGp5qPZ3tspLNMAdiLaDAADJkVT62yqsa6vHxQFuwMJs84rGp45GvEOwkXRy+PiMaTYTo4/zwA51oaxQssqYVixXQBF8CKTtHRc4QsVlAUyXup626aHkNMxcBIhhMLurKP+X+TKoJ2Wmgu+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761728095; c=relaxed/simple;
	bh=Dy4WiiEp2hDTLOfWgfOlVvW3TTdWJu7jpfAlJ8GtIl8=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=rsB3QkQ9EVkrrnUyOEWI0TQk7ZQ1FhamdHOxJ63IhxtG8b7HTR/r7R6g3ra0lVFErREzrIxBZxCzTiFjXbeNUjuQXsFaA7/hMGGSZW2ruIT682gHSfCaBiim5G4mc4/LulkghDuD+f9t1TAVX63vcqEp+r5rHpFfjLWnbSesQlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WEV4PnwV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C5F4C4CEF7;
	Wed, 29 Oct 2025 08:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761728094;
	bh=Dy4WiiEp2hDTLOfWgfOlVvW3TTdWJu7jpfAlJ8GtIl8=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=WEV4PnwVugjI4eYTb5D3Xn5Z4SpWwhIIgtQ6bhBAO5Gg+jfKiUPa6QqTDBVz2RpRk
	 kKbesQHYBsFKN3TodcNKNGbZ5TtT+qvKc/PDikJ6NLVp+eSB4YWfLPu5hei1tBbkVu
	 KsiIYA2AbjSgTgwKdUo46yC63JIcaEfkHZSoDNnQQqyfbRxdjaAHDMBiX8IoUs83ln
	 E/I8fAxI66UjB3g1xEz/e3+S921y55JmfwSU8n2lUjThdw95a/zd0XnjEKJ3PP5o2c
	 Z6TuDl1jusd6p/YiCR9aqvNO3uLyvOcvAsmp/0t7vm9/A8WkM9plbb6odoVrl2bdoI
	 QIcQLK4QqmxXQ==
Message-ID: <312c3226cd0581d00b39db8daea69417@kernel.org>
Date: Wed, 29 Oct 2025 08:54:51 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v3 3/7] drm/bridge: drm_bridge_attach: lock the encoder
 chain mutex during insertion
In-Reply-To: <20251009-drm-bridge-alloc-encoder-chain-mutex-v3-3-c90ed744efec@bootlin.com>
References: <20251009-drm-bridge-alloc-encoder-chain-mutex-v3-3-c90ed744efec@bootlin.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, "Andrzej
 Hajda" <andrzej.hajda@intel.com>, "David Airlie" <airlied@gmail.com>, "Hui
 Pu" <Hui.Pu@gehealthcare.com>, "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Jonas
 Karlman" <jonas@kwiboo.se>, "Laurent Pinchart" <Laurent.pinchart@ideasonboard.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>, "Neil
 Armstrong" <neil.armstrong@linaro.org>, "Robert Foss" <rfoss@kernel.org>, "Simona
 Vetter" <simona@ffwll.ch>, "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Thomas
 Zimmermann" <tzimmermann@suse.de>
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Thu, 9 Oct 2025 13:38:58 +0200, Luca Ceresoli wrote:
> drm_bridge_attach() modifies the encoder bridge chain, so take a mutex
> around such operations to allow users of the chain to protect themselves
> from chain modifications while iterating.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

