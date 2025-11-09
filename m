Return-Path: <linux-kernel+bounces-892189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A44D8C4493F
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 23:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C3AA188A69E
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 22:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B565263F5F;
	Sun,  9 Nov 2025 22:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="UeTugOV+"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70DC21B9C5;
	Sun,  9 Nov 2025 22:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762727561; cv=none; b=iWGVs37F9rLS+CphTVmMFcsezxAnPRoaDZ3bPWMq4uZW3SWrsW+os3aJhPkuyJBrBGmw1JRayGOmutNOzZIek8s2X6qobY2Dur0CPyFzCMMBVUiE9Wo20FhE4xufOXQHejCbTiOS5Ay2g7uruQkLYELYWFEME9pQyq3YNZwcfvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762727561; c=relaxed/simple;
	bh=fDMUm9q/yJ3JDgtU+vDyJyPVwa6DZQmOptBTe38SZrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=os6HZj1DPpK86o2A4K8fdB8NPDB2gk9QUt4bVq0/ytfaPjCZEMEpOr1lWmXpOYntNB8uxn9I2AhGNKWFmVdsZFrX1zhaZbFkH8GpUHiZwUdbVlra3bZyldWe3CFPlXACbmkQ5lk1rCS4KZkYcgnuZ/OCgp0ny/4vyb0Nxu6yuHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=UeTugOV+; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=byT23yRuymPPdxIdTw9swgQHBmcIsr3XjUFDrG55fV8=; b=UeTugOV+E0hXGyFevS5N0iiGGy
	Z04TlC1xumdZH+nmT/wlZcT6VB2EYFmR5T6N9pMYBtx76N4ewTk6uMCuHCsiWKrcR7XySmYklHaMC
	hHfkllprfyx2azRK9MI2rzFID9QWqakDL9f1eOVT8TS9jPoT337W+xY/HjDHO9ieBL5qCUzrPvBgf
	X9eLxHb7W+PcihWt40WJDr/4r2+jbqR8aUuVVwzuOvHzKgV20FBx3jq7hJiLizl94tWjQIeuJ4G5D
	by/ZGccOPc4ibNr6sXwPMx4McXn/3OHYx/1i/E0HK7JB9sMgWWwefHd1UP2X2WbX1RaYGCmouKCjg
	evGZ3JHw==;
Received: from i53875a5e.versanet.de ([83.135.90.94] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vIDhv-0007Wr-0V; Sun, 09 Nov 2025 23:16:23 +0100
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Diederik de Haas <diederik@cknow-tech.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Samuel Holland <samuel@sholland.org>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: hrdl <git@hrdl.eu>, phantomas <phantomas@phantomas.xyz>,
 Dragan Simic <dsimic@manjaro.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH 1/2] arm64: dts: rockchip: Simplify usb-c-connector port on
 rk3566-pinenote
Date: Sun, 09 Nov 2025 23:16:22 +0100
Message-ID: <5024969.GXAFRqVoOG@diego>
In-Reply-To: <a726fac9-afe5-4639-b06a-4bccc256d98f@kernel.org>
References:
 <20251109-rk3566-pinenote-dt-fixes-upstream-v1-0-ed38d200cc04@cknow-tech.com>
 <20251109-rk3566-pinenote-dt-fixes-upstream-v1-1-ed38d200cc04@cknow-tech.com>
 <a726fac9-afe5-4639-b06a-4bccc256d98f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Sonntag, 9. November 2025, 18:37:26 Mitteleurop=C3=A4ische Normalzeit sc=
hrieb Krzysztof Kozlowski:
> On 09/11/2025 18:05, Diederik de Haas wrote:
> > The USB-C connector on the PineNote has only 1 port, so there's no need
> > for a 'ports' node with address-/size-cells properties as a single
> > 'port' node suffices.
> >=20
> > This fixes the following DT validation issue:
> >=20
> >   Warning (graph_child_address): /i2c@fe5c0000/tcpc@60/connector/ports:
> >     graph node has single child node 'port@0',
> >     #address-cells/#size-cells are not necessary
>=20
> This is not a DT validation, but DTC warning which we do not really fix.

That is good to know. Is the same true for other dtc warnings?

Thanks
Heiko



