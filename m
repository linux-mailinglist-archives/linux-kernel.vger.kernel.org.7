Return-Path: <linux-kernel+bounces-797833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADB2B415EE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 275831BA0038
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 07:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2010D2D978C;
	Wed,  3 Sep 2025 07:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="bXhMGpGc"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBB44F5E0;
	Wed,  3 Sep 2025 07:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756883604; cv=none; b=CTA0h0JIIZQKLo3XhdayEtFFErKR2BtJFeoBF4LI/rvyURoKogDFE0ZB4fvSpUJVhb87gYneXTB3x0ESpazJSgaIOMNMxXYmS2WkZm0XEMQLbzjyOv4juTUslCH4CpKy09ASi+zOEPiERImjynQAZDBstTNxAmKWKAlTbGJqO9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756883604; c=relaxed/simple;
	bh=+SKJ2DOUnv0ju3m2fzI2NEnnUJ6bjzNIYaMHRG/U5d0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fF8qFnW5d0fWM3drHg23nhUpqqY2LTKCx4rZk9c3gPWmDnVbQlgsn4rB/SmsmaBYJCZp2hSssXheAhXS0Oz931f38YHsWACvWvXRnQeaUs7dnKWpAOi1OwOeOeF3OQ09temp07LHa48+FAdRyKzBOLa0zT69sE5inabnm+2w9xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=bXhMGpGc; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1756883600;
	bh=+SKJ2DOUnv0ju3m2fzI2NEnnUJ6bjzNIYaMHRG/U5d0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bXhMGpGcvrD3ixFoy8jvslo3iAJXogAk94gfIIvFFVj1de2p9FgC/vf5/POKe6Syj
	 nxxTdvMzr4VnovLF2eSUuNrXUUr5c1m36Tpy7b0ioL3PuRqTq4UEMY04n7seQX6fYq
	 eIzMmkXixGU9NhG/jShBOyf726SUtmW3ojaX2hjyzruvVAV2VVj6ne7mZ08Rum+Tny
	 3hD+U1cbT8nVea/WZLXNEnco2SkNMzqtwbpz07c1mu69zWt8WhR94sMO5IxG8scl5m
	 PNQK2r9wcKupbD847qT0eV1lqYHMyXp8EpL1YaOVvNtTPxfUzQiGPw+hBLzekJhx+n
	 wp8lEpQ1rGSmw==
Received: from [10.209.99.88] (unknown [180.150.112.213])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id BFE386445D;
	Wed,  3 Sep 2025 15:13:15 +0800 (AWST)
Message-ID: <613456d8ec80c29c6332c8a047bfe2a108dd2e65.camel@codeconstruct.com.au>
Subject: Re: [PATCH] dt-bindings: gpu: Convert aspeed,ast2400-gfx to DT
 schema
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: "Rob Herring (Arm)" <robh@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Lee Jones
 <lee@kernel.org>
Cc: linux-aspeed@lists.ozlabs.org, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 03 Sep 2025 16:43:14 +0930
In-Reply-To: <20250829230442.1495926-1-robh@kernel.org>
References: <20250829230442.1495926-1-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-08-29 at 18:04 -0500, Rob Herring (Arm) wrote:
> Convert the ASpeed GFX Display Controller binding to DT schema format.
> There was a duplicate, incomplete binding in mfd which can be dropped.
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>

Thanks Rob.

