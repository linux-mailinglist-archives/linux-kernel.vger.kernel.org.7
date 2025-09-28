Return-Path: <linux-kernel+bounces-835581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34148BA7810
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 23:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D12863B73AE
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 21:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADB929B793;
	Sun, 28 Sep 2025 21:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBCqQKly"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8734727602B
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 21:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759093581; cv=none; b=bHKbd7CawPHrvNS7VWdADZeSzl15YyWdtgzNcCBdIJY8O/VduasSzH56K/G4i46GU9XPrbB1Q4BIK3kzj/MXJEsoahoXz6Umtb5hcEYKbZqZ8CpzdKYt6y2P/V5UVhbILkSXmduLh145pUM4jKc+J8mdTU6HSk+go0uwWs79oPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759093581; c=relaxed/simple;
	bh=hc97JYJrs85TwiA+5FAaYD0kUVXhjcggsmiNwZw/EdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fz/TPLkUBCLBryyKok2rYpuVz588VIQMkMvK1Pq7GIaoYs6Av8s2enUTBVchYp18NdH/VDqTTVvmp7uFCR2as+uruIFOi2n1M4aoilULIa631sTcbo0BYktZu69+VqpKnccNzGyzRMJEewRaBTs/naLGSTLzVX1YksCJHxF2sqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mBCqQKly; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3fa528f127fso3025176f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 14:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759093578; x=1759698378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7GOZxADKetbNWmP18yfkEj41q2tuf7F+8JZh0ODXm7w=;
        b=mBCqQKly4slaYiyaaV1gvqckYt4FbLHRi7Zlpsd8ogumnw0Mz58bV/UKsWH4l8Ou5m
         v5PzQwgLYgy+eXrUWtQgykYpprbfN45WSKZihOia92rtpjxfIX6lrNTTasK6jmnIpR2V
         SJlnM8/siObN+a3YMWq0rcgSpNlUXi+jOt46jtbXnRmF3KUpfijFxkx/9PyZbWINCl1f
         qS6P55HyT2v+IXA2pcNCN9WtrzcbnBdg2t1MNypXvBQ0ZJLqqkbPOyvtI9Dja3oU5y/m
         PVXOQA+OpoWrKzBmxnis5Uzz+MYalkEGWY29PMXDEgKxHKmdA7r7c/B1ufW7+rufZEiN
         tRxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759093578; x=1759698378;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7GOZxADKetbNWmP18yfkEj41q2tuf7F+8JZh0ODXm7w=;
        b=vKbwW4FrRV6ABsWsXu3AJMBkvQ2ehKCJxo9AlbPQ1t5VWn7iT4mVBINA1/tIm9XvU1
         Up4OMr+2cP5iA/yi2ZVEp7Bppk74Me6Eh7FT6dnisY1gsJqyYuGthrf7W2Y/4ySZ/5KT
         DM+/cYEJ2OU/07qAO77/Nkm8daeXo80MmCMC+GWsMjOnhYr4uYdGhppVl+hDGFQtHMkd
         ydDjX38DukWiU3MB8Q62cfEBaCPFu02dHcLyZqQkQSIRAE2kkEMrzt9SDMRK3Us+hOHc
         BQMLGx1Q/9oAicTC4OP74C4uoHaSrmzjOZiJQJJ1XNdVeta6/V3ai8EN0S+jlCdVNGbg
         5JIw==
X-Forwarded-Encrypted: i=1; AJvYcCUn4R+lHNbnv+dpFgB3KGD/Asq2arFtXjE9gvqJoSEOMQqdzTqz/qjlrmT6kKfDjNmBmRoRrrj8+5QIW9w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1jIyBwwnxyrAnraOGnksBX1L5lqY0kc57PafuqT3v/HEMVmbh
	2d2ofR89q/5TfwPH/bg7U6OAWLYhpm9Qc5csfL1UpyICNbV/7EqJTfakssqfanui
X-Gm-Gg: ASbGncthxViG2ZsO4LFChbkUWePZ1StQ8kx6oqgbbGdRI5mkL891iDKH7gWvdQBzwAW
	uZ54vw0ovvx7VYqzRyxvBb3NG+Ib4qIydhPZ0gFNHzQOOvwccl6wQv/b54843Y+NYHuPUkX3Bnu
	9a9cW9oTWAhRvmwdldbZYzy2T1QPo/QXbsSm1IRHtdPnEdvbq92/jXCO8v+s+QBcsTK8TlX23sr
	PQlCaNxGUWPdpOP87ZzFnEr+5aj0L9q0dRk1E/x5qq87zUiWjLWbQqovp4N72Px9vC4huMuDBPH
	tTkNfFmMwwca77myfeeqcHOsI4L3Ye8zu4W+zb38mZNMrrpY/Y1vDVXWIkHvI3jCixeNw+3Rdr3
	oYeW7zXT4C9rKUAWs+qKtOA==
X-Google-Smtp-Source: AGHT+IHUTJAtPXtQmR3XeP0zOt9RmSQ9hMHtdnuAfVVnI2fiBfQPProKSkthhRtOdJndpA7ra6vBVA==
X-Received: by 2002:a05:6000:1847:b0:3fc:54ff:edbb with SMTP id ffacd0b85a97d-40f60fdfde1mr13463024f8f.9.1759093577811;
        Sun, 28 Sep 2025 14:06:17 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-40fc5602dc2sm15520842f8f.32.2025.09.28.14.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 14:06:17 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: David Woodhouse <dwmw2@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	linux-mtd@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] jffs2: Fix spelling mistake "Synching" -> "Syncing"
Date: Sun, 28 Sep 2025 22:05:28 +0100
Message-ID: <20250928210528.243027-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a jffs2_dbg message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/jffs2/gc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jffs2/gc.c b/fs/jffs2/gc.c
index 1b833bbffcf5..116567899e23 100644
--- a/fs/jffs2/gc.c
+++ b/fs/jffs2/gc.c
@@ -83,7 +83,7 @@ static struct jffs2_eraseblock *jffs2_find_gc_block(struct jffs2_sb_info *c)
 		nextlist = &c->erasable_list;
 	} else if (!list_empty(&c->erasable_pending_wbuf_list)) {
 		/* There are blocks are waiting for the wbuf sync */
-		jffs2_dbg(1, "Synching wbuf in order to reuse erasable_pending_wbuf_list blocks\n");
+		jffs2_dbg(1, "Syncing wbuf in order to reuse erasable_pending_wbuf_list blocks\n");
 		spin_unlock(&c->erase_completion_lock);
 		jffs2_flush_wbuf_pad(c);
 		spin_lock(&c->erase_completion_lock);
-- 
2.51.0


