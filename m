Return-Path: <linux-kernel+bounces-835927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB188BA85DD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 10:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39EDF189B819
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 08:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0241273D6F;
	Mon, 29 Sep 2025 08:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AzZKGgDH"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E141239E79
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 08:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759133481; cv=none; b=KXZSN/3ESW4pmHqSMEhStVtxRE4v11rTib0Jp+26bI0AT9sgDE8mcQPdjrC0wRAQAClx7ab0QTJpo8YACrRBPWKb3J0g7FLBYqx9xK44WVrmZla5ulf9hUhqddB947gn2P1H+L8d1wMeMMu7IdkMDDVcgsiEXY6cajI8jSy0eiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759133481; c=relaxed/simple;
	bh=7qZskoFTAcc896x7pDEMBjGUIu8+uo07rVe2jac6zeA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=up11JH74eyPRjviilaXbyK0fwILa/74TzgmlwxB0m+l9RqyXqX5CC59fA4UCfT6XtvIU0jtYx7guLyyndDfDkJau0lm29A871TeRvMxuqzE9Vsn3bG6Bk8IoJ77p1cZ0bgzgITnOCrq0s3tXDVhdiojJ2GfD3TCdnoT9pf5oCJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AzZKGgDH; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b5579235200so3099105a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 01:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759133479; x=1759738279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yEDTck6Ih0LB4S3mK316czhYt6Y/6Luy06LhdwUneVs=;
        b=AzZKGgDHuGV/Cb+jVE2NF5LSjqzUTXtIEtIY7oVEORk/9kP5vP9QyFB5pL+9rDD9wv
         UbT+rgDiq3EuF4lJBtVWQzS5f2cGcwz6J5Xc8+fPNYD94aAq8f2O07Hj6mq8HOlLR76D
         RxMU4sFbl2QAz1SH4whasE20WAEEBdeM070QH7afBJxovlh4cvbSNtFMqEgqP1bNNcFP
         aX9j509FGhQiOzUHebD77T7jaBeaNgNIqiS0Wb1udvUq+kxgxKjUXiXLWBslZBe0BJLV
         zKrlR9ymqklArDKfC/1dhki+9XDfOrWp6/bhWNjwDydNJZ8u24BrhKrhtgb7sZ56znTJ
         ZdHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759133479; x=1759738279;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yEDTck6Ih0LB4S3mK316czhYt6Y/6Luy06LhdwUneVs=;
        b=WYW6okhHfPNvNsjeRSXdUsFfBJpA8ZiKs9+1mpgOrMvEMrizxmTCxV5KiUbDvPMm11
         cki58jnS7p9JKdtfGOMyAYKi2BPvJ8wqyfoRjoAXITn4ea3RO88ek5hDU8kNaP0z7EPA
         FnPspT3N0CgRqbCI/lQgw0L4W0AwThvqPrIPtEk8xRO9P0BQZMTmqyJ/wkqnLNYEC5++
         fFNQL9x9JHX+VOOJpCala9t0r8tFs5Ly4zuWIxROq0h4N4A5BSyLbfiD+dEYGJ9y4Zg2
         +TcduGq39u7EdM5uNyz9qbFYuFTgZh4/+jzc30sksMAu0RrP5g80knC9BoRiDRGIwpos
         e+ZA==
X-Forwarded-Encrypted: i=1; AJvYcCXpB4kUpotDsxAzdAIHXvJh1S0HWihLbLTd5jvVNeut6VwvPli0ZQpQi8vm00JhOqAYBnc9ljUvtnXs7NU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9Ih2IZBjcgm2DrrfRH7Z8pUZ39izGA50Ks3p02Ld5J0hGw8Qn
	Ce+j+743v840W0h+Rb+7EsJnzen/wlvoC/Pp3ySCwrkD7pJOWZdWQIn0
