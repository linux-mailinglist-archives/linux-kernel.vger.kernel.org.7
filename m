Return-Path: <linux-kernel+bounces-725152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63788AFFB68
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 09:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 461255407FD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 07:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97BE28B7C7;
	Thu, 10 Jul 2025 07:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZjisULI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3679928B4FA
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 07:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752134090; cv=none; b=S9AnMtpI1AqtdWTysNz1xmRnC0mAgvsjzgYyiZHUZm3ntVJZjCZzpm3PyASVtRHhY++mqYbjOVSRxR6IgE4lrZxOcztgr/ikQ1hUhuL72ECO9MaTdeQLoNNnkTRRs4YJ2IqzT+uYX5198XmrfrQ9q4ePnmHwh5lkR9Ei1x6iE7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752134090; c=relaxed/simple;
	bh=eXSl8bjCjU1L5SLY+H6M5Dz42CkLWVlyk69+k1VhgRE=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=ZqMZD2VhgxMfnfffRkG4AVjQRDqVHcupOqVZEd62C90DPDXBsnRO2/5gc5CgKDEnpX5H3DHUEnyaTKu6QB46naelkTNY0w8gMkfcqay5sZrXkLe7U9oP6jolsJVgpme1tIrGsfqSyhQfHxyyhdjKB2AzPyB2e8I/bBy4AudrZ00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZjisULI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 053CDC4CEF9;
	Thu, 10 Jul 2025 07:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752134089;
	bh=eXSl8bjCjU1L5SLY+H6M5Dz42CkLWVlyk69+k1VhgRE=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=PZjisULI1PKs1YMYdRGmn9zN/XPVP9ytBtdWZCaeAg6+wDgz/wK3w16tYfHNr3dGc
	 NoE+rcDcNegIavSmOZ4KBUJ8yrOeCUjBB6fy+5bbXNuq7+QYjcRgcYhvNx7JcVwcca
	 4/NZ4GUELDBB25zj6usP4yomgnDhf+X8hK8wtrZH39RWvSvIW47jK8R6fl63nvYu4H
	 hGefoO7vkZ/FjPfG9HBCmDs4IVQLTlEj8sKiu1/3vgyxsxwYRSF+fIf5igWysMR9Ci
	 S1bbYsueXIOGRv4yOtUxADXmP6Q4C3PWi8VwRmDlSeVnWip2DBetYNLLTDMj6lyh+5
	 jubxDGhscurtQ==
Message-ID: <a599626ffe0fff92bead9f693c1a0090@kernel.org>
Date: Thu, 10 Jul 2025 07:54:45 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH 2/3] drm/bridge: select_bus_fmt_recursive(): put the
 bridge obtained by drm_bridge_get_prev_bridge()
In-Reply-To: <20250709-drm-bridge-alloc-getput-drm_bridge_get_prev_bridge-v1-2-34ba6f395aaa@bootlin.com>
References: <20250709-drm-bridge-alloc-getput-drm_bridge_get_prev_bridge-v1-2-34ba6f395aaa@bootlin.com>
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

On Wed, 9 Jul 2025 17:59:38 +0200, Luca Ceresoli wrote:
> The bridge returned by drm_bridge_get_prev_bridge() is refcounted. Put it
> when done.
>=20
> select_bus_fmt_recursive() has several return points, and ensuring
> drm_bridge_put() is always called in the right place would be error-prone
>=20
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

