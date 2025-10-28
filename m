Return-Path: <linux-kernel+bounces-874662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C79C16CE0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7CC5189B69D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 20:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9798D34A771;
	Tue, 28 Oct 2025 20:38:04 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C992820C00C
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 20:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761683884; cv=none; b=fiGkxKEh03Tw2DA5g1GUaox+f/85hrwjDX1PDNmAW2HuO0KnGkcvZEYx74zXHKfqE+Ac3vOatbBVbAQeGFJR2JuwsKlnb9pgzdaIxfYT/tzPQd8sDTv285cI1k+sQXoKjv2TrLSmFUt+X1PZ6oTaM2O9YJ24DAIXdlTqP16+8HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761683884; c=relaxed/simple;
	bh=JymgD4jCbp2ZywZ0vujEAVOvPnKv6Tph963V6GBSYEg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RZ7Nd2kND+Mq2MiB7SxwhGueaZfWowfGh3lnjECrpgbSV1N+s629lnkoV7A/MlM8dH+x20hE38BSAI2VfeeVVtHb2iK5fSH8jpthRdJL/Q6E9SsVkkn0wEhcr1hp9ORGJwz/OXti+kwf+1qntcWttT6ITiBRspTijt09Djf1RZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-431d999ebe8so203757125ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 13:38:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761683882; x=1762288682;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FYi7tqwNlP1VmOJIq5kTkbmDlFpPcvNu1rg1m4pJJb4=;
        b=goNxdFrTDIELbmHHQwDY8yfExYxLWA5PsmQEKre+8mq/2KzAnJqAqLzsQzbzD9O7cD
         huTqHVkMokwvLCQVbfYMs3HaMsI4sjGwjKAfEnb/R3tkJdXO9ddwhIxHX63Y6/rpIcTH
         0DmeutqU7M6oG8teXYhJTwlb7CleGiDcc6RwiZbKt4SBcUL0OnEZIkaJ5afbkOm8ZZSx
         eX++yRbuzI/yQdRhE7c6xrrV1HZYQTuVfbqRXASywufzU75AhM+pvFQDATWHSTCrzzKw
         MxzK3NvNXHRiY4YMuUJO5WETu2gpL4UttlY/xqYIs6HsRHJtfEdR/jRLR2woWUi3aya0
         onYw==
X-Forwarded-Encrypted: i=1; AJvYcCWcQ8MUcq11EI91PpsEE506W6oDlVZjlcE65DBpnlTxeqfETN1QKrs9Z+lYeUUn5DZW8AsPvxUSL1YpBPo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5MmHk2GnaeCxXc8QDk37l2q3pxS8N8gp57HEjA33k7Qzdn36L
	u9mJxRB4KRu25cZxaTwhuMrrtNdaWFTga/2pFpb4oMZVGb/ZlGVu5zXG6m0VBU2pf6PCKTFFsj7
	0Wab0v7rGQSvEAOBeFg5lbU1FIpsIFL6rogximqbArgjDsBuM0E04zzWQmZo=
X-Google-Smtp-Source: AGHT+IH1SSObioDEqr9FFbY4Poxn2tyMsoW+bhRnhqZKe34kHpvC0WeJmwdb8BAIWwloMbQGzZhC44HO3KvW65lTcpI9TyvXzXEj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:340e:b0:430:c78c:75d6 with SMTP id
 e9e14a558f8ab-432f8fc7ec8mr9225845ab.2.1761683881994; Tue, 28 Oct 2025
 13:38:01 -0700 (PDT)
Date: Tue, 28 Oct 2025 13:38:01 -0700
In-Reply-To: <20251028181943.j7Uu3%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690129a9.050a0220.3344a1.03e9.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: slab-use-after-free Read in ocfs2_fault
From: syzbot <syzbot+a49010a0e8fcdeea075f@syzkaller.appspotmail.com>
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
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5b21423ca3f0a96
dashboard link: https://syzkaller.appspot.com/bug?extid=a49010a0e8fcdeea075f
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=102c432f980000


