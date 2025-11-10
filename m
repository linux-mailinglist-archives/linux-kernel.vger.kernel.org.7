Return-Path: <linux-kernel+bounces-893404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A5122C4748C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F09F24ED06E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA039314A97;
	Mon, 10 Nov 2025 14:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AfoQaK8+"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB970313E15
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 14:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762785793; cv=none; b=dLP51VpymKQSA4vN5eJr0QEDKA4eLxHE1jdUnBqiDkH1KXW8bSlNW2fq++OvVo8BTd8GDCoeO0fWMhf43Jz/Ivf12TBa8pl/wnRvEdzP5FICFZkn8fyCC4meT+8TQxv5POP1DBeAgaIjZvVhGflCckaqpS+hAzaOjNkpyhJnRY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762785793; c=relaxed/simple;
	bh=/E3gJIQjBTJ6pBJSXNOjyTL+w6L6Y1/FtKLBYQhekO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZdrEwzNOtrko2dNeRQL1Y7qhBMzXI4KicAj+SHfW6oiA2nTEqxOBM6wZMmu4jw6yfVbxHziVzYawHHNYdHSvYJqOQc/BUPD8BNGm59ozbVs0EUQA7RdhOKoGM7b5yym3R3z0DlC82n9bsckfTp68YUgsj6JLaqMJgi+2u+dZGtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AfoQaK8+; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-340c2dfc1daso492482a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 06:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762785791; x=1763390591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F9990Zs5Z5XVH5d3pKn1lkTCNXa3vBYG5og1GHLxwso=;
        b=AfoQaK8+zes7Nzru3pGNenzbk5dmTfEp4axm1tczXdaPnG3Hvm0fFhv2+2uoiw1VBD
         XQyIrkaUpF3JZ/gV+KmHE/bxTutXWqCrOft/Z4d24HGMZBT605vg05ThumZuuTrQ4LZ4
         F709XjvlJvBPZqliGDrfhABchTXB52l6WAJZY0HArY0DbMOTvLL9JjCS2F+n+MA15KcK
         JHRZqu2FwjLGzAe8ErtK1/p/hIsaj0rwL7FZdI/5uaGMOwBJeN13kTp+LStOvmtfqY8b
         bMyWZlZvUrz2DQzjQ73TwkMjKzda4EK4PMoWsRfkWl1Jx0zBjFYhIEV6nDe3CdK1BFtY
         0yhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762785791; x=1763390591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F9990Zs5Z5XVH5d3pKn1lkTCNXa3vBYG5og1GHLxwso=;
        b=j6BueyTtMP+10o364aFjqQ42yUYQpUttUfISdq1M1M99imeqIretf2/N/mcK1IQh5K
         TaUVkE1zI0tz9nJj4Kq8/w5ac7i+SFQjk8tYeeyzf2AgIOpsnNC8kUL0l4+Q2bKvTNjL
         Q2/ASEpRv2rQehnNzBEKo5sVVmNZhRt5x1mk1ecEDcwitIqJ2e57GpWthq6OQAP/hIfr
         iG8GLsyGCwPr+uKCW92/4Ef1KQuDmPB17QIymFUyu6JPpSvLsHOFCTyD+YQMHPHKJTXI
         z8aeQ83wJ/2nZbUGSquZJ/nNGa/N6yDtNXMNepsq1gInHAfwPfLO70ItSoNKrnDera7T
         O4Jw==
X-Forwarded-Encrypted: i=1; AJvYcCU0td51Z+8Ok6SCNSSKQHh37oApPVefDdeeVtedO3I+2dIOb+tCCLQozrzJywG9ZhYl1FwYTIC+KTRNlOI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3PDdVryvzO1GAE9Nt97SK6onNHpUZnZSM8FNw5tCZ6OeOPQwo
	Vciw0R5ptHvOjZ9y5xoifbuq3+jJuO0qLdTjBvxQllAbdUWOwgtZrOuU
