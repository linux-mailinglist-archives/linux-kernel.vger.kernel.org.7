Return-Path: <linux-kernel+bounces-785842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A579B351B5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 04:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83D831B612A2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 02:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86AE01F0E26;
	Tue, 26 Aug 2025 02:32:04 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C035061FCE
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 02:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756175524; cv=none; b=ZPQBgpRzq8vkCovVP88wBIbE+cxDIdIx4rNjxR+uiBzKtGryDNIQyq/LQiU7GzrZfLS0N1qGmxJEFRk/EjHmPw1PeHP4d1lJJ5fBCgSHHG/gwh+u4PM9MRroGoBqxdDExOZ+LFc4tEPOnhIz23N3pLIadbRZOSkcOOvfjmAQbkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756175524; c=relaxed/simple;
	bh=qUKEeLAKHu19DJVfdI2lhMuECyXhVuhi5QrmcFjDts8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DC/pKnHJE/UyAURju5dXWbNVKqOaLxZL3ycDhjL2VL7Y5ZUYOTR5Zn4HSQaafReATey67reTEqxiFFBPVbrkU54I+/t3RL6/ruRk3e3PmU51539hYPCgBOhVYYp1tHIvVwltIhWCWd4hnJiezz8PICnQ/ER3gH9RhgGu2QWcLVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3eee0110eb5so2212345ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 19:32:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756175522; x=1756780322;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RIaPYxZIycFgH9zWp56bKXyzavbqdrpqAgrCeLMmpGM=;
        b=HMrPz3l5HiZjx71Y7LhqYvk8KQd+/ycAbvO1QnZkF6Pc0mMVFOr0ZSgyHCqO9VI/Nw
         +ypgdxQkVvhucX251BcIZkm3JUZVdkuGFaAsHXL4Vqx2wi9t4Gvpg9HLp/kWBzRozA9x
         uQQow+u7ExGrsR2+yrvnmxDJLta0/oYp0AuiUSIbudNKza+09Y+IO/yaIlpiC8TcHtPi
         FppvWkaDOtrolz2WOcmnXnn9K7zXObtBIOI7re3/iJud2UheF4CPHYlm29X3yH7oCroN
         JODouHZ9HtQh1hT5Nnm94Lrk9zZ/UZY0je4oL81pxgeRV9+1BiSDveLaVrngxou20OdH
         /+aw==
X-Forwarded-Encrypted: i=1; AJvYcCUR2+dx4wS0dWHBZqq39dABX0eOaxJ21mDm1/H8Wqu5TheAa9uoHet65YnXsM0twXSd6s3WzUirSz7IHH4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz4AJ2aL5+e/tyoEouqeAe4qLMyatJCzMFN77wCsKovRf9ObFb
	j9LT5LgEPyEu4OiqNmoCxFUI5/nKeqH7ltwnPPS3NnrjIgRYn65pWZtMVEL9jencPxoebuwa7YC
	J1zsmVBA0xOKXurOAvIafij3SMbQZh46vZCMZitGDG8PomPf1UQLH8OSg5kM=
X-Google-Smtp-Source: AGHT+IFmJYs1BfMrOMXzf+dJpZpqn7yo9y01cRX3nEQOUCPseYU3wotpSoxET+zxfYCz02l7dLFkDCUmFCq4OBbFPKjYdyT68CRz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c02:b0:3ee:8e4b:e6db with SMTP id
 e9e14a558f8ab-3ee8e4be93fmr18770595ab.12.1756175521821; Mon, 25 Aug 2025
 19:32:01 -0700 (PDT)
Date: Mon, 25 Aug 2025 19:32:01 -0700
In-Reply-To: <20250826014323.5493-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ad1ca1.050a0220.37038e.009e.GAE@google.com>
Subject: Re: [syzbot] [ext4?] possible deadlock in ext4_truncate (2)
From: syzbot <syzbot+c5c9c223a721d7353490@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+c5c9c223a721d7353490@syzkaller.appspotmail.com
Tested-by: syzbot+c5c9c223a721d7353490@syzkaller.appspotmail.com

Tested on:

commit:         fab1beda Merge tag 'devicetree-fixes-for-6.17-1' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=144f0634580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=da02162f945f3311
dashboard link: https://syzkaller.appspot.com/bug?extid=c5c9c223a721d7353490
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15bf1c42580000

Note: testing is done by a robot and is best-effort only.

