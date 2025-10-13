Return-Path: <linux-kernel+bounces-850608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED507BD3477
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 15:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 913AA3C6570
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 13:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3B7226CFE;
	Mon, 13 Oct 2025 13:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="io1hlNIi"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740B822759C
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 13:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760363249; cv=none; b=loLU3hlrDvGxWhH2BlQqdeEVbaa9ZSo5SwWV18+X+lduj79sPi1SRUD/gch2+rvFx0T6lScRnYj93Tmq7HqCFd27Rh6WXjHY4YPrHkb0oY27QAYAoXHmSypl6Ya80VXNt9Vl1Q0AV25RpTdC0BpyIwAHkACqSQ1YGA5TqPGWrRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760363249; c=relaxed/simple;
	bh=Swp4+xHTqvgYr+z64DMuU57MVlL3j0v8jDSlSv8/1Rs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=amHPzRm1S+EyFIqB2v7+deHGLiC4sBKLXE4BuxYaMTh36+TyWyhjqP0UFzhxFnzGKVtNc6yqK7xtF1diNlWGoupMWAfegDU7iJ4fupQCXj1lsnfOtBOENkz0DpQkGBc0PQxJ3mNCmbkBGv8J4ksQWVbVc5nx9AVZleDXPx9fd4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=io1hlNIi; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3307de086d8so3482151a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 06:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760363247; x=1760968047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=teOPnCrlstkFyH9+vuIz1dE4A6eVshfJueJ5oAZ3QHs=;
        b=io1hlNIiVqXlc1wjOO1Rak6dG0PCmd87m6yKf7aSc0mEZV0nxR+OmHBUv4xbgPmchU
         UT+ohTXQGkOWgu7RQUvjFsuw3jx95XXtFJj20VylppMWy9L9VAsDDkBiNpYVMusvyQ3o
         5wjdI0ZxwK366brx/sQD+9O8TEEWQm7k3m7aFlh6Nc3UJ0aqRWHBeoXzgROm4kJ/VXaI
         3pp5GEfkHcyzG+rdmiiYdmYN4N9F+SvKTQaUK/x/f4/7Fajd7S3IkP6Zi9AcdDIoz+tV
         1+5p1fKcdPVgXYtm6+w3qn6va/Hm+qiv9MFZnQXvkRaD0TGc+zOt81ZvR423VgKgR1Xu
         jzOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760363247; x=1760968047;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=teOPnCrlstkFyH9+vuIz1dE4A6eVshfJueJ5oAZ3QHs=;
        b=omvkktvFpMqRAUR+YTqEfaK5nVUgzdtpWHg8zN4qdsk29IfU6g/RhLQ7G6WE2Ce/6k
         orwpjdRgT2hmU3iWAz6zUBfv17wEnAIDG4gzTZzqfY/RoE2UZlOgsETKSZBAEbKUnpcC
         DH5XYCIVUUv2EUxn0EUluuSwKtlZxhqB4fUzPNNm7i4D25LZHIYe0Zb7H9EB6QbP7Mb0
         k+YgEYy9QxRw7ihZCPFjXbzH6ZiOB+gmi0yr4VHmaYNCB6HE0p1MZAvmJkqJnY6vjHqu
         ZP5H8kNR+dnaumVMczGjznHrxnqyouw4zvPSyf52K3ZM4anxpmjQc4sbjaadQAYrMS0C
         kZSw==
X-Forwarded-Encrypted: i=1; AJvYcCW7d7gwhIjBrRzSuKVMV0aU1kcOLi3oTCTR1lW9CdYR8JH/wUd+XJZU/jOQclmyWjWdOxtq+sXx9EA7x/I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt3LYVxdWuhRxfsGDdO3L4iLJxgYKP52tT1VyE9Fu8/oYgIejK
	KUY6S+leBEqXcYXoODrCR9EEh6jUlgRa6/DN8NWnaUbOLpV6AFfVVugN