X-Gm-Gg: ASbGncstB/Z2Bk5P/tkqLxtLO5gWNWwgSCM5HMVy6g+L3LyoUFs4zQT80GFv2FgnT2b
	94Rxqk0dC0Gh4c2wMekYUCxDoaPgPJrKUWfluOo5Y/712SfDJyDIYaiVyGpzEsM0LRm2hE73ozk
	HyHjviohk2IWEOkcTwj6BM8bSWyYfqbNtGBbr2ngD7xv1TdUGTqhPML16TOsPrWVXbdm9kwI/IJ
	aTFCHo9MUhHXP8szMietcNfimBsE+NI96f5YpENhwOju1WdjKLzLZyK+3FSRakwL6jDPLVyRg95
	pJO1RyQvOsfyiKyaRK6UAQO5DXpacrjcTRkKhL1+Cqn018ho4yYkgeud2Gem0giJ++iJCeSum4K
	PxQU8Krt2FdQL+5Ml4D/Cub6KLpkNTJx1YAJLwMrvzpexWg7Fbf6YIIdoRTzCh3PSjCDi+b5pci
	BGjRFE0H7BQcBxoU8wB6EkekxsEVLmr9DbLNNfB+M=
X-Google-Smtp-Source: AGHT+IHya+A0auZJFr6yNuX36i+1/oEdX5PqTd5tyOpfqW09H+Ff+mZ5vBFnIAIjcQ2qncxi+Eqb0g==
X-Received: by 2002:a17:90b:164a:b0:32e:1213:1ec1 with SMTP id 98e67ed59e1d1-3436cb9c0d9mr6237006a91.3.1762785790881;
        Mon, 10 Nov 2025 06:43:10 -0800 (PST)
Received: from elitemini.flets-east.jp ([2400:4050:d860:9700:75bf:9e2e:8ac9:3001])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343abec3836sm2163308a91.18.2025.11.10.06.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 06:43:10 -0800 (PST)
From: Masaharu Noguchi <nogunix@gmail.com>
To: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Cc: Jesper Juhl <jesperjuhl76@gmail.com>,
	David Laight <david.laight.linux@gmail.com>,
	Alexander Aring <alex.aring@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Masaharu Noguchi <nogunix@gmail.com>
Subject: [PATCH v2 2/2] samples: vfs: avoid libc AT_RENAME_* redefinitions
Date: Mon, 10 Nov 2025 23:42:32 +0900
Message-ID: <20251110144232.3765169-3-nogunix@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251110144232.3765169-1-nogunix@gmail.com>
References: <20251110144232.3765169-1-nogunix@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Users building the sample after including libc headers such as stdio.h
may inherit libc's AT_RENAME_* macros before <linux/fcntl.h> is pulled
in.  When that happens, the sample ends up with conflicting definitions
or the libc values leak into the rest of the build.

Drop any existing AT_RENAME_* macros before including the uapi header so
that the sample always uses the kernel values and does not trip -Werror
redefinition checks.

Signed-off-by: Masaharu Noguchi <nogunix@gmail.com>
---
 samples/vfs/test-statx.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/samples/vfs/test-statx.c b/samples/vfs/test-statx.c
index 49c7a46cee07..0123ab4efe0a 100644
--- a/samples/vfs/test-statx.c
+++ b/samples/vfs/test-statx.c
@@ -20,7 +20,16 @@
 #include <sys/syscall.h>
 #include <sys/types.h>
 #include <linux/stat.h>
+
+/* Undefine AT_RENAME_* macros that may have been set by libc headers
+ * (e.g. stdio.h) to avoid redefinition conflicts with uapi fcntl.h.
+ */
+#undef AT_RENAME_NOREPLACE
+#undef AT_RENAME_EXCHANGE
+#undef AT_RENAME_WHITEOUT
+
 #include <linux/fcntl.h>
+
 #define statx foo
 #define statx_timestamp foo_timestamp
 struct statx;
-- 
2.51.1


