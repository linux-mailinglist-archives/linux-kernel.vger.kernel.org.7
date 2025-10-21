Return-Path: <linux-kernel+bounces-863179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 36AF8BF7300
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 16:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3BD425000AD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20B0340A56;
	Tue, 21 Oct 2025 14:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U3lOkytZ"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A002334028B
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 14:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761058506; cv=none; b=DnPgiBR+nmCTizB4bH+741uU/46N7mERa/FAn9c9c+JbuE2cWcI5iClhRxTxnOZ1+gOElZKGt4c0J7vo4OvcGmEBDPCWZU+KTBBDdUQADobejXrt9fZuOPf6d7PP/5RLQ+UGbwBiQZ+lW5jpTyV6CiobkG6uoZQ5aGE/a/leE04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761058506; c=relaxed/simple;
	bh=DfZMU0R0dRnRuQiWcl7q8VsHGYmCXQ9jXTVQm1yN/2o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FGtGUtEeuNbKN1sjnA9CfoIXwFtjYwx9UvzlLA2Br5sc2U6RAvjrIL8Tt3OfSZ15ZL8QRrrbVEcYExty6+bJmr4gHrr1Gyydrq/izkBr6ctbPG0TBOXcKFaH3XeeGLegm3WUQbcwIRinJkj5qIyUpJ5v1BFOjvKBFn5n/Er1bz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U3lOkytZ; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-781254d146eso630660b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 07:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761058504; x=1761663304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i8VP2I0PGCA2sfJ++TfsZS3uJgWd3RCZmM7e0QrTU2A=;
        b=U3lOkytZnhJ3xunlZBIjvy3C2PSJcTAcZ6oS+atQJgKbX2eTCVitmX6MdpKdCbGatW
         MYa0EHzhU397hRnxYGmo6mkR478J+ald6CE7/bTss8OnzqI/aV3CQ+sK+esjUzZMZrNy
         cqlKDtHAnohEVGD5h+p8aerW2mruuUEjg8t4GlRrH6Wa2Za53Rd5LiJIs5RW/o+GgKlW
         jXOL9JyEUBilSfUxRs/a8PVCOBkHm+uJ4fzJXXwntc3xLhz5NwmzxEC/8So0k4UVtrRM
         OX56UckZtTDrj+Ye8K4XVMtKQtpYpJd9Nk2t2N9f0s7I/qAV+m1iuMqKPdYtPS1HmEIq
         s2Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761058504; x=1761663304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i8VP2I0PGCA2sfJ++TfsZS3uJgWd3RCZmM7e0QrTU2A=;
        b=pMR6YElUKSx8eXYjVkU1ttW+xyS8W66PP5zVNyToz/JM3RKww4UOgFb5KjGdPh49pd
         ZpebbtbNMj5ek8gQvrgLrwyOsUJgAsRovDX/G7RfALgqT1AQ+bBJfKjQTNbVINu/NBXj
         sKJbAc5Q2Dq14BD1k3MNkM+M789+meGnIQSL+pTEwXm3ymo+1CZKTL/z633aBqMic8lS
         nZUY5m/tPw7tREdRVLnX8GBgOy+LYeizBfMKWpXOJ0NlGoB651Dkb2C6JKpxsqpcL8SX
         4voy21hUKyE/W/7IJZnfPpCBZ50QugNJ8z55f/euCEJ7Yke1fCdTqUE2k0QgZ/idHWkS
         U7/w==
X-Forwarded-Encrypted: i=1; AJvYcCU4fgXDMHqou2c9DNLJFjkRAj/FmHcfMnJLUzDTjTb5Fa9F5dM0fd0kNq0kzcWU8j1ZyRy0eUPBAMVKaXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZYbd5fE1xoTWZQWVZG7yfc2yVQH0ztErcV9Q0WyCkqwfupJoo
	rtGej/X3MtAVEbofDF5n882O0L9FKM9K1NhWOeuTaiS+HUeG5ZqZCGZL
