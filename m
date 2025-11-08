Return-Path: <linux-kernel+bounces-891540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 55647C42E24
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 15:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 312E44E7A4D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 14:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509021DFE12;
	Sat,  8 Nov 2025 14:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b="XQwaLR2t"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AB719005E
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 14:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762611538; cv=none; b=kik3kxtF+O6mpDDPj1MIf2s8dXFGrHu6BzoPNq/qGe+U6kGfY3fVk9PEY60SJCn3bXIZ2n6RgiVLZ0TS3H7BR7EmS9eiiFTT6RR+i+5d68NlRqlrO2FyiEvvjlqK0OhYmbr82913sPSOrIcP7j3gouZvrKiDlTxdYdLbPR9pDmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762611538; c=relaxed/simple;
	bh=ZAWBzX0a54WgVpMoNdpAYLQpNuDibi0QFmX+nolbDCI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gft/HKUKDpCZuBbgCmzdGEc5WGCFHVJApi3yyJUIOFbJch/k+nP4MzIo9uF645b8WK9mZgrIQAJ2152nzrrNOiAOdC6pJDBgQx/VU+JCly2BQG483Y1DGOCukSqOMjDXBsUQR51ifi1nF2WoVF7GYhPI3+PEsBMc+rx7mDW09bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in; spf=none smtp.mailfrom=ee.vjti.ac.in; dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b=XQwaLR2t; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ee.vjti.ac.in
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-294fb21b068so19193115ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 06:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vjti.ac.in; s=google; t=1762611535; x=1763216335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+tbABRM++smOTjrYwL9jZfiTdA+E+dTcCgbmNoRiaFk=;
        b=XQwaLR2ttw0M8ua5piQ8WtDLfYcdvTZle47NGDMPMfO3cEC+43YklzJZ5nDHSX9tiV
         fpeWZXYu4IrNbRITV6z99r3KFUnl7W0pemw8yat7qJ/hOhxflYAQw1BtVkuDIHKw6TQ9
         RNXTSmcjItd87oZ3jUzAraJfaTnGqhBM/uQno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762611535; x=1763216335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+tbABRM++smOTjrYwL9jZfiTdA+E+dTcCgbmNoRiaFk=;
        b=qOdon9sGUK+qv5M7QBZru5hL8QJ0eoU35ZfmGOubNqWWiwMDZjyLuaOQwUybfFmThM
         qvXp3JmEtRUi7Saf1kNPtOND2rxPI+hZ8/wIVMEjHy8/vaDEj4WW8Ux/LcLuv/nGkj8E
         gklJmm9PP6tYGbhf7GwMy59hkK39ivQGTZaLRqi6+9QdX9kB7ac+jlKN1GgUFGnpUmot
         r8mXXHxkEsm7wecucRpoyA7PDLhdYym/M5qa7iUtdZGtiuwZrmIq1J5J992VK/w04F3j
         SWwzc8He6meqf6ACKCjsSOUUZjXpZHnkEEKkcz/lYv4xDfVErGodCD76vxn5V5OEqqiW
         hcZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNQs60kRSuSawxkTW0AjSx1MW3QDLVzknVUC7/P3u0StcWoa5WWpbHK2GydnvEkLsVXTOQFiA/1yfephA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqBljikrX4haLVYftYJiUVsJZtW40GgXaY+aNC+fAA+F+sc8Sm
	TNO1oIcvP8h2WdJu92EcgRQ1/8dAcDovlEoMmqdgiRUI3QzzG+2mlgPHCE6O7QcTxVg=
X-Gm-Gg: ASbGncuJM90LmYC+xySNiJNoVas2tVzmZsL2xWR5bWZbdHXWFsdHn4fiXGiABRJtSOC
	JpP5DM2KoQToVBPqRrpESkdEFk53F8hCZH9B43828vmIt/NcjjkCpvoexOc39pltonDnm/xTmm3
	3QtKTpNZ9XU23ATWgMeYaSp/fmKj0U+hVR3tCwsF2rqL59q16iQ6NuWf8v21YzO62+Mf0QLEPeS
	do3cp9RSKi5KdDcowtuw13SbbKZ9BUz46ldizyztMLA57uYJKUeIhDiI+YmjmcQkSNIncvYLBj5
	nVBlzd7147ZGQnwU8K0IFe0EgPt2Y1vYLqbxuti3d40tcYiz+qKEiWBxKe8NsjYVA+pXwuNya2E
	OFPkyxeuLYZcc4JC86l5v4vGx9jR3qt57yoR7Xo5YpJ5HWO4QGiLlmn+x3TaMS1IDkmuH+PLw75
	DWMYTsf0NoTnGHjpU7EIyojsCEP1lr4clEzOIk30bP+KTO
X-Google-Smtp-Source: AGHT+IFCeb0OWUAtDUt6hRwnA2ps8eQb2CSjpBUF+IDZHNXFG8VCogkyWXts3NiibrXsnC+yerYFLw==
X-Received: by 2002:a17:902:da4b:b0:295:557e:7465 with SMTP id d9443c01a7336-297e540a394mr32978555ad.11.1762611535569;
        Sat, 08 Nov 2025 06:18:55 -0800 (PST)
Received: from ranegod-HP-ENVY-x360-Convertible-13-bd0xxx.. ([2405:201:31:d016:940a:b59:9e93:d45a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650e5a33bsm91980345ad.47.2025.11.08.06.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 06:18:54 -0800 (PST)
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
Date: Sat,  8 Nov 2025 19:48:34 +0530
Message-Id: <20251108141834.46428-2-ssranevjti@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251108141834.46428-1-ssranevjti@gmail.com>
References: <20251108141834.46428-1-ssranevjti@gmail.com>
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


