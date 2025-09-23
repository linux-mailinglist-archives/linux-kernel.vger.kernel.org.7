Return-Path: <linux-kernel+bounces-829412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 120F0B97075
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 19:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A143D18876D6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 17:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2E527FB21;
	Tue, 23 Sep 2025 17:30:07 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D82C27FB18
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 17:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758648606; cv=none; b=l8GTWvEO7pAxNlCZjVoh+f6CW1ujRh/gTsImYtPc6DoUhP48yVhoRutFQMoQhXEzwneHAQn1TBpDZFZa59swzSLJc2OLAaRnesvlywnoPRa13azjCL2fZ99fVpFngoj1uTbynV7VyYwtmTjSf5ZuIe5hofcfOAKBrtDRHsYSzak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758648606; c=relaxed/simple;
	bh=z8vnp6syI+2lnCnAs+ZjyrxM49Hbd++DXZlCCyrpBIw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jq45sSa6PYgZTFk3jfyzTnkOPEmRd3jIVWg09lqP85zc0BWOQpRUVXlB3GC9mInJaAzzEebJtFPwnZijbY+IOD+aTwE8/yGzvlyep6Mp6cAH+H+Uq+AkTtu3S3YdfLziIH0eE2FGMiHJ4jLD+vW95dE3SuEz0RB/1Q3Pa7uvrJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-4257453b390so37998585ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 10:30:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758648603; x=1759253403;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yUiDPhvxAXmP6syQ6yawX55z/jlxeKJlJdZIK37obfs=;
        b=nQu1zzqHMd/Y2uqAkplCrqwJzQ2KCN/5YRBtEq8HpnqaE9H1DyXRayau45oOC/8mnu
         /6hnlEqY1iPQrLF+oa2VquQduigF/mT8OZiyOv/J0oLGOEgzktm9d1Rr041kPKsAXdc2
         kPnluUHOLqUtSeG+6ZtCIex5eYermnbtlxZttaVVz2hVNB/ETNfE3fbAf3GhQR4FOjNb
         zIShFEtQ/P8JVs4VdOFwhpvtR8erfI4IBzmgh+YfQvV5nW5ZUUBQNHt+7uB3vDdyCN0u
         rvFCVwFPFfowUfSF5bk+edgzGaZECOrahImnO80E3X3TbRG3AUCjKl1RF1WLWDESZe0I
         HlPA==
X-Gm-Message-State: AOJu0Yw6H/xSMgkl/0QDbhCufxY72NEgthBu/xWE1BJqoRlA/hB5O/sA
	r+XeI0sr/LbD3TCwJZrUJa9ABsNTybAExwjENWhOS4SvOlHiHYGhxGQcdt8STOe+zwKHoz0bCA/
	suX/Cr5/QQhjvHyfcOadx4xXL8dEmIojfmcGOxfTozE7g9w+JVY5W5o5lTew=
X-Google-Smtp-Source: AGHT+IEizYUo0GWXObWxjyEYJJrmNEHZQLW/N9lQA3SQomLEttxTBFJGcPnmcmVUd3Jz/0PpEaBqdl0r5qSk0CqbduHTS5H4MIV5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:250f:b0:424:7f06:4f46 with SMTP id
 e9e14a558f8ab-42581e03e96mr52369295ab.4.1758648602805; Tue, 23 Sep 2025
 10:30:02 -0700 (PDT)
Date: Tue, 23 Sep 2025 10:30:02 -0700
In-Reply-To: <20250923171012.1627266-1-listout@listout.xyz>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d2d91a.a70a0220.1b52b.02b5.GAE@google.com>
Subject: Re: [syzbot] [bpf?] general protection fault in print_reg_state
From: syzbot <syzbot+d36d5ae81e1b0a53ef58@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, listout@listout.xyz, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+d36d5ae81e1b0a53ef58@syzkaller.appspotmail.com
Tested-by: syzbot+d36d5ae81e1b0a53ef58@syzkaller.appspotmail.com

Tested on:

commit:         cec1e6e5 Merge tag 'sched_ext-for-6.17-rc7-fixes' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14ed0f12580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f01d8629880e620
dashboard link: https://syzkaller.appspot.com/bug?extid=d36d5ae81e1b0a53ef58
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1647627c580000

Note: testing is done by a robot and is best-effort only.

