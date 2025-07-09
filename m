Return-Path: <linux-kernel+bounces-723686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF57FAFE9F2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 622071C43BDA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1608A283FF0;
	Wed,  9 Jul 2025 13:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YREBtfwb"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA00A135A53
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 13:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752067190; cv=none; b=dcaqPP9QGpdC7Q2mQodMnqc9pWGdUS2igr5QXxRvRM9hx6pEq7rnRjsVD+awuGbMLjTUBUWEWilbItRwTlrXwQakey3KT7/wBabIuTTmO3vD48VQ14vlGYeL9tpn/5W4U0zjTicG3bMQtsZUQicRXAfQxnXJYumbXBesHP7Oxmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752067190; c=relaxed/simple;
	bh=LYwEdFZlZwVxfuxJAWhXEgE7x7WNTi/DIUlR8bQ9OXY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pqmoz3QAOpf/pZ57ZjJTRupUTa/timSaciNBdJQtVq+noPRWFnvEQfvMzDeO2XdQsPuS8WXwvFde4AGsietvtYSdpQvVleIakGpfMvwSGcL13wSAS9XA/N61gfji+0s8zEQYEVkIYRUSA4BkWOvEowHl3I3kp9hRmpmengFkKLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YREBtfwb; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a575a988f9so3601133f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 06:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752067187; x=1752671987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r9sdX/lzvISARIQd3K/Z9IYXIEZnTGzUJEULrozFqk8=;
        b=YREBtfwbQZyIZAXoNFan7izcdbdGa4g/lBi5pfp9r/OLo8Ok/lXO9dvi1qEggbKJMd
         04hHZZ4ngE5dyj87TZs6idTpFtHUcFaKMqrttu6O5CZ9d8omEAf0deP9VjiveK6PlM+J
         J3cHUVomLuRPz9hdEDJ1a9YFaKk5J9EYpB1lRLpdcAhfpdLYf7tkS6HvDRvnhbAvwI2+
         soIhDvqf3C/u53KI8li/Mue6BuDaP8LjaaWPQrCuPTRBYAs1NtYWPJcQxD80VzdtaklD
         eASMoTNeBd0o38B388o1CGM3lVOx96B7em42KoSMUDOlfbhSEYqUbXzIodUjgqB1kJg4
         Q7iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752067187; x=1752671987;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r9sdX/lzvISARIQd3K/Z9IYXIEZnTGzUJEULrozFqk8=;
        b=UZvAEHfSi0LgwDSP8c3maW6PkdIWbkIBwOQ2MpoA5vT4XLV0XCmtjp9ReuggXGRi4x
         ESrILFE3ZHGF0nDP5Kbxdb4h/cuFLfmGSmvTSovX8AtcxuyQ5xtG1/U9Rny9/Z54hrOJ
         VhT7lS/0Ew+Ha7h0uWnmme88TE7HL+tNwrDsHB9gAjMUNlQ0Rz5avJ43bUb5H0iNSEay
         D+c5+jCnv1jl9/LTSjfXbhX7ogXEznPjwkVAEwqR5SxJCvpqsuvhUlvKtAPTZ6LtL6Bj
         7OImi36Ogb529yGRtlw44yo08rCCNTw6znz4WKNbhSC4DCnYHuImp0NgR+tlNVBOb4U6
         uJWg==
X-Gm-Message-State: AOJu0YybGJ+4GHUYVVFCnVxQNTcD8eIYaX2em93PKdpPnu3oS5Gz3TKJ
	7jMqlRarL4JUHrWHsPBgylI00aJbBi+/AYIsc62S9LEekyz7uHggKbi1EMGcNQ==
