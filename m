Return-Path: <linux-kernel+bounces-878603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E4EC2113E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32F2E3A975F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F8E2367D1;
	Thu, 30 Oct 2025 16:00:16 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4041DC9B5
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 16:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761840016; cv=none; b=Y6UBpU3LXdMi2gypU7yEmZ6CW5ITfHzDAn7BZGzoMDyqVRhOnwC2YEXJxRgmsT4jWTxOiVrD1zjRdUTixKQpfkGj/pSCF6iLuKFmtlrhGTkQECmPWcVzgYfMjvlT7W1mDwXDCHZ9nNSxOEtCmTj9z3dXkopM7X2VbjvNsU4C6MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761840016; c=relaxed/simple;
	bh=Ky4Q60KcF9tVrnVev4zZPdHy1WTFcz9x/SsAdn3+7Gs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q1US/WDLGCti9WoILzVk7LEQ9R7Rn1ZI0d8hlQdge3G3TUN5WirrdgltYo8T7Gx5BwcpTnoJG6Y9OrDxe+FcgUa/dbF+fdtmPAVvtZie5q0BZl3pmLRsDK6XzwjeIfOwALD4vAN8q1IX6pmQtJFnWEjZMxjfw6oxvvwPuaa4nrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vEV4A-0004VY-QL; Thu, 30 Oct 2025 16:59:58 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vEV49-006Egv-2T;
	Thu, 30 Oct 2025 16:59:57 +0100
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vEV49-00000000DJV-2o09;
	Thu, 30 Oct 2025 16:59:57 +0100
Message-ID: <b8b2ae426c8f79664f5b54c5ddb4511a086d3c86.camel@pengutronix.de>
Subject: Re: [PATCH 0/2] drm/imx: parallel-display: fix
 drm/panel/panel-simple v6.17 WARNING regression
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>, Ernest Van Hoecke	
 <ernestvanhoecke@gmail.com>, Maarten Lankhorst	
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Shawn Guo	 <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
 <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, Thomas Petazzoni
	 <thomas.petazzoni@bootlin.com>, dri-devel@lists.freedesktop.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 30 Oct 2025 16:59:57 +0100
In-Reply-To: <20251014-drm-bridge-alloc-imx-ipuv3-v1-0-a1bb1dcbff50@bootlin.com>
References: 
	<20251014-drm-bridge-alloc-imx-ipuv3-v1-0-a1bb1dcbff50@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1+deb13u1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Di, 2025-10-14 at 13:30 +0200, Luca Ceresoli wrote:
> This series fixes the WARNING regressions reported by Ernest [0] and due =
to
> the missing conversion of the DRM_IMX driver to the new
> devm_drm_bridge_alloc() API.
>=20
> The second patch also adds drm_bridge_add(), which is a good practice and
> proposed to become mandatory [1].
>=20
> [0] https://lore.kernel.org/all/hlf4wdopapxnh4rekl5s3kvoi6egaga3lrjfbx6r2=
23ar3txri@3ik53xw5idyh/
> [1] https://lore.kernel.org/lkml/20251003-b4-drm-bridge-alloc-add-before-=
attach-v1-0-92fb40d27704@bootlin.com/
>=20
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Applied to drm-misc-fixes, thanks!

regards
Philipp

