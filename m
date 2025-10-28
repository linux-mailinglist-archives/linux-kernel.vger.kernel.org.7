Return-Path: <linux-kernel+bounces-874523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F6FC167F5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 19:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 89CFD346C9B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 18:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4263B34AB1C;
	Tue, 28 Oct 2025 18:33:08 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759ED199FAC
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 18:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761676387; cv=none; b=MqhsNUZvmvzzxC3zzyzLRlS4QevVbzCQNXoVs39tOACH3B3hTPoa2XV6969pqHYjLm3mMB0COxnf/3QtDzXSv+yLvIkIy/d42wzQC202EVFJDSjwlNukJfrdiexlmBaeF1Cm0x6lgp2JDNbfRfWfc3yCgTqAwrSlpsa/Ilzqoz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761676387; c=relaxed/simple;
	bh=ipwDZ9annplH38RhTUgq12LhogPLz69R4pZNtMH83xM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=E+2cuv7nsiFHHJbwUlntW1WP643VH07Pe8xkyOrBRcYD4PpzGSiv7/AGTNmLGulL+hLyqLpB93TYLwiVtGBuIpLPpXgy8oJ0wahE6PMUdWVzK7QKwjGh3lI7HQBxjsjR8Am5QxydVMRVP1qY2tp3e1n4h9vJ9Vjn+Jz7qpWE/0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-430d7ace0ddso82855115ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 11:33:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761676382; x=1762281182;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IqOwXWyQ5cg+z83zXoyA0D5QJ4Vp8EoxqU6T3H+FwkI=;
        b=EkBsVzeIVYoxgI79dASq4nqwY/Pk6rXZmgBN5xRRB+RVrwQdW2u8G2EaXeUI2oi786
         6jH9KsTOzLwSc5qwOqbziXLJdIgq/6OC3g9ZjvN7SRwYn3G+7HvXacREczIPDR3SENB5
         Cyd5hy5viceHngqtaIdr2umXY/GhDVDMqvUe5E70C4I90iQSBZdyxPlsjonhJHjolvHk
         RX1bOBi+N4K11cN9ik5XVo1azCsz2loHCTuJtBYS+gLJlTGUPdJgmKzs082xyabWC01R
         4JeKiIeU4dkgQYRm8tWWWGQTpDqxxf6BZQGj7GnGkw6sNsZ4yKXxtSOcBD+GaSlKyFhO
         DEiw==
X-Forwarded-Encrypted: i=1; AJvYcCURlzKIhoiroy8DB8cJhPElD/XNIwIB7MZHhISmEbdpBvfrIYz0mPzA0ntII6xIDZ/pM+wy7A4ccnNio1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNtqEnyLP1kIXRs6TsPdyeP+vRWotgotIoyUX1C2ha1Kxit2VE
	VlCmTUO218PJoC6ZTWR6PyHqk2u/UwzdS3fVZTKlH+42W7Y74QsXwHRP3V0Kc5mCd/yITgrLyVL
	qLNbpoQQqI+aif0gg7cPyGIP+JL4FmogE6wte8wQrJSr+fXA2pgEjKw/yxV0=
X-Google-Smtp-Source: AGHT+IGHqynQK0OYs0J9pN+0SjyXHE16vZmwAyz1MnJ0u91K0LDZ886s4yPNF402KwYG+kjSKGl8vB0ojHQloVph0vz6Y+zFEsZS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:318e:b0:430:aca2:53d5 with SMTP id
 e9e14a558f8ab-432f8f93765mr2914495ab.1.1761676382584; Tue, 28 Oct 2025
 11:33:02 -0700 (PDT)
Date: Tue, 28 Oct 2025 11:33:02 -0700
In-Reply-To: <20251028181934.eY2E6%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69010c5e.050a0220.3344a1.03d7.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in __ocfs2_move_extent
From: syzbot <syzbot+727d161855d11d81e411@syzkaller.appspotmail.com>
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
kernel config:  https://syzkaller.appspot.com/x/.config?x=84e81c4d0c0e900a
dashboard link: https://syzkaller.appspot.com/bug?extid=727d161855d11d81e411
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=156d6c92580000