X-Gm-Gg: ASbGncueaLvznTlfOMeWQ9zTLa3sbtXQNqy5otHLk1kTcrkft5/ZgZ8Z4WtFzfRf4yq
	SNONsrblkoZZsl0tceNtSEQWBwErq7cjFEIz0/n4xb9qA4XHClA6eH1YiMX8CpktePgkfVsO+DX
	51exB+jzJb1RuPQ205R4kqYmkLT+w3b97UqFKTmCXQtbcYOXp6nwPpVlefMuVzviNnMML4zvMDK
	IwC1B+A/rFfjce40W6EOKfQ2/9qQ8biYXCiZRm20ik6zSA9hDmfXcKuGVxydHby0PP+U4BY+KKY
	Uipmcc+HJQfTaTs0d04S+duMTlQEQeUW/RMckHDHnY1qWMdAc7I=
X-Google-Smtp-Source: AGHT+IEP36I4uLZFPEqIAKimNmUeX5RvwxrKa/udDy0+BToJFi6pB4mdPD7u8+I2RJKhP53s3ySe4w==
X-Received: by 2002:a05:6000:1a88:b0:3b4:98f6:dd77 with SMTP id ffacd0b85a97d-3b5e4502d0amr2206914f8f.36.1752067186569;
        Wed, 09 Jul 2025 06:19:46 -0700 (PDT)
Received: from fedora ([193.77.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47030bd58sm16159876f8f.18.2025.07.09.06.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 06:19:46 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH] workqueue: Use atomic_try_cmpxchg_relaxed() in tryinc_node_nr_active()
Date: Wed,  9 Jul 2025 15:19:03 +0200
Message-ID: <20250709131923.93776-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use try_cmpxchg() family of locking primitives instead of
cmpxchg(*ptr, old, new) == old.

The x86 CMPXCHG instruction returns success in the ZF flag, so this
change saves a compare after CMPXCHG (and related move instruction
in front of CMPXCHG).

Also, try_cmpxchg() implicitly assigns old *ptr value to "old" when
CMPXCHG fails. There is no need to re-read the value in the loop.

The generated assembly improves from:

     3f7:	44 8b 0a             	mov    (%rdx),%r9d
     3fa:	eb 12                	jmp    40e <...>
     3fc:	8d 79 01             	lea    0x1(%rcx),%edi
     3ff:	89 c8                	mov    %ecx,%eax
     401:	f0 0f b1 7a 04       	lock cmpxchg %edi,0x4(%rdx)
     406:	39 c1                	cmp    %eax,%ecx
     408:	0f 84 83 00 00 00    	je     491 <...>
     40e:	8b 4a 04             	mov    0x4(%rdx),%ecx
     411:	41 39 c9             	cmp    %ecx,%r9d
     414:	7f e6                	jg     3fc <...>

to:

    256b:	45 8b 08             	mov    (%r8),%r9d
    256e:	41 8b 40 04          	mov    0x4(%r8),%eax
    2572:	41 39 c1             	cmp    %eax,%r9d
    2575:	7e 10                	jle    2587 <...>
    2577:	8d 78 01             	lea    0x1(%rax),%edi
    257a:	f0 41 0f b1 78 04    	lock cmpxchg %edi,0x4(%r8)
    2580:	75 f0                	jne    2572 <...>

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
---
 kernel/workqueue.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 9f9148075828..f0bd688bb88b 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1686,17 +1686,14 @@ static void __pwq_activate_work(struct pool_workqueue *pwq,
 static bool tryinc_node_nr_active(struct wq_node_nr_active *nna)
 {
 	int max = READ_ONCE(nna->max);
+	int old = atomic_read(&nna->nr);
 
-	while (true) {
-		int old, tmp;
-
-		old = atomic_read(&nna->nr);
+	do {
 		if (old >= max)
 			return false;
-		tmp = atomic_cmpxchg_relaxed(&nna->nr, old, old + 1);
-		if (tmp == old)
-			return true;
-	}
+	} while (!atomic_try_cmpxchg_relaxed(&nna->nr, &old, old + 1));
+
+	return true;
 }
 
 /**
-- 
2.50.0


