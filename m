Return-Path: <linux-kernel+bounces-843735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB30BC01B3
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 05:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5ECD18995BD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 03:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445EE215F5C;
	Tue,  7 Oct 2025 03:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ROLtb6vs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1B434BA3A;
	Tue,  7 Oct 2025 03:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759808291; cv=none; b=l+Gmbd95QaIxsYrViWlk2efUHvMegHpnclW2igzLtX4GQmlQ8VNovik4FCIV9lzh7YDdlZViYkbu8p0MdQV/gE+wS8cp4inV/9LCl33ANkDVeEiuQBmhrgT3xRSbhGxxyqmZBg9/zbzUMBC/eKGw1lPR/5GzL6WrvaDRjdMzQLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759808291; c=relaxed/simple;
	bh=laZlRMTJlLHx1xQYrZ7hDVs8sVtuuELaDehxxN3PvFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aQqJMqL+9dKQ1E9MHAGhd5wPMcui5IpNIcoNkkSK73qt6euAewec6g/oTbyDxh6SNVkPM260Q9OAgQ3UsbJtFq8zDYnJa/MzJIuthRb3PiSfR5sXoGmMDEFqUZLfya81ozaB3RTqgVxziuCNOhEIUBQRNAZ9fhobT5zbLczeYmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ROLtb6vs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84930C4CEF1;
	Tue,  7 Oct 2025 03:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759808290;
	bh=laZlRMTJlLHx1xQYrZ7hDVs8sVtuuELaDehxxN3PvFM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ROLtb6vsjucBJQSHz2BW/Vcz1e6EhYx3ZzN5POI13Vu56ZQ4+60GniPAlE489biPh
	 Zf9dbzT68TFBmeK+NpkFYLlIqJuRmzAT12EmOzDSKIdRBcokuiBSZ+m6FPExWG9kdG
	 5V1+7n5n9wmYUwxQK6b4JZCR/VLG8qi12/LqtOGCG/ymE9Gu3oHIif55WaqcEwZ65Q
	 dSXQGTGPxxxmofkurEPP5sBB+e7+mIFzwb/Uane4ktZUYsRZXvTEWkSAK0MnEhg9vk
	 tQVdK9i+R/9Sqlfy2/Ww7oQQ0soJbKlAkEAzQ4qXISSMaBJh10Xn220n6IQR6q21vo
	 V2+Z7FbFnIbYg==
Date: Mon, 6 Oct 2025 20:38:08 -0700
From: Drew Fustini <fustini@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Anup Patel <anup@brainfault.org>, Arnd Bergmann <arnd@arndb.de>,
	Joel Stanley <jms@oss.tenstorrent.com>,
	Joel Stanley <joel@jms.id.au>, Michael Neuling <mikey@neuling.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@kernel.org>, Andy Gross <agross@kernel.org>,
	Anirudh Srinivasan <asrinivasan@tenstorrent.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Drew Fustini <dfustini@oss.tenstorrent.com>
Subject: Re: [PATCH v2 6/8] riscv: dts: Add Tenstorrent Blackhole SoC PCIe
 cards
Message-ID: <aOSLICqS1Hxi9gBF@x1>
References: <20251006-tt-bh-dts-v2-0-ed90dc4b3e22@oss.tenstorrent.com>
 <20251006-tt-bh-dts-v2-6-ed90dc4b3e22@oss.tenstorrent.com>
 <a05be32b-dc8f-444f-8c1c-2d49eb19536d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a05be32b-dc8f-444f-8c1c-2d49eb19536d@kernel.org>

On Tue, Oct 07, 2025 at 10:20:43AM +0900, Krzysztof Kozlowski wrote:A
> On 07/10/2025 06:21, Drew Fustini wrote:
> > From: Drew Fustini <dfustini@oss.tenstorrent.com>
> > 
> > Add device tree source describing the Tenstorrent Blackhole SoC and the
> > Blackhole P100 and P150 PCIe cards. There are no differences between
> > the P100 and P150 cards from the perspective of an OS kernel like Linux
> > running on the X280 cores.
> > 
> > Link: https://github.com/tenstorrent/tt-isa-documentation/blob/main/BlackholeA0/
> > Signed-off-by: Drew Fustini <dfustini@oss.tenstorrent.com>

Thanks for the review.

[snip]
> > +	cpus {
> > +		#address-cells = <0x1>;
> > +		#size-cells = <0x0>;
> 
> Cells are not hex. Please use decimal everywhere.

Okay, I'll change.

> > +		timebase-frequency = <50000000>;
> > +
> > +		cpu@0 {
> > +			compatible = "sifive,x280", "sifive,rocket0", "riscv";
> > +			device_type = "cpu";
> > +			reg = <0>;
> > +			mmu-type = "riscv,sv57";
> > +			riscv,isa-base = "rv64i";
> > +			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "v", "zicsr",
> > +					       "zifencei", "zfh", "zba", "zbb", "sscofpmf";
> 
> Blank line

Ack.

[snip]
> 
> You should have at least serial or any other interface, otherwise I
> don't see how this can be used at this stage.

The goal for upstreaming this minimal device tree is to make it possible
to boot mainline kernel builds. I attended the KernelCI workshop after
ELC-EU and learned there are not many RISC-V boards doing boot tests. We
already have Blackhole cards in servers that could be used for CI, so my
goal is to enable mainline to boot on Blackhole.

I had an explanation about the serial console in the cover letter but
I'll change the commit message in this patch for the next rev:

-------------------------------------------------
From: Drew Fustini <dfustini@oss.tenstorrent.com>

Add device tree source describing the Tenstorrent Blackhole SoC and the
Blackhole P100 and P150 PCIe cards. There are no differences between
the P100 and P150 cards from the perspective of an OS kernel like Linux
running on the X280 cores.

There is a virtual UART implemented in OpenSBI firmware that allows a
console program on the PCIe host to communicate through shared memory
with Linux running on the Blackhole card. CONFIG_HVC_RISCV_SBI needs to
be enabled. The boot script on the host adds 'console=hvc0' so that the
full boot output appears in the console program on the host. 

Link: https://github.com/tenstorrent/opensbi/
Link: https://github.com/tenstorrent/tt-bh-linux
Signed-off-by: Drew Fustini <dfustini@oss.tenstorrent.com>
-------------------------------------------------

Thanks,
Drew

