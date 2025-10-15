Return-Path: <linux-kernel+bounces-854886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F55BDFADF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 18:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AF813C1EE0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0CA3376A8;
	Wed, 15 Oct 2025 16:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZqwX5w3"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D7C33439F
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 16:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760546118; cv=none; b=Ql2RP40/5DLoUu0A9pPE8hL4lEeHT7Ptm9kgY6mr6oy0tBCMSITbqi2moWhEDk5ST+T1HL/4e/9HPkWiZ6e9qzdIfdo7zLZkHO1JEQv44htlwAGLt1bqSXgtGHjUBpSHWM1rq1DNa0TYtHdM6wch5cjdQYuR5KaI2S502Nu223E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760546118; c=relaxed/simple;
	bh=+F9lX8BxrHM09zh4THFUGQfBA0gUrRnxZiBHFNJDoZs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aVs3yiPFOZaPp85PsDxEQBOnylam4j0d8ejhLcyAVv/5R+ku+VKcs96LmFMVGqpn0gqpoOvjnUQkW1gr3PL8jrU/Ked6OQ5VFZpanfrrgB3r7QXM7wEUVX02C/UiybXFiLJ1K74opszB3lrNKWRdk2N4JjVXCS2KRzaoZMiLSbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZqwX5w3; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b50645ecfbbso1291335466b.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 09:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760546114; x=1761150914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bndtYUqfGIZpaVzkFCgkIe4QUYyWwzarc5JiifW+vfI=;
        b=CZqwX5w3uHcdGp6eJBbp0z+TB7KEAEkH0+W7OO+c7NO0ZjF5/gvUsf+IG5kyL95CzU
         wPeZaIeOc8k/DPXXReThu8sYqWUMQgnw6V9Vbg/IzkkIl1+NjcDNmz+apXDiL+fkSnHX
         0bk97tYHhJqNjS3zzW9eOv00gEc/zqOOOOyE9UqqsP3TlsPk4FXJyH/TqLwIVeYR93KZ
         kTWlGoqInXBUcy/lgvEQDczJPi6JM4PLq6IHVWvIAlfrurKPlpMWr4iQZ/hKy5Osd9SK
         uSuPot/oDTWNfPHlBo007kLFtsRkUSvucC7AAdeaUYbAxStCDNh8vtdSjrNSm5UXe0B2
         b3EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760546114; x=1761150914;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bndtYUqfGIZpaVzkFCgkIe4QUYyWwzarc5JiifW+vfI=;
        b=jA2tTN78q0m9WiCaIg8y6WLjLsjQCYph1dpD9algIlXMajd0YxN+N4uX54HTkZuIeH
         RndO+F2aUeUxzo+2c84wUqlM4+xgSRRCya+3CdaPhfB5eDCAZTgnEeVLdL/iyAoGmzj0
         TXXYOxUr/vgs0ttXHT253LZqEr9R7u3rSgi2HQMioeWAg/yWqdbP+8OEAgua4tiIZDx2
         l5DJuUNcSie9NzNH0KpoQUDuoFTb2sip2i92HnLCTK0BnIoc/MFr2uoXN9mZQbkMLv2z
         FR5dzC2XcH9OrVarI1c45SQRQxS73UnDmhELwQY+1oEJdfSYuQYKVwUxFWcfGYJghdHr
         Vd8A==
X-Forwarded-Encrypted: i=1; AJvYcCU/EWLEkQL1L0txfjARkAxfTni02FhrTEXHm7hB8/S/9Q8bsWytXuLtGWiSZjiQhCDc13FQqKXgJM6sAlM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwatJ6g5SiU7ATNTw8595BFr4BbNxU5ziO5GnU2tBCPJYNAAGf7
	1EYoXRzmb0amvvKzXMgc1SOJEAv47RSKJVZLwvI/FZDI/nYBpRx401Nn
