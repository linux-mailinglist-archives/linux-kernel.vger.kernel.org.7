Return-Path: <linux-kernel+bounces-796652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3045B4057A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 15:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC42A560DA1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 13:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FC33054F8;
	Tue,  2 Sep 2025 13:44:24 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A42C261593;
	Tue,  2 Sep 2025 13:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756820663; cv=none; b=g6dgx5OSmult+6OzOG2FvOv4rkqxEnJjYmzdtH10biMaZ7R9W//8UtRaI+wNEmU53T4uo4uL4KyBN/Mo56OOEVUETEnrJFrhFvZVRZemZ/E2a68btPM/tgpAtKTpbvZRPL6F9atdjxOqVZqq1L3MabGc3enwetEElVrhM3lKlJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756820663; c=relaxed/simple;
	bh=TUhn9SxfyKi/nflbAhcd4p8M9mm2MuZ2K4YLtGozXm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A0OsVEDbFBlQkmnx7lNSkJr/qefDiAjMkSwVj4rFhiW8Jy68zEEzvu6a6JxSydIGhiApWwcWf1mRcGP4+7IglxJkrYYeHqIl1/btDKYQtpVwNoU1eRBcTybc4r6VgMuNXNWjIyCueQrN0KmUirkSoM+VRdhLhidx3kPbQUB90SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.18.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 6D527335DC0;
	Tue, 02 Sep 2025 13:44:21 +0000 (UTC)
Date: Tue, 2 Sep 2025 21:44:17 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Alex Elder <elder@riscstar.com>, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] riscv: dts: spacemit: uart: remove sec_uart1 device
 node
Message-ID: <20250902134417-GYA1155728@gentoo.org>
References: <20250902-02-k1-uart-clock-v2-1-f146918d44f6@gentoo.org>
 <680534b4-27e7-4506-885a-1c3dc9d12b8b@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <680534b4-27e7-4506-885a-1c3dc9d12b8b@iscas.ac.cn>

Hi Vivian,

On 20:55 Tue 02 Sep     , Vivian Wang wrote:
> 
> On 9/2/25 20:26, Yixun Lan wrote:
> > [...]
> >
> > diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
> > index abde8bb07c95c5a745736a2dd6f0c0e0d7c696e4..3094f75ed13badfc3db333be2b3195c61f57fddf 100644
> > --- a/arch/riscv/boot/dts/spacemit/k1.dtsi
> > +++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
> > @@ -777,16 +777,7 @@ uart9: serial@d4017800 {
> >  				status = "disabled";
> >  			};
> >  
> > -			sec_uart1: serial@f0612000 {
> > -				compatible = "spacemit,k1-uart",
> > -					     "intel,xscale-uart";
> > -				reg = <0x0 0xf0612000 0x0 0x100>;
> > -				interrupts = <43>;
> > -				clock-frequency = <14857000>;
> > -				reg-shift = <2>;
> > -				reg-io-width = <4>;
> > -				status = "reserved"; /* for TEE usage */
> > -			};
> > +			/* sec_uart1: 0xf0612000, not available from Linux */
> 
> I know this is going back and forth a lot but I don't think that's a
> good description of what's going on.
> 
> My preference is that we just drop this node altogether, just forgetting
> that this thing even exists. But if you do think we want to keep the
yes, removing the comment and completely dropping it is an option..

> information we can drop the clock-frequency property too and change its
> status to something like:
> 
>   status = "disabled"; /* No clock defined */
> 
> Which also silences the warning - disabled nodes are allowed to be
> incomplete.
no, set to 'disabled' is simply wrong, it doesn't reflect the meaning of
"unavaiable", I remembered we've rejected this before introducing the
'sec_uart1' node in the first place

> 
> My personal opinion is that I think sec_uart1 and TEE support feels too
> theoretical to be worth caring about.
> 
> Vivian "dramforever" Wang
> 

-- 
Yixun Lan (dlan)

