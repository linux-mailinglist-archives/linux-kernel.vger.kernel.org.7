Return-Path: <linux-kernel+bounces-871591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D1DC0DB99
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BA1C404F0E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773C82459D9;
	Mon, 27 Oct 2025 12:50:27 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7DA23C506
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 12:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761569427; cv=none; b=mzf74bQbQShZfsf4Lfsx8ZmFWdUger2XEQoje+xXdmS16gqspZWbLXG9k1p0yUw9146JEQYWjY+pKLqTLpalxCjZNGxzUqvaBLwU5wkEaerteFsIrio2P7UaMK8KuAGMaE3y/se5K5XnWiQTPw7/NFQldmVPQbddogg5d8jvuL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761569427; c=relaxed/simple;
	bh=MYokRgUnklfgp2hSGLi/l31foxE3G9yPu1Ffasv37f0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=SRkyBZwQazG0sSXt/MWW9RWF+XM1VM5Z3qDC0jEVeSbuDHrSyPf/8A5WdNDYK2uWsqJmNIUzfPWmVhJennjPErc1bSc8JZokjlr2MHmDFp6Ain6CfsgPR94QKtwngwGI1JR5pO/gfx54Z5HbVVM8uIPyu+JIFYPQVTgHDNABFe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-945a07d5fa2so154012039f.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 05:50:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761569424; x=1762174224;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LJaGp5DmbI3TdoxyBnJoC8ClyEN+J7FA0llN9o0qtOA=;
        b=wVFRUVqhfLI2xr5n66i0nNS1llxqDDKD3YJk67Mit0bdEvvGFxAu3BjbG8G9bJg6ON
         EEvfuDXIH4u8e9qgSJt/ZmbYZvhkgxwR/0TjXf/k6TuVUFwPAiADwjF6OaxzrwsW2wlg
         Ttoa3LDLLwYpAmgn8fdOBuQC3xVBijIkDJ/yeei0ptnzfucX+BFljlcdnjm0mURXvs/3
         v6WtSnjaOcTCWJ530FN2ba0GP4Wa73Lpv/6v3QhGd+cb6kaIyUOMbcwyGleepd4soO9K
         NbEFvFCVsVeeTao8hVMmn/xnW2XgPJYL1a4LBh/Iss4zgBz6LhFZBm0Xt/WuJnVflDiC
         Ct9A==
X-Forwarded-Encrypted: i=1; AJvYcCUmXOV/hGqTD+ysf2O224qznCK9eznC7OQey/IIqXvpPokCWi+OcmjXp6N+bUMdD2hXtSlZJ591DgqKXXY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4hTVqNku4iOn/ZW5rIXGBICLMdhHN/lY8pegHnFWsCH+e9l1k
	pCUMAJknk6vvqY90Ttt4GDKS73OwCiPrmM4/lY6I2aNkVpAV7Ky1HxsgPtOiEf1OTTRSATwSBuF
	3WX2h9Q9GB+olDNB67hPhy0L/pYpuSlyTND4LyiP/QiE/z91ovwNzH4gb6Qg=
X-Google-Smtp-Source: AGHT+IFOhQ6MNo5f6BQh53xHVN/xb7dbWkIHpwoIidagx6Rmn/gbggVW8zAmug69JEstH/3ucEPq3nK2GQlCcB3N82y8wdKz06dP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:32c2:b0:431:d793:6ccd with SMTP id
 e9e14a558f8ab-431d7936d92mr233216075ab.15.1761569424499; Mon, 27 Oct 2025
 05:50:24 -0700 (PDT)
Date: Mon, 27 Oct 2025 05:50:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ff6a90.050a0220.3344a1.0393.GAE@google.com>
Subject: [syzbot] Monthly hfs report (Oct 2025)
From: syzbot <syzbot+listd792fd3cf3cd3d015985@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello hfs maintainers/developers,

This is a 31-day syzbot report for the hfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/hfs

During the period, 1 new issues were detected and 0 were fixed.
In total, 33 issues are still open and 30 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  129081  Yes   kernel BUG in hfs_write_inode
                   https://syzkaller.appspot.com/bug?extid=97e301b4b82ae803d21b
<2>  14106   Yes   possible deadlock in hfsplus_get_block
                   https://syzkaller.appspot.com/bug?extid=b7ef7c0c8d8098686ae2
<3>  5424    Yes   possible deadlock in hfs_find_init (2)
                   https://syzkaller.appspot.com/bug?extid=e390d66dda462b51fde1
<4>  4085    Yes   WARNING in hfs_bnode_create
                   https://syzkaller.appspot.com/bug?extid=a19ca73b21fe8bc69101
<5>  3538    Yes   KASAN: slab-out-of-bounds Read in hfsplus_uni2asc
                   https://syzkaller.appspot.com/bug?extid=076d963e115823c4b9be
<6>  2855    Yes   possible deadlock in hfs_extend_file (3)
                   https://syzkaller.appspot.com/bug?extid=2a62f58f1a4951a549bb
<7>  1830    Yes   KMSAN: uninit-value in hfsplus_rename_cat
                   https://syzkaller.appspot.com/bug?extid=93f4402297a457fc6895
<8>  1007    Yes   WARNING in hfsplus_bnode_create
                   https://syzkaller.appspot.com/bug?extid=1c8ff72d0cd8a50dfeaa
<9>  819     Yes   possible deadlock in hfsplus_find_init
                   https://syzkaller.appspot.com/bug?extid=f8ce6c197125ab9d72ce
<10> 599     Yes   WARNING in mark_buffer_dirty (7)
                   https://syzkaller.appspot.com/bug?extid=2327bccb02eef9291c1c

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

