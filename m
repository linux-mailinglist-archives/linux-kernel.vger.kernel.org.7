Return-Path: <linux-kernel+bounces-758553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95397B1D0B5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 03:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A184A582A69
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 01:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD59821ADAE;
	Thu,  7 Aug 2025 01:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pwG8Fu7t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A01517C211
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 01:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754531335; cv=none; b=d9ALklMSlZERzC8ecCL5NzWhJfoSc/2edF15OY+mLxMuNnmhPv/Qu3uH2UJm+QoqziTyHxRdHN/hqDHfijm/GeNIHTvVTsO+JZiWO4pP2Nek7YNKpMmZXa9RMFghndI59ylm8wXK12wHl6M1b40+fbveU1wiBtDDHuC5MqpsasI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754531335; c=relaxed/simple;
	bh=NwGyzV0uPsVPS98dCHheGmGxPIh3v1lpFVzgj9NHjQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZU0jcgo0oOqiiW3Pt1h6Y23H8Gqr3TAZNlBHPg9J4bxNb2cHsAwX2EZKMu4+TnorF+5pPEW/CQ4AAyCQqkBKqCBZ3LSihhjf5kjZdhHbFc81B2jAXabotBTcUfnwKyhEBYDGX7B9VC8m3QwNC6LFvnAZuaCADIJ8+lL5UTKf9aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pwG8Fu7t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64CDAC4CEEB;
	Thu,  7 Aug 2025 01:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754531334;
	bh=NwGyzV0uPsVPS98dCHheGmGxPIh3v1lpFVzgj9NHjQ8=;
	h=From:To:Cc:Subject:Date:From;
	b=pwG8Fu7t+iYodC1k+T7Mxon11m2dralbZeg5KG5rJC0mDdnhhpBFFUs01nkvkNEQQ
	 oTKMHT9P121wlRScZ/4mudXUWrDU3hDQIjFUzxrzeNGSETz1Qx29M32asSHLUfgTTz
	 FM1dpN7w+jMo0fZ1CI0rMDTpVIdVtLW3Ma0k0QLeYcvSbSStjzSxZQozgRfqdAuvbk
	 9t3+AGpD2a9z0xgBvFH/Ruys6lKUwBCymhDo52gSOnNID1Nbzywi9W+vJZZAW908LZ
	 Vrcgj7dVWMxrDIyS+EcKYzKmJpQczqSZ8wxOV9GFKaB+jesjO7Yj/cL0ViEwCvEUEd
	 NT7XtWXh/TTyg==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: fix to clear unusable_cap for checkpoint=enable
Date: Thu,  7 Aug 2025 09:48:35 +0800
Message-ID: <20250807014836.3780988-1-chao@kernel.org>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mount -t f2fs -o checkpoint=disable:10% /dev/vdb /mnt/f2fs/
mount -t f2fs -o remount,checkpoint=enable /dev/vdb /mnt/f2fs/

kernel log:
F2FS-fs (vdb): Adjust unusable cap for checkpoint=disable = 204440 / 10%

If we has assigned checkpoint=enable mount option, unusable_cap{,_perc}
parameters of checkpoint=disable should be reset, then calculation and
log print could be avoid in adjust_unusable_cap_perc().

Fixes: 1ae18f71cb52 ("f2fs: fix checkpoint=disable:%u%%")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/super.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index f37004780ce0..c1f45df9efec 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1014,6 +1014,10 @@ static int f2fs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 			ctx_set_opt(ctx, F2FS_MOUNT_DISABLE_CHECKPOINT);
 			break;
 		case Opt_checkpoint_enable:
+			F2FS_CTX_INFO(ctx).unusable_cap_perc = 0;
+			ctx->spec_mask |= F2FS_SPEC_checkpoint_disable_cap_perc;
+			F2FS_CTX_INFO(ctx).unusable_cap = 0;
+			ctx->spec_mask |= F2FS_SPEC_checkpoint_disable_cap;
 			ctx_clear_opt(ctx, F2FS_MOUNT_DISABLE_CHECKPOINT);
 			break;
 		default:
-- 
2.49.0


