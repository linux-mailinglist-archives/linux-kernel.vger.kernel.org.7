Return-Path: <linux-kernel+bounces-819357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A793B59F39
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 19:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C47C2A1B51
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 17:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FB52749CE;
	Tue, 16 Sep 2025 17:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pO0gLIw+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB8032D5CF;
	Tue, 16 Sep 2025 17:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758043646; cv=none; b=lZtNFf99ivKLZqmD1P0zjTTSDAQimf6VvV2fwm/ud2R4dDugdwQ+xdvOvCGH6xQ+hso1Z2qZ5XCikgKRnpyjupvH2DRbNrkanoz+82RBuNud9ql8BNfKCrTjKA9cQ2YjhK+0rzdSLKubT5mVlnXch1GXma8shJbH7ypyQQ7f6BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758043646; c=relaxed/simple;
	bh=fWZs1qHqxRc9T0uAavz42c01e6M1hsLN3wfmP16pG5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JPV8KflcLJyLQYoeQMLTnsIfSNXU9VTHTqJky1P1tR0hBchebt1CDIYvI3ucegjdqs1Hi6d5U+0tjd9nxi36vuKFFf3XjEwwd1DHV1MFiG1U0ulw4Bfi6mJV5YRVJvl7R26xaEcKBhBVWLK+tNd/7KmiRkskJJTXo0v4XpR5Alg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pO0gLIw+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D7AEC4CEEB;
	Tue, 16 Sep 2025 17:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758043645;
	bh=fWZs1qHqxRc9T0uAavz42c01e6M1hsLN3wfmP16pG5c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pO0gLIw+EEmWFX6tZXueH7cSlByMKixpJMBIDvQkWSCEZhMB/8zQvhP4lc9i93XUJ
	 3y5YvqeMzAp/aMJDyS06ibIi3WQHXNveV95k+wyRs0wP4cp6/oEz7uOpat2evlxuze
	 nhSLYhb2uEHWlDQn2+Z0NU2Znp0dczegfKAwkEJJn21vmyDfGyyKNHSeqHW9+7IB7I
	 pMOemdOTeWPys3Rh8+aIy7LbfSTEQKzJbhl4BHHSpVAuFO2UddhkDa0LZFxIEWZy8q
	 xOLTFA0RbhXQdYAt3YfhdGmlLAKEms03tBXXod/iYW+7fIdN4EjhRdaBF7aDhSZZS7
	 GBfN6JCNnBeUw==
Date: Tue, 16 Sep 2025 10:27:24 -0700
From: Drew Fustini <fustini@kernel.org>
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: Conor Dooley <conor@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Anup Patel <anup@brainfault.org>, Arnd Bergmann <arnd@arndb.de>,
	Joel Stanley <jms@tenstorrent.com>, Joel Stanley <joel@jms.id.au>,
	Michael Neuling <mikey@neuling.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@kernel.org>, Andy Gross <agross@kernel.org>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Drew Fustini <dfustini@tenstorrent.com>
Subject: Re: [PATCH 6/7] riscv: dts: Add Tenstorrent Blackhole A0 SoC PCIe
 cards
Message-ID: <aMmd/JQAfPwKuYyB@x1>
References: <20250913-tt-bh-dts-v1-0-ddb0d6860fe5@tenstorrent.com>
 <20250913-tt-bh-dts-v1-6-ddb0d6860fe5@tenstorrent.com>
 <20250915-mouth-banner-ddfb2e48bdb3@spud>
 <aMhSSka3gyIcND/L@x1>
 <70241f44-2f8d-4945-9c84-71416776cefd@codethink.co.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70241f44-2f8d-4945-9c84-71416776cefd@codethink.co.uk>

On Tue, Sep 16, 2025 at 02:56:05PM +0100, Ben Dooks wrote:
> On 15/09/2025 18:52, Drew Fustini wrote:
> > On Mon, Sep 15, 2025 at 05:47:08PM +0100, Conor Dooley wrote:
> > > On Sat, Sep 13, 2025 at 02:31:05PM -0700, Drew Fustini wrote:
> > > > new file mode 100644
> > > > index 0000000000000000000000000000000000000000..b2b08023643a2cebd4f924579024290bb355c9b3
> > > > --- /dev/null
> > > > +++ b/arch/riscv/boot/dts/tenstorrent/blackhole-a0-card.dts
> > > > @@ -0,0 +1,14 @@
> > > > +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> > > > +/dts-v1/;
> > > > +
> > > > +#include "blackhole-a0.dtsi"
> > > > +
> > > > +/ {
> > > > +	model = "Tenstorrent Blackhole A0 SoC PCIe card";
> > > > +	compatible = "tenstorrent,blackhole-a0-card", "tenstorrent,blackhole-a0";
> > > > +
> > > > +	memory@0 {
> > > > +		device_type = "memory";
> > > > +		reg = <0x4000 0x30000000 0x1 0x00000000>;
> > > 
> > > This isn't at address zero as the node address claims.
> > 
> > Thanks, I'll fix the unit address.
> 
> Is it time to just assume any dtc can handle a 64bit number?

Is it not valid for me to use the 64 bit hex number in the unit address?

I changed it to memory@400030000000 and 'W=1 dtbs_check' did not
complain. Am I doing something wrong?

-------------------------------------------------
$ git diff
diff --git a/arch/riscv/boot/dts/tenstorrent/blackhole-a0-card.dts b/arch/riscv/boot/dts/tenstorrent/blackhole-a0-card.dts
index b2b08023643a..7963712b53ea 100644
--- a/arch/riscv/boot/dts/tenstorrent/blackhole-a0-card.dts
+++ b/arch/riscv/boot/dts/tenstorrent/blackhole-a0-card.dts
@@ -7,7 +7,7 @@ / {
        model = "Tenstorrent Blackhole A0 SoC PCIe card";
        compatible = "tenstorrent,blackhole-a0-card", "tenstorrent,blackhole-a0";

-       memory@0 {
+       memory@400030000000 {
                device_type = "memory";
                reg = <0x4000 0x30000000 0x1 0x00000000>;
        };


$ make W=1 ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- -j32 dtbs_check
  DTC [C] arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dtb
  DTC [C] arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dtb
  DTC [C] arch/riscv/boot/dts/tenstorrent/blackhole-a0-card.dtb
-------------------------------------------------

Thanks,
Drew

