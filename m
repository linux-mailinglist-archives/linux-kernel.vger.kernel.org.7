Return-Path: <linux-kernel+bounces-859605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9736BEE15E
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 10:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B108189BA75
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 08:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFCF2D46DD;
	Sun, 19 Oct 2025 08:58:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FEA2D46C0
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 08:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760864284; cv=none; b=WDe6Kj3Y9gJrVrycC/ov+B/3D1jmrzNoIUrGffauZb6p8ajf9+35U2clVNOPenmNbHVIWaoixSf4ddsIkMm4ZXlsYSEf2h04LNA7njHEQHfnsrUChlFwWG9SVziShFKilxnZlDcSiMSfAd6b6j+wZoenpLalXkeQ82W/tbqa9y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760864284; c=relaxed/simple;
	bh=OWytkX1F8uQZIZPjgX2mKJHXmarjAKYgEHp35h7uLaQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Tf+SCzTUrt82upn9f5KGuAFsMgNiA8eDqRawibKn5ecsmygAA7hq33f69IZ7/ehWMtSL9UaWDkYQMjYkej0uv0nW9xt5sbJW6SBqNuYhkxYTDA456ynCvwzwHCz2XALPQ5nGIOAXlIPhD/4XdPHo+1F6mn4GWdtA2yfePeOJ00Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-93e7d299abfso201385539f.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 01:58:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760864282; x=1761469082;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NClov602kdmvaP3ZQOigr7hdarIZC3O+Z6Kw/5LU+Eo=;
        b=ZdYf30Av1zDyrPVardKUqwK7aGtf/fI9yW9qqhOytOzcQm1IeE61gGSeqh0INkbrDE
         XgZRVe3TmIVYRTdCo3QcqmpeN8ddp0CJ5Yk5vIRY6yNgC5uf3d/1OYZCJgxEhlrfaQBf
         A00g3brJ0E9iW+ju1ohQIlcLSeEzQxVycoASZPynokBctDK7SW70PvRqlecx2OUPWA+j
         ZwUbU27COpLSjqJMlrUgChXfGIjLdwepcPhMyAmc8eSCJFeCEgdtZMI5BSQ03t0CPi+c
         vag/2tLu92jr9t3nyh5w5wEcQC+KLXXeqWJi/lo06Fbnuhqk0E0025u32LizcJq9WzKa
         +gWg==
X-Gm-Message-State: AOJu0Yxq06JE/cLBWs+RkZzIR+5gQHo/aQ/qBmtduMpzm6e7XFLU+uck
	WPjtuDmpecvMeFuIUQxsftMf1akgAoLnsSehMhwrGy0ovZf4vP5BqY2kZM0sfujyI6LFrKmJo6E
	sznrJntMUYl+3odmEA8cxKcNqthDN5ZbndshGu/+SPTyeBIgD/oW/gzvt+Mc=
X-Google-Smtp-Source: AGHT+IGrNrcrUThdzvV8EayYWxMU6PYNxvscnTNOiR7UGwmHmV6baCa4ZOlbDmxqI1xoAM9+lGq+2QDu2R+JQK/2kIcmnUK7JPm9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3426:b0:93e:894b:af68 with SMTP id
 ca18e2360f4ac-93e894bb23bmr762539839f.0.1760864282479; Sun, 19 Oct 2025
 01:58:02 -0700 (PDT)
Date: Sun, 19 Oct 2025 01:58:02 -0700
In-Reply-To: <76a62d90-d13f-4657-8a38-2a07abc83c65@I-love.SAKURA.ne.jp>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f4a81a.050a0220.91a22.0438.GAE@google.com>
Subject: Re: [syzbot] [ext4?] [ocfs2?] possible deadlock in dqget
From: syzbot <syzbot+6e493c165d26d6fcbf72@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, penguin-kernel@i-love.sakura.ne.jp, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+6e493c165d26d6fcbf72@syzkaller.appspotmail.com
Tested-by: syzbot+6e493c165d26d6fcbf72@syzkaller.appspotmail.com

Tested on:

commit:         1c64efcb Merge tag 'rust-rustfmt' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14a9f67c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=568e69ca0c2fa75
dashboard link: https://syzkaller.appspot.com/bug?extid=6e493c165d26d6fcbf72
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10f1f67c580000

Note: testing is done by a robot and is best-effort only.

