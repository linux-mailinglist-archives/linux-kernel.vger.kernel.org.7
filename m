Return-Path: <linux-kernel+bounces-875558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B6582C19525
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 98E67505D50
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E7531E0E4;
	Wed, 29 Oct 2025 08:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bezlEPpR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84C91DF271
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761728124; cv=none; b=l0fZEJhh4X1va0irUccs2K9qg3vGdQd8qv9RfAGUneg2jQddqOf1xlId8UPPSPYmNuAu25ARFBm/kpzy/VmpI52Guxjx62Gvkf+XmCU//v2opmtEFzPmpxp+Gb+iQJwMEj2sGyVj4SKDa+TLKbqX1LXc/tqZlg2BBHrKY2ZJ4uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761728124; c=relaxed/simple;
	bh=phEg2pXqRD3Io5OWcNnG6saaAlBTyp0EzBzi9+EOrK0=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=LhloJsrezfHsekSL65bpRhpdAp1YpnqcqfjiNFy/ZT8SUIEhDGp+DNPkw7plwn/n5lEZjZvX0+XompoOfDgufLJFWiOCjcb+FYVEZdtAh0edlM7j/+Ceir8jBG6L0FiLY10oW4Bb8VSiclE2Ljt6t/aWre++y1YHHtenL2EgNb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bezlEPpR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5435C4CEF7;
	Wed, 29 Oct 2025 08:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761728124;
	bh=phEg2pXqRD3Io5OWcNnG6saaAlBTyp0EzBzi9+EOrK0=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=bezlEPpRBkgqkc10mB7ahmvPgLeCkHYle2USV/V0UykGaC6vHavgDhl/tslGl4m6N
	 wX0l2QxaAyfoLf3oCNEyNGaonRbOeRfVTbTHMVaMCeiX6PSsawdp6zC11ksjyM2WbN
	 lRYF/JsHo7IvMp6CYqdYtqfDE9X7MCQaSQEQjZ6LM29P+vEeyVLvvKdYzZhyEM1kKd
	 Xh+tXYLJjeBaNJNWiE4X4HMTVEvrY724HGD3XOj7tTM0bavnt5Z8nT+lW88JRjpOME
	 DHAzcPHyjHDz3O/VgQgyWRrlpNCSCtCkqOuNiByEg0w7QH75+0AL+ogMfc9Qsb4muv
	 7gAjUZa5FMGNg==
Message-ID: <0c0b84319f96b5d2a32bbae473e5758e@kernel.org>
Date: Wed, 29 Oct 2025 08:55:20 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v3 7/7] drm/bridge: prevent encoder chain changes in
 pre_enable/post_disable
In-Reply-To: <20251009-drm-bridge-alloc-encoder-chain-mutex-v3-7-c90ed744efec@bootlin.com>
References: <20251009-drm-bridge-alloc-encoder-chain-mutex-v3-7-c90ed744efec@bootlin.com>
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

On Thu, 9 Oct 2025 13:39:02 +0200, Luca Ceresoli wrote:
> Take the encoder chain mutex while iterating over the encoder chain in
> drm_atomic_bridge_chain_pre_enable() and
> drm_atomic_bridge_chain_post_disable() to ensure the lists won't change
> while being inspected.
> 
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

