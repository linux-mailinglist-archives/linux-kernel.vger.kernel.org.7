Return-Path: <linux-kernel+bounces-891523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C29BC42D84
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 14:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 81A224E183C
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 13:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BB41E008B;
	Sat,  8 Nov 2025 13:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b="GaMsnbtz"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4016554652
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 13:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762610338; cv=none; b=iXgrconEPThHHK2JEUoQ1amZuvR//Lwm8sOOzkSWv5EQKOuTTry58miT7scDz8R6CRe488EhmqdCg/Coo6eXDlMrwkpkWwUmXEbezQMT6bG2Qvq/rhfZ/taS2VoKXqjJB2dVRFUO/LVCHmyf7BcKnPlu8sUzIBmTAjtj1fFbIKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762610338; c=relaxed/simple;
	bh=R9U9FFPYFfs1lf4z9IJfnV89cTwqAR88nq9i7ZjM2ao=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PUM1wU5hVZq1S36juhWS8cG0sBW9Nzl3O/gVLDF07aEJSHEhcOz9JGZhci72746FnggNB9uqgG7UyN7Unt/Hd8sbO5fnwydd2+abO1TsMOuPPsNSjKzGZFkfzyxmeUX78KAEz3gzUcr+B+Dq/1DNQnJpiK3szD7jcppL896kTxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in; spf=none smtp.mailfrom=ee.vjti.ac.in; dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b=GaMsnbtz; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ee.vjti.ac.in
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7aad4823079so1478485b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 05:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vjti.ac.in; s=google; t=1762610334; x=1763215134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c6n3EPsz961nven+j6SJxgAVgFz9niflHZuv3YbeEgs=;
        b=GaMsnbtzQB6uTSej9w1hXM8YNbsfzq9NlDzyNw5EiD5VmGI5nsiXbaDZmCCOUpBcTe
         wf8YVCRbvTsF1tTqDcD1Oa7B4CRghIsWgocDsTSPZPffdvU1SVkmRh/uOtpZ6EBpBvuc
         psGtz+gQysxYQN45EYCqP66UaJuW+1m6UJF80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762610334; x=1763215134;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c6n3EPsz961nven+j6SJxgAVgFz9niflHZuv3YbeEgs=;
        b=UEEhYdPU3IZ/blmpkjCTB8nulY5OY2SWmlzRZHPmd9IPzbVGHpfFmfGdnGarYLkbga
         1WZSRZJhJm0lwSrPwfNrT2ifncERej3zPP+6k27BTvNQVdEL5mSaDJl/SOaizIMP70sV
         YZVVCTb+Iuee6SipMqTSxezTVY8UgaQAL4tHUU2xR8J8AaK8+6QOOvNDZBcFoVgc9D6U
         7Q2Z6L0+kd80hC/XJyQFb896aFQUNw2p67PNN7bveUHtOLQtfMj1J3sEghdJruhdywpI
         RPj2Sz5MS6fD+l1QRXCsbHRQUBG0rOBFNos/FMYig/Ds/BM71z8IomLCEzBGW+FDq1Dp
         LWZg==
X-Forwarded-Encrypted: i=1; AJvYcCXVJwCsbgHoyWHM3XfG3fBblACA0zWCLlXDx6iMGP85vdp03r9JXc8tKpvc9OAsbxtsEg28rPLELQwuSmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgE3rYl60s1IFoSF70Bh6sCt0AwQemOlrls4RynQEycMGbDraY
	+mDAbd1QANOaSF1Gs0MJ73jnXf3MnkbWYG7F4p6Kr9m4XppwT5wrO4fbdu8EbbJqIdw=
