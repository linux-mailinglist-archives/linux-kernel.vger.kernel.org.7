Return-Path: <linux-kernel+bounces-753355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EBB1B181D7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 14:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D0AA7A50DE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 12:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023FF248871;
	Fri,  1 Aug 2025 12:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gsCqEK6e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6342E248166
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 12:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754051635; cv=none; b=QqcsWftSi4OugHmYM0MjLJFWh9jVUaftKoFgOxzdpkuspBt+hXAE4oeqykJHDerYpNTRERxVafvp2MroZs3awnnPb3ZVIby19ZIgTsKS9W/IzkCHFFkkgncpt6DgEVK1b1GhgPdBdEzMMydZLILMDVzpDkJSgooHCbz9UZaaVgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754051635; c=relaxed/simple;
	bh=81FaV93weYhwiHOEAODS9ByaoigIf6myHPpSeiONwvY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QQwwavfIQr7jOt+jlbz/IjWQNjWDtD6Ba0LPAoWlRRHF+CJXkssLWlNCtykyQivrrwzfIv8vRcsNVuRS5+S68CrTL6RV0d9UMQX1/p1hXidDFuP3noGdNtBQn7a6mDp1+6cABi/ue0gmLDZdOZis7ncAQTujhb8Q9zy0FL3PWAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gsCqEK6e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7393BC4CEE7;
	Fri,  1 Aug 2025 12:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754051632;
	bh=81FaV93weYhwiHOEAODS9ByaoigIf6myHPpSeiONwvY=;
	h=Date:From:To:Cc:Subject:From;
	b=gsCqEK6egPtyxiYoLIPewubfXki86167LN8cshPjowU6Kcezj410DWfTyzeX+XY1z
	 GAKCZTVjc0aHMcqYGO4ctyy1iqdAye+WxlRaQlXxN1UeQtAamNhqLz9yUVzh2zVjBa
	 Bozec5Bljgoz82glpb+V1DPfGX97+c4aIvTSv9RsKzvEFbDS0B5dQDTJ3DSt5kgBnn
	 VEjtaE2Nd2G//US42uvra8fowaNbYoKVuEXGYKSeI640C72smhURqJ5sufc2tcMD7f
	 mPNIC6b2aagVaGxrPYDHW722uZHb/sQENhx2e5q0K3H5Nr8IaTyysauHifyUTg9pgo
	 kutjAGyc44bwg==
Date: Fri, 1 Aug 2025 18:03:49 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: SoundWire subsystem updates for v6.17
Message-ID: <aIy0LYXrdYiQCMWZ@vaman>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0uZAOp97NHe/PEyv"
Content-Disposition: inline


--0uZAOp97NHe/PEyv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Please pull to receive updates for SoundWire subsystem featuring couple
of core changes and couple driver changes as outlined

The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/so=
undwire-6.17-rc1

for you to fetch changes up to 34b1cb4ec286603127aa8c4191ea527eb8dd3567:

  soundwire: amd: Add support for acp7.2 platform (2025-07-21 10:43:21 +053=
0)

----------------------------------------------------------------
soundwire updates for 6.17

Couple of small core changes and driver updates:
 - Core: handling of nesting irqs to outside the lock, stream parameters
   handing on port prep failures.
 - AMD driver support for ACP 7.2 platforms and improved handing of slave
   alerts and resume sequences
 - Qualcomm updating driver debug spew
 - Intel BPT message length limitations, rt721 codec as wake capable etc

----------------------------------------------------------------
Bard Liao (2):
      soundwire: update Intel BPT message length limitation
      soundwire: stream: restore params when prepare ports fail

Charles Keepax (4):
      MAINTAINERS: Remove Sanyog Kale as reviewer on SoundWire
      soundwire: Move handle_nested_irq outside of sdw_dev_lock
      ASoC: cs42l43: Remove unnecessary work functions
      soundwire: Correct some property names

Johan Hovold (1):
      soundwire: qcom: demote probe registration printk

Naveen Manohar (1):
      soundwire: intel_auxdevice: add rt721 codec to wake_capable_list

Rodrigo Gobbi (1):
      soundwire: debugfs: move debug statement outside of error handling

Venkata Prasad Potturu (1):
      soundwire: amd: Add support for acp7.2 platform

Vijendar Mukunda (3):
      soundwire: amd: serialize amd manager resume sequence during pm_prepa=
re
      soundwire: amd: cancel pending slave status handling workqueue during=
 remove sequence
      soundwire: amd: add check for status update registers

Yumeng Fang (1):
      soundwire: intel_ace2.x: Use str_read_write() helper

 Documentation/driver-api/soundwire/bra.rst |  2 +-
 MAINTAINERS                                |  1 -
 drivers/soundwire/amd_manager.c            | 14 +++++++--
 drivers/soundwire/bus.c                    |  6 ++--
 drivers/soundwire/debugfs.c                |  6 ++--
 drivers/soundwire/intel_ace2x.c            | 11 +++----
 drivers/soundwire/intel_auxdevice.c        |  1 +
 drivers/soundwire/mipi_disco.c             |  4 +--
 drivers/soundwire/qcom.c                   |  6 ++--
 drivers/soundwire/stream.c                 |  2 +-
 include/linux/soundwire/sdw_amd.h          |  1 +
 sound/soc/codecs/cs42l43-jack.c            | 46 ++++++++++++--------------=
----
 sound/soc/codecs/cs42l43.c                 | 24 ++++------------
 sound/soc/codecs/cs42l43.h                 |  5 ----
 14 files changed, 55 insertions(+), 74 deletions(-)

--=20
~Vinod

--0uZAOp97NHe/PEyv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmiMtC0ACgkQfBQHDyUj
g0etPRAAqwAFPiLoKMwd4+aTYJ8GMm+2jPdwy7jjgCFKDPXi4geC+F6ZcJpI2Cvw
6+yVWIt1mkkS4JGiQKuPAWLuLEwSJs1SXlOxh3QI8FIQfCIpk9UCs++ttCHttwIn
8HarLM2UannWOY2ApV3AjiUPDyCbqqGxWi6g7JL2RqQ6xURT3XG6n6YeTxkAf5gK
kgmL3lez88MLK4zQyPxQg2cmivGV6Jdugm/B6S2sBuVISX7lOquuoz2hPGqz/usE
rxpLGFN+rIyabK/tX8gABkzsNZkKOQMJcpEGNiI5G1CZLjdKi/cg82c5/y+mky4P
vAlgMlHMJoJCm5enz+q8slszoU4qJI2fuuzzdCggA3yhPAHMjGPwp9YuWDyqV3TW
YoD7OYZ6Lvr2kCqK+6jpqbkm3zD/zdBu8PyYx3jpygWVT1/8zZYAaAeTeOx+zJIx
uHyrG5iy2YJe6+1oWng+ZIUaC1iQDx+uIiKDE68NlUAsC5xe5rBwWBrf4kkRMeFH
twDDCmHvzkkcVrd7owgFjTt9KeEr703g/nJnYkUXoAgcZQB2TY16Itl0ZtpRDiv5
I1gn61/AlpPYO5epuiq74Z4IRxjTLtssIAfdjNmSovYfv/mcEulkXntK5tuUqghz
IF5FgWklO4jn7+K+ModmLAXbrsYnPu0FvqKfCw9e3wSwIHykCrc=
=qhMh
-----END PGP SIGNATURE-----

--0uZAOp97NHe/PEyv--

