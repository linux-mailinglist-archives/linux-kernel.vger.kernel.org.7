Return-Path: <linux-kernel+bounces-840172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E805FBB3BC5
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 13:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FD3E192171A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 11:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C5C30FC07;
	Thu,  2 Oct 2025 11:26:34 +0000 (UTC)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009B82F25F8
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 11:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759404393; cv=none; b=XHCVn1TC2h88/Ip5g9u6LGohIL/SQ74Do2S33UDThaXo24GZU+Cn6OPJYsy3oTVWy/KEpsaSnVeja3HTfRk6ANLkQ8OHKTTMQs2N2QxITq9GyqHVUoWFsQxShLpFLH86W9JA1tsIIq/kwrAVFNkN3cXIUUfcLUIIBDmMqhfZ4Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759404393; c=relaxed/simple;
	bh=L2gyy5R2PGRsyNpSJCw6YF43D0THBoN3Fpu7eFNWOsQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=aNdJ2d3Z2IWiamQPE3MS4uFxEkipUx0rDoBQVLIUCPHlsMN0C9S+3yG5ZJjX0veWmoOnvqOF7Z5TJnz1lMx0IJyBPmjy0wnb2DMQ0uFjKj9kUclIx3SjH5A91PaUnRoApwj0CgVxpkzJR0WcPaWBJ18wP1Pe3LVR7waXwdtE3VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-636688550c0so1802434a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 04:26:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759404390; x=1760009190;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b0nIdEO3nCxjYmoEiKbLvMDM6O2oTNOpG3jz3yT7Mfc=;
        b=MVRFiRVTj8GeSX7tLlyEO+VQ2zq/UoseF9fwTf/mVuFjJp91MMmm2vQrXhtxmrNLgK
         ZBTQE6sfbIS6mzkO67R1nDmAtnRCchusMl/mYEoA46QW6bHDJrw2gzLbs6zlaOBBKGtr
         oG3M+yBQA1XU8DHmc3DYi/U/fI3F+A53X3fv+iFXaHilGzhlnZdA5dOhv6aU6+JVRXwk
         xUjVW7jKcdtHEQlZtS1AbaRMmIQOy+/557IIn/qq9OnOWJ2UTSKvCLmGhFTnswY4EMN9
         OdMccs65by+3HjCjvOAjmwaD+GSRalXxRl6l2j1DuOtACnsGm5RFzZNV72R1uzFPWd2L
         LJiA==
X-Forwarded-Encrypted: i=1; AJvYcCULEWRNo+6m/1e7uMCSGsXZkwXfuz96nUX7MgTfIDXHPWHhp6nlmh4FaSHC9RFudX45NKblu/skEXv8Q0M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzeuw4iHSaf9Pumxw6SFgFHoMWHzIRilxaehD+V/nhEKfwf115z
	upAOQkAWZM3Xi/qEOPkn6meLcYYpCFgfoqOA1diljrz9/AkxfsoGmagz
X-Gm-Gg: ASbGncuw5qa3RpIhp+iR2lH1GixhQN9eOoFGV4mPDfwL8Vgv93UbYuht+T/K059hNOQ
	8bx4k/WiLW1C7BpR8y+FQTUqAig45VgxcMtqHONp1HIbXeR90T6xpbxaJTz4KRMJoB8uSubRyJW
	Ap+JYKoYCe8wyjWIldurh+D5ikCkayf0ePHLRcQZlfMP4Tp9o/jVx65rzMDim4grmn+RNl3fr6Y
	5Xj3rAwkQlk+RM5tgzxZrviLUFu8hqUgz1vzMevSuter9jL5bzhY7z2J7kx38ZgHqLQOKZQEd0V
	fUX3jmp4ynzXE1IqlOgw6BgLR/3G254d2QdMwZI9W5XBCRiWZbUy4ZvHsOe59YzHpTzOZ5XQ7Lb
	RiZFdhfyyCKrQzA9osA0+V+wdnMRgHplrPE8F
X-Google-Smtp-Source: AGHT+IG9HhGolfHHMg6Ad2wpoa5xY0rqQothguiF1qQAIawwu0gA0HdvZrHHIiYXFOGXFbUci2Ul9w==
X-Received: by 2002:a05:6402:1ec9:b0:634:5fb4:10e6 with SMTP id 4fb4d7f45d1cf-63678c4d06amr8314834a12.23.1759404390054;
        Thu, 02 Oct 2025 04:26:30 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:8::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6375eb397fbsm1647457a12.0.2025.10.02.04.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 04:26:29 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 02 Oct 2025 04:26:20 -0700
Subject: [PATCH v2] stable: crypto: sha256 - fix crash at kexec
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251002-stable_crash-v2-1-836adf233521@debian.org>
X-B4-Tracking: v=1; b=H4sIAFth3mgC/3XMQQrDIBAAwK/InmNxTSXUU/8RQtFkjQtFiwZpC
 fl7ae69zmF2qFSYKlixQ6HGlXMCK3QnYI4urSR5AStAK21QKZR1c/5Jj7m4GmXQaNC7oK69h07
 Aq1Dg99mNUycgct1y+Zx7w5/+iRpKlL0acFZ+GW6G7gt5dumSywrTcRxfUTnH3KkAAAA=
