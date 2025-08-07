Return-Path: <linux-kernel+bounces-758725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB398B1D32A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 09:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D37118939C1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 07:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CEA0235041;
	Thu,  7 Aug 2025 07:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BlM+3OLn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBA68F48;
	Thu,  7 Aug 2025 07:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754551181; cv=none; b=QjMYnfnXg4ls03O3LplRo2f/s+YoH0FCOSg/3tOYqrQ7Lp2j7+lnrIp32BAnymY+c5DH4av0ootpTMmeHCZ/fT+7mY5dC5cbyo3TmwcD28/pZ9pTba8GKqhBCL2V3/iPpROai7K1Du+EcBx4ZwF2ucpZieW5HTf8azggq4DZJJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754551181; c=relaxed/simple;
	bh=AdJdBzD8fCrkZiV1XxDiJs2KuaTiavg3+PN4NwbZwyw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T587aAzx1ZZqkyexiRoWfVQs+0kIgtVhihLy8swsCsrAds3mtHUktp+SUDLd38UAtRQvQRFY6rUy/RKDAXL9pxihPUQBbVftyez97jZKybTkohdzKepImdoOHHmn5QIvMHPwS6o0X8BomIm2bXjIJUucsM4K9P2DHg9HkgQ6L+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BlM+3OLn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19432C4CEEB;
	Thu,  7 Aug 2025 07:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754551177;
	bh=AdJdBzD8fCrkZiV1XxDiJs2KuaTiavg3+PN4NwbZwyw=;
	h=From:To:Cc:Subject:Date:From;
	b=BlM+3OLnxJ3U6yt4pjlo9B5jGguBk/5a4iWnw7WsGu/YCMpVhugBCZnHXUXb97NBR
	 fa2iUyKqUZV+CyVc+H/m1d+SABz3YylWoKn8nbCqk4p41RxVKCCGKzuan9ml/9j5t9
	 HaLFQKI8yXPzUzf4eSCIv3BKIfT4ATCC8g5g+zIh/Fl4VEb7hqQUtRBAPAlGhIkXlq
	 Ka1O28AjRGJPutdrB6ZiXUlwccNGMtH3vE7XhA9tFJRZ2JHVA4O/n1x0Xohhz3NxYE
	 sUo10rUkB0DRGvhGvImbbif/AhfnNN+3AJArwJ2m7Ubt9/K1vzLwISiesO6KP6Kv3Y
	 oJTcJXtntYVSQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Lee Jones <lee@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] mfd: madera: work around false-positive -Wininitialized warning
Date: Thu,  7 Aug 2025 09:19:28 +0200
Message-Id: <20250807071932.4085458-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

clang-21 warns about one uninitialized variable getting dereferenced
in madera_dev_init:

drivers/mfd/madera-core.c:739:10: error: variable 'mfd_devs' is uninitialized when used here [-Werror,-Wuninitialized]
  739 |                               mfd_devs, n_devs,
      |                               ^~~~~~~~
drivers/mfd/madera-core.c:459:33: note: initialize the variable 'mfd_devs' to silence this warning
  459 |         const struct mfd_cell *mfd_devs;
      |                                        ^
      |                                         = NULL

The code is actually correct here because n_devs is only nonzero
when mfd_devs is a valid pointer, but this is impossible for the
compiler to see reliably.

Change the logic to check for the pointer as well, to make this easier
for the compiler to follow.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mfd/madera-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/madera-core.c b/drivers/mfd/madera-core.c
index bdbd5bfc9714..2f74a8c644a3 100644
--- a/drivers/mfd/madera-core.c
+++ b/drivers/mfd/madera-core.c
@@ -456,7 +456,7 @@ int madera_dev_init(struct madera *madera)
 	struct device *dev = madera->dev;
 	unsigned int hwid;
 	int (*patch_fn)(struct madera *) = NULL;
-	const struct mfd_cell *mfd_devs;
+	const struct mfd_cell *mfd_devs = NULL;
 	int n_devs = 0;
 	int i, ret;
 
@@ -670,7 +670,7 @@ int madera_dev_init(struct madera *madera)
 		goto err_reset;
 	}
 
-	if (!n_devs) {
+	if (!n_devs || !mfd_devs) {
 		dev_err(madera->dev, "Device ID 0x%x not a %s\n", hwid,
 			madera->type_name);
 		ret = -ENODEV;
-- 
2.39.5


