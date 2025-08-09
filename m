Return-Path: <linux-kernel+bounces-760909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED288B1F1E3
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 03:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 939A67AD2DB
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 01:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D9E277030;
	Sat,  9 Aug 2025 01:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="NcABfOKo"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E582221540
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 01:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754704570; cv=none; b=cqMKL95NkGslSqxUo2LPlWAzWr64LOfkdmHv51BZKHhFOdozQYjL4KVuhJ8GmmTQPoC7T3Hu7RlWfc+ltKtmgH3qWlDVNIDR09369wJQXYTPr1BsMiG2TBSZs+XQmtRxtrWoyWPloYbN8GIu6olIwjGo62zsU353q2cNgH4E8dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754704570; c=relaxed/simple;
	bh=MYKaqM8CAHkyIRmw3YojkfdyJu+8WrIZ/Vqc5NhiXkk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GZgp3I/XD/bw4X/l1XznbLcrVc1pjBx+Bsb6zVGJXtwQOJWp336ipcYKj9K7EbGPLRcqUjQ2+V0MH6qnbESZOtiBLV7UFPfn3t23gJVdqtAaBx5hz74Ef3XuhEPhWaB9Rm61By80RMDmZwgdTK7BEW1a0FdprHkSs/xYZMkKpSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b=NcABfOKo; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b271f3ae786so2271880a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 18:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1754704566; x=1755309366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T0gEu9M1jWiqQ/ChUNqQXxDev3uWQxp3w+IDbpV+h3k=;
        b=NcABfOKosfvTWZ6zrHfyp0u0iXkhQ393pcCM506MM+ZtF0s32A6RVj3JYTYRKb5Te0
         7JxvBkNKx0fCjnqDdeEmtRzu77+79USCB7v5NaFeK5qMXBckZDdFSRuWoZThye4//fzs
         t5RPJvjn8+xx6H0S8J8YnBy72xHQkfC1yXr0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754704566; x=1755309366;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T0gEu9M1jWiqQ/ChUNqQXxDev3uWQxp3w+IDbpV+h3k=;
        b=ndpnMAZQWx3yGK6nFcf1VbfNKhvR/0vpG6JNgFeayZHIGDIldRZNL0GbwcXKqIumde
         qf53ZRUQ8RNomW483lR5ClsnTdR+zbklED7PwFV6+Dm9EkU7DzfPl8E614MClMUsVNuz
         CzvjUQ9upEpsWv/rRAmTuI4sfco+UmNX/7ghcncCZ2Np0j99W0eVKFKcyY2yoeTFbp0c
         iPSW/3pWEMLPLQ8DR69KxdutwPeDAYkITxE6DEIRK5WgwMExHxwlF5zOZ1711pKeME3U
         NAmRzgCwWGywiUiVsrJbcJLrPPOpUTIgHTtCjktXqGj1MTfQ2K8hco0byTGOvzCobc5T
         4BoQ==
X-Gm-Message-State: AOJu0YwCHORkPOtsaP6rCfrHjNAZWtWcrE9fSYCfHOjavWxsPAmMD25o
	266OD6h+OufyYpVGmmCuf+tK67G5rD3pHCWt5IQq9XwceekX2cUweCLfxYeHVVGO9al4YY7wZOb
	WgFEZGw8=
X-Gm-Gg: ASbGncul48r2Z4igxPvFIoub+LdoYFDa6iJxdubmaEDNNb53Kp2WRXq20Gb39LatkeH
	DzKQ34dgRMkAbqEp9Dq/bCkaGqyiwLoLMv9WO8bkh3XxxXdlhLfD2n5O3bpfKmY7P7PZuS/lams
	3SMm5VTM+rg8tkHXIeQW+xR+XssNAz+ui6RI1EQBm+ZqMRslJVw6AYZvXVLrroe+JDlnXgqb3eF
	EmoIH4JR3ssLXEemrluyJKk6QO/S3MVyOhHElfpqMdM8IRE60VKhBh6oNbN71MvyWTw8Hm3YYY0
	58k0ONEex3joGxlyIJidiHVe8ioC457pnYgHzpNwA+ZgEN0UcKhgWnIOB5408wITXwDHcm1Vjr4
	BJ1Ibvjq4LDdIVHw2B12AayqRmQIHOh+p/cBxMSdGbl/Qs04Hw9k94E/tpGc0yTPgWu14gFvx9Q
	==
X-Google-Smtp-Source: AGHT+IERjA7mv9VWNW+RynYLJcRsU6bRSQXETe7C9BCz+ad/Id+lhGtD2CjniX3rZywKY+yyxNgFow==
X-Received: by 2002:a17:903:4b43:b0:242:9bc6:6bc0 with SMTP id d9443c01a7336-242c2266792mr66416245ad.55.1754704565794;
        Fri, 08 Aug 2025 18:56:05 -0700 (PDT)
Received: from shiro (p1561006-ipxg00c01sizuokaden.shizuoka.ocn.ne.jp. [153.226.109.6])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-241e89771e2sm220358985ad.88.2025.08.08.18.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 18:56:05 -0700 (PDT)
From: Daniel Palmer <daniel@0x0f.com>
To: geert@linux-m68k.org,
	linux-m68k@lists.linux-m68k.org
Cc: linux-kernel@vger.kernel.org,
	Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH] m68k: Add target for lz4 compressed vmlinux
Date: Sat,  9 Aug 2025 10:55:29 +0900
Message-ID: <20250809015529.373693-1-daniel@0x0f.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Traditionally gzip (/bzip?) has been the compressed image format
but its a pain to decompress because its very hard to load and
decompress it in chunks which you need to do if you don't
have enough memory to load the whole kernel image and decompress
it somewhere else.

With lz4 you can set a block size, read it from the header,
and then you only need memory for a single block and the
decompressed kernel.

I use lz4 compressed images on 68000 with 8MB of ram
and MVME147 with 16MB. I want to use lz4 in my fork of EMILE
to boot m68k macs because streaming decompress of gzip is painful.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 arch/m68k/Makefile | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/m68k/Makefile b/arch/m68k/Makefile
index 0abcf994ce55..a56e853037c0 100644
--- a/arch/m68k/Makefile
+++ b/arch/m68k/Makefile
@@ -124,6 +124,17 @@ else
 	$(KBZIP2) -1c vmlinux >vmlinux.bz2
 endif
 
+vmlinux.lz4: vmlinux
+
+ifndef CONFIG_KGDB
+	cp vmlinux vmlinux.tmp
+	$(STRIP) vmlinux.tmp
+	$(LZ4) -z9f vmlinux.tmp vmlinux.lz4
+	rm vmlinux.tmp
+else
+	$(LZ4) -z9f vmlinux vmlinux.lz4
+endif
+
 CLEAN_FILES += vmlinux.gz vmlinux.bz2
 
 archheaders:
-- 
2.50.0