X-Gm-Gg: ASbGnctfooOABZaOmIKmu56f9L1V5TDP75Shy9/xisBmIYVMKrDTr8q0zVdOQYhui9o
	jrIXFN0+ArjeSvjNLzGkuhqVDHEFGh/i5g3BLzc+PX7yLuj/dqgXuRjyFh5tKiXTDdGlZlCUS+Z
	ye5iAHyrp6SKaGzXt1BLD79hoNN6ZFb80Jf1VhTX407fQsJXvSz0RYFqDsA+JTQFfG2u0LduYW6
	gwjeJV0boXhnEGya54aMLeB5f/l+5r97bvEPb3mmXVtiy24YeYTY7paD+Gq3nx6k1Hv3OFbJE/U
	oid3INMfvmQeBRVCT4p2YaEyF4JS9XaeSDVXq7sC8/wikavjXHrXiVgNYSGIgRonS8XDJmZnT2l
	7iUHUe2dbooYgIq+k0BvGCFlb+65ow3BHhh/aAiNsz+sfsAS+b1YltDmdQrniS09TWiSCPvl8xl
	WARFat42sZtG4NPvrd2gwP2Ksaxf/ogcQFKEONBQRcFtlq
X-Google-Smtp-Source: AGHT+IFQqVguGIqedsjEz0k0Lw5GFUnn9lv1d5S1ooXU8a4FS9klL3ycJRWkb/ndyRRz6jrg5EhccQ==
X-Received: by 2002:a05:6a21:3391:b0:2ea:41f1:d54a with SMTP id adf61e73a8af0-353a3d61343mr3226851637.55.1762610334543;
        Sat, 08 Nov 2025 05:58:54 -0800 (PST)
Received: from ranegod-HP-ENVY-x360-Convertible-13-bd0xxx.. ([2405:201:31:d016:940a:b59:9e93:d45a])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba8f8c83d52sm7985853a12.3.2025.11.08.05.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 05:58:54 -0800 (PST)
From: ssrane_b23@ee.vjti.ac.in
X-Google-Original-From: ssranevjti@gmail.com
To: shaggy@kernel.org
Cc: jfs-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	dsterba@suse.com,
	david@redhat.com,
	shivankg@amd.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	Shaurya Rane <ssrane_b23@ee.vjti.ac.in>,
	syzbot+e87be72c9a6fe69996f5@syzkaller.appspotmail.com
Subject: [PATCH] jfs: Initialize synclist in metapage allocation
Date: Sat,  8 Nov 2025 19:28:41 +0530
Message-Id: <20251108135841.42281-1-ssranevjti@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>

The synclist field in struct metapage was not being initialized during
allocation in alloc_metapage(), leading to list corruption when the
metapage is later added to a transaction's sync list.

When diUpdatePMap() calls list_add(&mp->synclist, &tblk->synclist), if
the synclist field contains stale data from a previous allocation (such
as LIST_POISON values from a freed list node), the list debugging code
detects the corruption and triggers a stack segment fault.

This issue is intermittent because it only manifests when recycled
memory happens to contain poison values in the synclist field. The bug
was discovered by syzbot, which creates specific filesystem patterns
that reliably trigger this uninitialized memory usage.

Initialize the synclist field with INIT_LIST_HEAD() in alloc_metapage()
to ensure it's in a valid state before being used in list operations.
This is consistent with how the wait queue is initialized in the same
function.

Reported-by: syzbot+e87be72c9a6fe69996f5@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e87be72c9a6fe69996f5
Signed-off-by: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>

---
Tested:
 - Tested locally with syzbot reproducer, no errors observed

 fs/jfs/jfs_metapage.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/jfs/jfs_metapage.c b/fs/jfs/jfs_metapage.c
index 871cf4fb3636..77c512a0a42b 100644
--- a/fs/jfs/jfs_metapage.c
+++ b/fs/jfs/jfs_metapage.c
@@ -269,6 +269,7 @@ static inline struct metapage *alloc_metapage(gfp_t gfp_mask)
 		mp->data = NULL;
 		mp->clsn = 0;
 		mp->log = NULL;
+		INIT_LIST_HEAD(&mp->synclist);
 		init_waitqueue_head(&mp->wait);
 	}
 	return mp;
-- 
2.34.1


