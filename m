Return-Path: <linux-kernel+bounces-864946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A767BFBED6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CB7F134CDB0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85DE347BB4;
	Wed, 22 Oct 2025 12:49:17 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A54A346E4B
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137351; cv=none; b=QikPa/aP6HKJVIv7tLxr7+NNa4JE/OjsIGLjVOV0gcGiFmVlBA7OQCPEEP1/sdLg5TqFiyQDBXbfpV5Nm1SXBZ0foHUgNJvZ71CtgJREjJGhlQxH5vzBO9Hu/0Gtpe59M5o4WF6lKQ6JKRst3prpc5Bx1WSbcGKkqFvvq2nCxJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137351; c=relaxed/simple;
	bh=A+hqj8nXu/pWFNH1uR+WFnMmhOQ6v8rwCcwB+zW3YPo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=GWKx4Utw4DTgL+a+5381QIBpFc846zGINzTn0klIFyv9q7AeNtLMApokuOLjFYBC6h905eNNKzZoFnmrDLHVDGB1+jDFITuHL6K6OnGPVPiLVwLWzRwau1dylwa1RgcfH5OzVXgJ8n9580WI04Y3xkUSUXemuDw90r3y7+inSr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-93e8e029e0cso1203920939f.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 05:49:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761137343; x=1761742143;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HW9Jk7YMZht5X5TFYXY8m+zJrrP/wR4eJ+2lS7rFV/c=;
        b=tuWr3zxOyC+DOAoi0Eop9tbYHGKOBloilFBWCeRip5jKXLrhE7M47Gw0Ys4u8BukXi
         bxNOmWSLG79hAnaC37IKjQgL3ZrKzUT1iKWQRK7M3AWdgWh/1PbbT2XRuUq+zndBgUs8
         i7GMGEQN4SUKfInBwnLWrbJ9bGzKdYHCUiHs+2XTe72Am272YwdFktVAyTDrO6MIUvvv
         BbhPX8dPm2nJjrYEC4hMS2vMpDmTN4dgqDLlR545eeToQDyM6n8J2uv6vpSy9hJjqqJ9
         kg1b3AQ+Y43MQrt01ld8wIS/j3WJfiPzJU7q+K28M7nR1sBZobdQQIH4lpSWFSvsciw0
         WXdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUueCYVEK7K2rv9rn2WmqBPKNxY2fITfgs7Ojs44pKvttTYeOdKORtiBwUjEHnH6LFNghhpywiGCltVe4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrqdFSJULTkJRKATBn+KvfEl1VLiCXROAVWdfcP9xCx0D3aJgq
	Kg9/OyL0clW6aHAzWG0B8QehR3WP7I0x49I9AnufRba1R79afZWw2mjIgL5WZqPAgMjUV38RXEV
	nrdNc/y62U8M+I1oLWTDN5tiKqPm1xzpBpTln8gOVYsf6hOMN6PfhWD64yiU=
X-Google-Smtp-Source: AGHT+IF2khrbZoMhBihWYVv/iQz5bhiSaGyEJE3oHbQ7Zk+wF53TgIbeh53j5kJgpUN9MGPwFz0+bWBWCNPLveqUSL5CJGQCBcuX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1947:b0:430:9f96:23bb with SMTP id
 e9e14a558f8ab-430c522319amr267026205ab.8.1761137343168; Wed, 22 Oct 2025
 05:49:03 -0700 (PDT)
Date: Wed, 22 Oct 2025 05:49:03 -0700
In-Reply-To: <20251022121326.QRitS%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f8d2bf.050a0220.346f24.004c.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: use-after-free Read in ocfs2_claim_suballoc_bits
From: syzbot <syzbot+5054473a31f78f735416@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+5054473a31f78f735416@syzkaller.appspotmail.com
Tested-by: syzbot+5054473a31f78f735416@syzkaller.appspotmail.com

Tested on:

commit:         552c5071 Merge tag 'vfio-v6.18-rc3' of https://github...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1152ce7c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b1620e3721dc97c0
dashboard link: https://syzkaller.appspot.com/bug?extid=5054473a31f78f735416
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=116ce3e2580000

Note: testing is done by a robot and is best-effort only.

