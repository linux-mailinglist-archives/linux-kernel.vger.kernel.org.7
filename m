Return-Path: <linux-kernel+bounces-725070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F10AFFA78
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 09:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25E521C47432
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 07:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D432882AB;
	Thu, 10 Jul 2025 07:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3kePT4j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF8C2877F1;
	Thu, 10 Jul 2025 07:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752131522; cv=none; b=D06g3nDbEj0kxCRwqmuD5F9+XyVhZ+XmchFBu6o6okBcXCi3DUJ6cRSX+hS/d5QWQvsvGiKSH1CoaIG888lM+3mHZgbF9VxSBIiOVfffSjDa6hMleihszDmAoTLcUSFtAwgHRAereCCdJQww+Joe4umqni/cagkIghVW9wtZ/7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752131522; c=relaxed/simple;
	bh=aIQhENoNro5iEInnHFbG9/vXa6r2JKB29IlUxVOoRHw=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=fwKQy4OEEos8ULEaZz7Yal3497JXtTVjkmV3RNzlvjDnuv3qbGUpDRdtlIBZE7QCeEVBe9FBjbX+kEq4riItqwdA9HO1IsFDj+/0Y7vmPRWeHlM9rL+uC1cpObZigItEjDRqWVwOc5DRC+dqgXhbg+IfNNVJ9Vdi1wUbxYbbsAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I3kePT4j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1ECCC4CEE3;
	Thu, 10 Jul 2025 07:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752131521;
	bh=aIQhENoNro5iEInnHFbG9/vXa6r2JKB29IlUxVOoRHw=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=I3kePT4jqdjWj9P8opXGWsukdze0SOAzcPVjDhWJR2/uxCnkwbvsak9tsnDQFjOFd
	 422pW5tVF4fiAKGuRxLSuobbHLYg9sZEmlHUnVRMp2APdrfigh9K0KZuiInswpnJrV
	 Kf6Wo4xDGIFkqeyTvpC0HD/+noeRuXtIsHND5j/u9uxuTZ1U+IZMQjnfkpFlpf78ql
	 u2PYF1s1JWv3t+M/aqwvxaunKdxF8cNu2Kanc2RlHFs5XFEFOn4Ob3EyIhMrhxnPyZ
	 ntJFn+t/4tfg4tAdbCNY5BvCRJMb/b8aRhZHcMdDGpODp+1j5yBH5fiuZn8nJMvCm4
	 DPe0Uig86NFmA==
Message-ID: <4826eea327c406d55dc88f5553a94b62@kernel.org>
Date: Thu, 10 Jul 2025 07:11:58 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH 2/9] drm/bridge: add drm_bridge_chain_get_last_bridge()
In-Reply-To: <20250709-drm-bridge-alloc-getput-drm_bridge_get_next_bridge-v1-2-48920b9cf369@bootlin.com>
References: <20250709-drm-bridge-alloc-getput-drm_bridge_get_next_bridge-v1-2-48920b9cf369@bootlin.com>
Cc: dri-devel@lists.freedesktop.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, "Andrzej
 Hajda" <andrzej.hajda@intel.com>, "David Airlie" <airlied@gmail.com>, "Fabio
 Estevam" <festevam@gmail.com>, "Hui Pu" <Hui.Pu@gehealthcare.com>, "Jernej
 Skrabec" <jernej.skrabec@gmail.com>, "Jonas Karlman" <jonas@kwiboo.se>, "Laurent
 Pinchart" <Laurent.pinchart@ideasonboard.com>, "Liu Ying" <victor.liu@nxp.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>, "Neil
 Armstrong" <neil.armstrong@linaro.org>, "Pengutronix Kernel Team" <kernel@pengutronix.de>, "Philipp
 Zabel" <p.zabel@pengutronix.de>, "Robert Foss" <rfoss@kernel.org>, "Sascha
 Hauer" <s.hauer@pengutronix.de>, "Shawn Guo" <shawnguo@kernel.org>, "Simona
 Vetter" <simona@ffwll.ch>, "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Thomas
 Zimmermann" <tzimmermann@suse.de>, "Tomi Valkeinen" <tomi.valkeinen@ideasonboard.com>
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Wed, 9 Jul 2025 18:48:01 +0200, Luca Ceresoli wrote:
> Add an equivalent of drm_bridge_chain_get_first_bridge() to get the last
> bridge.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