X-Change-ID: 20251001-stable_crash-f2151baf043b
To: gregkh@linuxfoundation.org, sashal@kernel.org
Cc: stable@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, Ard Biesheuvel <ardb@kernel.org>, 
 linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>, 
 Michael van der Westhuizen <rmikey@meta.com>, 
 Tobias Fleig <tfleig@meta.com>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=2616; i=leitao@debian.org;
 h=from:subject:message-id; bh=L2gyy5R2PGRsyNpSJCw6YF43D0THBoN3Fpu7eFNWOsQ=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBo3mFk4r6DYmopianNWZQlWi3FjU3x2aPyn4g6Z
 GPHyjdKO4mJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaN5hZAAKCRA1o5Of/Hh3
 ba7wD/0bKMhDOdDE3/MMo0aZ/Scql4DlORNBiC9qjeNJFyFeSO6OBfIUAzIoUbtrm0f03PdRJdn
 bv36lxyUK0N12VhVzFx1xXwaUjgY10Wz4nlMwNFF6is8p0nvKpZ7S79Tzmms9SizXhhyVSu4uwi
 s+HOPjFgXlotiUhiuFF9MrU8dnLlwOBAvrDcWjgS0qod9A7iFBgfkywjEpYU3pFSvd7kuEhW3TI
 4Dlq+eyXukilJj7KDqzBG0x/5dwlAPzQMDaEq2Ovm2D2cQMDDlKry05sq6hWDC6rinUK2ckzgTT
 4u3BA9KQsVh+sKmXSaxJEcsi0vQB58b1xtx1nxgA5wp0tEx2emQQskXF5OpmkrJSmN0kQYyYteh
 FLxsAyuLaii0vMg1wka4Ij4jzSAGIgiTlr4GmB4F00DKMFNXwmjF80atG9vCzZTp20iyWGuNn96
 7zqm/wQMDPh2yVDC+qLAmQNPDRMjV3pcGYF7g7uQk/CqOX7b7vA+u+MvJT8FCR2PnkEtZCJPXDx
 gzSLxhlFIWdwFw0ispSGOaxTYbHnM/IAlO3a6t71OVYpwjGW4mrb0UzgkcN3KtnK31KlJOTKxl3
 D+Qdq1BY3M/N4DTCY+EzcEwmS1e+BVT0ryCQ09HINk0zxDjHoH10Zn0LQzsD8ATubhmGcX3Sbvg
 dTf48fpB3rSL5Ag==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Loading a large (~2.1G) files with kexec crashes the host with when
running:

  # kexec --load kernel --initrd initrd_with_2G_or_more

  UBSAN: signed-integer-overflow in ./include/crypto/sha256_base.h:64:19
  34152083 * 64 cannot be represented in type 'int'
  ...
  BUG: unable to handle page fault for address: ff9fffff83b624c0
  sha256_update (lib/crypto/sha256.c:137)
  crypto_sha256_update (crypto/sha256_generic.c:40)
  kexec_calculate_store_digests (kernel/kexec_file.c:769)
  __se_sys_kexec_file_load (kernel/kexec_file.c:397 kernel/kexec_file.c:332)
  ...

(Line numbers based on commit da274362a7bd9 ("Linux 6.12.49")

This started happening after commit f4da7afe07523f
("kexec_file: increase maximum file size to 4G") that landed in v6.0,
which increased the file size for kexec.

This is not happening upstream (v6.16+), given that `block` type was
upgraded from "int" to "size_t" in commit 74a43a2cf5e8 ("crypto:
lib/sha256 - Move partial block handling out")

Upgrade the block type similar to the commit above, avoiding hitting the
overflow.

This patch is only suitable for the stable tree, and before 6.16, which
got commit 74a43a2cf5e8 ("crypto: lib/sha256 - Move partial block
handling out"). This is not required before f4da7afe07523f ("kexec_file:
increase maximum file size to 4G"). In other words, this fix is required
between versions v6.0 and v6.16.

Signed-off-by: Breno Leitao <leitao@debian.org>
Fixes: f4da7afe07523f ("kexec_file: increase maximum file size to 4G") # Before v6.16
Reported-by: Michael van der Westhuizen <rmikey@meta.com>
Reported-by: Tobias Fleig <tfleig@meta.com>
---
Changes in v2:
- s/size_t/unsigned int/ as suggested by Eric
- Tag the commit that introduce the problem as Fixes, making backport easier.
- Link to v1: https://lore.kernel.org/r/20251001-stable_crash-v1-1-3071c0bd795e@debian.org
---
 include/crypto/sha256_base.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/crypto/sha256_base.h b/include/crypto/sha256_base.h
index e0418818d63c8..e3e610cfe8d30 100644
--- a/include/crypto/sha256_base.h
+++ b/include/crypto/sha256_base.h
@@ -44,7 +44,7 @@ static inline int lib_sha256_base_do_update(struct sha256_state *sctx,
 	sctx->count += len;
 
 	if (unlikely((partial + len) >= SHA256_BLOCK_SIZE)) {
-		int blocks;
+		unsigned int blocks;
 
 		if (partial) {
 			int p = SHA256_BLOCK_SIZE - partial;

---
base-commit: da274362a7bd9ab3a6e46d15945029145ebce672
change-id: 20251001-stable_crash-f2151baf043b

Best regards,
--  
Breno Leitao <leitao@debian.org>


