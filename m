Return-Path: <linux-kernel+bounces-788679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 185C1B3889A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 19:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32A6E7AA02E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 17:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C672D7DED;
	Wed, 27 Aug 2025 17:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a83xwGxl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166602D7D2A;
	Wed, 27 Aug 2025 17:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756315697; cv=none; b=kR+tflKu8osw2dLfRhlUPbMowy/oU2ev+8UiWu2jYJwLOrMwVhzyK2Dmc+CyQHjFl0hRgyxRsttGZPVi1WnAMphT/Kuni216FPrKc+xIjpGhOty+uaAV+PQdPIMtHxVbDHh6CT6I9aGJNH/RK4m8ju8LwPzbm7tMnFqJN9+ySmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756315697; c=relaxed/simple;
	bh=J2iW4fcquoMXCFvrwNgVUWmetrANS/ZUtfkvs7vrbUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bhrNqdNBzmwEOr6DQc2o/nmESwMGDsFFb0V9+6ngGZjFsU9mjaaYHxJ/7oJVsdUGK2weuIeohvItfLfXk1BvW3SVr9R+nRdhhYQ/6/DXnShQUsk2rDciFyLfE5rlhWk6lIEZzDLp+YBArGtFL3T8jmZXadNy4fKjPPgIxV8s990=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a83xwGxl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4104C4CEF0;
	Wed, 27 Aug 2025 17:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756315696;
	bh=J2iW4fcquoMXCFvrwNgVUWmetrANS/ZUtfkvs7vrbUw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a83xwGxlmmFgKbpXsiSmmPwVl48weCDVspZ0TGs/TfZ7amQqZKAQIUXlr2ls5/7RV
	 ES/aC3DOfpBAIuOy7lhwp0at6S1I7BRy/gV1WaX0PgupjR4DgdRacO2y6s27OHweXV
	 iqXXrvV5EEcNZtEY9548ph9X5pyM6QfZLU1lLbiZeNdIuciZVj1TFPOZ83OSUWbHmp
	 W4D2PTsd/47Q2NdXl+J0chm/MSYSDh7VgpdTDSXY0ZE6vDoDA29aEljZcBTwx3lR2w
	 O/RJWDlkB9MBrmZ23DhkkZNRmBcF+LrhauKt77mYId7FuYF9GBVMPnChHysjjh7X6P
	 wS5+1qz+WQg+Q==
Date: Wed, 27 Aug 2025 18:28:12 +0100
From: Conor Dooley <conor@kernel.org>
To: E Shattow <e@freeshell.de>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hal Feng <hal.feng@starfivetech.com>,
	Minda Chen <minda.chen@starfivetech.com>
Subject: Re: [PATCH v3 RESEND 0/3] riscv: dts: starfive: jh7110: More U-Boot
 downstream changes for JH7110
Message-ID: <20250827-aloha-datebook-6133960546ff@spud>
References: <20250823100159.203925-1-e@freeshell.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DBSyI2GI+xVp3lzx"
Content-Disposition: inline
In-Reply-To: <20250823100159.203925-1-e@freeshell.de>


--DBSyI2GI+xVp3lzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Aug 23, 2025 at 03:01:40AM -0700, E Shattow wrote:
> Bring in additional downstream U-Boot boot loader changes for StarFive
> VisionFive2 board target (and related JH7110 common boards). Create a
> basic dt-binding (and not any Linux driver) in support of the
> memory-controller dts node used in mainline U-Boot. Also add
> bootph-pre-ram hinting to jh7110.dtsi needed at SPL boot phase.

Emil, could you take a look at this please?


--DBSyI2GI+xVp3lzx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaK9ALAAKCRB4tDGHoIJi
0h47AQC8FbMusMnLVxo/83unGL4xyLbvXY89HBtv7cWlwJZMIwEAgL1E3yrJIeXC
LtVzvGmO2ZTGxJTfVWJVmWMOuLQsLgg=
=7Ecq
-----END PGP SIGNATURE-----

--DBSyI2GI+xVp3lzx--

