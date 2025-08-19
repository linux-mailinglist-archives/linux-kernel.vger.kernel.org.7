Return-Path: <linux-kernel+bounces-775877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B71B2C606
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A5F33BD13B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E3F33CE84;
	Tue, 19 Aug 2025 13:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ih5KrQAg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B30123AE9A;
	Tue, 19 Aug 2025 13:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755611012; cv=none; b=sutuKBtwEjDwanr+FZQidIZPgUpl9GMG0i3V5hdq1ALMpW5As/D/VdqrldT+74wprlVk/lk84gtlEdq9GdhWLfJbsA3UgDrGFOYze7Nk1+YXdYa4aUl/DNXDHyS3TiBSP1xKjShpu7/pbpTTJ/Vb9Fwk5pGNBq89DJERdbX8pVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755611012; c=relaxed/simple;
	bh=26yGzcpoEMSGrmdlxNcFoAgjBUvz7SP8XHQo/OesNlU=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=PJyXNm9dVsNh5fW9NWy3Wm0/PBXqwuatSOL/2azOS8opro/BjMf1UK8lPLQdaFHOAkpY27RN/caATFfVPkjj0YyFJPsuai2L80/KBn6TzSty4s6QRpbm68GyZxlSap39kfCP+UY48KZgMeTubzndFo7VEIwLsKXv+M4wHbGixQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ih5KrQAg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9335DC113CF;
	Tue, 19 Aug 2025 13:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755611012;
	bh=26yGzcpoEMSGrmdlxNcFoAgjBUvz7SP8XHQo/OesNlU=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=ih5KrQAghMQipKwCv3CPpu9ILPwXk74370NIfZ4Xw6s2a0G2Ve2ctgh/nohKO5S8P
	 r1p5B1mjnbqsVFjyS8cTMqUhnjHQvjyTcOD9q6woTvJoiBXAjjyvKrLecdB56dApKg
	 3cACFEapvKWVlL+K8DYJnQ3KCPqb8sDYKjjVjsSR4KDohjL38uAFiRm0REpkwkULXH
	 5DLb2QD/2c7cC+sCrQHzT1fOrCUkH2glqgsuC43yEhaVWer0v78tQwJ1E43mtFDbB7
	 H5oFTSuPzpPSwzDlk1ZQRzP6y7JGKpUnkVMeNcIk1BFXc2lS/hBmO44KBdYlYlSrHP
	 Z6794vLZioVfQ==
Message-ID: <d50ed50aa1f09f27421fa7bf8d0e84c2@kernel.org>
Date: Tue, 19 Aug 2025 13:43:29 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v2 1/9] drm/display: bridge-connector: use
 scope-specific variable for the bridge pointer
In-Reply-To: <20250808-drm-bridge-alloc-getput-for_each_bridge-v2-1-edb6ee81edf1@bootlin.com>
References: <20250808-drm-bridge-alloc-getput-for_each_bridge-v2-1-edb6ee81edf1@bootlin.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, "Andrzej
 Hajda" <andrzej.hajda@intel.com>, "Bill Wendling" <morbo@google.com>, "Chaoyi
 Chen" <chaoyi.chen@rock-chips.com>, "David Airlie" <airlied@gmail.com>, "Dmitry
 Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>, "Hui Pu" <Hui.Pu@gehealthcare.com>, "Jernej
 Skrabec" <jernej.skrabec@gmail.com>, "Jonas Karlman" <jonas@kwiboo.se>, "Justin
 Stitt" <justinstitt@google.com>, "Laurent Pinchart" <Laurent.pinchart@ideasonboard.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Nathan Chancellor" <nathan@kernel.org>, "Neil
 Armstrong" <neil.armstrong@linaro.org>, "Nick Desaulniers" <nick.desaulniers+lkml@gmail.com>, "Robert
 Foss" <rfoss@kernel.org>, "Simona Vetter" <simona@ffwll.ch>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>, "Thomas Zimmermann" <tzimmermann@suse.de>, "Tomi
 Valkeinen" <tomi.valkeinen@ideasonboard.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Fri, 8 Aug 2025 16:49:08 +0200, Luca Ceresoli wrote:
> Currently drm_bridge_connector_init() reuses the 'bridge' variable, first
> as a loop variable in the long drm_for_each_bridge_in_chain() and then in
> the HDMI-specific code as a shortcut to bridge_connector->bridge_cec.
>=20
> We are about to remove the 'bridge' loop variable for
>=20
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

