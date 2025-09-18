Return-Path: <linux-kernel+bounces-823265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1C9B85F2B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 18:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCC584A5B35
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 16:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDC1314D16;
	Thu, 18 Sep 2025 16:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="KrYRs1+0"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C25245006;
	Thu, 18 Sep 2025 16:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758212413; cv=none; b=pjastH2Qj19Wt46/FXNpL0HOegqFt4ZK0cXt4I18u5yvCxTuIyM8Aq0enUlo5dBUaez3ZOt2P6PkYxeHCIDZA1yemsCqa8L6MFTsgVY28UH7Ir6hVARZU++xKvxDAtJ6Po+utDZdkETsoYf0ly9OOOlkzp6Qm+2Y0jaVNxImgEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758212413; c=relaxed/simple;
	bh=ij7YRpjwTvulY3aWdGjnbYtUTkWGQpudRGCGsT9FAsA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PjQDR3mezmeJrnGyQWh1mYKxpj9ytYn+4FEKDP3KzKBtEpdX4/K6VsL31ylGJPkioG1NR79yYNlbLEoWvEdrtIT8mX9KlqEWGlVGpsbt4JrQPKu/3z+Dh4H6Fb0w0MJAEMvT4jJpXJFyI5GZ/5kVD1RB08y0DG/lW09s8A7ETfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=KrYRs1+0; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:Cc;
	bh=zMNCQB3IZJa1lenTGE4yLUo0+d2lJWLrI+MvU6M7hlo=; b=KrYRs1+0IXwH9rggfZxB6I0V6F
	VAf+xYmNBz8d+HEdykNno5v245fcT0C+kM+zRG5hz/ikTomnlz+QfmjC/QS3kh82Ns/Cm8Dcc2XkG
	BcdW/C0yUTbJd09PDkUBnNs94Uk59AofnJfc8m6KlJqO9byyHdqsv/xqN3iKGOmeHKHnaJ/AO0c00
	HsOOsKYhs+HoG9QPh3WM/5xrKTChgnc6oAcXm0Z7ntp/ekW0yj6Wrmw3afS2y/uO6n7CYjtE4meUG
	sfIAZEunYHPCiw3/TFbQZcmoibdlXCvn9ZUpaiO40k8b6JPPzt1EHFgJHwoKIKyP/4WbFoItXFUpe
	Qyi5HrRQ==;
Received: from i53875b0a.versanet.de ([83.135.91.10] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uzHMd-0001yb-F5; Thu, 18 Sep 2025 18:20:07 +0200
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ed Wildgoose <lists@wildgooses.com>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Ed Wildgoose <lists@wildgooses.com>
Subject: Re: [PATCH 0/2] arm64: dts: rockchip: fix dma and pinctrl defs v2
Date: Thu, 18 Sep 2025 18:20:06 +0200
Message-ID: <2424735.BjyWNHgNrj@diego>
In-Reply-To: <20250918093246.15623-1-lists@wildgooses.com>
References:
 <20250917114932.25994-1-lists@wildgooses.com>
 <20250918093246.15623-1-lists@wildgooses.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi Ed,

Am Donnerstag, 18. September 2025, 11:32:44 Mitteleurop=C3=A4ische Sommerze=
it schrieb Ed Wildgoose:
> Based on feedback, I reworked these patches. I've re-presented both as
> I realise that one had invalid formatting (spaces vs tabs) and I've
> moved the dma-names definition into the same board level dtsi. At this
> point it seems reasonable to also squash the two patches, but feedback
> appreciated?
>=20
> The default pinctrl definitions for the Radxa Zero 3W don't match the
> datasheet. Possibly few people enable extra UARTs and hence it wasn't
> noticed? I needed all 5 UARTs for a project and the first patch corrects
> the pinctrl defs. Without this patch, enabling the extra UARTs causes
> issues such as the MMC devices disappearing, due to collisions.
>=20
> Second patch adds a dma-names property, which appears to be a
> pre-requisite for enabling DMA on the UARTs. I've applied this to the
> board level dts as feedback suggested there could be unintended problems
> if enabled across the complete rockchip dtsi.
>=20
> It's tested on my Zero 3W board and appears to function correctly and
> DMA is reported as enabled.

housekeeping requests:
=2D please don't attach new versions to an old thread, but instead
  start a new thread
=2D this is supposed to be v2, so patches should be named
"[PATCH v2 0/2] ..." etc.

At least the cover-letter should contain a changelog what changed
between versions.


Heiko




