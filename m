Return-Path: <linux-kernel+bounces-882481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 692FDC2A912
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 09:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AE003A840B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 08:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E35F2DC33F;
	Mon,  3 Nov 2025 08:24:00 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AEB2DC33B
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 08:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762158239; cv=none; b=MLU5HG2A+rrLqS8NlIH/hnfEGZYyhlZZcKO4GPFj29rG8mfE8LPs0O4iFTN4V6cND4eRUxaSSPBfTMo9tAaUiW15wa+uI5jun06g1oIORs+WgaaaockRERUtbs9qUpy+MJCmx3ftsQ7fc6bGWNoiSHeQzMjuCHotlWircTp3QfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762158239; c=relaxed/simple;
	bh=S/DTc/O6rMhMH6zAzV0ay+G2IMZ8KQmdwqkOUmY0+FQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uMduHSH254KOYW6l1TjIU2TsoMnmWANx8Iqijk9oupouZyv8ngBm8SeZWIL4kibp2KGKaldC4lR7HWKIS+nKaetUiMbQYmXlbbFsekIMcADg1ZVpmM+Flb35rqnDYgPAofkaLX3dKcwhKY+zHGiD6dUmiGPoe9YRUHK/y1UDU8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-4333035774fso6472185ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 00:23:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762158237; x=1762763037;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=++IReHIa7IiNwxKIKgozoAKwB3QVw95sQFg+MidWDL4=;
        b=pbrxazgm8/+yKVTRaGPxky9nwyzD8kft62ZbsDdUL1tlorEHZZpOzPgEhjY1JZC273
         ubk8PvPqyjl2mERyQ3jiFgIb0GHFzExjwOgx/cheIQsDncoMQZ/wgw6wrhKbLJVXol4c
         htqQlogO3UXJY5E7azDYE7nCACD24xi2akDGRvE1e38vaug6nHW917xiehryA7y0yY7V
         BzHOQJOengauRES2GT+f8Qk6BEXUzUGOd7pAMKlcLOqvni5BrA4LzXonh2hH9PaNMt/5
         w9VtSigM4Wj5fhkTHR0MXkGxPzpOmgBYlg1ozYZiEOUani6QFBCpszjIKHfph3p2rZmR
         7pxQ==
X-Gm-Message-State: AOJu0Yx29Cq6ZVUTRevbzdI2e20lR6NMl94B9SxuEk5zIfVHBJcOq85j
	C4h+5WUneJ7bWoUFKCl+/yT7QykFDgL2hetlAxny/dC5FLBzqEfUp50fKsx2UadulQGu9MxKhnK
	2Sx4j6eFBDO6nyrFRVVbfxRNtBFPO0Uig7tnNMGlNcujsv0wrU7lj9R9F20c=
X-Google-Smtp-Source: AGHT+IGumfiUd1MUWl5RGKrdWz71+mjqfdxg2cIQa5TXWkwOXR7I1y8m81BvpOrno4u5u/u9H4Tr4ZqR9zuHeiJaz8FH/6Z8w6Gb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a2e:b0:433:330a:a572 with SMTP id
 e9e14a558f8ab-433330aa64dmr14238865ab.13.1762158237513; Mon, 03 Nov 2025
 00:23:57 -0800 (PST)
Date: Mon, 03 Nov 2025 00:23:57 -0800
In-Reply-To: <6903e7f7.050a0220.3344a1.044c.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6908669d.050a0220.29fc44.0037.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [ext4?] WARNING in ext4_xattr_inode_update_ref
 (2)
From: syzbot <syzbot+76916a45d2294b551fd9@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [ext4?] WARNING in ext4_xattr_inode_update_ref (2)
Author: lizhi.xu@windriver.com

#syz test

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index ce7253b3f549..5f535d45111b 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1040,6 +1040,13 @@ static int ext4_xattr_inode_update_ref(handle_t *handle, struct inode *ea_inode,
 		ret = -EFSCORRUPTED;
 		goto out;
 	}
+	if (overflows_type(ref_count + ref_change, u64)) {
+		ext4_error_inode(ea_inode, __func__, __LINE__, 0,
+			"EA inode %lu ref overflows: ref_count=%lld ref_change=%d",
+			ea_inode->i_ino, ref_count, ref_change);
+		ret = -EFSCORRUPTED;
+		goto out;
+	}
 	ref_count += ref_change;
 	ext4_xattr_inode_set_ref(ea_inode, ref_count);
 