X-Gm-Gg: ASbGncvZQkSCmwyb/lTWHtzR2qm0sAB4TY1qBvyT/FNxqIytH0Gz05diqsDiqNPpH1q
	6kuV8DdCTJZ6Eh0gawjcnFehLNGtLRC13YSToRzXrN6ZXae2eKEnWDE0v1z6H3Da7AQLeA/4C19
	mWmHT07/mVuvXxYugkU49iSJy6k3MX7ddUF/EXykJixsgwNlSatSZqd2MxbneznC2xKNUKaTw75
	UZi7imFEqG3OgVB31TaW+JXs6XXijdG2nGNgc1pxdE8YlVBS1C7mGdaO9ZKzwoJDlvP/6aRV57N
	sDCrbOodl9D+UtgAXokFsZYkyToBGVazhHUhO2AYA+xPlvRbF31JPZ0vvXNdt4iHSGMkUy9r3bc
	WV1AYoGi06sGRzhar347d8+u/VGJSMGLc6gJtIxUtRg+ZMiPH
X-Google-Smtp-Source: AGHT+IFbFtY6P6MLHr6AhqQIs9qRghu4g1lEqPTOpJqtgwSKotPoJnpXi9md1fO+Rhd39mfDohF1Xw==
X-Received: by 2002:a17:903:234f:b0:276:76e1:2e87 with SMTP id d9443c01a7336-27ed4a4979amr154539365ad.44.1759133478813;
        Mon, 29 Sep 2025 01:11:18 -0700 (PDT)
Received: from localhost.localdomain ([111.92.125.119])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed68821f8sm120319765ad.73.2025.09.29.01.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 01:11:18 -0700 (PDT)
From: Abinash Singh <abinashsinghlalotra@gmail.com>
To: kent.overstreet@linux.dev
Cc: linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Abinash Singh <abinashsinghlalotra@gmail.com>,
	syzbot+7fb23a5461e8c9d38a3e@syzkaller.appspotmail.com
Subject: [PATCH RFC] bcachefs: Fix KMSAN uninit-value in __bch2_read_endio
Date: Mon, 29 Sep 2025 13:41:10 +0530
Message-ID: <20250929081110.11618-1-abinashsinghlalotra@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KMSAN reported a use of uninitialized memory in __bch2_read_endio():

  BUG: KMSAN: uninit-value in __bch2_read_endio+0xb2a/0x2240
  fs/bcachefs/io_read.c:832
  ...
  Uninit was stored to memory at:
  poly1305_core_emit+0x46a/0x480 lib/crypto/poly1305-donna64.c:183
  ...
  __bch2_checksum_bio+0x1048/0x1130 fs/bcachefs/checksum.c:237

The local `digest` buffer in __bch2_checksum_bio() was left
uninitialized before being passed into Poly1305 routines, which
caused KMSAN to flag it as an uninitialized read.

Fix this by explicitly zero-initializing `digest`.

Reported-by: syzbot+7fb23a5461e8c9d38a3e@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=7fb23a5461e8c9d38a3e
Fixes: 1c6fdbd8f246 ("bcachefs: Initial commit")
Signed-off-by: Abinash Singh <abinashsinghlalotra@gmail.com>
---
 fs/bcachefs/checksum.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/bcachefs/checksum.c b/fs/bcachefs/checksum.c
index a6795e73f0b9..433ded62c77a 100644
--- a/fs/bcachefs/checksum.c
+++ b/fs/bcachefs/checksum.c
@@ -216,7 +216,7 @@ static struct bch_csum __bch2_checksum_bio(struct bch_fs *c, unsigned type,
 	case BCH_CSUM_chacha20_poly1305_80:
 	case BCH_CSUM_chacha20_poly1305_128: {
 		struct poly1305_desc_ctx dctx;
-		u8 digest[POLY1305_DIGEST_SIZE];
+		u8 digest[POLY1305_DIGEST_SIZE] = { 0 };
 		struct bch_csum ret = { 0 };
 
 		bch2_poly1305_init(&dctx, c, nonce);
-- 
2.43.0


