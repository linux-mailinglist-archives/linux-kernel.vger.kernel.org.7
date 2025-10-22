Return-Path: <linux-kernel+bounces-865222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 415F9BFC963
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C148D6E6661
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201D534DCE2;
	Wed, 22 Oct 2025 14:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I5tmfBCo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681B334DB62
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 14:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761143199; cv=none; b=r79LkvDVHT1mOagek6ebQBlKQwqdK5QPA/eaYazoROhYLa3mHEqz2kUsmpD0zoJ9j6FokatamTyADk0j9shdy9MurI8RlCNMlAAhPqHjvbci64bDIbmE/H+uFoE7jSrD3dZGGbXGBTWJmbP4xiBPEkOkRK1C9NTp+aK/j6+35kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761143199; c=relaxed/simple;
	bh=WPFbo9YO3Pyw1iyvVznyFGv5zJuD7NvB1FRw0HBOe9w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Qe41Bnncrg4mIBNH7DsmzHV1jH0rzYnG1cENMbJVr3OZdQ5K9UzfZpU8It1Oruejj2DzdHb2lLb5Te8cXzHM9orKtazPpoJc6GzDAh0Wm6jtBFTS+Rh6gEhhmrKsGmFJ1TvnXKYb3252NkgQm3dclPwpzfJuhkMMpGOd6lA0vNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I5tmfBCo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C297C4CEF7;
	Wed, 22 Oct 2025 14:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761143199;
	bh=WPFbo9YO3Pyw1iyvVznyFGv5zJuD7NvB1FRw0HBOe9w=;
	h=Date:From:To:Cc:Subject:From;
	b=I5tmfBCoHIjqQdpWx9JLd4NhTdht8cyYwBvpbw3fFbiBLlUUJORDtqGBWf1SVkYZB
	 CY9EqJSpGkUmfVoQofbVL6Ay0PcTDDYS5KaR+DXJXOJFK9Hd7gWFzYY5D97fmj+wQm
	 uuNa5NmGjckWWQnOg9m0bE10DrA/lFdsK/mSzKVtLpa/mnNffCyphrWrxjNH7m4+sY
	 EWir05GBMyRQSgLXrR36g5Wqq6jpoDj+kR4/pv7zNA6znNUS/PRuogZMOWDOwPXppt
	 Uzi9TzfBt+Im/x9lFFs8wUi2nlat9cQuDZVOJ6HPRQsvxCKzDY63jVuurMrbJUbUB6
	 3tGm35fxXlnzg==
Date: Wed, 22 Oct 2025 22:26:25 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Chao Yu <chao@kernel.org>, Hongbo Li <lihongbo22@huawei.com>
Subject: [GIT PULL] erofs fixes for 6.18-rc3
Message-ID: <aPjpkWvwoMrKHxvc@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Chao Yu <chao@kernel.org>, Hongbo Li <lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

Could you consider those fixes for 6.18-rc3?

Just three small fixes to address fuzzed images in relatively new
features, as reported by Robert.

Thanks,
Gao Xiang

The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.18-rc3-fixes

for you to fetch changes up to 2a13fc417f493e28bdd368785320dd4c2b3d732e:

  erofs: consolidate z_erofs_extent_lookback() (2025-10-22 07:54:31 +0800)

----------------------------------------------------------------
Changes since last update:

 - Hardening against fuzzed encoded extents

 - Fix infinite loops due to crafted subpage compact indexes

 - Improve z_erofs_extent_lookback()

----------------------------------------------------------------
Gao Xiang (3):
      erofs: fix crafted invalid cases for encoded extents
      erofs: avoid infinite loops due to corrupted subpage compact indexes
      erofs: consolidate z_erofs_extent_lookback()

 fs/erofs/zmap.c | 59 +++++++++++++++++++++++++++++----------------------------
 1 file changed, 30 insertions(+), 29 deletions(-)


