Return-Path: <linux-kernel+bounces-775879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BACB2C60A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAC556832D2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99FE32A3C3;
	Tue, 19 Aug 2025 13:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eR53X2GP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAA323AE9A;
	Tue, 19 Aug 2025 13:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755611034; cv=none; b=ALG2XU2ciIs2HFm+/eUiupr/qMEj/a3NFEhqEV4DUow8PAacZtCbMcf8FEAyl78atzRw2YSsXvPde+//E7g1ZCCXV1ARU0hM2vu0E3RxZ9YliparNUrZv4/zLifhNGR882sRo62yk7mMAyEZsLQ5OLXIQGD0cT0OwtQLKiQFox8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755611034; c=relaxed/simple;
	bh=pEwO34vKa2AleMQxAgTE9E4vXP3EDfO6zZ6fVuuOPvo=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=qrw4zHszzjeVUbEIsFKZTp8k7D/USmU8uqEfgKJm7Gcldpxk3053TFQuM5MQIlfScN3TKzivuu4FBRKIfBq6Ex54gZgIwGNJLY5eGlrpfc/3lDHkZ73Ov4VvmPaR3M2BRLKvIainLAfTbdrO+IMR36VpkLot3XBterkBjWyLxik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eR53X2GP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 280DBC4CEF1;
	Tue, 19 Aug 2025 13:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755611033;
	bh=pEwO34vKa2AleMQxAgTE9E4vXP3EDfO6zZ6fVuuOPvo=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=eR53X2GPOQPsfjZwCY2EBzUTjs+oBSEWMWqnwwNyRFf4r+dzc+eaC9qBm95oO6Z3Q
	 /0TKaglW+xZgVyQ7Ux0+6Lchhbz4RyGEHain2Exu1EsXXU2efP9R90ZNcJlu+9vm7p
	 zOp5/J04pvaDkU2316gM/nZ15zG8JDkGLieNeuONP1a/8tSuXQs1NgyCIi+PuSdB81
	 ujICr2b83psFhfTMxbz4f54ApLcnyrAtLWXC9pZgaYcjG/gq7CDRxPFAKQym30YHZp
	 q79VBcDUx3MCqetZHZ/X3gNbwkOych3lpv7s9ddlvn5pOkGAQ2rl+6VE5uhqYMbzKN
	 67PxJhuR+F0Mg==
Message-ID: <174f1c2e07d59e49996d88bad8e471fd@kernel.org>
Date: Tue, 19 Aug 2025 13:43:51 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v2 2/9] drm/display: bridge-connector: remove unused
 variable assignment
In-Reply-To: <20250808-drm-bridge-alloc-getput-for_each_bridge-v2-2-edb6ee81edf1@bootlin.com>
References: <20250808-drm-bridge-alloc-getput-for_each_bridge-v2-2-edb6ee81edf1@bootlin.com>
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

On Fri, 8 Aug 2025 16:49:09 +0200, Luca Ceresoli wrote:
> The 'bridge' pointer started being assigned and used within this 'if' sco=
pe
> in commit 0beba3f9d366 ("drm/bridge: connector: add support for HDMI codec
> framework").
>=20
> After that, commit 5d04b4188959 ("drm/bridge: split HDMI Audio from
>=20
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

