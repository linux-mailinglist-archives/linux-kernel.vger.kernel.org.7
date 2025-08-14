Return-Path: <linux-kernel+bounces-768862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA67FB2669A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F33DD1CC7C40
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 13:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DA02FF657;
	Thu, 14 Aug 2025 13:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCaNwslg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC3D2FDC2A;
	Thu, 14 Aug 2025 13:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755176946; cv=none; b=nvt3rZ6FgUQ1t33saTeNsYlDbbk2mKLRPP+klj0czlai38sfUaIgbhjIH5PucOwnNxlzs+ZR+hjI1kAtztxAzdhuxiApotq/QPc/nXbdaaxaQvmk/Nkr4ccre/w5lmVezOMxO6SP+/SbrdWxX3is+J05U4SeecJJNxO/g3N9Tm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755176946; c=relaxed/simple;
	bh=V0/mzt7rpQ7Ja/nnjC462dZYJStiYQcl4BcFdcuXGcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VHqJgJg6zQ+Qv9n3mKawbFbZ5ivwhsdYOqxchoWNhmRPVsZ4I2X1snsOB0Xw/0xUf8gwwmV/eeyrJ3l+YYpZxhSyciaelaM/SJrZlAFtIQUu/FeOTOtA+xwriG7N6TdXcfFXZtSCX0dB44qgiOw2fxDSGHFPDZ/OU+TbgiRIQYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCaNwslg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC5B4C4CEEF;
	Thu, 14 Aug 2025 13:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755176946;
	bh=V0/mzt7rpQ7Ja/nnjC462dZYJStiYQcl4BcFdcuXGcQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kCaNwslgBWiblbN70JZHhnR5rMobNvr1yRsRWdmRLk8CfXmjfDOFKtMilcgwfucRX
	 VeMVXVBYLCiJ3I8uK9A5rhZbCBO5DyKMWzaR6iU74ujFIK1PF2tUlV0MZwZC4MFwfV
	 T9npTDmENz+NZ/nlqn5WLnVUPCxEN/pyzmuaDXZkcyckKJ4thf38213tTBFf8fw09Y
	 ZEqOBWi+nL8MyTv1WdLnph3/Lz7lSTYVo20jjsUne0fWuxO5yhhhQcILxgJZr0P2Sv
	 zHHZ0qGsMIWdb/pxVY+kyc5a2GYdPdKp0R91s+uUI3uq4UJBCBKP+tgDV04sTt5Xti
	 6u9VjIh0hhAbA==
Date: Thu, 14 Aug 2025 14:08:57 +0100
From: Mark Brown <broonie@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Usama Arif <usamaarif642@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, corbet@lwn.net, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, hannes@cmpxchg.org,
	baohua@kernel.org, shakeel.butt@linux.dev, riel@surriel.com,
	ziy@nvidia.com, laoar.shao@gmail.com, dev.jain@arm.com,
	baolin.wang@linux.alibaba.com, npache@redhat.com,
	Liam.Howlett@oracle.com, ryan.roberts@arm.com, vbabka@suse.cz,
	jannh@google.com, Arnd Bergmann <arnd@arndb.de>, sj@kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v4 7/7] selftests: prctl: introduce tests for disabling
 THPs except for madvise
Message-ID: <620a586e-54a2-4ce0-9cf7-2ddf4b6ef59d@sirena.org.uk>
References: <20250813135642.1986480-8-usamaarif642@gmail.com>
 <13220ee2-d767-4133-9ef8-780fa165bbeb@lucifer.local>
 <bac33bcc-8a01-445d-bc42-29dabbdd1d3f@redhat.com>
 <5b341172-5082-4df4-8264-e38a01f7c7d7@lucifer.local>
 <0b7543dd-4621-432c-9185-874963e8a6af@redhat.com>
 <5dce29cc-3fad-416f-844d-d40c9a089a5f@lucifer.local>
 <b433c998-0f7b-4ca4-a867-5d1235149843@sirena.org.uk>
 <eb90eff6-ded8-40a3-818f-fce3331df464@redhat.com>
 <47e98636-aace-4a42-b6a4-3c63880f394b@sirena.org.uk>
 <1387eeb8-fc61-4894-b12f-6cae3ad920bd@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="glbdhY1Z3FbfdGG7"
Content-Disposition: inline
In-Reply-To: <1387eeb8-fc61-4894-b12f-6cae3ad920bd@redhat.com>
X-Cookie: This sentence no verb.


--glbdhY1Z3FbfdGG7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 14, 2025 at 02:59:13PM +0200, David Hildenbrand wrote:
> On 14.08.25 14:09, Mark Brown wrote:

> > Perhaps this is something that needs considering in the ABI, so
> > userspace can reasonably figure out if it failed to configure whatever
> > is being configured due to a missing feature (in which case it should
> > fall back to not using that feature somehow) or due to it messing
> > something else up?  We might be happy with the tests being version
> > specific but general userspace should be able to be a bit more robust.

> Yeah, the whole prctl() ship has sailed, unfortunately :(

Perhaps a second call or sysfs file or something that returns the
supported mask?  You'd still have a boostrapping issue with existing
versions but at least at any newer stuff would be helped.

--glbdhY1Z3FbfdGG7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmid3+kACgkQJNaLcl1U
h9DBEAf/atqlzm4RBPppUe6r1XpYt+RajQsB5AiYLmN8lTjImryp/2Gh23hCHlZw
gm22HJ5HZ/zAJketjugdDOiovu1RPgg4kJNoXy/tDnG/Sq1bFd9eZzu1QLKutztl
Hr2SbJii1zQgWo7bcSXMKKoHOva+AbkhTItweml/3eD0ntEoAak2niwtuhKYzw25
3DhOe5GOhsDt3OUTx9Z5kakWLDGkbmTc0ITomwJCste4pcdUFFOtv4m5XSGkAQOT
8xyA9jEUMM5ZXsrhdkNa85XMDb3/CPhNEX0jHBr4tikptYvJDf/ZV5a9rCldNAvl
lYGN1sDmGdtMHATgR170R/sTrdE2vw==
=ASIV
-----END PGP SIGNATURE-----

--glbdhY1Z3FbfdGG7--

