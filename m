Return-Path: <linux-kernel+bounces-785859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 122CDB351E0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 04:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB31F1B61D17
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 02:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF98279335;
	Tue, 26 Aug 2025 02:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1p1qoY4"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8902765D6;
	Tue, 26 Aug 2025 02:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756176483; cv=none; b=mfkcZP4iu/LXlvqtGYvkoZPq9MPygzbsmbCurAhlCrjst2h26Mxp6nEUjGdfsZDoWqjrHjWzvBVaSSkmqhiYu3L58x0rZAiPULxGt65AOANAonGcB3Rf5iSBaoYGdoOh7rI4TYgxxmUC8uYItZQHqeEs8XPhIJkR8SLmn2CQFfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756176483; c=relaxed/simple;
	bh=5O0xZfxdFwvw+gaf0aLZa6bI261Y3F9Srs9/2suiejg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UuBIT72c8e/m704b6gHnXBtiE3Iiavt4d02HoqwDYbtSVrgZfgcOHJUbwWxN7T0GxNE+beJ2tUJzBLd4VyxaRYs307MQbskvkFLe11GgeyRN4YcJQMuCtLkChGYwBYZQB3Bh45MxT/0ZJ7FJ1eQTrgSTftR3nDZtLclJYoXl+4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z1p1qoY4; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-246aef91e57so27151685ad.1;
        Mon, 25 Aug 2025 19:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756176481; x=1756781281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=th8vCaaeH9XGMni4YOrjZYqsp+amesPtImMzW7HsMDA=;
        b=Z1p1qoY4Plx4xjh02IPqKTxuOxxpy/U3yOHWR9xspfXPYJ2lBMMhT9BuexzGJ7ytP/
         lXtrOr3KZsMDMhTm4Bff+iljQ4WmrONX7AXf8vriWMNHippRUcUcQUaEldMSCvZikQ3l
         STshdMX25NO3aw25ofuB4onVkkF9S188/sRCg3Qq2LViE9D536PgzJKUchUWe1o7umMZ
         AgIxg14qC64ysFeHP1RGVML+gTGlTtDM67Kg3hKG4GlCW8XZxaGfZJpyW9vDAPaWcFiR
         Vf4MINvEW+wPFCuY1+PG8LUyZ+WN0nYF2+eAsnsXGxbCXDmUz++Q0ghCNwP79li76Cl9
         zDGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756176481; x=1756781281;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=th8vCaaeH9XGMni4YOrjZYqsp+amesPtImMzW7HsMDA=;
        b=MUDZdCTdeT1JHkXN3yMj8yGr39MFKe0uF/6Lkxpui6Jopa+o1lMJz2PCT56hmS4xh2
         v6j8cF78EVGZ0rkRZGDjZtoqQHU9WOCMBmlHN5R0KxLmxZnXzxgUkKFaTvaFChDSdHU8
         iApdox5ieR7BvZsqdIavv7cLRa6sK05Cdimx6IoEfdoZjnCn+Z9nqz8Zx6a8qMbxkTCD
         e5MnfMzdGPY7deIH/mCu/8/iaBtaIlmiLG3XruGHVPxIIsp9aIrPugV82IvhZUrKNFWX
         pzf1J/X1QBeeAF5nuu1P3X8d+3YEDINXohBRuiZdaOVtd7uCxytIcXxY0HBL6NDorA2y
         +pqw==
X-Forwarded-Encrypted: i=1; AJvYcCWvEho/EztJZlX3CgXKZJLHLdvLNlAtRXnHSxF+jS9NuagF2t45/7Lui7VgrwioXRYoFFqojd7VizY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/ldyuqNICBalPXWYY/f0og7OoF9hktIWVMCADhIxQquT7SDKX
	lXNGoJm7WQDJ+by4T0Qu6lgxQfJx0t5hhI7l2d1ekauaIuGam7eIKUVz
X-Gm-Gg: ASbGncvGhwTgTU9W1NA0vBz3FywU63hlei+PKlhzs30wUqgb+fAcGdjMeTSEqKeg9t8
	O5B16XsXy2UehroyFE/t8Di0v0jB8jeqGyE6kgvZbR/p514NwBNXd4bfS/1uqZJGfZ+TRFGxwr4
	PrqYh36wrROkwvYcJLx2jqMjD+2kbLSZ1fyJyOgS9+gyZfeEboK1yeDZV+gbrUAoan1KwDxLrA+
	9qdUYP/amW3MtjZSaplPmLL7wEoJMlwefHWl4h37mm1acs0kjQj40hKCGWHIUacXE21yo36sZZW
	dJN1FLDS33mhBQiS7UX22U6kq7ttW+mEGYBD1QegUaq5e2kbP+QSjOx0l0nTykaOGCZa+vSwkR1
	d001zfAwHMvrTbJ7frbyv09PQ4+32BCbu
