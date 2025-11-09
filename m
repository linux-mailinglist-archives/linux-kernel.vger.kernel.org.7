Return-Path: <linux-kernel+bounces-892021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E04DDC441B6
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 17:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9C15E4E6808
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 16:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDE82F83A7;
	Sun,  9 Nov 2025 16:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pUF3qlqZ"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54A1A55
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 16:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762704042; cv=none; b=WnYvGizKzCMRsLy41JTWt0faKk9NWE8HxJYG5806V0GBDOanWyx6j0Km7oMlMCmkTx35cKvJNzS7+zFJXMV0+DfKRvUbLLaP1yeSb2AuVuD0VOYz0zE4RBjZJ4IQ7msW8PBJ6Ndv//1TuO83Ct6KDdfiwhGW4IbjyKoGv3bQPJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762704042; c=relaxed/simple;
	bh=lZvV70kTqsZQewiAUaldYTCOHiC89W73BB0Zkoo7nrA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=q1UbppIFqsAigpEPW+ScnHVytxurlTeRfRBXxG74kuJARaN8bdBG8IVoRzyJzOtZ8MSZqqg5xH1UFtWDAunYt5Pzh+oj62k7StT1vFO50lxN+c0tBe25EG25Fo/Ms6k5gNfcG1t2+RdvpW9sJsPHkqTDHjqLZariMLlJ/OOKNMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pUF3qlqZ; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7a4c4eeeef2so4342285b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 08:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762704040; x=1763308840; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i2OzXeKNneGABFNBhjLRDYq8qC6GSQyDKseWAtysGpU=;
        b=pUF3qlqZk+bQRwiQTVO54Ss0sM+lu+19vHzk29ygkEMIBp5mAo+sdoMMlYrc9+Kk5y
         fDCQn867V9kDbXU7swUZMC8SEFrHCJVDgb7RpnWD6I392wcZAWpV8HvnvfNKjiR/PFKD
         bUrDRd/LdjQNu76JCjXwQbRSwowxSiMclH1vozkRnDe8L8ZTWWI433u9gcyRh0lkW2J6
         dItcBR0zwj+J5+p4wjeW6Jb6hMZhrajCz02/PGrt5nUO6pGnlehcUPlyHhEGE6NZpGum
         UpLVpad8pgGbxYA5SYm1TP/it0isJ9czU1Dk2SNWbdw7cCP0GZaL7faWKhCN+IpYSAfY
         hQyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762704040; x=1763308840;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i2OzXeKNneGABFNBhjLRDYq8qC6GSQyDKseWAtysGpU=;
        b=X1jOvsnjDD/B8AatGjHxkhnA5rw//f1tlqfNArMQgZNrCSD9h5Pv6Qi5WXOc/hajqz
         No3GHudyi1Mqtup5qCwbEGCeb0LDwIIUdPaO6/VWzgh6B0omxT5xbXO8XvCsFhVoL4Oq
         eSTjEqe9DTuHbaMFbID23lDmRwt3D1sd0lfYM5lDWjpyKN1CyynSTIC8UiNNS22d/Zei
         EEZDc/+cgwlVuJjg1xRW3wTShITte6cKGL+Z3foxqbkx0jlAgEod0NHhVZeprqwrBQgX
         inSHpzQ/FRKsn/86e+84tMXVp1qbbBIDZprXftSGg9PXRI0xqFimVPl3fQN+0DUGgzSA
         GxEA==
X-Forwarded-Encrypted: i=1; AJvYcCWnPQBht1r2VRuQB96JZqMi4BB7L/kCAQsPe9muPwTEirODXzUvtVLoeu7/byA6lhelQPcPVVV2ezdVe6E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs2UhrKK2K36Lkw0gSNhgzli2vwVPfsrmrfeKI1Q6hlUqjSaNK
	f7Y/R6hwS7Yx7XA39XUKkC0Fn0MkMseOTosP0gH9apzoqyL9XTQWvivaUJGd5VgPJNonnCGE+ce
	sab5dbHaTEEE92w==
X-Google-Smtp-Source: AGHT+IGwLWlMLyiX2l3NxY80lDvLEsez9GNj+dl7otW1z0CVKx1+M4K+OZc+6FIM3t44/6n6jbMNUetsoYmnPQ==
X-Received: from dlbeg37.prod.google.com ([2002:a05:7022:fa5:b0:119:49ca:6b93])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:6a2c:b0:2be:81e3:1124 with SMTP id adf61e73a8af0-3539f99f2b0mr7810074637.2.1762704040038;
 Sun, 09 Nov 2025 08:00:40 -0800 (PST)
Date: Sun,  9 Nov 2025 16:00:35 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251109160036.643864-1-cmllamas@google.com>
Subject: [PATCH] checkpatch: ignore removed lines in comment detection
From: Carlos Llamas <cmllamas@google.com>
To: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, 
	Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Carlos Llamas <cmllamas@google.com>
Content-Type: text/plain; charset="UTF-8"

The comment detection logic in ctx_locate_comment() can be confused by
removed lines in a patch. When a removed line is encountered, any
previously detected comments are ignored.

For example, in the following change checkpatch fails to detect the
existing comment and reports: "WARNING: data_race without comment".

         /* explanation */
 -       if (data_race(priv->init))
 +       if (data_race(priv->init) && bytes)
                 break;

Fix this by explicitly ignoring any removed lines when looking at the
context. This ensures that comments are correctly associated to the
added lines.

Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 scripts/checkpatch.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 92669904eecc..c4432f88c58f 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1990,6 +1990,7 @@ sub ctx_locate_comment {
 	for (my $linenr = $first_line; $linenr < $end_line; $linenr++) {
 		my $line = $rawlines[$linenr - 1];
 		#warn "           $line\n";
+		next if ($line =~ m@^-@); # skip removed lines
 		if ($linenr == $first_line and $line =~ m@^.\s*\*@) {
 			$in_comment = 1;
 		}
-- 
2.51.2.1041.gc1ab5b90ca-goog


