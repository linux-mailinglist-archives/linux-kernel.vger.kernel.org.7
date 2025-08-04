Return-Path: <linux-kernel+bounces-755639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D171B1A9AB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 21:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B7D2189D5EC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 19:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFC228B51A;
	Mon,  4 Aug 2025 19:30:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDB628B3F7
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 19:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754335806; cv=none; b=bVodLI3DSj1R6erHcC2y/r3t05FvS7fnwCJqPN8I8BopENOWG9IxHRrUIqYPU355qYm+AaoQAMv6/OgAitpjQE87M6I4xejQRcY4noIo/TjskimVJklBeb0Cmzc4zDuU0h1ermwh2hfw1PjlFHFzJb5YP4H2WgOEQeaj/92htk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754335806; c=relaxed/simple;
	bh=fOmWH6T2Ow8xnKuhdw4jCSegzyrjcNefsp4HQR+Ot/4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=GiyQy1O1pN+4W4BsFE9DY40fjtGs+57RM/VDmB2HVGFryskoTOSyXdfS7HdYVBsYuUJXb+MtoHiQQZp+TCJ8SY4mt2bwClXmFWTek6aqmWnptvU2OUEzM7NvsUPmJVpUIKIXi6FLc3R/mJpEfSj6a3kOZlhp8S9X2zJof+8j35o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-87c30329a56so681313339f.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 12:30:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754335803; x=1754940603;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DmHoKehu4O4jWApi0R1qiL4KWmJQ2TRS/lb9a0gB/cQ=;
        b=hIAyjNCI3VjXeJw2JJvIaXnUW8MhdwB5R02wzdmbeCdYkXnyMhRXU8JYd/yxyqVmF2
         xaQtjC8uoCB4PvFJ17aimtn4Jl2Gdwq8CfGCOjKaGLld3gKMtfVJflUy77pGKy6caNPM
         KwtPcqMw5Hx250JhsxlGIF1yZ1+NApo44+YpU1mHWrbYQwlGaHxPPxkycCCIFUL8o60u
         dfzZdXadxlJBVu053T8ae392vQXlnHmB6zJYr/k+8yqWpEw+P1zGGhtisfWQqow0PEoy
         TKVTNq1HvIW4EBAJGjh/bLTZSyti1A/lQBISsyIz9NmdZEr67PfgLRHjxgNXGdcK2XsI
         MiOw==
X-Forwarded-Encrypted: i=1; AJvYcCXmsBPHci1TpvxQjtumptCFt/tx9QZr68oHe6v5p85SB0iGpUopIPIPsKAiBm5cIc06+Z5c8Fcf1/k6q6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQjCTv0n6OErW05CJFiCXtYgfnOHyNVBrwSSR+3MBGdy4JwL1L
	nc4vBny84I2v9yRJ5zmvZO1bwNxqDuCRWqQeen9L+XoxT4UxBfRQRzAE9esqRGcOXDhrHziw8C5
	KbSB+oTyyhSgJvSaNKzrYaikqwxlxLayxQdcyTz91OAEsO6TJ09lBwEdRxaQ=
X-Google-Smtp-Source: AGHT+IGbYggjUtG1oqcPNs8Dk/McEy/ytGOSxsiwmA/eJL8RhSvrAHgoiKBaOcZDS4Se3Vhq7UHJXeNrp3EegbiaU+JsxuFtStzk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a5d:9b89:0:b0:864:a228:92b4 with SMTP id
 ca18e2360f4ac-8816834e0d4mr1558256939f.7.1754335803785; Mon, 04 Aug 2025
 12:30:03 -0700 (PDT)
Date: Mon, 04 Aug 2025 12:30:03 -0700
In-Reply-To: <2D7EE43B-5C6F-4F46-AE09-D5B50FF64589@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68910a3b.050a0220.7f033.0011.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] UBSAN: array-index-out-of-bounds in bch2_accounting_validate
From: syzbot <syzbot+cd063f869beedf5b9cd7@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mmpgouride@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file fs/bcachefs/disk_accounting.c
checking file fs/bcachefs/sb-errors_format.h
Hunk #1 succeeded at 323 (offset -5 lines).
Hunk #2 FAILED at 337.
1 out of 2 hunks FAILED



Tested on:

commit:         35a813e0 Merge tag 'printk-for-6.17' of git://git.kern..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=cae1291240e8962a
dashboard link: https://syzkaller.appspot.com/bug?extid=cd063f869beedf5b9cd7
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=135082f0580000


