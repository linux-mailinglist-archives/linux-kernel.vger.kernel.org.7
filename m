Return-Path: <linux-kernel+bounces-886919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B3EC36CAD
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 17:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E55214FE073
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 16:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DD6310777;
	Wed,  5 Nov 2025 16:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EHA1o6Ri"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD39303A32
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 16:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762360041; cv=none; b=mHIz+haPTujXB51HbRDEGVhlhi9kkxQ1XwGJ9UV/Tcf3j5OGrYzjKTBU+fKAEVEy8+yrfKHtapKw3yzq/ZIcMT4jhx5xTYH5RCJo7gUUQQpfJLwSUfzwF03AwS1PoefYZ1m6nzB8YRu47r9Exs78pCd453UBheMmxoYUX76sFKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762360041; c=relaxed/simple;
	bh=HYq4MzEXhs69h85BKnz867qg7d5EWHBgFdp42SDp81w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oAwQExrFIiKsBCmI9JT16fENY+JZq1cF2qpMOeNLsO3En2fWSWtJ9J7VrngDSdV939L4+kmiemSGuVdJkuWzJaRE/ruOqsauzYlHq4OtvMCZ5qgAtMaMY7YmbNnaC/NEfw/JKqIoakz8+NqhalTzhgDU+PNy641vJO1pbsEsFAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EHA1o6Ri; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF318C4CEF5;
	Wed,  5 Nov 2025 16:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762360040;
	bh=HYq4MzEXhs69h85BKnz867qg7d5EWHBgFdp42SDp81w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EHA1o6Ril2AssBhILRyAOCYWpPM5VvnOfJJ7AUuaWwPnEpdZ6+mdBmSAcNMN0FiQJ
	 I5xHwAVJiIxKLo39uNG4YwfML9EkkoveCM6e76oLYIcCbtCdf+UtSkSCSgcx98D8N7
	 UIZj4CXSlX73P6VBD5luRQn/PlndL5/ApvYjHTFzpWWFYdtCp2byAQCSjECsaP+Lbr
	 B9NWzzLC9AV6nWWWFH68Ub2VpQII4OFbh/csGWP+abFSL9uMWr/1oY2Pe+6AQtOzHc
	 uzqEdkKnwstJPhwxwn3O8bS5PddAl2qWVkeMfZStUAj3dzZC1Mmmm1e8sZ5rJdA9Gc
	 Xu5HoXfty4DBA==
Date: Wed, 5 Nov 2025 16:27:17 +0000
From: Mark Brown <broonie@kernel.org>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal Hocko <mhocko@suse.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH] regulator: irq_helper: replace use of system_wq with
 system_percpu_wq
Message-ID: <aQt65Rp0psfRr60s@finisterre.sirena.org.uk>
References: <20251105161425.308499-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DirHLVmZPjy9UV+Y"
Content-Disposition: inline
In-Reply-To: <20251105161425.308499-1-marco.crivellari@suse.com>
X-Cookie: If in doubt, mumble.


--DirHLVmZPjy9UV+Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 05, 2025 at 05:14:25PM +0100, Marco Crivellari wrote:

> Replace system_wq with system_percpu_wq, keeping the old behavior.
> The old wq (system_wq) will be kept for a few release cycles.

Same thing here, if we're using a per CPU workqueue it should be clear
why.

--DirHLVmZPjy9UV+Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkLeuQACgkQJNaLcl1U
h9BfFwf/W5A38CGUgIqwM7+LRk1M5RqDoPrOU8+55GCMsw2GUBzSBRf9PePGw1D8
ETKQ+A+9jPPALa3JYXvQw9iUKdQQ1hVYqSlQ1zYIz4Z6XNp3PBjhM+Pqa3XywZSV
oSIpeTOd1+3xN9hiP6EFXps1yBuFbnyshef1GNbwb5scWcyz0/Z1GF93/xPG3EdV
VQcUCQWrqmiamZCwI4KyDTPkXJ98VBZ36gElYVwpbJuPr4nRhm85pa4wn2Q1Q9J7
bypfLcTHG+NLiy9D9ZZissrX4T9dH47pVIfncqnWEI54yd3e3PTas5jc0F+1qCw+
WPzllOD81oV5Dn3vzh31i5gwJFzEdA==
=IuCR
-----END PGP SIGNATURE-----

--DirHLVmZPjy9UV+Y--

