Return-Path: <linux-kernel+bounces-892525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A28C4547E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 08:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 348A63B30FC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 07:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DA82F39BD;
	Mon, 10 Nov 2025 07:59:35 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931882F39A2
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 07:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762761574; cv=none; b=EFFLELaI8mXBuMPsav3NvXb3u1Ptj7phZXe/L39wlqUGc661+aqF8OiY2H0/ssNv2OvhXz+QO5Bn6bXo8SVXrE/+wlzxPU5J6Q/WqGIKuJOJIeFVh1Q1KPCe7Lci8rG0rLB6Fko2f0TZ0Tj60B9PovGayWmZWXxXAXwZ8wg91cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762761574; c=relaxed/simple;
	bh=ALoc2laiN9Lk6R0K4xYu3wzinSET35u6DU0A5m1a1FU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IlYIWnC96M4Ti8rKptBv0l2+lmgCLLPKPtpo3JA9FCx8UFb89DCUn6ZyTZdL2fDkfjcfTP09pnnyRWdaEoyXO75DfK7206tfwydI43B9IXhITIRtfRpDegMKYc+5XEv3EAsOz3dgDhRTWbWodVTxvxXwjiByGUV4QDnLFCWlYog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vIMo5-0002z5-K6; Mon, 10 Nov 2025 08:59:21 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vIMo5-007z6v-0Z;
	Mon, 10 Nov 2025 08:59:21 +0100
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vIMo5-000000002t2-0Q1m;
	Mon, 10 Nov 2025 08:59:21 +0100
Message-ID: <6689aeb46b3aad11dca9e82d912d8f3d315fb8c1.camel@pengutronix.de>
Subject: Re: [PATCH 6/6] media: staging: media: imx6-mipi-csi2: use
 devm_platform_ioremap_resource() simplify code
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Frank Li <Frank.Li@nxp.com>, Steve Longerbeam <slongerbeam@gmail.com>, 
 Mauro Carvalho Chehab	 <mchehab@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team	 <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: imx@lists.linux.dev, linux-media@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Laurent Pinchart
	 <laurent.pinchart@ideasonboard.com>
Date: Mon, 10 Nov 2025 08:59:21 +0100
In-Reply-To: <20251107-stage-csi2-cleanup-v1-6-5d42535243ac@nxp.com>
References: <20251107-stage-csi2-cleanup-v1-0-5d42535243ac@nxp.com>
	 <20251107-stage-csi2-cleanup-v1-6-5d42535243ac@nxp.com>
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

On Fr, 2025-11-07 at 15:44 -0500, Frank Li wrote:
> Use devm_platform_ioremap_resource() simplify code. No functional change.
>=20
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp

