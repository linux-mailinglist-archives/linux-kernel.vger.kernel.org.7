Return-Path: <linux-kernel+bounces-876070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 397F3C1ABC3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37691624462
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757BD33B6C3;
	Wed, 29 Oct 2025 12:55:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D1C3358DA
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 12:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761742505; cv=none; b=ssviDlgTbERhHL0IOIBvwC0iXj5C/UR8Ij2rBCrNQrP5aWbbyNllqoLKCu1MetcFzIOtaJ9mAf1lloDSYYUbb+wzlT61/tmEv6ah6k1T0Id3JeG0EiytRPiQtKBpd6Cl1tO0Ote6aalT88y+v/EbsVVylKXXSI4nk5hpSDwicpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761742505; c=relaxed/simple;
	bh=kqH8TBUlKcmS0qSZFNCEjDxV3wH/Fk1ZS+6W56vyfjI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mC2ueRW+xqbJ9/e4W2OFvrbAyojqhckLXRWpxaO3OUD9rpo+PveFX5qHhQe7DYmlOzSFj3Qdu01ch+kJioPZH9SXq3gbXciuXenJYcUX8NNmPtMD6z6XLUl6Pb0GKM5HyAWJ8PscOipvK6+eHmdkodSuwcBVL/K72weE+E/KL5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-430e67e2427so98105095ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 05:55:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761742503; x=1762347303;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uFxb75MZogM99UgS6KK8lwrmzQTIAHHisjOO7zYiBoM=;
        b=X1QAo/GVjkUCubtYlCgEGXtsP5FcRxYRFISH/41P5Zqxz1VXpLuob92VTaO5VXydpz
         KOBZEFfOq1Jxts/mbobNO73mFk6xKtSxPDbL++PWAajD+04go9PGNsxkbZyCwspvPAH1
         NlGZXltAjQtGYgscuQGs+S7gQCM4r5TJX317chy6nR4Pla0IrcBU1upblLwUd+mckAa2
         t5wUAJUMgUQHVeFYN38vAuPE4+/pT6Fch91opPihJ6tF9/prs3lvwF3sP9EvwYjKB9em
         U4hRfd99Yvyg30WTcflEPc/T5YiqcyUB/BetyjrEw995ppSUSJR2v/0w0tqpkccg6rSh
         1eow==
X-Forwarded-Encrypted: i=1; AJvYcCXUXK++7hzpdZJP19vWxYPvYzJx29yJ0/CQEq8ldP8pMf8vbT41Pdlk41Rrv34xtaaN2cOOcRnDSUj4KCU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd01ANhBbdXGaRjEl+QefQ8t4Wz5T1iE/qSY0rQmIRewTBVr4Q
	fwibTKpNRvSAFJ37ae3V9x2cXUfOBrVH8pgyoWKt4TcG3Ar33/xjzJ/D19wP6GtbglE1HXfG5Ia
	omMU/j3n25OKG+Hk5gnBbjBYq5fE5eeiFcqjB2nRJoli1qCflXgjzCpOZLOU=
X-Google-Smtp-Source: AGHT+IFa4rK+fwXqe+HFMMAG1h5pB6Akqmdze1VWZUIfJEhdHu8N9c5Ya+fhGwGAVp3Cx271ago6cRZ/Fc6F/1O5V0jCaJacfwHn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2217:b0:430:c9c5:734e with SMTP id
 e9e14a558f8ab-432f9066c94mr34303375ab.31.1761742503139; Wed, 29 Oct 2025
 05:55:03 -0700 (PDT)
Date: Wed, 29 Oct 2025 05:55:03 -0700
In-Reply-To: <20251029062545.KmCPd%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69020ea7.050a0220.32483.020e.GAE@google.com>
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

commit:         8e6e2188 Linux 6.1.157
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-6.1.y
console output: https://syzkaller.appspot.com/x/log.txt?x=12424bcd980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3fff88b67220f824
dashboard link: https://syzkaller.appspot.com/bug?extid=5054473a31f78f735416
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1737c32f980000

Note: testing is done by a robot and is best-effort only.

