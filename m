Return-Path: <linux-kernel+bounces-888803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2064C3BF3C
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 16:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46D4D18894DE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 15:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89FA3446C4;
	Thu,  6 Nov 2025 15:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="XSZGqn6G"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03327345CB3;
	Thu,  6 Nov 2025 15:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762441400; cv=none; b=k+GCadk38B6ERmE0tleYEb23cPSYvs3YetemxsvzEPfjQZ76oqNEeI2A0z+cypNQu+UpEC5OuYfttwCkoT8pIzDmEPpJFSEKulE9Yvkgg+qt+NpmU+RtNPQxX6lCsR2GXQUqB51vOa5goxKUzlnDyBEw9c1SZQC5aQO/VGVzXZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762441400; c=relaxed/simple;
	bh=7y2zEn2ROiUzVTxt1mB7quCKO14Pw3dkEKbmNjuWvh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CvQurzmTvhUoxvzvcolf4xHle2Uegcb8hKlgJbZkdMOdd9l3kpJaoF0yFLfQsZBEc+fJkCodEUQeCfi4r/u1QLdbhQpdoevjM6MwL97f+ecNeHP9aKj5oKKlY8EKH3gSgUaS+hLUQuLVFsRDSnwOMP5nu/z5kDzruAMlslqG3Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=XSZGqn6G; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id EB6071F93B;
	Thu,  6 Nov 2025 16:03:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1762441394;
	bh=6I2Iu+cJT3+xxGMe7PrlNglBTOagx6IwbhJZJqxqBGE=; h=From:To:Subject;
	b=XSZGqn6GIJD61EDUYa00+rIE5rUeW4v9fNypsOF6u/RPK6BxPlVVAj6tAdbZDNfGj
	 cESdjMrFBVhb0ZAs0GkNehC3GhXkfzDZGj7kPYpt72E/HCIqoP6lW8ygTB+zRtJqpy
	 6Po4wRrC44QVQNpSgJg1diuMDwpfrj3Hiuss0M7OZQJBz5X6DXtTJb7Mjj2/+u6MeM
	 Wj+a8mbumaROEssjFPUKxPPXXk62WIvnVZ4PLNESgWQAH7WoTn6miY14uF36aFhcS3
	 olAz+zgdzG8RaiZkOj46PIkzBTyOnSJ1iuTRY3FOWf5x6EpXgGVtlBPNJ56ZESvD7Z
	 V4pZ95whObyhQ==
Date: Thu, 6 Nov 2025 16:03:09 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Andrew Davis <afd@ti.com>
Cc: Francesco Dolcini <francesco@dolcini.it>, Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Parth Pancholi <parth.pancholi@toradex.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v1 2/3] arm64: dts: ti: Add Aquila AM69 Support
Message-ID: <20251106150309.GA44898@francesco-nb>
References: <20251104144915.60445-1-francesco@dolcini.it>
 <20251104145240.61219-1-francesco@dolcini.it>
 <20251104145240.61219-2-francesco@dolcini.it>
 <d77bf3dd-4501-4f17-a776-3353f96f4fb1@ti.com>
 <20251105115335.GA14157@francesco-nb>
 <7024f4b3-00a0-4618-8bf9-53e305fcc982@ti.com>
 <20251106101932.GA5975@francesco-nb>
 <be8040c0-76b1-46e3-bd89-841cbfa10c84@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be8040c0-76b1-46e3-bd89-841cbfa10c84@ti.com>

Hello Andrew,

On Thu, Nov 06, 2025 at 07:32:44AM -0600, Andrew Davis wrote:
> On 11/6/25 4:19 AM, Francesco Dolcini wrote:
> > On Wed, Nov 05, 2025 at 02:01:35PM -0600, Andrew Davis wrote:
> > > On 11/5/25 5:53 AM, Francesco Dolcini wrote:
> > > > On Tue, Nov 04, 2025 at 11:41:54AM -0600, Andrew Davis wrote:
> > > > > On 11/4/25 8:52 AM, Francesco Dolcini wrote:

...

> > > > > > +/* Aquila SPI_1 */
> > > > > > +&main_spi2 {
> > > > > > +	pinctrl-names = "default";
> > > > > > +	pinctrl-0 = <&pinctrl_main_spi2>, <&pinctrl_main_spi2_cs0>;
> > > > > > +	status = "disabled";
> > > > > 
> > > > > This is already disabled by default in the SoC dtsi file.
> > > > 
> > > > Yes, known. Is this an issue?
> > > > 
> > > > This node must be disabled, no matter what is present in any included
> > > > dtsi file, it's a deliberate decision.
> > > > 
> > > > This dtsi file describes a SoM, the used pins/functions are defined on
> > > > the pinout, but this node cannot be enabled unless the SoM is mated with
> > > > a carrier board that is exposing it.
> > > 
> > > Same as my point above, you shouldn't enable nodes that are not used
> > > or have anything attached. The SoM only has some edge connectors so
> > > it should not be enabled at the SoM level, that we seem to agree, but
> > > the carrier board doesn't connect those lines to anything either. They
> > > just run to a pin header with nothing attached, how is that header
> > > any different than the pins on the edge of the SoM?
> > 
> > You are commenting something unrelated here, or I am not understanding
> > you.
> 
> Yes this was a bit of a tangent to the comment above. The point here
> was more on the pinmux, as a new carrier board might use these pins
> for something other than SPI, the pinmuxing shouldn't be done at the
> SoM dtsi level. Instead do it at the point the node is connected to
> some hardware on the carrier board in its DTS.

Our SoM implements a specific pinout, with well defined functions,
therefore the functionality of the pin is defined at the SoM level [1].

[1] https://docs1.toradex.com/116801-aquila_family_specification.pdf
	  page 13, 14, 15


Francesco