X-Google-Smtp-Source: AGHT+IEx6KgtBSE8/foDuVT3dHGN20n3pJZnNDWiKKGoWzzcY3jyypCclHOCVCFqH6uNDW+YFz2fNw==
X-Received: by 2002:a17:902:f68d:b0:246:c077:980f with SMTP id d9443c01a7336-246c077a4cbmr85993235ad.39.1756176480906;
        Mon, 25 Aug 2025 19:48:00 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3254a1e5888sm8574343a91.12.2025.08.25.19.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 19:48:00 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 75619424E25B; Tue, 26 Aug 2025 09:47:58 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux ocfs2 <ocfs2-devel@lists.linux.dev>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH] Documentation: ocfs2: Properly reindent filecheck operations list
Date: Tue, 26 Aug 2025 09:47:56 +0700
Message-ID: <20250826024756.16073-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2543; i=bagasdotme@gmail.com; h=from:subject; bh=5O0xZfxdFwvw+gaf0aLZa6bI261Y3F9Srs9/2suiejg=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBlrpS9/9Ik4/HXKJY3yKf5+Et+X8N8QOSYrs+yHmMKUy iVvfV4t7ChlYRDjYpAVU2SZlMjXdHqXkciF9rWOMHNYmUCGMHBxCsBEHJsZGQ50nH2yjHliy/nE OMYVz+ZvPnfjqd0hyfblvU/f6X/b/52V4b/nmy3T3yvvKbBTfRbQ3RfkfydYJWDOFME/8UF5DG6 nWVkB
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Some of texts in filecheck operations list are indented out of the list.
In particular, the third operation is shown not as the third list
item but rather as a separate paragraph.

Reindent the list so that gets properly rendered as such.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 .../filesystems/ocfs2-online-filecheck.rst    | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/filesystems/ocfs2-online-filecheck.rst b/Documentation/filesystems/ocfs2-online-filecheck.rst
index 2257bb53edc1b1..9e8449416e0bee 100644
--- a/Documentation/filesystems/ocfs2-online-filecheck.rst
+++ b/Documentation/filesystems/ocfs2-online-filecheck.rst
@@ -58,33 +58,33 @@ inode, fixing inode and setting the size of result record history.
     # echo "<inode>" > /sys/fs/ocfs2/<devname>/filecheck/check
     # cat /sys/fs/ocfs2/<devname>/filecheck/check
 
-The output is like this::
+   The output is like this::
 
     INO		DONE	ERROR
     39502		1	GENERATION
 
-    <INO> lists the inode numbers.
-    <DONE> indicates whether the operation has been finished.
-    <ERROR> says what kind of errors was found. For the detailed error numbers,
-    please refer to the file linux/fs/ocfs2/filecheck.h.
+   <INO> lists the inode numbers.
+   <DONE> indicates whether the operation has been finished.
+   <ERROR> says what kind of errors was found. For the detailed error numbers,
+   please refer to the file linux/fs/ocfs2/filecheck.h.
 
 2. If you determine to fix this inode, do::
 
     # echo "<inode>" > /sys/fs/ocfs2/<devname>/filecheck/fix
     # cat /sys/fs/ocfs2/<devname>/filecheck/fix
 
-The output is like this:::
+   The output is like this::
 
     INO		DONE	ERROR
     39502		1	SUCCESS
 
-This time, the <ERROR> column indicates whether this fix is successful or not.
+   This time, the <ERROR> column indicates whether this fix is successful or not.
 
 3. The record cache is used to store the history of check/fix results. It's
-default size is 10, and can be adjust between the range of 10 ~ 100. You can
-adjust the size like this::
+   default size is 10, and can be adjust between the range of 10 ~ 100. You can
+   adjust the size like this::
 
-  # echo "<size>" > /sys/fs/ocfs2/<devname>/filecheck/set
+    # echo "<size>" > /sys/fs/ocfs2/<devname>/filecheck/set
 
 Fixing stuff
 ============

base-commit: ee9a6691935490dc39605882b41b9452844d5e4e
-- 
An old man doll... just what I always wanted! - Clara


