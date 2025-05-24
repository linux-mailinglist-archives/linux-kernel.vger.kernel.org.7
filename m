Return-Path: <linux-kernel+bounces-661772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B8CAC301E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 May 2025 17:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AD261896A06
	for <lists+linux-kernel@lfdr.de>; Sat, 24 May 2025 15:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451061E5734;
	Sat, 24 May 2025 15:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="nvkfsTT3"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35421DE3C4
	for <linux-kernel@vger.kernel.org>; Sat, 24 May 2025 15:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748100734; cv=none; b=T8glKZlQAyByTZEgdev6PsFN5hfCTmCNlLV52tWcRgAKmTcsaVRVaA6Cfzn1f1awAN2m2YEkVREdBoJKtO51M7jKgIbSiRZihSLRHA3N9+Guuuh8O5Fv8F3erOKG3dNlwTcysZLYhpplhWI1TWOe4XFerneFXNTyVdSL1Sl+haA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748100734; c=relaxed/simple;
	bh=NpDDJTNbuir8IKl9/RzH4L/6ciVQ+A2tZCGJBvvpEBg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Hrv/VfRktFFD8ZIxgGmyTlCy55gOTW7cBDGpOyhuiPdK+6GloIDkbk1xJsgG3UJc2jcdf1CKLoRKU1ll8QfV5NTzHPDWJFBNNl/OmmlPdn21lejUNWhNI8JJ/4VxWSrutHR1lqGtwiPTRF8PhePBmHUgSXWBZR1E3UEH3BN0fHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=nvkfsTT3; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 819CA4144F;
	Sat, 24 May 2025 17:32:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1748100725;
	bh=NpDDJTNbuir8IKl9/RzH4L/6ciVQ+A2tZCGJBvvpEBg=;
	h=Date:From:To:Cc:Subject:From;
	b=nvkfsTT3ES+Pakfpp/RCT1MfyiVgqiu6GYJuFmIxRgR6bcsW3C/p1lmc9wsO8RSI9
	 1Dp2Z44BWqf1Mu87by0XScgJznPXcZxgEzxguq6cVnUwS42M+Vfhgpozg6u5XQWPJG
	 Lkk5ejwNbos67Bv/Bl69UjDsyHSk1XMbM8XgqIGD8RiW2nYnO0PIK53zRJV26jwz4C
	 w/xPTNsdZHC2cJGmNVUHa95f9GD+FKxIpsUqoOl935DDD+C/pPtbRCv0RvgRVEAuV+
	 kKCZtykivA5DXzlWIQNJlvXpOWikyTMgzxcjE/Y5fKeUqa4/zjPLBiWhI+gRM7cYpg
	 0nIaBKXj9rXgA==
Date: Sat, 24 May 2025 17:32:04 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: [git pull] IOMMU Fixes for Linux v6.15-rc6
Message-ID: <aDHmdAoAE_gP6Xup@8bytes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 82f2b0b97b36ee3fcddf0f0780a9a0825d52fec3:

  Linux 6.15-rc6 (2025-05-11 14:54:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v6.15-rc7

for you to fetch changes up to b3f6fcd8404f9f92262303369bb877ec5d188a81:

  iommu: Skip PASID validation for devices without PASID capability (2025-05-22 09:10:00 +0200)

----------------------------------------------------------------
IOMMU Fix for v6.15-rc7:

	- Core: Skip PASID validation for devices without PASID support.

----------------------------------------------------------------
Tushar Dave (1):
      iommu: Skip PASID validation for devices without PASID capability

 drivers/iommu/iommu.c | 43 ++++++++++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 15 deletions(-)

Please pull.

Thanks,

	Joerg

