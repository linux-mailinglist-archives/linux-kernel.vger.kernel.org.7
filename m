Return-Path: <linux-kernel+bounces-874545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B396C168C4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 19:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1CF824E6CA5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 18:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097DA34CFDF;
	Tue, 28 Oct 2025 18:54:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417BD3B1B3
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 18:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761677645; cv=none; b=jn+Z1yu+SAbonqmPXvOVi+QaJ/xotiY016wHIV5cLRA2l9ztFGWsezrvXFcbHVhYD4RF14P6mtrePA+Ad2s0z+i6fwxDnf0LVXU3wjaCFQl4yOp9rB4ee5CVD3tbytCjKrabuGI+M/X0ClQ6CJ5/CBNBxz0g1yllvD0riTw0mPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761677645; c=relaxed/simple;
	bh=o+UTWi4KHvlcj1xBg2+IzdMEi4F6n8g0pg4gKYswcLk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SeWaUIB9tvVmXXC3X/EqOBxFhJKmhJgbGCMt6Zx27xB9KeBk5GPWwSQqP61uSbnnNZBcz449YceL+rQrcxkyyqyZh1PYVc429TLoG3BqnWwRYWourG7Ouw/4O9ogICKAiTU3zDcLe2QvtYukLvoH5Cba1JweWB51Pb2CtZS9ivU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-430ca53080bso66439075ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 11:54:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761677643; x=1762282443;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zx5MX1ry2hbynCSU10Pon24e1K54yKqgGCYT+qeJsFs=;
        b=ILDk1pNXnoh66qVw9qxUwhW2l0MrWknvq1MjbUEuYhVvoUVfidaW18qIJqSDSUgMYj
         zjluqQrar+oUfh0hMU3ZIoYfIZVrjuhoFcNf+z3sM2EM1kfCCQbFn4+OVNdZ7sVKA7ii
         hVbrCBEcVI9bCK4OrmL0NK20X+8QmA1UNkTC64z+RXAe3i/yXPT6y03M6G6hsh2pDsob
         G3URMdyhSVmk0C03vmQnqvhhyY+TXISIBQOh28mKkA2QiMThw0T0ifChozy9RBflrrbT
         8TNRrGVgWDg+sHNwG2cMDLpC7gzDd470up01BWvxbFiX4HMBF+Lmzp5WLfH/UL5WapeZ
         oG/g==
X-Forwarded-Encrypted: i=1; AJvYcCWgTUjMKl+QKAL8yIQWW3SQuLDkDEoqLRDkufL7q3/PDLwP7hErZ+QN1GeBnPGudkwHJi7mqbuc+FkkMiU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTcsPC0gNr8FjDj9Nn6ubULUmnI73mNwWJWuCfw+DFufb2Iz7L
	vewk6CokhGCv2735YmsIYBmLFdDXPEZQQIqJW/k6hNXWf+2GoYqkStDw+sBPrxR+1ym2b+NLUg2
	lWgzAhhM5Ed7VySc2nyrKTF19RgXTX7jxucYoe2bjW3aLrIZFXiEHQXohwN4=
X-Google-Smtp-Source: AGHT+IEU6nALTzGXWPIXpBYjOT4omgyopwqNOPGavFF/ZrADbLYetrgIpb9zDZodHFavM6+YDxyBp5ezzLaj9Ec4kqUCYSCUF1MB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:260a:b0:430:a110:a8b with SMTP id
 e9e14a558f8ab-432f8fad712mr4268625ab.13.1761677643507; Tue, 28 Oct 2025
 11:54:03 -0700 (PDT)
Date: Tue, 28 Oct 2025 11:54:03 -0700
In-Reply-To: <20251028181932.X-9Ib%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6901114b.050a0220.3344a1.03da.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: use-after-free Read in ocfs2_claim_suballoc_bits
From: syzbot <syzbot+5054473a31f78f735416@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

fs/ocfs2/ocfs2_fs.h:474:40: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:489:40: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:502:43: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:646:26: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:659:16: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:807:37: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:943:43: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:1030:39: error: expected ';' at end of declaration list


Tested on:

commit:         d3d0b4e2 Linux 5.10.245
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-5.10.y
kernel config:  https://syzkaller.appspot.com/x/.config?x=cae1291240e8962a
dashboard link: https://syzkaller.appspot.com/bug?extid=5054473a31f78f735416
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13dd5e7c580000


