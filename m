Return-Path: <linux-kernel+bounces-781305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C77B310B9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75CA5604758
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 07:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2202EA172;
	Fri, 22 Aug 2025 07:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="JcM74I65"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FBA2E229D
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 07:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755848738; cv=none; b=fEZ1thhXKolPNPEV7sduE1yhNbHhfqiOpK7VVJcPthrAxDI2x0JOAGzEh6RB9uQdd2IxLkZ1+YK5DAjdP69zAh1IE6ES3T2z+dzLny0DyLKNaF48qR5+A7gpsMSTd13N/PhY4sEx6d+h7BK3GpTm6N1mVmln2ZG/8fd5NvWySbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755848738; c=relaxed/simple;
	bh=pOYY8IbzykKlajiaUqPlg+H5I7fYOHJ6et8LTF9TFWM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e/4rnPMUF5rp0v4myatAS6nSuqTAfLuWs3xZwEWJCX3AGn9NU5iAVJZRcM8KmMA47eAkImzSEiDtBvSp44+4uB7iWExomYL5I2W3c8c/lglovxAL5DjxhazyTvh6iW1DEjK9mCse9UqfzhytRSSXt/qJN1zJctWuUizLUCpny3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=JcM74I65; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-24456ce0b96so19128715ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 00:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1755848736; x=1756453536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zQda6eBqVzSr9dgydh5Dkc6Xy9AQWu6zr5QDxwU9nZY=;
        b=JcM74I65aYL72jFTsppLeS89J9u4CON34oJH7Tc48hRjcn047nM0FCbkhUkDKksgT1
         l00sGRGCbjYiNsUcUPZ0rYSebJxJ6sx0Ln55SLa4DfCUXZBR9uk+lpCnauATjqI/0yCv
         VnvJowIW54FjV2OR4uxgsRhg85jzHb2mTGf92wPIoNXQILCTeDzPLLFDAek4OycQklUO
         cu+dnlnJ+ZnfqqXR1SWUBJ2Qt5UR95yLUeiJUkN0FrdD/s+srEhcVEsLh7RG3wtcy5iI
         rWoP4DPWtKwiNb1yMMRm78r6H3w7p1ErppQwnEaZaSqFl3zMhh/cnAlRA9pCX/QRK/Vw
         56Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755848736; x=1756453536;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zQda6eBqVzSr9dgydh5Dkc6Xy9AQWu6zr5QDxwU9nZY=;
        b=MqSy4fPpplQB1kQoPGzbOBDWpx06v6aBX5r4fHtLfMcHAfDBYAXEEGt7p/5yU+r0at
         cgF3DWclpGlQ51YRECOVu7hOZ4f3Yfqy72GXsr9mxfjnI7nIPCQM2QekKXsx0Ob0JjdY
         Ud3z3yANGtfrDoREOfGvA8ob64p6JQ7r7UFr5cuZibYhJo15eoVExqZUNuRbU2fZIxfE
         KmOZdYjnQU6FMsS/kDAZpvEBrzmmFJ2AcSaQjmbDmNiKu4EibYsx0S5UEYWNFaBUHCoi
         PiaIgmiMdwd9pmPxyrD22IBGlcLgc34va3myKy5d6zimqtE2U9fYP9frm5qDo8/fwiua
         v77w==
X-Gm-Message-State: AOJu0YxUV3CXbJKwfOjSmxni1lB6uO7674z7N/JesMwNdH9EwrlYTh4M
	H9YAfsjFk+xRPWbzEo0mN/v2oz3QpZifFWENdDl1+o6yUQVzAkf1GySTg8Sasf/WV1UmT40LC3k
	1qavT
X-Gm-Gg: ASbGnct+BIeRXfBDu4MJEImLCQ+OdnlSBgwnoWrSkMdneQJZQTXe1ID/xcgfvF0kPT5
	uWh6wkmTbxiyOjXtlACcoaJwfUKeUqR9NVZjgSHe1mPG03LNZegEg5Tr8L6VdQsvhQULfzTerD7
	mbNmqzqZGfAheHzerxc/wVkdP/ImADbzTaXH8umUYRcxHVx7H5duH99Ip+Imh0Sb6hKrjzHZFue
	3NuXK6wJc7VoukKnzDPX/vscZ8SwIJmTiAu83hgsct8hYoQQW7trdPLGaVIRLo0/6ZH35vDCvLZ
	L+HXHkB2cBtC1PcZCee5vspV/76CA2PIh7Qqo4hHib77JZOeFXAinW7p+q3cBDY7CvtQzfAOD8O
	ObG+FvayIsE+huqkb/1NlMxU0
X-Google-Smtp-Source: AGHT+IHXHQCF6vOrnsai6HbfSjEV2wNbQ9TB3wyUJIrIpWJasLsSLJwatr/p//AVc6F3BVE5eLBqcA==
X-Received: by 2002:a17:902:f707:b0:240:ac96:e054 with SMTP id d9443c01a7336-246337acf34mr23872025ad.23.1755848735931;
        Fri, 22 Aug 2025 00:45:35 -0700 (PDT)
Received: from mozart.vkv.me ([192.184.167.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24646229d6bsm8245885ad.23.2025.08.22.00.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 00:45:35 -0700 (PDT)
From: Calvin Owens <calvin@wbinvd.org>
To: linux-kernel@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Daniel Vacek <neelx@suse.com>,
	David Sterba <dsterba@suse.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Chris Mason <clm@fb.com>
Subject: [PATCH] btrfs: Accept and ignore compression level for lzo
Date: Fri, 22 Aug 2025 00:45:31 -0700
Message-ID: <a5e0515b8c558f03ba2a9613c736d65f2b36b5fe.1755848139.git.calvin@wbinvd.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The compression level is meaningless for lzo, but before commit
3f093ccb95f30 ("btrfs: harden parsing of compression mount options"),
it was silently ignored if passed.

After that commit, passing a level with lzo fails to mount:

    BTRFS error: unrecognized compression value lzo:1

Restore the old behavior, in case any users were relying on it.

Fixes: 3f093ccb95f30 ("btrfs: harden parsing of compression mount options")
Signed-off-by: Calvin Owens <calvin@wbinvd.org>
---
 fs/btrfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index a262b494a89f..7ee35038c7fb 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -299,7 +299,7 @@ static int btrfs_parse_compress(struct btrfs_fs_context *ctx,
 		btrfs_set_opt(ctx->mount_opt, COMPRESS);
 		btrfs_clear_opt(ctx->mount_opt, NODATACOW);
 		btrfs_clear_opt(ctx->mount_opt, NODATASUM);
-	} else if (btrfs_match_compress_type(string, "lzo", false)) {
+	} else if (btrfs_match_compress_type(string, "lzo", true)) {
 		ctx->compress_type = BTRFS_COMPRESS_LZO;
 		ctx->compress_level = 0;
 		btrfs_set_opt(ctx->mount_opt, COMPRESS);
-- 
2.47.2


