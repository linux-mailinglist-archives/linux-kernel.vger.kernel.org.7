Return-Path: <linux-kernel+bounces-776927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65757B2D31B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 06:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B69E91C43B42
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 04:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69BCC27A456;
	Wed, 20 Aug 2025 04:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KqCJgA3H"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAB0276038;
	Wed, 20 Aug 2025 04:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755664485; cv=none; b=h6DuS34LurKtv/DWCB3cnRVnavzAcRv7elYgwo58XwNJNkG8zDgemhd+UcsvOx5no5R9HP341Tzl63NYpfa31dB8zKtd+Uy1bt3DW+m30eNMrssN7Xf6jFw7qUiIVl9ehzPMq0CusYIDjGLYSmqXjJiCkLVAur1lKggFRtsU2oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755664485; c=relaxed/simple;
	bh=ibncyX6wSsvhMtT2VwbkV775dioY/Q+yZ3LZy0Dg3GY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t413oYqvMO0H4qKqqau1+tDYcWhhk4zJGd/azh4iSl/JRFvSaQrDEr4ZxBATlgI/Egml5qD/nAPBX3AMMFPEffKZL4LXa+2yQLDfgtm5t12rcjarZkFZ7QngnU5ZEv7v7uvPMyyWCR8pbcauoFtIOt9KlBqm9JPlXnTa0b1FhHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KqCJgA3H; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-24458298aedso51695635ad.3;
        Tue, 19 Aug 2025 21:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755664484; x=1756269284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yrt9mzNv9i8GrCA0dPeMmmg1/H4rSndrElHUIj4D/t4=;
        b=KqCJgA3H5ko9dndGqdMLtaZHPAJ7pdzkHeY3kQS1XraneY24aArWOui63AEKUmFx+H
         wXUNEopOE06k3Qy7Dn/RTk5TxRhMGLUqVHyCuzQdNK3UPij3ABhb0awK1PSx85vmIqlD
         DSKcp+Esn5+m3BZvFZ6QBWl4cfMzVs62UlsGypt3VEwaJ6FI9xDbtPFnnM+d3LMQ/+x+
         Ldg19WiBc5jEz6W3EfoIyy6KqaPMhbFFCCOQHFqAb6dkeWOs37xk4ICSgS0pPo9xFcj3
         0RhITNFjjMlEDUv3H/SOVW1J7koHxvGiVnkmeaSVDVDRL6EeMZAXLc2+pUvrRN0eA7Z8
         Em8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755664484; x=1756269284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yrt9mzNv9i8GrCA0dPeMmmg1/H4rSndrElHUIj4D/t4=;
        b=Umoa2ZYgV7J2QO+VhgaM1iiba2LUqr+mVQvM/kTijEyhqQLa9Ye3KA4o74VkMaL5Cz
         z/qn1ScDodLqgbe7z9pZj7MczGK8SNZWZ3dkQSgW4/YySjCRXg06Kl15a3nbNbA2u0vr
         aNmDa/U15fxSLk807iPNrA60v2ipBpm+S4Beo0CrNJA2edUbayakZ7IdLf1GSsQJYJXj
         zTZ4+utC/CF4hhst2tDTsU/bLereA2DnBQ/U2JvuSkYD80LRpwNKilXs69iA2mMffnlk
         vajww15+ta0W1B7o79Qvpu0oHiG0xJrJTGXiTJpl7FUyiXUE9EQXSOYbjlJfRNdpfZVK
         w1mA==
X-Forwarded-Encrypted: i=1; AJvYcCUOQMlKkwiDq1WVkjHb0jrNtprfoCuOIAcGJCe0JGhbsaeX4BNBOkTqTsOETur3PPG0uRY/1kfA6jM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywuh5K2iMcqM9Mgz4WouaOl9dkEnWnv+bCNQ4kYJz7xwoKUXAYV
	7j4LNReIn6DQNwRoXGPdPkH3cP0LUcJDotERy5GR30PYKIhdrF5MGplI
