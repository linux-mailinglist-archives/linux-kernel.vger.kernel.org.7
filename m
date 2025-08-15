Return-Path: <linux-kernel+bounces-770805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16EACB27F1A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 13:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86CE15A82F4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 11:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3412853E7;
	Fri, 15 Aug 2025 11:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8j62Mzp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17A721422B;
	Fri, 15 Aug 2025 11:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755256881; cv=none; b=q+Hqlz9kutnWdhSK4aItnsGmgwOWfOY24A4c7ERS5Idvy4oOpNY+ST6DchzD1SpbmsGcoBHj5bmj8whReF5X47a/IHaTcPwYu4nfbpg+w0RR0oblkmc4U6Hkz7WWuVq9TwwkG+hUEo+1QOnFwqK3/ocg2UAUWSw4K6bBPVVLW2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755256881; c=relaxed/simple;
	bh=IcKBbC8Ql6iD0ak3ttxASGdvakYmVW8V3mebISgdDqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a9kEKEPIysb4HKGJFHnzm16scTbPprdRmA6jd21uI9asypJqrI0vIDQAZ//QzXNcaKW42QjjtMiFL68BrEOYSDEU17zB/0U/xCRMoPKcLr1YIeX1HS2uDHTyJyoCX2MOOYV83qMbdKmt8z5Zf7HYNQfDtbIckd8zladbEqLO5tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K8j62Mzp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B0CC4CEF0;
	Fri, 15 Aug 2025 11:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755256881;
	bh=IcKBbC8Ql6iD0ak3ttxASGdvakYmVW8V3mebISgdDqc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K8j62MzpxcfBc3qcgt2UPHU32gtIvqCkx9BLNNUdg4OiYC38ZUdYoyurhs6BkRlcn
	 7y51ijwADt6qupR3TqxVDoBbIIqi1RyoDKKIPZkWbw2XHZ/NOgxkBTxT10GPR94GEx
	 1WNE80HNC/5e/g/iHF0WWKJ/KrYF5LYPvxUe5ujXLXhpwfaK9A1ZFtqx5Zat5/ZoA3
	 yMc63Etkfsrt+6EdSoiPHa+T+nrUNlM36VMaJoq4VetRURCXKRVpcZKw4FP25OZBxu
	 d06QNGZ4QjzUhJrBBjQ8kM7zMAE5Cfl15WMlEyfUttIL2Zue0iQbXaACJeI4XmK7CM
	 eiTYS+cT9d7eQ==
Date: Fri, 15 Aug 2025 12:21:15 +0100
From: Mark Brown <broonie@kernel.org>
To: Zhang Yi <zhangyi@everest-semi.com>
Cc: tiwai@suse.com, lgirdwood@gmail.com, perex@perex.cz,
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH] ASoC: codecs: ES9389: Modify the standby configuration
Message-ID: <06b5ea28-5b3a-4c9b-a2ed-6c945373d3b1@sirena.org.uk>
References: <20250815024729.3051-1-zhangyi@everest-semi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Gd7g/NSGg91lNoMV"
Content-Disposition: inline
In-Reply-To: <20250815024729.3051-1-zhangyi@everest-semi.com>
X-Cookie: Tell me what to think!!!


--Gd7g/NSGg91lNoMV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 15, 2025 at 10:47:29AM +0800, Zhang Yi wrote:
> Modify the standby configuration

Why?  Is this a fix?  You're just changing one magic number for another
here...

--Gd7g/NSGg91lNoMV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmifGCsACgkQJNaLcl1U
h9CSvgf/c4v10gdnh5qqAC5mUm1uBFzoV4BQ0pKDo4+AMo034DUzJcVaqmJMDyRs
P8koHD79nbBe+43WBxPIYo9kjMcQ6HxNx1UOZuH5O2QOfQh7flwQQVDlYNNVmQBZ
xsmMHxlmjlujJ2dppbgx6JgxXxnW9jhA0GVkuYPjSRpGmb2u0N3/j3RGZnkOsCeE
mWD7Hwc+Jgiw6Ugmgrl/X8aDwf8CFz/rLfhdb/fH4y+4NP3ECnNENNtJ/tmTB70J
yxzLcWlfe2tkREn/G1P0XKqV6jzq4uGuOYkTx2beAwBSbeGApIGFSXRDQtmnQ+AH
VlYvz5GiN6896SEPaUW7sdkWeJ/LEQ==
=I9lz
-----END PGP SIGNATURE-----

--Gd7g/NSGg91lNoMV--

