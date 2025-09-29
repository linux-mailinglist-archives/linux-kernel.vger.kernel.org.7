Return-Path: <linux-kernel+bounces-835912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E70BA8522
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D67E162E14
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 07:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5AB261B7F;
	Mon, 29 Sep 2025 07:51:01 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6022335C7
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 07:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759132261; cv=none; b=OJrzSRZ411OPshXBxsa27pzpUXylrGi1lYF6cFdz4Ml+cXSLL4vcQZGwtL+pSXXlSmHZ0i9O8ppFcxbjM0s1O7gaQxt7CEV1qzdrwfwmgMzmDdFrXO0hgmBbpT98jMhH11np8fi2ejrm7TTWA6sOVpO4VZzHbdoBTR9xKsKpPOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759132261; c=relaxed/simple;
	bh=KVZbQ8SGKXyWGEwg1X3DJbRP5H5cAxKNrM4JuhMYfrI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EdX+Nh2HC+q/CHDqCIRqkq51tTHqFeh5VqAaP1oHrRQ0uGxoZvDbOEUSU8HWCBYWi7ENyv2L+pRQylPNtvdcUyKiktxbZccCiSj0hKV2BRKw3lFmsYmNW3Vll3m8RGBSmEXH7QmNQlND1gK6AcTSxlyxfr4/TSsCZczjaUKTUIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-42b2a51fad2so10486435ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 00:50:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759132259; x=1759737059;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZKLRqR5o2alKBSAo9q3cyRSd6fwX2esn5mW0Cc2zz0c=;
        b=pD7O++W4aeG+eatt/0Kmhb0y+1ioOUgGDflbcshO1oYy60wv0806mAm28tiaMNutz9
         hNTkAaMXhshzo1ApoBE9qLZUn65y9yWzn3biS5OznI3V9qQgobPpmLOfJFgiLfTngidN
         Wj/00w4Sl3/kwofosk+e05M+ed7njbpZreNxS6WEihiy60yN1gXZEs20ym61jqDyGx0J
         j+XkKpQi5Bm7dfmT378oW9KHtCxDWtw6LV2Rw6b3jGcZ+z5N5ZWQ0a44kDXdf++yrNjE
         y99ae4lody4TRHUYwsU1b6RVF97ig576JPKTf5Ypf0lZW0Dl2UUz7gtYRe1XogSZNWy2
         HVSA==
X-Gm-Message-State: AOJu0YylLhTU8GSoMypkLTX2b6Iictk+H5k2f546Xnb88z6U43w4YNI2
	nzFgVm0UdVBNH9FUAxknRPD2Vkzc5KV/LuuA20hOl2BX/zq8uyejdaY3uIQmrYmb5JbubOtozUR
	QNYA/UjzraCScvC9U5UMoumm/EGaaEHOXaKQ0qU5sXhkYAEjyFms4fODL4DI=
X-Google-Smtp-Source: AGHT+IERaleGFuikTNC533zvDXGlMdO93yY3X23ksz32mERxKmoW9baDvONdefOnSiCkYzm+S14i2LqQDshnSgoV89Z4gh2x+6zS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18cf:b0:424:86d:7bb9 with SMTP id
 e9e14a558f8ab-425bdaf0355mr213281225ab.0.1759132258855; Mon, 29 Sep 2025
 00:50:58 -0700 (PDT)
Date: Mon, 29 Sep 2025 00:50:58 -0700
In-Reply-To: <68b87c9f.050a0220.3db4df.01fa.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68da3a62.a00a0220.102ee.0037.GAE@google.com>
Subject: Forwarded: 
From: syzbot <syzbot+e34177f6091df113ef20@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: nooraineqbal@gmail.com

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master

Resending this patch in the existing thread with a '#syz test:' directive
so syzbot can test it.

From 1bb35c6722b8fb03e9262f6e6530d240629a44df Mon Sep 17 00:00:00 2001
From: neqbal <nooraineqbal@gmail.com>
Date: Sun, 28 Sep 2025 03:52:44 +0530
Subject: [PATCH] x86/mm: Fix off-by-one error in set_memory

Correct end page calculation by subtracting 1 to prevent
out-of-bounds access.

Reported-by: syzbot+e34177f6091df113ef20@syzkaller.appspotmail.com
Signed-off-by: neqbal <nooraineqbal@gmail.com>
---
 arch/x86/mm/pat/set_memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index d2d54b8c4dbb..daefc96403f1 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -446,7 +446,7 @@ static void cpa_flush(struct cpa_data *cpa, int cache)
 	}
 
 	start = fix_addr(__cpa_addr(cpa, 0));
-	end =   fix_addr(__cpa_addr(cpa, cpa->numpages));
+	end =   fix_addr(__cpa_addr(cpa, cpa->numpages - 1));
 	if (cpa->force_flush_all)
 		end = TLB_FLUSH_ALL;
 
-- 
2.51.0


