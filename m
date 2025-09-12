Return-Path: <linux-kernel+bounces-814034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2474B54E71
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7453A485164
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70C63054E3;
	Fri, 12 Sep 2025 12:50:32 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0544D3019C5
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 12:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757681432; cv=none; b=ABdBkwq9wu5rhKxDC4nSPnhUS8JelEXU97EfjXsn1awP6ra812QTVwuko0pKBZiAtp25eD0VBGnNXIKbvcXDAc64r6xcKQeg3JkLoq81Y6x0hCKP4S6xQDMav3VVEsHhPofe9p3RiS551nRd6535QkJBPuF/+c4VtB+Oo+GuKVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757681432; c=relaxed/simple;
	bh=WaupZNManUqNcqnsFHmxD7OEwZG42QqbQmAYHworjNU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Be4Ql8d7kzpWXAmR+mUOvsrgEfM/OUx6+VINf34zDjxyV2E1tmkux0DR241CkoyVETFQb9tryFt90JBE6OoJ5+X/P+jftl/eT3ayc8H6CLzp7JW3cqG8/u9XPKz/aJRc6v6CKFMgIB4oUPGXtxY5Ey1pUwNmEzLwLfK8gd/vpgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3f6f0058e9aso55427965ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 05:50:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757681430; x=1758286230;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CrYY5yU99KJVXopcDS+1qbxSnA+64IIqInr0fnqZVEY=;
        b=cw5C9NsnouBJehZ/kS9mUqBl8eLEliR3yMbyQ8TebRMJcpl/DZBZk2q9bBelTif1Ei
         8TlyLRxuXoK8Guf7gUazBSIyG/gF3rF6kC49hobmSJwqHdyy2IS/Blf60VoeHgQ0RU+n
         BN4CqS6upV+tc8qWt9WlkMw3+46yGSs23LvENKMn4bSHxctfPbHuz99G7TtggZtwqKH9
         5SgmS56jWjb0FTxFbcYvJEDVbwa0NALTpjfRUV48tNZydIQI31T9bcFG6H7bk6nN28VF
         0X3U7NUw8HRXYvil6kmteWkxra2JDDpp2JqIa0dGLVBNapoD9YUyRrNjHntFQIrNsjiz
         6WOA==
X-Forwarded-Encrypted: i=1; AJvYcCUHeVRQe755zTvsdZHToZWUg+4oA6Cz/ag6jWOkh14hJsHzx+7PYtKd+/7pPcuRFRWVToOreifAmdXAYt0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGwfXjH4O32BH4s4xy4smH1SLagetWmcoSGjIRkzRinBnqXh2o
	rbSJM1CDHapJUprsiIKfmO3qTwU6Un/o4GNqnmArCVk1CdM9UZLgd6idVzzWyf37p3Z+4lgdOc9
	md+CIe4uVKyEtMvmNp9b8cXmEMe7UG4UzzmKTsXUBaMOV+i17k524qUABgp8=
X-Google-Smtp-Source: AGHT+IE2qh/2GCKU6BVMPASYLvG4vM/fF0wwnb1ckwYJaxtlUMlxDLBY9UK3FlpTNIcvXMVA0c4lcaUF0EG+xP5Jtax8fQlP9i6w
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19ce:b0:416:75eb:265e with SMTP id
 e9e14a558f8ab-420a4ee1eb0mr45949005ab.23.1757681430239; Fri, 12 Sep 2025
 05:50:30 -0700 (PDT)
Date: Fri, 12 Sep 2025 05:50:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c41716.050a0220.2ff435.035d.GAE@google.com>
Subject: [syzbot] Monthly crypto report (Sep 2025)
From: syzbot <syzbot+listfbe8ca840699475b61f2@syzkaller.appspotmail.com>
To: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello crypto maintainers/developers,

This is a 31-day syzbot report for the crypto subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/crypto

During the period, 0 new issues were detected and 0 were fixed.
In total, 4 issues are still open and 110 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 271     Yes   possible deadlock in padata_do_serial
                  https://syzkaller.appspot.com/bug?extid=bd936ccd4339cea66e6b
<2> 18      No    KMSAN: uninit-value in sw842_decompress (2)
                  https://syzkaller.appspot.com/bug?extid=8f77ff6144a73f0cf71b
<3> 7       Yes   KASAN: slab-out-of-bounds Read in xlog_cksum
                  https://syzkaller.appspot.com/bug?extid=9f6d080dece587cfdd4c

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

