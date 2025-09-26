Return-Path: <linux-kernel+bounces-833614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02760BA26B6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 07:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E7822A4916
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 05:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB95277C96;
	Fri, 26 Sep 2025 05:14:34 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C82266EE7
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 05:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758863673; cv=none; b=k9L0EZyMQOGCEuJihJwgS+9yW2EAZLBY84vTQ9WMB+YPQ0B9CMfPeaIaNoivfEiqwxqHWP94RFUirnp+yBBSD6Nm138W9+aeAISMF/yumq+LkZXXPbZTfc8ZfSC1V7jXRpiJ3fwhmeMLJxg41FoRGmG9WybsDySAT/PhwCZFaps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758863673; c=relaxed/simple;
	bh=lC761gkFpOQdcOGlWNPdTnK0sldm5KiE8/0aVMwxt04=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=bqkDpNmEsUjmHb+/z4xVDPKEVkXw/AQ9205Ro7HFchcO4r7EQxgXrtD6uBCZbXW/SIYnaaJ34J/GRiom5rOhEsu31cPJeoLHENnlpxm0NdOy2tpQHyawV3trZYn9voRODgSqkBztxZIECKn55UbIghHTHZkHAP0fOK+PkF7InRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-42570afa5d2so48157365ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 22:14:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758863671; x=1759468471;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DG8Duv53QLwynlPB4debmWfpydCbn0S0pF1aGiZ5NhQ=;
        b=lCGFd3ysG4/vmKa2UPbyj8uB828bCMCzRvZBOKWolAHXCdV4fXeyEouB/6wZERUtfm
         XThBQEhBjQzVAg8ZqqaYaXK8GQhr5j71Gr5DSX8ytdOjVFsPjV++t3aooW1Q48TlO8S5
         tXcZbClrvGakRZ1+ufkfUEpm6LcpmurMMAYQ2Kbr8qdnvzdn7C8L7LCXvcOjoww9eiE8
         rPstNFjUILpLQmRPtBz6qi+4nuPQ238LH9AchuHsx4d9G3byXQFp9dhzWJpa0u3wBiUe
         BipRw51y09KuVY6SbOUy9MlLiFf+4fRxcGPV2MfZk9TNv01dvc1IStdxYw3NCUwpwhUD
         GcfA==
X-Forwarded-Encrypted: i=1; AJvYcCXugGYBl10NGxfBBlv8bJ8qCLWGghYFLkSd1LxhEw/REWzvVMGUkjo4DWpKvaKy+ailknzqKbnmnvtUkuo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZqg2Dy8zY9VwyJZsm76ShHDdA8sdJNrnO688L33eQNOJ6TXip
	SO40V63AUM8R/fcoqbRIkvlh7iSmjR6a0jsWs4lMbhhFoRvqjD5B3LJkFnCz2UZtNXI68zcJthB
	vULjEvWj9gycnwiaoNYHpHHrciH30wpNwJqEvGsS49joURGP901c03KyLwxI=
X-Google-Smtp-Source: AGHT+IELGfhN0y0KKDaSMd9rjqVPYY0bokUyRgxktBIKZ0Q8NPzeQeOSQfb4BnmJZFw6DCMeYez/tARdzr75t5UHET0GkAIjTV5A
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1609:b0:424:7f5a:9423 with SMTP id
 e9e14a558f8ab-4259562f38amr85226455ab.19.1758863671182; Thu, 25 Sep 2025
 22:14:31 -0700 (PDT)
Date: Thu, 25 Sep 2025 22:14:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d62137.050a0220.3390a8.0007.GAE@google.com>
Subject: [syzbot] Monthly hfs report (Sep 2025)
From: syzbot <syzbot+listc1009fe7bea3a4e7174c@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello hfs maintainers/developers,

This is a 31-day syzbot report for the hfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/hfs

During the period, 0 new issues were detected and 0 were fixed.
In total, 41 issues are still open and 25 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  13773   Yes   possible deadlock in hfsplus_get_block
                   https://syzkaller.appspot.com/bug?extid=b7ef7c0c8d8098686ae2
<2>  10556   Yes   KMSAN: uninit-value in hfsplus_cat_case_cmp_key
                   https://syzkaller.appspot.com/bug?extid=50d8672fea106e5387bb
<3>  5157    Yes   possible deadlock in hfs_find_init (2)
                   https://syzkaller.appspot.com/bug?extid=e390d66dda462b51fde1
<4>  4862    Yes   KMSAN: uninit-value in hfsplus_delete_cat
                   https://syzkaller.appspot.com/bug?extid=fdedff847a0e5e84c39f
<5>  4680    Yes   KMSAN: uninit-value in hfsplus_attr_bin_cmp_key
                   https://syzkaller.appspot.com/bug?extid=c6d8e1bffb0970780d5c
<6>  4208    Yes   KMSAN: uninit-value in hfs_find_set_zero_bits
                   https://syzkaller.appspot.com/bug?extid=773fa9d79b29bd8b6831
<7>  3496    Yes   KASAN: slab-out-of-bounds Read in hfsplus_uni2asc
                   https://syzkaller.appspot.com/bug?extid=076d963e115823c4b9be
<8>  3491    Yes   WARNING in hfs_bnode_create
                   https://syzkaller.appspot.com/bug?extid=a19ca73b21fe8bc69101
<9>  3140    Yes   KMSAN: uninit-value in hfsplus_lookup
                   https://syzkaller.appspot.com/bug?extid=91db973302e7b18c7653
<10> 2635    Yes   possible deadlock in hfs_extend_file (3)
                   https://syzkaller.appspot.com/bug?extid=2a62f58f1a4951a549bb

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

