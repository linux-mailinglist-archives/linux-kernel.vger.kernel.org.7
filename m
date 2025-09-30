Return-Path: <linux-kernel+bounces-837388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4189BAC36C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 11:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 808831926F44
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891A52F616B;
	Tue, 30 Sep 2025 09:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gofnQE9q"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352442F5A24
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 09:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759223683; cv=none; b=T2dTK6BQwBBKTdwA63GVOYrcUGmctPUppEsxwVP1kPmHvMKen890ksmS/SfwmUFS+uKEVq8IUGxM5aX0Kfg1zM59z6WfV1jzx7gXzbMW+6FA8RyH5fz5ev072HjwJt9hHIGMwVWYf+JMWRl/G98823hgTnvvULyXNpwA5dU6rAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759223683; c=relaxed/simple;
	bh=14yGhWhxJxKPIeIrNLfrEWF/S6UUQE2k4azZt9Ge4F0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=huSXS/3TVbiIS3PA6MH5lRiLb1VjHVumJ+M7zKOrVXR8bpapdmlP7kk2BBUL9IwnqOfZoWWLr+yvgLdglSy9hHLmjwvZbVOn5JxPP/sRVp80Njyw7gGnTZoWaHqTDHm9mCfd6MZ/87H0VxWgWhGWDmdt+FmkpPPFB/wIaYFDIHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gofnQE9q; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3fffd2bbcbdso103504f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 02:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759223680; x=1759828480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DH1NlSlaEudUba94N0gvDnLMb1d3cyB+74kEXFRWj1E=;
        b=gofnQE9qaKwg1IFLtVmV8vCCvj8j9uoW+WbCZAyfWJpvrgb3kqJ9+mpjmXuxRwHPTQ
         0+WeOrlx85++KzdOdsf7waKpAFKtKP/YJNr7LjFV/ht9iCMNdnUDWHI95lzFl/nCR2y9
         CNKUjkdJkcmzFdJXFGeBq1qfEgU9wu/TTFJ+7IUxKqbdCEmXvOSgwwc0npo0ztxCPJ+o
         pwOJISs+hIsxhTDiITPufHS61C3T6J772iPvFcVqkliNGHWZX6go/IBGTsX1qUDGkn4D
         OAGe2C9aI7FY3tsFE5R6daBDWzWF7tLg0c9Ew9FjjuVnrOypkWz1gatda1Zn8oLNpgNK
         Y4cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759223680; x=1759828480;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DH1NlSlaEudUba94N0gvDnLMb1d3cyB+74kEXFRWj1E=;
        b=hl1lvbkpaViWmyupOVmitVp5rRZxVTQ0qPp4/Y1Ztij1N9yNBxv2sRavYU0oPnG1tl
         6xM7hRsdbl+x0YE32zjnqTO5WI6znqyEPNPt5IoYAg3ES98LQ3a7QZyI0BjwJS7Kdtvu
         vKsrOeDmYnmgEoAIiC8WTmv+4LhckvianQNKHNx0JkSKwXbLiVL/ylVAqrhqo8LthpGn
         2dFsWxxGZTY3OriSpEtxuNgOwsWXMDUYEzJSDG27t35h32r6dPm7bEfcTq9umfSYFBuX
         lxFYu5bVqZntWG7MXrr37/1Axaf4G5SDfKAdkAQIUa7kZRBKUApERmBWoBzbAlUnkEdB
         +Mog==
X-Forwarded-Encrypted: i=1; AJvYcCU6x29ccIIkHehkHHoWyPJlgb4k6jBfDZuMEP8iUK5OGtp0wgWFhK24NseSh/pEZi+vbnfPoQXW0++cnAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YykJOiflLBQ0ETfNQu6eJL39OVNp3iY5RG5MzDQ2oPw1KMfZvIn
	XrUQGXNk25VnOSfirMoqjkWcPNcTMLIU9vy9LBNzbotz0nLmzgQASpaF
X-Gm-Gg: ASbGncs59z3CEh7DbcX335kGWjLLZoMJ41OOBLXiwH9CF0mdkyjQ6pwuPzI/wKRTvl/
	cWnlovVxIAi1DGqB5qq3EUWz67XJAVzFaXueBf1smUQy72SE0Q+wDScM5qyt2nlWzMAWXLlfOqd
	Au12N9sOX1tZhTcepGi4bqu1NV3dtHPLUO6HGm65q/Y+CMV0BNrTit90xHAzLDa/mumhQRuENag
	mgDGZn/T6zgw1Y0djHxTae0oZMIIiMfHhaf2sD6UeiGWk0G4bTK8mCwokVhkV+t3Id6IOD1jyLp
	o9muPlahKJR6GXuOqLAjpgoDolnRS2504b+6qZ7fIgORqmzUv1XMRVSoaFzjeFy/iNelNUB37h7
	bIi+kd+2+Xx3McHr6iMBEOvABM/uf4/LHoghdslo2ZLqRrCfrZgFMMJ41MDSulW4ECd2Z97ZUB6
	8=
X-Google-Smtp-Source: AGHT+IHLikjr1LvbOBlnMIgFiu5KZJiA4nat4K1Q3fyVS+a1hd0LvhBcizuVjM3yI2Nj4+3iyJlerg==
X-Received: by 2002:adf:b64c:0:b0:3f4:52d3:7a6a with SMTP id ffacd0b85a97d-40e503e0212mr7500503f8f.10.1759223680399;
        Tue, 30 Sep 2025 02:14:40 -0700 (PDT)
Received: from bhk.router ([102.171.36.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb9e1b665sm21775209f8f.27.2025.09.30.02.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 02:14:40 -0700 (PDT)
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
To: clm@fb.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Subject: [PATCH] btrfs: Refactor allocation size calculation in kzalloc()
Date: Tue, 30 Sep 2025 10:14:22 +0100
Message-ID: <20250930091440.25078-1-mehdi.benhadjkhelifa@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Wrap allocation size calculation in size_add() and size_mul() to avoid
any potential overflow.

Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
---
 fs/btrfs/volumes.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index c6e3efd6f602..3f1f19b28aac 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6076,12 +6076,11 @@ struct btrfs_io_context *alloc_btrfs_io_context(struct btrfs_fs_info *fs_info,
 {
 	struct btrfs_io_context *bioc;
 
-	bioc = kzalloc(
-		 /* The size of btrfs_io_context */
-		sizeof(struct btrfs_io_context) +
-		/* Plus the variable array for the stripes */
-		sizeof(struct btrfs_io_stripe) * (total_stripes),
-		GFP_NOFS);
+	/* The size of btrfs_io_context */
+	/* Plus the variable array for the stripes */
+	bioc = kzalloc(size_add(sizeof(struct btrfs_io_context),
+				size_mul(sizeof(struct btrfs_io_stripe),
+						total_stripes)), GFP_NOFS);
 
 	if (!bioc)
 		return NULL;
-- 
2.51.0