X-Gm-Gg: ASbGncs4xPaq0p22Ys4DPXN7hDvp0BOpDiOBgWM6uPD8TALjRhwYk+SMdja4TgPgv8c
	bvRr+2GtY+lNrFWZUVVDIwv1fTjoUGlXmyVsOuvqQ0mr+NQkW82TkxsSX2EzU2xGuUOuFBPcbaN
	/hhhI/hPXP0ZWxewMZ9SZAbN/EyWJj32Jb4KCuGJDVTMI7AvJecK1bgtHjTjPDvL7cunoIZYSRe
	tmUS7H6oWZgExHiAkTwpRS60bH5wuo2b/fc/47F9srRDQAJG7h6qzsqLcNqbJcC+6bNKc+5azM4
	yww7GygjLjmUUNIkUV8yRRPDHsGPNaH8tX5iFb+k5VpHi6rwG095yRjsrYwqH08VwDgZxr3BNpu
	yqeuzT5e6o9rG0PEqeGemqA==
X-Google-Smtp-Source: AGHT+IHmG2KaV5A2aZ+HZ0hd/iIQlBfy8Y7PhJWbQKKu/KBlbqqPeeGfMzIvzJzs95XaL9C1UF7FwA==
X-Received: by 2002:a17:902:e888:b0:240:48f4:40f7 with SMTP id d9443c01a7336-245ef25c5d0mr21276695ad.39.1755664483587;
        Tue, 19 Aug 2025 21:34:43 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed35d511sm13326175ad.50.2025.08.19.21.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 21:34:42 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id C031F401648F; Wed, 20 Aug 2025 11:34:35 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux F2FS <linux-f2fs-devel@lists.sourceforge.net>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Daeho Jeong <daehojeong@google.com>,
	Yuanye Ma <yuanye.ma20@gmail.com>,
	Yangtao Li <frank.li@vivo.com>
Subject: [PATCH 5/6] Documentation: f2fs: Indent compression_mode option list
Date: Wed, 20 Aug 2025 11:34:31 +0700
Message-ID: <20250820043432.22509-6-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820043432.22509-1-bagasdotme@gmail.com>
References: <20250820043432.22509-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1604; i=bagasdotme@gmail.com; h=from:subject; bh=ibncyX6wSsvhMtT2VwbkV775dioY/Q+yZ3LZy0Dg3GY=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBlL/bcVvJ8Sftu1OEZAMV79w8GUjQ/V/ff2bdFmzHgQf /hbe+KFjlIWBjEuBlkxRZZJiXxNp3cZiVxoX+sIM4eVCWQIAxenAExEh5nhf35QhtqrOO49DkWM c2U2uYjePVz5o2fFluL19jGLj528KMbwvzJnWuLKsDv8Mm4crYF3b3t+ci1V/xXZk7GcvdKW07O eFQA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Indent description text so that compression_mode numbered list gets
rendered as such in htmldocs output.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/filesystems/f2fs.rst | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
index 0f9472ae62f2cb..146511d63b684e 100644
--- a/Documentation/filesystems/f2fs.rst
+++ b/Documentation/filesystems/f2fs.rst
@@ -922,14 +922,16 @@ compression enabled files (refer to "Compression implementation" section for how
 enable compression on a regular inode).
 
 1) compress_mode=fs
-This is the default option. f2fs does automatic compression in the writeback of the
-compression enabled files.
+
+   This is the default option. f2fs does automatic compression in the writeback of the
+   compression enabled files.
 
 2) compress_mode=user
-This disables the automatic compression and gives the user discretion of choosing the
-target file and the timing. The user can do manual compression/decompression on the
-compression enabled files using F2FS_IOC_DECOMPRESS_FILE and F2FS_IOC_COMPRESS_FILE
-ioctls like the below.
+
+   This disables the automatic compression and gives the user discretion of choosing the
+   target file and the timing. The user can do manual compression/decompression on the
+   compression enabled files using F2FS_IOC_DECOMPRESS_FILE and F2FS_IOC_COMPRESS_FILE
+   ioctls like the below.
 
 To decompress a file::
 
-- 
An old man doll... just what I always wanted! - Clara


