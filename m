Return-Path: <linux-kernel+bounces-786320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9A4B35840
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 11:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3ECCB7B6AF2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 09:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747A7303CA8;
	Tue, 26 Aug 2025 09:11:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DC3279DC5
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 09:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756199465; cv=none; b=Yy63qfz5j8aQFrGQ7efwd4KFgta5spO2r+bKw+m5EJkVCX+5antsKbdAmmIc++g0ReEWlLkBxOIBEeqXSqEe4QVEVXyQnwOOEr4C0FNtG+LB+heIEI342UDKt6GTMNK/52jjL7edvHS3VtlV+obtw3WycCFZPtYijNN0f1M6TXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756199465; c=relaxed/simple;
	bh=gEXYHOBGGEli8RvKYmckqBvsoX5LOA6W0GdLupDhUW8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Z95/BHXYm7OFk6ujbd03pihf9KqdDQzVmFmlR6h7szlIeptX+kHOBfUA/qft6Kkp1Y1YBxXB1c1j5ZByG9fAz6WxkDrdo4dUD/Z7CwTsbw3y9Ny9Admy9/YkP65439UF/BnzEEDelZAxju5Wi52E70i7JzYCrVBGU6Bv7b3JNkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-88432e1ea71so1397602139f.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 02:11:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756199462; x=1756804262;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MMj/VOAIYkkRpnJp2RloIJ2JilM6kX9Q3qYFM0TRN+s=;
        b=uuvG9+RJprklRgs1qBdDF67eVvOeQkWkIvXdFaPoA1bLPHULqM+upfalgO24IRbkc8
         IWXL3jat+iLfsI9kzDC3CqBHlTLkAE0uaudZ25Ecckph250sBJVDow+eRPV0w2fX7rfZ
         Es82FdYuYj0Qhl7KGp6rPAeKWbgOmyswRCGVHBSbMCoBFA0tmM+psh+cpvtwuWmt+GdQ
         q5J0fyPJgeqid/6DFZlolqU1RA1y7QBNBZB0iiPhJcGxr7q9CGVA+T56fzSO2u3TX6e3
         s9uymeMsC11z3QxQtqooAMpf4OCy3fTtp7j/sRGEY2+NIIkqpxuX9qka4Q30Y+QEQ32D
         vPjg==
X-Forwarded-Encrypted: i=1; AJvYcCXo6NEsKIIjraD90G4HdoNfQaKofN93W2QxaFBCaXih5KmhVa0qI3DxkwbBxQojLypyZq2kG9HMn+38++g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIQIxbx/qyWD77zvAH55z531FxBH44p9lzoO6YLsvJfdhRtU+1
	Mo7UxzuPb5i00Wty1XN47NL+fco/yX7UE0aXI0f1sgYhqvTQmA6M86KyBPKYCYvslxB8XsyXuY8
	mOFg0UNI4Tot8UfXQsnTNDQM9z+c8nUrA3hX6ZbjmfIMIbXes4vBnhP8fYjU=
X-Google-Smtp-Source: AGHT+IGv/JKXwGSCnbrecmul8CK0k+Anj4Ek2C++LuavJi+2hf6vhicEZ19pC7gsLG0rJ+Z8wPHfYZ0yMXwDS1j9zMLOZVigRapw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18cb:b0:3eb:2b11:441d with SMTP id
 e9e14a558f8ab-3eb2b1146bdmr147302155ab.15.1756199462711; Tue, 26 Aug 2025
 02:11:02 -0700 (PDT)
Date: Tue, 26 Aug 2025 02:11:02 -0700
In-Reply-To: <a3a6fd46-c9b4-4def-8633-f6ae79e40268@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ad7a26.050a0220.37038e.00b8.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: use-after-free Read in ocfs2_get_system_file_inode
From: syzbot <syzbot+900962ac9bf1860033f2@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+900962ac9bf1860033f2@syzkaller.appspotmail.com
Tested-by: syzbot+900962ac9bf1860033f2@syzkaller.appspotmail.com

Tested on:

commit:         fab1beda Merge tag 'devicetree-fixes-for-6.17-1' of gi..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=11998634580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=34aa432f9050e15d
dashboard link: https://syzkaller.appspot.com/bug?extid=900962ac9bf1860033f2
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10968634580000

Note: testing is done by a robot and is best-effort only.

