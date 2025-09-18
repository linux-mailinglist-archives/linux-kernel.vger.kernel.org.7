Return-Path: <linux-kernel+bounces-823501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 682E7B86AA7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 21:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 226B4480BC3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 19:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1592D3758;
	Thu, 18 Sep 2025 19:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BAbn0Zf0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E27372628;
	Thu, 18 Sep 2025 19:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758223368; cv=none; b=NOe1z6W8Fk4nKslUBDILvIJfq3LBePimSeGzGC5ean3oM3thGWMDdaHraKoNVnAFTUMJ2M5TWCbCvlAF4YBgc8zM0FFCN39NPMpVDVPT2Z8aCJLlwPre7PJAlCohiQSDM9p7oxsx8gDjEniussdDliJvy04YLntjC1DwnOYlL1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758223368; c=relaxed/simple;
	bh=uUTkBOCHlpE9jvtDKV3XPScDPvuC3VQ5F2qvTh6jLIk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eCZNeXXORU/DFW9gn4R6t5j1TzOJpIc6p1y8T8VL5WCZAsHoLjWEEYMYb3TSOVU8VCEcPVsZQu/EZRlswYIctsWRPpBujbP8JCBN2fQefT6hCXfsd00horNdzQxWbSM0Uy6Hc5s2D+Ab9GcUooYajFB7JMTkXc4ISh4uw5BB0KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BAbn0Zf0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A04DC4CEE7;
	Thu, 18 Sep 2025 19:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758223367;
	bh=uUTkBOCHlpE9jvtDKV3XPScDPvuC3VQ5F2qvTh6jLIk=;
	h=From:To:Cc:Subject:Date:From;
	b=BAbn0Zf07MqY+sjUJIbC5od42aLaFginsyXK8hlH9oUg2mk6nxkaQ60pTMToqssWu
	 MGUoH0/kM4TH6VwokFhtXpBRr16vrUokj3eRtSYrLyFd8i2cTLPk+fCRFUUiQHeL3t
	 LH/D1/GkmDOwDlxq4O4uidaRO0aDu4oztJsWc9OhRrlHnB76IBs6TdAWicXlp4dmvP
	 zTAtgFgn+0HkvRPjnNTxY7aG3H/vavVwiRbq1pHuECeDEcM3p64Y8fvpjYPOBnP0Sx
	 6JeJ3RhMzgK+GEqytC+bfQ7TJ596dwErRQ/oLmkBJhlS0sfS3XzBBzFt6EIfZiNmW4
	 /GALPuaNhiBpw==
From: Sven Peter <sven@kernel.org>
To: soc@lists.linux.dev
Cc: asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sven Peter <sven@kernel.org>
Subject: [GIT PULL] Apple SoC fixes for v6.17
Date: Thu, 18 Sep 2025 21:22:41 +0200
Message-Id: <20250918192241.29374-1-sven@kernel.org>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sven/linux.git tags/apple-soc-fixes-6.17

for you to fetch changes up to 07db1def8f0aad25612b35377b63aa20b032c86d:

  MAINTAINERS: remove Alyssa Rosenzweig (2025-09-18 21:17:31 +0200)

----------------------------------------------------------------
Apple SoC fixes for 6.17

Just a single commit that drops Alyssa from MAINTAINERS at her own wish
and adds here to .get_maintainer.ignore

Signed-off-by: Sven Peter <sven@kernel.org>

----------------------------------------------------------------
Alyssa Rosenzweig (1):
      MAINTAINERS: remove Alyssa Rosenzweig

 .get_maintainer.ignore | 1 +
 MAINTAINERS            | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

