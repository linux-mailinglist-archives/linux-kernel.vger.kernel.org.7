Return-Path: <linux-kernel+bounces-875533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A266EC194CE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 645DC505474
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4599331AF3B;
	Wed, 29 Oct 2025 08:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tZKMjCpi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CC130E0F3
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761727535; cv=none; b=U4cuNlFI+XmOd3QsVigw273ALsJZemONICUr2iIIJGx78OLc8Mz3iwUfHOuysrhe89MB1ru+8NiftD69Dni43WGDidC0MTSzGf3+I/PL0QXU4X22DsZ1zMZ+mgpbH/GILzryVjgmsJYEFCIKtzQBR5D0bI604TLx1yE/CAT1P1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761727535; c=relaxed/simple;
	bh=0YDrlEIqPkATDsNKVJHLVSFx1NWe0IWJ4rc0ZhZJzXA=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=d9g/6soAogQQl4Rzxy6XB/ANW3/dkRkb8lz6FXQVr+43rkpYQvzER8iJ2IrKaW8yyrlmFfwhJtl5EtyJN9FKiVPvfmmxr+5D9S8uy19Z99ClX12nGkLrvIp4DBmaYFtUyoE7QsLF67B5TOfYcnyeF7onbeoIAo4cg5KlN5zFO8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tZKMjCpi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8CADC113D0;
	Wed, 29 Oct 2025 08:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761727535;
	bh=0YDrlEIqPkATDsNKVJHLVSFx1NWe0IWJ4rc0ZhZJzXA=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=tZKMjCpi0P3TR7OLQI+zp7gGpcjGIYSo+Laew3ta9//+kD9YhSPLOn7xsG5IyfsiI
	 18AV+SfmQT3vUrPAWg4Fz6rFbe0ped/+htVhv9BOifUsgZ5qs7798uig+Hg0ug2Pw7
	 qjdfIiQXzvkNVdDfseGRWDLe/w29omj9Lv5bDTe3Ne9T0WcGFklUtXPxi/v6ZJ75zm
	 2Bs2JbWo8QcoLfWQtaAyVR6tlt8n0YUvN1e1uL+fQZT88snGOUZPXojhooAlocgOh6
	 oo24C3sUDqq6+G7HCnKeRy4Na4gE7S83kQGbnGwPs0rhwjNnwAu6tK1lWGdjEgTHg2
	 e9YEVFDmgUn/w==
Message-ID: <fa56698c6e13b7bd1aedb99d393bb5f9@kernel.org>
Date: Wed, 29 Oct 2025 08:45:31 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v3 1/7] drm/encoder: add mutex to protect the bridge
 chain
In-Reply-To: <20251009-drm-bridge-alloc-encoder-chain-mutex-v3-1-c90ed744efec@bootlin.com>
References: <20251009-drm-bridge-alloc-encoder-chain-mutex-v3-1-c90ed744efec@bootlin.com>
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

On Thu, 9 Oct 2025 13:38:56 +0200, Luca Ceresoli wrote:
> The per-encoder bridge chain is currently assumed to be static once it is
> fully initialized. Work is in progress to add hot-pluggable bridges,
> breaking that assumption.
>=20
> With bridge removal, the encoder chain can change without notice, removing
>=20
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

