Return-Path: <linux-kernel+bounces-821982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94918B82C2F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 05:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30A897220F9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 03:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1911F099C;
	Thu, 18 Sep 2025 03:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yx/E+x59"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AE134BA27
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 03:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758166373; cv=none; b=Xh/TLbkL2SQa0q7BltLdBacc8slGK+YRgYNiUvaluqwTl7Vwev1u9XUkpAtcSdAxIgkBHzV3O8sEaZHgz3DpAKy0xMy12zfMS8xzK6XcKeo/xDrhaTpdXG2QJoeR31Sz9RzwfWE7Q/9EnB2W6l++VwAG46Xh74CPV/Et2+a0Ls4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758166373; c=relaxed/simple;
	bh=G+ajCIiOtZPxJxQ7IluxlTc2+l1bJUWORu9oDo3Rh8Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=nHSXTFw2gfL0dFF5/DdXEJ4u/GWDTsFaWUAwqLc60fdK/kt1AFoFJBlXRRHJAUV5M5wt4zOje5HTgGpWGTb2ndgmuGmBeGegVLeLdNGM9VmoS467WqxThia/O549OcUTYVA9fX5RQyr6mG3owTBzBKqxVNXNfBytJ0v86OAdiPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yx/E+x59; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2FC9BC4CEEB;
	Thu, 18 Sep 2025 03:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758166372;
	bh=G+ajCIiOtZPxJxQ7IluxlTc2+l1bJUWORu9oDo3Rh8Y=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=Yx/E+x59so/anGGuFDyTaVyPcFub3sZ9XwchY07VF5SsYHACj5LOrFtByv1/Ypqg1
	 X8TrKQWSTQPS602SKNW9z1qClRMAGBputePFdXhSp6tRU9HqB/tjg3lIG8cfAh+Y/c
	 YJ5NCw9/shAv7t83SS72QEbVPB3pG+lsrqcGMs/YyUsK6fntt6D3RkmzcC+wFWxdDG
	 o4vOGJFUg8nkvVQPqeGGt3K8YQcs2YBLFCK/XKx6Ts3UH36j604RD7LK0Yfw5JJcUk
	 G0XViqE9b/+pZdAlwgiPaa2fQbhDpOw3d2jfKOlwl12Yo/mNhZxoU6YtY+LsVgfj7D
	 arvi2SQZG8wuA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB00CAC5A7;
	Thu, 18 Sep 2025 03:32:52 +0000 (UTC)
From: Jiucheng Xu via B4 Relay <devnull+jiucheng.xu.amlogic.com@kernel.org>
Date: Thu, 18 Sep 2025 03:32:42 +0000
Subject: [PATCH] f2fs: Use mapping->gfp_mask to get file cache for writing
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-origin-dev-v1-1-8d9877df9e77@amlogic.com>
X-B4-Tracking: v=1; b=H4sIAFl9y2gC/x3MQQqAIBBA0avIrBtQwaiuEi0sR5uNhoIE4t2Tl
 m/xf4NCmanAJhpkqlw4xQE1CbhuGwMhu2HQUhu5Kokpc+CIjiou1ng/n0TKaxjBk8nz+8/2o/c
 PLoFscVwAAAA=
X-Change-ID: 20250910-origin-dev-8a5ff6bee1f2
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 tuan.zhang@amlogic.com, jianxin.pan@amlogic.com, 
 Jiucheng Xu <jiucheng.xu@amlogic.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758166370; l=1204;
 i=jiucheng.xu@amlogic.com; s=20250821; h=from:subject:message-id;
 bh=Cfox4dJD5Z2I7UJ/AEjRgz28jZFDDgARsCgPQjW/S2A=;
 b=Tt6i/YFFmrIxDb3zDxPDh8BLNgR4ijbjwG/tkeEdWisUTLHUlLWv8JzFkU0BNDud+e04A9d1f
 U6Q8769JzCRCiUr5cpMFT+GqDKx2k6WOhaq6ElusJ12hhH59FX8Uyn/
X-Developer-Key: i=jiucheng.xu@amlogic.com; a=ed25519;
 pk=Q18IjkdWCCuncSplyu+dYqIrm+n42glvoLFJTQqpb2o=
X-Endpoint-Received: by B4 Relay for jiucheng.xu@amlogic.com/20250821 with
 auth_id=498
X-Original-From: Jiucheng Xu <jiucheng.xu@amlogic.com>
Reply-To: jiucheng.xu@amlogic.com

From: Jiucheng Xu <jiucheng.xu@amlogic.com>

On 32-bit architectures, when GFP_NOFS is used, the file cache for write
operations cannot be allocated from the highmem and CMA.

Since mapping->gfp_mask is set to GFP_HIGHUSER_MOVABLE during inode
allocation, using mapping_gfp_mask(mapping) as the GFP flag of getting file
cache for writing is more efficient for 32-bit architectures.

Signed-off-by: Jiucheng Xu <jiucheng.xu@amlogic.com>
---
 fs/f2fs/data.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 7961e0ddfca3aaa332b7dbd4985ae7766551834f..9fbc41f9accb2626da22754f1a424da4805ca823 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3587,7 +3587,8 @@ static int f2fs_write_begin(const struct kiocb *iocb,
 	 * Will wait that below with our IO control.
 	 */
 	folio = __filemap_get_folio(mapping, index,
-				FGP_LOCK | FGP_WRITE | FGP_CREAT, GFP_NOFS);
+				FGP_LOCK | FGP_WRITE | FGP_CREAT,
+				mapping_gfp_mask(mapping));
 	if (IS_ERR(folio)) {
 		err = PTR_ERR(folio);
 		goto fail;

---
base-commit: c872b6279cd26762339ff02513e2a3f16149a6f1
change-id: 20250910-origin-dev-8a5ff6bee1f2

Best regards,
-- 
Jiucheng Xu <jiucheng.xu@amlogic.com>



