Return-Path: <linux-kernel+bounces-825508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B5CB8BFE2
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 07:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77E1F585B66
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 05:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39423228CA9;
	Sat, 20 Sep 2025 05:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JzegsISH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC891F4297;
	Sat, 20 Sep 2025 05:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758346470; cv=none; b=M/GvguKcnHe9Dntyd0Ikp0xxPfXktybiUHWmLh7JUZBEJnYXnGTKt2zOw+CowdS5zj7AvXMaoqE1Efn/z4TPjUP3LWEV6e6MFTre4LMPkaFzclyUCxaCUmRjACYs8TGISbnATOmY/Q+H4TZY0fvw6NLguUP/8Zo9sJMUJ9Snmc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758346470; c=relaxed/simple;
	bh=V/+Qy01EmZ0PCln4OM3El4G5dCfh6SHIukCmzi2Z+hE=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=sRK7XDEbwgynGd9d7WF9wn4ALKv0+9F+cZwMCGtGNbL88lzg0asuYImE86tNJg7yviOX5r5axlzoFmpYUvLLkOExIkfvDor0P3EicBP95rHGA/yybggiZmjyfVnefRfIrWnNPmrvgjfYWvC9D5YLoG8qohzMCQ3AStkulyKe0M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JzegsISH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FABDC4CEEB;
	Sat, 20 Sep 2025 05:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758346470;
	bh=V/+Qy01EmZ0PCln4OM3El4G5dCfh6SHIukCmzi2Z+hE=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=JzegsISH0H3t4svbmqnQnDyNezfc/r0jPVr8wtNnTDaE+sKWjZy9gIqOsVpzdnJxE
	 uhpabUtXJWqSn7FzYYF0YNVthy7Q0rhng73metmwGlIgM+/BdqZuvH4HHgYCybdBbY
	 uGhyunLC43HOaidf8haNZacIhma0xv1wJfSgWycHhbJGexrAzRQeezadiyVOlSDQk8
	 Ewupijr6Rlv8wq8q6ZtxhRooXuSSZXhjTcsAVfs9bp/d1yhLH326WAc8fakCLF0czl
	 LxmSPDNmPiIIXPybWb492ETfm7EILWut/82ZQfV0Br/0Mb8W5AXr+5G4d3xreNgVXz
	 UQ5i5soWyTThw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <d36c5597-e26e-4ddc-93b3-222d8b40dab7@broadcom.com>
References: <20250901-kona-bus-clock-v6-0-c3ac8215bd4d@gmail.com> <d36c5597-e26e-4ddc-93b3-222d8b40dab7@broadcom.com>
Subject: Re: [PATCH RESEND v6 0/9] clk: bcm: kona: Add bus clock support, bus clocks for BCM21664/BCM281xx
From: Stephen Boyd <sboyd@kernel.org>
Cc: Alex Elder <elder@kernel.org>, Stanislav Jakubek <stano.jakubek@gmail.com>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, linux-arm-kernel@lists.infradead.org, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Alex Elder <elder@riscstar.com>
To: Artur Weber <aweber.kernel@gmail.com>, Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Conor Dooley <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Ray Jui <rjui@broadcom.com>, Rob Herring <robh@kernel.org>, Scott Branden <sbranden@broadcom.com>
Date: Fri, 19 Sep 2025 22:34:29 -0700
Message-ID: <175834646902.4354.13114906749225372224@lazor>
User-Agent: alot/0.11

Quoting Florian Fainelli (2025-09-04 11:28:34)
> On 9/1/25 10:07, Artur Weber wrote:
> > This patchset does the following:
> >=20
> > - Introduce support for bus clocks. These are fairly similar to
> >    peripheral clocks, but only implement policy, gate and hyst.
> >=20
> > - Add matching bus clocks for BCM21664 and BCM281xx peripheral clocks
> >    and update device tree bindings to match.
> >=20
> > Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
>=20
> Stephen, are you OK with taking all of those patches through the clock=20
> tree? Patches #8 and #9 have a dependency on patches #2 and #3.
>=20

I don't normally do that but sure. Is that a Reviewed-by?

