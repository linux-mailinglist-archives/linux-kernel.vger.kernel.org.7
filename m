Return-Path: <linux-kernel+bounces-762167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D7EB202F7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5AC324E27E3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDEF205AB6;
	Mon, 11 Aug 2025 09:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="fpyZf/6w"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841CD26E6E3
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 09:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754903627; cv=none; b=MHVd0YYDym5GFbVbskax6wXmSI6HP3iUQ2H3Rtl+t378/etUJ3iIR83z6guFHmTh2eow34Od0xYCIlvvIo+w2d0oGaUfBrcWeeqJQeEI+yVDf3LO89gwh/GEwNlS9jeN0FPrNLIEexRhjaM1NRS/X0qeB/wJNLe1X4i45/4OdF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754903627; c=relaxed/simple;
	bh=RtTVZLjTqyHu1cIzuelKKqvoRm3NQpOajnzBKgNHNfE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gXUH1qpi7cPA3Zf0bGb0m6Dk0cSLEb6HJkFh03eLua1OUpPun0rqwI8pnvXX+Dyg+HM65/9iSUQU+VHDWuUJ2atCtCX1LqslQ98bkXa1BA+hzwSRE6JwvEE8ggv7By9Pp++I6MAaencz51ZbmBqwzrQ7WmWGh+S22rXjCAKj+0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=fpyZf/6w; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1754903617;
	bh=RtTVZLjTqyHu1cIzuelKKqvoRm3NQpOajnzBKgNHNfE=;
	h=From:Subject:Date:To:Cc:From;
	b=fpyZf/6wD/4+Eynxo64B7bji6Ax0/0aJslC9tCLckobQt+ej1CMVc/TjiFNAKcAER
	 oHSCrKtOM5sLESwrG6iTtSgXrki1Vc7S21W0YlHPQbktjGTHJYGf4DVQRv+bxh0mG8
	 KdBiBpmB/aGDHqUXEJsio+rtv4EKI1JWX7Ca7Xbc=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v4 0/2] sysfs: finalize the constification of 'struct
 bin_attribute'
Date: Mon, 11 Aug 2025 11:13:34 +0200
Message-Id: <20250811-sysfs-const-bin_attr-final-v4-0-7b6053fd58bb@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAD60mWgC/33NQW7DIBCF4atErEMFg51AV71HFVUYhnqkCEcMd
 RpFvntJpCiLVF7+b/G9q2AshCzeN1dRcCamKbfothsRRp+/UVJsLUBBr0DvJV84sQxT5ioHyl+
 +1iITZX+U0WEXVUjW6ygacCqY6PeOfx5aj8R1Kpf716xv64N1a+yspZIKLNhodz6Z8HFGYuYw/
 oxvGau42TM8PaPNqgfNczuwHWq0NuC/nnl6vVGrnmneHrohhaT6wbkXb1mWPwtV+adpAQAA
X-Change-ID: 20250217-sysfs-const-bin_attr-final-d9e4d0cf8a1d
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754903617; l=1535;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=RtTVZLjTqyHu1cIzuelKKqvoRm3NQpOajnzBKgNHNfE=;
 b=0DwNw0BrJAPVYe7TDtbAkfDE5CzD5XYFjw+hG+2fVnoqm1Jm3XuuG5a51DRgHuYl3Wxb4GWBd
 xDndwpMrc1NDtsOz6GNlx3xa1xbrd6AwMccJo70O3L2b5AYVEhrJ+GO
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

All users have been migrated to the new const types and variables.
Get rid of the transition machinery.

After applying, make sure no leftovers are left:
$ git grep bin_attrs_new
$ git grep read_new ':!drivers/block/swim_asm.S'
$ git grep write_new ':!drivers/cpufreq/powernow-k8.c' ':!drivers/s390/char/monwriter.c'

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v4:
- Drop already applied patches
- Rebase on v6.17-rc1
- Link to v3: https://lore.kernel.org/r/20250530-sysfs-const-bin_attr-final-v3-0-724bfcf05b99@weissschuh.net

Changes in v3:
- Drop already applied patches
- Constify internal references in fs/sysfs/file.c
- Update const_structs.checkpatch
- Rebase on linux-next/master
- Link to v2: https://lore.kernel.org/r/20250313-sysfs-const-bin_attr-final-v2-0-96284e1e88ce@weissschuh.net

Changes in v2:
- Rebase onto current driver-core-next.
- Remove prerequisites list from cover letter.
- Link to v1: https://lore.kernel.org/r/20250219-sysfs-const-bin_attr-final-v1-0-02828d86af3c@weissschuh.net

---
Thomas Weißschuh (2):
      sysfs: remove bin_attribute::read_new/write_new()
      sysfs: remove attribute_group::bin_attrs_new

 fs/sysfs/file.c       | 22 +++++-----------------
 include/linux/sysfs.h | 11 ++---------
 2 files changed, 7 insertions(+), 26 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250217-sysfs-const-bin_attr-final-d9e4d0cf8a1d

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


