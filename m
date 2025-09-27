Return-Path: <linux-kernel+bounces-834814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E94D6BA594D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 07:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33B8816B5AB
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 05:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DDC230D1E;
	Sat, 27 Sep 2025 05:31:28 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5E522D785
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 05:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758951088; cv=none; b=R94cdkv31/PCkhupDaFC7weqUywFlHVXhtJRv4P8M41gQZHKx3lYQVn3V6iom0C48x645a7y/Hae0AjZYfMb9EVX4PuxlWeQxwtQMRqkLcCHuTjb7U29ND83485npLqsOiCoLBbe2q6EqagcR2WSzBQttig4DoGj4iLCI3epoBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758951088; c=relaxed/simple;
	bh=fXBasStR0YvzNi3/zlKF4ETowfRlGKbvHLdhK+kzfzk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UnUYWuEDXezuvuaQ9vciBMKdx1vkVJX3VVBrJtPq/vwQfgXTpJ11HbClvOu+/vuZtS0OBUUPVEYK/0A5AWsW1nxQsXcNI7b/t6Hk03ZiBXtsfrXYvypdnJrwy4VILmMtFLD7n0pTorJE7v+u6P1+MeFxUe/ma4xd+k80dmWV8vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-4284df6ceaaso19932155ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 22:31:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758951086; x=1759555886;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eN6OOFHSGB3d8o4/QsodOZBDtUtXieIEg6JEe9KrIm0=;
        b=r3eJWFbv0RrDH5XTpw8eVPq4dPNByhrljLS+LXW5UjsM+vWFwwi4w3tEa/er83OMLj
         0u70UMRVwaJcYxFAw+nvaMEZgrZD2hqGcuBC+scSfdA3UgUGhNVMYaroKp4tDYN/PaZ0
         BmjnK6VxxNrfupRmfnTZNcq/yraDnfKHqtyLps8z52NZYhVReaQ893OldrKS8LaHARAK
         MOKExKTam02CJ2omj2M1ppfHruqolhOXkK8SIB5en1D4os61Go65FTmF2vvzcr8om0dx
         5vtkd0C8ITXUUcqPdqApPKBjpvxGzIuthPgL1x0xEw7o5NwLRKU1oor5aa6fOgibjQCH
         1CJA==
X-Gm-Message-State: AOJu0YzJ7hpTs1RwCK6y2RYJeYMl/E9vCvukRP4acFr1oy0QMRN5maay
	svSOSvohUwy9ZUxeWht/D0X0erNv4ASo3LNgwyZkGXYulPOCIIH2yasSfP772qcE5Iid/23JUMj
	b/7wMbcgz/wUrI5TxqPhnqCYWGAnw+t3O6FxOrg6yrBeVpruuVcl16kCsS/c=
X-Google-Smtp-Source: AGHT+IHmtS0FQXqBsaEOU78WaSVyUyIuf1PdShKNTsfAhmDxGButxaGCf/aoppF3OYfouP4j/Mx6aKoKnUnoNxDnhoN0Wq5Z/+RQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a06:b0:427:d82b:1f36 with SMTP id
 e9e14a558f8ab-427d82b1ffemr55385555ab.32.1758951085968; Fri, 26 Sep 2025
 22:31:25 -0700 (PDT)
Date: Fri, 26 Sep 2025 22:31:25 -0700
In-Reply-To: <0000000000001c59010612fd7c60@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d776ad.a70a0220.10c4b.000a.GAE@google.com>
Subject: Forwarded: KMSAN: uninit-value in hfsplus_strcasecmp
From: syzbot <syzbot+e126b819d8187b282d44@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: KMSAN: uninit-value in hfsplus_strcasecmp
Author: rampxxxx@gmail.com

#syz test
---
fs/hfsplus/bfind.c | 2 +-
1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hfsplus/bfind.c b/fs/hfsplus/bfind.c
index 901e83d65d20..75f1c029c2ed 100644
--- a/fs/hfsplus/bfind.c
+++ b/fs/hfsplus/bfind.c
@@ -18,7 +18,7 @@ int hfs_find_init(struct hfs_btree *tree, struct
hfs_find_data *fd)

       fd->tree = tree;
       fd->bnode = NULL;
-       ptr = kmalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
+       ptr = kzalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
       if (!ptr)
               return -ENOMEM;
       fd->search_key = ptr;
--
2.50.1

