Return-Path: <linux-kernel+bounces-750643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8134B15F1B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 13:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC299188384B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 11:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC7028DEE0;
	Wed, 30 Jul 2025 11:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TI+oVnhc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0D1239E81
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 11:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753873788; cv=none; b=Ty2zHgct6v7bBaKZUvrjl2zak2OYqWNal3D+dCk7qxlTUyKlnQ3Y2N/3+oahGU1PTEds8V7dltDNVZ0MdnyU5Ty8kG7BPKDCYPGDhVGQTbPNNwDEpFth0xPXaTDdHc7MBDa1Z+6j0LsmjozQdWlylOfqWUdVY0EYqEG8z0uuTSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753873788; c=relaxed/simple;
	bh=0CNjdPeIjNe/Cr8sVG0T9YvP+Ef20nkwmViNCVeY6D4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QefR/XfEFw4DjsEo+MXOMgrekXrAvI1T/7PxEVkESq4Rtdo4TCRvubHqXbzh8lcFKCVTOSJzJCSNySH2FR3ed+Fgr0kkJm7PPu0Lo10psJ3ld6PSlJyc966uikv0vrK87jjnatl5O+YkYc4MjXZ25Q91I+EDI4vqJjaDgeKYsEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TI+oVnhc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30DD1C4CEE7;
	Wed, 30 Jul 2025 11:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753873787;
	bh=0CNjdPeIjNe/Cr8sVG0T9YvP+Ef20nkwmViNCVeY6D4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TI+oVnhcSrTOFD+Zrt/5XD+vWnJ9HOWXqNFPqlCoi13+zCBM9llHXlTLfTcVzjFGQ
	 /DJLdWvPNNmWlBO21+l6zZUjf7tGRWZ2SyAUpFgROLtL9rQxQH1smbJu3jCqsE8rTy
	 qpf5ds5uyXJUYpqf/EUEqvSmXVPljL9RLWAd9pC7/5ZDNCgGRuwzNrRssxl4a4LXiU
	 ai4oBDRZY0qwY1FCbv16kR765Dut24uuo++wLa4URS9a4QS89juH7ZK7dBfeJ9brYk
	 pCPGDuS4fFo8gzP17T+bwuhTSd2jMvofxMF5Cl+3brEvGspZCDgm8Kd3mKStousCyj
	 W1uRIc+MLdeSw==
Date: Wed, 30 Jul 2025 12:09:42 +0100
From: Mark Brown <broonie@kernel.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Leo Yan <leo.yan@arm.com>, Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 04/10] coresight: Appropriately disable programming
 clocks
Message-ID: <015c39de-001b-4660-bc64-6fd07eff9f18@sirena.org.uk>
References: <20250724-arm_cs_fix_clock_v4-v5-0-63f648dae021@arm.com>
 <20250724-arm_cs_fix_clock_v4-v5-4-63f648dae021@arm.com>
 <b3782b8f-8c09-4fb8-bec6-186102cc66a8@sirena.org.uk>
 <f9fb2174-5bc5-4c7b-b74b-8542b4f7cbe0@sirena.org.uk>
 <15370a42-8e92-4f57-9ff2-f283d9fd30bd@arm.com>
 <20250730085637.GB143191@e132581.arm.com>
 <caffdde4-fad4-4462-ba92-84416726a12d@arm.com>
 <20250730105432.GC143191@e132581.arm.com>
 <cd250adb-61e7-414f-bf17-6cc960e44f7b@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p4x4+9VUTrJ5jiST"
Content-Disposition: inline
In-Reply-To: <cd250adb-61e7-414f-bf17-6cc960e44f7b@arm.com>
X-Cookie: Linux is obsolete


--p4x4+9VUTrJ5jiST
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 30, 2025 at 12:01:25PM +0100, Suzuki K Poulose wrote:

> I would recommend using that and don't force the use of apb_clk/apb
> for AMBA devices. If the firmware doesn't specify a clock, but does
> specify the CoreSight components, it knows it better.

And perhaps more to the point if a currently working system suddenly
starts requiring additional clocks in it's binding that's an ABI break.

--p4x4+9VUTrJ5jiST
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmiJ/XUACgkQJNaLcl1U
h9BD8wf+ODcyt3KGHVPbd4ely45VxK+DeMhInki2yIOs1Qg9ZpVeJmClCei6+PXd
RG8cM+o0v/8ut+TGA71E8c7PMiuCX64gfWtwoVRf0rDFSxHcPNTceXGJ4x3wmrhV
wDHdzatndulWuOsHPUceg8HooawvvcI8597foZoSVMYjC3aylvWEiuvajgBvrpA+
SOnaTAVCtD51Ppha5THQ6OUNgLK6W8TY0Q+yhsvn5Sg802StaXKo2XkJKN3Nz7Uj
vhIrlxN4Bg54Vp4XVYe7xhzLHW4GVsKalXWhJNfpe1jgOkbjW6CHdFMs3sQk6YdJ
0dIbSWroraDHYryqKFUSmEZIIhs4zQ==
=7HYz
-----END PGP SIGNATURE-----

--p4x4+9VUTrJ5jiST--

