Return-Path: <linux-kernel+bounces-742673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE1CB0F537
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 16:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A69C41CC1B5A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 14:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014A32EF2B4;
	Wed, 23 Jul 2025 14:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cAQFRbNK"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072002EF2B2
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 14:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753280710; cv=none; b=m+lRO2oX1Y0uYWT2EQ+1PvLJnifvAFJt9ScSe0IecX2BMMIwV64h3AxfCIkdC+RnFgYIex/AOBf+nf6WYX327mc4BK+5G5c9Q7fTE6QFgiyZPFnVu5GRUDmIN+5+k0xIpY23rmtN7Q7euzmI4FwHIQidNqNpD7IWLzeLe1Ba/Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753280710; c=relaxed/simple;
	bh=qSqowWXZKovsMBtlZ3VYigeEwOKRz0DOrTN6ZbzeSwI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VKlFCs/fOzzzHRC7yy4qyyOlETR/SF0Hm8ZAaraEvMvRc510Bt76LpQMTSo15BgW3oWNwY4310ngPKUdwOxMsfjQa+i0JIYtTmX0s2ArA8n1ujYuFAZxF//X9oJeD9xrVegFZEu+3c4TBBsKRJvJc2Cv+7PViVn2VpMfI9MqZCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cAQFRbNK; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b350704f506so900239a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 07:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753280708; x=1753885508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xrJTE7O1/qPha3zwn2HxeCgRRmWdtz/w14Hn/0lyZSw=;
        b=cAQFRbNK0A1nufxMADYaIjgfEQsvnjU4ySGdoFw0jptiPjFsXD4HO5rzIr2/7RfEZb
         EQ7IWJn+gAfbp1hOh7PpakEtg+d7kZ60jAasnF/O+Cj1NgghZpgt/1P2zuos9MzK5gCo
         DJLkgcSFumbp8PSHDJ7kD9NUUgH1fuwL2tIZ4uyGdtRS3y/Cx8aqfX2LPupXhC2/3kc7
         Dkf6CoJPJC1zl+8Iyq6M8Z7hw9FLLyz3NeSLH8ot1/rx1ACN7czfteSZ4bM98n9OWyhP
         CqrW0P1/1ux/FflzHhynOwqXSmCFXtmynICSN5fYbcWytLkSSnabEyJcYT9H9BB0GPuH
         f/4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753280708; x=1753885508;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xrJTE7O1/qPha3zwn2HxeCgRRmWdtz/w14Hn/0lyZSw=;
        b=ryYcIRAv8pEQBo0HYh6iAxJ072Ow4QP8CWjmcnv/eAAvCSBoFGiZmk8p8UOZuMZjDd
         9LATaBzWSrgCBcOCy7W9A290DGlmql4q4Uhqucag6hkKYCbjMp1mrfaTGMOp1U9W4qEV
         JCswCP2NepWwmInlEV4Lm5Q6/XdpszCeGIsXnbeRyi2VuCHA2wTPu1wcSUqeaYbIYq6X
         1pznLr49tfrrXAH3dMEnUffhEhh/2ppUhCwmQH515K8GIln08IzHFmiErUYt6mfBpacT
         7lchy2Bh5cpau6PoJeKy0rp7/XfAF2BO1QMUvuZRgXnFeaeg3kJxalZ9FODXShzWuavJ
         6Ddw==
X-Forwarded-Encrypted: i=1; AJvYcCXm5UBRmL06yRb9eVbjU6ru4dQnWlWzuY2rIeUYJmTXCdrV4bzR0nBf8F57asoVQZBmunOndoP5J3feY6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL7cUgOqLNM/RoS+9iN/RQ1/vnX2XcLsaVR9rB5H2CqjHYouAg
	qJyl/n5NNGCDyqhhJ2mzYYcWEz3+HSBCebBCqpT5kHrGPEPJNebc7EhUVYpy+A==
X-Gm-Gg: ASbGnctdisywzJkMG3TM+/sSLU+lJyNbWDUoVEURQL0ASXThmIuJAHiCktQCDj7ko1K
	d0yjubUnXNJEnNvBCSoHnfzhH/pBcVGJB43JBFPgI45Vxf1mdW2QibqlgYntsUuWMr8ltGCbMoC
	yJQesrmMy5KjHpsFFWvqmpTn5GsHMLAdhPPDa8VBYAD/vWa1/kB1Ez9ZDKz/08qsSA4rdFegZZ1
	h9l0gsBhHVHsLvTLkR6l6KMW1oWYF9Ye0oEb0JVCyiA8qqMxqtnKB5RQtInYW+l6hSyJINRfja5
	IyzJDiNUce0pJIuCrbSfMWoWxCFPuy2Li2r+0vInJdNRg/1fijxtZo9RMqZvvvtL+hOcOon5d0e
	nA3a9V9dM5rFZGBgTPAin4Z/Qm6rU
X-Google-Smtp-Source: AGHT+IGTsJzIbEQm5HV2vmpaRW5RsnVce+YqtFX9PtY/+Yvicme9nLHhJs9s7xWg7oZD6V/vVBop0g==
X-Received: by 2002:a17:903:a90:b0:215:6c5f:d142 with SMTP id d9443c01a7336-23f9832e69dmr45488815ad.20.1753280708031;
        Wed, 23 Jul 2025 07:25:08 -0700 (PDT)
Received: from PC.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6eef80sm97689315ad.181.2025.07.23.07.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 07:25:07 -0700 (PDT)
From: Sheng Yong <shengyong2021@gmail.com>
X-Google-Original-From: Sheng Yong <shengyong1@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	shengyong2021@gmail.com,
	Sheng Yong <shengyong1@xiaomi.com>
Subject: [PATCH] f2fs: remove unnecessary tracepoint enabled check
Date: Wed, 23 Jul 2025 22:24:56 +0800
Message-ID: <20250723142456.2328461-1-shengyong1@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sheng Yong <shengyong1@xiaomi.com>

There is no extra work before trace_f2fs_[dataread|datawrite]_end(),
so there is no need to check trace_<tracepoint>_enabled().

Signed-off-by: Sheng Yong <shengyong1@xiaomi.com>
---
 fs/f2fs/file.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index bd835c4f874a..a96115584203 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4855,8 +4855,7 @@ static ssize_t f2fs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 			f2fs_update_iostat(F2FS_I_SB(inode), inode,
 						APP_BUFFERED_READ_IO, ret);
 	}
-	if (trace_f2fs_dataread_end_enabled())
-		trace_f2fs_dataread_end(inode, pos, ret);
+	trace_f2fs_dataread_end(inode, pos, ret);
 	return ret;
 }
 
@@ -4879,8 +4878,7 @@ static ssize_t f2fs_file_splice_read(struct file *in, loff_t *ppos,
 		f2fs_update_iostat(F2FS_I_SB(inode), inode,
 				   APP_BUFFERED_READ_IO, ret);
 
-	if (trace_f2fs_dataread_end_enabled())
-		trace_f2fs_dataread_end(inode, pos, ret);
+	trace_f2fs_dataread_end(inode, pos, ret);
 	return ret;
 }
 
@@ -5225,8 +5223,7 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			f2fs_dio_write_iter(iocb, from, &may_need_sync) :
 			f2fs_buffered_write_iter(iocb, from);
 
-		if (trace_f2fs_datawrite_end_enabled())
-			trace_f2fs_datawrite_end(inode, orig_pos, ret);
+		trace_f2fs_datawrite_end(inode, orig_pos, ret);
 	}
 
 	/* Don't leave any preallocated blocks around past i_size. */
-- 
2.43.0


