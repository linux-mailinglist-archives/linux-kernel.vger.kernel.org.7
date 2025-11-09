Return-Path: <linux-kernel+bounces-892103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDCCC44538
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 19:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CE211889EA7
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 18:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B365422FF22;
	Sun,  9 Nov 2025 18:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CAIdjjVC"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A6521FF26
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 18:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762714473; cv=none; b=W+qT8qE4GN8BjzF5Xw9sFbpD0zfx9NJYpUgzo2w5mZa5iMziKLtYMC3QWDaO7LLIb2ph0jJIejBOW1Xidy043ID1u0JNen8otIF38Kk/8dbEgscDkWewIeS6aIqfZAlV4yS56gXVjtIFxIs36npVp6ifJucqhjFAHAbYylsP+/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762714473; c=relaxed/simple;
	bh=J3Eapg6FSMiLMLlHLu7Lcc7HuutFBLZ75dfOfkEO7O4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ABdCvxddgE+DbCSBSgzsrHxJSlxn03hRbg8LBJhjOzy+fTsco5v/dhtrsabMYhgmXdEV6f7UtGCYzlEjHseLeHBWEpENuaEwFa3GmriquYG/+/Yo5NdQcdp3byNykMuRfzOspUbCBTU7bG52Ly+pjnCSZsU8E2xovQUTdPftWyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CAIdjjVC; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6407e617ad4so3950398a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 10:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762714470; x=1763319270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8iwkTig1PIiP3eBZ+a+R9WXt8C51PQf0ZsMJF1LX55s=;
        b=CAIdjjVCcwCbfpSnMGxbBl0mu7lxqbl+fXAkirVoM88YIn+3HNuWAfwh4305rk4lQ4
         Eu8ehCbZz4j59bc97YY8VD28pyyka8ueeFp870yhXZmubPHPoJmwXObzDSKH/CKDkwnv
         P0BZ2DE70m6WxNAbraTFfWXu8DOr7yc9E64w5dZLEyk7021aPZnlhy3/tZ7mmw6MXk+q
         tWjEcxyKrQny6g+V2YWiO0QPnSc/3largxaQeoZh5qsQq6dfIKYKisHwqILQ/mTXHRgR
         UQ43uxWFfY7XhP+J8LL+gHQxNOicaWWAq79XvDOz4dchnhUdXjvd+vscqAckHrYO8LTg
         S15g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762714470; x=1763319270;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8iwkTig1PIiP3eBZ+a+R9WXt8C51PQf0ZsMJF1LX55s=;
        b=q+4+8kn8UWA3wkbnpKFK2+yvqEUKKNaoMKEZRaCFiC4VFlKMcRWfX/3RfT42AJ/mtI
         XyunVgbFIEFiTJRkBcqFFEQjFhdpyhrz71D1Hs6EcGGjCfp6Qw65Hg3QLTyJrrN6Bq7L
         n6QGtnly4kqz5G0U0yhDrVNEv0qqro5xoo3UGRzk30JbzN2FDFzbFTZ0NJyLHUrMidcl
         uV5qvyEXaoapW95RvLec9boo1kmVwAKPQLXO3gassBFXlBXBQYzzbKxd3AG0CrRcCjat
         nPr6IxbvZVlbslta4l+bpycQLC01qyxSOOwCQZLc/V8LQLQuF+6s7tMslo8IH03V2tvm
         qg0w==
X-Forwarded-Encrypted: i=1; AJvYcCXT5LAgOUlhaBw1nqnsUMhAsMP1Xzqrmanv+xHzoO43FTX/iJCD1OLeN7NQOavKTe6CBCAkQMyjVDz2Kl8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxps7JrNChznHLW5PImMcaIYrdO763IxuEQRHQPi6ZbpciJ5+mH
	UXntd6H01iNU3et9UUlEERmyJ4jzDl9brLkjws8DwKvuRJ976ckhHMe9
