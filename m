Return-Path: <linux-kernel+bounces-876852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D25D6C1C856
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7F32D34C5ED
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E297350D74;
	Wed, 29 Oct 2025 17:40:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA49350D5D
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 17:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761759605; cv=none; b=oxBFz4tuEluyh4dNfRWkv5JN1wu2TzvHajjlJhXPm7g0t6vbzxYTFHzym+xb5I1r+3fSa/DELrTNA4L/HTuZmtUHPD7vryLce54Kdp7mYDfgXPnN85prqZvgUL3Dk/XC5qD23+bTOybSJ5SBtN11DmsgT7wDaM0jTNZhCbNVXlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761759605; c=relaxed/simple;
	bh=JA7LBvak9Mpey+GHorqRd6zMhqicvhChfPMlfhZMgAY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FcYGrOsxhyZk0H0Jgf6C5Ma8IIe4KuLEJb4t125JUFM9+27UuPJJdub8ETbeJvdco8QTcx2Yku6xPRUepBLnDzUfDgJOoAA2R4SLPxLmY7GYgNEAFtjwUWEJ9PUgpKqA/NcmoXmn0mwt6lk3FTaVe7/TOzUOcAXFykGTjnM76CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-430db5635d6so701885ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 10:40:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761759602; x=1762364402;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PGiNCz4/dF2dENqcuNoLFjsOAZpECL9FMGCiSPWvYnU=;
        b=Jv/ehO0FeG0KmNBbDRZkWWXPJLlUHKDjSLputRughjzWEe6sXcfjdtuD9UNY5eT8Aw
         WvOGE9+keKp4QWtl48gVVX4MuXb02H87u9B6J4BZXMnX4DqeK4goQvNgFuKT8EFhnKQo
         BpqFxpB3bf4FOu3i/yECmi+44I4u1CIkMFNv8taOtVDfB1HjOy6wvYmROhEectzmvvdU
         HCgcocB1Yw69XgS3J0hI228GXoMU3QHVcsKjHEcj6TRpnmbthjJrz5z36d2/bo5AhA2c
         RWtQM7kdPxl5F0QYVbFcFjI0eAUCGy+F1ItMHvoPy1XlyYJ9gGNV4IuvkkmUiVTbp1Zs
         Ijsw==
X-Gm-Message-State: AOJu0YwYT7cjXvYtFBKIPzlhShttA1Sw6qMFqSC00nqmIhMwB2sAooqn
	sIGTSgo5xwMTFmttiKHmnTcD7FaQJ3Mh2QWMzhyB4ibOmUhXw1ttKxAhR+PNjEWQTnwEy7dwu14
	P4+T6P4jQKGUTbK3dMuA5RDsMZiIH4C4695HxpUAnZimztx/jrmoMXyt4s0g=
X-Google-Smtp-Source: AGHT+IFZAx6GR2jM/xki8Dfd5lyhp+TefZKvMlyrq68IvL/WbOOELnXNJLIFPI8RwhTDdKSj/nwzGIomXb5EoQYBx5Twcp8GtNmU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2701:b0:430:ea1f:ff82 with SMTP id
 e9e14a558f8ab-432f90446a3mr48018275ab.23.1761759602299; Wed, 29 Oct 2025
 10:40:02 -0700 (PDT)
Date: Wed, 29 Oct 2025 10:40:02 -0700
In-Reply-To: <CAHjv_atXD_F0pMfDS5z36mR=inYx+pnODBLF+oj7uZuBMnK+9g@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69025172.050a0220.3344a1.042d.GAE@google.com>
Subject: Re: [syzbot] [net?] kernel BUG in ipgre_header (3)
From: syzbot <syzbot+a2a3b519de727b0f7903@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	zlatistiv@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+a2a3b519de727b0f7903@syzkaller.appspotmail.com
Tested-by: syzbot+a2a3b519de727b0f7903@syzkaller.appspotmail.com

Tested on:

commit:         e53642b8 Merge tag 'v6.18-rc3-smb-server-fixes' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10e64fe2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=486aa0235ebabcac
dashboard link: https://syzkaller.appspot.com/bug?extid=a2a3b519de727b0f7903
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12609258580000

Note: testing is done by a robot and is best-effort only.

