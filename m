Return-Path: <linux-kernel+bounces-816185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 838A7B570AF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 08:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 423014E165A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 06:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653562C08AF;
	Mon, 15 Sep 2025 06:54:29 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830A22C028B
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 06:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757919269; cv=none; b=ijBIhRTRpS5jno1k/Kau0GkCcY8rmckSzdXHDXZaSm8QX8q7EdAci1q77jtS5uyCDcm8x9oNHF6/IsOAmjDQp7DWlUkiUp4NQ7eS686w+ZMLwc3qD7ZuHbKvm/Nc0z8xn1yp+pNCkT53mkTMcgsLCzQ2Dp14GIbPHtbh4R5FFa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757919269; c=relaxed/simple;
	bh=7n0PCz1Mxe3myhk0Zddp4QenuZm2D3TFsysrjfzJjvA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=mfk9hPWbDN3nRdGXJ7gstBmkBvbvt2bVHBFuxfTTfloE+nMGFVuhZncecLpaEq1ps1GrpYQTae6Rnbnd6Pq3fefg2xuVQWRlbgBo1eyEZu/V8faYf3P/aPViKOl4dGPp+ERxGfUoAIqk5VD0J0T2G+gRSZBISJCZ4kmym+nZ65A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-42404e7bc94so21614745ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 23:54:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757919266; x=1758524066;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wP9FzrGSo7Vh+PQL9BOeaS4VAZ4FDREP6aI0hmCyut4=;
        b=dlzlXO4afnpEzkaCdNeNOurdZiEOdLpsalSJqiWMY6RWef1N6leabusc0OcHHIWdY6
         GVtvatiiRpK94jXucBryQYvH5GGaeqAkwGRV3Qt7E3UoN/JmwWJ4Vap0nndkeHldJhzY
         jc/7cq+g0ENQG+C+/nFcPntlGK5cXsty0NYGgP0N2L+cwHlqtBHnHnjtLHnXTOovQNM6
         jTsQcALPuNDHZhHXjHtiRdVenrP0spzKc/+trY/skZe4ehtwMzF95uST2j6eoa5+mZQL
         Lyue9X7gOK57x9VBDn1xEELqkUFWBGuGg73QOiFEQ68IbjiqsMVX5rS5xR8kiN84O1TN
         P1gQ==
X-Gm-Message-State: AOJu0YwFU9kn//yZy6lTS/OcqdOuvW2Od8w/cUwqK7Xxz8sBQUBOmdw+
	k9WAErHq1PV/InfpHa+wuj6IhYgsTJHy+gE838ZwaAUKZRi1+yAvb1kDCynnXAJYGIYW07Q74Z0
	tabPrlw70QoQ5D0HVrlEFWbx1jxg4uyY7Scat3chT8aUf6JwgalL57k/pVic=
X-Google-Smtp-Source: AGHT+IEWOslQcy1qrcT6epS03VdCcVjy3YGkMaj7PjsQjBuB1TotQWPUvyfVPETvtkdErYAVOukNSfaysxNlSaLLePhlJIRtVhvp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13d3:b0:423:fabc:67d1 with SMTP id
 e9e14a558f8ab-423fabc6833mr35274165ab.19.1757919266741; Sun, 14 Sep 2025
 23:54:26 -0700 (PDT)
Date: Sun, 14 Sep 2025 23:54:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c7b822.050a0220.2ff435.038d.GAE@google.com>
Subject: [syzbot] Monthly mm report (Sep 2025)
From: syzbot <syzbot+list477ead9e37a715bd2178@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello mm maintainers/developers,

This is a 31-day syzbot report for the mm subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/mm

During the period, 7 new issues were detected and 2 were fixed.
In total, 117 issues are still open and 340 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  7424    Yes   WARNING in ext4_dirty_folio
                   https://syzkaller.appspot.com/bug?extid=ecab51a4a5b9f26eeaa1
<2>  5478    Yes   WARNING in v9fs_fid_get_acl
                   https://syzkaller.appspot.com/bug?extid=a83dc51a78f0f4cf20da
<3>  3643    Yes   INFO: task hung in page_cache_ra_unbounded (2)
                   https://syzkaller.appspot.com/bug?extid=265e1cae90f8fa08f14d
<4>  2919    Yes   possible deadlock in filemap_fault
                   https://syzkaller.appspot.com/bug?extid=7736960b837908f3a81d
<5>  822     Yes   WARNING in trace_suspend_resume
                   https://syzkaller.appspot.com/bug?extid=99d4fec338b62b703891
<6>  708     No    KCSAN: data-race in __filemap_remove_folio / folio_mapping (2)
                   https://syzkaller.appspot.com/bug?extid=606f94dfeaaa45124c90
<7>  580     Yes   INFO: task hung in _vm_unmap_aliases (3)
                   https://syzkaller.appspot.com/bug?extid=fe8f8efd070d727de971
<8>  556     Yes   INFO: rcu detected stall in addrconf_rs_timer (6)
                   https://syzkaller.appspot.com/bug?extid=fecf8bd19c1f78edb255
<9>  464     Yes   kernel BUG in filemap_unaccount_folio
                   https://syzkaller.appspot.com/bug?extid=17a207d226b8a5fb0fd9
<10> 457     Yes   INFO: rcu detected stall in sys_newfstatat (4)
                   https://syzkaller.appspot.com/bug?extid=1c02a56102605204445c

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