X-Gm-Gg: ASbGnctKZsDG91zr/9jKTGLoP6yiCCW7iKFgV7sj1P25HzmUGphmqnEZuscuuUYJQAr
	EgjLTQsuspZmNGwnIETHG9x4YhVV8FWFGAO44ple73vTrGWDgYhzudPUjUG3XAvFClW5UfrAg/H
	I7sOb4e9BfFXdt+7Upr4M31NbDz4jvlz7RL2B2O8A6uzmLeqD2uO6gFMsPW28H8wfl2JTiwemNz
	AB+be8BoWV6IXdfcFmUBJT31u4X1nhiWHmuSGQJxKdLcPG6cz/Hq5/7TRcWTtUVRV8DWDlnVRb1
	GOtSvASZyOZhj5DnuartzKf1fhxmA6AWNpy/TirIn2rry+SBXIah2QNcU1QUtzgdQgGzcRY9VgX
	vKMrSqfQqxLyPwp+2pVtKpVdKH5QhjFHzyvHkFUiJNaftqxtZa6wRu+gnlnOtdDPHhy92sgc09A
	/dbfg3dsIeE25To1NExBl2i7agR2Y8IALx7xCS43+NXMTmIxR8sBoR6LJNq9DgiUvIf37NHSJD
X-Google-Smtp-Source: AGHT+IFGdbtj0ivIPfYSgKjRnJx+JRIuBP/TzlLHzhX/tcb7pAq49jg9nE07bVQ8DwbDuxENZ1F91w==
X-Received: by 2002:a05:6a00:1408:b0:781:229b:cf82 with SMTP id d2e1a72fcca58-7a2572d4b3amr2639509b3a.3.1761058503854;
        Tue, 21 Oct 2025 07:55:03 -0700 (PDT)
Received: from poi.localdomain (KD118158218050.ppp-bb.dion.ne.jp. [118.158.218.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff1581dsm11484614b3a.12.2025.10.21.07.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 07:55:03 -0700 (PDT)
From: Qianchang Zhao <pioooooooooip@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <smfrench@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tom Talpey <tom@talpey.com>,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	Qianchang Zhao <pioooooooooip@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ksmbd: transport_ipc: validate payload size before reading handle
Date: Tue, 21 Oct 2025 23:54:49 +0900
Message-Id: <20251021145449.473932-1-pioooooooooip@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2025102125-petted-gristle-43a0@gregkh>
References: <2025102125-petted-gristle-43a0@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

handle_response() dereferences the payload as a 4-byte handle without
verifying that the declared payload size is at least 4 bytes. A malformed
or truncated message from ksmbd.mountd can lead to a 4-byte read past the
declared payload size. Validate the size before dereferencing.

This is a minimal fix to guard the initial handle read.

Fixes: 0626e6641f6b ("cifsd: add server handler for central processing and tranport layers")
Cc: stable@vger.kernel.org
Reported-by: Qianchang Zhao <pioooooooooip@gmail.com>
Signed-off-by: Qianchang Zhao <pioooooooooip@gmail.com>
---
 fs/smb/server/transport_ipc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/smb/server/transport_ipc.c b/fs/smb/server/transport_ipc.c
index 46f87fd1ce1c..2028de4d3ddf 100644
--- a/fs/smb/server/transport_ipc.c
+++ b/fs/smb/server/transport_ipc.c
@@ -263,6 +263,10 @@ static void ipc_msg_handle_free(int handle)
 
 static int handle_response(int type, void *payload, size_t sz)
 {
+	/* Prevent 4-byte read beyond declared payload size */
+	if (sz < sizeof(unsigned int))
+		return -EINVAL;
+
 	unsigned int handle = *(unsigned int *)payload;
 	struct ipc_msg_table_entry *entry;
 	int ret = 0;
-- 
2.34.1


