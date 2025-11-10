Return-Path: <linux-kernel+bounces-892788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 30810C45D3A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C0F2F4EE72E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6C42FFFA8;
	Mon, 10 Nov 2025 10:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G45l4+an"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101C51DF72C
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 10:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762769111; cv=none; b=mk8zjQIdXFr3hbff7OrsGnju5yhbdBusye4AvfEVBNFA0TqSBeIFveFMsSLZ5q6q1sL/PddPNXVOUG7z76Z4ixKSyOVa7KqN/b3emN51+F2Xhubj4Hqxqi6tqTOt6EGBKorKsmVok9JF1cXB5LXcQko0SbmN3HYWRJx5+XwfOWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762769111; c=relaxed/simple;
	bh=hlkiH7RyJZpDhhRpZroaibQT/g2tEON32/xBcmeW52M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J3mkyborIAN8iuuBJyEX2VrZvrxKgOjUFLDzDKWvPmkxjtaIFylsRdRQYMsr0DBdmtRaot5dmvJRXPIg/dy3/rDjnebsXzF9/wfZafwi0NvEXvtzSkb9zARikgue1KsWDiUz3Z6HCiOg4QL51xvaL4s4ZWrmBoRuqwmWqAYJv1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G45l4+an; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-63c489f1e6cso4200061a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 02:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762769108; x=1763373908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bBm2zMuY+Afri40UzI7562MktkLPVD9d+ncsYP0UEPA=;
        b=G45l4+anS+FNBQ5+lj/zJAJU9RX674TtQ8/W9LKerFj15INmW9PB4tLtwV6jzJQh/B
         2lBa1XQsxgVY4PvyEMX+xFf04inOzN3EqIsKSpahAkXXzoHCIovpkI/fh85QyTPJ5JEJ
         NkvzGygyhvWXlPiKoRyp9nOpD3XQEyyYPAsJTFple1ZdLHsTqdjjEfWGHuHYpr6ymrxF
         wDjrIA24C0cLOMZJuECdcc0YkdU1rxPI1RVCOK2LZbRlVfQfrQgRs4N3/EQ6ufJ15cSP
         ffjdKV8TLWvqNnR46JgJhk0qjiLdH2AdmzD5xC5znR/fnFoBFSHHqkHiId93F9ZIHLig
         PRuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762769108; x=1763373908;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bBm2zMuY+Afri40UzI7562MktkLPVD9d+ncsYP0UEPA=;
        b=SWozRLaC32EYTjG7ORkZj8mRTsQYLbb2/dIwHZFenWs6hJxIVpeuoDK0IW35FRRssP
         jeiTF9r8574w3R2TrK5GyB3ExU9//d3U56e1Q4AqmXFZ7yVfroFQbI/4NB4Wde6yGWq4
         TNR4xE2pgbq1y4G578CO2CxtTf8CSxtfja+D7LDY8ZQ6HHz0FWgCIwFESg2dBUKow2iR
         8thPYK+TkPNmloFkZuj910+rH3eny0EXo3CeF/cyL2KxuoednqgyhYYCo4Z4nWGCGy0L
         dC4r4Li/vlihuha/RjYZoh73VKXx2WeFdvbZaS6uodYGcUgyChaIVZxLMhYIbZ7TXYl1
         kpOg==
X-Forwarded-Encrypted: i=1; AJvYcCVeSIhWBrZJCToaVtPXWBE8EOu0bkHZgH8pylXvkONiRgPS/v60WIp5TCQ1/HVD0iOjoj1zyTVhlG4vBio=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUulfk1VvVqTNGEOlxebF55POW8AEI4J0ffkxTAPzuEom5uA21
	dBqiXKy23oquiAgM4nfLRFO+S5nNLM0ENVxQ83iIo+C+AnS6kdCLKv6m
X-Gm-Gg: ASbGnct2UZ5EOnNYuVxUXgL7830n6yKoth66a7XkRW5yQyebsfUloTyXOEaDa/VxJNN
	iYcUsWVSS42Z61sbxzmmk202egVPyAGpL1zFtB36vxUCiiy6F08c9qEOu1oOPD7C6kkinpAwREo
	Sa3UEs6PvJa70iAUTPtT1BFl+Pu4y9CGzLNYu6I1kP3rBEI5qX0uOO/ZPqycD6F42Qgy1M5xCV2
	4mrbDKIPz/ug65tcb/JsxItZg9ZKI5Q3hKYkxqAqzoe49Ia5WVrFIoQ2GDUYgDdtm0/JYcDJPBG
	38bVHdwC0DoIF6/ZqJkJjze9+yIlV2XOYuoiZzgFrliuP7dkDC/tU+nVneWS1zrVnouA/EPv56S
	N1Wo0sWcE48lVzMgLyZ8IgI4cWj9Xp4CvaycJR0xnVGPoy/g+YXD5WzIhiBZd2cVauEgMIvlEtf
	hDOBplMm3hPB+tSbDzyiWT8teGNNwvLT3zB2CiQiPrOalGENI/xaFQdxUrIGacPWWU7O9qJA==
X-Google-Smtp-Source: AGHT+IFA08IWh5LeHbv095pwRvXx72RbGGyIYXDu9W0o2t0+2HmaJ1eQjqspJUpdqGf6YjPghZ6n+g==
X-Received: by 2002:a05:6402:2711:b0:634:11d7:f70c with SMTP id 4fb4d7f45d1cf-64159b5afe6mr6141872a12.2.1762769108052;
        Mon, 10 Nov 2025 02:05:08 -0800 (PST)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6416001a4a8sm6054882a12.15.2025.11.10.02.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 02:05:07 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: viro@zeniv.linux.org.uk
Cc: brauner@kernel.org,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2] fs: avoid calls to legitimize_links() if possible
Date: Mon, 10 Nov 2025 11:05:03 +0100
Message-ID: <20251110100503.1434167-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The routine is always called towards the end of lookup.

According to bpftrace on my boxen and boxen of people I asked, the depth
count is almost always 0, thus the call can be avoided in the common case.

one-liner:
bpftrace -e 'kprobe:legitimize_links { @[((struct nameidata *)arg0)->depth] = count(); }'

sample results from few minutes of tracing:
@[1]: 59
@[0]: 147236

@[2]: 1
@[1]: 12087
@[0]: 5926235

And of course the venerable kernel build:
@[1]: 3563
@[0]: 6625425

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

v2:
- drop 'noinline'
- spell out the check at call sites

verified no change in asm

 fs/namei.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 2a112b2c0951..0de0344a2ab2 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -882,7 +882,7 @@ static bool try_to_unlazy(struct nameidata *nd)
 
 	BUG_ON(!(nd->flags & LOOKUP_RCU));
 
-	if (unlikely(!legitimize_links(nd)))
+	if (unlikely(nd->depth && !legitimize_links(nd)))
 		goto out1;
 	if (unlikely(!legitimize_path(nd, &nd->path, nd->seq)))
 		goto out;
@@ -917,7 +917,7 @@ static bool try_to_unlazy_next(struct nameidata *nd, struct dentry *dentry)
 	int res;
 	BUG_ON(!(nd->flags & LOOKUP_RCU));
 
-	if (unlikely(!legitimize_links(nd)))
+	if (unlikely(nd->depth && !legitimize_links(nd)))
 		goto out2;
 	res = __legitimize_mnt(nd->path.mnt, nd->m_seq);
 	if (unlikely(res)) {
-- 
2.48.1


