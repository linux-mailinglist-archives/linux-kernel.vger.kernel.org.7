Return-Path: <linux-kernel+bounces-825600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8A9B8C4DB
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 11:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73D157BA0C1
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 09:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE332C08C4;
	Sat, 20 Sep 2025 09:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MCDoAt2T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C276F28689B;
	Sat, 20 Sep 2025 09:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758361234; cv=none; b=QtxWGejVkwaiVbj1RKZLW4v6TZ2zOPDLpBWq22m6w6u084uFQMxgkacByomNeG4/h1oL7ZzO/pFL6HkBnDtrKH4oJjrxP2TurnevLugirxbd2/jPnPnhFtjnlJDVV0unsJkbDrZN8LXLCLEIyz31F55OlaM9PeJ6lhnolfmGd78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758361234; c=relaxed/simple;
	bh=V3i0EJlJy0Ol7ItqJxFm4AqKCM48LgFSOdW0M2CfvxM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m+GLvT6aEsdg/YX4iZIuOcIggdFJEXWCiTflh/HPglvUKP8KAECtkE17HuLJ6mIxOkJv9j3+7Gj+4wQMg1ngV0IoPRyZSETMrgZ2kzES9nLfnTdm2sccOL4UDtDMeV7pLqz/zebVpsXCdfsEpbNg9dsVpnkL4FBN3dZxJ98FXTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MCDoAt2T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5646DC4CEF1;
	Sat, 20 Sep 2025 09:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758361234;
	bh=V3i0EJlJy0Ol7ItqJxFm4AqKCM48LgFSOdW0M2CfvxM=;
	h=From:To:Cc:Subject:Date:From;
	b=MCDoAt2TriGgEq9Z7vxnreVGN3Hp9IjCF+jMncemX5zDY5Q0JImv8Sy2bWql2Ciqu
	 VrilAY8+kih8klNJVJORHQrpgDU04BhI74/KnRI1C0T9DjZoGp0wcN8GaO/p7c2AM/
	 UoCQ5C7Dv01eFbwrlNYARS4WpRBjM1+OOmrF8EEBVyrulmFeayrenuvq6QHKrnPfCM
	 k+MBOMLWsm5cnSatUgMK96UdqDGAc2ntdoBV0v9HsJAhkgsgbbvSAtNU49WS3Tk+a8
	 EvCiWS3xAuVg/HJtR9FnanrdjL1yWsnIv2wbmGqtXE5uRewMUDlXXny3/crAKAfCot
	 qR657MuFj/X9A==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uzu52-00000004Z2p-1Fuu;
	Sat, 20 Sep 2025 11:40:32 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 0/3] A couple of patches for sphinx-build-wrapper 
Date: Sat, 20 Sep 2025 11:40:23 +0200
Message-ID: <cover.1758361087.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Hi Jon,

This small series is against docs/build-script branch.

The first patch addresses the lack of a check after running
sphinx-build to see if it returned some error code.

The second patch is a partial revert: we wneded including
sphinx-build-wrapper twice due to a badly-solved rebase from
my side.

The third patch is a bonus cleanup: it get rids with
load_config.py, replacing it by a single line at conf.py,
simplifying even further docs Makefile and docs build system.

Mauro Carvalho Chehab (3):
  tools/docs: sphinx-build-wrapper: handle sphinx-build errors
  scripts: remove sphinx-build-wrapper from scripts/
  docs: conf.py: get rid of load_config.py

 Documentation/Makefile              |   8 +-
 Documentation/conf.py               |  15 +-
 Documentation/sphinx/load_config.py |  60 ---
 scripts/sphinx-build-wrapper        | 719 ----------------------------
 tools/docs/sphinx-build-wrapper     |  18 +-
 5 files changed, 16 insertions(+), 804 deletions(-)
 delete mode 100644 Documentation/sphinx/load_config.py
 delete mode 100755 scripts/sphinx-build-wrapper

-- 
2.51.0



