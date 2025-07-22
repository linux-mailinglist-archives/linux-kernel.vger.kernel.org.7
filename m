Return-Path: <linux-kernel+bounces-740375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5988B0D332
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 09:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23DD717B6A0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 07:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA962DA751;
	Tue, 22 Jul 2025 07:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EbAkzTvg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614752D97BE;
	Tue, 22 Jul 2025 07:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753169468; cv=none; b=Ga64RaBBnM6uAY6wP+JTvozV0w/BCmg+D2Z9VJ0n/HBqGlZsUmki38wAOvxyu+H81njYa5HEUmVG3iCai8kmcgmux6JXUxgmLVZWKSNu5xsZDMV7fj3KT7+CDj7orVIBO8VCrYKrEPWtUueXw8jLHrAx0mNWGTtPLhSsWnfUW18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753169468; c=relaxed/simple;
	bh=FnmXk3RGYRkdTKxHf3IUZF8SVbHutxuKbL79UvPE+0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nf3TuXCWvAuXpWCBF5P3iQ0DvQ2mHJuMcZehU3kBQJtxtz3gHnK5u5LKcbjVe0kQnBjtQmf+5Pjd6t4KajZdVkeWpkkPLO93UIQsQTOwxEwegfZ8LtsZHaTFSadEsAs93GjnTnb5+N3ekv8q7NdJ4KS7OgOVBuc3X0WUTPIckiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EbAkzTvg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50561C4CEEB;
	Tue, 22 Jul 2025 07:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753169467;
	bh=FnmXk3RGYRkdTKxHf3IUZF8SVbHutxuKbL79UvPE+0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EbAkzTvgU9Y38FaD7bQ9BoIoTqBhDgU0/qAy1iwUpPxXqSPkEDDoPZtzuuMTFSMfR
	 X4TUvrqpKx6TxEBZX1xm7Q4nGbIBMy6atkG5zgFu7PTVCtO+zL4V0moIa8SskDrNkf
	 R+CJ45DZAi9ninTDRR1Y+4OG08Pvdglr6OTOGW6ZrWiXAi8siZZ4KM5U4KCgkqPYm4
	 XmJO2dK9t6q0x8IK5WY9htMXKfpUaITOEkkstDzVjkLrGYXQtmn/xyv9H3W3cwpqrO
	 6Xraa/U/es4jsHY6/zsmhEGvaZWL7QxTdnulKeHGQ5i05W9gcEZ3MYmRY4gf0jRLL3
	 mjjg6XUqu/zEg==
Date: Tue, 22 Jul 2025 09:31:05 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Junhui Liu <junhui.liu@pigmoral.tech>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Samuel Holland <samuel.holland@sifive.com>, Anup Patel <anup@brainfault.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@sifive.com>, 
	Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH RFC 09/10] riscv: dts: anlogic: Add Milianke MLKPAI FS01
 board
Message-ID: <20250722-proud-polar-mink-12caa8@kuoka>
References: <20250721-dr1v90-basic-dt-v1-0-5740c5199c47@pigmoral.tech>
 <20250721-dr1v90-basic-dt-v1-9-5740c5199c47@pigmoral.tech>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250721-dr1v90-basic-dt-v1-9-5740c5199c47@pigmoral.tech>

On Mon, Jul 21, 2025 at 11:46:15PM +0800, Junhui Liu wrote:
> Add support for the Milianke MLKPAI FS01 board based on the Anlogic
> DR1V90 SoC. The board features 512MB of onboard memory, with the region
> after 0x1fe00000 reserved for OpenSBI.
> 
> Currently, the board can boot to a console via UART1, which is connected
> to the onboard serial chip and routed to the Type-C interface.
> 
> Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
> ---
>  arch/riscv/boot/dts/Makefile                       |  1 +
>  arch/riscv/boot/dts/anlogic/Makefile               |  2 ++
>  arch/riscv/boot/dts/anlogic/dr1v90-mlkpai-fs01.dts | 28 ++++++++++++++++++++++
>  3 files changed, 31 insertions(+)

You need maintainers entry for your entire sub-arch. Otherwise why would
we want unmaintained code?

Best regards,
Krzysztof


