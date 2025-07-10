Return-Path: <linux-kernel+bounces-725151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A270AFFB65
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 09:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A02A94A79FA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 07:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7218928B4F8;
	Thu, 10 Jul 2025 07:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zu/ggh5p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26921E515
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 07:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752134067; cv=none; b=MyMY0sijsfiZ5JIwGpBPlkZ9qrUvnARze0vAW46vrpjnXaOyQiOjNVDOa3ptEAj2IgFu3805qoSF3/WuIjjLfhekUzLefSBue6ZGn0+5/iKr+AeLXbSqKWuWdHj1jaobz+85ejFvM1bvjli5/CtU/oZmhYWw8UwiuHG/jYUMJzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752134067; c=relaxed/simple;
	bh=Nkb7eiW3DW8HrJqIgBjo47OJwQQEx2ENdayhmRHj9co=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=RrWyplPHmc+e6BrkJLuBrqmULY0hKPqxoiRcSiLd5HNhOjsfPktPDxBNNcaXyBFUruplKoXJj+ryYP+61BdvKFnu0gLD0CZzNbBceCmgruFkho4mC8LIPNRfq22ovcJsAG/5H+OLFKDEVvDBQFCfdQ+BNna+rI2y0BYYgjChn4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zu/ggh5p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC061C4CEE3;
	Thu, 10 Jul 2025 07:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752134067;
	bh=Nkb7eiW3DW8HrJqIgBjo47OJwQQEx2ENdayhmRHj9co=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=Zu/ggh5p9xjdhaJqu8gwF2UchcWfpeNFOKmpSOWEuT37buAqUsp9Ulq7kdq5Bb54D
	 +wF2PYrwopPg4cJdNyppQKw9bJmh4GjkQfvPudOSNgUcYcJIrNC6o3JeO5h2p+FqG0
	 DCJ1ikhYAtE0rgP/k8faKAEbp8oa5pg8K4lpYusTwJEBFPjnKW4BTmW3EIL0CqlE4v
	 oWuvOyHrh/Dxww/WYTV24qDkrnCsUWstootNxy0Lq36e6Ke5h9COcXSTXgu5CoIivK
	 YIYoCgLN+/spKLYY3Rv+b0fOKHCFAGtRimJR7XlqMgOdRQEZl1vwQXF5ZBhhhq2jlC
	 Tnr6/qTYy7YBg==
Message-ID: <94ded7709abf1f21d5c1022691da149d@kernel.org>
Date: Thu, 10 Jul 2025 07:54:24 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH 1/3] drm/bridge: get the bridge returned by
 drm_bridge_get_prev_bridge()
In-Reply-To: <20250709-drm-bridge-alloc-getput-drm_bridge_get_prev_bridge-v1-1-34ba6f395aaa@bootlin.com>
References: <20250709-drm-bridge-alloc-getput-drm_bridge_get_prev_bridge-v1-1-34ba6f395aaa@bootlin.com>
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

On Wed, 9 Jul 2025 17:59:37 +0200, Luca Ceresoli wrote:
> drm_bridge_get_prev_bridge() returns a bridge pointer that the
> caller could hold for a long time. Increment the refcount of the returned
> bridge and document it must be put by the caller.
>=20
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
>=20
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

