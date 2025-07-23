Return-Path: <linux-kernel+bounces-742776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE79AB0F680
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 17:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E2D4AC81AA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 15:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07312F6F8A;
	Wed, 23 Jul 2025 15:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TG90Q8wS"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F78E2FEE21
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 14:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753282781; cv=none; b=nte5ag4X41eh+I+HIextsn+KicC9HQ77p9muamW2UxqhqKhR6p39oT27KnzXsHZ7Rf+FHXCP1GN6KrKqTLsaFLlVa9BoGBDFlZTStRNKg9nRQU3PZJmfDv5t/blI6ri3y1BJc7YSh171HPKI6dKfYYO/NmsXIDPLpiNHKXCglxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753282781; c=relaxed/simple;
	bh=lflwo8SbZiHuOx3xbFXIdZycCovxTAPGMaMcaHzVYj8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kxlXdjaYCkUDtL/PFqb2fonkNA3Ul0pQAsRkjYMxm2sHfLbFyA4A8PpkXMafKA6wuiT9NHHTY3CXbiMhVOU4hdOLNPb00hhTBI7JHDoJE92JGeDYFldRmVjiBziTtQKOqmHdRwbRI3SIBcdiXO2NDcxlVJbpPP1BU/SQ4Q98dGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TG90Q8wS; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-74924255af4so31247b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 07:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753282723; x=1753887523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/27YwIdqSPt9Qb6PywKqMjxiHr6G2jrbmK4p6axtTxg=;
        b=TG90Q8wSvgBGDF7H4wLVamkKf/kF9lnWa4A94/D/nS03ovs9zdfcmdaaROcRnX2Pa3
         zTILAFrTkbCH9NcVQ+fJscyIvsQPvgnw4vfbOAjBkagljFvjzAOeISOUXnuIOlSS0snb
         T5ms1j8OphOyI7eLnuOfpXieD2fVsxXsp3Nhiwu/ooEPG5M5i13eAdNb5tmBqMwQkAv6
         Gy7mjXjcel+LcnqH610nLBjJBkrIm8v6mfkpbF7+vVYa4w4RlnbE6+/0MKlybhMSRwDe
         yal2vgLEa4YsYhSSeO/q5vNckvXDGhJExe/YZYFHDfVddpdF4o5kwuHXHbyezinH4KkY
         dvlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753282723; x=1753887523;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/27YwIdqSPt9Qb6PywKqMjxiHr6G2jrbmK4p6axtTxg=;
        b=dPo8KJd/Tzakvc5zE4n7JM+0E5yBTkpSg4Ck9ftHj8pbh0k0U7YYJYeGR+thvoTcri
         nAVsqzj28wEKwO3wTxv9Lxn+gcG9a/qO2mMGN4f8heZDimFXGtho68y7v5AMIkgOgg2E
         /3HIKwloPzRRmC7GfX7y3y3SaCM/15d5M2MPGtmE0HigF7SfSZCpcFDxflRQAkFt3vhf
         ApTmfCbz1IdQmuEbk5FtuwrD4PiAq11r1FmVx/qusvuJ0XZf3A8tbb/wqKIB7Fu5HCye
         1suQMQql+IM4WuGno/ozwEF9fwjW3k1+UIhhgNfmoOO3Xp3wGWFBQtBTlWlui9Kh5Atd
         ThwA==
X-Forwarded-Encrypted: i=1; AJvYcCUxWyBg++7lVmNBdwbXikvOxL1Avxtdef/1iWACnSiMn0ymc1Lbc/6RLgx6VH9aGaLp6wridBVLGQAaMI0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7fasRvzh9Qw8tg60+lbc1BV1d08jhV+gEIxqYTue7SdA7HxlY
	oCq8oxXOrB/pFkoLv9uA3jJThESneFNDkS/TfHTqmbmi5U3qBYhS3cIj
X-Gm-Gg: ASbGnct5OCW6aA1ECLpIRMWeWFM4D1Ob0y7Ao77KTVqeTzH905LEt+8ktILHaf+T4WB
	EBYCO1HDEYIDpm5ezc7+ZMoiznc+NHl/hKeaBkZrAcz1DqXMOL4hPEZgmJpBBhHR4tDuHueWTkW
	VpopbTv9A2Kui/M3vkJI20Vm+iNKyppCjLWIJ1t0OrWThy6wUQlh+f1Q3nPmZe4PvDqfTWsPOUh
	4FtU9erkQ4D8+3/gK295ff1lfLGtffpRO3Jftx1oTetuQobi+jS4+PWG6+11w3xfk2xPJjLc3/a
	y+8z+p6itsiA78HOqW81zM0/iywVZSFMbYLkjgiqfdRx1SrtmSHjFy90XNsHYdkW9qieIgqdhBL
	5HpNzTQvzp1OBs70mQnZ2dyxp3yPNLzIeh8TxUbjkJ9ikF+xt1Yja
X-Google-Smtp-Source: AGHT+IEkfb/SYBi3q2XRVyGH3z+jt9CTWm3ql3e+4v/7AAgYckTussYE8f23iAqgOygr3QtsNYqTTw==
X-Received: by 2002:a05:6a00:180d:b0:754:7376:548f with SMTP id d2e1a72fcca58-76035bf6feamr5239852b3a.23.1753282723479;
        Wed, 23 Jul 2025 07:58:43 -0700 (PDT)
Received: from localhost ([61.152.208.177])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-759c89d55c8sm9962989b3a.62.2025.07.23.07.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 07:58:43 -0700 (PDT)
From: "mason.zhang" <masonzhang.linuxer@gmail.com>
To: chao@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH] f2fs: merge the two conditions to avoid code duplication
Date: Wed, 23 Jul 2025 22:58:37 +0800
Message-ID: <20250723145837.187089-1-masonzhang.linuxer@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional changes.

Signed-off-by: mason.zhang <masonzhang.linuxer@gmail.com>
---
 fs/f2fs/gc.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 3cb5242f4ddf..2df02e36fd5f 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -278,12 +278,7 @@ static void select_policy(struct f2fs_sb_info *sbi, int gc_type,
 {
 	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
 
-	if (p->alloc_mode == SSR) {
-		p->gc_mode = GC_GREEDY;
-		p->dirty_bitmap = dirty_i->dirty_segmap[type];
-		p->max_search = dirty_i->nr_dirty[type];
-		p->ofs_unit = 1;
-	} else if (p->alloc_mode == AT_SSR) {
+	if (p->alloc_mode == SSR || p->alloc_mode == AT_SSR) {
 		p->gc_mode = GC_GREEDY;
 		p->dirty_bitmap = dirty_i->dirty_segmap[type];
 		p->max_search = dirty_i->nr_dirty[type];
-- 
2.50.0


