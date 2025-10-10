Return-Path: <linux-kernel+bounces-848127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA1CBCC96F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 12:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A215188D218
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 10:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7595E283140;
	Fri, 10 Oct 2025 10:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1dbetcx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32541684A4
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 10:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760093174; cv=none; b=DZfVJ2/Wwlg2z3OhVgcb3gTr4Lb+uK7lNL+95zJsHxOXa4lB7jTDz6OBl0843t0NYbmHGbS+B5Scj9M0/C40E5GP7MKfxGXiiRb00V8BVlcj6fpPYjfhBK18vU+q03BXulvzqhssdKOFJcyWI3rSxB51y152GzZKX9Z4JY+/Wt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760093174; c=relaxed/simple;
	bh=tu/3YXWndspnmW1FhqUQCHSgsgn+D8yeWmdhNr94be0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=eGeSuSYsVxEsLfZRJwftQieXStx52EiLY574t4NwayVfNHHUlrSa9H7JTggLu75XslLoR2CMFNeRj4ziErjbvHtehxO8NacfldHkEAlVP69fMse0jEHrT4JMrB6DwT0bfey2Z5tGsfhXfuodnEHgP6fWa9/8JCGNkDlWpHAzF1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P1dbetcx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3420CC4CEF1;
	Fri, 10 Oct 2025 10:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760093172;
	bh=tu/3YXWndspnmW1FhqUQCHSgsgn+D8yeWmdhNr94be0=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=P1dbetcxC7JH6TiV0CYv7t7Hz7X+nYXsccRgu4vFt0+W3c/SYSaXQkSRBOOMiejgZ
	 Qyl11SDtdEptqVsbFRxej1C2gAfgZKQ4mMw5MTpo6P21gFZd0N49xveVnRWfq1q7m6
	 TndqzwPj137LadyPNN/cgLE3IChtjPaSEDZjPKrGF+On426L4Q3R4OuHa0l9cEL4E6
	 vR/XrDF6ipbsH289YVitAlzsuJ6V9hq/VVeA2pLHW2PWEQMVhdqqEv6KGeZdiYVv2C
	 B620MtLb5szFkSvbwvCMiqP+m8kLUhnlXbYvSa9D2QpIeKIB2JQsbeVdfkXvFbIehs
	 3s3gDfVv/AYag==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212B3CCD185;
	Fri, 10 Oct 2025 10:46:12 +0000 (UTC)
From: Jiucheng Xu via B4 Relay <devnull+jiucheng.xu.amlogic.com@kernel.org>
Date: Fri, 10 Oct 2025 10:45:50 +0000
Subject: [PATCH v2] f2fs: Use mapping->gfp_mask to get file cache for
 writing
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251010-origin-dev-v2-1-952a3c98cd9c@amlogic.com>
X-B4-Tracking: v=1; b=H4sIAN3j6GgC/03MwQoCIRSF4VcZ7jpDhUlt1XvELEyvzoVmDA0pB
 t89Gwha/gfOt0HBTFjgPGyQsVKhtPaQhwHcbNeIjHxvkFyO3AjOUqZIK/NYmbZjCKcboggS+uG
 RMdBrx65T75nKM+X3blfxXX+M/meqYIJpb7RSPhhU6mKXe4rkji4tMLXWPrgQj7OmAAAA
X-Change-ID: 20250910-origin-dev-8a5ff6bee1f2
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 tuan.zhang@amlogic.com, jianxin.pan@amlogic.com, 
 Jiucheng Xu <jiucheng.xu@amlogic.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760093171; l=1482;
 i=jiucheng.xu@amlogic.com; s=20250821; h=from:subject:message-id;
 bh=ys2NNWUvMRWSNrqqE75d/Agpj0X5GunxR0O5cIjS0+s=;
 b=zBpqK6IpjtdrVtovPKjZFXMscyFRS/aovVGopagjDr07kHZ2g+Rn8Bz2l8yn850QC/rwg1Z2W
 5EdQvlweuoxAm5ybl4mHETIzsjc2dHIS0i4oIw3YzP9HmnTx/8heVz7
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

Additionally, use FGP_NOFS to avoid potential deadlock issues caused by
GFP_FS in GFP_HIGHUSER_MOVABLE

Signed-off-by: Jiucheng Xu <jiucheng.xu@amlogic.com>
---
Changes in v2:
- Add FGP_NOFS to keep original GFP_NOFS flag.
- Link to v1: https://lore.kernel.org/r/20250918-origin-dev-v1-1-8d9877df9e77@amlogic.com
---
 fs/f2fs/data.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 7961e0ddfca3aaa332b7dbd4985ae7766551834f..b449edb519d9069f58572685d607a2502e4c9473 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3587,7 +3587,8 @@ static int f2fs_write_begin(const struct kiocb *iocb,
 	 * Will wait that below with our IO control.
 	 */
 	folio = __filemap_get_folio(mapping, index,
-				FGP_LOCK | FGP_WRITE | FGP_CREAT, GFP_NOFS);
+				FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_NOFS,
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



