Return-Path: <linux-kernel+bounces-838266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D70BAED7C
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 02:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5AC23A4BD2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 00:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1BF8479;
	Wed,  1 Oct 2025 00:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QEBpRZ4+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED6BA59
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 00:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759276951; cv=none; b=edU1HFo0GOSDxOwTCOYbm7kXW+/7ZcWyF1UTs97d7cJ78k8a/5k+ig83dmvHpmvL8d4YvAySId5HmlAplIfw01gE1GiPeeWJ8EVnafuqra1hbaDbQoIqsXfMbmVSHIyecg0zy7r23cTWkc6uE5F0Uek/4CgZyKQT/Ts44e2ZBrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759276951; c=relaxed/simple;
	bh=dwEW8+/b7xBo7At7AzTkhr8QZCIaouyj04nG9PeDN08=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Kp7xAD8LLi6h5BuZaWJJpQoaQv9M6ekmno1GihDk2P4BF+hc5slpMEkiUZ2uHVxZ9eomoYhDTE0be1K/Dd/vNC4J4xAc4+pnvCeNvq28hW/V0DQr3lpvHxi4IdmkONILHJOlw7sH1sEe4qmPD6Y1mnYtCarxl9usTal9EcgDHuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QEBpRZ4+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2E24C4CEF0;
	Wed,  1 Oct 2025 00:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759276951;
	bh=dwEW8+/b7xBo7At7AzTkhr8QZCIaouyj04nG9PeDN08=;
	h=Date:From:To:Cc:Subject:From;
	b=QEBpRZ4+/J4BwXERp2Y2y+w+0Ho99lQIQW4IK3ZHufEn2DM2RGIW4kEz0EHVgDMgX
	 Syc2iO3kdp338Q8mr4kx+UVb0/GUOkgagmakIAba0CTWlIAmyv5otyQl0UmamJTTu0
	 GYA85L2riCTUgoBqobv0y+rZqu88KHeoSkVdHHqZa9NBTH30WNiD0uJshjzX6I3SCJ
	 vWnKkTE80Z77gMUH1bjSIj11qKgHD0QdYCopCH/KH8p690ffFunZ4CQaacRvAdjHff
	 133nB6YiEkfjqWuUkKndnV9Ize8Gm30S4dTpIuNO2g3UfoD2aWxy6BCFjbsF4obPFW
	 NUVM5+HT4CgRg==
Received: by venus (Postfix, from userid 1000)
	id BFA74180734; Wed, 01 Oct 2025 02:02:26 +0200 (CEST)
Date: Wed, 1 Oct 2025 02:02:26 +0200
From: Sebastian Reichel <sre@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PULL] hsi changes for hsi-6.18
Message-ID: <c2wz3qml5mpdyyztgoilddzcjulkqhl3yowznr6jh6r42ghin5@hlmfe6yyscw6>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p4yahzqgu23ugyoa"
Content-Disposition: inline


--p4yahzqgu23ugyoa
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: [GIT PULL] hsi changes for hsi-6.18
MIME-Version: 1.0

Hi Linus,

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-hsi.git tags/hsi-for-6.18

for you to fetch changes up to ca50b295fd473ef797b69b8538036cca716f3d55:

  HSI: omap_ssi_port: Remove redundant pm_runtime_mark_last_busy() calls (2025-09-05 22:56:59 +0200)

----------------------------------------------------------------
HSI changes for the 6.18 series

 * Remove redundant pm_runtime_mark_last_busy() calls

----------------------------------------------------------------
Sakari Ailus (1):
      HSI: omap_ssi_port: Remove redundant pm_runtime_mark_last_busy() calls

 drivers/hsi/controllers/omap_ssi_port.c | 11 -----------
 1 file changed, 11 deletions(-)

--p4yahzqgu23ugyoa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmjcb5IACgkQ2O7X88g7
+pq0dw//bXrjrQ44pSWp1kj23u24oezxrUU59if6qQpIY0H8N9T8SqsXzVWCw6Ev
NZFTrGGxgwSFQHfxTw9jOQRmej9DXdQFWoC3waKTSO9Uv7GpprZE1VdGY/NV60hl
MKfFxSymkVvseYkstT+uDc6ZfuTQ6AgHTFlBZCPQ68l+PfydNRvGboSG+SXUsngV
j5eqxkwq9TqKpG7jsdMcYItEkT7rIKdkDIxJDupda82xCFgVQkElrj3E6UUfM9RW
A9HvlQWSusfXwo1zBDNSTAcvF1EjINShkeV6K8sW4tZoFVxZTcozx5ddDTGAUZCj
TmQyEq4V1xMeCVkYLsxcR9Zd+Fpaa+UCTPSVUarB8JC8v2hX/7J46xRiG+l8DETx
AcjR7+VQV1sUc0NKc3OFJp6GvqjdzfL2ung5J1Jj/+Lr9H4EOC4K6Pp0ysRjGTNU
KCYZANE7Vdktg5pSlqBUYP6AaxlS0UkvqXSe/a0pZ3EPgpL437sBj4JGptMGizbk
ZGac4c5SQZEww84zMXHvihwz2Xegq/4QDHrs+6H8vBWz16icuaih0GoyOMZ0o/vC
wFNb0vSVJP3Kc2mJ8au53xSpsRkS4A+TWqR1cg+d7hweAzU4zq0k6Gt3K2BSjTVN
Z9iWUQ+M+2gFuBIQPBIg6PONnhpaj2gD40cVAcR/kvHgwSE+dvE=
=TfbI
-----END PGP SIGNATURE-----

--p4yahzqgu23ugyoa--

