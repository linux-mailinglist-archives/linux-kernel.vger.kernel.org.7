Return-Path: <linux-kernel+bounces-852875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C95EBDA26A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 16:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF1DB427BAA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F41D2FC007;
	Tue, 14 Oct 2025 14:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QR1iM786"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033A92F99AD
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 14:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760453257; cv=none; b=puQLNICYcUTlIo0BUqntvNX9inak/ZZf965MR24a2e6LApIX8an/zISkpJKWz9Xb1vJF+O+8iYFIJQrAP5T1lcKOKWqmgsshTfPjQsLeStORgVu2XzVDFM1rHTVjQAuV7ct0PkKzQx5mDqYHzYScmyrhKgK6dk8R80TtBADra2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760453257; c=relaxed/simple;
	bh=1WUetKlauk9q6CO44k+lrfotpDff1uajdkaAQjZEFho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mc08JrQSCbBtBABj1FHyo9fgcGVZURwCoUwqsJxqB+cNS56kxojTP7mO4A8Wj+7XW+9ur1Vg46HyuK8AKF+n4hChrHTmqOtugB3JABqFqASNIqcGMlemkDx8EysGCOeQSjP14UslueAl/9xsnjVpIePzp6C7pXb3FAaoHUk0l+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QR1iM786; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-36a448c8aa2so47196181fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 07:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760453254; x=1761058054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2+NzArl50yruflBXWfUivTM4ljt6tZKIzBIR3VQtiao=;
        b=QR1iM786AQ4dP+c5OGZ0EoDex5LcrH/Hwc9r9L2kZRuksaHLrv0XmYPtwQxiZ9pUuN
         Bgrpr4zhkL+NnZr6FS3rNBWrwcE4Gx7jwzEeNihxZJs8A30eoh8sZXhjoL+oUxaugSXw
         raWbnxGctAYBU9hh975KwsSFQ07XxbdOOg5+i7C/Fiet7/R7FjfcQL9vO/TtPt6ywUAn
         vSFsc81FClX4QvZA/JxI0z/s5KPN8r7vZyWkK+piX6shGsVZs/WCcDTq/NGxz7ZgSQn5
         RNmXmtX69i6ZzYIUK3fpeDdmccTVYMZLdS30Gw1I/eaiA8Te1cmfxydg9BId5lbI4g19
         mCJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760453254; x=1761058054;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2+NzArl50yruflBXWfUivTM4ljt6tZKIzBIR3VQtiao=;
        b=PCbPUZqQVpEUfLyqtjjU7753re5MtWuySAR1Rb5ksCLU7fKBOg4IPOzIQNanFKGBn9
         5N1eVOts271Qp1Uh8ny6BlrLF93Xbdxr6xTrTAK2bkv3RULDTyi888sT8yceE74lEqL/
         oYLuqVOuZnfsblX9Rgt+Au/R5/ZTEWYJmhgh6VmX/wYxdkGfi7DOh6IXTFsyKCKf38CH
         eB6d1ZCTv4sMV5KpHqC4N9P4v/LhaE0yqk8lfFbRfM4FRpiwGOIz5dwTDk3duoT9jSD4
         6ZfzFhCpf0UCtLAxo7N121/CoIUX1G79v886e1RuHvXrUPjwU6nRxzqwBli9K5lECMZS
         ucOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuJZpDhgiF3q35LU5I4V8sJ8fSq7GvE+i3kdLUHnwXFObLoS5ft/FXgQiDuTOjt62LXvGXrdXPnVdBSmE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz65JG+p8Xkoyh+TPojNk/OSkR7zFmRj3fo0fMenspu0ypUCFEM
	ImvCUNnzzHLO4s8gq5pp/qc/+ydx33DrSXM+5vgYq1uq01WgTq9R15cG
X-Gm-Gg: ASbGncuKX1+xwpXAynvo22Fg78zlGo9KkJdJ0BElReXQn6a51CKwaPDcU/8twBKk24C
	opxBSTIbEdFFDZrv+4nWxTADP9u5cINFT08f7qAlhYHOXtvVFo7sRZR644EirLxgXmk42Z93Uo9
	D0Hy8YtrPtXhf86RyThf3d/1RbC8pkhQdUOXr/IyYq8MOhyhOo4aB7UVROUaYDlYfnxsxER2XUn
	NXEe7yDlVnD+uT7yAAsETJspSN+hcg4ZwsWZcXEbPEjBoDIT5C5qiP6oZXCBEgt9t+hJC3eNvuM
	lkpIyqHk1xk9Z5iLhkEt+G5Juk31Coqj2WpmDJHG8IxdplDUWQ+hGXILqRJg6OFdvrydg6lxZaJ
	amgchnm4hUSYYR1YKsuHYwdUPJF1CcmirLNpuNUrPOGD72A==
X-Google-Smtp-Source: AGHT+IFK4F5kk10SxvIDhTT4eCmKcDyB2K6FviG7CeDm523qbnVyJMoPw+sUVAfd7ZSWE53ZffFc/A==
X-Received: by 2002:a05:6512:b89:b0:581:9295:1b02 with SMTP id 2adb3069b0e04-5906dd532a0mr6183384e87.27.1760453253740;
        Tue, 14 Oct 2025 07:47:33 -0700 (PDT)
Received: from localhost.localdomain ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5908820d8cfsm5311007e87.57.2025.10.14.07.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 07:47:33 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: Mikulas Patocka <mpatocka@redhat.com>,
	Alasdair Kergon <agk@redhat.com>
Cc: Mike Snitzer <snitzer@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	LKML <linux-kernel@vger.kernel.org>,
	DMML <dm-devel@lists.linux.dev>,
	Uladzislau Rezki <urezki@gmail.com>
Subject: [RESEND PATCH] dm-ebs: Mark full buffer dirty even on partial write
Date: Tue, 14 Oct 2025 16:47:31 +0200
Message-ID: <20251014144731.164120-1-urezki@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When performing a read-modify-write(RMW) operation, any modification
to a buffered block must cause the entire buffer to be marked dirty.

Marking only a subrange as dirty is incorrect because the underlying
device block size(ubs) defines the minimum read/write granularity. A
lower device can perform I/O only on regions which are fully aligned
and sized to ubs.

This change ensures that write-back operations always occur in full
ubs-sized chunks, matching the intended emulation semantics of the
EBS target.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 drivers/md/dm-ebs-target.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-ebs-target.c b/drivers/md/dm-ebs-target.c
index 6abb31ca9662..b354e74a670e 100644
--- a/drivers/md/dm-ebs-target.c
+++ b/drivers/md/dm-ebs-target.c
@@ -103,7 +103,7 @@ static int __ebs_rw_bvec(struct ebs_c *ec, enum req_op op, struct bio_vec *bv,
 			} else {
 				flush_dcache_page(bv->bv_page);
 				memcpy(ba, pa, cur_len);
-				dm_bufio_mark_partial_buffer_dirty(b, buf_off, buf_off + cur_len);
+				dm_bufio_mark_buffer_dirty(b);
 			}
 
 			dm_bufio_release(b);
-- 
2.47.3