X-Gm-Gg: ASbGncvJg9qTUpfbwK5IeYTFVPTkvn5/yVDDLNrGvDV2WZDtN8apaeKbjh3HhuFjC9n
	3VUgLJMnW21MszxZxGM9DCE/X+8gd8U8ReLeXkkS/92HtyHqsEMh2ZNZzSXiT6TPcaUSHfVm3aC
	Q22jnqDDBNJDQ6luNw28tjKZckrePKa5dnDHevoTWOuMkg0had8f6qHik0XwAMZL9SU1gdq3i1C
	duoq1s++ngaWhAg1VrRmpCrkaKWB4lM4pBmWdFo7h1szA7fR7iMpt/aPP64t0TECNaVBDAeKggG
	RtUD8HBmxPQJMX7I3ZD24qFx140z/pG011dpzH3KUfHWDupumNB0V065AOB8PBqxWFg5RXuL8gK
	akauj9fxPdzUEY+3S4v1N2NhBBlFBF9NFeHQJQafKYMSwxhgwtvVgvgCsMgQzLzmyZn7D
X-Google-Smtp-Source: AGHT+IFD9xM53HQ+bQQDPEQgAUdL3IwH91zz8prxo1co6ZEPN18n39S7OZmUBWp8Eqf4/zWeSLysJQ==
X-Received: by 2002:a17:90b:1d06:b0:32e:2c90:99a with SMTP id 98e67ed59e1d1-33b513b4b51mr31706554a91.35.1760363246720;
        Mon, 13 Oct 2025 06:47:26 -0700 (PDT)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b626d61aasm12295067a91.17.2025.10.13.06.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 06:47:26 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>
Cc: Yuezhang Mo <yuezhang.mo@sony.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	pali@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+98cc76a76de46b3714d4@syzkaller.appspotmail.com,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH v3] exfat: fix out-of-bounds in exfat_nls_to_ucs2()
Date: Mon, 13 Oct 2025 22:47:08 +0900
Message-Id: <20251013134708.1270704-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the len argument value passed to exfat_ioctl_set_volume_label()
from exfat_nls_to_utf16() is passed 1 too large, an out-of-bounds read
occurs when dereferencing p_cstring in exfat_nls_to_ucs2() later.

And because of the NLS_NAME_OVERLEN macro, another error occurs when
creating a file with a period at the end using utf8 and other iocharsets,
so the NLS_NAME_OVERLEN macro should be removed and the len argument value
should be passed as FSLABEL_MAX - 1.

Cc: <stable@vger.kernel.org>
Reported-by: syzbot+98cc76a76de46b3714d4@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=98cc76a76de46b3714d4
Fixes: 370e812b3ec1 ("exfat: add nls operations")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 fs/exfat/file.c | 2 +-
 fs/exfat/nls.c  | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index f246cf439588..7ce0fb6f2564 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -521,7 +521,7 @@ static int exfat_ioctl_set_volume_label(struct super_block *sb,
 
 	memset(&uniname, 0, sizeof(uniname));
 	if (label[0]) {
-		ret = exfat_nls_to_utf16(sb, label, FSLABEL_MAX,
+		ret = exfat_nls_to_utf16(sb, label, FSLABEL_MAX - 1,
 					 &uniname, &lossy);
 		if (ret < 0)
 			return ret;
diff --git a/fs/exfat/nls.c b/fs/exfat/nls.c
index 8243d94ceaf4..57db08a5271c 100644
--- a/fs/exfat/nls.c
+++ b/fs/exfat/nls.c
@@ -616,9 +616,6 @@ static int exfat_nls_to_ucs2(struct super_block *sb,
 		unilen++;
 	}
 
-	if (p_cstring[i] != '\0')
-		lossy |= NLS_NAME_OVERLEN;
-
 	*uniname = '\0';
 	p_uniname->name_len = unilen;
 	p_uniname->name_hash = exfat_calc_chksum16(upname, unilen << 1, 0,
--

