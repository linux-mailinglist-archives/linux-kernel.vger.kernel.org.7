Return-Path: <linux-kernel+bounces-875530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B0EC19486
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 427C13BAD8B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23B6313277;
	Wed, 29 Oct 2025 08:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RyAcP7gV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB491917F1
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761727394; cv=none; b=UF9cfmfmNxLN451odDxUY9KNd7XiFmXU/EgvTeWL2YoiJnbRLrrF/9EaPSV2gDlcwPdG6X9VMGkK/I5Zgjz2VDc70PBwhAZIgm3vppmDhr2+wu788Z3/3WVBrOmrW5oHxHYeSptLCYhW3MowVDdZdCv0GuS9OiLt8uQUOC998AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761727394; c=relaxed/simple;
	bh=TsAISoVUqtst65vqUQebjmquWAzfVyJVFtTnSr4s+T4=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=gCVFlqjVV+MN4VITXvlUo/I02tT+YEyxmR92MQHWxEmZepU54lkkZeZXe1lUMqaFDzotukvY7G+TM2yW00u4692q0JoyFeNnPz+P71TNqYeCXCybNIhMGWiL+0PUPsP7VzuMso8KAJgi+GK4N2PTpa+0tKm5lKN5utmQMIqUtKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RyAcP7gV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 127F9C4CEF7;
	Wed, 29 Oct 2025 08:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761727393;
	bh=TsAISoVUqtst65vqUQebjmquWAzfVyJVFtTnSr4s+T4=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=RyAcP7gVXZFNPQAsCV3fjeXrb6DWMxwyBHv60k7g/IpMeuveDonwJYWyVcCTOsW8l
	 bYcfKgEzinTOlVnrwEuE5SIQ/t2DoIuGqWtbCF0nHo6c4PZH6qKuHZnuE8lGPI3e3E
	 40uvP8xbrmu5nPuVoszlkMxs+/tr+SGzLBfrY8F3HVz2Q5GS4s2ms/XUIsO/LPPxVQ
	 +N32q52Qtp7KadT5L4sIbAoO+VVs+bPMLVZLJP8wkHeg38g6B37YcLS6FVgiMqNKmj
	 qAoHGHnEiruZC1s0q4Gq7Rp8F3tTRwYcFTbS1LAZ4oDZiOEVEd0Z0+T6axO0YJnar2
	 gquNOqq9YdAsA==
Message-ID: <4e131b012f2866cffc3a49669db8e98c@kernel.org>
Date: Wed, 29 Oct 2025 08:43:10 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v3 3/6] drm/bridge: document that adding a bridge is
 mandatory before attach
In-Reply-To: <20251028-b4-drm-bridge-alloc-add-before-attach-v3-3-bb8611acbbfb@bootlin.com>
References: <20251028-b4-drm-bridge-alloc-add-before-attach-v3-3-bb8611acbbfb@bootlin.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, "Alain
 Volmat" <alain.volmat@foss.st.com>, "Andrzej Hajda" <andrzej.hajda@intel.com>, "Andy
 Yan" <andy.yan@rock-chips.com>, "David Airlie" <airlied@gmail.com>, "Hui Pu" <Hui.Pu@gehealthcare.com>, "Jernej
 Skrabec" <jernej.skrabec@gmail.com>, "Jonas Karlman" <jonas@kwiboo.se>, "Laurent
 Pinchart" <Laurent.pinchart@ideasonboard.com>, "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime
 Ripard" <mripard@kernel.org>, "Neil Armstrong" <neil.armstrong@linaro.org>, "Raphael
 Gallais-Pou" <rgallaispou@gmail.com>, "Robert Foss" <rfoss@kernel.org>, "Simona
 Vetter" <simona@ffwll.ch>, "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Thomas
 Zimmermann" <tzimmermann@suse.de>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Tue, 28 Oct 2025 11:15:44 +0100, Luca Ceresoli wrote:
> At the moment it's not documented that you need to add a bridge before
> attaching it. Clarify that.
>=20
> Suggested-by: Maxime Ripard <mripard@kernel.org>
> Link: https://lore.kernel.org/all/20250709-sophisticated-loon-of-rain-6cc=
dd8@houat/
>=20
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

