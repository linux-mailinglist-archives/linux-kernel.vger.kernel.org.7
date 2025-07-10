Return-Path: <linux-kernel+bounces-725155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B19AFFB6F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 09:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 201BB7BFFE1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 07:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D3928B513;
	Thu, 10 Jul 2025 07:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FM6534TB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9705C286D60
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 07:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752134101; cv=none; b=WAxdgncLsl0t6MGCJy8RQxpxOAKt1hFFHmE+jxO9pg40rERwO8OsCFHgVVM9ML9G6LafjRvT3cKXvLxAO5RdboxE88Yp3h96rOFsfF1sauayXrvuD1U6L6G7rfzOqYpUMi/AHDyz91Ygghs2CxSIsRDiwGaE2TK5ERrpeJbn/cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752134101; c=relaxed/simple;
	bh=miC9ULvehpVK+bWFsSxBlt+WLo0btkBVIubocwNZI6o=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=eAXq8vM96BUN5wvZ+9qnWhKsTT1UQ4P9klRWpGur5cf27+6MdsXWN0DWRtX6pDLe8MXriOlk7bCTvK0cWMqmrSYwX+YeSF92iqHhz/29EyeynHnurGcwzUJJnzGLvTIOqVxOqvqhSEVhqowfO17/M+FctCA38QDR/Iym1nmTjDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FM6534TB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CAE0C4CEE3;
	Thu, 10 Jul 2025 07:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752134101;
	bh=miC9ULvehpVK+bWFsSxBlt+WLo0btkBVIubocwNZI6o=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=FM6534TBp/dZa+q1OJNW4Nfhqqvrf4xMtLZBGTv3Ry0Jl93UewiIybj0RNGTC7Tjf
	 6PR/Z4yFlQ9Vsu+/HHZH3S76dnwUCSg15QDJC5USE1gVNi10tvR7iq36U9sIzKyBbK
	 hPoQc6yDrBoIcC3BYVbDOjZVwkaW+6H2/I1KFAoXAWaO0h8qyum8U1UsGC/fuo8gqh
	 XN4nD8by+RJm5LhS7Udy48izYkaRohq+FOpPbpyJDPx4TyLhZZ/nibwTKtFio824bX
	 rzVizmL95en6GlXrHfJ8zf5DCIvaf/A28ljlilXFaLcl8IrY+mOLGaxmum0BEaCRbw
	 SbnPmttCneE3g==
Message-ID: <79541d9510b217170c8f66d6e3fefc22@kernel.org>
Date: Thu, 10 Jul 2025 07:54:58 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH 3/3] drm/bridge: display-connector: put the bridge
 obtained by drm_bridge_get_prev_bridge()
In-Reply-To: <20250709-drm-bridge-alloc-getput-drm_bridge_get_prev_bridge-v1-3-34ba6f395aaa@bootlin.com>
References: <20250709-drm-bridge-alloc-getput-drm_bridge_get_prev_bridge-v1-3-34ba6f395aaa@bootlin.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, "Andrzej
 Hajda" <andrzej.hajda@intel.com>, "David Airlie" <airlied@gmail.com>, "Hui
 Pu" <Hui.Pu@gehealthcare.com>, "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Jonas
 Karlman" <jonas@kwiboo.se>, "Laurent Pinchart" <Laurent.pinchart@ideasonboard.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>, "Neil
 Armstrong" <neil.armstrong@linaro.org>, "Robert Foss" <rfoss@kernel.org>, "Simona
 Vetter" <simona@ffwll.ch>, "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Thomas
 Zimmermann" <tzimmermann@suse.de>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Wed, 9 Jul 2025 17:59:39 +0200, Luca Ceresoli wrote:
> The bridge returned by drm_bridge_get_prev_bridge() is refcounted. Put it
> when done.
>=20
> To keep the code clean and future-proof use a scope-based free.
>=20
>=20
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

