Return-Path: <linux-kernel+bounces-875578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9AAC1958C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5040F188572D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77EF2E0905;
	Wed, 29 Oct 2025 09:19:08 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50B8310635
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761729548; cv=none; b=RUpxmz5rU+cEYY0qnygk09cTXOuybtgMZipwsvxPs7BZZ+Ul3iz/fycY8ORCr4dxnVQG4ATzw0g6dYG1F6dOiy1FPXeKwqNkBAs5sAmYnbCn9sVa0GSOoDo8mZq6tknZK7uC7OuuBPY/pgokmrHoKmV/DfOig8cw8F6rNo/DZF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761729548; c=relaxed/simple;
	bh=EZTyKyEZeL6Zg5hYdwM0nGI6LGNR6mBTI8mkV8f5wzg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=S83pxocV48AGDL3ueoL61Gdvh+Ci+4/jSylXfvbe5AXL70fU6VnzaRs08rEgM0Kf5P5kv/E5ciNTHK0O7zOLbpR2b8JBUKr1Hsi09ZLOAxbv4JUy5bvqNi0AOaoerFFHXHi7CKXgtQTr3FhV1C8fbLVseyamHsgd4VMQ22Fhkog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-430d7ace0ddso92166125ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 02:19:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761729544; x=1762334344;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g1zZFWYJ7s+h7igpZ0emz0AKNjfUFwfNv3d9VdBd620=;
        b=CaJBVr/uYkjUzFREI/l5iRVW0+V+R6Djs5ZBBb9BtuGszISIPNmArCg5jxBH3KqBF7
         NNzfSzWTXBSh4rMGC1h3sMDhgQrhmYgSmVUXF4+Qk6lBtsEvk7SCca96AkwDQDlRb+al
         onLwndnvGAzt82yeE/CraQIs3SGjIr3ERUEImPG6kpd2BwaK9kT19ckzQ98lkIF17njK
         Fn4qoasxLQcGETWZRojzsQfnGP7Mh2zOoxk0B6E3NvlCXosWcR19YQBKKPcqOgX1uKnT
         /hiS88gExc2//EQ4CNsPj8NIFFtY8LQQ8k537S35JW/YriVbGBxCXPNaXuWgNyRMe6VO
         nZNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvqAVaOWNPYAbVQgcPP4AqV/RItBbvxsl/hgqotCBMDs/YFBPTuKhAYu7+wvh0DhGR9DdqPm5MO0hBo1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFrq75srqsWjSTBzDDGaPqHHEDDyrhaMQKUziDf/gW2BvCCEpL
	7iXsiJnZ+srzlxzTV21rODsr3FP0+S1SSrCAWWK//oOgks2qG9kG/peLu0g0opg5qk6BIVj2uQr
	gKwAmFFcMFnIfvqt4Kp5Jzin1xDEdLoqYtulJ7JLPPlDNUjBN7ooItPSKL8I=
X-Google-Smtp-Source: AGHT+IH+hazxpe33ouPdAhG6td5rgEMIbUufyYbh3eW8/NT+KI7oHymdcOa5U/yQvv8aHGccyAztz5G8Jr+jm4boGEuUhdars/lp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3388:b0:430:9bc3:e1d3 with SMTP id
 e9e14a558f8ab-432f8fbb51fmr33323525ab.12.1761729543989; Wed, 29 Oct 2025
 02:19:03 -0700 (PDT)
Date: Wed, 29 Oct 2025 02:19:03 -0700
In-Reply-To: <20251029062741.TtsCS%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6901dc07.050a0220.3344a1.041c.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in __ocfs2_move_extent
From: syzbot <syzbot+727d161855d11d81e411@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+727d161855d11d81e411@syzkaller.appspotmail.com
Tested-by: syzbot+727d161855d11d81e411@syzkaller.appspotmail.com

Tested on:

commit:         4fc43deb Linux 6.12.55
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-6.12.y
console output: https://syzkaller.appspot.com/x/log.txt?x=17e84fe2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fe7b438dcda9b036
dashboard link: https://syzkaller.appspot.com/bug?extid=727d161855d11d81e411
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16db6fe2580000

Note: testing is done by a robot and is best-effort only.

