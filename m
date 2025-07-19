Return-Path: <linux-kernel+bounces-737827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDFAB0B102
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 19:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A58CF562F07
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 17:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9752288506;
	Sat, 19 Jul 2025 17:11:04 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA679476
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 17:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752945064; cv=none; b=r3E3FvmZk2qY4RSpmS7nv6ZVtY+nMeBH3eWvtnvnYijyfK/me9dUYX7bpduufvpwc70jiCgJLwWTnAo1bV0LQVqlQrxJYbzi6X+PmhJNuVWkDjVU0do0DiLQEshml/q3OKwh/CIddlsMDDVzt8GGjr9cDZu9ABrs1N5sWn7EYOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752945064; c=relaxed/simple;
	bh=eLQr72iShRzPzh/YRZlHz8bG48MhcEqgNl4UCABcX/Y=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=tKY2F8PT1ZU0PdQ/snP9J8QNHr4EL+Vj5d7xpSZButJmzRc0DBsGwMCeCsuFmDVxRvEGJp77z5Gv4OOHtCYaUZJWVATCbh3ySCtyCDWh6tcJhWlXnbKSGPshg9WpjCjSjCYRv5zxBB3HEE/7scfbWBjOrTyiGGSiQoYirKBRDeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-87c1c2a4f9dso218153539f.2
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 10:11:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752945062; x=1753549862;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eLQr72iShRzPzh/YRZlHz8bG48MhcEqgNl4UCABcX/Y=;
        b=WPXak2LvyATFLANv5uB9jP8NLfslNo8OZunPIZ9biTaXMtxNh8jEvvd78/Ojhi1kYo
         gsQM5jQLkzYYETIZ2wBNul5jW9G1QiUW6bwYdaEHSm3KI6IjhAL2vKaQaQw+E6lrtL0I
         2XiA8HKnkb0bVCbREAndI5EjKfnpXGTg49LMyf2EqyUfeSjbvapBL7Ruk3ZnIAFJfxH/
         Y2MZe5QhixEmo3ixawk6QZ2xUIr3gniwW/3bYBwJXV2KHJej7kEBMQbkpINTfXRqzhsa
         Ni+Xnwi8MxcM7LddRjHyAtwvT+SMS0KLKmSZfHX8EYPi+4DrQOZtYBJJ4iNHsxwHDsT+
         bZsg==
X-Gm-Message-State: AOJu0YwuI47MfPVWaQn7Ku5CFY3eFlOcRE4pgw5eyZHr4TxuaVZchEky
	FjDamM51mOjgTePd14lHs19rkLpUuzF7h/JXnmBFgbrnbDqPKNfjlozoHHvEfwItKZXJzSrsKP4
	HvExYnQml5tIr0bm8hlFe7gXpj46J04N5/ZPQ6c6fHTvk110ddTxUTrb35xc=
X-Google-Smtp-Source: AGHT+IHKIJHVbE90lfVxfvqEmd9IsiBDk1jU5SQ5cGR8VRI3gA56MZtGfvU2UjPsJkItJBrYYcn+DjNKcU7+wAGSIgmVuGv6qFqM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6003:b0:875:ba23:a065 with SMTP id
 ca18e2360f4ac-879c2aea590mr1825246539f.11.1752945062215; Sat, 19 Jul 2025
 10:11:02 -0700 (PDT)
Date: Sat, 19 Jul 2025 10:11:02 -0700
In-Reply-To: <00000000000032dd730620055fde@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687bd1a6.a70a0220.693ce.008f.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [ocfs2?] possible deadlock in ocfs2_try_remove_refcount_tree
From: syzbot <syzbot+1fed2de07d8e11a3ec1b@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [ocfs2?] possible deadlock in ocfs2_try_remove_refcount_tree
Author: penguin-kernel@i-love.sakura.ne.jp

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