X-Gm-Gg: ASbGncv7bPgR7ZoPLiqlr9t72YGQ6jTIcrvKXVouYG53zzz3cuE4iDOjp5yqER8I2/E
	8w4H1MpRGObmY6MTCTtXYE0clxrb+au00btpbD0aM7ID/PrdvXK6Y51mcYUzJbuWaki5qylqe5x
	IjbyDuinrqo4k9JqOZtqI4/gQ1rPeI+twhL3gVgrBU4BACKskOv+3rIBDHGUtW4MS6pbenDXiId
	SNBTN+gZWkIo8o4vobkBzCZykTgmCwr9uhLmNhFohW3GRxbzzA1A7PwvM/MvxNC0wQHRfNiURSI
	iuYsmxZS95dtCfMP0bIn/K1a4FkHCVfvnNNdiEZCof7mmP85GHs8h7CrttcQaGhTkIheILp53wP
	kF4zrDvGXiC1tJEI7eC8BtFd8Jgt8xHP6Wm1OEq0b8OvWOGGMRR6UqB20kA==
X-Google-Smtp-Source: AGHT+IHLZWkUlyawqyiGfLz/qEWiPSOIz5Y4RNXz5EPwgCvjjbkARO4juP6RcyZkWDgaTU50o9F0PA==
X-Received: by 2002:a17:906:c105:b0:b3e:907c:9e26 with SMTP id a640c23a62f3a-b50ac5cfaf7mr3098522666b.59.1760546113373;
        Wed, 15 Oct 2025 09:35:13 -0700 (PDT)
Received: from build-server.. ([62.96.37.222])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5cba06c187sm263576266b.31.2025.10.15.09.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 09:35:12 -0700 (PDT)
From: mike.malyshev@gmail.com
To: Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mikhail Malyshev <mike.malyshev@gmail.com>
Subject: [PATCH] kbuild: Use objtree for module signing key path
Date: Wed, 15 Oct 2025 16:34:52 +0000
Message-ID: <20251015163452.3754286-1-mike.malyshev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mikhail Malyshev <mike.malyshev@gmail.com>

When building out-of-tree modules with CONFIG_MODULE_SIG_FORCE=y,
module signing fails because the private key path uses $(srctree)
while the public key path uses $(objtree). Since signing keys are
generated in the build directory during kernel compilation, both
paths should use $(objtree) for consistency.

This causes SSL errors like:
  SSL error:02001002:system library:fopen:No such file or directory
  sign-file: /kernel-src/certs/signing_key.pem

The issue occurs because:
- sig-key uses: $(srctree)/certs/signing_key.pem (source tree)
- cmd_sign uses: $(objtree)/certs/signing_key.x509 (build tree)

But both keys are generated in $(objtree) during the build.

This complements commit 25ff08aa43e37 ("kbuild: Fix signing issue for
external modules") which fixed the scripts path and public key path,
but missed the private key path inconsistency.

Fixes out-of-tree module signing for configurations with separate
source and build directories (e.g., O=/kernel-out).

Signed-off-by: Mikhail Malyshev <mike.malyshev@gmail.com>
---
 scripts/Makefile.modinst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.modinst b/scripts/Makefile.modinst
index 1628198f3e830..9ba45e5b32b18 100644
--- a/scripts/Makefile.modinst
+++ b/scripts/Makefile.modinst
@@ -100,7 +100,7 @@ endif
 # Don't stop modules_install even if we can't sign external modules.
 #
 ifeq ($(filter pkcs11:%, $(CONFIG_MODULE_SIG_KEY)),)
-sig-key := $(if $(wildcard $(CONFIG_MODULE_SIG_KEY)),,$(srctree)/)$(CONFIG_MODULE_SIG_KEY)
+sig-key := $(if $(wildcard $(CONFIG_MODULE_SIG_KEY)),,$(objtree)/)$(CONFIG_MODULE_SIG_KEY)
 else
 sig-key := $(CONFIG_MODULE_SIG_KEY)
 endif
-- 
2.43.0


