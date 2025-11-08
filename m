Return-Path: <linux-kernel+bounces-891539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 43746C42E21
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 15:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 06BB74E3D2F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 14:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B0D1D61A3;
	Sat,  8 Nov 2025 14:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b="C5rulVxe"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E3F14F112
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 14:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762611527; cv=none; b=LQZxc8J3kwW9VGOKM4Z93YBG9kVa5W6TXouZ/hqaJe3FYcMOgWCpe7ZCj1hBsXSx2An8YViIl57FemMHoLY26kd8H4WZJ1eTMiJJ3E4vGw80641T3OpLQU83mZQKgcxoFLSRz0c0ZQnTzPQ/0TyeJPdaX8X/Y+VWQmKM+gwm05Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762611527; c=relaxed/simple;
	bh=ZAWBzX0a54WgVpMoNdpAYLQpNuDibi0QFmX+nolbDCI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OWlyLQZKB7G3SrioMWYO/6BIZdisRjpdToUydAyiuJdvwADPPl2fAErLnaxd0KGZIlrxe0kIQiWlWmUUYPrCBey3F71+v1JbCJR/NOQhH2QuyGZKs+2c/o5Ep+ADrW9Imgqh6G6Y+3ftaWNV0vONI5l2a/Jto/ghSl5BMYjcmQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in; spf=none smtp.mailfrom=ee.vjti.ac.in; dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b=C5rulVxe; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ee.vjti.ac.in
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b9ef786babcso1097385a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 06:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vjti.ac.in; s=google; t=1762611525; x=1763216325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+tbABRM++smOTjrYwL9jZfiTdA+E+dTcCgbmNoRiaFk=;
        b=C5rulVxe5AifvFinuQS1mE9uIr0dKMIEGLvMKa2xfPzolO5vRZVBflcH1mMH1FhbBz
         poguA1t9xQctiAXunlXyW28OnktrocOTdfqNbSOd5HATCXjBAXVkrKeY1qdaRRz2rwD2
         qMQZ+iSXsKpT/teZWAwUBltlEFYdoFAGFugF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762611525; x=1763216325;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+tbABRM++smOTjrYwL9jZfiTdA+E+dTcCgbmNoRiaFk=;
        b=rnZ4af9N3CI4pfzikfmFfkj+9xorWT5PfBj3Gt5OyttuGLemuBKdiK/K3ShtpX+TLA
         AUZGEAIfzIIzkaGLCJji8YCRGlztKCHU9PU6LIiIcvDuwlX+1iUNFxiMNJ6/2Oe3yFDw
         7ydOtO0A6GFNn60PskHrDVcb6/yvNSwujyc1ZRAyyrHqhtvDO8OaEEElcYcjL2SZLCJY
         yhTcbOd8fdtC3cKNAzm9f+v2yD0RoufDP1dvKMc9G2tHqa5OnxCAcwSmlWstDrrXi87x
         oDOXuGetedjUth7Aguyo5B4HkgFP204G6A0+6XDjM0iiNkfqq6jsIU/bqZdcDgJnSnUM
         Ke+w==
X-Forwarded-Encrypted: i=1; AJvYcCXZyj16nW0S9ohDkJ5l8z08JprRMuMkuQ5mnGQj1ZrWdWax4ObvQ47aKCi3L4hdf/9Nw4WQQsaM8y86kis=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbDXiTAZ/bSwZtypjBYyStX7gLrnn9dtowhnG9t6jiWBPtJjyi
	/eTZoxL/YI0PNafm/TePjyKZ/LGHdSz4YyGIPB3JgzSb20YCwndTDimwbq+axxxpY9M=
X-Gm-Gg: ASbGncvSMIuGo3IF/X518G/MfAcocJo/YrpEnCK19DqNREabBK2fxvQSL79PUg0qrjM
	QdGFZXSRQdKQs8PJSNPtwddHiRp6LLWfBysBSOgygJh2U+l7out72yPY/un3zKbYgufQ6NyrhbM
	ad4f4bLoZBJvr7vk2CRrYpYKuPhjgmMxuEiPTLrF/uJgl1dzmvVsRSR5Nr/0qkVQMfP2JmQN8PA
	UiGOnz4fEEL2iu5ATZh3gaj/MC45dOaAgtkgf3jTa2Jvp6OPDtWDCBXb+5RK8kuyP0hUSWLU8T5
	PCjaislLaA6dwee4dtqan9ZoxfVuMdzK8308MM55zq0/3bq8FStbbl+o8qKAKf02pHh3OK6758A
	rbU8GyVcB1fnZLivHPIbpaHaND+xPSyxd3WTuviiGebXiovmPClXDER4nCwg6hfl8dWUDMQBaW/
	9sKvvJQ9zAPEThrjWfHPsVR2pcOgkMPCq3yiN5mNqO6GAO
X-Google-Smtp-Source: AGHT+IEZ9euzPCxHgG3701HKH2i39ZGTwwKtLTdHZiIOFoUF2Dx5qGD68ES419evk39qlMiE3JxWkw==
X-Received: by 2002:a17:903:240f:b0:297:e6aa:c499 with SMTP id d9443c01a7336-297e6aacda6mr28652735ad.58.1762611524506;
        Sat, 08 Nov 2025 06:18:44 -0800 (PST)
Received: from ranegod-HP-ENVY-x360-Convertible-13-bd0xxx.. ([2405:201:31:d016:940a:b59:9e93:d45a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650e5a33bsm91980345ad.47.2025.11.08.06.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 06:18:43 -0800 (PST)
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
Subject: [PATCH v3] jfs: Initialize synclist in metapage allocation
Date: Sat,  8 Nov 2025 19:48:33 +0530
Message-Id: <20251108141834.46428-1-ssranevjti@gmail.com>
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
Changelog:
- Correct bug link
- Corrected patch format

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


