Return-Path: <linux-kernel+bounces-869410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B3CC07CE7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 20:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B5793505BAE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 18:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142F334C991;
	Fri, 24 Oct 2025 18:48:32 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F10E34677C
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 18:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761331711; cv=none; b=rbRP+CbsOilXe2dmKt5CK8oWkincewun4wmWNggHmyPwv0/NwbKwKPX9Uv5kyn9/xF28Z5sxnH/i7VG8Mh2s9+XqNTWo5R2cFR3VuM1BJYlPa5OtF5I1TzgDa/wF//HlbGouJwSrjlkUTkmD8bnsuYNKchymjK3T5DoiMmrHDb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761331711; c=relaxed/simple;
	bh=Qbb2WYeO0Y8WFZ14ASW7pEL61yKzgWvQZ292QHupDDU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=I5yXvVicegyz/XtNtSr2pSnhSOWPzUGpcsouIMthLYLh6Ar8uPu8UCn3O9LAG6P3iT+ySE/L2klgJmk0+vM2o/9Yh+Ieo9Rx/x8vQKmWXNEk73TMf73L8DfAWfw9rfnHvxCZLmFtUbNk2Uv4iSt71OHFnQAkjDTVhHfOLR/SY9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-93e8db8badeso256694039f.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 11:48:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761331709; x=1761936509;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SvEBYgb7SdAK2PWCckV3bk1FK3VYsE3gB84Sjv6d/Uc=;
        b=xTK0RgywYuqXkIuhPqkGQp/j1Xr6kt4NpiAMmLyhDz3K+RpiPxr6xQFZaXkCY9lDxm
         53qJ9dqwa6QQDkJjNUQYjLaZi3iaA3IJS+yoZdRpONXGmF/5ey0Twp8k/gWvKL03WuST
         F6Es/IQ1BxS0e/oLMmeVGBDcojSub1+hV4Uo5+xnH9NAXkxfTVzfsfUFY5grX5kqKRjT
         48MofiTbTXx/hS5mV8gA3/29PfjLelQC9aA57PA8q/6EDEaI29K/XlSb/Dsvd3KGmqWh
         bYZ+OhvdrFIHFjW18mdbWsNITuoOGQyxZK81bHvMUIYyc08ZoCBMJsUzZovgGopLWLMN
         ztUw==
X-Forwarded-Encrypted: i=1; AJvYcCWQ0tRjoej9j98RrwvSZpS7bYBoX37b0GYKGmbogVgG7NF3Ntj7gn02jL5/7w1mWK97smEwM1l7ht83iE0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/KvLZwS1ANsCGe09RGMQaG6Pf2CERklT4cK3gUmuR5OZNGC9m
	6U3C5c8Pb5/H5/bVoEpk0ywYR0cvNN1cXXiMDXWtItAhNuu/yaOVcZtPXP2fSV4J1LQoqmZ+q6B
	WBz9DvJwVAB96rA8wT2Rlq1nH7ncJL7kHqGUL+CX7GXoDHn8LB73cFPlfyuY=
X-Google-Smtp-Source: AGHT+IF/3GxpmN9Z4MVOoN3pe7SsYeyW2mKEyrmDk5OqUd6R5+YUMUFUNXEnZpMNPGTKBeMZgPcHVwrggtrKpOQ1ZOAySJXdfKZL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1745:b0:42f:94fd:318f with SMTP id
 e9e14a558f8ab-430c521f9e2mr379341475ab.9.1761331709225; Fri, 24 Oct 2025
 11:48:29 -0700 (PDT)
Date: Fri, 24 Oct 2025 11:48:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fbc9fd.050a0220.346f24.0157.GAE@google.com>
Subject: [syzbot] Monthly kvm-x86 report (Oct 2025)
From: syzbot <syzbot+list4c7e56cf766b2f61a4b7@syzkaller.appspotmail.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com, 
	seanjc@google.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello kvm-x86 maintainers/developers,

This is a 31-day syzbot report for the kvm-x86 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/kvm-x86

During the period, 0 new issues were detected and 0 were fixed.
In total, 3 issues are still open and 76 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 655     Yes   WARNING: locking bug in kvm_xen_set_evtchn_fast
                  https://syzkaller.appspot.com/bug?extid=919877893c9d28162dc2
<2> 153     Yes   WARNING in handle_exception_nmi (2)
                  https://syzkaller.appspot.com/bug?extid=4688c50a9c8e68e7aaa1
<3> 24      Yes   WARNING in vcpu_run
                  https://syzkaller.appspot.com/bug?extid=1522459a74d26b0ac33a

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

