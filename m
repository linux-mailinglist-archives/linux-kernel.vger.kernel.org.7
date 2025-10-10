Return-Path: <linux-kernel+bounces-847871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F23D7BCBECF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 09:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A4271887045
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 07:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABCD2749E4;
	Fri, 10 Oct 2025 07:31:27 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B313023ED5B
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 07:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760081487; cv=none; b=DqT544xinmYZKgMGghhspdDSlLhaVe3me2Dw6YpHK2OygOURhx76sS0RUv6kL5z5x7TnmqFvDpz0gYwIOWiSrElknXmTjcjTbgEq6qPa1PGHqCMmC1EmdUR42T27pahoB8GCQ7vnk/vRGoYbWrK9NyQvG05ZsU2kWuQQm65rhWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760081487; c=relaxed/simple;
	bh=HgKyJhTChz4Rgep2XlmlHRxFOX/9CsLds63L1vhaxPw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Uj+SaMB4FWGhr8Wx/e75O5AiXnwvze6Y0R5U+ZFaz9Suwg10Gqu2QE3vJj9uO0u38pqQS4hV1hS4DUole2sZ+cuVyWoHA5RkIBaOK6rrdaCEGG7/Vt5ZDuqdFCkZgUgz4wfbm9Zdo5+JQdxftB1N0c8bvI1VVMbUiG1HzOQxyVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-42f81a589caso103862305ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 00:31:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760081485; x=1760686285;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IWjuIggXhlH2m7LaOstldhUWLsn8DgAp6qsRbFMAgFg=;
        b=WPlW5lJenDn1VeJFdy5we9gk6GhGXmIW+DmJ5sOEgHgf0u+nI9DeOuRmBXHlArhyzt
         1W4u2KDkoCjozY2nHLhjE7nvfX3D9wnjkTugzMRFJZ9bIgFzsaSl8p6HuAApOU8Ij22Q
         TTTqKG1pB9ap/csN8TS2oHL09Cy2wjAD9Z6aLJNf2bYY8HkO97QhP5E3K6OEBb2kYhVc
         ebZ18FBZQY2AyFoA+q1BDg3KwZDVrbAqEQn+AbgnRRc1P2PSU30fbVkzbyosnVtw3XOP
         YIrgu5cHE3Y11C3Zr+Y9dWKJF95OiIKBmn3G3hq7ucAXTWV1xZ7s8LfyR5/bF65+HSus
         BFDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJdIEPXfoNn3IF/1ZoaKioInAEwLX+XHSJxmTnuM7R8iZsJp95cFf0JosYJrhmoV9tnEIoTwzmNUDTEMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLcoQp51ozKpnKhX7/K+Pt0ToeSvOGpV7OlPHrf75jqTQQwWdX
	78QlybRCMjOLkThCjIJ7fTmaalfIWW299Fad+hC4i/VWqQsd09+SWuuNnFnGtZa9NH2BeH4eMYN
	G7jugf7KTLtm6St/HxXLobsrPu2JEaGXgeZ+E74cZlmYe4MYoiNP3d3931T0=
X-Google-Smtp-Source: AGHT+IHH0r7xDvLMFUPqNb76qZxXeVlenrqgH/tiFvWCpPDosZHwBvhmSOlnFlJt1RXHnBucdGD9kLikSjEjoCJMzERXXXdDjuhO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d8d:b0:42f:8d40:6c4b with SMTP id
 e9e14a558f8ab-42f8d40719dmr84874735ab.11.1760081484859; Fri, 10 Oct 2025
 00:31:24 -0700 (PDT)
Date: Fri, 10 Oct 2025 00:31:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e8b64c.050a0220.91a22.0135.GAE@google.com>
Subject: [syzbot] Monthly afs report (Oct 2025)
From: syzbot <syzbot+listc122bd568908b210969a@syzkaller.appspotmail.com>
To: linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello afs maintainers/developers,

This is a 31-day syzbot report for the afs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/afs

During the period, 2 new issues were detected and 0 were fixed.
In total, 4 issues are still open and 50 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 147     Yes   INFO: task hung in afs_cell_purge (2)
                  https://syzkaller.appspot.com/bug?extid=750f21d691e244b473b1
<2> 33      Yes   WARNING: ODEBUG bug in delete_node (3)
                  https://syzkaller.appspot.com/bug?extid=ab13429207fe1c8c92e8
<3> 1       No    WARNING in delete_node (4)
                  https://syzkaller.appspot.com/bug?extid=34813cbce633c9091556

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