X-Gm-Gg: ASbGncsqjIq85XW6zqzSzzOjXWVIsXlXTLSuS7mSi2RMa45Y1GLY4aLX6eN0nWRtUww
	/8nEcgtPG9ME3oJ0qS0Zm+IziOg35xrzDJ2hgRaY8DjW0z+jv1CEy8SYZMyWMdO9a3BuVJOkZlE
	TED2c7kMnMViPqwjOI9QHNNQVr79W4EzdbqoLIP10v17HylHEXHYKrdxa4t/Fk9/D7XWFI1nxu8
	ZaGos/LGPKksU14JELFnE0xa1fDP6sQ9Kou0YO37MEt+b1G1oFriDXDJt8zyOZzQUmz3lI3cpz0
	L26mkt3bgoh05/YHu7eNRJ75j45IVe5+4P3+rNiKBzJou/8CitnnjTvnrWbnB2hmOGWTMN+Gn5t
	ORBn99l5FrDJCpPZdLrC0GwlMpklVLCQV9wQSt+2B8EHluI0RuyeTvxCeUUWHvlfafBrJDWwd/A
	jwROgxhPsfR+zQgGJNNuvFM5CaI0TGNqHPwKQD5ljR8LtdwUsC
X-Google-Smtp-Source: AGHT+IF8g57bavsXqBfVBq9Xek59IpECDQlYh6sOrl3meu/h5BHoAkoM+JOiNtZTqe5C2ySHS4M7rQ==
X-Received: by 2002:a05:6402:518e:b0:641:6b44:75de with SMTP id 4fb4d7f45d1cf-6416b4480aemr3311507a12.5.1762714469448;
        Sun, 09 Nov 2025 10:54:29 -0800 (PST)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f713a68sm9550382a12.2.2025.11.09.10.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 10:54:28 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] fs: avoid calls to legitimize_links() if possible
Date: Sun,  9 Nov 2025 19:54:09 +0100
Message-ID: <20251109185409.1330720-1-mjguzik@gmail.com>
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
 fs/namei.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 2a112b2c0951..d89937c2c0b2 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -826,7 +826,7 @@ static inline bool legitimize_path(struct nameidata *nd,
 	return __legitimize_path(path, seq, nd->m_seq);
 }
 
-static bool legitimize_links(struct nameidata *nd)
+static noinline bool legitimize_links(struct nameidata *nd)
 {
 	int i;
 	if (unlikely(nd->flags & LOOKUP_CACHED)) {
@@ -845,6 +845,11 @@ static bool legitimize_links(struct nameidata *nd)
 	return true;
 }
 
+static __always_inline bool need_legitimize_links(struct nameidata *nd)
+{
+	return nd->depth > 0;
+}
+
 static bool legitimize_root(struct nameidata *nd)
 {
 	/* Nothing to do if nd->root is zero or is managed by the VFS user. */
@@ -882,8 +887,10 @@ static bool try_to_unlazy(struct nameidata *nd)
 
 	BUG_ON(!(nd->flags & LOOKUP_RCU));
 
-	if (unlikely(!legitimize_links(nd)))
-		goto out1;
+	if (unlikely(need_legitimize_links(nd))) {
+		if (unlikely(!legitimize_links(nd)))
+			goto out1;
+	}
 	if (unlikely(!legitimize_path(nd, &nd->path, nd->seq)))
 		goto out;
 	if (unlikely(!legitimize_root(nd)))
@@ -917,8 +924,10 @@ static bool try_to_unlazy_next(struct nameidata *nd, struct dentry *dentry)
 	int res;
 	BUG_ON(!(nd->flags & LOOKUP_RCU));
 
-	if (unlikely(!legitimize_links(nd)))
-		goto out2;
+	if (unlikely(need_legitimize_links(nd))) {
+		if (unlikely(!legitimize_links(nd)))
+			goto out2;
+	}
 	res = __legitimize_mnt(nd->path.mnt, nd->m_seq);
 	if (unlikely(res)) {
 		if (res > 0)
-- 
2.48.1


