Return-Path: <linux-kernel+bounces-868450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 556B0C05415
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D83C54212AA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 08:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3EE307AD4;
	Fri, 24 Oct 2025 08:58:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECAC307AD9
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 08:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761296286; cv=none; b=pZe/DUSuzeJ+WtNGwYVb1tnb5opfsCsAmGx97be7uwO+/Uw1B9ZBkAg99w01xJY3/R7Zoj7Snwx572BVPYyvaW8LmFez5XPTaVpfl0LkaTb1RHZh/FAI9qqYxi0Xha498+X84nhPTD52g3qtSdxj6MstfljzDZbEYQ6wRgJbNcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761296286; c=relaxed/simple;
	bh=zwlYTCIQGLY0yh41zuHU3+Xs80pLScow7jcNxPi3euQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YjRpz3qp8Y6l7ZL78NydADJjvdEdKEegvGed2iDjjhStUBxuEzSDEePW5Id21MC7bW34BCN4yHesxwarkj5NseqqtavxtwykPoRml+wlK447/9rXJmftC/bsAfh+m8EaSt+mfVIYJScgJtMQ3KfqCbWHPz3+SMzHegtn5hFemJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-93e7ff77197so520458739f.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 01:58:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761296284; x=1761901084;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6yahXNlFQ7S9MhfLB3CntrMuPhNaVCH9GfWsJAYRWWo=;
        b=a3QyrFCKwU7mOJ6BlFsI1hbMyCGd1ESYsQvet0HL6x7DLOQfvar+jF+iaHLPP3xzx5
         5ZhIfZmjvcjxZhHU8GvlIQ/zMhh39xfUb8hzDprRR3IMUE+ElniifECMvlxA7Kk9H9bI
         +Q4QLYXySXmTklRLJkE2vMWGP6MJT8zPqxz8m72+P71DSGMZdUC54lc/1WCXYhueaH7N
         ECH58X0gxaXCCepJW790OFrZS0i+gGDkn7lxmB0UACStekO+steLiwF2XAs09oH37baE
         AIjT/JGB0bfJbg73GT6o00Voz8uphSe0fCEpvfFoTc1qMMIzN2uhlSqv02mpE+74p+It
         /Rdw==
X-Forwarded-Encrypted: i=1; AJvYcCXmlCUw+JYPq4v4Y0XYTMr4dKO+bkxenGz1Br9KQvnIOCk3sbPL8oD+7TjQaWD19faP8H7tsRzxh+310V0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzyHNWDMGQSIfiloUx7JZgJtBs1KKvrRJuqzYAdm0ZonPtXR78
	WLY6d/iBJ7Ecxiu42TUZW7B3hhPhOJdEtDqjGGynm5AXSP/4YRShb11vx0vFB3+EKVz8bwchMIu
	7JvrRrNkMLb5LcjvOOq3I/3KbU2e2uEm6WaunWfr4HG3snjXz5zghkPxrrNM=
X-Google-Smtp-Source: AGHT+IG8wiUajVSQP2OPdwWx8twW9WropJ0zVkOe31SY83Hqj88ejRhX/tbbVE0fSzyU12O2JSudXrB6oK/DKIzrERM9KIi16J5F
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:b84:b0:940:da70:9dc1 with SMTP id
 ca18e2360f4ac-940da70a124mr2705056239f.8.1761296284004; Fri, 24 Oct 2025
 01:58:04 -0700 (PDT)
Date: Fri, 24 Oct 2025 01:58:03 -0700
In-Reply-To: <20251024071521.W4ZcY%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fb3f9b.050a0220.346f24.00b2.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in ocfs2_truncate_log_needs_flush (2)
From: syzbot <syzbot+c24237f0eee59c0c2abb@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+c24237f0eee59c0c2abb@syzkaller.appspotmail.com
Tested-by: syzbot+c24237f0eee59c0c2abb@syzkaller.appspotmail.com

Tested on:

commit:         8e6e2188 Linux 6.1.157
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-6.1.y
console output: https://syzkaller.appspot.com/x/log.txt?x=15be9be2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1c4111dd2cd8811f
dashboard link: https://syzkaller.appspot.com/bug?extid=c24237f0eee59c0c2abb
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=117c7734580000

Note: testing is done by a robot and is best-effort only.

